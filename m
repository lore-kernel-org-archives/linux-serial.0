Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE28CC433E2
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB32920707
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgFOHty (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:39988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbgFOHtV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 691C4AFF9;
        Mon, 15 Jun 2020 07:49:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 29/38] vt_ioctl: eliminate ret & breaks in vt_ioctl
Date:   Mon, 15 Jun 2020 09:49:01 +0200
Message-Id: <20200615074910.19267-29-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is still a leftover from BKL, when we locked it around vt_ioctl's
code. We can return instead of breaks in the switch loop. And we can
return in case of errors too. This allows for sifting of the code to the
left in some cases.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt_ioctl.c | 318 ++++++++++++++++----------------------
 1 file changed, 133 insertions(+), 185 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index daf61c28ba76..87fe088c3eb4 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -357,7 +357,7 @@ int vt_ioctl(struct tty_struct *tty,
 	unsigned int uival;
 	void __user *up = (void __user *)arg;
 	int i, perm;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * To have permissions to do most of the vt ioctls, we either have
@@ -369,8 +369,7 @@ int vt_ioctl(struct tty_struct *tty,
  
 	switch (cmd) {
 	case TIOCLINUX:
-		ret = tioclinux(tty, arg);
-		break;
+		return tioclinux(tty, arg);
 	case KIOCSOUND:
 		if (!perm)
 			return -EPERM;
@@ -408,8 +407,7 @@ int vt_ioctl(struct tty_struct *tty,
 		 * this is naïve.
 		 */
 		ucval = KB_101;
-		ret = put_user(ucval, (char __user *)arg);
-		break;
+		return put_user(ucval, (char __user *)arg);
 
 		/*
 		 * These cannot be implemented on any machine that implements
@@ -426,18 +424,15 @@ int vt_ioctl(struct tty_struct *tty,
 		 *
 		 * These are locked internally via sys_ioperm
 		 */
-		if (arg < GPFIRST || arg > GPLAST) {
-			ret = -EINVAL;
-			break;
-		}
-		ret = ksys_ioperm(arg, 1, (cmd == KDADDIO)) ? -ENXIO : 0;
-		break;
+		if (arg < GPFIRST || arg > GPLAST)
+			return -EINVAL;
+
+		return ksys_ioperm(arg, 1, (cmd == KDADDIO)) ? -ENXIO : 0;
 
 	case KDENABIO:
 	case KDDISABIO:
-		ret = ksys_ioperm(GPFIRST, GPNUM,
+		return ksys_ioperm(GPFIRST, GPNUM,
 				  (cmd == KDENABIO)) ? -ENXIO : 0;
-		break;
 #endif
 
 	/* Linux m68k/i386 interface for setting the keyboard delay/repeat rate */
@@ -449,15 +444,14 @@ int vt_ioctl(struct tty_struct *tty,
 		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
 
-		if (copy_from_user(&kbrep, up, sizeof(struct kbd_repeat))) {
-			ret =  -EFAULT;
-			break;
-		}
+		if (copy_from_user(&kbrep, up, sizeof(struct kbd_repeat)))
+			return -EFAULT;
+
 		ret = kbd_rate(&kbrep);
 		if (ret)
-			break;
+			return ret;
 		if (copy_to_user(up, &kbrep, sizeof(struct kbd_repeat)))
-			ret = -EFAULT;
+			return -EFAULT;
 		break;
 	}
 
@@ -481,8 +475,7 @@ int vt_ioctl(struct tty_struct *tty,
 		case KD_TEXT:
 			break;
 		default:
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 		/* FIXME: this needs the console lock extending */
 		if (vc->vc_mode == (unsigned char) arg)
@@ -511,51 +504,45 @@ int vt_ioctl(struct tty_struct *tty,
 		 * these work like a combination of mmap and KDENABIO.
 		 * this could be easily finished.
 		 */
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 
 	case KDSKBMODE:
 		if (!perm)
 			return -EPERM;
 		ret = vt_do_kdskbmode(console, arg);
-		if (ret == 0)
-			tty_ldisc_flush(tty);
+		if (ret)
+			return ret;
+		tty_ldisc_flush(tty);
 		break;
 
 	case KDGKBMODE:
 		uival = vt_do_kdgkbmode(console);
-		ret = put_user(uival, (int __user *)arg);
-		break;
+		return put_user(uival, (int __user *)arg);
 
 	/* this could be folded into KDSKBMODE, but for compatibility
 	   reasons it is not so easy to fold KDGKBMETA into KDGKBMODE */
 	case KDSKBMETA:
-		ret = vt_do_kdskbmeta(console, arg);
-		break;
+		return vt_do_kdskbmeta(console, arg);
 
 	case KDGKBMETA:
 		/* FIXME: should review whether this is worth locking */
 		uival = vt_do_kdgkbmeta(console);
 	setint:
-		ret = put_user(uival, (int __user *)arg);
-		break;
+		return put_user(uival, (int __user *)arg);
 
 	case KDGETKEYCODE:
 	case KDSETKEYCODE:
 		if(!capable(CAP_SYS_TTY_CONFIG))
 			perm = 0;
-		ret = vt_do_kbkeycode_ioctl(cmd, up, perm);
-		break;
+		return vt_do_kbkeycode_ioctl(cmd, up, perm);
 
 	case KDGKBENT:
 	case KDSKBENT:
-		ret = vt_do_kdsk_ioctl(cmd, up, perm, console);
-		break;
+		return vt_do_kdsk_ioctl(cmd, up, perm, console);
 
 	case KDGKBSENT:
 	case KDSKBSENT:
-		ret = vt_do_kdgkb_ioctl(cmd, up, perm);
-		break;
+		return vt_do_kdgkb_ioctl(cmd, up, perm);
 
 	/* Diacritical processing. Handled in keyboard.c as it has
 	   to operate on the keyboard locks and structures */
@@ -563,8 +550,7 @@ int vt_ioctl(struct tty_struct *tty,
 	case KDGKBDIACRUC:
 	case KDSKBDIACR:
 	case KDSKBDIACRUC:
-		ret = vt_do_diacrit(cmd, up, perm);
-		break;
+		return vt_do_diacrit(cmd, up, perm);
 
 	/* the ioctls below read/set the flags usually shown in the leds */
 	/* don't use them - they will go away without warning */
@@ -572,8 +558,7 @@ int vt_ioctl(struct tty_struct *tty,
 	case KDSKBLED:
 	case KDGETLED:
 	case KDSETLED:
-		ret = vt_do_kdskled(console, cmd, arg, perm);
-		break;
+		return vt_do_kdskled(console, cmd, arg, perm);
 
 	/*
 	 * A process can indicate its willingness to accept signals
@@ -583,20 +568,17 @@ int vt_ioctl(struct tty_struct *tty,
 	 * See also the kbrequest field of inittab(5).
 	 */
 	case KDSIGACCEPT:
-	{
 		if (!perm || !capable(CAP_KILL))
 			return -EPERM;
 		if (!valid_signal(arg) || arg < 1 || arg == SIGKILL)
-			ret = -EINVAL;
-		else {
-			spin_lock_irq(&vt_spawn_con.lock);
-			put_pid(vt_spawn_con.pid);
-			vt_spawn_con.pid = get_pid(task_pid(current));
-			vt_spawn_con.sig = arg;
-			spin_unlock_irq(&vt_spawn_con.lock);
-		}
+			return -EINVAL;
+
+		spin_lock_irq(&vt_spawn_con.lock);
+		put_pid(vt_spawn_con.pid);
+		vt_spawn_con.pid = get_pid(task_pid(current));
+		vt_spawn_con.sig = arg;
+		spin_unlock_irq(&vt_spawn_con.lock);
 		break;
-	}
 
 	case VT_SETMODE:
 	{
@@ -604,14 +586,11 @@ int vt_ioctl(struct tty_struct *tty,
 
 		if (!perm)
 			return -EPERM;
-		if (copy_from_user(&tmp, up, sizeof(struct vt_mode))) {
-			ret = -EFAULT;
-			goto out;
-		}
-		if (tmp.mode != VT_AUTO && tmp.mode != VT_PROCESS) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (copy_from_user(&tmp, up, sizeof(struct vt_mode)))
+			return -EFAULT;
+		if (tmp.mode != VT_AUTO && tmp.mode != VT_PROCESS)
+			return -EINVAL;
+
 		console_lock();
 		vc->vt_mode = tmp;
 		/* the frsig is ignored, so we set it to 0 */
@@ -635,7 +614,7 @@ int vt_ioctl(struct tty_struct *tty,
 
 		rc = copy_to_user(up, &tmp, sizeof(struct vt_mode));
 		if (rc)
-			ret = -EFAULT;
+			return -EFAULT;
 		break;
 	}
 
@@ -650,18 +629,16 @@ int vt_ioctl(struct tty_struct *tty,
 		unsigned short state, mask;
 
 		if (put_user(fg_console + 1, &vtstat->v_active))
-			ret = -EFAULT;
-		else {
-			state = 1;	/* /dev/tty0 is always open */
-			console_lock(); /* required by vt_in_use() */
-			for (i = 0, mask = 2; i < MAX_NR_CONSOLES && mask;
-							++i, mask <<= 1)
-				if (vt_in_use(i))
-					state |= mask;
-			console_unlock();
-			ret = put_user(state, &vtstat->v_state);
-		}
-		break;
+			return -EFAULT;
+
+		state = 1;	/* /dev/tty0 is always open */
+		console_lock(); /* required by vt_in_use() */
+		for (i = 0, mask = 2; i < MAX_NR_CONSOLES && mask;
+				++i, mask <<= 1)
+			if (vt_in_use(i))
+				state |= mask;
+		console_unlock();
+		return put_user(state, &vtstat->v_state);
 	}
 
 	/*
@@ -685,56 +662,54 @@ int vt_ioctl(struct tty_struct *tty,
 		if (!perm)
 			return -EPERM;
 		if (arg == 0 || arg > MAX_NR_CONSOLES)
-			ret =  -ENXIO;
-		else {
-			arg--;
-			console_lock();
-			ret = vc_allocate(arg);
-			console_unlock();
-			if (ret)
-				break;
-			set_console(arg);
-		}
+			return -ENXIO;
+
+		arg--;
+		console_lock();
+		ret = vc_allocate(arg);
+		console_unlock();
+		if (ret)
+			return ret;
+		set_console(arg);
 		break;
 
 	case VT_SETACTIVATE:
 	{
 		struct vt_setactivate vsa;
+		struct vc_data *nvc;
 
 		if (!perm)
 			return -EPERM;
 
 		if (copy_from_user(&vsa, (struct vt_setactivate __user *)arg,
-					sizeof(struct vt_setactivate))) {
-			ret = -EFAULT;
-			goto out;
-		}
+					sizeof(struct vt_setactivate)))
+			return -EFAULT;
 		if (vsa.console == 0 || vsa.console > MAX_NR_CONSOLES)
-			ret = -ENXIO;
-		else {
-			vsa.console = array_index_nospec(vsa.console,
-							 MAX_NR_CONSOLES + 1);
-			vsa.console--;
-			console_lock();
-			ret = vc_allocate(vsa.console);
-			if (ret == 0) {
-				struct vc_data *nvc;
-				/* This is safe providing we don't drop the
-				   console sem between vc_allocate and
-				   finishing referencing nvc */
-				nvc = vc_cons[vsa.console].d;
-				nvc->vt_mode = vsa.mode;
-				nvc->vt_mode.frsig = 0;
-				put_pid(nvc->vt_pid);
-				nvc->vt_pid = get_pid(task_pid(current));
-			}
+			return -ENXIO;
+
+		vsa.console = array_index_nospec(vsa.console,
+						 MAX_NR_CONSOLES + 1);
+		vsa.console--;
+		console_lock();
+		ret = vc_allocate(vsa.console);
+		if (ret) {
 			console_unlock();
-			if (ret)
-				break;
-			/* Commence switch and lock */
-			/* Review set_console locks */
-			set_console(vsa.console);
+			return ret;
 		}
+
+		/* This is safe providing we don't drop the
+		   console sem between vc_allocate and
+		   finishing referencing nvc */
+		nvc = vc_cons[vsa.console].d;
+		nvc->vt_mode = vsa.mode;
+		nvc->vt_mode.frsig = 0;
+		put_pid(nvc->vt_pid);
+		nvc->vt_pid = get_pid(task_pid(current));
+		console_unlock();
+
+		/* Commence switch and lock */
+		/* Review set_console locks */
+		set_console(vsa.console);
 		break;
 	}
 
@@ -745,10 +720,8 @@ int vt_ioctl(struct tty_struct *tty,
 		if (!perm)
 			return -EPERM;
 		if (arg == 0 || arg > MAX_NR_CONSOLES)
-			ret = -ENXIO;
-		else
-			ret = vt_waitactive(arg);
-		break;
+			return -ENXIO;
+		return vt_waitactive(arg);
 
 	/*
 	 * If a vt is under process control, the kernel will not switch to it
@@ -767,8 +740,7 @@ int vt_ioctl(struct tty_struct *tty,
 		console_lock();
 		if (vc->vt_mode.mode != VT_PROCESS) {
 			console_unlock();
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 		/*
 		 * Switching-from response
@@ -792,7 +764,7 @@ int vt_ioctl(struct tty_struct *tty,
 				ret = vc_allocate(newvt);
 				if (ret) {
 					console_unlock();
-					break;
+					return ret;
 				}
 				/*
 				 * When we actually do the console switch,
@@ -808,8 +780,10 @@ int vt_ioctl(struct tty_struct *tty,
 			/*
 			 * If it's just an ACK, ignore it
 			 */
-			if (arg != VT_ACKACQ)
-				ret = -EINVAL;
+			if (arg != VT_ACKACQ) {
+				console_unlock();
+				return -EINVAL;
+			}
 		}
 		console_unlock();
 		break;
@@ -818,40 +792,38 @@ int vt_ioctl(struct tty_struct *tty,
 	  * Disallocate memory associated to VT (but leave VT1)
 	  */
 	 case VT_DISALLOCATE:
-		if (arg > MAX_NR_CONSOLES) {
-			ret = -ENXIO;
-			break;
-		}
+		if (arg > MAX_NR_CONSOLES)
+			return -ENXIO;
+
 		if (arg == 0)
 			vt_disallocate_all();
 		else
-			ret = vt_disallocate(--arg);
+			return vt_disallocate(--arg);
 		break;
 
 	case VT_RESIZE:
 	{
 		struct vt_sizes __user *vtsizes = up;
 		struct vc_data *vc;
-
 		ushort ll,cc;
+
 		if (!perm)
 			return -EPERM;
 		if (get_user(ll, &vtsizes->v_rows) ||
 		    get_user(cc, &vtsizes->v_cols))
-			ret = -EFAULT;
-		else {
-			console_lock();
-			for (i = 0; i < MAX_NR_CONSOLES; i++) {
-				vc = vc_cons[i].d;
+			return -EFAULT;
 
-				if (vc) {
-					vc->vc_resize_user = 1;
-					/* FIXME: review v tty lock */
-					vc_resize(vc_cons[i].d, cc, ll);
-				}
+		console_lock();
+		for (i = 0; i < MAX_NR_CONSOLES; i++) {
+			vc = vc_cons[i].d;
+
+			if (vc) {
+				vc->vc_resize_user = 1;
+				/* FIXME: review v tty lock */
+				vc_resize(vc_cons[i].d, cc, ll);
 			}
-			console_unlock();
 		}
+		console_unlock();
 		break;
 	}
 
@@ -905,7 +877,7 @@ int vt_ioctl(struct tty_struct *tty,
 		break;
 	}
 
-	case PIO_FONT: {
+	case PIO_FONT:
 		if (!perm)
 			return -EPERM;
 		op.op = KD_FONT_OP_SET;
@@ -914,98 +886,77 @@ int vt_ioctl(struct tty_struct *tty,
 		op.height = 0;
 		op.charcount = 256;
 		op.data = up;
-		ret = con_font_op(vc_cons[fg_console].d, &op);
-		break;
-	}
+		return con_font_op(vc_cons[fg_console].d, &op);
 
-	case GIO_FONT: {
+	case GIO_FONT:
 		op.op = KD_FONT_OP_GET;
 		op.flags = KD_FONT_FLAG_OLD;
 		op.width = 8;
 		op.height = 32;
 		op.charcount = 256;
 		op.data = up;
-		ret = con_font_op(vc_cons[fg_console].d, &op);
-		break;
-	}
+		return con_font_op(vc_cons[fg_console].d, &op);
 
 	case PIO_CMAP:
                 if (!perm)
-			ret = -EPERM;
-		else
-	                ret = con_set_cmap(up);
-		break;
+			return -EPERM;
+		return con_set_cmap(up);
 
 	case GIO_CMAP:
-                ret = con_get_cmap(up);
-		break;
+                return con_get_cmap(up);
 
 	case PIO_FONTX:
 	case GIO_FONTX:
-		ret = do_fontx_ioctl(cmd, up, perm, &op);
-		break;
+		return do_fontx_ioctl(cmd, up, perm, &op);
 
 	case PIO_FONTRESET:
-	{
 		if (!perm)
 			return -EPERM;
 
 #ifdef BROKEN_GRAPHICS_PROGRAMS
 		/* With BROKEN_GRAPHICS_PROGRAMS defined, the default
 		   font is not saved. */
-		ret = -ENOSYS;
-		break;
+		return -ENOSYS;
 #else
-		{
 		op.op = KD_FONT_OP_SET_DEFAULT;
 		op.data = NULL;
 		ret = con_font_op(vc_cons[fg_console].d, &op);
 		if (ret)
-			break;
+			return ret;
 		console_lock();
 		con_set_default_unimap(vc_cons[fg_console].d);
 		console_unlock();
 		break;
-		}
 #endif
-	}
 
 	case KDFONTOP: {
-		if (copy_from_user(&op, up, sizeof(op))) {
-			ret = -EFAULT;
-			break;
-		}
+		if (copy_from_user(&op, up, sizeof(op)))
+			return -EFAULT;
 		if (!perm && op.op != KD_FONT_OP_GET)
 			return -EPERM;
 		ret = con_font_op(vc, &op);
 		if (ret)
-			break;
+			return ret;
 		if (copy_to_user(up, &op, sizeof(op)))
-			ret = -EFAULT;
+			return -EFAULT;
 		break;
 	}
 
 	case PIO_SCRNMAP:
 		if (!perm)
-			ret = -EPERM;
-		else
-			ret = con_set_trans_old(up);
-		break;
+			return -EPERM;
+		return con_set_trans_old(up);
 
 	case GIO_SCRNMAP:
-		ret = con_get_trans_old(up);
-		break;
+		return con_get_trans_old(up);
 
 	case PIO_UNISCRNMAP:
 		if (!perm)
-			ret = -EPERM;
-		else
-			ret = con_set_trans_new(up);
-		break;
+			return -EPERM;
+		return con_set_trans_new(up);
 
 	case GIO_UNISCRNMAP:
-		ret = con_get_trans_new(up);
-		break;
+		return con_get_trans_new(up);
 
 	case PIO_UNIMAPCLR:
 		if (!perm)
@@ -1015,8 +966,7 @@ int vt_ioctl(struct tty_struct *tty,
 
 	case PIO_UNIMAP:
 	case GIO_UNIMAP:
-		ret = do_unimap_ioctl(cmd, up, perm, vc);
-		break;
+		return do_unimap_ioctl(cmd, up, perm, vc);
 
 	case VT_LOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))
@@ -1029,17 +979,15 @@ int vt_ioctl(struct tty_struct *tty,
 		vt_dont_switch = false;
 		break;
 	case VT_GETHIFONTMASK:
-		ret = put_user(vc->vc_hi_font_mask,
+		return put_user(vc->vc_hi_font_mask,
 					(unsigned short __user *)arg);
-		break;
 	case VT_WAITEVENT:
-		ret = vt_event_wait_ioctl((struct vt_event __user *)arg);
-		break;
+		return vt_event_wait_ioctl((struct vt_event __user *)arg);
 	default:
-		ret = -ENOIOCTLCMD;
+		return -ENOIOCTLCMD;
 	}
-out:
-	return ret;
+
+	return 0;
 }
 
 void reset_vc(struct vc_data *vc)
-- 
2.27.0

