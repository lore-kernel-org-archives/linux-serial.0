From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/3] tree-wide: don't use GPIOF_* with gpiod_get_direction
Date: Sun, 14 Jan 2018 22:07:07 +0100
Message-ID: <20180114210711.13863-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The documentation was wrong, gpiod_get_direction() returns 0/1 instead of the
GPIOF_* flags. The docs were fixed with commit 94fc73094abe47 ("gpio: correct
docs about return value of gpiod_get_direction"). Now, fix the users who got it
as wrong as I did when developing bus recovery for the R-Car I2C driver.

We get rid of two users of 'linux/gpio.h' this way :)

Only build tested due to no hardware.


Wolfram Sang (3):
  extcon: int3496: don't use GPIOF_* with gpiod_get_direction
  serial: mxs-auart: don't use GPIOF_* with gpiod_get_direction
  backlight: pwm_bl: don't use GPIOF_* with gpiod_get_direction

 drivers/extcon/extcon-intel-int3496.c | 4 ++--
 drivers/tty/serial/mxs-auart.c        | 3 +--
 drivers/video/backlight/pwm_bl.c      | 6 +++---
 3 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.11.0
