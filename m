Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F77493D2D;
	Thu, 17 Sep 2026 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679742; cv=none; b=f2TEHPunSkC940U8YnuIz98pQ9CiK3EbWdsUM+3T6DG94TXvazcpGm3IliMFqUC4MzxMr7vQlNXJMaddM096TBTkCljShK9rFhbGNCMsBH2md857ohdnf5UcoaJBCD1EYMo8szRCbfl1giUKJW2sZ2vYNugS0Hy7RNgLVNeKySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679742; c=relaxed/simple;
	bh=UhfQvxugMW6hUP0cAn4RiyeZI8i+WHjc8dVSYSnXz2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TUkX0rlD5y4Getx+gQG4aArjng3SSgGyFLqIl+FNi4mQN6yoK+5VFy13nPPe+YX+RdIERRrDg+TEXGh4z0BV2MsCqo3K1QvoZwkXbb1OlcHq6MTI56DIvpNM6GLbrN2iEuayMwdwRJg8ArjtIbNXopwzkhS/C/NriHyoWiAQQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxBqAAQp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxBqAAQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA341F00893;
	Thu, 17 Sep 2026 21:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679741;
	bh=eOpQDnMf+AB8WkYSACAUKxEVO3CB5UP1ETrdTKsT3P0=;
	h=From:To:Cc:Subject:Date;
	b=PxBqAAQpk8H9JLyVIFHVUJ4Mq96ql2VXXhou3khTprQA0R4ziA5/8F7FqOLknAJz4
	 NB4BV38lfdUD5UA6MH8j3TSR0lABz3r8bG4D/wUpwS6KtyxhpZcI5G9hs8ORS3QKqu
	 WaWpe7dPfm+Ki4w8nxRNHlUAe5dCM0YgUR3gc9wI00qvXNKPmd4tDSO1cYp/FO6aTi
	 u+PksqZFn9fBCuAtKehZ+Vw9qKK9QggPh6O06IOg6bW63fr1AhCs4jPaWgp8nNWsfv
	 EMKQ/wu6l3C2jtS+Lds5G5WpBWDPUeJEE4/rXNUK/iZgDfM3aK6y5urx9fQZaRoTwy
	 Ggb88/UFIFzQA==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org,
	Alexey Gladkov <legion@kernel.org>,
	Joshua Rogers <linux@joshua.hu>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] vt: keyboard: Allocate new_map with ARRAY_SIZE()
Date: Thu, 17 Sep 2026 14:15:40 -0700
Message-Id: <20260917211539.i.636-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=kees@kernel.org; h=from:subject:message-id; bh=jPYzdx1aQPkuPmnEsl4NdLIuyaJAdI6EAJdbt6oWvuc=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrIqqXbGf0ONR2gFm30kxy94z0YrvZr5YfWRMdO/PGI zbJOPeejlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkILGL47+A1wS1Z8MMOc51a l3TTl/6PK2bftdS+brl37u+i9Ttl0hn+2Rhd82gXqu7UqJs8X/1xWMt00ReLGoQ8uOLkSh/9mny DEwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for converting the kmalloc family of allocators to the
type-aware kmalloc_obj family, we need to make sure that the returned
type from the allocation matches the type of the variable being
assigned. (The kmalloc family returns "void *", which can be implicitly
cast to any pointer type.)

The new key map has as many entries as plain_map, but the size was taken
from the whole array, which would make the allocation type a pointer to
the array rather than the "unsigned short *" being assigned. Allocate
ARRAY_SIZE-many entries instead. The resulting allocation size is the
same.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/tty/vt/keyboard.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>
Cc: <linux-serial@vger.kernel.org>
---
 drivers/tty/vt/keyboard.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c41d850b29c6..ef4a19aeb3ce 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2002,7 +2002,9 @@ static int vt_kdskbent(unsigned char kbdmode, unsigned char idx,
 		return 0;
 #endif
 
-	unsigned short __free(kfree) *new_map = kmalloc(sizeof(plain_map), GFP_KERNEL);
+	unsigned short __free(kfree) *new_map =
+		kmalloc_array(ARRAY_SIZE(plain_map), sizeof(*new_map),
+			      GFP_KERNEL);
 	if (!new_map)
 		return -ENOMEM;
 
-- 
2.34.1

