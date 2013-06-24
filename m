From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 03/10] pinctrl:st: Add pinctrl and pinconf support.
Date: Mon, 24 Jun 2013 15:12:57 +0100
Message-ID: <20130624141257.GM27646@sirena.org.uk>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com>
 <1371737138-9340-1-git-send-email-srinivas.kandagatla@st.com>
 <51C45816.5010207@st.com>
 <CACRpkdb-H2=GdF54Fay+PQVdXLTs++L5+QYe_vFPuzpa+E4ZMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SvPICi00/oKz9jF1"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdb-H2=GdF54Fay+PQVdXLTs++L5+QYe_vFPuzpa+E4ZMg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Stuart Menefy <stuart.menefy@st.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, kernel@stlinux.com, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Stephen Gallimore <stephen.gallimore@st.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org


--SvPICi00/oKz9jF1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2013 at 01:57:56PM +0200, Linus Walleij wrote:

> This seems fairly complete, but I cannot have such a basic dependency onto
> the regmap tree this late in the merge window, i.e. I'm not ready to pull
> all of regmap into the pinctrl tree. I'd consider this for merging
> for the next kernel cycle so it's more orthogonal.

I've got the patch on a topic branch in regmap to allow for this sort of
stuff - I can readily provide a signed tag for you to get just that
patch if that'd help?  Alternatively I'm happy to carry the pinctrl
patch in regmap?

--SvPICi00/oKz9jF1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyFPlAAoJELSic+t+oim9drkP/AvXwB+JkSkI5KOxPbYZLrAU
f6QwGGF7ASGbxukfntYf3ktBYexugj5MQMCo/uPYam8jTRJ85tCoSwFDyWAnHleh
8tEXp/7E0K6yEOUMlFjCvDQnQQctiBdKfTCy8/yI2BkvflVt2VzgJdGnck8PJ3ky
RxjkPXNMGoDAwE6ylPhWS+wO27ZzH1pj37bQdOaOUxIP9DIAKhPtP2nP9MSiU9Lh
0G1IwcmdrzCyUcwCTPEOzOcu0GlT7yHs6R0oDl5K/jR0z1WJOG+KOa+9zTOFJAk5
ogGhX/tju2ej+kaQRxckbsiBedbhDedGik99a66hQLv6xv5bg5vBJq9FKDPMqvdP
tUe1Xeua7BVvNop+TqfTvayVOPmoXRhe+Hz8qH0MgFQRy8kz1sD/HMfRTfRw9e39
Khj/JBfmbZ+IIv+n3nFGJjb1+QSonlmYNxhABgjwDsgCVqgBkcCW4rh4r/zVzVZB
jq2pFfchPnlASz1ZuzTIMnGS0cL3xGwnxMQKvAqe6rfWq+2uZPz1IhJSSwD7kAUJ
bOQOizb5wm//SmZbIJKANN6YQ5MuUX3vbQahHczlnPZe/v9M++cUzr4zEaENRtsk
WuiJqaS8+Vm5A7Gy9v8AmdT3saY7pqwCa1xBx58QQZUUDWV6eJIJ0m6zb9BMw6qR
B48zlMq6FmnjmYq1kmV1
=RT+C
-----END PGP SIGNATURE-----

--SvPICi00/oKz9jF1--
