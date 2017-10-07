From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
Date: Sat, 7 Oct 2017 02:03:25 +0200
Message-ID: <CAJZ5v0gLhnisMn9o00ndnB6fjHt5V7KCy_57UScF=ZfZVF=dxA@mail.gmail.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
 <CAL_JsqKDzR9-ptE=SbL0LuQvTKDNT-GZ8buOvffJDyWz6fHfSA@mail.gmail.com> <BF8AC3FB-72FE-41C3-BE8D-27A32B84F6CB@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <BF8AC3FB-72FE-41C3-BE8D-27A32B84F6CB@holtmann.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh@kernel.org>, =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, Greg Kroah-Hartman <greg@kroah.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 6, 2017 at 8:32 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Rob,
>
>>> This patch allows SerDev module to manage serial devices declared as
>>> attached to an UART in ACPI table.
>>>
>>> acpi_serdev_add_device() callback will only take into account entries
>>> without enumerated flag set. This flags is set for all entries during
>>> ACPI scan, except for SPI and I2C serial devices, and for UART with
>>> 2nd patch in the series.
>>>
>>> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
>>> ---
>>> drivers/tty/serdev/core.c | 99 ++++++++++++++++++++++++++++++++++++++++=
++++---
>>> 1 file changed, 94 insertions(+), 5 deletions(-)
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>
> so how do we get these changes upstream? If the serdev changes alone do n=
ot cause any harm, I am almost proposing taking them through bluetooth-next=
 tree and only leave only the ACPI change to the ACPI maintainers.

That would be fine by me.  I can take the serdev patch too, though.

Thanks,
Rafael
