Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955701;
	b=BNHMsn/8Cf5yb3YTkqT6t53IzmmnbI8CeViPJWrAgsqEj6725s7+3662AAkSJk+hSVkD
	 RxIu1eryYXnqz01wA5il7M69rxvQIU9PEUg8XkISmNMGmgUHZH4WuT1ZYtUEwXICEGJHT
	 U+7ZtUg3Spg9Nkzz18BdlAofJZbjf8z5Ban9qnOfp3aSIlr6vWatVBS3f4PtROYg+QSXP
	 Qk3DSpliNSVVl/K4TNI9ObSH4OQhO/Avmg+xHL6xp/Za2Mmkq9vSbL+XC3xUSfaiIl70C
	 B6UyKnMtYcSo9Vzk33+bNRprPUadGRmrwh1GCFrtcxvvQnAXfw6Nop4OCqfG21uPl1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955701;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=u6acokGNj4SYKyhK/qU5+s8LM63HA4bdVeXm6C7i5AY=;
	b=Ri9abmWB/AXP5QEXdIXhOf3ST0049X9HljBdF4KFnd3U9lZKJ9FtqHRX03MgIEwv/Nd7
	 BH/56xmb4Fq5856vh9UBJIha/fsVZlGdqpGF7QHINsA11ZFyXn8WnTVzR5r9K3ulx2d2Q
	 GXqKEmzVwu40LRJoaCoMiYdDhjK4d57/cGufpWF1Uywf1AdzF1OEmmWl883wcFalJ56tA
	 20/STWu88plNZi0Se6hIr+MkHLHA6rJGhk/G+4MslrLegtD4zvWJPxeR8Wo3VQnD/39GX
	 onSvxAiyNcu6P75FNc1cs9wuohTnTleaB9AYHEH4OBWys0QO7GBcexHQq2Tw26eQP+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qdq8U7E9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED7606A32C;
	Fri,  6 Nov 2026 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qdq8U7E9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAB71F008A4;
	Fri,  6 Nov 2026 09:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955700;
	bh=u6acokGNj4SYKyhK/qU5+s8LM63HA4bdVeXm6C7i5AY=;
	h=From:To:Cc:Subject:Date;
	b=Qdq8U7E9qzee9YQO26jrXBSFguUlc6f2HjFQzX7S9GBljxGA3ZPRwqNfAXvQxcw5B
	 l8/MnGSTveFNF/sbTaytRn2BlprxoihDkCnfqy21aJJNIY89xzY/3GOkGNPBP+IZfX
	 TMQlUR4BZViS8JmZ+rWMMq79LwWntSobG5U2YH795GT4xwAIOTCCbSU1rUKhKrAoH8
	 26d0yCcWdwdG+cZkWqROTeVZI6SqFWaCqObTC+s+6/I1SsRLdhufMwHpqj8MuP5Igi
	 7AabH8FbzQacrRPgj4HmKgLcQduKjYd+Z86pnCKVVMNw+HempP+YFWDHA5/BmkYW4Q
	 MOKIwQQOlwkHg==
From: Thorsten Blum <blum@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: use isdigit() in tty_find_polling_driver()
Date: Fri,  6 Nov 2026 10:01:23 +0100
Message-ID: <20261106090122.2265-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=624; i=blum@kernel.org; h=from:subject; bh=OUltn+uyiPEBSzXpzM/GpZAigvtO8FjmPHwVGN/+M2s=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlvpyets7xwQ41Jrudssu72RXelXjyYsmr+w0k+16ZM9 /9gz8N5oqOUhUGMi0FWTJHlwawfM3xLayo3mUTshJnDygQyhIGLUwAm4pfFyHBt+UZr5yTJrA9+ Kct3FTcnObXmLl14/+Pfvst9r9tX7jnJyNBz+sihyFbRf/X7tuzmOlOZ5OOw95Tpf2a59We/SjA c/8kHAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use isdigit() to replace the open-coded implementation.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1a6c8a1bc764..3575310c72e0 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -383,7 +383,7 @@ struct tty_driver *tty_find_polling_driver(char *name, int *line)
 	char *str, *stp;
 
 	for (str = name; *str; str++)
-		if ((*str >= '0' && *str <= '9') || *str == ',')
+		if (isdigit(*str) || *str == ',')
 			break;
 	if (!*str)
 		return NULL;
