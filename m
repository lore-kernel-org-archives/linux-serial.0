From: James Hogan <james.hogan@mips.com>
Subject: Re: [PATCH 0/3] MIPS: AR7: assorted fixes
Date: Wed, 8 Nov 2017 22:03:22 +0000
Message-ID: <20171108220322.GO15260@jhogan-linux>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8CNmCRe8Sh4keFKJ"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20171029152721.6770-1-jonas.gorski@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Florian Fainelli <f.fainelli@gmail.com>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: linux-serial@vger.kernel.org

--8CNmCRe8Sh4keFKJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2017 at 04:27:18PM +0100, Jonas Gorski wrote:
> This patchset fixes a few issues found in AR7 that accumulated in the
> past few years. One was fixed for ages in OpenWrt/LEDE and never made
> it upstream, the others weren't noticed until now.
>=20
> Jonas Gorski (2):
>   MIPS: AR7: defer registration of GPIO
>   MIPS: AR7: ensure the port type's FCR value is used
>=20
> Oswald Buddenhagen (1):
>   MIPS: AR7: ensure that serial ports are properly set up

Thanks. Patches 1 + 2 applied for 4.14.

Cheers
James

--8CNmCRe8Sh4keFKJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloDfyIACgkQbAtpk944
dnpRvg/8DkL56Q6m1iZzJwFPkCJlh0eWskY1Mi6b3msAGViiB8YrP+wSxoscSv91
MDD0LNPEuu3azN5UCR1FAfSALPml3Mc7mU0+l4mBtpQcIonrQLIHb7p06qMWPLul
BU6/Lii9B+TBvTv+45W4IrwtRPX8Jik+FI1kjbO9HtugNgfTrIBNHZNiC9pM2MhM
E6ZGRd+RsD3/O+hTMrtu9PbD8j8LT0wZJseT8ythEup53sFG/XTEts+DfxEHnvoM
ueqPYG05R36ufDsotqOOGZI1EAREsc/33+qR8H6YOmPx4zAj1wIl+ILtM9Nm9WbJ
CeIaA9OwTUej8hayMhmfH5i7bRFgZt2Nx5RYjvL14sn9KGLAEZJDh3v+IXi7zSpe
hqOnlL69u7bpoFnET5LYm3sRUDGofL/5lg4hRVtcou8tOhdQgxsRhC9FHDC5aKwd
1xS9fI5orU5dEvmKbcjeyZtn0u+TfY5oZdqRUI2qtHMqMf6SanipO+zcZvNwDmcS
KTxrGKf2VIzvm9rLFH/VY/4vIgKhSMFF1JGljbIW/sPJ6Qr4PHdAxStfJY8KiIOa
P2gGxHRawOrLhAmfpXoWxqZ+eFhmn19KH6Cl9154zQORsc9DxYw75Pvh+kpnOGzB
c8NPvJp/0g4ZJvdKfMGGz8j+5LG5tv/QBotyw0lk+3Aj8mDCO6M=
=p972
-----END PGP SIGNATURE-----

--8CNmCRe8Sh4keFKJ--
