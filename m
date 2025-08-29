Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CAB2566;
	Fri, 29 Aug 2025 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497335; cv=none; b=lCuPh6BKmC3z2kVydpPz8cw5KSS6wzIUuldWK2QOhw6j4EFsr9S+O/ohwIjjPQ0KP5gk6etVS5utoeiXh2hjz4qNH5iBOwrZ1Ln29bUziQdLgVjgCh/JVDkPIOmsKu/dzMIT+zrm3+r/Q+PGjxkrlugxn7KppDFuAG+ua4vbuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497335; c=relaxed/simple;
	bh=IzhJ2bnYnJTak80Dj2u9IYUqntAtJHZYpFBajvXNfRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c521vwZlqFoF776LAFgIIc4xaBqb1/sg2pyrfVGvpAe5Q0kr/10YK9uYDXQFy4Y51WBH/o5EBB8cID/yRziQ0LsDjavmVR3DYZO2846dMfZHVaX2p/gNfq6Ig2heK6UFvNlHI/UUBJl6c5Nt5Ra+KwicBevh4Om+YZIIDtYRx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 22DC41020C; Fri, 29 Aug 2025 21:55:17 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH 1/3] tty/vt: 8th bit location in vc_uniscr routines
Date: Fri, 29 Aug 2025 21:49:06 +0200
Message-Id: <20250829194908.24852-2-soci@c64.rulez.org>
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

Both vc_uniscr_check and vc_uniscr_copy_line assume that the 8th bit of
glyph is also the 8th bit in the screen buffer. However this is only the
case for fbcon at the moment. Vgacon has it on the 11th and so the
conversion won't work correctly in that case. The patch corrects this
oversight.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/tty/vt/vt.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 869261141..c6c931047 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -493,7 +493,7 @@ int vc_uniscr_check(struct vc_data *vc)
 {
 	u32 **uni_lines;
 	unsigned short *p;
-	int x, y, mask;
+	int x, y;
 
 	WARN_CONSOLE_UNLOCKED();
 
@@ -514,11 +514,14 @@ int vc_uniscr_check(struct vc_data *vc)
 	 * unicode content will be available after a complete screen refresh.
 	 */
 	p = (unsigned short *)vc->vc_origin;
-	mask = vc->vc_hi_font_mask | 0xff;
 	for (y = 0; y < vc->vc_rows; y++) {
 		u32 *line = uni_lines[y];
 		for (x = 0; x < vc->vc_cols; x++) {
-			u16 glyph = scr_readw(p++) & mask;
+			u16 w = scr_readw(p++);
+			u16 glyph = w & 0xff;
+
+			if (w & vc->vc_hi_font_mask)
+				glyph |= 0x100;
 			line[x] = inverse_translate(vc, glyph, true);
 		}
 	}
@@ -561,10 +564,13 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 		 * buffer of its own.
 		 */
 		u16 *p = (u16 *)pos;
-		int mask = vc->vc_hi_font_mask | 0xff;
 		u32 *uni_buf = dest;
 		while (nr--) {
-			u16 glyph = scr_readw(p++) & mask;
+			u16 w = scr_readw(p++);
+			u16 glyph = w & 0xff;
+
+			if (w & vc->vc_hi_font_mask)
+				glyph |= 0x100;
 			*uni_buf++ = inverse_translate(vc, glyph, true);
 		}
 	}
-- 
2.30.2

