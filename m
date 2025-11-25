Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C865328B7F
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083208; cv=none; b=WUDm7ARJySw7aRv7T1dx1l7XGeKh5CgZtgzY2cUXO7RrjBfX2eHzYaanzM4oWNhxnNLoTDRNQrWoskVMN6COF0XldK3sN0Rj6O5Px4iD3gQlUe0LFUTG0v81Cnih1cz2llAwNfn7b1S7Vwu1ZOmfdA5sXWjqAt5fj9dj1z0h+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083208; c=relaxed/simple;
	bh=Y9Og79ZAp1LzlNRB/+j1NPNbgm1v4IaiVXeLQZ1UcbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehHFBaGTji9bESrETYDCJTVsV+kj/XFOWMxdcsqMwYMGixMmQ9ZFHLQSx+HiXmX/tniuoT4KsNf15TmaC5U5a6ZMzxrhS84jGHzkFM6Me5upwDnfKe1Den2vBm461WoGXDcz/KZ2SnpkarNRWTHmgcxfOi+YCM3Z1iwFHgoss9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qnu1bQBz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qnu1bQBz"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso3501775f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083203; x=1764688003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQBggaWsGLbsTfz97O6p05mhqq7oFm4UAg4lh0dmr5w=;
        b=Qnu1bQBzuBB+12kdzy/dmdvb/C+WXI2l6K30U/NZqR90pITourjJjnQH24cC3Qad96
         nnM4NucDPlRNDpybB5SJ0JxISJA2vSoE0wVRVGtEMbfZxXqnrVfHO6r0mKrCC/1sfKQ/
         GVUITp8fMv1ukAahFzOPFJe/flz/fxyc7lrPabkStc8cJksIEYye+dWTXxAzvkgivvRR
         WfxWDge9fBuZXTTjAMbMYgWA87aNAiToe0G0WocSnLA7BvlQIVAgL1jaZVus3WlgbAV2
         eZrqkjIGlV9FR5tKAWSPu4anugcVDWxFuinAqZEBBmEXRs6ST4F7MBXZbye1IpnVGyg+
         gA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083203; x=1764688003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQBggaWsGLbsTfz97O6p05mhqq7oFm4UAg4lh0dmr5w=;
        b=ugVlRbfXYXO3dXPf8zZKaUUJ73vSPhEx+m166Fh43BjfETqm2SJGTg2tauLoUo0LPz
         CIe3nfg1yE0GQ6Busp02lCNDIrAnN8toV64HoB0nk83AX5A4sHPAjz7BdO1JtacoKWqq
         xrXU3DSUE8PEbE5L1w1SeeukvxVXEa4Q+CynkliKn4eCOMPPAvbwreZC7IMct5zery8c
         UeS0bvAsnQQlDomfDH/jAfKPn8NisGa4RuRIprcK8Tux823OpY6Di2wu7TjBrZH+j6Ij
         2AYZDxviC2pvz+dc4zbJ3kAYOaUeJV854HjCNlWiR1OCRRpJeF50gS61vX0VhCLxdfk1
         um7A==
X-Forwarded-Encrypted: i=1; AJvYcCWmIOicyEbA44EqGbaloW5rjAg2hReUkuKcZ/v9XfqFqdKMc6ldlUEec3NrbbPSbJUTk386yQu3tpyaR90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwID7XksFquqvNRa13iZ/5zvoiS5GobFRZmSdRM/VJPUBa7ydWQ
	39sGb7Eul7bd7iRnhktOd6oV83H+fi0Lnp8E6kh78oTapHOF1PMy3pkb
X-Gm-Gg: ASbGncsQU81eHSLA8v3CXCMag2zjGPKO7NRolSFQ7dzpa/ZvhEPnxIsw+WfCVLM7u4c
	fOf9HGLIjpOlnJr6RlBmDQYg6Ufzqyf6DlT1fyErB+zJC//lZJDe+Er+IgCxn5XsQVmK8gl7gxs
	9kNEN2Sv3kTCx4Jwu94VQW2LYdgyNJ9kL/VBg5nbGo7k+z6o3HZHQjx3PV9qe66pX7vUNsnstId
	08vSuZTwtXQ9u4tHXsymnydhGTOqAckcV0MuUm4ez/055bChUwlFTYn0WOiSMn39RvEbwRldfbj
	BcdZxCiS/TJcvTP2WW3QRuYbdWHBXCvPveIT/fmCgdjTA5iV93xm/a4LBeJNAVjKLEttSDpR2m9
	i+qULUhQl29HRIfndQ+shEwrCr/EHfQJf4bjYc+b7YjNJTk3PbRHuPFMScq0EzJUn911+KMAeOH
	3NYSHeqjPhN70Szru52HD9L5fU9Y9dSkj6Ah+3eaUQ6tzclfhphgzeA4JWJ8+G9eWFDGoGl15Wn
	qFL7+WYafCcTeM4
