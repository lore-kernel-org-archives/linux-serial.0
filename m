Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7A21146C;
	Tue,  3 Feb 2026 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094575; cv=none; b=E6Z3LLN9i1zp7K0nDqTgUXbgYlKrGd8Cdy0PecP00j7POoNyj71L51IvOAkVLciys5x9Ps2R/b3ev6zZKKssySHLnmi9ZdATq2IC3QWsQHpGDbiXUM6a17UO/jD7XBAaXWpd8VoUObcavx6RbYTUYRNZAkVHScbhUMSr3wmYS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094575; c=relaxed/simple;
	bh=bcQqnBtOxfsIxJdYptWpGCQ6WgSyW1+NBCV7XLlU8yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDXy7XenUAxzvyWseoR9drw24bLsgU32wkjiBRzQBTV3Q2uLNB12RzMnffbOj7tXALYX6qkbQH/1LYz/ze+6rPrNt+OdC6EkutV/ZO5DwjLVgLqTH/sF0wShpBkZxBhWcWEVeYQhF2GQjZxM0ZOsLgg8nvR3fEByqjNA+nUleGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=RyxNqF6j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tD7p13C2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="RyxNqF6j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tD7p13C2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2D091400097;
	Mon,  2 Feb 2026 23:56:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Feb 2026 23:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770094572; x=
	1770180972; bh=V+iATsliaEJ8WRf6f5LtvsK4ED3QI4H8YLvrpzkli9A=; b=R
	yxNqF6j9oRo99Mi1ftZHyP7QfyZtKsL7VpTRfUoHSTYaFsa616VU2IPJsqY3B+ql
	qJNg3+mo0pfFVGyW5T5QgxNnrRi+Tmy8Hj5R0FNldH90idMC798DVtm4SC8dTFB2
	5WZ1hTzk7zzgsXGh1X1yliID6okDqxhHFAZOB+0RzebPa14oezZwIviPkXzAkfJI
	l8bLb1+dlKhV4nrzsqSfqniRGA91niiVomZnOZE2g8EiSTR5QF5Myc00Cy6PyMzC
	vPMnQQJcN9lq1ZCp9ywtLAwGs4bOiPIrcLhOoqq/NIP9zEwqXZzzIz+qTeq1wk6u
	njK3NgyazkZcPc1nbORiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770094572; x=1770180972; bh=V
	+iATsliaEJ8WRf6f5LtvsK4ED3QI4H8YLvrpzkli9A=; b=tD7p13C2NjMc9Z+8j
	4VByAr1XVhn0w6lrKTFiV9CPkg7IGTMYSzemltgZNGa/64L/mdQmNwWC4BBzd3dX
	c6W772Z7BvUyJXhj9Sl0p7DAk9YwzGU/BmizyvEIkhAMAvT8cPcJ45jn7sugPIv4
	6KK9IvgpZ7b3u4/TmDr7YmFGM6dXDDy3mOPUDqewQmUha8WHV6RpExbIiR0SCyqF
	O/LL1xn7A3z8Jo0s2KJPzN0+7xDbtHngbYYyD+YpxSVKOHMa39fgld6M1vrcJ1kR
	lgy6tBG808nb3jZBU767G7aTQRthrVJyjP7AR5r+YEdhwkfsZIDCgqBX8WHLL6Rb
	L7sMA==
X-ME-Sender: <xms:7H-BaRDgAPYcFEA7FfcdW_Y0XXb4l3MQvDgbJHAHtjpWZaRFHq2Mxw>
    <xme:7H-BaY02W9qTUFokQhpXCdIvlxm9oHBNwMfrlfI9bfkqPM49EtOAEg_aAGtW88_7Z
    GUWFEEdODJLvJpICa3T0LCRy_v2fEShy0m9oAB15kGOhu8nWOBc5hY>
