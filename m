From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [PATCH] serial: exar: Fix stuck MSIs
Date: Mon, 24 Apr 2017 11:06:17 +0200
Message-ID: <d227c786-24eb-5acb-777d-02bd28d14254@web.de>
References: <39750541-c6a9-0e49-59fa-9f0a2e202850@web.de>
 <1493024379.24567.154.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cHsgV0Hh5rSIeUEJhQ8hIFhgchfeIq1Kw"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493024379.24567.154.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cHsgV0Hh5rSIeUEJhQ8hIFhgchfeIq1Kw
Content-Type: multipart/mixed; boundary="5UMidBpwS7AMKrkoiAkD82bGTnBeNU3GQ";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@web.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-serial@vger.kernel.org,
 Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Message-ID: <d227c786-24eb-5acb-777d-02bd28d14254@web.de>
Subject: Re: [PATCH] serial: exar: Fix stuck MSIs
References: <39750541-c6a9-0e49-59fa-9f0a2e202850@web.de>
 <1493024379.24567.154.camel@linux.intel.com>
In-Reply-To: <1493024379.24567.154.camel@linux.intel.com>

--5UMidBpwS7AMKrkoiAkD82bGTnBeNU3GQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-04-24 10:59, Andy Shevchenko wrote:
> On Sat, 2017-04-22 at 11:36 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> After migrating 8250_exar to MSI in 172c33cb61da, we can get stuck
>> without further interrupts because of the special wake-up event these
>> chips send. They are only cleared by reading INT0. As we fail to do so=

>> during startup and shutdown, we can leave the interrupt line asserted,=

>> which is fatal with edge-triggered MSIs.
>>
>> Add the required reading of INT0 to startup and shutdown. Also account=

>> for the fact that a pending wake-up interrupt means we have to return
>> 1
>> from exar_handle_irq.
>>
>> An alternative approach would have been disabling the wake-up
>> interrupt.
>> Unfortunately, this feature (REGB[17] =3D 1) is not available on the
>> XR17D15X.
>>
>> Fixes: 172c33cb61da ("serial: exar: Enable MSI support")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Regression of upcoming 4.11.
>>
>>  drivers/tty/serial/8250/8250_port.c | 19 ++++++++++---------
>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c
>> b/drivers/tty/serial/8250/8250_port.c
>> index 6119516ef5fc..3a3667880fcf 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -47,6 +47,7 @@
>>  /*
>>   * These are definitions for the Exar XR17V35X and XR17(C|D)15X
>>   */
>> +#define UART_EXAR_INT0		0x80
>>  #define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
>>  #define UART_EXAR_DVID		0x8d	/* Device
>> identification */
>> =20
>> @@ -1869,17 +1870,13 @@ static int
>> serial8250_default_handle_irq(struct uart_port *port)
>>  static int exar_handle_irq(struct uart_port *port)
>>  {
>>  	unsigned int iir =3D serial_port_in(port, UART_IIR);
>> -	int ret;
>> +	int ret =3D 0;
>> =20
>> -	ret =3D serial8250_handle_irq(port, iir);
>> +	if (((port->type =3D=3D PORT_XR17V35X) || (port->type =3D=3D
>> PORT_XR17D15X)) &&
>> +	    serial_port_in(port, UART_EXAR_INT0) !=3D 0)
>> +		ret =3D 1;
>> =20
>> -	if ((port->type =3D=3D PORT_XR17V35X) ||
>> -	   (port->type =3D=3D PORT_XR17D15X)) {
>=20
>> -		serial_port_in(port, 0x80);
>> -		serial_port_in(port, 0x81);
>> -		serial_port_in(port, 0x82);
>> -		serial_port_in(port, 0x83);
>=20
> You replaced 4 reads by one. I'm suspecting that on multi-port cards yo=
u
> still need to read all of them (I assume they are called INT0, INT1,
> ...). Perhaps you need a helper where you do that and call it from all
> necessary places.

Nope, we never had to read them all: "Wake-up Indicator is cleared by
reading the INT0 register." (Exar manual) INT0 contains the interrupt
status for all channels.

Jan

>=20
>> -	}
>> +	ret |=3D serial8250_handle_irq(port, iir);
>> =20
>>  	return ret;
>>  }
>> @@ -2177,6 +2174,8 @@ int serial8250_do_startup(struct uart_port
>> *port)
>>  	serial_port_in(port, UART_RX);
>>  	serial_port_in(port, UART_IIR);
>>  	serial_port_in(port, UART_MSR);
>> +	if ((port->type =3D=3D PORT_XR17V35X) || (port->type =3D=3D
>> PORT_XR17D15X))
>> +		serial_port_in(port, UART_EXAR_INT0);
>> =20
>>  	/*
>>  	 * At this point, there's no way the LSR could still be 0xff;
>> @@ -2335,6 +2334,8 @@ int serial8250_do_startup(struct uart_port
>> *port)
>>  	serial_port_in(port, UART_RX);
>>  	serial_port_in(port, UART_IIR);
>>  	serial_port_in(port, UART_MSR);
>> +	if ((port->type =3D=3D PORT_XR17V35X) || (port->type =3D=3D
>> PORT_XR17D15X))
>> +		serial_port_in(port, UART_EXAR_INT0);
>>  	up->lsr_saved_flags =3D 0;
>>  	up->msr_saved_flags =3D 0;
>> =20
>=20



--5UMidBpwS7AMKrkoiAkD82bGTnBeNU3GQ--

--cHsgV0Hh5rSIeUEJhQ8hIFhgchfeIq1Kw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlj9wA0ACgkQitSsb3rl5xQ/fACg0Gfp+9Q1bMrXlcRUOKJAFX1b
AX8AoL8X565gDfdOgumwLHLFCN4H7SNb
=EBZb
-----END PGP SIGNATURE-----

--cHsgV0Hh5rSIeUEJhQ8hIFhgchfeIq1Kw--
