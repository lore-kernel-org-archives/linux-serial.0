Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444580;
	b=z7f0EGNJhE+oFNiUM6R4rhQH78DyVfG6xrS50a1CG65couRnr11d85dkzTflSBgU64yP
	 zfSw4dUkc5OOSTJHyF27am9q7ippNHS+Cds8B8cI128LunK44gURX+ujskRzj8Z5mCQzs
	 ZWBH2bzToqXXtiqWT26xFSOIortWmhwWBc8NM16zgFHpqNt2m1Hqlt6H8BLxRSOLPVny8
	 rMfDM7UVaaV7Bh5FhWf65yOoYB56QpsbEUWQ/o88twwoXdaM9Hl+PcM+8hBGMf88nK91q
	 LY/CX1IUZy6+YkeSdWvMo90p+Hyek8deQ98clMbDT0eI+I7DDpaJaigTfyiRBQhuukg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444580;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+VxzWuvnA+V3BE3KwZmHCg52Qh/sYxSOOvdX43I3wdw=;
	b=K98Lowg+vl4PgduMH6kqlCx45hAcjvvYXu9MVzB9Geji2YZyGrwfdRNNT1AlrKh4TBkd
	 Ex2XDR4Yq1+G2ryEgSJDlfOQVO6wdiRr1UeSLgTutuxaMU2M7/78DQLC3Fpdr9mjbFXSf
	 iFze6cFRa+ZbiSjAMc4hi4hCY5rMmYVafKPBdThSKSIcALYhshoT0WC4Bi3pHYVY8BjR4
	 KRsA+55vIgZ5aQ+BhAEaNG/0bOKvgA1ZC/OBaBXAzlMxzEbJOcd1WkCpGR0K4q0HUWY/S
	 w0W+YC59YT3iDvqnPM7VzzSnMUb/kEgoCyUCqlqWqwUqfWhNXn2mMe4ljRG3yIqykJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fluxnic.net;
	spf=pass smtp.mailfrom=fluxnic.net;
	dkim=pass header.d=fluxnic.net header.i=@fluxnic.net header.a=rsa-sha256 header.s=fm2 header.b=z7qYBQi4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XScH0lWX;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE7606A31E
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 21:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CFE7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fluxnic.net header.i=@fluxnic.net header.a=rsa-sha256 header.s=fm2 header.b=z7qYBQi4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XScH0lWX
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C0B567A01FA
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 17:16:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 17:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1792444578; x=
	1792530978; bh=+VxzWuvnA+V3BE3KwZmHCg52Qh/sYxSOOvdX43I3wdw=; b=z
	7qYBQi4yKtrddauaPcLdhOmChsnyBSteIiazxnNHr4RbZr5yR33dM+3uIOnn7aMJ
	Y2BInv2mNTDc9A1SBQ7x6hMdZ8fLMNDkDDVwNfEDjQmQaIFK46M5u0l4acB1Nns3
	B+lklk5CrX7PdjMmFDzAsT1W1ozJZSfIvGRQPH48W+3n48CTDEqfsVM+KeU+ENjt
	bzYxXJhNXLf44eGe1+ihXKz5k0YkwFNWamNAgS4f3aTr4gAagrUH5d92rPzliRM1
	aC7BbvSLVg2y/eaf+BKAnXA6KmRKJ7vUaRpBtoCYr0j1fDQFs4nt7GENF9JMsKrL
	vA+1EuZCOXmW54uPkl84A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792444578; x=1792530978; bh=+
	VxzWuvnA+V3BE3KwZmHCg52Qh/sYxSOOvdX43I3wdw=; b=XScH0lWXdF7Ub2Me6
	5sfiMkQ7ODFn3Y9Ikv3n4nmAirSSW9I9pk5MJbpw9TnyoYPMGv4Uc+g6sU1s//qJ
	6zzxPD8PnGltEBzCN6TipKo5na95DiCG3HWggnppncsdkglI7KIYkfTBeL5kWYMC
	Bsz8wVTnFY4HwzTu2G+0lPGqBfZonWM3Xb8wvjigMSa74nQhoOevl4cw1j6NZfAm
	yy6A+v8Ro/mYhqRbhM+z8UqzzFQRefwxV3ECOYuoKnaJhdG5ZC4LgmhThsoTCsN1
	TirmbTfoIFOCorq1CGSStfsR6b2GSHHtAr0l+uTU876PD+/Gty94FrwcxaMbawjx
	xXjyA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fluxnic.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792444578; d=fluxnic.net;
	mf=PG5pY29AZmx1eG5pYy5uZXQ+;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:EsuEdAZwGNJ69NSQcQH8SdvOsN9AA+sG0pt73xR1DhqUn4N
	V3Hj5N+XFyjeOkU5FefLcylS6fYtp7xVcGIPdEnjreQzjHOh0gGBvFI2SKc8i39B
	gibNyKD2NCZI1/yH+pLmiGa9UnuvCgskO7CjufXt23ztAeFYQfg0oEWKdCDJ/MsY
	XD9D7GlNmu8FUTv8xKec/ElmuGfDhHHY86VfbclXtvzhmyv57x//J+G9qioXFCk7
	KW9zFBnLMRWpKsZ/VfGbYXMstbNlUQnqgJvTGAc4VAZ5ZAphZ0A1pUTvwLjeNGQN
	besUv7lLxdhYnnICh+6RTKVIzhwl/+7vugBCOVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:utB6vBsOBci+IYFCHJKRhuLOYM32k94sv1Q0YAU02uI=:qgeHQPMKljJtP4SqpcnVkaCEjQeJYK9Jyq1liX7PUok=;
