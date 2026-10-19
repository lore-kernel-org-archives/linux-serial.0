Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC5485945
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792388827; cv=none; b=XQohBfnL++ExSUvlE5SDxg2mIQ10sVf53ayDhs47US6cTmNomszxzt5rpJFUO9S8lhes5h8Tz0d3FD3XaIA4UWDj3AyDwrCbBIDM48CCzPiJ5ZDlnOgEmNsIgC/HwBfIQT5Q+wB9zcOivsUGbgpL52nONCgm6u06gvDDjw+0FbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792388827; c=relaxed/simple;
	bh=ERRi6+g5rzgUJaYDVJYKBwejLw0EgJxcASgn4PK3Qn4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LTqQenHJuxPqcOGJ2Y8OxrDxcrfNlwpzml/r6kyc04wePS6Ny3pCprvJpx6rrjK74Z9nTfVpQfDKf+WJYWae8o4g3X+HkpVdYZEvsMHhPeJ4I/5N2yYDVRyCZGb1KfIQ0it4BG2dOiR6aC69sNTP7YmvV4x0VicN4AKSQAYilX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=TNynuyPx; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="TNynuyPx"
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E55033F26F
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 05:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792388724;
	bh=t+uHMjrwGstrLHRQRbGN4J2yahKuSBuVcohrxjNliuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=TNynuyPxCxMvYc88k7FbHuZwR5BpAtl6Tw0TJqHJUq0gJMfTmilPHJOAFNgT+v0ND
	 7bzbvnlZcBzSOrmnvMdGWRP7/elEPIn1A+LCkQgCe+HOlPVCaUBkDbSfYoH0h88ywe
	 Av735TbfXAt2Wmkaelwl2nReAYienQob0k9Vhxz096rULybaWEpJZYk8ycJG5ES6VA
	 tOD7mkAM2Ww2RiU+v56oPOt59NQ4xyaPAAmDU0zeFfFsapd2RW/Gwo6Z/JjhwCtekJ
	 g+onyjCfKM5krth8dTBb2uk6aaG+wp5rot+RcOU6tAKUmj7PqB4ZyU8zUiir/wBR8b
	 SZFHXcUbjsGiqFBUanieqAvQQzJWywVRgFOcl3l+sAxl/h+i/rHUVZmnLoJ4/qP98n
	 PmihdYu50Mfz9uB0DWigDdhHVdC7WKm0D9Ck7rQdoHfytjNj/MCdgZGlM+G8NZemNv
	 Hm6kfYSAXbJ9o9ZKTYdJGii58AGZsE7CIddirOVNm63cSglUblmOJ8H5LYXujL0OeK
	 OSwbJi2lZKCWkBNqpGb6pQUooGX1E++I3lk/AbitdD7XMiW57diqJs8jUgfi3p1ZlV
	 u3xx+6p19B86/B77CFCgn14F3jf+XsAf+eOLPy6yZj244uSVTeDPYlUFffEDoyF2zN
	 8w/ICIRsgyNkr/2uPecxvw1Q=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a4ab8a6278so675119a91.2
        for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 22:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792388723; x=1792993523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+uHMjrwGstrLHRQRbGN4J2yahKuSBuVcohrxjNliuw=;
        b=pOaU4wBI4bQfzVkZk6NMp2RYHRXbQ+PnbbkqXn06Mn1Bn54aHUEP2aHGx53ZNtKHmK
         kCjzz5lbybw3QS2xQmGNFkluV8Lmfwtlz29VbfWXLmquKG2MkUU/s+++FwFY6/6VPQT7
         wJz3X+IwQchB79naE3qft/cWde/IZxcQIpUB7BuZkU5/TSfuzwBNsNMIKZmbHsvzrJCh
         4915diCq4krulXSwEORkyuqX6AoN3XS8wKMXSpJpzLq3Ntp2FPwq4ChO/b8ghFfJOqlN
         hhLSw40QU5aOg3rsITEEpwKvqVpgIIR5vHwUvXqbkZVEwkOpdVGdOuvwcSE4dDKpiF4T
         LkOw==
