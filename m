Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FF3D1CA5
	for <linux-serial@vger.kernel.org>; Wed,  8 Apr 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658072; cv=none; b=sG5CtTg4FmRiXSW7KXwGeWflp6P6ItDBvsu6tlBzJfJuogAuMmRAYvBFOYaaZ1oDRzBGc5vSeGKCSvqni1CjY8AcWI+3IumXGZvIljQ/2p416L1kBaHtzmKG48geshFFSejdwrbHBJt8saw1mEd1OIFknUEn8u8rGXWoxXWtW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658072; c=relaxed/simple;
	bh=62Mob0LE3sWA1dLdXfSheWhD/xPqahp1LlfQRWC9iC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OED8fsuhc/NzLiezvr02/rTzxyubiP2X6G00v3bJwAgj88Dbotob8kavCGn59ziy1n7I9RkILf729K1Tc4k1fCaC4q32MDqYJ4Yqoz35FR+84e0lvTcFs9IP0weYYuHRe7xl045f4X2cp7vG6ZR4DCbXJKQRPUh81nE062u8xTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGUeC0qT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGUeC0qT"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfce3a195so3926674f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 08 Apr 2026 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775658069; x=1776262869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dR5e0/e1aBEXjk8lZ27PYAez4UpdVKh/yDZiJgFVL94=;
        b=FGUeC0qTokb2e1w1lXNnv+ondKabpl/wwRUlkK0cqeJNm7B9wmpQFYfz9wffQ+V2tf
         0NTcBR3cg227+lJTcU0LBscwB1ZfS7M5uQnm359dQXUKLbu0HSyQjWm9/rzurw94KgT0
         FJ0khpa4CSzJcgfidKQj7eWgXVzdlZNsPRmTTfk/2Oeq7ych39agknc3iJiKcC8Se+Uw
         hpEeExusf0WVB+0oZYWo8DMjs7+HdrLkObWRMZJWDUiODS9Z7lFKBlslQniMMxLkqcCL
         byjcCDK7XwRHMPDNgsrqDUFxorsANF5IFNvwwls5EkzYfMMfYyZMAoUjTTQCXUcu38BL
         M0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658069; x=1776262869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dR5e0/e1aBEXjk8lZ27PYAez4UpdVKh/yDZiJgFVL94=;
        b=AV85vWRknhfoISkh3U3/RF3NtUP9x6cj7ZktVRejpG8nCIbIDPOdMA5F7fSeUgLlcX
         MWk+vQ6mxEnF+pHRJ3n2KQ7UURD9Dr9JN5Olo9dAJvOrP8opQ0ghRLow0HOOSAWSAaTA
         sx8Q4EEe/OP8rMwGRwaYLwTVWFDSM1smYV38IUkSvMbUdx61kqTdLw/jSjcn165cOj2a
         4KJ5cINs1aGvkRjDhZ0AWZVKafU4cjM+s728dyC0ZCnWh8vJGxrdzLvS729g9sWw84rb
         EzqkOBKTI0d99e8cDDlSxl9SRHt1phHum4l57ZecifKSy1e7YvpG6iWInWSqcfEjqxZi
         jmLw==
X-Forwarded-Encrypted: i=1; AJvYcCWgLRPtuon1RnVpj1c0MdjUrQQD8phSpFTKo+xQVhZg+4DeMCuJMUoIQZX6ETLS5E+YG/Ad/K7Ya1QKEiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXDY2zTzgWfF2+oK2GzlwwYsbU6VmvCY7ZQhs3iZqNw3l8AlN
	QyqPQRW50JIq+h7qGzwgwLua6B76IA3WHN1Fn8cbz3xBx2BXrT0IRHjE
X-Gm-Gg: AeBDiev5yBtr1pYH3coD46smINaR3XkCtrXKwNCHK/ORnHoV7ABBBZfcqc85R9/+Kap
	92sCOb2TIuGV9tYMFq0vL4e7m1W5qrc7053oW30wMIL/YcdTvNdlaVq+NnlWtsR2ke/C1q9440N
	syIouIwX9t6D62c/7BANBOKqkBPzT7m1WszWpQL6meBL0YG5b3plC0Ee+rDR86XmlS2WKaVNjwx
	QkfjdqJNBaNW2J4m0RsSdRFID/+oH/mzEqe4UduWOWnc3gCypQR2dOMzpQgGQB+ovlFSQOwxECv
	NsRBlu8W/9CZ/vL9VebEbW96h+1AD/zPiDNVqR/kPOuZRNdhivFhArwVrcW2KvnPack/WvZD0PT
	eMGUrqA6cmusHtZf+qRSuopKx+8oUhMOY0PrmfCu345eLDpoeNyRgsmnA/QShgdLw57RSTm4w66
	NqtKrcAvV6RVAZR5mCDcO5uBDEVrRBPq0NhQjmSa83mUAN1uw=
X-Received: by 2002:a05:6000:4023:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-43d292ff3d8mr28536857f8f.36.1775658069291;
        Wed, 08 Apr 2026 07:21:09 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:f65c:8080:131a:202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e1fe0b0sm60474467f8f.0.2026.04.08.07.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:21:08 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 1/2] serial: sh-sci: Avoid divide-by-zero fault
Date: Wed,  8 Apr 2026 15:20:58 +0100
Message-ID: <20260408142105.310210-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408142105.310210-1-biju.das.jz@bp.renesas.com>
References: <20260408142105.310210-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

uart_update_timeout() computes a timeout value by dividing by the baud
rate. If baud is zero — which can occur when the hardware returns an
unsupported or invalid rate — this results in a divide-by-zero fault.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch
---
 drivers/tty/serial/rsci.c   | 3 ++-
 drivers/tty/serial/sh-sci.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index b00c9e385169..a0858bab0822 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -286,7 +286,8 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
 	sci_port_enable(s);
 	uart_port_lock_irqsave(port, &flags);
 
-	uart_update_timeout(port, termios->c_cflag, baud);
+	if (baud)
+		uart_update_timeout(port, termios->c_cflag, baud);
 
 	rsci_serial_out(port, CCR0, ccr0_val);
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6c819b6b2425..429e89106ee3 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2805,7 +2805,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	sci_reset(port);
 
-	uart_update_timeout(port, termios->c_cflag, baud);
+	if (baud)
+		uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* byte size and parity */
 	bits = tty_get_frame_size(termios->c_cflag);
-- 
2.43.0

