class BlockchainInfo
  def transactions( address: )
    addresses = [ address ]
    Blockchain::BlockExplorer.new.get_unspent_outputs(addresses)
  end
end
