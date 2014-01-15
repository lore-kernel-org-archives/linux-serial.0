From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
Date: Wed, 15 Jan 2014 13:50:52 +0000
Message-ID: <20140115135052.GG25824@e106331-lin.cambridge.arm.com>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com>
 <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
 <20140115110537.GA25824@e106331-lin.cambridge.arm.com>
 <15900408.Osb5heuoGi@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63285 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664AbaAONvf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jan 2014 08:51:35 -0500
Content-Disposition: inline
In-Reply-To: <15900408.Osb5heuoGi@wuerfel>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Yuan Yao <yao.yuan@freescale.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>

On Wed, Jan 15, 2014 at 11:17:07AM +0000, Arnd Bergmann wrote:
> On Wednesday 15 January 2014 11:05:37 Mark Rutland wrote:
> > On Wed, Jan 15, 2014 at 05:21:05AM +0000, Yuan Yao wrote:
> > > --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> > > +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> > > @@ -4,11 +4,24 @@ Required properties:
> > >  - compatible : Should be "fsl,<soc>-lpuart"
> > >  - reg : Address and length of the register set for the device
> > >  - interrupts : Should contain uart interrupt
> > > +- clocks : from common clock binding: handle to uart clock
> > > +- clock-names : from common clock binding: Shall be "ipg"
> > 
> > Why are these now requried if they weren't previously? That breaks old
> > dts. I can't see any new code touching clocks. Was this an old but
> > undocumented requirement?
> 
> It was previously required but not documented. I asked Yuan Yao to
> add the text to the binding along with the new "dmas" addition.

Ok.

> 
> It would have been cleaner to do this as a separate patch, but at
> the very least it should be mentioned in the changelog.

Having it in the changelog would be nice.

Cheers,
Mark.
