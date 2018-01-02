From: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC v2 7/9] bluetooth: btrtl: load the config blob from
 devicetree when available
Date: Tue, 2 Jan 2018 23:06:34 +0000
Message-ID: <CAL9uMOFyfr_qGf5BeTojkMeWeH8LqPoKj=LrdgEMB2wmhGBxmA@mail.gmail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-8-martin.blumenstingl@googlemail.com>
 <563D6F9F-8495-40D4-BE56-5338ED2B9B99@holtmann.org> <CAL9uMOEMDup4hRkxD-tM8R0YirGs5uQi31AjJUnFCPNMKUdRHg@mail.gmail.com>
 <E8E39477-CF1A-4A3E-84C5-830E182C2266@holtmann.org> <CAL9uMOH0N-4jgQncmPjK-KyU0vY9Q0ZnHYSAGgz3z3ywzc8Avw@mail.gmail.com>
 <CAFBinCBB=SmviOMRHGDH6vzjTjV-mrtQEc8nBUhDbJGs9SBpgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFBinCBB=SmviOMRHGDH6vzjTjV-mrtQEc8nBUhDbJGs9SBpgw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 2, 2018 at 9:46 PM, Martin Blumenstingl
<martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> Hi Carlo,

Hi Martin,

> On Tue, Jan 2, 2018 at 12:31 PM, Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org> wrote:
>> On Tue, Jan 2, 2018 at 11:19 AM, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org> w=
rote:
>>> Hi Carlo,
>>>
>>>>>> Some Realtek bluetooth devices need a "config" blob. The btrtl drive=
r
>>>>>> currently only allows loading this config blob via the request_firmw=
are
>>>>>> mechanism.
>>>>>>
>>>>>> The UART Bluetooth chips use this config blob to specify the baudrat=
e,
>>>>>> whether flow control is used and some other unknown bits. This means
>>>>>> that the config blob is board-specific - thus loading it via
>>>>>> request_firmware means that the rootfs is tied to a specific board.
>>>>>>
>>>>>> The UART Bluetooth chips are implemented through serdev. This means
>>>>>> there is also a devicetree node which describes the Bluetooth chip.
>>>>>> Thus we can also load the blob from the devicetree node to keep the
>>>>>> filesystem independent of any board configuration data. In the futur=
e
>>>>>> this could be extended to support ACPI as well (in case that's neede=
d).
>>>>>>
>>>>>> Parse the devicetree node if it exists and obtain the config blob fr=
om
>>>>>> there. Otherwise fall back to using the "old" request_firmware
>>>>>> mechanism.
>>>>>
>>>>> where are these config blobs coming from? I think we also need to giv=
e people a helping hand on how to add them to DT. I still wonder if the onl=
y pieces we are using are the UART config, then maybe skipping the config b=
lob and allowing for clear named values in DT might be better.
>>>>
>>>> What about x86 platforms where we do not have DT (I didn't check but I
>>>> don't think that the UART config in that case is shipped in the ACPI
>>>> tables)?
>>>
>>> if we have this hardware in x86 systems, then I would really like to se=
e ACPI table dumps. Some pieces might need hardcoding based on ACPI ID.
>>
>> Yes, we have, especially on cherry-trail SoCs. In [0] the DSDT of a
>> cherry-trail laptop shipping the rtl8723bs (device OBDA8723).
>>
>> [0] https://gist.github.com/carlocaione/82bff95ababb67dd33f52a86e94ce3ff
> so this shows that the UART settings (initial baudrate, HW flow
> control, etc.) are part of the DSDT
> however, the actual config blob is not
>
> the description of this patch explains: "Parse the devicetree node ...
> [or] ... fall back to using the "old" request_firmware mechanism."
> do you have any other solution in mind?

As Marcel suggested we can assume that the information in the DSDT is
correct so that we can get rid of the config blob also for x86
platforms (assuming that the only useful information in the config
blobs is the UART configuration).

Adding the ACPI support on top of your patches is (hopefully) trivial,
just follow what was done for hci_bcm.c, basically adding a new _HID
and reading the configuration for GPIOs and UART, all the rest should
be transparent for serdev.

I'll test your patches on the hardware I have.

Cheers,

--=20
Carlo Caione  |  +44.7384.69.16.04  |  Endless
