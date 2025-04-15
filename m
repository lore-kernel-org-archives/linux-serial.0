Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63E823D2A4;
	Tue, 15 Apr 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744942; cv=none; b=lmndI9s9lYGMf4Cu/bYD/Z7xnAeX0eDga0vk/Co4ifKOW8vXQvhDiBlpwlxaSI7FBPqQCKVjesTSexis4oJYIXJR//FvQasbKcQE8t+JCs03YZWdXPipvI7IsDodGY/xnY8caZuyy/WhXajwuAhAY2Jb8vXkMJQRWpBcto0UmRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744942; c=relaxed/simple;
	bh=nm1E1FEVMIfYg7pbvLYIfRTfxicisS5FpQYS0urX5/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqE0rhvTJz+vHML9OnVebKWGzVAJPfCXRTCGlop74yrhXF4n5VaNvBZG0qquz/Vl6noQXpDmbbt50n54UERd0O0DgcqWWc1AZ7g3BsofRxb2nHrUcqnu0wflNFoWZPoWS76RdQdHCcobV1it5qgY+d47f6V73H4Pdp6uT4Ew67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=nWzMEJ6G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AR7syuZC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="nWzMEJ6G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AR7syuZC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B982813801DB;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 15 Apr 2025 15:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744744939; x=
	1744831339; bh=clBP/AOC+t0fTcP1nwoYlcZ2Ogk0dwhdHt+FVl4HuhU=; b=n
	WzMEJ6GIq/0jujeV4cf14lB0cWoVTk8AQighnIQHd6T0Boy2U5bNtmhhXqRyU6aI
	zRvN/R1d3Kg4EnZZIyK/GZoBB+0WxKnOxcE7MDCjq77mNuCPsJVUtJpwASd1ol3F
	B586GgRPuMX7BL2FQwHjlqAA3G5T4Nm/H4VE3ni66dgskLCBdjwBzcS6bkWn5Y3t
	8ch3GMv+4hMRVqFVClJeuPCsyTfOdZLibkI6HbUFW97KyR/gcsndqKGRGiOi2xJe
	MSJCyILCn+tA4ivLLBF7mm7/0F9Pcb9UVg2RlGte/GphXZZhriI4xlsDQf9DZD84
	w8UEIeD6L72ACsXjr0dZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744744939; x=1744831339; bh=c
	lBP/AOC+t0fTcP1nwoYlcZ2Ogk0dwhdHt+FVl4HuhU=; b=AR7syuZCE24ugIg7r
	crDGxFKTsUm/D/vUY9qkvlC4GRIKipROXgfkL1/HtAOvuXjH0ZEeuArL8b6DhrwG
	cG4gAdCd6eik/E7GxIY5J5O7g2KGPRERS0YCI3hAMsEU0WCNtH4zZAhVhC7Gs+cA
	KCCNoSOO5RdbCOXfLBL+Pl9Y4WhceaA7EKHaUhhUBqw6JhjkWx63LYIzaVYMPDTT
	yprQPbvUM2br2ow5r/hGcfZBghTWOaTPL7s2yCDVZYcX2r+L9VWmjH5DDLgrxIxr
	TZlvcGYeLJdo9aqwUsBB4PTKcDn5/xgs75/6tvS3mxkg+EW/MTnxpC5oxZj8Pjip
	Jo9JQ==
X-ME-Sender: <xms:67H-Z1VT8ZmZiI9wrc0m5J0s3nQiAURotj2Sh3Aw9Xu0k05QzEy6Fw>
    <xme:67H-Z1n18Cx0tWkT7sEYwzqLHEGcRZt6YzrWMYRvw9i1kAp2H5FCUKAAFuTDiXXGj
    zfxQjwzcZTK07DPGRc>
X-ME-Received: <xmr:67H-ZxbFcvKNG70zWxreToJ_V1coybWfhOXSN0QZrMOqHxGjJn7dvRv4omXy4dEgYF0atM4oTV_ACcjMH6946hpLjdbzVDZU8RcsDUl53tIZRQF3bQ>
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
X-ME-Proxy: <xmx:67H-Z4UaG2Hss25npzAFfwfidEdkGlMA22yaegLWxI8vHUsF9VK_ig>
    <xmx:67H-Z_mMPbceuwvDqE2uxsAyrrRhUnpxwnnhA4tGtq-HGBD_matAdg>
    <xmx:67H-Z1dYT7bwIvqtvKRmysUTOKlfSbqnigupF15KpiHCfSnPpV1RWg>
    <xmx:67H-Z5FY-D3nY7EjrLFZLV_dD7zp0Jwe3pYXPRn0j0usBtTwCa2ahQ>
    <xmx:67H-ZyH20worOBLGeWgsDk_EuG5QC_A-AJis2s_7ceOwWc2qoZU_6Alu>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:22:19 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 0F7801116613;
	Tue, 15 Apr 2025 15:22:19 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] vt: pad double-width code points with a zero-width space
Date: Tue, 15 Apr 2025 15:17:59 -0400
Message-ID: <20250415192212.33949-11-nico@fluxnic.net>
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

In the Unicode screen buffer, we follow double-width code points with a
space to maintain proper column alignment. This, however, creates
semantic problems when e.g. using cut and paste.

Let's use a better code point for the column padding's purpose i.e. a
zero-width space rather than a full space. This way the combination
remains with a width of 2.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 76554c2040..1bd1878094 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2923,6 +2923,7 @@ static void vc_con_rewind(struct vc_data *vc)
 	vc->vc_need_wrap = 0;
 }
 
+#define UCS_ZWS		0x200b	/* Zero Width Space */
 #define UCS_VS16	0xfe0f	/* Variation Selector 16 */
 
 static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
@@ -2941,8 +2942,8 @@ static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 		/*
 		 * Let's merge this zero-width code point with the preceding
 		 * double-width code point by replacing the existing
-		 * whitespace padding. To do so we rewind one column and
-		 * pretend this has a width of 1.
+		 * zero-width space padding. To do so we rewind one column
+		 * and pretend this has a width of 1.
 		 * We give the legacy display the same initial space padding.
 		 */
 		vc_con_rewind(vc);
@@ -3065,7 +3066,11 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 		tc = conv_uni_to_pc(vc, ' ');
 		if (tc < 0)
 			tc = ' ';
-		next_c = ' ';
+		/*
+		 * Store a zero-width space in the Unicode screen given that
+		 * the previous code point is semantically double width.
+		 */
+		next_c = UCS_ZWS;
 	}
 
 out:
-- 
2.49.0

