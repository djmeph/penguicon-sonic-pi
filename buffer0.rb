# Find me on Github at https://www.github.com/djmeph
# Twitter: @djmeph
# https://djmeph.net
#.     .       .  .   . .   .   . .    +  .
#  .     .  :     .    .. :. .___---------___.
#       .  .   .    .  :.:. _".^ .^ ^.  '.. :"-_. .
#    .  :       .  .  .:../:            . .^  :.:\.
#        .   . :: +. :.:/: .   .    .        . . .:\
# .  :    .     . _ :::/:               .  ^ .  . .:\
#  .. . .   . - : :.:./.                        .  .:\
#  .      .     . :..|:                    .  .  ^. .:|
#    .       . : : ..||        .                . . !:|
#  .     . . . ::. ::\(                           . :)/
# .   .     : . : .:.|. ######              .#######::|
#  :.. .  :-  : .:  ::|.#######           ..########:|
# .  .  .  ..  .  .. :\ ########          :######## :/
#  .        .+ :: : -.:\ ########       . ########.:/
#    .  .+   . . . . :.:\. #######       #######..:/
#      :: . . . . ::.:..:.\           .   .   ..:/
#   .   .   .  .. :  -::::.\.       | |     . .:/
#      .  :  .  .  .-:.":.::.\             ..:/
# .      -.   . . . .: .:::.:.\.           .:/
#.   .   .  :      : ....::_:..:\   ___.  :/
#   .   .  .   .:. .. .  .: :.:.:\       :/
#     +   .   .   : . ::. :.:. .:.|\  .:/|
#     .         +   .  .  ...:: ..|  --.:|
#.      . . .   .  .  . ... :..:.."(  ..)"
# .   .       .      :  .   .: ::/  .  .::\

tick   = 1.0
half   = 0.5*tick
quart  = 0.25*tick
length = 32*tick
whole = 4.0

# Drone
live_loop :drone do
  with_fx :flanger, invert_flange: 1 do
    sample :ambi_drone, rate: 1, amp: 2
    sleep whole
    #sample :ambi_drone, rate: 1.2, amp: 1
    #sleep half
  end
end

#wobble
live_loop :wobble, sync: :drone do
  #wob
  #sleep whole
end


#randomized weeyou sounds
live_loop :dude, sync: :drone do
  sample :guit_e_slide, rate: [0.8, 1, 1, 1, 1, 1, 1.2, 1.8].choose
  sleep whole
end

#melody
live_loop :mono, sync: :drone do
  #monolithic_pattern
  sleep whole
end

#groll
live_loop :groll, sync: :drone do
  with_fx :compressor, attack: 0, release: 8 do
    #groll_arpeg
    sleep whole
  end
end


#BIG ASS BOOM
live_loop :boom, sync: :drone do
  with_fx :reverb, room: 1 do
    #sample :bd_boom, amp: 10, rate: 1
  end
  sleep whole*2
end

#Slow Amen
live_loop :drums, sync: :drone do
  #with_fx :ixi_techno do
  #sample :loop_amen, beat_stretch: 4
  sleep whole
  #end
end

#BIG ASS BOOM
live_loop :bd, sync: :drone do
  with_fx :echo, phase: 0.5, decay: 4, pan: rrand(-1, 1) do
    #sample :bd_sone, rate: 0.8
    sleep whole*2
  end
end

#Sparkly shit
live_loop :ambient, sync: :drone do
  puts "lift off!"
  with_fx :reverb, mix: 1 do
    #sample :ambi_lunar_land, rate: [0.75, 0.5, 1.2].choose, amp: 0.5
    sleep whole*2
  end
end

#Faaaart
live_loop :foo, sync: :drone do
  use_synth :prophet
  #play :e1, release: 8
  sleep whole*2
end

define :groll_arpeg do
  with_fx :level, amp: 2.0 do
    with_synth(:fm) do
      with_fx(:distortion) do
        4.times do
          play 54.0
          sleep quart

          play :b2
          sleep quart

          #play 66.0
          sleep quart

          play :b2
          sleep quart
        end
      end
    end
  end
end

define :monolithic_pattern do
  4.times do
    [:a3, :cs4, :a4, :cs4].each do |note|
      play note
      sleep quart
    end
  end

  2.times do
    [:ab3, :cs4, :ab4, :cs4].each do |note|
      play note
      sleep quart
    end
  end

  1.times do
    [:ab3, :cs4, 66, :cs4].each do |note|
      play note
      sleep quart
    end
  end

  1.times do
    [56, :cs4, 65, :cs4].each do |note|
      play note
      sleep quart
    end
  end


  4.times do
    [57, :d3, 66, :d3].each do |note|
      play note
      sleep quart
    end
  end

  4.times do
    [54, :b2, 66, :b2].each do |note|
      play note
      sleep quart
    end
  end
end

# WOBBLE BASS
define :wob do
  use_synth :dsaw
  lowcut = note(:E1) # ~ 40Hz
  highcut = note(:G8) # ~ 3000Hz

  note = [40, 41, 28, 28, 28, 27, 25, 35].choose

  duration = 2.0
  bpm_scale = (60 / current_bpm).to_f
  distort = 0.2

  # scale the note length based on current tempo
  slide_duration = duration * bpm_scale

  # Distortion helps give crunch
  with_fx :distortion, distort: distort do

    # rlpf means "Resonant low pass filter"
    with_fx :rlpf, cutoff: lowcut, cutoff_slide: slide_duration do |c|
      play note, attack: 0, sustain: duration, release: 0

      # 6/4 rhythms
      wobble_time = [1, 6, 6, 2, 1, 2, 4, 8, 3, 3, 16].choose
      c.ctl cutoff_slide: ((duration / wobble_time.to_f) / 2.0)

      wobble_time.times do
        c.ctl cutoff: highcut
        sleep ((duration / wobble_time.to_f) / 2.0)
        c.ctl cutoff: lowcut
        sleep ((duration / wobble_time.to_f) / 2.0)
      end
    end
  end
end
