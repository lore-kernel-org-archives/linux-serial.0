Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048E36CA94
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846935; cv=none; b=DT6FOXyxTm6pXjXgPR8EoKVg5ovE9/l0KaySGfu4r3hw8Saua+nbfoslq6eEU27FitpQgOIRPavyy3s8JLm0bs+HG48QY8U8Pey0jkDEqIf2eyhDvhpPsdMXS+HXjzRlncnFKoObwTxYmukrfAqt16vAD7BlshUUYCKvd4j7t+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846935; c=relaxed/simple;
	bh=6rJaHYLudOTTm3QmqB48Nxc1YcoHdZeo58CPf1gncKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWaFTfVnzKPhFm8C/7Ly0m1heS4KTP6+XOhuIs9XamyRD5eeu10pQsXz/4BN0l8dnKZfKRt+L7a/qtH4MSWjwHMPwebt8IZVevAT68eppr+y/WPf5Q3MlWcviO6/AvrpTizI/Q75jnYZjkBvRH50L7GJ1pGWLH28eu5lABVdnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrMMf0Xg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrMMf0Xg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso12818925e9.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846930; x=1762451730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5RyjODeDGquD2fp8h4Ys0a9AjmkuXgJEKfRWxOkPhw=;
        b=PrMMf0XgSq1B0JXI4C70oCTj2Maqfp1aTPQyE4PfRxWdqt4RZSlYefFUdv8axPHcp1
         STUeFTfHz9GPVUjrC/5SHapO9lE02LoIsSbcamqAERyWb6Jta/HSzxqwpFbIqkspa301
         Qs4NdYB/PALTNM4Fylw/ORaandhlO9QN+9KGjy2+7mqGPwulG5FfCBpBBvKlYA8YQY+O
         tj8yisso6DiZySXDG82ICckzbG2Ne/lFWHThEG6ebrTQxIS9TpfKil/+Zt0UI1g4bU86
         VHO81rtR3k6k5Qd0LPeEmYjFktQwxT9EgtM+6Vsbm30b4TOlWyUdbL61BbaqB7aNNEiN
         0qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846930; x=1762451730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5RyjODeDGquD2fp8h4Ys0a9AjmkuXgJEKfRWxOkPhw=;
        b=opzGcB6XgvX0RhbG4XYuxp8SStG7n9kDhQO+hUC0RgrlRDtd5jA9wTJtO6IbFrgnKw
         D8LhQR2RBwMh7X+EDAcsf2Vchj8Ja/CQuXfTTlkKnGLiH6nrhOagUjEMkfdIUfzKY/QD
         gc5lNs7sAyhWw/Spp1OcS+u28ELqNHs5sn4zSxzI3aDXOXXmgXV1+WngEi+XhAwlTxrd
         cokJKs23m23q3VTS8IKw+jK4gmVY63N040QZrNPscd/AeB6d2jqjvsdwHBIyocm64O35
         SzfO6cRWpsHPGKyv8rxC6prOj3/VumoCJSvWQWMc1tGDDC4wibHhuP4NnY8nVQHyo6jw
         P+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWfMkE70fQLkSe1BHjrcsA2adm67jzB8bqPQMKh5yc7cI9R4w2i4JLwtstBN+ZIjq/QoWYwn9g+p0Nr2FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywHHSZ63WNiGgFRGrJ+Q32pKvtVYppSKK5euRWLpiYQgflxHjR
	+HT8VuzZDOKY+iWmjrw86dCikxEh1l3KR0TCZ6Uy1N3YjKxz1xWZueSd
X-Gm-Gg: ASbGncv1scpm37LwWK6KPZIZF5WugcUDObHqEQaCPM/mvdqw/jXk905KNjE43wjacKk
	2Amm44dHdnpRVB9x0Gg1+YVPKeyAteB+npD6GHPjXRPPTrKp3WwPfOA+sORMjL9HoSSLNIdc5fW
	885nftqy7lWFktG3cspHbnF0DU4PHY9ZFhZw6oq8UnD+S9pZj+ja/bYT7cV4tJfnfRdXdxJQpv7
	TifwokF490NLdyXEfTbGhqh6iGqjltqQvEJa768nObeISQGRbEAkVvbDzzp1ezjH/xPjyFQqaj3
	ng8Oft850RIoKmK2ZeIG/UYKJaN5HGaLM/ilSatHHyQvdJYjxi02hBn6ojvCbeKJ7w4uafuqsj4
	10xbbEvLZCfP8DASvISg6WRMd4YugNxwYYnSjijxLaiIS0YBygMOPHZ5ABE5vZp9e/Qq47QRc9B
	x0azRjtEsphNA+AtoQKA7KhpaV1zPCPPtxS7ZRk+KmgwaRZPD8RXCSJIu65g/18nWaDsg2kFY=
X-Google-Smtp-Source: AGHT+IFBi0hqrqgDBukpX7UuHHLxHjT0GA2iPHi9vZvzYJkR6850zvm4U+rMbHpm3ZqwPaCKtK5CeA==
X-Received: by 2002:a05:600c:64c5:b0:46d:996b:828c with SMTP id 5b1f17b1804b1-477307c1fd3mr5174305e9.10.1761846930304;
        Thu, 30 Oct 2025 10:55:30 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:30 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:55:07 +0000
Message-ID: <20251030175526.607006-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
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

