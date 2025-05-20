Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688472B9A9;
	Tue, 20 May 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761538; cv=none; b=J/SHJRvkRUVMN81JfJ6h+7b/nGh1JwEbnFkFrG63KlYBWZjKQ76SLP9BrNMMgjkgU5NSc0YC3I2plFN5/Y+iJsSokcKA/YqjAeUpEAwUWJqcxyf2lf3gNpqpd2JYVFDwgocCRQh95urHuX+W84fEVU2dBgO3mL7psI5wJmIlZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761538; c=relaxed/simple;
	bh=ACfNSwmkzssroJJcZP4EuRX43gpzxLxxSbrVcgjG9CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2hZBctwGE33VuGx7mokGTG0NYxAi8mZKqfBUHKoNPte6pGziQybcHWJzStAtOce9KvFX92bDGQMm1kck3lGpbxJbjaF1DaNv2+9xJRRV1tdUTP67XsSDy7PWcPZMyj9Tkizb69typ/sm9bfRlyy2yuZYqZ3Li9npjZ5VnodIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=E4LmKGGG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FoyI5tUy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="E4LmKGGG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FoyI5tUy"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A009E138045A;
	Tue, 20 May 2025 13:18:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 20 May 2025 13:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1747761535; x=
	1747847935; bh=cyUwDJ3M1+wj/CBnqD/jzq+Mn30lj8oo1hYViiIgR+o=; b=E
	4LmKGGGee2F1NyNn0zMpIZTdiWxvsdOMMLe4Xq3sBHhior++hHO7VWkdT4cgaKk1
	QDIS3Eq8ZP+LwCvQnCJa3DbrmgCmobwiNcoi99F8K+w24+42eHE7GxVdGO1yoOu4
	wRzVaOvLq7/ozcOqRfFp7OQMTchgGz7fdYr0KWGjbbkhIBojClZn+R6PYpiWMZMa
	FCJTRHQg0xQ8CYTrLIrBrlUxbfNmrdgcMhofCgrLtRdcr1yy/hVqlDliuz1cU8p4
	dsfNJ6ybfi+8wl9cpO9FMVvPIyREb2jFFDe2uMxmZywsf1rPWNzlj+AUeJuuTVz8
	5iKMHxMTf2t8mE2bAl8pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747761535; x=1747847935; bh=c
	yUwDJ3M1+wj/CBnqD/jzq+Mn30lj8oo1hYViiIgR+o=; b=FoyI5tUy+NovDHeU9
	w80QmirC/56+V08Xv7yK/ozjl0k3fZ/cbh0vmFtnc9BGXYuB+xRBTJq5AOkckOxB
	NDPFusgvQhXtwPKEf3tWI3W1IX8uYFfk9wMEX56NsowVkUs7sQExaz6MDZAmc3WR
	KY4Gm+Gxt66DbidlV5Uuz7cLYGiLmYVUckY2AMy74FhTJW5sQkOkItUBCTHf+4gT
	0lwoVFUbiaa76KudLsY/UalMiqDGl9/QWL3GclvNOhfJQ31ORuooebRS5TfYP6kG
	qZMFx9UF7YiYFNvNBvg1a7ZMzueto4gjv+EKz0MVTp9e18hjrHqS/wpbUJ2QyMGH
	UF4dA==
X-ME-Sender: <xms:f7ksaLbcOCS0UFbZlheay73SaE0sT9HSXVe3tGZU9MWHZanK25lsTA>
    <xme:f7ksaKaZPxblrUaEP3LWEByKoRyhmloDAGlQ3OGdmUxZ495lNI6kZQqzc4QONe8qk
    OOKOYfA6hyuOZiEx90>
