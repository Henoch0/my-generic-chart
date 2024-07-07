{{/* Common labels for all your templates */}}
{{- define "common.labels.standard" -}}
app.kubernetes.io/name: {{ include "common.names.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/* Generate a default fully qualified app name. */}}
{{- define "common.names.fullname" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Selector labels */}}
{{- define "common.labels.matchLabels" -}}
app.kubernetes.io/name: {{ include "common.names.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Generate a default volume name */}}
{{- define "common.names.volume" -}}
{{- printf "%s-volume" (include "common.names.fullname" .) }}
{{- end }}

{{/* Generate a default configmap name */}}
{{- define "common.names.configmap" -}}
{{- printf "%s-config" (include "common.names.fullname" .) }}
{{- end }}


{{/*
Generate a dynamic or user-defined container name.
*/}}
{{- define "container.name" -}}
{{- $chartName := .Chart.Name | default "default-chart" -}}
{{- if .name }}
{{- .name }}
{{- else }}
{{- printf "%s-%s" $chartName (replace "/" "-" (default "default-repo" .image.repository)) | lower }}
{{- end }}
{{- end }}
