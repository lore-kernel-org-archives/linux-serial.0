Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761895;
	b=s0ZwZ4Y4fGgvCxa7R131R2GXx7HGdNmVQuaxAq7ivVKbiu5PB7df8ufIqjKv/pCntAFX
	 myLKuuL6M1KfsYtQKV0Peh7CYEeOQeyQbtq9+8LfhZksHOgzBy6nNvoK6FFyzeG4NvwEK
	 6M2o7vzAN1m8FBera9HNCK7M+5ZUkKq8nz8ijFhVWTmnx0682s6oUfqdm556SxJHzg3+x
	 D5yYiJyc34aRnEjQyVJEOQrF/zeMeIzd7B06cwwC2MoyFZbyKtBmZlCwXrEGjyjhKv9mW
	 n8/5iAhlfJuTKnlsodErwN1ux/+z0bLlTKpKJgR8Coqoj+M+lUdWYiwiYssuTFu6shw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761895;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:
	 X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=JFTfF/+dKodAINkeqFDJ9gdDQsEU1yKigXEy0qcWv7k=;
	b=IqFkjUSCvvpRqOcjFwbTDIaMkn5kDQ+s2+Ufnj/sBnDJ9sefXW6375xrmP3oY/g3IoXH
	 UNelF6B6EAOYOkFSbsg0DZ3f+ehHcpsJBFeVga3p1IYrxh4c8k4Y7S8N5jRIhcop/55VB
	 EZ2pK8sG1pf9gxj3+vWZO6k0f2REK+4iFKSvPvkRS8mgBd+d2Tru21p38HZMf7dmuda8V
	 PWAOTypjinnxz8iBXGQCKZpUcDxtCuGin9mp+fzr4nsdmGbH4WIiegyIVDhQb+1Jsnczz
	 NevixY4+Y97juO1V84osJTuLnK9Nq3q5Iv9esd/+DeqTqmF7uUQYEbRIaicE0wgPp/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A11606A324;
	Fri, 23 Oct 2026 13:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9A11606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3BDA2220A6;
	Fri, 23 Oct 2026 13:24:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFED7134E6;
	Fri, 23 Oct 2026 13:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kolmHiNg22qfRQAAD6G6ig:T4
	(envelope-from <tzimmermann@suse.de>); Fri, 23 Oct 2026 13:24:52 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	deller@gmx.de,
	James.Bottomley@HansenPartnership.com,
	simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 3/7] fbcon: Implement struct consw.con_unblank
Date: Fri, 23 Oct 2026 15:16:13 +0200
Message-ID: <20261023132448.115747-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023132448.115747-1-tzimmermann@suse.de>
References: <20261023132448.115747-1-tzimmermann@suse.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 3BDA2220A6
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

Implement con_unblank from struct consw with the !blank branches from
fbcon_blank(). The new function is called fbcon_unblank(). Remove the
duplicated code from fbcon_blank().

Fbcon tracks fbdev blank state in par->blank_state using fbdev's FB_BLANK
constants. In fbcon_unblank() the stored value is always FB_BLANK_UNBLANK.
In fbcon_blank(), the new blank state is 1 + plus the VESA blank mode
given in the parameter blank.

fbcon_blank() now disables the cursor worker unconditionally.

v3:
- take mode_switch from parameter

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c | 55 ++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index d97d94bb8e99..f6139e3c26a2 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2270,32 +2270,52 @@ static bool fbcon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_par *par = info->fbcon_par;
 
-	if (mode_switch) {
-		struct fb_var_screeninfo var = info->var;
+	if (mode_switch)
+		par->graphics = true;
 
-		par->graphics = 1;
+	if (fbcon_is_active(vc, info)) {
+		int blank_state = 1 + blank; /* convert VESA to FB_BLANK constant */
 
-		if (!blank) {
-			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE |
-				FB_ACTIVATE_KD_TEXT;
-			fb_set_var(info, &var);
-			par->graphics = 0;
-			par->var = info->var;
+		if (par->blank_state != blank_state) {
+			par->blank_state = blank_state;
+			fbcon_cursor(vc, false);
+			par->cursor_flash = false;
+
+			if (fb_blank(info, blank_state))
+				fbcon_generic_blank(vc, info, true);
 		}
 	}
 
+	fbcon_del_cursor_work(info);
+
+	return false;
+}
+
+static bool fbcon_unblank(struct vc_data *vc, bool mode_switch)
+{
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
+	struct fbcon_par *par = info->fbcon_par;
+
+	if (mode_switch) {
+		struct fb_var_screeninfo var = info->var;
+
+		var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE | FB_ACTIVATE_KD_TEXT;
+		fb_set_var(info, &var);
+		par->graphics = false;
+		par->var = info->var;
+	}
+
 	if (fbcon_is_active(vc, info)) {
-		if (par->blank_state != blank) {
-			par->blank_state = blank;
-			fbcon_cursor(vc, !blank);
-			par->cursor_flash = (!blank);
+		if (par->blank_state != FB_BLANK_UNBLANK) {
+			par->blank_state = FB_BLANK_UNBLANK;
+			fbcon_cursor(vc, true);
+			par->cursor_flash = true;
 
-			if (fb_blank(info, blank))
-				fbcon_generic_blank(vc, info, blank);
+			if (fb_blank(info, FB_BLANK_UNBLANK))
+				fbcon_generic_blank(vc, info, false);
 		}
 
-		if (!blank)
-			update_screen(vc);
+		update_screen(vc);
 	}
 
 	if (mode_switch || !fbcon_is_active(vc, info) || par->blank_state != FB_BLANK_UNBLANK)
@@ -3145,6 +3165,7 @@ static const struct consw fb_con = {
 	.con_scroll 		= fbcon_scroll,
 	.con_switch 		= fbcon_switch,
 	.con_blank 		= fbcon_blank,
+	.con_unblank		= fbcon_unblank,
 	.con_font_set 		= fbcon_set_font,
 	.con_font_get 		= fbcon_get_font,
 	.con_font_default	= fbcon_set_def_font,
-- 
2.56.0

