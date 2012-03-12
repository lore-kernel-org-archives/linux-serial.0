From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] serial: PL011: clear pending interrupts
Date: Mon, 12 Mar 2012 11:28:41 +0000
Message-ID: <20120312112841.GY17370@n2100.arm.linux.org.uk>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com> <20120312083221.GW17370@n2100.arm.linux.org.uk> <01e101cd0042$5bf692a0$13e3b7e0$@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54168 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab2CLL25 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Mar 2012 07:28:57 -0400
Content-Disposition: inline
In-Reply-To: <01e101cd0042$5bf692a0$13e3b7e0$@lge.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Kim, Jong-Sung" <neidhard.kim@lge.com>
Cc: 'Linus Walleij' <linus.walleij@stericsson.com>, linux-serial@vger.kernel.org, 'Chanho Min' <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, 'Linus Walleij' <linus.walleij@linaro.org>, stable@kernel.org, 'Shreshtha Kumar Sahu' <shreshthakumar.sahu@stericsson.com>

On Mon, Mar 12, 2012 at 08:22:07PM +0900, Kim, Jong-Sung wrote:
> Maybe the character is handled on next upcoming RTIS or RXIS in normal.
> However, I agree with you there is possibility of already asserted RXIS at
> this point. (with debugger?) In such a case, we may lose Rx interrupts
> forever because it's not level-triggered, and the ISR lacks error interrupt
> handling. Correct me if something wrong.

The handler does not lack error handling - error handling is associated
with a character, and we deal with errors when we read the associated
character from the receive register.

So, we have no need for the error interrupts.

The PL011, as with all serial drivers I write, has full error handling
incorporated.
