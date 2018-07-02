From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 0/8] Tegra Combined UART driver
Date: Mon, 2 Jul 2018 16:17:28 +0200
Message-ID: <20180702141728.GP13096@ulmo>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702140343.GO13096@ulmo> <20180702140742.GA7977@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2037835502130023140=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180702140742.GA7977@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org, jonathanh@nvidia.com, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============2037835502130023140==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mejza3ZMMA5Za1mX"
Content-Disposition: inline


--mejza3ZMMA5Za1mX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 04:07:42PM +0200, Greg KH wrote:
> On Mon, Jul 02, 2018 at 04:03:43PM +0200, Thierry Reding wrote:
> > On Mon, Jul 02, 2018 at 02:40:25PM +0300, Mikko Perttunen wrote:
> > > Hi, here's v3. Changes are in individual patches. Acks are still
> > > missing from the following patches:
> > >=20
> > > mailbox: Add transmit done by blocking option
> > > mailbox: tegra-hsp: Refactor in preparation of mailboxes
> > > mailbox: tegra-hsp: Add support for shared mailboxes
> > > serial: Add Tegra Combined UART driver
> >=20
> > There don't seem to be any build-time dependencies between the above, so
> > technically I guess these could be applied to the respective trees
> > separately. The only thing we need to be careful about is to not merge
> > the final patch before the others, because it will break serial console
> > if the other patches aren't applied.
> >=20
> > Jassi, Greg,
> >=20
> > What I could do to resolve the runtime dependency is pull the mailbox
> > patches into a separate branch, create another separate branch for the
> > TCU driver that is based on the mailbox branch and then base the DT
> > changes on that branch, or possibly send a separate pull request for
> > just the DT change late in the merge window or shortly after v4.19-rc1.
> >=20
> > Obviously the latter would be equivalent to you guys merging the patches
> > through your trees for v4.19-rc1 and me sending out a late pull request
> > for the DT bits.
>=20
> No need for me to take the serial driver if these types of dependancies
> are required, you are free to take that in your tree if you want to.
>=20
> does that help?

It does if Jassi's okay if I take the mailbox drivers into the Tegra
tree as well. I'll wait for Jassi to comment and then we can decide what
to do.

Thanks,
Thierry

--mejza3ZMMA5Za1mX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6M/UACgkQ3SOs138+
s6EhnxAAwI9fH8fSx7Du3Z5PMU2jY3cko+JNZUpPiRjiRvvKX6wdCvNW8WVq/9qR
mbQshoHuNPY+BskYBBwECl8cJLDfF0LGOLkCZlQX6THET/L//Fm+LAWP+4u79G0k
f9H+rOduaFfbT4FimYn1BMe/bs0+dl1OdWTwXrB1oHLxjs1Vgyclh1HELlzs2Vbo
olLJlP8DEMCHlALWjPhYRAw7GWdmzV1LTIZ9z973LWJWsxe27dH3AVd71rJ5pFAP
UM2E+8Kuf7vwW8XldsFZzeutJdeqDBqB8DQovutlOhQrQ1/ll76eT2B1lkUSqD/6
xgWw2l5JzDs5pRc0S4xo5HYPMQnD+CLreQ2Sdc9O45p74hpVCjMqFftE5hH8Jx6a
GhaE7grXnRs6Z0BoFYwQHR7EiCNjsxiOiK0p5R16hJeipSCFGUPkyXgibmUJ7zL1
Lcg2JcSF9OF9PQr/Zv4vSf2D1mtI5D2kCRip/6Sf96FhhkEahDqr2EZHLwgFOvS/
1ZWYF2xCqQ3cfjnSvWbdOdbM91wqZR9+6ot86giDclNSAqHdPb61csWcLM5usdnX
zxCWIyvdItud6JgQnoox7+aUxv1GZh6Q6oSYs87dXXGMRiXsW/EBpa8c5hHFB97W
jre7HKlzAAUdG/k4V0aShM7HCwXwpZC92mh6VrNvg9LR5d498OE=
=oIKU
-----END PGP SIGNATURE-----

--mejza3ZMMA5Za1mX--


--===============2037835502130023140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2037835502130023140==--