X-ME-Sender: <xms:oojWarl3XLSCu1uTkoR_cHDelIk5UzTRG_Hyzwz0lqTUE0mV0CxIMQ>
    <xme:oojWagVaHDF_yij0QShuD4hVbsQwSrLeyd-kQ-yAcc2b2N2Esdd9iHKFOGXjz1GdR
    lDmh7CHFwuqlVjDHDL5nppYOx61nLDVKbcR7M0JjgxlrXS5gzANfXo>
X-ME-Received: <xmr:oojWahuPpOnzDHCm8s7Sn6FDVYZNkoG0dwRZlB22lL1sTWZBqOmSfb50AJSg5c8F6dWalQ-T85ZtgXRI1AMhwWD3Tby4OEBRwhFJuLdaZbaom1A>
X-ME-Proxy-Cause: dmFkZTF/vnGH0ScjvaxYxr+nv3rutIYng+eq1vxPiBPKiE3JZvmH65b3P8DmdCRPD7IBeK
    ugrAkzbPG9SBPGIZZDEhXEU7X6KDMKyBnLklQSkB1UxyewQvB6HLrWMnvG34mk3U2/2Ceq
    L779tVQ95/2tM/emuq54ysohR+3E+imrKQaInlUmEBa8mAQxiOo4HIqcAwsbbNTM5yXiuV
    /covjUzx/4rs6/hTGjpWVRBDT59UFTYfH6YGC/8gtytJybgRnCtj6Rx8PG6DPhxg+tN+2E
    gOb84bpauyj4Op6Vy1u5U1c6FIwS/0yons6lWFB7uL6EU0nvV63APo2Fi9pO9x4+KwyXi0
    2c1TLscqcMiyRZUFzddNaX0dRDzjREMEvynQGJfhp6DdCVFMTIr/NVguOw9eSmqVyNxqsn
    LRIV9CnepVsp7cInQv16NklAvX1i9kuP36bIH1Xj22PvhffQACTtkX33gSMme8a17A6kq+
    dKxgZqGRBOe1rdILAfedvI28xS+4pDM3WAEnW8wRGmxEoeuwR6+dWeaHgGiNJcWDwTNupn
    3u6K8XhrzRJqWpnZwk7aPOyYX8OFFNtWY2JPbzzd5KAg8LndkSQONNl1BeoTklffR4q0k3
    /ACDPg3iyeRALDzZKevWV83roOsq1UHM22mH6O7i+M8TNLzWXAhvCSL1an7g
