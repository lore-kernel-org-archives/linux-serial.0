Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998EC3C5DBE;
	Tue, 30 Jun 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813257; cv=none; b=R2w3FGddcbmGru0nYfzYrOW0Ep60KobkfKMMwhR24XZdUBDKYipE99wBHznIPKKKzKOIG1+n6B8N5BCkSRo2wN3SSkXMWQQ8EV13JXh7D0evjaf2kkPBdnr97MQsWUhsw+S6tAnAdp0hUIcM11y131dGCtEeKh9hGQq/wNEHtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813257; c=relaxed/simple;
	bh=1l5nypjekwnzBRt3HgrFDiY6QVoWNdg/DSKIroNfgjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VQDZQFSueKLWzgkQq2WciMWeyMDQXZ6/H2+CnYNP1LbDxR7PaX8UarTaZqZlPBoCV/E5sUiRJtcrbSZhyUIFicwtxnKqcT8jpcSmeuoFntgEYFcP3zbhUACX3lCM+KuozpMND8wY/GPaAJP9RdOrHr/Xe/4awB8DNq8hDH1ma/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLjspud0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLjspud0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C1C1F00A3D;
	Tue, 30 Jun 2026 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782813256;
	bh=tDWSzv7RoppnHctFbrBaIWKAcSqdkcgi5jg8Rh3cBZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OLjspud05wH0xID7dRcY2NJIexfe6TCXUemwCduf0Vy+chqbhhkQ7gG5dlaYQ4m/r
	 CJUzqy6WasN6z5iJtw309PfeNiRRUvHRUMBhMHxvEP62IBmOZiPPCqTZoQzUEPO/SF
	 oUKFCy3ELtWxDIGprpwimD/EzPjo2vPNtBamztO6REHLxmEPsSdPjQILpTaP5gXYcd
	 MBPr1QKkNyT1g/4Tp+uuhn0fFhS/7vN8d9ThdyDgJ5276E+uMUz0xQI28mRqdh7qMl
	 fYfNlN4nNdbwpeYAozuuj0WcdM9zxjHtgrM7AbhIQXMJAwsEtCkLoHjKk5IgtmOPFX
	 fnySvfhrirZgg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 12:54:06 +0300
Subject: [PATCH v3 4/4] vc_screen: replace __get_free_pages() with
 kmalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-tty-v3-4-a8476c66c582@kernel.org>
References: <20260630-b4-tty-v3-0-a8476c66c582@kernel.org>
In-Reply-To: <20260630-b4-tty-v3-0-a8476c66c582@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.15.2

vcs_read() and vcs_write() allocate staging buffers with
__get_free_pages().

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and it's a
modern way of saying "I need a page-sized buffer"

Replace use of __get_free_page() with kmalloc() and drop unused now
DEFINE_FREE(free_page_ptr ...)

Link: https://lore.kernel.org/all/700c5a5f-3128-4671-99aa-827ca73f5cdf@kernel.org
Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/vt/vc_screen.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 7d40eacc21b3..bf1502fd5bd4 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -53,8 +53,6 @@
 #define HEADER_SIZE	4u
 #define CON_BUF_SIZE (IS_ENABLED(CONFIG_BASE_SMALL) ? 256 : PAGE_SIZE)
 
-DEFINE_FREE(free_page_ptr, void *, if (_T) free_page((unsigned long)_T));
-
 /*
  * Our minor space:
  *
@@ -371,7 +369,7 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	loff_t pos;
 	bool viewed, attr, uni_mode;
 
-	char *con_buf __free(free_page_ptr) = (char *)__get_free_page(GFP_KERNEL);
+	char *con_buf __free(kfree) = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!con_buf)
 		return -ENOMEM;
 
@@ -596,7 +594,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (use_unicode(inode))
 		return -EOPNOTSUPP;
 
-	char *con_buf __free(free_page_ptr) = (char *)__get_free_page(GFP_KERNEL);
+	char *con_buf __free(kfree) = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!con_buf)
 		return -ENOMEM;
 

-- 
2.53.0

