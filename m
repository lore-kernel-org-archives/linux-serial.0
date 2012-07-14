From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 01/12] tty: revert incorrectly applied lock patch
Date: Sat, 14 Jul 2012 15:31:27 +0100
Message-ID: <20120714143112.26945.13874.stgit@localhost.localdomain>
References: <20120714142740.26945.98609.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34128 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab2GNOOe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2012 10:14:34 -0400
In-Reply-To: <20120714142740.26945.98609.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

I sent GregKH this after the pre-requisites. He dropped the pre-requesites
for good reason and unfortunately then applied this patch. Without this
reverted you get random kernel memory corruption which will make bisecting
anything between it and the properly applied patches a complete sod.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/amiserial.c      |   14 ++++----
 drivers/tty/cyclades.c       |    2 +
 drivers/tty/n_r3964.c        |   10 +++---
 drivers/tty/pty.c            |   25 +++++++--------
 drivers/tty/serial/crisv10.c |    8 ++---
 drivers/tty/synclink.c       |    4 +-
 drivers/tty/synclink_gt.c    |    4 +-
 drivers/tty/synclinkmp.c     |    4 +-
 drivers/tty/tty_io.c         |   67 ++++++++++++++++------------------------
 drivers/tty/tty_ldisc.c      |   67 +++++++++++++++++-----------------------
 drivers/tty/tty_mutex.c      |   71 +++++++++---------------------------------
 drivers/tty/tty_port.c       |    6 ++--
 include/linux/tty.h          |   23 +++++---------
 net/bluetooth/rfcomm/tty.c   |    4 +-
 14 files changed, 119 insertions(+), 190 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 35819e3..6cc4358 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1033,7 +1033,7 @@ static int get_serial_info(struct tty_struct *tty, struct serial_state *state,
 	if (!retinfo)
 		return -EFAULT;
 	memset(&tmp, 0, sizeof(tmp));
-	tty_lock(tty);
+	tty_lock();
 	tmp.line = tty->index;
 	tmp.port = state->port;
 	tmp.flags = state->tport.flags;
@@ -1042,7 +1042,7 @@ static int get_serial_info(struct tty_struct *tty, struct serial_state *state,
 	tmp.close_delay = state->tport.close_delay;
 	tmp.closing_wait = state->tport.closing_wait;
 	tmp.custom_divisor = state->custom_divisor;
-	tty_unlock(tty);
+	tty_unlock();
 	if (copy_to_user(retinfo,&tmp,sizeof(*retinfo)))
 		return -EFAULT;
 	return 0;
@@ -1059,12 +1059,12 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
 	if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
 		return -EFAULT;
 
-	tty_lock(tty);
+	tty_lock();
 	change_spd = ((new_serial.flags ^ port->flags) & ASYNC_SPD_MASK) ||
 		new_serial.custom_divisor != state->custom_divisor;
 	if (new_serial.irq || new_serial.port != state->port ||
 			new_serial.xmit_fifo_size != state->xmit_fifo_size) {
-		tty_unlock(tty);
+		tty_unlock();
 		return -EINVAL;
 	}
   
@@ -1074,7 +1074,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
 		    (new_serial.xmit_fifo_size != state->xmit_fifo_size) ||
 		    ((new_serial.flags & ~ASYNC_USR_MASK) !=
 		     (port->flags & ~ASYNC_USR_MASK))) {
-			tty_unlock(tty);
+			tty_unlock();
 			return -EPERM;
 		}
 		port->flags = ((port->flags & ~ASYNC_USR_MASK) |
@@ -1084,7 +1084,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
 	}
 
 	if (new_serial.baud_base < 9600) {
-		tty_unlock(tty);
+		tty_unlock();
 		return -EINVAL;
 	}
 
@@ -1116,7 +1116,7 @@ check_and_exit:
 		}
 	} else
 		retval = startup(tty, state);