X-ME-Received: <xmr:7H-BaT23SuKh3W5lX5nwHAOvrFH6TiE6BmBmApt0MGT-VQRQc96l2Ti-QilXW5baedyoC8OZKAH5pKojcNUMtH5Rxu6VMz7KqTz3u-Bu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheppfhitgholhgr
    shcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnhgvtheqnecuggftrfgrthhtvg
    hrnheptdejueeiieehieeuffduvdffleehkeelgeekudekfeffhfduffdugedvteeihfet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhitg
    hosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehnphhithhrvgessggrhihlihgsrhgvrdgtohhmpdhrtghpth
    htohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvghhi
    ohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7H-BadDx3Nvo0q02_uMJgDXfukbtUBOCXKTcfV2TJ04yFANjRa3FAw>
    <xmx:7H-BaS5MHHgEpqNgvKwYjFQeZGgmeMBX4NK5m_Y08lI4gG_cUPw33A>
    <xmx:7H-BaeLHs63aXnMtL4aWdmkp0BgRxD9LOkRwLNMsu41Y-F7lPIE-AA>
    <xmx:7H-BaTsDvabPHYMw2TI2wIGyik-m7ACE2L7iFzDHv0CfPbKCYxtVoA>
    <xmx:7H-BaU0oi8ubnOaVgeZjhoP8VYWwgeYr6IceLk6SQFQ_Y4sijO0tm8hr>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 23:56:12 -0500 (EST)
Received: from xanadu.lan (_gateway [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id CA03D151AE3C;
	Mon, 02 Feb 2026 23:56:11 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexey Gladkov <legion@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] vt: add fallback to plain map for modifier-aware key types
Date: Mon,  2 Feb 2026 23:52:48 -0500
Message-ID: <20260203045457.1049793-4-nico@fluxnic.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203045457.1049793-1-nico@fluxnic.net>
References: <20260203045457.1049793-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

When a key is pressed with modifiers (Shift, Ctrl, Alt, etc.) and the
modifier-specific keymap has no binding (K_HOLE) or doesn't exist, fall
back to the plain keymap if the plain entry is a modifier-aware type
(KT_CUR or KT_CSI).

This allows arrow keys and CSI navigation keys to automatically handle
all modifier combinations with just a single plain map entry. The key
handlers (k_cur and k_csi) read the modifier state at runtime and encode
it into the output sequence.

For example, with just:
    keycode 103 = Up
    keycode 104 = Csi_Home

All these combinations now work automatically:
    Up         -> ESC [ A
    Shift+Up   -> ESC [ 1 ; 2 A
    Ctrl+Up    -> ESC [ 1 ; 5 A
    Home       -> ESC [ 1 ~
    Shift+Home -> ESC [ 1 ; 2 ~
    Ctrl+Home  -> ESC [ 1 ; 5 ~

Previously, each modifier combination required an explicit keymap entry,
which was tedious and consumed keymap slots.

Explicit modifier bindings still take precedence - the fallback only
triggers when the modifier-specific entry is empty.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/keyboard.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 0b323cefc647..a145048e4da3 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1498,6 +1498,21 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 	param.ledstate = kbd->ledflagstate;
 	key_map = key_maps[shift_final];
 
+	/*
+	 * Fall back to the plain map if modifiers are active, the modifier-
+	 * specific map is missing or has no entry, and the plain map has a
+	 * modifier-aware key type (KT_CUR or KT_CSI). These handlers encode
+	 * the modifier state into the emitted escape sequence.
+	 */
+	if (shift_final && keycode < NR_KEYS &&
+	    (!key_map || key_map[keycode] == K_HOLE) && key_maps[0]) {
+		unsigned short plain = key_maps[0][keycode];
+		unsigned char type = KTYP(plain);
+
+		if (type >= 0xf0 && (type - 0xf0 == KT_CUR || type - 0xf0 == KT_CSI))
+			key_map = key_maps[0];
+	}
+
 	rc = atomic_notifier_call_chain(&keyboard_notifier_list,
 					KBD_KEYCODE, &param);
 	if (rc == NOTIFY_STOP || !key_map) {
-- 
2.52.0

