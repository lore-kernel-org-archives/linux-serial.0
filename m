Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2383374AC8
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847099; cv=none; b=tQJwhaMATUAbqTPJzxeMFk+IAwTMA41gyaqiMX8Ioqu72LHYmmMlfyebts2ou39QobJKah7atyNc7Pb3V49P4Wykt3vmZczMQljxGLwsu/9bxrkqlCeQTkTJB4fo/HldAPIVH46weLdfOFtADeEqPiUSwg2iEjpzVwz6NDWBXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847099; c=relaxed/simple;
	bh=6rJaHYLudOTTm3QmqB48Nxc1YcoHdZeo58CPf1gncKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNYQjVWz6FET74fqGKQDc4lupfNYjbjqGNqRKASUzr+dwD4Bhy1szuFV4wMxFAywA6LSrkxzME22Thq6zQSihGDSqbQIlcBe+CeKoteyUZpEiMeGTFZ5Rt7mv1U5+3eoN5AUVRdbYkvpCBivOV8f4iuQ1/+6VY17vKgfcK5ZFYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN+tFXfU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN+tFXfU"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4270491e9easo1202200f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847096; x=1762451896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5RyjODeDGquD2fp8h4Ys0a9AjmkuXgJEKfRWxOkPhw=;
        b=gN+tFXfUhYd7AN3Egbhc+T7/pjjMN64BsyJlhBek2r3vzGltI3kPlI/rTbHDhObt/v
         KDuecshf8fz1/LKL+bgt6zTWG5uYBx98KpeqkELuXlTesVM8gspjIp8iuR4yzPH3BOhM
         Q7afw2djT/6wdIrjocj4Z0+aWgSpvOKEa6U/7oxh4957jYlIPv8JbOmV/AKNdC2BUxcE
         Uuk9TWfGk0msU8pD3UiTi54FxLCDgbIIPj9IvBuFUJioXNebhjbJ6y+/XMKLl96gyZe2
         y1NGgvNSCGB7rX09KdcbStfOVHdjViDBfcEqPggOCuTSn++ROLMrRusk6cyPkInqQhZU
         TuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847096; x=1762451896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5RyjODeDGquD2fp8h4Ys0a9AjmkuXgJEKfRWxOkPhw=;
        b=OWmlrKEw+Cmdu3L8Qh6U9WlKDpJE0PFAq2lYxcRLS/PPYUE0kxyLF4/zP1BkxUTvKu
         77DaxvorEjzcbaGZYZa1eCxSWZkPvuchETp208f38e7bWs5FSGvn5n6BuXLi7dcGSFh3
         pkidnkIt9OsbnEOu+ukJRJ35EXTnXcCOzfMkgft9WZHWEXMqo1hyPdOcTZJrWBNTwaFg
         NQZPvwK+EwZsIhWn3sboCHPmX4nDlU3TtrP5coJ6vasszq3CVDg25lDMPqrps4PZpLlD
         CUQYtSw0Qv3mKKxxAqIt6thg9aAGp/r11fm+fYz8xwmSDS/hZcCt6qQomjUIUB1ec0Ur
         aNag==
X-Forwarded-Encrypted: i=1; AJvYcCUsQWu69lrX5D1ngM0SSCScCegiElXmNFqly6rIwd8imzA/g9ECzG0+T0TsgHZhYv1bY1gHvuYkEFcIwxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5hkZmikR8fPDcjvYba4RQgCs1NUvHXX3WdL5NhPcXIcPB/z7m
	HnWtDdqbBMu08ZNT1TnLvEOB/curxfgu7CnwTpEE+Yp44oBsQq151NBH
X-Gm-Gg: ASbGncujjAI5Jo3lhuGUozjXpYNxmwT+efVnIFERahShdATKlhNiNwNf1X1Oica/mlx
	amnDY6K9FnAf9/237gJy6hMhuF0CWRCc7kg/hqORdc8x2GmINI5FWtlRHj94pzH5QnHNvAUVXB2
	aP5qaE7qzVLKxK4XlLmaaF97rd/ckN4Nc97j1IQ1+ym5N9bZU+Tz600AWDfWjRZRs4Qsjh60yv5
	pKasuk7mPbZ0QqAvd3fXjCtxOHQmyctQazpNzGJdBSxU79yBZH4fAR2VMp0zqtvLQRbAVh+2Zqd
	NbLFkMpcSnoB6VhWyw4Xn3Lpvu2WEPv6WDI6qV0acaOOY04y3P9GvHlCESAA2Q3UhmTeLqQtiOG
	88yisH9EefwM9I5JwWhP3NJHNRyaBn0h8YZfhNRhSggPEY902zJ7bWkP77o2kxwCsYXuQ1vNNfa
	SpRJVBadkSJ0PG/EorGZ9P2HccMaRlkme47Q5MsxC81V+PGNgsgHf4lJWOr5aDWQLtCyMzEro=
X-Google-Smtp-Source: AGHT+IESJKAO8ONCerKPM8W5gyvkInHRoiE3CjlNsdnbfCKBMGmr+c3jFDp/+N+TA8ao+fo305pRQQ==
X-Received: by 2002:a05:6000:2f88:b0:426:d51c:4d71 with SMTP id ffacd0b85a97d-429bd675f4fmr449957f8f.8.1761847095655;
        Thu, 30 Oct 2025 10:58:15 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:15 -0700 (PDT)
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
Subject: [PATCH v2 03/13] serial: sh-sci: Drop extra lines
Date: Thu, 30 Oct 2025 17:57:51 +0000
Message-ID: <20251030175811.607137-4-biju.das.jz@bp.renesas.com>
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

Shorten the number lines in sci_init_clocks() by fitting the error
messages within an 100-character length limit.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit message 80-character->100-character.
 * Increased line limit for error messages to 100-column limit.
---
 drivers/tty/serial/sh-sci.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b33894d0273b..e9345f898224 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3008,11 +3008,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			return PTR_ERR(clk);
 
 		if (!clk && sci_port->type == SCI_PORT_RSCI &&
-		    (i == SCI_FCK || i == SCI_BRG_INT)) {
-			return dev_err_probe(dev, -ENODEV,
-					     "failed to get %s\n",
-					     name);
-		}
+		    (i == SCI_FCK || i == SCI_BRG_INT))
+			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
 		if (!clk && i == SCI_FCK) {
 			/*
@@ -3022,16 +3019,14 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			 */
 			clk = devm_clk_get(dev, "peripheral_clk");
 			if (IS_ERR(clk))
-				return dev_err_probe(dev, PTR_ERR(clk),
-						     "failed to get %s\n",
+				return dev_err_probe(dev, PTR_ERR(clk), "failed to get %s\n",
 						     name);
 		}
 
 		if (!clk)
 			dev_dbg(dev, "failed to get %s\n", name);
 		else
-			dev_dbg(dev, "clk %s is %pC rate %lu\n", name,
-				clk, clk_get_rate(clk));
+			dev_dbg(dev, "clk %s is %pC rate %lu\n", name, clk, clk_get_rate(clk));
 		sci_port->clks[i] = clk;
 	}
 	return 0;
-- 
2.43.0

