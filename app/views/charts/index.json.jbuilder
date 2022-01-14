# frozen_string_literal: true

json.array! @charts, partial: 'charts/chart', as: :chart