X-ME-Proxy: <xmx:oojWajaKg64JYaf_xYRtMm4WfQrrsNgQHtM63Gm1pGXKceVcPKYmIA>
    <xmx:oojWagWlLxBiDLQOQzMLIh6XhIF3gvip6uyqSzo7tftVOm7VFqoT6Q>
    <xmx:oojWaoQCmSANb90FZwBoyoGpwQ6FuYCQYjkPvAgJtMkVKJR_F8LtXw>
    <xmx:oojWauME3Gtr6uW7oymdqk4hpOYxxpi927vFrwb-FUc6b2ljA2dnuw>
    <xmx:oojWarGP8cxq-TLhjhct8YdTx5dHe520iI1O4hbHn_F8nB_-mjJulmvV>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 17:16:18 -0400 (EDT)
Received: from xanadu.lan (_gateway [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id DEB5B2331B;
	Mon, 19 Oct 2026 17:16:17 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH 3/3] vt: add DECRQM support to report mode states
Date: Mon, 19 Oct 2026 17:16:17 -0400
Message-ID: <ec7608275b930b9c31c1e08881b9984bc982a6a8.1792443833.git.npitre@baylibre.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792443833.git.npitre@baylibre.com>
References: <cover.1792443833.git.npitre@baylibre.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

Applications currently have no way to find out whether the VT supports
a given mode, nor what its current state is. DECRQM, "CSI Ps $ p" for
ANSI modes and "CSI ? Ps $ p" for DEC private modes, is the standard
query for this. But the '$' intermediate makes the parser ignore the
whole sequence, leaving applications waiting for a reply that never
comes.

This matters especially for mode 2027, whose specification relies on
DECRQM for applications to detect support before enabling it.

Add an ESdollar parser state for "CSI parameters $", and answer a final
'p' with DECRPM, "CSI [?] Ps ; Pm $ y", where Pm is 1 (set), 2 (reset),
0 (not recognized) or 4 (permanently reset). All modes handled by
csi_DEC_hl() and csi_hl() are reported, with 132-column mode reported
as permanently reset since it isn't implemented. Other sequences using
the '$' intermediate are still ignored.

Assisted-by: LLM
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt.c | 90 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4d5c9cabd058..22dfab8de7bc 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2083,6 +2083,82 @@ static void csi_hl(struct vc_data *vc, bool on_off)
 		}
 }
 
