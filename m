Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2549A2472A8;
	Fri, 29 Aug 2025 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497340; cv=none; b=rUPLbId0FEu/ahR5TzGJRNDqX5o6xHdAPix7u8B0V+/8GQQNqFBU2o995h9bwNtiQSOC07gKXefvE7Pef8A3PaClq3YrW9TVjdkS08EUb4HUK3mVlO1Q6FOt+hEt+U8jj6kt18OWOFWZK7S6Z182u/T1ABkBKbWvlnuDy64RvBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497340; c=relaxed/simple;
	bh=FJnhZmyi28u4LPz67qn3XDOHTDyYRFItIU79kz25L0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=skzHFeyxTDS2+VR37bmD2TdMZs/K2njioZdS1dheRtAsQnsH/4ZB8TWHdvI1MxkTmmNMrnhdLB5ipBILxF6uzWup1ih72tpxIrs2sQvfd5g9J6BJh/ZzUblftEHJm3qxilIIYwqrzk+2Aqgp5lN6/miMNniotr6dqTeCzwyQEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 267FD10338; Fri, 29 Aug 2025 21:55:17 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH 2/3] tty/vt: Prevent 8th bit corruption with soft cursor
Date: Fri, 29 Aug 2025 21:49:07 +0200
Message-Id: <20250829194908.24852-3-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250829194908.24852-1-soci@c64.rulez.org>
References: <20250829194908.24852-1-soci@c64.rulez.org>
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
index c6c931047..d54f4d24e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -823,6 +823,7 @@ static void add_softcursor(struct vc_data *vc)
 {
 	int i = scr_readw((u16 *) vc->vc_pos);
 	u32 type = vc->vc_cursor_type;
+	int mask = vc->vc_hi_font_mask | 0xff;
 
 	if (!(type & CUR_SW))
 		return;
@@ -836,6 +837,7 @@ static void add_softcursor(struct vc_data *vc)
 		i ^= CUR_BG;
 	if ((type & CUR_INVERT_FG_BG) && (i & CUR_FG) == ((i & CUR_BG) >> 4))
 		i ^= CUR_FG;
+	i = (i & ~mask) | (softcursor_original & mask);
 	scr_writew(i, (u16 *)vc->vc_pos);
 	if (con_should_update(vc))
 		con_putc(vc, i, vc->state.y, vc->state.x);
-- 
2.30.2

