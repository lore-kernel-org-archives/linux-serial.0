From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
Date: Tue, 11 Feb 2014 10:59:34 +0800
Message-ID: <20140211025932.GB31484@S2101-09.ap.freescale.net>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
 <20140127075025.GC4765@S2101-09.ap.freescale.net>
 <c1c2915231eb4595b89327e589bc521d@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:15140 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752199AbaBKC7L (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 21:59:11 -0500
Content-Disposition: inline
In-Reply-To: <c1c2915231eb4595b89327e589bc521d@BL2PR03MB338.namprd03.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yao Yuan <yao.yuan@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Feb 11, 2014 at 01:50:14AM +0000, Yao Yuan wrote:
> Hi, Shawn
> 
> Here I just want the DMA be a selectable property for each board. 
> Is it suitable?

No, it's not.  Just like IRQ line, DMA channel is a SoC level resource.
It should just be there once the SoC is out there.  Nothing to do with
board level configuration.

Shawn

> 
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawn.guo@linaro.org]
> > Sent: Monday, January 27, 2014 3:50 PM
> > To: Yuan Yao-B46683
> > Cc: gregkh@linuxfoundation.org; linux@arm.linux.org.uk; arnd@arndb.de;
> > mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org; linux-
> > serial@vger.kernel.org
> > Subject: Re: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
> > 
> > On Wed, Jan 22, 2014 at 12:09:30PM +0800, Yuan Yao wrote:
> > > Changed in v4:
> > > - Move dma properties from dtsi to dts.
> > 
> > Why this change?  DMA is a SoC level resource rather than board one.
> > 
> > Shawn
> 

