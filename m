From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 23:43:00 +0200
Message-ID: <7864389.KcZiMyceNA@wuerfel>
References: <20160818011445.22726-1-robh@kernel.org> <20160822203947.ksxwnvzhc3tpnnx7@earth> <EA228ADD-F03A-49C0-9A0B-E768D7A7A466@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <EA228ADD-F03A-49C0-9A0B-E768D7A7A466@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Oleksij Rempel <linux@rempel-privat.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Monday, August 22, 2016 11:23:26 PM CEST H. Nikolaus Schaller wrote:
> I see what you mean, but kernel divides between directly connected UART and USB-connected UART.
> 
> drivers/usb/serial/ vs. drivers/tty/serial/

That distinction purely exists for historic reasons. I'd argue that the
former should actually go into drivers/tty/usb or similar. A long time
ago, we commonly sorted device drivers by how they were attached to
the system (as drivers/usb/serial/ and drivers/usb/storage still do),
but almost everything is now sorted according to how it is used instead.

	Arnd
