Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444581;
	b=MgQcYe9DPtF7r2NmNUKDYgbI2CfDJmLED05Gn9girwqzIzbM9NWsdD5jhymUj5oMvyXR
	 AJzrZoALyUY3EgvMuMx+7V5qyYDKwQMuw5tVlLq42VdrVUXr3D0DfAEeEOPqkrgNHGCmd
	 w4jddayv4pX4DU3p1i0RxlddYqLwnMMbPEVzAhz6Ot3tYzVxlBmUOJX3qybj897EcCmME
	 Gig2ChnxClKyX3oRcBwUfQEjyGkPlEmP4i7Y20cZqX7Sqj27Y+60wB7lfGb5wXJQjeAnP
	 ir5Mattr5h/qxZanZ9fUj6bjvAPJDSJ5QtcGdPK1LwO7piSQ1qHQOsjCyI+VAFmLv4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444581;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RC1E6umfLomH1nFhSyYZirvMQSee+RINmiGAzynWQbc=;
	b=RF2iV1qKoLWxHrwK6dwq/5m/bKx2skSSPILtw2nRL9HhVM4bJY77+tUFt9DuhpajRkbv
	 WXJrdSf8J/TFdq5Wjj+FBcARsPUjoFIg2aLZAwFrhkk6ftQOJSEUDevSJc0eZKjutHHxZ
	 LiuD87T+OVH6GnMOIcIMAHxRa9Ojfe2wvmJ2fWIiATNClQhI12HqaKP/8z73tEawSR9Ua
	 Ybd8hKX2TP7n2KAUqJxqiBvawYTY/XslBKIk0CY8FWBHiwFHwN/spKzcuuWj0Z91I8UG8
	 wkC0MalaxfLYD1jQXOBQ6mxpY4EQIqiW06o4ccrL1BgKPg7m9J3ixHh/s1bSQOYB+Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fluxnic.net;
	spf=pass smtp.mailfrom=fluxnic.net;
	dkim=pass header.d=fluxnic.net header.i=@fluxnic.net header.a=rsa-sha256 header.s=fm2 header.b=ClaarH+h;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YvfMxoOG;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D08A606A31F
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 21:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D08A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fluxnic.net header.i=@fluxnic.net header.a=rsa-sha256 header.s=fm2 header.b=ClaarH+h;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YvfMxoOG
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC94C7A01F7
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 17:16:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 19 Oct 2026 17:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792444578;
	 x=1792530978; bh=RC1E6umfLomH1nFhSyYZirvMQSee+RINmiGAzynWQbc=; b=
	ClaarH+hsRMOt1kf+l6V4BHjfVuKIS1eTU4CD2YDYMAzzgKZ7k5fzgFfvaNQRS0q
	bNPR325PbgbjDzZ7d2FHVF/JB0Srysv2CEUmtvkWZHJlJE4t+YQMzIVsgYCwU3v/
	7euXUWY2IO7UCkhYKkN1XxjdsGMYlRpYvBlIKUSxYdS5ipDppaX0p2ks8Td7M9YF
	7YxA72phIg0xCQ4i8w5wbNwhQW1J2d6ZAIILA14OEQcfJ5Cq7n7sixz1Ymjoa38F
	jjCZMajHIpkNHUZRLMMPuLMFvEzJGUvWvqkoVD8VZH8QsmCByNTAPAYkBbppN0uU
	1evSchsUBs30uYM7KCcbNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792444578; x=
	1792530978; bh=RC1E6umfLomH1nFhSyYZirvMQSee+RINmiGAzynWQbc=; b=Y
	vfMxoOG0b/pLuCVAfDs658N7t42vxyzgXzAPLhl466ZwJ09ScmyBA1qfu1tSve+J
	aEUr10jFMoeGmYfBMineDjoKqJtqP01zrdusT+gR303KAd7URWi7jgn7/1FP04a0
	FhD7HeqsmxgqOe+7th0/ul97YbW8YGdnsPp0e9VuISlbcRpN/y1BieAd9XvMKpac
	ydhfExr5harYJb/LcWg5IIovUc+u4aOfv64k4dxrQGYcM7VezXlJUr27UU0lInC5
	Tm0bMUFWDEMS/AHbyqQpx/nHxsw9+hw/whFc4x1f1uQidGgrwJEul1DMwA3JtLIF
	lA9SFCZhaFsi1Zztxi0VA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fluxnic.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792444578; d=fluxnic.net;
	mf=PG5pY29AZmx1eG5pYy5uZXQ+;
	rt=PGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sf4O+rnVXH5b8e/9H+rVsy4g9DCQusicV2zDRdgMg9nkVEM
	fJtNZH7mO9XUGN7TtxPaVsAgQgTncGcEzV/qKnz0uX+DusoBMk+lbHK2avsWlriI
	9SYUAujMXZJXJgOjx0G0UbpLpZkJMoDN88FUS0VgYfVtAmxqUL/SuH8ojeZMpjvW
	XhGwaPp7eGZxogV13VCiym61ZnyEj8GCosUSQWEhj2lA45mDLb37ejWuOChdkn9a
	+q4WfwVr6HfpFqSYnXSmMkkZQM1dHbzv2zrqMdFtt5uHhvg7r4/o3SBnuXYvLs9m
	W9euPCK3Wyybqehb0Z5TP3iJVDtoMbZaRuA954A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DNS4vv1ji9DLXiRwmLAszR7n+DwI86lmFoFU20xbYx0=:6RSsl65YE1GDJ8PM6p1TVx5h5Eyg9SbZGcLlydsg1Vs=;
