Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F4218ADD
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083201; cv=none; b=K4CbAXrgwYxa/VjyZqC6sRgO1edrlmlm9vKgbZoE3nKw1Mrrd3lvtkisj2Ej+Ceu/GrXlNak6ws8widVrxuChr27/IfLfud71UHlJNy+0bR6BQuzdyWcUSGZGRFusrPUT8wv9UImg5NG8kyoGIEInjlMgcUa297C+4D5u355MKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083201; c=relaxed/simple;
	bh=oUVlAnpiKF1Pm6FuP938DKT7/iFOmxYSFR7wJ4R4/u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReMuiyEpJIPdNX8oDc3aiJrgd3cB3aRKP6V79vmw4ou2JfxLKG7IcwJRgvdHD6fTHNE1XqKzp9+QCY1bVp6X+g+CWGIEzR1ewygsdtelNhFanwLqDvHWvQI6Lshl+MOGeQEdyOfp5wNVR8SohBx+p1AHvlQN1CwizRHjpP4tnqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l90jiu4F; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l90jiu4F"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso2255932f8f.0
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083198; x=1764687998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8Vy4foiqKrCWE5vi4KIrqrTOPxlJurxB7w7FOVWY0s=;
        b=l90jiu4FNpN/K7qsBYqo95Sh0KTXGVQWGsl27Ii9MJ8RdILt8uHMlVMNhw5AYnxw6R
         Zff9QuOpjikATHP9+PwtJ8JcOqkdsCZo3/JBqAu/lN63bhba+V0eS9epLEGAIs6x3sVu
         lf+MqCqmzrv9E+Equ3Mzuv8oSHqr2UltEAFyNBWUlx4wz7JcUbdC+zU2CbfCZWX/ElJV
         kepY5jD/N7rg2iaylgiiE3OMyZJJZgKSmNNHmqyM0zfrS+UtCv8g+d+OIELjvlGin70E
         vSxpf4lahTansycCoC3VH9NtElYlu435n0BWkYwNy62ywsDqWhiJRd3I2IHAhcjqv0Na
         B91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083198; x=1764687998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d8Vy4foiqKrCWE5vi4KIrqrTOPxlJurxB7w7FOVWY0s=;
        b=ws3Rmkv1kdYgm3TRTM+1aclil1p6zOZ3hM3lRxSs5+QZGtICJrSkD5ChB5acL23jHo
         x9MNrqV78CZm7nqMYQmIxz+18BUqi56M5d5pqyLsSnGO9KMz8hl7q+dgIiKbjcwShsIK
         x7Yj36ox9MQGQGJnXwLWB5FKqUfxXAWpJZp2H48eh1myNcb8/Szr47zJFyR9/yioFG/J
         XCj/KoApNdDkBCD/Dw7dBS5OO3i+u+ZaH8Ej0T2saXm7XXEnmyynRWhyPbDcqP/ZaCzs
         +5jJUULkMZz556zvt5ANiQ3uS0BQSiQwPHHEVl7kuUfO3j1zAQAKVIzSUf5qvgocPI78
         x0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoO4B0eIR+II+H/ZB8fKjupaKqTboYCwEZ/MtZUcpcvQe+is6ms03bAw0bPn6d+9Jl+l5JY51tRSlnXW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAUrAa/yYgtpVE4DmHZw/EWukMZ0iID4ij2TyFwmClNUp+Y4c
	eSp3XyFwGF9Yr4UyVHlJ/R5Xkfi3futzGocTxjZHJIoNKyujDK7oSqG6
X-Gm-Gg: ASbGncs543dTLeQS4hV8pe+40KVJIq0orcOWpwDurTcXhoNifTL1ku9qTPM+MDbWPIG
	kKSuat7r64mKQW7RSF7z0N9n9NhWLEoQcVwxYMI/9ZPNEysl5i3yJx3hY3PJPUTXaF5bW4Z9IEG
	/YJlB4xY4Uma7dGy4qCTgpbXTuVOzFdwaJ5aeqePYtmY47CIdNrz4d9HOrSBjF/A/kVvbJMAMcU
	1SOvqgYwhTXVBnMRg83KqLKCn5g7ej05Ph3w2sAalaAtsyVxL9tKPEUk6WtSbz5Twe7mZ/Y69B9
	vXG2AQF8FekJm4ecUcWLyD7xI0+4H0houCXvxgUs3GOABT39aSbvCcLhMr2bye882JMlASjfXsg
	UxE6+kLVYGto1PDtqEcUhfoqySMY4r2WkKERi1lWAFLqYWXWdMb/93q2xT4hUgW6FdhC4eBTvws
	3xITkq8hde6fVxEOixl2k8s2rvB9321MUyN47DV6zlPHSDHqOlJzKBmKJ7nWVKYJxybextL8I5a
	nNozLGW922rzG9c
X-Google-Smtp-Source: AGHT+IG6ixLkzz2qdg5wshNHg6Bnc3eFDwK8wBvdOmM8fHsmmuCE8HAQERhUmowkosTlJBvT5KBa1A==
X-Received: by 2002:a05:6000:2881:b0:42b:3dfb:645c with SMTP id ffacd0b85a97d-42cc1ac9debmr17211462f8f.12.1764083197726;
        Tue, 25 Nov 2025 07:06:37 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:37 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 03/16] serial: rsci: Drop rsci_clear_SCxSR()
Date: Tue, 25 Nov 2025 15:06:05 +0000
Message-ID: <20251125150632.299890-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
References: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop rsci_clear_SCxSR by reusing rsci_clear_CFC() as the contents of
both functions are the same.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Collected tag
 * Updated commit header and description
 * Dropped rsci_clear_SCxSR() instead of rsci_clear_CFC() as it clears the
   CFCLR register.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index b3c48dc1e07d..b5afa7b2a4a8 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -137,10 +137,6 @@ static void rsci_clear_DRxC(struct uart_port *port)
 	rsci_serial_out(port, FFCLR, FFCLR_DRC);
 }
 
-static void rsci_clear_SCxSR(struct uart_port *port, unsigned int mask)
-{
-	rsci_serial_out(port, CFCLR, mask);
-}
 
 static void rsci_start_rx(struct uart_port *port)
 {
@@ -375,7 +371,7 @@ static void rsci_poll_put_char(struct uart_port *port, unsigned char c)
 	}
 	rsci_serial_out(port, TDR, c);
 done:
-	rsci_clear_SCxSR(port, CFCLR_TDREC);
+	rsci_clear_CFC(port, CFCLR_TDREC);
 }
 
 static void rsci_prepare_console_write(struct uart_port *port, u32 ctrl)
@@ -448,7 +444,7 @@ static const struct uart_ops rsci_uart_ops = {
 static const struct sci_port_ops rsci_port_ops = {
 	.read_reg		= rsci_serial_in,
 	.write_reg		= rsci_serial_out,
-	.clear_SCxSR		= rsci_clear_SCxSR,
+	.clear_SCxSR		= rsci_clear_CFC,
 	.transmit_chars		= rsci_transmit_chars,
 	.receive_chars		= rsci_receive_chars,
 	.poll_put_char		= rsci_poll_put_char,
-- 
2.43.0

