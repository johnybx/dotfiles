#!/usr/bin/python3
import argparse


def main():
    brightness_path = "/sys/class/backlight/intel_backlight/"
    brightness_f = brightness_path + "brightness"
    brightness_max_f = brightness_path + "max_brightness"
    actual_brightness_f = brightness_path + "actual_brightness"

    parser = argparse.ArgumentParser()
    parser.add_argument("--inc", help="increment brightness %")
    parser.add_argument("--dec", help="decrement brightness %")
    parser.add_argument("--query", action="store_true", help="get brightness level %")
    args = parser.parse_args()

    with open(brightness_max_f, "r") as f_brmax:
        brightness_max = int(f_brmax.read())
    with open(actual_brightness_f, "r") as f_actb:
        actual_brightness = int(f_actb.read())

    if args.query:
        brightness_p = int((actual_brightness / brightness_max) * 100)
        if brightness_p < 10:
            bulb = "󱩎"
        elif brightness_p < 20:
            bulb = "󱩏"
        elif brightness_p < 30:
            bulb = "󱩐"
        elif brightness_p < 40:
            bulb = "󱩑"
        elif brightness_p < 50:
            bulb = "󱩒"
        elif brightness_p < 60:
            bulb = "󱩓"
        elif brightness_p < 70:
            bulb = "󱩔"
        elif brightness_p < 80:
            bulb = "󱩕"
        elif brightness_p < 90:
            bulb = "󱩖"
        else:
            bulb = "󰛨"
        print(f"{bulb} - {brightness_p}%")
        exit()

    if args.inc or args.dec:
        if args.inc:
            actual_brightness += brightness_max / 100 * int(args.inc)
            if actual_brightness > brightness_max:
                actual_brightness = brightness_max

        elif args.dec:
            actual_brightness -= brightness_max / 100 * int(args.dec)
            if actual_brightness < 0:
                actual_brightness = 0

        with open(brightness_f, "w") as f_br:
            f_br.write(str(int(actual_brightness)))


if __name__ == "__main__":
    main()
