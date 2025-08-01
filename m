Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C1125B9;
	Fri,  1 Aug 2025 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036777; cv=none; b=NlMmSxoSVaCgfwhwRnqb8/PQSpVGyfnZD/45jzfwpHLrlQYR46JY45SVQapOCkgbKo93xtSmCpjmS3c5Hx3S+Kd7+K/THHNUVQ9AqUTRGcIGXBc+Wlcdrn6WRlOHMh4XG+EpN8umLcUu7YuxZltHjzb/ssUurtTwgZY2THfbFTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036777; c=relaxed/simple;
	bh=fRCi1qPRbtvD2/DgMMDR9l6f8BWnDMdK36GBpgIFDxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QB8aBficWBi1o+lAeU7ymYZ/GsUD9R6euyvYUt/SJzz3WSk4i0Hf0QmWT89VyztCvtZJX0zwXz77+qj3XaHpfSPrbZE+8oec3hWn4dUInBLIU9Yi0RSQ8+SFv5hD94pLGoaCe8tX/g7Cg4GwsCljsNWmLLQrJ5vT3b5DOCEpBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpqNnxIZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpqNnxIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA64C4CEE7;
	Fri,  1 Aug 2025 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754036776;
	bh=fRCi1qPRbtvD2/DgMMDR9l6f8BWnDMdK36GBpgIFDxs=;
	h=From:To:Cc:Subject:Date:From;
	b=KpqNnxIZD01F0fP0ZNnw/mBek+uTQJimo2t7dvNZTuz+TxlCDuOnubX70NwBsO9TX
	 7pdMLNq0ayVtP/o4I/f3OiU4hA+qqso41hQm30X2WpjFx4E0tSRWSs1Rzm/tJeEDSP
	 4FTL6QJYONQWy4b83UongMmhd80HV+DGPiB3seCSn+3kqBYT3vljVdTuoy8SL8lYMJ
	 pROC9FgJfw9OjWBGvSYMWCE6LWepsMOrboXGpCRQPrbmDKAwOuPDmMyIwnp1NMRHFT
	 PfJGrsumegOqPMDk3th+P4blvgUx+FHf6YjPyetsmCIp47qvoIdsJ/CCSeUCxCdmxH
	 m5CUK2zLHDE+Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] Revert "tty: vt: use _IO() to define ioctl numbers"
Date: Fri,  1 Aug 2025 10:26:13 +0200
Message-ID: <20250801082613.2564584-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit f1180ca37abe3d117e4a19be12142fe722612a7c. Since the
commit, the vt ioctl numbers are defined differently on platforms where
_IOC_NONE is non-zero: alpha, mips, powerpc, sparc.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/all/436489B9-E67B-4630-909F-386C30A2AAC9@xenosoft.de/
Link: https://lore.kernel.org/all/97ec2636-915a-498c-903b-d66957420d21@csgroup.eu/
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/uapi/linux/vt.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
index b60fcdfb2746..714483d68c69 100644
--- a/include/uapi/linux/vt.h
+++ b/include/uapi/linux/vt.h
@@ -14,9 +14,9 @@
 		/* Note: the ioctl VT_GETSTATE does not work for
 		   consoles 16 and higher (since it returns a short) */
 
-/* 'V' to avoid collision with termios and kd */
+/* 0x56 is 'V', to avoid collision with termios and kd */
 
-#define VT_OPENQRY		_IO('V', 0x00)	/* find available vt */
+#define VT_OPENQRY	0x5600	/* find available vt */
 
 struct vt_mode {
 	__u8 mode;		/* vt mode */
@@ -25,8 +25,8 @@ struct vt_mode {
 	__s16 acqsig;		/* signal to raise on acquisition */
 	__s16 frsig;		/* unused (set to 0) */
 };
-#define VT_GETMODE		_IO('V', 0x01)	/* get mode of active vt */
-#define VT_SETMODE		_IO('V', 0x02)	/* set mode of active vt */
+#define VT_GETMODE	0x5601	/* get mode of active vt */
+#define VT_SETMODE	0x5602	/* set mode of active vt */
 #define		VT_AUTO		0x00	/* auto vt switching */
 #define		VT_PROCESS	0x01	/* process controls switching */
 #define		VT_ACKACQ	0x02	/* acknowledge switch */
@@ -36,21 +36,21 @@ struct vt_stat {
 	__u16 v_signal;	/* signal to send */
 	__u16 v_state;		/* vt bitmask */
 };
-#define VT_GETSTATE		_IO('V', 0x03)	/* get global vt state info */
-#define VT_SENDSIG		_IO('V', 0x04)	/* signal to send to bitmask of vts */
+#define VT_GETSTATE	0x5603	/* get global vt state info */
+#define VT_SENDSIG	0x5604	/* signal to send to bitmask of vts */
 
-#define VT_RELDISP		_IO('V', 0x05)	/* release display */
+#define VT_RELDISP	0x5605	/* release display */
 
-#define VT_ACTIVATE		_IO('V', 0x06)	/* make vt active */
-#define VT_WAITACTIVE		_IO('V', 0x07)	/* wait for vt active */
-#define VT_DISALLOCATE		_IO('V', 0x08)  /* free memory associated to vt */
+#define VT_ACTIVATE	0x5606	/* make vt active */
+#define VT_WAITACTIVE	0x5607	/* wait for vt active */
+#define VT_DISALLOCATE	0x5608  /* free memory associated to vt */
 
 struct vt_sizes {
 	__u16 v_rows;		/* number of rows */
 	__u16 v_cols;		/* number of columns */
 	__u16 v_scrollsize;	/* number of lines of scrollback */
 };
-#define VT_RESIZE		_IO('V', 0x09)	/* set kernel's idea of screensize */
+#define VT_RESIZE	0x5609	/* set kernel's idea of screensize */
 
 struct vt_consize {
 	__u16 v_rows;	/* number of rows */
@@ -60,10 +60,10 @@ struct vt_consize {
 	__u16 v_vcol;	/* number of pixel columns on screen */
 	__u16 v_ccol;	/* number of pixel columns per character */
 };
-#define VT_RESIZEX		_IO('V', 0x0A)  /* set kernel's idea of screensize + more */
-#define VT_LOCKSWITCH		_IO('V', 0x0B)  /* disallow vt switching */
-#define VT_UNLOCKSWITCH		_IO('V', 0x0C)  /* allow vt switching */
-#define VT_GETHIFONTMASK	_IO('V', 0x0D)  /* return hi font mask */
+#define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + more */
+#define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
+#define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
+#define VT_GETHIFONTMASK 0x560D  /* return hi font mask */
 
 struct vt_event {
 	__u32 event;
@@ -77,14 +77,14 @@ struct vt_event {
 	__u32 pad[4];		/* Padding for expansion */
 };
 
-#define VT_WAITEVENT		_IO('V', 0x0E)	/* Wait for an event */
+#define VT_WAITEVENT	0x560E	/* Wait for an event */
 
 struct vt_setactivate {
 	__u32 console;
 	struct vt_mode mode;
 };
 
-#define VT_SETACTIVATE		_IO('V', 0x0F)	/* Activate and set the mode of a console */
+#define VT_SETACTIVATE	0x560F	/* Activate and set the mode of a console */
 
 /* get console size and cursor position */
 struct vt_consizecsrpos {
-- 
2.50.1

