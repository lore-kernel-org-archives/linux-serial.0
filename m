Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C94CB5B;
	Mon, 20 Oct 2025 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970663; cv=none; b=dyGBsDKcdtgod5nhBAr04Ar0WpYmJkU9V0mBafr9LR+IZJnWXa3ZzKeyI8Fmk2N04BERjfEAVHDAsqATlLprztC8No0j7NoGhU5vE5AKhJnPKGxYwtrNaUn5M0GYg0+uGPBPSzZLOH5x0WWKt47gLQQdXJnyxT9c7KyaUcpUC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970663; c=relaxed/simple;
	bh=Zgh/z5OAav7Q4sWyHwtd8KQU+ZJ/UY2frwfkFs/0zg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TjpAkenHPTMGAhOVu3l2U3O++0ZW2Kz3Q5pq7OpLtoupdoiK1FD5VWQfKwf/WgpRGxMWeNqpNxq4t5ntKaZanQcsgq2M85NopYAGqpOOEZpg2JF1NouQOza/BazGgulynAdTERFzF56tkDygab0JRv3+JzZH9joPxzBuTHENuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7+ZDnsB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7+ZDnsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA76C116B1;
	Mon, 20 Oct 2025 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760970663;
	bh=Zgh/z5OAav7Q4sWyHwtd8KQU+ZJ/UY2frwfkFs/0zg0=;
	h=From:To:Cc:Subject:Date:From;
	b=k7+ZDnsBo6sHFfM7V3XjA540jxwzbjD7wpXcvDjXgBZHceYe7SmphByUgNxyioXn6
	 /B1Kqi83dvd9U37KNqP4f0HRQne1lyscHCkndUZFgy1BnAVUSjezJEsGhrdzko8TRv
	 h+ObONN54XTBZsJrK7hx+95DhdoOV9eIKkGfbC1bW6wga4Ej96JLoSOi8I+XWbOpGV
	 QCxeSUxmBXxZxZNduGonaSKD1vmACPpz+T2+/Nx+7okTyUcWO9A3AMvy33UsmYqTN1
	 d8jAgOo9CjZrSA5ZzeH8d/Tf0j0E6kdVKlwBXMBkBsxC9EBgwnxOu4uafllhn/ILPI
	 0D1gykG+4O5yg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm, vc_screen: move __free() handler that frees a page to a common header
Date: Mon, 20 Oct 2025 17:30:55 +0300
Message-ID: <20251020143055.407696-1-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

vc_screen defines __free() handler that frees a page using free_page().
Move that definition to include/linux/gfp.h next to free_page() and
rename it from free_page_ptr to free_page.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/vt/vc_screen.c | 6 ++----
 include/linux/gfp.h        | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index c814644ef4ee..d2029f029de6 100644
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
+	char *con_buf __free(free_page) = (char *)__get_free_page(GFP_KERNEL);
 	if (!con_buf)
 		return -ENOMEM;
 
@@ -596,7 +594,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (use_unicode(inode))
 		return -EOPNOTSUPP;
 
-	char *con_buf __free(free_page_ptr) = (char *)__get_free_page(GFP_KERNEL);
+	char *con_buf __free(free_page) = (char *)__get_free_page(GFP_KERNEL);
 	if (!con_buf)
 		return -ENOMEM;
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 0ceb4e09306c..93a6a532f10d 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -385,6 +385,8 @@ extern void free_pages(unsigned long addr, unsigned int order);
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
 
+DEFINE_FREE(free_page, unsigned long, if (_T) free_page(_T));
+
 void page_alloc_init_cpuhp(void);
 int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);

base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.50.1

