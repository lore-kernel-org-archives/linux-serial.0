Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7851D54EF;
	Wed, 14 May 2025 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747187777; cv=none; b=H1rbvecaay1ePTIqvop2HO0lE+4+yStOp2U9iW71xHcK3vhaqGevE/D+6iiCaD20iocX0NPrZwusOZsGAl3ZJm7LB1DufpNgYwfXYXsW+i7j/H5oNrTjSCDs9tfF0mn1DGtE3PnTbOvs3NjZXVTaJFopl+afKtJElkjhAb3FGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747187777; c=relaxed/simple;
	bh=GhDZA2yzFUGM/WEprlssE0ISu5wMlmmeOvmU+/mZWa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9/tjy2+NvX9LDNyUvrXQy6GAf2mVSn+Z936/tkC3rk6XPhcS3Scv6MRZZXTGH60h9yf1tMqkbtBgLCVnUQBNfhIJYl1oeh9gAXE5/u4iIWS8MjlOY2fQzoacljIQ+HD06RKitxxq/jI5edLup/1jrwbJXLyy07p6Yrc2dv/O50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=DNZdonSu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HyQrh9dq; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="DNZdonSu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HyQrh9dq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F9971380130;
	Tue, 13 May 2025 21:56:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 13 May 2025 21:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747187773; x=
	1747274173; bh=1sN+Q0V6uO6gbyFjrK9KygHtWNP7ta31+oqMUG0XGy0=; b=D
	NZdonSuv3feVjf4wcVS9p0Y6g3eT8cROz31+O1W8FkXG3RijcOKcrtehlP476leL
	346PwWrE7KxbVHXEYIs7Tb6uJ+iHkKIUiJG+cUI/BqBVD1vHYuZ70a2mJ85WwweU
	QIYH6gs4rje+Xte6KNkInysBg6sM4V+13u8KkuUe8xAlVsq0ZPCQLZ4KiWMTJb93
	N9d5ErvXzRt88LnwMQx6kDeG2OAIt6AqUMBy6bLYRfjx3LBh0KmTdkYTYb1+E06D
	I3/ZwMPHjaLOICOovjgnhUav4xvp3MGQVzTL05WywsFpIpS00bYqKLf6ZCmX+nuv
	UPytmv03Z1RFPUA8CMghQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747187773; x=1747274173; bh=1
	sN+Q0V6uO6gbyFjrK9KygHtWNP7ta31+oqMUG0XGy0=; b=HyQrh9dqC4RT7Q5vA
	g5dTzntBfpbrv+H2Vmwa7nyIQGGZyCMkIcfMgoRXfdO0l8cecgllZHdSJaBZ0SYx
	Nm6l0/huS5LTopRlJXT6RdXqpChr2xi+sw4YcuVAhc8UuvUnz4yhhlUmRu3kyJrE
	slG95kkZ9FThs3DMv3zJdB9BrKtWhjIix/AtGoyW2rPtGJyBg0Lx9syi+TJx4ohe
	GyJ6iXoNfDqimbtRoQJc2hS5y5yZ7h/Mp4kuB21V7Og/dKkclHx2viyGfa1VOCPq
	DsQkfh8Ol49EdLSYYcxPfmvVNWfXWMBaPL8W+y8NKKSROK2dpAWC9WH3+KXCRd7J
	4by8g==
X-ME-Sender: <xms:PPgjaIFa1TfZi9p-5FecW4qlHGfU8qkSwCyX9L9UCgh3q1wLB0ISjA>
    <xme:PPgjaBWLCQpak9QOv31CSJZ8N3Vn5c_iEG5oLlWpyVOF6FK0kN8NbaeqRD9FifA9b
    gZ5ilwdp2Ygoo3VPAU>
X-ME-Received: <xmr:PPgjaCJuwT2Nk3nmoLkLhIMdqL_rWHs-rKrCqZpSkzYUqUapoQk1ZDn_1B-ku7CQqnxheBDhKBFShrLEGYktUwBZDVHEO4jL4NBIa_yLczY-vi72rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdehjedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:PPgjaKHciVzXYTw_JnXG32IpkZgwfSrp4-LF5RObeiKckJdg1NxnRA>
    <xmx:PPgjaOVam4HIIIy2bElPt_fNdoMM8KU60Mn4t0qHb8q8hg03JZCjsA>
    <xmx:PPgjaNMN0qQ_MGLSRunmeZfI1fB82PhUrpI0Lse7iw5ijQcWokzWuA>
    <xmx:PPgjaF0G_RBPMW4sdQuTgQix6sYgiaI1kidayKVCFRbp-VF4qIo1rw>
    <xmx:PfgjaJ31QNFoHI3YaqmNXqh38XDNWPeXDmBbZF_5q8DBXw-ukKI3lFB_>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 21:56:12 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 2CA9E11A0BC7;
	Tue, 13 May 2025 21:56:12 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vt: bracketed paste support
Date: Tue, 13 May 2025 21:52:57 -0400
Message-ID: <20250514015554.19978-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514015554.19978-1-nico@fluxnic.net>
References: <20250514015554.19978-1-nico@fluxnic.net>
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
---
 drivers/tty/vt/selection.c     | 35 ++++++++++++++++++++++++++++++----
 drivers/tty/vt/vt.c            | 15 +++++++++++++++
 include/linux/console_struct.h |  1 +
 include/uapi/linux/tiocl.h     |  1 +
 4 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 791e2f1f7c0b..ac86b82411a8 100644
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
@@ -427,10 +433,31 @@ int paste_selection(struct tty_struct *tty)
 			continue;
 		}
 		__set_current_state(TASK_RUNNING);
+
+		if (bps) {
+			count = tty_ldisc_receive_buf(ld, bps, NULL, strlen(bps));
+			bps += count;
+			if (*bps == '\0')
+				bps = NULL;
+			else
+				continue;
+		}
+
 		count = vc_sel.buf_len - pasted;
-		count = tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted, NULL,
-					      count);
-		pasted += count;
+		if (count) {
+			count = tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted,
+						      NULL, count);
+			pasted += count;
+			if (vc_sel.buf_len > pasted)
+				continue;
+		}
+
+		if (bpe) {
+			count = tty_ldisc_receive_buf(ld, bpe, NULL, strlen(bpe));
+			bpe += count;
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

