Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9995A189B8B;
	Mon,  5 May 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464472; cv=none; b=O+QsiwnBV1mFEdCDvmenckwlN072u6+rZym7aaZJVIbppOq+UWVSiegu8xMzroHg+LB7Gzralul9J67nEgwA1cuzGXSCU/yKQGaSY5wCLayr1ErDnIpI6tbgzsgPW2frNaKvtX+xsHSJ3fcQ8m6ITwpc31/Klr1QkPr5xi4nOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464472; c=relaxed/simple;
	bh=87J4+10tw0aBiCCo7OxCAL5Ve3ziirUjYkIJXC8qCxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESlntXchs/PUySLB8oUe1X1GzxXWo/5aan0voVTdw3VmrckB70W3BkJ2js01n+ANYnWuHPKibBqIMSjEq+2oeQjlmuV4ezUnMU2mEA5Y0CmUBN23fsPIatadotxpRd70mJ3+F2lnW6Aim29+jCYERjpT5yzlve40anIN4suMKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=PadnLKAR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ukrEec7m; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="PadnLKAR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ukrEec7m"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A12CE1140255;
	Mon,  5 May 2025 13:01:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 13:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1746464468; x=
	1746550868; bh=QVKu64FnPFkGQGnNcQhk+59/Y/TDDqUKlS7l09ruG4Q=; b=P
	adnLKAR9YvW3HYGAIk4HxjHzccaKe0TZpclc7Y4nKoX3mRmLfjbN2B1i/m715qf7
	f5cCRFLkIh6eZDg8NZDuEVQL+fZFK+HDhQ2okdt6bAERPJnXrh+w0XXRS38i75we
	fqQn+Ra1RtEOtFWEjyyqDcrXkilGTolpKOVsAf6cL4mByCYAUd653K5z/AQzpj9F
	1Xup77vVGp6SKeJZkxNnFVLeqme41jSDNC4hWXIA79eKwM0wRRI0jYYaH3j7/Ka+
	BQHUTl4866jmCiSTvZdMrbLLkLgtwb9pdfOtmKp//eWrPzH4Nt41C7eDhvq4/pc6
	2yKJXe2lUYjeZVM606ALg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746464468; x=1746550868; bh=Q
	VKu64FnPFkGQGnNcQhk+59/Y/TDDqUKlS7l09ruG4Q=; b=ukrEec7mxrgUUQTj3
	3GAbOo/TJ+5eKSK4ZGa1R1M8xcyV/ygOMnKbHlPBLxBQyCVRCBzt9izYQl82WJHh
	Bs+6ynNoGKcFzhnE060tl9GYScRHF7gx95F/SJxiDL2aNU7xkvsLsCZ7PTVsWV3b
	huTzhZk6bHReuUVzu92nisTb3IzyXifLMT9ADsUwzgLTkaVwpEqmqhk/vQh4C+8V
	PA+YQQ34ccIWq8fSCWEp2Y8XoeXjwhnR2o+sfXS2uUnaS7yjQeDY9oIxnIAiZVj/
	kMY2af4zNSc0r2em12mBaAaQolT1Gq9EdAJfbPWj73cvn37OjImxiQNMzvhe1RB/
	kIgEA==
X-ME-Sender: <xms:1O4YaA-2tw9mAf0cC7Bzpwjh1jnXuXPcgr9p8a2hjidumMiML7yGXw>
    <xme:1O4YaIsalN6Nelh2kA_9ersxy1--2NoF0tzhAJfPVd3hfbHhYlcK5VG9bs-eTJLoM
    2BYEVRJ9LCCiNoY2o0>
X-ME-Received: <xmr:1O4YaGCHbM7hC9VDek9gMzJdiETqqX_yfzKLcAtKDRgPuY8zpy_o_zB58E1J5-0qrmB0bi0clNRnmZ17Ztp_VMMSgDsPtnms9LT_clThKpqz6W_tyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduieegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1O4YaAdQObfuVvLyF0hOXaumwSIg6D80YqtR6IVvJPtgebRyxe43tg>
    <xmx:1O4YaFMhBZYvEU7hWDHoZsWyIIui6_Na-zQI507AN2sUGYSQn17VKA>
    <xmx:1O4YaKleiq8tI08In-4xRJxbR1eDuLHiuL-ikiAF4MCVeH3rOHWk4w>
    <xmx:1O4YaHu1X1OH6B5Svsc1k79bCApK360vT10eMU-hxfMMhmcm20HH1w>
    <xmx:1O4YaHMvZ_Li69683xrrOGqDsYTh18wPMYTKdRAWeJQ4I7hrEbcRDXgk>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 13:01:08 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 504B11185459;
	Mon, 05 May 2025 13:01:07 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] vt: ucs.c: fix misappropriate in_range() usage
Date: Mon,  5 May 2025 12:55:24 -0400
Message-ID: <20250505170021.29944-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505170021.29944-1-nico@fluxnic.net>
References: <20250505170021.29944-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

The in_range() helper accepts a start and a length, not a start and
an end.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/ucs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/ucs.c b/drivers/tty/vt/ucs.c
index 0b58cb7344a3..b0b23830170d 100644
--- a/drivers/tty/vt/ucs.c
+++ b/drivers/tty/vt/ucs.c
@@ -46,7 +46,7 @@ static int interval32_cmp(const void *key, const void *element)
 
 static bool cp_in_range16(u16 cp, const struct ucs_interval16 *ranges, size_t size)
 {
-	if (!in_range(cp, ranges[0].first, ranges[size - 1].last))
+	if (cp < ranges[0].first || cp > ranges[size - 1].last)
 		return false;
 
 	return __inline_bsearch(&cp, ranges, size, sizeof(*ranges),
@@ -55,7 +55,7 @@ static bool cp_in_range16(u16 cp, const struct ucs_interval16 *ranges, size_t si
 
 static bool cp_in_range32(u32 cp, const struct ucs_interval32 *ranges, size_t size)
 {
-	if (!in_range(cp, ranges[0].first, ranges[size - 1].last))
+	if (cp < ranges[0].first || cp > ranges[size - 1].last)
 		return false;
 
 	return __inline_bsearch(&cp, ranges, size, sizeof(*ranges),
@@ -144,8 +144,8 @@ static int recomposition_cmp(const void *key, const void *element)
 u32 ucs_recompose(u32 base, u32 mark)
 {
 	/* Check if characters are within the range of our table */
-	if (!in_range(base, UCS_RECOMPOSE_MIN_BASE, UCS_RECOMPOSE_MAX_BASE) ||
-	    !in_range(mark, UCS_RECOMPOSE_MIN_MARK, UCS_RECOMPOSE_MAX_MARK))
+	if (base < UCS_RECOMPOSE_MIN_BASE || base > UCS_RECOMPOSE_MAX_BASE ||
+	    mark < UCS_RECOMPOSE_MIN_MARK || mark > UCS_RECOMPOSE_MAX_MARK)
 		return 0;
 
 	struct compare_key key = { base, mark };
-- 
2.49.0

