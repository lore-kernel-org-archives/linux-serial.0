Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D46288CB9
	for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547358; cv=none; b=aIX19H4px6f5j7MuTQZv/epOEJrWpr0NLTPUen0o1ugSWwzOA37IPmQHc53onQsHIT85jOIrwhaFQgAi1wGgUAZ6UWu4cC05Xwgpiny5Kh+HOYHLRGbKgKNwCKHPciHq9f+rABIG1N1TWs8GIykh70QOXOUzB70Z73M2jSR8TcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547358; c=relaxed/simple;
	bh=wS0CLPtfhOm5b92kf/uhx1Ra/XOqdQalM0tptjFMS7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GD7FILiHAxuUm4KucEeg+WN5u9K6toYrq5UjaC6cuBEK5MarfObRdvqbnopDLiFyOZIxbiU8bX5xjrbbY4T6IylNPCAWhJxSAEdxaQnGQeFQch5cX0RcikDyjQG8GFU+P0LffOVqJOzwkacs/3ymYfEtZQ4oV01QDesWuew+7x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DEWwRNAf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DEWwRNAf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2345c60507bso36604075ad.0
        for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749547355; x=1750152155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va3siO387j2VoC06GK/4QFQK9voTcsrvQqeBKNKR4Iw=;
        b=DEWwRNAf0QB2d7GkzvpEDbRUyXqhoQQ/vHt80SnhzPnM7GUUyESOHyNPXAkWKlVIxu
         QeMWeeAbkCYiik3qIN+4ufsZB9lPUSX2fkytzQ+dsWX11E4sJyzH8DOKkfTyCqJBGYgy
         Gee0TjotVAdPxmB0+H1pWb5qNMM541rpYePFR7oXqN7OKaCaBN+FYc6iqL62FQSC2HUP
         7s15EUrFdXLtxWxrEpERwq4XyiMcN/fMfgwmwCUitSE3eWJRciRYeBHSSsrbykwQpV0N
         3Tyiteh71ern4CQtx74JD9VbpOhtEMfpXR21CXU7ROPJEXpiBGa0aNNZetOUegbHt4uV
         xGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749547355; x=1750152155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va3siO387j2VoC06GK/4QFQK9voTcsrvQqeBKNKR4Iw=;
        b=ebZX8lv25lwdr5l1Irb3LKvzuK70PKZTY3nqgdjRLteRX6GzhvUm0UQq3H7R2EOHtk
         +gBxyMgLmHu2UO5HVNmqQ+KkrawSRg1Jn2CNKu6AlREjLrv5THn5zQAOHd45wo4zTjgv
         RWFWoqxDj8bO/oQvI28c04iC17INi1K9PIOaxdHiMT6xUzMlfxWAVquQqEEvBWNIHZ4b
         KvvAjmzFAi1mib94mUJ4PiIt/ZROoEZZ5TbQWWi9JPho7QCIsRzLDdB5UGQm2PBcc2LJ
         uEXoSZGnchG0PgZEl2i9k4txzbvYTYzxXhIyFDNEBjVAoP6A68+dArlIDNsiy5Q0/q9G
         Cfww==
X-Forwarded-Encrypted: i=1; AJvYcCXZJDcCkm3Y0i63mrOaRv8jSIwrUD6MGv4e5/g6OAdHH3FCqDAmcvHozi/OfxeklPU25PQqZM7H96o1wEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMw6yBst9S0y1j5cKGUYsvdtEwnj+UxYmVq027x/4xcVCzzgdk
	Pr/9Lk+0cdlpbL//C3ptfNhKQ/Iq4bdwOhUcX/py2H+cW0zhGg+n9+yREhyB+1/CCBw=
X-Gm-Gg: ASbGncvQDapZwaBD1lKD1WKysSDacIyFLb0GP+By5siPC6cvE0hGAUKteLVPi0rhyL+
	1oSwSAp9tp1k6xoo1yeKZeHKszwKSDyrPKE1C7FVvID3xWB/uft/IWKEsqT8F3aoLt5LhOvjlF7
	J3T2Za7A4m++cagXUMpoyUkzqcvrp7zccjQina2FTYf5auD/53Fr0Fp+mzlwIWHqFH0eJBsdXwR
	cuSM2Aw4pQgCXZh/oEFGxT1TgG+z76W7MdklJPjJcUY+aoSc1tWN3xER14mjm4DwkongRZkApAQ
	t145uEKenCIh7n1+LWo279nH+0Q+kOYcUzRtoSOzV9VfqEnq5F8BPjtdY/iL9YdgsqJkA04BcgS
	MGBZzrcIjpFy+KcpKWqBJjiqG11oOE3MoTR0JXRsEmQ==
X-Google-Smtp-Source: AGHT+IGbJIHfa2t3hQ2mUqrjlD8bC5fxJHJIfWVyoLl/p5BzNAK7pEuE5ojARq5pOZZifArzHeM8sQ==
X-Received: by 2002:a17:902:ec92:b0:235:f298:cbb3 with SMTP id d9443c01a7336-23601d05c8bmr191836805ad.18.1749547354908;
        Tue, 10 Jun 2025 02:22:34 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc9ebsm66968605ad.106.2025.06.10.02.22.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 02:22:34 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: arnd@arndb.de,
	andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu,
	cuiyunhui@bytedance.com,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	jkeeping@inmusicbrands.com,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	markus.mayer@linaro.org,
	matt.porter@linaro.org,
	namcao@linutronix.de,
	paulmck@kernel.org,
	pmladek@suse.com,
	schnelle@linux.ibm.com,
	sunilvl@ventanamicro.com,
	tim.kryger@linaro.org
Cc: stable@vger.kernel.org
Subject: [PATCH v9 2/4] serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
Date: Tue, 10 Jun 2025 17:21:33 +0800
Message-Id: <20250610092135.28738-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250610092135.28738-1-cuiyunhui@bytedance.com>
References: <20250610092135.28738-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DW UART may trigger the RX_TIMEOUT interrupt without data
present and remain stuck in this state indefinitely. The
dw8250_handle_irq() function detects this condition by checking
if the UART_LSR_DR bit is not set when RX_TIMEOUT occurs. When
detected, it performs a "dummy read" to recover the DW UART from
this state.

When the PSLVERR_RESP_EN parameter is set to 1, reading the UART_RX
while the FIFO is enabled and UART_LSR_DR is not set will generate a
PSLVERR error, which may lead to a system panic. There are two methods
to prevent PSLVERR: one is to check if UART_LSR_DR is set before reading
UART_RX when the FIFO is enabled, and the other is to read UART_RX when
the FIFO is disabled.

Given these two scenarios, the FIFO must be disabled before the
"dummy read" operation and re-enabled afterward to maintain normal
UART functionality.

Fixes: 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_dw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1902f29444a1c..082b7fcf251db 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -297,9 +297,17 @@ static int dw8250_handle_irq(struct uart_port *p)
 		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
 
-		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
+		if (!(status & (UART_LSR_DR | UART_LSR_BI))) {
+			/* To avoid PSLVERR, disable the FIFO first. */
+			if (up->fcr & UART_FCR_ENABLE_FIFO)
+				serial_out(up, UART_FCR, 0);
+
 			serial_port_in(p, UART_RX);
 
+			if (up->fcr & UART_FCR_ENABLE_FIFO)
+				serial_out(up, UART_FCR, up->fcr);
+		}
+
 		uart_port_unlock_irqrestore(p, flags);
 	}
 
-- 
2.39.5

