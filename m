From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [RFC v2 7/9] bluetooth: btrtl: load the config blob from
 devicetree when available
Date: Tue, 2 Jan 2018 22:43:06 +0100
Message-ID: <CAFBinCBK7uDOE-8t69obLqi+PVUPigs8OG9aYhYZ7s4p-HmbDQ@mail.gmail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-8-martin.blumenstingl@googlemail.com>
 <563D6F9F-8495-40D4-BE56-5338ED2B9B99@holtmann.org> <CAL9uMOEMDup4hRkxD-tM8R0YirGs5uQi31AjJUnFCPNMKUdRHg@mail.gmail.com>
 <E8E39477-CF1A-4A3E-84C5-830E182C2266@holtmann.org> <CAL9uMOH0N-4jgQncmPjK-KyU0vY9Q0ZnHYSAGgz3z3ywzc8Avw@mail.gmail.com>
 <F38429FB-2D20-4EF7-8547-E5A5D67D1618@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F38429FB-2D20-4EF7-8547-E5A5D67D1618-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Marcel, Hi Carlo,

On Tue, Jan 2, 2018 at 12:38 PM, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org> wrot=
e:
> Hi Carlo,
>
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
>
> so the BTHx entries normally come at least with the UART configuration. I=
t would be useful check if it is actually correct. And then I think similar=
 handling like what is done in hci_bcm.c and hci_intel.c needs to happen he=
re.
what I can see is (which also matches the settings I use on my Amlogic
based boards):
- initial speed =3D 115200
- 8 data bits
- 1 stop bit
- even parity
- HW flow control enabled

> I think that we extended serdev to ACPI as well. Don=E2=80=99t recall of =
the top of my head if these patches were merged or not. But if they are the=
n it is as simple as a serdev DT based driver. Just add the appropriate _HI=
D and got from there.
yes, serdev recently gained ACPI support iirc
however, can we agree on implementing this step-by-step:
- I do not have any hardware that uses a RTL8723BS or RTL8723DS and
ACPI (I have these chips in Amlogic SoC based "TV boxes" where DT is
the leading firmware, so I cannot test the ACPI part)
- my goal is to get rid of the rtk_hciattach userspace tool dependency
(mostly Allwinner and Amlogic based devices will benefit from this)
- it would be great if I could get feedback what to consider or to
avoid when implementing this so ACPI support can be added easily on
top of my patches

> However now I think that moving towards making hci_h5.c more like generic=
 abstraction like hci_h4.c and having a hci_rtl.c be specific for Realtek c=
hips seems a bit cleaner direction. Frankly only H:4 and H:5 plain protocol=
s should be used by btattach. And all others should go via serdev.
I agree with you here (as already discussed in the other patch)


Regards
Martin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
