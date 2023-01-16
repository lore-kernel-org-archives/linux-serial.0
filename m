Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12185C63797
	for <linux-serial@archiver.kernel.org>; Mon, 16 Jan 2023 14:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjAPOji (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Jan 2023 09:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjAPOjR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Jan 2023 09:39:17 -0500
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6B45AB74;
        Mon, 16 Jan 2023 06:17:40 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id 351C02F20230; Mon, 16 Jan 2023 14:17:00 +0000 (UTC)
Received: from localhost (broadband-188-32-10-232.ip.moscow.rt.ru [188.32.10.232])
        by air.basealt.ru (Postfix) with ESMTPSA id 9612F2F2022E;
        Mon, 16 Jan 2023 14:16:58 +0000 (UTC)
Date:   Mon, 16 Jan 2023 17:16:58 +0300
From:   "Alexey V. Vissarionov" <gremlin@altlinux.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Abraham <thomas.abraham@linaro.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        lvc-project@linuxtesting.org, gremlin@altlinux.org
Subject: [PATCH] serial: samsung: fix buffer size for clk_name
Message-ID: <20230116141658.GC8107@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Although very unlikely, the 'clk_num' value may be as big as
2**32 - 1 (uint32_max), so the buffer should have enough
space for storing "clk_uart_baud4294967295\0".
Also, the numbers in clk_name are expected to be unsigned.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5f5a7a5578c58852 ("serial: samsung: switch to clkdev based clock loo=
kup")
Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>

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

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJjxVxaAAoJEFv2F9znRj5K0MsP/1QGXpm/Axd8kWH2EW7QmnUo
q8LW8ox4wZMJCgzT0dObphT3N7IK9ElbtgauBsn6bYeBy4gB/QHv850tpoysVVb2
QQ/Lr2hxWmuYd9s5/FAyJEHKwLGQWIJw/A2aR3Cz+Cq8FgB5rL0FJQAkMPrJ8bhk
/A4zn7fqJ+hzNxiTA5GI4bGWeIrMNCLP4ASAjjZFz8FfJpPv3S9c3xRTnDnTi4cc
W7+56nK3Ee1Ag6F+rPWtMYLUBuBZlK6lORR/t1+tgtlUk4n45lnjMllLq2lNMLj5
BV0uLGfioPyvu5tK4GIr3bXqi30Fg18teCYTd/bL34fzwZ0tirOnVQGePlg8YEjg
O4Lm/YW0EvEiCK41RDUAJeMtrvhuoyBhfEt6KoA9L2NzORTjOmDGc8x57U755Ghi
+4VNGAPUm6RENMuL95ckR6c3ip2XP6TL+49dmzMGme1TxeI/CfteSXmTYiwOF1/E
885S7KKiuMcmc+Ve1XLoQnJICDY9MFx4TJzcrgCNazTzxvBWs36kvgbVQe6MCkiR
MjGRXPbqF9fPKOagZuXKsJYLIXVzsYiio3Q7DYahA893V7DvGHqSEnEwN+rDQlR2
LaGQ7YauHx5CkdR3s1XhftBEdxrJHy5E7cbVAk4d9r6PjSOi5yWuBnEbILvoqNni
w9bv2xruDpeq4td4y7vt
=18iO
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
