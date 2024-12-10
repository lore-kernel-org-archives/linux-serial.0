Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499BCA934;
	Tue, 10 Dec 2024 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788849; cv=none; b=uk5l/5jzFKxP0aAtCMXfgNhfj27mdchkg0x8qTKcjjCTYfNtj/3iykMEo+ChIzl4l36/fP0MoFutzWlkLcRzwN5S3rPVCE3q9VIAYWSQ14//3GwodcWAvGQHu1ZYSlk5omCj90likAMDBIkJHS2fTxNmAYKSZ+/yJNoINnohu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788849; c=relaxed/simple;
	bh=h3uBjElatKr0hPl6/PqFIk1FIlumz86KPe43ygUTTV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pkeMTeEUJvmiKwQolLDSq4oq7xZ3CTXb7OW21lz9cgNWEUh5B30lk/lzn9ph7My8gKtR7XOCpNTf8eMvpQFPmg+9ice4PN//V7vgPRicYiLTYkcwWAFxPlU5vln26FcG1B/RZQlIFSqxLor+MRZ+hR4k1vn4SsKav3zkmdTIVW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jxd9eSFB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jxd9eSFB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PBXruUUq7CFnP5baKZ7oFYfGkNPXA/nLTilEYn4xNxQ=; b=jxd9eSFB8O7Bg0AfXpNa7MfiD1
	kzUy8ZVQXBLehc9K2sr80w8/4pklxtkLIDpDj1KY3GawCwZ2Y884+0sM6YQL+v3qTUPimhdfEDGRk
	DKlCu2csdL92kq85vCYOCb2doThNFQK1zG9zIcm69+Mq1z9iQdQl9DL2gbwM//zzuMPqWIkYjj9tH
	1vNN97oq9QTOWzMiJ2MgDjM800Jzs5FZIrBaqGGd4zVRtZuB7eUuefjmCbi1myuqFban3TYhbRmq6
	ggj1AmmlX5zw6qu/fQl1U5inxiW7eksB0PCeF8PaFeCVm/nGjY6SKa0BFUCJl01ZjeW6jUXrGLNi9
	crp1Jcmw==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKngD-00000009dUD-10C1;
	Tue, 10 Dec 2024 00:00:45 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Jonathan Corbet <corbet@lwn.net>,
	workflows@vger.kernel.org,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-debuggers@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net,
	Alex Shi <alexs@kernel.org>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH v3] Documentation: move dev-tools debugging files to process/debugging/
Date: Mon,  9 Dec 2024 16:00:41 -0800
Message-ID: <20241210000041.305477-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move gdb and kgdb debugging documentation to the dedicated
debugging directory (Documentation/process/debugging/).
Adjust the index.rst files to follow the file movement.
Adjust files that refer to these moved files to follow the file movement.
Update location of kgdb.rst in MAINTAINERS file.
Add a link from dev-tools/index to process/debugging/index.

Note: translations are not updated.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Daniel Thompson <danielt@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: linux-debuggers@vger.kernel.org
Cc: kgdb-bugreport@lists.sourceforge.net
Cc: Doug Anderson <dianders@chromium.org>
Cc: Alex Shi <alexs@kernel.org>
Cc: Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Daniel Thompson <danielt@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v3: add link to process/debugging/index from dev-tools/index.

@Andrew, please drop v2 of this patch.

 Documentation/admin-guide/README.rst                                 | 4 ++--
 Documentation/dev-tools/index.rst                                    | 5 +++--
 .../{dev-tools => process/debugging}/gdb-kernel-debugging.rst        | 0
 Documentation/process/debugging/index.rst                            | 2 ++
 Documentation/{dev-tools => process/debugging}/kgdb.rst              | 0
 MAINTAINERS                                                          | 2 +-
 include/linux/tty_driver.h                                           | 2 +-
 lib/Kconfig.debug                                                    | 2 +-
 lib/Kconfig.kgdb                                                     | 2 +-
 9 files changed, 11 insertions(+), 8 deletions(-)


diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index f2bebff6a733..eb9452668909 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -356,5 +356,5 @@ instructions at 'Documentation/admin-guide/reporting-issues.rst'.
 
 Hints on understanding kernel bug reports are in
 'Documentation/admin-guide/bug-hunting.rst'. More on debugging the kernel
-with gdb is in 'Documentation/dev-tools/gdb-kernel-debugging.rst' and
-'Documentation/dev-tools/kgdb.rst'.
+with gdb is in 'Documentation/process/debugging/gdb-kernel-debugging.rst' and
+'Documentation/process/debugging/kgdb.rst'.
diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 3c0ac08b2709..65c54b27a60b 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -10,6 +10,9 @@ whole; patches welcome!
 A brief overview of testing-specific tools can be found in
 Documentation/dev-tools/testing-overview.rst
 
+Tools that are specific to debugging can be found in
+Documentation/process/debugging/index.rst
+
 .. toctree::
    :caption: Table of contents
    :maxdepth: 2
@@ -27,8 +30,6 @@ Documentation/dev-tools/testing-overview.rst
    kmemleak
    kcsan
    kfence
-   gdb-kernel-debugging
-   kgdb
    kselftest
    kunit/index
    ktap
diff --git a/Documentation/dev-tools/gdb-kernel-debugging.rst b/Documentation/process/debugging/gdb-kernel-debugging.rst
similarity index 100%
rename from Documentation/dev-tools/gdb-kernel-debugging.rst
rename to Documentation/process/debugging/gdb-kernel-debugging.rst
diff --git a/Documentation/process/debugging/index.rst b/Documentation/process/debugging/index.rst
index f6e4a00dfee3..387d33d16f5e 100644
--- a/Documentation/process/debugging/index.rst
+++ b/Documentation/process/debugging/index.rst
@@ -11,6 +11,8 @@ general guides
    :maxdepth: 1
 
    driver_development_debugging_guide
+   gdb-kernel-debugging
+   kgdb
    userspace_debugging_guide
 
 .. only::  subproject and html
diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/process/debugging/kgdb.rst
similarity index 100%
rename from Documentation/dev-tools/kgdb.rst
rename to Documentation/process/debugging/kgdb.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..1753fe792d04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12809,7 +12809,7 @@ L:	kgdb-bugreport@lists.sourceforge.net
 S:	Maintained
 W:	http://kgdb.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git
-F:	Documentation/dev-tools/kgdb.rst
+F:	Documentation/process/debugging/kgdb.rst
 F:	drivers/misc/kgdbts.c
 F:	drivers/tty/serial/kgdboc.c
 F:	include/linux/kdb.h
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index dd4b31ce6d5d..d4cdc089f6c3 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -320,7 +320,7 @@ struct serial_struct;
  *
  * @poll_init: ``int ()(struct tty_driver *driver, int line, char *options)``
  *
- *	kgdboc support (Documentation/dev-tools/kgdb.rst). This routine is
+ *	kgdboc support (Documentation/process/debugging/kgdb.rst). This routine is
  *	called to initialize the HW for later use by calling @poll_get_char or
  *	@poll_put_char.
  *
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d723705879..d2cf74cbbe70 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -433,7 +433,7 @@ config GDB_SCRIPTS
 	  build directory. If you load vmlinux into gdb, the helper
 	  scripts will be automatically imported by gdb as well, and
 	  additional functions are available to analyze a Linux kernel
-	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
+	  instance. See Documentation/process/debugging/gdb-kernel-debugging.rst
 	  for further details.
 
 endif # DEBUG_INFO
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index 537e1b3f5734..8336b1a489a3 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -19,7 +19,7 @@ menuconfig KGDB
 	  CONFIG_FRAME_POINTER to aid in producing more reliable stack
 	  backtraces in the external debugger.  Documentation of
 	  kernel debugger is available at http://kgdb.sourceforge.net
-	  as well as in Documentation/dev-tools/kgdb.rst.  If
+	  as well as in Documentation/process/debugging/kgdb.rst.  If
 	  unsure, say N.
 
 if KGDB