-	tty_unlock(tty);
+	tty_unlock();
 	return retval;
 }
 
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index 69e9ca2..cff5468 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -1599,7 +1599,7 @@ static int cy_open(struct tty_struct *tty, struct file *filp)
 	 * If the port is the middle of closing, bail out now
 	 */
 	if (tty_hung_up_p(filp) || (info->port.flags & ASYNC_CLOSING)) {
-		wait_event_interruptible_tty(tty, info->port.close_wait,
+		wait_event_interruptible_tty(info->port.close_wait,
 				!(info->port.flags & ASYNC_CLOSING));
 		return (info->port.flags & ASYNC_HUP_NOTIFY) ? -EAGAIN: -ERESTARTSYS;
 	}
diff --git a/drivers/tty/n_r3964.c b/drivers/tty/n_r3964.c
index 1e64050..5c6c314 100644
--- a/drivers/tty/n_r3964.c
+++ b/drivers/tty/n_r3964.c
@@ -1065,7 +1065,7 @@ static ssize_t r3964_read(struct tty_struct *tty, struct file *file,
 
 	TRACE_L("read()");
 
-	tty_lock(tty);
+	tty_lock();
 
 	pClient = findClient(pInfo, task_pid(current));
 	if (pClient) {
@@ -1077,7 +1077,7 @@ static ssize_t r3964_read(struct tty_struct *tty, struct file *file,
 				goto unlock;
 			}
 			/* block until there is a message: */
-			wait_event_interruptible_tty(tty, pInfo->read_wait,
+			wait_event_interruptible_tty(pInfo->read_wait,
 					(pMsg = remove_msg(pInfo, pClient)));
 		}
 
@@ -1107,7 +1107,7 @@ static ssize_t r3964_read(struct tty_struct *tty, struct file *file,
 	}
 	ret = -EPERM;
 unlock:
-	tty_unlock(tty);
+	tty_unlock();
 	return ret;
 }
 
@@ -1156,7 +1156,7 @@ static ssize_t r3964_write(struct tty_struct *tty, struct file *file,
 	pHeader->locks = 0;
 	pHeader->owner = NULL;
 
-	tty_lock(tty);
+	tty_lock();
 
 	pClient = findClient(pInfo, task_pid(current));
 	if (pClient) {
@@ -1175,7 +1175,7 @@ static ssize_t r3964_write(struct tty_struct *tty, struct file *file,
 	add_tx_queue(pInfo, pHeader);
 	trigger_transmit(pInfo);
 
-	tty_unlock(tty);
+	tty_unlock();
 
 	return 0;
 }
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index d855883..b50fc1c 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -47,7 +47,6 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 	wake_up_interruptible(&tty->read_wait);
 	wake_up_interruptible(&tty->write_wait);
 	tty->packet = 0;
-	/* Review - krefs on tty_link ?? */
 	if (!tty->link)
 		return;
 	tty->link->packet = 0;
@@ -63,9 +62,9 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 		        mutex_unlock(&devpts_mutex);
 		}
 #endif
-		tty_unlock(tty);
+		tty_unlock();
 		tty_vhangup(tty->link);
-		tty_lock(tty);
+		tty_lock();
 	}
 }
 
@@ -616,27 +615,26 @@ static int ptmx_open(struct inode *inode, struct file *filp)
 		return retval;
 
 	/* find a device that is not in use. */
-	mutex_lock(&devpts_mutex);
+	tty_lock();
 	index = devpts_new_index(inode);
+	tty_unlock();
 	if (index < 0) {
 		retval = index;
 		goto err_file;
 	}
 
-	mutex_unlock(&devpts_mutex);
-
 	mutex_lock(&tty_mutex);
+	mutex_lock(&devpts_mutex);
 	tty = tty_init_dev(ptm_driver, index);
+	mutex_unlock(&devpts_mutex);
+	tty_lock();
+	mutex_unlock(&tty_mutex);
 
 	if (IS_ERR(tty)) {
 		retval = PTR_ERR(tty);
 		goto out;
 	}
 
-	/* The tty returned here is locked so we can safely
-	   drop the mutex */
-	mutex_unlock(&tty_mutex);
-
 	set_bit(TTY_PTY_LOCK, &tty->flags); /* LOCK THE SLAVE */
 
 	tty_add_file(tty, filp);
@@ -649,17 +647,16 @@ static int ptmx_open(struct inode *inode, struct file *filp)
 	if (retval)
 		goto err_release;
 
-	tty_unlock(tty);
+	tty_unlock();
 	return 0;
 err_release:
-	tty_unlock(tty);
+	tty_unlock();
 	tty_release(inode, filp);
 	return retval;
 out:
-	mutex_unlock(&tty_mutex);
 	devpts_kill_index(inode, index);
+	tty_unlock();
 err_file:
-        mutex_unlock(&devpts_mutex);
 	tty_free_file(filp);
 	return retval;
 }
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 7264d4d..80b6b1b 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -3976,7 +3976,7 @@ block_til_ready(struct tty_struct *tty, struct file * filp,
 	 */
 	if (tty_hung_up_p(filp) ||
 	    (info->flags & ASYNC_CLOSING)) {
-		wait_event_interruptible_tty(tty, info->close_wait,
+		wait_event_interruptible_tty(info->close_wait,
 			!(info->flags & ASYNC_CLOSING));
 #ifdef SERIAL_DO_RESTART
 		if (info->flags & ASYNC_HUP_NOTIFY)
@@ -4052,9 +4052,9 @@ block_til_ready(struct tty_struct *tty, struct file * filp,
 		printk("block_til_ready blocking: ttyS%d, count = %d\n",
 		       info->line, info->count);
 #endif
-		tty_unlock(tty);
+		tty_unlock();
 		schedule();
-		tty_lock(tty);
+		tty_lock();
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
@@ -4115,7 +4115,7 @@ rs_open(struct tty_struct *tty, struct file * filp)
 	 */
 	if (tty_hung_up_p(filp) ||
 	    (info->flags & ASYNC_CLOSING)) {
-		wait_event_interruptible_tty(tty, info->close_wait,
+		wait_event_interruptible_tty(info->close_wait,
 			!(info->flags & ASYNC_CLOSING));
 #ifdef SERIAL_DO_RESTART
 		return ((info->flags & ASYNC_HUP_NOTIFY) ?
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 5ed0daa..593d40a 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -3338,9 +3338,9 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 			printk("%s(%d):block_til_ready blocking on %s count=%d\n",
 				 __FILE__,__LINE__, tty->driver->name, port->count );
 				 
-		tty_unlock(tty);
+		tty_unlock();
 		schedule();
-		tty_lock(tty);
+		tty_lock();
 	}
 	
 	set_current_state(TASK_RUNNING);
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 45b43f1..aa1debf 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -3336,9 +3336,9 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		}
 
 		DBGINFO(("%s block_til_ready wait\n", tty->driver->name));
-		tty_unlock(tty);
+		tty_unlock();
 		schedule();
-		tty_lock(tty);
+		tty_lock();
 	}
 
 	set_current_state(TASK_RUNNING);
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 4a1e4f0..a3dddc1 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -3357,9 +3357,9 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 			printk("%s(%d):%s block_til_ready() count=%d\n",
 				 __FILE__,__LINE__, tty->driver->name, port->count );
 
-		tty_unlock(tty);
+		tty_unlock();
 		schedule();
-		tty_lock(tty);
+		tty_lock();
 	}
 
 	set_current_state(TASK_RUNNING);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ca7c25d..ac96f74 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -185,7 +185,6 @@ void free_tty_struct(struct tty_struct *tty)
 		put_device(tty->dev);
 	kfree(tty->write_buf);
 	tty_buffer_free_all(tty);
-	tty->magic = 0xDEADDEAD;
 	kfree(tty);
 }
 
@@ -574,7 +573,7 @@ void __tty_hangup(struct tty_struct *tty)
 	}
 	spin_unlock(&redirect_lock);
 
-	tty_lock(tty);
+	tty_lock();
 
 	/* some functions below drop BTM, so we need this bit */
 	set_bit(TTY_HUPPING, &tty->flags);
@@ -667,7 +666,7 @@ void __tty_hangup(struct tty_struct *tty)
 	clear_bit(TTY_HUPPING, &tty->flags);
 	tty_ldisc_enable(tty);
 
-	tty_unlock(tty);
+	tty_unlock();
 
 	if (f)
 		fput(f);
@@ -1104,12 +1103,12 @@ void tty_write_message(struct tty_struct *tty, char *msg)
 {
 	if (tty) {
 		mutex_lock(&tty->atomic_write_lock);
-		tty_lock(tty);
+		tty_lock();
 		if (tty->ops->write && !test_bit(TTY_CLOSING, &tty->flags)) {
-			tty_unlock(tty);
+			tty_unlock();
 			tty->ops->write(tty, msg, strlen(msg));
 		} else
-			tty_unlock(tty);
+			tty_unlock();
 		tty_write_unlock(tty);
 	}
 	return;
@@ -1404,7 +1403,6 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 	}
 	initialize_tty_struct(tty, driver, idx);
 
-	tty_lock(tty);
 	retval = tty_driver_install_tty(driver, tty);
 	if (retval < 0)
 		goto err_deinit_tty;
@@ -1420,11 +1418,9 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 	retval = tty_ldisc_setup(tty, tty->link);
 	if (retval)
 		goto err_release_tty;
-	/* Return the tty locked so that it cannot vanish under the caller */
 	return tty;
 
 err_deinit_tty:
-	tty_unlock(tty);
 	deinitialize_tty_struct(tty);
 	free_tty_struct(tty);
 err_module_put:
@@ -1433,7 +1429,6 @@ err_module_put:
 
 	/* call the tty release_tty routine to clean out this slot */
 err_release_tty:
-	tty_unlock(tty);
 	printk_ratelimited(KERN_INFO "tty_init_dev: ldisc open failed, "
 				 "clearing slot %d\n", idx);
 	release_tty(tty, idx);
@@ -1636,7 +1631,7 @@ int tty_release(struct inode *inode, struct file *filp)
 	if (tty_paranoia_check(tty, inode, __func__))
 		return 0;
 
-	tty_lock(tty);
+	tty_lock();
 	check_tty_count(tty, __func__);
 
 	__tty_fasync(-1, filp, 0);
@@ -1645,11 +1640,10 @@ int tty_release(struct inode *inode, struct file *filp)
 	pty_master = (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 		      tty->driver->subtype == PTY_TYPE_MASTER);
 	devpts = (tty->driver->flags & TTY_DRIVER_DEVPTS_MEM) != 0;
-	/* Review: parallel close */
 	o_tty = tty->link;
 
 	if (tty_release_checks(tty, o_tty, idx)) {
-		tty_unlock(tty);
+		tty_unlock();
 		return 0;
 	}
 
@@ -1661,7 +1655,7 @@ int tty_release(struct inode *inode, struct file *filp)
 	if (tty->ops->close)
 		tty->ops->close(tty, filp);
 
-	tty_unlock(tty);
+	tty_unlock();
 	/*
 	 * Sanity check: if tty->count is going to zero, there shouldn't be
 	 * any waiters on tty->read_wait or tty->write_wait.  We test the
@@ -1684,7 +1678,7 @@ int tty_release(struct inode *inode, struct file *filp)
 		   opens on /dev/tty */
 
 		mutex_lock(&tty_mutex);
-		tty_lock_pair(tty, o_tty);
+		tty_lock();
 		tty_closing = tty->count <= 1;
 		o_tty_closing = o_tty &&
 			(o_tty->count <= (pty_master ? 1 : 0));
@@ -1715,7 +1709,7 @@ int tty_release(struct inode *inode, struct file *filp)
 
 		printk(KERN_WARNING "%s: %s: read/write wait queue active!\n",
 				__func__, tty_name(tty, buf));
-		tty_unlock_pair(tty, o_tty);
+		tty_unlock();
 		mutex_unlock(&tty_mutex);
 		schedule();
 	}
