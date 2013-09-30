From: Michal Simek <monstr@monstr.eu>
Subject: Re: [RFC PATCH] tty: serial: uartlite: Extend time for sending chars
 through mdm IP
Date: Mon, 30 Sep 2013 16:28:02 +0200
Message-ID: <52498A72.3080609@monstr.eu>
References: <fec1c418d7d8933a9729ea1926c76e404f8c3020.1380541829.git.michal.simek@xilinx.com> <20130930125433.GC13654@kroah.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3VSqGIBaPvACEMRJih3rENpQa8Nlkecd8"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:47347 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245Ab3I3O2H (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Sep 2013 10:28:07 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so2688093eaj.26
        for <linux-serial@vger.kernel.org>; Mon, 30 Sep 2013 07:28:05 -0700 (PDT)
In-Reply-To: <20130930125433.GC13654@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, arnd@arndb.de, Peter Korsgaard <jacmet@sunsite.dk>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Jiri Slaby <jslaby@suse.cz>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3VSqGIBaPvACEMRJih3rENpQa8Nlkecd8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/30/2013 02:54 PM, Greg Kroah-Hartman wrote:
> On Mon, Sep 30, 2013 at 01:50:35PM +0200, Michal Simek wrote:
>> From: Michal Simek <monstr@monstr.eu>
>>
>> Serial over jtag via mdm is compatible with uartlite driver
>> just need to extend time for reading chars because connection
>> is slow.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>  drivers/tty/serial/uartlite.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartli=
te.c
>> index 5f90ef2..f55c342 100644
>> --- a/drivers/tty/serial/uartlite.c
>> +++ b/drivers/tty/serial/uartlite.c
>> @@ -422,7 +422,7 @@ static void ulite_console_wait_tx(struct uart_port=
 *port)
>>  	u8 val;
>>
>>  	/* Spin waiting for TX fifo to have space available */
>> -	for (i =3D 0; i < 100000; i++) {
>> +	for (i =3D 0; i < 10000000; i++) {
>>  		val =3D uart_in32(ULITE_STATUS, port);
>>  		if ((val & ULITE_STATUS_TXFULL) =3D=3D 0)
>>  			break;
>=20
> Ick, what happens next year when we get a faster cpu?

I will start to celebrate because 150MHz is not enough. :-)

> Please make this a time delay, not a 'loop till we can count to this
> number', so we know exactly what is going on here.

But seriously, I will look at this change and will try to find out
the slowest and the fastest hw to test this.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--3VSqGIBaPvACEMRJih3rENpQa8Nlkecd8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJJinIACgkQykllyylKDCGJEgCeJ11Vd+VTxA1RjiYQlCKZyx3m
hjAAn00ki9aYF+q/QpzMaKsocWKlGIef
=FkeQ
-----END PGP SIGNATURE-----

--3VSqGIBaPvACEMRJih3rENpQa8Nlkecd8--
