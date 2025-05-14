Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71A8F6E;
	Wed, 14 May 2025 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747187776; cv=none; b=Tuo0lTCQZlGteENwRerAXk5VrOm1CTf2Qx1r3EzkkOrgurLkcLHQuf6fok8JOwIDzvkpL3swhGpsU1ZubeSs48ClvzOnaofT0r+gSGSyS/ho7ld9KXzpgds+gLAwqItkI9BkgUOsJR67EW5d+nEa9vud5VKuwu+f9P7iNydLj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747187776; c=relaxed/simple;
	bh=pwpGJLCxMvblR/fqWSrrpSyMXEgz4M3Z2/0HbbZRwtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxi5HZ8peSu5KQQumn23i1cPMhzOyofKcXP6NK/2L1qqWatn7P8FzcJuv4ztpMklMW/+7dMuX4IiRXXtFZIFk4xp5oJabhn8IBeQkMwzjGGPe1Ay6HYHJpf9/4++3mV7u+Kf9Fbkmp84otZyXYmP+alf5d4dvqspuMOaEVFzz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=COXUm77a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hAXcUazi; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="COXUm77a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hAXcUazi"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 71A24138013E;
	Tue, 13 May 2025 21:56:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 13 May 2025 21:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1747187773; x=
	1747274173; bh=JCnByk9tATHpA5kwfqJBxsplUrnKcd6kfo6AeIj+I1c=; b=C
	OXUm77aAwETmmDQrSRqP3FtcRIaBlJ/JlKshg3Gq6EmbPJgPYBmgVA5vAoGbRglK
	0Hfwk9ptRjywBMJ6I230VucfTimZ4SM8r+lcBdy3lQXJLLMuLdFpVggCCFIPlz9R
	a0YFs9I2DPqDIsDPg6ZwxDDMpAxaLln0KNjvfI1Lct3V/vRkfpvMc89/jp4PBtI/
	U9Y3KrFtDdCkwd4UF8mGTDAsm/vYzugq+45vtYP+pOZpzMGxgSkfwoWz+RqgFEgU
	vklIhIJt1mBF72/yDKrFI0qqHH7QNyIcs2vK58YqhYIw0mZPBKPpkRxHnKJDQ24A
	asXlRaY0VckKDnYAHKscQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747187773; x=1747274173; bh=J
	CnByk9tATHpA5kwfqJBxsplUrnKcd6kfo6AeIj+I1c=; b=hAXcUaziWHjTlTB85
	Z8BWqcmX53TWim6AL5XtzuCTYRXm6SCzfLtkhZiKmxORfYj0VXD6zqj2hDeDK0qG
	ABdEJlyYJCEv9vzbaPvOwcO0BWk2Wy9FUsaEltGz4KznWJnkFalbFMqgR9ZRN5e6
	U+hDkgGR2bj9jkxMI50oLoGX1funxpGeCqcQJ2nbj9BtzkjsHHka6+8oQ/4L/qs8
	aN97PmW1I7j3BfearJ7Qji+O0mJroPf0jXUqydoj4+7rZMeJyW40wLr3fstt0I8u
	OIS+qh26RRS2K57k1H0V7UYJWMBxNAGtQDN8hHEQkKxWiRxWTsCeo0lQoIz/2QFV
	lM7Ww==
X-ME-Sender: <xms:PfgjaMEJagP6pQH2RPK3bw6ik1yyXfcTnMDVA8jrLr_YFGTKSSuwgw>
    <xme:PfgjaFWpy1wdL3fSFEOBIxOUUoOSbmAa39f2pJ60pa192GKVZmX0HxHFbQHmaKKBG
    s_hhK-kcCxKvxJXL8o>
X-ME-Received: <xmr:PfgjaGLPlUSRqMXcUj3UQ4pzDGJzKEnI83bpvyCfzGpQp5CCe1d2uW1lOr9syjm8awGScstGvfPwdgyuv-zWMpmXZJsiOqnOUxfHpb7bKuBV6hlJ5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdehjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeek
    udekfeffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhi
    hlihgsrhgvrdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:PfgjaOHEVjv1-L16Aways5Pa5mYYHOJi8zDZ5T6m7AHyHeRZ3aRBpg>
    <xmx:PfgjaCW-gxJXT_MDOPifZT1IeEA17FDfFxiLDK7MUxu-AWGAzmPQ9w>
    <xmx:PfgjaBPQ7x8M5jECN_QVgPkMDfD6EAPZ_bjWWWSqRmgx8M-kC49Cxw>
    <xmx:PfgjaJ07LsxuF-EPs7bKajum3WTMypLRD8Cz-Fi7S9eK598C8eGXcw>
    <xmx:PfgjaN0X-R6ac2ABq7B_VpIAGVh0mDvNp8bTviy09lFHaei-Vb_9WTqP>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 21:56:12 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 4988F11A0BC9;
	Tue, 13 May 2025 21:56:12 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] vt: add TIOCL_GETCURSORPOS to retrieve the screen cursor position
