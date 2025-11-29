Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D830F92B
	for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434623; cv=none; b=HaplUU8mgiFgcxkCcvXmSQ9rjW68H40GoQQgZtzbLZFr0lmqu5PRNinuk2LdkwcmEMsf/KJrh/+9z6ueM3Y6HKKRoY9LEVf9oiN1p7Yf5HRbZfS95rxiB4vCMUoAo7Jb79FhTR/w+je9pg8si2Vx74+8jAGfRhjWixGNSWBo1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434623; c=relaxed/simple;
	bh=XBCrxsQYf937Ejr2N6MWvDWdvNJ4u/5LwtUrX9xN2ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lACNGA7XOnwgc9Zskf8WqQpXlEN446C51EyNehRp6jVXCPuUAL1QoGUzx6ftC+JgJb1cm8xU20cqKHtXCdUjFRK0AZb4wzJNDTUVGr4sLwVASLl+hAlGoyebIAGtmCtOCNMouqKBxXoIkjmakOhp+YcpN2tMLxHhZlBvrTaPbyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYI4GNMr; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYI4GNMr"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b38693c4dso979269f8f.3
        for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 08:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764434616; x=1765039416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDyWAV+ePALrOqExfIXtV1JBjB1ek/toSMQSyUnW1y4=;
        b=dYI4GNMr3A76XDJhbPAt4GOBUnB1ia9zWpmdfMt2kkwn2IeBi1r/nFKCw5pCq1ULTp
         I4DBVYj3zhrn1BfjDyFUahB7qGhKo1mkbsh33CGwLJH3T8Wlg1N8PDg2EOb6P+LeBT/r
         IfkcwU4Pj2NoqtMEjuh3UWr+UU8OkUMYKCSoLdFmInfKiRVxnuDIkcwK4eK+le3He6gh
         Io+4Ck0zSeE3x4e7T456FZUkKHpkdFxDcIXsy5pwrWkr268WZmOFU4jxiLP9YcaXGdnd
         2HvF2o+z3TFITrRBDU9nX7PJeBzwA5QdPWZ3nlFjZbTRvxwsbzxb7/EKfUn3/hCt8PPS
         weEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764434616; x=1765039416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wDyWAV+ePALrOqExfIXtV1JBjB1ek/toSMQSyUnW1y4=;
        b=qGG5kqXdDB/1X1aJzWQ4oGJRkoesV3Xi1PI3lbbIqUyME5lH+XySNYtSJk901AXFpn
         o8jFcCCjyyY3Y3PhRZu7F2N0CX1ydKGCLyTUvRyNgcnXoOTLjGStkGtEfKKjrigVGO2T
         HzEIl44uyV4/qOfXg+k4WNkFAUMMAKVK2jPJ9zOfUOYLXX/vyx/LtmI2VEGk5TOVKtin
         B/brWEgX5OXCbV4ahXEj6sEwkoO9WcPHUm2NN40Z4VTYMrIsVhx6b1J77XEIlet3rWrY
         zid3cbOYxik+jUX9MTGkdQ4TZxLWMCulhVHSfuWrXPSoS5CaYM9SEHB76yC+pLGn7vYy
         osAw==
X-Forwarded-Encrypted: i=1; AJvYcCWM5p+o0PnCBF3gOMo5y30CwlseS9ETK9gv3y8GwO/ui+hpbkdSTq3ZQFFYhJuL8ZEaxcnZkQiOFVMGtmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSNF+ZxH4WgtNwmbMzw2kIFFywuAEEE9PuuZR7UW8BsfZxypWF
	/JelLHlduPNSOllvMqQvG54P1AbXb7b8qPIi0v4kX8aHZyfcp2ElD/Yr
X-Gm-Gg: ASbGncsedVTaIa4KqZ7b8I4QvNd9a41Lr/B+E5VCr5rPhOf7xWCok4B0ODH/P/tw7Jc
	SNDZL7zXYVFVjhsOdvuDryXruH4mtquBrCF3jpMyKIvEXdcbz0DNs/cg67V4iysAeylm+HSZd+Z
	jbrGobimg+n4A18ozQUzgw+NerqNYfy/XXAIWRHFOL5+Gc0lSUaau4vUTQWj/yf5DiDjH9qpjeW
	fDmo4UqCZzb6x/hqLyDpMRzwDUbOQ32c5Kr/B/1yfC95nsT4lfun3ch0gvbQpbmSAmsY8a4lKKc
	j7KhjsVXf49cmALtub+ImwywlUCurYQlX8JK0h3WVAY62D7FphbOM8sGD88Kj3yWJ6RAPrVcf8w
	EqRFypo/azEZsrDoNt8xDFYiQlu0jjppri0NQKRHi4UOUtzBoCcHNetnYQkgVyTe6flQfNefY2S
	C1AX4wFxBU+956SP7I2KPpGIjr7Z8l6mq85n+pJy0H69HKHBn8cb3ZpG1OlYlJ1ZEUmwNliJHGX
	KyUGrP/KWv/RL4c
X-Google-Smtp-Source: AGHT+IGl+JVajCZzJ02y35VEOUIGeotZl+/jspEr+qj7ieMX6RPsv2bm5PEY87wgkTa5WXNtbjIdxg==
X-Received: by 2002:a5d:5d85:0:b0:42b:324a:b9c8 with SMTP id ffacd0b85a97d-42e0f1e3610mr20339350f8f.3.1764434616034;
        Sat, 29 Nov 2025 08:43:36 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm15970060f8f.29.2025.11.29.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:43:35 -0800 (PST)
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
Subject: [PATCH v5 11/17] serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
Date: Sat, 29 Nov 2025 16:43:07 +0000
Message-ID: <20251129164325.209213-12-biju.das.jz@bp.renesas.com>
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

Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16 to differentiate it from
RZ/G3E port that has 32-stage FIFO.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * No change.
v4:
 * New patch.
---
 drivers/tty/serial/rsci.c          | 2 +-
 drivers/tty/serial/sh-sci-common.h | 2 +-
 drivers/tty/serial/sh-sci.c        | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 5a58c783fe8c..7f4cb04daeeb 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -462,7 +462,7 @@ static const struct sci_port_ops rsci_port_ops = {
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
index b7fef518a2b8..624ef41701f2 100644
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
-- 
2.43.0

