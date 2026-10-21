Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574500;
	b=sd2r8THQuXFtGk6PdwAV+5o6S5R6uOefF9S5pJRt4omQQDjyD+/kjtEu4vLq95RbcNdN
	 87oJm0KJCfa3/wddlb44i+yB6HREafSswlUQawm9eDvj7l2+U9/J2zaE6pxjJa2FuggzV
	 mdY5pikz4TVGCfmRZ1DVUo0w1YlUgmWXpGfQnXjNshR2IlCjaIazy4YKyJRklsW7uCuOk
	 q2zHbmhhoMCcjpHSoku8GoJHBXclS4mMFVWMv04OQQ+eG4nrtBIrMKswOE1zT4BdFS/EB
	 5nIosLWzZfiESQJDw9U3jg8mAPmCcLbVWKl9EfNA0j5ZhteBIayef7zv9E2KJhZKY7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574500;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pjLw4ni01XCQ9bFFwFJPEpPhHyB1Fll+ofVTTD9NfnY=;
	b=dPKrzFVBKrf/D7zlyb2ZqQdevuj8/68oUj/IlNy5j5Gn7fJM/T+Yc03Ueoi4456ikK7a
	 DshtzSDhwT9nwrP2K5/HlOGY3NT1qAXpdUvlhPmvCsZfr4Qccg43IInVZAj/KghfBvGZG
	 vAxGgXKC8rDbAog7Q9MnAIoYbpowg5EAG8i7r1fNrRG4hJVyD/E71K0rA+Ziks2eUC6Ll
	 uKRNpf4HedUoYdnbPMBw6FkP788zinsIcgs319HUWI2x4NPYlm6jiU8jEaJcWxVdoLbQg
	 c66/cDAGA8InilbLq+o5NZo6NCRiRqFI6f5xQutopHL2FJOv26rpzToMC9h3ZUXSk7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=NauWSat4;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B170D606A321
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 09:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B170D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=NauWSat4
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5693C3FEB0
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792574498;
	bh=pjLw4ni01XCQ9bFFwFJPEpPhHyB1Fll+ofVTTD9NfnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=NauWSat4jEfzc48kmw63vJ/WgcO3hRVm4qEQ/W71yd/Gr8GrG5jYRvRNShZXaLtGH
	 OBB5JG/R2gsAqGvWJDFhPQI2/4LwqgjgdqH8RLm+nEBevYCA6rslva1b+r0fV3n88L
	 3ysewhYq0MjMDGefkuiihWlohvy6px39OBxY8yUsieF0GHyrdeEaqbE0msNyXLJZld
	 DPHIjuVY8W9i5xkRi6nqxs+JoiNEm9dJn4DPX+hCF6sTpOlP541IHK/ORArFAWooTX
	 J6l5pccGCoIyMVc1Wllt//qHFIXlk9n3GhXIdjRWPpV1XfbiocwIn5XZXJi41rCK/J
	 cDWevXsOuXBznK6rw+XlNPyW9+rNwiQvId3FQb511SQygifwol9DP0GhJyEn+r2x9L
	 ZHU4rIr/M9Hr5JTQyE6irQ/kEWGsaEh5ppqhsMzIr/GAmqpum6lvpvuL7Gl7Blcg4/
	 D9ukvGW909Bqp6KvYiAgzgYviUTlRbAJKlGdsgteHc3xU8XSG6pdlvbdTA2gwDi3Ur
	 0GLVHJCKcMNuOTiKvXQn5tOZi+BY2tdvFKW0rGDYpBEMnpWSoGZdL2MpGzGOvFpA1d
	 wnyVxQWZD1dMssFBM6hItzXxPJ5zcxZJprCIvuNzRgAVrZ3OSDxoMOPfBEw40yOlrk
	 nQdO7Kkaa9e7rEwESEmDF/s8=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e9a4052726so2233935ad.0
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 02:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792574497; x=1793179297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjLw4ni01XCQ9bFFwFJPEpPhHyB1Fll+ofVTTD9NfnY=;
        b=iBXZKjVz8LEWEIZn73LKa57UI3qdtckUNr0vLtxo/zjXlS6hZFoqhP9nGVcOuNOfOT
         HOWfJCn5Vhktg9x7VyAq2L2sK4+3gJ+oUQNWqffb54SZMzZhkCpiK/wzzqTVQROqOyKj
         rfQp/pWwwSSg2yJl82+d9dLZI3HszCQWOKxBCPgzf/2J+3vaV2AUGOmwLKYcPRTPGt9h
         cvPVLaJLXZDhtotolsdew8ZvNzmDU2V5Fg29qx8NZ8MwflVhteAwU5BHrhP/crm/YBWf
         zZocLdMhYgFU4TzO9G8okXPB1zpQzntfUMIv2xdFwvcKT/H9uJegCT/ahkk/pA5Qkulh
         W2Ig==
