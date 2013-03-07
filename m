From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial/efm32: parse location property
Date: Thu, 7 Mar 2013 08:37:38 +0100
Message-ID: <CACRpkdZuNOFco+GTe9YOD=qy+dgEaokoqvWaPA2mCxYHs9oxVA@mail.gmail.com>
References: <1358774576-13275-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20130304143854.395EF3E206B@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130304143854.395EF3E206B@localhost>
Sender: linux-doc-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, devicetree-discuss@lists.ozlabs.org, kernel@pengutronix.de, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 4, 2013 at 3:38 PM, Grant Likely <grant.likely@secretlab.ca=
> wrote:
> On Mon, 21 Jan 2013 14:22:56 +0100, Uwe Kleine-K=F6nig <u.kleine-koen=
ig@pengutronix.de> wrote:
>> The non-dt probing allowed passing the location via platform data fr=
om
>> the beginning. So make up leeway for device tree probing.
>>
>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>
> Linus, does this look like some thing that should be done using pinct=
rl?

Hm it's a bit weird actually.

Most platforms will have some cetral entity dealing with pin multiplexi=
ng,
and often it is combined with either a system controller register range=
,
or it's combined with a GPIO controller (which is more common).

This is a new oddity: it's like multiplexing is distributed out among t=
he
peripherals on the EFM32, or atleast for this UART, so there is a
register on the peripheral itself selecting where to route it.

If all peripherals on the system follows this pattern, like if there is
some such "location" register on each and every peripheral, ideally
that should be centralized into some file like drivers/pinctrl/pinctrl-=
efm32.c
but the thing is that then that driver needs to own a single register
or even just part of a register in each peripheral device memory
range.

And that seems a bit complex to handle.

But if the EFM32 is using device tree exclusively it's actually
just an array of named  <&ampersand> references in the node for
the pin controller, pointing to each peripheral with a mux register.
So maybe that's not that bad after all.

Still it might be a bit overzealous to request that each device
ask a central entity to write one of its own registers. So it needs
to buy you something - like for example if it is possible to
completely screw up the muxing if different peripherals are
muxed to the same pins.

So it all depends, we need a birds-eye view of the system to
determine this. I tried looking at the datasheet but couldn't figure
it out. Uwe how does this work on EFM32?

Yours,
Linus Walleij
