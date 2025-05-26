{{- define "eventservice_chart.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "eventservice_chart.labels" -}}
app.kubernetes.io/name: {{ include "eventservice_chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "eventservice_chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "eventservice_chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "eventservice_chart.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}
