Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815146BF;
	Thu,  6 Feb 2025 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738813193; cv=none; b=kBOaJ3c3MBhoR5qFEve0vx198IEf4DljY0WOVgnYH2Lf4+OTQ+rZ9d/Li3wepS+NkJ0hr9A+dvq+faKVtjpJlj5SChGa0hlFFqWs0LMIosPXN9BStYXyV8ozlc2gqiVd44M6eXV+EobCpLpxFUZ4l6GC2PKas9mFixQEeI9cn9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738813193; c=relaxed/simple;
	bh=u+KIz+0ekM8kKBmnoSW/Z79RFvrLdFsyi8HjKjHTJMs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tup2G/DMx1hVgViKFb0I4H3So0qUjbOO9r8/9RKLkut/O1cUOUf4+X8hZTlsaT7p9j9PNjS1LIztmThhaI3ooC2TmJkWmY/6cGLwfYMN/yylkGu6Og85elH+AvKl9vtROE6Wn/qcOLiuBjmc8Cd4/jTnrnwXGXT4KdpSOrgy5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzs33vJJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzs33vJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774D3C4CEDD;
	Thu,  6 Feb 2025 03:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738813193;
	bh=u+KIz+0ekM8kKBmnoSW/Z79RFvrLdFsyi8HjKjHTJMs=;
	h=Date:From:To:Cc:Subject:From;
	b=Nzs33vJJH8jhCPsjbGraDBKMYDzg9vhFUp8nd5upsZmh8FGuJuXW2qk3xWQ7IyHkB
	 pwb4XvV70lZiXFHtord6mtTkSelGI5QaiXEEvI7uC+z5rzZSfDhM62Vu7WCxyyx/FW
	 vIjhidsGy7BgylnlUA52kGENqtmp5j91mC9gzHPUSJJTBBuQUTMRrsRZJHbQUe0nqQ
	 s+s+Cg6R1XkCPmncVJlWfjPHmd+Xldtals9xsrbC+zHXZIbPAHOPLTmgcchaRIa23l
	 jW27wokHsOSTFLAmmwGIVN43JznVe+Wb/0jL1B13vuWG5OamcAAwWTxf0M76xieuo3
	 48n+06bBxXPaQ==
Date: Thu, 6 Feb 2025 14:09:45 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z6QvAZxiQusdaDkH@kspp>
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

Currently, member `sentinel` in `struct tty_bufhead` is causing trouble
becase its type is `struct tty_buffer`, which is a flexible structure
--meaning it contains a flexible-array member. This combined with the
fact that `sentinel` is positioned in the middle of `struct tty_bufhead`,
triggers hundreds of -Wflex-array-member-not-at-end warnings because
flex-array members in the middle of structures are deprecated, and all
code involving them should be fixed/refactored/adjusted --flex-array
members are only allowed at the very end of any number of nested
structures. Enabling -Wflex-array-member-not-at-end globally will
enforce this behavior.

So, in this particular case, we create a new `struct tty_buffer_hdr`
to enclose the header part of flexible structure `struct tty_buffer`
This is all the members except the flexible array `data[]`. We then
replace that header part with `struct tty_buffer_hdr hdr;` in
`struct tty_buffer`, and change the type of `sentinel` from `struct
tty_buffer` to `struct tty_buffer_hdr` --this bit gets rid of the
flex-array-in-the-middle part.

The next step is to refactor the rest of the related code, accordingly.
Which means, adding a bunch of `hdr.` wherever it's needed.

Lastly, we use `container_of()` whenever we need to retrieve a pointer
to the flexible structure `struct tty_buffer`.

So, with these changes, fix 384 of the following warnings:
include/linux/tty_buffer.h:40:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Implement `struct tty_buffer_hdr` as a separate struct and embed it
   into `struct tty_buffer`. Refactor the rest of the code, accordingly.

Changes in v2:
 - Fix a space at the beginning of the line issue, and adjust the
   identation of a code coment.
 - Link: https://lore.kernel.org/linux-hardening/Z6L29DXeGWl-6OnK@kspp/

