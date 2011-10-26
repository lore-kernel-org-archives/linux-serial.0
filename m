From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/79] drivers/tty/synclink: remove double comment
Date: Wed, 26 Oct 2011 14:12:07 +0200
Message-ID: <1319631204-23262-2-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60915 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab1JZMN1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:27 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Edwin van Vliet <edwin@cheatah.nl>, Greg Kroah-Hartman <gregkh@suse.de>

From: Edwin van Vliet <edwin@cheatah.nl>

Redundant comment line was removed

Signed-off-by: Edwin van Vliet <edwin@cheatah.nl>
Reviewed-by: Jesper Juhl <jj@chaosbits.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/synclink.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 272e417..e67fb20 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -2124,7 +2124,6 @@ static int mgsl_write(struct tty_struct * tty,
 	if ( info->params.mode == MGSL_MODE_HDLC ||
 			info->params.mode == MGSL_MODE_RAW ) {
 		/* operating in synchronous (frame oriented) mode */
-		/* operating in synchronous (frame oriented) mode */
 		if (info->tx_active) {
 
 			if ( info->params.mode == MGSL_MODE_HDLC ) {
-- 
1.7.7

