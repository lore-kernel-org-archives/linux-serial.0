Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C12561D9;
	Thu, 17 Apr 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915750; cv=none; b=qn7TjgGNPb1BuQL24cB6Zcl7dbLCDEdpOqlL72eseZ6K3n+FUaZDri6+ppeC8yA5+Mt8FtDG8SBxO8+jj1wbQdMsGAR2acJ+EB1Qnwwjv5xkJt7x9ephcNaYB7L6nwkfr/cCJJQUcVniWF/Vo+ZBSkYoyoSuyws8vCW/vEmhDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915750; c=relaxed/simple;
	bh=erlMHrM9Cs6b3GgS9nPHlqBtf3Ox19dftn3lWGx+vhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CX2VNilku4LG6VEEXTjQ5MZmAgr92tJG5IH04NwcUe5Gyd3fRwGOwSrb8R7Dkzz88xrRC+Mlz/MSq1NgqH1Jc0tJwZY7mMX2xycJ1q69iWy/18SPeGRugI/2Vbv6RDRJjyT1YYPIg7/CR6mQgmSAZ6pfM0NquLtJGjrF8uNvhXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=AbfmN6Ah; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OLfs08lJ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="AbfmN6Ah";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OLfs08lJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 081F811400D2;
	Thu, 17 Apr 2025 14:49:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 17 Apr 2025 14:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744915747; x=
	1745002147; bh=ib4GxQsCcbLjx08EB7K5kdtLw96IO5K7n2r4f7nSpeA=; b=A
	bfmN6AhWjc6flNYhOheDHOrfIsI9z61iJ+TRixXKD5yQ3YKoBsrsMG8M5mF51sEv
	L3CBZs9CIjBev98CKsdcLbi2nQrDYvHgeF31qe3VXyrhv+F9o/tcJ53BPUP696Ez
	Sxvtcc/ddaUPgMUEzKPErCphgoPEilauggzFAPbJfCcwc42XPF3M9vQkLZ1MHhfW
	vHG7F2lIGtcl+1iekHjZCNAEBUt/Oz5BkIDvnICuyncPYbArB99AEoNSOkPckWrh
	7N02t/eTv+jpVfDtalDMUK4ufTsgH9UGsIFPrFQ08025dofZi55epXvHA+GMaa5I
	kInbVKkHJdvVDQ11TjpYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744915747; x=1745002147; bh=i
	b4GxQsCcbLjx08EB7K5kdtLw96IO5K7n2r4f7nSpeA=; b=OLfs08lJy1cjWX/jf
	f82TkLPZXXDoqMmm3C7+BSlRr5SdTJJAwDr/2voStPilPZ7/pDfKD6Yloi8sNM3h
	udjrcVmC3vzmGlH4g/um7PYDDBgMRafch4Z9ShoL883XC71SVaYvretfikDInzqd
	zT3upCkgL+ztbanBlrNIO2uFSQ0IOpAmCkQATDav6enXfcKd9sg06ccOO2/mrhfK
	f52XrIfAG3iyoT1WaN8Zk1m0X3AwYEoWrl3GnzoovpGjW/i2WJMsSyvP2mx7iNcz
	/j3Gf9vCFK/C/cFvpaRGaKQGRQ48zBa+1Z27bv44ARu3M8k3pUNAgzHYqvoE/D5f
	6DuOQ==
X-ME-Sender: <xms:I00BaLEK6Vb1qCq-QZIa0ONKG0-wfPS_O1GViUxJktHaXlJKzCwkJg>
    <xme:I00BaIWv9gGCc5M9W7_WhnNyAa9JnKQsQUeAxyxLdXyukU-7jYDO4LBC5-cUt_MPy
    skwrft5YeNt25oDb_g>
X-ME-Received: <xmr:I00BaNKRtpOCqmKQ2gPghdFJGP-pf7aJgxQflVVWjYM4V0rlddpE9Oi_vLzGhB-Z7r1nRoVsKD89xFwGOunz71K7EjYzq0PlxuQnogFCZdNDPhTIwg>
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
X-ME-Proxy: <xmx:I00BaJEuOrqBF1fgrRPoI44GO_Gz8cXobC8dm_Y0GAbPCcB3t0i5DQ>
    <xmx:I00BaBXei3igKO0BL0GuzVouL4DbKveR1jWUfzBN16005Wls9gCcLw>
    <xmx:I00BaEMJV28Z5J2fT_W-otwvKXflatUh1R0fhAtiFJMj8qd942fBYg>
    <xmx:I00BaA21wrAMdfQk9wfIuNj6r1FAh6_6c39nkUbQ7QebuOTE2-a5Fw>
    <xmx:I00BaA1ZEVjHgpt8YyBTPnWJ4e78QKub1SjS-5yCk7Oe_0Aj5Aar43ny>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 14:49:07 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id E445B11443C9;
	Thu, 17 Apr 2025 14:49:06 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/14] vt: minor cleanup to vc_translate_unicode()
Date: Thu, 17 Apr 2025 14:45:03 -0400
Message-ID: <20250417184849.475581-2-nico@fluxnic.net>
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

Make it clearer when a sequence is bad.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
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

