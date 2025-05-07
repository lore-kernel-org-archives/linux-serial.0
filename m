Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4672637;
	Wed,  7 May 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746627345; cv=none; b=Ej7FOXSvotUeuxv4gE/rdcUEYgXaxeQ2lyNxgzqy6xN6ksludPiggTbfDXR5uMTEjzfbk1C+QJ3W7bZ5zA4tIAt6rdOTZRWw8fpwlhDXxj3EtEwLL67F36qikUO0nOnRdn1DihQbsZcCYEPOOX9ZSu8bhEdEF/VOy9EhtFL2coE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746627345; c=relaxed/simple;
	bh=bI1sK8XMug1YgtyLkPeWDjQEoEo2Mj2X0dqd0ULkoac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G96F2fVGoIczBWhy3ZN/qIUQ6zSk7tP5o6ZSCih6HlWGw6ymO1IXE6tW95tCU+MHP1esq6zdzSwDhyvyku0qN3kIsMIq+/yT/cUHvnd2ceTCwcCzPOMcf8E9jUVo1GlNAqW+f1BAFYFZucX2bKm5DXi5HfGhKXm6m6Z0J3595yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=BmCncZrn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovTkNvM2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="BmCncZrn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovTkNvM2"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B7CF213801F4;
	Wed,  7 May 2025 10:15:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 07 May 2025 10:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1746627342; x=
	1746713742; bh=II0FV8lIQGnLCFCBAKSVPcW42zDW/Eux7qlFDWL5iyg=; b=B
	mCncZrnp7Z9ItUHcrhcWtZR1yHYEJh4x/16TkBkeUcJ9zS8tyMqngAvCsYzqZhX9
	j/2mPY9K/9qy3VC4tF/OBdYfjGiN9BkK1PdP9RP1oUrCozim0D7h307FSJd2An2H
	PwxJEtW829MtNK33S9ug8WsQljGYhHeagmrjefjfvuuoXBtCxGwVsMzWu1b5gjph
	4CGoayYEy14LIgAGt+ve/x0sKwaM2cKD0VEHERLIEbMjKObs2wFom4l6zClF20JW
	+i7MxVUgZRC6yjuZfxz0948sAcxAUM9Zrqr8roUCWQOLPDHq6rsKS4muwcaRoNoR
	JP4ddTroj0uBSuVHcQmNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746627342; x=1746713742; bh=I
	I0FV8lIQGnLCFCBAKSVPcW42zDW/Eux7qlFDWL5iyg=; b=ovTkNvM2ZO4TZ7iQb
	mpnbdlmCkWeJT24Qdbwj9Qg7wdIhu+HBEDM5D5rM5kg1PxFTxr2NA1ds30d1Qr2k
	yzfw16ZeFaTM5uVUGXkWmfcgFU0/CIfXECSwv/oYrC3fhOV0rdU3w1LAHb5PkRLL
	RSWun1kCVunmzoC34JOdubweBHrfXDAHW3MRfW3cP6Vn97AEedUOZsWEgdTI4e+g
	DQgbR8WX72LeovoGdpVSB0iYHZgc4pMsmDqzi2WQeYGNUJh8NTKgsP7qo+or7e9s
	L+/OzLhw5mm/qdZDFToH8AX3HVLFgj8H/4LVtY2piOsHfSRymWoUuHPMDQp6xN+B
	tfYiA==
X-ME-Sender: <xms:DmsbaPRlXYEBzT2b73MCZtVHAnzBHmcKwVADgloz7IA3ZWCFB5uwRQ>
    <xme:DmsbaAy9Q9sD-xGCJKEtbve3HnRfmDTNfAR1Vg4tgLURsreaUowZyFaAKBT0YFARd
    I3dUsDLt4-TDGNByWA>
