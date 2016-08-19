From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Fri, 19 Aug 2016 12:06:31 +0100
Message-ID: <20160819120631.5fe2af0d@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <20160818202900.hyvm4hfxedifuefn@earth>
        <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
        <20160819052125.ze5zilppwoe3f2lx@earth>
        <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> If possible, please do a callback for every character that arrives.
> And not only if the rx buffer becomes full, to give the slave driver
> a chance to trigger actions almost immediately after every character.
> This probably runs in interrupt context and can happen often.

We don't realistically have the clock cycles to do that on a low end
embedded processor handling high speed I/O. The best you can do is
trigger a workqueue to switch the buffer data around and call the helper
while the uart may be receiving more bytes.

What you are asking for you'd get out of the first parts of tidying up
the receive paths because you'd set a different port->rx() method and get
bursts of characters, flags and length data.

Alan
