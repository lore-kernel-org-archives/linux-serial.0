Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733256;
	b=YJqvsYW2YM/s0aKvasgjNRDzHmFMj+46AZsXh9X1YlVChp4zt0tN7YmLVDtT0f9qs7Qu
	 FUewOvCcUdXu6mtv+VFmiWPB2PizJ+9ksD/PEv+klYk6OVXBPS4FSGMpkdk7WiOK5NXkE
	 dpJSLb4g0xvpqd9X1pbfy+5TVp5ZA9BeHrC76VI34c6xwwlpPjh5nfrUblmI4ggQ3VmHK
	 6I1js0K8LroqIQ4AC8KRT0KNu+X2GoV0Zl0L71121Mui4Sj+AeXzHgJhlZHe+OcZd91OQ
	 O2F7tkQtzVRiAbAt0u67DJEv4o+xP8nzHKQ5GplOedvYiX9bolfZderI5gEOXILALiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733256;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4L6weuCfG+0+7nbvcKznkqD/AuPq+kc5T9Pa5EzUN/c=;
	b=A+O7vi3wSv8E2+TckKlU3u3qhu88ahrRUuElv4+eFq0wsXP8tEHrzeTuEvWPSBSfkgyB
	 N+jO3d5qSg+4LModoYc+Pw5p7lw/fJlK3RUkTgK7lmzIuJAbsNQDHsC8RX1NVe7bZEEKT
	 76QdyH3vU/m721YQaKpPrV8DyGuxt3sKt10O/RPukkpU+YLSGeVIyERGlkMFpnWgEHAOD
	 l9O10hAEjgan90Y70vRqdqA6BJJHBQq2dETE7FbeiGdiJq2EQIDXXkWku87N6NcVyzeXs
	 F9rF8lDUrbL/V20WtnW8HEVsJ/meyCDVsnh5bLrKiNdgNs4vHbJy89BnVPLiKJ9yZlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=P6MVOUgL;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395A7606A336
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 395A7606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=P6MVOUgL
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F20C240134
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792733254;
	bh=4L6weuCfG+0+7nbvcKznkqD/AuPq+kc5T9Pa5EzUN/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=P6MVOUgLpdyz1m/C/KJqvd0ZhIU8tazsqc5DTTE4lX9fGpJbRFBXrijK9yK9mmA6I
	 WkHtiFhKd6vhMTaLmQ40Xd7MEDRr7zYgAIg/KonAdIyDAuhxKi+S92/BfGPmpxd9og
	 Bkt5EYJHTznnxb6uUWChXAJbZrVGbSgrF7MqeZuXiZ8YX8Z7/irEpHDV+DryYyM5oX
	 st3yg3g3509MyuIi0TICnmFVK6hyx2yO0AEkEm78bdgakQRhhYG3wmdQ+RBqfCetfb
	 NCOzWjnqKgVgk3Xaswsk/psyWsecTRCqFPNF5B8yc5koeU3awn3AzrSppwVfB93Bw+
	 Qj7Kmbgn4XuldZ+t9X7RUTa0HP14v8Wu1/80BQT51OXZLqka6E1yayQZ7+bbdLz7P2
	 KtNPcit7Ydve/x+kE6tAmTRH3p4qEwG9wQILB7r8b0iM2lJGxy4pGaVrcowsfvecvL
	 c5V4bsfIR3LFJdsrImGE79SmXQheUDbTPg8QK1qYElTu3wTqxBo31oVH7+iMjnOgU7
	 Swj8wZVOIl6oOLoxLRm6p83ldqop40sYyyJunHX/hV/Y9ScX0FRIgiNqqfWkHDx2t7
	 gL+oxYzPaBxAXK5PocIjMmXweBh/+bnIDoH7jG7gMovMsHudT1KGTnKGIdCOVozvrq
	 O6bucIw4kyJha3ugsKpNRinU=
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-313c7315becso99329eec.2
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 22:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792733252; x=1793338052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4L6weuCfG+0+7nbvcKznkqD/AuPq+kc5T9Pa5EzUN/c=;
        b=eOYQeQeZLIG0DNJNaqriaJ9Qc2153tgNEuIWXafqp30DvaSSBh+ZHsr95o+H1LqCVc
         ucCMaEJ3V2VsTidnbGu9FqlgI92x4yTylV9mgbMj/mbLutJj1tS12RJ1R0X6rWi+y0ve
         fJoeifrE+AhZFD0he0GwGlTzOR5p2HM/xyCnpxGo0a/bEr98TEuFBoCu9KXSKcCH8eEr
         kdnYiW58UfNaa9tugcixbclc6x/ZHKk4w8M1PvGLMKixtqqC0IE9GajuTmzAx+yV7/7Y
         qdUqo4XCuANLckxHWehSwlpLM+7D2Di1gSJaZNHi07i4j3dE80MNd9A2rQcIENXycstW
         w/9Q==
