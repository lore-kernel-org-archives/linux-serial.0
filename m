Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ABB3B1014
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762529; cv=none; b=RWVHHIXzQ2uETVbIQmi4X0yMFKZwuK2VGnCM/MuUzMvOo4S0jIXuceO9vK04wQrldaWVkZ93xZ0v2m4rOQ90NVs5CSdB7Njwu5R3bvbPM1Dyfp4nTKrmMwpB8C+qyeg7cG6O38rYJpb62a1IQpOHCr673B5/1FUO7Xdual0Pgcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762529; c=relaxed/simple;
	bh=X8W9fGrm68+NdQxaUiu3aZ0LqSsMxvwJOKXUJF3NRok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scGcoJQ3ehzci9K3RimtAJv8TQCsHqiefb39o92u5I2qw2bdJrX2d0OOjZMWnk10KxzF6CWz4nRobT9Da3fmHqejH9nwbtTbD/7cthzFSF6Ts1QklJmEjWeNRAKMDF+dQ+JZQnGFkIKN5JaspaYHnJaQJHmZBqu+gFLikbEtTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCE5Ada6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCE5Ada6"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2546698a91.0
        for <linux-serial@vger.kernel.org>; Sun, 06 Sep 2026 23:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788762525; x=1789367325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FLAE2XmmuZSgKOvA0qkWrT7oMG5vU8MEAkdw+Fem9Fc=;
        b=YCE5Ada6FQzfpkuGlHVhIwt5SEIItzv0YqqKbbLW5cfJ7iYZZqKzZjOQb9QYoULWMC
         EBtcvyd+jWZ4pbO3v/dHRO2G6qKIi8xhS/RZGwrAKIpIZkK9Z1HG38E1cCJ0jeZYadzC
         ClARr0kYU2ALs9CxdobI7bykirfi2kvsRce44Rd56eYwGzfx6iPtS3Nxr9YRtHdIMQ0h
         y+tOHvrGAuYwBDZvtcI8lsXmfeC2aquEkAEZ2XPnFII4y00L4EvFuDYfJ2CmfIsOdxMn
         sa+dd9y7vszF8tMJ3Z7QpHxX/YfyDcRRfa7cfEz9D2H7WhRXLB7ogGoi4bC401Yk7fDi
         A9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788762525; x=1789367325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FLAE2XmmuZSgKOvA0qkWrT7oMG5vU8MEAkdw+Fem9Fc=;
        b=PlRwrMsQoBKaAtTUWZWKPfjVM6CCaPSCdye+G0pSxWzebcO/FYely+ZpRK5TQ/R458
         P4jXT3AswG6XMeiM8VH4NTCaxZSdYO9Y0tDmZe8WoqQpVnbd/JmC1FLuayxHZngpXeNb
         McrXFY9v5e9qBXqyKw8qZ24CshKnltJuV2Rf4GdNXdeb391LlmQzt7dMnY6hPBbQSXhy
         /1PMhY8+Vin4o/8VUzLnV5XAlrihAjOUJ0MBx1lR9B8kuIuHLb/x7PCT/QTyrUBQYTjE
         YkeOW9vyv9EApQP+JC5XLkMLYdlJcJG098z/Mt6OD/TEjyWfdGLXXeBy8R/SgQierjWB
         vhvw==
X-Forwarded-Encrypted: i=1; AKwUvBzBf3ZrW9nKby91x+DflMXxOTELK7gYLeFwG1Th06T+e7q5afhgyGtgF6MSEwOsvLpOtMRgv0WBVaPAAqM=@vger.kernel.org
X-Gm-Message-State: AFuF++neI4pozAuT/12WubtSFDc7ELvIAXNOy46TgRZqONf/KDyzC0/u
	ycDT760SvckosxPIDk8xT2mvcSmYj+oHMibG21yQogod7B6cQbY/vOV0JxPdCdezb9w=
X-Gm-Gg: AYBFou1K9AZRprDIMVZXzm+nFDJ55T6ha4Xlp8FgbLtCafr2ubl0M69H11S/JAmWtu4
	QF+tlQGjijdVIN6YVdoLOPJ8PJn/tvmMbapPSlt2w7kobEZdwpe/hh81mllPFoBY1Al1GftqLB7
	72mN6BTzE5QQpcSbvhvMNqZNx+jPWgVtlgeENZWCkVIyynBeaJPxMFbrhAyT59UT2t7opkElgIX
	Jtcdz27vICj85hxpaGN17z2TQERVmSUkmwaVeKe0b2qsASMH70FdgovX546MTuHrRubNxiShPkX
	NbzEDB8V9VklyVE2hYxpk4uaPss5vJfNeXmw1gFBSabFlcOnAr6sUYihxjlO426ZUMcbI5t4g7d
	w1Fc6pKokxLOTZE84NWgt8e1KdYK+e1+7BXQIcoY62FfRS4bYGfivRrKehsJi1+39kjPcC8IJJ0
	eKqXoUa0wJP87u5DkdK8MqUNwipQHUW1F/8NjjU8x+OxfiKDlHGTTb6pFoMNXcpI0paeIMJIzPv
	TEMLUaebsmu7Q==
X-Received: by 2002:a17:90b:1641:b0:399:1f8b:d255 with SMTP id 98e67ed59e1d1-39b260dd3fdmr30248151a91.5.1788762525152;
        Sun, 06 Sep 2026 23:28:45 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm36612713c88.4.2026.09.06.23.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:28:44 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Vineet Gupta <vgupta@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: fix typo "satify" in comment
Date: Mon,  7 Sep 2026 11:58:40 +0530
Message-ID: <20260907062840.17276-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "satify" to "satisfy", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/tty/serial/arc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 5c4895d154c0..3988e5958896 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -304,7 +304,7 @@ static unsigned int arc_serial_get_mctrl(struct uart_port *port)
 {
 	/*
 	 * Pretend we have a Modem status reg and following bits are
-	 *  always set, to satify the serial core state machine
+	 *  always set, to satisfy the serial core state machine
 	 *  (DSR) Data Set Ready
 	 *  (CTS) Clear To Send
 	 *  (CAR) Carrier Detect
-- 
2.48.1

