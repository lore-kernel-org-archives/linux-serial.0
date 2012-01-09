From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Subject: [PATCH] Updated TTY MAINTAINERS info
Date: Mon,  9 Jan 2012 17:39:24 -0200
Message-ID: <1326137964-10671-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:42941 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933046Ab2AITjc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Jan 2012 14:39:32 -0500
Received: from /spool/local
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-serial@vger.kernel.org> from <lucaskt@linux.vnet.ibm.com>;
	Mon, 9 Jan 2012 17:39:30 -0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>

Greg Kroah-Hartman is the current TTY maintainer, however he wouldn't appear
listed as such upon running get_maintainers.pl for drivers under
drivers/tty/serial.

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
---
 MAINTAINERS |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc6a466..6a856df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6641,7 +6641,7 @@ TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@suse.de>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty-2.6.git
-F:	drivers/tty/*
+F:	drivers/tty/
 F:	drivers/tty/serial/serial_core.c
 F:	include/linux/serial_core.h
 F:	include/linux/serial.h
-- 
1.7.4.4

