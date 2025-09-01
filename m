Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308C2459E5;
	Mon,  1 Sep 2025 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706085; cv=none; b=mgLl4g1qhjVQYdh5Z9GnN9H194m9+unHbaVF2lgQG/ozNIWjtpu2fJQJZqBj0Z0C2H/W5c6R3KjmkjFRaV0/TT7tikQ19LuHNia9KIAzyErVcpvz6J57tC378QEJMNlvM1qF8V6xUHMQK/vehPogwsjZIk/6GFTpzWtEn/iTnHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706085; c=relaxed/simple;
	bh=b+JembdX+6ybMa/4m6aMkCM7bVnvXPD1p0kwJv0g+k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIARYGt5md7LTiZpFh9kW2bTJBFX8rKuIanMgVUiwmAXfmYfrkwvpADsEKB3hhKbS8mPQDEWA4bHAZaHD1vfi35QNZBz/KCtmLaWxoNzAy5u+aiJHxflxi2pd75UiZf42EY+D+aaH9OppwSVyWdOHGjVAo1KFsHJ++kAqrmgeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 6751A10336; Mon,  1 Sep 2025 07:54:19 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH v2 3/4] tty/vt: Fix unreadable kernel messages on vgacon
Date: Mon,  1 Sep 2025 07:26:35 +0200
Message-Id: <20250901052636.8981-4-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250901052636.8981-1-soci@c64.rulez.org>
References: <20250901052636.8981-1-soci@c64.rulez.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a 512 glyph font is loaded on vgacon and the bold attributes are in
effect then the kernel console output (printk) becomes unreadable. It is
because the brightness bit (used for bold) is at the same place where
the 8th bit of the glyph index is. This patch adds the missing masking
to ensure the output will be displayed using the lower half of the font.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/tty/vt/vt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 27b1afd5d..5d458211b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3361,7 +3361,8 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 				continue;
 		}
 		vc_uniscr_putc(vc, c);
-		scr_writew((vc->vc_attr << 8) + c, (unsigned short *)vc->vc_pos);
+		scr_writew(((vc->vc_attr << 8) & ~vc->vc_hi_font_mask) | c,
+			   (unsigned short *)vc->vc_pos);
 		notify_write(vc, c);
 		cnt++;
 		if (vc->state.x == vc->vc_cols - 1) {
-- 
2.30.2

