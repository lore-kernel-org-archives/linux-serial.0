From: joe@perches.com
Subject: [PATCH] [547/2many] MAINTAINERS - XILINX UARTLITE SERIAL DRIVER
Date: Sun, 12 Aug 2007 23:39:53 -0700
Message-ID: <46bffcb9.DiGt/lxDU9Y5bBxR%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from DSL022.labridge.com ([206.117.136.22]:2492 "EHLO perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967471AbXHMGkN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Aug 2007 02:40:13 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@linux-foundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jacmet@sunsite.dk, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index e400d13..14de518 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5175,6 +5175,7 @@ P:	Peter Korsgaard
 M:	jacmet@sunsite.dk
 L:	linux-serial@vger.kernel.org
 S:	Maintained
+F:	drivers/serial/uartlite.c
 
 X86 3-LEVEL PAGING (PAE) SUPPORT
 P:	Ingo Molnar
