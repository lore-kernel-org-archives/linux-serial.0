From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 0/2] HSCIF tweaks support
Date: Fri, 29 Sep 2017 15:08:52 +0200
Message-ID: <1506690534-27302-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org
Cc: wsa@the-dreams.de, linux-serial@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi!

These patches enable tweaking of the HSCIF RX FIFO timeout and sampling
point via sysfs. I have put them in one series because they have textual
dependencies and implement similar functionality.

"serial: sh-sci: Support for variable HSCIF hardware RX timeout" includes
minor touch-ups suggested in Geert's review of the standalone version.

CU
Uli


Ulrich Hecht (2):
  serial: sh-sci: Support for variable HSCIF hardware RX timeout
  serial: sh-sci: Support for HSCIF RX sampling point adjustment

 drivers/tty/serial/sh-sci.c | 114 +++++++++++++++++++++++++++++++++++++-------
 drivers/tty/serial/sh-sci.h |   7 +++
 2 files changed, 104 insertions(+), 17 deletions(-)

-- 
2.7.4
