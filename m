Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467041;
	b=yzL0LrOxYAdtG4wUZlUE+Jytn0bvy6k8x2idcCus5Z+MQuFQWjBhCje9CmwIjYV7t8AP
	 cWH/yeJJL9ehfCM5ody+/NRK669IA3qjN6gxk3OyKhoKkfO9N8anjfyEmULPswFuMUENq
	 0RZvFf9kpHmyeCLtob2zx+cx+uMVB9EAbNMIQuBc5lpVV95ZpELq2yRliBEwFvj8Vhjal
	 ajRqku4hMEHTGsBLjRrqiX7wiGjac3wsTzv8eBO9md53aG+ViHAFiWzlPnwLbDudRc7IL
	 wxtnrQhizyld3Luq2BCtgNAh8HzDpEpgFXNerCKMCaqkIFyCZPM79SDQyIh0xTKIfOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p+q3LFIMHbm/nMce+FLXOK/M2t+rToT1SbCyE/uCano=;
	b=IrnbGVIggmZBct1LLcu23YA3qygNV6Iy6lOqhC6VEXs5fRbiv5t5dyryXKgp02hq/KnX
	 jKXJhODnYdr0PBRHrr1IEu2qJKIXOHQuTNkER9SNxKDGE+HS9c/kvaRevLl6SNte2uYs4
	 PGNczMLjUGsxYueuYcad6l44+kVWz6dABjuwQrBIVoTEOzobrTfooCvEs6HmIwO3S8Nqq
	 lrAn5um/uPGU3I9fOVaNdHifkrL2xk5VjXUiFhgOz8w5BL7rZZujDbwcT7rt7c737vVZN
	 yUDsG1h9dW0wE6Qagz2ogR6JLLcZPy7wj7LEDs0oFlzGJLjrOfV1FQgcvXIxouWaOsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="W/CZqpJK";
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868DF606A8A4
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 07:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 868DF606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W/CZqpJK
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f3c8958d5so451914585a.2
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 23:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794467040; x=1795071840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+q3LFIMHbm/nMce+FLXOK/M2t+rToT1SbCyE/uCano=;
        b=W/CZqpJKA65YtvxwT5MNQLZEU0BhUMGSqQ0F+WBRSXAMuwkyGFtMhx7Dpg/Uw7fY52
         kr1QEZYGJ/tVrF/2FOF6XduooZ1qqpF3r/2HdNSJ/0XfaFxvRAxzEGj2vb+xyfmXz9qR
         aV8KsGDkvRtJGts90nNF9iBIv5AMkRtUrh2X/90fRKNYilocVj0vcsTQHfzxwkRfPNRw
         Je2D2/JM9q7j/Hvr47aRQpoRjvxxgIiihCh7klL85KZBPj2x8uYvF4yYMcz7pZog7I3x
         2uz1BtzoNq62UkmSmXm7FSk3bEGEMrFhxjUiXgGLDRlu36RWfiP79uSBQnftMnXjocPM
         S2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467040; x=1795071840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+q3LFIMHbm/nMce+FLXOK/M2t+rToT1SbCyE/uCano=;
        b=DfAF452ttOfob5NoMo4dba4BIzakhlVNXtAL/eRTB27MxbiqEWK5E4sVHJ8Hf4yvJF
         +AjuZ33KTOPsc1mnQAfV1AyHSfVCyoZ/HWXONKlPf79M9tVDfc8dDHcF71RPl5DtXYwL
         XIFhpyWv6NnzYG99ooqVPgnUFCoCPWJ45h/N1ahpKP/A09D8Qv/M6qZM4XO1JL/93jUC
         VQ3nhTHkegU7wxUAX6W+sXy1v6wZE0o/cWJFM+s7zFrvgipfSAnN59V+hQClkQzpqkEw
         Q4jdwT1RQXDc92uIwlhbW596soRKJm4Fiqh8okgBCvMRmRRA2KH/rKlkXNpHpRweKN9Z
         yI1w==
