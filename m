Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220886FBF;
	Wed, 11 Jun 2025 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749607352; cv=none; b=sZU/IADpQxbhShRW6r9rGlgcMIhyeBuEHdiBtv/e2DmLAvikO6R+vrnxZCxpvqIZu70wEWVpVcbmkivWBN/VeUbBCQrN47vopSGnXlS5TEQvnTXyqhRGtCn3KiiqxCTt30bGKiur63hJBS7LGRdliEKFWsO9p5FLW+b9wIwvdM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749607352; c=relaxed/simple;
	bh=MwRP3MjkanXH5MsPlrHeH1GolpSHF55hJd1hVoFHLu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dN8gG3fyf+FBtHJ9bBoPZsLJP/6qTphnymLbJtBo8XbDR0yCMRWHCC2kg1DtIcTHUwhnAtVAyW6Yz8VsoClOIxtLtS3gBhFLCFMuF/GpCk5inyMlLysIInm2EwCTZEm223fiufxXpKh1/VVc7ClZpZk3MnL8NK+wZeoqZi1BzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0v7Hnj7l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0v7Hnj7l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=X9FpvER8PD2MOmvDWoEC2AeOOYPGUKq7iiqeH/690Ks=; b=0v7Hnj7lM4xToCUI17yyO+fn+g
	9HvEOLGQdUm3uPftBCgMs4PTKazylzf+AHHlRRrqmCoOMfkphEXQKM6a/U+50crXuF6XJBDrEvz+B
	lUEwOpN9yrZ6pNdkC7MP/8A2sCFQW8b5eg4TlDHJ1ZbpIktE4Whq2yD5oc5JsxiowcF4fB/KIdmKN
	qEEFG1uN54cyThC0IofFeH/QejYohlqmrUM/ikl3NchltC4jMLYO17HM95LaT2MsOeS64kGEBXs1u
	uFQ6zxm9tMJRvrekQ3Boa6Jnl/fonr80Ixx3dlMQRbq4JOTXRAcN1cwBY97iW8+fh+oXKPP/1w1V7
	aEg8pvtQ==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPAnO-00000008bTm-0UU3;
	Wed, 11 Jun 2025 02:02:30 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH v4] vt: fix kernel-doc warnings in ucs_get_fallback()
Date: Tue, 10 Jun 2025 19:02:29 -0700
Message-ID: <20250611020229.2650595-1-rdunlap@infradead.org>
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
Reviewed-by: Nicolas Pitre <npitre@baylibre.com>.
---
v2: add Jiri and linux-serial. Mea culpa.
v3: drop "Base" from @cp description (Nicolas).
v4: add Nicolas' Reviewed-by tag (duh).

 drivers/tty/vt/ucs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-616-rc1.orig/drivers/tty/vt/ucs.c
+++ lnx-616-rc1/drivers/tty/vt/ucs.c
@@ -206,7 +206,7 @@ static int ucs_page_entry_cmp(const void
 
 /**
  * ucs_get_fallback() - Get a substitution for the provided Unicode character
- * @base: Base Unicode code point (UCS-4)
+ * @cp: Unicode code point (UCS-4)
  *
  * Get a simpler fallback character for the provided Unicode character.
  * This is used for terminal display when corresponding glyph is unavailable.
