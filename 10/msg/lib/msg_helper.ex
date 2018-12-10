defmodule Msg.Helper do
  @moduledoc """
    Helpers for Msg.
  """
  # require Logger

  @input "whatever"


  @doc """
  quick and simple @input grabber
  """
  def get_input, do: [
    %Pnt{x: -42417, y:  32097, vx: 4, vy: -3},
    %Pnt{x: -10502, y: -10533, vx: 1, vy:  1},
    %Pnt{x: -53094, y:  32093, vx: 5, vy: -3},
    %Pnt{x: -53090, y: -21188, vx: 5, vy:  2},
    %Pnt{x:  53486, y:  21441, vx: -5, vy: -2},
    %Pnt{x: -21142, y: -42496, vx: 2, vy:  4},
    %Pnt{x: -42422, y:  32088, vx: 4, vy: -3},
    %Pnt{x:  42778, y:  10784, vx: -4, vy: -1},
    %Pnt{x:  10826, y:  42748, vx: -1, vy: -4},
    %Pnt{x: -10449, y:  53401, vx: 1, vy: -5},
    %Pnt{x: -42453, y: -21187, vx: 4, vy:  2},
    %Pnt{x:  32154, y: -31839, vx: -3, vy:  3},
    %Pnt{x: -42434, y: -53156, vx: 4, vy:  5},
    %Pnt{x: -21149, y:  32097, vx: 2, vy: -3},
    %Pnt{x: -10497, y:  53409, vx: 1, vy: -5},
    %Pnt{x: -42438, y: -53151, vx: 4, vy:  5},
    %Pnt{x:  21490, y:  10778, vx: -2, vy: -1},
    %Pnt{x:  42831, y:  42753, vx: -4, vy: -4},
    %Pnt{x:  53474, y: -42501, vx: -5, vy:  4},
    %Pnt{x: -42436, y: -21192, vx: 4, vy:  2},
    %Pnt{x:  53450, y: -53154, vx: -5, vy:  5},
    %Pnt{x:  32118, y: -21185, vx: -3, vy:  2},
    %Pnt{x: -21158, y: -10533, vx: 2, vy:  1},
    %Pnt{x:  10842, y:  42749, vx: -1, vy: -4},
    %Pnt{x:  53467, y:  21436, vx: -5, vy: -2},
    %Pnt{x:  32130, y: -53160, vx: -3, vy:  5},
    %Pnt{x:  32119, y: -53151, vx: -3, vy:  5},
    %Pnt{x:  32143, y: -21183, vx: -3, vy:  2},
    %Pnt{x: -10486, y:  10781, vx: 1, vy: -1},
    %Pnt{x: -53098, y:  21433, vx: 5, vy: -2},
    %Pnt{x: -10465, y: -42503, vx: 1, vy:  4},
    %Pnt{x: -53083, y:  10776, vx: 5, vy: -1},
    %Pnt{x:  32173, y: -53151, vx: -3, vy:  5},
    %Pnt{x: -31782, y:  21436, vx: 3, vy: -2},
    %Pnt{x:  32143, y:  10782, vx: -3, vy: -1},
    %Pnt{x:  21487, y: -42500, vx: -2, vy:  4},
    %Pnt{x: -53082, y:  42752, vx: 5, vy: -4},
    %Pnt{x:  42775, y: -21183, vx: -4, vy:  2},
    %Pnt{x:  53431, y: -53160, vx: -5, vy:  5},
    %Pnt{x: -53078, y:  10784, vx: 5, vy: -1},
    %Pnt{x: -10505, y:  53408, vx: 1, vy: -5},
    %Pnt{x:  21507, y: -53151, vx: -2, vy:  5},
    %Pnt{x:  42814, y: -53160, vx: -4, vy:  5},
    %Pnt{x:  53427, y:  53402, vx: -5, vy: -5},
    %Pnt{x: -21164, y:  10780, vx: 2, vy: -1},
    %Pnt{x:  21461, y:  53404, vx: -2, vy: -5},
    %Pnt{x:  32173, y:  21436, vx: -3, vy: -2},
    %Pnt{x: -53086, y:  21438, vx: 5, vy: -2},
    %Pnt{x:  32146, y: -42503, vx: -3, vy:  4},
    %Pnt{x:  32159, y:  21439, vx: -3, vy: -2},
    %Pnt{x:  53442, y:  42751, vx: -5, vy: -4},
    %Pnt{x: -31817, y:  42752, vx: 3, vy: -4},
    %Pnt{x:  53459, y: -21188, vx: -5, vy:  2},
    %Pnt{x:  21458, y: -21191, vx: -2, vy:  2},
    %Pnt{x: -21134, y:  53402, vx: 2, vy: -5},
    %Pnt{x: -10481, y: -10534, vx: 1, vy:  1},
    %Pnt{x: -21137, y: -53158, vx: 2, vy:  5},
    %Pnt{x: -21110, y: -31839, vx: 2, vy:  3},
    %Pnt{x: -21153, y:  21441, vx: 2, vy: -2},
    %Pnt{x: -31766, y: -42495, vx: 3, vy:  4},
    %Pnt{x:  42799, y: -53155, vx: -4, vy:  5},
    %Pnt{x: -42449, y:  42752, vx: 4, vy: -4},
    %Pnt{x: -53102, y: -10531, vx: 5, vy:  1},
    %Pnt{x: -21149, y: -10527, vx: 2, vy:  1},
    %Pnt{x: -31801, y:  53401, vx: 3, vy: -5},
    %Pnt{x: -10462, y: -31842, vx: 1, vy:  3},
    %Pnt{x: -31806, y:  42751, vx: 3, vy: -4},
    %Pnt{x: -10502, y:  10777, vx: 1, vy: -1},
    %Pnt{x: -53129, y:  10785, vx: 5, vy: -1},
    %Pnt{x:  10803, y: -21186, vx: -1, vy:  2},
    %Pnt{x:  42810, y: -31847, vx: -4, vy:  3},
    %Pnt{x:  53450, y: -21189, vx: -5, vy:  2},
    %Pnt{x:  53434, y:  21433, vx: -5, vy: -2},
    %Pnt{x: -21126, y:  32094, vx: 2, vy: -3},
    %Pnt{x:  53446, y: -53157, vx: -5, vy:  5},
    %Pnt{x:  21518, y: -31839, vx: -2, vy:  3},
    %Pnt{x: -21146, y: -53157, vx: 2, vy:  5},
    %Pnt{x:  32135, y:  32089, vx: -3, vy: -3},
    %Pnt{x: -53094, y: -21188, vx: 5, vy:  2},
    %Pnt{x:  32170, y: -53152, vx: -3, vy:  5},
    %Pnt{x: -42476, y:  21437, vx: 4, vy: -2},
    %Pnt{x: -42446, y: -31840, vx: 4, vy:  3},
    %Pnt{x:  53471, y: -42503, vx: -5, vy:  4},
    %Pnt{x:  10850, y:  42752, vx: -1, vy: -4},
    %Pnt{x: -21141, y: -10531, vx: 2, vy:  1},
    %Pnt{x: -10508, y:  53404, vx: 1, vy: -5},
    %Pnt{x:  42818, y: -21190, vx: -4, vy:  2},
    %Pnt{x:  21483, y: -42503, vx: -2, vy:  4},
    %Pnt{x: -10482, y: -42503, vx: 1, vy:  4},
    %Pnt{x: -53089, y: -31847, vx: 5, vy:  3},
    %Pnt{x:  32162, y:  32092, vx: -3, vy: -3},
    %Pnt{x: -31763, y:  42753, vx: 3, vy: -4},
    %Pnt{x: -10462, y: -10535, vx: 1, vy:  1},
    %Pnt{x:  42831, y:  21433, vx: -4, vy: -2},
    %Pnt{x:  42819, y: -42504, vx: -4, vy:  4},
    %Pnt{x:  53426, y: -21192, vx: -5, vy:  2},
    %Pnt{x:  21475, y: -42495, vx: -2, vy:  4},
    %Pnt{x: -10462, y:  32092, vx: 1, vy: -3},
    %Pnt{x:  42802, y: -10533, vx: -4, vy:  1},
    %Pnt{x:  32146, y:  32088, vx: -3, vy: -3},
    %Pnt{x:  10831, y: -21184, vx: -1, vy:  2},
    %Pnt{x:  53466, y:  42752, vx: -5, vy: -4},
    %Pnt{x:  21516, y: -42499, vx: -2, vy:  4},
    %Pnt{x:  32159, y: -53152, vx: -3, vy:  5},
    %Pnt{x: -53123, y:  32097, vx: 5, vy: -3},
    %Pnt{x: -53126, y:  21434, vx: 5, vy: -2},
    %Pnt{x: -31790, y: -21189, vx: 3, vy:  2},
    %Pnt{x: -31789, y: -31843, vx: 3, vy:  3},
    %Pnt{x: -10502, y: -21185, vx: 1, vy:  2},
    %Pnt{x: -53124, y:  21441, vx: 5, vy: -2},
    %Pnt{x:  53486, y:  10779, vx: -5, vy: -1},
    %Pnt{x:  42805, y: -31846, vx: -4, vy:  3},
    %Pnt{x: -42470, y:  53406, vx: 4, vy: -5},
    %Pnt{x:  53469, y: -42495, vx: -5, vy:  4},
    %Pnt{x:  53450, y:  42751, vx: -5, vy: -4},
    %Pnt{x:  42822, y: -31843, vx: -4, vy:  3},
    %Pnt{x:  32133, y:  21436, vx: -3, vy: -2},
    %Pnt{x:  21487, y:  21437, vx: -2, vy: -2},
    %Pnt{x:  32149, y: -31841, vx: -3, vy:  3},
    %Pnt{x: -31778, y: -53151, vx: 3, vy:  5},
    %Pnt{x:  32175, y: -42504, vx: -3, vy:  4},
    %Pnt{x:  10834, y:  42750, vx: -1, vy: -4},
    %Pnt{x:  10855, y:  10777, vx: -1, vy: -1},
    %Pnt{x:  21492, y:  21438, vx: -2, vy: -2},
    %Pnt{x: -21131, y:  21434, vx: 2, vy: -2},
    %Pnt{x:  53455, y:  32091, vx: -5, vy: -3},
    %Pnt{x: -31786, y:  53408, vx: 3, vy: -5},
    %Pnt{x:  10829, y:  10781, vx: -1, vy: -1},
    %Pnt{x:  10831, y: -10529, vx: -1, vy:  1},
    %Pnt{x: -42460, y:  53405, vx: 4, vy: -5},
    %Pnt{x:  10813, y: -31839, vx: -1, vy:  3},
    %Pnt{x: -53076, y:  21432, vx: 5, vy: -2},
    %Pnt{x: -10452, y: -42499, vx: 1, vy:  4},
    %Pnt{x:  21487, y: -10534, vx: -2, vy:  1},
    %Pnt{x: -53082, y:  10781, vx: 5, vy: -1},
    %Pnt{x:  10839, y: -10527, vx: -1, vy:  1},
    %Pnt{x:  42770, y:  21441, vx: -4, vy: -2},
    %Pnt{x:  53466, y: -21185, vx: -5, vy:  2},
    %Pnt{x:  10812, y:  42753, vx: -1, vy: -4},
    %Pnt{x:  32156, y:  21432, vx: -3, vy: -2},
    %Pnt{x:  10803, y:  53407, vx: -1, vy: -5},
    %Pnt{x:  53430, y:  42747, vx: -5, vy: -4},
    %Pnt{x: -53114, y:  32088, vx: 5, vy: -3},
    %Pnt{x:  32156, y:  42748, vx: -3, vy: -4},
    %Pnt{x:  42802, y: -42499, vx: -4, vy:  4},
    %Pnt{x: -53110, y: -42500, vx: 5, vy:  4},
    %Pnt{x:  21474, y: -31840, vx: -2, vy:  3},
    %Pnt{x: -21166, y:  21432, vx: 2, vy: -2},
    %Pnt{x: -10506, y:  42746, vx: 1, vy: -4},
    %Pnt{x: -31819, y: -42499, vx: 3, vy:  4},
    %Pnt{x: -31769, y: -10528, vx: 3, vy:  1},
    %Pnt{x:  53426, y:  32088, vx: -5, vy: -3},
    %Pnt{x: -21150, y: -10529, vx: 2, vy:  1},
    %Pnt{x: -53086, y:  53408, vx: 5, vy: -5},
    %Pnt{x: -31782, y:  32095, vx: 3, vy: -3},
    %Pnt{x: -42449, y:  42747, vx: 4, vy: -4},
    %Pnt{x: -53098, y: -31847, vx: 5, vy:  3},
    %Pnt{x:  32162, y: -21185, vx: -3, vy:  2},
    %Pnt{x: -53110, y: -42497, vx: 5, vy:  4},
    %Pnt{x:  53455, y: -10532, vx: -5, vy:  1},
    %Pnt{x:  32157, y: -42504, vx: -3, vy:  4},
    %Pnt{x:  42802, y: -53155, vx: -4, vy:  5},
    %Pnt{x: -53106, y:  42749, vx: 5, vy: -4},
    %Pnt{x: -31781, y: -31848, vx: 3, vy:  3},
    %Pnt{x: -53100, y:  53403, vx: 5, vy: -5},
    %Pnt{x: -10508, y: -21187, vx: 1, vy:  2},
    %Pnt{x: -42477, y:  53407, vx: 4, vy: -5},
    %Pnt{x: -31795, y: -42504, vx: 3, vy:  4},
    %Pnt{x: -53077, y: -10527, vx: 5, vy:  1},
    %Pnt{x:  32133, y:  32097, vx: -3, vy: -3},
    %Pnt{x: -53090, y:  53409, vx: 5, vy: -5},
    %Pnt{x:  10847, y:  42749, vx: -1, vy: -4},
    %Pnt{x:  21466, y: -21192, vx: -2, vy:  2},
    %Pnt{x:  21476, y: -21192, vx: -2, vy:  2},
    %Pnt{x: -10462, y:  21439, vx: 1, vy: -2},
    %Pnt{x:  53430, y: -53153, vx: -5, vy:  5},
    %Pnt{x:  42831, y: -10534, vx: -4, vy:  1},
    %Pnt{x: -42435, y:  21432, vx: 4, vy: -2},
    %Pnt{x:  32131, y:  53400, vx: -3, vy: -5},
    %Pnt{x: -10481, y: -31844, vx: 1, vy:  3},
    %Pnt{x: -10478, y:  53404, vx: 1, vy: -5},
    %Pnt{x: -42438, y: -53160, vx: 4, vy:  5},
    %Pnt{x:  32170, y: -53153, vx: -3, vy:  5},
    %Pnt{x:  42778, y:  32092, vx: -4, vy: -3},
    %Pnt{x: -42427, y:  42753, vx: 4, vy: -4},
    %Pnt{x:  21476, y: -21183, vx: -2, vy:  2},
    %Pnt{x: -21126, y: -21191, vx: 2, vy:  2},
    %Pnt{x: -21118, y: -31842, vx: 2, vy:  3},
    %Pnt{x: -10505, y: -31848, vx: 1, vy:  3},
    %Pnt{x: -42421, y: -10536, vx: 4, vy:  1},
    %Pnt{x: -31779, y:  21436, vx: 3, vy: -2},
    %Pnt{x: -53106, y:  21437, vx: 5, vy: -2},
    %Pnt{x:  42807, y: -53151, vx: -4, vy:  5},
    %Pnt{x:  10810, y:  10778, vx: -1, vy: -1},
    %Pnt{x:  32154, y: -10534, vx: -3, vy:  1},
    %Pnt{x:  42814, y: -53160, vx: -4, vy:  5},
    %Pnt{x:  53430, y:  21439, vx: -5, vy: -2},
    %Pnt{x: -42462, y:  32097, vx: 4, vy: -3},
    %Pnt{x:  21506, y:  10777, vx: -2, vy: -1},
    %Pnt{x: -53092, y: -42495, vx: 5, vy:  4},
    %Pnt{x: -53081, y: -10528, vx: 5, vy:  1},
    %Pnt{x:  53471, y: -53153, vx: -5, vy:  5},
    %Pnt{x: -53106, y: -21187, vx: 5, vy:  2},
    %Pnt{x:  53450, y:  21437, vx: -5, vy: -2},
    %Pnt{x:  21515, y: -10527, vx: -2, vy:  1},
    %Pnt{x:  42791, y: -31846, vx: -4, vy:  3},
    %Pnt{x:  21463, y:  21433, vx: -2, vy: -2},
    %Pnt{x:  53485, y:  10776, vx: -5, vy: -1},
    %Pnt{x:  42790, y: -31848, vx: -4, vy:  3},
    %Pnt{x: -21122, y: -21192, vx: 2, vy:  2},
    %Pnt{x:  21511, y:  53406, vx: -2, vy: -5},
    %Pnt{x: -10505, y: -21192, vx: 1, vy:  2},
    %Pnt{x: -21163, y:  21436, vx: 2, vy: -2},
    %Pnt{x:  53426, y: -42496, vx: -5, vy:  4},
    %Pnt{x:  32162, y:  10781, vx: -3, vy: -1},
    %Pnt{x: -42470, y: -10527, vx: 4, vy:  1},
    %Pnt{x: -10458, y:  32093, vx: 1, vy: -3},
    %Pnt{x: -21105, y:  42745, vx: 2, vy: -4},
    %Pnt{x:  53479, y: -31840, vx: -5, vy:  3},
    %Pnt{x: -31805, y:  42744, vx: 3, vy: -4},
    %Pnt{x:  21498, y:  32094, vx: -2, vy: -3},
    %Pnt{x: -10486, y:  32094, vx: 1, vy: -3},
    %Pnt{x:  21484, y:  10781, vx: -2, vy: -1},
    %Pnt{x:  32140, y:  32088, vx: -3, vy: -3},
    %Pnt{x: -21130, y:  10777, vx: 2, vy: -1},
    %Pnt{x:  42794, y: -10533, vx: -4, vy:  1},
    %Pnt{x:  21498, y: -21187, vx: -2, vy:  2},
    %Pnt{x: -21116, y: -31848, vx: 2, vy:  3},
    %Pnt{x:  53450, y: -31844, vx: -5, vy:  3},
    %Pnt{x:  32142, y:  42745, vx: -3, vy: -4},
    %Pnt{x: -31782, y: -53152, vx: 3, vy:  5},
    %Pnt{x: -53091, y: -10527, vx: 5, vy:  1},
    %Pnt{x:  42798, y:  10777, vx: -4, vy: -1},
    %Pnt{x: -42422, y:  42744, vx: 4, vy: -4},
    %Pnt{x:  10855, y: -10529, vx: -1, vy:  1},
    %Pnt{x:  21490, y:  32094, vx: -2, vy: -3},
    %Pnt{x: -42437, y: -42504, vx: 4, vy:  4},
    %Pnt{x:  53483, y: -21192, vx: -5, vy:  2},
    %Pnt{x:  53466, y:  53406, vx: -5, vy: -5},
    %Pnt{x: -10458, y: -31848, vx: 1, vy:  3},
    %Pnt{x:  42771, y:  32090, vx: -4, vy: -3},
    %Pnt{x: -31780, y:  53404, vx: 3, vy: -5},
    %Pnt{x: -53115, y: -10536, vx: 5, vy:  1},
    %Pnt{x: -10449, y:  10776, vx: 1, vy: -1},
    %Pnt{x: -31772, y:  32097, vx: 3, vy: -3},
    %Pnt{x:  21515, y: -21186, vx: -2, vy:  2},
    %Pnt{x:  42815, y:  42749, vx: -4, vy: -4},
    %Pnt{x: -21158, y:  21437, vx: 2, vy: -2},
    %Pnt{x:  42774, y: -31846, vx: -4, vy:  3},
    %Pnt{x: -53105, y:  53405, vx: 5, vy: -5},
    %Pnt{x:  21478, y: -10527, vx: -2, vy:  1},
    %Pnt{x: -31781, y: -21183, vx: 3, vy:  2},
    %Pnt{x:  53450, y:  32093, vx: -5, vy: -3},
    %Pnt{x:  10810, y: -42499, vx: -1, vy:  4},
    %Pnt{x:  32132, y:  10781, vx: -3, vy: -1},
    %Pnt{x:  32138, y:  10785, vx: -3, vy: -1},
    %Pnt{x:  10863, y: -21190, vx: -1, vy:  2},
    %Pnt{x:  10859, y:  53409, vx: -1, vy: -5},
    %Pnt{x: -53109, y: -42499, vx: 5, vy:  4},
    %Pnt{x:  32132, y:  53400, vx: -3, vy: -5},
    %Pnt{x:  53434, y:  32088, vx: -5, vy: -3},
    %Pnt{x:  53479, y: -10530, vx: -5, vy:  1},
    %Pnt{x:  53487, y:  21432, vx: -5, vy: -2},
    %Pnt{x:  53427, y:  10779, vx: -5, vy: -1},
    %Pnt{x: -10465, y:  21434, vx: 1, vy: -2},
    %Pnt{x: -21149, y:  21432, vx: 2, vy: -2},
    %Pnt{x:  10823, y: -42504, vx: -1, vy:  4},
    %Pnt{x: -42446, y:  10783, vx: 4, vy: -1},
    %Pnt{x: -31771, y:  42753, vx: 3, vy: -4},
    %Pnt{x:  21501, y:  10780, vx: -2, vy: -1},
    %Pnt{x: -53081, y: -31847, vx: 5, vy:  3},
    %Pnt{x:  53475, y:  53400, vx: -5, vy: -5},
    %Pnt{x: -53074, y: -53160, vx: 5, vy:  5},
    %Pnt{x: -53126, y:  21441, vx: 5, vy: -2},
    %Pnt{x:  10823, y: -21190, vx: -1, vy:  2},
    %Pnt{x:  53485, y: -53160, vx: -5, vy:  5},
    %Pnt{x: -21108, y:  10785, vx: 2, vy: -1},
    %Pnt{x: -42457, y:  32097, vx: 4, vy: -3},
    %Pnt{x: -10486, y: -53158, vx: 1, vy:  5},
    %Pnt{x:  53466, y:  21432, vx: -5, vy: -2},
    %Pnt{x:  10834, y:  53409, vx: -1, vy: -5},
    %Pnt{x:  21493, y:  32090, vx: -2, vy: -3},
    %Pnt{x: -31798, y: -21183, vx: 3, vy:  2},
    %Pnt{x: -42429, y: -10536, vx: 4, vy:  1},
    %Pnt{x: -53131, y:  10781, vx: 5, vy: -1},
    %Pnt{x:  53459, y:  53404, vx: -5, vy: -5},
    %Pnt{x:  53469, y:  53404, vx: -5, vy: -5},
    %Pnt{x:  42828, y:  53409, vx: -4, vy: -5},
    %Pnt{x: -21139, y: -53160, vx: 2, vy:  5},
    %Pnt{x: -31769, y: -42499, vx: 3, vy:  4},
    %Pnt{x:  42821, y:  10781, vx: -4, vy: -1},
    %Pnt{x:  21490, y:  21434, vx: -2, vy: -2},
    %Pnt{x:  21459, y: -53158, vx: -2, vy:  5},
    %Pnt{x:  10842, y: -10533, vx: -1, vy:  1},
    %Pnt{x:  42778, y:  32097, vx: -4, vy: -3},
    %Pnt{x:  32131, y:  42750, vx: -3, vy: -4},
    %Pnt{x:  42821, y: -10531, vx: -4, vy:  1},
    %Pnt{x:  42775, y: -53159, vx: -4, vy:  5},
    %Pnt{x:  42820, y: -42495, vx: -4, vy:  4},
    %Pnt{x:  53468, y:  53404, vx: -5, vy: -5},
    %Pnt{x: -31818, y:  42746, vx: 3, vy: -4},
    %Pnt{x: -42422, y: -31840, vx: 4, vy:  3},
    %Pnt{x:  21479, y: -21183, vx: -2, vy:  2},
    %Pnt{x: -42454, y:  21435, vx: 4, vy: -2},
    %Pnt{x:  10847, y: -53152, vx: -1, vy:  5},
    %Pnt{x: -31813, y:  53409, vx: 3, vy: -5},
    %Pnt{x:  10847, y:  21435, vx: -1, vy: -2},
    %Pnt{x: -53081, y:  32094, vx: 5, vy: -3},
    %Pnt{x: -42473, y:  32096, vx: 4, vy: -3},
    %Pnt{x:  10807, y: -42503, vx: -1, vy:  4},
    %Pnt{x:  10862, y:  32097, vx: -1, vy: -3},
    %Pnt{x:  53469, y:  10785, vx: -5, vy: -1},
    %Pnt{x:  21503, y: -42498, vx: -2, vy:  4},
    %Pnt{x:  53430, y:  21435, vx: -5, vy: -2},
    %Pnt{x:  53427, y: -31841, vx: -5, vy:  3},
    %Pnt{x:  42799, y: -42495, vx: -4, vy:  4},
    %Pnt{x: -21107, y: -31839, vx: 2, vy:  3},
    %Pnt{x:  21511, y: -53151, vx: -2, vy:  5},
    %Pnt{x: -42433, y: -10530, vx: 4, vy:  1},
    %Pnt{x: -31777, y: -31846, vx: 3, vy:  3},
    %Pnt{x: -21141, y: -21191, vx: 2, vy:  2},
    %Pnt{x: -53100, y:  32094, vx: 5, vy: -3},
    %Pnt{x:  21514, y:  42753, vx: -2, vy: -4},
    %Pnt{x: -42466, y:  10785, vx: 4, vy: -1},
    %Pnt{x: -31790, y:  21441, vx: 3, vy: -2},
    %Pnt{x: -42433, y:  32095, vx: 4, vy: -3},
    %Pnt{x: -42430, y: -42497, vx: 4, vy:  4},
    %Pnt{x:  21503, y: -31840, vx: -2, vy:  3},
    %Pnt{x:  21475, y: -53154, vx: -2, vy:  5},
    %Pnt{x: -42449, y:  32095, vx: 4, vy: -3},
    %Pnt{x: -53094, y:  10784, vx: 5, vy: -1},
    %Pnt{x:  21495, y: -21192, vx: -2, vy:  2},
    %Pnt{x:  53434, y: -21191, vx: -5, vy:  2},
    %Pnt{x:  32143, y: -21189, vx: -3, vy:  2},
    %Pnt{x: -21140, y: -53155, vx: 2, vy:  5},
    %Pnt{x:  21495, y:  42744, vx: -2, vy: -4},
    %Pnt{x:  21502, y:  32097, vx: -2, vy: -3},
    %Pnt{x: -53094, y: -42495, vx: 5, vy:  4},
    %Pnt{x: -42474, y:  53406, vx: 4, vy: -5},
    %Pnt{x: -21141, y: -10535, vx: 2, vy:  1},
    %Pnt{x:  42788, y: -31843, vx: -4, vy:  3},
    %Pnt{x: -21139, y: -21192, vx: 2, vy:  2},
    %Pnt{x: -10493, y:  10782, vx: 1, vy: -1},
  ]
  def get_test, do: [
    %Pnt{x: 9, y:  1, vx: 0, vy:  2},
    %Pnt{x: 7, y:  0, vx: -1, vy:  0},
    %Pnt{x: 3, y: -2, vx: -1, vy:  1},
    %Pnt{x: 6, y: 10, vx: -2, vy: -1},
    %Pnt{x: 2, y: -4, vx:  2, vy:  2},
    %Pnt{x: -6, y: 10, vx:  2, vy: -2},
    %Pnt{x: 1, y:  8, vx:  1, vy: -1},
    %Pnt{x: 1, y:  7, vx:  1, vy:  0},
    %Pnt{x: -3, y: 11, vx:  1, vy: -2},
    %Pnt{x: 7, y:  6, vx: -1, vy: -1},
    %Pnt{x: -2, y:  3, vx:  1, vy:  0},
    %Pnt{x: -4, y:  3, vx:  2, vy:  0},
    %Pnt{x: 10, y: -3, vx: -1, vy:  1},
    %Pnt{x: 5, y: 11, vx:  1, vy: -2},
    %Pnt{x: 4, y:  7, vx:  0, vy: -1},
    %Pnt{x: 8, y: -2, vx:  0, vy:  1},
    %Pnt{x: 15, y:  0, vx: -2, vy:  0},
    %Pnt{x: 1, y:  6, vx:  1, vy:  0},
    %Pnt{x: 8, y:  9, vx:  0, vy: -1},
    %Pnt{x: 3, y:  3, vx: -1, vy:  1},
    %Pnt{x: 0, y:  5, vx:  0, vy: -1},
    %Pnt{x: -2, y:  2, vx:  2, vy:  0},
    %Pnt{x: 5, y: -2, vx:  1, vy:  2},
    %Pnt{x: 1, y:  4, vx:  2, vy:  1},
    %Pnt{x: -2, y:  7, vx:  2, vy: -2},
    %Pnt{x: 3, y:  6, vx: -1, vy: -1},
    %Pnt{x: 5, y:  0, vx:  1, vy:  0},
    %Pnt{x: -6, y:  0, vx:  2, vy:  0},
    %Pnt{x: 5, y:  9, vx:  1, vy: -2},
    %Pnt{x: 14, y:  7, vx: -2, vy:  0},
    %Pnt{x: -3, y:  6, vx:  2, vy: -1},
  ]
  @doc """
  quick and simple obtain a stream from an input file path
  """
  def get_file_stream(path), do: path |> File.stream!()

  @doc """
  a-z alphabet
  """
  def letters, do: ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
