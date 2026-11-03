Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738372;
	b=ygidTJ+ai2m7kHHMs2wfU8IN7801NVGNcGAqPcVmOTJuq8cqtnsntaXQSss2oTd4ctjC
	 rY1W/7XN2i8p4lklYX6M+nSETkCWa4fZSHcSCSKI7kueX+3Hr9N5KMKANhLNeMN86Xhk6
	 svclDcOj/5TUzm1tg4Wvmr9Fzk5x1bD5pAfwN9r1t+bTCs1Mq8XtgRGmbMaV1YObuDrX5
	 pbP/HVYu+b4gMWPH4N5Iy7wxF2qvUDJErmqaYQ4xCJE2cGTiGbtwTTsYW6OZe2hRicUlZ
	 DKUgcnUaIyUOmfHTlhbNmhGIFAynv0mINGlcBprB+ptBpxfyfZt1c9qpGvvcUf9Ykjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738372;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=V7izd36fjKXdZ+gzbVLsZTvCdQtFHyr5pEDlDocPRsA=;
	b=uOo64uv6P9rcWU+3IPTdbJGVtRdwa0fb8PM5O3WFTx2KPGLpA2gdIJ5JNwd65j898PPS
	 fXsYJzcY9KNOm9myBZo9yWvxhsrFFn65FDU1QOqmoH97U0OIWR9s22PP98CM3zRVQnVla
	 NADpF8Q2KLm0x72WUR+Ha4HZdAicCRwQwi5hJ+f3GBYLHsZ7OHbE6Jxs3uEZ78F+hyqZ7
	 kirO3UlhyX+fN+k9cd28OwUGAGtQkyLjQMoe7ksmFKJ1sqaaEMiEc2wDpOlqYcGPhbYXo
	 e+KY6c07UmGxQCHJlpQWqS/st5PSV9IePANGBPpcdvklRu3V6C+MrSd9H0HuYo43A0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hWagJdym;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F9606A31B;
	Tue,  3 Nov 2026 20:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 933F9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hWagJdym
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=V7izd36fjKXdZ+gzbVLsZTvCdQtFHyr5pEDlDocPRsA=; b=hWagJdymGKfcNa+QU0a0WhOiwQ
	CIMe82YRQarotixmUcUcL4conl+lmpIjiZYTehzy+qpvC68OzYVlDCcN56ne6snE110tcfFHiX6nm
	51njWHmoJoMJnYenJ990h9fyHw6Z9VjmGX7LWIWRRkQ9z5o1BxgBsdF0CRg0YMdlspPvA0uw30tgT
	JYzMU0Q8NBc3JBK2OocQfMVbipxOe2EHOWRFeukN50NWK/fLr20na/VF4SSqwgHmF2vi2+e4laoRU
	HIwfejEhSu7G7Clv+HezUKSxzDqTT0tGOr0RTNa03Lyj/B9tQpScpvl5aXhxair2Uib/pU9iSGpm0
	clVuE9AA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOLI2-00000003dhn-2fM0;
	Tue, 03 Nov 2026 20:39:30 +0000
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
Subject: [PATCH] vt: modify a constant prefix that looks like a ReST target
Date: Tue,  3 Nov 2026 12:39:29 -0800
Message-ID: <20261103203929.2916563-1-rdunlap@infradead.org>
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

Prevents these warnings:

Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:275: ERROR: Unknown target name: "cur". [docutils]
Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:317: ERROR: Unknown target name: "cur". [docutils]
Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:353: ERROR: Unknown target name: "cur". [docutils]

Fixes: 1438d00569c4 ("vt: Add cursor-size helpers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
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
+ * The argument given in @cursor_size is one of the CUR_* constants, as stored
  * in struct @vc_data.vc_cursor_type. For unknown values, the helper draws the
  * default cursor or an underline dash.
  *
@@ -317,7 +317,7 @@ EXPORT_SYMBOL_GPL(vc_cursor_valid_size);
  *
  * The parameter @cell_height is the height of the character cell as
  * displayed by the console. The argument given in @cursor_size is one
- * of the CUR_ constants. See vc_cursor_valid_size() for how to get a
+ * of the CUR_* constants. See vc_cursor_valid_size() for how to get a
  * valid cursor-size constant.
  *
  * Returns:
@@ -353,7 +353,7 @@ EXPORT_SYMBOL_GPL(vc_cursor_start);
  *
  * The parameter @cell_height is the height of the character cell as
  * displayed by the console. The argument given in @cursor_size is one
- * of the CUR_ constants. See vc_cursor_valid_size() for how to get a
+ * of the CUR_* constants. See vc_cursor_valid_size() for how to get a
  * valid cursor-size constant.
  *
  * Returns:
