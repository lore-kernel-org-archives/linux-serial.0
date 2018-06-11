From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH v2 15/24] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 17:09:14 +0200
Message-ID: <CAPybu_0=ykAcCx=nZyrv90YRfihDxi3s2+Nz+6UP8Fwd5eH2-A@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-16-ricardo.ribalda@gmail.com> <CCB7FF79-F89A-4421-A6C0-E0663BEE6065@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CCB7FF79-F89A-4421-A6C0-E0663BEE6065@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, David Miller <davem@davemloft.net>, Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, netdev@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Marcel,
On Mon, Jun 11, 2018 at 3:01 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
>
> the commit message is misleading me. If I build something with ACPI or DT=
 support, then modinfo will show all modalias information for ACPI and DT c=
ompatible strings. What else does udev/modprobe actually need? Is something=
 broken with the modalias export?

The main purpose is to autoload drivers for devices that have been
created via sysfs or another module.

Eg1: We have a serial port on a standard computer that has connected a
GPS module. Since it is something that is not in the ACPI nor the DT
table the user will run

echo serdev_gps > /sys/bus/serial/devices/serial0/new_device

Eg2 module: https://github.com/ribalda/linux/blob/415bb3f0076c2b846ebe54095=
89b8e1e3004f55a/drivers/tty/serdev/test_platform.c

Modprobe does not know what module to load for that device unless
there is a matching MODULE_DEVICE_TABLE
Today, we have the same functionality for i2c devices
https://www.kernel.org/doc/Documentation/i2c/instantiating-devices

I guess the commit message is really bad :), sorry about that. Any
suggestions to improve it?

Thanks!

>
> Regards
>
> Marcel
>


--=20
Ricardo Ribalda
