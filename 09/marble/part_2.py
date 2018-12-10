from collections import deque
import re, collections, numpy

from collections import deque, defaultdict

def play_game(max_players, last_marble):
    scores = defaultdict(int)
    circle = deque([0])

    for marble in range(1, last_marble + 1):
        if marble % 23 == 0:
            circle.rotate(7)
            scores[marble % max_players] += marble + circle.pop()
            circle.rotate(-1)
        else:
            circle.rotate(-1)
            circle.append(marble)

    return max(scores.values()) if scores else 0

def play(players, last_marble):
    marbles = range(1, last_marble+1)

    circle = collections.deque([0])
    scores = numpy.zeros(players, dtype=numpy.int64)
    for marble in marbles:
        player = (marble-1) % players

        # first marble in circle = current marble!
        if marble % 23 == 0:
            circle.rotate(7)
            scores[player] += marble + circle.popleft()
        else:
            circle.rotate(-2)
            circle.appendleft(marble)

    return max(scores)


def game(players, marbles):
    state = deque([0])
    scores = players*[0]
    for m in range(1, marbles+1):
        player = (m-1)%players
        if m % 23 == 0:
            state.rotate(-7)
            scores[player] += m + state.pop()
        else:
            state.rotate(2)
            state.append(m)
    return max(scores)

if __name__ == "__main__":
    print("game")
    print(game(476, 7165700))
    print("play")
    print(play(476, 7165700))
    #  print("play_game")
    #  print(play_game(476, 7999 * 100))
    print("done")
    #  game(476, 7165700)
