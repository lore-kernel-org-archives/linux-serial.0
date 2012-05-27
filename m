From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH RFC] serial/8250: Adjusting FIFO parameters for LPC32xx
Date: Sun, 27 May 2012 11:06:47 +0200
Message-ID: <4FC1EEA7.2060109@antcom.de>
References: <1338048678-23991-1-git-send-email-stigge@antcom.de> <201205270232.58253.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:60040 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab2E0JGv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 May 2012 05:06:51 -0400
In-Reply-To: <201205270232.58253.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, linux-arm-kernel@lists.infradead.org

Hi,

On 27/05/12 04:32, Arnd Bergmann wrote:
>> this is how the modified FIFO is handled in the repositories at
>> git.lpclinux.com. Is there a better way for doing this (without ifde=
f)?  Looks
>> like registering additional types (like PORT_16550A) isn't encourage=
d.  Maybe
>> extending of_serial.c? The latter currently doesn't handle .fifosize=
 and
>> .tx_loadsz, though.
>>
>> Any suggestions appreciated.
>=20
> We occasionally add new types, and I think that would be ok here too,=
 if it's
> actually a new type. It definitely doesn't look like a 16550.
>=20
> I wonder if it's in fact a PORT_16654, or if we can at least pretend =
it's one.

Thanks for the hint!

I did it via the following modification in of_serial.c:

--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -179,6 +179,7 @@ static struct of_device_id __devinitdata of_platfor=
m_serial_table[] =3D {
        { .compatible =3D "ns16450",  .data =3D (void *)PORT_16450, },
        { .compatible =3D "ns16550a", .data =3D (void *)PORT_16550A, },
        { .compatible =3D "ns16550",  .data =3D (void *)PORT_16550, },
+       { .compatible =3D "ns16654",  .data =3D (void *)PORT_16654, },
        { .compatible =3D "ns16750",  .data =3D (void *)PORT_16750, },
        { .compatible =3D "ns16850",  .data =3D (void *)PORT_16850, },
        { .compatible =3D "nvidia,tegra20-uart", .data =3D (void *)PORT=
_TEGRA, },

Works for now, will need to test more thoroughly with LPC32xx (note tha=
t
the manual explicitly mentions "downwards compatible with the INS16Cx50=
"
and "Register locations conform to =E2=80=98550 industry standard" but =
nothing
about an EFR register which 16654 is configured for in 8250.c).

The patch should be useful in of_serial anyway (even without the LPC32x=
x
case).

Wondering if it should rather be .compatible =3D "st16654"?
Will prepare a patch with adjustment of Documentation/.../of-serial.txt=
 when
we agree on sth.

Thanks,

Roland
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
