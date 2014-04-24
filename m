From: yegorslists@googlemail.com
Subject: omap-serial: use mctrl_gpio helpers
Date: Thu, 24 Apr 2014 11:24:30 +0200
Message-ID: <1398331471-16745-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org
List-Id: linux-serial@vger.kernel.org

This patch is based on Richard Genoud' patch adding generic GPIO support [1]
and my patch adding get_direction() functionality to OMAP's GPIO driver [2].

So far RTS/DTR are working both as modem control outputs and RTS as RS-485 2-wire controller.

CTS/DSR/DSR/RI are generating interrupts.

Richard, Greg, what is the status of [1]? It seems like it will be available in 3.16 first?

TODO:

1. remove rts_gpio from uart_omap_port
2. perhaps add rts_gpiod to uart_omap_port to avoid numerous invocations of

rts_gpiod = mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS);
3. add device tree documentation 

Yegor

[1] http://comments.gmane.org/gmane.linux.serial/13967
[2] http://www.spinics.net/lists/arm-kernel/msg325162.html

