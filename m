From: James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH RFC 3/3] MIPS: AR7: ensure the port type's FCR value is
 used
Date: Mon, 22 Jan 2018 13:07:19 +0000
Message-ID: <20180122130718.GA22211@saruman>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
 <20171029152721.6770-4-jonas.gorski@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171029152721.6770-4-jonas.gorski@gmail.com>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Florian Fainelli <f.fainelli@gmail.com>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: linux-serial@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi stable maintainers,

On Sun, Oct 29, 2017 at 04:27:21PM +0100, Jonas Gorski wrote:
> Since commit aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt
> trigger I/F of FIFO buffers"), the port's default FCR value isn't used
> in serial8250_do_set_termios anymore, but copied over once in
> serial8250_config_port and then modified as needed.
>=20
> Unfortunately, serial8250_config_port will never be called if the port
> is shared between kernel and userspace, and the port's flag doesn't have
> UPF_BOOT_AUTOCONF, which would trigger a serial8250_config_port as well.
>=20
> This causes garbled output from userspace:
>=20
> [    5.220000] random: procd urandom read with 49 bits of entropy availab=
le
> ers
>    [kee
>=20
> Fix this by forcing it to be configured on boot, resulting in the
> expected output:
>=20
> [    5.250000] random: procd urandom read with 50 bits of entropy availab=
le
> Press the [f] key and hit [enter] to enter failsafe mode
> Press the [1], [2], [3] or [4] key and hit [enter] to select the debug le=
vel
>=20
> Fixes: aef9a7bd9b67 ("serial/uart/8250: Add tunable RX interrupt trigger =
I/F of FIFO buffers")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Please can this patch be applied to stable branches 3.17+. It is now
merged into mainline as commit 0a5191efe06b ("MIPS: AR7: ensure the port
type's FCR value is used").

Commit b084116f8587 ("MIPS: AR7: Ensure that serial ports are properly
set up") is a prerequisite for it to apply cleanly, but is already
tagged for stable.

Thanks
James

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpl4f8ACgkQbAtpk944
dnpopQ//fY1n/30G72tl0a4aiEmfOANG49EYl9su7I0f7LAd77ueYqkrSNjI0OXK
O8UpbAksKoCse3NJrTGw47GWa8o60QxII0kVnGNBNGg15i0ZA3wlxCIttvo7DTFK
DohUknAn4bgBvzH+aASGORh5BD/f/qJGaAcSe7H9HP6OStz1XICDJ5vG8bTbmdcv
Ya0/ZXu7PxymJTT6L1ybNEC/7U4IvJhMxD8uT+hKCFdEnEv4rrhZFdL8/L53cEJG
2oGjmVRkLvVNpvzCFL4YZ3GmNR1pPNd7Nu9deO4p0DP7v6/B4aW3moVNk1qAbjGC
RKN6C3Udb83dCwyuc793DgTDvfuJdGprN/87/x6JDqA0BpDubHpJ3H3B3+/ncI23
G8cXXsWxjePwNnwtleX1hr5GVwecLgeiUVia7GII0xx+CyisnScpAFQ/dxghJ16m
n1G6FfzT/ASR3wNyjV8iWa12ItMeMn7VuCal+FSpoQ32YiphOLkMZXI7DIXIIE1M
zHmQzgZj/Z31iY31BkwbI6HUfOVM4OUrnHodLDhYrk090la5QatqdOtnmUQkLqwI
G+GuYBLvHOCv81hspHwfeUYWG9439JgYdGXMweixTDNJwqtvzG8GQMPLwEHK4NQF
u2oiTHVCrviy8XhKbG7xSI7Yjhh9KOmF6ibZxjzwV1+Nq34iqnc=
=xJlN
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