@@ -1778,7 +1772,7 @@ int tty_release(struct inode *inode, struct file *filp)
 
 	/* check whether both sides are closing ... */
 	if (!tty_closing || (o_tty && !o_tty_closing)) {
-		tty_unlock_pair(tty, o_tty);
+		tty_unlock();
 		return 0;
 	}
 
@@ -1791,16 +1785,14 @@ int tty_release(struct inode *inode, struct file *filp)
 	tty_ldisc_release(tty, o_tty);
 	/*
 	 * The release_tty function takes care of the details of clearing
-	 * the slots and preserving the termios structure. The tty_unlock_pair
-	 * should be safe as we keep a kref while the tty is locked (so the
-	 * unlock never unlocks a freed tty).
+	 * the slots and preserving the termios structure.
 	 */
 	release_tty(tty, idx);
-	tty_unlock_pair(tty, o_tty);
 
 	/* Make this pty number available for reallocation */
 	if (devpts)
 		devpts_kill_index(inode, idx);
+	tty_unlock();
 	return 0;
 }
 
@@ -1904,9 +1896,6 @@ static struct tty_driver *tty_lookup_driver(dev_t device, struct file *filp,
  *	Locking: tty_mutex protects tty, tty_lookup_driver and tty_init_dev.
  *		 tty->count should protect the rest.
  *		 ->siglock protects ->signal/->sighand
- *
- *	Note: the tty_unlock/lock cases without a ref are only safe due to
- *	tty_mutex
  */
 
 static int tty_open(struct inode *inode, struct file *filp)
@@ -1930,7 +1919,8 @@ retry_open:
 	retval = 0;
 
 	mutex_lock(&tty_mutex);
-	/* This is protected by the tty_mutex */
+	tty_lock();
+
 	tty = tty_open_current_tty(device, filp);
 	if (IS_ERR(tty)) {
 		retval = PTR_ERR(tty);
@@ -1951,19 +1941,17 @@ retry_open:
 	}
 
 	if (tty) {
-		tty_lock(tty);
 		retval = tty_reopen(tty);
-		if (retval < 0) {
-			tty_unlock(tty);
+		if (retval)
 			tty = ERR_PTR(retval);
-		}
-	} else	/* Returns with the tty_lock held for now */
+	} else
 		tty = tty_init_dev(driver, index);
 
 	mutex_unlock(&tty_mutex);
 	if (driver)
 		tty_driver_kref_put(driver);
 	if (IS_ERR(tty)) {
+		tty_unlock();
 		retval = PTR_ERR(tty);
 		goto err_file;
 	}
