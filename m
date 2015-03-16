From: Jakub Kicinski <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: [PATCH 0/4] serial: sc16is7xx: bunch of small fixes
Date: Tue, 17 Mar 2015 00:28:45 +0100
Message-ID: <1426548529-21738-1-git-send-email-moorray3@wp.pl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Karol=20D=C4=99bog=C3=B3rski?= <k.debogorski-XA5MxPtj9CQ@public.gmane.org>, Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>

This series fixes three small problems with the sc16is7xx driver
and adds an ability to configure from user space the RTS inversion
for RS-485 mode.

None of the fixed issues is pressing so this seems like a -next
material (based on tty.git/tty-next).

Jakub Kicinski (4):
  sc16is7xx: remove ports on probe error path
  sc16is7xx: don't wipe out port configuration on shutdown
  sc16is7xx: expose RTS inversion in RS-485 mode
  sc16is7xx: enable the clock

 drivers/tty/serial/sc16is7xx.c | 44 ++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

-- 
2.1.0
