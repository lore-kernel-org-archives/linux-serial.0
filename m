From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH tty-next v2 4/4] Documentation: devicetree: add
 bindings documentation for bcm63xx-uart
Date: Fri, 21 Feb 2014 13:49:46 +0000
Message-ID: <20140221134946.GA20449@e106331-lin.cambridge.arm.com>
References: <1392920154-3642-1-git-send-email-f.fainelli@gmail.com>
 <1392920154-3642-5-git-send-email-f.fainelli@gmail.com>
 <3250738.VGSO94B75K@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39579 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932139AbaBUNuI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Feb 2014 08:50:08 -0500
Content-Disposition: inline
In-Reply-To: <3250738.VGSO94B75K@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mbizon@freebox.fr" <mbizon@freebox.fr>, "jogo@openwrt.org" <jogo@openwrt.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "gregory.0xf0@gmail.com" <gregory.0xf0@gmail.com>

On Fri, Feb 21, 2014 at 12:49:05PM +0000, Arnd Bergmann wrote:
> Two more comments:
> 
> On Thursday 20 February 2014 10:15:54 Florian Fainelli wrote:
> > +- clock-names: should contain "periph" for the functional clock
> 
> I think we should really start standardizing on the clock names more.
> We don't have any uart that calls its functional clock "periph" so
> far.
> 
> How about naming it "fclk" or "uart"?
> 
> I'd actually prefer making it an anonymous clock, but I know that
> will just trigger comments about what might happen if it turns
> out we need more than one clock for a future version of this device.

Yup ;)

I'm happy as long as we have a well-defined name for each clock input,
regardless of what those particular names might be.

Mark.
