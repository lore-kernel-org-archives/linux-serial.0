From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Fri, 26 Aug 2016 14:12:23 +0100
Message-ID: <20160826141223.445ed1db@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <20160818102208.GA20476@kroah.com>
        <CAL_Jsq+Va2OF1pYTivH8YN1GKsiaT1eTOaSv607K_V+H+0Buvw@mail.gmail.com>
        <20160818160449.328b2eec@lxorguk.ukuu.org.uk>
        <CAL_JsqJ_5+Em5SLSuqiJ3SnazhyEY2XaYh6N1AtR8_+MdcezMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJ_5+Em5SLSuqiJ3SnazhyEY2XaYh6N1AtR8_+MdcezMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> Either we'd have to call tty_port->rx a character at a time or
> implement some temporary buffer. I don't think we want to call things
> like BT receive code a byte at a time. This needs to be a layer
> higher. flush_to_ldisc either needs to be duplicated to handle
> tty_port->rx or generalized to call either tty_port->rx or ldisc
> receive_buf. I'm not sure what to do about ldisc ref counting in the
> latter case.

You already have the buffer

What I was trying to suggest was that instead of


chars->buffer
flush
workqueue
loop pushing data into the ldisc


You can also do

chars->buffer
flush
workqueue
->rx()  [where flush_to_ldisc is just one implementation of ->rx]

For byte by byte ports it really makes no difference (except you would be
able to do processing without an ldisc), but for DMA devices it would
give us a faster path for processing since the DMA completion event can
simply fire a buffer a characters directly at the protocol handler where
there are not latency concerns (ie it starts the new DMA and directly
involves ->rx())

Alan
