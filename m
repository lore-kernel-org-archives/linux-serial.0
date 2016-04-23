From: Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 2/2] tty: serial: msm_serial add info message
Date: Sat, 23 Apr 2016 10:17:05 -0700
Message-ID: <571BAE11.3020706@gmail.com>
References: <571BAC8B.80001@gmail.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <571BAC8B.80001@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: ivan.ivanov@linaro.org
List-Id: linux-serial@vger.kernel.org

From: Frank Rowand <frank.rowand@am.sony.com>

Failure to enable DMA by the msm_serial driver is silent.
Add a message to report the failure.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 drivers/tty/serial/msm_serial.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/tty/serial/msm_serial.c
===================================================================
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -170,6 +170,7 @@ rel_tx:
 	dma_release_channel(dma->chan);
 no_tx:
 	memset(dma, 0, sizeof(*dma));
+	dev_info(dev, "msm_serial: DMA not enabled\n");
 }
 
 static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
