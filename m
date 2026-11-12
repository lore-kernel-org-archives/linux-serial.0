Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497641;
	b=r4qc1GjzK/Pv9pHoDUZ11lfZEofPvWKgpKt+fLgqtOkFJRjKtDkBry8yQ8uqHI3qV8Fi
	 +qVgr2WhQWJp/wFayDoa+0qtm3c6SLKKK5eQqbTUhlHm7V+cS81+5m9u8fl17ucxhG+Hz
	 7DvzWsjXo4KD37cbup8AtfKe3N5md6upJvGTd37S9MB+f2zEzYyS4dYAEjF4FtkKp22OJ
	 FUn+vyTu8U16kq5OrFn2D/1ZZ2sOdLg0c8K/kIqqzTFyS5gloLNdS19BUsDMPy6JAw2ct
	 5amQABPN+2I+B2XU8hdkNUE9YUl1z78cMFVuiNmY7Sau5LyuibD093tLCR4RXKKTFMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6lC9fobCw8jtySKuvUyiU/10ib75zIoG1CNd+i9ZAGU=;
	b=z88u8XqkHIYLdNR7xX1meQS9BdJPBXRB0Kp1Jws9jrs/XX6cUh0p8VT3FlXzEqGDp9z+
	 ogrMjWkz/MzkW+7pnHuRzBX8WOPAREJ8/fo3BkAcpczRWuB8Y7L/j2+YI7ysDOp6bA0cw
	 XXbBDOhXbOSqqPanAHw+RyJlu1YdihRmRLbt9E2HRW9jOcP28GfnzXK0OxO/6goTkkFEF
	 yZtJBHK1SUZ9+JET9sQ4biMg/kFNpv9Dgwszke6C/1D4UDM3a3LiQCeXgHBqcoPUTxMkN
	 DN53F2urD6U3hmy9YKhJPmCi8dQYTa3oZPa2ht93OAdNd7eIqA+W5kEnd22onWzwTSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EokDPv8x;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678F606A89D
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 15:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0678F606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EokDPv8x
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so48142335e9.0
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 07:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497639; x=1795102439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lC9fobCw8jtySKuvUyiU/10ib75zIoG1CNd+i9ZAGU=;
        b=EokDPv8xKSqSlNX9ETMSGbsztjgoWIdnSbgwLZlFpc3HMtyZTokbSKgZN4mWoU0uzE
         MUCSAh6WltB95VqEz+zVH4BmmcdwT93k99XWkelkaD8EvE6SdfxiaYzCmG7mh5vNMimg
         7U6V/HeIXlIRikEI92dq62FEzvFEuK34ErpsEv2aqnPwY5pfyUhqbjCiAFzZ4eqhLRn6
         2gnnIyMA+Y53ot4D3sREtol5p9EDnPEQ1up21a1WQNWKWmM57Mw9fGNwghUovWAv35Sc
         pNmASa1xZWspTA3/fABLO+z/Blq6WDuqnO1OCKiYlsUmM8S33hA/xUaoxN5hWlemg9sy
         B7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497639; x=1795102439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6lC9fobCw8jtySKuvUyiU/10ib75zIoG1CNd+i9ZAGU=;
        b=DI8PRWG9EAuflMf/YmB50/NJ3PRY7DhsH//rJofNCfkPhysEY1Qe1yGYmRB09KAHG9
         LEY4lPubn/EM+0Hn3CEke+GBox277JwfZOY+HpuePQ6UQXj0Cgcc0uG+7p3P0ctxAYKv
         WQ1jwN7REn06wWWTs/+7PhKW9/z/aEQRbk0X8qmK8aGJicbMSkFGQdQ91dGxK87igf2t
         rMGTKDj+VdpFqRHjghTGrAcJxcw5l1iiwXGEa1BwUs0vTvg3QEHCCKpE+XwVkL1SViZj
         vnQLYvlN+hm2MJLEY2AbRh3yEnOB/VoVZQ/sZcs1cPCecYtqQCF3Vh34PdG5tcdBLGxH
         ODFg==
X-Forwarded-Encrypted: i=1; AL+hErHIimY+6oBqIEL+6iyc5EdKux9jOGVEY5SQr7OglyDl6leb93vfUdHijFjY6gpgWQo5Urjl1Hwhc0uWG4o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jToN37k0Bu7YoJsHWGMyTj9P1vCSL8AJiCuM8Mz5Tgv2/ccG9
	xY9wIMr962Oe1H/3WwHG4jhcBpAPVDYu4XWBCxNR/cha+IC4HiiTauVe
