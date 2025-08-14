Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2072798E1;
	Thu, 14 Aug 2025 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156321; cv=none; b=FlmYv3LtqgvTMGKOjAiOP55tc61N6EOch93ntBHHOL5NisDWvLBd3vtgwp6OK8ABlUcmwxN4MNLVQRFtdddnCgC/nSLMqQdtwcKgqezQi9WXzZItissI/TbHxjSp9jq2vTi0qKpO7tYGcghWwZtDvmJ8E+Cba6eBtjsQzULK6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156321; c=relaxed/simple;
	bh=ikP8D9+lVXMFYOcdbTvUdAH0C7+FbtOqJ0QHfm3h56s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFw2+nb9+996aSZ7ObZbtEGkZrt3ny5iT6qAYdAeb9lQd+4KcXxiPxOjrBjAMRVWJvjgSWXvG5gLEl2+kgVF+cZNpmq6y8NBLNOdVjinHD2Nu/uOkT96UvKnt/FbeK7KrrxjF+mGztTohvqAqZmnAQSgRBg/AUi/dKDXt3N2hZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx+X+Zco; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx+X+Zco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD36C4CEF4;
	Thu, 14 Aug 2025 07:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156320;
	bh=ikP8D9+lVXMFYOcdbTvUdAH0C7+FbtOqJ0QHfm3h56s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lx+X+ZcoYMK4SRF+LjGdMB2nmlbx0kSbYgyVH4F+b/iC/ThhKYft87mpMZFg+SY5d
	 3kh3HNA9eEkARzCA+lYhFwTRZ0oDRXEnJidte6LAIo+AMsIAqpVe5nm0VcNPBMDpbG
	 VtRS5crBZYc3+JhDyb7QhPL6AE7/kJmRrFhaydSOGqfSfoV9zFVYYw3QiE0C6gIE4T
	 P1XMIdkjDIfsGQbrTJg51rKHdANqyhPMG85CTBah7Xd8zJ6N0k38oZla5gVeAwvjKt
	 AQUCKwvDearKpyH4DEQlY6OysbzhUlL8GxZmmAPS81Jzgb6WV7HkhoIMfBEQCMgIRB
	 v6LhTFExkZYWw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 14/16] tty/vt: use guard()s in con_font_set/get() and con_{set,get}_unimap()
Date: Thu, 14 Aug 2025 09:24:54 +0200
Message-ID: <20250814072456.182853-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having all the new guards, use them in the 8250_rsa code. This improves
readability, makes error handling easier, and marks locked portions of
code explicit.

The new __free()-annotated declarations are moved to the allocation points
as is preferred:
https://lore.kernel.org/all/CAHk-=wjvh_LUpa=864joG2JJXs3+viO-kLzLidR2JLyMr4MNwA@mail.gmail.com/

