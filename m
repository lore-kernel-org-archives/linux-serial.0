Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB56030FC30
	for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434623; cv=none; b=MwgkACb2XF1Sr60aevuGIkuPzg7NnZQQ2QjQPs9uXkAYqNDgBpqCxGEi4M2BGiW2x6rcz2ua3o8WwMl0qUVSvwyPFSsxglo9QWsDtZFPJubP0hxKxZJr2TX2IAsdctiDyNDn+eQD+fCQhkHG0LcXrYfrmbVwiQKKGx2wKPJGJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434623; c=relaxed/simple;
	bh=TT/L8D+DPx3PadZQsD9/6YfQ7uKMMz9N2IefVEmqDGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LB4YsK3aiPEZyZU9Ju2TJKfIfb5tOOGlzjSE0smAWU/c1Ef/Cf/84v99eO27DDRpOVw0Lj0YUkJpmt+WS/kFMUep89H703K3mVgBLWRcagepGZrZwKLRu1Hbhwuk8zPF7Iomfu3tUF+vqR4ikmJwCC41k89eI6F7MRZJH4n1jSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpENuIw+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpENuIw+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso16197355e9.2
        for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 08:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764434618; x=1765039418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQMRt2Uwt/gqU7bHz6od5jmCrmeJ5h3FXYG7R4U2WHM=;
        b=cpENuIw+Vf7iahjP4+7XJ745OBkv0PZfFR8gjAqIvLi1K/A7FjKpaPr+uLMd8QfDG3
         3qJ5+1I0GMBgtTvZgBsPKR7vVtiyCxwqHe+qRuRZjQ0TxEBp5oPAxn/6se/+SF1/utV3
         v8kdBvqxW8eYBokgPlAcxcW+FvjsQJJPFIQKv9KnQpt7KX3MkUb60G7pwHPr+IT54OFC
         HVMdm0oLpD/Y2daXv324cUe3onnkFK3lOEzZYjQLNdDet2fByYFPcV83C5y/Vf1dlmdm
         wFaNFEm0PgTRb7CWpHkgiAjpnHaI2FQi5RkvyxnoVVHs3xMviHwUxptgVZGXM1L/4hSa
         W4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764434618; x=1765039418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQMRt2Uwt/gqU7bHz6od5jmCrmeJ5h3FXYG7R4U2WHM=;
        b=BDTL8z6uvLAAos9T73C9+3TYVCs94vNLUnCnXwn4WVi7xOA1aCC9zwb7ES1lJAKLtF
         nclXrSkMGWMZnzzphAcfzDGIzoPjGTMmamQsde5RkPLecUlfCosmLLPUmOJz67i/LGhO
         8MJZaPm/vvRRSEFn3Ys4iExXHxaQCzIF3Bd10Lta0XqhNoO7McfWsTf5gTXHIAQDZBME
         9nsonz9m943k8DNT3SCOgju8SjkaobQro442INaXphdvbm2dSwxpY+WYkt4zOhFSdkRY
         MyQ3nLDEg5hBJdBeEIEkB8z73Lkb6xdIiGhOQ5zW/mrDrLUYI2zUjm/gQavBN7bIiVoU
         wmtA==
X-Forwarded-Encrypted: i=1; AJvYcCXucWZnARgnc6h4eqJuehpf2VI26bko8/NKOQqppYsmnoGnZcdYFNNV6BfIGVJsnSqeVfhBOhgjcC3/O00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xfsgYBB2vm8TcgtRlzOqAnK2CMoANFFSMfmgagylsZds4cXI
	WjP4pEtVVWxulvwxlFq9Oif+HVzPxqrTtRZAYE9+uE0c8ItGABerTnNH
X-Gm-Gg: ASbGnctX+nGghzcV0znlYl5CwLu2PSIwXNZxhJEMKaZkjf+ekU89K7AU759GbrYovQ8
	uSqGNPvllIzy1EpOliXyurfVp9mcn9GayM8w8j6KBUiV2P4PYqz2+SxjFjrxEN/2sLvyvqgIIYA
	KZqyWguRVGXcSg98B/dUd+OpQfCHmdirZ41pUcuMsdvayXEEEHzoN0SS0A2QH5j7XysPzYSFdkl
	pDJAZMTxpX5rRDK8x7dxiKPWmIKDcfDoKgjsuAgT83dZoCOglcGwqbKnb0gYfVjTvBisWp3GVlk
	iBnIMPSlyiyFIqTdCGMo/6sz0Le3x/053KV7BIfLopBwgoluRJWBKJASnGW1prHYGTKkBjZPekM
	HY0xOHYm9qDFPI99P4A1GPW8zw3weepCUH6pyRDWlhV18xln0Y/Y4V8qBeRNYFxcuPRvUc/fy6r
	zWU/8ezEAufqyNzOKnNAQWH1C+T/XW7ficQpX9b8KJub2NvyKsDcR4YfbiN7MBeRzCz1FjofHYG
	Zo3UdhI1hg+nZWV
X-Google-Smtp-Source: AGHT+IGDGob4+ZaYdvQdfCK+1xhcDfbYjh04gjTGQLuDVEOxYegqBaf/ci4z1iCYjQ2Mx3h1Ew3RdQ==
X-Received: by 2002:a05:6000:22c9:b0:42b:2eb3:c910 with SMTP id ffacd0b85a97d-42cc1cd9466mr33476719f8f.3.1764434617923;
        Sat, 29 Nov 2025 08:43:37 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm15970060f8f.29.2025.11.29.08.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:43:37 -0800 (PST)
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
Subject: [PATCH v5 14/17] serial: sh-sci: Make sci_scbrr_calc() public
Date: Sat, 29 Nov 2025 16:43:10 +0000
Message-ID: <20251129164325.209213-15-biju.das.jz@bp.renesas.com>
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

Make the function sci_scbrr_calc() public for code reuse to support RZ/G3E
RSCI IP.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * No change.
v3->v4:
 * Collected tag.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 3 +++
 drivers/tty/serial/sh-sci.c        | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 5d30771278b4..976e394ab968 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -169,6 +169,9 @@ void sci_port_enable(struct sci_port *sci_port);
 int sci_startup(struct uart_port *port);
 void sci_shutdown(struct uart_port *port);
 
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks);
+
 #define min_sr(_port)		ffs((_port)->sampling_rate_mask)
 #define max_sr(_port)		fls((_port)->sampling_rate_mask)
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5d7e78f95c70..e2ba752f9c16 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2573,9 +2573,8 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
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
@@ -2639,6 +2638,7 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 		min_err, *brr, *srr + 1, *cks);
 	return min_err;
 }
+EXPORT_SYMBOL_NS_GPL(sci_scbrr_calc, "SH_SCI");
 
 static void sci_reset(struct uart_port *port)
 {
-- 
2.43.0

