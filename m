Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792893820;
	b=mPSpyJDStv+gnNFP2+gOSzToSscCeMqccfuu8P550kqE4lFR+jkEgTtrY/799CzWPGjI
	 f8XdzH6Q6BaZmGALoV5L8o8gVG9lRGVvVks2BbUj7yp8pQTDUg2WBJXWNPLuSwTs3IVZ2
	 +4lTEKnp8z92pDdjU8Icvcr3B+acSRZLaQAV92/K1lM76bqWKYg/2eo0EhOjiviB9h1ba
	 leUxfhWCvm604N9zT3XWm27MgDm1fqpsN/zKqEea5B60J+fXSJZSEnYd1rb9CAsxKmlKJ
	 9gERgQq0CHZRS/gB5Z/P5s7UCvxu+b2S46kry1tjrlvR7txc3I6IfZt7LWErE6Wu0PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792893820;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8HMHgdeILuk+JbZuGBNZ98iCp3ntUR48S81/BHCsYyI=;
	b=utPOnbLLA5+/fSSJE2I2XTdNinubmznddk1uFy50mqYvssqiDy47z7cmWBIwy6jvuC4E
	 MAcGHSSWp0uZA7c28rUwUdZ5fn9xrBlqJn0chOjnBdHzjFQWdiuy29BpWMOCRhhqJ9Z/9
	 36PySDNUDs7uqLi77iXkH0of9tQNnG/dBrMnAlUhx2ennfzaZ8cYmJxb4fIXf3lv20UPS
	 Ch2qyP5IeAS4aaDy4jqYQzOQtcWFpmAbNTxQDOB7+xbDZg8CXgn4BrFroxgGlfn5K8m7u
	 1I1gyRF5EQAYJd2nCZ/ABDPiXOBG6FlhcFUNciQvPMUqHqcFups487xAu4oGpAgZIBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=rWvGhGop;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496F606A331
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2496F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=rWvGhGop
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CD90D3F276
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792893818;
	bh=8HMHgdeILuk+JbZuGBNZ98iCp3ntUR48S81/BHCsYyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=rWvGhGopgZ/uub5s+4J3JkkG/NT1mwOikSHDiqcad+iEJVIp9qJEan7aJEZZhunbo
	 CuCCrivvvjE+5XWgnpf7hqMHCGO1/06PxO25quhQygBDmuy7H1u9F9T7k0bTVfpX4M
	 L9NgC/1bQnCPZzWTx/0j5EGodPydeyAVFclUwD2FOfztBtj5eb2XgL+8o79OxlFd+s
	 eJNOiK9fz7QvkJE8naiiHTlXa8WYC60dHFqgy/wqS+FRY9nNZdtV+0rTvOPZafDCGJ
	 wqjieNEOM5YFsPuNvVUaG67S7G0XP9atyiJazK4LI2JdYw1jPvLTh6wENjL9BaxyTl
	 AMXIUAWZ9WZsWxnzN9GhJMQnbEdZFOCwqcYcEj/p9UHh4E+t7xDAAm7i9zbyTlhtPV
	 JRSkiwRArceurN85BkmhtsyX5xuZcpE6vKISDa0SBTU5TgOmEMtokjT9s2un60vwKa
	 CdQxKyUmc0oquG1VD6VqzAaM/nbx+qvWP8eSkCnM4nmzB8W4ncovuPMXWLmDmjUUSR
	 AmesFQnTyo8+5yWiFgt1TUMbOyA8jrv1YqPd1nzpkwSmNR4iSWUQxpN9hlcvZsjKqG
	 ZMsnkhcGqAKUZL44JBfp/C7rd2MaqaAX8IiWKuTbsluB2VxkdnOqG6ZxUykX8o617j
	 hpzL6csLuFrofQzAaLZUnHSY=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad3bf3fe2fso780270a91.0
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 19:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792893817; x=1793498617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8HMHgdeILuk+JbZuGBNZ98iCp3ntUR48S81/BHCsYyI=;
        b=ThHWl+v9nL1D2aLd7jyJqJ2Vb15c20qbH4h6TzlmEiNlYk4yB/w41CW4Kr9LX59FbJ
         Y+mKFyXn5EGBR+2U4UIOOm4migMoqRQFPtNiYpnaBTfmlYZQKAAXTl9UB2N7gCZt0FUn
         GifAiSmpDsqjxQ7w9IsgWEsjHYsjR8+Ij75dGv4eINqXN4Dog09OAByRCxxoH53R51bP
         wB9crcuSLJJfE0T3qVIy0QlshJEt017J6gxdh+VTVnnpMA7xodmq/3HD1AaHpSkTwkvh
         wwFMAJ1659RHFc2861yw/uOD1SIFWpdjqfexV/JOPAkzF5TN/9QAxQ0jcXuK4vrsU539
         LPOw==
