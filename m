Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC90288539;
	Wed,  7 May 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627346; cv=none; b=N6ER3UMpmtJHgd+j79LzYivOEAGDrLGVwvS9GU8DCBPbW38yral8itizEl/u17RyYNJe/1zgS35BNrdjpfgbFhPHtp+B/xwp0YQNB85myXiPNgnpA06+b5Y7vAybGpfm2UafwIBGJZhTv67tUDIlPZQz0GGeqbmxDuC4g3hULWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627346; c=relaxed/simple;
	bh=PjuGJHGeB2MF+v69Bo2qC9kMy6XJXy/TbdCNGtfCWoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HySJqdtMiq8WwYuckMNN9c03OJ8fD0BRI/88CAP5MfPBQ9kkzQAt3ED8PAIJchIN00c2XO+7x5LsxdNLgFh1B2TEZvyjk7TSaXaPzZaIYobMdNMSUPL8PKBk9/BQjhyvC/RRw+7NK6mO/pEc6ZwtQsVl5s/gd25gBeKxKoXctmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=fChE39gE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iUO8/S+t; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="fChE39gE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUO8/S+t"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B64D11400F3;
	Wed,  7 May 2025 10:15:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 10:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1746627342; x=
	1746713742; bh=XNpF4JgFKM/Z4mjRfly1s+3cu5aICbUG9CzAZUaSDjU=; b=f
	ChE39gEDH8z0iaNkYbHCIGDuNFA0LB2l4M80Qo3n0heS7c7pKNcumtKLkkNJVMgc
	jlY+N3cZL1R45KjxuCkxWSYWL0s2nocwS8F9XdwR11+w1xnA9Kmu1Qz8ZVzbPdm4
	9dekiOA5XbY++KiwqAg4HqOORe0WTvEus7q9MGYuU+qQiRDIqOZD/bcxsKNRDKYI
	r/A9kr+OIyAAm4+DbbO7ip7RGQ6noz33jbYqrSwosHB/XnNCT/OAmsWH6XHpE+EG
	25rkirNsCOqUwPSYoTOsOLSxnh+iaBn5spPbWFVjmJRoGdXRK0DHiWh8NAVGbUou
	qvho53BZj6SQwT3Xkm1sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746627342; x=1746713742; bh=X
	NpF4JgFKM/Z4mjRfly1s+3cu5aICbUG9CzAZUaSDjU=; b=iUO8/S+tj7tXJY46r
	6qclICcayadZCTb2Inxytb7I8X6JQs+4acsz7n9kEJrQxoQ2rjrtJFlsI4B/irqt
	o1r4DL5pTz7br9MYYQz2bXjv2f8scoh9i6HoLYFbOPOGJFXLbzY9YW2LZn6lVxdF
	o/j82PtFvrlKCXORuRbuQqcZ+PCNffFPvRiPOVqP6OkTzIH/kfeF0sU02okxLnEW
	ZaNSbtN3E3LrgvaKI48kbgDGeNUcHZhYgBtblYIRrzJlqk5wLahYtmTZhDD7ELoF
	XlQlvbvhl8KoTIw91mg0MHY7rjZnH+J2DkgFP/z858OSDj+hQd8XrkF/EG5sRtyk
	R9t+Q==
X-ME-Sender: <xms:DmsbaH-_ihkNPHZ-0bO4t4BuvadUYnpqCWattsAX3d_uLzTcP4Sjkg>
    <xme:DmsbaDu_KXuN7NOw8ZHsd2mJlcKKgsWCNg0DvtTf51CZOjxY_Ly78LNrrjQXz22Bg
    9VGQZfFrRKH6WKfYBU>
X-ME-Received: <xmr:DmsbaFDGWV6lgHMeL9AvYtvYqb2r75wdDFvTbsVfuWt5lqjrv-fMx6M9740VhJZBBTl9_2JxpHfsEb_PuU0WpESAquLmV_mzeJxdEUFIQbbHZPeRTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejtdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DmsbaDe8CEsj5Yaev-rCKqODe6XPv5gfeP9VK9Xo7Nw3koi4PL6KvA>
    <xmx:DmsbaMNRyTx8z5tkLkkkHFfxbbCPnRrhWqVZUERJwRqbtwOLA8CuBg>
    <xmx:DmsbaFme17uTtrKetdhUR02SLGaRZRaoAy83AX-if_QGAJVgdGqSXw>
    <xmx:DmsbaGvzu01w3lFvsLNOBbNroas2Ww8A8YXZBK0sOiWYhpVAVFwIgA>
    <xmx:DmsbaCM3VYuZrYPIGcI9qpPr7nbB90L4XN4XvmE1p8joVLbqnrXMuYQ->
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 10:15:42 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id B5CA41189EA0;
	Wed, 07 May 2025 10:15:41 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] vt: ucs.c: fix misappropriate in_range() usage
Date: Wed,  7 May 2025 10:13:16 -0400
Message-ID: <20250507141535.40655-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507141535.40655-1-nico@fluxnic.net>
References: <20250507141535.40655-1-nico@fluxnic.net>
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
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
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

