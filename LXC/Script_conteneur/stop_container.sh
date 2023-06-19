#!/bin/bash

# Vérification des paramètres
if [ $# -lt 1 ]; then
  echo "Usage: $0 container_id [container_id ...]"
  exit 1
fi

# Boucle sur les identifiants de conteneurs
for container_id in "$@"; do
  # Vérification de l'existence des conteneurs correspondant à l'identifiant
  containers=$(lxc-ls -1 | grep -E "^$container_id")

  # Si aucun conteneur n'a été trouvé, vérification des jokers
  if [ -z "$containers" ]; then
    containers=$(lxc-ls -1 | grep -E "^$container_id")
  fi

  # Si aucun conteneur n'a été trouvé, affichage d'un message d'erreur
  if [ -z "$containers" ]; then
    echo "Aucun conteneur correspondant à l'identifiant $container_id n'a été trouvé."
    exit 1
  fi

  # Arrêt des conteneurs trouvés
  for container in $containers; do
    lxc-stop -n "$container"
  done
done

echo "Les conteneurs ont été arrêtés avec succès."