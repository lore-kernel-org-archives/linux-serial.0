Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5700229B36
	for <linux-serial@vger.kernel.org>; Wed,  5 Feb 2025 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738747875; cv=none; b=Q1Zdp99TtFhlUDi9a26XyztH7ErFNvNpnF9F4j6Xs1RSYd0PIqb3Lc3SjgRse84xp8DhV8S6+ZjPf2dIVFWn3A/m07KrN5d/LkXaMc/vOZQ8Fpbp640s0xtO5/7qGo+HqDtwVE05znvDcCNoqylqAXUwahuV+E5LI+vDXOYRwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738747875; c=relaxed/simple;
	bh=jHDBXjhSUq4kXJGyHh7NJ4ZakuUpx9kWVj+0VeYsqfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5U6/RBB8x4gT+1EJmX6jcx0ncimcmeTkoIZGfiKzvi4zwuZ2dmRNXRqGKPS5zkrKkkjw3A015DG3dsHML21GGHOJHnCwrvChNAHvMovIcefVihyzFYMIr0ndLoXy9azCBnD2t21anSgd3njOvZ5lNVmmC5emlkTzZYiY7AbvVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Waus9W0N; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Waus9W0N"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab698eae2d9so35021966b.0
        for <linux-serial@vger.kernel.org>; Wed, 05 Feb 2025 01:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1738747872; x=1739352672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MHCjb4U4W5peYjGqhen8R1FyjB8spPyGmDAL2pxi76Q=;
        b=Waus9W0N0eHDhaNK5e2LELJXTsY8hcVAZJWvwQOewbKTAQhir8Vz9o6Jgb08oJADAn
         KMnwAMTsHc7SKWtN57SOJG03UCt19Okr92ew5lHwSkxPLZogMN3eMOajnLTSShhMf3/A
         AMyrBldd4zzT6Q3ugAMEHqFYdwVjVe2i7DEnm1kV0gxbYmgBepBtkvyIvljtIyRsllVL
         VyTp0U/6zF96t/rRVp45RR+N3SYBM6x6lPl/0TvH6Ly4oT8KN8N7k5LjXu17Z7UDZFHZ
         HZJcn/4UydawZG1iF4o1bZSE58JQrLWgoihylttzp1Hfb31L5+uIp6YjjDnR47Kp+QLz
         n88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738747872; x=1739352672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHCjb4U4W5peYjGqhen8R1FyjB8spPyGmDAL2pxi76Q=;
        b=mD2Z1lmA9EViL9Ueodea16Eez1p5pOw84yeJIYu6J3KLomHwQ1yh/lbwFg568Z7Pxo
         k2N9Fh8aOHu72FtuDOQ0e65e3oAKoZyOGGPBmKgwXAB1UQkL8A+imAyltjTFUvGNpgd3
         bHkb/x647K9gd5Nonv1gtBmrJeae3+rjkCGzCv0mJ6gxBcq++AnXpIoIp8H4ZJYfyduX
         LeWgQ95QyQKE+mtvaVQLAsFMytLh0UvoxoobvYNhgfPIqzswKws6NRtHnhAFlXI9X77e
         4ebXWmBYv9qUcPi0hRoyXmMj2uWgRbroLnUVRb44fzC3xKoFtX2oOhOyuq2zAaATeYjy
         TliA==
X-Forwarded-Encrypted: i=1; AJvYcCULW7lDfIn7NTMqdjhVqYahjOFdL2Aqt0nuz+zCyWznHRQ/bxnUZdvuM4/jMwKD8SUmBn1rxUeJZKmg4Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6s6ioV2m2oKm5i7NkI2EAmZXBdraXEoU+k2j/Ttx3BP48jP6O
	M24btarbThLb6uIloKGRrvuydHCNxDIhHq6HgIrvuhskR1Jp+X6BygoDRNHGNrI=
X-Gm-Gg: ASbGncsNM39iUmJWuH9kF8T9FBeQEdaLIhkEPMdMw8a5yVhJzn771UZZMPlE5J5D0rB
	l+Xcs4z0my+mzrQ9F3q0VbokU4GMiEz0OUdujg7pk2HnYxHPZ2b0TFGk9o8vkCzjlq+Qoq9jOu2
	VkmH5yEPqlZZXlUv2+cXBlQ1uE1URMZUR5X5xlcyut85vSwNbFCF589vM1+nm6NZ22TryNakdYM
	0p8NzQNy5Ddsezgi1Muhie0po4uVL8q1Z6r6RInd/ynFCXiVl5DaRzG01XiKmn3/qPR1/oLDX7S
	k9CjacpeOgU6neSDebejCZ/AE22S4oe5Dcerqp7UPNelFw==
X-Google-Smtp-Source: AGHT+IHoZk2JpL5pPjKQA/glfhGs8GDupmQhGbkNANdUDiV5QxwDF1wHrCEdf0uYNcQG28ZL6K41qA==
X-Received: by 2002:a17:907:3da8:b0:aaf:74dc:5dbc with SMTP id a640c23a62f3a-ab75e262823mr203421466b.29.1738747871692;
        Wed, 05 Feb 2025 01:31:11 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47d06casm1080968766b.58.2025.02.05.01.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 01:31:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	wsa+renesas@sang-engineering.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5] serial: sh-sci: Update the suspend/resume support
