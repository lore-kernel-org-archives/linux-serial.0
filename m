From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
Date: Thu, 9 May 2013 10:51:43 +0100
Message-ID: <20130509095143.GB7478@sirena.org.uk>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
 <20130508150141.GA5057@opensource.wolfsonmicro.com>
 <518A8E6C.6070907@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0730921491666076171=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <518A8E6C.6070907-qxv4g6HH51o@public.gmane.org>
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
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--===============0730921491666076171==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="67nA0I2t09EExhkH"
Content-Disposition: inline


--67nA0I2t09EExhkH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2013 at 06:42:04PM +0100, Srinivas KANDAGATLA wrote:

Fix your mailer to word wrap within paragraphs.

> Ultimately the syscon_write use the regmap_update_bits, however we
> really want is the flexibility in using/referring the syscon
> registers/bits in both device-trees and non-device tree cases.

So what you're looking for here is some way to offload discovery of
register fields from the driver?

> The reason for these APIs, is the extent of syscon usage is very high
> in ST set-top-box parts.

> Without these new APIs, its very difficult to pass this information to
> the drivers.

I'm not 100% convinced that putting all this information into DT is a
good idea, and to the extent that it is sensible it feels like something
which might be useful with any device using register maps, not just
syscon.  For example many MFDs have similar needs - essentially the
system controllers are just a particular kind of MFD.  To me that says
that this should be outside syscon so other things can use it.

--67nA0I2t09EExhkH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRi3GrAAoJELSic+t+oim9IWoQAJHvNeQZZXveXmlB1koA35Uf
gPsYkfgFvkD/EaS9Rr7OO3kd5RfavgeoOQu7CMrn5k4Cm4AXHDBW15YI6ZgBacvU
mP34x1IJh93o2AUtspBxWAGebGO+KahFKv+t5kag9mvfVjXE1QUnLQbOucWYBr/S
059Z5+WO8sPbcpuRAIfr3qYFwqrztYz6LcBmOK0XOpkgp/0to9W5wvUzG6xFgywz
YWCZfjh+vn7FUFR2U8mifUp48SHrKUqEu1EFDTG0u69yk5olnwSD1C71ga4LADau
O+N0/p6MtJe9V9r9/kxHTJYRfZqvB927ta8awZqCpCsuhepi1Tfihx0KcvefvJKU
2RL+LJhChs0jVwHCAmaFcE5D4xyT3EGrTiPWn+AaKrg17aHaz2qonQJTtpDuUBPC
K40ebQMzxlbXDh/1R71ZxPP3R+Kd5DdWKzG5SILYak0qTEVlcHiUpFhv/UIhsw4E
D8qQuxcELQkNMHAa6B3nuXCDUgYMNpot4cJiXLvKZbeRjZ4tLSnrzen4skkDZt7e
HMUf39XiYm2gfrPbcMb1GY1vrNUHrbMfpbkArvbRVa6l5tbh9Q972uk8Q0G2fQjb
r3dgXUGkooco4d5ruQVopj9m5bxTlQy3nG2U/SvEYC6NffkZHs42LLDrw+wzcCGZ
w6FS6DNQPrxLMbvrQT5I
=vpYd
-----END PGP SIGNATURE-----

--67nA0I2t09EExhkH--

--===============0730921491666076171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0730921491666076171==--
