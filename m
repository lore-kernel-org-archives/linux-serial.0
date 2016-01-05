From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/1] serial: sh-sci: Remove cpufreq notifier to fix crash/deadlock
Date: Tue,  5 Jan 2016 19:36:35 +0100
Message-ID: <1452018997-14103-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Michael Turquette <mturquette@baylibre.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Jiri,

The BSP team noticed that there is spin/mutex lock issue on sh-sci when
CPUFREQ is used.  The issue is that the notifier function may call
mutex_lock() while the spinlock is held, which can lead to a BUG().
This may happen if CPUFREQ is changed while another CPU calls
clk_get_rate().

Taking the spinlock was added to the notifier function in commit
e552de2413edad1a ("sh-sci: add platform device private data"), to
protect the list of serial ports against modification during traversal.
At that time the Common Clock Framework didn't exist yet, and
clk_get_rate() just returned clk->rate without taking a mutex.
Note that since commit d535a2305facf9b4 ("serial: sh-sci: Require a
device per port mapping."), there's no longer a list of serial ports to
traverse, and taking the spinlock became superfluous.

To fix the issue, just remove the cpufreq notifier:
  1. The notifier doesn't work correctly: all it does is update the
     stored clock rate; it does not update the divider in the hardware.
     The divider will only be updated when calling sci_set_termios().
     I believe this was broken back in 2004, when the old
     drivers/char/sh-sci.c driver (where the notifier did update the
     divider) was replaced by drivers/serial/sh-sci.c (where the
     notifier just updated port->uartclk).
     Cfr. full-history-linux commits 6f8deaef2e9675d9 ("[PATCH] sh: port
     sh-sci driver to the new API") and 3f73fe878dc9210a ("[PATCH]
     Remove old sh-sci driver").
  2. On modern SoCs, the sh-sci parent clock rate is no longer related
     to the CPU clock rate anyway, so using a cpufreq notifier is
     futile.

Both patches fix the same issue:
  - Patch 1a applies against tty/tty-next and v4.4-rc1..v4.4-rc8, and is
    intended for current/stable.
    It needs some rework to apply to earlier kernel versions, as
    functions were moved around in v4.4.-rc1.
  - Patch 1b applies against tty/tty-next with scif-clk-sck-brg-for-v4.5
    (pending pull request for v4.5) appplied, and is intended for next.

Thanks for your comments!

Geert Uytterhoeven (1):
  serial: sh-sci: Remove cpufreq notifier to fix crash/deadlock
  serial: sh-sci: Remove cpufreq notifier to fix crash/deadlock

 drivers/tty/serial/sh-sci.c | 39/42 ---------------------------------------
 1 file changed, 39/42 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
