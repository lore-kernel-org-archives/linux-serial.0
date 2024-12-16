Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B9413B2A4
	for <linux-serial@vger.kernel.org>; Mon, 16 Dec 2024 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360854; cv=none; b=kfnyIRwhvJsGhlqatYiWICzFwXYeppM+PGWPaaOqA/nIyL/C6CgAeSn5lKQSwEnV/a8k3V4x9w8ZnxKWkMmj5gOhrhPjvMec+0Y99V204IzLtOdfFZB2V2psiPThmWHF+kdOY2srATPyYmXP4Zis21IjDQYHtEQ5Ry8qMXRzcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360854; c=relaxed/simple;
	bh=bn3iJLzlKSMWMJtRrej6vZqzCfJ4v28p5CBRgpdTTFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KiuzyjIbxNvKGSVGcMXBR+mbZg18VFrlHaQcE1payz1+CdXOf+7UIczTqr97JI5scCxLTKq2r1TFbz7ikTQtSy02pnpMK1R2cd2eMt0eOzwwCOzp2ziZ+LQbO/wpVjmb546hJfZAVdz7mlkdBDdZf+9YWvh4PiTvb1XyCudLTQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com; spf=none smtp.mailfrom=hefring.com; dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b=khiFj1hZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hefring.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="khiFj1hZ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6e4d38185so323929585a.0
        for <linux-serial@vger.kernel.org>; Mon, 16 Dec 2024 06:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1734360851; x=1734965651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrDI54RrtTH587z61yGqvhuIg5ioNpJ5JcTwNcL7S14=;
        b=khiFj1hZMQfNWK+ChbH/E99KZuHkO5g4IZLGAdgr4R83qQJjPqDjs6FffVn3Zo1Ll5
         wk+hvB2UlOlbhckPaUAGiuBBuT6AHhqv8YlDYPXqpmuBImzA3cUBxYa9he4GOXKe2EOX
         5aHWLX2anL8xlKdEuSnYeBxEJwfX59rDXorKOprZIEaJvOpkkAyvyGiqATgSQu43Fa+C
         DueWVt1evD4LhcOfyVCz8ETEOoDL6E1vFRQCEGPWB66mWgGvt7ctQoBXkulyc4b81321
         0zEXD0z6UiH1B2qUbaJR/0SuKpf7o2mf0pknQReTy4i0IimI+BmY39IWhEwAUzsQs0NH
         5W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734360851; x=1734965651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrDI54RrtTH587z61yGqvhuIg5ioNpJ5JcTwNcL7S14=;
        b=CXEoFLRdThxycNCeZPjBmiY2q3AiKGO7iPHpGA94ztCXezvxKC8fUQ7aAKRd1GIqcr
         /jWKkB3yrLQtCXsvamwuB9vnPAVwNJKAiOFDungHTvspgn/FigzkxGr46qu4WrGAg0xC
         sU+TxZ6aPYLgTkrDpgmG3yABkrtwDxWfGcPeGzGkz3adeAtqP5XWkUGxNNxq9VnwO7aT
         ECcgxB9oZp1UNopCmIcpqaBgWNj0aRWlhtHQmGUlzDUK3yfevaOWxFugpgea3kFQMCzM
         3El+hrmzNkPE0KcGXgCFWlEuSQfDSnu1N11ClvMlA8M3C008XGMLcxU59X47pYxEqJqJ
         Ez0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeMYxlXFZSicrJfxlUb0+jZsBqBFiQI6I2SmKtdxik7FHc9gkS8lT4WGLWrx6Mtz0ScmQ5NG1ERvnoGq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwluDpKs/AyN/v+KdJNOQBcrn3j6h/Kt42oXNeG77bUvg5rcWGt
	+hFkTSs1rdWjU5ja5+o59YebkUM2F702Rqu/vvEsO7seBwsapElA38Zr6m9TCyaKSCZz1wi10BB
	ZtHc=
X-Gm-Gg: ASbGnctpFOGCcGihYTl4WLpq8Egs1mm5cE0bnWb/iRqxORRInVjYMQNqVxzNCB3iei4
	qH8BZmsM4pCCKbd6v7Kdzm9J1nYLwZvN05QKFfkHrot3Fkk6BiAvxWjJLKJAvtgJYjebEFTVKyU
	rjphVSBD82BnrttpriXaAwICVv/HaL4ltdZJm4vSOcCjxKzkaGV2FwzgexgcC0wZ/scSlVHLuAv
	Er2FnR+/VHoIAyw2UvFz1RiGEUqMdsBAhZ0YzIKErvRJhkEjfO4JR+G+zuq5hWtXCGFD/Gs7+kc
X-Google-Smtp-Source: AGHT+IEejh93L0FZI+AsvKAjo6R6QN8N65ppACXanwMRaMhjPpRdaO8GmKLrZ1p3hnkSIvCPYIc0vQ==
X-Received: by 2002:a05:620a:4889:b0:7b6:d939:f958 with SMTP id af79cd13be357-7b6fbee8df9mr2384495685a.25.1734360851084;
        Mon, 16 Dec 2024 06:54:11 -0800 (PST)
Received: from localhost.localdomain ([50.212.55.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047aa633sm230461085a.10.2024.12.16.06.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:54:10 -0800 (PST)
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH] serial: stm32: use port lock wrappers for break control
Date: Mon, 16 Dec 2024 09:53:23 -0500
Message-ID: <20241216145323.111612-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 30e945861f3b ("serial: stm32: add support for break control")
added another usage of the port lock, but was merged on the same day as
c5d06662551c ("serial: stm32: Use port lock wrappers"), therefore the
latter did not update this usage to use the port lock wrappers.

Fixes: c5d06662551c ("serial: stm32: Use port lock wrappers")
Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/tty/serial/stm32-usart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 7dc254546075..1ec5d8c3aef8 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1051,14 +1051,14 @@ static void stm32_usart_break_ctl(struct uart_port *port, int break_state)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	if (break_state)
 		stm32_usart_set_bits(port, ofs->rqr, USART_RQR_SBKRQ);
 	else
 		stm32_usart_clr_bits(port, ofs->rqr, USART_RQR_SBKRQ);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int stm32_usart_startup(struct uart_port *port)
-- 
2.46.1