X-Gm-Message-State: AFq9FYIMoIJ/RYN0uI6nTKIuLGT9JLLss7uSPYn801Mgi+5b2/jh+YEK
	TH2H4sizSYtL3QnYKXbZ1v4yAc1DmV80bUWc0SEu+llOMPu0mD5rTDwObn+WdYRH/6EoS9NncKL
	zUojhlvu5SeGu4UA3EeOwWNUIfkKk0Vf5ajkfYctGsjNOCYDI3teYxMA7qeiKRJ13dXG//nHdrQ
	deiraGRzkEtZBa6w==
X-Gm-Gg: AYBFou0AmGKdTck8uvnWmx0HnbWIKXE+3pxCQMf4oNMflIkOSNenpP9Rsih/irNcwRE
	qvGR7czV9DP1oRfCQu1hMtTWj8HS19yO7HDlJgWiy/b0HuaWlYH+zWGS7OZM+3KDnKsnOGkAKKX
	5RDmwBqM4Z7whnlvyZ9u4TmcmHZRZ5/TnTITnbaNt4PjhELDuXq4+tb5xXSQhkn85GBt6Fl4ZPB
	re0sMe6YAvnMs0DDQTcJK8VNNH5FYcFgUmx8o5xC09cFglsMMRs8SupgE4OUPLAbNVsMXXaLcRL
	CwjxY+HT2pnPvgS4W39mnHEe05osIg3J74Dnkruls6yphI7rE6/o3W6IcIMZeSgrEmqr+iWdhN6
	sFHlkiLjbKRpo22o2r+fgc1ZJDIBAXv+JauHd3uYD1YwYhnhI72yOGSOEVfrFp9rRqobZJv9lXv
	8Ct6cuBgVQA/HGK8kdiiDMEIwBjZ0SSeW4Wb27bKcxhVMY30CUy4DQMMxP2AK3vGhYDArryFDnV
	N2V6sxaZKr7Ik8dzDf2oq4S5no6tZSl4xwTV+lpkQ==
X-Received: by 2002:a17:90b:4fd0:b0:3a0:238b:db4d with SMTP id 98e67ed59e1d1-3adeb0f6c42mr4824998a91.5.1792893817335;
        Sat, 24 Oct 2026 19:03:37 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd0:b0:3a0:238b:db4d with SMTP id 98e67ed59e1d1-3adeb0f6c42mr4824972a91.5.1792893816917;
        Sat, 24 Oct 2026 19:03:36 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-0e25-4b6d-1924-440d.dynamic-ip6.hinet.net. [2001:b011:2008:445c:e25:4b6d:1924:440d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebacbf5fsm4226044a91.6.2026.10.24.19.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:03:35 -0700 (PDT)
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
Subject: [PATCH v6 3/3] platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching
Date: Sun, 25 Oct 2026 10:03:17 +0800
Message-Id: <3827984795c4bd797008652a49b069151e1e8be6.1792856688.git.an.wu@canonical.com>
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

The software-node-backed serdev client cannot be matched through ACPI or
device tree and is force-attached to its driver.

Pass the modalias to serdev_device_add() and give the serdev driver a
matching id_table, so that the serdev core binds the two through normal
matching. Deferred probing is then handled by the driver core, so the
-EAGAIN translation is no longer needed.

A failing serdev probe no longer propagates out of the platform probe;
as for any other bus, the client is simply left unbound.

Signed-off-by: ChunAn Wu <an.wu@canonical.com>
Reviewed-by: Markus Probst <markus.probst@posteo.de>
---
 .../lenovo/yoga-tab2-pro-1380-fastcharger.c   | 25 ++++++-------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
index 5e568fe1162d..ecac3eb3f336 100644
--- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
@@ -219,11 +219,17 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
 	return 0;
 }
 
+static const struct serdev_device_id yt2_1380_fc_serdev_id[] = {
+	{ KBUILD_MODNAME },
+	{ }
+};
+
 static struct serdev_device_driver yt2_1380_fc_serdev_driver = {
 	.probe = yt2_1380_fc_serdev_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
 	},
+	.id_table = yt2_1380_fc_serdev_id,
 };
 
 static const struct pinctrl_map yt2_1380_fc_pinctrl_map[] = {
@@ -260,25 +266,12 @@ static int yt2_1380_fc_pdev_probe(struct platform_device *pdev)
 	/* The fwnode is a managed node, so it will be auto-put on serdev_device_put() */
 	fwnode_handle_get(dev_fwnode(&serdev->dev));
 
-	ret = serdev_device_add(serdev, NULL);
+	ret = serdev_device_add(serdev, KBUILD_MODNAME);
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
@@ -304,10 +297,6 @@ static int __init yt2_1380_fc_module_init(void)
 {
 	int ret;
 
-	/*
-	 * serdev driver MUST be registered first because pdev driver calls
-	 * device_driver_attach() on the serdev, serdev-driver pair.
-	 */
 	ret = serdev_device_driver_register(&yt2_1380_fc_serdev_driver);
 	if (ret)
 		return ret;
-- 
2.34.1

