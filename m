Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAB32F760
	for <linux-serial@vger.kernel.org>; Tue,  4 Nov 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268084; cv=none; b=bZGu4BeeHZ3+mj5aR6x/7Mdha4DKvBkoG+84qglt9t15A6iYp7YVFipGrjHHGGP5Ro0cXWGLn4xYJu5vZ8ZzNiGuTWz7ozzlR7SPBpQIWQYO/fegq2T9UDQkZz9DYj6lLQbyPy5QZGr3Z9T7xEp/imeCRY3YlCI5VNFPgOl38J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268084; c=relaxed/simple;
	bh=WXJgANZ+e9h8MzCDzeaAESu7lB6O6+zjBXrW56L/8IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyQoS2QOBShCSgK67jseg8wjcJ9/C/ZUPDyvaiwNqzS+njUHmIMiSsrAixgbQH1RjnIV7c8hrXChIulsaJo4qQ2ymBzoxCcKhp3+tlTNuv4JqWOAP34rikajsI85AXTYUv7hwmAGu4foLAep75dVcAONWwxJye3b1bci8mHJFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ix74fq6U; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix74fq6U"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so3742829a12.0
        for <linux-serial@vger.kernel.org>; Tue, 04 Nov 2025 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268081; x=1762872881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Eoyutw2xWn5tZ7X64KI/elnJZ6bDgfQd3mhxBVUbfo=;
        b=Ix74fq6UDHhm2Gfgs0Ecv2/CMIr2PSZYO3cfVs0C/uOvECHY9K2XOI+gKjUxiPzTB9
         o3myGmXM0bf6k9aM2TeBCxtJLH4x5YUI6HKJTtTXoNxj/U+KV9vC06Iar+KUVfGNMbhL
         BQHJyjubllGoONnDkkJDejqZmiVv7XXKJ7xeSEoOxBwIQ7mJM4Xl+c/3wxllLxCdkenW
         8tYJpZHNdHAH4L1xDHM5uqhWXBK4pwO9A3W2W57c5bvHpE+KXs+D6lFSvU4ZkcqakJaa
         xde/iEhTegaan9eQ05ne2xIi7CRCUkdi2sutNFgAmSgi5RsSGCCDCsFkBKd1C9R/XDUx
         Zcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268081; x=1762872881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Eoyutw2xWn5tZ7X64KI/elnJZ6bDgfQd3mhxBVUbfo=;
        b=JMKAMSS4qOksgHxhbQJzOoAJUHWHoZOapNCcKhfApACTWjURF/+F4uEWEeSLf0UVgc
         P8sm2YKeZu25DDSwCG7Uo2z+oWymD9MnwhgACkBRmSCxKGGgDx1o9yvcF8x5xGNgymWt
         ELMrc5Z9LL1rSPObweT/q+ToLbVc0XVu/90UaIaIZBAt+XURRV/bNX0VYaR1HikquiOi
         VRvR4ST1HIUY+nzZF8cdROnbi8SwXIHKwJrulyxfcRT1l/M9mdFjgAl9Hkh9ohB5lhDL
         VNnUZX08Z10UH8ocJMLjA1o9fk07tiA1cApjdBKUa54N41i0BDiVNzazbodjo3BBhKjN
         qq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkhyF61QJ1gHVCkZbCrZhez2LfDVJ3ur2gWkvfV0L9/9Z0Qbb6LaC9R2IeIAiHJJ8VBwml/i2W3lAze7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jL9FJW+5ARH5lZhHdf8R+zqoT2dtDOnue/hvuBBaS7lIAFhP
	rOR0Uzd87OJW6XvTpfthgiEcLuLnOPFkGMkC9CMFJrZigqi2gViowlrW
X-Gm-Gg: ASbGncv3ktIGwPl/tNrGu5GdLLhSjumiCutvXRw/kZJ/bcJfo6Rka9uDaC3pxYFla9I
	/ecn86F+cog6W1A0BdLPHYQ1vmeOY7kag6DqFL4pY8N3WxUbNBj7c5fPbknxQjlHAlYC1OMquLH
	UFGBIzewbq06e2XkHa+BLb4mX0FWWOPzv74V2eL/PNHKerL64MfslTX5lRklyV3eZB97jNAacWi
	HV2bRUrSO7iOUw90bPtt7PmdsuScsSkiLr/qbvXBVtz1PpKjQumyAyDdzTJcEXsOgiuvglCm6vt
	bx8nYDxw6VPXwe0n06o6v31lq66DpWxTgZHGDha+lLqQUg0e2CFKix0hyQq2OWQjozBb/iUPzHX
	B3tZ2oaZPAxN2Ez8cUL9f0gCHyZLuM0Tw4O7x4hrRltMOcGaEYSDMKUMGk+t9Lk41TPIYkSqK1A
	vXB6f1CS1VYFE=
X-Google-Smtp-Source: AGHT+IEYcV6g8pSrWp9gJnopoqBVCsEt0pmu0JfN5263UUfCpD9RJnczJUaoNY/BYUSo+GB2s8qE/g==
X-Received: by 2002:a05:6402:51ca:b0:640:eb29:fc7e with SMTP id 4fb4d7f45d1cf-640eb29fdc4mr2223377a12.20.1762268081332;
        Tue, 04 Nov 2025 06:54:41 -0800 (PST)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a70b50sm2235016a12.25.2025.11.04.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:54:40 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 2/2] serial: 8250_dw: fix runtime PM initialization sequence
Date: Tue,  4 Nov 2025 17:54:26 +0300
Message-ID: <20251104145433.2316165-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104145433.2316165-1-a.shimko.dev@gmail.com>
References: <20251104145433.2316165-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pm_runtime_set_active() call earlier in probe to simplify error
handling and add proper error checking to ensure the device is marked
as active before any runtime PM operations can occur.

Additionally, replace the const struct dev_pm_ops declaration with
_DEFINE_DEV_PM_OPS macro for better consistency with modern kernel PM
patterns.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 0ff500965c10..0c0a9fc97fe3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -643,6 +643,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = pm_runtime_set_active(dev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to set the runtime suspend as active\n");
+
 	data->uart_16550_compatible = device_property_read_bool(dev, "snps,uart-16550-compatible");
 
 	data->pdata = device_get_match_data(p->dev);
@@ -685,7 +689,6 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
 	return 0;
@@ -757,10 +760,9 @@ static int dw8250_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops dw8250_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
-	RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume, NULL)
-};
+static _DEFINE_DEV_PM_OPS(dw8250_pm_ops, dw8250_suspend, dw8250_resume,
+			  dw8250_runtime_suspend, dw8250_runtime_resume,
+			  NULL);
 
 static const struct dw8250_platform_data dw8250_dw_apb = {
 	.usr_reg = DW_UART_USR,
-- 
2.43.0

