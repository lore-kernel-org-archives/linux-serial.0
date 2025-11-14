Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE3313E28
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117532; cv=none; b=iXaml13WavbkYqmGz5ip2XP1WGvx7qoFtNGBkFuV8ve2R7rdBkl05ga5pM6ejqU+RIMgMjzhUkBp2DCVNOIBhMLZqBgOE1aUfnbyZKrG9w+xbewbcsuhdy74ytSPEX1NdinWJYZhL6uDLSA/GqsYAnZVMARieMF4JuiM2aJ1P74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117532; c=relaxed/simple;
	bh=ru2guaIk7rMFxFxpc2N5M6yg2VTwXiC4MjDfQ6kWZxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8M1yZkYPmLQ6ic0H18rF+/hF6H6pO90k4yDnl/z0ZKu0dysg0GuPvi/Ncb+T3PikEQSAXC8ctOZjF/41GPkW93rmANKNYSFlwlwBADEWEl4o/swxSSpJ+nZl9F6ytrRZAYTq4sBSdm4npLq/tFxTJSK+hm0Xm2Dbjc0C7Hemlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5eZNGG5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5eZNGG5"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so982060f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763117528; x=1763722328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BlqBBFnU6cpkdBKW6lNeDZYEdxfRJJxWHLMTx3xDXs=;
        b=D5eZNGG5YQWZtMyvqIa3KVOnUgH1TBk2LpJvOIDRNg5mnFK8rK96OMcnlesMpZXS9l
         XkNXOht3btt5bkDC+/8lx4+S5cV0t2iRc1741V0vtmRV1b9g9ALm5HLzGqVXi5G9qA4Y
         C14b1cv6EiTdrDPGctnNpSMH0EIj+lpoyZKqjCHxkcB66M3vjzzK6AoO01JZ5EdQi19s
         e7SVkT1h1JbT5X4AQCbWBi/DXtqS4p6OH3v0sLRxjgVe7AqZWNtVBC4QH/fka5apx+Pv
         m7KJG3MeLnQ2JdTTdjNEX3Cxz3Tw0IQ2EH1aDCtW4uVAvuzp4xRanzt1kQV6yFRDpFdU
         yQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117528; x=1763722328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2BlqBBFnU6cpkdBKW6lNeDZYEdxfRJJxWHLMTx3xDXs=;
        b=IHL/fhKNX97LiZGVWu4brMTNFAHgmNtjYTa6H8PH/ixgZg+h1wztrn1xmUS5lcJIFE
         59yEZ7nntbmAv7UfNjsKdiFePooZF0bEyXOFSnxfiXKS4wRpf3w+KrMFqXwxs2xsZYRY
         MNEYy5WWzdUeH2zPKQp1HE7sfgKsOS8xJpRTp7736LqEY5L+U4GizYdRgagseVZcvYKf
         rO9BnaUgPg+CfJ6GXoU3NfSoAr2oBV4Mq7Uc32/nZWyBstqI6pUk8xm8rPzeHWek++Mj
         SGfbwQiN8Mqy8LVoaz5LR+MM0CsRXKdUnTSz7xbkkr5dIsp64B+4Y8jszBxuIaU5uT/X
         ZGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFhax0PERGUAX3nXkkuztsaheBThz7zg6FahOdHpCJx8t67IF1NHUvgZBVa/wH/YDb8mDwdIOIeOEQSDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1Os/klcfho0vRXYJKoW36TiS3jHj2q0Hc87yPI8CWWC2mtjP
	plU3Twjai/R7j284F4y1fb+55cA6MifnuRLDrvzoVznu69YA9xcMgznQ
X-Gm-Gg: ASbGncsLDwx7zM5TD9G0SPf4T4uMdZZ6GaAvvQEQGGrfCSG9yXf/DLkXJU/ugpXdWHh
	385O2H5zuJW6ATarrPes7uNSrHDyeoesmewzcqnkAS8M8aEpCe2d1fcBb74gNiBO35F4VnJ8+Iq
	xwWlhgLeM3JNnXNf4UKNwO+I+SwZuhX+26kEGGNrWkNEoEppkZAO9nFGR1Wi5Kjmn+YL4bkQEAe
	r33T7EoSHDkElk3oyTGLyr0sxoXFx31xZDA569dsypEE8d0f3W+j1ipCGCxs3AHFWu7cgY6MfRM
	nBNh+w22vRSmEraQRmFCgifZlfUfU2KB+DQ+J8u1AOq5w/6eDXaU1ibodWukqiO6Yzqw8drXgXO
	qvn9+aMjQiqfh2zfVpjynnJt77coi2Uepw/rqgDZdYIYYsBAxL4xvjtSkiUPvCDnCbOfTUb6pIO
	Np7MedZ1grvBDLNFGvY/nny/4VV/HhgtGmXkxVI1fjsLmAr0AAGV1qW/UZCO8htFg6791nuYcOJ
	TXbyoCkOrDmiTp3
X-Google-Smtp-Source: AGHT+IENiq1FIhiBDu3DOoS3VvOneVM2ON1HCZYGoXUdTVJ1zjs7sgGz0Gqc2GRNOhTZl2xSdT7f+w==
X-Received: by 2002:a5d:588a:0:b0:42b:2de5:251e with SMTP id ffacd0b85a97d-42b5934e2fdmr2898715f8f.26.1763117527909;
        Fri, 14 Nov 2025 02:52:07 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9031255f8f.35.2025.11.14.02.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:52:07 -0800 (PST)
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
Subject: [PATCH v3 06/13] serial: sh-sci: Use devm_reset_control_array_get_exclusive()
Date: Fri, 14 Nov 2025 10:51:15 +0000
Message-ID: <20251114105201.107406-7-biju.das.jz@bp.renesas.com>
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

Replace devm_*_get_exclusive()->devm_*_array_get_exclusive() to support
existing SoCs along with RZ/G3E as RZ/G3E has 2 resets.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1065773555ba..78fb3b6a318b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3710,7 +3710,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 
 	data = of_device_get_match_data(&pdev->dev);
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
 	if (IS_ERR(rstc))
 		return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 					     "failed to get reset ctrl\n"));
-- 
2.43.0