X-Forwarded-Encrypted: i=1; AL+hErGy7bm7do0WZpOMQEk460O40VSSP+t/8M8e7NI9FkkdE0bYzII7F5e514XJZBhMHr8bAewhoizXeXg0jNE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+STHFVcp6brdNGqybQQExgPt77OBO5ccBZTXCtvVQfxVOazzZJ
	Cs91QC1TTbiaJ24vSpH+N975gPjO0nL6w7N161cDW+gYH/7Xg/wjvvY=
X-Gm-Gg: AYBFou2vGQiwUSnjka5hdEDJ4RfcS1oXGIdPJNmg6gw4z5jnTwFeIIr5JlTBQuSTrPV
	6U+1170ocNoB3xDxcUtjVZjaLtxGeXwzrWBaZunXeE8t5ZHy7ZFqdPNT6fNNs+FSCstuvB3qW2k
	COtWNpPjERTPSDu3UGy78wUyIp7wWFuDOaDu+3beBQxNZSzKqCPCO4uCpT/alrnhISw9g1g1f2I
	rDCf1skMx3DPiSIuzga4Pzdhcf0/vPojlOOEiCXkM/WZl2oQAca3cNODJPBFMNLzjGICSPRniDd
	3mh8N+KKx6qk4CZTyZxYKoJK3y+nFKnuDyszvDG2Ewy0XfKKLsnaEj9dRYxkd1nza2mTg2KQEdl
	h3OBs+ZUPWtS6dvrZHtqDRFBea+0Mgx+h1/KfbkqYmhjIlWSWz3tzpkQtYp7KxGJgEvETr38u4T
	Xx825AB9byoDjczJLSnmPKjVmFO6H8hsxDBpAjDCNPZAf55Z2iguvyE21vTsY5GEwd84TKU1SDP
	dMdm3SvOJ+ir7QerVNYWLiZ9iNgcyiGPCIjqmfui/n4f7eKeZfEh+pQqYCIzSpftwLcVkTf3oDD
	K95jkCkyz+uQ44yNzVJ5FxPVXoXDr9VXOSeVMq7McchiNSAOag2CPIUGBNeNi5+h/CnfcWPqts7
	irXhKOgy4fJ40uEyW7gqQWm39mbsiNDzwjZgfpmp4c6CB2cNncoCzu7p+WAAneM8rR9wBthT1zK
	2mlO5Od0cxkbooSgkqGWrrO/0dWcDHVrO4Bw0Fhh+lWTNt+I13/grKyQ==
X-Received: by 2002:a05:620a:460e:b0:93b:ef24:bc8c with SMTP id af79cd13be357-947afff0a6amr852657585a.47.1794467040229;
        Wed, 11 Nov 2026 23:04:00 -0800 (PST)
Received: from localhost.localdomain (h16.44.55.139.dynamic.ip.windstream.net. [139.55.44.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7f2edesm663463585a.40.2026.11.11.23.03.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 23:03:59 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] serial: 8250_aspeed_vuart: shut down the unthrottle timer on removal
Date: Thu, 12 Nov 2026 02:03:57 -0500
Message-ID: <20261112070357.38870-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

aspeed_vuart_remove() deletes unthrottle_timer while the port IRQ is
still active. An interrupt can re-arm the timer before port shutdown,
allowing its callback to access freed driver data.

Use timer_shutdown_sync() to prevent rearming. Keep it before
serial8250_unregister_port(), which releases the register mapping
used by the callback.

Found by a static analysis tool under development.

Compile-tested with W=1 for arm64 and x86_64.
Not tested on hardware.

Fixes: 5909c0bf9c7a ("serial/aspeed-vuart: Implement quick throttle mechanism")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---

 drivers/tty/serial/8250/8250_aspeed_vuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 452bef82bec2..0776675b8382 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -552,7 +552,7 @@ static void aspeed_vuart_remove(struct platform_device *pdev)
 {
 	struct aspeed_vuart *vuart = platform_get_drvdata(pdev);
 
-	timer_delete_sync(&vuart->unthrottle_timer);
+	timer_shutdown_sync(&vuart->unthrottle_timer);
 	aspeed_vuart_set_enabled(vuart, false);
 	serial8250_unregister_port(vuart->port);
 	sysfs_remove_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

