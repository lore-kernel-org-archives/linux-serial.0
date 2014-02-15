From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] serial: max310x: Fix devicetree documentation for clock name
Date: Sat, 15 Feb 2014 14:59:02 +0400
Message-ID: <1392461942-19328-2-git-send-email-shc_work@mail.ru>
References: <1392461942-19328-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp33.i.mail.ru ([94.100.177.93]:43821 "EHLO smtp33.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbaBOK7M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 15 Feb 2014 05:59:12 -0500
In-Reply-To: <1392461942-19328-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

Clock names mistakenly given opposite. This patch fix this issue.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/serial/maxim,max310x.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.txt b/Documentation/devicetree/bindings/serial/maxim,max310x.txt
index 0daf780..83a919c 100644
--- a/Documentation/devicetree/bindings/serial/maxim,max310x.txt
+++ b/Documentation/devicetree/bindings/serial/maxim,max310x.txt
@@ -13,8 +13,8 @@ Required properties:
   controller. The format of the interrupt specifier depends on the
   parent interrupt controller.
 - clocks: phandle to the IC source clock.
-- clock-names: Should be "osc" if clock is an external crystal or
-  "xtal" if an external clock source is used.
+- clock-names: Should be "xtal" if clock is an external crystal or
+  "osc" if an external clock source is used.
 
 Optional properties:
 - gpio-controller: Marks the device node as a GPIO controller.
-- 
1.8.3.2

