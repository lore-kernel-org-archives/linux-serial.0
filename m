Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05BF21257F;
	Sat, 28 Mar 2026 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774667391; cv=none; b=f6prnUWXKjytsCzB2zx/to3rZS85ZJM/2Zedy5Joz+pE8NjQ6pv90ppj7BefMKXC7gl8TH0mVGMH4tEMR3ji6mkI6bRhDqaXktiWFROHC7BBe3oh5MMDcLc68un3SEDGXVMWbTPtwIj6vq+7Vw4Z0ANkiJ4+5zkQGmp5ZQObObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774667391; c=relaxed/simple;
	bh=1n7W0VIFDGhn7IS2NMHZdTmq7VR8tBT5LJynIpC9BlY=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Eh8A+rWVKDpYF3ViDF2X0kNXTraGBPu335N57p6bGBWKoCV3lKdWvf/PqP2tq3spG9LjyOEHwd5nDMOmz89U1QdJUnebS1U9R8C6RabDfMhUyD0XYiwCFaR/tfF5/sEivLwq7ZCMDXxVN5e1WwCBqmA7uBz/jIOqIiSVZZ7MS0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=CCdMbhQP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EM/OboxI; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="CCdMbhQP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EM/OboxI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 1689C1380ABE;
	Fri, 27 Mar 2026 23:09:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 27 Mar 2026 23:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1774667389; x=1774674589; bh=PwA/MmsLbOk1QIbLSYIDIq+umf8LeZ5d
	al0SSem/TDk=; b=CCdMbhQPr9dC2af+wXABIOQZwC23DUCgq6hf4/qtiNoq6dYW
	H4c8Bqg2/4EMVS5LNLLVM/bu/9G3K41FatHWNL7Vi52Ni4t6z1J1pjjzEtvWoDZV
	rHLQHfG92Mru7psdwj/tOsOCsIdF+ZjkqYn036Ujvq0j4jiLpblBq7FbSX5hzJ7V
	xJTnLCQQ0wyInTL0/3s3Ln/sXeQq6eO51rYcMoH2quSGOCU9QAojRARl7oNPBnMt
	DtP4xJFjXE35LDiwFPukiqvIMw1HsO//x2IHyq2L/akCxZIGv4dDUdZdBFDa7nHT
	R+YefZsK5ByiMB5726zqo3gjSGAQW3ry6GpJIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774667389; x=
	1774674589; bh=PwA/MmsLbOk1QIbLSYIDIq+umf8LeZ5dal0SSem/TDk=; b=E
	M/OboxIz/g2Kz3eTEhxM67nr5F75vO9dTLDIGadl7feCCFWs3GNhp7GFt29CKxbx
	0WdT9AgMHeyxfFNDrW9k/waFgOhXNHhD4E/ChaQ1QAz9MXczItMPe8W4Ed8K72oB
	Z9rM78sDh6o8m09gQytK6js3L4MqEPB2HUWV72woWGCVf6drW1UQn+yksAOC9t30
	bbs2Hv7s+zt/f29hqRXF+SQ7bC0JOXvOJoMOVzpRWdSzX/pB5mqLM0mxLc3tk9iM
	F8awiePGoliwq0TsPo5jkDM8Smj/ikPvm2va6MVdurROQHJ8GGSGq6d1o/377500
	f/drb7lZmNxNczVoze7Cw==
X-ME-Sender: <xms:fEbHaWlNjsV6_crNEnreMJv1k9XNvnwuWP5LEkrr7NvNohUrKdTSjA>
    <xme:fEbHaVnPuUqb6pDXisUh0WrvcLgkUyLhlbaFoDGNVwAfNAB5lVaefb0m8K9dmrcNg
    90Rrnaaqkv38aZaKthjUGjNk61gDZZkZAkrTNEvk0hv8WgaQplAZeM>
