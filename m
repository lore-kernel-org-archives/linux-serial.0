Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792822463;
	b=3gSnBNe7/XdsStIA36lLucquTWEhEnqgG2+vqkQNVFL3pSEqVTxJbuLnfDfpITpE83pr
	 KDPzikh5RGZeMVOiNIF+GQXuAv9PxmMaPxIsDfpN6fB2X9DYxAeKqs7LmNWnYa8Ekqrcc
	 /Dh++UjIoJ2c8T+splyQmLKtRLHEW3ixHBeVrWunU8lnJKejqCJJFINW0lNlTd6oWuq2Q
	 agQwXLbBXZLNBZCKeq+S/xSZgchRL6Q0HuU8RLjlpsLXnS2B9MxEz85Ej6fZl6k791ANA
	 Qt46/HI+7XdAliXOCyUARvJo5GVr0t/amlFgYNy2CfpndPEfJumuJxzZQgm4RST0sQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792822463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=l+dQSq35iMWLaAG/hUbby+nPz6VKUfVtqj6bR0W+roc=;
	b=ldxp7qVCTDFMdCoWAbhn9hgEChYTXHVzSVljUcJVL+ETc8S+HN5fUqqw6oRdNaX/oqw5
	 /Pr7F6lt578ylW7fOg5PdwTIxBe89xJelbDEzHegAgtDj+jtB5beDO0BVnAAk7fPYSh6Y
	 sGyxraKeMB/J++MynNgf2gCSvWOB1hSl8DJJcFmchafAyCdLX1RVZ2ULeUhP3tcj5c798
	 0VG1nYqFlVu1a+dTVLSi8UePvOofR4xwNKcd0PNmct8/t515QL1k6WfwukaLdAC8HtPPU
	 bLNHA3waQEKOPDQg8XctxuDcnFGnXO4dxkReuBIxYU2O6799JVbDC0NhtPGI7RFvdfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TS3HvRq2;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD38606A320
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 06:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD38606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TS3HvRq2
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-843cf077f10so1638937a34.1
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 23:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792822462; x=1793427262; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l+dQSq35iMWLaAG/hUbby+nPz6VKUfVtqj6bR0W+roc=;
        b=TS3HvRq2ZiEHda5hrwQtN4NAs0us8I+D66E0RqqjsxZb0a0emzNdWTVsRBt8ygSEM+
         3ySrug4ZfF17PAixiTPLhW6W6m7oMBrDoWBFiJUfE3HCO/tmRLyF2SjeNAL8U0J6UxrZ
         B0lWkBX38lv7V7WheGyxU+UEQfSm3iWaU2BG8wlAlKwGt2DoK6pYX4HNikOHqFCvLgMw
         FaFD8Hz+eV3p9Q2BHniD1yQHClR2c1yMyzGCEQXHkIq/J8D0eFCly5XSoLKr64qR1beQ
         vO7LCIcS5I074xA8W2YQhLhSJWl3Dakbe+HNBwxerzTm620wTsjTGgsNjTpwTj9ua+/8
         OQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792822462; x=1793427262;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l+dQSq35iMWLaAG/hUbby+nPz6VKUfVtqj6bR0W+roc=;
        b=jX3mGZDWQGS9SbIysSPBQoqzwpclCwfebyh5fN8PFOG0Dzcpm3uWA3D7RpbWTrTGR3
         GjGVtIiga0h6ybu6lw9C5c5KLLEK/Y02hJzK/q+wgKVFMf6bFzdTuHvBooazCkdoFeD2
         kKZORbzNz8e+xnceQitl/2Il2g4IgVhT3znlv2jGCVdu5NAYHyYMkybbgQHESqkroJQi
         g3vI/r2Tu0IByHlO/mYERUAm4qeNfvC7nfodIIB5C84j7nCwe6j19c9mLLXe2hTNWVw/
         GFaoCqpXLKpSwkP/jNb5QsFoIFjzLwWAXfeJNBQf+0rIGTmK8gxgIjJmhEHY7F5Izllr
         SfLg==
X-Forwarded-Encrypted: i=1; AKwUvBwB874t8JZCVfbKfyf/5wVUhhHsLowZfYpcqchf0bW77yEW6h0IpuIY5GY0pjmN49iLSrpAtuM7jPCZyMw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4RQ40vZFePml8O5BG5NhmH9KFYdnB3aaddLYYjB/wMnRQ8kvV
	zARqbo3xu+Be9LyJ6M/hjIB9hqDHRLpRmCA6djL7H4Hjv6/PHsGT1CVe
