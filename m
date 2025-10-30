Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA836CE05
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846939; cv=none; b=mMnMV8Dia5FeXFfofY4GsIFa8Zaa6O4GaEz+e8uNQA0ajNmCzcsHG8Karvxr4MqbxejLcJSO4qnfc/n6wJcMrjT6g98/gNYGJncNnVmXkuYKzu32/goC/Vnvp2BvfModSpSzM6xUvynaq+HdZ8LRvVfdpouCLrLkw9PIRrzJEgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846939; c=relaxed/simple;
	bh=FUUpdN5VqPaa0AglNAM37NGlXaHlU8F1s0H5S0bhfxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kX5AF79VJ0XGtjc2P+G5bfKsrSUAV0BWEo/kV4JoTFveMp7XPA0+AVsgZ2p9bIMPBjKGf78JV2HHIlbXrsmk06JWMHD7aHydzDnFaBjJ699C9Tf+TtscQApV54Ff/tu5Sh0d7W1K0f2MfWwAOVTa406Y3HCkXFbaSxvWTAkupzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLeuDtXN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLeuDtXN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429b895458cso724335f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846934; x=1762451734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx09GhYIQEqgtyHYb9x3QHdYCDiDGK8KkivjnJ7GUsM=;
        b=VLeuDtXN2KJFSg2RW2rvkZQMu13Rlp4GFEPNaVhqFtPZJv5CFNG+OYknmQOhhFDKyz
         8mx0tYDWG2jdrt83B+JeRMCv+A8Q601logzyaGpMUfW/XFrrNm4TfZLLjjUQHoK2b1l4
         YA0IiQWL4DaS6SmOgDo/nwP8i/t+1bGNsacIkF8y3OF1ZzT83AysrcEHfn5vWvT6B4nX
         rlSBFyda8jBKk5bRqDJ/Cjzbq2rNK1/ruwr/T1GnRJAeTxX2KX8c5jG0Pg8GAaePiqm4
         UrZaCSFL53wYn06Z30kKFtWuI2iZTxv1saN8emR/hk9wsAoedb+gxm2chfbKgGsxX2jb
         lIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846934; x=1762451734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx09GhYIQEqgtyHYb9x3QHdYCDiDGK8KkivjnJ7GUsM=;
        b=iu6jqFEuzCiy6RQeBlAiQbw3XMGVHzBd0zb9umd3G3bGpz6YRSmJf5VhR+E7EyV33p
         t8kbvDGg0A/B0qd1awmBuMCZM7/axTP3rf7nbFlByky0HUFwZmPj1H4bjCcNLtweW5Eg
         XRGInNhT4+IT5+Lr+QJRDwdqjJhFbGTByfR6mYpOifZcYildK75WJGOd3BeP/tYfg39k
         iQ5Mmsm5STL6BINQm2f/7s938pUZOBFKuBdtQbhC7MAzRtvxIHw89rOCzMCDyzOCQTai
         jzCPOEDHsitOTiZTxP8G3+JJK2o67Nn5/Rz9mWxPiCpvlAe7Cg2rLh1j5m74M7sijF9m
         GKWA==
X-Forwarded-Encrypted: i=1; AJvYcCU+/FGj1aEIv1HZpRaOh7/RNZGIq/Rb9hWgT0g1uuWCVaULgaw67CAx7aNIMAc8lEaUY77yG5vWFmY5AmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLm3g8v8u178Vx9g5FIekoa5W4Q2x/P2E+umIz5HVL20szPvK2
	pdOTQ3gR/1MZ/upqvYKvXbeizBrPi98W35eEvZGQ3n3eMjtnfymB0ioM
X-Gm-Gg: ASbGncskI4PH/VkmltVC2d4CsV6X5AL6pr7nVqdm5L4PjqTma2ZBH1HugRn9NNe7L5Y
	MtmL63BlQHhx4zBYqCXlWvGdQthUD2l5ztkhPDy5ymcmu9ZX5cEJQxi8WKEGUQX+yFsAse6YHkV
	GRLLBrl2H4Qr0TYxb+Z+V5yGJt4eML97dMJDfBi4vz9okMWu4ZfcTbjDCPP7hjE/ZrCRFXzt80f
	00HRY9MDx7/Qkyv4UuBweQHRkqRg6xWcIsUcf+v1Uz1zOCOv9fxDX9RWZTxX9tH90CdGXsJPete
	0z2t85ANmCFtw2Qe9WXCtHMnE3kubDbvm6PcVcpp/7k1AP35eI/jGGNLozl6CqC7LeDyIr7SKiW
	PAaGnDpwWxVznNMaHMPJc8umfSx0SEQovbSCC33r35cu8FO0GXS/BUlzbELah5H+hfk9Ije+K9T
	Dk0hv5fWLTzpQBGiiibGCA+hDviS072orT6RYhCSyUC2Gt5APebN1quWyNGkSv
X-Google-Smtp-Source: AGHT+IE2wGBv6w4TzgH/dIqRMjz4ljrVN4/hTLrQ5+0NZaeomnqoztVj/d+T+noqIPl5lxRmm33nkQ==
X-Received: by 2002:a5d:5f55:0:b0:429:bc31:5de6 with SMTP id ffacd0b85a97d-429bd671ed0mr446668f8f.12.1761846933645;
        Thu, 30 Oct 2025 10:55:33 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.33
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
Subject: [PATCH v2 10/13] serial: sh-sci: Make sci_scbrr_calc() public
Date: Thu, 30 Oct 2025 17:55:14 +0000
Message-ID: <20251030175526.607006-11-biju.das.jz@bp.renesas.com>
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

Make the function sci_scbrr_calc() public for code reuse to support RZ/G3E
RSCI IP.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 3 +++
 drivers/tty/serial/sh-sci.c        | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index f730ff9add60..a3f4a76cdecb 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -171,6 +171,9 @@ void sci_port_enable(struct sci_port *sci_port);
 int sci_startup(struct uart_port *port);
 void sci_shutdown(struct uart_port *port);
 
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks);
+
 #define min_sr(_port)		ffs((_port)->sampling_rate_mask)
 #define max_sr(_port)		fls((_port)->sampling_rate_mask)
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 67eba7feea9f..ca4915c1e2e6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2395,9 +2395,8 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
 }
 
 /* calculate sample rate, BRR, and clock select */
-static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
-		   unsigned int *brr, unsigned int *srr,
-		   unsigned int *cks)
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks)
 {
 	unsigned long freq = s->clk_rates[SCI_FCK];
 	unsigned int sr, br, prediv, scrate, c;
@@ -2461,6 +2460,7 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 		min_err, *brr, *srr + 1, *cks);
 	return min_err;
 }
+EXPORT_SYMBOL_NS_GPL(sci_scbrr_calc, "SH_SCI");
 
 static void sci_reset(struct uart_port *port)
 {
-- 
2.43.0

