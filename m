From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] serdev: Update drivers/tty/serdev/Kconfig for ACPI
 support
Date: Sat, 7 Oct 2017 08:42:41 +0200
Message-ID: <D567DA4A-4443-4A88-B078-50EE458C822A@holtmann.org>
References: <a4051ac2-1156-751d-ec16-2dbbb30b9258@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <a4051ac2-1156-751d-ec16-2dbbb30b9258@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Ian,

> The current Kconfig for serdev is not compatible when adding ACPI support as it does not work when built as a module as it requires config SERIAL_DEV_CTRL_TTYPORT to be set. This patch makes serdev compiled into the kernel if selected so that config SERIAL_DEV_CTRL_TTYPORT can be correctly set if requiring ACPI support.
> ---
> drivers/tty/serdev/Kconfig | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
> index cdc6b820cf93..a9fb09a9c105 100644
> --- a/drivers/tty/serdev/Kconfig
> +++ b/drivers/tty/serdev/Kconfig
> @@ -2,7 +2,8 @@
> # Serial bus device driver configuration
> #
> menuconfig SERIAL_DEV_BUS
> -	tristate "Serial device bus"
> +	bool "Serial device bus"
> +	default y
> 	help
> 	  Core support for devices connected via a serial port.
> 
> @@ -11,6 +12,6 @@ if SERIAL_DEV_BUS
> config SERIAL_DEV_CTRL_TTYPORT
> 	bool "Serial device TTY port controller"
> 	depends on TTY
> -	depends on SERIAL_DEV_BUS != m
> +	default y

actually we made hci_nokia.c be buildable as separate module. We might need to do the same for hci_bcm.c to avoid forcing SERIAL_DEV_BUS into a bool. Or you need to explain the reason behind this change a bit better.

Regards

Marcel

