Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD13148BD
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117534; cv=none; b=oYHPrHFDISdw5+fn+sHBXuKqxoVO7o2l22r6x7d/I8Yhx/XYZ5YTiqLWJ6z1JFtxA/JMvuOa/G211xHeSuP4EdXGse8lL53SGEfg6mXb85wcSf1rpkSQwIvBmWpL5wlI/EnfK/i9zSc9SsJDqowx/TOWnKCyFvQvxwul4Yb88pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117534; c=relaxed/simple;
	bh=JDFyzj52p8gGmebREXJka9Y1zAT1VPXuoiczO+R68IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTb/2XbKeh7gYyIdATbZs6KzJVl5UvqeqmVZ54+wR7uK7bpZ9MCX+f3gDUBvOUIClmZwhWXkbNV/nTV9M59qyKMFmgpKtbeTyqqx2/xjjtbktd+1stw6FTi7NVihC5ZHH4+EeCtjQIT0NVNuGjQYkfEk76Jws0H9orAiTIh3hk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flcbMXG0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flcbMXG0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477770019e4so21633075e9.3
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763117529; x=1763722329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HE59SkHgerKKlNxfiNiqvQ/Oh6UzVvTwbF5Npt8Lw8=;
        b=flcbMXG0dgUfRQh4uTqiedUC9qqMyV2SNXtT3nn9FGstsmK0cG+76Rk5CGL5AaJwo9
         DESifjG7eMimbrxOoj/u6mqSt6XBKQR6EfLbhUhyGCvW9bfTG50Cim+GmPio7UcMYyHG
         gaZ4N+GHJbxznnG80/mwH0xf2ib+2u/7Nwbh/vGRvkDi/960gIDtpaUPL8BxTpfkV6/S
         Lgm/MxZHa7Yv1X3oqBP6vIVrtg6UN5s3sLAN92fnvFvoeikIAV+EKu3XpnPTBE2A0ZS3
         tEpm+cUxv0wDB255gkfFhPWGdwTAXdmDg912Qe+k7xF1RO9xgIFieFUpVNHF06q7u3mD
         VIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117529; x=1763722329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HE59SkHgerKKlNxfiNiqvQ/Oh6UzVvTwbF5Npt8Lw8=;
        b=nl2bL9XcBCl/Yc+2pmNKPJ/3QvezFMTlBXoF5j02v9HK98pECSYAlDcomCPQF1WlDu
         ttyRBGvfQOoBl6nB1iEEybpEc+Ok2xrbOxT/5M/MwhnAia8w4bmHQa9mHzANMEngTDFz
         gI9/MWPlHu5kq6KFFBTccMldHKqIuj77zA7Po3E8Vywnj3zBvMtI0SQE+cAiaAp3IE05
         J5vw8azi9Vu9l3feycR0s2Zh+27rU/YzTalIdY5u25Uhtkw9bsoOp0rC4WDtgozpJIJn
         +VSo3Hr8g2/U37UxWiXeaulRDhNtKHl6e6p0VEHPMrndf4xoJaBgScHv7VE7dixzgBVy
         aYQg==
X-Forwarded-Encrypted: i=1; AJvYcCXmo03oZm74tJ4FqXPJwpZzvDxcBCSjPIHOLpKM1xyHYyBIS5Izq255POJWuQVGvACgTJmeBS6E9THXGcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbCYZnLgsN4ibvHeRCmE9gDPMKlLBGK5pWVxOW5NjHI1bi5QFy
	WaNK+TpOrhn73FXaYqIUJFtlChIcgoxOInb8azY34ABgDXtTSy2FlQel
X-Gm-Gg: ASbGnctGu+L3FPZJNtLWIdKd0fa2GzlnVCNZdmVyuXPNKCUUMCNYK+7dOuNIj8HLx3R
	RXcXyhoYZ/me3Z0r7Yux3Kbswo3hKiWIZ87ozXkIXyTCnhey1HgFOpa84knQibLWjN8bBOTGnmp
	3BiotsaGRgqKkSA4CSHTJgBdkiftN+Agy1VI8tVZ+EDh2rWn0227wJfydamMR+iBuERV0qTY/nF
	ocR/sZ60u+dYqClpvLJKjsT7VPExlqYkKO9yALi1BS1GgJQS3N7Q1cCcXZAda6nYk2OtSJgCRnW
	TQYE29oI9reYtVzZ4w73TT7i73IwuZkgWjEt919ytUshG+HVkTuSKKB5OFEm0Knvpkqq8qB1qhq
	1jh+S/qUyAlNC1aG60IrnobQXxP9S8bRnftw6I/hW3EVQAtpuUVeVWgkDRrpsN77fouZnmOKwNR
	G0PDGmTtbwotO7YKAlC6IBJnrFpXlOQnpNfbZnMDHRMZPtuVjA8ju60WvDmrPsKFv/d/MYeCsQi
	g2mr7mse4ra2ddc
X-Google-Smtp-Source: AGHT+IENkbhcihRPvhZGWpf9PbgT3osv7NVPvnk/P4cCA7/vVF2AJ/GMHACD1iqN53motj1hl8eSvg==
X-Received: by 2002:a05:600c:a47:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-4778fe78b15mr24098395e9.23.1763117528706;
        Fri, 14 Nov 2025 02:52:08 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9031255f8f.35.2025.11.14.02.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:52:08 -0800 (PST)
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
Subject: [PATCH v3 07/13] serial: sh-sci: Add RSCI_PORT_{SCI,SCIF} port IDs
Date: Fri, 14 Nov 2025 10:51:16 +0000
Message-ID: <20251114105201.107406-8-biju.das.jz@bp.renesas.com>
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

RZ/G3E RSCI tx/rx supports both FIFO and non-FIFO mode. It has 32-stage
FIFO. Add RSCI_PORT_SCI port ID for non-FIFO mode and RSCI_PORT_SCIF port
ID for FIFO mode. Update the rx_trigger for both these modes.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 2 ++
 drivers/tty/serial/sh-sci.c        | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index e3c028df14f1..77f9a67d8efc 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -8,6 +8,8 @@
 /* Private port IDs */
 enum SCI_PORT_TYPE {
 	SCI_PORT_RSCI = BIT(7) | 0,
+	RSCI_PORT_SCI = BIT(7) | 1,
+	RSCI_PORT_SCIF = BIT(7) | 2,
 };
 
 enum SCI_CLKS {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 78fb3b6a318b..66ab85571230 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3326,6 +3326,9 @@ static int sci_init_single(struct platform_device *dev,
 	case SCI_PORT_RSCI:
 		sci_port->rx_trigger = 15;
 		break;
+	case RSCI_PORT_SCIF:
+		sci_port->rx_trigger = 32;
+		break;
 	default:
 		sci_port->rx_trigger = 1;
 		break;
-- 
2.43.0

