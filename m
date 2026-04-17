Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939063C3BFE;
	Fri, 17 Apr 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437637; cv=none; b=ugXDg/49Leu8PYTauxFEEPsGHGr88z+4vIGj0AdkzpxhFscDf94VtlC29pVlV1cRhyNuGhWabHYf1Gc9pUbK2/udRzU02/jJXEAFh6Nop12hkieF2jBjTJt/K68C1pBmSuLOZ0EzttywPd6DZCypwZy8H3q007KkOdDQNRG47Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437637; c=relaxed/simple;
	bh=wObiIqMcNdEQXV7Hzzt0v2+CpCLKuq8rheKiJxg2LvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOTcVIH2ZpsanN0wZl8Ip6NkiLWKARWr+FONn04t0SpoLQBd67u8fD0dk2vd7eBpgQDetFmdSnJFVkDs3OQHEKxd7HOVDUKWODF4vq+m/kzp4rpwLz+VXqyZKCxFKfbBGjrkHJu+9Qo1BLysOzNjQfJ+fuSZPn2EvhGb6Uli93U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=W/q5dedm; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="W/q5dedm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=NsW39ciRTFfIB9gxo/s0Uk0V/Zf9zf+Ew3TDN23WMC0=; b=W/q5dedmtFfnBix+1DDxdsMtIx
	XvxRnEaHuoaPpidLVlT0zbtrlv2r2iBLPQBuXU6H96Yy6L+EuEYswIINBJRaD2IbbnE8sDz6ixsAI
	9ukQHgm41VBtcgEyv9ktL9mRc4bIM2IUAphttyLRSU6f0hglBS/CEjAVvk5ZbOmLL35w=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDkZp-000000006G1-15aM;
	Fri, 17 Apr 2026 10:53:50 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Fri, 17 Apr 2026 10:53:37 -0400
Subject: [PATCH 10/10] serial: max310x: add comments for PLL limits
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-max310x-2-v1-10-b424e105ecac@dimonoff.com>
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

Add comments to help clarify the provenance of the various hardcoded values
used in computing the ref clk.

Assisted-by: Gemini:Pro
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 748306d1a9329694e90ec4f096dd00e39d457fda..9f423b3b4201d0db07bbd7b15934db36249e7620 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -585,6 +585,23 @@ static u8 max310x_pll_mult_to_id(u8 pll_mult)
 	}
 }
 
+/*
+ * From table 7 in datasheet: PLLFactor Selector Guide
+ *
+ * +-----------+----------------+-------------------+-------------------+
+ * | PLLFactor | MULTIPLICATION |      fPLLIN       |       fREF        |
+ * |  (1 & 0)  |     FACTOR     +---------+---------+---------+---------+
+ * |           |                |   MIN   |   MAX   |   MIN   |   MAX   |
+ * +-----------+----------------+---------+---------+---------+---------+
+ * |     0     |        6       |  500kHz |  800kHz |   3MHz  |  4.8MHz |
+ * +-----------+----------------+---------+---------+---------+---------+
+ * |     1     |       48       |  850kHz |  1.2MHz | 40.8MHz |  56MHz  |
+ * +-----------+----------------+---------+---------+---------+---------+
+ * |     2     |       96       |  425kHz |   1MHz  | 40.8MHz |  96MHz  |
+ * +-----------+----------------+---------+---------+---------+---------+
+ * |     3     |      144       |  390kHz |  667kHz |  56MHz  |  96MHz  |
+ * +-----------+----------------+---------+---------+---------+---------+
+ */
 static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 			       unsigned int freq, unsigned int *fref, bool xtal)
 {

-- 
2.47.3

