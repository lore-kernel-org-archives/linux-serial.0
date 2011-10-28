From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Subject: [PATCH] jsm: Change maintainership
Date: Fri, 28 Oct 2011 13:52:08 -0200
Message-ID: <1319817128-20038-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:33862 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab1J1Pwi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Oct 2011 11:52:38 -0400
Received: from /spool/local
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-serial@vger.kernel.org> from <lucaskt@linux.vnet.ibm.com>;
	Fri, 28 Oct 2011 13:52:34 -0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>, Breno Leitao <leitao@linux.vnet.ibm.com>

Breno Leitao has passed the maintainership on to me.

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
CC: Breno Leitao <leitao@linux.vnet.ibm.com>
---
 MAINTAINERS |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27af9c9..84b0b5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3654,7 +3654,7 @@ F:	fs/jbd2/
 F:	include/linux/jbd2.h
 
 JSM Neo PCI based serial card
-M:	Breno Leitao <leitao@linux.vnet.ibm.com>
+M:	Lucas Tavares <lucaskt@linux.vnet.ibm.com>
 L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/serial/jsm/
-- 
1.7.4.4

