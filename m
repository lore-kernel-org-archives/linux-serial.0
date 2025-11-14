Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E0314A76
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117535; cv=none; b=st4E/Gplgt59/L5NCYf8uL2Qw1RCC4uBpJRzfsvEUePEddDLMy22qknXlAGB/b4TE0I3aRZPndKkf7jcjwg2wsiERTDGzjff177xbl9IVQ1lKpTZH8p3khOTzHqtIdPVMAnpnXSVKa2iTwslMCY1IUTESE4iIVr9s7iFNZ/M6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117535; c=relaxed/simple;
	bh=o2GT+tAT3KaMQHIum9qg97jjk1lJRZTQ0SAE08Yq7rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oeinnltzbvt7vcrqwbmkORV6P0I+3F42GSCdvpXUUlDzRkIDR9GAo3NMKiSLJYt1/HYXK2ik5JklteO4eOMdBGVTKLof1eS+e1jVlRZwATXK852sckht1ub9w+QxzrYFtHx/6MvFQsIVqA5DlD+1ejZDxoLuS8uKTWhVqx5QIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCu24F9I; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCu24F9I"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3108f41fso1013036f8f.3
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763117530; x=1763722330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8X/Pwrf9F+TtHyTukhSNpyyWy/Sr3pdNdxYJ7CPLkpc=;
        b=JCu24F9IaG+ySSAmvwNI3+T5NC69RFhN/zuWjIML9rOWtn5xXJ6ga0iI2pjdHWfgE3
         lSRuJnfPufv9PbCw3PpHRf6BFOGENhRwes4BuKamlEoVoncp5bqefiJPVFRaz7jTxuPh
         dBMggCH118Pd9lIVe5mW78w0W1cabwgBFjlEEzktFdBCl1MCAmFaSqYwuMYoT969imaX
         UKYcknTn9PgqQ2/63ctMZKnGhF81GsAZVOqxkTmUcSFlPxAmnAySdgWlCG/410CeCuZz
         TMbPR+HmCrTtZjbRGSbPzfWEtSTwDAE8BYpGhpgPR5VIh0D3VZaMaT497yD0XIVt9hG7
         4pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117530; x=1763722330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8X/Pwrf9F+TtHyTukhSNpyyWy/Sr3pdNdxYJ7CPLkpc=;
        b=a4cWQFrqRCwL39UW4/m9RcIaR9ONVClQ4eWh+7E/49+wmQ710q+zjtnX20XAcdhN5I
         tk8VJG1Sl6Ak0qRRZJJGwbwiIwLDTVM9JBMSpGov75tiP1AyqdXHAgfcBhf7OtQzJ0Uq
         yS80xT3bLJTACsqGCKu4XNzBq/prxpM//n0RnjNLibk/Lkl8GOPjOdR2JP9ZTMfGjt/7
         nZpfnfpRVHYRsMwu3/nWbAi757oWAzyw2Wl2/oVfdhQSaYuhXnIuXoCspBJ9swExHfbC
         9Ff/3ISaKK/QDK8N31NKaffvHYNLLBfF3GrGf/PbCLqsT2CxfeTWlSIsDrdA/c02O94g
         Im4w==
X-Forwarded-Encrypted: i=1; AJvYcCWrgVnoKyiVinAVxJensW1s1TR0N/dec7PfLuS31FdL+JcNSYd7UHDgHnIKREQ8C4qjtdGjh4neC2y2ykM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/744NAGtf08Wr9/EqY3AKV7OG+eriENc3mkzXpIZIz7bVF9tk
	iyhZWZ1dEoBl2ClejypqtasFYWrZY/7ld7Dp4Y8QIvaBgnFAUGXxRc+8
X-Gm-Gg: ASbGncuqewNNVsFtG4XXjyGFMGlhY31v7bRaXltS8Ju50wHAjghhEDiR34O5n1QJ3mP
	jtDKUN5TGR8rl1Qm5/wz3DzJdgi9tCENyojdjibvaOYweTBB8/1tX7P4BrdzfIUjvK+D4+wpxjv
	Xj85+u5ZIs8KaD1CP1jTI3REmwXInGPRWpUfTTAa/Q8ZKLgj1o7j3sPC9Tn9LBjigkabuI49Bvw
	GqVMS9VEi7RsZi4oxID/qnEaCgFtAYAqQsEe/a8oM9+nCfoMiTPR7m1C+ZwCQEYME1QFfpHbXAR
	9reeoh3mwkL6IeNwbuG2yV8jC7pNjhGqBQU7RdDhVm3tYYNdeR1rD93yQ0IJPN103/m/zxLjwgZ
	BM1tSsKi/BeIIPjGivw7D8Dxv3QLX+kg92qDo26rqEvZJotIolQ9kxxrUjfvsQ3FgRntkCJCWhW
	SHxidhM2+KeKUoe08e2TvqmUcfqrlCw74DTolggM5o3r7nV9Fo3JYbXP2NqyKrjawNWnHyO4wEj
	5Gy9zLz4qkokzyg
X-Google-Smtp-Source: AGHT+IGHCuqgfNwauAekSJk609AbqQ1B+ZH/YoLkb3M4enU+0WN1Ju/YsW4fhWWiQ3c21vO8G1F2kg==
X-Received: by 2002:a05:6000:2008:b0:429:c450:8fad with SMTP id ffacd0b85a97d-42b59396f60mr2591122f8f.53.1763117530214;
        Fri, 14 Nov 2025 02:52:10 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9031255f8f.35.2025.11.14.02.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:52:10 -0800 (PST)
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
Subject: [PATCH v3 09/13] serial: sh-sci: Add support for RZ/G3E RSCI clks
Date: Fri, 14 Nov 2025 10:51:18 +0000
Message-ID: <20251114105201.107406-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
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
v2->v3:
 * No change.
v1->v2:
 * Updated commit description.
---
 drivers/tty/serial/sh-sci-common.h |  3 +++
 drivers/tty/serial/sh-sci.c        | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 77f9a67d8efc..6c849757119b 100644
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
index 2da36e8ce555..3b03d3d3f2c7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3172,6 +3172,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		[SCI_SCK] = "sck",
 		[SCI_BRG_INT] = "brg_int",
 		[SCI_SCIF_CLK] = "scif_clk",
+		[SCI_FCK_DIV64] = "tclk_div64",
+		[SCI_FCK_DIV16] = "tclk_div16",
+		[SCI_FCK_DIV4] = "tclk_div4",
 	};
 	struct clk *clk;
 	unsigned int i;
@@ -3181,6 +3184,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	} else if (sci_port->type == SCI_PORT_RSCI) {
 		clk_names[SCI_FCK] = "operation";
 		clk_names[SCI_BRG_INT] = "bus";
+	} else if (sci_port->type == RSCI_PORT_SCI || sci_port->type == RSCI_PORT_SCIF) {
+		clk_names[SCI_FCK] = "tclk";
+		clk_names[SCI_BRG_INT] = "bus";
 	}
 
 	for (i = 0; i < SCI_NUM_CLKS; i++) {
@@ -3194,6 +3200,12 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
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

