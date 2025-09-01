Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AD239E63;
	Mon,  1 Sep 2025 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706090; cv=none; b=ZgbbJJPrIfzhdiiuG8CVuThcFdH7g8uXeHSmHX2Oo9jItdVcUa7BP+EuGAblPFU/RKVgslrVu65tniw0a2Rg7dD15PsBXSKSkd2fGAoT3PEnTvhBtaUQmH0e+p29PILBNMeAnD9TzT0xaedwEhd2u0VWkVBGOfL/r14C+xhokwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706090; c=relaxed/simple;
	bh=nJ9BB9Y3VY69GTDVRQiby0kbXG7hz2ESCGjLDKAqxOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBbyOFXgPIn+hwqFmFFbzmaK2DSCZpeDH3uLiFsZ+RkXXtzA0bxYtxdr/52wjg9valut3A2SVLIdN3Q2JFJ3sn05jbA7Sy53JGwjgDLNWxy6/a8fWNpFG/F71BlC/muXiaPRYrEFydYOiUEwHAzcsxV//twBLJPQ4afHynbUXzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 6E0A110338; Mon,  1 Sep 2025 07:54:19 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH v2 4/4] tty/vt: use correct attribute mask in do_update_region
Date: Mon,  1 Sep 2025 07:26:36 +0200
Message-Id: <20250901052636.8981-5-soci@c64.rulez.org>
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

The original code assumes all bits in the attribute byte are for
attributes. If 512 glyphs are in use then one is used as the 8th bit of
the glyph. This can unnecessarily split up a region of uniform
attributes whenever that bit changes.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/tty/vt/vt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5d458211b..eb60f69f3 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -613,22 +613,23 @@ static void do_update_region(struct vc_data *vc, unsigned long start, int count)
 {
 	unsigned int xx, yy, offset;
 	u16 *p = (u16 *)start;
+	u16 mask = 0xff00 & ~vc->vc_hi_font_mask;
 
 	offset = (start - vc->vc_origin) / 2;
 	xx = offset % vc->vc_cols;
 	yy = offset / vc->vc_cols;
 
 	for(;;) {
-		u16 attrib = scr_readw(p) & 0xff00;
+		u16 attrib = scr_readw(p) & mask;
 		int startx = xx;
 		u16 *q = p;
 		while (xx < vc->vc_cols && count) {
-			if (attrib != (scr_readw(p) & 0xff00)) {
+			if (attrib != (scr_readw(p) & mask)) {
 				if (p > q)
 					vc->vc_sw->con_putcs(vc, q, p-q, yy, startx);
 				startx = xx;
 				q = p;
-				attrib = scr_readw(p) & 0xff00;
+				attrib = scr_readw(p) & mask;
 			}
 			p++;
 			xx++;
-- 
2.30.2