+/* DECRPM mode states */
+enum {
+	DECRPM_NOT_RECOGNIZED	= 0,
+	DECRPM_SET		= 1,
+	DECRPM_RESET		= 2,
+	DECRPM_PERMANENTLY_RESET = 4,
+};
+
+static int decrpm_state(bool set)
+{
+	return set ? DECRPM_SET : DECRPM_RESET;
+}
+
+/* State of a DEC private mode as handled by csi_DEC_hl() */
+static int csi_DEC_mode(struct vc_data *vc, unsigned int mode)
+{
+	switch (mode) {
+	case CSI_DEC_hl_CURSOR_KEYS:
+		return decrpm_state(is_kbd(vc, decckm));
+	case CSI_DEC_hl_132_COLUMNS:
+		return DECRPM_PERMANENTLY_RESET;
+	case CSI_DEC_hl_REVERSE_VIDEO:
+		return decrpm_state(vc->vc_decscnm);
+	case CSI_DEC_hl_ORIGIN_MODE:
+		return decrpm_state(vc->vc_decom);
+	case CSI_DEC_hl_AUTOWRAP:
+		return decrpm_state(vc->vc_decawm);
+	case CSI_DEC_hl_AUTOREPEAT:
+		return decrpm_state(is_kbd(vc, decarm));
+	case CSI_DEC_hl_MOUSE_X10:
+		return decrpm_state(vc->vc_report_mouse == 1);
+	case CSI_DEC_hl_SHOW_CURSOR:
+		return decrpm_state(vc->vc_deccm);
+	case CSI_DEC_hl_MOUSE_VT200:
+		return decrpm_state(vc->vc_report_mouse == 2);
+	case CSI_DEC_hl_ALT_SCREEN:
+		return decrpm_state(vc->vc_saved_screen != NULL);
+	case CSI_DEC_hl_BRACKETED_PASTE:
+		return decrpm_state(vc->vc_bracketed_paste);
+	case CSI_DEC_hl_GRAPHEME_WIDTH:
+		return decrpm_state(vc->vc_vs16_wide);
+	}
+	return DECRPM_NOT_RECOGNIZED;
+}
+
+/* State of an ANSI mode as handled by csi_hl() */
+static int csi_ANSI_mode(struct vc_data *vc, unsigned int mode)
+{
+	switch (mode) {
+	case CSI_hl_DISPLAY_CTRL:
+		return decrpm_state(vc->vc_disp_ctrl);
+	case CSI_hl_INSERT:
+		return decrpm_state(vc->vc_decim);
+	case CSI_hl_AUTO_NL:
+		return decrpm_state(is_kbd(vc, lnm));
+	}
+	return DECRPM_NOT_RECOGNIZED;
+}
+
+/*
+ * DECRQM: request mode, "CSI Ps $ p" for ANSI modes and "CSI ? Ps $ p" for
+ * DEC private modes. Reply with DECRPM: "CSI [?] Ps ; Pm $ y".
+ */
+/* console_lock is held */
+static void csi_RQM(struct tty_struct *tty, struct vc_data *vc)
+{
+	unsigned int mode = vc->vc_par[0];
+	bool dec = vc->vc_priv == EPdec;
+	char buf[32];
+	int len;
+
+	len = snprintf(buf, sizeof(buf), "\033[%s%u;%d$y", dec ? "?" : "",
+		       mode, dec ? csi_DEC_mode(vc, mode) : csi_ANSI_mode(vc, mode));
+	respond_string(buf, len, tty->port);
+}
+
 enum CSI_right_square_bracket {
 	CSI_RSB_COLOR_FOR_UNDERLINE		= 1,
 	CSI_RSB_COLOR_FOR_HALF_BRIGHT		= 2,
@@ -2233,6 +2309,7 @@ static void restore_cur(struct vc_data *vc)
  * @ESsetG1:		ESC ) parsed
  * @ESpercent:		ESC % parsed
  * @EScsiignore:	CSI [0x20-0x3f] parsed
+ * @ESdollar:		CSI parameters $ parsed -- final char expected
  * @ESnonstd:		OSC parsed
  * @ESpalette:		OSC P parsed
  * @ESosc:		OSC [0-9] parsed
@@ -2254,6 +2331,7 @@ enum vc_ctl_state {
 	ESsetG1,
 	ESpercent,
 	EScsiignore,
+	ESdollar,
 	ESnonstd,
 	ESpalette,
 	ESosc,
@@ -2788,6 +2866,9 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 			vc->vc_par[vc->vc_npar] *= 10;
 			vc->vc_par[vc->vc_npar] += c - '0';
 			return;
+		case '$':
+			vc->vc_state = ESdollar;
+			return;
 		}
 		if (c >= ASCII_CSI_IGNORE_FIRST && c <= ASCII_CSI_IGNORE_LAST) {
 			vc->vc_state = EScsiignore;
@@ -2846,6 +2927,15 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 			return;
 		vc->vc_state = ESnormal;
 		return;
+	case ESdollar:	/* CSI parameters $, final char expected */
+		if (c >= ASCII_CSI_IGNORE_FIRST && c <= ASCII_CSI_IGNORE_LAST) {
+			vc->vc_state = EScsiignore;
+			return;
+		}
+		vc->vc_state = ESnormal;
+		if (c == 'p' && (vc->vc_priv == EPdec || vc->vc_priv == EPecma))
+			csi_RQM(tty, vc);
+		return;
 	case ESpercent:	/* ESC % */
 		vc->vc_state = ESnormal;
 		switch (c) {
-- 
2.55.0

