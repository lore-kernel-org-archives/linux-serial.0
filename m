From: Shreshtha Kumar SAHU <shreshthakumar.sahu@stericsson.com>
Subject: Re: [PATCH 2/2] amba pl011: platform data for reg lockup and glitch
Date: Fri, 10 Jun 2011 14:37:06 +0530
Message-ID: <20110610090704.GA476@bnru02.bnr.st.com>
References: <1307653008-3398-1-git-send-email-linus.walleij@stericsson.com>
 <20110609210218.GH24424@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:57880 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751372Ab1FJJHg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Jun 2011 05:07:36 -0400
Content-Disposition: inline
In-Reply-To: <20110609210218.GH24424@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@suse.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>

On Thu, Jun 09, 2011 at 23:02:18 +0200, Russell King - ARM Linux wrote:
> On Thu, Jun 09, 2011 at 10:56:48PM +0200, Linus Walleij wrote:
> > +	/* uart-0 pins gpio configuration should be
> > +	 * kept intact to prevent glitch in tx line
> > +	 * when tty dev is opened. Later these pins
> > +	 * are configured to uart mop500_pins_uart0
> > +	 *
> > +	 * It will be replaced with uart configuration
> > +	 * once the issue is solved.
> > +	 */
> > +	GPIO0_GPIO	| PIN_INPUT_PULLUP,
> > +	GPIO1_GPIO	| PIN_OUTPUT_HIGH,
> > +	GPIO2_GPIO	| PIN_INPUT_PULLUP,
> > +	GPIO3_GPIO	| PIN_OUTPUT_LOW,
> 
> Why do you want the TXD line (GPIO3) to be indicating a break condition?

Yes it should be PIN_OUTPUT_HIGH, as it is configured in mop500_pins_uart0.

Thanks,
Shreshtha
