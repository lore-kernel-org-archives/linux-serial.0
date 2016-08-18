From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 15:07:39 +0200
Message-ID: <CACRpkdZYmXHE=6KoB7vn0PKrowEfEz6wh9_L6c4mtqQm_-du5A@mail.gmail.com>
References: <20160818011445.22726-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818011445.22726-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 18, 2016 at 3:14 AM, Rob Herring <robh@kernel.org> wrote:

> Currently, devices attached via a UART are not well supported in the
> kernel. The problem is the device support is done in tty line disciplines,
> various platform drivers to handle some sideband, and in userspace with
> utilities such as hciattach.

Freaking *awesome* Rob, this really really needs to happen.
I'm very happy that you're driving this.

> This is functional with minimal testing using the loopback driver and
> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the slave
> device). It still needs lots of work and polish.

I have Bluetooth (HCI) over UART on the Nomadik and Ux500,
both with DMA support for the PL011 too. So I hope to be able
to utilize this.

(The HCI transport is then used for GPS, FM radio and whatnot
but that is another issue.)

Yours,
Linus Walleij
