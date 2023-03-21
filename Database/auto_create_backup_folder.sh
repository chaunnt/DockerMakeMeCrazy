#!/bin/bash
TIMESTAMP=$(date +"%F")
BACKUP_DIR="/backup/$TIMESTAMP"
mkdir -p "$BACKUP_DIR"