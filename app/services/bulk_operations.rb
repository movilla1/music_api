# frozen_string_literal: true

# This class will handle bulk operations over a model association
# Specifically AlbumSongs, AlbumArtist and ArtistSong
class BulkOperations
  def self.process_array(model_class, source_column, input_array, destination_column, destination_id)
    return false unless input_array.is_a?(Array)

    input_array.each do |operation, source_id|
      if operation == "add"
        create_new_record(model_class, source_column, source_id, destination_column, destination_id)
      else
        remove_record(model_class, source_column, source_id, destination_column, destination_id)
      end
    end
  end

  # adds new record for the model class
  def self.create_new_record(model_class, source_column, source_id, destination_column, destination_id)
    new_record = model_class.new
    new_record.send "#{destination_column}=", destination_id
    new_record.send "#{source_column}=", source_id
    new_record.save
  end

  # deletes records, doesn't update
  def self.remove_record(model_class, source_column, source_id, destination_column, destination_id)
    model_class.where("#{source_column} = ? AND #{destination_column} = ?", source_id, destination_id).first&.destroy
  end
end
