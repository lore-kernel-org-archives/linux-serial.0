Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8F374AD4
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847101; cv=none; b=uypxMnFiUWO1LGkdugu0J27bOAe1KzoOYGDfrBH2bSZ2TUm/pRm/TCIvoEYmt02nEgxe9uVt0saBFwkyTSu0ycArdDEUnDXl8E6t33yOz+nbpN8SuDZlD6ebmT9ouInlIp5XzBi+8uGPNW5sw5IVE8PhJ15kHT33Zx25+O2e6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847101; c=relaxed/simple;
	bh=9jcJ345rfMMIxdlmZfAg0y+exXpCpE0R+jvegxv2zm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCvnumwYxS7z8US7LdLOEe8vaTUfysJu3JNeU9ppnRw7ozBDVa2UABF/usGHUeah1a9h5gIhDJuis4K88AneIGuSknV8xZhZYnTsEXYCWLJjgM6PankQquZ+kMtLPfiZ48iX5BBLCjB7FCCouQCuPHQ1PjSK0it2R51ZUR/DJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2/7CgLG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2/7CgLG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710683a644so13481485e9.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847097; x=1762451897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbIsB+JA33Gj1io+1AAFvPQwYHrrul7tUKhFdp8JQ+s=;
        b=g2/7CgLGNM06zuV3it5VB7AXNnSh/EFwuTl55MbCt9TwFejVsFq0yfSD0jmSKpi9pe
         cm2JLb+QJtOCRR5M18Bva9NoODFirJbmNYh8tMNP3WnQzAq8NlnBWM5FaRqObSiuBq4y
         VyBoUir3jd5pGWYhmGSso1bWxq7m4yhFF8RJeY/1yfcLIIh8a/UHOMiL8JKUExb2Z3h3
         JFfz28PD0MH3XYs6RI4fJ2aCZU/gSM3Xf7p6kkYfLxXTwgcAgVVU2RZ5agdCR4wQn/Gd
         qui/5F0a5Qpq77OMC0Hs7K2RN75atwWzfLJrLYWt1inZ9zWvw3xNpGK6yyLZfDPeejDp
         cWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847097; x=1762451897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbIsB+JA33Gj1io+1AAFvPQwYHrrul7tUKhFdp8JQ+s=;
        b=dZmhA4/T0TAGe+z5NtqJnsvbKSn4DfbwtkIRkdkELHijPKtCk8PMpNQ6eVUxcytZXf
         KKXufdo6GB6ke6HKv/9v/3R9GD4ZA64fsWb5CYhNKo7ZvlY3ZAFSFQ5fi04u9s7KBF7j
         /pZ1w3F3ZwMn4BvpbHW9lMnhDpL2iV9mY9VlbBJCyGq0qRoZNii/orylOIHGXueChhMc
         c5QlA+eviF6LWVBrD89EjOsrSoWf+EML1YxqxJdOcIBV1ppTm/1Cj4Ibl6duiajbmoi2
         y/87oBLB/NVf4nRFVbRJd7zGbDz34m4YnT26CZVvBXpyRoK65jbFxNHScjhy3B6w0Bw3
         9t7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMSMJj6oQSnpDfvuel8rPp26CK+n8Xkq/na+aeEKhmBuSnvy9ZtdV+x+SiVj9J1rHDsKaVH2zhREpzDFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNTEy/oIl1wJ00Synlgzovqax+QmpySU3pQdevr8v2rYyNOSMR
	XyE71mAc5/MrYp/XN8I0b5tCODxzDf+dRUjXFVE2hNTaz/7/rC27pLiQ
X-Gm-Gg: ASbGnctA9NaOc12FO668bwTIXoLN95886UeBAGUU2G87jbBhwwQrNvkXjdmYNfYht4Z
	oO+gBCtqKH75gsk7Bc+zs0IuJY0qpSsVxC0ubqnoDthcw1ilyE37iegcYPWCV7sEABwqu5PoNba
	IshhCVtUZV8MZ9C2XHEG5j+mPmmAIDD4ak5vAwRrafLkXxudBVglDZFSA5V05uu+IqxN1+uzag+
	OSVT+OGP8pUf5AHrQlMtrfuag1CNvjIqXQEGgfUihJwqfccc3PCRzuo5IaU/49MNIp82aO5XYY6
	VedH9TaQE0n2ssLOwNPgCEedV15xeShfgd5ZJT/ngI8XdAbOIq2VL6BAaM2MUMStiUZJYUFRj+b
	5o/E1trII2KMiJxxLDg1ZfSp3b2NqA3nqJYAC/Q3hJuwNBovXHmXjo2f4LNNdngDk3UgoQhdBVG
	U+gs7/i9bzhYgyxQ6rrMECEYUXUP9UFQ1U+F6Q/hG0Y+MZ2rl4m+01PIi3Pr+zJPEP+uUKqbY=
X-Google-Smtp-Source: AGHT+IHaW/aKuio2uca4DVlK5hpIYnror7GRbjbf3WKhe549DWwP6AesragGrVL8J6g2M1dW2nuRjA==
X-Received: by 2002:a7b:ce96:0:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-4772622261fmr32312035e9.3.1761847096589;
        Thu, 30 Oct 2025 10:58:16 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:16 -0700 (PDT)
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
Subject: [PATCH v2 05/13] serial: rsci: Drop unused TDR register
Date: Thu, 30 Oct 2025 17:57:53 +0000
Message-ID: <20251030175811.607137-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop the unused TDR register-related macros.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 470b5701cd67..ade5ee479e99 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -35,12 +35,6 @@ MODULE_IMPORT_NS("SH_SCI");
 #define RDR_FPER		BIT(11) /* FIFO Parity Error */
 #define RDR_RDAT_MSK		GENMASK(8, 0)
 
-/* TDR (Transmit Data Register) */
-#define TDR_MPBT		BIT(9)	/* Multiprocessor Transfer */
-#define TDR_TDAT_9BIT_LSHIFT	0
-#define TDR_TDAT_9BIT_VAL	0x1FF
-#define TDR_TDAT_9BIT_MSK	(TDR_TDAT_9BIT_VAL << TDR_TDAT_9BIT_LSHIFT)
-
 /* CCR0 (Common Control Register 0) */
 #define CCR0_SSE		BIT(24)	/* SSn# Pin Function Enable */
 #define CCR0_TEIE		BIT(21)	/* Transmit End Interrupt Enable */
-- 
2.43.0

