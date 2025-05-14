Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD7323D;
	Wed, 14 May 2025 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252054; cv=none; b=K5KWji26m9R0Bc87J8lixAsHitFI0Ny+CiV8roMdRNxTy2ZNhf8v8paO1241CbUp3q9VmfBLfP9UEENt3WTmhnnnfQA2cDL5xKTbN60E4S5jdVSp9/CTKOTzTOY0NgTUzC+IIWpYk9rYhh8ylXG0lnfdMoz0TX0YgvRaMueDs2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252054; c=relaxed/simple;
	bh=NE3G+B6HKRYb/yE9TfjfmofVj/zJKOkrwGAAUbyPCK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgXrWDOFAlDWFxKGRBcb+1/SqHoORg6v0eIXk/h5hxr9CBnSo2P42JLnN2wP/d7/OmLNkksjR3Gh3TJxyC4hWS6muzsS6/YhPny3b6Tj9yUUcgibQA3VMIqXSCg81kwy5QWzzIg+/tuk6ouDXXslXOo7bNItHFIXtTolWkvA+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=aSxTB4+q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sOis7Ku9; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="aSxTB4+q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sOis7Ku9"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C54C625400F1;
	Wed, 14 May 2025 15:47:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 14 May 2025 15:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747252050; x=
	1747338450; bh=AOJZkOXnIPu3c2Yr+S0MTZdI+IAv0M+sMRCHiXFrViA=; b=a
	SxTB4+qjGEGxTo9MR7ymzmCyC4ZI9q/skXV5NmwO9FMheCqVpB/rGmOcv964zeeX
	7PQU4WtJojhMbCSGmjrS0G/I3WDknEDLGmfeOP6wQLfSs3MFvXzZ+OKBcB2DfNp+
	XnMryJO+ZBMQAK0MEDOe13QEdq8MMFUUn4lSN9+e7RFv+h2MeeFjcMgeEIy5638D
	zj4JuN6EtaqoRXfPU762MHsop29V1s7bHkZLWlm635hzgbXh3+QSR7/sW4yDzxYx
	FUKnLBcJz0rgHPLjFRxQU5TCKkMGsg8Bj8N6Jiriov7g0nKU1si3pFU8aRV6ZglH
	aNTFSHRiBRMfrCMzLl3uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747252050; x=1747338450; bh=A
	OJZkOXnIPu3c2Yr+S0MTZdI+IAv0M+sMRCHiXFrViA=; b=sOis7Ku9NVCdXborf
	eSuCDattCbOkGc+yUoKkwbk2suULK3ZPm5gk3vFQTWf+aPTs5VyQXgcWeY/OLkNG
	awF7bLi069kSO+xJP4pjXbIF7fUjG8ymdHwuOyX7o5xq/VrnbArz/DN9WM0JgKhO
	egA4Sj1Wsn1fWGH+YzM0F90YxFR4ZjohAy0ItOyeSPJcE2mz8MNO000PfGUnYdls
	tGs1GIljkm6yLyrj/TrJ+zKE7hL7xEcGjcHpPzyRXJC2UHg+D50wDdVd6kwSuH0r
	5+LnB5fu3jXYZOP+F2HCNQ5eGoIm7R/5rqhcoCuYQRkGZoJfCoKElfYnitaVJMvP
	mLkxA==
X-ME-Sender: <xms:UvMkaEEJaJE2ELOIkoiQsJET4NZ4J9QmDHDcO6xb6jdu-cUk3QGngw>
    <xme:UvMkaNVyfo9EB1CMK43-UO6fec2v0n9kOW9hmvEBA4-dsTNurTdtl_0Ch5A-vyzP6
    OH141x2macIthSf_2c>
X-ME-Received: <xmr:UvMkaOKavj0dSVEc6NmJqydB4Lb6gCkVkZeOoUeRUpZJOdUApc6UYQ85G-Gh6c3E0UGf9R2O7P_NwF2pAcuRuIYIVbK4byfSj9NoAbEWkzs9d4gRGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnhepgeevuddukeevhfdujefgfeevuddvuedvieeu
    vdduieevjeeuudeggeetvefhhfejnecuffhomhgrihhnpeifihhkihhpvgguihgrrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhi
    tghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghp
    thhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvg
    hgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UvMkaGFqipLRLpfhT08vxUoKRoXkiLgTXPArDgTFy7lWayZMqg99ZA>
    <xmx:UvMkaKU1MiwH6GAPcqVLzrkkouKXF_nYXbvI7bCKM6SqFVBo7OU48w>
    <xmx:UvMkaJOxlfjXy8Zohb8YcY9kx38udHg1NiIS4-wonbH-MJ3ucxZYgA>
    <xmx:UvMkaB0_aPV0HdhoikTNUM8_1Bz85FztnYeguHV2WpoDIQuGhn976g>
    <xmx:UvMkaF0565aNEnGunTk_fjDe5H5RvYx7FzCzOigx4rxNXVf38bj3nEeL>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 15:47:30 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 857B411A26E7;
	Wed, 14 May 2025 15:47:29 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] vt: bracketed paste support
Date: Wed, 14 May 2025 15:42:39 -0400
Message-ID: <20250514194710.6709-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514194710.6709-1-nico@fluxnic.net>
References: <20250514194710.6709-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

This is comprised of 3 aspects:

- Take note of when applications advertise bracketed paste support via
  "\e[?2004h" and "\e[?2004l".

- Insert bracketed paste markers ("\e[200~" and "\e[201~") around pasted
  content in paste_selection() when bracketed paste is active.

- Add TIOCL_GETBRACKETEDPASTE to return bracketed paste status so user
  space daemons implementing cut-and-paste functionality (e.g. gpm,
  BRLTTY) may know when to insert bracketed paste markers.

