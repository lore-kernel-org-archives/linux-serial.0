From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/9] Serial slave device bus
Date: Tue, 10 Jan 2017 13:05:34 +0100
Message-ID: <30AE636D-CE43-4972-8BA5-575C9B515157@holtmann.org>
References: <20170106162635.19677-1-robh@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170106162635.19677-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Rob,

> Here goes another attempt at a serial device bus (aka uart slaves, tty
> slaves, etc.).
> 
> After some discussions with Dmitry at LPC, I decided to move away from
> extending serio and moved back to making a new bus type instead. He didn't
> think using serio was a good fit, and serio has a number of peculiarities
> in regards to sysfs and it's driver model. I don't think we want to inherit
> those for serial slave devices.
> 
> This version sits on top of tty_port rather than uart_port as Alan
> requested. Once I created a struct tty rather than moving everything
> needed to tty_port, it became a lot easier and less invasive to the tty
> core code.
> 
> I have hacked up versions of the BT ldisc and TI ST drivers moved over to
> use the serdev bus. I have BT working on the HiKey board which has TI BT.
> With the serdev bus support, it eliminates the need for the TI userspace
> UIM daemon.

thanks for looking at the TI ST driver. That thing has been a thorn in my eyes for years. It has been such a hack job and I wanted to get rid of the double line disciplines for a long time now. Even using HCI line discipline as we have to day would be way better than dealing with the UIM daemon. The hacked around issues that have been solved cleanly in the Bluetooth subsystem.

Regards

Marcel
