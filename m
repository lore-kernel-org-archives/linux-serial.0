From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH 14/16] tty: serial: imx: remove the use of
 MXC_INTERNAL_IRQS
Date: Mon, 18 Jun 2012 16:22:08 +0800
Message-ID: <20120618082207.GE25447@shlinux2.ap.freescale.net>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-15-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:21884
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751317Ab2FRIZS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 04:25:18 -0400
Content-Disposition: inline
In-Reply-To: <1339653587-4832-15-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <s.hauer@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Dong Aisheng-B29396 <B29396@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Thu, Jun 14, 2012 at 01:59:45PM +0800, Shawn Guo wrote:
> As the part of the effort to enable SPARE_IRQ for imx platform,
> the macro MXC_INTERNAL_IRQS will be removed.  The imx serial driver
> has a references to it for a decision on flags of request_irq call
> based on rtsirq is beyond MXC_INTERNAL_IRQS.  However the searching
> on imx platform code tells that rtsirq will never be beyond
> MXC_INTERNAL_IRQS.  That said, the check, consequently the reference
> to MXC_INTERNAL_IRQS are not needed, so remove them.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: linux-serial@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng

