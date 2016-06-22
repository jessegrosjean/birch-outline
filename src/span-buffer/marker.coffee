# See: https://github.com/atom/marker-index
#
# Todo: Implements overlapping markers in similar way that run-buffer is
# implemented. Use create tree spans for each change point. Allow the markers
# to be associated with multiple spans if needed. In this way it's possible to
# have overlapping ranges.
class Marker

  constructor: (@string='') ->
