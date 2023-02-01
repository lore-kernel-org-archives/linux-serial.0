Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D836CC636D3
	for <linux-serial@archiver.kernel.org>; Wed,  1 Feb 2023 02:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBACpC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Jan 2023 21:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBACpB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Jan 2023 21:45:01 -0500
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B390EAF;
        Tue, 31 Jan 2023 18:45:00 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id 61C342F2022B; Wed,  1 Feb 2023 02:44:59 +0000 (UTC)
Received: from localhost (broadband-188-32-10-232.ip.moscow.rt.ru [188.32.10.232])
        by air.basealt.ru (Postfix) with ESMTPSA id 8C6B22F20227;
        Wed,  1 Feb 2023 02:44:57 +0000 (UTC)
Date:   Wed, 1 Feb 2023 05:44:57 +0300
From:   "Alexey V. Vissarionov" <gremlin@altlinux.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH v2] serial: samsung: fix buffer size for clk_name
Message-ID: <20230201024457.GD446@altlinux.org>
References: <20230116141658.GC8107@altlinux.org>
 <Y8lZNi9pYVFkYvh9@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <Y8lZNi9pYVFkYvh9@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

serial: samsung: fix buffer size for clk_name

Although very unlikely, the 'clk_num' value may be as big as
2**32 - 1 (uint32_max), so the buffer should have enough
space for storing "clk_uart_baud4294967295\0".
Also, the numbers in clk_name are expected to be unsigned.

Found by ALT Linux Team (altlinux.org) and Linux Verification
Center (linuxtesting.org) using SVACE.

Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>
Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")

---

On 2023-01-19 15:52:38 +0100, Greg Kroah-Hartman wrote:

 >> Fixes: 5f5a7a5578c58852 ("serial: samsung: switch to clkdev
 >> based clock lookup")
 > Please fix your scripts to use the proper number of SHA1 digits
 > in a Fixes: line as the documentation asks for.

Done. Also added the comment to the source regarding the buffer size.


diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_=
tty.c
index 0fce856434dafd80..2c701dc7c6a37191 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1407,7 +1407,7 @@ static void s3c24xx_serial_pm(struct uart_port *port,=
 unsigned int level,
  *
  */
=20
-#define MAX_CLK_NAME_LENGTH 15
+#define MAX_CLK_NAME_LENGTH 24		/* "clk_uart_baud4294967295\0" */
=20
 static inline int s3c24xx_serial_getsource(struct uart_port *port)
 {
@@ -1457,7 +1457,7 @@ static unsigned int s3c24xx_serial_getclk(struct s3c2=
4xx_uart_port *ourport,
 			!(ourport->cfg->clk_sel & (1 << cnt)))
 			continue;
=20
-		sprintf(clkname, "clk_uart_baud%d", cnt);
+		sprintf(clkname, "clk_uart_baud%u", cnt);
 		clk =3D clk_get(ourport->port.dev, clkname);
 		if (IS_ERR(clk))
 			continue;
@@ -1957,7 +1957,7 @@ static int s3c24xx_serial_enable_baudclk(struct s3c24=
xx_uart_port *ourport)
 		if (!(clk_sel & (1 << clk_num)))
 			continue;
=20
-		sprintf(clk_name, "clk_uart_baud%d", clk_num);
+		sprintf(clk_name, "clk_uart_baud%u", clk_num);
 		clk =3D clk_get(dev, clk_name);
 		if (IS_ERR(clk))
 			continue;
@@ -2522,7 +2522,7 @@ s3c24xx_serial_get_options(struct uart_port *port, in=
t *baud,
 		/* now calculate the baud rate */
=20
 		clk_sel =3D s3c24xx_serial_getsource(port);
-		sprintf(clk_name, "clk_uart_baud%d", clk_sel);
+		sprintf(clk_name, "clk_uart_baud%u", clk_sel);
=20
 		clk =3D clk_get(port->dev, clk_name);
 		if (!IS_ERR(clk))


--=20
Alexey V. Vissarionov
gremlin =F0=F2=E9 altlinux =F4=FE=EB org; +vii-cmiii-ccxxix-lxxix-xlii
GPG: 0D92F19E1C0DC36E27F61A29CD17E2B43D879005 @ hkp://keys.gnupg.net

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJj2dIpAAoJEFv2F9znRj5KU4AQAJvU1W+saE+0cNg53LGU0MmJ
7+PqoS3fqV8VPmXLbNIwPijOAz4n0KwJJLmYiefF1irhPQ1V2sZ6+j6GbvPRl4UG
78reDDY1mp3sAMGzFoeoVI3mcPzCiVr4yvs03BSq2Y3dX9HdEZspmO87DpO+L56A
s+Rke3F41eh21luK+5H8TvhPnbFKjZhtsb9dTHCV5zyfQg+EGeCW99IjPW8rcyvL
3xN4d2+ZsxKzgWX/cR6cY+XsxrE/lGVvl5z6+qLUfXZnRbXeckTfgQT6F4MGMFxd
rGZkJ1vfc/9SCXXd1vVl0HWJDhQ1bLVX6FRuqaSizg6ET+jbbksNXP9yt4+VJXUG
HJh0GrbzCKMYYq3r3Crsr1f68NJ0Z8NTKEp9bO2/QHtnOXi9V6Tl08EjtRPrF/v5
I3QY6BIHjeS9QqXcIYwmJFBxLn9vZgnZEBC1kGkOy9OwfniHBt5mEmo5T+p6pcZ9
Wxvq7jAUEfzmuIE2h4CTw7nxP8Zb1GPCQh217j8pWx608QOv4yb3WeqAdhmND/R4
8gT9E4mpKqQ1TdswW6ha1IHCEmjpgzL4PhUoBizNnoXCyZOUC0DKDKrxPCoj2qCt
W0ks13V+0j0Xo30CrtJ59CmtbXgBIAAgn63PskyQYgpwmsKmoyAdSmfIq6wZfl6F
8W8j4ddNGWLu2vLk1Sul
=31x7
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
