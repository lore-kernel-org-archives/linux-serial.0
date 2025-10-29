Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F33128DA
	for <linux-serial@vger.kernel.org>; Wed, 29 Oct 2025 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726068; cv=none; b=ENaAjssZzcOkGI8wqR/LXzVre6UTcVLr26UELZ2jm/eyfAux6HT3ghHVNggyWTwyth1Odniy3XEBTSAvKkbXEGRIT+LNcssmYXUvNNxW42fI16cxr9WtLyt+YBw9LLBnf0glXEPlN5RqF4/i+fyLQSRXv4NiPi0ObPynSo4oaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726068; c=relaxed/simple;
	bh=YvpqraNS2DmQtSqvMgvUzfp+mnUD4shcDi4PHRgBkBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vmc+D3k2jd0UNierhaMgKs69+KekcWnlnsVrRmFrD4n/S+N5gZ4ZV9XJzjyfxkkz7wZd4aXUiIga0DGF3GDJ8aTeYSspBnSh7OdA/56Z+9+MpJP7qbXPSyKQGu7wrmYc5LLGbyHMMW9T9iBv2iWx29IX5lR5Yye0pPcR/90SyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHp/1Kca; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHp/1Kca"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so6541409f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 29 Oct 2025 01:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726065; x=1762330865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW6IRdIBhUetAuPh0pBdlfNENv4jvRassCxbHPsKnSI=;
        b=GHp/1Kca+8QVrQvvY5v+eC3dCBGNkHN8H1RbyNEhKFsYhMYpYxTstLVWH7kUp+FTF0
         XeDzseGBieUYbEZROaqeGscVcras6JAAEmX3Jqtepcuq31WkAs60QOs1+AQZ2NzmpDsA
         MTjlfRTtUvwN2GBOHrL2mS6VwY1ltydUDy/4VVFVo8/iH0GMImRfiBeFlueu1mRuICjI
         wMNqvcnZXgfYfWzUusIc+M8iNWnBrx0i8tYmbgz6RERf1te9mWw+GREstNC6TsjP9GiC
         i67cpxBMfgvEik/SxgpY4CuXVKCgsjj0ui2oXhsoAZC//7jaFBYtDE5z6skQTNB7CUab
         QGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726065; x=1762330865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW6IRdIBhUetAuPh0pBdlfNENv4jvRassCxbHPsKnSI=;
        b=isoe+SZ35srOmvuvZyqUEX7vSi5xibJKRrqu4/0C0f0i1KWTQX4X9+XsEF33oSejKN
         Blyvpf/2Ios6vxeKi9O2tJUonjY/dPD6PYyQbBU9WuYZHhBF8U+A8YwDkSwvyJOEtYHl
         RQAvkQgBXmVG2PIZiXds38rTqqpDhACwBxsiAvaTRBt5WtY5tR9Tn+9W1fVByAGLjLQd
         bWPcskjFXI9mtOQ6+KiSr3+60WwO1T8GLeqJZCfQbxliQoXY/lQrfbzBhAVTESXkTBku
         IwqFsVNq6zSBtRDag5OC1mCIeMmYsojapmOaLqJO8ID0tiSYrBO90wemkDdHkT07hePc
         l+og==
X-Forwarded-Encrypted: i=1; AJvYcCUMZl97iFUffo2DXmxY5mugpqsGvfRLA2cdfWHPmwLoILaTm5esVU0kJGEtCpogGGg9QSt3wdgtE+bWXWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6Qo5WCwZ5uptGlFUmKo4Aq+YJ33IFl7u0bqfIYN+O1wQoONw
	n2NYIBmT2KQHXYzpaLGscGJ55msjoNkWa5vfzZt4AFK1J1xNFwC1QdKn
X-Gm-Gg: ASbGnct5Z+V52q89Nbh5TKfJjaSdRG6HF+Qqxq/YMF4yg6jQFKUbLJ1TXYc2QtR9Kef
	9k9YDG0msIruEOGjTI76NMgx3Ul9kx3A8WEmYyqQQuBqlksQYRWx4XfWChoDGbyL3E4waHVA4Jm
	jx94rB25I7Bl7g5FdxWJX+mdk0jNIWgghch1Zh3WSqj90KO3zjmV5Got9616DPvzZEMe6jRfQRx
	sTgtamyOgjQFEcQL33YMvOMrz57Mt7bgcwYmjJooyNLW82Mw3ZZFAzX7/vqA9XN88Vuhgpczq85
	Q22PvyHz+xcbMH7/WW1v2pycPsBYNrDo0AbIXODVvxZp1tNBmPA84Lo/OiHkAf2ixsqPCq2eSYC
	5HFI062VV8VmHh8V8W5xDaNknf9AvUopNCJ2/D3n6MqUWAA0Pt6AYoSnaqUsqj30vuEu4A5IQ9r
	JMeQ1jad2qs8SZ89jUjGsbSVoWlPPzlky4tZhEeGI+L7G9mlXWWBVtY0+9/6f4
X-Google-Smtp-Source: AGHT+IFe0RPTgcm6P2nkvsmiEiNCMG16kADfs4KIy98NqJ2br7YI+TqzdQIPzDxNgFJX1lZZcKgPQw==
X-Received: by 2002:a05:6000:26d1:b0:429:8b47:2f35 with SMTP id ffacd0b85a97d-429aef80db3mr1787632f8f.26.1761726064580;
        Wed, 29 Oct 2025 01:21:04 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e196a22sm35191915e9.5.2025.10.29.01.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:21:04 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH v2 2/2] serial: sh-sci: Fix deadlock during RSCI FIFO overrun error
Date: Wed, 29 Oct 2025 08:20:57 +0000
Message-ID: <20251029082101.92156-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029082101.92156-1-biju.das.jz@bp.renesas.com>
References: <20251029082101.92156-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

On RSCI IP, a deadlock occurs during a FIFO overrun error, as it uses a
different register to clear the FIFO overrun error status.

Cc: stable@kernel.org
Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Split the fixes patches from original series.
---
 drivers/tty/serial/rsci.c          | 1 +
 drivers/tty/serial/sh-sci-common.h | 1 +
 drivers/tty/serial/sh-sci.c        | 8 ++++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index b3c48dc1e07d..3e1f4b3c4e59 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -414,6 +414,7 @@ static const struct sci_port_params_bits rsci_port_param_bits = {
 	.rxtx_enable = CCR0_RE | CCR0_TE,
 	.te_clear = CCR0_TE | CCR0_TEIE,
 	.poll_sent_bits = CSR_TDRE | CSR_TEND,
+	.overrun_clr = CFCLR_ORERC,
 };
 
 static const struct sci_port_params rsci_port_params = {
diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index e3c028df14f1..bcdb41ddc15d 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -51,6 +51,7 @@ struct sci_port_params_bits {
 	unsigned int rxtx_enable;
 	unsigned int te_clear;
 	unsigned int poll_sent_bits;
+	unsigned int overrun_clr;
 };
 
 struct sci_common_regs {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 62bb62b82cbe..b33894d0273b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1024,8 +1024,12 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 
 	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
-		status &= ~s->params->overrun_mask;
-		s->ops->write_reg(port, s->params->overrun_reg, status);
+		if (s->type == SCI_PORT_RSCI) {
+			s->ops->clear_SCxSR(port, s->params->param_bits->overrun_clr);
+		} else {
+			status &= ~s->params->overrun_mask;
+			s->ops->write_reg(port, s->params->overrun_reg, status);
+		}
 
 		port->icount.overrun++;
 
-- 
2.43.0

