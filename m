From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH v2 15/24] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 18:21:56 +0200
Message-ID: <CAPybu_37067-Vny5ZbMK6ZkU8=f-Pk8f9=Sf+NsK7V_VGBMBLg@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-16-ricardo.ribalda@gmail.com> <CCB7FF79-F89A-4421-A6C0-E0663BEE6065@holtmann.org>
 <CAPybu_0=ykAcCx=nZyrv90YRfihDxi3s2+Nz+6UP8Fwd5eH2-A@mail.gmail.com>
 <B4BC9DB0-2D7C-4F9D-99FE-8227D4DC3D54@holtmann.org> <CAPybu_2ViGvN6egz-Ajq4+1fv6VAVFswuvSPAVmYH0a9R-Yjvw@mail.gmail.com>
 <07871EF5-D1D3-4677-8100-B5E7F14DB302@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <07871EF5-D1D3-4677-8100-B5E7F14DB302@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, David Miller <davem@davemloft.net>, Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, netdev@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Marcel,
On Mon, Jun 11, 2018 at 5:52 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Ricardo,
>
> >>>> the commit message is misleading me. If I build something with ACPI =
or DT support, then modinfo will show all modalias information for ACPI and=
 DT compatible strings. What else does udev/modprobe actually need? Is some=
thing broken with the modalias export?
> >>>
> >>> The main purpose is to autoload drivers for devices that have been
> >>> created via sysfs or another module.
> >>>
> >>> Eg1: We have a serial port on a standard computer that has connected =
a
> >>> GPS module. Since it is something that is not in the ACPI nor the DT
> >>> table the user will run
> >>>
> >>> echo serdev_gps > /sys/bus/serial/devices/serial0/new_device
> >>>
> >>> Eg2 module: https://github.com/ribalda/linux/blob/415bb3f0076c2b846eb=
e5409589b8e1e3004f55a/drivers/tty/serdev/test_platform.c
> >>>
> >>> Modprobe does not know what module to load for that device unless
> >>> there is a matching MODULE_DEVICE_TABLE
> >>> Today, we have the same functionality for i2c devices
> >>> https://www.kernel.org/doc/Documentation/i2c/instantiating-devices
> >>
> >> but why does this have to be the driver name? I would rather say, crea=
te a generic string that describes the hardware and then use that. I think =
you also want the special handling, as from USB for example, that lets you =
reference an existing .compatible or ACPI ID as reference so that the drive=
r_data is copied.
> >
> > We can choose any name, but if there are no special variants (like the
> > rave-sp driver) I would prefer using the module name. We can of course
> > use more names, like the part number of the the device, but it is very
> > convenient to also use the module name, and other subsystems also do
> > that.
> >
> > If you want to add specific names for this device please let me know
> > and I will add them to the list. You know much more about this module
> > than myself.
>
> if we want to use the driver name, then why not build this into the new_d=
evice handling itself instead of duplicating that name in each serdev_devic=
e_id table. What is the reference here? For example platform device do matc=
hing on driver name if I recall this correctly.

We do the matching also over driver name at serdev_device_match():

if (sdrv->id_table)
return !!serdev_match_id(sdrv->id_table, sdev);

return strcmp(sdev->modalias, drv->name) =3D=3D 0;

This is just for the module autoloading

>
> However what is most important is that device_get_match_data() actually w=
orks. There should be no difference between DT, ACPI or a dynamic device.

Agree, will take a look to this tomorrow morning.

>
> Regards
>
> Marcel
>


--=20
Ricardo Ribalda
