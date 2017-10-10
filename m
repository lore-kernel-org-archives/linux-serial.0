From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: Re: [PATCH v2 1/2] serdev: Add ACPI support
Date: Wed, 11 Oct 2017 02:16:07 +1100
Message-ID: <CAFXWsS88T4TXya0dzVWLmgy_2tuLgPLJg8CQe=9ohAt_Mjvoow@mail.gmail.com>
References: <1507630365-26692-1-git-send-email-frederic.danis.oss@gmail.com> <1507630365-26692-2-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1507630365-26692-2-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg KH <greg@kroah.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10 October 2017 at 21:12, Fr=C3=A9d=C3=A9ric Danis
<frederic.danis.oss@gmail.com> wrote:
> This patch allows SerDev module to manage serial devices declared as
> attached to an UART in ACPI table.
>
> acpi_serdev_add_device() callback will only take into account entries
> without enumerated flag set. This flags is set for all entries during
> ACPI scan, except for SPI and I2C serial devices, and for UART with
> 2nd patch in the series.
>
> Check if a serdev device as been allocated during acpi_walk_namespace()
> to prevent serdev controller registration instead of the tty-class device=
.

<snip>

Hi Fred,

I tested the v2 patch and can confirm it works:

Before v1 patch:
$ dmesg | grep tty
[    0.000000] console [tty0] enabled
[    2.409003] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200)
is a 16550A
[    5.380336] 8086228A:00: ttyS4 at MMIO 0x9151b000 (irq =3D 39,
base_baud =3D 2764800) is a 16550A
[    5.388412] 8086228A:01: ttyS5 at MMIO 0x91519000 (irq =3D 40,
base_baud =3D 2764800) is a 16550A
$

After v1 patch:
$ dmesg | grep tty
[    0.000000] console [tty0] enabled
[    2.416973] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200)
is a 16550A
[    2.417317] serial serial0: tty port ttyS0 registered
[    5.928492] 8086228A:00: ttyS4 at MMIO 0x9151b000 (irq =3D 39,
base_baud =3D 2764800) is a 16550A
[    5.982195] serial serial1: tty port ttyS4 registered
[    6.004426] 8086228A:01: ttyS5 at MMIO 0x91519000 (irq =3D 40,
base_baud =3D 2764800) is a 16550A
[    6.019369] serial serial2: tty port ttyS5 registered
$

After v2 patch:
$ dmesg | grep tty
[    0.000000] console [tty0] enabled
[    2.420295] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200)
is a 16550A
[    5.884777] 8086228A:00: ttyS4 at MMIO 0x9151b000 (irq =3D 39,
base_baud =3D 2764800) is a 16550A
[    5.917980] serial serial0: tty port ttyS4 registered
[    5.933160] 8086228A:01: ttyS5 at MMIO 0x91519000 (irq =3D 40,
base_baud =3D 2764800) is a 16550A
$

Regards,
Ian
