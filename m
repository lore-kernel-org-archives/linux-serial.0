From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH 0/2] Move uart_register_driver call to device probe for pl010 and sh-sci
Date: Fri, 24 Mar 2017 17:26:32 +0100
Message-ID: <20170324162634.8880-1-sjoerd.simons@collabora.co.uk>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org


When testing on a Renesas board with the PL010 serial driver enabled
serial output broke. Turns out the minor device numbers for both
drivers happen to overlap, causing whichever driver happened to be the
second one to register to fail.

The attached patches move the uart_register_driver call to probe time
for both drivers avoiding the issue.


Sjoerd Simons (2):
  serial: pl010: Move uart_register_driver call to device probe
  serial: sh-sci: Move uart_register_driver call to device probe

 drivers/tty/serial/amba-pl010.c | 27 +++++++++++++++++----------
 drivers/tty/serial/sh-sci.c     | 21 ++++++++++-----------
 2 files changed, 27 insertions(+), 21 deletions(-)

-- 
2.11.0