X-Gm-Gg: AYBFou3mqOuIOfRT/mSFsI+prQL8b0beEb/XntlLSmaGde6Pw9yjn0AsrFMONxF6nWQ
	2Qm6tFtJ5y26IiAwnUK2JXvwQJC0XCNST7JyPgKYxJPX9AZneTK7LPOz9kTzthU5MsDFFd0xlME
	Ydgo2IzUdlN99C0w2q/p6hqZ5WWyNkp/Ni0zBk42aunXTMpXWyWxYmckKkJkZAnOd9sXFvSWywN
	m7Bc4C7t8KeeZHON9UFQfG8yPdX1h9C5/Vvu+Y7CkzTkEkSPyDS5Hf3waVSfQjgSUE8luL3Ojvf
	6YGkdfewX90OruZolaqGccV8qggA4d7XX7pbCOPoajMMY3NZcEe5Wsdpm0JiLT+z/7gRXD6ewhI
	EfapLlSPU9vE51u5hZHKjt00kO2DIMIqlWui+XfqaguwrjvVqTEnS5d8icHV+pB+Ociyv14qL7T
	9OhiMkgAFoSQsy1v6IoiIH5XTAYRxW4yKyKrl4+nJEMREwj7j8641S5lpn/CDc7DKKe31iBpVOq
	2sx1IGax1DLBGt1Cv1Pm/YyXbbEeUaamv4YonrOMe+Xwgrj7zz62REaft8DmMPPPdDsH23G/MSw
	SMkIjVPgWLBewAZk7sgTHkqeZsnLxG2mr+rJC8tz38wDSk/54jbWrYhxSKbfArqcBQGnQolrGYi
	6jj6nCA==
X-Received: by 2002:a05:600c:e558:20b0:4bb:4b30:8042 with SMTP id 5b1f17b1804b1-4bb4b308088mr60698665e9.19.1794497639340;
        Thu, 12 Nov 2026 07:33:59 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2593e4sm87105855e9.5.2026.11.12.07.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:33:57 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 12 Nov 2026 19:33:12 +0400
Subject: [PATCH v2 4/6] serial: vt8500: Drop the port index bitmap
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-vt8500-serial-cleanup-v2-4-36b258e0c0dd@gmail.com>
References: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
In-Reply-To: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3072; i=alchark@gmail.com;
 h=from:subject:message-id; bh=jcZiVN1H4g98kKKxKtvLfwo5DJs4n8bgP8iSaXWS7PQ=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9veNVbnW206G2RPjcydy2gPKuWSVLNTMqt6RvDzt25
 HHy55jjHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEy11D9GhulSd9anyf49pKkfUaeiMq/uS/NlzjdFh3w7rMynn/G6Kczwv/aaJYs
 025G1j19l8Ch1hTznyC1fN6O5oT/qgl8m0/cyDgA=
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Stop reserving a line in the vt8500_ports_in_use bitmap before probe
acquires its resources: nothing ever clears the bit, so an early probe
failure strands the line, and a retry then fails with -EBUSY on an
aliased port or drifts to the next free index on an unaliased one.

Keep using an in-range "serial" alias, and otherwise let the serial core
pick a free line while it registers the port, so that a line is only
ever held by a registered port. That also stops an unaliased port from
taking the line of an aliased one that probes later.

Fixes: 4001130df1a7 ("serial: vt8500: Add devicetree support for vt8500-serial")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-ca000721-4a5b-4d88-bdb8-7f1e438dc81e
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/tty/serial/vt8500_serial.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 4abd4a8d5ef3..0c8ddd55f94d 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -90,7 +90,6 @@
 
 #define VT8500_RECOMMENDED_CLK		12000000
 #define VT8500_OVERSAMPLING_DIVISOR	13
-#define VT8500_MAX_PORTS	6
 
 struct vt8500_port {
 	struct uart_port	uart;
@@ -101,13 +100,6 @@ struct vt8500_port {
 	unsigned int		vt8500_uart_flags;
 };
 
-/*
- * we use this variable to keep track of which ports
- * have been allocated as we can't use pdev->id in
- * devicetree
- */
-static DECLARE_BITMAP(vt8500_ports_in_use, VT8500_MAX_PORTS);
-
 static inline void vt8500_write(struct uart_port *port, unsigned int val,
 			     unsigned int off)
 {
@@ -606,29 +598,6 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	if (np) {
-		port = of_alias_get_id(np, "serial");
-		if (port >= VT8500_MAX_PORTS)
-			port = -1;
-	} else {
-		port = -1;
-	}
-
-	if (port < 0) {
-		/* calculate the port id */
-		port = find_first_zero_bit(vt8500_ports_in_use,
-					   VT8500_MAX_PORTS);
-	}
-
-	if (port >= VT8500_MAX_PORTS)
-		return -ENODEV;
-
-	/* reserve the port id */
-	if (test_and_set_bit(port, vt8500_ports_in_use)) {
-		/* port already in use - shouldn't really happen */
-		return -EBUSY;
-	}
-
 	vt8500_port = devm_kzalloc_obj(&pdev->dev, struct vt8500_port);
 	if (!vt8500_port)
 		return -ENOMEM;
@@ -661,7 +630,11 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	vt8500_port->uart.irq = irq;
 	vt8500_port->uart.fifosize = 16;
 	vt8500_port->uart.ops = &vt8500_uart_pops;
-	vt8500_port->uart.line = port;
+	port = of_alias_get_id(np, "serial");
+	if (port >= 0 && port < vt8500_uart_driver.nr)
+		vt8500_port->uart.line = port;
+	else
+		vt8500_port->uart.line = UART_LINE_AUTO;
 	vt8500_port->uart.dev = &pdev->dev;
 	vt8500_port->uart.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 	vt8500_port->uart.has_sysrq = IS_ENABLED(CONFIG_SERIAL_VT8500_CONSOLE);

-- 
2.56.0

