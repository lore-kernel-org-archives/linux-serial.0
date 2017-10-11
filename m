From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/2] ACPI serdev support
Date: Wed, 11 Oct 2017 15:09:12 +0200
Message-ID: <CAJZ5v0jPEg5Ow4p0DzPJ9Md7RUTPhZZqCzqP5zmX-pPf9N80=g@mail.gmail.com>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com> <20171011090354.GS4269@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171011090354.GS4269@localhost>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Loic Poulain <loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 11, 2017 at 11:03 AM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Oct 11, 2017 at 10:32:12AM +0200, Fr=C3=A9d=C3=A9ric Danis wrote:
>> Add ACPI support for serial attached devices.
>>
>> Currently, serial devices are not set as enumerated during ACPI scan for=
 SPI
>> or i2c buses (but not for UART). This should also be done for UART seria=
l
>> devices.
>> I renamed *spi_i2c_slave* to *serial_bus_slave* to reflect this.
>>
>> This needs Johan Hovold's "serdev: fix registration of second slave" pat=
ch.
>
> In theory this series could go in through the acpi-tree without my
> fix. It would only affect an error case where an unlikely failure to
> register an ACPI serdev device, would prevent the tty-class device from
> being registered instead of the controller. That is, something we can
> live with until this all converges in 4.15-rc1 if needed.
>
> That said, I think we should consider taking all serdev changes, and
> therefore also the ACPI patch, through the tty tree instead in order to
> avoid merge conflicts. Rafael?

OK

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

to the ACPI core change.

And I will assume that this series will go in via the tty tree.

Thanks,
Rafael
