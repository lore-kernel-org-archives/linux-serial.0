Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7FC27AC4D
	for <linux-serial@vger.kernel.org>; Mon,  9 Feb 2026 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670768; cv=none; b=rLRoW/jXnKwy4vDJ7qYFWrWAwivg2w4Hk5UQw6DFGPEDJ9aB4iqFfORhr7+cOugJZKgVqqHgdAB36iKkqctW86dcy1vyIV6Sas4DhGbeU50zQV/cNaPX4slRECGllDvxO/yanY/FJywVPczcJAGRaUpS3YaewPDUTb/5ofUtvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670768; c=relaxed/simple;
	bh=V+nB4qVLD9kd898rqz8BpxYpKJZOQQnZHtIM3gVQkYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rn/MuYK/XI2yT4/zXLojaeQvl9YPzuBftvuHngg0rjp1vldK567nJB0pD7BeZuHT6JvqHUcKGjcz0SHeJgjpLRYa10QoIp9622OzL7kZHLR24uUwV18ZDCiP3hOoa2AVeItSvubbNSzmwn0eUdNv1DRTct+28q6kt4dCOWKYxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iuHn/gFC; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iuHn/gFC"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7cfcb46ffc9so3334137a34.0
        for <linux-serial@vger.kernel.org>; Mon, 09 Feb 2026 12:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770670766; x=1771275566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aduJlgD3b6UC0biOWy3CFWbM9K0Gqo/oShp1Bs/OvoY=;
        b=iuHn/gFCybNPyM8fjMPusMkeS7gJ8OqlAWbqhYZkVr+YdbfPgxOxz2p+bBmXvYbkw8
         iuPMv2/3m8dTYQcjMoSuukJgVOJnqp0KcNoi6kA0+mxdgVn+gBXrg0Sz2h7KYHaZIp4C
         4cpCogoyArv/pBgT1wbdFik7GvsRwwEJ3hxJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670766; x=1771275566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aduJlgD3b6UC0biOWy3CFWbM9K0Gqo/oShp1Bs/OvoY=;
        b=Ru+8L85eJxamfvGJ7R2NKzhM4VWlQdJvSpgpS903M71p0jkSfPKR9HA3nuVr+vdYFf
         EsCIy70mRD6cikviiosrnWodZXXBmaxj7RR5OazgU71+2bhR5FC5YxzJWfL9j/Bl5Aw+
         QJUIS7G7oeqka+24qQmXw7NP1g9ppPakKSgj8DmqxoD5Qf/3Dvs7pAxnhWxy+U5mWh0H
         aPyD9zWYiZrqK6bgTyVUIilEW8H33ZDX7kxCdyYmrnFyBEvaQAsGaEaLSIyV9dLkQLJF
         t+dNs5Z4/B5AZbx2PgfyUcLqG/fDjOYZvREzeu1bzGnXtBfdsots41LpLSrjHD7gRZKZ
         l4Eg==
X-Gm-Message-State: AOJu0Yz8r027Y8NyUewDbsZb1y7MvyPxH87GD46RI/DiUD54NqIlUTVZ
	9lcsBmmJ/USwfZn2CduAkCG09quhDahgUJMLUUAgg3wG6B3EOw9aPsqnYm+lI8Nt2LSdZ4wrgCX
	I1ZU=
X-Gm-Gg: AZuq6aKlgQV4Ksq84PJBNggxSr8rIzN7cOHnYcsQEtjajEOCF1sIoJ/DNhktAjuMk+k
	EWH2Wk24rMDR7fhRwILKnqbr1tBEOFwhdujuF/9P0Q62h6md8DupWL493ECuNIz1mj+ybpFZdUx
	fxgGci46PuuELdJiLx+V3vFa0LoKfbkoLwZ5SNGW+qn9nVI40oZeWLY9deSzJ4WuwlOTh3Uo7P/
	lhovh6X/Js4axasEUJribzzLvLdISPo2wC7+hSwq54Q3UWCxhwLu0MaEv6GiJGIQ5i22sD2lk5m
	orX282YbT5P0tLtl7v9nT3a06x6r7eJaj/7NflYW9Hq8UkxEl5Q9fjSxM3RbeDjCGLPH6+mgZXp
	OHz32dUQ5Pw1TIvQzYEeL/DVJoscRRwWmt48Iv/9Cbsueff3eJ5YFCIfCLODxYJuP7ZGQCTkE5Z
	VJAgZlYElDtk1avp1FbJHcr2LkxYgwPE5cSUn8hCb4aObvVrgWhjOlr48BNxY84m4qgglXcxX09
	yePJZtU48jEiRU1rzqXCbMYOL4=
X-Received: by 2002:a05:6820:99a:b0:65c:faa7:7077 with SMTP id 006d021491bc7-672ebb9d7c4mr59285eaf.23.1770670766205;
        Mon, 09 Feb 2026 12:59:26 -0800 (PST)
Received: from rrangel920.bld.corp.google.com (h96-60-216-201.arvdco.broadband.dynamic.tds.net. [96.60.216.201])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-672662e6b30sm706337eaf.6.2026.02.09.12.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 12:59:25 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
X-Google-Original-From: Raul E Rangel <rrangel@google.com>
To: linux-serial@vger.kernel.org
Cc: jkeeping@inmusicbrands.com,
	Raul E Rangel <rrangel@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250: Fix TX deadlock when using DMA
Date: Mon,  9 Feb 2026 13:58:18 -0700
Message-ID: <20260209135815.1.I16366ecb0f62f3c96fe3dd5763fcf6f3c2b4d8cd@changeid>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`dmaengine_terminate_async` does not guarantee that the
`__dma_tx_complete` callback will run. The callback is currently the
only place where `dma->tx_running` gets cleared. If the transaction is
canceled and the callback never runs, then `dma->tx_running` will never
get cleared and we will never schedule new TX DMA transactions again.

This change makes it so we clear `dma->tx_running` after we terminate
the DMA transaction. This is "safe" because `serial8250_tx_dma_flush`
is holding the UART port lock. The first thing the callback does is also
grab the UART port lock, so access to `dma->tx_running` is serialized.

Fixes: 9e512eaaf8f4 ("serial: 8250: Fix fifo underflow on flush")

Signed-off-by: Raul E Rangel <rrangel@google.com>
---

 drivers/tty/serial/8250/8250_dma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index bdd26c9f34bd..3b6452e759d5 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -162,7 +162,22 @@ void serial8250_tx_dma_flush(struct uart_8250_port *p)
 	 */
 	dma->tx_size = 0;
 
+	/*
+	 * We can't use `dmaengine_terminate_sync` because `uart_flush_buffer` is
+	 * holding the uart port spinlock.
+	 */
 	dmaengine_terminate_async(dma->txchan);
+
+	/*
+	 * The callback might or might not run. If it doesn't run, we need to ensure
+	 * that `tx_running` is cleared so that we can schedule new transactions.
+	 * If it does run, then the zombie callback will clear `tx_running` again
+	 * and perform a no-op since `tx_size` was cleared above.
+	 *
+	 * In either case, we ASSUME the DMA transaction will terminate before we
+	 * issue a new `serial8250_tx_dma`.
+	 */
+	dma->tx_running = 0;
 }
 
 int serial8250_rx_dma(struct uart_8250_port *p)
-- 
2.53.0.rc2.204.g2597b5adb4-goog

