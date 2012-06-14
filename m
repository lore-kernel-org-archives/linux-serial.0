From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 14/16] tty: serial: imx: remove the use of
 MXC_INTERNAL_IRQS
Date: Thu, 14 Jun 2012 08:37:55 -0700
Message-ID: <20120614153755.GC17140@kroah.com>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-15-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63222 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756246Ab2FNPiC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Jun 2012 11:38:02 -0400
Received: by pbbrp8 with SMTP id rp8so3966325pbb.19
        for <linux-serial@vger.kernel.org>; Thu, 14 Jun 2012 08:38:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339653587-4832-15-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Dong Aisheng <b29396@freescale.com>, linux-serial@vger.kernel.org

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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