X-ME-Received: <xmr:f7ksaN_nhy3YYlccEg8XMjy6yD7WNVEC1JUhCWdwzPnUAcNA2PL1atWMlFQHsvkWHoNHIR4pxWfsNMxzA4IZ-9ni0ZOjmvZQ6mdnIZAQTGegZZpRXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejleculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghf
    ggfgsedtkeertdertddtnecuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitg
    hosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrhhnpedtjeeuieeiheeiueff
    uddvffelheekleegkedukeeffffhudffudegvdetiefhteenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgv
    thdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnh
    hpihhtrhgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehjihhrihhslhgrsgih
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunh
    gurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f7ksaBqAp-Uiz_WvJZ0KCNHvLgCie5v5_P-IfUR8U3d5CUZFS-KoZw>
    <xmx:f7ksaGqrpCWdfewso2msc4iDOt0ApQ5iRyXfXljqrISgyX5lxrHteQ>
    <xmx:f7ksaHTUvGttByw-K-GmMhltezu3Uo3Ouyy7BwOqFy65NdAqTL7Ohg>
    <xmx:f7ksaOo-1GviOiBopWGglnG0Q8nBMlHYbDeSspMTOojY45LDE4RBkw>
    <xmx:f7ksaL4pj1UKfBjSEhQ2ov8lRJd7lfEM9Y5B6uaxaRQ-WM6ixTpQUGKf>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 13:18:55 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 6C99011B0CF0;
	Tue, 20 May 2025 13:18:54 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] vt: add VT_GETCONSIZECSRPOS to retrieve console size and cursor position
Date: Tue, 20 May 2025 13:16:44 -0400
Message-ID: <20250520171851.1219676-3-nico@fluxnic.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520171851.1219676-1-nico@fluxnic.net>
References: <20250520171851.1219676-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

The console dimension and cursor position are available through the
/dev/vcsa interface already. However the /dev/vcsa header format uses
single-byte fields therefore those values are clamped to 255.

As surprizing as this may seem, some people do use 240-column 67-row
screens (a 1920x1080 monitor with 8x16 pixel fonts) which is getting
close to the limit. Monitors with higher resolution are not uncommon
these days (3840x2160 producing a 480x135 character display) and it is
just a matter of time before someone with, say, a braille display using
the Linux VT console and BRLTTY on such a screen reports a bug about
missing and oddly misaligned screen content.

Let's add VT_GETCONSIZECSRPOS for the retrieval of console size and cursor
position without byte-sized limitations. The actual console size limit as
encoded in vt.c is 32767x32767 so using a short here is appropriate. Then
this can be used to get the cursor position when /dev/vcsa reports 255.

The screen dimension may already be obtained using TIOCGWINSZ and adding
the same information to VT_GETCONSIZECSRPOS might be redundant. However
applications that care about cursor position also care about display
size and having 2 separate system calls to obtain them separately is
wasteful. Also, the cursor position can be queried by writing "\e[6n" to
a tty and reading back the result but that may be done only by the actual
application using that tty and not a sideline observer.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 drivers/tty/vt/vt_ioctl.c | 16 ++++++++++++++++
 include/uapi/linux/vt.h   | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 4b91072f3a4e..83a3d49535e5 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -951,6 +951,22 @@ int vt_ioctl(struct tty_struct *tty,
 					(unsigned short __user *)arg);
 	case VT_WAITEVENT:
 		return vt_event_wait_ioctl((struct vt_event __user *)arg);
+
+	case VT_GETCONSIZECSRPOS:
+	{
+		struct vt_consizecsrpos concsr;
+
+		console_lock();
+		concsr.con_cols = vc->vc_cols;
+		concsr.con_rows = vc->vc_rows;
+		concsr.csr_col = vc->state.x;
+		concsr.csr_row = vc->state.y;
+		console_unlock();
+		if (copy_to_user(up, &concsr, sizeof(concsr)))
+			return -EFAULT;
+		return 0;
+	}
+
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
index e9d39c48520a..e5b0c492aa18 100644
--- a/include/uapi/linux/vt.h
+++ b/include/uapi/linux/vt.h
@@ -2,6 +2,8 @@
 #ifndef _UAPI_LINUX_VT_H
 #define _UAPI_LINUX_VT_H
 
+#include <linux/ioctl.h>
+#include <linux/types.h>
 
 /*
  * These constants are also useful for user-level apps (e.g., VC
@@ -84,4 +86,13 @@ struct vt_setactivate {
 
 #define VT_SETACTIVATE	0x560F	/* Activate and set the mode of a console */
 
+/* get console size and cursor position */
+struct vt_consizecsrpos {
+	__u16 con_rows;		/* number of console rows */
+	__u16 con_cols;		/* number of console columns */
+	__u16 csr_row;		/* current cursor's row */
+	__u16 csr_col;		/* current cursor's column */
+};
+#define VT_GETCONSIZECSRPOS	_IOR('V', 0x10, struct vt_consizecsrpos)
+
 #endif /* _UAPI_LINUX_VT_H */
-- 
2.49.0

