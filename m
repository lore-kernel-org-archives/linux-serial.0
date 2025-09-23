Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F003203A3
	for <linux-serial@vger.kernel.org>; Tue, 23 Sep 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619742; cv=none; b=EI7CbBh4LZP/6/xTzpGPFEhmBeDtlWCfEEVbebL7bqtUCu96Ryek6R0an4T/96hQu5vFCdAg6xN++oes8hiXuGJ4chbQ/+QWkn1UFAyXaEB6Z13sBX4+91ot7aI0JwWtDZhgtqZQNhSKSh764Nao1HMmtHvAVpsYd5vAvYzdrDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619742; c=relaxed/simple;
	bh=NBEQffd2H9uKpV++ZtU70NTiqjKCKVw4AAQiI8qHzlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBW++3PMK51m8Qqp4NBNnQsbJjftT1CFGgnVl8VwSBjk9UtopR4oCNCNRMMa0j3GXh6ynZNWa3krPpIRAkGkWMBMjkqA1qbHHYJkR5fSZZKKQNOFr8J5WdPm8KXwziynEV1tXsWrHeA/GzQqMzglC0ELmubjQmn0AvJ1rbssAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmaCJJWK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmaCJJWK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-468973c184bso20948955e9.3
        for <linux-serial@vger.kernel.org>; Tue, 23 Sep 2025 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619739; x=1759224539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbyITinY33OhIKJ5MBGUt4odwalHEaw3IqQgPt6HVIQ=;
        b=ZmaCJJWKfyfPNMshhyqKIxZU6tW/9Q5gaOCKLbnTnxl5inQ7tBFJNshsHUeBdeb+f1
         i+kwQWyo8cQphIhkeEWRNoyfSGczckqNdUcHcufyOQGOiOmsqVPVGHrethYMCbmTD7Rf
         sX/PyhLipS5Zld5DywQ/w7d4VGz165Z7/k4eHzucq8bM0LTPx5eWmMx1SE8C4cSE+94k
         nFNJlcwWh0VSESW2xcg2Ldz8PjdfrzUJV3xVXd3t/QcBlKAXSSTS8GvUFna8o24943C4
         vfz+1so0SxWBOAIHL4SSPEu/CETD3PVZ1HqNAPkCBs/SawJDd8F5k7XP483uzHwn5PKo
         LxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619739; x=1759224539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbyITinY33OhIKJ5MBGUt4odwalHEaw3IqQgPt6HVIQ=;
        b=jeY4J8E0lWJ+Z9OTXaRim0sBSDjWDpb2MqiSNLE5xcAWmBmyaB2sSmOPFlKP6r/y/v
         o4jVtc4lu716WJrvGotdKfHXxdaztT5YFH7FYBtYEB8nV3AJVyxlI596ArziRwZ9HIKS
         Uwf2/DTqbxCFU1D4oFM8E2gGfsZrLG3QhUgzzMl2OpPrY4y5Y893jzg64nj/xJKyFGn9
         I8ogHK7B5Xjw7qRhDdVmEeUyDQOgAhvaci5osIXySM3ViutSepTI9pcUAxvAWXeeSueq
         DJ7rEvawGzf7MbocTJHtnwepFfSYQeFWgYH8msWgtMlZbRylv+xNIUjIvxoLHfklP6CH
         vHBw==
X-Forwarded-Encrypted: i=1; AJvYcCUKY+tToFC7yy6i1LaIRExC4gKcbhpt1vrcdRc7I5G+YvIzw66do9zna7gKQ5zaJHM8BRKxLv9KtXE97CM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Y26h3yaYHG6Z9bIK6On66EJw3R3fR1xyPPTFOyFgiLT+a4Lc
	3fGwOGtL1GcznLbmGzdRGUqMUXIHSYcUM2hJfeaH2KTMx66LLc4FhSG6
X-Gm-Gg: ASbGncvZopj1lsG9NL/Cld5tIApM/HILKCa6Ozd+wLZj7+dCleSUZwoq+Yp8v10TfgK
	MjvPFUP3FjMs28Bc84QsY7m/nu/PpEmOC2gWinblio7Dnl8JOZpN9bW1njgu4QOXRhXCj+dthxk
	0pBlP+Im1sU/966Jqu36bT0/OwGGf7bWY3j3bN0ebqvCiiGBjr+dgsAhz4Ymj3fWvUejWophj1S
	rE6vP77n5nADOIxcfgSpWHginTlb+ONZCzxEdO6p7RjQ4q7zIaB5az8iIO55mGm37MvA4rAMvW1
	HeOMOdIythqJy4TtvLcNTZMmnPwnZZ34gGrAOF6PzE90Hb3LvkGs0z/NOslk2RgVIdpD7fc7+Lf
	m5DEYs7/J9u9U22VMUeGSC9umaIFyQP7vPrSUqQN9xyGCHoM=
X-Google-Smtp-Source: AGHT+IF7z73d2VuvQnNwt++NqM3EoWvKvnBFDLgcn+C2wjtH1EryvG8YXOQEMCGihX4URtIuIPau1Q==
X-Received: by 2002:a05:6000:2f87:b0:3eb:7f7d:aefb with SMTP id ffacd0b85a97d-405ccbd73damr1680845f8f.53.1758619738435;
        Tue, 23 Sep 2025 02:28:58 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:a5d1:59f5:ca88:d11c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461391232e7sm271956435e9.6.2025.09.23.02.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:28:57 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] serial: sh-sci: Add missing header guard
Date: Tue, 23 Sep 2025 10:28:46 +0100
Message-ID: <20250923092846.74517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add header guard to sh-sci.h to prevent multiple inclusions of the
header file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 951681aba586..22f877e2a17e 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SH_SCI_H__
+#define __SH_SCI_H__
+
 #include <linux/bitops.h>
 #include <linux/serial_core.h>
 #include <linux/io.h>
@@ -176,3 +179,5 @@ enum {
 	(((port)->type == PORT_SCI) ? SCI_TDxE_CLEAR : SCIF_TDxE_CLEAR)
 #define SCxSR_BREAK_CLEAR(port) \
 	(((port)->type == PORT_SCI) ? SCI_BREAK_CLEAR : SCIF_BREAK_CLEAR)
+
+#endif /* __SH_SCI_H__ */
-- 
2.51.0

