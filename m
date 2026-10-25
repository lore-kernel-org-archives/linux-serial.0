Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792893817;
	b=fF9aG5xmNJPvLaK4+SiRscfUzH4494s1si37foMFEb4TYlRUyk4g53Byo1KsSMAhlDAN
	 VqhRltNX1h9Z4FtpXkL80Wc2rPtaSq35HP1Qw0x0KBD3HOx/olzQlQdSSALc459/rkYdY
	 Bcc279ih/81MC/+QigXEyORvHZNX3IjIvxTcnc2GDenbt10vNGyfbfBGmXeOwqVdmNeh1
	 RR4ie93fqN8rdaZY8V/eLsLHXdgg6NjdT0PQpeu1YCruh0VrMU6P4TcfZudmsn0U7p1Rq
	 JXLLOGmvy/E/SAXvsho1ytd6/mYQ3P16HX7lm/YrSgEZf+qC623rJGkrh1P234CXVNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792893817;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=o5OJ4oy2J+hfRd2KpSbnpHV5mlGk05MxAQLLAb5RJaU=;
	b=i5fb/OMVF+YeKveX6w4cbqIQwgJ2pqA1rXDfq0G4Jep0ac81Oso+jUPLoY3ybBnZbey+
	 RJr+2N2d2aZZDLosrCW1b8BBAOoh8G6Kdh5cC9gdc34qoazChCex95SRcIEAacD5OeD5E
	 aTVwYf4wLI2T/3t1u4Zz14hlJGE2cI0cTEWIhQK2wrNYUrC8h97hSv7iVmoV3gPvw6LEA
	 bhzal+f22RWQliqbHyWBOmRtkL0DT/O+P3RDJxOBsvSUrI5A3gAv1wFLoIKEwWbUIkOoN
	 qWowVNMVrUq0+dQp/fB2Ie8C0eIQJs5Hvs6iB/nNYHDM5Gt4lkWuS0Qh0ModpWug2UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=PB3Qefui;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854C60A2608
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3854C60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=PB3Qefui
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6CE0A3F342
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792893815;
	bh=o5OJ4oy2J+hfRd2KpSbnpHV5mlGk05MxAQLLAb5RJaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=PB3Qefui9E2TLRLt05hN4KZRjlBMsBsbiKro7dxl6dfWVihYZE1iZRP4CaQpZmhqX
	 9Clg2B4znwtufKN4epjtygXiR6CUv+PWYB358hY76En0mwfOmv09XH3B1evvENF4Kl
	 E8hg9j3w08vao8kBqVQSp0+15hDnPTd+D+z2CjeguqzaiPH7Bkf+6kOD/eKHr2hoGC
	 yL2377G+yhfKA+d+ln2aKcj7x1h7eFPGhG+yqyfqhru8Xe4McksBDmCITkAY0x1e3x
	 4D9AmvlcDLWoLTpoOwPgzndCsYoTKzlpGv0IinuWWLSDhiwbOyiU6B8UQLZCybYpnu
	 8AAKimuY+y5UGNkHmWBgEQ+BztSAIuIMwyRlFGlm3J9Wv3qiOmS01Wl1IsrEVUfLc2
	 8GeATKMKY6eU3DxlnmeuVo5GJ3fY5KAPIzddH1uEtWUWEYKJTx/ZhDAZ4PAJY+fFaV
	 Tth0KYYbkZdZq06RdvaEgJJ3kLq3LBFMAPVq/6vSmI0bFpBW52o2QdcD67eBVK+ijW
	 Sudv4AcsjJfTXh5XKHAvKqg6b+xaQvKHfBD2UKCN0Y2yu263wz2RCTM6Z/D/faepDS
	 3GBKelJl7f+qZVJd7etlA4DdpXGSDRV+c9aV1VusCb59FVKbX/WdG/DmEkUE3r+HNJ
	 pU5qOvSYQrrWWtKlhzd3kjGY=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab27c28489so689462a91.1
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 19:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792893814; x=1793498614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o5OJ4oy2J+hfRd2KpSbnpHV5mlGk05MxAQLLAb5RJaU=;
        b=XVFYh2yNYRv9S0Ruo/7Ml77OY+M7tRZyqJJLT62P9CzXXh6x1LpyPhqyziZjVHuG8Q
         KeuybOAUBRc+fuo3Xi2wV4e13KAiDF7yCDql5h+Sa671sogkT/tJ6ssSXzJJ2fziUumi
         rDODFMgvMHyoAtTMKmGg8Oe1I1RXCjLHIieyt3x64luyqx+bWktQ+bId17KhZy6bjhdT
         DKsZg5xBNkOcegpvE3MEkjbGcwKJ/fEKgZGZoyVjubvykTMv2prPmB5plCVs6BxBfgdI
         9Y2FmubEygurOdhuhk9plShL5oZU84bcgGotCTABxVkYzTLIjlUH/wa2sNrR+vvu0uB+
         Uukg==
X-Gm-Message-State: AFq9FYILgYSJf+5f2wEmTwbYu2vRW8XDg6YBeIdZlOkzwLHbc7PNFmr8
	PthccoLoweIQGF/kUwpmeGkdAIGYpIbTV9c6Keno6BxGhUd7y/Es+uq+UsOkr4R57NGEnuV9pqs
	pWUjJQYkatJu6Dam/rMihpHfnKnlqpCVAKCOIgv0j5tB8kiclJCMFa+OnS3sA+0JuOOqCcRd0EE
	sEsaxlGBdleyjUhg==