X-ME-Received: <xmr:fEbHaXu61H9unfa3o4jRx6x2zo8hDW3SDWJ5t9AqPrks9bgrCgCDC3D5MvVGIFw_oFpDoChr1ITFV7mRWw1YuR_HuyT50Mr1VE3-gB59>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmneetug
    hnkfguqdgfufdqffettdelucdlfedttddmnecujfgurhepfffhvfevuffkgggtsehttder
    tddttddvnecuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugi
    hnihgtrdhnvghtqeenucggtffrrghtthgvrhhnpeeigfeiteevgefgtdehhfegvedvvdfh
    tedugeettdekveegteeifefgveeigeetvdenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhi
    tghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:fEbHaYlpEyv0hIiIswoIjc0j-Q_tGzXFZI0s2Ytv-S30jX7ENCDklQ>
    <xmx:fEbHaSsPNE7O7tDlfF5c4rEFP9kMYsy3V8m5N3gZdhy9YuG5qNEkNw>
    <xmx:fEbHaefXnbpJQ6_5D6VjAfFB3BdVpfOOQAl2pUJWMiftYdz6IpDGAw>
    <xmx:fEbHaSyFDA5vXuZFeGWzRyowvTkhpL3nody7zmSM0xq55hh0PF7H9A>
    <xmx:fUbHaWCjDM1FNQXq2wPudVyGpbFtdPWR92S0vw7arlBnhjDrJP8rX575>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 23:09:48 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 1241415B1E3D;
	Fri, 27 Mar 2026 23:09:48 -0400 (EDT)
Date: Fri, 27 Mar 2026 23:09:47 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vt: resize saved unicode buffer on alt screen exit after
 resize
Message-ID: <3nsr334n-079q-125n-7807-n4nq818758ns@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Instead of discarding the saved unicode buffer when the console was
resized while in the alternate screen, resize it to the current
dimensions using vc_uniscr_copy_area() to preserve its content. This
properly restores the unicode screen on alt screen exit rather than
lazily rebuilding it from a lossy reverse glyph translation.

On allocation failure the stale buffer is freed and vc_uni_lines is
set to NULL so it gets lazily rebuilt via vc_uniscr_check() when next
needed.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

Liav Mordouch identified and fixed a bug of mine where the saved unicode 
buffer would be blindly restored with stale dimensions after a console 
resize during the alternate screen, causing out-of-bounds accesses:

  https://lore.kernel.org/r/20260327170204.29706-1-liavmordouch@gmail.com

His fix correctly discards the stale buffer and lets it be lazily 
rebuilt. I don't want to simply replace his patch as he deserves credits 
for investigating the bug and providing a good fix.

This patch, which goes on top, improves on that by resizing the saved
unicode buffer to the current dimensions instead of discarding it. This
preserves the original unicode screen content rather than relying on a
lossy reverse glyph translation to reconstruct it.

It would be nice to have this in before v7.0 is released.

 drivers/tty/vt/vt.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 99f15b3e9544..b4b19157f05c 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1901,7 +1901,6 @@ static void leave_alt_screen(struct vc_data *vc)
 	unsigned int rows = min(vc->vc_saved_rows, vc->vc_rows);
 	unsigned int cols = min(vc->vc_saved_cols, vc->vc_cols);
 	u16 *src, *dest;
-	bool uni_lines_stale;
 
 	if (vc->vc_saved_screen == NULL)
 		return; /* Not inside an alt-screen */
@@ -1912,16 +1911,23 @@ static void leave_alt_screen(struct vc_data *vc)
 	}
 	/*
 	 * If the console was resized while in the alternate screen,
-	 * vc_saved_uni_lines was allocated for the old dimensions.
-	 * Restoring it would cause out-of-bounds accesses. Discard it
-	 * and let the unicode screen be lazily rebuilt.
+	 * resize the saved unicode buffer to the current dimensions.
+	 * On allocation failure new_uniscr is NULL, causing the old
+	 * buffer to be freed and vc_uni_lines to be lazily rebuilt
+	 * via vc_uniscr_check() when next needed.
 	 */
-	uni_lines_stale = vc->vc_saved_rows != vc->vc_rows ||
-			  vc->vc_saved_cols != vc->vc_cols;
-	if (uni_lines_stale)
+	if (vc->vc_saved_uni_lines &&
+	    (vc->vc_saved_rows != vc->vc_rows ||
+	     vc->vc_saved_cols != vc->vc_cols)) {
+		u32 **new_uniscr = vc_uniscr_alloc(vc->vc_cols, vc->vc_rows);
+
+		if (new_uniscr)
+			vc_uniscr_copy_area(new_uniscr, vc->vc_cols, vc->vc_rows,
+					    vc->vc_saved_uni_lines, cols, 0, rows);
 		vc_uniscr_free(vc->vc_saved_uni_lines);
-	else
-		vc_uniscr_set(vc, vc->vc_saved_uni_lines);
+		vc->vc_saved_uni_lines = new_uniscr;
+	}
+	vc_uniscr_set(vc, vc->vc_saved_uni_lines);
 	vc->vc_saved_uni_lines = NULL;
 	restore_cur(vc);
 	/* Update the entire screen */
-- 
2.53.0

