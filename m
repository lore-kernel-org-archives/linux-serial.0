Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264E30F939
	for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434623; cv=none; b=cL9D5EI0aHLwmNmCl9KUYW37sPlKFr5i+2d3TG7UiNCOWRdZiUk0HLxTXPF1M1HM52veDcTkM7XLSNVv8brjw1bkSgE6WWwlfpc5XyEIbl/OMO/Zw+tg+Pxcv9VtAGjOgvp3xzysc5IeKxgWZgq0x+ZE8XzR5JgaeFFkMHHpLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434623; c=relaxed/simple;
	bh=YmCSx/5zP/xv39yO1GxM96Pkw3/b6e+V34jI5TfF2ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYMDYuQb5OyiiTGCKiuO46ZMtAgXxc0qUJ+W+C8KsVN1wRgs8+QZcR2DYy/HwBE5Idtc21naA3MAzjRVsMvt/xvxomg4cBm+pC6jj1MO29jjDovWlGsy2mEEZbxLybGeiy26sI25P21h1eu/ZAWN4GKbtSybyGiANqdcOF2FxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsM05OYP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsM05OYP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso12552185e9.1
        for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764434617; x=1765039417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCds5SL6p55Ece6CoMNTKlBAZwv4gWLV93N5BoUx8oQ=;
        b=EsM05OYPDTEyg3fjY2TZ7HRjzESe6KWkNnc7oBEQ6MmPugcQUZc7c8T1bxzsiJGuhY
         9Y2SR6R9ixsBDpBUJChWV+k/+legegkdhy4K1cM8xbaUefRQpBkS1i2pWy2eUmiIuNrs
         H+DrQjzTW8Zz/8ghMUsvZNilqJ2Pofuwb6m+oWajqv9kUzCUaypisYxSVET6ycgI4vB7
         JzGG+DwOuGjcQqg2IaqJTLQsLaF+y10XGx53oFxzFNbe9sqrT5Cf1k6hFrPb87XBFDgA
         GRIZL8Ggrz4xp3dGaXSMqR2k6KRtmfis+zgosOnkbDdd0C+lpAI+oe1ocfNT6dn3j32o
         Nbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764434617; x=1765039417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cCds5SL6p55Ece6CoMNTKlBAZwv4gWLV93N5BoUx8oQ=;
        b=PUGWKKalLah1iDu3CJ+FCtghHv0uLs5KiJ2J+WTVluifRKQiaZZiTMWxQAeOY2G8nw
         ozTxH/6uxYjJzV3tniHqpu+Waa+bAY+i17jPtW8VXKqqUMSVoLwaKjrvmdmy7a42VkiI
         SA0HOp8Fsw63sA0l1jxNLJ30KfQvoKeh8gc+019HwDhzizzicP2Jbsyza0xUGzkzh9Ro
         Wp37d45ttDZ1POwt6OMNYqASskwkGvoHaBd5WH3pNKadiZZ2LixdVy/kiVJ2AKjNq9pa
         q3cXFSufFR3nULFApEbrM+92VNyCYfT6oIidHG2pejulq7NDilA2bdJaceJtfp7k0mOD
         mwdw==
X-Forwarded-Encrypted: i=1; AJvYcCVDEIOUMhz2h6wy3Oe02tGKzt/8QfJR8d4lIjcoSOnksxhF/DPzt/L/VazY82pVyXceDmBHj/ZelH/qRho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkK3k0j2t9cKZisLvhSomiGvifOw3y4yEN+epkdlw/tW1GLw1
	ceLXgZrwJXPEbVxFPMWZDr3AXQByRv+8/qlXmJ0Jlm2I2l1QAP6H4HJN
