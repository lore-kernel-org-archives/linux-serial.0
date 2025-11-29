Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7430FC30
	for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434617; cv=none; b=iTc6QL1eDPyW96vGhDCroRATdUx8GRrt58pFJDlKreR8JK+Jf/+b/U9y+UPQFgdBTczNKnVGi+KCh2hTzJ0PYiCeJCf295yEFUL1RlJsFhALjGKQ4ooIYZMV/hife+Pb9MIULp7U1i0vyaz7u8gQ/URkDmWFKtJLtmcwgBpvPVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434617; c=relaxed/simple;
	bh=hQcgSPe+3G+uQfj8XLN0eIAy48l320/rWO9G0mm7LGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ahy0aSsYUSSWbzOQ72VLnX94G13ni2KZEL1i94msEgz+HReJRQSjfbm4MiaJmrcKknbR/zY+2qlK/YGqpZ+6io+TOENA9JxpyDsdS7u043N4YgQVSIEyaPevVxme5cRQXxMt/Cv826T4N/3t8LKaWFpkvrzhppFEZ/dIUjcBov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNo6IoqK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNo6IoqK"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42e2e239ec0so25767f8f.0
        for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 08:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764434613; x=1765039413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU+1F9sZHt+KpcH2RieoRsvtMz9fRLo9Sf6niQnCQ5o=;
        b=VNo6IoqKzf0FNLizGybC+Jpprqilvf2wV2mYpZcEY3MqTtWVr0Tumrf97hV9F1JSF2
         5IAeVGpVAQ0l530KLgoobB8JZrGti02CFqbT1Ze5mR/Dsbxez1XndmnKbKS0gYOpyji0
         o5WAzHqoTeGkeXRyJWfP6MLRNCD4k5W662yJi5Z4g+ojqxSLMxVhc8stkoYcTw2ivoNO
         0hq0WcuJZ5SjfuaT1MZrmSfKOMj98uWQzD3enIxbbLS5BLKi+wM+DuisRKif87Lo+XPS
         K001v20U9EGrBLqkL+HJPGRD7BNPoetigLBuj3xGqV8QEa8nJ/gonGyEJDdpoPIMKlKK
         Jvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764434613; x=1765039413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WU+1F9sZHt+KpcH2RieoRsvtMz9fRLo9Sf6niQnCQ5o=;
        b=g3z1BfDj2ZVxYWFjMcbsI0kjAYSLb/Ay4YHyMJ3EL0Y/2UyzUtq2HUt6ugqC1Xjg6A
         P3zs4XPP5s+CXwCLymeKEGUjO0VGaYakaLulzEE4VFTnlB7X4vjcwkjkXdjONGqLyI9p
         56nphlnPN7qXm2VRCYWwFiXMzXvv+gqc3XNoB8/jFPt78ewK8/Qf0DjGz2V4BFumpteX
         a16VJaYGy2UE7M+lmCR48l2T0bemAw1icnoSXUA8r5Q3EJ7KfKRJNvEsye2WDMvCfV/g
         fRpvxZIn+BWNwaS9MjVZxJ7oS5FsaPkiYFJCzDgnrqfSkQAd5/B3SgttGh1qRx9iK9Qu
         k5vg==
X-Forwarded-Encrypted: i=1; AJvYcCUWtboYNa2bRwL/EDT8hWZLvB9RRK+LoBXFySRLFcWlHu7Gx9PpgAEj2WseMNll9H7ifKH/BTWzyOTs8zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXBtTPJ95stHCfrgd3Ukm7EpUdYZNFliLRwLTrUymeO+3+HCAD
	gevLkm9wKfz9uXLJJps3JZOSuQe4MHC/HQplRZFEoFRVCMyTAFnyIIRp
X-Gm-Gg: ASbGnct3gvBZBGMoi+TIG4qZjgh/57+G3et28Vynp9iJKAZVrNs5QO5fGp7wL4bQ6Pu
	yT7tyoXoxqkwyp7BZH6calsVfpCI+fRsjlGrAvW0+tqK6IeGcWesETL6QLU/tX3sBn8rWC45SuL
	WAcxJWFLSxii59lzSt0MFUPAh/EvxCVfPiRF+a8eIatQ4kTEW+1KzgceD8EyqUFVkbPFRd9h1qZ
	v2ryZDsNgKI4L6kHsy/BdYh5KiLPTP+gAMPbIXQyzo+rNYKpsTzDBmO502RpsCgDBNxWieTgZcH
	tcez8Yrf+EhV9ukHNu2/q3W3aVow9kj9xIixDjq5SqHik4kW1Q5alVZJt9quiaNlfZFmfHU08qD
	MC2L0FvFL12C5Cngf/3AtdpS9AjNq8hSi/cDfyOEVH93wrFQa6wnLxq1VeximX8f+byyIMS9T/b
	g9xonB27vkdzx3jQQ+ilR8yugvIeN2lxBDMNQu70kzyRrughY9lAslDyBnAWRiXHXY7YuYWt38a
	IP9+nHHml9g3T24qPMs3PbIFfo=
X-Google-Smtp-Source: AGHT+IG4VSqxVVSZjRwFuCe0LHraq9/dWhrqgN/VtxoabswYV9qfBD5LmWWmAPZWuqMDQGEweg8EGg==
X-Received: by 2002:a05:6000:208a:b0:42b:3bd2:b2f8 with SMTP id ffacd0b85a97d-42cc1d3543dmr33904842f8f.46.1764434612707;
        Sat, 29 Nov 2025 08:43:32 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm15970060f8f.29.2025.11.29.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:43:32 -0800 (PST)
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
Subject: [PATCH v5 06/17] serial: sh-sci: Drop extra lines
Date: Sat, 29 Nov 2025 16:43:02 +0000
Message-ID: <20251129164325.209213-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
References: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * No change.
v3->v4:
 * Collected tag.
v2->v3:
 * Updated dev_err_probe() in sci_init_clocks() as it fits in 100-column
   limit.
v1->v2:
 * Updated commit message 80-character->100-character.
 * Increased line limit for error messages to 100-column limit.
---
 drivers/tty/serial/sh-sci.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ff5459c449fb..7ca94fa84a40 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3186,11 +3186,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
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
@@ -3200,16 +3197,13 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			 */
 			clk = devm_clk_get(dev, "peripheral_clk");
 			if (IS_ERR(clk))
-				return dev_err_probe(dev, PTR_ERR(clk),
-						     "failed to get %s\n",
-						     name);
+				return dev_err_probe(dev, PTR_ERR(clk), "failed to get %s\n", name);
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

