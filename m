From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: [PATCH v2 0/2] Move uart_register_driver call to device probe for pl010 and sh-sci
Date: Thu, 20 Apr 2017 14:12:59 +0200
Message-ID: <20170420121301.382-1-sjoerd.simons@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org


When testing on a Renesas board with the PL010 serial driver enabled
serial output broke. Turns out the minor device numbers for both
drivers happen to overlap, causing whichever driver happened to be the
second one to register to fail.

The attached patches move the uart_register_driver call to probe time
for both drivers avoiding the issue.

Changes in v2:
- Add locking to prevent issues when two probes run in parallel

Sjoerd Simons (2):
  serial: pl010: Move uart_register_driver call to device probe
  serial: sh-sci: Move uart_register_driver call to device probe

 drivers/tty/serial/amba-pl010.c | 31 +++++++++++++++++++++----------
 drivers/tty/serial/sh-sci.c     | 26 +++++++++++++++-----------
 2 files changed, 36 insertions(+), 21 deletions(-)

-- 
2.11.0
