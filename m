From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 08/14] tty: Convert tty_struct bitfield to ints
Date: Wed, 10 Sep 2014 15:06:30 -0400
Message-ID: <1410375996-4693-9-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
 <1410375996-4693-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410375996-4693-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The stopped, hw_stopped, flow_stopped and packet bits are smp-unsafe
and interrupt-unsafe. For example,

CPU 0                         | CPU 1
                              |
tty->flow_stopped = 1         | tty->hw_stopped = 0

One of these updates will be corrupted, as the bitwise operation
on the bitfield is non-atomic.

Ensure each flag has a separate memory location, so concurrent
updates do not corrupt orthogonal states. Because DEC Alpha EV4 and EV5
cpus (from 1995) perform RMW on smaller-than-machine-word storage,
"separate memory location" must be int instead of byte.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/tty.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1c3316a..a707196 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -261,7 +261,10 @@ struct tty_struct {
 	unsigned long flags;
 	int count;
 	struct winsize winsize;		/* winsize_mutex */
-	unsigned char stopped:1, hw_stopped:1, flow_stopped:1, packet:1;
+	int stopped;
+	int flow_stopped;
+	int hw_stopped;
+	int packet;
 	unsigned char ctrl_status;	/* ctrl_lock */
 	unsigned int receive_room;	/* Bytes free for queue */
 	int flow_change;
-- 
2.1.0
