From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
Date: Wed, 8 May 2013 16:01:41 +0100
Message-ID: <20130508150141.GA5057@opensource.wolfsonmicro.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201305081650.23264.arnd@arndb.de>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, dong.aisheng@linaro.org, sameo@linux.intel.com, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Stuart Menefy <stuart.menefy@st.com>, Shawn Guo <shawn.guo@linaro.org>, Olof Johansson <olof@lixom.net>, Jason Cooper <jason@lakedaemon.net>, Stephen Warren <swarren@nvidia.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Dave Martin <dave.martin@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2013 at 04:50:22PM +0200, Arnd Bergmann wrote:

> > In many cases a single syconf register contains bits related to multiple
> > devices, and therefore it need to be shared across multiple drivers at
> > bit level. The same IP block can have different syscon mappings on
> > different SOCs.

> My feeling is that syscon is the wrong place for this functionality,
> since regmap already handles (some of?) these issues. If you need
> additional synchronization, it's probably best to extend regmap
> as needed so other code besides syscon can take advantage of that
> as well.

This sounds like regmap_update_bits() ought to be all that's needed.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRimjBAAoJELSic+t+oim9JfgP/05p2QINT4gcE3xlw0POhT+t
ooCGqpfqk+GX9+3iH8YqnuEqrYp5oy6k3vhNF2IG3mvvIfQyqMEqe3HzEKqsfmDz
skR3HKrZA43R0D+Mn1tWM6q36vC6Ylgf5YsigpvCIjDK7J3iNi23hmhiHpwtRILj
Bgh3gzYS/JA+Xrl6ZMZ0ZnVPTRS5PMhPU8wNMlVJRd0MVxl52vdhbl2cAIFHs3NA
bYOXs90Tpq0PyGQ59q4Y1GR0njyCuUon2Gw9C/HlYRIFmvcQoeXpqjKYySTgk+3o
2UB8tS1Sec9Gwg3MZCcvVamP9Cy7EPMXi9ftU2Ct+UYmJQs4vf9STDiSLKBMX/Cn
wJgweJmHzksT+iYczffIiPC8SSiFnAxHKg0kcNPvpDbPithowWhbc2hqP28XzMFL
o3ACBrl1GXzS6BOkaOgeNI2CvFqffKyShdr1fn/tMaSDlY04S0iB/YFGAi/yCZ+f
y5kSy2vOj71tjc/LrV44ihFiwkjeespp9lPF5ItsmMfM55c4Wsh1RvghUVtyXmyf
XCU+76xc6e6KHudmsxYVrUdhqjwQMHZc8OfrWS6u/Nt1Y6X6xxob0vBk8EO7DvpX
AViDm+ksWz0OiSTooPq3n1f1Jf2Tj6iTUIzbnS0NuNx8yrayzRFZp8JdxsG7AhvG
7pZYm9YXNFPP/Vapr6ZS
=oPWe
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
