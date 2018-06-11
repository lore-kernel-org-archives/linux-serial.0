From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] serial: pxa: Fix an error handling path in 'serial_pxa_probe()'
Date: Mon, 11 Jun 2018 19:30:35 +0200
Message-ID: <20180611173035.26930-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-serial@vger.kernel.org

If port.line is out of range, we still need to release some resources, or
we will leak them.

Fixes: afc7851fab83 ("serial: pxa: Fix out-of-bounds access through serial port index")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/pxa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index eda3c7710d6a..4932b674f7ef 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -887,7 +887,8 @@ static int serial_pxa_probe(struct platform_device *dev)
 		goto err_clk;
 	if (sport->port.line >= ARRAY_SIZE(serial_pxa_ports)) {
 		dev_err(&dev->dev, "serial%d out of range\n", sport->port.line);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_clk;
 	}
 	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
 
-- 
2.17.0
