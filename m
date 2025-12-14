Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75488222575
	for <linux-serial@vger.kernel.org>; Sun, 14 Dec 2025 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765706697; cv=none; b=kvXYpWTjP9HiKRdqiduTERWiTUI1Txqw/7jS3UnqCYk9kfjBpBhroxAafv870hWjngFjj3eKZZFdANKwaN3w/jFuLY/QlOnwHx4Wcl2SB/vSlXGjZEoBiO3Wngn03HnzuS+uHAdp/Y7Zdb9XXHik6JRADocbEueqhrAw++rYdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765706697; c=relaxed/simple;
	bh=t+sBrxGvgUkc6MdscaohpPIRZPOe1e/G8hNIHEhR2is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjAlxk5hmKrOsHPs3iN+XICjSPCEp78T6EpPBUGl4WomkjzUjPcUgxRDD9ooJCkNJVCKwl/qeTHpBKNhklKREOzPoBxqRgyNzEpb0/19ueEdsa01g6QzbGFmQHB+xWdfvNEpn1yM8jx4WXbdRL3omB1L/6PL9Dgjqx5BTsos5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGpIaYRn; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGpIaYRn"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-450063be247so1181088b6e.2
        for <linux-serial@vger.kernel.org>; Sun, 14 Dec 2025 02:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765706694; x=1766311494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx5BTfbUyWw1J+Tj8PtT5p4me7Fezd4/mZp1b+JLsts=;
        b=VGpIaYRnuNImNhD6zLChu9kPDQ3Xf4hoglaQJa336ee+nXzQUmvpGvgOHri5Az8SKP
         3BVviTCf5lx9sg4ks0cyYa2zx5CE4WZdKXdnaJp4vhFFiSQiVLhh4YLS+wz/0zkI1bNZ
         tVPEQlgdy2fakheby1r5mXjb2nlegBtrzhopdLf69dY8VY057V47SO8irfkBbPndgCqw
         aEi9XqrhBR5+FQM2T14TA9rw/ZMoz5i1vVToka2/1LmFg8VrLegox0ABFe3loyLnIqnz
         I1vngXNdO8DgeUXyqMFa8eC/bgUwL8adoAGxAg4JVwQYvbh3nw0ngQMRO2WNTqzqwqFj
         jzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765706694; x=1766311494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx5BTfbUyWw1J+Tj8PtT5p4me7Fezd4/mZp1b+JLsts=;
        b=Ir2LN3d+kYJekF5PZVJK7vsxVI2e/wPqe9t9Rfpi/UdyMK0Tjozezf78B1bYKkyU1x
         pxTq6MxZjOA+JEu9BwUY2xDmxH6/1nV2om3vX3wEhSajIE81RivWblgYvZVc+4UaDs5E
         hCZRZzbnc0nmXIWL7Ns1Ce6Yx0vJoIWwJvi/fJk6pABh9d54v8w1tWE7wYgZqdQNKUfq
         ki/+6W96lI9flkYvTeuMRV3uKhlSQcWv3to6AJZhvt0X+yoXYbX1F2QHMoi109KBmSnr
         b1dDu22WCitzOc6jHqKOIl5pLVZZh88Tk8VgP2AhlRkri2Bxpqn4ruEpuHbhjyKQV0aj
         y+Nw==
X-Gm-Message-State: AOJu0YwKd5nQWJcYPYR3MMfhlaCGxWLevJE7cQ4E0GNuY0m/n4Fm98VM
	IIx5lnAMLn6e753IYBrNSjgNQAvHPuRflXBbNTmGWyZ843reYaAD365+
X-Gm-Gg: AY/fxX6zO701LwOVvOacsE+qXMCDf4GLSy/81uoNdso217Ce8P/O2PTpaFrrJ+TmSUu
	vbRPIWfK/g5nt8pN7JGckdmBju2yyznT8d1vXLd51DJM12GNmCvIxzQDrmYa6pSfe1mRr9nr1r/
	xzDv6NHO/srpt70lJUN3OEtTkdpLXCHrhaDIp+Hl8O3JTttIPuySQdyWmPAtKLskZLJ9Qdlt+aV
	8/gSXl6dNXT2S8IEkqv67tto8AMuQBSZejXpAvmGExswdA870mD3P6McZTerVuUrKD39HQuvjvu
	uboX00FmLsNaog8BOcBm4ylCiie7F0bLSoil8iQnha0IBAG7efWfLR8jpCGBP28CW3PdWQrZBPI
	e0Pw7dJ8dNHIEQaxvYeiMeMx9fSO4JHYoAag6UvQ4pzBbWGeIn59dVuj3Q51khYyoWaEcBxvk1j
	L6+VuYXlAB+gO1DuC8CEgKEKTDlUK5DL7W72E/FH1CptAZSGU4KfBi96Hj1yIV2Foh1Q==
X-Google-Smtp-Source: AGHT+IH98jk961KB6slF343tmvt+nWxdmDpjr4Eh/yWE6YXbapIIQ9K89dN5+DbNTzEIuFTF2V+isA==
X-Received: by 2002:a05:6808:bc7:b0:44f:e376:14db with SMTP id 5614622812f47-455ac95825bmr3750577b6e.44.1765706694498;
        Sun, 14 Dec 2025 02:04:54 -0800 (PST)
Received: from localhost.localdomain (c-24-9-224-2.hsd1.co.comcast.net. [24.9.224.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-455ad53c68esm3349352b6e.17.2025.12.14.02.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 02:04:53 -0800 (PST)
From: harindhu007 <harikrs0905@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	harikrs0905@gmail.com
Subject: [PATCH] serial: pxa: Fix comment typo
Date: Sun, 14 Dec 2025 03:04:13 -0700
Message-ID: <20251214100413.10436-1-harikrs0905@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a spelling mistake in a driver comment.

Signed-off-by: harindhu007 <harikrs0905@gmail.com>
---
 drivers/tty/serial/pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index e395ff29c1a2..218fa4003733 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -99,7 +99,7 @@ static inline void receive_chars(struct uart_pxa_port *up, int *status)
 		 * Specification Update (May 2005)
 		 *
 		 * Step 2
-		 * Disable the Reciever Time Out Interrupt via IER[RTOEI]
+		 * Disable the Receiver Time Out Interrupt via IER[RTOEI]
 		 */
 		up->ier &= ~UART_IER_RTOIE;
 		serial_out(up, UART_IER, up->ier);
-- 
2.43.0

