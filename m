From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: 4.3 serial driver crashes with console shortly after boot
Date: Tue, 10 Nov 2015 18:15:56 -0500
Message-ID: <56427AAC.3000409@hurleysoftware.com>
References: <20151110002939.GG3533@two.firstfloor.org>
 <56414DE9.20707@hurleysoftware.com>
 <20151110223957.GI3533@two.firstfloor.org>
 <20151110224340.GA30452@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151110224340.GA30452@two.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/10/2015 05:43 PM, Andi Kleen wrote:
> On Tue, Nov 10, 2015 at 11:39:57PM +0100, Andi Kleen wrote:
>>> I've just tried to reproduce this without success on my current
>>> tree which has some additional patches I just posted this am. They weren't
>>> intended to fix crashes but they directly impact the area of concern. Could
>>> you try these three?
>>>
>>> [PATCH v2 2/4] n_tty: Ignore all read data when closing
>>> [PATCH v2 3/4] tty: Abstract and encapsulate tty->closing behavior
>>> [PATCH v2 4/4] tty: Remove drivers' extra tty_ldisc_flush()
>>>
>> Applying the three patches fixes the crash. 
>> I haven't tried to figure out which one did the trick.
> 
> Actually I was wrong sorry. It still crashes, but now it doesn't
> hang the system anymore.

Argghh.
Can you run the patch below and send me full dmesg (privately if you prefer)?

Regards,
Peter Hurley

--- >% ---
Subject: [DEBUG PATCH] tty: Turn on core debugging

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c       | 2 +-
 drivers/tty/tty_io.c    | 2 +-
 drivers/tty/tty_ioctl.c | 2 +-
 drivers/tty/tty_ldisc.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 8ba5792..21219a3 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -25,7 +25,7 @@
 #include <linux/mutex.h>
 #include <linux/poll.h>
 
-#undef TTY_DEBUG_HANGUP
+#define TTY_DEBUG_HANGUP
 #ifdef TTY_DEBUG_HANGUP
 # define tty_debug_hangup(tty, f, args...)	tty_debug(tty, f, ##args)
 #else
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 2f8c21e..f3bd522 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -105,7 +105,7 @@
 #include <linux/kmod.h>
 #include <linux/nsproxy.h>
 
-#undef TTY_DEBUG_HANGUP
+#define TTY_DEBUG_HANGUP
 #ifdef TTY_DEBUG_HANGUP
 # define tty_debug_hangup(tty, f, args...)	tty_debug(tty, f, ##args)
 #else
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index b8c5c12..7970c94 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -24,7 +24,7 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
-#undef TTY_DEBUG_WAIT_UNTIL_SENT
+#define TTY_DEBUG_WAIT_UNTIL_SENT
 
 #ifdef TTY_DEBUG_WAIT_UNTIL_SENT
 # define tty_debug_wait_until_sent(tty, f, args...)    tty_debug(tty, f, ##args)
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index ab0f559..760373a 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -19,7 +19,7 @@
 #include <linux/uaccess.h>
 #include <linux/ratelimit.h>
 
-#undef LDISC_DEBUG_HANGUP
+#define LDISC_DEBUG_HANGUP
 
 #ifdef LDISC_DEBUG_HANGUP
 #define tty_ldisc_debug(tty, f, args...)	tty_debug(tty, f, ##args)
-- 
2.6.3
