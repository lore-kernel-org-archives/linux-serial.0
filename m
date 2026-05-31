Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A9344D92;
	Sun, 31 May 2026 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210983; cv=none; b=eD4v03PNclwgkcA+2ofr03OSDCBK2CMqnT/0XGXJi3ysRd9QPCxQEIO37xJqdSvig6ge3pHflLu2+47184Dk9Z5JeIH+Kdfgbc6MQPRi8VT8MxXr/wsNK/3ThuO3dvmJctaVdyKhwmg17m44Kd+w0K1X3j6sJb2HyiuFNxifSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210983; c=relaxed/simple;
	bh=d1A9mqMOwj3aEO/CdtcRJwVKHqEy4iAO8L57zNBx0j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a47Umu2GNVqKYvTo5OGaywsSheQw/D4eB/K5zOMqSPMWr9ZDKrMONWXjyc1U3iZw+/r6K900L9uFEBAA/vDaZ6ufCWT6YGsEJ2zh6zO481wfoYRnU6HYsK6Ix/NmPsftVufLqBA2XxenwG4zhZX57EIiHWG5xka7A+ZUDB3is74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQ1d/NT0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ1d/NT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47961F00893;
	Sun, 31 May 2026 07:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780210982;
	bh=aZgXT2ovXS3IZ2JxTPqBmcz8kuu7e/GyHmKzI+j+wn8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EQ1d/NT0ktwMqaIaxkjQ3YMSMwQ8G1/81ix0mzlqQKvoKr2wM21vdAXDQCSv9xYT5
	 YTgDSzC8vXNypKaBKCRHnofmeHsKAEygjKrnsoV7SS11gw6GL4i6Anp53r+H4gz/Wh
	 ovxIg3AwVoGB/RjMcqZeEDJgg+cFKvgxD+oDNL7MQ7aPeklBmHqSdhfC3/fPP1T6cI
	 X8y0sOtIAgmDjgkIIV4gJw1Dv2h/LF/egkayhlB/heyzQ+1v4hqT6qziZ6ErKQ2tQ3
	 dI+kNrXaCaLMdau40yq4Ubva1g3Q8HcsPYQCAv+bZzzwed3TvcGhJZ/gYqxztsIl8+
	 JFxp3hcNuC/0A==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 31 May 2026 10:02:50 +0300
Subject: [PATCH v2 4/4] vc_screen: replace __get_free_pages() with
 kmalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-b4-tty-v2-4-f7149947d4ef@kernel.org>
References: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org>
In-Reply-To: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org>
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

