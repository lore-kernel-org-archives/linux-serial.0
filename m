Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183B455199
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049108; cv=none; b=P8bZJ0jx5oT8lm/BWctzk+Elh31KJV1WRTwpkxYEWmqmP+pKp2YK8XL7Ux9SzCHhGNSamft4nbja7U81PuHKwPxXLVoTG0lopTO3/sALrEbkVlYuPox0XkXJy0XOh99u+sFS/tYOEDl9m2wtdLSSQ4pQFrZk9HPL7EgbVBp+pSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049108; c=relaxed/simple;
	bh=MB7LGi5bia5b4s3lqho08nciPjjAh60PaTv8Fxk69LI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2quut/QtUZgvRhc0M/Ht8QVEQf1z3uLCYYHXtzS8cSnpc/pjKDoJ7yoTcb0XZTCV58ALuO/XAY2ByUZPyHYRdR4dhjWzKw5HgONz1UQ7fVk0+a1eM69T3UQIn1yCy1go8jCwBDPuk2cG2blocxZS946E8Em6oWAJik/Nqj17P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=ZpPL1hBN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="ZpPL1hBN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b966dd74so29945665e9.3
        for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 03:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049105; x=1787653905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SehFAIGV4EScw1eNaWWBsUyEtfJAkEOaG1RHubt8kHo=;
        b=ZpPL1hBNAhh9e7Fa/gznaduk147YgM/1Qp/GspKesEv31lYOAL3WB8RPrvzF9l3HT8
         wEdlYcwLFohII7K1oKz/7/dGnczF0sXAgQsDkMfxoN937zUaf7n5m1IlwXRuksn8mJCF
         EqdmAFR68dY0nQ6kIQw+cZy8RsBycZCXaXaPett10qOfxZ0QP+aEk+J6pZJfbAsYbc4d
         Bt6VOvWkJFiHkIxcmlzpGwL3d40HVaxKFtOLr4gMnHar7mD3Nf2KMsCGu/vxACBEkDr8
         0z/fbpRQDZQjDW3/omP5FfT7LTXypYSOVCcPySNYTv4EEJycD8SqkW3K7BPxw1gnpAmk
         AZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049105; x=1787653905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SehFAIGV4EScw1eNaWWBsUyEtfJAkEOaG1RHubt8kHo=;
        b=Nq4yzjiLZo+L2wh/PKAFm8P/X9OIRn/ENKuOEBCGXaLzpFNohJEfIHfqpCCRVZrdXR
         AvRBjEEfLmNq/GMApCV+nN72oNnkiwZ0hYqGjJX9QkBEbHHT2TJOsKXCjXQ03ym1sBw7
         0pjTOiwpvO4pYz1X4MMd3FPL6yiwjhdyQlB1lOlznTg46FUG8n8pbGvQYohu6oBizz1m
         Fk3MrjwA2Mez/Clx9/trMMFgacfYLgRB5Dxye9Ym8EF992Zp9qGhoK+8Nz0c+SbxRFVO
         D+EU7kGs8LtFGBGnAAT+6dQC7VlnfI+yVvk/KzzIMahbNj02EQ2ZQRstw0BeieJFwYdq
         wkXA==
X-Forwarded-Encrypted: i=1; AHgh+RpkLEmYJg43szWvLkJcwjfIMn0gphQXUY9vp9I2AWvRg5kgFU1HdyVSt3d1t1KadpAjsYFJi0MLoSSrgq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpyYogyiLOrCoa7z2N0lzsWxv0RJyhoZbyrynoPCb554HA/+I
	PKG5/qqOMtOptCQBslpRUdn/9Ix5lZ+7cO2sgIwOlNOTOmQAzJGJZ+6JSAODUnN3ICM=
X-Gm-Gg: AR+sD10BKq6cmpUKDXPFtPmSCA6OPz8CSSCe2SEyQHjpa9XRg8bJyhMgFfhjfalvhXN
	q6HZgpgnPW2pJvqhuG9ZdGUEJiUFgJHTVaEK7ZesbO2TvGC9dh4EUppkIUHbJfEelK+9CyqmpNq
	efBQq9R1RtbXiZL7ci/ogHFslpKgJWmSMel/q5DzHGqJ6zHo0bP1Z6GKpomh/n7GDL55OqZWUWt
	8lPYbAzrrWWPnKQLV/QUoY/M1SZ/7UD+zdmGS08XKvYQNfVbsxDZJt6hS3KTaXZ3PBv9z/JyHyH
	41FkKhJU55Fh9E42N2ZN1odKB+HW6+683eVuYMRnsNRFkVuscImhYySU14aIxPjLIOwv1L21hvC
	K8CsEfItNvFAxD9BGOKicY7/69Q6SOB8S4Rp3xvoFdT4tVVjvgRp5O1PETmyiEJTiAVPxAz1+fP
	5ftDDYyJTGe1XWKdsjdqgRwhsqWM6DxEaqcYhCQoQjlksHsY21aaw42k3mXymnWbg+vVu03rn+b
	Pyk/tG2DqYmPqsLRIt0J48iZVRJmpzePN6PHPqROVGBSzHO7fBrsFtu5M+S
X-Received: by 2002:a05:600c:3049:b0:499:781e:25fc with SMTP id 5b1f17b1804b1-4998792e359mr338967655e9.3.1787049105086;
        Tue, 18 Aug 2026 03:31:45 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:44 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:15 +0000
Subject: [PATCH v6 2/6] serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart
 compatible string
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-aspeed-driver-v6-v6-2-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
X-Mailer: b4 0.15.2

Make the driver compatible with the ast2600-vuart.
Enable specific configuration for the AST2600.

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 26fc0464f1cc..6afa2f4057e1 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -560,6 +560,7 @@ static void aspeed_vuart_remove(struct platform_device *pdev)
 static const struct of_device_id aspeed_vuart_table[] = {
 	{ .compatible = "aspeed,ast2400-vuart" },
 	{ .compatible = "aspeed,ast2500-vuart" },
+	{ .compatible = "aspeed,ast2600-vuart" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_vuart_table);

-- 
2.54.0

