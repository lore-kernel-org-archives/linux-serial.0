Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497627;
	b=2KXkyVT1AkdR5jiFuGaBsts4fx2VoE/0doYwdpfG4uaxYLq0Wh6MOxwCt/151QsaPkkJ
	 dKXVZoaqswN7SMVun5yxBxjGKXGkomDIqMCBDzmH1wFJqRC5gNf+o2hh6vgXOFOpGYidA
	 0fHO4zAxfClA+3OHfMRiaTZ3VAF0rthUqyyzOSiDaib37qT32Ymz/GVEEajbieastKUfA
	 Q2HGnoos1gCM88skAehgDBY8nUbOHqda26cReF/932anSqCtUXBQykmcrX9BAC0b/lmC3
	 TgrnuM6apfakQegVo1v/jB3gHLxk3QDOkNlPbEVutRM253HgyiLtArNtjG9Qr6afUKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gOHeB5d4ws3WTTlDcSY7S8wi2CUUdkygOoZR8h/O8BQ=;
	b=rO3kQS/4NJnbtnzBDHEFDQ2Q1AbUK9tyXzn8g2L8XfvCcVQVVkskIU4t9bOyMiYmOT/9
	 gU0YUI1SPh/atcn20pXcmEKyCuBsbldyF6hAhCgQo9wAC8Gp+Uw46Nn0v9AKRITEoz6E3
	 7QpvhmYQhEjRUCJ/UIosOG0vns+Z8zjUM9p1o+QP4Lbr0+mEFdEbqNgEwyULJwt+a5iiL
	 K2szXln0bsrmEXqm0gz6bKmDnW6LSQHrdXS9v7eRbaXmEeZC0wDTzx/xYqFe2xXcI7VMS
	 RscJDCEWWmbwmobcflqv36BPvmRhDBlWRWXCI1Z/DrByvfOqA3KQdzvTkOQ6Cd5rGIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n1h9wnUs;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610560A3807
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 15:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8610560A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n1h9wnUs
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so39063395e9.2
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 07:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497625; x=1795102425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gOHeB5d4ws3WTTlDcSY7S8wi2CUUdkygOoZR8h/O8BQ=;
        b=n1h9wnUs9bbG2WTNcgtnq21djsXCZZ6P+seSlzXn5nUhKbsFqP/qGNfeM6E75lv2Cu
         /ddQVSwlZrO8cPWVRyd/U0fMu5j3TJNRrdJCsJKZcZSKncDEYq/J0Qz6hVsmreF3mV/X
         tJ0UfR6PiZ1ely4JxcStXx17Dg8fRLVeMi+uge/0Y8KxZ8wt2bC8SSdL62Bt8gSSPCQv
         W1VNItGKqvuXDxYa4Pwoiyu8MtTS8KVDAxteohoFI5z6I4uBr/3iuNQNOsPufL19hh+7
         zF2DKKmoraXPIAIbSjXSL1dZxt3nB9oUDNCtksHcc++vfir5zqHyRYm9+kd71VwJRZQS
         Ib8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497625; x=1795102425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOHeB5d4ws3WTTlDcSY7S8wi2CUUdkygOoZR8h/O8BQ=;
        b=DHeoE7V1wLvx6rwcCemyvKATPVQjKG846ujMndOke8SROZHuxknxnhkBQP7cYTSfB6
         7pS081jCu6e0YPI5VXXGMLU55SfxSUAEWN2m3qWyp/EWi33pmLso/6HIThV5dIqVMACM
         nCAbKrAqr4JqhwRAdcLCBY51dAwHAcoFDqZ5PZ12OYtQIxPdCanKBf0nGBjnkEMSNVyU
         x+6xKKfvpdYRQvhOkbFbNYzmgjW4zoF8+gzZi9DF/jLIlC/duVUy+85GOOiVLWglQEOw
         YTtMG0q+qgOTOT8kuqbZyN44e4JE9O2OefeCyHAQ3wx/dNX7nhAfDuqErMvH3yQbf4qy
         fvRA==
X-Forwarded-Encrypted: i=1; AL+hErF3Cr/Skc8mbvzgSqG1f2rEiIIgYSzXGxrfKf3akwzLsHIkDYrJfrXVgRGnVpww2S6Dv0TIPYkNTvybkN8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CIC0LoQWJVxBqHFzZgw4L932xiYPRF8sbFj9CmFgG8QVHlhIM
	v5n3ZrRojXBhmeOfN0YGQPUZfP/Yluu2+FhOyQNsn2TXnt8SirsvO2nr
