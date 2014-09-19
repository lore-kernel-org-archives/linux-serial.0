From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
Subject: RE: [PATCH] serial: imx: fix throttle/unthrottle callbacks for
 hardware assisted flow control
Date: Fri, 19 Sep 2014 07:46:32 +0000
Message-ID: <084e39be60d6494eb6ad370882a8eb28@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1411111031-22172-1-git-send-email-b38611@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bn1bon0131.outbound.protection.outlook.com ([157.56.111.131]:43712
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751008AbaISISt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 04:18:49 -0400
In-Reply-To: <1411111031-22172-1-git-send-email-b38611@freescale.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "fugang.duan@freescale.com" <fugang.duan@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Pls ignore the patch.

From: Fugang Duan <b38611@freescale.com> Sent: Friday, September 19, 2014 3:17 PM
>To: gregkh@linuxfoundation.org
>Cc: linux-serial@vger.kernel.org; Duan Fugang-B38611
>Subject: [PATCH] serial: imx: fix throttle/unthrottle callbacks for
>hardware assisted flow control
>
>From: Huang Shijie <b32955@freescale.com>
>
>From datasheet, UCR2[CTS] bit controls the 'CTS' bit and takes effort only
>when the 'CTSC' bit is negated. 'CTS' has no function when 'CTSC' is
>asserted.
>0: The CTS pin is high (inactive)
>1: The CTS pin is low (active)
>
>For throttle, it needs to clear 'CTS' and 'CTSC' bits.
>For unthrottle, it needs to enable 'CTS' and 'CTSC' bits.
>
>The patch just fix the issue.
>
>Signed-off-by: Fugang Duan  <B38611@freescale.com>
>---
> drivers/tty/serial/imx.c |    6 ++----
> 1 files changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
>044e86d..070a37e 100644
>--- a/drivers/tty/serial/imx.c
>+++ b/drivers/tty/serial/imx.c
>@@ -823,11 +823,9 @@ static void imx_set_mctrl(struct uart_port *port,
>unsigned int mctrl)
> 	struct imx_port *sport = (struct imx_port *)port;
> 	unsigned long temp;
>
>-	temp = readl(sport->port.membase + UCR2) & ~UCR2_CTS;
>-
>+	temp = readl(sport->port.membase + UCR2) & ~(UCR2_CTS | UCR2_CTSC);
> 	if (mctrl & TIOCM_RTS)
>-		if (!sport->dma_is_enabled)
>-			temp |= UCR2_CTS;
>+		temp |= UCR2_CTS | UCR2_CTSC;
>
> 	writel(temp, sport->port.membase + UCR2);
>
>--
>1.7.8

