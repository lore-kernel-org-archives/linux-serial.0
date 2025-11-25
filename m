Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B9327C0D
	for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764083203; cv=none; b=Qyt7zjO1AT2Xx+VwZDTR01V3L/wXt6Pc7J6a2ITUjFG4dk9hlWj6qYhShYlN1uo0E+L8wTuB5qiFSrOkMszzX9egb0nyuCWmhG+GIrYsjyCF7WzE1JfAQCH+CGmU5uIZlIRIJIv15nmN+IEI3y0Ka2SVptMOSIeVAf2YDY7NMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764083203; c=relaxed/simple;
	bh=CSD7kFI0wySJ/AlKIEamPA0YB45z8JOZMFeKgaJIhpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4CAtPKkKqCmKqy/cZTrLVMUpNhtGbV95UYBvSZyPPEBdN5UVYsMnkojjVpYGzi3mRb4RdgcCKaHXMzo8AFxozKUVuYETPscqQCx9+HCAZM9/iWlgmqfkKY3KInhYf3HCvm2WDF/ZUsN7bTdU6Ozycfd9ecpdHLHhO53hWkFNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyjcWFeU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyjcWFeU"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b2dc17965so5320756f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 25 Nov 2025 07:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764083199; x=1764687999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQziduuM6JBsyM6+4nJEFa2lBvhbFNVVerLMQJ71dvc=;
        b=NyjcWFeUU4Y5gUNqAE669LPveQTx617VC0Oa3Yx1u5fNOcZqkDTI7EuTIsT1dxwwLy
         0jbBIoW82YWN/CY94mTcOPvwWSdokCG0dbEnqluzEkKPSGLKnD9QdcIfTmE2n4eb9SJS
         FpjahswGzoul3oTnlswHr/cTQpZajok2YOMwSg4ZyoU3TJ3pA5Ohzvr/ek1XLZs4KNCZ
         MznJAxWbL/tWusqKeOtDqVZoAtr7yXU40z5LlWWkAaU3CfysOTpmc+CGKTLWig6N6KbF
         +UXNGuXT9Kc6p04hpdGw6AeTk4kH+64bUN3imr6SfZWp9FV/0jlaAPBHSJ3F4KpgxrSd
         vmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083199; x=1764687999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQziduuM6JBsyM6+4nJEFa2lBvhbFNVVerLMQJ71dvc=;
        b=CyrsPa34YPwLgMtYtpm6rHlWUX62sMyByjfvFSb4NDHyAUaxRT4p3OqWdXFvGfZpt4
         YXqsdbvIGW4kKVAKkgN81dU5k0zFK9FQ6fTvbiec/WiZRm/630LhEf7Euk1PAUUaflaF
         QTziyCO1I5ULOYKtNWYn58Re/3YMkXlOQgy+0HLzIVNh56SPdMT2JY7vWlIVg/cUsOxX
         Z2GTFfBIS0fUxzQMeqs2PR5dX4zcNFXtHO1l84Hns7HF7OkKNsfu2/6ICT8yk7HImczh
         4qVB14QMRMkEMEX62mmJgcX4bgem4M5hY3EtbpvENCTknjkbtgDk9LZMHVdouo078uMR
         8uiA==
X-Forwarded-Encrypted: i=1; AJvYcCUSL6k+WyCbdf9EusDGuWbEso2LOb/Ch0MDKEx9G28XcGurxq4bgwGvWoro0rvucZXV/Q0d3Vf9p6awtEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW20mpd0AhsP+zC7KCEY6KVrecG14xlgdlvFJ9TWKExTdfN8NA
	AUqfMiUOv/hOkZIaT+U28gcaNlis3iZ/yn6FsQPj55dgmjqw0YkzOcK9
X-Gm-Gg: ASbGncs3qz66kRrogSZ+NCzCR+ZjbJURjWaQLE9dLJZz617Y/Ehth+6TxQyDlVU+/OU
	IlWFT6kARkj6HhAot73l0a2C7fwYZkd/anE+Hh4Zl/F6d+eeY/F8it697yykpgEc3V3EhPsi9+g
	v0+o+ewZUs3m/KSqYKjhZ7JkhWhjIPcAD09XGoHS3EgrlVi+/Glbh5c/l3qaRSayCMdFPMPPf9A
	P23WdC/GqprYAOYaaNgl9TId6tdkrGhAAg6HJVSDwhO/J2G2pu2KfkIMfM3+rKuQZz3mGcZln6s
	gCnGgaYfudZWWAXK7L64KssOSRkr+oQgrojdt7ukMKaqhQCbhnS5ykq+yEpoS6O5wKxxWZPeHAs
	hSSu6p7BbZUk1Adso/g+Sroi7IZpor9ABGebm58QHt/DZooZw6xoOJ8P5xJAflQqQOAqtD0ojNt
	4HBCYavsnkm2nJgXut4xqvc4lkkAWUukGp1wR70UdhteLPVqjv3ZgZuHwTF/Db76HdjXeIzvLu8
	g==
X-Google-Smtp-Source: AGHT+IEjq27xh/vO088NXc1xLod8BK5SoqS4WSTemdISNzAYy9ARbRUfoih94uE1BYs9/hR5op/8tA==
X-Received: by 2002:a05:6000:4014:b0:42b:3825:2ab4 with SMTP id ffacd0b85a97d-42cc1d22c7dmr15817905f8f.52.1764083198699;
        Tue, 25 Nov 2025 07:06:38 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm34797809f8f.32.2025.11.25.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 07:06:38 -0800 (PST)
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
Subject: [PATCH v4 04/16] serial: sh-sci: Drop extra lines
Date: Tue, 25 Nov 2025 15:06:06 +0000
Message-ID: <20251125150632.299890-5-biju.das.jz@bp.renesas.com>
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

Shorten the number lines in sci_init_clocks() by fitting the error
messages within an 100-character length limit.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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
index 56d6489b2a7c..4dc5b51f01da 100644
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

