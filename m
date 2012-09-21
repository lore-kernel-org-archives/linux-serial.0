From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 2/3] ARM: move udc_pxa2xx.h to linux/platform_data
Date: Fri, 21 Sep 2012 10:48:55 +0100
Message-ID: <20120921094855.GC15609@n2100.arm.linux.org.uk>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk> <E1TEzet-00077v-VD@rmk-PC.arm.linux.org.uk> <CAMPhdO_xqpqUUbSvi1zC4eT6vr0xFO-70+ieknjMWk9h0iWfHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37332 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab2IUJtF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 05:49:05 -0400
Content-Disposition: inline
In-Reply-To: <CAMPhdO_xqpqUUbSvi1zC4eT6vr0xFO-70+ieknjMWk9h0iWfHg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khc@pm.waw.pl>, Haojian Zhuang <haojian.zhuang@gmail.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Fri, Sep 21, 2012 at 05:40:07PM +0800, Eric Miao wrote:
> On Fri, Sep 21, 2012 at 5:36 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > diff --git a/arch/arm/mach-ixp4xx/include/mach/udc.h b/arch/arm/mach-ixp4xx/include/mach/udc.h
> > index 80d6da2..b47cc0d 100644
> > --- a/arch/arm/mach-ixp4xx/include/mach/udc.h
> > +++ b/arch/arm/mach-ixp4xx/include/mach/udc.h
> > @@ -2,7 +2,7 @@
> >   * arch/arm/mach-ixp4xx/include/mach/udc.h
> >   *
> >   */
> > -#include <asm/mach/udc_pxa2xx.h>
> > +#include <linux/platform_data_pxa2xx_udc.h>
> 
> Guess a typo here, "/" instead of "_"? Otherwise looks good to me

Yea, fixed.
