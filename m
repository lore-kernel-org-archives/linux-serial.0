From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 4/4] serial: bfin_5xx: pull in linux/io.h for ioremap prototypes
Date: Thu, 17 Sep 2009 17:52:28 -0400
Message-ID: <1253224348-6996-4-git-send-email-vapier@gentoo.org>
References: <1253224348-6996-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:49487 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636AbZIQVw2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Sep 2009 17:52:28 -0400
In-Reply-To: <1253224348-6996-1-git-send-email-vapier@gentoo.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

git-svn-id: svn://localhost/svn/linux-kernel/trunk@7305 526b6c2d-f592-4532-a319-5dd88ccb003d
---
 drivers/serial/bfin_5xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/bfin_5xx.c b/drivers/serial/bfin_5xx.c
index 67fa057..c969a68 100644
--- a/drivers/serial/bfin_5xx.c
+++ b/drivers/serial/bfin_5xx.c
@@ -14,6 +14,7 @@
 
 #include <linux/module.h>
 #include <linux/ioport.h>
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/sysrq.h>
-- 
1.6.5.rc1