"q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

  @doc """
  convert a string to a freq count per letter

  ## Examples

      iex> Msg.Helper.string_freq_count("abcdef")
      %{"a" => 1, "b" => 1, "c" => 1, "d" => 1, "e" => 1, "f" => 1}

      iex> Msg.Helper.string_freq_count("bababc")
      %{"a" => 2, "b" => 3, "c" => 1}

  """
  def string_freq_count(str) do
    str
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, fn(l, acc) -> acc |> Map.update(l, 1, &(&1 + 1)) end)
  end

  @doc """
  Does a Map have a Value as a Member?

  ## Examples

      iex> Msg.Helper.map_value_member?(Msg.Helper.string_freq_count("abcdef"), 2)
      false

      iex> Msg.Helper.map_value_member?(Msg.Helper.string_freq_count("bababc"), 2)
      true

      iex> Msg.Helper.map_value_member?(Msg.Helper.string_freq_count("bababc"), 3)
      true

      iex> Msg.Helper.map_value_member?(Msg.Helper.string_freq_count("bababc"), 4)
      false

  """
  def map_value_member?(%{} = f, n) do
    f |> Map.values() |> Enum.member?(n)
  end

  @doc """
  build grid and assign {x, y} points

  ## Examples

      iex> Msg.Helper.grid(5) |> List.last()
      %{x: 4, y: 4}

      iex> Msg.Helper.grid(5) |> List.first()
      %{x: 0, y: 0}

      iex> Msg.Helper.grid(5, %{id: :custom}) |> List.last()
      %{id: :custom, x: 4, y: 4}

  """
  def grid(len \\ 10, src \\ %{}) do
    len = len - 1
    for x <- 0..len, y <- 0..len do
      src |> Map.merge(%{x: x, y: y})
    end
  end

end