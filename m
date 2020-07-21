Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C74C433EB
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 17:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2F9207DD
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 17:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="oZ3BrUtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbgGURmg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbgGURmf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 13:42:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79566C0619DA
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 10:42:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so12280507pgm.2
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=E4KZgwVTI5aMyqyLhFG3oLM6lp0QMlQ+v/7xrQ4lxDs=;
        b=oZ3BrUtmP+vLY3N3slRcKIuQ7yd0ZvpzWXZDGA+txT2uXl3KtRkQlZPRYpMbmi0nDm
         gnT49lqnyjoTGBDP4UE1OYnWpllTkB0baayRG9MWBNY0yCXj6rJJuhW6pUtw47yJuh7a
         jpRAvlP4Lb45W2/c/Ltk/q1+fTOpnqu+UbhjpVaH64FNUgsKqQPvKT1KpQSsOabJTKz2
         89puFcMefNK36uviukBAAf2brQGgMcj2NvPx84gCPJZqt+afp6j5JNdzBylBzMe15xNq
         fM2tN2jRjr6WMGttsZTUQMQfz3XBcBzAr+Jq3AHnLJQp2IpCOPIAECew14TlNXeDoqor
         h80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=E4KZgwVTI5aMyqyLhFG3oLM6lp0QMlQ+v/7xrQ4lxDs=;
        b=fyvMXV7tznxlAPTWBxLyOlogtlnZUj15Z3h5Rr5v/iRqaTVLQ7n6cdDeHgeEE1TR5J
         +O+LgqeHbHCea9kU/bBL7UWFJD0n2aVlsJasIpAaYirJ/CYVivrhpLaE0tkRs3NBNCp9
         sCSL3EBK0KKyKk9LAEJjCTrKdDfDz9ZRAagTsLAtoS159XBus/FYGiJ12rSdfBx5G6oz
         xyVH2qxA5j6lRtLsd/NM3rER5HvPyR8RjlTw1oxu5s9kYQkaQ0r87FeBPn1/bdaRmOXE
         uHrhHmm4rCz6Jr+kgXnEBL3ukwkwMxEE8/d60UqkRQBWGBva0Il/8JQoDmMS+Z4vekY9
         4uiQ==
X-Gm-Message-State: AOAM531c9rPi50hHQ+3EOOzDZXmPkOtgryhIyU8aW1we2jjgBb36fkSl
        7upJ8umdvamCQmINCT81Z2W8uw==
X-Google-Smtp-Source: ABdhPJyx0AqwTp4Ow6VK7fzRhEUxTwYv15VH55g7hiaH9UyQhijrz82/lwbSAZsX7VvxpESMScUMvQ==
X-Received: by 2002:a63:5b05:: with SMTP id p5mr23096072pgb.143.1595353355016;
        Tue, 21 Jul 2020 10:42:35 -0700 (PDT)
Received: from localhost ([2406:7400:73:d7b6:d055:3e56:d1e4:ce99])
        by smtp.gmail.com with ESMTPSA id q14sm18238201pgk.86.2020.07.21.10.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 10:42:33 -0700 (PDT)
Date:   Tue, 21 Jul 2020 23:12:29 +0530
From:   B K Karthik <bkkarthik@pesu.pes.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>,
        "bhuvanchandra.dv@toradex.com" <bhuvanchandra.dv@toradex.com>
Subject: [PATCH v2] tty: serial: fsl_lpuart.c: prevent a bad shift operation
Message-ID: <20200721174228.misj2mgqzcfz2lsj@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kx56zhcajbwqldfb"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--kx56zhcajbwqldfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

prevent a bad shift operation by verifying that
the argument to fls is non zero.

Reported-by: "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
---
v1 -> v2:
	added Reported-by tag

 drivers/tty/serial/fsl_lpuart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 7ca642249224..0cc64279cd2d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1168,7 +1168,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_p=
ort *sport)
 	 * 10ms at any baud rate.
 	 */
 	sport->rx_dma_rng_buf_len =3D (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
-	sport->rx_dma_rng_buf_len =3D (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
+	if (sport->rx_dma_rng_buf_len !=3D 0)
+		sport->rx_dma_rng_buf_len =3D (1 << (fls(sport->rx_dma_rng_buf_len) - 1)=
);
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len =3D 16;
=20
--=20
2.20.1


--kx56zhcajbwqldfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEIF+jd5Z5uS7xKTfpQZdt+T1HgiEFAl8XKQQACgkQQZdt+T1H
giFRLwv/dorzPs5nBpoVYe3F6rKkcsPcUgftu5wmWsXMH7qtEsdOHt8bJ5Wsmfht
BCtAyys8u14LXfoKvk5pDCq1JKJpnqSV6gNV8Mn5VYdnYAuIRJkGDj8nZjNvPLSf
iQvHeyRa3rDCbSYb/eAtlPnLUwdYn+/tUYPyCQHECv/2NS6/skACNWfHftb3brdk
Hhqad3BP6Og7w3T9f5eJnpQoE0tSEdP6R/wEcNXjG3SLrH/3RSI5uWW5aYOxMESy
RikMQ9cFZMuuzjPaCAGn5n94mVUlw6qvtCXYq+Jxo9xVoHbR9wwBTg0B26Lj3/zY
pemiPjMKcjnyHUjwFFVLVG9JkXWFM/QfmhFJZWL+AAAv6U2lFfo/TEocuAbEoMC5
UVxHWP1SbPw3frLwHZkwni8qr+Yyko+9zlwuyc8Tsc09PtXr9nWXQYF65yBgi2ZO
ijZSU7go9xPFJ14+4UBvfPdPx7bKkzO/GFUu3M2ijP6geBk+6bS4EabnWMH/EiYa
qFeQEn7D
=RgO/
-----END PGP SIGNATURE-----

--kx56zhcajbwqldfb--
