Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F0366541;
	Mon, 21 Sep 2026 04:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789964613; cv=none; b=N02JJkEhkDwmn7zdRpQM29csczZW233yjvxR5pltLQ+jZM753drRAXGyqxqwSJdPLJsO6emz9rSIhyhqR4L09Hv3i+LrBOl2WQtV8eN779RYd61ngFqGTJkPmAkErjkDJcIM7hCE9BUvtdkfupBlXE78tLJZT3A1vOpoxt98j5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789964613; c=relaxed/simple;
	bh=DHOOUWew6XqstWVudeHYH34B8AdGFHQzXLMLdRJhDzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GPJf5kPjy/3SxxBMvwIxgS5kilBNac45ARHgFfXntdzMzsEYR6/RqZ1Tp+YHnsd27NzTCHxabrxVCyceB9K4ufHKynTfMLRO4eEPKYT4/0CoQmJj16kasnm/9vMI/Nnu+2NVVzvbUsxr/YF9weqBODZ4Y7eYvHQOFm2uCtnHAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKiTDvXF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKiTDvXF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1488DC4AF15;
	Mon, 21 Sep 2026 04:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789964613;
	bh=DHOOUWew6XqstWVudeHYH34B8AdGFHQzXLMLdRJhDzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rKiTDvXFRXLfuvVDrn3FnKb+hYqV+OD/fAUANM6wBkL2z83o0nOg49Em5bZyuBti0
	 tjJ3zwEQEGAl7undb2nUmuZ6MNhcONTbkhCpk/f/hW6pf5cRdDV1pXoC+jjS97HZxJ
	 vhlY+VhkVue/5cDNMkZW89kRuYrlnvar2AOpVyV+tKKs9Tab70SNUhabjq/AnqE1Fe
	 VEWtethkt+8aom+QmVJ4pBc82Vdr1n9HoYtszz1iGsnTS2Nv0Ovxcuxwdu1FfpcEj9
	 H6Bp2EJWfcjjwUGCWaUdtiTt95XzXnRRkpefM7fkNLYOM/i9qldyK3klBM32hJ6b5a
	 fToxGLMlVEkqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE991C982DA;
	Mon, 21 Sep 2026 04:23:32 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Mon, 21 Sep 2026 12:23:30 +0800
Subject: [PATCH v8 11/18] gpio: pl061: use IRQ_TYPE_LEVEL_MASK and
 IRQ_TYPE_EDGE_BOTH
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-cv75-v5-v8-11-282ff5d98dda@ambarella.com>
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
In-Reply-To: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Long Zhao <longzhao@ambarella.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789964608; l=1319;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=nz51yActj1YXpv3NW2G+jZPYSgBHFOPI8W4g4YsvTL4=;
 b=uKCp/46nsRO5BF/rtCpHTEFHOuSWs4cyunvPht6xRRVU1PnHLtQLijpPhG92Ufs7PJYr/fp25
 utNTH4rmibLDMpgHGX6Xy/HeqaUQTAPelYEYno50LWM3YnnwhTz8fx5
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com

From: Long Zhao <longzhao@ambarella.com>

Use the standard IRQ_TYPE_LEVEL_MASK and IRQ_TYPE_EDGE_BOTH helpers
instead of open-coded edge and level comparisons.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 drivers/gpio/gpio-pl061.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 66aea0856bc4..2913daf46aff 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -167,9 +167,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	if (offset < 0 || offset >= PL061_GPIO_NR)
 		return -EINVAL;
 
-	if ((trigger & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) &&
-	    (trigger & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)))
-	{
+	if ((trigger & IRQ_TYPE_LEVEL_MASK) && (trigger & IRQ_TYPE_EDGE_BOTH)) {
 		dev_err(gc->parent,
 			"trying to configure line %d for both level and edge "
 			"detection, choose one!\n",
@@ -184,7 +182,7 @@ static int pl061_irq_type(struct irq_data *d, unsigned trigger)
 	regmap_read(pl061->regmap, GPIOIS, &gpiois);
 	regmap_read(pl061->regmap, GPIOIBE, &gpioibe);
 
-	if (trigger & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) {
+	if (trigger & IRQ_TYPE_LEVEL_MASK) {
 		bool polarity = trigger & IRQ_TYPE_LEVEL_HIGH;
 
 		/* Disable edge detection */

-- 
2.34.1


