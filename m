Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D157442C;
	Mon,  1 Sep 2025 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706081; cv=none; b=SW/AKKlUWclsfP9rdGOBPexp/2NoDDR/iwmQrtaBwPT90Swz3LHVrBHWy2Ov88TbvWvrMt51thdjZNMdNEj3llpwJbUcEsmoKOFBz4bAUCLPM22A3ymdOpwBPH0XQZhzs9k6HiPqkD4TFgPNBF9spHtXCPKxoZBSuUlhT04507s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706081; c=relaxed/simple;
	bh=13uYvtYgIMVg7BkAxvNbTfqzRDSjeTXqFy5aviaKgsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCsLmUtBsC3qdmIa2pOSRAiRgzspg5DERYoN5g2zwXtaogBKVNygSKDZmBbQdTiaI2vq29n0Q0zuJmimlzhmCt3oVcOQssGI0FUy8iXnv8PRSzZTI04qyDhIboT8vPuWsAQKhBH6hp93IGWQX/1+QztFNvVfrkQ+XAMtXVAbU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 63B1210303; Mon,  1 Sep 2025 07:54:19 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH v2 2/4] tty/vt: Prevent 8th bit corruption with soft cursor
Date: Mon,  1 Sep 2025 07:26:34 +0200
Message-Id: <20250901052636.8981-3-soci@c64.rulez.org>
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

The attributes of the soft cursor are configurable and one would rightly
expect that only the attributes are to be affected. But that's not
guaranteed for a font with 512 glyphs as the 8th bit is in the attribute
byte. This patch makes sure that really only the attribute bits are
changed by the cursor and not the glyph's appearance.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/tty/vt/vt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 19ce9c426..27b1afd5d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -828,6 +828,7 @@ static void add_softcursor(struct vc_data *vc)
 {
 	int i = scr_readw((u16 *) vc->vc_pos);
 	u32 type = vc->vc_cursor_type;
+	u16 mask = vc->vc_hi_font_mask | 0xff;
 
 	if (!(type & CUR_SW))
 		return;
@@ -841,6 +842,7 @@ static void add_softcursor(struct vc_data *vc)
 		i ^= CUR_BG;
 	if ((type & CUR_INVERT_FG_BG) && (i & CUR_FG) == ((i & CUR_BG) >> 4))
 		i ^= CUR_FG;
+	i = (i & ~mask) | (softcursor_original & mask);
 	scr_writew(i, (u16 *)vc->vc_pos);
 	if (con_should_update(vc))
 		con_putc(vc, i, vc->state.y, vc->state.x);
-- 
2.30.2

