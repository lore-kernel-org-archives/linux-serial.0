From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Update gpiod API
Date: Wed, 22 Jul 2015 07:51:32 -0700
Message-ID: <55AFADF4.5030409@roeck-us.net>
References: <1437510892-30376-1-git-send-email-linux@roeck-us.net> <20150721210115.GJ9981@pengutronix.de> <55AEC50E.3030202@roeck-us.net> <20150722070659.GK9981@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150722070659.GK9981@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cris-kernel@axis.com, Jesper Nilsson <jesper.nilsson@axis.com>, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On 07/22/2015 12:06 AM, Uwe Kleine-K=C3=B6nig wrote:

> While I stumbled over the calls to gpiod_get variants in the etraxfs
> serial driver I noticed several problems with that driver. I pointed
> them out in
>
> 	http://www.spinics.net/lists/linux-serial/msg17794.html
>
> . If you read the follow-ups Jesper Nilsson then said:
>
> 	I can push a patch that just drops all signal handling (since
> 	it's bogus ATM), or you can ignore the driver as currently
> 	implemented.
>

If you want to mark the driver as BROKEN due to those other problems,
go ahead, and I'll drop the architecture from my tests. But it should
not be marked BROKEN because you did not update an API.

> I explicitly did the latter. Apart from that single driver I fixed al=
l
> users. @Jesper: You said you poked Niklas to care for that. Any news
> from that front?
>
> I'm all for the usual habit that API changes should be handled by the
> API changer. But if the code was already relying on undefined behavio=
ur
> before the change and fixing that needs testing on the respective
> hardware, I think pushing the needed work back to the driver owner is
> fine. IMHO a simple build fix that doesn't fix the brokeness isn't th=
at
> helpful here.
>
The driver works fine for me (in qemu), possibly because qemu doesn't
use/need modem lines.

Guenter
