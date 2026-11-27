Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794991;
	b=OTjhPLJBeIWFiTOTV67tZMINkkp99zkF69Is0A0kfDz/XMdxQR3qont/Vyuqk+xHHxQ7
	 gew7MIlh/TL6347oFrX89cE7XRKhY8A2HGxyatG8bNDddKGalXN2NQoTW93dVImdG2BmB
	 yMmDWLRZLVh/usVPh1DBvHEGgPZrUuhvE1yu+it6eq7ZdH2o3oBCReo2lb4xJQLSvfsI3
	 0p+947APZu2NtShJCBNVTtY57Wc+Onw6OkW2Q9fzNlWbpAq5j9UGmXyriOjoXz8njRNM7
	 yU1aG+1f+i8xulX4NZ0kwCaeOqhRnnXYgu4CiG4zCAd0Pu2LZzVTlbei+k98d5INIxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Va7mmJMRyV8C2mf4qXe8YFNGI85O0e3HsmDcruX7rYs=;
	b=FKjUTG4Okka7EH8MfnW9wi4f4g4pRtzvdKqTJADD9C9jZbkD2u8yIMk0R6xBNHjqTZA+
	 7Q/+RlqfLHY63zdEEuB0wbYkP6p8eHACZjWVjZuUyNOuNboDksN9lL0C5ktIGHJCL6FZ+
	 ykceBFHmQT1VYFkxKsJZkzqxD9KMUfhLrkBUfiq8lmhazxoZCicQPdIbovzv9HggFCZIw
	 XsAkzNX2G04c4aF5a86dcB19exN1BdKHgWEYp8wnorOGVGrp8dxP1TYcc2nmm1VE2fzvE
	 Y8snQbhEBycpbICewXQWg83E2twCszjpRZBA7wlX4+SoxpXMJXUDAE1T8TQUpb3htyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="p7aI5/lr";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC76606A323
	for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 15:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC76606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p7aI5/lr
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492f0a1b685so5913478f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795794989; x=1796399789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Va7mmJMRyV8C2mf4qXe8YFNGI85O0e3HsmDcruX7rYs=;
        b=p7aI5/lrjhOg+QJOFzNmbjMeqdKVhTpuCet9BXJAQLKH8yo5ZkAVgO4uDWlUkb592o
         PZkfrVGhwWvboOUKBk3JohIvWm3G25l2xBAU3je94W6ziFNDGoH/2lnBjJp/TaioVcKX
         5adtrqys66vBCLOXWcexMCybdwyKN0bFSCYHbrp/atc1/NO2ij4dO+2oSCv/RPo58Aub
         1/ubKF39kif/EohUN9wGFKmQ9tdHjpGyyJieCFPAp9bw4JBmr21NCRu/4p3XtLus51rC
         FSy3DU31o7ilAJd6OF1ZbPChEsQLx5F0kKMZUd8D4nO5oNU1DkjTzQnWeq92QftS/vl4
         aeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795794989; x=1796399789;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Va7mmJMRyV8C2mf4qXe8YFNGI85O0e3HsmDcruX7rYs=;
        b=L7+4qrFxalG1q30i8H8oN7+qHrRknZ10xVU9oFzAdRPNzTEduvWbFgsFEqccsTIcAn
         kvszL8SOrrlWDBfe544DsRBJIBrPhHGWg95kumn8sKyNgJDRNh2jjnQF94Fdn9kHI8v4
         xs74N2silVj5zOl4jHxd48PQt3opBdgJJ4at1A8dG9tl10hEh4wl9+Lb7mpj8VP4sHv2
         lOsGMgk8RBDOZRMfvN0YoLcoCw4JZYG5/ru6cXzfaulkMgGsJm5oUF6qq42QTO/Oq9CS
         Pmw9fkpXtpNpylb+HoaODXiRJQy2Rgc27Q8MnSzrbSZtMPJ1iIC41cymWWmCes+oGTaV
         GhDg==
X-Gm-Message-State: APuU4Z/i3+M95ochbrn10glzV5F9mQqiPk7U3MNxbf6Xu4h3aIs0LKHo
	knQswvwKyM2FpaDk7gA4pyBFgLRxygyhqo1Id5M6MLhDw9NxH0UzhSAgLEvNTTwrJF0=
