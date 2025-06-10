Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61843380;
	Tue, 10 Jun 2025 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749513773; cv=none; b=KzirLNdXPGTu21vB2xLPYDI7NCuLTyJV06qUPUJCYetPbHZRcD/AjyYQCR6FcwsMJWtRTHAZyBW4QCJaoZqOd6WR7CJPE4phmUZX7OJZ869H1Ljq9hE7OTQRzEYvHoM+idVwZ6MR47MZhBs5+gCOoEUQghVyRx1saySf/L2ScDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749513773; c=relaxed/simple;
	bh=czlnWdFoGhY2LqbG/nYKIBJE/8bgqH1H3VFxTbd6CMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfDTGsjRgWCP5BvMRr4hbvZZdiboA1uDUGcud+1Vr77CHUKr5CwYqfkQTSWXF2j3vGlQcP6UdZ5+lK4cmm7qaUR8qln4QSNapujkbTDxnk0iiCkDi92SY5jUv9c2L67mg/yWg8P0MC9HQoS+HBixaF11j5VoxKvUGQVG0IJ6qsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GVBW1hTO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GVBW1hTO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UP8n7HYsFN3JTUyYB1TXG0gNfIHp9GeVzaNjNbPSfsg=; b=GVBW1hTOnsXSOcKCeobbgX5QBD
	xXyxWvOQB3FFeSSTZK3SBsIyumBQrO/9GFTndiKoXumIxmJRexogpGc37HFhDc2tHC2HXIBWRAOiH
	EILL04nvBRqKA96f2VBxY6m5Fq+3FpTcgbdyUCR8KL5kmFEFTXNQ1PvAsb0/MPcHgMZZlccbXOsqS
	cyB0qH0ssKvStzoMVJBdwTEzo0iDYd2mGTJoxG0cxTMMQswWB8NfKySwafV/eJ634CyOUKjpdQ6TU
	mQqGqIg7VS2CKzuKH6xY4qHNXbsReHNwR3ND4JLuCl4QKDcOq0ImDmqy85PX9o6sqAh4+PwuEznGQ
	grDTiF6A==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOmS3-00000005U5X-2hUa;
	Tue, 10 Jun 2025 00:02:51 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH v2] vt: fix kernel-doc warnings in ucs_get_fallback()
Date: Mon,  9 Jun 2025 17:02:51 -0700
Message-ID: <20250610000251.282760-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function parameter name in ucs_get_fallback() to prevent
kernel-doc warnings:

Warning: drivers/tty/vt/ucs.c:218 function parameter 'cp' not described in 'ucs_get_fallback'
Warning: drivers/tty/vt/ucs.c:218 Excess function parameter 'base' description in 'ucs_get_fallback'

Fixes: fe26933cf1e1 ("vt: add ucs_get_fallback()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nicolas Pitre <npitre@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
---
v2: add Jiri and linux-serial. Mea culpa.

 drivers/tty/vt/ucs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-616-rc1.orig/drivers/tty/vt/ucs.c
+++ lnx-616-rc1/drivers/tty/vt/ucs.c
@@ -206,7 +206,7 @@ static int ucs_page_entry_cmp(const void
 
 /**
  * ucs_get_fallback() - Get a substitution for the provided Unicode character
- * @base: Base Unicode code point (UCS-4)
+ * @cp: Base Unicode code point (UCS-4)
  *
  * Get a simpler fallback character for the provided Unicode character.
  * This is used for terminal display when corresponding glyph is unavailable.