X-Gm-Message-State: AFq9FYLUSxBe4pUoJScmaPKRA9w6Q74FQQYyA67jTmKxOgIVwnGBiHO6
	pWEvHgVHANx20v1iBQM6JqrPrySFMh6tIvFOKlJfNhrHU9nnqVfZ+iEitaRuXhx1t9m7UwroaU8
	QugkWClEUcOs0vW6N5q6NRR8XSEaZW0zOKQ4SkuBocSrpX/2oh0UfHaiWUP95HFkstUaa/QScUQ
	3RGG/7QFPClTMfgg==
X-Gm-Gg: AYBFou1kQGL0skeU4e2UdebuBkjpvmGOK5munuFjWQuSzQqb1M1XoVXRfkW+lXRdqnr
	VkvV4NDdxR1QgUt+oG3B6ejGm0pcRs2ZII3F1cz3drFjEqR5j1sQqLSV5R5aeFaV4WWBLXuofc/
	1ETfnzeCY8wPJeh/15WbP6CmrzWzQsl09n8/x6iEnQ0n3UjMHY+QwPRtSc9Hye2PxXqzvZh02he
	Y1TNrecseILX4AHyAcwSK/TsdYPCi/MYGJN9rBde8Ur6uSI9+e1uFfpJJ0RDo0YjAQM8PeLTXTH
	5emnJffbWfxE3OdDuFyZk3WusPgmuBWwS7RRGzNz7dyrfCiMld4EczhHgj5FjJ2FHKzvOjVZamP
	TObXeCYJChWYmWsRp2qge+whFb0vdYbehO/SQ7wmLgUulpkIpF3iwh260F9WZ2Toor3VM3e3E7v
	IEoWVrgXWbm/BhUbxBOsEApF1lf8Ob/9GoEDCOKmr80loaonFoX7HT7Bd6b0jWfz3JaOfQnp1rp
	umA9RSpRaJiFfF3YOXYFd7cvMNlvm6MKi/W3XPd4g==
X-Received: by 2002:a17:903:1a0f:b0:2e9:9263:a58 with SMTP id d9443c01a7336-2ea438e2a84mr21563835ad.1.1792574496841;
        Wed, 21 Oct 2026 02:21:36 -0700 (PDT)
X-Received: by 2002:a17:903:1a0f:b0:2e9:9263:a58 with SMTP id d9443c01a7336-2ea438e2a84mr21563625ad.1.1792574496546;
        Wed, 21 Oct 2026 02:21:36 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-c2b4-05d7-81df-1886.dynamic-ip6.hinet.net. [2001:b011:2008:445c:c2b4:5d7:81df:1886])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea4005a7c1sm6572935ad.71.2026.10.21.02.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:21:36 -0700 (PDT)
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
Subject: [PATCH v2 2/3] platform/x86: dell-uart-backlight: Bind through normal serdev matching
Date: Wed, 21 Oct 2026 17:21:23 +0800
Message-Id: <20261021092124.2306053-2-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021092124.2306053-1-an.wu@canonical.com>
References: <20261021092124.2306053-1-an.wu@canonical.com>
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
force-attaches its driver.

Set its name before adding it so the serdev core can match the driver
normally, then remove the manual attachment.

Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
 drivers/platform/x86/dell/dell-uart-backlight.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index f323a667dc2d..19ed7f8b12bd 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -354,6 +354,8 @@ static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
 	if (!serdev)
 		return -ENOMEM;
 
+	serdev_device_set_name(serdev, KBUILD_MODNAME);
+
 	ret = serdev_device_add(serdev);
 	if (ret) {
 		dev_err(&pdev->dev, "error %d adding serdev\n", ret);
@@ -365,20 +367,10 @@ static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
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

