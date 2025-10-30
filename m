Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783736CA97
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846935; cv=none; b=F66Q92gdP1cfXO1WpZ4sUaNhubIukM1GEFm8BAPaHIRcXby7z+FGig20PShIAxIHpXK01VDEgRHzZmFxVpVlw1+IXnQKW7HHArzHH5L1y1s94w9VkcX0gwcfCiuOWreaWP1raWtThXZpOlgEnFf71ZS4bzoQrnwm0Gxx3MZMED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846935; c=relaxed/simple;
	bh=KXgzGd6gNo09gi0VZSrUZARuDuGxlTCFI7gHi/TqNjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnsM2GnS7K6DMq9IFXG9J6wNZRMjyWWnkylGh+70qnR27A39xDITOtW0TeW2B6p9u7xAuNvTfRQydOGx36lSOOs1Usx5SXRdI11SB/3i6eWMbldG7K4trUApnFP2Sey5HB532IIIzKWjeA0udRGlwiQpNXPjmGhym7EBtXrZIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJxsvXJy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJxsvXJy"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso645294f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846931; x=1762451731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NV2npGkfv500PmnI9y9LBiyb4UX94aZHfGA0F6aPZeM=;
        b=JJxsvXJy8xGyi60rXx7saWafLF4CUHIy0MhtDrZxYJWXUbS3oekbNu01FzAOzQld47
         FMX7j4GMcj90L07+YyRQ4kGHznI6/O0lj8a+lA3muhDCHTMR07QvVdOkkAAaI7ebMKkn
         F80hlCO8RufaMl9A9UEpyzEGlWmwacZNhbqzm8NxBcoOOEdfl1WHOqgaNtiMuD9HrgQ3
         o7CsC4ckQ7Dm2SZu0mohcdpJt9AtwYmxxppYM+Byfb8Gl2Yg+WKn8ZeC2F4SKCjapOnB
         An5Oni7TdMwpFxD+blL1yqigB+OoCZWRjQmIvr0qo0AmseCr8XY05chIbSrAPQaRRiXq
         1a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846931; x=1762451731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NV2npGkfv500PmnI9y9LBiyb4UX94aZHfGA0F6aPZeM=;
        b=ja+Huc69QWp5XjeX7E49Dq1BTQh6f0zW0wqS67mvsTcyKNIL+e3MxxorBdJ3oP+oYl
         vNz+OAOJvsnTguyvrF+8brT+OTwWoU93EDp1rZ8nVbDzr+dH3z1JwEIFbGFCMrBWpKm2
         RCa76utBU0OU4SSucQGw8cYe/7zIuoYzR17uES8eBZ4Nj1EhyHjwo1Pj/uYl0j+GHOnB
         AzjJngOIXE34XKSOIzwXL1+UaFD8BmDzuOpx6iXeI9FILpp2az4iITu+Xwv53jZd44Q3
         baZGoRIjA/KgDaTHwgxzHvXutnA/Dfjp/MyqpQqqq46bpOynmZt0SDsU2/gfmJfzhUsV
         ommQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhS41VDXkMf1q1v0Rc5kO6DU0w5jTldSvxQqTZcis1qUjSsub/h8YQKEVpK1Wl1XfBXQzKymUP7CtRcQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HNR2A22/1EfPB8V9s4L4RPprqR6dCQPGs6U4kCict3/sF+oi
	6VGUS5dLnU6tu9/SPu9R85D/PrXCoul3a/aysbCIpLR2kXtLgvxIbyph
X-Gm-Gg: ASbGncvMZhkyvtoZOQm7qvt6RN1EmVauwGIa+iFdTetEyNg9gr4hIiB+tEPwtLBmfBF
	ZCoswXQRs6j03DaK2JKJdnRRGzzOR+v/jq1gh8iX/DOXJuv2wz/8IrSd/gHRw5PZ+nTBVaiRk7s
	6d+8v8Dj8AAEvtBmgKUOZFKnEFxBNsOPOBSH3Vs+x4YPuS2eRfXtDiN+D9i7Yz/dHu45vCowSsV
	5lASdZGSbWpnKvhV0JPdCKB0iPr6+T1BTKgt4M4hpIyWFigFxR2i8IYewzuxBhgRuAOMeIv4lo3
	74yrSPIR4wLMGz8C7EcFx4XAle5LHPPhh04wGKsfopolx7xzPL7E/TDYefYlR3U0nCSbPfQ/18t
	qzqNAAco/Zi85ZUGfEM3Y6xsTqeAmp/UloNy08EoL56dFv5Uss9wcGwqrztS8lLnH5O//UuXjQr
	H3odAi3p7mfUbOTq5mo2+sfFTthX5W+R4OwxiTT4mcAJWouIqPoFw4J/Tod3+icOEORQ0KLiY=
X-Google-Smtp-Source: AGHT+IHMkjvLfmwalDhCBBe8OAxHC/LlNBETUVjK4U+fGTxaXOKW/TVcRRYQUO/q05YhnrUanlIZGQ==
X-Received: by 2002:a05:6000:2306:b0:427:5eb:d82d with SMTP id ffacd0b85a97d-429bd68d047mr428378f8f.17.1761846930766;
        Thu, 30 Oct 2025 10:55:30 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:30 -0700 (PDT)
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
Subject: [PATCH v2 04/13] serial: rsci: Drop unused macro DCR
Date: Thu, 30 Oct 2025 17:55:08 +0000
Message-ID: <20251030175526.607006-5-biju.das.jz@bp.renesas.com>
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

Drop unused macro DCR and its bit definition.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 504361ed5ecc..470b5701cd67 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -24,7 +24,6 @@ MODULE_IMPORT_NS("SH_SCI");
 #define CCR3	0x14
 #define CCR4	0x18
 #define FCR	0x24
-#define DCR	0x30
 #define CSR	0x48
 #define FRSR	0x50
 #define FTSR	0x54
@@ -119,8 +118,6 @@ MODULE_IMPORT_NS("SH_SCI");
 /* FFCLR (FIFO Flag CLear Register) */
 #define FFCLR_DRC		BIT(0)	/* DR Clear */
 
-#define DCR_DEPOL		BIT(0)
-
 static u32 rsci_serial_in(struct uart_port *p, int offset)
 {
 	return readl(p->membase + offset);
-- 
2.43.0

