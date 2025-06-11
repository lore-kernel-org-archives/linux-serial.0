Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CAA262FDF;
	Wed, 11 Jun 2025 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636219; cv=none; b=OcCkGkZdP7OyJt8VcnZ2ApYCMWHA3Umcy6iToSLcHZH3fO6MXMMtnpWOj3dJzG+AxTZL/0AgjpvrlhvuRaPsV3ioFuSTpxCN9eb9PBzQS6m52NaB592X5yodxcQnlOJ7XWSpujlSSnhtFe1LqaOu/IlK4OjwWQtWIOlAT0NmngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636219; c=relaxed/simple;
	bh=VGXfIDzE2QNN2PICBkzKgVdMlq8Xdmxeh79OvSTS4Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKcbcq4CiAyyQPP7a/AL9sX42tofUnrXTBKd2/YkVbdeNbdIX8YNfFNtZRHKosPW4egek51AXnXl9Bl8oHr+QRjCKiv+CF1YIIZEpT4gnyiO6Pv7CdhLJD0NuHXqfPh5JteyNvZ/OOIiitDXWWIul5WR2WQANiBZNARpvKFv9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBP+po5F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBP+po5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F402C4CEF1;
	Wed, 11 Jun 2025 10:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636219;
	bh=VGXfIDzE2QNN2PICBkzKgVdMlq8Xdmxeh79OvSTS4Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBP+po5FrOngYY8KfC+BWJK4n+Nwghk3WZvyldHV2CMjWPhvaV8a+GcWhhaoa6eO9
	 PXSGR8LEVubAh/KVTNQ0Q3lco5MZ/Nzytvjq7xmPxlFVUi/S+hlN9b5a7PB04h8jz3
	 21nHFahYX/Z+V3ByqFUf2Rte5dbm00a2t43TPZnwqVpZQpZXz9wZWMlKjvQOU+zd+R
	 PfwAWk8bPpGdQu+5DUsbaslsP1wn1DO4IbxPEIye4hWod3ulC8wHdGRiE4urhwUrrX
	 wM5RKhc4nfBHGnQ6X9HPgPHWbLpNFi6yEsteO3cdfbCYXLe2m3gCJjojzvLkqh0L9y
	 6mlfI7zvX6x5A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 07/33] tty: vt: use _IO() to define ioctl numbers
Date: Wed, 11 Jun 2025 12:02:53 +0200
Message-ID: <20250611100319.186924-8-jirislaby@kernel.org>
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

_IO*() is the proper way of defining ioctl numbers. All these vt numbers
were synthetically built up the same way the _IO() macro does.

So instead of implicit hex numbers, use _IO() properly.

To not change the pre-existing numbers, use only _IO() (and not _IOR()
or _IOW()). The latter would change the numbers indeed.

Objdump of vt_ioctl.o reveals no difference with this patch.

Again, VT_GETCONSIZECSRPOS already uses _IOR(), so everything is paved
for this patch.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 include/uapi/linux/vt.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
index 714483d68c69..b60fcdfb2746 100644
--- a/include/uapi/linux/vt.h
+++ b/include/uapi/linux/vt.h
@@ -14,9 +14,9 @@
 		/* Note: the ioctl VT_GETSTATE does not work for
 		   consoles 16 and higher (since it returns a short) */
 
-/* 0x56 is 'V', to avoid collision with termios and kd */
+/* 'V' to avoid collision with termios and kd */
 
-#define VT_OPENQRY	0x5600	/* find available vt */
+#define VT_OPENQRY		_IO('V', 0x00)	/* find available vt */
 
 struct vt_mode {
 	__u8 mode;		/* vt mode */
@@ -25,8 +25,8 @@ struct vt_mode {
 	__s16 acqsig;		/* signal to raise on acquisition */
 	__s16 frsig;		/* unused (set to 0) */
 };
-#define VT_GETMODE	0x5601	/* get mode of active vt */
-#define VT_SETMODE	0x5602	/* set mode of active vt */
+#define VT_GETMODE		_IO('V', 0x01)	/* get mode of active vt */
+#define VT_SETMODE		_IO('V', 0x02)	/* set mode of active vt */
 #define		VT_AUTO		0x00	/* auto vt switching */
 #define		VT_PROCESS	0x01	/* process controls switching */
 #define		VT_ACKACQ	0x02	/* acknowledge switch */
@@ -36,21 +36,21 @@ struct vt_stat {
 	__u16 v_signal;	/* signal to send */
 	__u16 v_state;		/* vt bitmask */
 };
-#define VT_GETSTATE	0x5603	/* get global vt state info */
-#define VT_SENDSIG	0x5604	/* signal to send to bitmask of vts */
+#define VT_GETSTATE		_IO('V', 0x03)	/* get global vt state info */
+#define VT_SENDSIG		_IO('V', 0x04)	/* signal to send to bitmask of vts */
 
-#define VT_RELDISP	0x5605	/* release display */
+#define VT_RELDISP		_IO('V', 0x05)	/* release display */
 
-#define VT_ACTIVATE	0x5606	/* make vt active */
-#define VT_WAITACTIVE	0x5607	/* wait for vt active */
-#define VT_DISALLOCATE	0x5608  /* free memory associated to vt */
+#define VT_ACTIVATE		_IO('V', 0x06)	/* make vt active */
+#define VT_WAITACTIVE		_IO('V', 0x07)	/* wait for vt active */
+#define VT_DISALLOCATE		_IO('V', 0x08)  /* free memory associated to vt */
 
 struct vt_sizes {
 	__u16 v_rows;		/* number of rows */
 	__u16 v_cols;		/* number of columns */
 	__u16 v_scrollsize;	/* number of lines of scrollback */
 };
-#define VT_RESIZE	0x5609	/* set kernel's idea of screensize */
+#define VT_RESIZE		_IO('V', 0x09)	/* set kernel's idea of screensize */
 
 struct vt_consize {
 	__u16 v_rows;	/* number of rows */
@@ -60,10 +60,10 @@ struct vt_consize {
 	__u16 v_vcol;	/* number of pixel columns on screen */
 	__u16 v_ccol;	/* number of pixel columns per character */
 };
-#define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + more */
-#define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
-#define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
-#define VT_GETHIFONTMASK 0x560D  /* return hi font mask */
+#define VT_RESIZEX		_IO('V', 0x0A)  /* set kernel's idea of screensize + more */
+#define VT_LOCKSWITCH		_IO('V', 0x0B)  /* disallow vt switching */
+#define VT_UNLOCKSWITCH		_IO('V', 0x0C)  /* allow vt switching */
+#define VT_GETHIFONTMASK	_IO('V', 0x0D)  /* return hi font mask */
 
 struct vt_event {
 	__u32 event;
@@ -77,14 +77,14 @@ struct vt_event {
 	__u32 pad[4];		/* Padding for expansion */
 };
 
-#define VT_WAITEVENT	0x560E	/* Wait for an event */
+#define VT_WAITEVENT		_IO('V', 0x0E)	/* Wait for an event */
 
 struct vt_setactivate {
 	__u32 console;
 	struct vt_mode mode;
 };
 
-#define VT_SETACTIVATE	0x560F	/* Activate and set the mode of a console */
+#define VT_SETACTIVATE		_IO('V', 0x0F)	/* Activate and set the mode of a console */
 
 /* get console size and cursor position */
 struct vt_consizecsrpos {
-- 
2.49.0

