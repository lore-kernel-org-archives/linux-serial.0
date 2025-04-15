Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9324503A;
	Tue, 15 Apr 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744942; cv=none; b=bC0oxJewlAjOKY5qBjHRMyq7MPLv1qXAeHh79U4wuLoA8hJGzKHMcg22JAfkq+PP7aleCZkK1qIpMSGIYuGJ0/pifEuXIO14ITPWueKZ9BEDGoHJNdRTg7QjgL4Tl446gg04GIMZKEiuR28ALRvGbXTCXiT44JjI5I+8o9pHnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744942; c=relaxed/simple;
	bh=ft54p6bhTxDj+z0qJTAsmGd30EjVDhq/ynj+X5E4H/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciAIGGu+NP/s8fDN43wVT/rH9hkUIXEje+gRLLiVwN8bJPVpjF6Kg4plzmxxyxAEXZSOo6LhiUdgufSSGexq/FPyvPjs8WGKlNwN9FDYdwEHH/bV9ReQmfnmthhjYS7FYl8PjPRft//jaD/bu/beYKabc3mAY5Xw8WT8byXHdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=GSvR5vFq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gygb56/N; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="GSvR5vFq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gygb56/N"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BADE11401BE;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Apr 2025 15:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744744939; x=
	1744831339; bh=zNG1YKUsmyDP/ojfVRvL6wcBsNKK7C86m9dSyKIqDh8=; b=G
	SvR5vFq7pJ6IVgUWVYyRCthVZYfp42xWizOdCXTZe4xJJFIHmt6mnh5nnJAY2CMM
	YNC/fdyCkzukzpEeNUMbJgOGx5yhYR1DeCG0xShc5oWZJ8E0yfXcsC0HJuj+tKqV
	CO/7EvzYtftM/bssMoNa+OL2pGiZYfg09gi84m8aTDHzm1eGWz/2vmtZ3N4vgtZZ
	7g/TR3UBulotuf6onK2cLawtPTYNykuXdU7sD8AlS6DqENiaUDgvE5aOX3hfDbM+
	9tzVSDmfKDQm0nFYrjX9Tr5WhQiIjApU0vMsa9MwTqMN8Rlo3/yEBygdP3aNkpwn
	eYleefb2KNzsC8dxuhFbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744744939; x=1744831339; bh=z
	NG1YKUsmyDP/ojfVRvL6wcBsNKK7C86m9dSyKIqDh8=; b=Gygb56/NugqO1PuGX
	mMAcaVLa5yPvQCURno3XhjB76khWPAFCIxhumsh9L6RIyIOMS6t1YQpsYwutx39J
	K+KSfgYgTIDKP8wfXOgdIWOWNDKd9y0PUkB/IM4pQgIBoMEviIsqAbXApegRjCd6
	+L1rM3GmIIVHmlIq+2/KDilrcOcKtN88QyWxqBOa7i74keAYabeZHh+GLU1a8zu+
	t7wN57Iw10uyd9BSs2PgNeieaKYsMDDpbxUL4Z5ux0XTZdHY/g27kRXweOL01wjp
	QLRYx/bNejWKpXpGlaR1sZnOHbABaBs1rPDX2vInhXRuPfHw/1Op+R4Mcp3G7VeI
	tRUOg==
X-ME-Sender: <xms:6rH-Z-GHlB6M-iw6v1qAJ7_30nYjTqm89U3iCFDWP6OwIVOLIlbL0Q>
    <xme:6rH-Z_UctCBfpNtnexacr1Jotu4XJPNmBNKDLB5Ag3YkRSuwqSg-WpQQjnQ2WMzbH
    Iupg7gIr6RQdTEBYNo>
X-ME-Received: <xmr:6rH-Z4LK8N2IBfCzsUooiDM2Yktje7hDNgecPdSjsPRFfeSnhsNGrvmXjL-7bzxDlYtQesFaYluP6TgdBjgV3jLI1DLirf_EeOFKohr_2l1wZlkwVg>
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
X-ME-Proxy: <xmx:6rH-Z4FxMoZiBib1o3l9f10DWxslO3Plo7b1mcKnaJUJyZ8FcdQxyw>
    <xmx:6rH-Z0X-ozI8mNpdTk_Z--8ZZliNGkbKxV6a03IWYZUAaTNHvwXCkA>
    <xmx:6rH-Z7Pdx6RZhJcxfaVjty-9Jv1OcYCOLUOG_xU53Kn9oE8oSZAuIA>
    <xmx:6rH-Z73I6ccdmyBjXPQO-BSoU5ygZiyrMz1Ph52zwnIYJEk3RdPGRw>
    <xmx:67H-Z30VL7C5arXQ2o_JUoLcPkzuUbiv8N2hVXbbaGNsnwlANRcIDUK6>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:22:18 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id DCEAC1116607;
	Tue, 15 Apr 2025 15:22:17 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/13] vt: minor cleanup to vc_translate_unicode()
Date: Tue, 15 Apr 2025 15:17:50 -0400
Message-ID: <20250415192212.33949-2-nico@fluxnic.net>
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

Make it clearer when a sequence is bad.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f5642b3038..b5f3c8a818 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2817,7 +2817,7 @@ static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
 	if ((c & 0xc0) == 0x80) {
 		/* Unexpected continuation byte? */
 		if (!vc->vc_utf_count)
-			return 0xfffd;
+			goto bad_sequence;
 
 		vc->vc_utf_char = (vc->vc_utf_char << 6) | (c & 0x3f);
 		vc->vc_npar++;
@@ -2829,17 +2829,17 @@ static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
 		/* Reject overlong sequences */
 		if (c <= utf8_length_changes[vc->vc_npar - 1] ||
 				c > utf8_length_changes[vc->vc_npar])
-			return 0xfffd;
+			goto bad_sequence;
 
 		return vc_sanitize_unicode(c);
 	}
 
 	/* Single ASCII byte or first byte of a sequence received */
 	if (vc->vc_utf_count) {
-		/* Continuation byte expected */
+		/* A continuation byte was expected */
 		*rescan = true;
 		vc->vc_utf_count = 0;
-		return 0xfffd;
+		goto bad_sequence;
 	}
 
 	/* Nothing to do if an ASCII byte was received */
@@ -2858,11 +2858,14 @@ static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
 		vc->vc_utf_count = 3;
 		vc->vc_utf_char = (c & 0x07);
 	} else {
-		return 0xfffd;
+		goto bad_sequence;
 	}
 
 need_more_bytes:
 	return -1;
+
+bad_sequence:
+	return 0xfffd;
 }
 
 static int vc_translate(struct vc_data *vc, int *c, bool *rescan)
-- 
2.49.0