X-Gm-Gg: ASbGncuScB5Ern7By9zrDlPG6lENQ5Z2MkHSUVGkk5jqWP/3A++78TlPa5rf0wWgz2o
	eWPTu6CryzwaeUHsvg/Z5hPdwMqWL0JUjdFRx+c0EXEeRYqso+9b3KbGl54e8GmJQqRDnCabxDo
	/Sr2kGfs1htiuUGFpqYy9HLtVagM69YdNzbn6uK3eY3hBQYi3Cem68haZuzYpSwShr70adWSA7V
	1iOAbNTVcV9NH5J39ojGiu1pScBR/Tj9fEfA59LB5YEDjYiEwcqZSUPEeAzFAx1k1y6tnXVTpxS
	5Do4THwdyg3aE1RyBrlFSvRsqqr6kEtxlEPejnlmin61kvfQo+pYgoyCOxmCVrqokKvwdRqf0Pe
	rhS11Tk89Tt7ZEhMt3sjx6yA+XoZTYwDJaLmAZ6cpHog+AW7dU1V5IlINELONfidDC8yxFMQy/a
	YeHF0RjC5oIvVQfFVr7zFIbrJ1L8xvl15w60810vSMrNcG8+ePP4vRqAEe9O6Nwuyw+xN043rHX
	sVmwftnTt8yHt0E
X-Google-Smtp-Source: AGHT+IFtzNqcNHQfGjKyo21/21zJkuYtEeH39fIKHX4otYIWX+r0NISKN0ppBUXCX+9THLjyTrnUgg==
X-Received: by 2002:a5d:584d:0:b0:429:d391:642d with SMTP id ffacd0b85a97d-42cc1ac9a9fmr33425676f8f.5.1764434617297;
        Sat, 29 Nov 2025 08:43:37 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm15970060f8f.29.2025.11.29.08.43.36
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
Subject: [PATCH v5 13/17] serial: sh-sci: Add support for RZ/G3E RSCI clks
Date: Sat, 29 Nov 2025 16:43:09 +0000
Message-ID: <20251129164325.209213-14-biju.das.jz@bp.renesas.com>
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

RZ/G3E RSCI has 6 clocks (5 module clocks + 1 external clock). Add
support for the module clocks.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * No change.
v3->v4:
 * Replaced clock name of RZ/G3E from bus->pclk
 * Rearranged clocks tclk{4,16,64}.
 * Reduced the checks in sci_init_clocks() by avoid looking up clocks that
   are not relevant for the port.
v2->v3:
 * No change.
v1->v2:
 * Updated commit description.
---
 drivers/tty/serial/sh-sci-common.h |  3 +++
 drivers/tty/serial/sh-sci.c        | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index abcd5bcc7c36..5d30771278b4 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -16,6 +16,9 @@ enum SCI_CLKS {
 	SCI_SCK,		/* Optional External Clock */
 	SCI_BRG_INT,		/* Optional BRG Internal Clock Source */
 	SCI_SCIF_CLK,		/* Optional BRG External Clock Source */
+	SCI_FCK_DIV4,		/* Optional Functional Clock frequency-divided by 4 */
+	SCI_FCK_DIV16,		/* Optional Functional Clock frequency-divided by 16 */
+	SCI_FCK_DIV64,		/* Optional Functional Clock frequency-divided by 64 */
 	SCI_NUM_CLKS
 };
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index a63370f22574..5d7e78f95c70 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3172,6 +3172,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		[SCI_SCK] = "sck",
 		[SCI_BRG_INT] = "brg_int",
 		[SCI_SCIF_CLK] = "scif_clk",
+		[SCI_FCK_DIV4] = "tclk_div4",
+		[SCI_FCK_DIV16] = "tclk_div16",
+		[SCI_FCK_DIV64] = "tclk_div64",
 	};
 	struct clk *clk;
 	unsigned int i;
@@ -3181,6 +3184,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	} else if (sci_port->type == RSCI_PORT_SCIF16) {
 		clk_names[SCI_FCK] = "operation";
 		clk_names[SCI_BRG_INT] = "bus";
+	} else if (sci_port->type == RSCI_PORT_SCIF32) {
+		clk_names[SCI_FCK] = "tclk";
+		clk_names[SCI_BRG_INT] = "pclk";
 	}
 
 	for (i = 0; i < SCI_NUM_CLKS; i++) {
@@ -3194,6 +3200,10 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		    (i == SCI_FCK || i == SCI_BRG_INT))
 			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
+		if (!clk && sci_port->type == RSCI_PORT_SCIF32 &&
+		    (i != SCI_SCK && i != SCI_SCIF_CLK))
+			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
+
 		if (!clk && i == SCI_FCK) {
 			/*
 			 * Not all SH platforms declare a clock lookup entry
-- 
2.43.0

