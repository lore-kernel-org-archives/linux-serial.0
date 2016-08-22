From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 22:35:56 +0100
Message-ID: <20160822223556.0127ae6f@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <12886761.WF058qtZp8@wuerfel>
        <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
        <2775954.hrE2UdODgU@wuerfel>
        <20160822164533.688a6aec@lxorguk.ukuu.org.uk>
        <FAD4CEF6-93F4-41D1-915E-823867F740F7@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <FAD4CEF6-93F4-41D1-915E-823867F740F7@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> I now wonder if we can not just turn the ldisc into a bus. So we have a ldisc bus that exposes devices that have no business of having a userspace /dev/ttyX exposed. And our Bluetooth UART support just turns into a ldisc driver on the ldisc bus.

The ldisc and tty have the wrong object lifetime for a bus, but you can
put the tty_port objects onto the bus, and it is those you need to
instantiate the stack.

The port exists for hardware lifetime, the tty and ldisc exist only while
the port is "up".

Alan
