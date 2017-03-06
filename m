From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] serial: 8250_dw: Fix breakage when HAVE_CLK=n
Date: Mon, 6 Mar 2017 10:16:04 +0000
Message-ID: <20170306101603.GW996@jhogan-linux.le.imgtec.org>
References: <CAHp75Ved2h2WyWBokEOsDmAyB3w3iM=uh-9Bq01mU1ST4FapWQ@mail.gmail.com>
 <20170304130958.23655-1-james.hogan@imgtec.com>
 <CAHp75Vc=VmxvkqjP7nY6K4CKXBJC-NND0CUMbzwjV2nmQ-5OTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6h64vBu9tReNbGLX"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vc=VmxvkqjP7nY6K4CKXBJC-NND0CUMbzwjV2nmQ-5OTw@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jason Uy <jason.uy@broadcom.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Heiko Stuebner <heiko@sntech.de>, David Daney <david.daney@cavium.com>, Russell King <linux@armlinux.org.uk>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-clk@vger.kernel.org, linux-mips@linux-mips.org, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
List-Id: linux-serial@vger.kernel.org

--6h64vBu9tReNbGLX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 04, 2017 at 04:37:17PM +0200, Andy Shevchenko wrote:
> On Sat, Mar 4, 2017 at 3:09 PM, James Hogan <james.hogan@imgtec.com> wrot=
e:
> > Commit 6a171b299379 ("serial: 8250_dw: Allow hardware flow control to be
> > used") recently broke the 8250_dw driver on platforms which don't select
> > HAVE_CLK, as dw8250_set_termios() gets confused by the behaviour of the
> > fallback HAVE_CLK=3Dn clock API in linux/clk.h which pretends everything
> > is fine but returns (valid) NULL clocks and 0 HZ clock rates.
> >
> > That 0 rate is written into the uartclk resulting in a crash at boot,
> > e.g. on Cavium Octeon III based UTM-8 we get something like this:
> >
> > 1180000000800.serial: ttyS0 at MMIO 0x1180000000800 (irq =3D 41, base_b=
aud =3D 25000000) is a OCTEON
> > ------------[ cut here ]------------
> > WARNING: CPU: 2 PID: 1 at drivers/tty/serial/serial_core.c:441 uart_get=
_baud_rate+0xfc/0x1f0
> > ...
> > Call Trace:
> > ...
> > [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
> > [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
> > [<ffffffff8149c710>] uart_set_options+0xe8/0x190
> > [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
> > [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
> > [<ffffffff811901a0>] register_console+0x1c8/0x418
> > [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
> > [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
> > [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8
> > ...
> >
> > The clock API is defined such that NULL is a valid clock handle so it
> > wouldn't be right to check explicitly for NULL. Instead treat a
> > clk_round_rate() return value of 0 as an error which prevents uartclk
> > being overwritten.
> >
>=20
> You forgot to add that it is dependent to Heiko's patch
> http://www.spinics.net/lists/linux-serial/msg25314.html

Indeed I did. Sorry about that.

>=20
> Patch looks good to me and shouldn't bring any regression to Intel
> hardware (x86 is using clock framework).
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks
James

--6h64vBu9tReNbGLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYvTbQAAoJEGwLaZPeOHZ6PR0P/Ri3CSMyjhXUgiu1LIRrGyyp
QZIEbmylYFH5egbu1IFmK7J0+h8hT0PikUDtcEGxsVVXqS8EL7CkIuoo1IMJcVeV
Zsbb2B/qxiezbjwyFOjucyE7ilxxu37fmsDBKMOUoZFvTrfc9HMfHKZBIEAGlNc3
93pEEdv9f6gKk8B8wGLLuRDkCdTxyQv3RoCp6TNo7X+qJMnmYpk/RRTPBFd/aUft
s/ziHb5WIJWTiY4bwVBI2Atr51inx61IU8uUDJahAJClFYOhMb2OgOfaO1jofPBP
c14bDcbDUlvGisfvBOLxMB2/MTO4mtRrksEQ7TlqA4NacRncR6yjjndmfgbKvuU1
IlamLaknN667/7Aefb5OuiLdArRH+Wy0+DTlAXEnQYG1jKYPg3h5xYiR1ynUFmux
CaJFa0zwjf6O2cIt8qlJpzObfs7E6i3jUkXxiqLJjfyOrL8intPFgf9ckYQIadNG
IpGk1V9gJwe99EjpQNndI8GApYSDHuehffA2Hzjvc7IRCl5eiC3m/AD2mMYp82h9
300ufzUcZYu0nnHLh0bM30CohxNp3gA5GP75n5JnvIflid7+EB5gFGPohhCiUMqw
/i8fWPQXIYxNG9Q1tfRSM7oDQ4qDpBp4Ri4VPdloIzioqg7HFKr/STcCfbaWca0I
zWohi2YkPlD6NQ3Abe8H
=ebpd
-----END PGP SIGNATURE-----

--6h64vBu9tReNbGLX--
