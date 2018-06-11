From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 11/24] Bluetooth: hci_bcm: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 16:31:08 +0300
Message-ID: <CAHp75VcbVuzo3MHwogdqBoGQkUwB4hkL1Kfjq+PtDKO9cXnUjw@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-12-ricardo.ribalda@gmail.com> <D4622EB7-BB18-4931-BF14-34995F7EBBA8@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D4622EB7-BB18-4931-BF14-34995F7EBBA8@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 11, 2018 at 3:59 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Ricardo,
>
>> Export serdev table to the module header, allowing module autoload via
>> udev/modprobe.

>> static const struct serdev_device_id bcm_serdev_id[] =3D {
>>       { "bcm43438-bt", },
>> +     { "hci_uart_bcm", },
>>       {}
>> };
>> +MODULE_DEVICE_TABLE(serdev, bcm_serdev_id);
>
> so this one I can see real use of and is a good fix to finally clean up h=
ci_bcm.c and remove platform support for the Edison hardware. However, I wo=
uld really then first rename hci_uart_bcm into some Edison specific string =
since this is really just one outlier here.

Or other way around, hack
arch/x86/platform/intel-mid/device_libs/platform_bt.c to be compatible
with these changes (Dunno if it's possible).

--=20
With Best Regards,
Andy Shevchenko
