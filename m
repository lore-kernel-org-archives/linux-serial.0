Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816580;
	b=5dMQkscpszfGZzVWtXmjJ2in4u2o6R/+ZYsJJVn+1tARdyNCJh/HUMGZgS5cagUtxPa2
	 hOWF+4epOPgK8j0UgyFy3KnBw76FpmiaqkA0zyGSTPNzFvS4OMIOrCHITUWXOWlzod6Z7
	 BO2HBHogF+WJEQL7IutThmhLS0XAicjmzylCjYk/5BzjwgcxgN4n1Cg6qmPShvqp/KyyL
	 q2PTh5LQEHM3CSm/2bEfySB8p3hOUdhjTdzsVhJHsvW98hUy+l/DUMJvDT8YE52qvmOuG
	 WBoQ3BDDN0CGoizD2AnmJw6QA4GsrA624uT0uRB+YXdqfsRxNZa4RcbQgPb+/vT+xvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816580;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0vwJIjuJBOoDrkviLqQLNhscEI3o8yi5cI8+qVz/msU=;
	b=jn3Z7WMlJFZ5BXYuN7ZcklqPdggGjoHOrl1+dUlaGdvLpw3LVOUPbi4u6/9KIw444FVX
	 lznnVpYW95cjuL22Trt9Ki2HAA/vebMz9GcRwrV1sgggXuK/B4QSO2WaLJjlJzo5xk1KN
	 lEd97BMBpK6O2i8avcnrTtEeRIeLjNHw24j8RdZbAjjUN81uRPtgk0+rpPx5hM2JLj/jr
	 n9C8qFu9n3EU+c5GT/jJlJKtCNBDftFQ1dyZA4gEzXhXsZ86KzLskxm9DZJgGFxD90/KK
	 IUsUeBd3gMzFoYhR5WOl/m5VmjDEdsJo1YTqMH2sWOuNqkstpzM+6FtC/h6y5yDggsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Kp0pGRfa;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804E60702F9;
	Wed,  4 Nov 2026 18:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6804E60702F9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Kp0pGRfa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0vwJIjuJBOoDrkviLqQLNhscEI3o8yi5cI8+qVz/msU=; b=Kp0pGRfaiCEfPA/C+8ZLYs40QH
	BThqDDNTa4gzab/TdfxvWetJV/aVIosXbDvT/ZPYK5OG9lTwTtyl6vk0sqjHTYGdmxg5lBjIU4BYU
	5IJ6fCpJufPFZP5r9BKCUGOXeV8RBSjekcw0DST6dkcTSsCpJd9j+6C3Wp3BdmPQ5ZW6kJO4ItnK7
	V0meOlaUsPf+SKVp2LbRzWLTf90e4+K/KNpu+r0Xg6Qvogpp56s6vMpa4pMUkkc87pI3wl4rkLGjP
	ws0e+xJaAbfvvg9A4RC8MAiTgfHZMBUNtq99wyFrbj9uemTW19AmD2w+Q6qCDOvMtHgNBb8zWUZvB
	EjNrJXZw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfdS-00000006O2K-38IJ;
	Wed, 04 Nov 2026 18:22:58 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2] vt: modify a constant prefix that looks like a ReST target
Date: Wed,  4 Nov 2026 10:22:58 -0800
Message-ID: <20261104182258.3226665-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
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

Use CUR_* (could also be something like CUR_x) instead of just "CUR_"
because the ending '_' indicates a documentation target name, so
unconfuse the name.
Precede it with '%' to indicate that it is a constant.

Prevents these warnings:

Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:275: ERROR: Unknown target name: "cur". [docutils]
Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:317: ERROR: Unknown target name: "cur". [docutils]
Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:353: ERROR: Unknown target name: "cur". [docutils]

Fixes: 1438d00569c4 ("vt: Add cursor-size helpers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: Precede "CUR_*" with a '%' to indicate constant. (Jiri)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 drivers/tty/vt/vt.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20261102.orig/drivers/tty/vt/vt.c
+++ linux-next-20261102/drivers/tty/vt/vt.c
@@ -273,7 +273,7 @@ EXPORT_SYMBOL_GPL(vc_font_size);
  * vc_cursor_valid_size - Computes a valid cursor size from the given value
  * @cursor_size: The size constant of cursor pattern
  *
- * The argument given in @cursor_size is one of the CUR_ constants, as stored
+ * The argument given in @cursor_size is one of the %CUR_* constants, as stored
  * in struct @vc_data.vc_cursor_type. For unknown values, the helper draws the
  * default cursor or an underline dash.
  *
@@ -317,7 +317,7 @@ EXPORT_SYMBOL_GPL(vc_cursor_valid_size);
  *
  * The parameter @cell_height is the height of the character cell as
  * displayed by the console. The argument given in @cursor_size is one
- * of the CUR_ constants. See vc_cursor_valid_size() for how to get a
+ * of the %CUR_* constants. See vc_cursor_valid_size() for how to get a
  * valid cursor-size constant.
  *
  * Returns:
@@ -353,7 +353,7 @@ EXPORT_SYMBOL_GPL(vc_cursor_start);
  *
  * The parameter @cell_height is the height of the character cell as
  * displayed by the console. The argument given in @cursor_size is one
- * of the CUR_ constants. See vc_cursor_valid_size() for how to get a
+ * of the %CUR_* constants. See vc_cursor_valid_size() for how to get a
  * valid cursor-size constant.
  *
  * Returns:
