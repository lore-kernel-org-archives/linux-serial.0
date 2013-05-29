From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4] tty: serial: add Freescale lpuart driver support
Date: Wed, 29 May 2013 15:26:05 +0800
Message-ID: <20130529072603.GI370@S2101-09.ap.freescale.net>
References: <1369733161-19168-1-git-send-email-b35083@freescale.com>
 <20130529034913.GF370@S2101-09.ap.freescale.net>
 <B56CDBE15CE27145A4B77D2D24263E851CDEFB@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:25960
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935077Ab3E2HZj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 May 2013 03:25:39 -0400
Content-Disposition: inline
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851CDEFB@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lu Jingchang-B35083 <B35083@freescale.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>

On Wed, May 29, 2013 at 06:57:43AM +0000, Lu Jingchang-B35083 wrote:
> [Lu Jingchang-B35083] 
>   For multiple dts uart nodes, each node will call .probe once. If the uart_register_driver is called from .probe without any conditioning check, it will then be called more than once, but the uart_register_deiver can only register the same uart driver once. So I think current arrangement will be more reasonable. Thanks!
> 

It shouldn't be too hard to add a check for that.  But if you like to
stay with the current one, okay, I'm fine.

Shawn

