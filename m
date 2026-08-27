Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A44B048D
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856181; cv=none; b=IACRgLnbS2dGmyEJxSaG5YNpDBLywHujCBXwvZWfOW/omyD0I6JzAwrxY7NFUFBwhZ8tyXWQ5Xyf6CAL1bBdOF3SYYaaeCdxnAHlZhauEy9buJmAEWmpU2ON43SVfPwT8DIQpsGLhf2/fIIUCX77IC7j5CgeruKPunvDDy5WNrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856181; c=relaxed/simple;
	bh=YcXHbUHpjUxvnT/0nQlTheClFqrGsI1vBpBLxrWbTto=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=kGUxXQRpzsoxiWGeyNFp7y8hot7z/4lwUPClxVyjOxZYye186APGtFJi2ycJm1nnJhUpo740++/jGol2KI3Gd8bmncbTax6EvRVG4+GFSbhnY7o9wejuorzR73awatnoskCpwjOpp1JnRLrwzMO01hFzo9yNf3APZ94JOx0W9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 13979 invoked by uid 3782); 27 Aug 2026 20:42:53 +0200
Received: from muc.de (p4fe15cdf.dip0.t-ipconnect.de [79.225.92.223]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Aug 2026 20:42:53 +0200
Received: (qmail 30964 invoked by uid 1000); 27 Aug 2026 18:42:52 -0000
Date: Thu, 27 Aug 2026 18:42:52 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
  linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: acm@muc.de
Subject: [Patch 1/9]: Make consolemap.c handle Unicode planes outside BMP
Message-ID: <apCFLI0ga-DG-HRN@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCEDM2sWv_M354-@MAC.fritz.box>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

vt: 32b glyph: 1. Make consolemap.c handle Unicode planes outside BMP

For this, add a fourth layer "planes" onto the sparse map in
this file.  Also handle glyph numbers up to 2^21 rather than
256/512.  Move the conversion between __user and kernel data
from consolemap.c to vt_ioctl.c.

Signed-off-by: Alan Mackenzie <acm@muc.de>

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 3fa89a2dbeba..2f695d97f0eb 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -34,11 +34,11 @@
 #include <linux/tty.h>
 #include <linux/uaccess.h>
 #include <linux/console.h>
-#include <linux/consolemap.h>
 #include <linux/vt_kern.h>
+#include <linux/consolemap.h>
 #include <linux/string.h>
 
-static unsigned short translations[][E_TABSZ] = {
+static u1632 translations[][E_TABSZ] = {
   /* 8-bit Latin-1 mapped to Unicode -- trivial mapping */
   [LAT1_MAP] = {
     0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007,
@@ -184,66 +184,79 @@ static unsigned short translations[][E_TABSZ] = {
 /* The standard kernel character-to-font mappings are not invertible
    -- this is just a best effort. */
 
-#define MAX_GLYPH 512		/* Max possible glyph value */
+#ifdef CONFIG_FB_GLYPH_21BIT
+#define MAX_GLYPH 0x110000
+#else
+#define MAX_GLYPH 512
+#endif
 
 static enum translation_map inv_translate[MAX_NR_CONSOLES];
 
-#define UNI_DIRS	32U
+#define UNI_PLANES	32U	/* Actually, only 17. */
+#define UNI_PLANE_DIRS	32U
 #define UNI_DIR_ROWS	32U
 #define UNI_ROW_GLYPHS	64U
 
+#define UNI_PLANE_BITS		GENMASK(20, 16)
 #define UNI_DIR_BITS		GENMASK(15, 11)
 #define UNI_ROW_BITS		GENMASK(10,  6)
 #define UNI_GLYPH_BITS		GENMASK( 5,  0)
 
+#ifdef CONFIG_FB_GLYPH_21BIT
+#define UNI_PLANE(uni)		FIELD_GET(UNI_PLANE_BITS, (uni))
+#else
+#define UNI_PLANE(uni)		0
+#endif
 #define UNI_DIR(uni)		FIELD_GET(UNI_DIR_BITS, (uni))
 #define UNI_ROW(uni)		FIELD_GET(UNI_ROW_BITS, (uni))
 #define UNI_GLYPH(uni)		FIELD_GET(UNI_GLYPH_BITS, (uni))
 
-#define UNI(dir, row, glyph)	(FIELD_PREP(UNI_DIR_BITS, (dir)) | \
+#define UNI(plane, dir, row, glyph) (FIELD_PREP(UNI_PLANE_BITS, (plane)) | \
+				 FIELD_PREP(UNI_DIR_BITS, (dir)) | \
 				 FIELD_PREP(UNI_ROW_BITS, (row)) | \
 				 FIELD_PREP(UNI_GLYPH_BITS, (glyph)))
 
 /**
  * struct uni_pagedict - unicode directory
  *
- * @uni_pgdir: 32*32*64 table with glyphs
+ * @uni_plane: 32*32*32*64 table with glyphs
+ * @count: Number of unicode entries in this structure
  * @refcount: reference count of this structure
  * @sum: checksum
  * @inverse_translations: best-effort inverse mapping
  * @inverse_trans_unicode: best-effort inverse mapping to unicode
  */
 struct uni_pagedict {
-	u16		**uni_pgdir[UNI_DIRS];
+	u1632		***uni_plane[UNI_PLANES];
+	u32		count;
 	unsigned long	refcount;
 	unsigned long	sum;
 	unsigned char	*inverse_translations[LAST_MAP + 1];
-	u16		*inverse_trans_unicode;
+	u1632		*inverse_trans_unicode;
 };
 
 static struct uni_pagedict *dflt;
 
 static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *dict,
-	       enum translation_map m)
+			       enum translation_map m)
 {
-	unsigned short *t = translations[m];
+	u1632 *t = translations[m];
 	unsigned char *inv;
 
 	if (!dict)
 		return;
 	inv = dict->inverse_translations[m];
 
-	if (!inv) {
-		inv = dict->inverse_translations[m] = kmalloc(MAX_GLYPH,
-				GFP_KERNEL);
-		if (!inv)
-			return;
-	}
-	memset(inv, 0, MAX_GLYPH);
+	kfree(inv);
+	inv = dict->inverse_translations[m] =
+		kmalloc(dict->count * (sizeof(*t)), GFP_KERNEL);
+	if (!inv)
+		return;
+	memset(inv, 0, dict->count * (sizeof(*t)));
 
 	for (unsigned int ch = 0; ch < ARRAY_SIZE(translations[m]); ch++) {
 		int glyph = conv_uni_to_pc(conp, t[ch]);
-		if (glyph >= 0 && glyph < MAX_GLYPH && inv[glyph] < 32) {
+		if (glyph >= 0 && glyph < dict->count && inv[glyph] < 32) {
 			/* prefer '-' above SHY etc. */
 			inv[glyph] = ch;
 		}
@@ -252,39 +265,48 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *dict,
 
 static void set_inverse_trans_unicode(struct uni_pagedict *dict)
 {
-	unsigned int d, r, g;
-	u16 *inv;
+	unsigned int p, d, r, g;
+	u1632 *inv;
 
 	if (!dict)
 		return;
 
 	inv = dict->inverse_trans_unicode;
-	if (!inv) {
-		inv = dict->inverse_trans_unicode = kmalloc_array(MAX_GLYPH,
-				sizeof(*inv), GFP_KERNEL);
-		if (!inv)
-			return;
-	}
-	memset(inv, 0, MAX_GLYPH * sizeof(*inv));
+	kfree(inv);
+	inv = dict->inverse_trans_unicode =
+		kmalloc_array(dict->count, sizeof(*inv), GFP_KERNEL);
+	if (!inv)
+		return;
+	memset(inv, 0, dict->count * sizeof(*inv));
 
-	for (d = 0; d < UNI_DIRS; d++) {
-		u16 **dir = dict->uni_pgdir[d];
-		if (!dir)
+	for (p = 0; p < UNI_PLANES; p++) {
+		u1632 ***plane = dict->uni_plane[p];
+
+		if (!plane)
 			continue;
-		for (r = 0; r < UNI_DIR_ROWS; r++) {
-			u16 *row = dir[r];
-			if (!row)
+		for (d = 0; d < UNI_PLANE_DIRS; d++) {
+			u1632 **dir = plane[d];
+
+			if (!dir)
 				continue;
-			for (g = 0; g < UNI_ROW_GLYPHS; g++) {
-				u16 glyph = row[g];
-				if (glyph < MAX_GLYPH && inv[glyph] < 32)
-					inv[glyph] = UNI(d, r, g);
+			for (r = 0; r < UNI_DIR_ROWS; r++) {
+				u1632 *row = dir[r];
+
+				if (!row)
+					continue;
+				for (g = 0; g < UNI_ROW_GLYPHS; g++) {
+					u1632 glyph = row[g];
+
+					if (glyph < dict->count &&
+					    inv[glyph] < 32)
+						inv[glyph] = UNI(p, d, r, g);
+				}
 			}
 		}
 	}
 }
 
-unsigned short *set_translate(enum translation_map m, struct vc_data *vc)
+u1632 *set_translate(enum translation_map m, struct vc_data *vc)
 {
 	inv_translate[vc->vc_num] = m;
 	return translations[m];
@@ -297,18 +319,19 @@ unsigned short *set_translate(enum translation_map m, struct vc_data *vc)
  *    was active.
  * Still, it is now possible to a certain extent to cut and paste non-ASCII.
  */
-u16 inverse_translate(const struct vc_data *conp, u16 glyph, bool use_unicode)
+u1632 inverse_translate(const struct vc_data *conp, u1632 glyph,
+			bool use_unicode)
 {
 	struct uni_pagedict *p;
 	enum translation_map m;
 
-	if (glyph >= MAX_GLYPH)
-		return 0;
-
 	p = *conp->uni_pagedict_loc;
 	if (!p)
 		return glyph;
 
+	if (glyph >= p->count)
+		return 0;
+
 	if (use_unicode) {
 		if (!p->inverse_trans_unicode)
 			return glyph;
@@ -371,7 +394,7 @@ int con_set_trans_old(unsigned char __user * arg)
 int con_get_trans_old(unsigned char __user * arg)
 {
 	int i, ch;
-	unsigned short *p = translations[USER_MAP];
+	u1632 *p = translations[USER_MAP];
 	unsigned char outbuf[E_TABSZ];
 
 	scoped_guard(console_lock)
@@ -410,31 +433,38 @@ int con_get_trans_new(ushort __user * arg)
 /*
  * Unicode -> current font conversion
  *
- * A font has at most 512 chars, usually 256.
+ * A font has at most 512 chars (2026-01: no longer true), usually 256.
  * But one font position may represent several Unicode chars.
  * A hashtable is somewhat of a pain to deal with, so use a
  * "paged table" instead.  Simulation has shown the memory cost of
- * this 3-level paged table scheme to be comparable to a hash table.
+ * this 4-level paged table scheme to be comparable to a hash table.
  */
 
-extern u8 dfont_unicount[];	/* Defined in console_defmap.c */
-extern u16 dfont_unitable[];
-
 static void con_release_unimap(struct uni_pagedict *dict)
 {
-	unsigned int d, r;
+	unsigned int p, d, r;
 
 	if (dict == dflt)
 		dflt = NULL;
 
-	for (d = 0; d < UNI_DIRS; d++) {
-		u16 **dir = dict->uni_pgdir[d];
-		if (dir != NULL) {
-			for (r = 0; r < UNI_DIR_ROWS; r++)
-				kfree(dir[r]);
-			kfree(dir);
+	for (p = 0; p < UNI_PLANES; p++) {
+		u1632 ***plane = dict->uni_plane[p];
+
+		if (plane != NULL) {
+			for (d = 0; d < UNI_PLANE_DIRS; d++) {
+				u1632 **dir = plane[d];
+
+				if (dir != NULL) {
+					for (r = 0; r < UNI_DIR_ROWS; r++)
+						if (dir[r] != NULL)
+							kfree(dir[r]);
+					kfree(dir);
+				}
+				plane[d] = NULL;
+			}
+			kfree(plane);
+			dict->uni_plane[p] = NULL;
 		}
-		dict->uni_pgdir[d] = NULL;
 	}
 
 	for (r = 0; r < ARRAY_SIZE(dict->inverse_translations); r++) {
@@ -464,7 +494,7 @@ void con_free_unimap(struct vc_data *vc)
 static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *dict1)
 {
 	struct uni_pagedict *dict2;
-	unsigned int cons, d, r;
+	unsigned int cons, p, d, r;
 
 	for (cons = 0; cons < MAX_NR_CONSOLES; cons++) {
 		if (!vc_cons_allocated(cons))
@@ -472,26 +502,39 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *dict1)
 		dict2 = *vc_cons[cons].d->uni_pagedict_loc;
 		if (!dict2 || dict2 == dict1 || dict2->sum != dict1->sum)
 			continue;
-		for (d = 0; d < UNI_DIRS; d++) {
-			u16 **dir1 = dict1->uni_pgdir[d];
-			u16 **dir2 = dict2->uni_pgdir[d];
-			if (!dir1 && !dir2)
+		for (p = 0; p < UNI_PLANES; p++) {
+			u1632 ***plane1 = dict1->uni_plane[p];
+			u1632 ***plane2 = dict2->uni_plane[p];
+
+			if (!plane1 && !plane2)
 				continue;
-			if (!dir1 || !dir2)
+			if (!plane1 || !plane2)
 				break;
-			for (r = 0; r < UNI_DIR_ROWS; r++) {
-				if (!dir1[r] && !dir2[r])
+			for (d = 0; d < UNI_PLANE_DIRS; d++) {
+				u1632 **dir1 = plane1[d];
+				u1632 **dir2 = plane2[d];
+
+				if (!dir1 && !dir2)
 					continue;
-				if (!dir1[r] || !dir2[r])
+				if (!dir1 || !dir2)
 					break;
-				if (memcmp(dir1[r], dir2[r], UNI_ROW_GLYPHS *
-							sizeof(*dir1[r])))
+				for (r = 0; r < UNI_DIR_ROWS; r++) {
+					if (!dir1[r] && !dir2[r])
+						continue;
+					if (!dir1[r] || !dir2[r])
+						break;
+					if (memcmp(dir1[r], dir2[r],
+						   UNI_ROW_GLYPHS *
+						   sizeof(*dir1[r])))
+						break;
+				}
+				if (r < UNI_DIR_ROWS)
 					break;
 			}
-			if (r < UNI_DIR_ROWS)
+			if (d < UNI_PLANE_DIRS)
 				break;
 		}
-		if (d == UNI_DIRS) {
+		if (p == UNI_PLANES) {
 			dict2->refcount++;
 			*conp->uni_pagedict_loc = dict2;
 			con_release_unimap(dict1);
@@ -503,15 +546,24 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *dict1)
 }
 
 static int
-con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
+con_insert_unipair(struct uni_pagedict *p, u1632 unicode, u1632 fontpos)
 {
-	u16 **dir, *row;
+	u1632 ***plane, **dir, *row;
 	unsigned int n;
 
+	n = UNI_PLANE(unicode);
+	plane = p->uni_plane[n];
+	if (!plane) {
+		plane = p->uni_plane[n] = kcalloc
+			(UNI_PLANE_DIRS, sizeof(*plane), GFP_KERNEL);
+		if (!plane)
+			return -ENOMEM;
+	}
+
 	n = UNI_DIR(unicode);
-	dir = p->uni_pgdir[n];
+	dir = plane[n];
 	if (!dir) {
-		dir = p->uni_pgdir[n] = kcalloc(UNI_DIR_ROWS, sizeof(*dir),
+		dir = plane[n] = kcalloc(UNI_DIR_ROWS, sizeof(*dir),
 				GFP_KERNEL);
 		if (!dir)
 			return -ENOMEM;
@@ -573,12 +625,12 @@ int con_clear_unimap(struct vc_data *vc)
 }
 
 static struct uni_pagedict *con_unshare_unimap(struct vc_data *vc,
-		struct uni_pagedict *old)
+					       struct uni_pagedict *old)
 {
 	struct uni_pagedict *new;
-	unsigned int d, r, g;
+	unsigned int p, d, r, g;
 	int ret;
-	u16 uni = 0;
+	u32 uni = 0;
 
 	ret = con_allocate_new(vc);
 	if (ret)
@@ -587,63 +639,70 @@ static struct uni_pagedict *con_unshare_unimap(struct vc_data *vc,
 	new = *vc->uni_pagedict_loc;
 
 	/*
-	 * uni_pgdir is a 32*32*64 table with rows allocated when its first
+	 * uni_plane is a 32*32*32*64 table with a row allocated when its first
 	 * entry is added. The unicode value must still be incremented for
 	 * empty rows. We are copying entries from "old" to "new".
 	 */
-	for (d = 0; d < UNI_DIRS; d++) {
-		u16 **dir = old->uni_pgdir[d];
-		if (!dir) {
+	for (p = 0; p < UNI_PLANES; p++) {
+		u1632 ***plane = old->uni_plane[p];
+
+		if (!plane) {
 			/* Account for empty table */
-			uni += UNI_DIR_ROWS * UNI_ROW_GLYPHS;
+			uni += UNI_PLANE_DIRS * UNI_DIR_ROWS * UNI_ROW_GLYPHS;
 			continue;
 		}
 
-		for (r = 0; r < UNI_DIR_ROWS; r++) {
-			u16 *row = dir[r];
-			if (!row) {
-				/* Account for row of 64 empty entries */
-				uni += UNI_ROW_GLYPHS;
+		for (d = 0; d < UNI_PLANE_DIRS; d++) {
+			u1632 **dir = plane[d];
+
+			if (!dir) {
+				/* Account for empty table */
+				uni += UNI_DIR_ROWS * UNI_ROW_GLYPHS;
 				continue;
 			}
 
-			for (g = 0; g < UNI_ROW_GLYPHS; g++, uni++) {
-				if (row[g] == 0xffff)
+			for (r = 0; r < UNI_DIR_ROWS; r++) {
+				u1632 *row = dir[r];
+
+				if (!row) {
+					/* Account for row of 64 empty entries */
+					uni += UNI_ROW_GLYPHS;
 					continue;
-				/*
-				 * Found one, copy entry for unicode uni with
-				 * fontpos value row[g].
-				 */
-				ret = con_insert_unipair(new, uni, row[g]);
-				if (ret) {
-					old->refcount++;
-					*vc->uni_pagedict_loc = old;
-					con_release_unimap(new);
-					kfree(new);
-					return ERR_PTR(ret);
+				}
+
+				for (g = 0; g < UNI_ROW_GLYPHS; g++, uni++) {
+					if (row[g] == ~0)
+						continue;
+					/*
+					 * Found one, copy entry for unicode
+					 * uni with fontpos value row[g].
+					 */
+					ret = con_insert_unipair(new, uni,
+								 row[g]);
+					if (ret) {
+						old->refcount++;
+						*vc->uni_pagedict_loc = old;
+						con_release_unimap(new);
+						kfree(new);
+						return ERR_PTR(ret);
+					}
 				}
 			}
 		}
 	}
-
 	return new;
 }
 
-int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
+int con_set_unimap(struct vc_data *vc, u32 ct, struct unipair8_21 *list)
 {
-	struct uni_pagedict *dict;
-	struct unipair *plist;
 	int err = 0;
+	struct uni_pagedict *dict;
+	struct unipair8_21 *plist;
 
 	if (!ct)
 		return 0;
 
-	struct unipair *unilist __free(kvfree) = vmemdup_array_user(list, ct, sizeof(*unilist));
-	if (IS_ERR(unilist))
-		return PTR_ERR(unilist);
-
 	guard(console_lock)();
-
 	/* Save original vc_unipagdir_loc in case we allocate a new one */
 	dict = *vc->uni_pagedict_loc;
 	if (!dict)
@@ -660,7 +719,9 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	/*
 	 * Insert user specified unicode pairs into new table.
 	 */
-	for (plist = unilist; ct; ct--, plist++) {
+	err = 0;
+	dict->count = ct;
+	for (plist = list; ct; ct--, plist++) {
 		int err1 = con_insert_unipair(dict, plist->unicode, plist->fontpos);
 		if (err1)
 			err = err1;
@@ -769,54 +830,69 @@ EXPORT_SYMBOL(con_copy_unimap);
  *	Read the console unicode data for this console. Called from the ioctl
  *	handlers.
  */
-int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
-		struct unipair __user *list)
+int con_get_unimap(struct vc_data *vc, u32 ct, u1632 *uct,
+		   struct unipair8_21 *list)
 {
-	ushort ect;
+	u1632 ect;
 	struct uni_pagedict *dict;
-	unsigned int d, r, g;
+	unsigned int p, d, r, g;
+	int ret = 0;
 
-	struct unipair *unilist __free(kvfree) = kvmalloc_array(ct, sizeof(*unilist), GFP_KERNEL);
-	if (!unilist)
-		return -ENOMEM;
+	scoped_guard (console_lock) {
 
-	scoped_guard(console_lock) {
 		ect = 0;
 		dict = *vc->uni_pagedict_loc;
 		if (!dict)
 			break;
 
-		for (d = 0; d < UNI_DIRS; d++) {
-			u16 **dir = dict->uni_pgdir[d];
-			if (!dir)
+		for (p = 0; p < UNI_PLANES; p++) {
+			u1632 ***plane = dict->uni_plane[p];
+
+			if (!plane)
 				continue;
 
-			for (r = 0; r < UNI_DIR_ROWS; r++) {
-				u16 *row = dir[r];
-				if (!row)
+			for (d = 0; d < UNI_PLANE_DIRS; d++) {
+				u1632 **dir = plane[d];
+
+				if (!dir)
 					continue;
 
-				for (g = 0; g < UNI_ROW_GLYPHS; g++, row++) {
-					if (*row >= MAX_GLYPH)
+				for (r = 0; r < UNI_DIR_ROWS; r++) {
+					u1632 *row = dir[r];
+
+					if (!row)
 						continue;
-					if (ect < ct) {
-						unilist[ect].unicode = UNI(d, r, g);
-						unilist[ect].fontpos = *row;
+
+					for (g = 0; g < UNI_ROW_GLYPHS; g++, row++) {
+						if (*row >= dict->count)
+							continue;
+						if (ect < ct) {
+#ifndef CONFIG_FB_GLYPH_21BIT
+							if ((p || *row > 0xffff)) {
+								ret = -EINVAL;
+								goto unlock;
+							}
+#endif
+							if (list) {
+								list[ect].unicode = UNI(p, d, r, g);
+								list[ect].fontpos = *row;
+							}
+						}
+						ect++;
 					}
-					ect++;
 				}
 			}
 		}
+#ifndef CONFIG_FB_GLYPH_21BIT
+unlock:
+#endif
 	}
-
-	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
-		return -EFAULT;
-	if (put_user(ect, uct))
-		return -EFAULT;
-	if (ect > ct)
-		return -ENOMEM;
-
-	return 0;
+	*uct = ect;
+	/* NOTE: For the correct functioning of the program setfont, it is
+	 * critical that -ENOMEM, not 0, is returned when ct is zero.  ACM,
+	 * 2025-02-12.
+	 */
+	return ret ? ret : (ect <= ct) ? 0 : -ENOMEM;
 }
 
 /*
@@ -849,26 +925,33 @@ int conv_uni_to_8bit(u32 uni)
 int conv_uni_to_pc(struct vc_data *conp, long ucs)
 {
 	struct uni_pagedict *dict;
-	u16 **dir, *row, glyph;
+	u1632 ***plane, **dir, *row, glyph;
 
-	/* Only 16-bit codes supported at this time */
-	if (ucs > 0xffff)
-		return -4;		/* Not found */
+	if (ucs >= MAX_GLYPH)
+		return -4;	/* Not found */
 	else if (ucs < 0x20)
 		return -1;		/* Not a printable character */
+	else if (ucs == 0xfeff || (ucs >= 0x200b && ucs <= 0x200f))
+		return -2;			/* Zero-width space */
 	/*
 	 * UNI_DIRECT_BASE indicates the start of the region in the User Zone
 	 * which always has a 1:1 mapping to the currently loaded font.  The
 	 * UNI_DIRECT_MASK indicates the bit span of the region.
 	 */
+#ifndef CONFIG_FB_GLYPH_21BIT
 	else if ((ucs & ~UNI_DIRECT_MASK) == UNI_DIRECT_BASE)
 		return ucs & UNI_DIRECT_MASK;
+#endif
 
 	dict = *conp->uni_pagedict_loc;
 	if (!dict)
 		return -3;
 
-	dir = dict->uni_pgdir[UNI_DIR(ucs)];
+	plane = dict->uni_plane[UNI_PLANE(ucs)];
+	if (!plane)
+		return -4;
+
+	dir = plane[UNI_DIR(ucs)];
 	if (!dir)
 		return -4;
 
@@ -897,4 +980,3 @@ console_map_init(void)
 		if (vc_cons_allocated(i) && !*vc_cons[i].d->uni_pagedict_loc)
 			con_set_default_unimap(vc_cons[i].d);
 }
-

-- 
Alan Mackenzie (Nuremberg, Germany).
