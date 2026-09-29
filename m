Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522B3D9DB6;
	Tue, 29 Sep 2026 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663704; cv=none; b=a8DgJbM+qSRTXhtmjQccBggWVjqg/EOc3TT/4CDlQSMGUKeSGh4eJZEd/Dj3g1QeywPeeF79fAd7f0ig4pY3wMiF2Y4JKIezOEhDg4RhwnfRBTAeB/vROxV8vq5mfBbk1NIojcGzeWlYMOV81dHgrmjbinVXyRfINPkAtcAiK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663704; c=relaxed/simple;
	bh=kiO3A+UCSmajWWKFQ++gIh2o5dyt/i43ij3thbn4I4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRvVYjr2qQECqMyKyU+d7V/QCU7/Qo8AMd5eUvYlHXnJf+nESumNeVtIMclaNTceCBhJdVyQzzcxK7ZvMvdXRhXiO73kX/7uKVbmeOGaqktYcLhLrXFGwLZr7IkuKo4R42b+WbjthqONqE6djDyQfeYteXYDCF2srPTIHhpQ26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw+NfNvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw+NfNvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE191F00893;
	Tue, 29 Sep 2026 06:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663703;
	bh=AqkLOG6vp6Vsh99YJdEMgsfkLHRJ2+yxOnHunFY/tzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iw+NfNvNfng8RYycBeEcqjiCQkvCeOLe+H5W5jTqtMfVpx/8AC3ZXwaKuEHko+Rbl
	 +eZGIwiw+YuXBxHjwgCCfRSyUkh0yifA794BkxAj6XF6FEQei+kebchAauNGyqg8N5
	 65MtUbVO/LLBm/GlnM3rsyFWrOo6M/Mr9w7jIcMah7kcAxea9QFa90dAmWx+UVTG4t
	 ysqrbFmadMlHUDWm/uhjlzjl8/uFUXyT1bd3t5NdVye9esKVdA8x75WGB/IFyUTETS
	 gTTC4I8QDdGBOfINagsOgi3Dc1lRZYeKYsKcLcFaczuM97gVDdoyCBW+yazmXQ0s1F
	 3YkDLa7fmTuvQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/20] arm64: kconfig: let ARCH_BERLIN cover Synaptics arm64 SoCs
Date: Tue, 29 Sep 2026 14:14:04 +0800
Message-ID: <20260929061417.20733-8-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260929061417.20733-1-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend ARCH_BERLIN to cover Synaptics arm64 SoCs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/Kconfig.platforms | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d2acfac73003..1c0747555a57 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -108,13 +108,13 @@ config ARCH_BRCMSTB
 endif
 
 config ARCH_BERLIN
-	bool "Marvell Berlin SoC Family"
+	bool "Synaptics/Marvell Berlin SoC Family"
 	select DW_APB_ICTL
 	select DW_APB_TIMER_OF
 	select GPIOLIB
 	select PINCTRL
 	help
-	  This enables support for Marvell Berlin SoC Family
+	  This enables support for Synaptics SoCs or Marvell Berlin SoC Family
 
 config ARCH_BITMAIN
 	bool "Bitmain SoC Platforms"
-- 
2.53.0

