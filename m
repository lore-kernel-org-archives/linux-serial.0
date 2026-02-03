Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE921D3D2;
	Tue,  3 Feb 2026 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094575; cv=none; b=dWFtN//VGjjqN/sMBZIV6X+A5bItJS0tb0eaVE96lo57x8emBrg0hgZETfEw6XlMyyg3uxm7NaPL5LvFmwVvUrKz7A94n1eKwrkCUP/TAIx+UwlgJJp91M/qHdODKnEHketahqcufdUtGDDcOcDk2tdClt78cloOP0zvUvBpUrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094575; c=relaxed/simple;
	bh=YX3ddRErhJmkqLa2vI7Uo4ePlfnJ4VRoyrNL81YBCXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+ddsDitB4AdwgPGCACfGhsNiU8+81ZzymMuY29GLROYGTnJo+H1cqTo53phlx6crDA7esvVnPNjDVP5V2RcKtXNIzYrfTHT66pHEkZ4+KoCcfm2KStbznRJGqso3LKDxl24oISsc+uZP/f0fImjii7UiCI9ZrFWp+07XFzedgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=KM2ALRzt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=llBQ8aO2; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="KM2ALRzt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="llBQ8aO2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A663C140008A;
	Mon,  2 Feb 2026 23:56:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 02 Feb 2026 23:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1770094572; x=
	1770180972; bh=6OgqYQ+bJP/Rsu67GlT4totdCauvICVJAmMVEgcwnn8=; b=K
	M2ALRztuYBbFrIhEG81P2EB0LOBYKN86joVGqDwKHTEZrNn/VzY/YSMoghploydi
	mTVFTg13s2nZJ2KqE6IF213bDSSJeCw5rv5yyknZI4qiiSt/M57wY9v8+xp6ZyNt
	7yolaDYCa2UEEvW+BlAV48+T22F4hswJ4mmL6peSoF9/W5FOHpUEGsrUMPwbEVuz
	fSPdlgLNLUYCaJtuP1MCSiWhrSuEiLJ911Ih4EtB66P7IioJuY4kxO8bbmCC3Ina
	Tv2Uy8PBr3D1dgVvCatBXWR2TkNAL6fkkkcUf7op1eCem2nAX2OjzsSN1k37otQF
	wxZwesaK+JQ3wJJXFz6MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770094572; x=1770180972; bh=6
	OgqYQ+bJP/Rsu67GlT4totdCauvICVJAmMVEgcwnn8=; b=llBQ8aO2gyNduX29b
	4SHb2ylXW1SItbq/KUdSDGqZvQpL5eWv62gvbLKK1G0vk4yXKTfMk21HbmKhkPl0
	IwfkQZ4zZkiw8nKZYPHO08NXdKASg8PDe7DDCBI151HU96RJCpOSMmqiKNEbvaV6
	U9VpH2SFTokKmZfgunalhQDj+GRM+JVZSufCpdk2ptJqNm1h+WAdbOdc9dqm/Kwb
	q26dz4uZmnu+Rr1BSnhPx3H/EwH7EBiOiKQzy7dKOs7pnI216T7dJBba0mUTTy0f
	VbpuO7uLUR+Dci4FrekPgF3bPRXvHbDvkGKPL4gh3QgdIGy4vKYms4sOjcHMP6Sc
	jGQxg==
X-ME-Sender: <xms:7H-BacMlwACFlJmMq30Br5PApPnwsL8Qp9G4hlFCUOyALAoC5gwuXw>
    <xme:7H-BacS1bsFZvHqs3aG4xOIe6dENqTZafggEC1xz50zB5ITivuBO_I4N-HC_gmJ0a
    qUuA0_sIw-098aG7Qh1ug-cErksFAiouQjKUQT-dkmfrgAMtHUzI6o>
