From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/1] serial: vt8500_serial: Convert to
 devm_ioremap_resource()
Date: Mon, 4 Mar 2013 10:16:07 +0100
Message-ID: <20130304091607.GI13335@avionic-0098.mockup.avionic-design.de>
References: <1362387279-31829-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61426 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab3CDJQT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Mar 2013 04:16:19 -0500
Content-Disposition: inline
In-Reply-To: <1362387279-31829-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-serial@vger.kernel.org, linux@prisktech.co.nz, gregkh@linuxfoundation.org


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2013 at 02:24:39PM +0530, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/tty/serial/vt8500_serial.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRNGZXAAoJEN0jrNd/PrOhScAP+wWiOIWYxx/0nwu7Bg4OcRkt
lzowU3q1kdBNo77waDLY2hWjVrmDWm5Zp9qzofdcJ0citkJV5aA/IVfaeZdOVuVR
eg/e0+yurbaYzpXt6LquTO4HlfmOf+KTEnF7vUwqvRXxEfw/NHcUZWHAlEEfLv1h
9WLUasmqwHf2F7NQ6HMi9yPI9LdP39AzdDcLuO8Wzz02EaYRN/YGBL6qxIEUDXqx
609VGM9MJQNSWRr+JyrPmJsoqidkfUIQ8fR1XnmauUFmuX/X6ioS1oH6/RWckcli
W5g+Jo+mzPQ64JPLb0nYdoajP68w5RrcBHuQBfqHeBIJOJ/e3X5G2mgwJt1WBiQL
j4CJPulMb7q+8fpa+XZUcemJEDMJ9VlbNLysb+vS4oYyOVnpuc7nEaAcY7hDAWI4
NRFcfn6IpzvgCDCyzKombXCF1ZT/zP5FYoi46tctdw/aQetvw2Is4AqnaYjNJ9jm
z3nByx+AFfSsZdtSvZ8A1oyoEF/ARlYh/vNnHln+vtUYTubXBXU85qj1PWkoSN/U
kXPkQn834fkghcyExuMi5+T3xKSJ7BeKi8TrVaeuWa5DrTMpKwfEnTqvmdzQqvKP
JZnhLL/Eme0ldZ1rhrm2AqD2VGJnQfn9Mu9XxTmJwloF0JZX5xpsP7PuMHuoSmUX
AaIyXT4FInqli4F2/oRf
=/TG/
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
