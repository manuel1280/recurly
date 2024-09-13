module TinHelper
  def formatted_tin(format, tin)
    case format
    when 'au_abn'
      tin[0..1] + ' ' + tin[2..4] + ' ' + tin[5..7] + ' ' + tin[8..10]
    when 'au_acn'
      tin[0..2] + ' ' + tin[3..5] + ' ' + tin[6..8]
    when 'ca_gst'
      tin[0..8] + 'RT0001'
    when 'in_gst'
      tin.upcase
    else
      'unknown format'
    end
  end
end