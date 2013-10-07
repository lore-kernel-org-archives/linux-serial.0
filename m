From: Kees Cook <keescook@chromium.org>
Subject: Re: base baud reporting strange on efm32
Date: Mon, 7 Oct 2013 13:46:46 -0700
Message-ID: <CAGXu5jLgR5iU+uNqNVKvfnOmvPp3DPG4TAXwA-SnMhVb5ucwnA@mail.gmail.com>
References: <20131007070306.GA31070@pengutronix.de>
	<20131007072149.GB4755@kroah.com>
	<20131007072824.GJ10079@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:39344 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996Ab3JGUqr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Oct 2013 16:46:47 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so16930062iec.2
        for <linux-serial@vger.kernel.org>; Mon, 07 Oct 2013 13:46:47 -0700 (PDT)
In-Reply-To: <20131007072824.GJ10079@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, kernel@pengutronix.de

On Mon, Oct 7, 2013 at 12:28 AM, Uwe Kleine-K=F6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Oct 07, 2013 at 12:21:49AM -0700, Greg Kroah-Hartman wrote:
>> On Mon, Oct 07, 2013 at 09:03:06AM +0200, Uwe Kleine-K=F6nig wrote:
>> > Hello Kees, hello Greg,
>> >
>> > since commit
>> >     7d12b97 (serial: report base_baud after initialization)
>> > my efm32 machine says during startup:
>> >     4000e400.uart: ttyefm4 at MMIO 0x4000e400 (irq =3D 25, base_ba=
ud =3D 0) is a efm32-uart
>> >
>> > Is this "=3D 0" expected or is there something wrong in the driver=
?
>>
>> Does the hardware work properly?  That's the best test of this, righ=
t?
> Yes, it works fine. Still I wonder if there is a problem that the dri=
ver
> doesn't fill in port.uartclk early enough. In the efm32-uart driver (=
i.e.
> drivers/tty/serial/efm32-uart.c) this member is only assigned to in
> .startup.

Hm, yeah, it looks like uart_add_one_port() (which ultimately makes
the printk call) is called in efm32_uart_probe(), but uartclk gets set
during serial open (via efm32_uart_startup()).

So, it seems this "0" report is harmless. If the efm32 driver wants to
have something meaningful there, I guess the clk code needs to move
around.

-Kees

--=20
Kees Cook
Chrome OS Security
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