Except font_data in con_font_get(). The scope in there would not match
the expected lifetime. But the declaration is moved closer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/consolemap.c | 84 ++++++++++++++++------------------
 drivers/tty/vt/vt.c         | 89 +++++++++++++++++--------------------
 2 files changed, 78 insertions(+), 95 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index bb4bb272ebec..8eb9d745a868 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -637,32 +637,28 @@ static struct uni_pagedict *con_unshare_unimap(struct vc_data *vc,
 
 int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 {
-	int err = 0, err1;
 	struct uni_pagedict *dict;
-	struct unipair *unilist, *plist;
+	struct unipair *plist;
+	int err = 0;
 
 	if (!ct)
 		return 0;
 
-	unilist = vmemdup_array_user(list, ct, sizeof(*unilist));
+	struct unipair *unilist __free(kvfree) = vmemdup_array_user(list, ct, sizeof(*unilist));
 	if (IS_ERR(unilist))
 		return PTR_ERR(unilist);
 
-	console_lock();
+	guard(console_lock)();
 
 	/* Save original vc_unipagdir_loc in case we allocate a new one */
 	dict = *vc->uni_pagedict_loc;
-	if (!dict) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
+	if (!dict)
+		return -EINVAL;
 
 	if (dict->refcount > 1) {
 		dict = con_unshare_unimap(vc, dict);
-		if (IS_ERR(dict)) {
-			err = PTR_ERR(dict);
-			goto out_unlock;
-		}
+		if (IS_ERR(dict))
+			return PTR_ERR(dict);
 	} else if (dict == dflt) {
 		dflt = NULL;
 	}
@@ -671,7 +667,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	 * Insert user specified unicode pairs into new table.
 	 */
 	for (plist = unilist; ct; ct--, plist++) {
-		err1 = con_insert_unipair(dict, plist->unicode, plist->fontpos);
+		int err1 = con_insert_unipair(dict, plist->unicode, plist->fontpos);
 		if (err1)
 			err = err1;
 	}
@@ -680,15 +676,12 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	 * Merge with fontmaps of any other virtual consoles.
 	 */
 	if (con_unify_unimap(vc, dict))
-		goto out_unlock;
+		return err;
 
 	for (enum translation_map m = FIRST_MAP; m <= LAST_MAP; m++)
 		set_inverse_transl(vc, dict, m);
 	set_inverse_trans_unicode(dict);
 
-out_unlock:
-	console_unlock();
-	kvfree(unilist);
 	return err;
 }
 
@@ -787,50 +780,49 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
 {
 	ushort ect;
 	struct uni_pagedict *dict;
-	struct unipair *unilist;
 	unsigned int d, r, g;
-	int ret = 0;
 
-	unilist = kvmalloc_array(ct, sizeof(*unilist), GFP_KERNEL);
+	struct unipair *unilist __free(kvfree) = kvmalloc_array(ct, sizeof(*unilist), GFP_KERNEL);
 	if (!unilist)
 		return -ENOMEM;
 
-	console_lock();
-
-	ect = 0;
-	dict = *vc->uni_pagedict_loc;
-	if (!dict)
-		goto unlock;
-
-	for (d = 0; d < UNI_DIRS; d++) {
-		u16 **dir = dict->uni_pgdir[d];
-		if (!dir)
-			continue;
+	scoped_guard(console_lock) {
+		ect = 0;
+		dict = *vc->uni_pagedict_loc;
+		if (!dict)
+			break;
 
-		for (r = 0; r < UNI_DIR_ROWS; r++) {
-			u16 *row = dir[r];
-			if (!row)
+		for (d = 0; d < UNI_DIRS; d++) {
+			u16 **dir = dict->uni_pgdir[d];
+			if (!dir)
 				continue;
 
-			for (g = 0; g < UNI_ROW_GLYPHS; g++, row++) {
-				if (*row >= MAX_GLYPH)
+			for (r = 0; r < UNI_DIR_ROWS; r++) {
+				u16 *row = dir[r];
+				if (!row)
 					continue;
-				if (ect < ct) {
-					unilist[ect].unicode = UNI(d, r, g);
-					unilist[ect].fontpos = *row;
+
+				for (g = 0; g < UNI_ROW_GLYPHS; g++, row++) {
+					if (*row >= MAX_GLYPH)
+						continue;
+					if (ect < ct) {
+						unilist[ect].unicode = UNI(d, r, g);
+						unilist[ect].fontpos = *row;
+					}
+					ect++;
 				}
-				ect++;
 			}
 		}
 	}
-unlock:
-	console_unlock();
+
 	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
-		ret = -EFAULT;
+		return -EFAULT;
 	if (put_user(ect, uct))
-		ret = -EFAULT;
-	kvfree(unilist);
-	return ret ? ret : (ect <= ct) ? 0 : -ENOMEM;
+		return -EFAULT;
+	if (ect > ct)
+		return -ENOMEM;
+
+	return 0;
 }
 
 /*
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 62049ceb34de..100d6cb26887 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4801,57 +4801,51 @@ void reset_palette(struct vc_data *vc)
 static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 {
 	struct console_font font;
-	int rc = -EINVAL;
 	int c;
 	unsigned int vpitch = op->op == KD_FONT_OP_GET_TALL ? op->height : 32;
 
 	if (vpitch > max_font_height)
 		return -EINVAL;
 
+	void *font_data __free(kvfree) = NULL;
 	if (op->data) {
-		font.data = kvzalloc(max_font_size, GFP_KERNEL);
+		font.data = font_data = kvzalloc(max_font_size, GFP_KERNEL);
 		if (!font.data)
 			return -ENOMEM;
 	} else
 		font.data = NULL;
 
-	console_lock();
-	if (vc->vc_mode != KD_TEXT)
-		rc = -EINVAL;
-	else if (vc->vc_sw->con_font_get)
-		rc = vc->vc_sw->con_font_get(vc, &font, vpitch);
-	else
-		rc = -ENOSYS;
-	console_unlock();
+	scoped_guard(console_lock) {
+		if (vc->vc_mode != KD_TEXT)
+			return -EINVAL;
+		if (!vc->vc_sw->con_font_get)
+			return -ENOSYS;
 
-	if (rc)
-		goto out;
+		int ret = vc->vc_sw->con_font_get(vc, &font, vpitch);
+		if (ret)
+			return ret;
+	}
 
 	c = (font.width+7)/8 * vpitch * font.charcount;
 
 	if (op->data && font.charcount > op->charcount)
-		rc = -ENOSPC;
+		return -ENOSPC;
 	if (font.width > op->width || font.height > op->height)
-		rc = -ENOSPC;
-	if (rc)
-		goto out;
+		return -ENOSPC;
 
 	op->height = font.height;
 	op->width = font.width;
 	op->charcount = font.charcount;
 
 	if (op->data && copy_to_user(op->data, font.data, c))
-		rc = -EFAULT;
+		return -EFAULT;
 
-out:
-	kvfree(font.data);
-	return rc;
+	return 0;
 }
 
 static int con_font_set(struct vc_data *vc, const struct console_font_op *op)
 {
 	struct console_font font;
-	int rc = -EINVAL;
 	int size;
 	unsigned int vpitch = op->op == KD_FONT_OP_SET_TALL ? op->height : 32;
 
@@ -4870,7 +4864,7 @@ static int con_font_set(struct vc_data *vc, const struct console_font_op *op)
 	if (size > max_font_size)
 		return -ENOSPC;
 
-	font.data = memdup_user(op->data, size);
+	void *font_data __free(kfree) = font.data = memdup_user(op->data, size);
 	if (IS_ERR(font.data))
 		return PTR_ERR(font.data);
 
@@ -4878,18 +4872,17 @@ static int con_font_set(struct vc_data *vc, const struct console_font_op *op)
 	font.width = op->width;
 	font.height = op->height;
 
-	console_lock();
+	guard(console_lock)();
+
 	if (vc->vc_mode != KD_TEXT)
-		rc = -EINVAL;
-	else if (vc->vc_sw->con_font_set) {
-		if (vc_is_sel(vc))
-			clear_selection();
-		rc = vc->vc_sw->con_font_set(vc, &font, vpitch, op->flags);
-	} else
-		rc = -ENOSYS;
-	console_unlock();
-	kfree(font.data);
-	return rc;
+		return -EINVAL;
+	if (!vc->vc_sw->con_font_set)
+		return -ENOSYS;
+
+	if (vc_is_sel(vc))
+		clear_selection();
+
+	return vc->vc_sw->con_font_set(vc, &font, vpitch, op->flags);
 }
 
 static int con_font_default(struct vc_data *vc, struct console_font_op *op)
@@ -4897,8 +4890,6 @@ static int con_font_default(struct vc_data *vc, struct console_font_op *op)
 	struct console_font font = {.width = op->width, .height = op->height};
 	char name[MAX_FONT_NAME];
 	char *s = name;
-	int rc;
-
 
 	if (!op->data)
 		s = NULL;
@@ -4907,23 +4898,23 @@ static int con_font_default(struct vc_data *vc, struct console_font_op *op)
 	else
 		name[MAX_FONT_NAME - 1] = 0;
 
-	console_lock();
-	if (vc->vc_mode != KD_TEXT) {
-		console_unlock();
-		return -EINVAL;
-	}
-	if (vc->vc_sw->con_font_default) {
+	scoped_guard(console_lock) {
+		if (vc->vc_mode != KD_TEXT)
+			return -EINVAL;
+		if (!vc->vc_sw->con_font_default)
+			return -ENOSYS;
+
 		if (vc_is_sel(vc))
 			clear_selection();
-		rc = vc->vc_sw->con_font_default(vc, &font, s);
-	} else
-		rc = -ENOSYS;
-	console_unlock();
-	if (!rc) {
-		op->width = font.width;
-		op->height = font.height;
+		int ret = vc->vc_sw->con_font_default(vc, &font, s);
+		if (ret)
+			return ret;
 	}
-	return rc;
+
+	op->width = font.width;
+	op->height = font.height;
+
+	return 0;
 }
 
 int con_font_op(struct vc_data *vc, struct console_font_op *op)
-- 
2.50.1

