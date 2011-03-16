From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 30/76] tty,vt: fix VT_SETACTIVATE console switch
Date: Wed, 16 Mar 2011 14:12:00 -0700
Message-ID: <1300309966-5745-30-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32781 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829Ab1CPVNw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:52 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Olsa <jolsa@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Olsa <jolsa@redhat.com>

using VT_SETACTIVATE ioctl for console switch did not work,
since it put wrong param to the set_console function.

Also ioctl returned misleading error, because of the missing
break statement. I wonder anyone has ever used this one :).

Signed-off-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/vt/vt_ioctl.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 6bcf05b..9e9a901 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -1010,8 +1010,9 @@ int vt_ioctl(struct tty_struct *tty, struct file * file,
 			if (ret)
 				break;
 			/* Commence switch and lock */
-			set_console(arg);
+			set_console(vsa.console);
 		}
+		break;
 	}
 
 	/*
-- 
1.7.4.1

