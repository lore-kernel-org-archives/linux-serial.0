Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794235485;
	b=i5toHNON80/x0Y9N7ZMI70P58qxcy7McXo+VhJ4cn2nzDva3z87uKJJVw1fpJql1Ccsj
	 HmmX8xqQVLsj6Z4AudErynqWU0CbwXKHqtTf3aAa28/LLrteVQyAPrzUd83fGrlhO+KaH
	 8BV2qOS/1rXkBknvEaWSNHj0aQQCSAS82WiVhx6KJWWUHlthX2nE3cy5NJnV+RiqWCaiL
	 qBoQxd51/Fkmp2At80GrqBLrgKCoCfdjGAiKnCMXXzQsJkYISWX0hq6ITgD+9B6EkXPG3
	 G48uPYjlpy50tbbPn1mn2juKzMgvzOiP1wCgk2A49xMs6CIDWKBrskfaqvB5fDq3IVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235485;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fsb5m8uyyKxFLJlwAnbap8+GD4wIrFORIE3SZs3ZMVo=;
	b=Dhj2ZT39y+Z7A3tf+6M9H9oj3mNMuseqFPX8EkNSzE18i6QkxWTa95fKNab/ObIuTdY0
	 8lOhnVEnxpbWPCKEBzQq320ZNjffF0qQIWmiNJ7CAaCYBFL/ByOYyH2TZYE3Iqz1dnScU
	 d7Qz7McmQ5qThSbngc1N1Lk/IWFezuwfBZBco81/3qp+7AF6aIo1T3MeLVKq1p8gzqrfv
	 VFM8+TCe6vKmynxBmOB9SB3ekf+A2UxstwpmmxDetQhvyo4qFqM82ZiSP0bvQ5GY5mgMI
	 vfrSeubDugwJyAPVn6WMExmi8FWH41mmjKzqzp6lTeR+DGcm+I2mtQsRrvtHGtWmRWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMBxRQI0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7AE606A321;
	Mon,  9 Nov 2026 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMBxRQI0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794235484;
	b=yhjrbbsh2duDWcroTpZpqxGrJwLlHaQziuooKgtaCJmXPmagxQkrtZWrZwXsVnS60Elw
	 F24aArwEq4T7NgszDPixHJtLl2dE0Ai/cAI5zZR85D4dpOd64EqV4lVjvlVmylP7QZizU
	 5DY/vgpIHGEsPEl0SAxaUeDFr1NRpyvSShs3BOiMZACkcZrqAHN1H7SMRIkaNyA2jKySl
	 g5/76fg498B4erCCQtlIkl4HJ2go/o0urNn6DjiMLMl0JY38/f8wNEL/AnWgYbjdIPWDB
	 YGluDUChBafY5RbQB7pAWv1REA+Qb2EoU0Vn7E4YQMsRE64QIy1iYPvuKq09jl+H2OQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794235484;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fsb5m8uyyKxFLJlwAnbap8+GD4wIrFORIE3SZs3ZMVo=;
	b=wjemTBBjOS2RyBSz4sgKIfGQ/s5qQotb8JR0ruUdPP9LzPujivfmYu6xKLDJksaGelun
	 y0WPFcS+NAA09CGInd0VHcsYLahd1/hAXHKN3/WOLCMc5G5YvpMBzsGGrYw3hoUPFcx0E
	 3yaJJZEGV6nxwvh9ewx50FfSc6j4+FymGSSjj4w3nFrKk9/sGBOwsdX3oW8TDdFuh0lge
	 f7/AgvyMoJ2CsNb6EezKYXfY9xMGATY/JqIgCONspggSBN/Bi4tap5b9j2NathP/5xcmn
	 WGmvDVql74h6R2PjU91omg+cZ49k1GICdtqoMmFMjgbIXkltSRnA6NsGFXNcwF/e0vw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D996A1F008A1;
	Mon,  9 Nov 2026 14:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235484;
	bh=fsb5m8uyyKxFLJlwAnbap8+GD4wIrFORIE3SZs3ZMVo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dMBxRQI0llMdrBh6hP6xnnUoTgY15KtNT57x6NshNioljgg9bEmJIP9yS98SXkqOT
	 3x1mja5NN4MjYSgIhKLjGb9reHv/1iZ9iUjxJ14m+KVS+e25k8ZflnDgQ1BKPKIlDe
	 ut0Az7UTPUtztQfy+4RqBTcAQiWVAIsJCtgiG93Q3MT2l6vxcHEN9hNVyg9FOpkrSv
	 JYR5sVcuAc/J5JRz3rAGghie4kYxu8qpA+UBZN16ef45IiiofOoq9i3Zov2xRhCZny
	 Qxh6pATLuJq7EyCXZxlAyLM3UWHI+CI5wVtl+FBzpVdMV0xGM3bP4GHMI77UyT5Tv8
	 KHebWqDxFBYag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 587FD48501;
	Mon,  9 Nov 2026 14:44:43 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 15:41:00 +0100
