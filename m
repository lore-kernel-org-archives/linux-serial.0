From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 19:31:05 +0200
Message-ID: <E1CFF612-FB5B-4DBA-A45E-5B1E658D70F8@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org> <CACRpkdZYmXHE=6KoB7vn0PKrowEfEz6wh9_L6c4mtqQm_-du5A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZYmXHE=6KoB7vn0PKrowEfEz6wh9_L6c4mtqQm_-du5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Linus,

>> Currently, devices attached via a UART are not well supported in the
>> kernel. The problem is the device support is done in tty line disciplines,
>> various platform drivers to handle some sideband, and in userspace with
>> utilities such as hciattach.
> 
> Freaking *awesome* Rob, this really really needs to happen.
> I'm very happy that you're driving this.
> 
>> This is functional with minimal testing using the loopback driver and
>> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the slave
>> device). It still needs lots of work and polish.
> 
> I have Bluetooth (HCI) over UART on the Nomadik and Ux500,
> both with DMA support for the PL011 too. So I hope to be able
> to utilize this.
> 
> (The HCI transport is then used for GPS, FM radio and whatnot
> but that is another issue.)

that is something we can already solve via regmap. We have started work on Intel LnP which also includes a FM radio chip where registers/interrupts are exposed via HCI commands/events. So fundamentally the Bluetooth HCI device would expose the GPS and FM radio nodes via regmap.

Regards

Marcel