X-ME-Sender: <xms:oojWamr_7XsunPAnT2nV6VWG8ttI8VWYe-tPb6279ku1DohVlJP7PA>
    <xme:oojWamImKH9cV1rzLk7f3WDVZAnxa6gF8iYiLfXSx39QFPA9BVcZqP5k3WUNd25p8
    Wx8Ff2Bhv2n5Np0AmVsL1Wcepb35NuGlvIhRKRl5cyD5VcyDwkS6nuE>
X-ME-Received: <xmr:oojWarQgAspF8us82ycqq6fGIz_O1tRd1kx848acRbRD7ME0bBH4VrjXD5IXJePPtnqQcN4-DwqJvSWFr7GCs0WkgxI94fj8k1OwEZgx4XIgUR8>
X-ME-Proxy-Cause: dmFkZTEskaRpMmo5mA9eUzo2TboD98x/CxvN/POfGDE5/84InX+evMpVDYeBWnhQoI3j4+
    KvaDgKTXizcB/NLv0U1SBZ5nATEEXyhgFd6IA5N/rwJ8U/A4sw2lcFAYXx1+N9Gl3US3Jy
    sK6ZDquh1nUAg0XuJEUQRvbysbUpYqCqBKZQfeORo3ekbU9vTfiWIYs5/AdGWPr1PjFoMD
    8XOz5RKmZ0GNl4NZ3u2BYVcvWOMV932TGnQSjhrud/DaNIg7p14s7x7cnBaSUsfi7fP9rd
    TjR2nwirLkbLcb4lk94cx0kU2vxKMmmuHas4vcwbX7+uivWIW/7QBeBnPgQS0cXr9k1Wji
    UZmRLmH6+3ViiyKvLHAmScBolpd778g0I/fQWosYFzFXCfbn3DPe6hP107uvCOz/NHgjd8
    YgyOoud1Flrfm4sQwUiyWvA5N8HdEKUbSqdLNreT3SUlufssLpdFIDxGiH0ePtNHtK3eYJ
    kf0rA69OTYx+qQBushR4qfr6TmpA4WK8qUn/3aXxxrmWcRwuMxgZXl7U1hanLYQTvWFeYH
    EfqKCAaFmJMlvEkw9B3tqxnLbRitOXvfe7y8Qf1Ei1SaWWjAR2dvpz3AqrHisz3qORGSVv
    e7aJqWBL2WHsTGuvDWF2wlLhIfhHT5cB2STGZqMkfyz7Y3ogEAs6oEkQWBTQ
