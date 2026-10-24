Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792808992;
	b=K84ve+z1w+aeED7gDhUT5fiopgfuw4LSh1iQakN944QMHIiOzfpH24wLBJKEOUp9sOd4
	 1ZP3ONH8c3H3o+zSbpnIls77gO0wAiZ8Nq7eWk4yeXnM27XLveToIHROLJuhzbElNBd0v
	 aDVhal1/lT2m2EosozmEA52XextAq3TJ5l6uQ4qap/GighpqRrg3pQmOYJNY3A/GrqAuN
	 Cde9i5ti0pyl4UsZFgZl4OUmcvXPEtH0peC3ZTTbSBmInTNf1r0mIO7MBKfTPFc2hFER1
	 KKFXB7la2ykAhIqklxNSpZNuyAOQHVtFNY9fkLR9ZOjaZsw4HzCZ9/Ki4wcQHtqk+vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792808992;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XcXND02uVU9mligWZKre8PewcZOkoWJ0b9UoDwiNQPw=;
	b=g4tn/JfrOZRiC8B1iDBjVWI2uCnL/Isy7WO+/loP7sNR+SA4mg0q14s48i2gkrUVlx7L
	 WJDez1N5ZuaaTyrLRDRvZg3Jo4HPUFOEu30y0fk1SDt7Sm6iO7IAnOUEpIzt+CWz9Fx3l
	 8FwJgndG+rykLq++l/fkFkUuc+wf2Sw+/e4UWbVjTM4IspY9pZSx1ASCgGj0KJz0IR7Tq
	 KdvTZVTnJu8+Qeis+oXJ5DB8XeIvcHqJUY5aESVy+uh6o/JihMVr5qNHu8TU2Cdp3q3cw
	 sFcGxrrDTu2uZOfhyYNaRwQ6ouXqzCLCOriVMaYAWmgohyYouZAcdQfZx4gej7ertDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ar7yPg7j;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D40606A326
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 02:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5D40606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=ar7yPg7j
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 631E4402EF
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 02:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792808990;
	bh=XcXND02uVU9mligWZKre8PewcZOkoWJ0b9UoDwiNQPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=ar7yPg7jOX43xUprxw2RgD7SBcbws9+iM33JEsO0/7KTqmLlsww187gug+qJUwN9x
	 G3rpWbtWh5dGI3SN6DkCN+uEErKJpN1C49npC3ZV7LP3PJfGq5Kcyur4sJteQo7B3t
	 w0P6EnKFcrGGhoD5zk6r0ng6ayngtatwj0awYSV8neR1RDO+pNKlt2ptlR5V3yV+nr
	 3f11EKu7KW/hQnn2Kksu/D8urs1Mc89IRZyddiBevToKaFVxjFeFtnaZKEF7xP24dk
	 WMVIhvI7km3zS8BYCdWSibnbt5/uqri27ncCVqD3fm/L0xp+/SIyqPw/sREHIzVk3j
	 5NUvxotONw3mqo6x9Y0+AuLFhngR8luwG7Ud5s/i/A2ZpxXzLJygGpgIzCBYLLWzip
	 IyWCHHEbrVVNi4i1o0GoAa2/WFMPYUr165ulUTguyiX8Chmh4xHTBzL8xUpgsfB0rQ
	 Hbjzm9PV3Hv0NiMZh0CsHAhb/7Ag/Ru0V5pFsdSBTGbA5qd8k8v6fAqQUhufKLM5WS
	 7bHwCrFZLxeMIqofWyDFU911k9kuDg2CMhAqCKW2F7/z8U+IRDPGLl6sPKG6GbU7wF
	 Wdemb9otEXO5+7rioJM/77SVYcqtFRr7hWGAmldHslcTsHSUm+mW9jFYrB1q7oLauC
	 GtIR7H6Ll/u5r9XL5GONA3BE=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad94b96698so368153a91.1
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 19:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792808989; x=1793413789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XcXND02uVU9mligWZKre8PewcZOkoWJ0b9UoDwiNQPw=;
        b=Mg5Blc8C8D2c+SuQ8Hzwf0fjIpoUX8qtZDtd1jsMuszBOSvzKn0/NY4b6SJCRBQ5co
         eAM198koVyD4Abki1kEkZ7izgEjkSw64iO5ATfpnEQprgHw4yZvVZVG1UKpetPh9ENKU
         yy/xzJy5eXTsZN2TvNyCOWkZcsRgqiRBag7+hXml8bB2qCnhspVo+L7y2Su3yCaTDJFe
         dGj/6lgFRyEXzUMK76LDo/gCU6AxLBvmJbdiKfBu/oSGOyDXshYTJceSgw8P1J0uqyDN
         U1A+i95tc1kuUyJwDBL7O69L+zvWUpDvwDPPH/L8HYGSXIjSGffWp/1VYECJ8DjljMue
         on1w==
