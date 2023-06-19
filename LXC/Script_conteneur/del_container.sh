#!/bin/bash

# Vérification des arguments
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 container_id..." >&2
  exit 1
fi

# Boucle sur les identifiants de conteneurs
for id in "$@"; do
  # Vérification de l'existence du conteneur
  if ! lxc-ls -1 | grep -q "^$id$"; then
    echo "Le conteneur $id n'existe pas" >&2
    continue
  fi

  # Destruction du conteneur
  echo "Destruction du conteneur '$id'"
  lxc-destroy -f "$id"
done