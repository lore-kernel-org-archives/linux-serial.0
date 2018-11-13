From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: serial: Add bindings for
 nvidia,tegra194-tcu
Date: Tue, 13 Nov 2018 11:03:55 +0100
Message-ID: <20181113100355.GA15642@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-7-thierry.reding@gmail.com>
 <f7d19f6e-0dcd-753c-a407-fcec4fa1474b@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0263439412098821479=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f7d19f6e-0dcd-753c-a407-fcec4fa1474b@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jassi Brar <jassisinghbrar@gmail.com>, Mika Liljeberg <mliljeberg@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Timo Alho <talho@nvidia.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-tegra@vger.kernel.org, Pekka Pessi <ppessi@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============0263439412098821479==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 09:39:08AM +0000, Jon Hunter wrote:
>=20
> On 12/11/2018 15:18, Thierry Reding wrote:
> > From: Mikko Perttunen <mperttunen@nvidia.com>
> >=20
> > Add bindings for the Tegra Combined UART device used to talk to the
> > UART console on Tegra194 systems.
> >=20
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Jon Hunter <jonathanh@nvidia.com>
> > Acked-by: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../bindings/serial/nvidia,tegra194-tcu.txt   | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/nvidia,teg=
ra194-tcu.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-t=
cu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> > new file mode 100644
> > index 000000000000..085a8591accd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
> > @@ -0,0 +1,35 @@
> > +NVIDIA Tegra Combined UART (TCU)
> > +
> > +The TCU is a system for sharing a hardware UART instance among multiple
> > +systems within the Tegra SoC. It is implemented through a mailbox-
> > +based protocol where each "virtual UART" has a pair of mailboxes, one
> > +for transmitting and one for receiving, that is used to communicate
> > +with the hardware implementing the TCU.
> > +
> > +Required properties:
> > +- name : Should be tcu
> > +- compatible
> > +    Array of strings
> > +    One of:
> > +    - "nvidia,tegra194-tcu"
> > +- mbox-names:
> > +    "rx" - Mailbox for receiving data from hardware UART
> > +    "tx" - Mailbox for transmitting data to hardware UART
> > +- mboxes: Mailboxes corresponding to the mbox-names.
>=20
> Looks like there is some trailing white-space in the above line and git
> warns after applying this patch.

I'm not seeing it. I remember seeing that trailing space in an earlier
version of this patch and fixing it up. Did you perhaps end up applying
the wrong version?

Thierry

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvqoYYACgkQ3SOs138+
s6HinA//RCbYotsZykkHSETpQ0vxALAy3maWLAEaUmDFgYT8c/ZYtqn4Ak8Prn/b
r8sltNU9JX67zXJMaQzMsR1Ahtxy/WwD9dlujTwwY7qEs/Z7dHUhcTHQ3yxzgRAb
W60FcRS0gJIMY5F+fnxricT5SLNZJTk72m99It1wfze0al2PvJfU4UbBzqIjjVXC
thFeBqmOaWIMrugTRhdDAZGOqwzl0796YvT+HGPiLtW8+dheRV9dUd5ceR0mhjv/
tWaZQxHAzPzb7haQXbKuW5YG3Q94Q/VwzxcZtbWwsk2QLn/FiqMB5Ek6ym2/p0qy
tdvz+64xVgEp+VETjE+aJdgw5nY9HcgDdqTPvUQ9G6AlJDI4QqUE7xzfCjyCpzuS
YBUd2c61T0v8JuHqZUuaVCIsHu0DfBw36OHKesvdQk2eNrmdKpWODFZwQc1LaIa8
1u9J5IM+QcDTHIuTm9qk5ZcXNE206Cd7bKBCmjdn3YP8HQpZbHxWfu5Qs9zsBmSD
/f4pCmaCJdNBWBadK6Jvvtt+R0Y1OKz2i5xQOJMNlfBWeP5d2sUejf7LJpZszmom
CKaNIn1xXLE1c05k88FjdM40o3yljr1KYvjK7XMmlyUQ3kokgrw8GZCIATLh0pmb
04Ax1o0TiplOgVEkD2LlL39N/dnwqhFp+DHzzGpF9F4FzbGXk10=
=K2yk
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--


--===============0263439412098821479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0263439412098821479==--
