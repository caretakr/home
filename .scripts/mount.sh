#!/bin/sh

#
# Mount disks
#

_EXPANSION_UUID="70f65a9f-da6a-4c3a-9170-b217645dbf35"
_EXPANSION_PASSPHRASE="$(secret-tool lookup device "disk" uuid "$_EXPANSION_UUID")"

_STORAGE_UUID="49ec3386-7443-49e7-8ff1-3005755ad45d"
_STORAGE_PASSPHRASE="$(secret-tool lookup device "disk" uuid "$_STORAGE_UUID")"

_CARETAKR_PATH="/media/caretakr"
_STORAGE_PATH="/media/storage"
_SECRET_PATH="/media/secret"
_BACKUP_PATH="/media/backup"

pkexec <<EOF sh
    if
        [ ! -z "$_EXPANSION_UUID" ] \
            && [ ! -z "$_EXPANSION_PASSPHRASE" ]
    then
        if [ ! -b "/dev/mapper/$_EXPANSION_UUID" ]; then
            cryptsetup luksOpen --key-file <(printf '$_EXPANSION_PASSPHRASE') \
                /dev/disk/by-uuid/$_EXPANSION_UUID $_EXPANSION_UUID
        fi

        if [ ! -z "$_CARETAKR_PATH" ]; then
            if [ ! -d "$_CARETAKR_PATH" ]; then
                mkdir -p "$_CARETAKR_PATH"
            fi

            if ! mountpoint -q $_CARETAKR_PATH; then
                mount \
                    -o rw,noatime,compress=zstd:3,ssd,space_cache=v2,subvol=home/caretakr+live \
                    /dev/mapper/$_EXPANSION_UUID $_CARETAKR_PATH
            fi
        fi
    fi

    if
        [ ! -z "$_STORAGE_UUID" ] \
            && [ ! -z "$_STORAGE_PASSPHRASE" ]
    then
        if [ ! -b "/dev/mapper/$_STORAGE_UUID" ]; then
            cryptsetup luksOpen --key-file <(printf '$_STORAGE_PASSPHRASE') \
                /dev/disk/by-uuid/$_STORAGE_UUID $_STORAGE_UUID
        fi

        if [ ! -z "$_STORAGE_PATH" ]; then
            if [ ! -d "$_STORAGE_PATH" ]; then
                mkdir -p "$_STORAGE_PATH"
            fi

            if ! mountpoint -q $_STORAGE_PATH; then
                mount \
                    -o rw,noatime,compress=zstd:3,space_cache=v2,subvol=base+live \
                    /dev/mapper/$_STORAGE_UUID $_STORAGE_PATH
            fi
        fi

        if [ ! -z "$_SECRET_PATH" ]; then
            if [ ! -d "$_SECRET_PATH" ]; then
                mkdir -p "$_SECRET_PATH"
            fi

            if ! mountpoint -q $_SECRET_PATH; then
                mount \
                    -o rw,noatime,compress=zstd:3,space_cache=v2,subvol=secret+live \
                    /dev/mapper/$_STORAGE_UUID $_SECRET_PATH
            fi
        fi

        if [ ! -z "$_BACKUP_PATH" ]; then
            if [ ! -d "$_BACKUP_PATH" ]; then
                mkdir -p "$_BACKUP_PATH"
            fi

            if ! mountpoint -q $_BACKUP_PATH; then
                mount \
                    -o rw,noatime,compress=zstd:3,space_cache=v2,subvol=backup+live \
                    /dev/mapper/$_STORAGE_UUID $_BACKUP_PATH
            fi
        fi
    fi
EOF
