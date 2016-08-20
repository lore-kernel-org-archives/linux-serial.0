From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Sat, 20 Aug 2016 14:34:05 +0100
Message-ID: <20160820143405.04303834@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <20160818202900.hyvm4hfxedifuefn@earth>
        <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
        <20160819052125.ze5zilppwoe3f2lx@earth>
        <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
        <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de>
        <53A846F1-33E5-48C3-B3A6-DB251661CDD5@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53A846F1-33E5-48C3-B3A6-DB251661CDD5@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> A single one is already difficult... And some scenarios need to shield the UART
> from user space (currently there is always one /dev/tty per UART - unless the
> UART is completely disabled).

That bit is already covered and one or two devices support this because
they have things like 3 serial ports but one cannot be used if some other
feature is enabled.

You simply keep a private counter and return -EBUSY in the
port->activate() method if needed. That is sufficient to share a UART with
the tty layer when you have a contended resource, but not to borrow the
UART and re-use the stack which is what is needed in this case.

(You can even steal a UART this way by doing a hangup on it and then once
it drops out of use taking it over and ensuring the EBUSY behaviour)

> 
> Some ideas where it might be needed:
> * bluetooth HCI over UART
> * a weird GPS device whose power state can only reliably be detected by monitoring data activity
> * other chips (microcontrollers) connected through UART - similar to I2C slave devices
> * it potentially could help to better implement IrDA (although that is mostly legacy)
> 
> What it is not about are UART/RS232 converters connected through USB or virtual
> serial ports created for WWAN modems (e.g. /dev/ttyACM, /dev/ttyHSO). Or BT devices
> connected through USB (even if they also run HCI protocol).

It actually has to be about both because you will find the exact same
device wired via USB SSIC/HSIC to a USB UART or via a classic UART. Not is
it just about embedded boards. A current PC class device will usually have
bluetooth connected via a UART where both components are on board. The
same for GPS (or more accurately location services as it's usually more
than just a GPS nowdays). There may also be onboard WWAN modems and other
widgets wired this way.

In the PC case the power relationship and connectivity is usually
described via ACPI and that often means the kernel simply doesn't know
how to manage the power states besides telling the modem, GPS. etc to
turn itself on and off via normal ACPI power descriptions. Those may well
call OpRegion handlers so it's all abstracted nicely and generic, but
rather more invisible to the OS than DT describing pmic and/or gpio
setings for the device.

Todays low end Intel x86 PC has multiple DMA accelerated low power 16x50
compatible UARTS on die along with multiple channels of I2C and SPI.
Things like Android and PC tablet devices with sensors have pretty much
converged the old divide between a desktop/laptop/tablet PC and an
'embedded' board.

Alan
