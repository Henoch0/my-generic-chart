{{/* Helper für vollständig qualifizierten Namen mit zufälligem Suffix */}}
{{- define "common.names.fullname-with-suffix" -}}
{{- $name := default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- $suffix := randAlphaNum 5 }}
{{ printf "%s-%s" $name $suffix }}
{{- end }}

{{/* Erweiterte Standardlabels, die ein einzigartiges Suffix verwenden */}}
{{- define "common.labels.standard-with-suffix" -}}
app.kubernetes.io/name: {{ include "common.names.fullname-with-suffix" . }}
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
{{- $image := .Values.image | default dict -}}  
{{- if and $image $image.repository -}}
{{- printf "%s-%s" $image.repository .Values.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "image-or-repository-missing-%s" .Values.name | trunc 63 | trimSuffix "-" -}} 
{{- end -}}
{{- end -}}
