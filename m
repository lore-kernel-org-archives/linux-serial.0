Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E33B9DAD;
	Thu, 28 May 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963878; cv=none; b=DG7r3eIXN0byEoPswSLX3xa81sykO98vdMYupdhILXuz9yokPqwjEKGLdJBUyBYk+FajakDJrwwfhLeXJ8aJ0wbfE87AYsKLiVr2OonPxSoPsyDGrDpA2s7Weiz3Fl2pHgoRSIUyE8kYMsBkImUXIvmx2QU8F4lRgVrlVWz66+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963878; c=relaxed/simple;
	bh=26jMB7BQtNy710o0MhospMkViyaBA5bEsLVotCFqd2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NPHPzHWl4h08jCJ0kIz3/zJ77a71BfD3oQyslyz40joXqE/j2o5EjHooZ436HQvoE9cJQHmQunyXEsTHeXCjYsuGcgA61vXQQJ1iwe7AEjUgtmoFOmijwnR4Qk7slW/UK8xb+1e8Vkd9Zapo8PVTQ0W3I2m46rIWj52ADxzvhng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDLFSNtp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDLFSNtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2049C1F000E9;
	Thu, 28 May 2026 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779963875;
	bh=d+AhWlAChbSoPeU9eNoAX+z4q2Nry8L3D0tILMGrjBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jDLFSNtpWZ4SFcdq99qvcWECTH5S6J0WzXpd+KaYIl/yvHuKNiW3aEio9nYC9+2RK
	 4x4JWGPm+LvHELdJtX30I/kqk2y4PeDX9Ki9+JljaVcJ39Ai6WaElHwymwfd2codid
	 UcL04/DHTGnP5xbgzH9HquhxgUra/Fo7vAyIaS+Jy40mY6StyQDvbw0grM5SeHpSSi
	 CvI2iQSYk66M9SxrrUrDE6dbqxjJO/n7WtGTtrp4XQK3Tw2EC86lnmILQf8b2OGU0c
	 hXK7vagS6/sY0DL5nVWKo6dnl/u0On2wLsBckqDx194Wifl95S2QxFm24qwABEfa+l
	 bRWrVnE2bpnxg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 28 May 2026 13:24:20 +0300
Subject: [PATCH 4/4] vc_screen: replace __get_free_pages() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b4-tty-v1-4-9da9f7aec5f2@kernel.org>
References: <20260528-b4-tty-v1-0-9da9f7aec5f2@kernel.org>
In-Reply-To: <20260528-b4-tty-v1-0-9da9f7aec5f2@kernel.org>
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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/vt/vc_screen.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 4d2d46c95fef..386c80efc672 100644
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

