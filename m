From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial/efm32: parse location property
Date: Fri, 8 Mar 2013 08:04:25 +0100
Message-ID: <CACRpkdb5-t-k6B-WKBwyr6hV7qUHv7YiDs1RwPJMxDRZm5pYWQ@mail.gmail.com>
References: <1358774576-13275-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20130304143854.395EF3E206B@localhost>
	<CACRpkdZuNOFco+GTe9YOD=qy+dgEaokoqvWaPA2mCxYHs9oxVA@mail.gmail.com>
	<20130307093829.GG15375@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130307093829.GG15375@pengutronix.de>
Sender: linux-doc-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, devicetree-discuss@lists.ozlabs.org, kernel@pengutronix.de, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 7, 2013 at 10:38 AM, Uwe Kleine-K=F6nig
<u.kleine-koenig@pengutronix.de> wrote:

> If you have an idea how to model this such that it fits nicely into t=
he
> various subsystems (most interesting: gpio and pinmux), any input is
> welcome.

Looking at it, and assuming you will use device tree for this, I think
the best is to have a single driver in drivers/pinctrl/pinctrl-efm32.c
that handles all muxing, pin direction/biasing/pulling and GPIO.

Let this driver's DT entry reference all the devices with local
MUX registers and pick out these nodes by reference and
manipulate them from the pin control driver.

You put ampersand nodes into the pin controller node.

In the dbx500 pin controller we have this:

                pinctrl {
                        compatible =3D "stericsson,nmk-pinctrl";
                        prcm =3D <&prcmu>;
                };

Basically this "prcm" is another peripheral with a set of misc
registers that also do some pin control, but we let the pin control
driver grab a handle to that because they are related.

Yours,
Linus Walleij
