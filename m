From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 66/79] h8300: drivers/serial/Kconfig was moved
Date: Wed, 26 Oct 2011 14:13:11 +0200
Message-ID: <1319631204-23262-66-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32853 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932952Ab1JZMN7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:59 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Paul Bolle <pebolle@tiscali.nl>, Greg Kroah-Hartman <gregkh@suse.de>

From: Paul Bolle <pebolle@tiscali.nl>

commit ab4382d27412e7e3e7c936e8d50d8888dfac3df8 moved
drivers/serial/Kconfig to drivers/tty/serial/Kconfig, so we need to
source the latter file.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/h8300/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 091ed61..2b1eee7 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -195,7 +195,7 @@ config UNIX98_PTYS
 
 source "drivers/char/pcmcia/Kconfig"
 
-source "drivers/serial/Kconfig"
+source "drivers/tty/serial/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
-- 
1.7.7

