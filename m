From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
Date: Fri, 6 Oct 2017 20:32:27 +0200
Message-ID: <BF8AC3FB-72FE-41C3-BE8D-27A32B84F6CB@holtmann.org>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
 <CAL_JsqKDzR9-ptE=SbL0LuQvTKDNT-GZ8buOvffJDyWz6fHfSA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqKDzR9-ptE=SbL0LuQvTKDNT-GZ8buOvffJDyWz6fHfSA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Loic Poulain <loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Rob,

>> This patch allows SerDev module to manage serial devices declared as
>> attached to an UART in ACPI table.
>> 
>> acpi_serdev_add_device() callback will only take into account entries
>> without enumerated flag set. This flags is set for all entries during
>> ACPI scan, except for SPI and I2C serial devices, and for UART with
>> 2nd patch in the series.
>> 
>> Signed-off-by: Frédéric Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>> drivers/tty/serdev/core.c | 99 ++++++++++++++++++++++++++++++++++++++++++++---
>> 1 file changed, 94 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

so how do we get these changes upstream? If the serdev changes alone do not cause any harm, I am almost proposing taking them through bluetooth-next tree and only leave only the ACPI change to the ACPI maintainers.

Greg, any thoughts?

Regards

Marcel