X-Gm-Message-State: AFq9FYI8hejV+Hc61mej46qAeUUw9hphOhEU0s3OhadS6whUSQAEelL8
	Ai4P9uRE6j9DIlX43GAR2Bhgda2FyiVZZj2CmTRGeSpdU0U0Y9PYK5tQqa9AH0iNIJluKvV9+LI
	CLH7ksEAToJfqQ4TJBCqmTh4ah1XN35/152WojYyFDCqwfgXFpjA9XelG2EVmDBWabBaV9OsidS
	8K7xwDcL8VBAdZsw==
X-Gm-Gg: AYBFou0vdoHZUcBjQzXkPQDa3onDjFi3Nwve8tsnZdNmc1/wvvmOjeZQE8BZEsgjdKf
	RqZqEMke1b42L9RdYaflIzkDeJ5GezjgwmQeALiPpf3q7cX1TV+rSwrcj8eQedmkzM4rduXrXpE
	oCjiTKKo8+6GW8YHVmivTpBrzD0E5Zv3gCSrR21N9WXLfqgJo+Y0R1pDyfzqfCjRHakaxwopeAd
	JuIh/k5fxs1RZ0OMmVFFtx8L5ebVUU0jIDRAsNV99licuN/s/ittDDnPwYajFPzbh1r7dF+/qwO
	yWtVH3mgXdyA+tOd5ebq+TN5sO77PTQnBImqj0Gn1q+V49eFF015Ys7I3hO0rvF5em94S6HERnH
	tpiIPXj2YeXoY/Uz/ezojHk0nhX77xNUye8zccVwcecSGNAKJQQsZIUnSTe1zPbaV8oCLpYKZhL
	31wQ8kkCAr7qMOJWYQ7xfvNHC9z+u+N/WDDCxRCLPa1Yl9OXFySo/cZUsY/kp6vAQSca4B2s9nv
	YmgUT8VRh4P8ZlKtDELtcQmQrZeoUs5MdXi9sm9NiM=
X-Received: by 2002:a05:693c:8952:10b0:35f:ea17:d171 with SMTP id 5a478bee46e88-369d975d845mr2603012eec.2.1792733252242;
        Thu, 22 Oct 2026 22:27:32 -0700 (PDT)
X-Received: by 2002:a05:693c:8952:10b0:35f:ea17:d171 with SMTP id 5a478bee46e88-369d975d845mr2602969eec.2.1792733251744;
        Thu, 22 Oct 2026 22:27:31 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-b47a-213f-cf99-45b4.dynamic-ip6.hinet.net. [2001:b011:2008:445c:b47a:213f:cf99:45b4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9e1a085sm3590098eec.29.2026.10.22.22.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:27:31 -0700 (PDT)
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
Subject: [PATCH v3 2/3] platform/x86: dell-uart-backlight: Bind through normal serdev matching
Date: Fri, 23 Oct 2026 13:27:16 +0800
Message-Id: <20261023052717.2577234-3-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023052717.2577234-1-an.wu@canonical.com>
References: <20261023052717.2577234-1-an.wu@canonical.com>
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

Set the modalias of the client before adding it and give the serdev
driver a matching id_table, so that the serdev core binds the two
through normal matching, then drop the manual attachment.

The client now also reports a "serial:dell_uart_backlight" modalias to
userspace instead of failing with -ENODEV. A failing serdev probe no
longer propagates out of the platform probe; as for any other bus, the
client is simply left unbound.

Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
Changes in v3:
- Use serdev_device_set_modalias() instead of ::name; add an id_table
  to the serdev driver

Changes in v2:
- New in v2

 .../platform/x86/dell/dell-uart-backlight.c    | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index f323a667dc2d..13515ebda3dc 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -325,11 +325,17 @@ static int dell_uart_bl_serdev_probe(struct serdev_device *serdev)
 	return PTR_ERR_OR_ZERO(dell_bl->bl);
 }
 
+static const struct serdev_device_id dell_uart_bl_serdev_id_table[] = {
+	{ KBUILD_MODNAME },
+	{ }
+};
+
 static struct serdev_device_driver dell_uart_bl_serdev_driver = {
 	.probe = dell_uart_bl_serdev_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
 	},
+	.id_table = dell_uart_bl_serdev_id_table,
 };
 
 static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
@@ -354,6 +360,8 @@ static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
 	if (!serdev)
 		return -ENOMEM;
 
+	serdev_device_set_modalias(serdev, KBUILD_MODNAME);
+
 	ret = serdev_device_add(serdev);
 	if (ret) {
 		dev_err(&pdev->dev, "error %d adding serdev\n", ret);
@@ -365,20 +373,10 @@ static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
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