X-Gm-Gg: AZFdTZfMpyroWpaQN0Br2Cyd1sdCTNhnLjGDmmBD0JHBnPboUBJ6AyN1sQWfu6257PR
	MeG6kV0bl3d4khcR6U1jUcfWy4et6aVmjNVSn4ALG8RTkquWY0cLpykFSpXGhXlE0duw6uEbdqI
	ewA/ZM63S8COe4cD80zOXaz65BP6gNSRi0CqZD2HqpNUdDWBJC3UFdEw/NJuKXod04z8zXj9+cu
	I4CmYXUK/abMhJtkUJOYz/dDvXatcsI20FfVhhTCWyT0gCMp1AopbZKkwiquyzQYDHssa/ugzXU
	I0ohcSe8fqeWNZ2dRLhsbE0js5Ev0p3+gZFtNj95pLzKoLTXsmA2JguAkgmWC98lhMj7kuv/c/P
	exvfRs6fLBuCQ5uDTZU94GZizuW0aGNK3jJQRmwRvW4CaM1kGsC2fiaDsWTq9yMry8bVHhhCKdV
	vI3vAUttpclKPE1v+4KeGC0y8b860OmbQEYgl6JhIipTIYpim9IhQ1k+cU97AfxEhAy6uprI+B4
	xUV8o1i+atKS5EEkt6urgLmwrssSqOrP/GEqT5GGjbOxLy1lKtQiiWqEy18q+6sPUK3MSdcPqe/
	D+2gSg+F4/CB7AByyQZHUS0osHZOFEX9fOoQc/yaNcnrGpPyFQ7Viiw2th6uU4KmkdTRfLGXPXi
	rwd0l5Ks=
X-Received: by 2002:a5d:64e5:0:b0:4a4:f208:6a37 with SMTP id ffacd0b85a97d-4abb4e642fdmr49567529f8f.42.1795794989438;
        Fri, 27 Nov 2026 07:56:29 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110ba3sm39382661f8f.35.2026.11.27.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 07:56:29 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-riscv@lists.infradead.org,
	sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
Subject: [PATCH RFC v2] serial: esp32: Rearm TX interrupts when the FIFO is full
Date: Fri, 27 Nov 2026 15:56:23 +0000
Message-ID: <20261127155623.129706-1-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125233020.1380594-13-vitorhg20080@gmail.com>
References: <20261125233020.1380594-13-vitorhg20080@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When transmission starts with a full FIFO, queued data can be left
waiting with the TX interrupt disabled. Keep the TX FIFO empty
interrupt enabled while a high-priority character is pending or while
transmission can progress on queued data.

Use UART_TX_NOSTOP so the driver controls TX interrupt masking. If a
deferred x_char is sent while normal transmission is stopped, mask the
TX interrupt and leave the queued data for the next start_tx() call.
This prevents repeated TX interrupts while the queue is stopped.

Hold the port lock in the TX interrupt handler as required by the
serial core TX helpers.

A mocked FIFO test verified the deferred x_char case, IRQ masking and
TX restart. Normal serial console operation was tested on the
Waveshare ESP32-P4-Module-DEV-KIT.

AI assisted with driver development.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
Changes in v2:
- Keep TX IRQ masking in the driver and mask the IRQ after sending a
  deferred x_char while TX is stopped.
- Verify the stopped-TX sequence with a mocked FIFO and run a serial
  console regression test on the ESP32-P4.

This replaces patch 12/19 and applies after patches 10 and 11 from v1.
v1: https://lore.kernel.org/linux-serial/20261125233020.1380594-13-vitorhg20080@gmail.com/

 drivers/tty/serial/esp32_uart.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 304e134..2058bd6 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -354,25 +354,31 @@ static void esp32_uart_transmit_buffer(struct uart_port *port)
 	unsigned int pending;
 	u8 ch;
 
-	if (tx_fifo_used >= ESP32_UART_TX_FIFO_SIZE)
-		return;
-
-	pending = uart_port_tx_limited(port, ch,
-				       ESP32_UART_TX_FIFO_SIZE - tx_fifo_used,
-				       true, esp32_uart_put_char(port, ch),
-				       ({}));
-	if (pending) {
+	tx_fifo_used = min_t(u32, tx_fifo_used, ESP32_UART_TX_FIFO_SIZE);
+	pending = uart_port_tx_limited_flags(port, ch, UART_TX_NOSTOP,
+					    ESP32_UART_TX_FIFO_SIZE - tx_fifo_used,
+					    true, esp32_uart_put_char(port, ch),
+					    ({}));
+
+	/* Keep TX IRQs enabled while there is sendable data. */
+	if (port->x_char || (pending && !uart_tx_stopped(port))) {
 		u32 int_ena;
 
 		int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
 		int_ena |= UART_TXFIFO_EMPTY_INT;
 		esp32_uart_write(port, UART_INT_ENA_REG, int_ena);
+	} else {
+		esp32_uart_stop_tx(port);
 	}
 }
 
 static void esp32_uart_txint(struct uart_port *port)
 {
+	unsigned long flags;
+
+	uart_port_lock_irqsave(port, &flags);
 	esp32_uart_transmit_buffer(port);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static irqreturn_t esp32_uart_int(int irq, void *dev_id)
