From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 9/9] tty: drop unused alt_speed from tty_struct
Date: Tue,  6 Jun 2017 12:54:41 +0200
Message-ID: <20170606105441.689-10-johan@kernel.org>
References: <20170606105441.689-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606105441.689-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Drop the now unused alt_speed field from struct tty_struct.

Setting an alt_speed using the ASYNC_SPD flags has been deprecated since
v2.1.69, and has been broken for all tty drivers but serial-core since
v3.10 and commit 6865ff222cca ("TTY: do not warn about setting speed via
SPD_*") without anyone noticing.

Note that serial-core still supports changing speed using TIOCSSERIAL
and SPD flags (including "alt-speeds"), but also warns about it being
deprecated since pre-git.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/tty.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index eccb4ec30a8a..585cf2b5ca94 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -316,7 +316,6 @@ struct tty_struct {
 
 	struct tty_struct *link;
 	struct fasync_struct *fasync;
-	int alt_speed;		/* For magic substitution of 38400 bps */
 	wait_queue_head_t write_wait;
 	wait_queue_head_t read_wait;
 	struct work_struct hangup_work;
-- 
2.13.0
