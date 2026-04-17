Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A11343D64;
	Fri, 17 Apr 2026 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437635; cv=none; b=JIvQyZK/cHOidjPQ5tlxfNF9Z2za/te3Wkghlad8iBy1e28JXr4LCjW1mLUdJXeksnqRfRxXvii1d/nbtgMaJoTuO68lJayyJvy+duXOhN21LPI1UqtpqFGoGrDGdAK3gtQdKSKQ6U+k+oykVD50Q5yA+LZbwqmE/TcPRPMUeqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437635; c=relaxed/simple;
	bh=fJGl8rTHcD0lYeArsdepEP62C/lB3VZQGfCqwCoSL2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoMtmLBe5Zr/W7PCw48A4BaJ4ifNieAhGTkXNZ55KZG6kzjS98m4e76R0O0gR7x0ssreYvIqwtoA1LAg2HugJ+H3aw658B7sza+LsNB9p6FvxaDifMm3HZEHd1yARu5LhYLGJ2VSTo2Sr0VYd4nfIZ++u6RjqFZNkK9f4sPlUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=L4OWErt2; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="L4OWErt2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=LLJbvgMZ7HRJjKFqcc755Hb791ZghHSrxSCXtUi5C+I=; b=L4OWErt23Uwrr2RANq+R0dYqdN
	H74WB8Hgndc8MaHtwfRVB96HNZYQ0sKYgxs4sKVby4O8PH3czs3AN/hCCeCo3KWUhLBX8a9BsvYC1
	LEacCVXxGzkLcWUXGwtHalLFPtlokhOrIQS9D8NfWOy1YHcPsE+Vm8qo98Gll1rJ9JoE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDkZn-000000006G1-1RYn;
	Fri, 17 Apr 2026 10:53:47 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Fri, 17 Apr 2026 10:53:34 -0400
Subject: [PATCH 07/10] serial: max310x: use FIELD_PREP macro to set PLL
 bitfields
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-max310x-2-v1-7-b424e105ecac@dimonoff.com>
References: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
In-Reply-To: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Use FIELD_PREP macros to improve code readability.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 7ab5e4bd87ee6c87dd211bc52a3a4eb169a2b202..b4449b68cfeee07d1d6d3206cf58f72fac00044e 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -9,6 +9,7 @@
  *  Based on max3107.c, by Aavamobile
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -621,7 +622,9 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 		u8 pll_id = max310x_pll_mult_to_id(cfg.pll_mult);
 
 		clksrc |= MAX310X_CLKSRC_PLL_BIT;
-		regmap_write(s->regmap, MAX310X_PLLCFG_REG, (pll_id << 6) | cfg.prediv);
+		val = FIELD_PREP(MAX310X_PLLCFG_PLLFACTOR_MASK, pll_id) |
+			FIELD_PREP(MAX310X_PLLCFG_PREDIV_MASK, cfg.prediv);
+		regmap_write(s->regmap, MAX310X_PLLCFG_REG, val);
 	} else
 		clksrc |= MAX310X_CLKSRC_PLLBYP_BIT;
 

-- 
2.47.3

