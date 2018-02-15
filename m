From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] serial: sh-sci: prevent lockup on full TTY buffers
Date: Thu, 15 Feb 2018 14:12:37 +0100
Message-ID: <20180215131237.4yi42wq4duic7uaq@katana>
References: <1518696147-23790-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2yddoec54ffcayat"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1518696147-23790-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, geert@linux-m68k.org, yoshihiro.shimoda.uh@renesas.com
List-Id: linux-serial@vger.kernel.org


--2yddoec54ffcayat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This can be prevented by doing a dummy read of the RX data register.

Just so I understand the issue correctly: We are reading the register to
throw the content away to prevent it being used in the TTY buffers?


--2yddoec54ffcayat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqFh0QACgkQFA3kzBSg
KbbKBQ/9FxFI+YMHsIhQbAo2Iqn0Yt+GMl4husICOOQwMRzRTSVaQmkAIZZLNHo1
2A6Gk3HwBSNAZbOQ7GWqjJnkB9/3xbpealYhTeSjlQTZb4O5r3MhAN7KECHeO7Pi
tzy3TPBnc/qOkVfDIvyi7Y0godRuV+93KMPpH9khvCZ6BYtXOFoafSpTkxOL00zC
W7uwFfQnOqCoekAq/L3ZwyR57wA+LbMD963dIhtWSPoDhHJ5x1646vOuDWwb+vqF
eRSrQEUYI/vJgsdKeaqVMeyaKWWg1E3cUmkm1Tx+BF0eYAjv9h/OKP5XN+xq8Jvq
9Xo4ODeSHvjRkItoz+/ovVNRhVSdQMccc0hX6vxrJBf11Hy70I5sS8xQxuZ5LeLU
s1C94aALp71D/XSRrq1gIc4lxJ/aQan3dM/G6Q3ldg85k772d4GMXBQc8vqwPXwe
qTQ1W1BC3QlGOp9LZ4REBvEOtosU8vuT2IuFBg3TzB1+/8MHbdpqoddLcQaITXmm
Vy815MPUCLZQiYDt0r76eSDM4b0ryp73RUowHSdC0pVmtpC14PVJSZKmaSfQb8pY
l76e0dp9WKVpE8CN7ayVPx54yveLjMNHwa0VVpVFZHu3iRglzwaCN0KH5PRcdlgp
r8ZSv2p8kY5F2HODInz3s+57N96yUdnVms4qTV2VmLNywf9QpWw=
=Cv23
-----END PGP SIGNATURE-----

--2yddoec54ffcayat--
