Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2D262FDD;
	Wed, 11 Jun 2025 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636219; cv=none; b=npMMzx4zF5ut5lHoyKfN/127Ywkjzi4kXp+J6ZChyzoPsLpYDQbwpy8UemUYCd7E0bRaf8MAqmym7iC0no1AWGJc0D5CXybjjdicrcmzFZM0VYQ+cx4mhMV7qvlnp+glFzswDt/hVpneWAPIgfdeKOXmxgo0mQC87mYR19rE7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636219; c=relaxed/simple;
	bh=5Q0CjVoicAIw0CDdGWTMCIuANCo4rMmJyghB0nFaP1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9ZDHcSD2ysGIfk0jbwSMHm3y3YZuw13LkB5fBTS8OtzCucrkrRPRn7BEHXJ5LB6b5iMiJAVYsjhaJXMZp4XkXII3fuc57pXc34AiSTFIot4svikiMgnEcbb9Fyz3LGnqDVYredTj5a1WXgYxye40MSmbLJcD2gjCrtgchdCd54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOplSrJd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOplSrJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CE1C4CEEE;
	Wed, 11 Jun 2025 10:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636217;
	bh=5Q0CjVoicAIw0CDdGWTMCIuANCo4rMmJyghB0nFaP1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOplSrJd9ABgii074v4h7w8xZcMHgkS4jAd4Flp6KNdVqWwLyH9u1pBHyS7Qitu+T
	 9LCDjr46Eb1MvWP8QUHWzO7a8sWxjhDcLuyWcE0iloXKFD3MJoURyp9NaYnHuQd5uW
	 AskGJLSerSGHW0LFUl2GgTnMt12/6yBgj68kJG/MK9sqzCNcjmfa4PRwvxJJq4eShl
	 n5wDmRyEr/x48q71ifIVGnTuwiaUM4bLpTqil83uBZ6Oke9xCDvem9QMr/pswth2Tf
	 AiMbedhAJx8nuKmumqXUN3y0RHdpO+BlKSQQbTirJ3CWj2WmFjrkre2ZLK5G2Q8DOW
	 QyS4zbEX35KZw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 06/33] tty: vt: use sane types for userspace API
Date: Wed, 11 Jun 2025 12:02:52 +0200
Message-ID: <20250611100319.186924-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100319.186924-1-jirislaby@kernel.org>
References: <20250611100319.186924-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed earlier (see the Link below), use the preferred ioctl types
in vt.h (__u8, __u16, ...).

These types are already used for the new VT_GETCONSIZECSRPOS.
Therefore, the necessary includes are already present. Since now, the
types are used for every structure defined in the header now.

Note the kernel is built with -funsigned-char, therefore 'char' becomes
'__u8' in here.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
Link: https://lore.kernel.org/all/p7p83sq1-4ro2-o924-s9o2-30spr74n076o@syhkavp.arg/
---
 include/uapi/linux/vt.h | 44 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
index e5b0c492aa18..714483d68c69 100644
--- a/include/uapi/linux/vt.h
+++ b/include/uapi/linux/vt.h
@@ -19,11 +19,11 @@
 #define VT_OPENQRY	0x5600	/* find available vt */
 
 struct vt_mode {
-	char mode;		/* vt mode */
-	char waitv;		/* if set, hang on writes if not active */
-	short relsig;		/* signal to raise on release req */
-	short acqsig;		/* signal to raise on acquisition */
-	short frsig;		/* unused (set to 0) */
+	__u8 mode;		/* vt mode */
+	__u8 waitv;		/* if set, hang on writes if not active */
+	__s16 relsig;		/* signal to raise on release req */
+	__s16 acqsig;		/* signal to raise on acquisition */
+	__s16 frsig;		/* unused (set to 0) */
 };
 #define VT_GETMODE	0x5601	/* get mode of active vt */
 #define VT_SETMODE	0x5602	/* set mode of active vt */
@@ -32,9 +32,9 @@ struct vt_mode {
 #define		VT_ACKACQ	0x02	/* acknowledge switch */
 
 struct vt_stat {
-	unsigned short v_active;	/* active vt */
-	unsigned short v_signal;	/* signal to send */
-	unsigned short v_state;		/* vt bitmask */
+	__u16 v_active;	/* active vt */
+	__u16 v_signal;	/* signal to send */
+	__u16 v_state;		/* vt bitmask */
 };
 #define VT_GETSTATE	0x5603	/* get global vt state info */
 #define VT_SENDSIG	0x5604	/* signal to send to bitmask of vts */
@@ -46,19 +46,19 @@ struct vt_stat {
 #define VT_DISALLOCATE	0x5608  /* free memory associated to vt */
 
 struct vt_sizes {
-	unsigned short v_rows;		/* number of rows */
-	unsigned short v_cols;		/* number of columns */
-	unsigned short v_scrollsize;	/* number of lines of scrollback */
+	__u16 v_rows;		/* number of rows */
+	__u16 v_cols;		/* number of columns */
+	__u16 v_scrollsize;	/* number of lines of scrollback */
 };
 #define VT_RESIZE	0x5609	/* set kernel's idea of screensize */
 
 struct vt_consize {
-	unsigned short v_rows;	/* number of rows */
-	unsigned short v_cols;	/* number of columns */
-	unsigned short v_vlin;	/* number of pixel rows on screen */
-	unsigned short v_clin;	/* number of pixel rows per character */
-	unsigned short v_vcol;	/* number of pixel columns on screen */
-	unsigned short v_ccol;	/* number of pixel columns per character */
+	__u16 v_rows;	/* number of rows */
+	__u16 v_cols;	/* number of columns */
+	__u16 v_vlin;	/* number of pixel rows on screen */
+	__u16 v_clin;	/* number of pixel rows per character */
+	__u16 v_vcol;	/* number of pixel columns on screen */
+	__u16 v_ccol;	/* number of pixel columns per character */
 };
 #define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + more */
 #define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
@@ -66,21 +66,21 @@ struct vt_consize {
 #define VT_GETHIFONTMASK 0x560D  /* return hi font mask */
 
 struct vt_event {
-	unsigned int event;
+	__u32 event;
 #define VT_EVENT_SWITCH		0x0001	/* Console switch */
 #define VT_EVENT_BLANK		0x0002	/* Screen blank */
 #define VT_EVENT_UNBLANK	0x0004	/* Screen unblank */
 #define VT_EVENT_RESIZE		0x0008	/* Resize display */
 #define VT_MAX_EVENT		0x000F
-	unsigned int oldev;		/* Old console */
-	unsigned int newev;		/* New console (if changing) */
-	unsigned int pad[4];		/* Padding for expansion */
+	__u32 oldev;		/* Old console */
+	__u32 newev;		/* New console (if changing) */
+	__u32 pad[4];		/* Padding for expansion */
 };
 
 #define VT_WAITEVENT	0x560E	/* Wait for an event */
 
 struct vt_setactivate {
-	unsigned int console;
+	__u32 console;
 	struct vt_mode mode;
 };
 
-- 
2.49.0

