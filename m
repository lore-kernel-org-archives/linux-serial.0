Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24A331237
	for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224990; cv=none; b=eC1KFa9gfw5rKEstzfHR7SfW3/FGDx+CCMxwKBHRRRuKKXsNRacbUXl0MEB90qSGm9wd/GpsNStDcOvY2JGMJfAXlUp14NR9UWFvu2n4tzfb1sQP8SGGl8Pc+EncBek8qYJ3pMX8thxIHRYni5XxNeSZmi5cNdUW9roxAhCucEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224990; c=relaxed/simple;
	bh=7il5GDO7kTOW6jqS+Mumwj/X/fmS8K5D/UJr7JfEaE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opCkV/IsrwMF7oOWA/o64vqs57n9Zx1+OE15zon6zvfdydTEYp9Xb39or2aSQw4tTikASW/jdFQyz0h67bzEtnkhMXfRtvQRdh6hUx/5aggB9577TjQFNjj0aaXNZ68WpE3z2bDUxM1mLFxw7UTRloyMv/ID5XPOvNPnn8d76tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=ZwId7PxD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="ZwId7PxD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b9318997so39432795e9.2
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2026 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782224987; x=1782829787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVmu3f7j9ByFGe5OedcL6Pz7umApHSUq7F28TFt4Y78=;
        b=ZwId7PxDBkxuNGrZ1/XmPSt0HpIgtIOpc+93qFaFP870b2yn2rArgvwabnZuQhXYzU
         bcIYYrJpGenfRawIPFfcyRku/JtfjlRoei/2AAEvjKngotAJZfCHn0mAhytA49Wj9PZA
         +4mz5fwvxMxckLhg8gicfhhxxAPDg0D72IOEwCfJmIj9t/Bx3tcSmR/jI16yHDVtsl7v
         DVHJvPLV5oXEHdcZBR2YXedeeaEEapkKLaDuRUbcf2T2ayR8xx1XmJCEbYpaw2uGCnkR
         nGON55TYWMSFBagRz/yptFCfbJ1JyeDnDL7WdnLomNklw0a5Smp6mDu2EDLUd4lqEf5P
         kPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224987; x=1782829787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVmu3f7j9ByFGe5OedcL6Pz7umApHSUq7F28TFt4Y78=;
        b=Srm9OOsaeR+q+NYEI3LKb22YZVXf0BVoX5QCMXIWLzKrTz/UbWtbSLLgeHBK6QAYyc
         NkPlVtSu4G8ZDbkSoyGAp6kFA7xhExY92QwnGqO1E8WP/xFUZ4q2nOqcamx75W/h5qi9
         ehcSbkpaOyG56t0rya76EBsK2Iol1nMU9SkgEIhocnPisGjyWwJKuzyz97Tgx4nDaQK9
         Qjl3PqKxeqRm0xnF+9wVXuZHfEjFqxhHClAQti5TYJuJT8yCHadFfHoIBqYybgWbzd7V
         Ad3XB11sdlO5iE1xnlNYRA/TzjD1JiJpBiXl0NeLbahIOQS42fZ2qqKrm5ZBd4qN1s4+
         PRBw==
X-Forwarded-Encrypted: i=1; AFNElJ/iFi89PdDEY6ybmkoUl6TPWNa5NDfZ116mIILP4fOyyZ219oRF4cmAGLPJzHW0/bdPt/JoUUuF0l3tnXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSO7Vv657/po4AnXZWXgVDa9cnu2yXakSj4uCtUrqDr2ot8Nm
	rNebfqJLlUy+BWSNqCLRsHWnivBzK+UF6xIVouQD0HZZpVuJ/h8IWKmPiFMMOPEb2bg=
X-Gm-Gg: AfdE7ck8jU+edzevuQJ3xfNKHYqCu1kgLNmvDmWrHb8CyNtBSz+2Y4unExsClJAPrKd
	s37L8C5ZXJEbqSnaZ4vmzhOvbc7Sm1+Vpd5594c+J29yYmcu8Epp5qJrDJy0IrPImFfuVlTTloK
	Bs1C30Oj359mCkoO59Kujh1liT0NlgCP8xZN23cDt0NdN+KOyovVf9FDYpi079wighlABeHHoHy
	8nQpnu33rqeu5BBaVcwtmFVmoeSsHPedeDfg4jBxOOF2QohyXC/TQUZat2FvGSh/wBs1Chbw1bl
	mQQi1+rriaClq2nTLo6J0mgT1RMZIFTLs6j/SbLExLPlS48rGJLklIs1kVJSvaTtaLwPlpKtlcV
	NvKIenFFtqtVyDW5ios8TXOUkqgFpfj6LSMYiUrpN+TYxnPu+vOkhIf2/FWi+GESYg46FmrlAEk
	BebhCP0yVVg5T3ESsPOtmAL27mfqisgImWJNN0QCu8xLYShbJp3NwbzieuQN5yk8SYncXdD0Lj+
	FSRjQEIYz1jpAlXvQLwcWnSlpqt
X-Received: by 2002:a05:600c:8b18:b0:492:46c2:f5b9 with SMTP id 5b1f17b1804b1-4925b389c2dmr48178725e9.3.1782224987165;
        Tue, 23 Jun 2026 07:29:47 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm362507805e9.2.2026.06.23.07.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:29:46 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	linux-serial@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v3 3/7] serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
Date: Tue, 23 Jun 2026 14:25:41 +0000
Message-ID: <56c378923566ea0be831f58fd7c2f186ab3f5cba.1782224059.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782224059.git.gregoire.layet@9elements.com>
References: <cover.1782224059.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Makes the driver compatible with the ast2600-vuart.
This enables specific configuration for the AST2600.

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

