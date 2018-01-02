From: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC v2 7/9] bluetooth: btrtl: load the config blob from
 devicetree when available
Date: Tue, 2 Jan 2018 11:15:59 +0000
Message-ID: <CAL9uMOEMDup4hRkxD-tM8R0YirGs5uQi31AjJUnFCPNMKUdRHg@mail.gmail.com>
References: <20180101204217.26165-1-martin.blumenstingl@googlemail.com>
 <20180101204217.26165-8-martin.blumenstingl@googlemail.com> <563D6F9F-8495-40D4-BE56-5338ED2B9B99@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <563D6F9F-8495-40D4-BE56-5338ED2B9B99-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 2, 2018 at 11:11 AM, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org> wrot=
e:
> Hi Martin,
>
>> Some Realtek bluetooth devices need a "config" blob. The btrtl driver
>> currently only allows loading this config blob via the request_firmware
>> mechanism.
>>
>> The UART Bluetooth chips use this config blob to specify the baudrate,
>> whether flow control is used and some other unknown bits. This means
>> that the config blob is board-specific - thus loading it via
>> request_firmware means that the rootfs is tied to a specific board.
>>
>> The UART Bluetooth chips are implemented through serdev. This means
>> there is also a devicetree node which describes the Bluetooth chip.
>> Thus we can also load the blob from the devicetree node to keep the
>> filesystem independent of any board configuration data. In the future
>> this could be extended to support ACPI as well (in case that's needed).
>>
>> Parse the devicetree node if it exists and obtain the config blob from
>> there. Otherwise fall back to using the "old" request_firmware
>> mechanism.
>
> where are these config blobs coming from? I think we also need to give pe=
ople a helping hand on how to add them to DT. I still wonder if the only pi=
eces we are using are the UART config, then maybe skipping the config blob =
and allowing for clear named values in DT might be better.

What about x86 platforms where we do not have DT (I didn't check but I
don't think that the UART config in that case is shipped in the ACPI
tables)?

Cheers,

--=20
Carlo Caione  |  +44.7384.69.16.04  |  Endless
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
