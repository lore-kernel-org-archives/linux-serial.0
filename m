Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803C14A82
	for <linux-serial@vger.kernel.org>; Wed,  8 Jan 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736341854; cv=none; b=jboyqFOF6bq0Bbhou5FPY+8gwpeIF6qZRzkxONAMDSPVggWdAIfOJYeaUUGGFVk2K4AAxamgdRELXR1A6xWmapFgXDyqkem69NBCgIJQqEebj35aCoQxLbSZwJIfAWHkgbBNPE9c1Ap5LkQeNg4LRNHgCmsGseuHGUMacIcY6Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736341854; c=relaxed/simple;
	bh=IMjiMKuDcoOKg7EhCgSKW4Eehfkeo0sfGrNn/NXI+Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2hKdwj1pDBMR2/IPii7avcZXEjudmrI1eQDD7HpFEFTMOzFS8YyTeTDqBLyLpsXWr4Giqdk/Gh/HCGgbnMTYHAf/XIZdetqUrHK65P4ssYk9A+Uj7sP5Y71VHbMpUua3SnJG/oNOstzd2NEGVWpYyuJ0VI5DVCI415bia8wlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mLJhaO7y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mLJhaO7y"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso32990403a12.0
        for <linux-serial@vger.kernel.org>; Wed, 08 Jan 2025 05:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1736341850; x=1736946650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTD4xCu+4feI3XGCQAs3L1ZGc+rHp5IadbyQhEAC64Y=;
        b=mLJhaO7y/88FxTWfPfjy+o5IOxOBoynoKW84cK+ouwPZKTC2n8fIJeR7fC+udKdCM4
         zSegtGrFVW97TvvEVvc76euaCmWc69s2D0Oj+dq4D5a4DpXDr0xSIg5y3dzsrdulkSER
         pFzfJRGpoADvnITdAuf8zsZGJZ/kDLxk3kCE+MiHgw8Bv8iwbtHRkNtqeQaTAxH8q8rQ
         AodnM9asbO2PYcpkR6HXuzRKcv6MaJmxEIShh+4bf+aQDpgt92qZDs3UzK54sZWmfzSJ
         UDHEOVmiqjbHZtZhYGfZ8wGIiIVkfLR7Qgt9OtWU3d6GnTF0rGR4JIVFF+vnCoAlsHji
         8PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736341850; x=1736946650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTD4xCu+4feI3XGCQAs3L1ZGc+rHp5IadbyQhEAC64Y=;
        b=lXiWtAldD/4xh+0EZEcIXfgi8LyyNL60ruuLsB1smDig/QU4NMgoZC8XJR3BOh45ns
         AJINcKv85ZVzuodVxAPo44L7ZqZFZ6Nc6x6/9XrRC9S74M1I5Zl4NPfb/0BhCP3o5QDb
         say2zvoTBYNbWtrHZxEasIH2ekX3K1bPut6Aznqq4hMBoKeld/7rWOHIqI6lrbbY62bJ
         cWw4NkkBxAhv3jcyk/XvZRLv+cFkrs5vmkRdjO/r29/698HGgMzfkHnTlvfx9ytqjaC3
         k3CS3YBKPrRDsqRlBp1YIQK3MJSylEgxpdOTgKdjjC91neWEEcyoEMYLFxXOVIPv5SRU
         j1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfjQxb5kdXTV+3p+8SC59KA8YBQkw8uNL/imzeO0zv2qrG6t52+umFqkKjLwV6DiBtSoNIBNSONzsN5jE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8NopXP2NTZ3q4oYrlItkr2htJnEji0GKCTiCAOCHz4KcUQFTR
	30HNsPGpQ/pMMLsewFLtfPfRasnYI4W2FL30QrFChObrYSxzyFEOnM26TJyyNVI=
X-Gm-Gg: ASbGnctjY8iSymL6RKQxHUlujWOAuwPv0duljaHm3lQkhtomQ8eAOi3WoZEyH9qjJzi
	TJxSX+LfeFtlWFzEjdATcEEFGIseWpQP4m12y0SrhvsF15DcuBlVv1KZg5awh94S+/CZM2dd7vw
	dyziVDgie/Yc+X8rVLPQzbn6lP2MyxxBWfbOQH7J/xfY5SRPaZ3cBVqebVjD07+H8skeDqelUYP
	g4qnkn6fKtzRTdiDGP0z7Np71ZxxRZ5Kj7StJsIXqqcCThLNa3BdqEUNXMA/flwLfcIJCcyT11N
	5w==
X-Google-Smtp-Source: AGHT+IHLwNyy4A70HAWpzRTfVcvclZt7HwGR3P3PBQ5fNfIfanYr2FOL00ctrneNCFGNPtK8PpM4xA==
X-Received: by 2002:a05:6402:35d5:b0:5d1:2440:9ad3 with SMTP id 4fb4d7f45d1cf-5d972e703e5mr2225214a12.30.1736341850034;
        Wed, 08 Jan 2025 05:10:50 -0800 (PST)
Received: from fedora.. (d-zg2-023.globalnet.hr. [213.149.37.23])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d806fedaebsm26159761a12.57.2025.01.08.05.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 05:10:49 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	lars.povlsen@microchip.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	daniel.machon@microchip.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 1/3] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Wed,  8 Jan 2025 14:09:26 +0100
Message-ID: <20250108131045.40642-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the Microchip LAN969x ARMv8-based SoC switch family.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
* Rebase on top of next-20250107

Changes in v2:
* Add forgotten LAN969x architecture support itself

 arch/arm64/Kconfig.platforms | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index e2638e5118a7..cd29480be792 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -133,6 +133,20 @@ config ARCH_SPARX5
 	  security through TCAM-based frame processing using versatile
 	  content aware processor (VCAP).
 
+config ARCH_LAN969X
+	bool "Microchip LAN969X SoC family"
+	select PINCTRL
+	select DW_APB_TIMER_OF
+	help
+	  This enables support for the Microchip LAN969X ARMv8-based
+	  SoC family of TSN-capable gigabit switches.
+
+	  The LAN969X Ethernet switch family provides a rich set of
+	  switching features such as advanced TCAM-based VLAN and QoS
+	  processing enabling delivery of differentiated services, and
+	  security through TCAM-based frame processing using versatile
+	  content aware processor (VCAP).
+
 config ARCH_K3
 	bool "Texas Instruments Inc. K3 multicore SoC architecture"
 	select PM_GENERIC_DOMAINS if PM
-- 
2.47.1

