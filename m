From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] ACPI serdev support
Date: Tue, 10 Oct 2017 02:27:33 +0200
Message-ID: <CAJZ5v0iaXiPhZaohmN0XLJ2_n7ZzhbWebUh80uC3-8n5uGg8jg@mail.gmail.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1507107090-15992-1-git-send-email-frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Loic Poulain <loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 4, 2017 at 10:51 AM, Fr=C3=A9d=C3=A9ric Danis
<frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Add ACPI support for serial attached devices.
>
> Currently, serial devices are not set as enumerated during ACPI scan for =
SPI
> or i2c buses (but not for UART). This should also be done for UART serial
> devices.
> I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.
>
> For hci_bcm, this needs Hans de Goede's "Bluetooth: hci_bcm: Add (runtime=
)pm
> support to the serdev drv" patches to work.
>
> Tested on T100TA with Broadcom BCM2E39.
>
> Since RFC:
>   - Add or reword commit messages
>   - Rename *serial_slave* to *serial_bus_slave*
>   - Add specific check for Apple in acpi_is_serial_bus_slave(), thanks to
>     Lukas Wunner
>   - Update comment in acpi_default_enumeration()
>   - Remove patch 3 "Bluetooth: hci_bcm: Add ACPI serdev support for BCM2E=
39"
>     in favor of patches from Hans de Goede
>
> Fr=C3=A9d=C3=A9ric Danis (2):
>   serdev: Add ACPI support
>   ACPI / scan: Fix enumeration for special UART devices

Some review comments you received on this series should be addressed
IMO, so I'm expecting an update of it.

When sending the next version, please add all of the tags you've
already received on it.

Thanks,
Rafael
