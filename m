From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH v2 2/3] serial: mxs-auart: add the DMA support for mx28
Date: Thu, 15 Nov 2012 17:11:42 +0800
Message-ID: <50A4B1CE.5070203@freescale.com>
References: <1351074456-25863-1-git-send-email-b32955@freescale.com> <1351074456-25863-3-git-send-email-b32955@freescale.com> <50A21613.6030709@bluegiga.com> <50A45F83.1010009@freescale.com> <50A4983F.8080407@bluegiga.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------000706060904090302040907"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:29038 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754505Ab2KOJHr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 04:07:47 -0500
In-Reply-To: <50A4983F.8080407@bluegiga.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, linux@arm.linux.org.uk, vinod.koul@intel.com, Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>, Fabio Estevam <fabio.estevam@freescale.com>

--------------000706060904090302040907
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

=E4=BA=8E 2012=E5=B9=B411=E6=9C=8815=E6=97=A5 15:22, Lauri Hintsala =E5=86=
=99=E9=81=93:
> Hi,
>
> On 11/15/2012 05:20 AM, Huang Shijie wrote:
>> =E4=BA=8E 2012=E5=B9=B411=E6=9C=8813=E6=97=A5 17:42, Lauri Hintsala =E5=
=86=99=E9=81=93:
>>> Hi Huang,
>>>
>>> DMA support doesn't work with latest stable v3.6.5 or development
>>> 3.7-rc5 kernels. I get following error message when I open the serial
>>> port /dev/ttyAPP0:
>>>
>>> [ 48.730000] mxs-auart 8006a000.serial: step 1 error
>>> [ 48.750000] mxs-auart 8006a000.serial: We can not start up the DMA.
>>>
>> I tested this patch set in imx28-evk board Rev C with=20
>> linux-next-20121114.
>> it works fine.
>>
>> Maybe you can try the linux-next code.
>
> I tested linux-next-20121114 on apx4devkit (imx28 based device) and I=20
> got the same error message:
>
> # stty -F /dev/ttyAPP0 crtscts; microcom /dev/ttyAPP0 -s 115200
> [  133.710000] mxs-auart 8006a000.serial: step 1 error
> [  133.720000] mxs-auart 8006a000.serial: We can not start up the DMA.
Could you test this patch?

thanks
Huang  Shijie

--------------000706060904090302040907
Content-Type: text/x-patch; name="0001-fix-patch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-fix-patch.patch"

>From 502db325af8664e239be3da47f32d496f3db036f Mon Sep 17 00:00:00 2001
From: Huang Shijie <b32955@freescale.com>
Date: Thu, 15 Nov 2012 16:24:31 +0800
Subject: [PATCH] fix patch


Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/mxs-auart.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index d593e0a..0e60ef2 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -542,7 +542,7 @@ static int mxs_auart_dma_init(struct mxs_auart_port *s)
 	dma_cap_mask_t mask;
 
 	if (auart_dma_enabled(s))
-		return 0;
+		return -EBUSY;
 
 	/* We do not get the right DMA channels. */
 	if (s->dma_channel_rx == -1 || s->dma_channel_rx == -1)
@@ -666,10 +666,21 @@ static void mxs_auart_settermios(struct uart_port *u,
 		 * in mx28.
 		 */
 		if (is_imx28_auart(s) && (s->flags & MXS_AUART_DMA_CONFIG)) {
-			if (!mxs_auart_dma_init(s))
+			if (!mxs_auart_dma_init(s)) {
 				/* enable DMA tranfer */
 				ctrl2 |= AUART_CTRL2_TXDMAE | AUART_CTRL2_RXDMAE
 				       | AUART_CTRL2_DMAONERR;
+
+				/* prepare for the DMA RX. */
+				if (!mxs_auart_dma_prep_rx(s)) {
+					/* Disable the normal RX irq. */
+					writel(AUART_INTR_RXIEN,
+						u->membase + AUART_INTR_CLR);
+				} else {
+					mxs_auart_dma_exit(s);
+					dev_err(s->dev, "DMA failed.\n");
+				}
+			}
 		}
 		ctrl2 |= AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
 	} else {
@@ -687,16 +698,6 @@ static void mxs_auart_settermios(struct uart_port *u,
 
 	uart_update_timeout(u, termios->c_cflag, baud);
 
-	/* prepare for the DMA RX. */
-	if (auart_dma_enabled(s)) {
-		if (!mxs_auart_dma_prep_rx(s)) {
-			/* Disable the normal RX interrupt. */
-			writel(AUART_INTR_RXIEN, u->membase + AUART_INTR_CLR);
-		} else {
-			mxs_auart_dma_exit(s);
-			dev_err(s->dev, "We can not start up the DMA.\n");
-		}
-	}
 }
 
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
-- 
1.7.0.4


--------------000706060904090302040907--
