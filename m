From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] serial: ifx6x60: Improve a size determination in
 ifx_spi_spi_probe()
Date: Sat, 9 Dec 2017 20:12:21 +0100
Message-ID: <2134a9fd-73d9-686f-cc41-0d143a62cbbe@users.sourceforge.net>
References: <992f55e5-961d-79ea-a6cd-441ceb3ad058@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <992f55e5-961d-79ea-a6cd-441ceb3ad058@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 9 Dec 2017 19:22:50 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/ifx6x60.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 832751479f41..1883e3382338 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1005,7 +1005,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 	}
 
 	/* initialize structure to hold our device variables */
-	ifx_dev = kzalloc(sizeof(struct ifx_spi_device), GFP_KERNEL);
+	ifx_dev = kzalloc(sizeof(*ifx_dev), GFP_KERNEL);
 	if (!ifx_dev)
 		return -ENOMEM;
 
-- 
2.15.1
