Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D917BA6
	for <linux-serial@vger.kernel.org>; Wed, 23 Jul 2025 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753238014; cv=none; b=QvwS9MH2CSHh7cCGpbfPPC+1j7ouLrELxn9srcOfK1MmHTTV5rFQo0k9NbtJ2k65Vhi/W06ht+VFRtyJlDcSke6ymrwTeRPvLF+L5UmkWTNBgOWJ20rjBs4gxiEDhjlvwbQ8rxtc9MaheGPnki+W6jZdEOdr6XJ3lKB850kcroY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753238014; c=relaxed/simple;
	bh=QYnDkcFxjUc1p8r6rcSKnVWJbbiet0m3swroFTjL7Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E2TZY3zOArEHbq1cv7l3gzQRJoxQBmA19dMaEKgddxoN79FhCSMfZgyebDvbBk6qPrIRDrkDCdyasY6HcFQF7KyoPam6pK4o6XXw7zpN2tVBFn48AIkkHm/luiZQCSVYASp04PJ+H7vE+PLA77YLE1BuVqgwdB1UyRZFG2KNrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FVGTAJk/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FVGTAJk/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23c8a505177so56746435ad.2
        for <linux-serial@vger.kernel.org>; Tue, 22 Jul 2025 19:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753238011; x=1753842811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULYSExyofLDc1Jey4lDATUb3dL+5bvIFG5PP1qslaiQ=;
        b=FVGTAJk/G0HbktGGgCxggFQfOCWPWSAECJLTjFEuSz/pBMFx48uPi5S1Y3QjA4y2/+
         Ggs/DSZ+BRGIdF4miiILXzTQftbU4Zod2JxHiNPL4yCD/4vWzKlMM0e2XXeQjuS3Keep
         4cJnVxhHMeBmFu5zBDIZri7viK3eyejLrxXBgIav6mp6p0x8+nogAl7xIIxt3Lbx1hMc
         /I6r+E9KKxcBEcpAv6oY41smQqmgp1ZrYt1mWblsbahm2Fq2+B1DmbM1k+v2y2Ha+u8K
         FjFF0jeq9gl0Gf2ZKxJwcCVRf0we1II3GBP4+pAnq2yUJs3tJOdncHn5xshnJVHPCGQE
         B6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753238011; x=1753842811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULYSExyofLDc1Jey4lDATUb3dL+5bvIFG5PP1qslaiQ=;
        b=PKTfqdTbKLm9lVPYYABZAv4ALxr4iI8L9f6EYCGSODIQV8Aly6xVdGFOj4bnKcIBZQ
         09Gise02LJ2tTNgZ4xfSpJFfXVdenhsIm3u4vYsHQTJUCXMKuw1PA0w3S18QLdf6PbwE
         79ZuLp7x8kkZd3RwHsW7ku/HO0EzdVhV65cEtpArZ0upQ9ecK3EEfpzN8YVzSF5euKC9
         K0VR7275uR3V9nkmpSGdkbl3MYvPQbKNA9H23Vc1cWozVoLaRmK7qIq25oAmF9WKNwS5
         SqQz2JFU4pLy353xLNRScZbhAZ7U7Ksam5aRaR/HIqnm6z1EztT5X0AklGD3p2jT+3K3
         1d6g==
X-Forwarded-Encrypted: i=1; AJvYcCVo4TTVkGEAGP00Fas4pCREUSvUl4qqUsAAi8XWWVVC8xuWJJQj+H26ha/21iXryTQROCJ4EbstUlvaSjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWfjX1e9mLqn6KW2xuF5gJlQ0iGGa8sqGYFxzZh+d3dd1Keep
	nlZ2goIk+KWf5nS4zqH6Z6g1JyP7+GiK/Y6QV4GbQrzdytnFerxwE3oOTnmLYWg/4iY=
X-Gm-Gg: ASbGnctRjrtWFHSMA1YYq/YSSBZndsQXbCGTv/0RBkuk0Lm9/sH9xZsb8goFgKWh1XO
	CdQJmxVZeiirlTUgnkvdaVhNCGZIA9WLq2Cq/1SvuaO59D0gfpgw5T8rOqQNPY3BLSAN/tcbDdP
	AxussBVM0BH7SHrKosjnm5h+p0GSNsVKBA8XZUzaKwdTllcbEWk0wSd+1tSr0EKZanwXTXCkdTN
	ULMvCECiIhQy/fg7s77WvYzI/Q+u1L9PtzC3KVtsOumJznzYL4vHl9Z3Sfp0DB3vmWJHBU8v96T
	aqXqCG8Fm4KH4SW+oljnHv83a9ryjYqo/vE8MpBI+DZ5MKtj6PS6GbilLf0DFxvGkcCb4Irs810
	dWj+0lT8aNfNI2myG9q5y13o/MNtoYz0lMx6dWC6GBOuc5XeS4t4yWGFd
