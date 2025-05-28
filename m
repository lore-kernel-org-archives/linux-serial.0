Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932991A23A6
	for <linux-serial@vger.kernel.org>; Wed, 28 May 2025 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748413583; cv=none; b=YZm88bu/lV/h5Zd29zOOomBFivFV4nu0okxaK5wzh/iUZyWeBCTlSfQC4JINb110zhNcpUtKuoiePVUzZvu2xauSADBANSvjcDYaY7PpjEoeRo9uJRiwdM4manhNLlT+6B0WyXgz9yaqXhjrYzw9+0T0cNsOKR4OVKtwZSVddeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748413583; c=relaxed/simple;
	bh=kVXBJy2waXc8Zm3U1zeBkK0QCDtIv0VCdcWVejgqIaw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Y9tZS/qWlXh5aevirA0/91aadPKPMC3XFOhnx0dlu+V9vOB5wMJ0FQPB5KrFzaRb/JtPV885/yL7TTwIHRVwfcu94cDUbiFaAwkFku4tvnlW8J9CEUW1vXrrvluWfShSYczk5WjGCz03TI/rFwxZVR9oNV58MGcQFx5wthYfSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ewSpP0y/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ewSpP0y/"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so439754b3a.0
        for <linux-serial@vger.kernel.org>; Tue, 27 May 2025 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748413581; x=1749018381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJQtmBORsLul2V6MNygZMp10lRlI52BK+PKHssMFRlI=;
        b=ewSpP0y/zWP6dzyhIJbggeIjxYShxz9NcHfqBwijmiCUiVlpPSEUZscjH3SXlKHHaP
         jwuKUo8j8vUl1+OTjcce97wf94Dlb/RZDU8dMDiiGfI20QzMh8+adwq13Vt7+/H+KDaZ
         zh0o6vIBJuHWAuz8jIH3p/H5mbbjJ8PIx1ByguzXqIVk6hcnqR4Oq2Qio5/S8Hf+KE2B
         yngoFAhIVy5dPjBD3nyJa6wdxqbvJ+wuyHg6yNtVgHofiYoBzuRVtwxvPjWVBGiiqXNd
         oqAxY3d7Zb5NBlZV1lF63Y1B6exbZsRzjVL45dmJLAbgjocS8135RRnYCVLMX6DbPjoR
         7PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748413581; x=1749018381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJQtmBORsLul2V6MNygZMp10lRlI52BK+PKHssMFRlI=;
        b=sY89JcEAMAqtXZP3rKOmU42onFrDtQl1sCljahnVtExjNA3mQlXS5Ca2uHgxbf3quq
         a8LO9Xzr+ODQBH6pTrtRLaTXTx2dIYKe/4c4HtsCX84eFWgz5pX0UAjE6HhKtuXD6nHi
         0Dx9WKNPq5seCyWj/ypaWj4svK0oynzEk7wq1guL9N3iujIQGtcOQ2HoduKbpsBz5sfJ
         pNcjooBtxv2AVKkrylF2i1yHe9u5HvE1iUNkW3oGUE7zgUiez5JeA+iVza2ZL/ci6T2g
         icHntvdNxKqUTvS7gRytisMvTGwWmvWLMCcZ1rEpnYBmXGm1xFRy+84Iw/kEo/asz/af
         G+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbZz3KaFZVsqvDhUCfLMQNpFj0VXQasNy3WE0E4AKZ0RUB8pTNQUHAetnbUEX/jL5w/Q0wHBU/SXBMJp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxgpbuWKNoEhwqWaZJPzNyk8C+i8b28dooKb4bXDNiyOZPq6Nf
	vfXRZgmtPJh15gwYrs+ILirkSoPj938ACrFUccqN90hNVRm+TLzHeX6Tyad7Qw2ZKq4=
X-Gm-Gg: ASbGnct35LtgclyeJMJqvNgBaDtaQcA6AGufi/ZbsGbd4Rv6HHSg/v36poBaa9+GJsb
	NShSZBJq8TpdY33TMyIYR3N+OMs1JnuYZIJ/dSHL5dOvRxcma+70A9kpjTNbsEeax5UDG8EibCw
	mIODjsEkhWGJhd1neOshajjYrQjWCvCi1v5/YHIjURVI5i0/XUP0W3eBOwLl3EFh65niNKbjqjR
	OqnslsY3niSbQMS7ND2U4DpyLdsu9Ytf+JK9mFeaOuGvkMni0kkljfC7H5QQxf8GCofn+1YrvNH
	TbLFjRCNFTyDLaSNN0iU+jQP8xvyDWvHPANWuDQB4D31UgSbuIJYaoqDedTzu/JGUGDwvjucoI9
	sgOv878CQ8A==
X-Google-Smtp-Source: AGHT+IG1r91+7tI2/CIrBwPliEl4ShQJtjrlA4mz6gCB/b9+fF0Qvdsp0MdfXtmq8J21fWN5WqE8Qw==
X-Received: by 2002:a17:903:3d0b:b0:234:6b1f:6356 with SMTP id d9443c01a7336-234b74b4c95mr53731085ad.22.1748413580666;
        Tue, 27 May 2025 23:26:20 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35acf6dsm4619515ad.201.2025.05.27.23.26.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 May 2025 23:26:20 -0700 (PDT)
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
Subject: [PATCH v7 1/4] serial: 8250: fix panic due to PSLVERR
Date: Wed, 28 May 2025 14:26:06 +0800
Message-Id: <20250528062609.25104-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6d7b8c4667c9c..07fe818dffa34 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2376,9 +2376,10 @@ int serial8250_do_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
-	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
 	uart_port_lock_irqsave(port, &flags);
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
+
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
-- 
2.39.5

