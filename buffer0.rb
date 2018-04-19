live_loop :drone do
  with_fx :flanger, invert_flange: 1 do
    sample :ambi_drone, rate: 1, amp: 2
    sleep 4
  end
end

live_loop :dude, sync: :drone do
  sample :guit_e_slide, rate: [0.8, 1, 1, 1, 1, 1, 1.2, 1.8].choose
  sleep 4
end



live_loop :drums, sync: :drone do
  #with_fx :ixi_techno do
  #sample :loop_amen, beat_stretch: 4
  sleep 4
  #end
end

live_loop :bd, sync: :drone do
  with_fx :echo, phase: 0.5, decay: 4, pan: rrand(-1, 1) do
    #sample :bd_sone, rate: 0.8
    sleep 8
  end
end

live_loop :ambient, sync: :drone do
  puts "lift off!"
  with_fx :reverb, mix: 1 do
    sample :ambi_lunar_land, rate: [0.75, 0.5, 1.2].choose, amp: 0.5
    sleep 8
  end
end
