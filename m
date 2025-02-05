Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F721D5A3;
	Wed,  5 Feb 2025 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733308; cv=none; b=ZKuhVbRmvn4Ejz0IuKTV4p82nqR+hFOGHAy6WIbzu9FgALbxaZgmDciNguIJQK6JmTKDKH6X0ppiOVm9zQ7cJIoXZGEYdc5jEX8gGrL8MbXViQSt/2UBuMPjnFmzwltNeDS3GzyWcDVHzaZDGVcuKVoLUVB41DvVJGpLFtM0xzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733308; c=relaxed/simple;
	bh=0n+4YgEc9u3YaQhLk0UdMuWq7cV5Fe8zlFg0KUvaA4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WkvLdmwD0B+wvo3m0tR4tMRox9nrbeEj4Jjt6A31R7scO4Rn/5yKwSr0iuqqDDV+JBJkOsFIZkN4SG8NlZCNhjlJWQlr0u4Q0LidA+VCn4I9o87FlH9NNoqO2omfx7UI2UpRJxaFHTc5yyVUukahiBg4euvOw9x5QhcWPaa+odY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5Bh+uS4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5Bh+uS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD27C4CED1;
	Wed,  5 Feb 2025 05:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738733307;
	bh=0n+4YgEc9u3YaQhLk0UdMuWq7cV5Fe8zlFg0KUvaA4I=;
	h=Date:From:To:Cc:Subject:From;
	b=f5Bh+uS4dJEhVj/7NyJmxrXd7mw9JXj4cXwudsvxJv5c48g+nl7jRl/NzxfzKaNJx
	 O6iZysMj8PfBg4O8p65ODY2MzXzlh0IBjVY1ey44kAui4ZuaqjbTpB3twchaVPSrxK
	 gm4XPTLnFtr/OGYILg3fFMKPpY9Lp8FrEyvYqApZNxHY80ibJ4iBFP4NX73ia6RR5Z
	 Wn72LzrPRNFMpwtzK1jfOGcf0fIWx+x4m+o20jhjRKeSubxkmF5qzJ4iERYSXjCH5s
	 nhSGFind4rwhmbwK5nIYDb1ypnuAaeIHxh+fsOnL8CjfOIfg2Zgl/8bnQLtWSlFb45
	 1ypSvlpr9zYMQ==
Date: Wed, 5 Feb 2025 15:58:20 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z6L29DXeGWl-6OnK@kspp>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of other structs, we use the `struct_group_tagged()` helper
to create a new tagged `struct tty_buffer_hdr`. This structure
groups together all the members of the flexible `struct tty_buffer`
except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct member currently causing
trouble from `struct tty_buffer` to `struct tty_buffer_hdr`.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct tty_buffer_hdr` as a
completely separate structure, thus preventing having to maintain two
independent but basically identical structures, closing the door to
potential bugs in the future.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which we can access the flexible-array
member, if necessary.

So, with these changes, fix 384 of the following warnings:
include/linux/tty_buffer.h:40:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Fix a space at the beginning of the line issue, and adjust the
   identation of a code coment.

v1:
 -  Link: https://lore.kernel.org/linux-hardening/Z6L1XwE-WEzcGFwv@kspp/

 drivers/tty/tty_buffer.c   | 18 ++++++++++------
 include/linux/tty_buffer.h | 43 +++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 79f0ff94ce00..f4e7520df7b1 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -120,11 +120,14 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
 void tty_buffer_free_all(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
+	struct tty_buffer *buf_sentinel;
 	struct tty_buffer *p, *next;
 	struct llist_node *llist;
 	unsigned int freed = 0;
 	int still_used;
 
+	buf_sentinel = container_of(&buf->sentinel, struct tty_buffer, __hdr);
+
 	while ((p = buf->head) != NULL) {
 		buf->head = p->next;
 		freed += p->size;
@@ -135,9 +138,9 @@ void tty_buffer_free_all(struct tty_port *port)
 	llist_for_each_entry_safe(p, next, llist, free)
 		kfree(p);
 
-	tty_buffer_reset(&buf->sentinel, 0);
-	buf->head = &buf->sentinel;
-	buf->tail = &buf->sentinel;
+	tty_buffer_reset(buf_sentinel, 0);
+	buf->head = buf_sentinel;
+	buf->tail = buf_sentinel;
 
 	still_used = atomic_xchg(&buf->mem_used, 0);
 	WARN(still_used != freed, "we still have not freed %d bytes!",
@@ -576,11 +579,14 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
 void tty_buffer_init(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
+	struct tty_buffer *buf_sentinel;
+
+	buf_sentinel = container_of(&buf->sentinel, struct tty_buffer, __hdr);
 
 	mutex_init(&buf->lock);
-	tty_buffer_reset(&buf->sentinel, 0);
-	buf->head = &buf->sentinel;
-	buf->tail = &buf->sentinel;
+	tty_buffer_reset(buf_sentinel, 0);
+	buf->head = buf_sentinel;
+	buf->tail = buf_sentinel;
 	init_llist_head(&buf->free);
 	atomic_set(&buf->mem_used, 0);
 	atomic_set(&buf->priority, 0);
diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 31125e3be3c5..5f1221a7eb6c 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -8,19 +8,24 @@
 #include <linux/workqueue.h>
 
 struct tty_buffer {
-	union {
-		struct tty_buffer *next;
-		struct llist_node free;
-	};
-	unsigned int used;
-	unsigned int size;
-	unsigned int commit;
-	unsigned int lookahead;		/* Lazy update on recv, can become less than "read" */
-	unsigned int read;
-	bool flags;
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(tty_buffer_hdr, __hdr,
+		union {
+			struct tty_buffer *next;
+			struct llist_node free;
+		};
+		unsigned int used;
+		unsigned int size;
+		unsigned int commit;
+		unsigned int lookahead;	/* Lazy update on recv, can become less than "read" */
+		unsigned int read;
+		bool flags;
+	);
 	/* Data points here */
 	u8 data[] __aligned(sizeof(unsigned long));
 };
+static_assert(offsetof(struct tty_buffer, data) == sizeof(struct tty_buffer_hdr),
+	      "struct member likely outside of struct_group_tagged()");
 
 static inline u8 *char_buf_ptr(struct tty_buffer *b, unsigned int ofs)
 {
@@ -33,15 +38,15 @@ static inline u8 *flag_buf_ptr(struct tty_buffer *b, unsigned int ofs)
 }
 
 struct tty_bufhead {
-	struct tty_buffer *head;	/* Queue head */
-	struct work_struct work;
-	struct mutex	   lock;
-	atomic_t	   priority;
-	struct tty_buffer sentinel;
-	struct llist_head free;		/* Free queue head */
-	atomic_t	   mem_used;    /* In-use buffers excluding free list */
-	int		   mem_limit;
-	struct tty_buffer *tail;	/* Active buffer */
+	struct tty_buffer	*head;	/* Queue head */
+	struct work_struct	work;
+	struct mutex		lock;
+	atomic_t		priority;
+	struct tty_buffer_hdr	sentinel;
+	struct llist_head	free;		/* Free queue head */
+	atomic_t		mem_used;    /* In-use buffers excluding free list */
+	int			mem_limit;
+	struct tty_buffer	*tail;	/* Active buffer */
 };
 
 /*
-- 
2.43.0

