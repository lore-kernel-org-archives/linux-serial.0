Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761895;
	b=tLC3sCECsr22qrggqPEIb6kq48mc8H6Z6D0T7HaYrOhRj89O2Esh5IFYC9thZMHvOzac
	 3rkFJf/+7MDVKgLXe6O8PFdK0KWCwE7cIOsoU79HdUrx+Boj3pH52bGPaMRgqUUpTa4RY
	 CVArlT5iMeqkZPs8qxMDdlDqFi4mBcJI5gmg0rBO8DyyrHFbxuR/V79Hz4hETe8s5T31k
	 59y7VCF7ZCaGMAYr5urO+Fogo2J371vh7PEwdcVc8Ct9GUtHdf3/3tskY9ImwQrJ10nZk
	 8oKL4MKZNP8zGbeIBcNHUneQ75NJPVAAc11sh0v0A/kYVY4ZjwWXy3BezenqJG2Ohpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761895;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Queue-Id:
	 X-Rspamd-Pre-Result:X-Rspamd-Action:X-Rspamd-Server:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score;
	bh=23Z0lb7bZcJI8jq52NeAveNZQJLHFRDKRar/W0fR32k=;
	b=oJSYwHqaYqMfX/G5K+hPgWBAuka7w44r86bH88ZtMq3W0pSunBoi7kGQ5E5QVbVgVYK8
	 6VW82dM2kqocBR0BZ8tD3/FLTM94x0vIZz1ZthXMfin28cjV4J+7pco9Sv8TLT+Sp9tIl
	 97sVluhHoY+Ziu+iCwQ95gdPFhqs9Fjo2lXhkrEUgEb4YSzKo6RZ2kGIi60TOw1L9LE5z
	 YEe3TqbFZdWzKzEXkz0r0hzH8OJbRL1LAD9OcnVYCvJwFMuyfsbysi9M5fo01yCQHCayh
	 sSX0InFUO9wZ3OJFDvN6dCXLxZsVhimm7hstR439rplqEBsXR4S51nYAFT4E6HLVUJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348D606A32E;
	Fri, 23 Oct 2026 13:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F348D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89E1421FC2;
	Fri, 23 Oct 2026 13:24:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ACCF133F6;
	Fri, 23 Oct 2026 13:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kolmHiNg22qfRQAAD6G6ig:T5
	(envelope-from <tzimmermann@suse.de>); Fri, 23 Oct 2026 13:24:53 +0000
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
Subject: [PATCH v3 4/7] newport_con: Implement struct consw.con_unblank
Date: Fri, 23 Oct 2026 15:16:14 +0200
Message-ID: <20261023132448.115747-5-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 89E1421FC2
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

Implement con_unblank from struct consw with the VESA_NO_BLANKING
branch from newport_blank(). Remove that code from the blank helper.

Both helpers, newport_blank() and newport_unbank(), clear or set
a single flag in a hardware register. No further VESA DPMS blanking
is supported.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/newport_con.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index ecbbe2e4e2a6..1a6f9e8a79aa 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -481,17 +481,18 @@ static bool newport_blank(struct vc_data *c, enum vesa_blank_mode blank,
 {
 	unsigned short treg;
 
-	if (blank == VESA_NO_BLANKING) {
-		/* unblank console */
-		treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
-		newport_vc2_set(npregs, VC2_IREG_CONTROL,
-				(treg | VC2_CTRL_EDISP));
-	} else {
-		/* blank console */
-		treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
-		newport_vc2_set(npregs, VC2_IREG_CONTROL,
-				(treg & ~(VC2_CTRL_EDISP)));
-	}
+	treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
+	newport_vc2_set(npregs, VC2_IREG_CONTROL, (treg & ~(VC2_CTRL_EDISP)));
+
+	return true;
+}
+
+static bool newport_unblank(struct vc_data *c, bool mode_switch)
+{
+	unsigned short treg;
+
+	treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
+	newport_vc2_set(npregs, VC2_IREG_CONTROL, (treg | VC2_CTRL_EDISP));
 
 	return true;
 }
@@ -666,6 +667,7 @@ const struct consw newport_con = {
 	.con_scroll	  = newport_scroll,
 	.con_switch	  = newport_switch,
 	.con_blank	  = newport_blank,
+	.con_unblank	  = newport_unblank,
 	.con_font_set	  = newport_font_set,
 	.con_font_default = newport_font_default,
 	.con_save_screen  = newport_save_screen
-- 
2.56.0

