Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798572;
	b=ljJCgZhks0R4vtH64uvU1LiEFsjvKtr/TNnnYTziwQ6/YpWpjpVzgRuPPAgzbOUl9bNB
	 0gaQzPAhSCM1FVXOKauJou9E30J+acHK40Ors9x84umAi40mx8gcriQIekuentfMy6ogg
	 cYCdljZEuGs7no7VWOpZHJgVVebJSxlaEg8reoCgvI2AVgYMi1IUt8gJVFptXZbmbDngf
	 HCaitzN64wY/mGAcKv/80GTCpl1SqT9kKzgGiLbgXLwR9q8tm1sQRDbi+jsqOYd4ikmoi
	 1pTcOnR29tg31tPZxMCP8Kww820TKXS58BhJI4aQnvfWIDtcluyvjfdfuB2Ru0n56Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ipkmKJKWGNB6mDs2u9bY6uizcIe+dVA2X22JdmXX2qw=;
	b=4fTNQEyVPm6BMQ1owAKL5JgAa3kAQ2NadONexgF9IQ1ClwADPQLpltTU+T7ktjRar6Jw
	 IvL8kFC+UAbb7/baJ3geafAt3Mmj1ZziE/oJMKYFqChhIHIPJp7T1UsobAhSZJ5Frc2Ci
	 JBp5kHBbqKkZXfgPAW+Nvth5sOvzXdf05y3dKKZD77W2slUTYXnizsVZY8/GNS20633C2
	 h9fL2vRj3uHTc6WIa1zWUcy6dNEf1P0uT5mlin8/E5ieem4gIelCmeOezfZ1rzOHJeLCv
	 8g50WpIAZLEIg7C18pKKZag/PnyJ6r/rPvApWE4mL7tnJLrRH702MCx1err3c0WxU2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpR+eVAr;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A81606A332
	for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 16:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A81606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpR+eVAr
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso59860795e9.1
        for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 08:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795798570; x=1796403370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ipkmKJKWGNB6mDs2u9bY6uizcIe+dVA2X22JdmXX2qw=;
        b=HpR+eVArZ+EyQHAYDMzBO5rPOqE7655kRJGqqR8HL5RH75aSLfHEVNL8dUkPTZHaTy
         xghnof1U2D5QM8q+W/U+Qna6cj5GQQQkTp9herBeFCM7V7+wF6kkm08XBV7MIuqoVCLv
         IUt+M746lJFaWFFdHWU+RPKn1huWa/xqJw/gMa/VyqYAvLo0khovXnmWpGgLHDFW0AGW
         MHuj7CW33+5hlYrFZXAL68efvnZm36mKnP11zYWHOBSKFmzqtv4pH+A53B2GBuJ2L4/n
         GA8ihX0UCZqajLUcmiXyPkLUKhkrLvvnAGl1Vit3msniw9nwa+R8uKQ6fETASVjpPmkj
         1WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798570; x=1796403370;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ipkmKJKWGNB6mDs2u9bY6uizcIe+dVA2X22JdmXX2qw=;
        b=tr7YTf2Xco8+YfuPLfvkcm04FKC7xMKwxgWuEwn8/W+TthK6EHD4jyQH/6p6NF9YRs
         1ltmVTlsgCMYNQtacC/ohwkXTkpwkFql4ShIHELuTyIGjbV+teVc0AOmlTTf3Hk1cy/1
         Uawzr8e/Ln9ScjNzzZBqL/lshMli4HF+vzJKqysm5FUEp1kssprA9R2Yn7oIcDWxlb66
         hc52uZfE1On1PPKecqt9DuibFmdy6/jSzLHEs1X1Qp9KyA6kI9Azm39r0XeuQoULSXeN
         OwjdcGvLj9ShNgOVkdNS3uuzl2EwUHPKiCD433vS0WX2znrSCfSG53wuheSQRzCO+b3b
         Pktg==
X-Gm-Message-State: APuU4Z/EEqP222TQLVVDqQUBGeZ4+9oRJz848y7lDmoeiAwSY6BjqovU
	hrv9e3THJoYD8vKcIjw3D5gYTWeMXtz04PAWFkAvoCyefCh90G2mqBw7v5uruqgsOFc=
