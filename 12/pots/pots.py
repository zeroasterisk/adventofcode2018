initial = '######....##.###.#..#####...#.#.....#..#.#.##......###.#..##..#..##..#.##..#####.#.......#.....##..'

rule = {}
rule['...##'] = '#'
rule['###..'] = '.'
rule['#.#.#'] = '.'
rule['#####'] = '.'
rule['....#'] = '.'
rule['##.##'] = '.'
rule['##.#.'] = '#'
rule['##...'] = '#'
rule['#..#.'] = '#'
rule['#.#..'] = '.'
rule['#.##.'] = '.'
rule['.....'] = '.'
rule['##..#'] = '.'
rule['#..##'] = '.'
rule['.##.#'] = '#'
rule['..###'] = '#'
rule['..#.#'] = '#'
rule['.####'] = '#'
rule['.##..'] = '.'
rule['.#..#'] = '#'
rule['..##.'] = '.'
rule['#....'] = '.'
rule['#...#'] = '.'
rule['.###.'] = '.'
rule['..#..'] = '.'
rule['####.'] = '#'
rule['.#.##'] = '.'
rule['###.#'] = '.'
rule['#.###'] = '#'
rule['.#...'] = '#'
rule['.#.#.'] = '.'
rule['...#.'] = '.'

current = '.'*30 + initial + '.'*300

next = ['.']*len(current)

lasttot = 0
for t in range(1000):
    tot = 0
    for p in range(len(current)):
        if current[p] == '#':
            tot += p-30
    print current
    print t,tot,lasttot,tot-lasttot
    lasttot = tot

    for i in range(2,len(current)-2):
        spot = current[i-2:i+3]
        next[i] = rule[spot]

    current = ''.join(next)
    if current[:5] != '.....':
        print 'hit left end'
        break
    if current[-5:] != '.....':
        print 'hit right end'
        break

print current
