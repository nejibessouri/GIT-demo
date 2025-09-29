#!/bin/bash

# Username cible (à adapter à ton cas)
USERNAME="user@org.com"

# Récupère tous les alias liés à ce username
ALIASES=$(sfdx alias:list --json | jq -r ".result[] | select(.value==\"$USERNAME\") | .alias")

# Garde seulement le premier alias (le "principal")
MAIN_ALIAS=$(echo "$ALIASES" | head -n 1)

echo "✅ Alias principal conservé : $MAIN_ALIAS"
echo "🗑️  Suppression des alias en trop..."

# Supprime les autres alias
for ALIAS in $ALIASES; do
  if [ "$ALIAS" != "$MAIN_ALIAS" ]; then
    sfdx alias:unset $ALIAS
    echo "   → supprimé : $ALIAS"
  fi
done

echo "✨ Nettoyage terminé."
