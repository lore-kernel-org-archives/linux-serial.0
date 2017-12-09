From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] serial: ifx6x60: Delete an error message for a failed
 memory allocation in ifx_spi_spi_probe()
Date: Sat, 9 Dec 2017 20:11:17 +0100
Message-ID: <378523b8-0fd4-2bc0-03f8-fa57e60e95e0@users.sourceforge.net>
References: <992f55e5-961d-79ea-a6cd-441ceb3ad058@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <992f55e5-961d-79ea-a6cd-441ceb3ad058@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 9 Dec 2017 19:20:37 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/ifx6x60.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 473f4f81d690..832751479f41 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1006,10 +1006,9 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 
 	/* initialize structure to hold our device variables */
 	ifx_dev = kzalloc(sizeof(struct ifx_spi_device), GFP_KERNEL);
-	if (!ifx_dev) {
-		dev_err(&spi->dev, "spi device allocation failed");
+	if (!ifx_dev)
 		return -ENOMEM;
-	}
+
 	saved_ifx_dev = ifx_dev;
 	ifx_dev->spi_dev = spi;
 	clear_bit(IFX_SPI_STATE_IO_IN_PROGRESS, &ifx_dev->flags);
-- 
2.15.1

