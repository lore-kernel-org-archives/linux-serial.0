Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF583C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 17:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4A22065D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 17:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="UVkWJ6lS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgGUROV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgGUROT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 13:14:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EED2C061794
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 10:14:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x72so11043950pfc.6
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Pf9387P6pQdIdEtt81PR6nfU9ZoFkF+G5kNWohKHeqo=;
        b=UVkWJ6lS4iOeLNd8CBsIehrgJ94bCAMS6q7pQ46939s2553llSYJyO5E6HDitxAeX4
         qfEuxj70/BEtHyHrTTWLsn4DsR8C8pVGXrkDZRux0j59Sy4NqRXpL+4Z1CWXcRGJVV6y
         kKKJ7AfnpX1EpnFbC83wv78jdiEdP9Mr++Vji9pWRRDDoWN9t93AJuLO1lILyPEoXOAc
         N0rph+BKWwaCPdfrdB/czzgQJVvSxxpJi+5Ya9rkiA7pnjvpQhPzV7bzWm3JorR8HGRI
         3xrkyyqCrUUrKqG7EKvUePPJugeUey8c2ia1Vk+szG/2l+kd8vOfgPxWV9yEULZFnW3C
         9rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Pf9387P6pQdIdEtt81PR6nfU9ZoFkF+G5kNWohKHeqo=;
        b=NM83tAMf8FPMZ11uaA93bR5BI6wWavE1SCQpQ2J0ZPOjOSbM7GsvzIVwqYV6kchnwl
         Eg5IyQtks4kFYVBBM3BSD7jDY/sSHft84GiYAIGSBrxfbIEcBcbcoI0dKvEVtzHScQWD
         t8qxJNHif0KXzkz4rM0hn2xkYOcytCJYidBEz75urXeMYptOOGNbCEuM/3yfjYBfacHO
         qf7P3jorLQKhI/BlStAfQIvCMiidl8hby8Mb6T53QzGqAk2j984TX+AFYz0RvNAsv+Bt
         60x/ahYlG5ryf6Efdr1jY45Zs/Y9tm44RQX4ih6oHPgx3Kn92Wr1anCFQzHtUDv3sKnv
         g0dw==
X-Gm-Message-State: AOAM530OYA77JX8pSiKurAIcGiVOSKl/qNlq73Pwm1MfRAobV+ZLfzPf
        tokKqXsh1VY90FbQqNQffIenbA==
X-Google-Smtp-Source: ABdhPJx+igMiGHQSrnF0vS4TSQeTCbzR3biiWzZ7JbPKt7DqbIPWTGkovOoFDaoP9+T7ibJjtcpg3w==
X-Received: by 2002:a63:7f5d:: with SMTP id p29mr23273143pgn.259.1595351658706;
        Tue, 21 Jul 2020 10:14:18 -0700 (PDT)
Received: from localhost ([2406:7400:73:d7b6:d055:3e56:d1e4:ce99])
        by smtp.gmail.com with ESMTPSA id z25sm20953188pfg.140.2020.07.21.10.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:14:17 -0700 (PDT)
Date:   Tue, 21 Jul 2020 22:44:12 +0530
From:   B K Karthik <bkkarthik@pesu.pes.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tty: serial: fsl_lpuart.c: fix a parentheses coding
 style issue
Message-ID: <20200721171412.xfpzswsrjn7savco@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a6njxhymkk2m2bqq"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--a6njxhymkk2m2bqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

add parentheses to expression to improve
code readability.

Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 0cc64279cd2d..3108f5ab57fa 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1167,7 +1167,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_p=
ort *sport)
 	 * Calculate length of one DMA buffer size to keep latency below
 	 * 10ms at any baud rate.
 	 */
-	sport->rx_dma_rng_buf_len =3D (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
+	sport->rx_dma_rng_buf_len =3D (((DMA_RX_TIMEOUT * baud) / bits) / 1000) *=
 2;
 	if (sport->rx_dma_rng_buf_len !=3D 0)
 		sport->rx_dma_rng_buf_len =3D (1 << (fls(sport->rx_dma_rng_buf_len) - 1)=
);
 	if (sport->rx_dma_rng_buf_len < 16)
--=20
2.20.1


--a6njxhymkk2m2bqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEIF+jd5Z5uS7xKTfpQZdt+T1HgiEFAl8XImQACgkQQZdt+T1H
giERlQv/S2icA1m53XUpMbtlbFJcZrJOA4QwY8aR5B7zHmpZglXUk4JXNwTQGCme
aGRKGFGVeD3oGpYRK+wF0LjfuXQQwZ9DZ00z6mf7uAf3a5CQp/pGGOAUdOkEKnfY
TZX9FbREERoiF7bMuVyH2yDu7kCbsXPRzRMqpeQorIHOTFoQqX1WUa+e3GgVdlWc
lvcGQeGHLlzCEZcQTktr6zlQlGeyeRw37VyOc24Bq9mgbBaZnk4Mxo/R8YxGrRrF
5kH7Xu2mxrQ/eUuX9O44xr5MBgMMlbHixclzAxUfGb9wZai/LPrJPi2ZbbgTbB2G
WlpJJ/PH7e19W43IxiF497l738xGOag2yFe4R7lMfHJW2GkVW3L/Fn23XUQYAKuq
bqohITqc0sD/gs3ALeKPrk9Jx1Fj20rD7x/tGJV79IYB80cBiTT8U0dh8KcIZk4a
bMMILiwpydGQ7o5nBX2NVNtmS7UFdfgYfIYZe+MnaIe9NpnGt7wz9zF6pfcsCzeD
ViqUR9gu
=01qZ
-----END PGP SIGNATURE-----

--a6njxhymkk2m2bqq--
