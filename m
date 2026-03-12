Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3876E347BD4
	for <linux-serial@vger.kernel.org>; Thu, 12 Mar 2026 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304038; cv=none; b=fJMQNoGAw4pN77+r+1P+R2QP5cuBu74Md+ZDw/GhWIFvnXgmpGz5UllJtnnKeP4H0/WLavu6f+fLf1I4KUYFD4sRtfRLVYue4zcCBvLRRKVq2UrfDq9APdZqjiSijzxlEWVHeeZgIwJuZN/+LZE0doY9atawZyNg8ffg4q5X4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304038; c=relaxed/simple;
	bh=W7n9PFfmbHD9bBHfSmJxQdqiBTG9ld7PAttPVTL2itA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqwgQ7pgEbfI84rP8kR+oBZklg/QL6cwwTRjOgoF2t0ssx04f29rkIJUsOdS+jx0CF26BF1o/b5HNqg1bIRuhBDJisnjwkMstVVWtEViJkZhLGhM8YGeXNIbRuP6vJKQqEsXZnms/QiKu0GKmqXNwIZ9I2dhnZR8nntT/KEEYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9XGb8Pj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9XGb8Pj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853aec185aso5932545e9.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Mar 2026 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773304035; x=1773908835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+fTCUzr1yf+dyuiZw+j1NGb2VJLMPVc0xP+QNm1+WA=;
        b=H9XGb8PjHMIpjA7OfqB3R9gKSNfRYDOwQTsTiaFBNiap/U2GwBp0YN8x3BSjJH/tGs
         mdOLlLiZc9WYJZdh84GUwxNjlacqCYyW3e9/d07qup7BxXkPHXrK+1KqfNSeLLLXAq9D
         /scB8eANGm8kYdkfuVLwr4gzg3KpcsdZqdpgJBkXNKN5HT/CNkvSaBjuSsXNslpKJMKl
         Njy8VsK2Wq+rQxDnj3YRCYCNrxLzHkIa7n7YWCN0aE0QrhOPlZz+zxd2d20CnYrQdxVS
         TgpkPK3KuPPtwDOYRCagDvOXPXWVRGPDKIcsZnJRhEigq1/urEBbaEGq/mmJl9oan6u9
         iAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773304035; x=1773908835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+fTCUzr1yf+dyuiZw+j1NGb2VJLMPVc0xP+QNm1+WA=;
        b=PyHziABmJzDrKtl4Am3zLFznQUNNhQaxYyNZ69ADqnhC4XKKB2fu84Ei+HonOVziFl
         mb7Nej0hHqNJepdCiOkFeEgMvYWg1HXbYSdc0NFDHshuNg0nm0a2JZGGTg0P5mDvy+sL
         v4qQbpp5958k2tQ+dKLJs82L1XG2zorqdwcR1NrbHGxOUblzQ5ND+bzjMheDUNZFl5Ys
         PVGnyoV2nSisLBiC2B7YmKnGyuhuoKXhMOF3vL586SSXEP5m4j0zc2eWPUwW6KifiGLU
         onMEtC8FVxKWm7z/9/eSTOQvcOweeThvWF6wCONOWQ3uxBsxKuiV4JHizyvsR2HG2+V7
         SbIg==
X-Forwarded-Encrypted: i=1; AJvYcCWS3rZS8JSjs1FQLn69wbdCsKn+2OgiFd9W3slXMqfGluCOgJ8AnL4dukuPV22Y8+Yxi8126BWTp02B/Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+0pcaC0eIJLnQSuZ3TIVg7PytqeWUfdFp6LOdGg3p/5Wz9aNa
	cBNUS8DJEVZol7mVuKMdyrAIEWcz6HMFuoNk98mGS9M+V0qKKHHm09Ly
X-Gm-Gg: ATEYQzwtsLJlhiP1vOLTs7HPvTxDkGOynU3Sbylvkvb+TjF8sUXF9/ikt0NGOjpfm1r
	SR3hVqGgVuBMRZyJmic/oexWUR7Fl/RFN/bocCP2gP/R0Azk9QRVaKfPv3HVoVj7slwtZ1xeGiz
	5PaWFW307RI/gGMu1sKKPL0/j4VSoUWe7h+rpn1pk58Ip0Hn1f4r3gUnIIU/EAnvTRU6XeCBXOC
	EXXg87XfJ18QY2BrME98vBjSpXrWn0xV65en/mzJSbvieDKSpzGI8jEX5a4yuGfrXKke3gDeum+
	WnHn3wgX+vNpsiAfHN+j91LSEvyktXYWwb0rkcGZc9F58wlkvovQAfiSKWtzqDLWQA5p8g5Et1m
	4scV/a+/zURu0W2myQERpoji+4iw/uPdPbIutHWf7HHHL0YtzraBg1RxX07zf6FVjrWPYbIxDY3
	TDENIf1wgMYAqufYjsu+t2yM+naT2B9B/l6N3VELzUZp5IhtU=
X-Received: by 2002:a05:600c:5298:b0:485:445a:87d1 with SMTP id 5b1f17b1804b1-4854b0bb3d3mr90512615e9.8.1773304034486;
        Thu, 12 Mar 2026 01:27:14 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2eea84sm65925065e9.1.2026.03.12.01.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:27:14 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 2/2] serial: sh-sci: Add support for RZ/G3L RSCI
