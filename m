Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ABD31077A
	for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434621; cv=none; b=pb7emaWEEpNPY59nCjkClc07aQZbYk7IukVOMbTF1JmN0G4gbc1yes9Rb5vS51kRNBRroGhTvRx40W9nI/PYhPj2duGRybXu1wMco08+y/brRy1lGaCu7WFuYHwjmSHGr52OXN0dBTuR9v9apKM0dBdQEnrwherlIpwI3o4Xmy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434621; c=relaxed/simple;
	bh=p1WYEv6A1wFU0XW9CE8LVYfeNV+9/VBPGL1bg8wroOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0MMxsGL/Kvyl1Kbt6dxQngt33wQgG/48XTeii9EIvTv6nkLCmwhGx5rv1zPD1RUqymUVKHUPhedMX5/D0CkJ2HzRV0cLgfy4aQdWqJ1V0AL1O7qOuy043lUQNNpyCyQe2Odsnbx1cXhbOjyzCjIFdVw4mvZuq4LqAlfrCb//VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaGc2Ion; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaGc2Ion"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477770019e4so22028385e9.3
        for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 08:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764434617; x=1765039417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV/phN61ONyLTDZca1RG2tB5jror9Wjo3bt6PCNvA8w=;
        b=FaGc2IonMgOC3NKAyIFg5urqx4KR7cT1xrVEwhJZwXpEBOKeUKzvA20tx440D/yH4F
         wvTIMyT8B+L5FPTXc13JwBtO2iIL/63tsbP7yKRB9qYE3JpjDezarIWC0py3TgtJToor
         dTED++0iGF9MiTTxIFmtJGPjbIifFaaWs0XKA16ru0WZYYQInKR/mmDUvphz3yVmhCRK
         eScIf+VWMfejWyCAq1Hha82jBr864n1Yzm79vP3wGW4FOacE+g9ibnBasSSCfk0ANqhW
         gYC3CxhnW7Wl6dcLXITCnTpeHnsm/Qv4ThmhJaNkFcc1t0QhefWeFlZC2QXOfYRxFFCC
         Lh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764434617; x=1765039417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sV/phN61ONyLTDZca1RG2tB5jror9Wjo3bt6PCNvA8w=;
        b=SAlLtmQ7K03LyaKPKH8fbpCX27IAVPvQenKxgRYBW81q137T1Fi4uDxTaubKCqzQfM
         jR9SuhgMGPDgWGTdFR/ABBQKBJa6jKiU2bqimIa6IyBlkyuvUZc6JJDeE3yVecef7ZYJ
         wecxoyCQWHkcziabkigK8dnnMI4uQnrO+y2OTON3a8L1bsUDPEGhBk41/JgmPQTgdGJb
         UYPvMCBZSiW6CoF6hLgG9gGfnQuWTsrh+dXTxNvXrBWI4KZqMsmSdwF8wQfXCxyKoyjz
         TIhsGjwDyMIf/7M/8Eqt3rvmAIwElFRP+gFyGQhr6t1k5A/GQPz6Ma8g3GvkUWrym1v7
         2r9g==
X-Forwarded-Encrypted: i=1; AJvYcCXac1+Uz5tZ7vg3THpzTDAinScAX4oL/FEoQm4SDEHqDUKdMOq3/VbMpYoUAgSaapboYbXnZGPBFQrMlJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtAOWZHucZb2L9CyL1AIzIhFD9K/Ft9kxR22GkCOWqj3UIPO6
	RUBf1HzLBqgjELhpDkfjXE9BodfkcgkhADwbyCEg66MJdeJSBqmv4naM
X-Gm-Gg: ASbGncvQ96lhIBXqFzYKcZy02Dscan0AeWO+OMEumweaoYQ32Fs1GxoFfL9jP7va3dR
	jGOoT0sNtO+bjy9SnJfFGLFpGyld5jET7MBByRmoPn5Nf/A8IaF2zg7v1Mf/69hkwD3JW6pq3HJ
	/z6G6112bNRQ2MMaXFl5LqPik25ISeGznaVS6mczMWxSIsoxXWzgTxkKyRpct2Y4RGogrs3DZxk
	HzGKsRferfSeaTQ2EKE59JIHGHwpDEjutYxgdVB4AL3BBmUFZ06V1AioxLGZ8jeg7Its5ezWo/3
	FiaFDfkf54BhSckF2gfaJ9SzM55BD5fJu+wijvfAmTSVhBHl6ToDeOXlO4Y7SNqX3nvdgfzML1r
	kUd6FrnrDZdrNjI0tEKupH7k2M5MRHOCehfYA6ZXgQY5I2WH24WTLwzYXs3B5Dzb6vXjMEgQdUs
	irEYJIy2wJJZ+nc0WS2IJJltKFAJF/ZUxbvGvQVGzjIiVO7fkqELjHYvF4zpwRLAVgW+gbzgjgI
	sl8LYDolmz5JTk4
X-Google-Smtp-Source: AGHT+IGzNOuP5I+gYgfGj36btSZCyfRIbYTuTX4epxDNVcEZ+n3U8KnYkaRTC3aJ8GzwGl3RatIGvg==
X-Received: by 2002:a05:600c:4e8c:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-47904af05b5mr211140525e9.15.1764434616629;
        Sat, 29 Nov 2025 08:43:36 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm15970060f8f.29.2025.11.29.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:43:36 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v5 12/17] serial: sh-sci: Add RSCI_PORT_SCIF32 port ID
Date: Sat, 29 Nov 2025 16:43:08 +0000
Message-ID: <20251129164325.209213-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
References: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G3E RSCI IP has 32-stage FIFO compared to 16-stage FIFO on RZ/T2H.
Add RSCI_PORT_SCIF32 port ID to differentiate it from RZ/T2H RSCI and
update sci_is_rsci_type() and sci_is_fifo_type()

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * No change.
v3->v4:
 * Dropped enum RSCI_PORT_SCI
 * Replaced the enum RSCI_PORT_SCIF->RSCI_PORT_SCIF32
 * Moved rx_trigger update to later patch.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 1 +
 drivers/tty/serial/sh-sci.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 1b9480c7f4cb..abcd5bcc7c36 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -8,6 +8,7 @@
 /* Private port IDs */
 enum SCI_PORT_TYPE {
 	RSCI_PORT_SCIF16 = BIT(7) | 0,
+	RSCI_PORT_SCIF32 = BIT(7) | 1,
 };
 
 enum SCI_CLKS {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 624ef41701f2..a63370f22574 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1184,7 +1184,7 @@ static int sci_handle_errors(struct uart_port *port)
 
 static bool sci_is_rsci_type(u8 type)
 {
-	return (type == RSCI_PORT_SCIF16);
+	return (type == RSCI_PORT_SCIF16 || type == RSCI_PORT_SCIF32);
 }
 
 static int sci_handle_fifo_overrun(struct uart_port *port)
-- 
2.43.0