X-Gm-Gg: AYBFou1+ECgGfLoD0/psGOI9BoWVF+HNniFDgu9Xja2ti7Rp9gc/GOXRg8dHbK71lzs
	yZTJrYqGGL6ZDLFG8q7wizOQM2MNhSmKJ98n+pNWdm7ofLgNZoByGTCx1Rs4Yw4CqoK0MfkAkvO
	GVECZJIJ7L/C0dNUfuRNqKzHTyAP/85u47wMPgtK3sc5UyWqIzScxb7s/Lm53Vlm3ZPhvKUeQ0J
	cV0hJpOSrYOksLoivvpHRucrbtunORGO/U2BiR+TANJMS9DdSC6oFPi8xpRs6quUCoz666M70cy
	lm4aSDwoY1WOcyb6vbLt4BVrBPO56pmhrc5eLoRGRX7BP5hBPFqkDRGfBFx0mXyZk38tKIuuGkd
	afBxKsM47J+3P7iUxBy6lbEhP/n98PZnf0ZNn9kvRy/K2FQUX0u4W0QrSycfhZeEWIi5P/obwis
	HnaupdH71lFAAx7IqG62oc3g+g7TLkdACHNpaRwSVWmMVRj2KCCkVz5SNtUVJlfUdCVoHfBcFRR
	76lBRtmEgo1mJdautMXLOHQrINjsj+B2z/39IR5CA==
X-Received: by 2002:a17:90b:1809:b0:3a0:c162:51af with SMTP id 98e67ed59e1d1-3ade9481ef8mr4927456a91.0.1792893813910;
        Sat, 24 Oct 2026 19:03:33 -0700 (PDT)
X-Received: by 2002:a17:90b:1809:b0:3a0:c162:51af with SMTP id 98e67ed59e1d1-3ade9481ef8mr4927434a91.0.1792893813535;
        Sat, 24 Oct 2026 19:03:33 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-0e25-4b6d-1924-440d.dynamic-ip6.hinet.net. [2001:b011:2008:445c:e25:4b6d:1924:440d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebacbf5fsm4226044a91.6.2026.10.24.19.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:03:33 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: linux-serial@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	markus.probst@posteo.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com
Subject: [PATCH v6 2/3] platform/x86: dell-uart-backlight: Bind through normal serdev matching
Date: Sun, 25 Oct 2026 10:03:16 +0800
Message-Id: <50556466ff036ece9b73f7088deaece5faf4e59b.1792856688.git.an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792856688.git.an.wu@canonical.com>
References: <cover.1792856688.git.an.wu@canonical.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver creates a serdev client without firmware metadata and
force-attaches its driver to it.

Pass the modalias to serdev_device_add() and give the serdev driver a
matching id_table, so that the serdev core binds the two through normal
matching, then drop the manual attachment.

The client now also reports a "serial:dell_uart_backlight" modalias to
userspace instead of failing with -ENODEV. A failing serdev probe no
longer propagates out of the platform probe; as for any other bus, the
client is simply left unbound.

Signed-off-by: ChunAn Wu <an.wu@canonical.com>
Reviewed-by: Markus Probst <markus.probst@posteo.de>
---
 .../platform/x86/dell/dell-uart-backlight.c    | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index f076cfac2bc5..9b8ef91bb0a2 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -325,11 +325,17 @@ static int dell_uart_bl_serdev_probe(struct serdev_device *serdev)
 	return PTR_ERR_OR_ZERO(dell_bl->bl);
 }
 
+static const struct serdev_device_id dell_uart_bl_serdev_id[] = {
+	{ KBUILD_MODNAME },
+	{ }
+};
+
 static struct serdev_device_driver dell_uart_bl_serdev_driver = {
 	.probe = dell_uart_bl_serdev_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
 	},
+	.id_table = dell_uart_bl_serdev_id,
 };
 
 static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
@@ -354,7 +360,7 @@ static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
 	if (!serdev)
 		return -ENOMEM;
 
-	ret = serdev_device_add(serdev, NULL);
+	ret = serdev_device_add(serdev, KBUILD_MODNAME);
 	if (ret) {
 		dev_err(&pdev->dev, "error %d adding serdev\n", ret);
 		serdev_device_put(serdev);
@@ -365,20 +371,10 @@ static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_remove_serdev;
 
-	/*
-	 * serdev device <-> driver matching relies on OF or ACPI matches and
-	 * neither is available here, manually bind the driver.
-	 */
-	ret = device_driver_attach(&dell_uart_bl_serdev_driver.driver, &serdev->dev);
-	if (ret)
-		goto err_unregister_serdev_driver;
-
 	/* So that dell_uart_bl_pdev_remove() can remove the serdev */
 	platform_set_drvdata(pdev, serdev);
 	return 0;
 
-err_unregister_serdev_driver:
-	serdev_device_driver_unregister(&dell_uart_bl_serdev_driver);
 err_remove_serdev:
 	serdev_device_remove(serdev);
 	return ret;
-- 
2.34.1

