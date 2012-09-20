From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] serial: pl011: safeguard against impossible
	baudrates
Date: Thu, 20 Sep 2012 19:57:48 +0100
Message-ID: <20120920185748.GA15609@n2100.arm.linux.org.uk>
References: <1348134346-25593-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36800 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab2ITS56 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Sep 2012 14:57:58 -0400
Content-Disposition: inline
In-Reply-To: <1348134346-25593-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Matthias Locher <matthias.locher@stericsson.com>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>, Christophe Arnal <christophe.arnal@stericsson.com>, linux-arm-kernel@lists.infradead.org

On Thu, Sep 20, 2012 at 11:45:46AM +0200, Linus Walleij wrote:
> +	if ((termios->c_ispeed > max_baud) ||
> +	    (termios->c_ospeed > max_baud)) {
> +		dev_err(port->dev,
> +			"requested a baud rate > clock/mindivisor\n");
> +		return;
> +	}

Why do we need this check?  In any case, this is incorrect behaviour
just to 'return' from this function without doing anything.  You just
produce an error message, and userspace believes that it's request
has been satisfied.

uart_get_baud_rate() is there precisely to do the right thing for invalid
baud rates, which is to fallback to the old termios setting (and update
the new termios with that) if the old termios setting satisifies the
limits, if not it falls back to something within the limited range.
