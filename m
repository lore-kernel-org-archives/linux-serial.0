Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD430FF30
	for <linux-serial@vger.kernel.org>; Tue, 14 Oct 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442472; cv=none; b=GWJ0ajpYDR2ONSAP5e7BDwjIq9HXIcPv8cQ0jMjdzcfk7x9aRvd0J383YVnKoq1hPji5wLtP3Wnk/H+DjMFd8s3QJ59EuivFwY29ioymAe1RNqd3QI/oQd4/oy677dkdSnX+s4EiW47kH5voLnzYb4xr2M2Q48k4U8ssftskDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442472; c=relaxed/simple;
	bh=Co7cFHJGgPG9rCr6E7oygAs+aPpLYgTiSC9rPlo2r3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ERbJwpUw7DFM6wPFLq0w6WkkjrhEJhrcsl65+ezuWEO1rlNpnqdzCqLlEmcVCbGUOOw5YXSxPqsliXC9F5itVw0L4Ol28Y5VLZ1jaDXxp6PWPNkDlcEqwTknWsa8lAbpbHQTTigWYxl6vts8k/GGIndUYbC7w3VljfjJXv+/Vk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=loH605AG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="loH605AG"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781206cce18so5406237b3a.0
        for <linux-serial@vger.kernel.org>; Tue, 14 Oct 2025 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760442470; x=1761047270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mPcMZxR0+lz33DfIEWTqyg43P9pNhyUOM9QOLXBPj9I=;
        b=loH605AGC78aBr2tgfalp7w0kMaMcdfPdH3TL8/xnTwVpuKpKJi4y0Doso2hwOSoWc
         zh5uP2AwQMjAFxCNrSfEWCOOeB3hUKqyb0xB6D6DKl7lyTAYkQCNhU6BU8bAbhwT8ZC9
         fze0SHgk6TMaHJj2LsjO68qy+Upv9/WKRl2wNji1/+5xl4cvWhIPUUV8sULytENwtBBg
         7nuZjVmVa1eVG6bLipcJ0RbdJvy1Uoq5Va53Ivu6EeLVM/yKOjS2tkl5FoV3iZJUcPLZ
         TLeb/qHVYZfjbotdQ0oChRqIqpZhSHOmDrIL+nyiiEgF8xEOHR24pct99OQIIgph0Lk+
         hGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760442470; x=1761047270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPcMZxR0+lz33DfIEWTqyg43P9pNhyUOM9QOLXBPj9I=;
        b=ru39PC0edeE0njLwzlntvcAAXN1iSu3vwwtiKLIvG/QSSGkDqrw2Icqf4nuaDR+Y3p
         DQaIq4pc/B9+3ShtTRSKdMfxqdXOpJYhAGmybZskfLS0+oa1LTzgwqySzRawjWpoF9TY
         ZWr5l//OU4Dtz9FTAgi1E82yMVsLD3JcEh94X1dG5ytfJtx+9yizAVeVqk19FWT/yKIK
         S6R7w5Amk/lxta1OMHHrXB4udLMrFt6iM4FwBcYTCGA9UnUfW+i3x7oDF2Q6YqN3rvrI
         yqA3fxmlc6gTz1PPA1/hKwtXDsNuiHFTuhiYkqrK6af4zDGMZwbWqZC+H824MXbFLpzh
         VLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1IO/20klzlEoLJFqA7YRlOOtMjURzi4O939iNYTRjM/k/zTyoiCQFn6BJb8ZtfEKG8uIy4VaBd8qp3QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpIhdTQFmbThDvwzH9ZKa4v3pITZR7HOaxPo4vTRU/hgPPHbL/
	sXHXORVpbM1aSBynakShEQ0jam9AQ+luKcO2EeHGydKZSaE+QlZrGXStToT9G86XgyxjAEgaTPs
	q3Wq6TGQ=
X-Gm-Gg: ASbGnctYBQKUw1Va2Icln9ECwrthXrzeAnVnpJQfKfH94168mFFg/QtDbtS2J4e1VR7
	QrRJOEt14tj6uuTlLzJDRKHgeifVKgmc4Y/ACv/GEu72/gsGvbygofgaZuv9n6q6k2RCYwknD9R
	92ICXGe9Qo49TcGsOplVX498Kh/69m5YBVFK+LdIZQ9VJOCgzyR7KAMyVSQiNAjbFg0n9e15ibo
	4gXjHGGnA/CV5tbqdoCOxGToE28hz9yBoSNP0e6R60kVMFIaT/1FQqIqWYZW1xat1eOjT0mamYB
	Mu6yijZs4xhu0hoOBz4oONHMBBTD3GY+AxXB6EkIFFYHe8x4lGwqRVmb8aCS4OXY4daHgYvkc4f
	OeoqF0woZhjiWIv6OUk+OeiyQOOQQ/iIRb3BvEVGrPpQXqeAfnkSN0hNmE5sCJ8kObvImZIxV19
	vkXKy8gfl7l+SOiBDyis8u
X-Google-Smtp-Source: AGHT+IEJ/Z4BcFcaDskM94Iyrqcu0UCwbiA+isEXzRBD9KhGU4ru+KvJ4hlRRGy82ez5z6OPxuufAg==
X-Received: by 2002:a05:6a21:999d:b0:2cf:afc1:cc3c with SMTP id adf61e73a8af0-32da8f7b6c4mr30979496637.16.1760442470439;
        Tue, 14 Oct 2025 04:47:50 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0966d7sm14808111b3a.40.2025.10.14.04.47.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Oct 2025 04:47:50 -0700 (PDT)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	songmuchun@bytedance.com,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH] serial: 8250: always disable IRQ during THRE test
Date: Tue, 14 Oct 2025 19:47:27 +0800
Message-Id: <20251014114727.1186-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
has been set up") moved IRQ setup before the THRE test, so the interrupt
handler can run during the test and race with its IIR reads. This can
produce wrong THRE test results and cause spurious registration of the
serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
short duration of the test and re-enable it afterwards to avoid the race.

Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has been set up")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 drivers/tty/serial/8250/8250_port.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..addeef7a0d59 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2147,8 +2147,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 	if (up->port.flags & UPF_NO_THRE_TEST)
 		return;
 
-	if (port->irqflags & IRQF_SHARED)
-		disable_irq_nosync(port->irq);
+	disable_irq_nosync(port->irq);
 
 	/*
 	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
@@ -2170,8 +2169,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 		serial_port_out(port, UART_IER, 0);
 	}
 
-	if (port->irqflags & IRQF_SHARED)
-		enable_irq(port->irq);
+	enable_irq(port->irq);
 
 	/*
 	 * If the interrupt is not reasserted, or we otherwise don't trust the iir, setup a timer to
-- 
2.20.1

