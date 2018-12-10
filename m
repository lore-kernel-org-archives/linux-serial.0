From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 05/10] mailbox: tegra-hsp: Add suspend/resume support
Date: Mon, 10 Dec 2018 10:58:16 +0100
Message-ID: <20181210095816.GB15154@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-6-thierry.reding@gmail.com>
 <9a7a55fa-9989-21cd-f981-f43d3b0f2d6c@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1418119014636887706=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <9a7a55fa-9989-21cd-f981-f43d3b0f2d6c@nvidia.com>
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


--===============1418119014636887706==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 11:17:58AM +0000, Jon Hunter wrote:
>=20
> On 12/11/2018 15:18, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Upon resuming from a system sleep state, the interrupts for all active
> > shared mailboxes need to be reenabled, otherwise they will not work.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/mailbox/tegra-hsp.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >=20
> > diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> > index 0100a974149b..1259abf3542f 100644
> > --- a/drivers/mailbox/tegra-hsp.c
> > +++ b/drivers/mailbox/tegra-hsp.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm.h>
> >  #include <linux/slab.h>
> > =20
> >  #include <dt-bindings/mailbox/tegra186-hsp.h>
> > @@ -817,6 +818,23 @@ static int tegra_hsp_remove(struct platform_device=
 *pdev)
> >  	return 0;
> >  }
> > =20
> > +static int tegra_hsp_resume(struct device *dev)
> > +{
> > +	struct tegra_hsp *hsp =3D dev_get_drvdata(dev);
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < hsp->num_sm; i++) {
> > +		struct tegra_hsp_mailbox *mb =3D &hsp->mailboxes[i];
> > +
> > +		if (mb->channel.chan->cl)
> > +			tegra_hsp_mailbox_startup(mb->channel.chan);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(tegra_hsp_pm_ops, NULL, tegra_hsp_resume);
>=20
> Is it worth disabling interrupts on suspend to avoid any in-flight
> interrupt triggering a bad access on entering suspend? I assume that the
> context of the mailbox registers get cleared/lost at some point and so I
> was not sure if there is a time where they have a bad state or are
> inaccessible?

Theoretically I think we'd have to do that. However, since we end up
having to busy-loop for any current use-cases (i.e. console) anyway,
we'll never end up in a situation where an interrupt could occur at
this point. The console will long have been suspended when we reach
this point. I'll take a look if a use-case can be constructed where
such an in-flight interrupt could be produced.

Thierry

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwOOLgACgkQ3SOs138+
s6GYsQ/9HvdB8fE3i/lxsreIZfMKBLSwsSeSeisY77tK4hAGA2C/rTAvWotc44xu
sQAzvPEGv0J6hTpPlxQRf6lwigofiPxai/u1XB8/WiUltpVKPAIMWyqKAonrO1xJ
dwJ9qP6Y9oEsDSjfcYgsjbWOpRU9AjzvUgTFihQFVCJdVb9+dt4JuJY4kJGRrijI
8dsfg/xhtw1C2jf+21XCTnxzkME6V2oRBCh1ttXE0ODGFVdz644TlzDD77ZiHv+t
ZUyEKf2RSk3yNf8spoh6PfWa6mJ6uLRsI/+SqhOpoITph8mlsVNOgdqSHj+Lqd39
cVFpxfghaCAIcnAwa2EFpDgMNcDAa0CphpUSqFczR3eiKeEnaw7vESAkqg7SayQ7
Wr13w2KE4Vhj/ZmRds1gx5WOsS6l2OK6zmwTCf3EEA8tFy67Bfot5eAbHcwKf6yv
SqOHfvvulhPhsmvfsAR1O1MCEIEeNK+DfqQvT5NclhvqAIbWuLgf1Ksh0j40ljxC
uXW3+KeHVFiHP+kSorKnueF7SGulsSwzmv1s79KgxCws7cvzDCw5QAGpOdeRJhSZ
9pvYY+ImjTYhxQoanpwjpxADUntz+B+1tGnAGjin7ADPrF1YJCC5uO+PvG5LGvNU
1XbaxnV6rxQdjJB/O0RhizItRckwoeFGpf/5Dgi3bKyzkzo40zU=
=34cK
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--


--===============1418119014636887706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1418119014636887706==--
