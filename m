Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795741A4F8;
	Fri,  4 Sep 2026 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503954; cv=none; b=L5+iOLSoqZtWRKQMFQqhxJ1/NR53zvFHzZ8/sFa71HvmETGuxj0JxDI0aBTaPqM6R6v3Kxwy689MK15sIh7uXLN7sU1+0haAZntDpZP1tWY0HsMs+2dOdBzARfYdvKfyKA/QArn77ZPbz3izWqqzJO5thg4B4gHOmUqm1PElYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503954; c=relaxed/simple;
	bh=QVo13gwqTD4KZzt9imrEAhoQPNNjElG0xmVDlRWUyNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAqtJDYaFpJn6hIIzRv2kuAbNW81q6v4GQaK4xaOaGeOojSR2nWwLEIVbBMZOOmIJNuEWH5zgxoYkXrPvzOXYW94yzHa8vb3+D6Ab6ze5wV9V4flL+CyLuuOFtARNnk6VCpGOfuRQqoB+hM/N5XQZNkTMP/LGmD6a/iSmpae+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G992KqID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G992KqID"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4D26C2BCFF;
	Fri,  4 Sep 2026 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788503953;
	bh=QVo13gwqTD4KZzt9imrEAhoQPNNjElG0xmVDlRWUyNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G992KqID7ViHJDqHPpmDi8wbGTaEghik1XU/Wo1YDkCHDvcwnAWFjIv+HmfbMLUQh
	 tg/SIX5IBJJKgfnh3+3jN59m6vGs1urtHhokZ/fSLMnyb4Al8fZFIJu6ykfRGkcfoM
	 G/6X6iEmak9aQtwKW7nBs5m2esuikdz2JLNa9urvP4d7uSvZW/+ConO7K0LF1uFfKm
	 ZidMEIdczAk1uuhzR+Ziuvj9vEdeiNzf7/QpybsToB81gt3UgC+0Wum7DwrmySv3By
	 ZHU0NBvOpAfw5AmbYLlYDHsR8iIQPtC0FSuPSyZC0Wmgo4YlNWh+lL5gYrvpyr7S4i
	 FB+AQNaPoAQGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6175C79F83;
	Fri,  4 Sep 2026 06:39:13 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Fri, 04 Sep 2026 14:38:09 +0800
Subject: [PATCH v6 02/13] dt-bindings: mfd: syscon: add Ambarella CV75
 secure scratchpad
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-cv75-v5-v6-2-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
In-Reply-To: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Long Zhao <zl020895@163.com>, Lee Jones <lee@kernel.org>, 
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788503951; l=864;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=UZUyXXBBt/U6PUqQu+CGVwiN2KK9z5EYeOVD1g3SxZg=;
 b=CwSlga0ruE0ibNmpezfeIz539kTYoK34X+29YUwGVEo6zU4HI3MTunq5Ln7NuQyWCzNCCviYR
 hqw2hJVwMFCDwN7qMQAtZgvZRzmyFdfxjcD/vZIc2q1nI8OWH7EWbJ1
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Allow ambarella,cv75-sec-scratchpad as a syscon for the shared secure
scratchpad registers on CV75.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index fe882d3f828b..9ebf702c06f1 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -32,6 +32,7 @@ properties:
               - allwinner,sun50i-a64-system-controller
               - altr,l3regs
               - altr,sdr-ctl
+              - ambarella,cv75-sec-scratchpad
               - amd,pensando-elba-syscon
               - amlogic,meson-mx-assist
               - amlogic,meson-mx-bootrom

-- 
2.34.1