@@ -1992,7 +1980,7 @@ retry_open:
 		printk(KERN_DEBUG "%s: error %d in opening %s...\n", __func__,
 				retval, tty->name);
 #endif
-		tty_unlock(tty); /* need to call tty_release without BTM */
+		tty_unlock(); /* need to call tty_release without BTM */
 		tty_release(inode, filp);
 		if (retval != -ERESTARTSYS)
 			return retval;
@@ -2004,15 +1992,17 @@ retry_open:
 		/*
 		 * Need to reset f_op in case a hangup happened.
 		 */
+		tty_lock();
 		if (filp->f_op == &hung_up_tty_fops)
 			filp->f_op = &tty_fops;
+		tty_unlock();
 		goto retry_open;
 	}
-	tty_unlock(tty);
+	tty_unlock();
 
 
 	mutex_lock(&tty_mutex);
-	tty_lock(tty);
+	tty_lock();
 	spin_lock_irq(&current->sighand->siglock);
 	if (!noctty &&
 	    current->signal->leader &&
@@ -2020,10 +2010,11 @@ retry_open:
 	    tty->session == NULL)
 		__proc_set_tty(current, tty);
 	spin_unlock_irq(&current->sighand->siglock);
-	tty_unlock(tty);
+	tty_unlock();
 	mutex_unlock(&tty_mutex);
 	return 0;
 err_unlock:
+	tty_unlock();
 	mutex_unlock(&tty_mutex);
 	/* after locks to avoid deadlock */
 	if (!IS_ERR_OR_NULL(driver))
@@ -2106,13 +2097,10 @@ out:
 
 static int tty_fasync(int fd, struct file *filp, int on)
 {
-	struct tty_struct *tty = file_tty(filp);
 	int retval;
-
-	tty_lock(tty);
+	tty_lock();
 	retval = __tty_fasync(fd, filp, on);
-	tty_unlock(tty);
-
+	tty_unlock();
 	return retval;
 }
 
@@ -2949,7 +2937,6 @@ void initialize_tty_struct(struct tty_struct *tty,
 	tty->pgrp = NULL;
 	tty->overrun_time = jiffies;
 	tty_buffer_init(tty);
-	mutex_init(&tty->legacy_mutex);
 	mutex_init(&tty->termios_mutex);
 	mutex_init(&tty->ldisc_mutex);
 	init_waitqueue_head(&tty->write_wait);
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index ba8be39..9911eb6 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -568,7 +568,7 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 	if (IS_ERR(new_ldisc))
 		return PTR_ERR(new_ldisc);
 
-	tty_lock(tty);
+	tty_lock();
 	/*
 	 *	We need to look at the tty locking here for pty/tty pairs
 	 *	when both sides try to change in parallel.
@@ -582,12 +582,12 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 	 */
 
 	if (tty->ldisc->ops->num == ldisc) {
-		tty_unlock(tty);
+		tty_unlock();
 		tty_ldisc_put(new_ldisc);
 		return 0;
 	}
 
-	tty_unlock(tty);
+	tty_unlock();
 	/*
 	 *	Problem: What do we do if this blocks ?
 	 *	We could deadlock here
@@ -595,7 +595,7 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 
 	tty_wait_until_sent(tty, 0);
 
-	tty_lock(tty);
+	tty_lock();
 	mutex_lock(&tty->ldisc_mutex);
 
 	/*
@@ -605,10 +605,10 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 
 	while (test_bit(TTY_LDISC_CHANGING, &tty->flags)) {
 		mutex_unlock(&tty->ldisc_mutex);
-		tty_unlock(tty);
+		tty_unlock();
 		wait_event(tty_ldisc_wait,
 			test_bit(TTY_LDISC_CHANGING, &tty->flags) == 0);
-		tty_lock(tty);
+		tty_lock();
 		mutex_lock(&tty->ldisc_mutex);
 	}
 
@@ -623,7 +623,7 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 
 	o_ldisc = tty->ldisc;
 
-	tty_unlock(tty);
+	tty_unlock();
 	/*
 	 *	Make sure we don't change while someone holds a
 	 *	reference to the line discipline. The TTY_LDISC bit
@@ -650,7 +650,7 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 
 	retval = tty_ldisc_wait_idle(tty, 5 * HZ);
 
-	tty_lock(tty);
+	tty_lock();
 	mutex_lock(&tty->ldisc_mutex);
 
 	/* handle wait idle failure locked */
@@ -665,7 +665,7 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 		clear_bit(TTY_LDISC_CHANGING, &tty->flags);
 		mutex_unlock(&tty->ldisc_mutex);
 		tty_ldisc_put(new_ldisc);
-		tty_unlock(tty);
+		tty_unlock();
 		return -EIO;
 	}
 