X-Gm-Gg: AYBFou2HaW1B6jINlckvlxZHDvMU2blwxPCnz+LbRHQi5LkBnazUeUds9E4w8QEfcdq
	A6CGN+LwYorxlGnccJ4WIMPQFewH+Tvnf7wFoAfIrd2ZyCBOFjzxtfHzCwVBivnUq4qcLqP2Ugl
	9atX13BPpEcPRBO2iES25wtBu4WNI23On327Ise/LyB1sXPtrXIJ5TwrTzRtWUdCvag8h2T5oQ3
	E3i094d13ShmXWDqFfWZVi20Z5jKu/YqCOkpvjTbmFhY2YeF/l1qOxYfiOfk1SKk0rP9r3Bt55Q
	+drN+8dyqoLJ21GXrqX1NuEtQRLh7YOvafb8fKqKADe0qd1ysj3QuARJqhiqK9xpcC/Omwy2qsv
	Hqj5J6U2BgCVaLgrUluVC2GA1/MG4yDNGLF6NC17EI09wliY23nvhpb6hmawHhJxDEPw/L/yojj
	BMKJa4EZZ4Tvk5BGqV2fivrbYI63ufrAiMJOEYJm4pwpVRLXlvrwXVkyYlnm6x+q7ShI3uUYgJA
	ylzzxd4/teF2DjsJoDe2KoIoQQKQL9A5gKZZC4qeM5OSvjnhx2gXg6fNk3fWxVyzxxLn5xsLHGv
	qeH9/4siSPxUY46gc6dqrJ2CaAZ4O85RlrzE7TWM5Jd7Zrzh411l4w86W0mQdGI2ORTbhhijUFH
	oIFnV3kc6Pqan5nlai/rGeulZ3Pm+HxRfg8027QSWxwi083mrYZYYEw7i40i2puBwrmkiMELwsm
	F5t9Q=
X-Received: by 2002:a05:6830:916:b0:81d:54f9:d6a3 with SMTP id 46e09a7af769-850fba2af5fmr1170106a34.4.1792822462041;
        Fri, 23 Oct 2026 23:14:22 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fa99c4f2sm1516420a34.6.2026.10.23.23.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:14:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 00:14:19 -0600
Subject: [PATCH] serial: 8250_mid: lock RX DMA timeout flushing
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
Message-Id: <20261024-submit-serial-8250-mid-rx-lock-v1-v1-1-2b9afdf869d7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw7CMAxEr1J5jUUSQRRxFcQiH5ca2hQloSqqe
 ncSWHjxRjPPG2RKTBku3QaJFs48xwry0IEfbLwTcqgMSigthTphfruJC7aZHdGos8CJA6YVx9k
 /cZGopNeajAi9EVA9r0Q9r78f19ufq+RBvjRxazibCV2y0Q8tKuVzrIeR1gL7/gWFevp9pAAAA
 A==
X-Change-ID: 20261024-submit-serial-8250-mid-rx-lock-v1-21c66e80df80
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "Chuah, Kim Tatt" <kim.tatt.chuah@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Raul E Rangel <rrangel@chromium.org>, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The Tangier and Denverton DMA timeout handlers call
serial8250_rx_dma_flush() without holding the UART port lock. The helper
pauses the transfer, copies received data, updates RX state and terminates
the channel. The DMA completion callback accesses the same state under the
port lock, so it can race an unlocked timeout flush. The IRQ-chain lock
held by serial8250_interrupt() does not serialize the completion callback.

Take the port lock around each timeout flush. Release it before handling
the UART interrupt, since serial8250_handle_irq() acquires the port lock
itself.

Fixes: 692aa1905679 ("serial: 8250_mid: Read RX buffer on RX DMA timeout for DNV")
Fixes: 4831e0d9054c ("serial: 8250_mid: handle interrupt correctly in DMA case")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Previously included in the DMA cancellation series v4:
https://lore.kernel.org/r/20261023-submit-serial-8250-dma-cancel-v1-v4-0-e759de1839de@gmail.com
---
 drivers/tty/serial/8250/8250_mid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 44b43163df51..83f928b1f643 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -94,7 +94,8 @@ static int tng_handle_irq(struct uart_port *p)
 	/* Rx DMA */
 	err = hsu_dma_get_status(chip, mid->dma_index * 2 + 1, &status);
 	if (err > 0) {
-		serial8250_rx_dma_flush(up);
+		scoped_guard(uart_port_lock_irqsave, p)
+			serial8250_rx_dma_flush(up);
 		ret |= 1;
 	} else if (err == 0)
 		ret |= hsu_dma_do_irq(chip, mid->dma_index * 2 + 1, status);
@@ -148,7 +149,8 @@ static int dnv_handle_irq(struct uart_port *p)
 	if (fisr & BIT(2)) {
 		err = hsu_dma_get_status(&mid->dma_chip, 1, &status);
 		if (err > 0) {
-			serial8250_rx_dma_flush(up);
+			scoped_guard(uart_port_lock_irqsave, p)
+				serial8250_rx_dma_flush(up);
 			ret |= 1;
 		} else if (err == 0)
 			ret |= hsu_dma_do_irq(&mid->dma_chip, 1, status);

---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261024-submit-serial-8250-mid-rx-lock-v1-21c66e80df80

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

