module EDItX
  class Order
    class Party
      include ROXML

      xml_accessor :id_type, :in => "PartyID", :from => "PartyIDType"
      xml_accessor :id, :in => "PartyID", :from => "Identifier"
      xml_accessor :name, :in => "PartyName", :from => "NameLine"

    end
  end
end
