Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1202459F2;
	Tue, 15 Apr 2025 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744945; cv=none; b=XdE+JXl6ik/dPVPn0Lg4430iTLoJRo5Cv5/DpoQKn38x9WqIHxIQXueKNPkabYsRs41rst/xpCLkTE5ftX9IlgR0tNUyPHQlIGh3Blx+5Fh+TIb8xvuEEVe8s0EklFkauiEpSxsviy1jitUDSkUGSdMs75CrsUd+FQhT3mo/pxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744945; c=relaxed/simple;
	bh=+kpwGVPI0KH9D5YJh9PcK+QwDScwKiJ3yKe2ok/lfw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hn2f/7Bc3yckeCl9s48thoqQnc1S4SwJqOjgCW/Vmh/AuNFspoDyhkaJdecc5uTsS1XAs579fR+cHy3OGYvyiCpKbkK8Ie4okxR6Dvf6m8CvOKTZEjE7d9+U6UlMvUMiYhElm7qJ+yD/Z19WZeCrqz9T9MvsVkUhv3r5/AGfbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=LPQIT3UP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=da7z92YM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="LPQIT3UP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="da7z92YM"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E664D11401FE;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 15 Apr 2025 15:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744744939; x=
	1744831339; bh=Pxfdmu6a1Rq5FX2/mG+2d7QtU5Ii4ZEqu82w8ijjsho=; b=L
	PQIT3UPDjy0/gEyMYxtYyrgy2vQ/h4qwIRu1GOSngPWZ7t3tLK5GHORHcPyBpfJl
	f5vrROeJrV4j0q/qjzurBUzRwvQEJ1GUidWExJtb1M2TEOz4rTxdFNlJS+X4BHSY
	TEloI8xWy7p426QUef/rbdFMvomk+c+ri/x7/qne9aevJnykTrAARpVjpsYxhuCm
	BroA1tp0JwapLA40YCJ3QEVE5/HuHwS6MVGAHFvS2MCDjdwWCq/TjBf4oH/Ve8RA
	hkLZldjUCHFBkwIx3ny7kOd56nb67RmWp/aMoEQhl5XkGo3MXig237FbZJEThEdp
	CppLBZiNQy2O1sbGLT9aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744744939; x=1744831339; bh=P
	xfdmu6a1Rq5FX2/mG+2d7QtU5Ii4ZEqu82w8ijjsho=; b=da7z92YMAB4v5nGNg
	QCkQ+60fFNb50VU7EaQYKDPYsJStMVUoM1l7dVfwEPqXF8vPfUoaR+7o4qfJHMI4
	wOH70OZ5vkdFO+pylIsXomjY9soye+mpeUhXphYJGiDv81aix6nxM+Vmt9TgFXKq
	St9WZ4JfDPWrBYDoEKSYILoUvWccvyGiWVQ2LaOCmRuQOUyDROKA4/NqVV9eFbnm
	38rIukXhv8kqr20bbzkAcunvBZsOmg/F4AatMuGIb0jYBtoG1HYwwMwiofUF54e6
	itAIDWlwFg6/RkQQ+be79Bx6A4B3SSv+3puPHIgeUuViTlmwYrMfJL7e7qwkarSh
	wJ8kw==
X-ME-Sender: <xms:67H-Z7AVyXhPgA6mvfg0laZpwi2wGLBAKgps8k93OHEFNe-xecMPCw>
    <xme:67H-Zxh4UP2sPE6CqJ1RzsDu5F9Tdbq-3KanlJ7RsTV-VkqKZnnF6zov_ShplFQsa
    9Oy1Zcz0PWU25ijaAE>
X-ME-Received: <xmr:67H-Z2kKqaRTZQmNbb2STU_G5kazxnk7RuzY_sV2BjUHWmqVzDUeS79ha-wh06mvssN-ZFOEZdfZK_9QnlUsEU_-p5E_c-HpknZ9uCf1UhLsrWIJqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:67H-Z9wwA-e2I3JC4CugS8zVL5RrPSTiBOvCzeCN8j8WNkLQl6xW9w>
    <xmx:67H-ZwQ6VUmyga5zmCK0GerJBwXPwXmhq2_Lcp7CTk0f_8fE2HH1sA>
    <xmx:67H-Zwbo_z_Hs_KcNMOhpZOdCgIgOK9YOSOZc9ZH8_4KHK138Ipzgw>
    <xmx:67H-ZxTAkLbZzn-6fbHYvywx7vQazKee_leAIK6rDrR8Kou5pkGTQQ>
    <xmx:67H-Z1BQCT1SH1CpgEOUtM4duKF0ZNf9xwsHHHAYGd4AxdsQxHjmiUou>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 1E1361116617;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] vt: remove zero-width-space handling from conv_uni_to_pc()
Date: Tue, 15 Apr 2025 15:18:00 -0400
Message-ID: <20250415192212.33949-12-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415192212.33949-1-nico@fluxnic.net>
References: <20250415192212.33949-1-nico@fluxnic.net>
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

