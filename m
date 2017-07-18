From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH 0/5] earlycon hang under some conditions
Date: Tue, 18 Jul 2017 12:29:58 +0800
Message-ID: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, briannorris@chromium.org, dianders@chromium.org, peter@hurleysoftware.com, Jeffy Chen <jeffy.chen@rock-chips.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Jiri Slaby <jslaby@suse.com>, Vineet Gupta <vgupta@synopsys.com>, linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

I was testing earlycon with 8250 dw serial console. And it hangs in
these cases:
1/ kernel hang when calling early write function after free_initmem:
a) the earlycon not disabled after the init code(due to keep_bootcon or
   not specify a real console to switch to)
b) the early write func is marked as __init, for example 8250_early.

2/ kernel hang when calling early write function after disable unused
clks/pm domain:
a) the earlycon not disabled after the init code
b) the disable unused clks/pm domain kill the requiered clks/pm
   domain, since they are not referenced by the earlycon.

3/ kernel hang when calling early write function after the serial
   console driver runtime suspended:
a) the earlycon not disabled after the init code
b) the serial console driver's runtime suspend kills the requiered
   clks/pm domain, since they are not referenced by the earlycon.

This serial fix 1/ case only.



Jeffy Chen (5):
  serial: arc: Remove __init marking from early write
  serial: omap: Remove __init marking from early write
  serial: xuartps: Remove __init marking from early write
  serial: 8250_ingenic: Remove __init marking from early write
  serial: 8250_early: Remove __init marking from early write

 drivers/tty/serial/8250/8250_early.c   |  8 ++++----
 drivers/tty/serial/8250/8250_ingenic.c |  8 ++++----
 drivers/tty/serial/arc_uart.c          |  4 ++--
 drivers/tty/serial/omap-serial.c       | 13 ++++++-------
 drivers/tty/serial/xilinx_uartps.c     |  2 +-
 5 files changed, 17 insertions(+), 18 deletions(-)

-- 
2.1.4
