From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] tty/serial/ucc_uart: Improve a size determination in
 ucc_uart_probe()
Date: Wed, 6 Dec 2017 22:12:39 +0100
Message-ID: <38dd53cc-f7e8-57b9-bd0f-0946c787ac2e@users.sourceforge.net>
References: <5c6d363d-398b-4695-78c3-33b9e8dbffa3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c6d363d-398b-4695-78c3-33b9e8dbffa3@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Timur Tabi <timur@tabi.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Dec 2017 21:45:32 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/ucc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 48364f0eba72..a9ce652899aa 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1253,7 +1253,7 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 		}
 	}
 
-	qe_port = kzalloc(sizeof(struct uart_qe_port), GFP_KERNEL);
+	qe_port = kzalloc(sizeof(*qe_port), GFP_KERNEL);
 	if (!qe_port)
 		return -ENOMEM;
 
-- 
2.15.1
