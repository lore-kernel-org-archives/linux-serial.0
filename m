From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 -firmware] rp2: Initial commit of Comtrol RocketPort 2 microcode
Date: Tue, 29 Jan 2013 10:54:35 -0800
Message-ID: <bf2fff0541e90f31c9d92f1dbda5fa2b@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [69.28.251.93] ([69.28.251.93]:43678 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753029Ab3A2S7A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Jan 2013 13:59:00 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: dwmw2@infradead.org, ben@decadent.org.uk
Cc: grant.edwards@comtrol.com, linux-serial@vger.kernel.org

This is used by drivers/tty/serial/rp2.c.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Grant Edwards <grant.edwards@comtrol.com>
---
 WHENCE |    8 ++++++++
 rp2.fw |  Bin 0 -> 63 bytes
 2 files changed, 8 insertions(+)
 create mode 100644 rp2.fw


This is intended for the linux-firmware repo.

Also available from: git://github.com/cernekee/linux-firmware rp2


diff --git a/WHENCE b/WHENCE
index 96142c2..c3971a2 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2046,3 +2046,11 @@ Downloaded from http://linuxwireless.org/en/users/Drivers/carl9170
 Licence: GPLv2. Some build scripts use the New BSD (3-clause) licence.
 
 --------------------------------------------------------------------------
+
+Driver: rp2 -- Comtrol RocketPort 2 serial driver
+
+File: rp2.fw
+
+Licence: Freely redistributable in any format, per Comtrol.
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
1.7.9.5

