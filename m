From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] amba pl011: platform data for reg lockup and glitch
Date: Thu, 9 Jun 2011 22:02:18 +0100
Message-ID: <20110609210218.GH24424@n2100.arm.linux.org.uk>
References: <1307653008-3398-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35277 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab1FIVCk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 Jun 2011 17:02:40 -0400
Content-Disposition: inline
In-Reply-To: <1307653008-3398-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Thu, Jun 09, 2011 at 10:56:48PM +0200, Linus Walleij wrote:
> +	/* uart-0 pins gpio configuration should be
> +	 * kept intact to prevent glitch in tx line
> +	 * when tty dev is opened. Later these pins
> +	 * are configured to uart mop500_pins_uart0
> +	 *
> +	 * It will be replaced with uart configuration
> +	 * once the issue is solved.
> +	 */
> +	GPIO0_GPIO	| PIN_INPUT_PULLUP,
> +	GPIO1_GPIO	| PIN_OUTPUT_HIGH,
> +	GPIO2_GPIO	| PIN_INPUT_PULLUP,
> +	GPIO3_GPIO	| PIN_OUTPUT_LOW,

Why do you want the TXD line (GPIO3) to be indicating a break condition?
