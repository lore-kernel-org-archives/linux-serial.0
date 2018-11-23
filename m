From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Date: Fri, 23 Nov 2018 12:56:17 +0100
Message-ID: <20181123115617.GB31881@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
 <20181120152907.GA28796@ulmo> <20181121142740.GA29704@ulmo>
 <CABb+yY0nH3Su6a11TZLJf=CCpD+gTpqUkLnRhpy4MUwNJk5prw@mail.gmail.com>
 <20181122084712.GA5741@ulmo> <20181123111700.GA31881@ulmo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7688473310539915483=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181123111700.GA31881@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, mliljeberg@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com, linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org, ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--===============7688473310539915483==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 12:17:00PM +0100, Thierry Reding wrote:
> On Thu, Nov 22, 2018 at 09:47:12AM +0100, Thierry Reding wrote:
> [...]
> > Perhaps you'd be less concerned about such a change if it was perhaps
> > more explicit? Just throwing ideas around, I think something that could
> > also work is if we explicitly add a mbox_flush() function that would
> > basically be calling ->flush(). That way users of the mailbox can make
> > their requirement very explicit. I haven't actually tested that, but I
> > think it would work. Does that sound more acceptable to you?
>=20
> I tried implementing the explicit flushing on top of this series and it
> would look roughly like the below. What do you think?
>=20
> Thierry
>=20
> --->8---
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
[...]
> @@ -184,9 +185,6 @@ static int tegra_tcu_probe(struct platform_device *pd=
ev)
>  		return -ENOMEM;
> =20
>  	tcu->tx_client.dev =3D &pdev->dev;
> -	tcu->tx_client.tx_block =3D true;
> -	tcu->tx_client.tx_tout =3D 10000;
> -	tcu->rx_client.dev =3D &pdev->dev;

Somehow this line ended up being removed in the diff, but it's actually
required. Only tx_block and tx_tout should be removed in this hunk.

Thierry

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv36t8ACgkQ3SOs138+
s6E8ow/8Cap/d4F5/GkXfvoUcXHP0iD8f4o+DHQrCG4JD1giLjiwel5cPEsknocp
3cO9j2ZsqcwzZiQzEjxRUC2N1q+1hZNMnzWKqAFmrryqtaggS1fP9Nkn8JIfGfgk
GsJPzBdIzBuNuvhWKqx5t4Lr0LWgGNAjs4A67ICLeKIHe4Xm3QubfrNNRhFlV7pt
Ui/7DpZSvruq3EkQ1ZB41ltksRPyPpRf0sQlKol6PN1u78ptIpd3IDI6rGnO3B8s
oWFkiuArBtuOP6i6V+pduUP9g9sD0PpV/lm76jdSGzk4iEfK/tmtNcZfn3N0R1cD
yTPXw1uAs4vhM9GwD0YBWJ/jhsBgb86YdC/IOjzn0evv/Vwoh5jtQIcyIwa5IHUu
rF8p/ttWoLySc+rTEhBYg8YgRJTyj1iIPiahCe4HpiF/yVqBp5HL1ffIFQinxz+B
7GAy1P/hOt2OksjaP/kOM/N9aX0XYKzlS2VrfM9bUks69ZcjC2cce2mG0XEWhHeR
gRFOyxIhRzreXrsdCO/UoxB+0ntp5NihZTXxRaEVYLTQZATyRPsV1jDPA2pAynnB
/DNHEcwfoZUyeCq0UMLifWstLSVyoJfIIaOvan0vN1JKlXNkMtXvj+bS+LoXhMsH
pdmcSaIBFgYDI50mDCzKe+0tP+Q93Qe1gqhCu6yG1Lu7Tu+hvKw=
=zANt
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--


--===============7688473310539915483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7688473310539915483==--
