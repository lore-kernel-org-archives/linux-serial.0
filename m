Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574503;
	b=zjWdmX7MT1m6XTLC6CJI7IBKiPF9pyrRce1gucR7qaeVeUW6lbU6iDDBgshEHljeEOPn
	 2YeEtvVCB/PiBfqp74YmyQQpB7COak+3dwe+AFgNzxTwGfyXdFcJSpCA1gIcCSK895GUr
	 AZZHFWrvO22jTN4J/tw3SXV3jWcaOXxLAMEZ/ZsrgJoOpCEAz3YO4wCAbEobx4EfDzzF0
	 w7it1dGTXPI0ErRtD15pU4HpkLDf96SNGCE3vOH6tF9wlaLr/nRU5C3teXs+wEwGooXfd
	 5iq/pzLrrZnFKTIIoCX71BSqOTdKZgIpmOQ5mR1+K+Ki4TuDylw96MvpLNMosJkgYxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574503;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TqZ79ECxYN/RwCBf7F+bL3hULKViJj255xlTW5oDrDw=;
	b=Si0S4zP+c5PWMDwCVBe3adV6IGALnhjwsQMraruDaPxF3M0NZiqfbngLEJ/WyN+yZmGN
	 Wxx77400fZCQLaY0x3n8Yq0bPpmq0AmcJyxs5NkO/Dihrzy6BAoxtlhH3U280Fdfik3Uc
	 4HwUQ9JSXe3ATdAMsclRLkVKNbl1643qOXuC6FE5MMmwNMZZd4jTDO4KOIIK7IvfkONX3
	 z3Q2q2AI15NS7kUKJmIDHry8J/d4gdsb3pY1aEmwcqE1MaVg8QACIzLw6kFAXpng4uVtW
	 6I0a62TDuflNRPd9tX+fECzt3g9EAR43ROV3W8GKW9J8U7RGZvl4RzIvbkalJHUPIwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=WhvXiVSE;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8960A2604
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 09:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A8960A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=WhvXiVSE
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3A8964025A
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 09:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792574501;
	bh=TqZ79ECxYN/RwCBf7F+bL3hULKViJj255xlTW5oDrDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=WhvXiVSEPinCRhs3oLUbwdZIhVPLfxfLSp1yJbAhYnFuM77nJerKvSzjrYVHeRkdX
	 xnBwP/BaKADyLcjbqi+dHaCsntgKb4esG4dPx+BHvnw4nqYNzB1xZAA7oeogFkddcU
	 5mrUEV+lFHeP/kX+H1juF2jYLAMYJcNdxXq+DjV9mX97KigFuQlBPBb8Hiv6v6cAjF
	 pA3TORXZhTe81bnvBGDaqnhK5dk8AG/b7savi0Ckk52PtXGHKbOjEKZMyQbyLxEj4j
	 1lQhdPaRydyvmQuQpaT8+tyB7+99bdPExNSDGC9vhZmbSofWTgWKwE2VISFbpAZDFn
	 TM6a1ftddN8dzffJ9fnNwn1ZbwM0h3AN/+A3VdC1SjBQrDPpFfLKGz0Cy8amLT0mz1
	 cBQV+IucZkwLaUwnMHAujOCC57k1us3JfH8VFp4kIWFHJt73/Yv7zpydzfVqH0m6gV
	 teo8Fs99aFfZVeVPNmX4zSgAOBocxvtbwT9JunB0PNbqGTZcyKfnVnVOhTJvRK8Qij
	 T8+dDeJjBmpih9sDz/XW8C7SS55bZOf0iP6/tXRTGqPnDKN/NrTy9tZLxS9CEnH+Lx
	 BKUDjPYLaBd3rhVt698wfrKXMAF+bg4XhEakCiDy4oXu9z0hrozHszpy/2z/hYEucj
	 OSh4yb6kqz/NQl74KKiUZQFc=
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e83d5e518aso733785ad.1
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 02:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792574499; x=1793179299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TqZ79ECxYN/RwCBf7F+bL3hULKViJj255xlTW5oDrDw=;
        b=OTWEyU+GzKx9bNrBL/Q6KEVDQlu0CU/IjXS6FOpNxm51xvybnSXAJ/oj9sFdhczqX1
         d+qLEWwqq2rIp4u6eTDGXVdT/vbW9BHD1ZYDs16IQrfzUuphKusEwwZYxwEagHioGT+v
         GUL8boNO1oj+h2jXDUVM8yuiPxtfyjNABiqnmnT2SpS/TOD/va0IFu51Nxrw47gtCur+
         5szH4vtLFWKrqYRYan70h2vCKMvXlwbNgSSjMs4Yn7qocaF2ifDHBNvWejCpeKvyioJB
         0BQso0RGLy8YrAaV2AIPp4SAJU9EVC7T9mMZ/LeIQ4GIMv7Khe2Aq5hAR22fiX37FZn7
         e+TQ==
