From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH -firmware 3/3] rp2: Initial commit of Comtrol RocketPort 2 microcode
Date: Sat, 29 Dec 2012 23:23:24 -0800
Message-ID: <4afa5e3b9acea9c3d4a9255a0f5be260@localhost>
References: <bd10fdeead3e321db2bb291c0b722203@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [69.28.251.93] ([69.28.251.93]:50673 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab2L3HhE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 30 Dec 2012 02:37:04 -0500
In-Reply-To: <bd10fdeead3e321db2bb291c0b722203@localhost>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: dwmw2@infradead.org, ben@decadent.org.uk
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 WHENCE |   13 +++++++++++++
 rp2.fw |  Bin 0 -> 63 bytes
 2 files changed, 13 insertions(+)
 create mode 100644 rp2.fw


This is intended for the linux-firmware repo.

Also available from: git://github.com/cernekee/linux-firmware rp2


diff --git a/WHENCE b/WHENCE
index b7dcda3..3923185 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2034,3 +2034,16 @@ useful, but WITHOUT ANY WARRANTY; without even the implied warranty
 of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 
 --------------------------------------------------------------------------
+
+Driver: rp2 -- Comtrol RocketPort 2 serial driver
+
+File: rp2.fw
+
+Licence: Allegedly GPLv2+, but no source visible. Marked:
+
+  // RocketPort Infinity/Express device driver for Linux
+  // Copyright (C) 2004-2011 Comtrol, Inc.
+
+Found in hex form in the manufacturer's GPL out-of-tree driver sources.
+
+--------------------------------------------------------------------------
diff --git a/rp2.fw b/rp2.fw
new file mode 100644
index 0000000000000000000000000000000000000000..a571e77925d479cbd4d17e72f49ee9b90bc8e2d7
GIT binary patch
literal 63
zcmey?J@<(45y2S>T#8)1zuFib1SPo`9E2sgel;_4F>pEl?>v;&);Q52wGYhba7b-!
NVQAvw-~s^-E&$nE6vO}k

literal 0
HcmV?d00001

-- 
1.7.10.4