X-Gm-Message-State: AFq9FYKbFyfcZCF0LpICxCE9IgEITO/8t/oMN/s/dxI0DAvuocgh8DSB
	cUXEQc5h2k3I0dEG5uZCLSWlk8G0JRTkrr1bk8lyNcudPcMc+dcMJvRtUyH8oXRwll6GNL1uzdC
	XoW2wKFYbeya23+mKmTXL4Tmpqjbi2eoOYTCHm/UEOIkmHtt2aV9vuwBEH94RbnMdmbJX5yrJBW
	PzL5vMx30+PetUUg==
X-Gm-Gg: AYBFou2HuRy4MbPuE2uRTyBFKJq1oME6k2mFKHl/CsTAnifv4KdhizCQ1Ayw9QLmG3a
	1hZeNYc2tXcHqhrNGM3kPVxCyOh1Du2IphA0aJR1DIqqRZh3Jt/9+zJXJmN7zWdZajEoZPe4U5t
	odd5BdHKHx17PBhv9wDF+Gss9Yh6CzamYVrvcunDlN9f5GPTATvefEhgVvy4fNq7X3uYFmtXwye
	8scE60UQIX55UO4jdGde8mCAR1C+TTno6cwwGQQLGnY3EAMC4b1y1CcuW/GrB6JmiIdACPgojH1
	0uFgaNYT8QpDSE43lWqvnlk/683ThkGSRIlI5lx2Dw5WSJRkutn6vhAxLS/RrPh76TYvU8yPFgR
	gZzQlRk6d2hZGo67IR/nXf4a0hTcVmyjy3NeliMEByazVumj7V4BlefYqTHmr/ExWnmgm9oJt+I
	rhcTL+MUreRePhhdLTbD+czzfUW8gtwjmvLo36j1vZkZaCgqj6kJR7wvuZaWESaOVLBDNVksd0O
	t6z3Sm63nHTPsOmTYYoe1eL65cmnJ/fOACjoMSRolo=
X-Received: by 2002:a17:90b:580c:b0:3ac:73c7:9c07 with SMTP id 98e67ed59e1d1-3ade953ea72mr1289335a91.0.1792808988905;
        Fri, 23 Oct 2026 19:29:48 -0700 (PDT)
X-Received: by 2002:a17:90b:580c:b0:3ac:73c7:9c07 with SMTP id 98e67ed59e1d1-3ade953ea72mr1289311a91.0.1792808988509;
        Fri, 23 Oct 2026 19:29:48 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-9c57-136b-f73a-3698.dynamic-ip6.hinet.net. [2001:b011:2008:445c:9c57:136b:f73a:3698])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb75254sm587341a91.4.2026.10.23.19.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 19:29:48 -0700 (PDT)
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
Subject: [PATCH v4 3/3] platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Bind through normal serdev matching
Date: Sat, 24 Oct 2026 10:29:30 +0800
Message-Id: <20261024022930.2704030-4-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024022930.2704030-1-an.wu@canonical.com>
References: <20261024022930.2704030-1-an.wu@canonical.com>
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
---
 .../lenovo/yoga-tab2-pro-1380-fastcharger.c   | 25 +++++++------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
index 8551ab4d2c7d..d0bd9d4e3137 100644
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
 
-	ret = serdev_device_add(serdev);
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
@@ -305,8 +298,8 @@ static int __init yt2_1380_fc_module_init(void)
 	int ret;
 
 	/*
-	 * serdev driver MUST be registered first because pdev driver calls
-	 * device_driver_attach() on the serdev, serdev-driver pair.
+	 * serdev driver MUST be registered first so that the serdev device
+	 * created by the pdev probe binds to it via the id_table match.
 	 */
 	ret = serdev_device_driver_register(&yt2_1380_fc_serdev_driver);
 	if (ret)
-- 
2.34.1

