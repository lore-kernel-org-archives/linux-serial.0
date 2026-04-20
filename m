Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C53630A3
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693873; cv=none; b=ogwr90swUrqsx6tLpN7i26WUOhdmccbzAFAEBWDII5dC35HzwfAuidg7fPGrwpptGVW+FJ0I4vilKBe+BUc6XLJaBeuv+r46Nd2HhTemRoBmD9qoqbvBlrfge7ypBmjjhMfK+sf76CBmKHx2onTHp4jj3pvNw9wfzSah/CznVEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693873; c=relaxed/simple;
	bh=qFelcTJ1pCIXmrY7KftYX4Oy2N/9lTZs2Hg3YIzcshg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itP+lCnT9rCT03bEV09WYeroBr3OtPXxtODRuF4t09Tz+HQSrdLfpTUEvwPnvc1n6libC0dvzO2Q9TmdpIf4YCk/INTI5zAwHYucGaCT7MfTivTntYoLnc5ivwloLkwQ3Wzm9pveBPnTmh6yiGxw13OXKsz7VSYYcxT4tKktaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2C3iAue; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2C3iAue"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so2609432f8f.1
        for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776693870; x=1777298670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvbI/EJN7GrntRh/mrLK4eeJPAlGYiiclh9mMVV1bZo=;
        b=A2C3iAuePbLRVZ/TPlwwo2c1vpTw9/57ertNcsyijii52MKjm6WKR0VI7KWCLTyX4I
         v7t1Cf2BwjgxvYXCgmKyZ4vG1y7lyAZx2o8aEwdBAejVmjk+WsjgM0R8NM2xzweLQ+mp
         VvS0pIuxJKgIr8WuKERZTG7hq0SRlqsJiuio68W6F78brzXdGHt4STBCOHHLKo1WgTZo
         +a6swFmu8eV6TwYMu458+mtcBwPxIhWw9ljJ++j3RcWMjty56bQolnTbeSBBCW06Eki2
         nS5y8stBFExl061l9iR4G74uCsTgfYezATVbBIm48UZV801ln0KWk9CETBhjLZ/o1IOQ
         AukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693870; x=1777298670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qvbI/EJN7GrntRh/mrLK4eeJPAlGYiiclh9mMVV1bZo=;
        b=EsLU5zxURKKyI0XbC6jtNFI2F7wcrPZeAdetns4ER8s34WfpTtsF+VdtrLrG6RtIKb
         HChJFc3FASh3DqnBFuD8cXeOGD2VK5ACjuBQJT/35GK1DbCzQBTdcc3euzaiKktzefsT
         MWvojJZBpSbuv7F/oVFl+mIYR9bLJI0cJzdToYDCA9wYwDDTSz9i+XTqgIRTW3g3exWg
         cLlkWt+VlMzNUi6Bi8yw2eXB89RIVl3uQQgbNdUqpGJO+ppse8GDLXzeb1PYKGQkQptu
         4+FPo8EPl+wOpMl3G9smFHfWHyVrnrAJceEoHJB/CgO6ZXZ0qxU2hOWHDo33BYjnF++7
         cI3A==
X-Forwarded-Encrypted: i=1; AFNElJ81VJjiQe8GD4d+PwJdgWL62hsoFu+SjSRO1i6pN1ic28hwXxbnTSBj3QojPzYoCWtJ04H3XtXIWk+1OXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kKF7whAtIzV8dpdLJHrSk5PEEbcnmBZA6oksrBio2p4DHoqj
	w+5Y6EKnUmGZUK3KsSn13gia1KmskExcbPC22lnv8QzXCECAgb+q7zb9
X-Gm-Gg: AeBDievQd++tjQdPGvCj2WrcDl3SPWdFQeufSq5NFl49EEYG6wGT8yIrt655fGAvGlM
	QfIVmHmCaKhwRYAoMwW7IDyceb+3Plnuj2lq4SUs5qf254i2V2aYEAUYdfhdLYZndJfILLMj4BR
	ygZx/fDn9Vap2sfctiolwkEIccO79p09g1ZFp8PGGRZonxtKe239JpDrk+MiYpTzcIJJwOr9EPV
	5IPL8QmNwt13Z0NNb5ixQhOq3kRG0rEbjsy/W+0w9arD72l3zhWffMPCNFhtLfVHlH9Yd7yN+ms
	wgB52NaHLUVQImH0T2R8qm+srTCkKKygTty8P/GfvRYc4dE5/j8QAfff9C0HOjvi3V1apXyN7K3
	VpljOKxcFc7JUJKDg6EoCFzNy34eF50C7KClQ3iVpJk8ToZGBrLjzpTUsIPCfPHruNXbfoMQWeE
	lZMs/5Sy5APkVXDktyDvQS+ZUbuM87kX5XmHSF98eopGym4vx/TSAe2JDzBj8=
X-Received: by 2002:a05:6000:1a89:b0:43d:7125:e79f with SMTP id ffacd0b85a97d-43fe3e25c89mr21697002f8f.47.1776693870054;
        Mon, 20 Apr 2026 07:04:30 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:5f3e:f914:6f8c:72c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm28377778f8f.31.2026.04.20.07.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:04:29 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 1/3] serial: sh-sci: Avoid divide-by-zero fault
Date: Mon, 20 Apr 2026 15:04:21 +0100
Message-ID: <20260420140426.237865-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420140426.237865-1-biju.das.jz@bp.renesas.com>
References: <20260420140426.237865-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The expression (10000 * bits) / (baud / 100) can produce a divide-by-zero
if baud is less than 100, since integer division yields zero before the
outer divide occurs. Rewrite it as (10000 * bits) * 100 / baud, which is
algebraically equivalent but eliminates the intermediate division, making
a zero divisor impossible for any valid baud rate.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6c819b6b2425..7473b26ce9cf 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2915,7 +2915,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/* Calculate delay for 2 DMA buffers (4 FIFO). */
-	s->rx_frame = (10000 * bits) / (baud / 100);
+	s->rx_frame = (10000 * bits) * 100 / baud;
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	s->rx_timeout = s->buf_len_rx * 2 * s->rx_frame;
 #endif
-- 
2.43.0