v1:
 -  Link: https://lore.kernel.org/linux-hardening/Z6L1XwE-WEzcGFwv@kspp/

 drivers/tty/tty_buffer.c   | 114 +++++++++++++++++++------------------
 include/linux/tty_buffer.h |  12 ++--
 include/linux/tty_flip.h   |  10 ++--
 3 files changed, 73 insertions(+), 63 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 79f0ff94ce00..cd04a6567a33 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(tty_buffer_lock_exclusive);
 void tty_buffer_unlock_exclusive(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
-	bool restart = buf->head->commit != buf->head->read;
+	bool restart = buf->head->hdr.commit != buf->head->hdr.read;
 
 	atomic_dec(&buf->priority);
 	mutex_unlock(&buf->lock);
@@ -101,13 +101,13 @@ EXPORT_SYMBOL_GPL(tty_buffer_space_avail);
 
 static void tty_buffer_reset(struct tty_buffer *p, size_t size)
 {
-	p->used = 0;
-	p->size = size;
-	p->next = NULL;
-	p->commit = 0;
-	p->lookahead = 0;
-	p->read = 0;
-	p->flags = true;
+	p->hdr.used = 0;
+	p->hdr.size = size;
+	p->hdr.next = NULL;
+	p->hdr.commit = 0;
+	p->hdr.lookahead = 0;
+	p->hdr.read = 0;
+	p->hdr.flags = true;
 }
 
 /**
@@ -120,24 +120,27 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
 void tty_buffer_free_all(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
+	struct tty_buffer *buf_sentinel;
 	struct tty_buffer *p, *next;
 	struct llist_node *llist;
 	unsigned int freed = 0;
 	int still_used;
 
+	buf_sentinel = container_of(&buf->sentinel, struct tty_buffer, hdr);
+
 	while ((p = buf->head) != NULL) {
-		buf->head = p->next;
-		freed += p->size;
-		if (p->size > 0)
+		buf->head = p->hdr.next;
+		freed += p->hdr.size;
+		if (p->hdr.size > 0)
 			kfree(p);
 	}
 	llist = llist_del_all(&buf->free);
-	llist_for_each_entry_safe(p, next, llist, free)
+	llist_for_each_entry_safe(p, next, llist, hdr.free)
 		kfree(p);
 
-	tty_buffer_reset(&buf->sentinel, 0);
-	buf->head = &buf->sentinel;
-	buf->tail = &buf->sentinel;
+	tty_buffer_reset(buf_sentinel, 0);
+	buf->head = buf_sentinel;
+	buf->tail = buf_sentinel;
 
 	still_used = atomic_xchg(&buf->mem_used, 0);
 	WARN(still_used != freed, "we still have not freed %d bytes!",
@@ -167,7 +170,7 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 	if (size <= MIN_TTYB_SIZE) {
 		free = llist_del_first(&port->buf.free);
 		if (free) {
-			p = llist_entry(free, struct tty_buffer, free);
+			p = llist_entry(free, struct tty_buffer, hdr.free);
 			goto found;
 		}
 	}
@@ -200,12 +203,12 @@ static void tty_buffer_free(struct tty_port *port, struct tty_buffer *b)
 	struct tty_bufhead *buf = &port->buf;
 
 	/* Dumb strategy for now - should keep some stats */
-	WARN_ON(atomic_sub_return(b->size, &buf->mem_used) < 0);
+	WARN_ON(atomic_sub_return(b->hdr.size, &buf->mem_used) < 0);
 
-	if (b->size > MIN_TTYB_SIZE)
+	if (b->hdr.size > MIN_TTYB_SIZE)
 		kfree(b);
-	else if (b->size > 0)
-		llist_add(&b->free, &buf->free);
+	else if (b->hdr.size > 0)
+		llist_add(&b->hdr.free, &buf->free);
 }
 
 /**
@@ -230,12 +233,12 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 	/* paired w/ release in __tty_buffer_request_room; ensures there are
 	 * no pending memory accesses to the freed buffer
 	 */
