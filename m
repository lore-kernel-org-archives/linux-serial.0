Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A278D2ECD32;
	Sun, 30 Aug 2026 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788076192; cv=none; b=kxHkju7vpaMLwqPxQxETMwO2hY8+pBhgnjH8cIkCdb2sB2o0fR/B22RUPsMFo9O0APjTsgERmorO7DcxGvJIQg4q4MsYJsyT5gpXftzIfHj/MRJG+AfJku8S3hACeeSM/FYYPMA6RG08M1x1bGOOJIrftkGckIiJCPuuJ+KcaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788076192; c=relaxed/simple;
	bh=b6bV+calvs086psmivgvJ311zZjl8suy0+j6cxPIjJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ste43ngdKnniD6vW7Nsd5pZ+bbm9FyNDX/jOy7dI+8X+lSggy3rRiP+OnD05v+OhKP1lCNabCyU/LuL2WDUNzbeWBFItEf3M0Y/l0BZ1NGgVMdRmgp/gtEiaTY0JNoEW2gB4DL8Kr3pC6fdpIVgAgv/bmTIImmVtm7jvUjcxQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5zBjU2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5zBjU2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19B91F00A3D;
	Sun, 30 Aug 2026 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076191;
	bh=N0aOUz6JVmh3kXeQM+NnLc75cSb7tkVgfwn6MO33S8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b5zBjU2SCdjNynbg16pje0gRmCFrD2lpThEIZpjQImPRVDgN5PG8PUs5Y+pWBNxWo
	 SkR/m95kAtKUgDcA7pG+mgK6GKoLUoKWkPLr9kQROsoJTVUBgu2Ndc1cdzAboL4mx+
	 zovU54HVU9Zx1PHAUtsimOlAdSLGtQjmx0gLUBAH7i/2KABKvH9Xj09UPoBpjvMOCk
	 4+bayv5WuWfiXFs03oJYXx59pFZ4H5N0YFuOjm06Cuoeabrrdcz5M1TV2MLy6uiajp
	 OA6KrwNHb1d6V9E+q2YZ/ONsT+E9yJ/CABRqr4QlKx4EgyThytkTlGLuzIBV25AijX
	 nRDHvVS1DfNIA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 10:49:39 +0300
Subject: [PATCH 3/3] tty: hvcs: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tty-v1-3-0cbe6170649b@kernel.org>
References: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
In-Reply-To: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.17-dev

hvcs_initialize() allocates the buffer that receives the partner info
returned by the H_VTERM_PARTNER_INFO hypercall. The buffer is passed to
the hypervisor as a physical address and it must not cross a page
boundary.

kmalloc() guarantees that a power of two sized allocation is aligned to
its size, so a PAGE_SIZE allocation is page aligned as well.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/hvc/hvcs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index d32b1e3c50bf..b94d59fa3627 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1470,7 +1470,7 @@ static int hvcs_initialize(void)
 		goto register_fail;
 	}
 
-	hvcs_pi_buff = (unsigned long *) __get_free_page(GFP_KERNEL);
+	hvcs_pi_buff = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!hvcs_pi_buff) {
 		rc = -ENOMEM;
 		goto buff_alloc_fail;
@@ -1486,7 +1486,7 @@ static int hvcs_initialize(void)
 	return 0;
 
 kthread_fail:
-	free_page((unsigned long)hvcs_pi_buff);
+	kfree(hvcs_pi_buff);
 buff_alloc_fail:
 	tty_unregister_driver(hvcs_tty_driver);
 register_fail:
@@ -1528,7 +1528,7 @@ static void __exit hvcs_module_exit(void)
 	kthread_stop(hvcs_task);
 
 	spin_lock(&hvcs_pi_lock);
-	free_page((unsigned long)hvcs_pi_buff);
+	kfree(hvcs_pi_buff);
 	hvcs_pi_buff = NULL;
 	spin_unlock(&hvcs_pi_lock);
 

-- 
2.53.0

