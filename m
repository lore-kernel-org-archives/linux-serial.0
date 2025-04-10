Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D759B71;
	Thu, 10 Apr 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247945; cv=none; b=a6bw+1HDo8vkEaAQkn89NWTavjHXoj8dHjAOffzIo0oze4cfWY5xzC3k6HwfvZMU5nnWpy4XhZSHXopqdgkSxOTRRckzP5KGL+62nUOKaJkBK0INJir78OH+GkpGNxPF7hQ6jajZ8AHgIcNzwPNluYF2C9JrGl88gd4RS8xJ3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247945; c=relaxed/simple;
	bh=ft54p6bhTxDj+z0qJTAsmGd30EjVDhq/ynj+X5E4H/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9tEA/j5SIqi0GPz9wpL5gTjN2kMgUFYuZfWcHRJRedCkn7hoMwtDb/suOLssmd/JhI+AZqrfhKnwJWhHgAhQFtM7b98nZdvU/iNSuE4kwBkBkJh5duFAZ9FufojCjBW1erF8K0yxBIUje+B07Xp2bCSL1hjQF/pOEEc2Oz4Teo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=GYT7VLYQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzdpraBe; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="GYT7VLYQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VzdpraBe"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D08813801DE;
	Wed,  9 Apr 2025 21:19:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 09 Apr 2025 21:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744247942; x=
	1744334342; bh=zNG1YKUsmyDP/ojfVRvL6wcBsNKK7C86m9dSyKIqDh8=; b=G
	YT7VLYQrEkgcvd7ErWD6swkG3DzXD+IJ8RlVU/KQL4F47YXMH9mbiKBUAAzpmfsf
	xFv7Q/Dm90XbQg+6zz1JaEQMwsjPDQjSBEwz4RcXl7kTQdcZZY5Xp7w7G48dLx29
	oiyOWsL9+0N+eAXLLXlrrHrT+WgkLDClEj64DJvfNxirCKgUt0LEi2M5xJM4THoK
	Q+Rw350vPe7fLHrIOlvrvaVeIg921JwPqRN/mGZiHkgWujGOZIZ+dSTbmL15lBuE
	F8dEs5gOc7ziX990LDct74+ut0ZNHNfNYAOIcaHyhk36rXYF4gvCcSbV9GlTaKDM
	9vCFyL21r8Gy+UTKO5/dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744247942; x=1744334342; bh=z
	NG1YKUsmyDP/ojfVRvL6wcBsNKK7C86m9dSyKIqDh8=; b=VzdpraBeULecAOql4
	JLZmmktWXvSRiH8gU4/YEoABf63A9fboOq8oqTSa5YgbJrwAYP6dPl/YaUa8fAeB
	YU8nZkcSWcn4161XoAyQzP81aqhG+r97lOwdNVeqrFSgTK6xF00qJMp/s7N78WoI
	uijf/MCGPgp4+TuAIFOuRLlZHoPEyanXlNc9MKT/U2Qfmzi+0xMZx7XGGOKckQbp
	Z8e9bQRs02Q3Lr24fRKmhFKBUBIhQmDtNRQVSzZ0aEywoIGTtdaQrx9I800tvo4a
	JrdkwzqcBpLcSZ4FrWo+iDilcm7J+bwRVwMzjKd1q9Qkq0mSMxJJy9Zzu+6Knn28
	4VNJA==
X-ME-Sender: <xms:hhz3Z_XpJN-a294f7wDw_SuSlBDLFVMYKFrcCzclHiLsThtQuj39nA>
    <xme:hhz3Z3nXu5g9MqqlBkUTptmvTtdIXQyEZ9FdEM8z7lpE9yOXYV4haX3DNQDmrrQXD
    PUgtlxVQnfdfchNvBg>
X-ME-Received: <xmr:hhz3Z7bMfVTC-J55uvwpeulgNGOxfLNIZwLaIqBJfIkpTAJVOvRywkADFVYxc6BefSLuxcrgiBjqjeD6x_K_HsOqO7sUIw8qIWpBJ72PgSc-7p-lfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitg
    drnhgvtheqnecuggftrfgrthhtvghrnheptdejueeiieehieeuffduvdffleehkeelgeek
    udekfeffhfduffdugedvteeihfetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnphhithhrvgessggrhi
    hlihgsrhgvrdgtohhmpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepuggrvhgvsehmihgvlhhkvgdrtggtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hhz3Z6UZJ9Ci9aDYE3U4UUDweKmi2NzTXxAXSCi4RcY_eUpZq4-Ycg>
    <xmx:hhz3Z5ntD7gS1v_FZOBt5_Kji2aBMB2IJZxG1cEZCJoQHO07WimZnw>
    <xmx:hhz3Z3c8MubpSyz_T3gMd5VQEJpm-HV4bj0iuEwY7DF36okZfqRycw>
    <xmx:hhz3ZzE6CIjRfWR-plpL8mRg9VWq8N9moO_novXpsjt7YcN9qrmKgQ>
    <xmx:hhz3Z1G62k33MxSNzliwamBQ8gccPAIFZf_aNBlU3Az9i_M5TvVfxLRg>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 21:19:02 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6A8EF10D8B6E;
	Wed,  9 Apr 2025 21:19:01 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] vt: minor cleanup to vc_translate_unicode()
Date: Wed,  9 Apr 2025 21:13:53 -0400
Message-ID: <20250410011839.64418-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410011839.64418-1-nico@fluxnic.net>
References: <20250410011839.64418-1-nico@fluxnic.net>
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

