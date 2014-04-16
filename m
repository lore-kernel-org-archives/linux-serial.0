From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v4 12/21] serial: support for 16550A serial ports on
 LP-8x4x
Date: Wed, 16 Apr 2014 19:35:32 +0100
Message-ID: <20140416193532.0782f045@alan.etchedpixels.co.uk>
References: <1397668411-27162-7-git-send-email-ynvich@gmail.com>
	<1397668667-27328-1-git-send-email-ynvich@gmail.com>
	<1397668667-27328-6-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1397668667-27328-6-git-send-email-ynvich@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Paul Bolle <pebolle@tiscali.nl>, Stefan Seyfried <seife+kernel@b1-systems.com>, James Cameron <quozl@laptop.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> +	baud = uart_get_baud_rate(port, termios, old,
> +				  port->uartclk / 16 / 0xffff,
> +				  port->uartclk / 16);
> +	switch (baud) {
> +	case 2400:
> +		len |= 1;
> +		break;
> +	case 4800:
> +		len |= 2;
> +		break;
> +	case 19200:
> +		len |= 4;
> +		break;
> +	case 38400:
> +		len |= 5;
> +		break;
> +	case 57600:
> +		len |= 6;
> +		break;
> +	case 115200:
> +		len |= 7;
> +		break;
> +	case 9600:
> +	default:
> +		len |= 3;
> +		break;
> +	};

Some explanation of this would be useful - eg why is it set to 7 for
115200 baud and 3 for 115201 baud ?
