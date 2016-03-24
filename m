From: Matthias Schiffer <mschiffer@universe-factory.net>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
Date: Thu, 24 Mar 2016 03:09:37 +0100
Message-ID: <56F34C61.50505@universe-factory.net>
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
 <56F16708.4020109@hurleysoftware.com> <56F2D523.6000405@universe-factory.net>
 <56F3386A.5040100@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bH8tHUgxmMM5nQn9EmjhtKfWxPJFb45NL"
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <56F3386A.5040100@hurleysoftware.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bH8tHUgxmMM5nQn9EmjhtKfWxPJFb45NL
Content-Type: multipart/mixed; boundary="mXSi9OadEK5a0C2GMvqlwxgihmNSWHPwR"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
 jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <56F34C61.50505@universe-factory.net>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
 <56F16708.4020109@hurleysoftware.com> <56F2D523.6000405@universe-factory.net>
 <56F3386A.5040100@hurleysoftware.com>
In-Reply-To: <56F3386A.5040100@hurleysoftware.com>

--mXSi9OadEK5a0C2GMvqlwxgihmNSWHPwR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> autoconfig_16550a() is doing all kinds of weird checks to detect diffe=
rent
>> hardware by writing a lot of register values which are documented as
>> reserved in the AR7242 datasheet (there's a leaked version going aroun=
d
>> that can be easily googled...), no idea if any of those are problemati=
c.
>> Just setting UPF_FIXED_TYPE as suggested by Peter would avoid that cod=
e
>> altogether.
>=20
> That's just a debugging patch and not appropriate for permanent use,
> the reason being that this uart is _not_ 16550 compatible (or even 1645=
0
> compatible).
>=20
> The three options for 8250 driver support for this part are:
> 1. Similar to the debugging patch, set UPF_FIXED_TYPE but set port type=

>    to PORT_8250 instead. This will lose FIFO support so 115K won't be
>    possible and likely neither will 38400.
>=20
> 2. Set UPF_FIXED_TYPE but define a new PORT_* value and add support for=

>    this PORT_* value to uart_config array, uapi headers, and anywhere
>    the scratch register is used.
>=20
> 3. As with 2. above but don't set UPF_FIXED_TYPE and add a probe functi=
on
>    that detects ports of this type to autoconfig(). I don't recommend t=
his
>    method.
>=20
> This requirement is independent of fixing prom_putchar_ar71xx().
>=20

I can send patches for all of this, and I think that 2. would be the nice=
st
solution. I've noticed though that include/uapi/linux/serial_core.h is
experiencing a little "overflow": PORT_MAX_8250 has grown just below the
first non-8250 entry. Should I just add the new entry at the bottom (and
thus grow the uart_config array by ~85 unused entries)? What about
PORT_MAX_8250 (used at least in drivers/tty/serial/8250/8250_of.c)?

Regards,
Matthias


--mXSi9OadEK5a0C2GMvqlwxgihmNSWHPwR--

--bH8tHUgxmMM5nQn9EmjhtKfWxPJFb45NL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW80xhAAoJEBbvP2TLIB2cJSsP/Ar//8qthU7JIwqBtCv9YfLd
07TkbJrLcVWQDCJL02Nza2JxQJ/B9cUUOJemENrsvp8J5pAx4mNQF4eWUC1UM2NX
SzzVa5818sy4TYUySO806znEfWlWfDbVDpByNE8B1CsSSjEXFWgr3wfc4fFsbrJb
Chl057ki575DwPMT/zNvFLq5KT8cbnys0+bSunIkc+zlUJbrziaSXym+Pa4Ep3R6
/dytO2Yo4/EsI7C5E79WwwdzesCUd5DTrAa46vL+2qfn5hBiwzhy+gD6bl4geZve
9bZueH/d8JB0ET2JpAPW+IgSIXIJyMYVMkmMe+UDEXsAgMEqACrAaBzPcq0DRH70
HYvmDDmc/SUeEiVXbIIB0gHIgxNKLw0dFantPNIYrXOA0SOJVvGlDhmvl9/hF6sR
Gq5qEWvjjKzmAfM3ColrdVqhGg3LsWo6guSYOz9Dub3AoMSSbdtUYPTGGCMkHdUM
64gUEF1ilrPFMjLov0BamVW+1LEVoMUd+eMvVycCpf4DDX2aIDcJILup0KJ7oTJV
xToq7JRBtlBLt2I68Y0wEiK7Jy2E4GMYL0haQIKCkS1RSsJfObAAwgI+ae/OI72L
nZUy3+QV2C7HMEc0OFr6C017SKccrxHvju/hAgoIOm4qrpjiy1w2M/QtbCeHDiCb
OhOcvObiDUIOYQuDjTS6
=mRrh
-----END PGP SIGNATURE-----

--bH8tHUgxmMM5nQn9EmjhtKfWxPJFb45NL--
