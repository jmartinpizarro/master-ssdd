#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROGRAM="${PROGRAM:-$SCRIPT_DIR/practica}"
PLATFORM="${PLATFORM:-$SCRIPT_DIR/platform-cluster.xml}"
OUTPUT="${OUTPUT:-$SCRIPT_DIR/resultados.txt}"
REPETITIONS=30
RATES=(0.2 0.5 0.7 0.9)

if [[ ! -x "$PROGRAM" ]]; then
    printf 'Error: no existe un ejecutable en %s\n' "$PROGRAM" >&2
    printf 'Compila primero con: make\n' >&2
    exit 1
fi

if [[ ! -f "$PLATFORM" ]]; then
    printf 'Error: no existe la plataforma %s\n' "$PLATFORM" >&2
    exit 1
fi

printf 'lambda\trepeticion\ttiempo_medio_servicio\ttamano_medio_cola\ttareas_medias_sistema	tareas\n' > "$OUTPUT"

for rate in "${RATES[@]}"; do
    for ((run = 1; run <= REPETITIONS; run++)); do
        printf 'Ejecutando lambda=%s, repeticion=%d/%d\n' "$rate" "$run" "$REPETITIONS"

        metrics="$("$PROGRAM" "$PLATFORM" "$rate" | awk '
            NF >= 4 && $1 ~ /^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$/ {
                print $1 "\t" $2 "\t" $3 "\t" $4
                exit
            }
        ')"

        if [[ -z "$metrics" ]]; then
            printf 'Error: no se pudieron extraer las metricas de lambda=%s, repeticion=%d\n' "$rate" "$run" >&2
            exit 1
        fi

        printf '%s\t%d\t%s\n' "$rate" "$run" "$metrics" >> "$OUTPUT"
    done
done

printf 'Resultados guardados en %s\n' "$OUTPUT"
