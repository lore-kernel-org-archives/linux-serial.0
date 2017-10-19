From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 0/2] ACPI serdev support
Date: Thu, 19 Oct 2017 21:05:06 +0200
Message-ID: <0046719b-648f-556d-2dd5-ac695d843103@redhat.com>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
 <20171011090354.GS4269@localhost>
 <CAJZ5v0jPEg5Ow4p0DzPJ9Md7RUTPhZZqCzqP5zmX-pPf9N80=g@mail.gmail.com>
 <AA38D4FD-5A35-460D-85CF-380BAB933448@holtmann.org>
 <ac53458d-c910-2d0a-a2ad-e7d21f8a5be7@gmail.com>
 <20171018145608.GB27138@kroah.com> <20171019142354.GE5638@localhost>
 <877ea825-eec5-d982-f962-d67067749009@redhat.com>
 <115502FA-19DE-439C-A171-3CD5E6D92338@holtmann.org>
 <1503e15d-6199-221a-542f-3766a69577e5@redhat.com>
 <CAMZdPi_ZpNrdjJPnS_rQ9t3oYe6+en9oHQMjmMjx_xHL-WWZKQ@mail.gmail.com>
 <28b99df9-de22-4542-055e-d9fa585aba8f@redhat.com>
 <FFD85CA6-6BD9-45AA-B3C2-898212711C0C@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <FFD85CA6-6BD9-45AA-B3C2-898212711C0C-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Loic Poulain <loic.poulain-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Loic Poulain <loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On 19-10-17 21:00, Marcel Holtmann wrote:
> Hi Hans,
> 
>>>             Hmm, I've never actually seen any hardware use an intel BT HCI connected
>>>             to a serdev, but I guess people did not write that code for fun, so those
>>>             do exist ?
>>>         they are all ACPI based and could now start using serdev. Previously they were all driven by btattach.
>>>     I understand, I was just wondering if anyone is aware of any hardware
>>>     actually using Intel BT devices in this manner, because it is going
>>>     to be tricky to do a similar series if we cannot test it.
>>> Yeah this driver supports Lightning-Peak iBT 3.0 UART controller.
>>> I remember this controller comes (at least) with Atom x3-c3440 / x3-c3445 SoCs.
>>> However I don't have the hardware anymore.
>>
>> Ah, those are the Rockchip manufactured Atom based SoCs which
>> come with Mali graphics, I don't think anyone is trying to run
>> mainline on those and not a whole lot of those have shipped to
>> begin with (the line has been canceled).
>>
>> I've an Apollo Lake based laptop with Intel Bluetooth, I just
>> checked and that is simply using USB.
>>
>> So I don't think we are actually going to break anything by
>> just moving forward as planned. This reminds me of the axp288
>> driver where Intel's "embedded" engineering team upstreamed
>> parts of the axp288 PMIC code, but in a way where the driver
>> could not work as it would not load with platform_data which
>> was never provided by the mainline kernel.
>>
>> As such it might actually be good to break this and if no-one
>> complains we can just remove the hci_intel.c code altogether.
> 
> I think we can go forward with what we have. I am not going to remove hci_intel.c since the firmware loading code etc. is pretty generic to all Intel UART based chips. However we just take the PM pieces out or maybe someone is going to fix them.

Ok.

>> The alternative would be to revert 2 if the 3 patches of
>> my last series for making the BT on the GPD win / pocket
>> (and likely other devices) work in uart mode. Then someone
>> (me?) would need to do a completely untested series for
>> hci_intel.c, and get that + reverts of the reverts into 4.16,
>> which is not the best way forward IMHO.
> 
> I am not doing that. We have to make progress towards serdev. So if things really turn out badly, then we have to deal with it, but that should not hold up getting things in the direction this needs to go.

Sounds good to me.

Regards,

Hans