X-Gm-Gg: AYBFou2bVsCRIRO+GAnBojX8naFdnGRDCC82ZH7HKy46qsQx0OgOuZqH4Bpa19INARI
	On+Q/YNIP0Gd3dpuL2stsOFGsQwmwdNEfDoPH/PavM2goEN+Z7Lq2QDu2laeaQ1ebhoSl2yjDre
	EvLGfuELIUwrkYrfFxRfC9FfOOBMA0mWNZzcvoM9Pjq8coxQJtaJDHuEN0sPoz6n9Rp8koVBxLe
	4wS0FAYoVTjSBW/u8JDw4XZ/1I4aNJRw0Z2dMw/GpISAcU/tnuDXbnwKWrVUaU+VSUQFMhCdMH8
	rYM5mtE2d4SCEIw4uh538ISQOKRFjm79JXoCf9bd51YBjpPA4pcZ3f6yh6SUxyEfnf76YGS4xdI
	okZlcktrofdqd3NCjY7bJILzls5RbVLuQxGQcvVzNQbzynO0pR/sACVcN0kIvhLLW5ZQcBIn358
	qnKyjCwkoI6Y3rSlF2V/3Bx8S5qN5XsfynxHusM+wshQUiPegsE6G66xjkvCnd5dSW1SOZeh/Ri
	6b+zVBTx8IRzASEqDu8R3wuyv4ESD9OJI3lu/vjhPm9Xg7/HiGs4ExoSaleWwNVV4wi3VmNcyM1
	9JM5puay7yMW97VyXgAE8O5C2HrGe7BrpyeMTjDLAKifpp32/7TlyGYFue8AdeQsFeMeyuIy3oG
	9s4XFRg==
X-Received: by 2002:a05:600c:698e:b0:4a3:12fb:1ee7 with SMTP id 5b1f17b1804b1-4ba09383e08mr115598955e9.25.1794497624825;
        Thu, 12 Nov 2026 07:33:44 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2593e4sm87105855e9.5.2026.11.12.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:33:39 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 12 Nov 2026 19:33:09 +0400
Subject: [PATCH v2 1/6] serial: core: Add uart_console_port()
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
Message-Id: <20261112-vt8500-serial-cleanup-v2-1-36b258e0c0dd@gmail.com>
References: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
In-Reply-To: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599; i=alchark@gmail.com;
 h=from:subject:message-id; bh=axSnBeslNCexms4qsSumKGe3yRSirau1N9EJqbpzpbk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9veP5wMhIM9FtplyeqkXsedYffPteyhVOmmASsXyuS
 Jxn1WbLjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKZ63myG/1XZLH2TLTLO5O8+z5x1/HQnE88Lc87Z52/d8FRaFaR1dgMjw0ebfaE
 LKhm7D3sl7Tf//nbfL5OJzVcm3dM0OaDitTCghwcA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Console ->setup() and ->write() callbacks need the port behind
co->index. Most drivers keep a static port array just for that lookup,
and the few that skip it read the uart_driver state table, which the
header reserves for the core.

Provide the lookup next to uart_console_device(), which already relies
on co->data pointing at the uart_driver. The core links a port into the
state table before registering its console and unregisters the console
before unlinking the port, so the result stays valid in both callbacks.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 drivers/tty/serial/serial_core.c | 21 +++++++++++++++++++++
 include/linux/serial_core.h      |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b06d2649be34..683ffb4fda92 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2890,6 +2890,27 @@ struct tty_driver *uart_console_device(struct console *co, int *index)
 }
 EXPORT_SYMBOL_GPL(uart_console_device);
 
+/**
+ * uart_console_port - look up the port behind a console
+ * @co: console whose @data points at its &struct uart_driver
+ *
+ * Serial core registers a port's console only after linking the port into
+ * the driver's state table, and unregisters it before unlinking the port, so
+ * the result stays valid for the console's ->setup() and ->write() callbacks.
+ *
+ * Return: the port registered on line @co->index, or %NULL if there is none.
+ */
+struct uart_port *uart_console_port(struct console *co)
+{
+	struct uart_driver *drv = co->data;
+
+	if (co->index < 0 || co->index >= drv->nr)
+		return NULL;
+
+	return drv->state[co->index].uart_port;
+}
+EXPORT_SYMBOL_GPL(uart_console_port);
+
 static ssize_t uartclk_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 4eeb8253752a..9ac1ce1c10b5 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1127,6 +1127,7 @@ void uart_parse_options(const char *options, int *baud, int *parity, int *bits,
 int uart_set_options(struct uart_port *port, struct console *co, int baud,
 		     int parity, int bits, int flow);
 struct tty_driver *uart_console_device(struct console *co, int *index);
+struct uart_port *uart_console_port(struct console *co);
 void uart_console_write(struct uart_port *port, const char *s,
 			unsigned int count,
 			void (*putchar)(struct uart_port *, unsigned char));

-- 
2.56.0

