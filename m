Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792808990;
	b=p+cd4jrxz6XUREOx/kWN8taLFPyT3UEUyYqY4H9zMXE/OEEJrQ7CFAKHKGT++gfmjilU
	 0OlyLZ9LfWydzJK7UOH5VABVofwcnkLHXDnffsWusVh85eSw1VjhnR34ObKW7K45XIRud
	 YCA1Mla0JcSv3izEsvBn/qe0wAFNvgHQfvIBWVBP65N+m3zf3FL/0iAox6nUxRkzktnm5
	 TYpXf7nRB7OQQft6T/bHh+hyWlFIyjP7QEd+h/zlXWSKjFhNNBG9FlUgS++wXdf/J/jVm
	 jKl3Aodq5QIHk4WJxmahY9iwgJLO0pK+wxMDe/QVrvMWNV0t77LhHzX0Ab/XwrEnsnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792808990;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i4VVej3KE6r0xh/Sp6hm3WcrpLIYI5P1lVi2/jNr6p8=;
	b=gAM5r0P9kQobQWs1U/xbSBiJwYSf0gdRIlNyIhTE3sXu6c3lGyTRtXGcCQ3r8OrsCGzY
	 hw0DRYZDNBQsGNtq2LAoBRSfOxCN0diNn9YTRpsE2ynOYn3XOW/+tx5NOsP4YlDaj0bhi
	 P24/2q5NMwTTUHXV0bE9/AbCDgTrBxEuEA+vyeW6yqNwLpxgTV7jVFYQpSoPyP8aml+8W
	 wM6tbNgONg/sNyWt1roEGrE7Ouz3vEthVbafyUJxkWqmsYF7x8eTboxgv94PDZCJSd4o2
	 cHPEgkbIEq5wgyJLAZ33vk3z5Kuu5frM0jYEd3+mZS9VXu1J5pvd+SZt802VaoIK6fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=H9ijO9tz;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1C606A32D
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 02:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CE1C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=H9ijO9tz
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9A9B3402EF
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 02:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792808987;
	bh=i4VVej3KE6r0xh/Sp6hm3WcrpLIYI5P1lVi2/jNr6p8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=H9ijO9tzhTGXqyy2qGYxCC1jLR21xEYsjPStybnUXDJ6jh9MoTVcHkqRrTzsTAWDy
	 jqqd5C9IOndBIH5MyFa79dE5Nw/UMRIU4OogtIcjJSryBbPqlJ/pl5SghyfW42kWJS
	 G9SiXPq8v3wIcpWPjjUovkCp2l2G1xgCIL2wuJwF85DC/om5nLlRmuJlErhZup+yt7
	 YDyskipv1zLbv6bgNBCJbyVqcvHfCTGjwFcOTaeUbwO/sa15sZXKVxQMUvhfgD640S
	 wQzhBU6fzI009PflVt/M+1AFqWMTClzBmQBcqVA98trYWxnH+FPUuB6T/mUYOcXC+8
	 1fkNGWTuoLB0++5a07YiES5jWomh4T0pXhbdNXokHSjkXyKj5nMp5PSjjuDjf4Qui7
	 zlEiyinnbLhzVXCwOIm8rcGSAar7JzodYyOCLZl7xy7KxEMTXBuUoQSTVtwXU1exL6
	 1do/qdGoauBkkvz893UpOvrpgwOtf+odDUq3UiDvCBLQHbdD5pLCcPHZMH6weXCPFw
	 sI4Qzog9Wy/RhdwSEolTXDpBNdHx4tLUpHRayJ6p7UEsmTkLj3hGYLGKGXmHKKmsZE
	 8ZJVbkJ3B8umIJozH0pGEdO4TMEaOwr5MBhn4IWH67rTJ5rtfQPNp1zsdmpj7+GWFW
	 IH1wVySKPVk959f8AS8mpEH0=
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad94b96698so368148a91.1
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 19:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792808986; x=1793413786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i4VVej3KE6r0xh/Sp6hm3WcrpLIYI5P1lVi2/jNr6p8=;
        b=UPbPB2icqT9FCxaNSkcJbLQw6Xa4R5jRLOG/sCyxfj9I/d+4CWdm+E9gMTGn/JKxaY
         KcdXgta1ZRaq/ZqCPV3AREWgADpNN1ahLwye/mEWO4qBWW7QJUlWTiLkXHWp3VRmykkH
         4Y2v4FO/Y+E30TBpFh0zk/tk8VpS60Ro1AvhqhxGSAUmlVqdw/B30HDmyvlqmwIDhuxY
         YL1mAsk5k8rsLJjCCUu68DIs8umWVscidiSqDvZ30yrar8Y+gzalCYRKvstdBVG83B6R
         iLN5yDKHRYQZqpvzvzZUqi7rtXLA1ds5Zn3sBzRss8ps6iKIhk29tnjdiGPSSjX4ptH6
         IuhA==
