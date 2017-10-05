From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/2] ACPI serdev support
Date: Thu, 5 Oct 2017 17:21:50 +0200
Message-ID: <A58D9E0F-99FC-4C13-95E8-F60EC61C18B2@holtmann.org>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.6\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
List-Id: linux-serial@vger.kernel.org

Hi Fred,

> Add ACPI support for serial attached devices.
> 
> Currently, serial devices are not set as enumerated during ACPI scan for SPI
> or i2c buses (but not for UART). This should also be done for UART serial
> devices.
> I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.
> 
> For hci_bcm, this needs Hans de Goede's "Bluetooth: hci_bcm: Add (runtime)pm
> support to the serdev drv" patches to work.
> 
> Tested on T100TA with Broadcom BCM2E39.
> 
> Since RFC:
>  - Add or reword commit messages
>  - Rename *serial_slave* to *serial_bus_slave*
>  - Add specific check for Apple in acpi_is_serial_bus_slave(), thanks to
>    Lukas Wunner
>  - Update comment in acpi_default_enumeration()
>  - Remove patch 3 "Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E39"
>    in favor of patches from Hans de Goede

I already applied Hans’ patch series to bluetooth-next tree. And I have no objections or comments for these changes. They should be reviewed and acked by the appropriate maintainers as well, but from my side this looks good.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

What we should discuss on how we get them upstream since besides the Bluetooth subsystem, they cover ACPI and TTY subsystems.

Regards

Marcel

