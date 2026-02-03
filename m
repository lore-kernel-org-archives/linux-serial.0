Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257E2367D1;
	Tue,  3 Feb 2026 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094576; cv=none; b=s39j+H17Ronaf7Ei4CMwGTyW3P1pg9fa2T86Wc0ak7CWVFE8sQFZecXIiXRP1CDvB349rsKamAg84Z4jzvo+Xcn2J86390iqeedZ3NkR4Jf14Dw8gMUox9Wm46VmfGX9FAvLg0OvdWWghNDqumgAgNBnsx3imD9nKUYR52gW3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094576; c=relaxed/simple;
	bh=H00p2QTWgHRd3v7fXeiVC00XtIWN4oAlLCk2/E7v4Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7V06oR4I01Uiy4bmLqAswH54glRGaxUhZVEdoZc3asMxTkIWac5eFAlSkflSQIHct9kEEcM6LbmsDJVBMxOt1Q3ciwo30lCgCh68lHXvG/2GIXmbkELvm8LpHLJb3XRxcfDFwM4Ar4meiOXWXl6WFnIW17VSOR9h8RwtsiWSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=Rl4SAXgF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tGEfKmCO; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="Rl4SAXgF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tGEfKmCO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C2E08EC00D9;
	Mon,  2 Feb 2026 23:56:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Feb 2026 23:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770094572; x=
	1770180972; bh=mtU/GWKtojl4sW0tNaxPzcXLqRiii+DrYSo1mhjQGjk=; b=R
	l4SAXgFBatNQCQg6VG5ivoql5JU2nxI7XwdK9CRZsoYwDfpLcFbYd2miLiz1wXPY
	xkzOhFGss41w8vkUVCg5nXOS0lrPxyNRsIhkRLUvJ1rYR5zGO6GVIpkCbIrPC+Z4
	YP2+iE8Io9s9gz6Ypdh1pNCRBKzooTV4ymmy3fcKTh+apsceJP1voU5iVk5UfidX
	pUJL3fhOVCnziTSQAoRw/cADWgLgWfbZR4mmOLFzGfo8jd/OMs1NXx8o9B8Lg+yj
	jMrJMHIF15QmbFANfY0leiGjjiFZbCZGV5a1l0CrfeAoc384LhvFrDXioEjEh/E7
	Z6NzzWcqk6p0NhjM968FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770094572; x=1770180972; bh=m
	tU/GWKtojl4sW0tNaxPzcXLqRiii+DrYSo1mhjQGjk=; b=tGEfKmCOzDhPx4UZD
	gyWm+Vs5fYS/tLqYWpTYo6ZP2Qo2JEfEZNu0aBbv8gMsY+gfgmx1/tnnPVwomxjj
	7EVs8Pjw2bPFm6YSOjkNrZVvkB4JBB+c9KDTQvK3A0fkWFQCX2cTNEoAzOAgZJhI
	lb2hmkXabh1FW7TvnIhpb787rU7EwLdcd7BnyNwqzfcP6SPoRCOxT8Z0YLPeUoOT
	qG094o4bJ84Cf09tLFkxIQmyhRs72bsgyq7v9G88JVuWPxu/HhOQnyCLzC9x8Zua
	ic4pYaC4JiMHfR5zR2d6Ycd+VITe+3gPhrCG4q6X7AhIZqqJcxQYMCfV3RNPvP2i
	Z9RpA==
X-ME-Sender: <xms:7H-BaVNRKr4W0g-6lg0hZ4DaKkYGdI9EqU-3MfeamKXKZLs1g1n1-g>
    <xme:7H-BaRSihtOYLAfmAol-j9dTJ7_6RkKHpY69PzuhEMUIiv0YZeZqbe4jOLqTB0Q1D
    3bGMHwjm7s5tjrBj-6ITVfpzZy_Z_auW-cyA_wgFpGjauRR5SsgAzg>
X-ME-Received: <xmr:7H-BabjJ1i6YuxlIxwwBFn1Wmcc0bGMhAxql28vl0BxHunsuAV-VG6eyT2MJGDsGXfpaAP61P6jTa2ZUi0xzKAWlp6WeDurtsoM7fULQ>
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
X-ME-Proxy: <xmx:7H-BaS9Sf__S-Uu4pvx_-R_jfb8Vjx2qZixYMZBDqvrvJPiZPSSiKQ>
    <xmx:7H-BaaGuaMDODsIzdtqvCom26nC8PqW9HIwpvdlYEbnhcf8Z4aRulQ>
    <xmx:7H-BadkEsZKgYIR0vuRJmVbLVcKTwUy1qTPKHyn48GiR77xxl4edpw>
    <xmx:7H-BaWbiCRHaqKTpHL_dshdTE30iXR4iAIPrx7pxqjWFxcNz0rximA>
    <xmx:7H-BabDoEIqgHp_bg-cRxSyGHGMElBfnBRok796o0mt31QhNED7Y1Y-x>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 23:56:12 -0500 (EST)
Received: from xanadu.lan (_gateway [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id A5C33151AE39;
	Mon, 02 Feb 2026 23:56:11 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexey Gladkov <legion@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] vt: add modifier support to cursor keys
Date: Mon,  2 Feb 2026 23:52:46 -0500
Message-ID: <20260203045457.1049793-2-nico@fluxnic.net>
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

Generate xterm-style CSI sequences with modifier parameters for arrow
keys when Shift, Alt, or Ctrl are held. For example, Shift+Up produces
ESC [ 1 ; 2 A instead of plain ESC [ A.

The modifier encoding follows the standard xterm convention:
  mod = 1 + (shift ? 1 : 0) + (alt ? 2 : 0) + (ctrl ? 4 : 0)

When no modifiers are pressed, the original behavior is preserved.

Explicit keymap bindings for modified cursor keys (e.g., "shift keycode
103 = Find") take precedence over this automatic modifier encoding.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/keyboard.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index d65fc60dd7be..dacc2267de6b 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -765,14 +765,39 @@ static void k_fn(struct vc_data *vc, unsigned char value, char up_flag)
 		pr_err("k_fn called with value=%d\n", value);
 }
 
+/*
+ * Compute xterm-style modifier parameter for CSI sequences.
+ * Returns 1 + (shift ? 1 : 0) + (alt ? 2 : 0) + (ctrl ? 4 : 0)
+ */
+static int csi_modifier_param(void)
+{
+	int mod = 1;
+
+	if (shift_state & (BIT(KG_SHIFT) | BIT(KG_SHIFTL) | BIT(KG_SHIFTR)))
+		mod += 1;
+	if (shift_state & (BIT(KG_ALT) | BIT(KG_ALTGR)))
+		mod += 2;
+	if (shift_state & (BIT(KG_CTRL) | BIT(KG_CTRLL) | BIT(KG_CTRLR)))
+		mod += 4;
+	return mod;
+}
+
 static void k_cur(struct vc_data *vc, unsigned char value, char up_flag)
 {
 	static const char cur_chars[] = "BDCA";
+	int mod;
 
 	if (up_flag)
 		return;
 
-	applkey(vc, cur_chars[value], vc_kbd_mode(kbd, VC_CKMODE));
+	mod = csi_modifier_param();
+	if (mod > 1) {
+		char buf[] = { 0x1b, '[', '1', ';', '0' + mod, cur_chars[value], 0x00 };
+
+		puts_queue(vc, buf);
+	} else {
+		applkey(vc, cur_chars[value], vc_kbd_mode(kbd, VC_CKMODE));
+	}
 }
 
 static void k_pad(struct vc_data *vc, unsigned char value, char up_flag)
-- 
2.52.0