Date: Wed,  5 Feb 2025 11:31:08 +0200
Message-ID: <20250205093108.2027894-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S supports a power saving mode where power to most of the
SoC components is turned off. When returning from this power saving mode,
SoC components need to be re-configured.

The SCIFs on the Renesas RZ/G3S need to be re-configured as well when
returning from this power saving mode. The sh-sci code already configures
the SCIF clocks, power domain and registers by calling uart_resume_port()
in sci_resume(). On suspend path the SCIF UART ports are suspended
accordingly (by calling uart_suspend_port() in sci_suspend()). The only
missing setting is the reset signal. For this assert/de-assert the reset
signal on driver suspend/resume.

In case the no_console_suspend is specified by the user, the registers need
to be saved on suspend path and restore on resume path. To do this the
sci_console_save_restore() function was added. There is no need to
cache/restore the status or FIFO registers. Only the control registers.
The registers that will be saved/restored on suspend/resume are
specified by the struct sci_suspend_regs data structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

The v4 of this patch was part of a series with 4 patches. As the rest of
the patches were applied I dropped the cover letter. The v4 cover letter
is located here:
https://lore.kernel.org/all/20250120130936.1080069-1-claudiu.beznea.uj@bp.renesas.com

Changes in v5:
- fixed typo in patch description
- adjusted the patch description to reflect the new patch content
- added struct sci_suspend_regs and dropped the suspend_cacheable
  flag introduced previously in struct plat_sci_reg; along with it
  the updates in sci_port_params[] were also dropped;
  also, the function (now sci_console_save_restore()) that saves
  and restores the registers content was adjusted accordingly
- s/sci_console_setup/sci_console_save_restore/g

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- rebased on top of the update version of patch 2/8 from
  this series

 drivers/tty/serial/sh-sci.c | 55 +++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b1ea48f38248..03349bc31080 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -104,6 +104,15 @@ struct plat_sci_reg {
 	u8 offset, size;
 };
 
+struct sci_suspend_regs {
+	u16 scsmr;
+	u16 scscr;
+	u16 scfcr;
+	u16 scsptr;
+	u8 scbrr;
+	u8 semr;
+};
+
 struct sci_port_params {
 	const struct plat_sci_reg regs[SCIx_NR_REGS];
 	unsigned int fifosize;
@@ -134,6 +143,8 @@ struct sci_port {
 	struct dma_chan			*chan_tx;
 	struct dma_chan			*chan_rx;
 
+	struct reset_control		*rstc;
+
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	struct dma_chan			*chan_tx_saved;
 	struct dma_chan			*chan_rx_saved;
@@ -153,6 +164,7 @@ struct sci_port {
 	int				rx_trigger;
 	struct timer_list		rx_fifo_timer;
 	int				rx_fifo_timeout;
+	struct sci_suspend_regs		suspend_regs;
 	u16				hscif_tot;
 
 	bool has_rtscts;
@@ -3374,6 +3386,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	}
 
 	sp = &sci_ports[id];
+	sp->rstc = rstc;
 	*dev_id = id;
 
 	p->type = SCI_OF_TYPE(data);
@@ -3546,13 +3559,41 @@ static int sci_probe(struct platform_device *dev)
 	return 0;
 }
 
+static void sci_console_save_restore(struct sci_port *s, bool save)
+{
+	struct sci_suspend_regs *regs = &s->suspend_regs;
+	struct uart_port *port = &s->port;
+
+	if (save) {
+		regs->scsmr = sci_serial_in(port, SCSMR);
+		regs->scscr = sci_serial_in(port, SCSCR);
+		regs->scfcr = sci_serial_in(port, SCFCR);
+		regs->scsptr = sci_serial_in(port, SCSPTR);
+		regs->scbrr = sci_serial_in(port, SCBRR);
+		regs->semr = sci_serial_in(port, SEMR);
+	} else {
+		sci_serial_out(port, SCSMR, regs->scsmr);
+		sci_serial_out(port, SCSCR, regs->scscr);
+		sci_serial_out(port, SCFCR, regs->scfcr);
+		sci_serial_out(port, SCSPTR, regs->scsptr);
+		sci_serial_out(port, SCBRR, regs->scbrr);
+		sci_serial_out(port, SEMR, regs->semr);
+	}
+}
+
 static __maybe_unused int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
 		uart_suspend_port(&sci_uart_driver, &sport->port);
 
+		if (!console_suspend_enabled && uart_console(&sport->port))
+			sci_console_save_restore(sport, true);
+		else
+			return reset_control_assert(sport->rstc);
+	}
+
 	return 0;
 }
 
@@ -3560,8 +3601,18 @@ static __maybe_unused int sci_resume(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
+		if (!console_suspend_enabled && uart_console(&sport->port)) {
+			sci_console_save_restore(sport, false);
+		} else {
+			int ret = reset_control_deassert(sport->rstc);
+
+			if (ret)
+				return ret;
+		}
+
 		uart_resume_port(&sci_uart_driver, &sport->port);
+	}
 
 	return 0;
 }
-- 
2.43.0

