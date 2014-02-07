From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 0/8] tty/serial: at91: Add missing modem signals to atmel_serial.
Date: Fri,  7 Feb 2014 15:59:07 +0100
Message-ID: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:53365 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbaBGPAI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 10:00:08 -0500
Received: by mail-wg0-f42.google.com with SMTP id l18so824658wgh.1
        for <linux-serial@vger.kernel.org>; Fri, 07 Feb 2014 07:00:07 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

The USART controller on sam9x5 chips (and also all AT91/SAMA5 chips
but at91rm9200) are not capable of handling DTR/DSR/DCD/RI signal.
Moreover, even if the controller can handle CTS/RTS, the dedicated
CTS/RTS pins are already muxed for other peripherals (LCDC/EMAC/MMC).

So this patchset adds the possibility to control those lines via GPIO,
as it is done for RTS in the patch "switch atmel serial to use gpiolib"

With all those signals, you'll finally get the best out of your brand
new 33600 baud modem \o/.

And with the Ring Indicator, Atmel boards can now answer the phone !


This is based on 3.14-rc1 + Linus Walleij/Nicolas Ferre's patch:
 354e57f3a0a2 ARM/serial: at91: switch atmel serial to use gpiolib
(in Uwe's tree git://git.pengutronix.de/git/ukl/linux.git dropmachtimexh )

Tested on at91sam9g35, with a null modem cable between 2 serial ports,
one with CTS/RTS controlled by the USART controller, the other via GPIO,
full duplex transfers.
Did some tests also with null modem cables on a PC.

Richard Genoud (8):
  tty/serial: at91: use dev_err instead of printk
  tty/serial: at91: remove unused open/close hooks
  tty/serial: at91: prepare for more gpio lines to come
  tty/serial: at91: add cts control via gpio
  tty/serial: at91: add dtr control via gpio
  tty/serial: at91: add dsr control via gpio
  tty/serial: at91: add ring control via gpio
  tty/serial: at91: add dcd control via gpio

 .../devicetree/bindings/serial/atmel-usart.txt     |  15 +
 arch/arm/mach-at91/at91rm9200_devices.c            |  25 ++
 arch/arm/mach-at91/at91sam9260_devices.c           |  35 +++
 arch/arm/mach-at91/at91sam9261_devices.c           |  20 ++
 arch/arm/mach-at91/at91sam9263_devices.c           |  20 ++
 arch/arm/mach-at91/at91sam9g45_devices.c           |  25 ++
 arch/arm/mach-at91/at91sam9rl_devices.c            |  25 ++
 drivers/tty/serial/atmel_serial.c                  | 324 +++++++++++++++++----
 include/linux/platform_data/atmel.h                |   5 +
 9 files changed, 441 insertions(+), 53 deletions(-)

-- 
1.8.5

