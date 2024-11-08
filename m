Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9CA1EF0A7
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074341; cv=none; b=sJkip0A8eHYVw3ScDV+hWV6h7Lsfnz8BDeTnb5EIWP2HP24u8UVaBjAbxIuSCjlg/eYRtWfNfEw7DhhvVzH1ykVOc/gobfUNfnA4IvHVG+RmA4puKYOgSxlRv6pOO9NaUPt3XNzSHat6u3V+xMkggXVHknoTSxADI8l3MLSBioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074341; c=relaxed/simple;
	bh=VJCrnUUdGei/ZnbWKo/IVdIKLNCrBMpKE8oFEy+MEtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NoTn5qg0K2aQYbNxGCdFGCuyDEDm4b8YvbxkERK9k6cbFdhmvCLMB/LFAHLF1/udTE7CPkoIHoGTAH5DzV82I/ODh5kQl3gsKVG9xWjOwmaSTqTFtpK20OvRWBy6wGxCfjOFdbKvQPvM0zLkBDSK+JEXB07D8UnPyqneWFXWg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=aokS2xF1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="aokS2xF1"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so1494576f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731074338; x=1731679138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19nNoiZMI2JgXeIpnibERXoHDynmYT61X0LDoD+6J9c=;
        b=aokS2xF1F/Mi5SLlcydh7o8RUauswrA9c52O8DFGYKy7+g+Iow8tk4b5eVMWD+Ne6K
         tVk9aXOsXEm3WV+P1hmFDgHv55o6vihvNfhJHIDGo704McJL9Uh2U35A2OYBf/ii9kAA
         GTllmrCgc2sg1Y0Iq7Q0BNypXNe1XfCWMGEDGQWM3gLgr7/EzBExuMnluUYSw+/6YgYA
         fI+VMnJU19ZWlSZ8ftsLX04ig8BPK/uUrQQ3NEEE9aihwah9X2JyE4qkCwxO5psYy5Er
         /8fSSjGlIrggx+QF80+Xk1SnynWjnTYYlfZXYUx48P54PDbgsGiF3WAdDTTNqsf9TXf7
         sjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731074338; x=1731679138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19nNoiZMI2JgXeIpnibERXoHDynmYT61X0LDoD+6J9c=;
        b=DDXrvTqDPLIsD+jKt5qGDb1keQcXLyA6sppPWwl0mVYScYpIhJvR3TbFl1a6GpUyUc
         /Y/Qi6EtKSZskmn5UwS0MGs6grSncKV6I7UuBIhvBxRZG1IDzGkHSFhP5D7TahACJBdy
         lYH8VNxx2jDmTYPmz+bu/XaC/Nh6rBR2SK7XpINUlL+tfj/ZQWYiVEuDOhi0zUejQ/JG
         XrNVAitPMihSfy3f5+L4i40VgsoJYPs0QUOrsaD0Q95/ifJ69SRlBYa32TicehG4elVV
         L9rqcZ4ogANeYEc8GSIFhnb7jXWTBwcI0G0tNz7VqYKxGwt2xBWJQk5Iia3o7yiTqe10
         O5lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3OQGcjk7df8AL5BspNu6EWqGlsFV/nJMCprszBL3mEbw+Ma1xu6kD7Jgf/UxbaUNqteWREe7cJmOsmw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9lj33RCj45nHLMZxJiYomDXtxvrVoZVhdngVsW9Qj+0j/mh5
	T7PTIwXwRPVRrP2zzl4ApMtZjDQq0IxTxKmhSO5p1Jrs4v2zKsMkcuMK2X9rcwA=
X-Google-Smtp-Source: AGHT+IHddZyZHnBvXvpwpiOFOpBw0pB+ps3Rxlk3QlAmQ6sdQYs/NNEYqY/D3vFEUDZaWTay7pUGFA==
X-Received: by 2002:a05:6000:401f:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-381f182fc02mr2476225f8f.45.1731074338350;
        Fri, 08 Nov 2024 05:58:58 -0800 (PST)
Received: from fedora.. (cpe-188-129-46-99.dynamic.amis.hr. [188.129.46.99])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed97cd97sm4924431f8f.27.2024.11.08.05.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:58:57 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/4] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Fri,  8 Nov 2024 14:57:31 +0100
Message-ID: <20241108135855.129116-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.0
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
Changes in v2:
* Add forgotten LAN969x architecture support itself

 arch/arm64/Kconfig.platforms | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6c6d11536b42..4650ad3674aa 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -128,6 +128,20 @@ config ARCH_SPARX5
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
2.47.0

