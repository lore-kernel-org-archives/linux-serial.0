Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2DB329395
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083209; cv=none; b=eS3tBV1Ob4oUZ5JnuzoHPXq3YnP9y2pM+om6jW9RB/D+posiEv2KHr8JoHnb9ds17uzUeQeRyc4kkQXQZBHqTktEADDj15iZ40vrnxyfhBrFroOdA3T1wzoXOhDxUOmIxGUOu9T3pFLAYdbEd+eiMBdK7TB6Cnlc5sz+Fy6oBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083209; c=relaxed/simple;
	bh=0TeSuVvpnuWAy2Uv6XjitAEOhD/6z8E1pwq8wlnNkPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCVE5dWeUBqfZZn+LiR4+X+EWz2gpW1h8QHXulizBFuhtgNk7FrXTLLH68SaDStGwcxsdXWtki0VLkLhBfwbeIN2pCVrvjY48qbCHEMnFVr0LOFn+AhfYK7AbSfQxceRmnZrvGzy6C396wKo9ACDcdG8WvZGdeqt3pdsIkYyRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwgIWc7y; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwgIWc7y"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso4511008f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083204; x=1764688004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7v4yXEluYy9oZWvAWU7opMAWpoz90w29+FrMm8nGM4=;
        b=jwgIWc7yKkDIgS8e6j9iac/mK6Wvd+gAn2IZu+SLo3EBfjKixfP0x3oXnzd1pcjbIw
         v6K0o9pFpstlOIbVgId5h1Qk6YV1PzeOQzyGRKf+CpSbVuESdBZQpsaesiUlzBXinrkg
         65Y/c1zJQRwRXceIjDNAseIamSNo79/RmdjVWgGWI306MEO7LtCii9RJucgs4nmeUC7W
         jW0mMvYh+nnDy9Pm563hBV/PYzCIUSr0OyIcU/E/E/ADQyemU/mNgRXVf80WFiynQYed
         d/SxgII5vgeR1Xts0ofpsBKl50hUriT4Yuw/XSvAz1gjJiwzvo8X0xj6Zwh7/GBMi3SB
         weqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083204; x=1764688004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7v4yXEluYy9oZWvAWU7opMAWpoz90w29+FrMm8nGM4=;
        b=lXkcjG2qNMu1dJEbRpKF1HOZhaemxs6ammOKsm0SYpQgiCoJGctHO0FPrQ5OMbExPj
         M0QrRkW7YnwZAjAgnsmdkcepp+n+GSVR9kiBGozeLna67RvuL+xrt+MwJafPNXQDZLlX
         9Vnh7ip6PJQ9dES0UazO7mMaDV//xPoxWJ6r+dPsvxI8qfNcWROttp/cxiBXdF2lP2hx
         XNVBYYo4zbLuRkt37xwE6A33YW3vvHwnhc3zF6FwgwORSSrvTrSjeI0UndEWSr3cVYp+
         jl+hyF1PVPiCxAbOCFBIbuvejEhKpmMbPZQL+AJNdHBAnhJKZnNZ+zjbT9gprgUiTzfq
         YBCw==
X-Forwarded-Encrypted: i=1; AJvYcCWgCTOadp+qdQf9xSrIqBQpQ6Kb4urfZ7HM5DbVR2vttAA4A49+PjzIwzUfvDo6aaKk3fGoNKcKs6DZ7Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSlrmGc2XONuwQHWOlI5RWLBMPj2jid79Ji7Z3wAKUcfy78Xa1
	gMm2wsb6vBJ/UERj8m08nN7bobdgG5hF/YmP4p0rNeDNmbf9slFP9Z1j
X-Gm-Gg: ASbGncsPmtXs68oH6rE1qIB31fEC7NMXbF/hdrhWaFeP4px+ZtZSSdZUMfG8Z/gBWdB
	+3Mm1vLJ6kWImP1NNz5a3WeJg7zil28KTdPnzr1kk1a43HW6A83H6tK6k4nh7sR+A2oi3tNg7ob
	Fb8/Xo4+nX7rHh0ixW5k/6JdLhtbziCOiceqH/Vl3djA4L2lXigs85SFm0SbU4qnRjIMCyZFTPM
	FSV7BhVvWl7DQg7iYceCqvEOOpa68mAniA/+l5vZzZ5fOv0gIbvip9wtLtL2fG4EWZH4TAmd5Pc
	g2CrLVq4GY4ncVMWdBcUMru+7wOgOiQTCqGYWYiMuqWIfh8AbZYGtK7J/lZIyBgazY/tjv4W2Ir
	vCUAm6wIhewCPyvF1zbV169uWpbICxw9lvbo+hc/TcblA0QqLipq8q/X7BfvNjqfbIYcW0DOdNy
	QdREhie/lr3MTwCNSzB9F7UgnIEUq+rJBUywm/52zYZddSw43kj4Och6hSndqmck7e0vI3pYNPj
	A==
X-Google-Smtp-Source: AGHT+IFC1qSNc9qa+jp336x1ouZpDLCyNSK0HctgOn2iTioSrmTbrqrX3Nj2Kee+iUdHzj/DnysfLw==
X-Received: by 2002:a5d:5d08:0:b0:42b:41d3:daf9 with SMTP id ffacd0b85a97d-42e0f1d5993mr3439715f8f.2.1764083204282;
        Tue, 25 Nov 2025 07:06:44 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:44 -0800 (PST)
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
Subject: [PATCH v4 12/16] serial: sh-sci: Add support for RZ/G3E RSCI clks
Date: Tue, 25 Nov 2025 15:06:14 +0000
Message-ID: <20251125150632.299890-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
References: <20251125150632.299890-1-biju.das.jz@bp.renesas.com>
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
index 9afc3b8aae91..d7c25635bb2a 100644
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

