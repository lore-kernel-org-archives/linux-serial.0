Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1734314D16
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117537; cv=none; b=KyY0dC1g1VdWccNqQUBZWxnipGSxtXzCvAgH9jtIbmKu0QvgmxcdBieig8BFbOl8ph7u4koMI+M8mReef3TIjfG0HBIhRGg4prIEM8Y0iCdRpdVVFOTstxPDGMfjZx3PG9Cu++sRaTgruCFBhmhCFFs49S77TAf2WtPZCS8C+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117537; c=relaxed/simple;
	bh=kZoNkXgOK5bPCHyxt2VA23mgi202ylSEj8OjJso4u5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqiRsP83kjAgRvgyK9MAY/rbAJ3XNq4T15A76UmaLKMRgugh1YOnlmr0iNaiItVpMmk4tOPSmkcFgmaqSKJ7oM4oiUMTYJDDQok7A2yzjV7RA156nbN+d8miLUpkgehIkPWMTsIc/eVmJ2PnqLJexJAhuFxrGiCKTRWuR9XKy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iW+hYQiM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW+hYQiM"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b427cda88so1321745f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763117532; x=1763722332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f1hrtdOgHB+cZ58s64lvGyaNvO528/Gm1Zm08fZHhY=;
        b=iW+hYQiM0VI29XaBpOdWMOjjdcEz7jbe7ITD1MRjo2et6SSiE5VcApPT11nzxiQujJ
         Gi6GDWPY4NicawZw+SrbzfYJRC2ORwdLDiVSQ4vDwCYJVe/OD4W9MS6kVsvqRSas9kL3
         WcJg07tmQIguelcnNeOfHZYLrPQV3gbyypbCNfRd7GCvHtPk75Dooc3SLKTVTZETHc+s
         g6gOU2CGAvsKY3aJ8FrrhDq2HIXc7TB8ohhnCCrQcTHXGdxaUXI7IoubgrCBKOju0d7+
         S0nZPqpqI86UbAAGO29qnBVHabth7kbjXBZmTIdvtIyn2UNjaKvKP3R55QHd7+e6j6It
         QbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117532; x=1763722332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2f1hrtdOgHB+cZ58s64lvGyaNvO528/Gm1Zm08fZHhY=;
        b=E/bkCNgp+0FSyNEv7+wUheRrrxTOvShQZTyTQTjcBAThxo1aE41EQNfC9lBftT6ZWU
         Myhlv6+LSsz6LSusC7qYWEgTIT4/9HCkEwCcpC0s/urNzc4AFfSe5xxxyS7HiQ+8Rcar
         v1aebyWx0q6mgYGAkAVC+xiYwEV5k7hBmLvIvvciIMZelimP3LvCEfoEM0CvJGPRuTq/
         6PXemCyHWg+hU0L6m/v8PJQ5dYOqCiD3Vo8W+MBJ2HQbAtVjHusuS0p8EErtSpKepHWB
         f7HXSr7A6D16XMm9clQP8ng4lpLshWn/E1kMb3ouvNTYl8LXr63IXDAYtT/+coBLxhWp
         t6tw==
X-Forwarded-Encrypted: i=1; AJvYcCXK2EYgu/oCsqqB8Mk0Ud1oBpbOzONNpa6ijZQcYJTS6dFwv7K8WN3UkLR+QYVq16AaxYuGhS+qd3ZkfkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXtdb7/li1O/6ysO6GQynbTPVANUioWKkU956AyKX/v8sdYKHh
	OOFkVAgMdZEdBsPs0IeECz0yWFC9IWuHN/wViwgprFAEf4UghCBX8Q3x
X-Gm-Gg: ASbGncuiItCKvaW4wcagC+TVh6lSPPlTk28Gkv2yCnE0JZgCea0F3pNSI5/7FZyU8nT
	EnA9Bbd58XavsZTGgWtdIIVX5GDewms9164faLblg86xDjdSDBkcSB14QkF9nmlOsOYZtzbGVpC
	4lOTeUzyI6VhiQ+hQyIAJWjZhILrXJC+6ikF69zxmbeSyvk8YE4lu5e2DLZps/dEHFBasEO9TBW
	VL+v9Fs8BoU8lOjFOPGk48d5OlFo3E0+DXML7d+UTYYiWInNhaS+mGy74bvKNQSo67TrhQ7XlAj
	McoIqxVJd8HVUGGcqOu/IJ+vzl7oqXSZcoDcSfOKDODt2cN530Wyr8sbsqQrMNhlbLlNxUVA2Vo
	tQ55/a1/LvD5vIfMFwsFhr8f7HNEejGS3npeZ+dk9qpijZq8KgjxGm+aWb21Acz1uuTqF0aeC8M
	c/K/Tgyu0SZNJfL5Y7SW3bQvzr7SSzfJngPGvEhUGi+6DtNjHAiGQ0+O2iuvkRYc3diI4stlRwY
	B23pBRA13H9o1ok
X-Google-Smtp-Source: AGHT+IHc+3zQOPHYh27ICavvHRoLPV7fV5gAdj66PKngODYp6s5toJxSvaZhvEzRDtYaUaQmY4XPGQ==
X-Received: by 2002:a05:6000:288e:b0:42b:3b55:8927 with SMTP id ffacd0b85a97d-42b5933919dmr2175294f8f.21.1763117531526;
        Fri, 14 Nov 2025 02:52:11 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9031255f8f.35.2025.11.14.02.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:52:11 -0800 (PST)
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
Subject: [PATCH v3 11/13] serial: sh-sci: Add finish_console_write() callback
Date: Fri, 14 Nov 2025 10:51:20 +0000
Message-ID: <20251114105201.107406-12-biju.das.jz@bp.renesas.com>
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

Add finish_console_write() callback as RZ/G3E RSCI IP needs special
handling compared to other SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 1 +
 drivers/tty/serial/sh-sci.c        | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 41a437440dfa..4e6fee828243 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -94,6 +94,7 @@ struct sci_port_ops {
 	void (*shutdown_complete)(struct uart_port *port);
 
 	void (*prepare_console_write)(struct uart_port *port, u32 ctrl);
+	void (*finish_console_write)(struct uart_port *port, u32 ctrl);
 	void (*console_save)(struct uart_port *port);
 	void (*console_restore)(struct uart_port *port);
 	size_t (*suspend_regs_size)(void);
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c7f8a9b470fe..e269f4f9edd0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3436,7 +3436,10 @@ static void serial_console_write(struct console *co, const char *s,
 		cpu_relax();
 
 	/* restore the SCSCR */
-	sci_port->ops->write_reg(port, regs->control, ctrl);
+	if (sci_port->ops->finish_console_write)
+		sci_port->ops->finish_console_write(port, ctrl);
+	else
+		sci_port->ops->write_reg(port, regs->control, ctrl);
 
 	if (locked)
 		uart_port_unlock_irqrestore(port, flags);
-- 
2.43.0

