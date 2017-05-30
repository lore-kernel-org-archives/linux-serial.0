From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [RFC, PATCH] imx: serial: Take tty->files_lock opportunistically
Date: Tue, 30 May 2017 05:37:26 -0700
Message-ID: <20170530123726.18598-1-andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, cphealy@gmail.com, Peter Senna Tschudin <peter.senna@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Trying to load a serdev driver agains a tty port on i.MX6Q results in
the following lockdep warning:

kworker/u8:1/100 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
 (&(&tty->files_lock)->rlock){+.+...}, at: [<c04d3d4c>] imx_startup+0x2c0/0x50c

and this task is already holding:
 (&port_lock_key){-.....}, at: [<c04d3b98>] imx_startup+0x10c/0x50c
which would create a new lock dependency:
 (&port_lock_key){-.....} -> (&(&tty->files_lock)->rlock){+.+...}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&port_lock_key){-.....}

... which became HARDIRQ-irq-safe at:
  lock_acquire+0x74/0x94
  _raw_spin_lock_irqsave+0x40/0x54
  imx_txint+0x18/0x1d8
  imx_int+0xc0/0x21c
  __handle_irq_event_percpu+0x8c/0x124
  handle_irq_event_percpu+0x24/0x60
  handle_irq_event+0x40/0x64
  handle_fasteoi_irq+0xd4/0x1ac
  generic_handle_irq+0x28/0x3c
  __handle_domain_irq+0x6c/0xe8
  gic_handle_irq+0x58/0xb8
  __irq_svc+0x70/0x98
  cpuidle_enter_state+0x18c/0x2b8
  cpuidle_enter+0x1c/0x20
  call_cpuidle+0x28/0x44
  do_idle+0x1b0/0x224
  cpu_startup_entry+0x20/0x24
  rest_init+0x128/0x168
  start_kernel+0x328/0x39c
  0x1000807c

to a HARDIRQ-irq-unsafe lock:
 (&(&tty->files_lock)->rlock){+.+...}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire+0x74/0x94
  _raw_spin_lock+0x30/0x40
  tty_add_file+0x28/0x50
  tty_open+0x9c/0x490
  chrdev_open+0xa4/0x180
  do_dentry_open+0x1f0/0x318
  vfs_open+0x54/0x84
  path_openat+0x32c/0xfbc
  do_filp_open+0x68/0xcc
  do_sys_open+0x108/0x1d0
  SyS_open+0x20/0x24
  kernel_init_freeable+0x15c/0x200
  kernel_init+0x10/0x11c
  ret_from_fork+0x14/0x24

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&tty->files_lock)->rlock);
                               local_irq_disable();
                               lock(&port_lock_key);
                               lock(&(&tty->files_lock)->rlock);
  <Interrupt>
    lock(&port_lock_key);

 *** DEADLOCK ***

In order to avoid this problem, change the code to opportunisticaly
take 'tty->files_lock' by using spin_trylock() in the offending
codepath instead.

Fixes: 18a4208826dd0a13eb06de724c86bba2c225f943 ("imx-serial: Reduce
RX DMA startup latency when opening for reading")

Cc: cphealy@gmail.com
Cc: Peter Senna Tschudin <peter.senna@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Not sure if this is the best way to solve the problem (hence the RFC
tag). If anyone has a better idea, or if there's a better fix for this
already, please let me know.

Thanks,
Andrey Smirnov

 drivers/tty/serial/imx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 33509b4..24fe7fc 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1350,14 +1350,14 @@ static int imx_startup(struct uart_port *port)
 		struct tty_file_private *file_priv;
 		int readcnt = 0;
 
-		spin_lock(&tty->files_lock);
+		if (spin_trylock(&tty->files_lock)) {
+			if (!list_empty(&tty->tty_files))
+				list_for_each_entry(file_priv, &tty->tty_files, list)
+					if (!(file_priv->file->f_flags & O_WRONLY))
+						readcnt++;
 
-		if (!list_empty(&tty->tty_files))
-			list_for_each_entry(file_priv, &tty->tty_files, list)
-				if (!(file_priv->file->f_flags & O_WRONLY))
-					readcnt++;
-
-		spin_unlock(&tty->files_lock);
+			spin_unlock(&tty->files_lock);
+		}
 
 		if (readcnt > 0) {
 			imx_disable_rx_int(sport);
-- 
2.9.4
