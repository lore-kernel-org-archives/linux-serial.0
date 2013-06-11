From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 03/11] regmap: Add regmap_field APIs
Date: Tue, 11 Jun 2013 11:48:41 +0100
Message-ID: <20130611104841.GX1403@sirena.org.uk>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856118-6503-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7961417050520950574=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370856118-6503-1-git-send-email-srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, Stephen Gallimore <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--===============7961417050520950574==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7WMexqIhC8AwFtpM"
Content-Disposition: inline


--7WMexqIhC8AwFtpM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2013 at 10:21:58AM +0100, Srinivas KANDAGATLA wrote:
> It is common to access regmap registers at bit level, using
> regmap_update_bits or regmap_read functions, however the end user has to
> take care of a mask or shifting. This becomes overhead when such use
> cases are high. Having a common function to do this is much convenient
> and less error prone.

So this looks basically good.  A couple of smallish nits below, if you
could respin I'll apply this on a branch so it can be pulled in as
dependency for the other things that use it.

> +	regmap_field_init(rm_field, regmap, reg_field);
> +
> +	return rm_field;
> +
> +}
> +EXPORT_SYMBOL_GPL(devm_regmap_field_alloc);
> +/**
> + * regmap_field_alloc(): Allocate and initialise a register field

Needs a blank line between the two functions.

> +#include <linux/device.h>
> +#include <linux/slab.h>

> +static inline void regmap_field_free(struct regmap_field *field)
> +{
> +	kfree(field);
> +}

> +static inline void devm_regmap_field_free(struct device *dev,
> +	struct regmap_field *field)
> +{
> +	devm_kfree(dev, field);
> +}

Probably not worth inlining these, just put them in the code.

--7WMexqIhC8AwFtpM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtwCGAAoJELSic+t+oim9juYQAJPLATgvMslyR8CbZBdkMYrr
5JHA77lEL/wOXbk+rdvqP6W82d12p/3UGgKIOvINb2bvadCQXmkJr1wdpwXx3cHO
cCqQ1aOt49hx7QS7i751s/f9k6kMQbdEYH8AjvG/CzlSZ8HM0bHPoIbDSpTWutPL
scAzrnEHVKGGC2XPgNF6fjCDiIfg9KtaLf+vnCIL7Yddlj6uEtcv+j2LaZsqy9CM
ZuITB3V21AJ7uKpQRFvU3jhp9lbsTfWAt0vYZqU8ysuoMmKhRbrEy4pFosV9aTAQ
JEW28Wn8qqZPVO57GFCuEc6HPN2+Rjr2ap2CVeoHNK7Spobwv9Q+JaRjm340eU1E
FVjshYADBVejTSz4zwwuU7T1dZaGxJ6P02NHF3Wi/cvWla7s2KOAf9tG6MZueufu
kMneeHgJpzSNnHgJQyXHElGUDwJi9GFkz+yfnsnBs9tTxxAKs9GJtUp59K/Lv4JH
g0vpUOyNAXD/wl/LrTgS7197KSaGM+xnQDh3LtNvFfqvVAp1+qLLAiAzblcDSmLc
q3RRSAJ+mRZAv7MlpQyJP9fSykRZMjYU65eTewo/gwW7gS+/JVd+v+H/nT15Eotv
bgY/pnRfEr+Sw1Wb3WOARQbnTAZM/ieua3Ira44nNJqsl12u/k2DE5XK6lVOquee
aTYlrj01KDxafDg7vfka
=BL7K
-----END PGP SIGNATURE-----

--7WMexqIhC8AwFtpM--

--===============7961417050520950574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7961417050520950574==--
