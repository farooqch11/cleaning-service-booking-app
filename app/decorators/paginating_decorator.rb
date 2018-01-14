class PaginatingDecorator < Draper::CollectionDecorator
  # support for will_paginate
  delegate :current_page, :per_page, :offset, :total_entries, :total_pages , :will_paginate

end