From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 15:25:28 +0100
Message-ID: <20160818152528.569eb426@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818011445.22726-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 17 Aug 2016 20:14:42 -0500
Rob Herring <robh@kernel.org> wrote:

This was proposed ages ago and the point clearly made that

a) the idea doesn't work because uarts are not required to use the uart
layer and even those that do sometimes only use half of it

b) that you should use the tty_port abstraction

So instead of just waiting some months and recycling the proposals it's
unfortunate that no listening and reworking was done.

https://lkml.org/lkml/2016/1/18/177

So I'm giving this a large neon flashing NAK, because none of the
problems have been addressed.

> Currently, devices attached via a UART are not well supported in the
> kernel. The problem is the device support is done in tty line disciplines,
> various platform drivers to handle some sideband, and in userspace with
> utilities such as hciattach.

For most platforms it works very nicely and out of the box. The only
real issue I have actually seen is the bandwidth issue from early tty
based 3G modems. That's not hard to fix with some tty buffer changes.
Basically you need a tty port pointer that is atomic exchangable and
points either to the usual tty queue logic or to a 'fastpath' handler
which just gets thrown a block of bytes and told to use them or lose them
- which is the interface the non n_tty ldiscs want anyway. That's exactly
what you would need to fix to support in kernel stuff as well. The tty
queue mechanism for devices that can receive in blocks just becomes a
fastpath.

There are some disgusting Android turds floating around out of tree where
people use things like userspace GPIO line control but you won't fix most
of those anyway because they are generally being used for user
space modules including dumb GPS where the US government rules won't allow
them to be open sourced anyway.

> - Split out the controller for uart_ports into separate driver. Do we see
>   a need for controller drivers that are not standard serial drivers?

As I told you over six months ago uart_port is not the correct
abstraction. You need to be working at the tty_port layer. The original
design of tty_port was indeed partly to push towards being able to have a
serial interface that is in use but not open to user space. The rather
nice rework that the maintainers have done to put the buffers in the
tty_port takes it closer still.

Plenty of the classic serial port interfaces also don't use the UART
layer including every USB device (which is most of them these days), SDIO
and others. USB has to be covered for this to be sensible.

Your changes also don't work because serial uart drivers are not obliged
to use any of the uart buffering helpers and particularly on the rx side
many do not do so and the performance hit would be too high.

It's been explained how to make it work with tty_port, every tty is a
dynamic file handle life time object bound to a tty_port. Every tty has a
tty_port, every tty driver has a tty_port.

Alan
