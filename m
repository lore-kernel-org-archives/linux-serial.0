From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 7/9] serial: Add Tegra Combined UART driver
Date: Mon, 12 Nov 2018 16:30:14 +0100
Message-ID: <20181112153014.GA29481@ulmo>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
 <20181026111638.10759-8-thierry.reding@gmail.com>
 <20181109170526.GB14151@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181109170526.GB14151@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Jiri Slaby <jslaby@suse.com>, Mikko Perttunen <mperttunen@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>, Mika Liljeberg <mliljeberg@nvidia.com>, linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2018 at 09:05:26AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Oct 26, 2018 at 01:16:36PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
> > multiplexing multiple "virtual UARTs" into a single hardware serial
> > port. The TCU is the primary serial port on Tegra194 devices.
> >=20
> > Add a TCU driver utilizing the mailbox framework, as the used mailboxes
> > are part of Tegra HSP blocks that are already controlled by the Tegra
> > HSP mailbox driver.
> >=20
> > Based on work by  Mikko Perttunen <mperttunen@nvidia.com>.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks. I just sent out v2 addressing Pekka's comments on the series.
But I'm slightly confused now. Are you expecting anyone else to pick
this up? There are technically no build time dependencies between any
of these patches, so it should be fine to pick them all into the
corresponding subsystem trees.

Perhaps the only thing to note is that there is a runtime dependency
=66rom this patch on patches 1 and 2 in the series. Patch 1 is required to
make blocking a mailbox possible in interrupt context, which we need in
the TCU driver because the TTY and console paths do end up calling the
mbox_send_message() from interrupt context. Patch 2 is only required at
runtime if the two mailboxes are provided by different instances of the
HSP block (which they are for TCU on Tegra194).

Would you prefer for Jassi to pick up the TCU patch along with the
mailbox core and driver changes so that we deal with the runtime
dependencies that way?

Alternatively, if Jassi is okay with the mailbox changes, I can pick up
all of the v2 series of the patches into stable branches for v4.21, deal
with the dependencies there and send out pull requests for everyone to
merge into their subsystem trees.

Thierry

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvpnIIACgkQ3SOs138+
s6G9thAAmhwMCREJAWW3pWq4rGnjyHIlRwal0f3ryO2kKoJUU6pMMjIpyhyL7HDg
UE9ytBcLqT8UtijC79Ur9pT8Zg8iocoLhK2CUlkt+swYWiKgCTYY04U7th/rsiEP
Eqqxw8W6Ev8mmWnbtZxEnANPGye1O+QyWKNr/enMynt4oFKmXhoPopJE9X+jdDrm
BPkTsfB+iDpurl6az6dpbkiJoTfnDH/KslT0O2B8b3glX84NPouZd9d/uX2GSD6C
9u9AXoAtm2I13zVTHrwYXdAbJW+R3fgN52QX5ugaygrM+15dkOgomREfeRTZLQyu
1Sgc6GEMr0Jj+cB7MnJuVrduVZBemGP6w4NGo0A6vAIG4J2rqM1XGfWXAaeN3iv2
8aQfedqyWlmByrPw+CSwxdBQYfKPkxgEt5aCRXPv3qfock+ycHy/jUp+po3Y+0Nu
A5Abh1x1WzUJBIL8tMd6wAh7sm5ndxRBFJjdIWXXuGKHYv1H7URD0RNooE1B+vEK
itDzAx5ZS+JCbqkhsrTxtNqxhgalaprdEtHj2JbB1VY9w/RdoORyz9jQ49b7BENB
flX3750cp1p364hSncwBIsAw6Z3Hk87iLZh5PcHGOHCgowU7izEEMS3gbVSfDgPc
kWRr0GaixLog3OXxriCFU/HurHGBcQNb7YiQbuxNUMum3dRR6oQ=
=SwJi
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
