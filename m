From: yegorslists@googlemail.com
Subject: [PATCH] Documentation: serial: fix header path
Date: Wed, 13 Aug 2014 15:54:48 +0200
Message-ID: <1407938088-7099-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.visionsystems.de ([213.209.99.202]:41758 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaHMO1a (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Aug 2014 10:27:30 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@suse.de, trivial@kernel.org, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

RS485 related structure will be defined in user space API
header.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 Documentation/serial/serial-rs485.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/serial/serial-rs485.txt b/Documentation/serial/serial-rs485.txt
index 41c8378..39dac95 100644
--- a/Documentation/serial/serial-rs485.txt
+++ b/Documentation/serial/serial-rs485.txt
@@ -132,5 +132,5 @@
 
 5. REFERENCES
 
- [1]	include/linux/serial.h
+ [1]	include/uapi/linux/serial.h
  [2]	Documentation/devicetree/bindings/serial/rs485.txt
-- 
1.7.7

