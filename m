From: Sergei Ianovich <ynvich@gmail.com>
Subject: Re: [PATCH v4 12/21] serial: support for 16550A serial ports on LP-8x4x
Date: Wed, 16 Apr 2014 23:01:47 +0400
Message-ID: <c4533da6-30bd-4ea4-9011-a7e3b7258e62@email.android.com>
References: <1397668411-27162-7-git-send-email-ynvich@gmail.com> <1397668667-27328-1-git-send-email-ynvich@gmail.com> <1397668667-27328-6-git-send-email-ynvich@gmail.com> <20140416193532.0782f045@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140416193532.0782f045@alan.etchedpixels.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Grant Likely <grant.likely@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Paul Bolle <pebolle@tiscali.nl>, Stefan Seyfried <seife+kernel@b1-systems.com>, James Cameron <quozl@laptop.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk> wrote:
>> +	baud = uart_get_baud_rate(port, termios, old,
>> +				  port->uartclk / 16 / 0xffff,
>> +				  port->uartclk / 16);
>> +	switch (baud) {
>> +	case 2400:
>> +		len |= 1;
>> +		break;
>> +	case 4800:
>> +		len |= 2;
>> +		break;
>> +	case 19200:
>> +		len |= 4;
>> +		break;
>> +	case 38400:
>> +		len |= 5;
>> +		break;
>> +	case 57600:
>> +		len |= 6;
>> +		break;
>> +	case 115200:
>> +		len |= 7;
>> +		break;
>> +	case 9600:
>> +	default:
>> +		len |= 3;
>> +		break;
>> +	};
>
>Some explanation of this would be useful - eg why is it set to 7 for
>115200 baud and 3 for 115201 baud ?

I am not related to the device vendor in any way, so please take my answers for what they are worth.

It seems that there is not enough pins to properly connect the chips to the memory bus and just you the standard 8250 UART driver. Instead, clock divisor is set using this register.

So, if you know you're asking for (115200) you get it. If you don't or guess (115201), you get the default 9600.

This is a policy, it may not be the right way to write a driver, but it is cheap and it works.