Date: Tue, 13 May 2025 21:52:58 -0400
Message-ID: <20250514015554.19978-3-nico@fluxnic.net>
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

The screen cursor position (as well as the screen dimension) is
available through the /dev/vcsa interface already. However the vcsa
header format uses single-byte fields therefore those values are
clamped to 255.

As surprizing as this may seem, some people do use 240-column 67-row
screens (a 1920x1080 monitor with 8x16 pixel fonts) which is getting
close to the limit. Monitors with higher resolution are not uncommon
these days (3840x2160 producing a 480x135 character display) and it is
just a matter of time before someone with, say, a braille display using
the Linux VT console and BRLTTY on such a screen reports a bug about
missing and oddly misaligned screen content.

The screen dimension may already be obtained using TIOCGWINSZ but there
is no such alternatives for obtaining the cursor position. Querying it by
writing "\033[6n" to a tty and reading back the result by anything else
than the actual application using that tty is not possible.

So let's work around this limitation by adding TIOCL_GETCURSORPOS as a
fallback method to get the cursor position when /dev/vcsa reports 255.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c        | 22 ++++++++++++++++++++++
 include/uapi/linux/tiocl.h |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index ed39d9cb4432..60a1fee17198 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -152,6 +152,7 @@ static void con_driver_unregister_callback(struct work_struct *ignored);
 static void blank_screen_t(struct timer_list *unused);
 static void set_palette(struct vc_data *vc);
 static void unblank_screen(void);
+static int get_cursor_pos(struct tty_struct *tty);
 
 #define vt_get_kmsg_redirect() vt_kmsg_redirect(-1)
 
@@ -3498,6 +3499,8 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 		return console_blanked;
 	case TIOCL_GETBRACKETEDPASTE:
 		return get_bracketed_paste(tty);
+	case TIOCL_GETCURSORPOS:
+		return get_cursor_pos(tty);
 	default:
 		return -EINVAL;
 	}
@@ -4991,6 +4994,25 @@ void putconsxy(struct vc_data *vc, unsigned char xy[static const 2])
 	set_cursor(vc);
 }
 
+/* invoked via ioctl(TIOCLINUX) */
+static int get_cursor_pos(struct tty_struct *tty)
+{
+	struct vc_data *vc = tty->driver_data;
+	unsigned int x, y;
+
+	console_lock();
+	x = vc->state.x;
+	y = vc->state.y;
+	console_unlock();
+
+	/*
+	 * Clamp x to 16 bits, y to 15 bits. A display larger than 65535x32767
+	 * characters won't be a concern for the foreseeable future.
+	 * Bit 31 is reserved to represent negative error codes elsewhere.
+	 */
+	return min(x, 0xFFFFu) | (min(y, 0x7FFFu) << 16);
+}
+
 u16 vcs_scr_readw(const struct vc_data *vc, const u16 *org)
 {
 	if ((unsigned long)org == vc->vc_pos && softcursor_original != -1)
diff --git a/include/uapi/linux/tiocl.h b/include/uapi/linux/tiocl.h
index 88faba506c3d..51d33d55abf5 100644
--- a/include/uapi/linux/tiocl.h
+++ b/include/uapi/linux/tiocl.h
@@ -38,4 +38,8 @@ struct tiocl_selection {
 #define TIOCL_GETKMSGREDIRECT	17	/* get the vt the kernel messages are restricted to */
 #define TIOCL_GETBRACKETEDPASTE	18	/* get whether paste may be bracketed */
 
+#define TIOCL_GETCURSORPOS	20	/* Get screen cursor position */
+	/* If return value >= 0: x = lower 16 bits, y = upper 16 bits. */
+	/* Negative error code otherwise. */
+
 #endif /* _LINUX_TIOCL_H */
-- 
2.49.0