Subject: [PATCH 2/2] serial: 8250_dw: Select U6_16550A for 64-byte FIFO
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
Message-Id: <20261109-8250-select-u6-64bit-v1-2-04bc8332fa34@gmail.com>
References: <20261109-8250-select-u6-64bit-v1-0-04bc8332fa34@gmail.com>
In-Reply-To: <20261109-8250-select-u6-64bit-v1-0-04bc8332fa34@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>, 
 Miroslav Ondra <ondra@faster.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794235482; l=1747;
 i=cleverline1mc@gmail.com; s=20241112; h=from:subject:message-id;
 bh=tbchbKgf4kvxbU+PFwpYUbA6/5DTF0wZIBoRBHeTq0o=;
 b=orLP3TrrB5XbdCVxNkTqhcupcoB3GSd2j6ojGBCGcI5BM8ZlnWV2XkvAZBQ9gF2MXQEi7dB93
 bzVu4JHI50IDYkkU6Rog+KjlWtj92H5Gl/jhz+nmPZdLGYmi7SZsbtx
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=EJoEbw03UiRORQuCiEyNA8gH1Q6fIpEWnn/MyaWOWX0=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20241112 with
 auth_id=275
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com
Content-Transfer-Encoding: 8bit

From: Kryštof Černý <cleverline1mc@gmail.com>

DesignWare 8250 ports that describe their FIFO in the CPR register are
always configured as PORT_16550A, regardless of the FIFO depth. On
UARTs with a 64-byte FIFO, such as those on the Rockchip RK3328, this
selects the 16-byte rxtrig_bytes table {1, 4, 8, 14}. The rx_trig_bytes
sysfs attribute then reports 8 bytes while the hardware triggers at 32,
and writes to it program the wrong trigger level.

Select PORT_U6_16550A when the CPR reports a 64-byte FIFO. Generic
autoconfig already assigns this type to a 16550A with a 64-byte FIFO,
and its rxtrig_bytes table matches the DesignWare FCR RT encoding.

The FIFO size, TX load size and capabilities are still taken from the
CPR, and the default FCR value is the same for both types, so the
hardware is programmed exactly as before. The port type reported to
userspace changes from 16550A to U6_16550A.

Co-developed-by: Miroslav Ondra <ondra@faster.cz>
Signed-off-by: Miroslav Ondra <ondra@faster.cz>
Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 drivers/tty/serial/8250/8250_dwlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 9bb02a4ab11f..ae556b06b03a 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -236,9 +236,9 @@ void dw8250_setup_port(struct uart_port *p)
 
 	/* Select the type based on FIFO */
 	if (reg & DW_UART_CPR_FIFO_MODE) {
-		p->type = PORT_16550A;
 		p->flags |= UPF_FIXED_TYPE;
 		p->fifosize = DW_UART_CPR_FIFO_SIZE(reg);
+		p->type = (p->fifosize == 64) ? PORT_U6_16550A : PORT_16550A;
 		up->capabilities = UART_CAP_FIFO | UART_CAP_NOTEMT;
 	}
 

-- 
2.47.3