X-Gm-Message-State: AFq9FYKPaClFfZl8o0p1+q5hoyC6eXGqc/uqBMnALeONUWAclKw3eKFb
	fzwNe8MCIE9IwF13897Cs46bC3pJxqkXUSRNB7uTTUhoGSgg3bEwvlTmmuhORLfy2WB95YeXrsI
	+fvooi8ajWCOV7AsjYAkYuMu7uSJ0npn8tZLMPmgYHgRzLNPptpi3wg8enCNWdPP6uzkbzjO85r
	5JJ8t7gdembFyU9Q==
X-Gm-Gg: AYBFou3uotjxrZqFpJ9YCuC0Sg7aVQzA55X4gOeoL25L5EButCOPryEzMBCjpKut8fb
	IVWY4dgdcA4x8lD1o2tA13jwWSiwLhqcoOnFvDFalICm1TZSR56pAoERJn/7LD+HZEa5IWRVmtU
	aLlpYrbFEKulvbFhMSZ7XImtXKhO8AJZ8jxnmyDuJJ3amN1OHLgp07QOwBmf8FUEbCEU8eMMaw4
	C+Wov3HshJfSac95AxFrs8kElAq1CB1iB3XVUUKw7zqceBtXq9PcHyGc+oGod8XXE1Pv7gJSWWh
	u5iUnQ+FU6nj/bN/2Rh3NEsO0q6wCXmxVAhKBsxW+6QOSFAN/Z02UBiGb2Xe4pW/sompLgCs2Hs
	QjCtw0qCD4RG+oqAdGFYcrqyKjJ7PK1m5eACreMqcFaKCANwp1pe9Lm/zYNDzAveFlIee1ffgQc
	ryzhtwRFQk6xX8nBQRU4UpBQeuKjSe0/kRPcMrWZ4FNkrYcFhFf50jzk47fm8SloAbfNddk+a7S
	1okI9A4cRgxkpg/kreqMC6uPYCGOHl2qn/BQ6FAmvY=
X-Received: by 2002:a17:90b:58cd:b0:3ac:9c37:9422 with SMTP id 98e67ed59e1d1-3adea2003c9mr1490259a91.2.1792808986090;
        Fri, 23 Oct 2026 19:29:46 -0700 (PDT)
X-Received: by 2002:a17:90b:58cd:b0:3ac:9c37:9422 with SMTP id 98e67ed59e1d1-3adea2003c9mr1490243a91.2.1792808985767;
        Fri, 23 Oct 2026 19:29:45 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-9c57-136b-f73a-3698.dynamic-ip6.hinet.net. [2001:b011:2008:445c:9c57:136b:f73a:3698])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb75254sm587341a91.4.2026.10.23.19.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 19:29:45 -0700 (PDT)
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
Subject: [PATCH v4] platform/x86: dell-uart-backlight: Bind through normal serdev matching
Date: Sat, 24 Oct 2026 10:29:29 +0800
Message-Id: <20261024022930.2704030-3-an.wu@canonical.com>
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
---
 .../platform/x86/dell/dell-uart-backlight.c    | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index f323a667dc2d..9b8ef91bb0a2 100644
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
 
-	ret = serdev_device_add(serdev);
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