@@ -708,7 +708,7 @@ enable:
 	if (o_work)
 		schedule_work(&o_tty->buf.work);
 	mutex_unlock(&tty->ldisc_mutex);
-	tty_unlock(tty);
+	tty_unlock();
 	return retval;
 }
 
@@ -816,11 +816,11 @@ void tty_ldisc_hangup(struct tty_struct *tty)
 	 * need to wait for another function taking the BTM
 	 */
 	clear_bit(TTY_LDISC, &tty->flags);
-	tty_unlock(tty);
+	tty_unlock();
 	cancel_work_sync(&tty->buf.work);
 	mutex_unlock(&tty->ldisc_mutex);
 retry:
-	tty_lock(tty);
+	tty_lock();
 	mutex_lock(&tty->ldisc_mutex);
 
 	/* At this point we have a closed ldisc and we want to
@@ -831,7 +831,7 @@ retry:
 		if (atomic_read(&tty->ldisc->users) != 1) {
 			char cur_n[TASK_COMM_LEN], tty_n[64];
 			long timeout = 3 * HZ;
-			tty_unlock(tty);
+			tty_unlock();
 
 			while (tty_ldisc_wait_idle(tty, timeout) == -EBUSY) {
 				timeout = MAX_SCHEDULE_TIMEOUT;
@@ -894,23 +894,6 @@ int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty)
 	tty_ldisc_enable(tty);
 	return 0;
 }
-
-static void tty_ldisc_kill(struct tty_struct *tty)
-{
-	mutex_lock(&tty->ldisc_mutex);
-	/*
-	 * Now kill off the ldisc
-	 */
-	tty_ldisc_close(tty, tty->ldisc);
-	tty_ldisc_put(tty->ldisc);
-	/* Force an oops if we mess this up */
-	tty->ldisc = NULL;
-
-	/* Ensure the next open requests the N_TTY ldisc */
-	tty_set_termios_ldisc(tty, N_TTY);
-	mutex_unlock(&tty->ldisc_mutex);
-}
-
 /**
  *	tty_ldisc_release		-	release line discipline
  *	@tty: tty being shut down
@@ -929,19 +912,27 @@ void tty_ldisc_release(struct tty_struct *tty, struct tty_struct *o_tty)
 	 * race with the set_ldisc code path.
 	 */
 
