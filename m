Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D34C185B72;
	Thu, 10 Apr 2025 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247947; cv=none; b=O8/U/49b92LHgFN92Pwm7V8vtXgaMSxGu84OzKCCkToLbcQ414SnG767Dy1VeddLXdpXWlGBErAuS+PNV8Fm9B0OTT5RRcHAi8Ya3bQkXBT+SoJUmWH3DZnHyFq/TPgbaqwquvolqsZXGBTfgNZvVsy6VUA5DRf8CeUQv6aMIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247947; c=relaxed/simple;
	bh=7Fl01rmqtsQopHmhT4GKDbwNXFWXu9m4k9r0i5xZdNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqGRyR/vSmJdewj7s3emYl0iH6J0gVp12cMx9t8XF64PURwKwEfYjJoBaglO4UDF52xwxU4o8QOyUvbgylxVTiWWt2G24QUZ7YtkPMdJBLUxnoCkQppnkwQikslp9rNzBQsLeZ8+TBuUPVtmFd63aZ/Aw1mBkTeygUGk2ip40+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=UOm7qTHH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hczixEIm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="UOm7qTHH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hczixEIm"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D2731140293;
	Wed,  9 Apr 2025 21:19:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 09 Apr 2025 21:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1744247943; x=
	1744334343; bh=kciBX3rNr/kvXLJfeX4cavlPoN4UItk15A/naDhaYic=; b=U
	Om7qTHHBWtgjBQ9Fc+UHcP0DIdWte3128f2MlWELtqN805gCUR18C94JFRECHMHg
	EUF0pO4432Fb3Ji7v3gFvkCcaRVIkP5fbZCxlGkzbjHuwkgyz7Kr2twiGMggRawk
	glkmpUIk7nvSFbNDgMmzQSuONpVH0bj717IIdLeJGE70+o0OE17Uhe2MZNZ6IarS
	WTkTGZiudSd69JsMsI4k4TmIuOnVF34t7CzEeJfBblOFssM4BGRKDzZJvx/hNoQI
	8rGQ2JuvysWUDp86B/oD2s7EuN4UmLMiiifol0ZbMVZsv/VaaTsEtFP3ZMjrV0S/
	NhtpAA2gSJDeN7VabQUOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744247943; x=1744334343; bh=k
	ciBX3rNr/kvXLJfeX4cavlPoN4UItk15A/naDhaYic=; b=hczixEImpv23Y9LqV
	t+MazNa/Iaq7NCvqMR1ky6HkoGz5IMbtp2fc11SoIw5B0ZBG622SBNpCZxyF6ou8
	LGfcHOBawsHTFzdyvVYLX6jjq+1ur59JZ7i9OFU8+Wb2lN8FNK5NIhVsST1Q2hSl
	GTbpJfLzLkPcjTrPYd9jHv3OSuAslBZkVwFX4/FZouTO7yUhN4526w0L7slRfb2q
	/KxtFhQyp5twxurSzyc+VgdGWTZWgCYv/PmiWpKteMdmJBkgWfW7mQa1SKW42yrb
	7y/bEeuSokWmt3+lMbI0v518BpD8cxXR2xCDzxgdA0BLgDuNkIp9FeVAlvYt8XJZ
	4H8zg==
X-ME-Sender: <xms:hxz3Z3aQbmkkjK1asJ40w2VRVZGb-pvCy11PhZg3LVeTSPSvI7u6yg>
    <xme:hxz3Z2aimwI9MqoD_RWrwiD90sr4fQWVioPOiyyYs0mkUUMxowoKyP7L7SeYx9JAb
    LeZ-RfPBn_8jDEPZOs>
X-ME-Received: <xmr:hxz3Z58hlBFjE7AUTh4u201pSWIVzel787O_OQGGJWa5_iBS6aWnyBuHEac-OrjrfCA_8s8zbjdDjxyfhLOlN3FCWG8RZrf4IRn0Z8jsW1S9nTnsng>
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
X-ME-Proxy: <xmx:hxz3Z9qWvrdV8Wqs6AVA_HhfvKHzx20OOuFzKOkLBkOU7fqFf0BtUA>
    <xmx:hxz3Zyrb6dDRrBGd9UmpQlo3SgDvFPwrtHPbtbBctucSmg40SPZ-bA>
    <xmx:hxz3ZzSpGAZ_v__DraFI7jn2iy1U0v8O2EFsX3vuBZ51FI9hPQn5Ag>
    <xmx:hxz3Z6pUEkfPJtuf_iqktINwNUyWqVnOLajxp3VAHGYoctCzhjatzw>
    <xmx:hxz3Z_o0RejPN6txIBzETzSVBL9SWWEOY2ywzp7ZHVWdjV30c3mN107f>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 21:19:03 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 92C3E10D8B78;
	Wed,  9 Apr 2025 21:19:02 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] vt: support Unicode recomposition
Date: Wed,  9 Apr 2025 21:14:00 -0400
Message-ID: <20250410011839.64418-9-nico@fluxnic.net>
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

Try replacing any decomposed Unicode sequence by the corresponding
recomposed code point. Code point to glyph correspondance works best
after recomposition, and this apply mostly to single-width code points
therefore we can't preserve them in their decomposed form anyway.

With all the infrastructure in place this is now trivial to do.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5d53feeb5d..e3d35c4f92 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2953,8 +2953,15 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 				 * double-width.
 				 */
 			} else {
-				/* Otherwise zero-width code points are ignored */
-				goto out;
+				/* try recomposition */
+				prev_c = ucs_recompose(prev_c, c);
+				if (prev_c != 0) {
+					vc_con_rewind(vc);
+					c = prev_c;
+				} else {
+					/* Otherwise zero-width code points are ignored */
+					goto out;
+				}
 			}
 		}
 	}
-- 
2.49.0

