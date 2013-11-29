From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 24/31] serial: tegra: use reset framework
Date: Fri, 29 Nov 2013 15:49:38 +0100
Message-ID: <20131129144937.GE9712@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-25-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384548866-13141-25-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 01:54:19PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.
>=20
> Cc: treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
> Cc: pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
> Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
> ---
>  drivers/tty/serial/serial-tegra.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmKmBAAoJEN0jrNd/PrOhk/4P/32G6UZ27/AUArV8htZLaCTx
blQ/rkFOAecYFkg2k8wDFoRaPgawxRV+73fgpWQ1rFPHOHhOxyFUgvwWbtzhv5n+
kfeBF3sbacmHnh1MvysBB05e9Bf/4qgEgjF9zyXjedHK8fzwLl354p2i2JIq3kEe
K/xKteokIbhX0KuPmUsgsCyvfzS9qCE0NxWnsNlDz4r/ltNZEDvngWAcdrqqnfH+
RUxdC1sdzHdXVTkjlXG2dXra+9PvEj2xval2y+oNd8s27jOEUSuMEfjZ8s9Yck30
g6BenLkOs81wfStqki3NiY1vEVhtxeUGeKJCZBdoCsLl19TXCOJukqvLoBaM43cY
vaU/luVDl8cpXhI73OxbXer6aHX5Y9jLllX3PY4FSbeKK4Ksrnh0az7buo7Wt6zt
2ypwCb7v8yvutOWVTmOCLaQa1cC+ADM3QJM/mIVQvm57C3AsGo4DtkS7ZIuCMUf3
zX0UPFmxQssJJFeyPDg+8pYPdfYido5F4lNorPc5rtXtzb9IuW4d/eHnQd104cW7
9jL+neqwv/tHx+YleIQ2qqYvDmEHX+aoneUT0/ye7ljkDZTWSiMx39AE02KneMsM
eO2B8CE2A8huuQrTyfAc0emw/BOZGKcWszewIWUwL/SZaZT96c4J23JfYK9M6auQ
Uu53B83uwOEA6f+1AHsS
=Oju/
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