X-ME-Received: <xmr:7H-BaahLl8I5InN70JRXKVuyQ5PWZ3Z9tv8pPCl-N4jvcs7NgynCL9TAbWFFMP8gl9XVuUA-nUrdc_FM_KoEn-LkKfOgY1ePggHdzJaW>
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
X-ME-Proxy: <xmx:7H-BaV9FdMZJF8lQzqYWWzeQZkL9ela2qTxX-83SbaS0FBNm3kiUWw>
    <xmx:7H-BaRFacVl9a5va9UAHIANYbmyHdNgvpZfHmrnd3ez_LC2Ue8iffg>
    <xmx:7H-BaYmjqLCZTytrJiEPBIS1JVXQDT-b6XpfdUV-jXE3oebQimKiNA>
    <xmx:7H-BaVaTSjaEYu4jyrGk6rnaNdI3juUhYx-f-p-agm1fl5XaQOpDOQ>
    <xmx:7H-BaSBHEGGDBR1hIPA_HfU8S3Mrw7KJE994R22buCaPwKhbv2CQ_GYl>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 23:56:12 -0500 (EST)
Received: from xanadu.lan (_gateway [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id B922E151AE3A;
	Mon, 02 Feb 2026 23:56:11 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexey Gladkov <legion@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] vt: add KT_CSI keysym type for modifier-aware CSI sequences
Date: Mon,  2 Feb 2026 23:52:47 -0500
Message-ID: <20260203045457.1049793-3-nico@fluxnic.net>
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

Add a new keysym type KT_CSI that generates CSI tilde sequences with
automatic modifier encoding. The keysym value encodes the CSI parameter
number, producing sequences like ESC [ <value> ~ or ESC [ <value> ; <mod> ~
when Shift, Alt, or Ctrl modifiers are held.

This allows navigation keys (Home, End, Insert, Delete, PgUp, PgDn) and
function keys to generate modifier-aware escape sequences without
consuming string table entries for each modifier combination.

Define key symbols for navigation keys (K_CSI_HOME, K_CSI_END, etc.)
and function keys (K_CSI_F1 through K_CSI_F20) using standard xterm
CSI parameter values.

The modifier encoding follows the xterm convention:
  mod = 1 + (shift ? 1 : 0) + (alt ? 2 : 0) + (ctrl ? 4 : 0)

Allowed CSI parameter values range from 0 to 99.

Note: The Linux console historically uses a non-standard double-bracket
format for F1-F5 (ESC [ [ A through ESC [ [ E) rather than the xterm
tilde format (ESC [ 11 ~ through ESC [ 15 ~). The K_CSI_F1 through
K_CSI_F5 definitions use the xterm format. Converting F1-F5 to KT_CSI
would require updating the "linux" terminfo entry to match. Navigation
keys and F6-F20 already use the tilde format and are fully compatible.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/keyboard.c     | 38 ++++++++++++++++++++++++++++++-----
 include/uapi/linux/keyboard.h | 29 ++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index dacc2267de6b..0b323cefc647 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -74,7 +74,7 @@ static inline int kbd_defleds(void)
 	k_self,		k_fn,		k_spec,		k_pad,\
 	k_dead,		k_cons,		k_cur,		k_shift,\
 	k_meta,		k_ascii,	k_lock,		k_lowercase,\
-	k_slock,	k_dead2,	k_brl,		k_ignore
+	k_slock,	k_dead2,	k_brl,		k_csi
 
 typedef void (k_handler_fn)(struct vc_data *vc, unsigned char value,
 			    char up_flag);
@@ -127,6 +127,7 @@ static const unsigned char max_vals[] = {
 	[ KT_SLOCK	] = NR_LOCK - 1,
 	[ KT_DEAD2	] = 255,
 	[ KT_BRL	] = NR_BRL - 1,
+	[ KT_CSI	] = 99,
 };
 
 static const int NR_TYPES = ARRAY_SIZE(max_vals);
@@ -644,10 +645,6 @@ static void fn_null(struct vc_data *vc)
 /*
  * Special key handlers
  */
-static void k_ignore(struct vc_data *vc, unsigned char value, char up_flag)
-{
-}
-
 static void k_spec(struct vc_data *vc, unsigned char value, char up_flag)
 {
 	if (up_flag)
@@ -1029,6 +1026,37 @@ static void k_brl(struct vc_data *vc, unsigned char value, char up_flag)
 	}
 }
 
+/*
+ * Handle KT_CSI keysym type: generate CSI tilde sequences with modifier
+ * support. The value encodes the CSI parameter number, producing sequences
+ * like ESC [ <value> ~ or ESC [ <value> ; <mod> ~ when modifiers are held.
+ */
+static void k_csi(struct vc_data *vc, unsigned char value, char up_flag)
+{
+	char buf[10];
+	int i = 0;
+	int mod;
+
+	if (up_flag)
+		return;
+
+	mod = csi_modifier_param();
+
+	buf[i++] = 0x1b;
+	buf[i++] = '[';
+	if (value >= 10)
+		buf[i++] = '0' + value / 10;
+	buf[i++] = '0' + value % 10;
+	if (mod > 1) {
+		buf[i++] = ';';
+		buf[i++] = '0' + mod;
+	}
+	buf[i++] = '~';
+	buf[i] = 0x00;
+
+	puts_queue(vc, buf);
+}
+
 #if IS_ENABLED(CONFIG_INPUT_LEDS) && IS_ENABLED(CONFIG_LEDS_TRIGGERS)
 
 struct kbd_led_trigger {
diff --git a/include/uapi/linux/keyboard.h b/include/uapi/linux/keyboard.h
index 36d230cedf12..48ecb0cefb45 100644
--- a/include/uapi/linux/keyboard.h
+++ b/include/uapi/linux/keyboard.h
@@ -41,6 +41,7 @@
 #define KT_SLOCK	12
 #define KT_DEAD2	13
 #define KT_BRL		14
+#define KT_CSI		15	/* CSI sequences with modifier support */
 
 #define K(t,v)		(((t)<<8)|(v))
 #define KTYP(x)		((x) >> 8)
@@ -461,5 +462,33 @@
 
 #define NR_BRL		11
 
+/* KT_CSI keys: value is the CSI parameter number for ESC [ <value> ~ */
+#define K_CSI_HOME	K(KT_CSI, 1)	/* ESC [ 1 ~ */
+#define K_CSI_INSERT	K(KT_CSI, 2)	/* ESC [ 2 ~ */
+#define K_CSI_DELETE	K(KT_CSI, 3)	/* ESC [ 3 ~ */
+#define K_CSI_END	K(KT_CSI, 4)	/* ESC [ 4 ~ */
+#define K_CSI_PGUP	K(KT_CSI, 5)	/* ESC [ 5 ~ */
+#define K_CSI_PGDN	K(KT_CSI, 6)	/* ESC [ 6 ~ */
+#define K_CSI_F1	K(KT_CSI, 11)	/* ESC [ 11 ~ */
+#define K_CSI_F2	K(KT_CSI, 12)	/* ESC [ 12 ~ */
+#define K_CSI_F3	K(KT_CSI, 13)	/* ESC [ 13 ~ */
+#define K_CSI_F4	K(KT_CSI, 14)	/* ESC [ 14 ~ */
+#define K_CSI_F5	K(KT_CSI, 15)	/* ESC [ 15 ~ */
+#define K_CSI_F6	K(KT_CSI, 17)	/* ESC [ 17 ~ */
+#define K_CSI_F7	K(KT_CSI, 18)	/* ESC [ 18 ~ */
+#define K_CSI_F8	K(KT_CSI, 19)	/* ESC [ 19 ~ */
+#define K_CSI_F9	K(KT_CSI, 20)	/* ESC [ 20 ~ */
+#define K_CSI_F10	K(KT_CSI, 21)	/* ESC [ 21 ~ */
+#define K_CSI_F11	K(KT_CSI, 23)	/* ESC [ 23 ~ */
+#define K_CSI_F12	K(KT_CSI, 24)	/* ESC [ 24 ~ */
+#define K_CSI_F13	K(KT_CSI, 25)	/* ESC [ 25 ~ */
+#define K_CSI_F14	K(KT_CSI, 26)	/* ESC [ 26 ~ */
+#define K_CSI_F15	K(KT_CSI, 28)	/* ESC [ 28 ~ */
+#define K_CSI_F16	K(KT_CSI, 29)	/* ESC [ 29 ~ */
+#define K_CSI_F17	K(KT_CSI, 31)	/* ESC [ 31 ~ */
+#define K_CSI_F18	K(KT_CSI, 32)	/* ESC [ 32 ~ */
+#define K_CSI_F19	K(KT_CSI, 33)	/* ESC [ 33 ~ */
+#define K_CSI_F20	K(KT_CSI, 34)	/* ESC [ 34 ~ */
+
 #define MAX_DIACR	256
 #endif /* _UAPI__LINUX_KEYBOARD_H */
-- 
2.52.0