X-Google-Smtp-Source: AGHT+IHY3RAScU6Nx94JkJj3C7pct+wKtm7jPjdtRPYHB33Drum3deOmgXGvKEWzPIL7rdg62WgVbw==
X-Received: by 2002:a5d:5d02:0:b0:42b:3339:c7ff with SMTP id ffacd0b85a97d-42cc1d19a16mr17579997f8f.43.1764083203179;
        Tue, 25 Nov 2025 07:06:43 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:42 -0800 (PST)
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
Subject: [PATCH v4 10/16] serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
Date: Tue, 25 Nov 2025 15:06:12 +0000
Message-ID: <20251125150632.299890-11-biju.das.jz@bp.renesas.com>
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

Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16 to differentiate it from
RZ/G3E port that has 32-stage FIFO.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4:
 * New patch.
---
 drivers/tty/serial/rsci.c          |  2 +-
 drivers/tty/serial/sh-sci-common.h |  2 +-
 drivers/tty/serial/sh-sci.c        | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 5d43e8cdbc0d..c5d373ee494f 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -445,7 +445,7 @@ static const struct sci_port_ops rsci_port_ops = {
 };
 
 struct sci_of_data of_sci_rsci_data = {
-	.type = SCI_PORT_RSCI,
+	.type = RSCI_PORT_SCIF16,
 	.ops = &rsci_port_ops,
 	.uart_ops = &rsci_uart_ops,
 	.params = &rsci_port_params,
diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index e3c028df14f1..1b9480c7f4cb 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -7,7 +7,7 @@
 
 /* Private port IDs */
 enum SCI_PORT_TYPE {
-	SCI_PORT_RSCI = BIT(7) | 0,
+	RSCI_PORT_SCIF16 = BIT(7) | 0,
 };
 
 enum SCI_CLKS {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 914bdb41ccc6..08a1898f14ea 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1184,7 +1184,7 @@ static int sci_handle_errors(struct uart_port *port)
 
 static bool sci_is_rsci_type(u8 type)
 {
-	return (type == SCI_PORT_RSCI);
+	return (type == RSCI_PORT_SCIF16);
 }
 
 static int sci_handle_fifo_overrun(struct uart_port *port)
@@ -3178,7 +3178,7 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 
 	if (sci_port->type == PORT_HSCIF) {
 		clk_names[SCI_SCK] = "hsck";
-	} else if (sci_port->type == SCI_PORT_RSCI) {
+	} else if (sci_port->type == RSCI_PORT_SCIF16) {
 		clk_names[SCI_FCK] = "operation";
 		clk_names[SCI_BRG_INT] = "bus";
 	}
@@ -3190,7 +3190,7 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
 
-		if (!clk && sci_port->type == SCI_PORT_RSCI &&
+		if (!clk && sci_port->type == RSCI_PORT_SCIF16 &&
 		    (i == SCI_FCK || i == SCI_BRG_INT))
 			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
@@ -3328,7 +3328,7 @@ static int sci_init_single(struct platform_device *dev,
 		else
 			sci_port->rx_trigger = 8;
 		break;
-	case SCI_PORT_RSCI:
+	case RSCI_PORT_SCIF16:
 		sci_port->rx_trigger = 16;
 		break;
 	default:
@@ -3548,7 +3548,7 @@ static struct uart_driver sci_uart_driver = {
 static bool sci_is_fifo_type(u8 type)
 {
 	return (type == PORT_SCIFA || type == PORT_SCIFB ||
-		type == PORT_HSCIF || type == SCI_PORT_RSCI);
+		type == PORT_HSCIF || type == RSCI_PORT_SCIF16);
 }
 
 static void sci_remove(struct platform_device *dev)
-- 
2.43.0

