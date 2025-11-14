Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78D313E0E
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117532; cv=none; b=qu8NBwWRhFxx4Xm/y2sywqwtc1lYJrjCzmQUjALy6JLDW/V+WBu53v+BtbqMwbD2PDDER+lDiyKW8Ad3j+GGiOU9BK/HwxpGAepI9al5Az1Yq8K7TXpXdroVodJB9sn871YTOnZ8tM7Kf8zUDkKe1FDSJFkEqcaacSDKaN3oX4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117532; c=relaxed/simple;
	bh=Bo7fHv11Re9CoW+XK21VskhvvMCHF+6Qb3LdhXkgXoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIfxsmwXTvlGPZO0OCqSuGvysApqv4Pda8dxGU5RQPgjft30ZBXtnyIMjfZSY3RKyswCh5FxZQIzudmczge6qn1Ehb9YIt7cF8phGC4ZHUUIFtAzpIVYl1ikO/AoZfwqg/U3D6xU+QFSbVRLoCYhDroHjtZMA7Bw4xo3sXHT08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSYNPYnD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSYNPYnD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b312a086eso1113771f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763117526; x=1763722326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcdLKywiX2/UGkDQLLsxetMHBbjl411Sv7eO32NzeAE=;
        b=dSYNPYnDtxvD/zMSx+TnOx89GV3zaX58Oq+4ZO0EfcoxK6RaZXFrFdRvKBZcVk5Ahy
         8PcICF9eI954oMoSylVTxqDuRMbvQ5Yzo9fSD6JLcEE1zjOfRLQo6zFunccTr5uxhCoi
         4Fd/+Pd7/xnt4j22UeDxua803k/nMZ1xu5r5qgcpwzBPuA4oFY90TB5SjLGEIK1w17GE
         gvbCjGBW9VWLDpdY1Xhry8hGpIT8WQtpJlXPhdNjqgEpkJ0xReu0qEVoD111AV7YYh6X
         Wl0CjYWdKQlASRm77MEAFFPbeTxwaVI2voA7q9KN0tl7RNTDotzzOsOTkvCCgIjLRXTz
         MJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117526; x=1763722326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XcdLKywiX2/UGkDQLLsxetMHBbjl411Sv7eO32NzeAE=;
        b=ltZfT/D5dv43vGAmpNwtu7D6WhJDRNqxunwTUrlfQJX9piYP6nYweS4UZIL0ecSDn/
         ccdmb7bLu8U4j/IfaGJnUtDgQJbBGZ3HYAxDinelXgq2JadFECSh5vudKAOAu9vwzvIr
         p0hHVzpVtjQPLl1Wja8VxbjSLLorxHoeqCriE15khg3XbYYrc4CeUmnxbjpNXo0mW4hP
         UZyXM0zimbQqqnlhNyN0k8Y/1u00xOovDHt3mFMpF5+a05izDio3SbESTjKP3i2Kxz1s
         mgHN/es8HRg72FhzIPpwe2q6l1fj4LZ1/1TYsR71CD7MtirHfHzmBUqmZvw5XRp1CNhb
         CNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9hw8CV46P03hNt7B56yGiE/p+j9aRu8q2uxFxJksT0gq0b4Fgrl+UlFXJe+2qhnu5ef78OVIOikEAXMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VX6yIkEyc8HihjQAKHri3Pov0V8G6UCOMdVEQtur/iI8X9CY
	wcbuIwZKdn/lUa9Sr15loUDjjZPETYCVFj1MKYKJlcA24P+z2lg2o3tL
X-Gm-Gg: ASbGncvKhuA2/9fHcy9tJTrcGhF+mA0Q9FkEGaeCMUV3Cxp/RMR1kMX2c0imuE0TsfM
	svTTdpeWZBRAouh7lOI+S87knl1KnkzZM5qRbZHDL68a05l5eGe9+K+6G+2smQ9vfKrGCoVVG+L
	IytgMXLcW5GL4OjSmx35SxCk0pVTihqhhXDCpWg1YhxV3WQI6Eg2jap6xbCuar2wybfP8h56559
	h7IjYYrsxzxYock2k0kWbFOjFmgtoY3yyjclVLi3En8wObcsEAVurtLqrIxJgxcGzPLAn7xtMvg
	XGqnK0S+s2gy9wzA2ZvU8gfG/nuNANkZNYBLUtlyjkfJtm/FOLmVbuH2bzAehzTAqIcrZV7kKIM
	BXuyVyegcLlZWi2OZozBe14QIVkfUDGAAw40ke2Ty4JZ+CH6ktH/97SmKpZOfASMaKopCRqxFgX
	dot6WKU3lcc+sNKx01Qk+V4WEurVNyQr28AktUhhQAW6wcS9nHWZo3BZJqHCz+n460qC1hS1ZJc
	CgXrqhsvrVFsv0j
X-Google-Smtp-Source: AGHT+IF9AeRcYUxmrudgZkczghPrqdHlfNHpVMvqeLBzhtxnBkmtDd/7lfsgfcFS62tiRc4aZwfVTw==
X-Received: by 2002:a05:6000:40cc:b0:429:b9bc:e826 with SMTP id ffacd0b85a97d-42b59399155mr2685801f8f.53.1763117525845;
        Fri, 14 Nov 2025 02:52:05 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9031255f8f.35.2025.11.14.02.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:52:05 -0800 (PST)
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
Subject: [PATCH v3 03/13] serial: sh-sci: Drop extra lines
Date: Fri, 14 Nov 2025 10:51:12 +0000
Message-ID: <20251114105201.107406-4-biju.das.jz@bp.renesas.com>
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

Shorten the number lines in sci_init_clocks() by fitting the error
messages within an 100-character length limit.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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
index 53edbf1d8963..1065773555ba 100644
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

