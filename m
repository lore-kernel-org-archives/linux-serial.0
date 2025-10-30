Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5AA36CDE9
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846937; cv=none; b=rzfaENn2NZ5K6pNIGuze6vEa6tASohjgVbZpLdvGlT6F9HdwlvHOqBXHMDpcQq6yOLqGUCUHCK0hnAnS5NQHDABS1PUM1lKy00MOoTJp9hiAIqP8cc9BligDJ4A092nvWlJIgY0zuD1cVt8POZhbxmRuvBZnN+BA+mLkEU6tsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846937; c=relaxed/simple;
	bh=hRGcrf757tBUlPVJghD36FxXRGKWF+Ddzd5vihoN5uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KD4+vwdDpQpllms95k3y84rjEQozoOHqcrxmGW+XjVnmnr8EP1jdOnS7Or+BHp0Gy4vSY5TKx4feHhx89is95t0doQ7hi5RGMVzZSNrzKV1ywsbDktCbIttE/nK3EfEWI80wR1Jipmz733zurgtGvH4LTRCG7qvZiDNVwvA9jR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGe/LOP6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGe/LOP6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475e01db75aso9400935e9.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846932; x=1762451732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uqGmMoi1PPAQaFicRlny+AD/MJGroEdg5O4X9kuPbw=;
        b=JGe/LOP6kP0kR3YkY8Zb3tovTrvToZP561qYcPgDTZTAhjepk14eHemg5Yf1+lX4hc
         B6kXOVgC770FUX+5EnJhk/tYMqMh7QaN2KD1spjLFmyWj39Lm2vsbdAF1RcpeNSMm+4x
         Xr4enHaO5Fdxcl/hh/iMjfEOI2qDUE4TGc7CqepFDBejhlPBdxoz1Qh0GdXyFAoWcVvM
         RJrkMmGyVU2WKyyUjzb8YrKyyPbl5BS9a6+ZiEJvZh9ClX2hX1zme6GV1WYi3jo5HL4V
         QIlaaAZp5BELY7hS9AtYQ4GBSRH1r3cn07pTn2pVkiVHhrebYnnD2oFDLaNwnPhYYWWe
         0ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846932; x=1762451732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uqGmMoi1PPAQaFicRlny+AD/MJGroEdg5O4X9kuPbw=;
        b=s71Mh4akDGyFKZvxafl9tDOtwvaqaqFMNJCUVUWk1mtTvtlW68kjWnOkRR164otXy0
         3T1+JcyMPB16/qJ1rK8SSGR60ojLZSe8kXbeneVC+TMaY+L1R7agxXfk/Po6s/Tf9mLY
         thvfmi0J778bIp2MlizkpDyvY/8GQzxiAzJBHsxzoAH/g5KUuQMIMIiwLWNiEuVErGaB
         nUYC6WkWx7kgOhISlJ/i0Tx3O86hhloL7d49cpF9c0A1BW8ch3Bexe9fpe3M628MhQjg
         HVUw+xaRyF2O6itlkhy6pu5xChQoe/jGii23a5nN2J8l7rdaYopn2dhJHz7LhrgusT3D
         2uXw==
X-Forwarded-Encrypted: i=1; AJvYcCVxWchvGEnA1b4KdgmxHNnxGZ31dfBKvGUyn50uJ32CFlg+yiiQIt6iNlnqfamEuc+88nr0I62EWiRKvsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLMWukSLiMrgrRpvdDNkDVs1P6SW2UxOm4HIbqgcRQcvwhHWJ
	Tc/+SRWOWTcYb2vjBiSHbQs1pQew5VIBp8Bar6dvDKN3pB2FUax8Xb1S
X-Gm-Gg: ASbGncvGK1t16Ajn6EphqzIoluwgOZegi9wdAsd866YbCMMw+KPvT9bwbnDazQ9zH8D
	z/cEhLz5PulbS2ogOqaofWIsVV4KMjJ3BqwkujdIOZWI7cAo2kCJNKy5WIP9hm+mBfKsM6iMXua
	RgCOLwefh+mD7S7XdSQ2MUAI++dbqD7Yos4NN4HiiBVIhAQvu1z5BnivWCgbIH8XkKJFrmp64YW
	1+MQoVNtD8NMf0frtkP/4X8dIIRxh7F8QG4P64KsqqqqziNNjDRWF5WYNsteNFRECoP3nzgv9vd
	9utQC7SzrZfqM1zVYO2a3gFAS9a5xhEhBqXdecnxSmhOm5GD0tajPVStQ/5Zrn2MNWdeFXUxt8T
	+sgexwWeZgXicr8a8lv4HQMrjz+Pa0JZbZVg+tL9dNs/mvvCHWkrsLZ5baaZYSvzcYcOl4XCnI+
	vFohhN25G4rZURtF4omazT/qOj7E7crmfjmd3AOp2SiOtT2hpYGZys4LNfiN92
X-Google-Smtp-Source: AGHT+IHhalSgP2kmhosVrLIAl+xUpJ8DATCni255mO2cl/2W+LygbY8oRYqgCijoqXjlLsSWAJ/x0Q==
X-Received: by 2002:a05:600c:3e17:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-477308aec8amr6285475e9.31.1761846932213;
        Thu, 30 Oct 2025 10:55:32 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:32 -0700 (PDT)
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
Subject: [PATCH v2 07/13] serial: sh-sci: Add RSCI_PORT_{SCI,SCIF} port IDs
Date: Thu, 30 Oct 2025 17:55:11 +0000
Message-ID: <20251030175526.607006-8-biju.das.jz@bp.renesas.com>
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

RZ/G3E RSCI tx/rx supports both FIFO and non-FIFO mode. It has 32-stage
FIFO. Add RSCI_PORT_SCI port ID for non-FIFO mode and RSCI_PORT_SCIF port
ID for FIFO mode. Update the rx_trigger for both these modes.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 2 ++
 drivers/tty/serial/sh-sci.c        | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index bcdb41ddc15d..ef1d94ae8b5c 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -8,6 +8,8 @@
 /* Private port IDs */
 enum SCI_PORT_TYPE {
 	SCI_PORT_RSCI = BIT(7) | 0,
+	RSCI_PORT_SCI = BIT(7) | 1,
+	RSCI_PORT_SCIF = BIT(7) | 2,
 };
 
 enum SCI_CLKS {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d07424caeeab..6f396e1151d8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3149,6 +3149,9 @@ static int sci_init_single(struct platform_device *dev,
 	case SCI_PORT_RSCI:
 		sci_port->rx_trigger = 15;
 		break;
+	case RSCI_PORT_SCIF:
+		sci_port->rx_trigger = 32;
+		break;
 	default:
 		sci_port->rx_trigger = 1;
 		break;
-- 
2.43.0