X-ME-Proxy: <xmx:oojWalv-NS78EBoHmWzpyKh8Hyay5kYORomNLF1pO4106lFGiJfziA>
    <xmx:oojWasZWoOsr8PYOkjfC7Mm8IPJyBnTieEBy3G4Qs5JFZRshJWC7XA>
    <xmx:oojWarEXNAvnhg9fMjrs4-dw775U69ZWaCOsSICeq011HzfkM-lMOg>
    <xmx:oojWagx3ZjBY0NXBZcVAfSn4m9rjibH5Yf88Mj9rkjfE3Gj97I9e7Q>
    <xmx:oojWamaF3Hjo4gFboa61zEX35c-I5Afe0uG4QuhOWnwGIA6lWS1qDIP0>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 17:16:18 -0400 (EDT)
Received: from xanadu.lan (_gateway [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id DA0BE2331A;
	Mon, 19 Oct 2026 17:16:17 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH 2/3] vt: add DEC private mode 2027 to control VS16 widening
Date: Mon, 19 Oct 2026 17:16:16 -0400
Message-ID: <76b7fb6634652a8670a4f03aa397f21ea57aa367.1792443833.git.npitre@baylibre.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

VS16 (U+FE0F) after a single-width character currently turns it into a
double-width one, giving emoji presentation sequences such as U+203C
U+FE0F (‼️) a square aspect.

There is no consensus on this among terminals. According to the
ucs-detect survey [1], these widen such sequences to 2 cells, as the
Linux console does:

  kitty, foot, Ghostty, Contour, Konsole, iTerm2, Windows Terminal,
  mintty, Rio, tmux (3.4)

while these keep them at 1 cell:

  xterm, VTE based terminals (GNOME Terminal, XFCE Terminal, ...),
  Alacritty, st, urxvt, Apple Terminal, GNU Screen, libvterm,
  xterm.js (WezTerm only partially widens)

On the application side, glibc's wcwidth() is per code point and
returns 0 for VS16, and so do the tools relying on it. Even vim, which
has its own emoji width table, counts U+203C U+FE0F as 1 column.

Applications that track the cursor position themselves therefore get
out of sync with a widening terminal. For example, mosh writes full
width rows and moves with relative CR/LF. A row containing ‼️ is one
column wider on the console than in mosh's model, so its last cell
wraps to the next line and the whole screen ends up scrolled by one.
Others are reconsidering widening by default too: tmux 3.6 added the
"variation-selector-always-wide" option to turn it off, and xterm's
emoji width handling is configurable.

DEC private mode 2027, from the Contour terminal's Unicode core
proposal [2], is meant to give applications this control. With it set,
VS16 promotes a grapheme cluster to emoji presentation and a width of 2
cells. With it reset, the behavior is left to the terminal. Contour,
Ghostty, foot and WezTerm implement it.

Make VS16 widening follow that mode. Applications, or the user before
starting them, can opt out with CSI ? 2027 l, in which case VS16 is
zero-width as wcwidth() says. Only the VS16 part of the proposal is
implemented here.

The initial and reset state of the mode comes from the new
vt.default_vs16_wide parameter, similar to vt.default_utf8. It
defaults to 1, preserving the existing behavior, and can be set to 0
on systems where applications relying on wcwidth() are the norm.

[1] https://ucs-detect.readthedocs.io/results.html
[2] https://github.com/contour-terminal/terminal-unicode-core

Assisted-by: LLM
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++++++++++
 drivers/tty/vt/vt.c                             | 15 ++++++++++++++-
 include/linux/console_struct.h                  |  1 +
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..983afb6c531e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -8451,6 +8451,16 @@ Kernel parameters
 			Default is 1, i.e. UTF-8 mode is enabled for all
 			newly opened terminals.
 
+	vt.default_vs16_wide=
+			[VT]
+			Format=<0|1>
+			Set system-wide default for whether VS16 (U+FE0F)
+			turns the preceding single-width character into a
+			double-width one, as in emoji presentation sequences.
+			This is the initial and reset state of DEC private
+			mode 2027 on all tty's, which applications can also
+			change with CSI ? 2027 h/l. Default is 1.
+
 	vt.global_cursor_default=
 			[VT]
 			Format=<-1|0|1>
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 335253aec549..4d5c9cabd058 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -166,6 +166,9 @@ EXPORT_SYMBOL(global_cursor_default);
 static int cur_default = CUR_UNDERLINE;
 module_param(cur_default, int, S_IRUGO | S_IWUSR);
 
+static bool default_vs16_wide = true;
+module_param(default_vs16_wide, bool, 0644);
+
 /*
  * ignore_poke: don't unblank the screen when things are typed.  This is
  * mainly for the privacy of braille terminal users.
@@ -1984,6 +1987,7 @@ enum {
 	CSI_DEC_hl_MOUSE_VT200	= 1000,
 	CSI_DEC_hl_ALT_SCREEN	= 1049,
 	CSI_DEC_hl_BRACKETED_PASTE = 2004,
+	CSI_DEC_hl_GRAPHEME_WIDTH = 2027,	/* VS16 widening */
 };
 
 /* console_lock is held */
