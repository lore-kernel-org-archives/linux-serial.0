From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] serial: pl011: allow very high baudrates
Date: Thu, 20 Sep 2012 20:00:34 +0100
Message-ID: <20120920190034.GB15609@n2100.arm.linux.org.uk>
References: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36812 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab2ITTAm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Sep 2012 15:00:42 -0400
Content-Disposition: inline
In-Reply-To: <1348134368-25663-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Thu, Sep 20, 2012 at 11:46:08AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The ST Microelectronics variant of the PL011 is capable of supporting
> very high non-standard baud rates, even above 4 Mbps. However the
> uart_get_baud_rate() will not allow us to set these, so override that
> calculation on very high speeds.

You don't explain why it doesn't.  It should in theory allow you to,
because there's no limits within that function other than those which
you pass in as the minimum and maximum.

If your userspace hasn't been updated to use the integer baud rate
setting mechanisms, then that could be where the problem lies.
Alternatively, if some Bxxxx setting is not being respected by
tty_termios_baud_rate(), that also would need fixing.

But the fix you propose in this patch just looks wrong.
