From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/5] tty: serial: sh-sci: Hide driver specific config questions
Date: Thu, 30 Nov 2017 14:11:57 +0100
Message-ID: <1512047522-16312-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

	Hi Greg, Simon, Magnus, Sato-san, Rich,

The Renesas (H)SCI(F) driver has several driver-specific config options.
This may confuse users, and leads to inefficient testing and development.
E.g. recently a regression was introduced in SCIF DMA support, and
someone didn't see early con output, both due to the relevant options
being accidentally disabled.

This patch series is an attempt to stop bothering (H)SCI(F) users with
several config questions, while providing sensible defaults for these
options, based on the target platform.  The defaults can still be
overridden if CONFIG_EXPERT is enabled.

The last patch updates shmobile_defconfig to take into account the
defaults.  It is marked RFC, as it depends on the first 4 patches to be
effective, and to avoid feature regressions.

Thanks for your comments!

Geert Uytterhoeven (5):
  tty: serial: sh-sci: Hide number of ports config question
  tty: serial: sh-sci: Hide serial console config question
  tty: serial: sh-sci: Hide earlycon config question
  tty: serial: sh-sci: Hide DMA config question
  [RFC] ARM: shmobile: defconfig: Disable CONFIG_EMBEDDED

 arch/arm/configs/shmobile_defconfig |  6 +-----
 drivers/tty/serial/Kconfig          | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