X-ME-Received: <xmr:DmsbaE2eIN68Y3aOr-UdO-qIH5wwki_jnLs9tq5yFxXBWAdVzYPz2rG77sVZG10jirC_tOWTFWMX5_CDKrg9X9YJ0mheizek0mGpZMTvPjtyVwelxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejtdekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DmsbaPAA_Ns2o0EcH23wsbG4kHgeuOotsmDxirFCDgVGCYBJ9_fpKA>
    <xmx:DmsbaIjKp0wa792qToD0Mq1VjzR8Q94USJbzr__ah1JRUXPt_A_qtQ>
    <xmx:DmsbaDoIron3KHKC4XLT7fbkWahgPzwbl5R-II4VF4aOPDXo5ZZd3w>
    <xmx:DmsbaDguk06LIDKpr2iXStgQ7HcUikU_bqiZ7kcltQ83ifTgwp4etQ>
    <xmx:DmsbaITudrqbvEi8B0RwNc-FU33P2wFe80X2mu8VQvfuJKYdyOKgf7gl>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 10:15:42 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id DF5BE1189EA3;
	Wed, 07 May 2025 10:15:41 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] vt: move glyph determination to a separate function
Date: Wed,  7 May 2025 10:13:18 -0400
Message-ID: <20250507141535.40655-4-nico@fluxnic.net>
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

No logical changes. Make it easier for enhancements to come.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c | 71 ++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 58fa1b285f22..556af82a9231 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2925,6 +2925,7 @@ static void vc_con_rewind(struct vc_data *vc)
 
 #define UCS_ZWS		0x200b	/* Zero Width Space */
 #define UCS_VS16	0xfe0f	/* Variation Selector 16 */
+#define UCS_REPLACEMENT	0xfffd	/* Replacement Character */
 
 static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 {
@@ -2984,12 +2985,38 @@ static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 	return 0;
 }
 
+static int vc_get_glyph(struct vc_data *vc, int tc)
+{
+	int glyph = conv_uni_to_pc(vc, tc);
+	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+
+	if (!(glyph & ~charmask))
+		return glyph;
+
+	if (glyph == -1)
+		return -1; /* nothing to display */
+
+	/* Glyph not found */
+	if ((!vc->vc_utf || vc->vc_disp_ctrl || tc < 128) && !(tc & ~charmask)) {
+		/*
+		 * In legacy mode use the glyph we get by a 1:1 mapping.
+		 * This would make absolutely no sense with Unicode in mind, but do this for
+		 * ASCII characters since a font may lack Unicode mapping info and we don't
+		 * want to end up with having question marks only.
+		 */
+		return tc;
+	}
+
+	/* Display U+FFFD (Unicode Replacement Character). */
+	return conv_uni_to_pc(vc, UCS_REPLACEMENT);
+}
+
 static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 		struct vc_draw_region *draw)
 {
 	int next_c;
 	unsigned char vc_attr = vc->vc_attr;
-	u16 himask = vc->vc_hi_font_mask, charmask = himask ? 0x1ff : 0xff;
+	u16 himask = vc->vc_hi_font_mask;
 	u8 width = 1;
 	bool inverse = false;
 
@@ -3000,39 +3027,17 @@ static int vc_con_write_normal(struct vc_data *vc, int tc, int c,
 	}
 
 	/* Now try to find out how to display it */
-	tc = conv_uni_to_pc(vc, tc);
-	if (tc & ~charmask) {
-		if (tc == -1)
-			return -1; /* nothing to display */
+	tc = vc_get_glyph(vc, tc);
+	if (tc == -1)
+		return -1; /* nothing to display */
+	if (tc < 0) {
+		inverse = true;
+		tc = conv_uni_to_pc(vc, '?');
+		if (tc < 0)
+			tc = '?';
 
-		/* Glyph not found */
-		if ((!vc->vc_utf || vc->vc_disp_ctrl || c < 128) &&
-				!(c & ~charmask)) {
-			/*
-			 * In legacy mode use the glyph we get by a 1:1
-			 * mapping.
-			 * This would make absolutely no sense with Unicode in
-			 * mind, but do this for ASCII characters since a font
-			 * may lack Unicode mapping info and we don't want to
-			 * end up with having question marks only.
-			 */
-			tc = c;
-		} else {
-			/*
-			 * Display U+FFFD. If it's not found, display an inverse
-			 * question mark.
-			 */
-			tc = conv_uni_to_pc(vc, 0xfffd);
-			if (tc < 0) {
-				inverse = true;
-				tc = conv_uni_to_pc(vc, '?');
-				if (tc < 0)
-					tc = '?';
-
-				vc_attr = vc_invert_attr(vc);
-				con_flush(vc, draw);
-			}
-		}
+		vc_attr = vc_invert_attr(vc);
+		con_flush(vc, draw);
 	}
 
 	next_c = c;
-- 
2.49.0

