Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC337572D
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847101; cv=none; b=sOvKztE+ecs8onnthd23PiYeK6VDLftnbQgzYSbSo70UsVaxT7r3JJjjxwEPCePSqzbtBRQvTxpnFJYJRJkXgM9qwr+WxuKIh6C112kHf6UHXMuQTiSc17Fv8jOrRreFRd6rM8v+Rp6Q6SRZfcTdCNi6AjS5Mpyyxc5YTe20BKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847101; c=relaxed/simple;
	bh=h/WB+hR/anHyT+SzoBQFwmDv8A8kpm7m3RVwaDTL2qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LL5taQMjiAWDluCvhXR0l7X/7pVg98wSpmRYVKfiT3UdAyXE9z+GPUVqfnItvIDteREDBuwqeWy297LhnmJb641eU48+QDp41YYjSVGxUu+uKttuYp50s23ix/tNpfcltWTw2n406Ipx5ada8hu/D3TnAfiDvPPa+AzzAMxrq28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue6HlFbQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue6HlFbQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso11285375e9.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847097; x=1762451897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpqM7R8t1LjT1e31UVuLTSZ7tEVjNoHsGLOYlh8Q1Lk=;
        b=Ue6HlFbQ8SrByoyiJdjZKBFdoL7coCuUelTMxyniu0aIjWwOG4v0R/dmqD7/usgFn4
         gKbjDEzzV1gaZdt13CGa4B10ug49ctS9rqbqE6eKGm8XfON4puoWxRX/RkmV0bqFTFU4
         lgrQNLqDUy8xsrlSFwia5d3kbiiH3AaSgRD97ov/ingswzvXA9Ey8F/7vV57X+FSUZqb
         e1dDanbEsFBfOor0bV3g2B8eCjHr+xuATVIV0E7vfS7r2Tgho0IvFBNwbMaObtrWJjLX
         eSBueea+2IUSjhMVbmsk8bi7yXki8tHkkXhwN07U5JHu+AJbwWKdLgFMNDtaKuXROpps
         S2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847097; x=1762451897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpqM7R8t1LjT1e31UVuLTSZ7tEVjNoHsGLOYlh8Q1Lk=;
        b=tcHaxjzmHNl7Fy/biPynONe5brLycSmVY3NrvkOqaMeWDuL8MBWPRvPFZ6+ekUh70O
         x7wmyj6tJ2slEJ4hzcjPNV1J2MMcWX2Mr/V8kKIS06iyjK5f68J/EHLRc9zAx25eAoD/
         /mYl44bNgSofKH8ld1dE3yybMmAogJBbHuowzZOwxJTRpFg929o6eMAaEgvreIJF1pDn
         gA4jCOe57fAIOoxJ400GsDNWPDtdGbH8NYuqtt12dpNPnPw3GJuAypCCcqfMf+x/Y4wy
         B6I5oK8ni9NK+08sQs6mV85ujOjW5PBq1xYDaTPMqap5LJIRPKxBzQvt8xUYkncf4Q7I
         +Bfw==
X-Forwarded-Encrypted: i=1; AJvYcCUmIVyFu4tC02aekZaLiG3I7LOjIYUSMvWgMBY0AmkwIM4gYFkTunHq3Mo0uVRCl/92dRisqJ3tH9UUIh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrptz9vcUQAXZc36GiCKqbpbkxrgNrVRvx02Ms/gmxVDk1AVAO
	GfSFYRvwwDsI685qvZTDxJ3UndVkDFkx2fahcn6woEVZMu4EpJtqgV8F
X-Gm-Gg: ASbGncvuCsekaR7sAJ20ie1tNelShiT3b5I58FLf3hqrecLPyn46awC273WxYMv2zbX
	KqhjvneWBbn0mHmmYydIn7bY7u/Y+38jp3q3qAcWwkbFEQUEIjjOBze6rFW/a2lgfZrMPjbFKEK
	WPtzYyrDz88neJopIoW+cxGhSH0q/3xpxYj4X+xy+A+4q69y/Rrix/lYgLa4ZND77HRw04LrjL6
	hNKcqTRlb8VEdDb4SfxC48dHMKjJmNQ7ywAtOWbP+qq2SyZU0ClgXe8MGuP3SVj6Ns5asUszw1C
	eOHbODuKZkeGzb5Uv5saTcx1GH7CMhv3elRr2yeuOpPyvBuqVdWj+olVWQUFh0qeJ+TjrmLX5ui
	rSY3rKnNKxQLZBtINJFQG6XYb8V5+dzz5ghajCU3pQ7sptrYk/6iaD2mXQuhjXbxiQ9arq9a5FI
	slTp8wSL3VT5yQP3Jnf9VMYDZ0A5mFnpLgTM4U41aB7DNX+CAbic/IKGdcJ5OaN3+6YRyYgZM=
X-Google-Smtp-Source: AGHT+IGYhfx2hhEnVp811r6o3+mVesMzRX0VxLwwsFF+Aubi9Ud9nfeO5K494LycQhg4yojLHmy/Ng==
X-Received: by 2002:a05:600c:3590:b0:471:115e:624b with SMTP id 5b1f17b1804b1-477308595f6mr6032205e9.17.1761847097374;
        Thu, 30 Oct 2025 10:58:17 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:16 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 06/13] serial: sh-sci: Use devm_reset_control_array_get_exclusive()
Date: Thu, 30 Oct 2025 17:57:54 +0000
Message-ID: <20251030175811.607137-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace devm_*_get_exclusive()->devm_*_array_get_exclusive() to support
existing SoCs along with RZ/G3E as RZ/G3E has 2 resets.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e9345f898224..d07424caeeab 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3533,7 +3533,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 
 	data = of_device_get_match_data(&pdev->dev);
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
 	if (IS_ERR(rstc))
 		return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 					     "failed to get reset ctrl\n"));
-- 
2.43.0

