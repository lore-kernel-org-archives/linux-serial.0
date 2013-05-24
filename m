From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 -firmware] rp2: Initial commit of Comtrol RocketPort 2 microcode
Date: Fri, 24 May 2013 00:53:10 -0700
Message-ID: <1369381990-8640-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:59397 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758598Ab3EXHy2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 May 2013 03:54:28 -0400
Received: by mail-pd0-f174.google.com with SMTP id 3so2036178pdj.5
        for <linux-serial@vger.kernel.org>; Fri, 24 May 2013 00:54:28 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: ben@decadent.org.uk, dwmw2@infradead.org
Cc: linux-serial@vger.kernel.org, grant.edwards@comtrol.com, nick.thompson@comtrol.com

This is used by drivers/tty/serial/rp2.c.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Grant Edwards <grant.edwards@comtrol.com>
Signed-off-by: Nick Thompson <nick.thompson@comtrol.com>
---
 WHENCE |   18 ++++++++++++++++++
 rp2.fw |  Bin 0 -> 63 bytes
 2 files changed, 18 insertions(+)
 create mode 100644 rp2.fw


V3: Update license text after clearing the changes with the vendor

git pull: git://github.com/cernekee/linux-firmware rp2


diff --git a/WHENCE b/WHENCE
index c08336a..b7c6169 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2110,3 +2110,21 @@ File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
 Licence: Redistributable. See LICENCE.ibt_firmware for details
 
 --------------------------------------------------------------------------
+
+Driver: rp2 -- Comtrol RocketPort 2 serial driver
+
+File: rp2.fw
+
+Licence:
+Copyright (C) 2013 Comtrol Corporation
+
+Comtrol grants permission to use and redistribute these firmware
+files for use with Comtrol devices, but not as part of the Linux
+kernel or in any other form which would require these files themselves
+to be covered by the terms of the GNU General Public License.
+
+These firmware files are distributed in the hope that they will be
+useful, but WITHOUT ANY WARRANTY; without even the implied warranty
+of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
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

