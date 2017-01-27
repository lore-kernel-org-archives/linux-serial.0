From: Shailendra Verma <shailendra.v@samsung.com>
Subject: [PATCH] Tty: serial - Fix possible NULL derefrence.
Date: Fri, 27 Jan 2017 16:46:13 +0530
Message-ID: <1485515773-3542-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170127111619epcas4p44c21059f85b7aa091016019c98d42939@epcas4p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.v@samsung.com>, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: linux-serial@vger.kernel.org

of_match_device could return NULL, and so can cause a NULL
pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/tty/serial/max310x.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 8a3e926..a94d147 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1323,6 +1323,10 @@ static int max310x_spi_probe(struct spi_device *spi)
 	if (spi->dev.of_node) {
 		const struct of_device_id *of_id =
 			of_match_device(max310x_dt_ids, &spi->dev);
+		if (!of_id) {
+			dev_err(&spi->dev, "Error: No device match found\n");
+			return -ENODEV;
+		}
 
 		devtype = (struct max310x_devtype *)of_id->data;
 	} else {
-- 
1.7.9.5
