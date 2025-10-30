Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3A36CA7C
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846938; cv=none; b=dcb8PW81dsrn5M5OsAIm0hiG8zv9DLkLmGw81HN6CNMLpt6CAVCk6KH2Mju9lhZwsf9Nwb6tKfsfI/uenHftrcvlvgw6GSzQHtS7G4K6TcMdsYdZC8RFtCz4r7oTokCIpWKQk55cM5LwS9YdWp1+8CrbIvkKwQlPtatwRubgYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846938; c=relaxed/simple;
	bh=HUpnC1htM18fOjkA4XpHL5QRou+4yn4bYa0B4lXoOyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1ILu1TAl0dEVe+LPKAIVSzPNE4sBhL9zetuvvTZINYJIc0iCkJ9xWh/KiuoqXAjgJ5vlVi5zNCDIpoLIzSavElFmyN9w1PDSIoVqvP4xssZ/n2s1akpA069W5WH3CCbnxnRQ3uFSV4oO8Mzy13Cjdu7H75sEb4aP2+sNFu+xbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjoMLTIx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjoMLTIx"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429a0d1c31aso939276f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846933; x=1762451733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEUFPuIhsavAXgb0AC7F4BVlpWod4yVZ6DEuITlOuu0=;
        b=YjoMLTIxKin+/GWOhbVfyK4bQIQ+l/X64jHnWln8KmJpjXDCtsz4i7rEMQN9xg+8yS
         knrX88QyPBfEoSuewqVkUUnXBHIOTeCUbE4Ysh7Fcm0wfEOCq0Tb311xPCsKoncOIaIR
         xKukIjZNbrqzV67CmJY3EDdf0oczljYrFSSnciPFL4GzuIYRKWaDLbvK7xvlAGCorbyz
         oUVcmnbb+HxdpS03aBz/wuBurylhXqskyR61bru6f7vp+I/VngyI4YXD/nhFTscrBIo9
         hZaZk2Mc4jb8iy413u6YClfBowwAu5DZ19duY82DYsyuO4nmhmQ2bnYCgtZxkZ4CPrlp
         XN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846933; x=1762451733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEUFPuIhsavAXgb0AC7F4BVlpWod4yVZ6DEuITlOuu0=;
        b=neXX4kRUf7vHSwHK3mY1SZqSdt6z4Qy+B8sjB/Vmj9T1AddrUAPJfQKN0HKYOLaB8P
         u1XJoj0oO2vgU6DW665km0VHFAiY2rcnIcBnX3wuDSiW8mqnkOtkDLyhT7ZDtOGhebjD
         GM1ue94l9MZi+aug8wHPd/suVhMdqB01li3Vhkiv+RP4+tg+MaQBDhiSUrmRQT2BCKst
         eZ19+tOAH05F2X2k/tJPt1LV5dT/BkPP6CDUXmx+cb/OCLEr4Sb47f3ONz3lK0R0hKJ8
         27gtVeFC1Q76UmXUOqO537zqY2dLMxkXUTFb1ubIBc4Eam+TbareFjHhlWVhPZzOupz/
         7zdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY1TlceubD3/NOOW9WKrqRtaWsuMuZTPl/94CIcnqGCtgxPbVMnZin/oEWe8teP2au8H9yW5KI192EL+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyafDo8DEgXcDd1pEMsZnJMuNdXSdzBQiczw/RSK6b1gFHKlbMZ
	71JPPDvtbcTbB4UtCkxhpiWFu7Yb0Mi8YbeTUg3Kv2F32gXFrBjTFoFI