Date: Thu, 12 Mar 2026 08:26:59 +0000
Message-ID: <20260312082708.98835-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312082708.98835-1-biju.das.jz@bp.renesas.com>
References: <20260312082708.98835-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for RZ/G3L RSCI. The RSCI IP found on the RZ/G3L SoC is
similar to RZ/G3E, but it has 3 clocks (2 module clocks + 1 external
clock) instead of 6 clocks (5 module clocks + 1 external clock) on the
RZ/G3E. Both RZ/G3L and RZ/G3E have a 32-bit FIFO, but RZ/G3L has a
single TCLK with internal dividers, whereas the RZ/G3E has explicit
clocks for TCLK and its dividers. Add a new port type
RSCI_PORT_SCIF32_SINGLE_TCLK to handle this clock difference.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c          | 13 +++++++++++++
 drivers/tty/serial/rsci.h          |  1 +
 drivers/tty/serial/sh-sci-common.h |  1 +
 drivers/tty/serial/sh-sci.c        | 14 +++++++++++---
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index c3f12df693ad..b00c9e385169 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -695,6 +695,13 @@ struct sci_of_data of_rsci_rzg3e_data = {
 	.params = &rsci_rzg3e_port_params,
 };
 
+struct sci_of_data of_rsci_rzg3l_data = {
+	.type = RSCI_PORT_SCIF32_SINGLE_TCLK,
+	.ops = &rsci_port_ops,
+	.uart_ops = &rsci_uart_ops,
+	.params = &rsci_rzg3e_port_params,
+};
+
 struct sci_of_data of_rsci_rzt2h_data = {
 	.type = RSCI_PORT_SCIF16,
 	.ops = &rsci_port_ops,
@@ -703,6 +710,11 @@ struct sci_of_data of_rsci_rzt2h_data = {
 };
 
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
+static int __init rsci_rzg3l_early_console_setup(struct earlycon_device *device,
+						 const char *opt)
+{
+	return scix_early_console_setup(device, &of_rsci_rzg3l_data);
+}
 
 static int __init rsci_rzg3e_early_console_setup(struct earlycon_device *device,
 						 const char *opt)
@@ -716,6 +728,7 @@ static int __init rsci_rzt2h_early_console_setup(struct earlycon_device *device,
 	return scix_early_console_setup(device, &of_rsci_rzt2h_data);
 }
 
+OF_EARLYCON_DECLARE(rsci, "renesas,r9a08g046-rsci", rsci_rzg3l_early_console_setup);
 OF_EARLYCON_DECLARE(rsci, "renesas,r9a09g047-rsci", rsci_rzg3e_early_console_setup);
 OF_EARLYCON_DECLARE(rsci, "renesas,r9a09g077-rsci", rsci_rzt2h_early_console_setup);
 
diff --git a/drivers/tty/serial/rsci.h b/drivers/tty/serial/rsci.h
index 2aa2ba3973ee..0985fd1b3348 100644
--- a/drivers/tty/serial/rsci.h
+++ b/drivers/tty/serial/rsci.h
@@ -6,6 +6,7 @@
 #include "sh-sci-common.h"
 
 extern struct sci_of_data of_rsci_rzg3e_data;
+extern struct sci_of_data of_rsci_rzg3l_data;
 extern struct sci_of_data of_rsci_rzt2h_data;
 
 #endif /* __RSCI_H__ */
diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index f363a659c46a..01ff9fced803 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -9,6 +9,7 @@
 enum SCI_PORT_TYPE {
 	RSCI_PORT_SCIF16 = BIT(7) | 0,
 	RSCI_PORT_SCIF32 = BIT(7) | 1,
+	RSCI_PORT_SCIF32_SINGLE_TCLK = BIT(7) | 2,
 };
 
 enum SCI_CLKS {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bd7486315338..6c819b6b2425 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1184,7 +1184,8 @@ static int sci_handle_errors(struct uart_port *port)
 
 static bool sci_is_rsci_type(u8 type)
 {
-	return (type == RSCI_PORT_SCIF16 || type == RSCI_PORT_SCIF32);
+	return (type == RSCI_PORT_SCIF16 || type == RSCI_PORT_SCIF32 ||
+		type == RSCI_PORT_SCIF32_SINGLE_TCLK);
 }
 
 static int sci_handle_fifo_overrun(struct uart_port *port)
@@ -3181,7 +3182,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 
 	if (sci_port->type == PORT_HSCIF) {
 		clk_names[SCI_SCK] = "hsck";
-	} else if (sci_port->type == RSCI_PORT_SCIF16) {
+	} else if (sci_port->type == RSCI_PORT_SCIF16 ||
+		   sci_port->type == RSCI_PORT_SCIF32_SINGLE_TCLK) {
 		clk_names[SCI_FCK] = "operation";
 		clk_names[SCI_BRG_INT] = "bus";
 	} else if (sci_port->type == RSCI_PORT_SCIF32) {
@@ -3196,7 +3198,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
 
-		if (!clk && sci_port->type == RSCI_PORT_SCIF16 &&
+		if (!clk && (sci_port->type == RSCI_PORT_SCIF16 ||
+			     sci_port->type == RSCI_PORT_SCIF32_SINGLE_TCLK) &&
 		    (i == SCI_FCK || i == SCI_BRG_INT))
 			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
@@ -3330,6 +3333,7 @@ static int sci_init_single(struct platform_device *dev,
 		break;
 	case PORT_SCIFA:
 	case RSCI_PORT_SCIF32:
+	case RSCI_PORT_SCIF32_SINGLE_TCLK:
 		sci_port->rx_trigger = 32;
 		break;
 	case PORT_SCIF:
@@ -3663,6 +3667,10 @@ static const struct of_device_id of_sci_match[] __maybe_unused = {
 		.data = &of_sci_scif_rzv2h,
 	},
 #ifdef CONFIG_SERIAL_RSCI
+	{
+		.compatible = "renesas,r9a08g046-rsci",
+		.data = &of_rsci_rzg3l_data,
+	},
 	{
 		.compatible = "renesas,r9a09g047-rsci",
 		.data = &of_rsci_rzg3e_data,
-- 
2.43.0