-	while ((next = smp_load_acquire(&buf->head->next)) != NULL) {
+	while ((next = smp_load_acquire(&buf->head->hdr.next)) != NULL) {
 		tty_buffer_free(port, buf->head);
 		buf->head = next;
 	}
-	buf->head->read = buf->head->commit;
-	buf->head->lookahead = buf->head->read;
+	buf->head->hdr.read = buf->head->hdr.commit;
+	buf->head->hdr.lookahead = buf->head->hdr.read;
 
 	if (ld && ld->ops->flush_buffer)
 		ld->ops->flush_buffer(tty);
@@ -263,8 +266,8 @@ static int __tty_buffer_request_room(struct tty_port *port, size_t size,
 {
 	struct tty_bufhead *buf = &port->buf;
 	struct tty_buffer *n, *b = buf->tail;
-	size_t left = (b->flags ? 1 : 2) * b->size - b->used;
-	bool change = !b->flags && flags;
+	size_t left = (b->hdr.flags ? 1 : 2) * b->hdr.size - b->hdr.used;
+	bool change = !b->hdr.flags && flags;
 
 	if (!change && left >= size)
 		return size;
@@ -274,19 +277,19 @@ static int __tty_buffer_request_room(struct tty_port *port, size_t size,
 	if (n == NULL)
 		return change ? 0 : left;
 
-	n->flags = flags;
+	n->hdr.flags = flags;
 	buf->tail = n;
 	/*
 	 * Paired w/ acquire in flush_to_ldisc() and lookahead_bufs()
 	 * ensures they see all buffer data.
 	 */
-	smp_store_release(&b->commit, b->used);
+	smp_store_release(&b->hdr.commit, b->hdr.used);
 	/*
 	 * Paired w/ acquire in flush_to_ldisc() and lookahead_bufs()
 	 * ensures the latest commit value can be read before the head
 	 * is advanced to the next buffer.
 	 */
-	smp_store_release(&b->next, n);
+	smp_store_release(&b->hdr.next, n);
 
 	return size;
 }
@@ -312,19 +315,19 @@ size_t __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
 		if (unlikely(space == 0))
 			break;
 
-		memcpy(char_buf_ptr(tb, tb->used), chars, space);
+		memcpy(char_buf_ptr(tb, tb->hdr.used), chars, space);
 
 		if (mutable_flags) {
-			memcpy(flag_buf_ptr(tb, tb->used), flags, space);
+			memcpy(flag_buf_ptr(tb, tb->hdr.used), flags, space);
 			flags += space;
-		} else if (tb->flags) {
-			memset(flag_buf_ptr(tb, tb->used), flags[0], space);
+		} else if (tb->hdr.flags) {
+			memset(flag_buf_ptr(tb, tb->hdr.used), flags[0], space);
 		} else {
 			/* tb->flags should be available once requested */
 			WARN_ON_ONCE(need_flags);
 		}
 
-		tb->used += space;
+		tb->hdr.used += space;
 		copied += space;
 		chars += space;
 
@@ -358,10 +361,10 @@ size_t tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size)
 	if (likely(space)) {
 		struct tty_buffer *tb = port->buf.tail;
 
-		*chars = char_buf_ptr(tb, tb->used);
-		if (tb->flags)
-			memset(flag_buf_ptr(tb, tb->used), TTY_NORMAL, space);
-		tb->used += space;
+		*chars = char_buf_ptr(tb, tb->hdr.used);
+		if (tb->hdr.flags)
+			memset(flag_buf_ptr(tb, tb->hdr.used), TTY_NORMAL, space);
+		tb->hdr.used += space;
 	}
 
 	return space;
@@ -396,7 +399,7 @@ EXPORT_SYMBOL_GPL(tty_ldisc_receive_buf);
 
 static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
 {
-	head->lookahead = max(head->lookahead, head->read);
+	head->hdr.lookahead = max(head->hdr.lookahead, head->hdr.read);
 
 	while (head) {
 		struct tty_buffer *next;
@@ -407,12 +410,12 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
 		 * ensures commit value read is not stale if the head
 		 * is advancing to the next buffer.
 		 */
-		next = smp_load_acquire(&head->next);
+		next = smp_load_acquire(&head->hdr.next);
 		/*
 		 * Paired w/ release in __tty_buffer_request_room() or in
 		 * tty_buffer_flush(); ensures we see the committed buffer data.
 		 */
-		count = smp_load_acquire(&head->commit) - head->lookahead;
+		count = smp_load_acquire(&head->hdr.commit) - head->hdr.lookahead;
 		if (!count) {
 			head = next;
 			continue;
@@ -421,26 +424,26 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
 		if (port->client_ops->lookahead_buf) {
 			u8 *p, *f = NULL;
 
-			p = char_buf_ptr(head, head->lookahead);
-			if (head->flags)
-				f = flag_buf_ptr(head, head->lookahead);
+			p = char_buf_ptr(head, head->hdr.lookahead);
+			if (head->hdr.flags)
+				f = flag_buf_ptr(head, head->hdr.lookahead);
 
 			port->client_ops->lookahead_buf(port, p, f, count);
 		}
 
-		head->lookahead += count;
+		head->hdr.lookahead += count;
 	}
 }
 
 static size_t
 receive_buf(struct tty_port *port, struct tty_buffer *head, size_t count)
 {
-	u8 *p = char_buf_ptr(head, head->read);
+	u8 *p = char_buf_ptr(head, head->hdr.read);
 	const u8 *f = NULL;
 	size_t n;
 
-	if (head->flags)
-		f = flag_buf_ptr(head, head->read);
+	if (head->hdr.flags)
+		f = flag_buf_ptr(head, head->hdr.read);
 
 	n = port->client_ops->receive_buf(port, p, f, count);
 	if (n > 0)
@@ -479,11 +482,11 @@ static void flush_to_ldisc(struct work_struct *work)
 		 * ensures commit value read is not stale if the head
 		 * is advancing to the next buffer
 		 */
-		next = smp_load_acquire(&head->next);
+		next = smp_load_acquire(&head->hdr.next);
 		/* paired w/ release in __tty_buffer_request_room() or in
 		 * tty_buffer_flush(); ensures we see the committed buffer data
 		 */
-		count = smp_load_acquire(&head->commit) - head->read;
+		count = smp_load_acquire(&head->hdr.commit) - head->hdr.read;
 		if (!count) {
 			if (next == NULL)
 				break;
@@ -493,7 +496,7 @@ static void flush_to_ldisc(struct work_struct *work)
 		}
 
 		rcvd = receive_buf(port, head, count);
-		head->read += rcvd;
+		head->hdr.read += rcvd;
 		if (rcvd < count)
 			lookahead_bufs(port, head);
 		if (!rcvd)
@@ -513,7 +516,7 @@ static inline void tty_flip_buffer_commit(struct tty_buffer *tail)
 	 * Paired w/ acquire in flush_to_ldisc(); ensures flush_to_ldisc() sees
 	 * buffer data.
 	 */
-	smp_store_release(&tail->commit, tail->used);
+	smp_store_release(&tail->hdr.commit, tail->hdr.used);
 }
 
 /**
@@ -576,11 +579,14 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
 void tty_buffer_init(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
+	struct tty_buffer *buf_sentinel;
+
+	buf_sentinel = container_of(&buf->sentinel, struct tty_buffer, hdr);
 
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
index 31125e3be3c5..80a9d7832c97 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -7,7 +7,7 @@
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
 
-struct tty_buffer {
+struct tty_buffer_hdr {
 	union {
 		struct tty_buffer *next;
 		struct llist_node free;
@@ -15,9 +15,13 @@ struct tty_buffer {
 	unsigned int used;
 	unsigned int size;
 	unsigned int commit;
-	unsigned int lookahead;		/* Lazy update on recv, can become less than "read" */
+	unsigned int lookahead; /* Lazy update on recv, can become less than "read" */
 	unsigned int read;
 	bool flags;
+};
+
+struct tty_buffer {
+	struct tty_buffer_hdr hdr;
 	/* Data points here */
 	u8 data[] __aligned(sizeof(unsigned long));
 };
@@ -29,7 +33,7 @@ static inline u8 *char_buf_ptr(struct tty_buffer *b, unsigned int ofs)
 
 static inline u8 *flag_buf_ptr(struct tty_buffer *b, unsigned int ofs)
 {
-	return char_buf_ptr(b, ofs) + b->size;
+	return char_buf_ptr(b, ofs) + b->hdr.size;
 }
 
 struct tty_bufhead {
@@ -37,7 +41,7 @@ struct tty_bufhead {
 	struct work_struct work;
 	struct mutex	   lock;
 	atomic_t	   priority;
-	struct tty_buffer sentinel;
+	struct tty_buffer_hdr sentinel;
 	struct llist_head free;		/* Free queue head */
 	atomic_t	   mem_used;    /* In-use buffers excluding free list */
 	int		   mem_limit;
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index af4fce98f64e..1874b0059e97 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -67,11 +67,11 @@ static inline size_t tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag)
 	struct tty_buffer *tb = port->buf.tail;
 	int change;
 
-	change = !tb->flags && (flag != TTY_NORMAL);
-	if (!change && tb->used < tb->size) {
-		if (tb->flags)
-			*flag_buf_ptr(tb, tb->used) = flag;
-		*char_buf_ptr(tb, tb->used++) = ch;
+	change = !tb->hdr.flags && (flag != TTY_NORMAL);
+	if (!change && tb->hdr.used < tb->hdr.size) {
+		if (tb->hdr.flags)
+			*flag_buf_ptr(tb, tb->hdr.used) = flag;
+		*char_buf_ptr(tb, tb->hdr.used++) = ch;
 		return 1;
 	}
 	return __tty_insert_flip_string_flags(port, &ch, &flag, false, 1);
-- 
2.43.0