-	tty_unlock_pair(tty, o_tty);
+	tty_unlock();
 	tty_ldisc_halt(tty);
 	tty_ldisc_flush_works(tty);
-	if (o_tty) {
-		tty_ldisc_halt(o_tty);
-		tty_ldisc_flush_works(o_tty);
-	}
-	tty_lock_pair(tty, o_tty);
+	tty_lock();
 
+	mutex_lock(&tty->ldisc_mutex);
+	/*
+	 * Now kill off the ldisc
+	 */
+	tty_ldisc_close(tty, tty->ldisc);
+	tty_ldisc_put(tty->ldisc);
+	/* Force an oops if we mess this up */
+	tty->ldisc = NULL;
+
+	/* Ensure the next open requests the N_TTY ldisc */
+	tty_set_termios_ldisc(tty, N_TTY);
+	mutex_unlock(&tty->ldisc_mutex);
 
-	tty_ldisc_kill(tty);
+	/* This will need doing differently if we need to lock */
 	if (o_tty)
-		tty_ldisc_kill(o_tty);
+		tty_ldisc_release(o_tty, NULL);
 
 	/* And the memory resources remaining (buffers, termios) will be
 	   disposed of when the kref hits zero */
diff --git a/drivers/tty/tty_mutex.c b/drivers/tty/tty_mutex.c
index 67feac9..9ff986c 100644
--- a/drivers/tty/tty_mutex.c
+++ b/drivers/tty/tty_mutex.c
@@ -4,70 +4,29 @@
 #include <linux/semaphore.h>
 #include <linux/sched.h>
 
-/* Legacy tty mutex glue */
-
-enum {
-	TTY_MUTEX_NORMAL,
-	TTY_MUTEX_NESTED,
-};
+/*
+ * The 'big tty mutex'
+ *
+ * This mutex is taken and released by tty_lock() and tty_unlock(),
+ * replacing the older big kernel lock.
+ * It can no longer be taken recursively, and does not get
+ * released implicitly while sleeping.
+ *
+ * Don't use in new code.
+ */
+static DEFINE_MUTEX(big_tty_mutex);
 
 /*
  * Getting the big tty mutex.
  */
-
-static void __lockfunc tty_lock_nested(struct tty_struct *tty,
-				       unsigned int subclass)
+void __lockfunc tty_lock(void)
 {
-	if (tty->magic != TTY_MAGIC) {
-		printk(KERN_ERR "L Bad %p\n", tty);
-		WARN_ON(1);
-		return;
-	}
-	tty_kref_get(tty);
-	mutex_lock_nested(&tty->legacy_mutex, subclass);
-}
-
-void __lockfunc tty_lock(struct tty_struct *tty)
-{
-	return tty_lock_nested(tty, TTY_MUTEX_NORMAL);
+	mutex_lock(&big_tty_mutex);
 }
 EXPORT_SYMBOL(tty_lock);
 
-void __lockfunc tty_unlock(struct tty_struct *tty)
+void __lockfunc tty_unlock(void)
 {
-	if (tty->magic != TTY_MAGIC) {
-		printk(KERN_ERR "U Bad %p\n", tty);
-		WARN_ON(1);
-		return;
-	}
-	mutex_unlock(&tty->legacy_mutex);
-	tty_kref_put(tty);
+	mutex_unlock(&big_tty_mutex);
 }
 EXPORT_SYMBOL(tty_unlock);
