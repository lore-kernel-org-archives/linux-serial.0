Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC17083C;
	Tue, 10 Jun 2025 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749534490; cv=none; b=HPn918sp+POPpyRCihFhe4Y4Dzym2uA48AaSG7mcjapjIjqqf6HfuQzxo7Kt9dnCoHxFq1qiqJ5rVUnfIRGi7hPuZWa83Xexj+CHU16ABobaTi0zAlZtYoo0iRSIX8+JOts/XUB4k1VOkGgVthf2bV1j9W8Go/OWMd9xXeHLies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749534490; c=relaxed/simple;
	bh=4kKbrgZIEsRfSqcwLUy0JoyoJPmIGHgvkQVsEOSQFm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wumh/qx3VUOQoZ9jbS2Q/iLQkTKPK/GdxQrjCii27jdZyB0kVohhHcSP6GbXcBT8lYtB61QMdQgVM/d4b83Zu3P97fz+H50x/hMZhAT0ILfU3AM1m1nbigv3lkyBg0aW4f5MSTT1m0byJyo/A2mWqPNbfGIlJN4OL2g3hvA+Lm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hAvjxf7Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hAvjxf7Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jfuZXvb7ZY6kqP+DobC6hQA99SJpUyjsbbWyK9b/5/w=; b=hAvjxf7Yerj364IcazgYqB8V/a
	WRiBo9d51OAI4C1Lgvlzx9TQUhY160VtlF7grJh7WoB7p9GP802vnPtqllwz6wXa8bcjQvHNndlmV
	KeNgo/suCdsKNCSjBxWJX1EDaYmctPT8GmbuP4Q6eZK+HOR9TP0g4s4SYZ0XScrvpleuhzYR811jp
	6txGTUybvLGOompRhtzjACN7rCS/kwt4XTGoJbK7dg4XrwC2/8si+bQuVK7nZ+MDsAsHCyLQ3VoGS
	CBVnGv1qKymLdGmc+CdHBQvLe6dqqL/gGfSSuVs8xq+uwLtXYxlkkbPF6k/ImfjFU6AkLUQIGg5oD
	LVqAlZtA==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrqC-00000005rpL-2Uit;
	Tue, 10 Jun 2025 05:48:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH v3] vt: fix kernel-doc warnings in ucs_get_fallback()
Date: Mon,  9 Jun 2025 22:48:07 -0700
Message-ID: <20250610054807.3955933-1-rdunlap@infradead.org>
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
v3: drop "Base" from @cp description (Nicolas).

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