X-Gm-Gg: AZFdTZcX+I6ulddEjM/zsk+QygpSKoKjDx3BaBg8ylRQ+h8/8Mw+sZ6fl28C4hRTlqJ
	gAkyezCothTp5ZAb4InX7+UQP+8w2q1OxQndGJIX0MOszUus0AN03xA+gKVj2JIOqgmnH5llJZS
	/B2QFJsX/pkG3DQdkBkRvZfqbKQNbLMO1AXGjKvhhPVMPJxuYDFISw6MBLkD69hMX55/mIRhYbc
	PRqFKWouiG1lF5fiG1TmI7plnzdzJIszn/TxoviWQrzM79FRPZc+E7rSZB/aT+fgCev1nXSTeMc
	yEP9ZzU43NqdzJjTlfOpx7EOVCfWILNALqxUXIeD1O/w8h6gmtDcU/krYhuvmL3JUFK96t2ZAdd
	+kmlF+rtUsPazHS4TBvbs30R4wNdTsv9UDaEC16iK3tDy+aMO4UeVNnB/FOboR5pWyX9Z8FVPpb
	iSgB/FPbG7R/HQ8/EFEDP2hflvpBVj7NsSNIJWPzEPktxBLWJInOIWAH4DbD1r7SNDnG0W8BLI0
	/e7SGXcfiawEwwjJoBlUJiEzePu8EZV6QUTHNNQdsUFyuqCbVVkPE+cf05NFZ5Tm/X6qcktcYlM
	NNNJkZcICGSvi6bhXEwUJbz1bQZh8W9XShqkxFEGwdhuBBZDhu76ifwRFtLD/soasQXPReY0b1S
	bVo9SLX0=
X-Received: by 2002:a05:600d:6510:10b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4bb8881de57mr352984235e9.26.1795798570113;
        Fri, 27 Nov 2026 08:56:10 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm979838655e9.11.2026.11.27.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:56:09 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-riscv@lists.infradead.org,
	sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
Subject: [PATCH RFC 3/4] serial: esp32: Deliver and mask receive break interrupts
Date: Fri, 27 Nov 2026 16:55:51 +0000
Message-ID: <20261127165552.133713-3-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127165552.133713-1-vitorhg20080@gmail.com>
References: <20261125233020.1380594-11-vitorhg20080@gmail.com>
 <20261127165552.133713-1-vitorhg20080@gmail.com>
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

Pass a hardware break to the TTY layer when uart_handle_break()
leaves it unhandled. This lets the line discipline apply the break
handling configured in termios.

Mask the break interrupt together with the RX FIFO interrupt in
stop_rx() so a break cannot restart receive handling. Leave the TX
interrupt mask unchanged.

A mocked interrupt test verified break delivery, handling by the
serial core and the resulting interrupt enable mask.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
 drivers/tty/serial/esp32_uart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 0e7128a..40acff7 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -317,7 +317,8 @@ static void esp32_uart_rxint(struct uart_port *port)
 		    (esp32_uart_read(port, UART_INT_ST_REG) & UART_BRK_DET_INT)) {
 			esp32_uart_write(port, UART_INT_CLR_REG, UART_BRK_DET_INT);
 			++port->icount.brk;
-			uart_handle_break(port);
+			if (!uart_handle_break(port))
+				tty_insert_flip_char(tty_port, 0, TTY_BREAK);
 		} else {
 			if (uart_handle_sysrq_char(port, (unsigned char)rx))
 				continue;
@@ -403,7 +404,7 @@ static void esp32_uart_stop_rx(struct uart_port *port)
 	u32 int_ena;
 
 	int_ena = esp32_uart_read(port, UART_INT_ENA_REG);
-	int_ena &= ~UART_RXFIFO_FULL_INT;
+	int_ena &= ~(UART_RXFIFO_FULL_INT | UART_BRK_DET_INT);
 	esp32_uart_write(port, UART_INT_ENA_REG, int_ena);
 }
 