-
-/*
- * Getting the big tty mutex for a pair of ttys with lock ordering
- * On a non pty/tty pair tty2 can be NULL which is just fine.
- */
-void __lockfunc tty_lock_pair(struct tty_struct *tty,
-					struct tty_struct *tty2)
-{
-	if (tty < tty2) {
-		tty_lock(tty);
-		tty_lock_nested(tty2, TTY_MUTEX_NESTED);
-	} else {
-		if (tty2 && tty2 != tty)
-			tty_lock(tty2);
-		tty_lock_nested(tty, TTY_MUTEX_NESTED);
-	}
-}
-EXPORT_SYMBOL(tty_lock_pair);
-
-void __lockfunc tty_unlock_pair(struct tty_struct *tty,
-						struct tty_struct *tty2)
-{
-	tty_unlock(tty);
-	if (tty2 && tty2 != tty)
-		tty_unlock(tty2);
-}
-EXPORT_SYMBOL(tty_unlock_pair);
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index a3ba776..4e9d2b2 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -239,7 +239,7 @@ int tty_port_block_til_ready(struct tty_port *port,
 
 	/* block if port is in the process of being closed */
 	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
-		wait_event_interruptible_tty(tty, port->close_wait,
+		wait_event_interruptible_tty(port->close_wait,
 				!(port->flags & ASYNC_CLOSING));
 		if (port->flags & ASYNC_HUP_NOTIFY)
 			return -EAGAIN;
@@ -305,9 +305,9 @@ int tty_port_block_til_ready(struct tty_port *port,
 			retval = -ERESTARTSYS;
 			break;
 		}
-		tty_unlock(tty);
+		tty_unlock();
 		schedule();
-		tty_lock(tty);
+		tty_lock();
 	}
 	finish_wait(&port->open_wait, &wait);
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 7f9d7df..40b18d7 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -268,7 +268,6 @@ struct tty_struct {
 	struct mutex ldisc_mutex;
 	struct tty_ldisc *ldisc;
 
-	struct mutex legacy_mutex;
 	struct mutex termios_mutex;
 	spinlock_t ctrl_lock;
 	/* Termios values are protected by the termios mutex */
@@ -611,12 +610,8 @@ extern long vt_compat_ioctl(struct tty_struct *tty,
 
 /* tty_mutex.c */
 /* functions for preparation of BKL removal */
-extern void __lockfunc tty_lock(struct tty_struct *tty);
-extern void __lockfunc tty_unlock(struct tty_struct *tty);
-extern void __lockfunc tty_lock_pair(struct tty_struct *tty,
-				struct tty_struct *tty2);
-extern void __lockfunc tty_unlock_pair(struct tty_struct *tty,
-				struct tty_struct *tty2);
+extern void __lockfunc tty_lock(void) __acquires(tty_lock);
+extern void __lockfunc tty_unlock(void) __releases(tty_lock);
 
 /*
  * this shall be called only from where BTM is held (like close)
@@ -631,9 +626,9 @@ extern void __lockfunc tty_unlock_pair(struct tty_struct *tty,
 static inline void tty_wait_until_sent_from_close(struct tty_struct *tty,
 		long timeout)
 {
-	tty_unlock(tty); /* tty->ops->close holds the BTM, drop it while waiting */
+	tty_unlock(); /* tty->ops->close holds the BTM, drop it while waiting */
 	tty_wait_until_sent(tty, timeout);
-	tty_lock(tty);
+	tty_lock();
 }
 
 /*
@@ -648,16 +643,16 @@ static inline void tty_wait_until_sent_from_close(struct tty_struct *tty,
  *
  * Do not use in new code.
  */
-#define wait_event_interruptible_tty(tty, wq, condition)		\
+#define wait_event_interruptible_tty(wq, condition)			\
 ({									\
 	int __ret = 0;							\
 	if (!(condition)) {						\
-		__wait_event_interruptible_tty(tty, wq, condition, __ret);	\
+		__wait_event_interruptible_tty(wq, condition, __ret);	\
 	}								\
 	__ret;								\
 })
 
-#define __wait_event_interruptible_tty(tty, wq, condition, ret)		\
+#define __wait_event_interruptible_tty(wq, condition, ret)		\
 do {									\
 	DEFINE_WAIT(__wait);						\
 									\
@@ -666,9 +661,9 @@ do {									\
 		if (condition)						\
 			break;						\
 		if (!signal_pending(current)) {				\
-			tty_unlock(tty);					\
+			tty_unlock();					\
 			schedule();					\
-			tty_lock(tty);					\
+			tty_lock();					\
 			continue;					\
 		}							\
 		ret = -ERESTARTSYS;					\
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 580d100..cb96077 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -705,9 +705,9 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 			break;
 		}
 
-		tty_unlock(tty);
+		tty_unlock();
 		schedule();
-		tty_lock(tty);
+		tty_lock();
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&dev->wait, &wait);

