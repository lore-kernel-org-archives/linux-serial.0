From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH] tty: serial: meson: Implement earlycon support
Date: Mon, 8 Feb 2016 12:50:43 +0100
Message-ID: <56B88113.2050800@suse.de>
References: <1454878635-24396-1-git-send-email-afaerber@suse.de>
 <56B817FC.4000604@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <56B817FC.4000604@hurleysoftware.com>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-arm-kernel@lists.infradead.org, Carlo Caione <carlo@caione.org>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-doc <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-meson@googlegroups.com, Matthias Brugger <mbrugger@suse.com>, Nicolas Saenz <nicolassaenzj@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

Am 08.02.2016 um 05:22 schrieb Peter Hurley:
> On 02/07/2016 12:57 PM, Andreas F=C3=A4rber wrote:
>> Reuse the existing console write implementation for implementing
>> DT-based and command-line-based earlycon support.
>>
>> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>> ---
>>  Documentation/kernel-parameters.txt |  6 ++++++
>>  drivers/tty/serial/meson_uart.c     | 13 +++++++++++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/ker=
nel-parameters.txt
>> index 602065c..90801ac 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -1030,6 +1030,12 @@ Such letter suffixes can also be entirely omi=
tted.
>>  			the driver will use only 32-bit accessors to read/write
>>  			the device registers.
>> =20
>> +		meson_serial,<addr>
>> +			Start an early, polled-mode console on a meson serial
>> +			port at the specified address. The serial port must
>> +			already be setup and configured. Options are not yet
>> +			supported.
>> +
>>  		msm_serial,<addr>
>>  			Start an early, polled-mode console on an msm serial
>>  			port at the specified address. The serial port
>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/me=
son_uart.c
>> index b12a37b..6f89567 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -548,6 +548,19 @@ static int __init meson_serial_console_init(voi=
d)
>>  }
>>  console_initcall(meson_serial_console_init);
>> =20
>> +static int __init
>> +meson_serial_early_console_setup(struct earlycon_device *device, co=
nst char *opt)
>> +{
>> +	if (!device->port.membase)
>> +		return -ENODEV;
>> +
>> +	device->con->write =3D meson_serial_console_write;
>=20
> meson_serial_console_write() is not appropriate for earlycon; it assu=
mes the
> earlycon port is the same as the driver port (it isn't).

Thanks for spotting that.

I forgot to mention that I tested this on arm64, where there is no
earlyprintk any more, seemingly successfully getting a bootconsole
uart0. Using co->data instead of co->index I now get meson_serial0
instead, doh.

This probably slipped though because another patch is necessary for
fixing the baudrate calculation on my device.

>> +	return 0;
>> +}
>> +EARLYCON_DECLARE(meson_serial, meson_serial_early_console_setup);
>> +OF_EARLYCON_DECLARE(meson_serial, "amlogic,meson-uart",
>> +		    meson_serial_early_console_setup);
>=20
> With today's linux-next (or Greg's tty-next tree), it is no longer ne=
cessary to
> declare separate earlycon's when you want both; OF_EARLYCON_DECLARE()=
 declares
> both a devicetree-enabled earlycon and automatically provides for a c=
ommand line
> earlycon of the same name.

Thanks for the hint, it was based on linux-next from a couple days ago.

Is there any guidance wrt naming? I noticed that msm uses -uart in the
compatible string and _serial for earlycon, so I copied that; should it
rather be meson_uart or just meson?

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton; HRB 21284 (AG=
 N=C3=BCrnberg)