Link: https://en.wikipedia.org/wiki/Bracketed-paste

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/vt/selection.c     | 31 +++++++++++++++++++++++++++----
 drivers/tty/vt/vt.c            | 15 +++++++++++++++
 include/linux/console_struct.h |  1 +
 include/uapi/linux/tiocl.h     |  1 +
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 791e2f1f7c0b..24b0a53e5a79 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -403,6 +403,12 @@ int paste_selection(struct tty_struct *tty)
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
 
+	bool bp = vc->vc_bracketed_paste;
+	static const char bracketed_paste_start[] = "\033[200~";
+	static const char bracketed_paste_end[]   = "\033[201~";
+	const char *bps = bp ? bracketed_paste_start : NULL;
+	const char *bpe = bp ? bracketed_paste_end : NULL;
+
 	console_lock();
 	poke_blanked_console();
 	console_unlock();
@@ -414,7 +420,7 @@ int paste_selection(struct tty_struct *tty)
 
 	add_wait_queue(&vc->paste_wait, &wait);
 	mutex_lock(&vc_sel.lock);
-	while (vc_sel.buffer && vc_sel.buf_len > pasted) {
+	while (vc_sel.buffer && (vc_sel.buf_len > pasted || bpe)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (signal_pending(current)) {
 			ret = -EINTR;
@@ -427,10 +433,27 @@ int paste_selection(struct tty_struct *tty)
 			continue;
 		}
 		__set_current_state(TASK_RUNNING);
+
+		if (bps) {
+			bps += tty_ldisc_receive_buf(ld, bps, NULL, strlen(bps));
+			if (*bps != '\0')
+				continue;
+			bps = NULL;
+		}
+
 		count = vc_sel.buf_len - pasted;
-		count = tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted, NULL,
-					      count);
-		pasted += count;
+		if (count) {
+			pasted += tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted,
+							NULL, count);
+			if (vc_sel.buf_len > pasted)
+				continue;
+		}
+
+		if (bpe) {
+			bpe += tty_ldisc_receive_buf(ld, bpe, NULL, strlen(bpe));
+			if (*bpe == '\0')
+				bpe = NULL;
+		}
 	}
 	mutex_unlock(&vc_sel.lock);
 	remove_wait_queue(&vc->paste_wait, &wait);
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index efb761454166..ed39d9cb4432 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1870,6 +1870,14 @@ int mouse_reporting(void)
 	return vc_cons[fg_console].d->vc_report_mouse;
 }
 
+/* invoked via ioctl(TIOCLINUX) */
+static int get_bracketed_paste(struct tty_struct *tty)
+{
+	struct vc_data *vc = tty->driver_data;
+
+	return vc->vc_bracketed_paste;
+}
+
 enum {
 	CSI_DEC_hl_CURSOR_KEYS	= 1,	/* CKM: cursor keys send ^[Ox/^[[x */
 	CSI_DEC_hl_132_COLUMNS	= 3,	/* COLM: 80/132 mode switch */
@@ -1880,6 +1888,7 @@ enum {
 	CSI_DEC_hl_MOUSE_X10	= 9,
 	CSI_DEC_hl_SHOW_CURSOR	= 25,	/* TCEM */
 	CSI_DEC_hl_MOUSE_VT200	= 1000,
+	CSI_DEC_hl_BRACKETED_PASTE = 2004,
 };
 
 /* console_lock is held */
@@ -1932,6 +1941,9 @@ static void csi_DEC_hl(struct vc_data *vc, bool on_off)
 		case CSI_DEC_hl_MOUSE_VT200:
 			vc->vc_report_mouse = on_off ? 2 : 0;
 			break;
+		case CSI_DEC_hl_BRACKETED_PASTE:
+			vc->vc_bracketed_paste = on_off;
+			break;
 		}
 }
 
@@ -2157,6 +2169,7 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	vc->state.charset	= 0;
 	vc->vc_need_wrap	= 0;
 	vc->vc_report_mouse	= 0;
+	vc->vc_bracketed_paste	= 0;
 	vc->vc_utf              = default_utf8;
 	vc->vc_utf_count	= 0;
 
@@ -3483,6 +3496,8 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 		break;
 	case TIOCL_BLANKEDSCREEN:
 		return console_blanked;
+	case TIOCL_GETBRACKETEDPASTE:
+		return get_bracketed_paste(tty);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 20f564e98552..59b4fec5f254 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -145,6 +145,7 @@ struct vc_data {
 	unsigned int	vc_need_wrap	: 1;
 	unsigned int	vc_can_do_color	: 1;
 	unsigned int	vc_report_mouse : 2;
+	unsigned int	vc_bracketed_paste : 1;
 	unsigned char	vc_utf		: 1;	/* Unicode UTF-8 encoding */
 	unsigned char	vc_utf_count;
 		 int	vc_utf_char;
diff --git a/include/uapi/linux/tiocl.h b/include/uapi/linux/tiocl.h
index b32acc229024..88faba506c3d 100644
--- a/include/uapi/linux/tiocl.h
+++ b/include/uapi/linux/tiocl.h
@@ -36,5 +36,6 @@ struct tiocl_selection {
 #define TIOCL_BLANKSCREEN	14	/* keep screen blank even if a key is pressed */
 #define TIOCL_BLANKEDSCREEN	15	/* return which vt was blanked */
 #define TIOCL_GETKMSGREDIRECT	17	/* get the vt the kernel messages are restricted to */
+#define TIOCL_GETBRACKETEDPASTE	18	/* get whether paste may be bracketed */
 
 #endif /* _LINUX_TIOCL_H */
-- 
2.49.0

