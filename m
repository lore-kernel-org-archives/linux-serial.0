From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] serial8250-em: convert to clk_prepare/unprepare
Date: Tue,  8 Oct 2013 13:24:27 +0900
Message-ID: <1381206268-3914-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

please consider this enhancement from Kuribayashi-san for serial8250-em.

Also, please let me know if you would like us to handle serial patches
a different way.

Shinya Kuribayashi (1):
  serial8250-em: convert to clk_prepare/unprepare

 drivers/tty/serial/8250/8250_em.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.4

