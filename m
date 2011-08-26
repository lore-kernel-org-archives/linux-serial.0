From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ce4100: fix a build error
Date: Fri, 26 Aug 2011 11:23:36 +0100
Message-ID: <20110826102324.16980.61370.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60893 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1HZLU4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 07:20:56 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: x86@kernel.org, linux-serial@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Fix a build error

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 arch/x86/platform/ce4100/ce4100.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index 28071bb..4c61b52 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -109,7 +109,7 @@ static __init void sdv_serial_fixup(void)
 }
 
 #else
-static inline void sdv_serial_fixup(void);
+static inline void sdv_serial_fixup(void) {};
 #endif
 
 static void __init sdv_arch_setup(void)

