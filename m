From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
Date: Tue, 11 Feb 2014 13:45:50 +0800
Message-ID: <20140211054548.GC31484@S2101-09.ap.freescale.net>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
 <20140127075025.GC4765@S2101-09.ap.freescale.net>
 <c1c2915231eb4595b89327e589bc521d@BL2PR03MB338.namprd03.prod.outlook.com>
 <20140211025932.GB31484@S2101-09.ap.freescale.net>
 <c2b2798647d44d3c950ce17f23551555@DM2PR03MB349.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:15139
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750758AbaBKFpX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Feb 2014 00:45:23 -0500
Content-Disposition: inline
In-Reply-To: <c2b2798647d44d3c950ce17f23551555@DM2PR03MB349.namprd03.prod.outlook.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yao Yuan <yao.yuan@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, Feb 11, 2014 at 05:34:49AM +0000, Yao Yuan wrote:
> Here I also have a confusion.
> IRQ is must. But DMA isn't very necessary.
> How to deal with if one board is need DMA but another is not need?
> You mean if DMA is be support once all of them must use dma as first?

That's the point.  Why whether using DMA or not is a board decision?
The DMA resource should be defined at SoC level from the beginning
just like IO and interrupt resource.  And using DMA or PIO should be a
decision made by device driver not device tree.

Shawn

