require('./assets/lib/piety')($, document)

colors =
  low: '#00E676'
  med: '#ff9926'
  high: 'rgb(255,44,37)'
  back: 'rgba(0,0,0,0.4)'

chartWidth = 15
chartType = 'donut'
refreshFrequency: 3000 # ms

# Run all commands in one shell call, separated by ':::'
command: """
CPU=$(ps -A -o %cpu | awk '{s+=$1} END {printf("%.0f",s/8);}')
GPU=$(ioreg -l | grep 'PerformanceStatistics' | tr ',' '\\n' | sed -E 's/\"//g' | grep -E '(Device Utilization)' | awk '{print $3}'| tr -d '%,=')
MEM=$(memory_pressure | awk '{ field=$NF };END{print 100-field}' | tr -d '%')
STO=$(df -Hl | grep '/System/Volumes/Data' | awk '{print $5}' | tr -d '%')
echo "$CPU:::$GPU:::$MEM:::$STO"
"""

render: (output) ->
  """
  <div class="system-stats">
    <div class="stat cpu">
      <span class='number'></span>
      <span class="chart"></span>
    </div>
    <div class="stat gpu">
      <span class='number'></span>
      <span class="chart"></span>
    </div>
    <div class="stat mem">
      <span class='number'></span>
      <span class="chart"></span>
    </div>
    <div class="stat storage">
      <span class='number'></span>
      <span class="chart"></span>
    </div>
  </div>
  """

update: (output, el) ->
  [cpu, gpu, mem, sto] = output.split(':::').map(Number)

  # CPU
  fill = colors.low
  fill = colors.med if cpu > 40
  fill = colors.high if cpu > 80
  $(".cpu .number", el).text("CPU: #{cpu}%")
  $(".cpu .chart", el).text("#{cpu}/100").peity chartType,
    fill: [fill, colors.back]
    width: chartWidth

  # GPU
  fill = colors.low
  fill = colors.med if gpu > 40
  fill = colors.high if gpu > 80
  $(".gpu .number", el).text("GPU: #{gpu}%")
  $(".gpu .chart", el).text("#{gpu}/100").peity chartType,
    fill: [fill, colors.back]
    width: chartWidth

  # Memory Pressure
  fill = colors.low
  fill = colors.med if mem > 40
  fill = colors.high if mem > 80
  $(".mem .number", el).text("Memory: #{mem}%")
  $(".mem .chart", el).text("#{mem}/100").peity chartType,
    fill: [fill, colors.back]
    width: chartWidth

  # Storage
  fill = colors.low
  fill = colors.med if sto > 40
  fill = colors.high if sto > 80
  $(".storage .number", el).text("Storage: #{sto}%")
  $(".storage .chart", el).text("#{sto}/100").peity chartType,
    fill: [fill, colors.back]
    width: chartWidth

style: """
  .system-stats {
    position: fixed;
    right: 24px;
    bottom: 24px;
    display: flex;
    flex-direction: row;
    gap: 1.5rem;
    width: auto;
    white-space: nowrap;
    color: white;
    font: 15px -apple-system, sans-serif;
    user-select: none;
    text-shadow: 0px 1px 4px #000000;
    -webkit-font-smoothing: antialiased;
  }
  .stat {
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 0.5rem;
    min-width: 70px;
  }
  .number {
    margin-top: 0;
    font-weight: 500;
  }
  .chart {
    vertical-align: top;
  }
""" 