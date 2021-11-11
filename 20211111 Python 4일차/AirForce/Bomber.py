#import AirForce
from AirForce import AirForce
class Bomber(AirForce):
    def __init__(self, bomb_num):
        self.bomb_num = bomb_num
    def take_off(self):
        print("폭격기 발진")
    #def fly(self):
    #   print("폭격기 출격")
    def attack(self):
        print("bomb_num :", self.bomb_num, "폭탄 투하")
    def land(self):
        print("폭격기 착륙")

