From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 16/16] tty: vt, remove unused vc_deccolm
Date: Thu, 23 Jun 2016 13:34:37 +0200
Message-ID: <20160623113437.28416-16-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

vc_deccolm is only set and never read, remove the member from vc_data.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c            | 1 -
 include/linux/console_struct.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 26de5c0fc056..213ce24060b5 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1482,7 +1482,6 @@ static void set_mode(struct vc_data *vc, int on_off)
 					clr_kbd(vc, decckm);
 				break;
 			case 3:	/* 80/132 mode switch unimplemented */
-				vc->vc_deccolm = on_off;
 #if 0
 				vc_resize(deccolm ? 132 : 80, vc->vc_rows);
 				/* this alone does not suffice; some user mode
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index a12d3f2899a8..6fd3c908a340 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -106,7 +106,6 @@ struct vc_data {
 	unsigned int	vc_decawm	: 1;	/* Autowrap Mode */
 	unsigned int	vc_deccm	: 1;	/* Cursor Visible */
 	unsigned int	vc_decim	: 1;	/* Insert Mode */
-	unsigned int	vc_deccolm	: 1;	/* 80/132 Column Mode */
 	/* attribute flags */
 	unsigned int	vc_intensity	: 2;	/* 0=half-bright, 1=normal, 2=bold */
 	unsigned int    vc_italic:1;
-- 
2.9.0
