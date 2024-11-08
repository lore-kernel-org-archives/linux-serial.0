Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AA1E2831
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065042; cv=none; b=W0mKY4X3HNvoo9cKuaDGN4Ajd51lW2mxH73dy4Y+OjM+v0f0jEK8AUgSFZjeN1ZkHYF1oou1NA85zttg8O3x60scf0yqkeklGUWVOty7IKzhB0I+iGO/WmfDq0dUX4RTizDISGF7GdWx/gZU6CKvdGuuNzapaJu9Da3wFpFfu7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065042; c=relaxed/simple;
	bh=mAPRkq8mcGAitqZ2NJPZs4WYcWRS92IxYDvqOFLptL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5kCj/a2bMRpWh4Lpi7GEC9NvdrvKfCrulywzb4KbzFTAEy3qg0vDdWfVTWo12ifdMqyMRpmcJ7QhRQ1Kv+oyRBNl6VvxYFoaBCkfInnUW0o5drWXZHsLDHRMMlneLIWHt1m7QSTcw7N/f2Nxsb8gMTmASmrknVSzonX21NaoBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=REkWowVA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="REkWowVA"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d447de11dso1390178f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 03:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731065039; x=1731669839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1w6RpVPZFLgX8W7zDDIW9Bt9wUWPJmCNFHj/06iwgR0=;
        b=REkWowVAGXFPJsLao/LHIOwLWbc7bC1/om4qfzn8elqIvx1CDGor+LfsvAEKRs5ONp
         HrLWQ41Pz+FCFIPno/G61I3/QOMTCYiVD5rkxsDx0n62c/ta/f2UdmqML50ZeBeBTCmn
         2GpB5OxxRnkhUEhutTzAEVpKHO6JdeKfsIuvIzmoyRsy379tSkAtIibOJNk4Uq6Nfsxk
         iUl7TEhWSKGOAHZUG9Jttwe9R6VMP80E0rQSK/68Szo9bhKXOAnMvsPQlEX8uNKn4wz6
         c8fZSfxOxGNpM7V1/XgTDRR2f6fsCuqYFSFx5Wk/qmsLyYNsIHnXi2PEGVxI2aUSVGK0
         x3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065039; x=1731669839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1w6RpVPZFLgX8W7zDDIW9Bt9wUWPJmCNFHj/06iwgR0=;
        b=dTHWxdGYrs5Ir57G/9F04/lopHjOk/6nz16aL8K3qdx9bZiGaJCOsyjQdNk2yhWmO0
         Pq1M1F+GUqIIcpwv7+g/PoxAPxy1dbDKgtIw7g1jMVznBsmqlEw5t5KWiidEXobXNz8H
         VJakKwYtzY+Ap+kjg6iNfxH7Li2IQTduHtl+ORmCT9G3tnILBbckatl7KhpE3Xc8Gx9G
         mP7KagXyLEsV3qtodJ5elG12Lsj1tsopTCspzFWWnUtGPI//KV08Awm1Kr66Pm0LkBDj
         ZCJdXF1zl8LZbJMSSzuFoeVSNvaWudlZ4AidSkrWk2olowUUSxXw9D83/rFMDgHf+qHT
         enWw==
X-Forwarded-Encrypted: i=1; AJvYcCUjJMD1COL4UfR6uC70OWS3oZ8YSXLOdgxnv/DTMb5T7ASS9D33GsSV7r0x9NaM8IeW2aiBoNtP+3GMK9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXoWceGfs1RErALQyo23IwnyQjJbR1f5JjXmRhblY+jnYBf3ag
	MAR1wgjBhPqu8gZ2C3L37p8AL8rFVQhyPWuXpYRzK0NWSM2+L7gypLJ2ODsvdHYPMoG3lJyBzxo
	8
X-Google-Smtp-Source: AGHT+IE2dTZAM2eNBdyoJ0vYP2310xH3HRvixP7wsdVyd9U7THrSH3mKlvans7ZEtSce5JJp+KGjDg==
X-Received: by 2002:a5d:6daf:0:b0:371:8eb3:603a with SMTP id ffacd0b85a97d-381f17253e1mr2103427f8f.27.1731065038785;
        Fri, 08 Nov 2024 03:23:58 -0800 (PST)
Received: from fedora.. (cpe-188-129-46-99.dynamic.amis.hr. [188.129.46.99])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed970e18sm4281443f8f.10.2024.11.08.03.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 03:23:58 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/3] clk: lan966x: make it selectable for ARCH_LAN969X
Date: Fri,  8 Nov 2024 12:22:34 +0100
Message-ID: <20241108112355.20251-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the same LAN966x clock driver so make it selectable for
ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index ef709327cba1..713573b6c86c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -270,7 +270,7 @@ config COMMON_CLK_LAN966X
 	tristate "Generic Clock Controller driver for LAN966X SoC"
 	depends on HAS_IOMEM
 	depends on OF
-	depends on SOC_LAN966 || COMPILE_TEST
+	depends on SOC_LAN966 || ARCH_LAN969X || COMPILE_TEST
 	help
 	  This driver provides support for Generic Clock Controller(GCK) on
 	  LAN966X SoC. GCK generates and supplies clock to various peripherals
-- 
2.47.0