X-Gm-Message-State: AFq9FYLhP24i2zpfoWlclkMZpNr55cDR8rjuFTzPFrZMS1UpPBSWp/Fp
	+sb3QtlPJi60Oyr9GFvjfwpDoGozbXYUb3QjP0hqopUiYTXAvpBm9ux/y78Mh/h2y4R8XNP0aD9
	9If3Doal0omNyDX7VXR0vhrbKx97RJh7//vjyjGBcJwVq7FA38a9aE25/E5dW75P18QHcgIo+dV
	sPIv3gmOTDQaxZPg==
X-Gm-Gg: AYBFou1UyduozS+NCAMQp/PFKiDIubOE0rqfzSQfLTePGMKcKgRZV1FjufjRfSQPKDv
	8NjogwpMqK7cLbiKH+ZxUle9CX+sqcVz3t9/sLvk6pfDMeIiiJtll87VZrAjHhVQHezxXisO+mw
	IrjYUYbIC1QZas8h7iPi3N+0zH+Ds+cY2E84rtHaT0ToWiDvQvDzX3afRUjrTsCTPDnG0ewAKQQ
	6oDJ4wsCj91Bewz1ptnEeSxexEKIhC4Qct19W1onN5hm+tbduZvzHmaHiUu42siPgH5FFiopGKL
	zVhPeBBKgwYdxFCukXvrseND5R1WU6JavxpXXCdAq8P4qD5ocCHT9/nCBDfSo+0+XD5edeJB3OD
	MoLAK/1znP2SwQ5+tUqRy3ETXS7/wZd6sx81vM7qfhT29b9GJKw8lOmKk6jsL29GXjcybS1eOFr
	spe2BrFgtAoKd+rfgZH8Za0zfqOI+F/acl0VZYlHvPAOO1ZP90ZzZHSYozmake4vswEnnJMEiXb
	+TyN4TgWC5EWVFF5Q8r0tId7HECCuZw5Z1Y8F2SrQ==
X-Received: by 2002:a17:903:2f85:b0:2e9:4175:306b with SMTP id d9443c01a7336-2ea4391292amr20386725ad.1.1792574499685;
        Wed, 21 Oct 2026 02:21:39 -0700 (PDT)
X-Received: by 2002:a17:903:2f85:b0:2e9:4175:306b with SMTP id d9443c01a7336-2ea4391292amr20386405ad.1.1792574499271;
        Wed, 21 Oct 2026 02:21:39 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-c2b4-05d7-81df-1886.dynamic-ip6.hinet.net. [2001:b011:2008:445c:c2b4:5d7:81df:1886])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea4005a7c1sm6572935ad.71.2026.10.21.02.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:21:38 -0700 (PDT)
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
Subject: [PATCH v2 3/3] platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching
Date: Wed, 21 Oct 2026 17:21:24 +0800
Message-Id: <20261021092124.2306053-3-an.wu@canonical.com>
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

The software-node-backed serdev client cannot match through ACPI or
device tree and is force-attached.

Set its name before adding it so the serdev core matches it normally.
Deferred probing is then handled by the driver core.

Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
 .../lenovo/yoga-tab2-pro-1380-fastcharger.c   | 21 ++++++-------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
index 8551ab4d2c7d..2eee9ecbcae7 100644
--- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
@@ -260,25 +260,14 @@ static int yt2_1380_fc_pdev_probe(struct platform_device *pdev)
 	/* The fwnode is a managed node, so it will be auto-put on serdev_device_put() */
 	fwnode_handle_get(dev_fwnode(&serdev->dev));
 
+	serdev_device_set_name(serdev, KBUILD_MODNAME);
+
 	ret = serdev_device_add(serdev);
 	if (ret) {
 		serdev_device_put(serdev);
 		return dev_err_probe(&pdev->dev, ret, "adding serdev\n");
 	}
 
-	/*
-	 * serdev device <-> driver matching relies on OF or ACPI matches and
-	 * neither is available here, manually bind the driver.
-	 */
-	ret = device_driver_attach(&yt2_1380_fc_serdev_driver.driver, &serdev->dev);
-	if (ret) {
-		/* device_driver_attach() maps EPROBE_DEFER to EAGAIN, map it back */
-		serdev_device_remove(serdev);
-		return dev_err_probe(&pdev->dev,
-				     (ret == -EAGAIN) ? -EPROBE_DEFER : ret,
-				     "attaching serdev driver\n");
-	}
-
 	/* So that yt2_1380_fc_pdev_remove() can remove the serdev */
 	platform_set_drvdata(pdev, serdev);
 	return 0;
@@ -305,8 +294,10 @@ static int __init yt2_1380_fc_module_init(void)
 	int ret;
 
 	/*
-	 * serdev driver MUST be registered first because pdev driver calls
-	 * device_driver_attach() on the serdev, serdev-driver pair.
+	 * Register the serdev driver first, so that the serdev device added
+	 * by the pdev driver's probe() matches it and gets probed. serdev
+	 * drivers are probed asynchronously, so that probe may still be
+	 * running when the pdev probe() returns.
 	 */
 	ret = serdev_device_driver_register(&yt2_1380_fc_serdev_driver);
 	if (ret)
-- 
2.34.1

