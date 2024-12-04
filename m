Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C62144C2
	for <linux-serial@vger.kernel.org>; Wed,  4 Dec 2024 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327902; cv=none; b=SaRR3LhRrnFSyocbomDrJDewnUBapM0WMPDx4gbSeELQSV1WcNbEjvMs5ksT/3OHaBEP+4YV0zmAiG58mHbdIazIw2zIztgDJh8SbDMelN2AVTikNt09j3rNtFzY1frwtQ5cGVbNWJ+ZvUykc81GtmVAqU5k7S0wgNde4z7ws3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327902; c=relaxed/simple;
	bh=ZT/xdjFLeWNNlsrj3Ue+9kz2Tfvcw+jWnO0VG76SBPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BP+jIvP5UKOuxp6JR5lZ9E5NqFj6Pfk+vu6Fc+z5dC9q2I3thO+eiTpR46wktJvx5lJYUaM6/cFjAlhYCNTGkYJy48S9kvOFk6iFLOjr9ImcI8ed8mkFoN4iecVw4JBJPMJLMsPrCuxaKHiwV4D+8iR2tBmDUJjERZoklec55Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jsPFp6Cw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jsPFp6Cw"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434aa222d96so85488715e9.0
        for <linux-serial@vger.kernel.org>; Wed, 04 Dec 2024 07:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733327899; x=1733932699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iw97V1HkeTfD3TObMHDloJkcKAuf8zzJLrBo8Fp9hAs=;
        b=jsPFp6CwqnKs6uCZj8RfZB4mh0xEeb//7c9XjOdsA1BDzN9VodpgLMN2ZosSzFum0/
         Zh/lGILkVfTCf8WCcNyqAlTQRsUJjQVbkCcpVhQCfNwudGaX3SE+7ux+3iICm8I6YkyD
         60U9RE/5CsWtjqsN0xQH+vevlKffzMMRlww0M47K0rdI4CVaT/erh/imD7V7XhqjqZci
         XKXSPM995v3aVclBenxpH88qx9REPXjU3UI5o/WKYMDQBMWl2uL+l5nRQKoO8IeCYocl
         bOUGPLtPDr5KC8pF2TPZXcK8VLeOzczMMfpO5AwuIvPzr49Y5tOVuVx2smAp99f4vKIG
         lEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327899; x=1733932699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iw97V1HkeTfD3TObMHDloJkcKAuf8zzJLrBo8Fp9hAs=;
        b=ND45eo3himreu7NalZ1mYwVbhc8SCUdh2xZN5+qQp2gf/9srh0PLQkHniXDLLlvk23
         fy1XqOCF3Xy3X6NJxK4KrnO6H3sxDK1xJUCKAQBJp1X3Fp+M6TgJhCRBPtJB3ZtyUkaq
         +123us43oFVJPx7PScvfv7EeZuhlGFyHw00quSmBbB/jbcMSpAvxdciv480l07fxbF/P
         8OwWdYEZbcSIfbO42RcQiXORe6kZZHR/qRoGpqunt6ZJ+vPLRO4WrwZYnuw413VwVoda
         6pLNp+9JK3W0T27/MzxngGFJtb9xno190Me7lwoMCr1zh+rSUjn10QD6Y2l4a4TFQF6M
         89PA==
X-Forwarded-Encrypted: i=1; AJvYcCVLe9VjzJ0gGoKKNFIv2BkI2WzoB1akTdecXuPMpo47TyVLlhTtF+TGfL0bgZ0zOjbSip9cpehDxDyaMIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdMRHEJORxRAvVoCSypZF/BAXSitN/s5Sxrrh/JXHbfLJqm7N
	ZhmxgyhhZWmEHw5hcYvib4ru9HgBgagykni8HjzES8+lDI5dVXfRXQgIbrm3B3U=
X-Gm-Gg: ASbGncsRQigOaZAK8E6jc1DVxYtIqqNeHx/W0elzNU+7PiiewgLsZed/l9kzXKiFrvg
	hZwn8l7QFZipTYj51EW6KzYzOPIbgrbyUk8OoJT7QIi2ycpxtQ4dDAjPoKr+v1i2TU+T/ZnhKTy
	mVXV+ojk43GBaNKJkvoKkfNBkgfz3Kd3DbmfqFkNDFiaKTRH30OBjAwJqGfFXHBq0BACwUqSOMO
	3oq5ic07BYP04MmEMVELmANhJbghkeC38k8scqg5VLigN26Rmg3vCDJH30gjkBJrRI6xZCmWxGS
	zjVg
X-Google-Smtp-Source: AGHT+IEdO01rXNTKKymFk0tOKPPstS1yxCCBYj396aNVH1MZSrtaciEZJPkmPj7/r7/fpuguB+UslA==
X-Received: by 2002:a05:600c:4593:b0:434:9ec0:9e4e with SMTP id 5b1f17b1804b1-434d0a28531mr77312675e9.30.1733327899104;
        Wed, 04 Dec 2024 07:58:19 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b5677sm29043695e9.37.2024.12.04.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:58:18 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	wsa+renesas@sang-engineering.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	groeck@chromium.org,
	mka@chromium.org,
	ulrich.hecht+renesas@gmail.com,
	ysato@users.sourceforge.jp
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH RFT 3/6] serial: sh-sci: Move runtime PM enable to sci_probe_single()
Date: Wed,  4 Dec 2024 17:58:03 +0200
Message-Id: <20241204155806.3781200-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241204155806.3781200-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Relocate the runtime PM enable operation to sci_probe_single(). This change
prepares the codebase for upcoming fixes.

While at it, replace the existing logic with a direct call to
devm_pm_runtime_enable() and remove sci_cleanup_single(). The
devm_pm_runtime_enable() function automatically handles disabling runtime
PM during driver removal.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4f5da3254420..373195995d3b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3056,10 +3056,6 @@ static int sci_init_single(struct platform_device *dev,
 		ret = sci_init_clocks(sci_port, &dev->dev);
 		if (ret < 0)
 			return ret;
-
-		port->dev = &dev->dev;
-
-		pm_runtime_enable(&dev->dev);
 	}
 
 	port->type		= p->type;
@@ -3086,11 +3082,6 @@ static int sci_init_single(struct platform_device *dev,
 	return 0;
 }
 
-static void sci_cleanup_single(struct sci_port *port)
-{
-	pm_runtime_disable(port->port.dev);
-}
-
 #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, unsigned char ch)
@@ -3260,8 +3251,6 @@ static void sci_remove(struct platform_device *dev)
 	sci_ports_in_use &= ~BIT(port->port.line);
 	uart_remove_one_port(&sci_uart_driver, &port->port);
 
-	sci_cleanup_single(port);
-
 	if (port->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
@@ -3425,6 +3414,11 @@ static int sci_probe_single(struct platform_device *dev,
 	if (ret)
 		return ret;
 
+	sciport->port.dev = &dev->dev;
+	ret = devm_pm_runtime_enable(&dev->dev);
+	if (ret)
+		return ret;
+
 	sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
 	if (IS_ERR(sciport->gpios))
 		return PTR_ERR(sciport->gpios);
@@ -3440,7 +3434,6 @@ static int sci_probe_single(struct platform_device *dev,
 
 	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
 	if (ret) {
-		sci_cleanup_single(sciport);
 		return ret;
 	}
 
-- 
2.39.2

