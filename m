From: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] serial: flush ldisc after hangup
Date: Tue, 1 Mar 2016 13:02:55 -0500
Message-ID: <1456855375-17175-1-git-send-email-jbacik@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter@hurleysoftware.com
List-Id: linux-serial@vger.kernel.org

We hit a panic pretty consistently in production that looked like this

PID: 461061  TASK: ffff880203f8bc00  CPU: 2   COMMAND: "kworker/u8:2"
 #0 [ffff88015834b940] machine_kexec at ffffffff8103c1c5
 #1 [ffff88015834b990] crash_kexec at ffffffff810cd448
 #2 [ffff88015834ba60] oops_end at ffffffff81006478
 #3 [ffff88015834ba90] no_context at ffffffff818c5262
 #4 [ffff88015834baf0] __bad_area_nosemaphore at ffffffff818c545a
 #5 [ffff88015834bb40] bad_area_nosemaphore at ffffffff818c548c
 #6 [ffff88015834bb50] __do_page_fault at ffffffff81045ad5
 #7 [ffff88015834bbc0] do_page_fault at ffffffff81045efc
 #8 [ffff88015834bbd0] page_fault at ffffffff818d6b82
    [exception RIP: __uart_start+0x1a]
    RIP: ffffffff8152f30a  RSP: ffff88015834bc80  RFLAGS: 00010046
    RAX: 0000000000000000  RBX: ffffffff822e9920  RCX: 0000000000000036
    RDX: 0000000000003636  RSI: 00000000000000fe  RDI: ffffffff822e9920
    RBP: ffff88015834bca8   R8: 0000000000000000   R9: 00000000ffffffff
    R10: ffff8802546f0d20  R11: 0000000000000000  R12: ffff880254712400
    R13: 0000000000000286  R14: 00000000000000fe  R15: ffff880254712400
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #9 [ffff88015834bc80] uart_start at ffffffff8152fbf2

It was a NULL pointer dereference, the state->port.tty was NULL so when we go to
check tty->stopped in uart_tx_stopped() we panic.  Looking at the other CPU's we
were in the middle of uart_open(), and the core actually had a valid pointer in
state->port.tty, which points to a race between either close or hangup (the only
two places that set state->port.tty to NULL) and open.  Close already flushes
the ldisc but hangup does not, which means we could have some characters in the
receive buffer in between the hangup and the open, and we end up in this
situation.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/tty/serial/serial_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b1f54ab..93b7a53 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1527,6 +1527,7 @@ static void uart_hangup(struct tty_struct *tty)
 		wake_up_interruptible(&port->delta_msr_wait);
 	}
 	mutex_unlock(&port->mutex);
+	tty_ldisc_flush(tty);
 }
 
 static void uart_port_shutdown(struct tty_port *port)
-- 
2.5.0