X-Gm-Message-State: AFq9FYJPhebvn+Lvfm9p93nUuTgWbjaKNXFdfhde97tw0vVHfJ+SAuuX
	VdIyi0/B2ejkmmRrx2h+tRJ/aZ1BJxi4w15/VqATQz0kXbs0lwq3UEclD2mJPQINxj5Er3QJC8y
	XBPKuMAAsE1yAufviarSgHZfPU6xslVRqUg+TAyLIZvUMSm7Tz741iIWucTxv7QBg5pW8ktziFD
	q9opf7SW4DU+nwvA==
X-Gm-Gg: AYBFou2i8P6gbBOfN2L8KqZJLLifHX2Noo9fyKBRbg26J7snw0Z3p7Eo2X5nBWAg019
	/r97BR3ju9Z9vettGy2NvKeGfVGVZoVFaF7hnGJXwkCuhG8hHwcUqeprvLNpS8CxMGLxTL8DA+l
	iK53AIB9icpLvOg0RBt5CIKZB+eWYaA9VJsZjVL4QDLU8ymlLVuwA767kK9SCAfQyNw9ZoCgYWP
	i8tB8SEP95PUHToqJRMTmUjpNFYz9Wy5AukWPbQAodbJvIf751FlpC70tRvEYZJmk/NnL5RLznf
	au+JW6YqNOM+eC009XBuEHKcRYgOQ98hQ/96LSuQ688sZhvJBtgxlSmLCsayZ3s6mK5Glos8Xx3
	hbxRvfU6E6D9GxrfwdkEjpa59iQ71D87rvHqcEKOgLmRWydxw2RgiqgRpfeQGBlWRpJoP90nj1N
	l/o4Cu7uSiPA2SVGEf/21r67r6rptY8jjBBPrINBX20KYuy8En2lX2UHWKlJ4nID6IKwwfX8cc8
	ZxsTt0tNHPdiqmkYg9AI+2MRpNRF2E5hR9sNq3purk=
X-Received: by 2002:a17:90b:3b41:b0:3ac:9c37:9422 with SMTP id 98e67ed59e1d1-3acee6dd64bmr9573049a91.2.1792388723329;
        Sun, 18 Oct 2026 22:45:23 -0700 (PDT)
X-Received: by 2002:a17:90b:3b41:b0:3ac:9c37:9422 with SMTP id 98e67ed59e1d1-3acee6dd64bmr9573024a91.2.1792388722908;
        Sun, 18 Oct 2026 22:45:22 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-69e4-621d-b142-2ba5.dynamic-ip6.hinet.net. [2001:b011:2008:445c:69e4:621d:b142:2ba5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc38b457esm15437027a91.0.2026.10.18.22.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 22:45:22 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: linux-serial@vger.kernel.org
Cc: markus.probst@posteo.de,
	gregkh@linuxfoundation.org
Subject: [PATCH] serdev: handle devices without an ACPI or device tree node
Date: Mon, 19 Oct 2026 13:45:13 +0800
Message-Id: <20261019054513.1966382-1-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some drivers, such as dell-uart-backlight, manually instantiate serdev
clients without an ACPI companion or device tree node.

For these devices, both modalias helpers return -ENODEV. This makes the
modalias sysfs read fail and suppresses the device add uevent, even
though the device is registered and bound to its driver.

Return success with no modalias when neither metadata source exists.
Devices with ACPI or device tree metadata keep their existing alias
generation and error handling.

Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
 drivers/tty/serdev/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 7500efcdfc21..366c6d906233 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -26,11 +26,26 @@
 static bool is_registered;
 static DEFINE_IDA(ctrl_ida);
 
+static bool serdev_device_has_modalias_node(const struct device *dev)
+{
+	if (ACPI_COMPANION(dev))
+		return true;
+
+	return dev->of_node && !dev_of_node_reused(dev);
+}
+
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	int len;
 
+	/*
+	 * Serdev devices instantiated by a driver instead of by firmware have
+	 * no node to derive a modalias from, which is not an error.
+	 */
+	if (!serdev_device_has_modalias_node(dev))
+		return 0;
+
 	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
@@ -51,6 +66,9 @@ static int serdev_device_uevent(const struct device *dev, struct kobj_uevent_env
 
 	/* TODO: platform modalias */
 
+	if (!serdev_device_has_modalias_node(dev))
+		return 0;
+
 	rc = acpi_device_uevent_modalias(dev, env);
 	if (rc != -ENODEV)
 		return rc;

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.34.1