X-Gm-Gg: ASbGncuoBZ+uUNmkZ3Ws5oyttCn9SguMIPRMOH8qATEod/8GxSFoJJ9J7s8S3KtgQ1m
	qRHN5aBq0yYTq5mRrYhGbOXKpCNzHX2v0CD/bTfbkmqu8ulcEN1gFKWKD46PoosK3nKALfnkmSC
	2pKGkZ+5TqyY2ELnSlx5pGrf7nSZMQivTec3bHFEiF5UX+wxMD1PnGTYGLqtFIvUE420THtZZK0
	epuJZ9kIvE7kJ6jcG8PnYdxGqsyblpD+XvPPAHKtOk5bRNQBLOUArCCWs2YpsmImfhxu0DY8eJ1
	LjkiWQeb/w02w7v61/aVp7kK03oDwtWWvSFfS70y/jdpuuoMwlUWNXyXBYekJAhfWc6LNNFZ7Bq
	eglXu/S2tfHb65pOFLtD/H1htWvLbMIYSL4OjUFkjA4Pu+02dDIsutSU92/HEYsgjUCVNBcky+h
	rWHF8DOqU4XMRnG0CO43nxMMqm9SlxcC8dbNcFAW5ySvQSp5HAzNwNNGTUVh7u
X-Google-Smtp-Source: AGHT+IFlRpzCZJwVLyz4vd+bbM0VhDvQFIr7m66Xdde7XxC4dW/e2SY7oK12bgM2QVykMekDGxO43g==
X-Received: by 2002:a05:6000:2308:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-429b4c8b48fmr3544505f8f.26.1761846933193;
        Thu, 30 Oct 2025 10:55:33 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:33 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 09/13] serial: sh-sci: Add support for RZ/G3E RSCI clks
Date: Thu, 30 Oct 2025 17:55:13 +0000
Message-ID: <20251030175526.607006-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3E RSCI has 6 clocks (5 module clocks + 1 external clock). Add
support for the module clocks.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit description.
---
 drivers/tty/serial/sh-sci-common.h |  3 +++
 drivers/tty/serial/sh-sci.c        | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index ef1d94ae8b5c..f730ff9add60 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -17,6 +17,9 @@ enum SCI_CLKS {
 	SCI_SCK,		/* Optional External Clock */
 	SCI_BRG_INT,		/* Optional BRG Internal Clock Source */
 	SCI_SCIF_CLK,		/* Optional BRG External Clock Source */
+	SCI_FCK_DIV64,		/* Optional Functional Clock frequency-divided by 64 */
+	SCI_FCK_DIV16,		/* Optional Functional Clock frequency-divided by 16 */
+	SCI_FCK_DIV4,		/* Optional Functional Clock frequency-divided by 4 */
 	SCI_NUM_CLKS
 };
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7cc2b622e270..67eba7feea9f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2994,6 +2994,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		[SCI_SCK] = "sck",
 		[SCI_BRG_INT] = "brg_int",
 		[SCI_SCIF_CLK] = "scif_clk",
+		[SCI_FCK_DIV64] = "tclk_div64",
+		[SCI_FCK_DIV16] = "tclk_div16",
+		[SCI_FCK_DIV4] = "tclk_div4",
 	};
 	struct clk *clk;
 	unsigned int i;
@@ -3003,6 +3006,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	} else if (sci_port->type == SCI_PORT_RSCI) {
 		clk_names[SCI_FCK] = "operation";
 		clk_names[SCI_BRG_INT] = "bus";
+	} else if (sci_port->type == RSCI_PORT_SCI || sci_port->type == RSCI_PORT_SCIF) {
+		clk_names[SCI_FCK] = "tclk";
+		clk_names[SCI_BRG_INT] = "bus";
 	}
 
 	for (i = 0; i < SCI_NUM_CLKS; i++) {
@@ -3016,6 +3022,12 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		    (i == SCI_FCK || i == SCI_BRG_INT))
 			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
+		if (!clk && (sci_port->type == RSCI_PORT_SCI ||
+			     sci_port->type == RSCI_PORT_SCIF) &&
+		    (i == SCI_FCK || i == SCI_BRG_INT || i == SCI_FCK_DIV64 ||
+		     i == SCI_FCK_DIV16 || i == SCI_FCK_DIV4))
+			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
+
 		if (!clk && i == SCI_FCK) {
 			/*
 			 * Not all SH platforms declare a clock lookup entry
-- 
2.43.0

