Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E71E1DE7
	for <linux-serial@vger.kernel.org>; Wed, 23 Jul 2025 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753238018; cv=none; b=EONBCjMUKR5Cp2CG+v+wb7AtE+ZJa2ktqXUG2ETudeCJsVx90sJAPwagoo1zx+f6uT5zhp8oDoN5NLDmvHJkSTrc5a0cfa5ITd5CeQQVxMEiCOeL+SswZIaSFhglr8cDLflafpQWj583EgW8ox093vwCNEGo1MaO3Wld8XxiABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753238018; c=relaxed/simple;
	bh=SqF492q9Kp82C7tym/WEovxGbqtFyhfwFxqr0W+j9Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IA2Av97M1N6M8uoN+PQJAvo1At5l7ZnV6W/0QAakXUiHrSYu6bZlGOPfU1rJ+O7/JmqPnCfm8iHuBRXdlCsDmx/oVq8BIPE28zDPFpkFeUyAX5PASJZsAxR7ASVO9DXaIMjnSwS60U+lbkhkCXYE7sx4c3UvX2fjWdyCEuHokIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dBXdZBY7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dBXdZBY7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ea292956so56787045ad.1
        for <linux-serial@vger.kernel.org>; Tue, 22 Jul 2025 19:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753238016; x=1753842816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI974Jb0wm0kSmb50OjDAjQveAFQOS1fTvXMINV5m8o=;
        b=dBXdZBY742Qe6eu3o+2wDaSvfIIreToWinwBW7Ng70yjYMJy685LqI6zuvJ+m9OzgO
         7wHGrpsSDbensDb9PbJB3RfFSGZZ70WJJHa4inD1lg94dE1fKWxvxAc5b2xFAGQLLd3m
         LOe69i90kS+gO6Uq2LvwtdEa1UubJZO+addWVv9KpixTxIEk34JMvsNAFjalGL6VJqLo
         1ZdibaJ17mpEebeYASDUHdIik6VXistwsntwOT2gKscDSn1JfZkRpSrV7zJOOpqflJ5L
         VVfVuh1AMvwy0PzEgwbBPy1cM6y7/+W8Z6tKIoUOkoDIf4+BV6Q2aEe7elBUJ23NXMuo
         3Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753238016; x=1753842816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI974Jb0wm0kSmb50OjDAjQveAFQOS1fTvXMINV5m8o=;
        b=fOfS2girnu6j2tCozZSULNbT5UYpoUtQH83x2mbYJRnmxbkAQwntnZDIEjqeiBC7I+
         HQieg9rediJ2RFq0QlcsVk3hSmuRjZ1OG4VC8LgL4G0ce08Jqg000tUMYNMI2MS/f0W3
         gfsEgZobroOm+D+NM5bmzECgzW349Wxh5ZjXjzbGzD1g2n63tY2UuJfNVeF/StPOoxIx
         n6Zg1qhR/3bKEpGE7uis02GZgJdwOyQebr+xywqZF9M8puUYsLJWI/1qYRMywvDPKpnJ
         9XeoiWkTs4mM5gbBpGa6nReRO5L9JEg6IJSk829ZfB4jkbCd/wc3jZ+7TvpRMdG0JWky
         fO+g==
X-Forwarded-Encrypted: i=1; AJvYcCUGJX+GEiuz9JrFZffC66Bq0WC3HMUQKzaSodglnsIweiVnY18iyKx/OLbhq9ywxT40NbyjyAQ3mmJQmEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEis1DGbUBJgK0W2gpZkYFs2hBMoVfnwYEsJ7ru29+tOhkYXOT
	ptqdpNwS7xYBkpCkbA2Plxem5sKz+6+FF2/Ysa8sh3O79Os5D+mbFVJeYJLW6o27LRo=
X-Gm-Gg: ASbGncvgpLRivPdHPEqu5U9S0eRDqjSBUxXXQ9aa8QLWpufaE7kPJWjSAe5rPbnl44w
	eD1jDx8JNDvczn4vPk4o+pAup5zBCoSGZOGUZokCH/mocEbq1ewkdwKQIKf3gyX41RE3OP5D7Am
	9U1fblRjTAiFyF2Vs04UBNI/dTpFGK+qx06Xb+F2Jktmhs8skTF1RJvr/ssobBXnvQS1zElF/Ut
	CXxSwkwxMDLxP42Slzx2HybGTFx5SQjRv5ytYj9obAje9uEh2a78OObbJFstgDuk5HRpllt5ue+
	Tu5RwWVw8OZB9a+fDKE9NQKhIksYxZQAuRXC7HGYc3TWOaXcw1Kq8HXiCLmz2akY2+URr9pNMJS
	trq6R91AOe3Yj71Y1c+eL8cpAdZIXHrr/Li4Vw5wmGzbdlRn3GlRbRcqy
X-Google-Smtp-Source: AGHT+IF2KZMu9tBJ5eQnwYDzw6P9UXzyzYbdG7iFoo+7BGUm52xEPh6annNbtlg5BtEsYH8AFeKVTA==
X-Received: by 2002:a17:902:e785:b0:235:880:cf8a with SMTP id d9443c01a7336-23f98149b7bmr15717685ad.15.1753238015655;
        Tue, 22 Jul 2025 19:33:35 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d2a77sm85325795ad.136.2025.07.22.19.33.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Jul 2025 19:33:35 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	john.ogness@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	matt.porter@linaro.org,
	tim.kryger@linaro.org,
	markus.mayer@linaro.org,
	heikki.krogerus@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v10 1/1] serial: 8250: fix panic due to PSLVERR
Date: Wed, 23 Jul 2025 10:33:22 +0800
Message-Id: <20250723023322.464-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250723023322.464-1-cuiyunhui@bytedance.com>
References: <20250723023322.464-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PSLVERR_RESP_EN parameter is set to 1, the device generates
an error response if an attempt is made to read an empty RBR (Receive
Buffer Register) while the FIFO is enabled.

In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
Execution proceeds to the serial_port_in(port, UART_RX).
This satisfies the PSLVERR trigger condition.

When another CPU (e.g., using printk()) is accessing the UART (UART
is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
(lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
dw8250_force_idle().

Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->lock
to fix this issue.

Panic backtrace:
[    0.442336] Oops - unknown exception [#1]
[    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
[    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
...
[    0.442416] console_on_rootfs+0x26/0x70

Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7eddcab318b4b..2da9db960d09f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2269,9 +2269,9 @@ static void serial8250_initialize(struct uart_port *port)
 {
 	unsigned long flags;
 
+	uart_port_lock_irqsave(port, &flags);
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
-	uart_port_lock_irqsave(port, &flags);
 	serial8250_init_mctrl(port);
 	serial8250_iir_txen_test(port);
 	uart_port_unlock_irqrestore(port, flags);
-- 
2.39.5

