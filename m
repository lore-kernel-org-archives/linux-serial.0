Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485C1F80CC;
	Thu, 24 Oct 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790593; cv=none; b=ME90KMCzwnny2UjYbYBjXtsqQYQn3Uw7OrKe8g7gG+QXgU3E+UGBVe7U2gcDOh2ekZoe2PV/KXNvaoq81oWpDze1kv7yqjWLAuVUx+wlfbFVM4/ohW9Ni0VBTdwIN8TxbWerI21UKdc3xI37rdiHeLrNzXaPb3HbCSjcgpyI/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790593; c=relaxed/simple;
	bh=vT7bWknks8WP9eKxqVDkKd3XZCZMDxZnVgxD5CpDSwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ak9B3/SrvKgqPhTQOdEqFnSICIv7S4WEbtl8HQGf1IRAXvZW9nCcXnSXItzDkhNYgu0KsyqzsZ4bSEDXGG0cEP2JGV80CTqUrffDlLNueteMN00w0SPFtv89xEWjAz0P1awDEM1XqJfKwY682bZPSDJ+gRiPE/5YJaRuTrf9bk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eg2SDNWt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg2SDNWt"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720519c4e2eso90244b3a.0;
        Thu, 24 Oct 2024 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790591; x=1730395391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NBM71vD6WDqf0TCJvK6rWX4TDGTSUy4YN3C5hnGxHqo=;
        b=Eg2SDNWtUUVOi2cQPitopPw8HStkGZL0TLwPJnU7pKHJa+oWAe9hKrRNxB/pcnZLsB
         +MBhzthQlEU0iOfEvRk8TmfahgqqcBRa26IEOtkcqpe3C66G/A2VUh/qnPdywsQ+ulSn
         b7ghCiGjM7vabhma5V3gXW0YB1RIgmyJTCX3/kgxSIv4C6ufJcTee7wMcpCpY7PJy3s2
         1B8KtMKT3rRMxYe2rFJJU+FvkAwr9mGAmDEl/W/H7i1MyLz+CmDUMm8hn2tIH9B05zqY
         2NwP6zd8igIG2ywMZN+W8ngL64us1IjL83XUweYEdqv/NzdBEUAiXXVrQz6T1+yM7rR1
         oxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790591; x=1730395391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBM71vD6WDqf0TCJvK6rWX4TDGTSUy4YN3C5hnGxHqo=;
        b=vOQkjVr0+PSHPwPQI9avv+jB1AoV/coHxETk5meVrhg8hGv6vbTQKW79JpjPu8V2uZ
         XJAJxjqEHt2MrSefOwiuYfmGDBjonveMr6JrWQO7VDSIrx+H2xL/vZGxBgGrWxkbZmjv
         6krwbgNAUJqO40pcP3dNFqrqKzYsbDA3v33DjoQkhlM4arspti8XQwC0NUKSq+Nkra6e
         Y1O8IToSs5pW/LAeQGXmPFKoxmX4cl+NQ1pctGdMske2Tv1kUIqys7h6jJzlD2sv2HwF
         v8W0chlxb9uP2PQySrLG4kpvrSFUTHfrPOtoxi8S5ox5a6PddM4VD7+Tk1O3pJcO/gPO
         yubg==
X-Forwarded-Encrypted: i=1; AJvYcCV07xMrnxEfstTTWqDQJOssn+zGqOSEQD3YFGs/TPjRGHr8Qufau0TgCKl3dds8Emg/xZDRT8B+w7OOM+E=@vger.kernel.org, AJvYcCWFJ3CamyP53mEtYYx/NMXeV4X+m9YeZ07LMrxdpfCr1RO8eIYriUI1GWyJ12n7P9yOgrn9ZAYkGmVwfR0e@vger.kernel.org
X-Gm-Message-State: AOJu0YwgldfM7onpKlQYttnLPEsxmbEz6gMkgspKSO6EDKOGxulvjlUg
	eJty6lPGt1pTreDL0V2BRyB00PlI5xxIECGfziM9LDI28Diod9un
X-Google-Smtp-Source: AGHT+IGVo1RaZUfhxMDG2y4ONxaW9Mm/VearOH8rgYdvQwVVjjmjcPfVHGU0nhenMc+XNZBQnF7BEA==
X-Received: by 2002:a05:6a00:3d43:b0:71e:8049:474e with SMTP id d2e1a72fcca58-72030bc178bmr9500663b3a.26.1729790590929;
        Thu, 24 Oct 2024 10:23:10 -0700 (PDT)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132fef0sm8258816b3a.63.2024.10.24.10.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:23:10 -0700 (PDT)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: richard.genoud@bootlin.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH] Typo: Fix typo in atmel_serial.c
Date: Thu, 24 Oct 2024 22:53:00 +0530
Message-Id: <20241024172300.968015-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected minor typo in atmel_serial.c
- Fixed "retreives" to "retrieves"

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 09b246c9e389..bb1978db6939 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1166,7 +1166,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
 		port->icount.rx += count;
 	}
 
-	/* USART retreives ownership of RX DMA buffer */
+	/* USART retrieves ownership of RX DMA buffer */
 	dma_sync_single_for_device(port->dev, atmel_port->rx_phys,
 				   ATMEL_SERIAL_RX_SIZE, DMA_FROM_DEVICE);
 
-- 
2.34.1

