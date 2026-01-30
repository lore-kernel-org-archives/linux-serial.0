Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3430C373;
	Fri, 30 Jan 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758185; cv=none; b=Op76cj4MCykR4jViR6yueiG4R7U2VtDJmg5vXAspbV1PwubiPwny+hLAkhlV6a/Jp3TwgT5JcOPjyAaveKv1wymF2Dg5ntDptIbXPy6FY8kJwoIMLizxJf/5cKpIvChHf4/Sk7xO442XVIF+A7BlTC29hNoftEjQcbB9SgNt6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758185; c=relaxed/simple;
	bh=6WE0Xds7QJU7MoPff11UxI8f5HpcyyFD6UDYWO+e9qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cimIyqtGMilAgE+fHAWpblTEUpRcua4F96VsV9tDdJvUvdnJuWDhB0PaeyBI6tmkCAfLebOeLcMD48TNtLN+KByxIir++JKXG7Jp9suHfePnK/0LP6xd7HfSdnYExJQ6mcxbospCJgu6chz0ut+DZ4qD1iVxmBgLmaICmLBPe0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=37q1F1+I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="37q1F1+I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1q7l3cf0hPLD0O5rGHsZ/nxvzquqh1DhwSv089uPgvw=; b=37q1F1+IGMJHE3H3pez/SK5TwD
	GyDPjg6knF5AqQOTNXY6IbB0f7SRq6eWLcdIPbJn7Io/tC5kGtNj/lDlosEWQLjeVdVba1lWr11pR
	c2PVIuAZPt6St8c9X6/fQitseCUQ7CkUkNEvktgDu30micPiFePqUVD5/pI8QWnNHKg7syhVZB+cq
	mczCWgUtopj70MgvONsz06UNJ6pr9R4Lxba+pq13Jgh5GUem51eWVcjKRtcxPuLWKlZ8A7sXi3q+T
	JWH3GpM+zqXlpZGoSaa+vy9ym/tQRCVA5cSXyKbNCp+IqamvmV6qoo6RwXszc2mx3if+Y633jzB0F
	myUeIcJQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vliwm-000000019KS-0lqa;
	Fri, 30 Jan 2026 07:29:40 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] tty: hvc_iucv: fix off-by-one in number of supported devices
Date: Thu, 29 Jan 2026 23:29:37 -0800
Message-ID: <20260130072939.1535869-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MAX_HVC_IUCV_LINES == HVC_ALLOC_TTY_ADAPTERS == 8.
This is the number of entries in:
  static struct hvc_iucv_private *hvc_iucv_table[MAX_HVC_IUCV_LINES];

Sometimes hvc_iucv_table[] is limited by:
(a)	if (num > hvc_iucv_devices) // for error detection
or
(b)	for (i = 0; i < hvc_iucv_devices; i++) // in 2 places
(so these 2 don't agree; second one appears to be correct to me.)

hvc_iucv_devices can be 0..8. This is a counter.
(c)	if (hvc_iucv_devices > MAX_HVC_IUCV_LINES)

If hvc_iucv_devices == 8, (a) allows the code to access hvc_iucv_table[8].
Oops.

Fixes: 44a01d5ba8a4 ("[S390] s390/hvc_console: z/VM IUCV hypervisor console support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
No, I haven't seen an issue with this out in the wild.

Cc: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>

 drivers/tty/hvc/hvc_iucv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20260128.orig/drivers/tty/hvc/hvc_iucv.c
+++ linux-next-20260128/drivers/tty/hvc/hvc_iucv.c
@@ -130,7 +130,7 @@ static struct iucv_handler hvc_iucv_hand
  */
 static struct hvc_iucv_private *hvc_iucv_get_private(uint32_t num)
 {
-	if (num > hvc_iucv_devices)
+	if (num >= hvc_iucv_devices)
 		return NULL;
 	return hvc_iucv_table[num];
 }
