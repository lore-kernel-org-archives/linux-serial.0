Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0B1A2C3A;
	Thu, 10 Apr 2025 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247948; cv=none; b=HSepUIVr+rZHs9HshCOTnPMOpv2k/l/KBtLQopbH8gCKJu9Onou0rywN9UkzgT/TcfD/0kiRVl+LMmEwGqUW7jjG8uh/T1KY5FxC+m+FXLYOk00naZkaALfIZ3RqJ40EdmBqdRahfJkhIFS+FqRS+LX/YwMqDGoTDCUoky4GhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247948; c=relaxed/simple;
	bh=/Y85mHkgYi5NV6tiAamTtPpChyrVUnAlTn58mog05iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5rT32rdDtiq45hterQWds91uYftr+eAQxwezeVQpBqltgj+CpXRD2WsJ35uUPPvMKsO6coo8qJgCjzmU+s0db6YQk62uhYIxvO+3aUzLHuMksXh6V4hAY1d2/7QDqUdsK/u5/e9H4HICKuD9qhtdNfp5XYFbjfrD6fyz4pAOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=isrpxXJe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+K8wkck; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="isrpxXJe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+K8wkck"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1307F1140299;
	Wed,  9 Apr 2025 21:19:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 09 Apr 2025 21:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744247944; x=
	1744334344; bh=ixNtqElVlHFv8vJYBrN2UgLQXSpShh/TyAFUVWLQKrw=; b=i
	srpxXJeV0XTV2yZAIl6BQ8CbVo+q4ZaHsVIffubTk2Vm4NFGMDnA4eM41YH0FUFK
	vYDZGL4zNLyKknMEIb+4RkC6zYJf5MgBd389pXyZVUjgDa/6S5rThlvl4rgwTDoE
	O99gM8MPLI6apv3JQwXLkPq0iITJFhTbtEV3qR6rC45Tt+W8YbWd9jk5g+VHsbKb
	PZpLZjBeJYVE/+/xH38Ao2DGPE54yMUWbEdBcV7j8NiVn8nke9GzDzmimDYa98BV
	dmJsj20Lo0+q2jSp9hGeLqi3aymRl7o5WjE2cFYzsTiNVbFMy2rIZOC2s5z724YV
	0aiQruBKlG8sgvKcXx6vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744247944; x=1744334344; bh=i
	xNtqElVlHFv8vJYBrN2UgLQXSpShh/TyAFUVWLQKrw=; b=t+K8wkck8CZTT2Tz0
	ie6UYfCqx5khSerUPe1CDF8pLZ/3+exgFTFWq0O7Gsx9jv961v2JslPv3KfMLWgW
	PAgBOm5AQgrDofZ5KgbyPyf3A2MWcFMxSYosDIxheEotRhFxgP+ypewtpBIcQnkA
	EXEsuLNClQ1zjXspZOuljG/FkbD9XBHCSFDeAlxZnwAYYi+WG/hjgQCO0L3QZWtR
	zQa1IXOQTC6amFPGjeUW+1A1soT028OkO27JKijbaqRW6U/J4kK5bUfa84T3/Hz9
	pRwsB8IpeMlHVdiF2BPuhrKYL9ZBeNWh1gBxvf8DAC7lCEEIyouxaiSCGivXlX2I
	n3Cag==
X-ME-Sender: <xms:hxz3ZwwyAvCXL0_JkDrHwuCqldQqLI8hc3b2DwqlnoxA4uXlowbGdQ>
    <xme:hxz3Z0Qz7PzcAwewLurlNgJ0OVLS82QGop9PIH_vC2unwN650FXW9bT14mIzlVfi7
    L9hiHRmbY5xhn1ljiA>
X-ME-Received: <xmr:hxz3ZyVEsRhyE5FVgO6Z0EvozrcP9lKuMZrhz3J8Ox6Ts1uEmtNo70OOVJ07uwd5J99p47eTSZa1_c7L2FiUnlpwF2qqhTMFgVuLrH6KYcw7hkzlEw>
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
X-ME-Proxy: <xmx:hxz3Z-itsvOUzlMtLFAwnWfFcONhr8C8q9-EBulwulZiTxHK3eOiOA>
    <xmx:hxz3ZyBAdgm7GqXrhN-EMTopHrkdTrOng-k3Z_k7PSDE3AvDRRvzRg>
    <xmx:hxz3Z_KpXKMePjIOH6q9Q6X7odVfDsxtJ45V7cHHz8wxeBTaNS6PYg>
    <xmx:hxz3Z5BZ2cgkP91KPheWhyJ6kJuh1K7VmduVbP5cnAedSgTBx1v0CA>
    <xmx:iBz3ZwD2l6WU60nlLdwLq9Q1PKFjPF4vxshyPD8OcQLcKyWJZpbTrj8b>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 21:19:03 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 1A60410D8B80;
	Wed,  9 Apr 2025 21:19:03 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] vt: pad double-width code points with a zero-white-space
Date: Wed,  9 Apr 2025 21:14:03 -0400
Message-ID: <20250410011839.64418-12-nico@fluxnic.net>
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

In the Unicode screen buffer, we follow double-width code points with a
space to maintain proper column alignment. This, however, creates
semantic problems when e.g. using cut and paste or selection.

Let's use a better code point for the column padding's purpose i.e. a
zero-white-space rather than a full space.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e3d35c4f92..dc84f9c6b7 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2937,12 +2937,13 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 			width = 2;
 		} else if (ucs_is_zero_width(c)) {
 			prev_c = vc_uniscr_getc(vc, -1);
-			if (prev_c == ' ' &&
+			if (prev_c == 0x200B &&
 			    ucs_is_double_width(vc_uniscr_getc(vc, -2))) {
 				/*
 				 * Let's merge this zero-width code point with
 				 * the preceding double-width code point by
-				 * replacing the existing whitespace padding.
+				 * replacing the existing zero-white-space
+				 * padding.
 				 */
 				vc_con_rewind(vc);
 			} else if (c == 0xfe0f && prev_c != 0) {
@@ -3040,7 +3041,11 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 		tc = conv_uni_to_pc(vc, ' ');
 		if (tc < 0)
 			tc = ' ';
-		next_c = ' ';
+		/*
+		 * Store a zero-white-space in the Unicode screen given that
+		 * the previous code point is semantically double-width.
+		 */
+		next_c = 0x200B;
 	}
 
 out:
-- 
2.49.0

