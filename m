From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] serdev: Update drivers/tty/serdev/Kconfig for ACPI
 support
Date: Mon, 9 Oct 2017 09:47:00 +0200
Message-ID: <20171009074700.GM2618@localhost>
References: <a4051ac2-1156-751d-ec16-2dbbb30b9258@gmail.com>
 <20171007152414.GK2618@localhost>
 <8D8274B0-4EF6-41A0-8B76-95023F6DD26C@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8D8274B0-4EF6-41A0-8B76-95023F6DD26C@holtmann.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hovold <johan@kernel.org>, Ian W MORRISON <ianwmorrison@gmail.com>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Oct 07, 2017 at 09:57:40PM +0200, Marcel Holtmann wrote:
> Hi Johan,
> 
> >> The current Kconfig for serdev is not compatible when adding ACPI support as it does not work when built as a module as it requires config SERIAL_DEV_CTRL_TTYPORT to be set. This patch makes serdev compiled into the kernel if selected so that config SERIAL_DEV_CTRL_TTYPORT can be correctly set if requiring ACPI support.
> >> ---
> >> drivers/tty/serdev/Kconfig | 5 +++--
> >> 1 file changed, 3 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
> >> index cdc6b820cf93..a9fb09a9c105 100644
> >> --- a/drivers/tty/serdev/Kconfig
> >> +++ b/drivers/tty/serdev/Kconfig
> >> @@ -2,7 +2,8 @@
> >> # Serial bus device driver configuration
> >> #
> >> menuconfig SERIAL_DEV_BUS
> >> -	tristate "Serial device bus"
> >> +	bool "Serial device bus"
> >> +	default y
> > 
> > I understand why you want this (to prevent hci_bcm from breaking), but we
> > should generally not have new entries default to y.
> > 
> >> 	help
> >> 	  Core support for devices connected via a serial port.
> >> 
> >> @@ -11,6 +12,6 @@ if SERIAL_DEV_BUS
> >> config SERIAL_DEV_CTRL_TTYPORT
> >> 	bool "Serial device TTY port controller"
> >> 	depends on TTY
> >> -	depends on SERIAL_DEV_BUS != m
> >> +	default y
> > 
> > Same here.
> > 
> > It may be better to have BT_HCIUART_BCM depend on (or select?)
> > SERIAL_DEV_CTRL_TTYPORT instead.
> 
> if we move SERIAL_DEV_BUS to bool, then I would just have it be
> selected by BT_HCIUART_BCM. Frankly the SERIAL_DEV_BUS option is
> pretty hard to find in the kernel config. And if we depend on TTY, but
> then select SERIAL_DEV_BUS, I think that is a good compromise.

The Bluetooth UART drivers already depend on on SERIAL_DEV_BUS (through
BT_HCIUART_SERDEV). And the problem with BT_HCIUART_BCM is that the
current ACPI devices really need SERIAL_DEV_CTRL_TTYPORT (and not just
serdev core).

And we should probably try to avoid selecting options if we can (to
avoid ending up with unmet dependencies).

Johan
