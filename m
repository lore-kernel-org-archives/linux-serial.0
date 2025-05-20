Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525926C3AD;
	Tue, 20 May 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761539; cv=none; b=Qafh2IOSoDKaaKHks1UH3AHax5aA2UVamyoX5efcMxjjY5QsTijVVVwDcnGsX31fAWPrVFm6BvAWaMyosvVgdBQ+A0UsFEEsmNTjJm9fxCtAM0ZAq14jS5nE6sPKSmMWBDTb7moF7BrB5pxBN+tvdDv3cJ7d21g27kNPY4CxsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761539; c=relaxed/simple;
	bh=NE3G+B6HKRYb/yE9TfjfmofVj/zJKOkrwGAAUbyPCK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quJDaPam0lsB3mKKKPAlqfQBC0G1F/Er6ozGFHdylt724797rurX2kdTfBYbq/eRoE3NFksP6KcsVlz/n1IGsKoh2vfym8B6LutKwQPMyabbCjnrPIBioXm9eZKSZBzjXUCtjMKbK6L7GaMmIUN1sRPwVWoyzY3tj4qo0X9fKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=teU2eywg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hj1By7JB; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="teU2eywg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hj1By7JB"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8003111400D2;
	Tue, 20 May 2025 13:18:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 20 May 2025 13:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1747761535; x=
	1747847935; bh=AOJZkOXnIPu3c2Yr+S0MTZdI+IAv0M+sMRCHiXFrViA=; b=t
	eU2eywgGnfYYhIoC0tliVbjBtgctO5wUj4gbj6CifCxZbA+OmvIpYt51OQI6tI2/
	5vjtA/ujnu7tgodEiFT+NYDpSi04PZdbrCA2spRWB3Fvsp2xV9Af03SsMI7PaY6y
	0Jne3Q1vvnWt1w7IHYLqKXpV8X30vtW1EQBiGOjuAWHzFFOQSOfhcb9ZWHcPWuju
	s8pLiB04uh/r5g7NPmdtnH8fShj8lb2noAH94om6+rCQM/FXHKrDRRZRLMB7/Q7D
	h6o6hKhzo4TiAl5BTYxAkN2XqQMR2JItQX+GDv09o1ISQOFkngbz7wDlQGtd+fJ7
	eao0Yg9UIX6LWV1cN5ZQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747761535; x=1747847935; bh=A
	OJZkOXnIPu3c2Yr+S0MTZdI+IAv0M+sMRCHiXFrViA=; b=Hj1By7JBumg6T+8uD
	HDbndjOLdlYPqazp5XUnDpMNgVjhkjKvp9nUjkBoHQJN6Tqnbl2gpAjHewrVT0hK
	9SLdH0j2pKjs96/WxNQJjaTDBDCnICueuCsgW67MXefdDFYAO5jqLZT2Oh18sRzM
	NdZdM3KKlMHligL5zk6/XtpVurJap5xpSOqhclWEr47g9dYINnD/0yIYIKRy4uRc
	q4uIOEaFM9sss1HHF4UePaGXHZBwIZTiln6LPHa6V/1ttTU78FwjW9H9PJVwCoDa
	6ikg6Y2oTvOKq1lm0FbVsJHodPS0HodCf8IB821HjKjkw5n0HswIClQtjdz4MXO/
	4ilJA==
X-ME-Sender: <xms:f7ksaE1xF4Xq48kSftOIr7GVxd75OpW38aSLR1z_MMTLOdh7tcmIug>
    <xme:f7ksaPGHuDvWZMkJA8rfDLlr58Zb92ZwmHtommxhWcqBm9bwEeuS5yCBR31_K1H58
    braZK0M3UJtRL7hG3g>
X-ME-Received: <xmr:f7ksaM6_QH-_tLcDz6jUMnt_hx4-xXpqEoUmzlBRBp2vr4EpyBrzeGnB5_JEvIbPRzRSerNFVkTxOrMMcbCZU0ySxl5FOmQqSJJAfFV073Cc83l-Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejleculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitg
    hosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrhhnpeegveduudekvefhudej
    gfefveduvdeuvdeiuedvudeiveejuedugeegteevhffhjeenucffohhmrghinhepfihikh
    hiphgvughirgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohephe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhpihhtrhgvsegsrgihlhhisghr
    vgdrtghomhdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f7ksaN0qsBWIauTi7ki6kaiSOJC4KTY-RrZx3HciYyJbRUn_W5Grbg>
    <xmx:f7ksaHGShOjTre41h1eB2K41lypqmTtT4DhIglJsLeTA4JusrW8zLw>
    <xmx:f7ksaG98FpvB6afHIqbbmKj_go45F59_5YLNyjyCEx9z716_xQpyOA>
    <xmx:f7ksaMlGUKfG6eN5Acu1tW2Yznd8TfxBz8XgweCOaviAfg8_dGaRpQ>
    <xmx:f7ksaDneoOlDekpqVTjcruyGShAfHBxouZYMVViYYC6zKMwJ6NNKRE-8>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 13:18:54 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 5421311B0CEE;
	Tue, 20 May 2025 13:18:54 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] vt: bracketed paste support
Date: Tue, 20 May 2025 13:16:43 -0400
Message-ID: <20250520171851.1219676-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520171851.1219676-1-nico@fluxnic.net>
References: <20250520171851.1219676-1-nico@fluxnic.net>
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

