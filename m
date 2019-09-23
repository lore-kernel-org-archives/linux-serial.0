From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
Date: Mon, 23 Sep 2019 10:14:40 +0200
Message-ID: <8bed7cde-1f59-c5bf-9506-757dd89ad594@redhat.com>
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
 <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 23-09-2019 00:29, Maximilian Luz wrote:
> Hi all,
>=20
> On 9/20/19 5:00 PM, Hans de Goede wrote:
>> So as promised I've given this patch a try, unfortunately it breaks
>> existing users of ACPI serdev device instantation.
>>
>> After adding this patch "ls /sys/bus/serial/devices" is empty,
>> where as before it gives:
>>
>> [root@dhcp-45-50 ~]# ls -l /sys/bus/serial/devices/
>> total 0
>> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0 -> ../../../devices/pci00=
00:00/8086228A:00/serial0
>> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0-0 -> ../../../devices/pci=
0000:00/8086228A:00/serial0/serial0-0
>>
>> And since the serdev is missing bluetooth does not work.
>=20
> Thanks to some testing by Hans, it turns out that the reason for this is
> that acpi_walk_resources fails with AE_AML_INVALID_RESOURCE_TYPE for a
> specific device. If anyone is interested, the _CRS of the device in
> question is
>=20
>  =C2=A0=C2=A0=C2=A0 Method (_CRS, 0, NotSerialized)=C2=A0 // _CRS: Curren=
t Resource Settings
>  =C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (NAM, Buffer (0x14)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\\_S=
B.PCI0.SDHB.BRC1"
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (SPB, Buffer (0x0C)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 00=
00 */=C2=A0 0x8E, 0x1D, 0x00, 0x01, 0x00, 0xC0, 0x02, 0x00,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 00=
08 */=C2=A0 0x00, 0x01, 0x00, 0x00
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (END, ResourceTemplate (=
)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Concatenate (SPB, NAM, Local0=
)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Concatenate (Local0, END, Loc=
al1)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Return (Local1)
>  =C2=A0=C2=A0=C2=A0 }
>=20
> To solve this, I propose ignoring errors that occur when evaluating the
> _CRS method. Note that with the previously discussed change for v2,
> where we will only look at the first device in _CRS, we should be able
> to handle errors from the actual serdev device allocation separately
> (and only ignore AML evaluation errors).
>=20
> Further, I think it might also make sense to move the status and
> already-enumerated checks out of acpi_serdev_register_device to before
> looking at _CRS.

Ack, this is what drivers/i2c/i2c-core-acpi.c is doing and more in general
all ACPI enumeration code always first checks _STA before doing anything
else, so I think it would be best to do this here too.

Actually I think it might be best to fully copy how drivers/i2c/i2c-core-ac=
pi.c
does things.

Regards,

Hans
