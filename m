Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD08030CD9E;
	Wed, 11 Mar 2026 05:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206631; cv=none; b=Jlyiqta5i91LPLFSrTGfsR7koNguK3+0Ou3cYVjLbWOOjwiwUmO8Fy7EfYrtZuw9BX7KhfP1RuC6NSgdXEt8mkT5P2p0b7Q3BQf8VXTtknExtxeUsXP4pP1uEX7lU6bLa0/oYZXjGQgpEGAO+nLEoFJ4VhZrede5uJwkBtQ6Xe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206631; c=relaxed/simple;
	bh=cMg04Dtx82QXwT3YajsGbm62dM+MzTcXjpRCyFwFwww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzFZyK69w+OjVzZ0hmSOj/IsI8W2Et1Hla6rkvtI69Fz/hUIWs+owbPGGQ+pk5vkOCWf6uISj/G1BJHcHVTZvuxkqnnmZz34QVaIP55exhO9l5VciZZogDABRpDammuy/UmgcyivbrWC/wHP76dqP39nM5Tzd1lN4GBemN9CtA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZM8bESKd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZM8bESKd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jhmEJjun7R3TY86Qal3V2Inbbrt7z47euhhHkRmqjEM=; b=ZM8bESKdQWU8nliGiOWbZ8DkHR
	1zkRGfqkh6THjq9aDDX74lRRAGUEgKJoxoLNfAf0VNDRu2a2ky2VXDzD5huJu5+lX2vlDVXKGT8P7
	Nf9DDt554L8+4/4NfYGJdmsdWzv00tl18u2MK5nxyebmhFmlYE9tPYWBb272IGV3lGpu5NNHEFg9I
	B7V8pOatlQ0eQlKqjNsde8N9YNCIo4+r24AEbAsYRxV+vvHyLaQcfSAyUvg+3wi9qu555SAbfSdNf
	E855eNZ2JakZ7JiimWiZle+AlOMgUQq9DAdfzUp8IZyUkCGBijzvkotAHeSttAnOsWSA9a7flnVmK
	pBkn33PQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0C2v-0000000Am2U-1DJ3;
	Wed, 11 Mar 2026 05:23:49 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Rob Herring <robh@kernel.org>,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] serdev: serdev.h: clean up kernel-doc comments
Date: Tue, 10 Mar 2026 22:23:47 -0700
Message-ID: <20260311052347.305612-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct kernel-doc comment format and add a missing to avoid
kernel-doc warnings:

Warning: include/linux/serdev.h:49 struct member 'write_comp' not
 described in 'serdev_device'
Warning: include/linux/serdev.h:49 struct member 'write_lock' not
 described in 'serdev_device'
Warning: include/linux/serdev.h:68 struct member 'shutdown' not described
 in 'serdev_device_driver'
Warning: include/linux/serdev.h:134 function parameter 'serdev' not
 described in 'serdev_device_put'
Warning: include/linux/serdev.h:162 function parameter 'ctrl' not
 described in 'serdev_controller_put'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Rob Herring <robh@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 include/linux/serdev.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- linux-next-20260309.orig/include/linux/serdev.h
+++ linux-next-20260309/include/linux/serdev.h
@@ -37,8 +37,8 @@ struct serdev_device_ops {
  * @nr:		Device number on serdev bus.
  * @ctrl:	serdev controller managing this device.
  * @ops:	Device operations.
- * @write_comp	Completion used by serdev_device_write() internally
- * @write_lock	Lock to serialize access when writing data
+ * @write_comp:	Completion used by serdev_device_write() internally
+ * @write_lock:	Lock to serialize access when writing data
  */
 struct serdev_device {
 	struct device dev;
@@ -60,6 +60,7 @@ static inline struct serdev_device *to_s
  *		structure.
  * @probe:	binds this driver to a serdev device.
  * @remove:	unbinds this driver from the serdev device.
+ * @shutdown:	shut down this serdev device.
  */
 struct serdev_device_driver {
 	struct device_driver driver;
@@ -129,7 +130,7 @@ static inline void serdev_device_set_drv
 
 /**
  * serdev_device_put() - decrement serdev device refcount
- * @serdev	serdev device.
+ * @serdev:	serdev device.
  */
 static inline void serdev_device_put(struct serdev_device *serdev)
 {
@@ -157,7 +158,7 @@ static inline void serdev_controller_set
 
 /**
  * serdev_controller_put() - decrement controller refcount
- * @ctrl	serdev controller.
+ * @ctrl:	serdev controller.
  */
 static inline void serdev_controller_put(struct serdev_controller *ctrl)
 {
