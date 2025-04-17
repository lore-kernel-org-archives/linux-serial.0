Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9F256C62;
	Thu, 17 Apr 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915751; cv=none; b=hv8IJtFvsXTNySsjE7fgUIUNhMixqufI0+ncN05KLkfKmMrxAmHp1+cQNCER/BOALbb3PPi7G+alELdqGVaLFpmU9zW5WGF1bZki6jtovdA1/9yGBQKBGGenA5KnrhnOLlWaWc5/PMNmiQqrI5kehunqVeIxVeRadR+32tQfmCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915751; c=relaxed/simple;
	bh=fm3eFyJozG2lS4Rb/hc1hRnxBHCnkLqI+2kI+zYTuII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrZ+0MJ7D17WkkYjs+9ieCslIGbLGzapXAe6kD7jORCYMCPMD57hU4PFW+cel5wNg2Y0tPOsaXoociFHMivsKgAL6n/mIjGVvZ13CzDP5bbBnYk8OjkJWsOF0uXk5g7YuF/uAoDXyIilgnQXAbPVUmbMbJtQduV7nFMHZmdb1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=jjmq5NdS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l4P2uOaf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="jjmq5NdS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l4P2uOaf"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1715E254014A;
	Thu, 17 Apr 2025 14:49:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 17 Apr 2025 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744915748; x=
	1745002148; bh=xawSWFfcd32yMzp1Ryv7c3+npsnX3TTRHig5t/4hu6Y=; b=j
	jmq5NdSbe9BgguNAjklmxVSbuFdkV7zcp/WaHywvH+HwtkSji77CTgNfWiFsxgVn
	BYvLPdgxuV4j14EIKGQCVicupsyKXl7i6Mu7UT7kzOVHx08w6oBx6bT+zTftGeeS
	o/wsnNG9ilKnVTujS+0SO8nR9AnQw/R5AaF6XKLNhzTRNB2nD1SXZ+YvgQalK7Zs
	xpwjNce2okzD1yTUx3EP9xLMYUtQyYnFg27H/KCvZ7hK0No/kgEchYGwL9Ru0wzs
	u3eDxCxCknlaFrq0Hd6Hg615gX2r9pap5Flj/iZoHuDVhdkrfmcsSFcyRUwb5yrA
	R282XR6q8ks0nVlrluKUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744915748; x=1745002148; bh=x
	awSWFfcd32yMzp1Ryv7c3+npsnX3TTRHig5t/4hu6Y=; b=l4P2uOafNptS1wwEh
	yzSyhM/UVBgRIoWhF6MQLTU2Y1bLuJWVDDnm+6Xk0A1YYme8AVQO4WK3UHGHayQr
	nP4gUQDeiVjEK5nZWWlwaEO+daRar+XOKIJQFa3/mDRcaTER1P3F7K9+IPrcgow2
	R1Q7tFwSrpqc1ELNXKZSJp6GOu2gb4Y8Jwy/sbN7ZuzLIcMoF94JtGrytr0bjaXt
	V+BeXUwDWpEzZmNve6OhZhVfdV6c0iMM1V7PMhBRtpi1dP/co2OZh4zBlZOqkd3R
	RxBma32KYWhipzgzlgNWDnL2z9auBtx6MhQ8lbF7yCSUig0pbn7qjKA3UyEfujWv
	TUyyw==
X-ME-Sender: <xms:JE0BaIXW8yoDV8BS-YUiu7S9CCu5XsK5iWQRAAxaR7KXPRP7fNVeqA>
    <xme:JE0BaMnwH72efVSTkam5MDouK8f07cIfiwZ21jCTHIXdVOPNrdU82VWGzz7Yw4EUL
    xSCnodaFZ0XtpBQp-4>
X-ME-Received: <xmr:JE0BaMZzmncz9UFbOF3-LKEIgD6rvrnBdi3A7ML_aYFw8vPAEA-kN39MNaPyB2B0lWtiRiGwhszkw67X-c1HdINKVevRKCIXA_eSJEVkuxjehrOxbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedttddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:JE0BaHWbMmT-pbubaVzb757gOIcet_gTcJo_QJCXucLqOo9gPt-X4g>
    <xmx:JE0BaCkTVyMP5J1WjjpggFUOYVspiuRde60PCnm4XY1JmdzJtcvlKg>
    <xmx:JE0BaMea_P_yzYiqPzcdR9bSYcVn1znYKHELwEP6Qc7P2c-MoxRNWg>
    <xmx:JE0BaEFCrqWFNFk7Y6OGGqfON30szkw1RXFigE-gYJyCHpJqfxbalA>
    <xmx:JE0BaJEgG_jjr7tizZ7CC8z1rqAzJOPuT1B4AbiaUdIkCoxoIf79HIpp>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 1A2C711443D7;
	Thu, 17 Apr 2025 14:49:08 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/14] vt: remove zero-width-space handling from conv_uni_to_pc()
Date: Thu, 17 Apr 2025 14:45:13 -0400
Message-ID: <20250417184849.475581-12-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417184849.475581-1-nico@fluxnic.net>
References: <20250417184849.475581-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

This is now taken care of by ucs_is_zero_width().

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/vt/consolemap.c | 2 --
 drivers/tty/vt/vt.c         | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 82d70083fe..bb4bb272eb 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -870,8 +870,6 @@ int conv_uni_to_pc(struct vc_data *conp, long ucs)
 		return -4;		/* Not found */
 	else if (ucs < 0x20)
 		return -1;		/* Not a printable character */
-	else if (ucs == 0xfeff || (ucs >= 0x200b && ucs <= 0x200f))
-		return -2;			/* Zero-width space */
 	/*
 	 * UNI_DIRECT_BASE indicates the start of the region in the User Zone
 	 * which always has a 1:1 mapping to the currently loaded font.  The
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 1bd1878094..24c6cd2eed 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2995,7 +2995,7 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 	/* Now try to find out how to display it */
 	tc = conv_uni_to_pc(vc, tc);
 	if (tc & ~charmask) {
-		if (tc == -1 || tc == -2)
+		if (tc == -1)
 			return -1; /* nothing to display */
 
 		/* Glyph not found */
-- 
2.49.0