X-Google-Smtp-Source: AGHT+IGJyNSioORUhw/HvAVmarOWBL3jmQwch7U8T4X2neBD4U3MGaYZ8bCJiZFEmgEyV/X4v/y0qg==
X-Received: by 2002:a17:902:dcc5:b0:23f:9a4d:2764 with SMTP id d9443c01a7336-23f9a4d28bbmr3496675ad.30.1753238010866;
        Tue, 22 Jul 2025 19:33:30 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d2a77sm85325795ad.136.2025.07.22.19.33.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Jul 2025 19:33:30 -0700 (PDT)
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
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v10 0/1] Serial: 8250: Fix PSLVERR related issues
Date: Wed, 23 Jul 2025 10:33:21 +0800
Message-Id: <20250723023322.464-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cause of PSLVERR:
When the PSLVERR_RESP_EN parameter is set to 1, the device generates
an error response if an attempt is made to read an empty RBR
(Receive Buffer Register) while the FIFO is enabled.

Patch[1]: Fixes a panic caused by PSLVERR due to concurrent UART access.
Patch[2]: Fixes a panic caused by PSLVERR during RX_TIMEOUT conditions.
Patch[3] & Patch[4]: Improvements to minimize the occurrence of PSLVERR.

v1 -> v2:
Added UART_LSR_DR check in shutdown() to avoid PSLVERR issues.
Added Fixes: tag to reference upstream issues.
v2 -> v3:
Added lock protection in more functions (e.g., autoconfig_irq()) to
ensure atomicity.
Used lockdep_assert_held_once to detect potential deadlock risks early.
v3 -> v4:
Introduced serial8250_discard_data() to unify data read logic and avoid
code duplication.
Addressed PSLVERR caused by RX_TIMEOUT.
Split complex fixes into multiple patches (1/4 to 4/4).
v4 -> v5:
Removed reads from UART_FCR, using up->fcr to determine FIFO enable status.
Removed return value from serial8250_discard_data().
v5 -> v6:
Based on latest linux-next code: Resolved redundant dont_test_tx_en code.
Updated comments and git commit descriptions.
v6 -> v7:
Reverted PSLVERR-related changes in serial8250_get_poll_char().
v7 -> v8:
Added Cc: stable@vger.kernel.org to patch[1] and patch[4].
v8 -> v9:
Reordered the patches: bugfixes as 1-2, improvements as 3-4.
v9->v10:
Patch[4] has been removed, and patch[2] still needs discussion.
For patch[3], although it has the "Reviewed-by: John Ogness john.ogness@linutronix.de" tag,
a problem was found when rebasing to the linux-next top commit: 

If serial8250_clear_interrupts() is modified to:
static void serial8250_clear_interrupts(struct uart_port *port)
{
	u16 lsr;

	lsr = serial_port_in(port, UART_LSR);
	if (lsr & UART_LSR_DR)
		serial_port_in(port, UART_RX);
	serial_port_in(port, UART_IIR);
	serial_port_in(port, UART_MSR);
}
It may not truly achieve the purpose of clearing interrupts, especially
during the second call to serial8250_clear_interrupts(port) in
serial8250_do_startup().

static inline void serial8250_discard_data(struct uart_8250_port *up)
{
	u16 lsr;

	lsr = serial_in(up, UART_LSR);
	if (lsr & UART_LSR_DR)
		serial_in(up, UART_RX);
}

PSLVERR is addressed through two methods. One is to introduce
serial8250_discard_data() to check whether UART_LSR_DR is set
before reading UART_RX, thus solving the PSLVERR issue when the
FIFO is enabled. The other is to place FIFO clearing and reading
of UART_RX under port->lock.

During the first call to serial8250_clear_interrupts() in
serial8250_do_startup(), which occurs right after serial8250_clear_fifos(up),
the first method to prevent PSLVERR is satisfied. However, during the second
call to serial8250_clear_interrupts() in serial8250_do_startup(), the FIFO may
have been enabled. It would be best to prevent PSLVERR via serial8250_discard_data(),
but this might result in not calling serial_in(up, UART_RX), thus failing to achieve
the original intent of clearing interrupts.

Therefore, let's submit patch [1] first, and discuss patches [2]/[3] later.

Yunhui Cui (1):
  serial: 8250: fix panic due to PSLVERR

 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.39.5