@@ -2039,6 +2043,9 @@ static void csi_DEC_hl(struct vc_data *vc, bool on_off)
 		case CSI_DEC_hl_BRACKETED_PASTE:
 			vc->vc_bracketed_paste = on_off;
 			break;
+		case CSI_DEC_hl_GRAPHEME_WIDTH:
+			vc->vc_vs16_wide = on_off;
+			break;
 		case CSI_DEC_hl_ALT_SCREEN:
 			if (on_off)
 				enter_alt_screen(vc);
@@ -2284,6 +2291,7 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	vc->vc_decawm		= 1;
 	vc->vc_deccm		= global_cursor_default;
 	vc->vc_decim		= 0;
+	vc->vc_vs16_wide	= default_vs16_wide;
 
 	if (vc->vc_saved_screen != NULL) {
 		kfree(vc->vc_saved_screen);
@@ -3139,12 +3147,17 @@ static int vc_process_ucs(struct vc_data *vc, int *c, int *tc)
 
 	prev_c = vc_uniscr_getc(vc, -1);
 
-	if (curr_c == UCS_VS16 && prev_c != 0) {
+	if (curr_c == UCS_VS16 && prev_c != 0 && vc->vc_vs16_wide) {
 		/*
 		 * VS16 (U+FE0F) is special. It typically turns the preceding
 		 * single-width character into a double-width one. Let it
 		 * have a width of 1 effectively making the combination with
 		 * the preceding character double-width.
+		 *
+		 * This can be disabled with DEC private mode 2027 for
+		 * applications that compute widths per code point with
+		 * wcwidth(), where VS16 is always zero-width. Otherwise
+		 * they lose track of the cursor position.
 		 */
 		*tc = ' ';
 		return 1;
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index fe915afdece5..8a1031cd097e 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -167,6 +167,7 @@ struct vc_data {
 	unsigned int	vc_decawm	: 1;	/* Autowrap Mode */
 	unsigned int	vc_deccm	: 1;	/* Cursor Visible */
 	unsigned int	vc_decim	: 1;	/* Insert Mode */
+	unsigned int	vc_vs16_wide	: 1;	/* VS16 makes preceding char wide */
 	/* misc */
 	unsigned int	vc_priv		: 3;
 	unsigned int	vc_need_wrap	: 1;
-- 
2.55.0

