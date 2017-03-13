From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] serial: 8250_dw: Fix breakage when HAVE_CLK=n
Date: Mon, 13 Mar 2017 11:14:07 +0000
Message-ID: <20170313111407.GJ2878@jhogan-linux.le.imgtec.org>
References: <CAHp75Ved2h2WyWBokEOsDmAyB3w3iM=uh-9Bq01mU1ST4FapWQ@mail.gmail.com>
 <20170304130958.23655-1-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZG+WKzXzVby2T9Ro"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170304130958.23655-1-james.hogan@imgtec.com>
Sender: linux-clk-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jason Uy <jason.uy@broadcom.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Heiko Stuebner <heiko@sntech.de>, David Daney <david.daney@cavium.com>, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, linux-mips@linux-mips.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-serial@vger.kernel.org

--ZG+WKzXzVby2T9Ro
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sat, Mar 04, 2017 at 01:09:58PM +0000, James Hogan wrote:
> Commit 6a171b299379 ("serial: 8250_dw: Allow hardware flow control to be
> used") recently broke the 8250_dw driver on platforms which don't select
> HAVE_CLK, as dw8250_set_termios() gets confused by the behaviour of the
> fallback HAVE_CLK=3Dn clock API in linux/clk.h which pretends everything
> is fine but returns (valid) NULL clocks and 0 HZ clock rates.
>=20
> That 0 rate is written into the uartclk resulting in a crash at boot,
> e.g. on Cavium Octeon III based UTM-8 we get something like this:
>=20
> 1180000000800.serial: ttyS0 at MMIO 0x1180000000800 (irq =3D 41, base_bau=
d =3D 25000000) is a OCTEON
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 1 at drivers/tty/serial/serial_core.c:441 uart_get_b=
aud_rate+0xfc/0x1f0
> ...
> Call Trace:
> ...
> [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
> [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
> [<ffffffff8149c710>] uart_set_options+0xe8/0x190
> [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
> [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
> [<ffffffff811901a0>] register_console+0x1c8/0x418
> [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
> [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
> [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8
> ...
>=20
> The clock API is defined such that NULL is a valid clock handle so it
> wouldn't be right to check explicitly for NULL. Instead treat a
> clk_round_rate() return value of 0 as an error which prevents uartclk
> being overwritten.
>=20
> Fixes: 6a171b299379 ("serial: 8250_dw: Allow hardware flow control to be =
used")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jason Uy <jason.uy@broadcom.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: bcm-kernel-feedback-list@broadcom.com

Any chance we could have this patch in v4.11-rc3?

As Andy pointed out, it depends on Heiko's patch:
https://www.spinics.net/lists/linux-serial/msg25483.html

Thanks
James

--ZG+WKzXzVby2T9Ro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYxn7/AAoJEGwLaZPeOHZ6CPcQAKA1RF1u6dwNOewVEw/yq0Vy
5u0jHf3ilg/ulwoPzAfeBsXZDv3lRD7oPDE2juDHgxINHObBjeBwsw1yNbGDtAh1
aNoZBruIKy6D4wM8ZHvVGyqGDxfjcEDFNqh9FMjpiyGjAnqiMpxUlrkQ82+g3Qmg
3ydhB+X5Q7EVIORsbyG88Clzpc2q5+qzR7CAul/bR8yVD+OkJE6eVaI6HPoMpcgK
EFMgTLquauruLLkinGYgUY/S4FTDa3JC7RrpHyem0qvnHSbbJtt/JVr7ZVrAkiaz
IeNbkVqPBHUjssILyFyar+TGaTcUDloGh/3GSW/yNMQ+FzorU5+Bk18MOd+ik0XI
UKxp9ce2Xac44CkYLLQ4fc/xIHIBFeTFWBWWJDD57VPxpMS7v68dl23BqrN7Uim3
6zeyRXk66laxIkpf8CHNHSHRvU1KLzHIT8b+Yz9PcD3D3NGVtr2054spEMtld7xm
FTt5EcpHpOjAyyRRsboCrZVseJFQBwo5R8/1a4jH9cpmOq4B8tWoU+0oWOuVxUuq
ktlPm67M0kFyFJl8PAaqOpFzsMRI4GQLUqnV5+VY7/XqTNXLrAwwQcbygnDJqrdL
tPm43ujJr6fPWQ5rsaUcjjJ09seXm5pDET/fsMPOf9wwTZuUVzopzJfQJKXz+mCs
mJlqNI3fvp7sdK93Pamy
=2J3Q
-----END PGP SIGNATURE-----

--ZG+WKzXzVby2T9Ro--
