From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] tty/serial/ucc_uart: Delete an error message for a failed
 memory allocation in ucc_uart_probe()
Date: Wed, 6 Dec 2017 22:11:07 +0100
Message-ID: <f67ae4e0-2f64-3b6d-bd87-3f249a0cca5e@users.sourceforge.net>
References: <5c6d363d-398b-4695-78c3-33b9e8dbffa3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <5c6d363d-398b-4695-78c3-33b9e8dbffa3@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@tabi.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Dec 2017 21:41:14 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/ucc_uart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 2b6376e6e5ad..48364f0eba72 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1254,10 +1254,8 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	}
 
 	qe_port = kzalloc(sizeof(struct uart_qe_port), GFP_KERNEL);
-	if (!qe_port) {
-		dev_err(&ofdev->dev, "can't allocate QE port structure\n");
+	if (!qe_port)
 		return -ENOMEM;
-	}
 
 	/* Search for IRQ and mapbase */
 	ret = of_address_to_resource(np, 0, &res);
-- 
2.15.1

