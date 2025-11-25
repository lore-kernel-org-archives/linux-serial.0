Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8432860B
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083205; cv=none; b=ewGvW41I1XXtwYNQw/IhxXWqmXG9wlv79NVO+tO2YDsvRUCDtP7Fv+VffbRaTFO4QlAI/tSpbRwF5OAS88/KzC3JwO135zncbSeFWRYbdUv/xqnhas1s+hWAZxnpcNbN/89oyMySVuiN/DiSvOj/7ZbAlegPVL5kl6TtYG4PO7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083205; c=relaxed/simple;
	bh=9U4oO5I2NrgNcG17dJctJ7d46CJVpoossK5zTcu6m/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WahMF/R/N1z1YLWFmPajOBMx8FzyUgusVYcMmlvM6Z3kS+/x9UT2M5XlNRxPdn0RMOesAP/FF9ANnKjd/UC0gldpRPGVxC01qVA1Cwd74eZImiDLzMAD/xCu/tg/tmBaa2S4e0pb9ViAHVbBPqr5iuDZtI82k5/SD/9fnqJVWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVNejC6C; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVNejC6C"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47755de027eso30168075e9.0
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083201; x=1764688001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9zh8AfG+HNjbK+VLsM1cI3csPWUGN2qVWpFhP1KUXY=;
        b=LVNejC6CK5x8w3WEjXAL2/nW/Soytrzv3km33PvKIV1QlJE4EGls66sjE7L/lULJUC
         xoO53Pa7qe4GP8CG0iikdmMNkKpez9wQx/vTaFBZBQNDPozNgcE64EiN4jTGSU2anOTe
         WTnKXgk4uGYHc+Yayfz0xaElCPuYlDx/bA3LixCxB2GQEtYE8IaZQN/SlQ0V3r0ksIKp
         YaXQnIs+YcqXdMozN2Sws5veLGB8B7JmY5qtQ6V0kdnUpAPjLx4/uV8ZgxrVt9HKWT87
         bRREy7lQ9IlD6F0xupWnu2OZnCYp8DrFAhgZngIB2xyXmQYpVCfQLwBr+ZSf7XIj3qtj
         9s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083201; x=1764688001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a9zh8AfG+HNjbK+VLsM1cI3csPWUGN2qVWpFhP1KUXY=;
        b=F480grXak495BpmWDQnf3GFklMnVweb5PytKbZnSbmKq7gza9DII+z5UElVPHQavma
         ckX/jdv+QyEvNAK4CA9q1uDN66lpdyBy2J1p0fSAFUa+mdMKIsqSAyuoimtzWkhqc/2Z
         rrt47OlxTdF/r9HfpC4zqetQ76Ruh5+LzAGI8gCbg2eOaInHqsBJPErAq6ushiJ5fA7t
         dXfoL88fghynPICOJtF1hH4HLWnxzxqaHor7LLxB7pbq5j/QGr4A8SCNPMlZ7Qc1R8xn
         bGsSwnqDlljnUBMfErdRNgUAJ0wcIGe6/7dyxvBFHTU4nRp/q1Zn3/gIOUVsurbUCLP2
         rjEA==
X-Forwarded-Encrypted: i=1; AJvYcCXpSz/zLylP9KGN4u+m67b1l5x2aiRdeGREP39gcdu+wX/bOy2Dyy8r5UbfMe07/ZhMZ13C8kyxvibcUHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHU5HmsvHUUgz9tYN2z/UACqPe3WOmaiabgiRg6GcOm34h3XM
	C1sQq1WzvkPZw4WLL7gWbQzqwdCEyeZyNO9PTPZrDCiXeU/5HXji1qx6
X-Gm-Gg: ASbGncsnKfTUHN1HTh8piShJ7b42rsJOvj4m27cVLuy00GtkcYlqmYNKjmIjS2yy47L
	UO6DcLShQrq551hA8S9NzbuUf6qNDhHQDLiF793ZvpDzRidxz+nxU6Bsjvk9fAnsqqAEAkN4fv9
	EvN1UwX2H//U4yiwZnv9iE6Su9CbVRGIpPdQTW2V0IglUnZ7JMXQYoax5plP/9nC1EBX5gQ/JVw
	Kqm7NyvE93Kro7T91My5sN6ta15TcgLZ0u6DfyByg9vu32EIvckYYNkWaovBRihlbDHF269L1+P
	t8ZX88AdNsTUEPHSXRr7/sS+OcqF2G5tIH1Hnzd07gq4w4mEDOx0Bf7jeAP7WESEG2h9suigiGo
	S+Hm+XBhU0VzsGi3NeDzZPmHiAbEu+UPx3suI5/69QWBX0vm7T9mFDZpFo0pqk35hNxCM8754Du
	nXkGLHrhkjxDxEBdFLMXpjSBGLjSdP3MEjXRGKYZkGCe+K/2ucQ2Ar4kGI0+DNHp9WPYGr5cvpf
	yqP8YAj57WuDFMU
X-Google-Smtp-Source: AGHT+IFvMZXRi0NodkmkvyAj0DhVJuKBmn1mTBhyFBKqA6ZbjFFQnNJMGYPDLgRUcU08fkxzO2pSsQ==
X-Received: by 2002:a05:600c:c83:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-47904aed270mr35278435e9.12.1764083201071;
        Tue, 25 Nov 2025 07:06:41 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:40 -0800 (PST)
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
Subject: [PATCH v4 07/16] serial: sh-sci: Use devm_reset_control_array_get_exclusive()
Date: Tue, 25 Nov 2025 15:06:09 +0000
Message-ID: <20251125150632.299890-8-biju.das.jz@bp.renesas.com>
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

Replace devm_*_get_exclusive()->devm_*_array_get_exclusive() to support
existing SoCs along with RZ/G3E as RZ/G3E has 2 resets.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Collected tag.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4dc5b51f01da..8869c25eac95 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3715,7 +3715,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 
 	data = of_device_get_match_data(&pdev->dev);
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
 	if (IS_ERR(rstc))
 		return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 					     "failed to get reset ctrl\n"));
-- 
2.43.0

