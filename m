From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Race between release_tty() and vt_disallocate()
Date: Mon, 14 Aug 2017 16:25:27 +0200
Message-ID: <8400458.N1a9Uh7DF8@wuerfel>
References: <CAK8P3a2Pok0Mpmj+DZG3gi13F9bWrK_u7M0hC4kHKuUzSuH1Ng@mail.gmail.com> <20170814133947.37ad1855@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814133947.37ad1855@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adam Borowski <kilobyte@angband.pl>, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, jun.he@linaro.org, graeme.gregory@linaro.org, gema.gomez-solano@linaro.org
List-Id: linux-serial@vger.kernel.org

On Monday, August 14, 2017 1:39:47 PM CEST Alan Cox wrote:

> > the tty closes and that leads to  tty->count dropping to zero
> > before we call tty_buffer_cancel_work() on the tty_port that
> > has now been freed.
> > 
> > Apparently the locking and/or reference counting between the
> > two code paths is insufficient, but I don't understand enough
> > about tty locking to come up with a fix that doesn't break other
> > things. Please have a look.
> 
> I'm actually not sure how we can fix this within the current API. The tty
> port is refcounted (see tty_port_put() and tty_port_tty_get()) so
> any ioctl would end up returning but the console port resources would not
> disappear until that tty finally closed down.

It seems that part of the problem is the lack of tty_port_put/tty_port_get
calls in the VT code.

> The only easy way I can think to keep the current semantics would instead
> be to keep the tty port resources around and indexed somewhere but
> blackhole input to/output from that port or switching to it and also call
> tty_hangup if the port has a tty.

What would still be missing if we just add that reference counting and
delay the freeing of the vc_data/tty_port? I probably missed part of your
analysis, so just throwing this out for discussion.

(not tested, probably wrong as I said)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 2ebaba16f785..9ab3df49d988 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -750,6 +750,16 @@ static void visual_init(struct vc_data *vc, int num, int init)
 	vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;
 }
 
+static void vt_destruct(struct tty_port *port)
+{
+	struct vc_data *vc = container_of(port, struct vc_data, port);
+	kfree(vc);
+}
+
+static const struct tty_port_operations vt_port_operations = {
+	.destruct = vt_destruct,
+};
+
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
 {
 	struct vt_notifier_param param;
@@ -775,6 +785,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 
 	vc_cons[currcons].d = vc;
 	tty_port_init(&vc->port);
+	vc->port.ops = &vt_port_operations;
 	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 
 	visual_init(vc, currcons, 1);
@@ -2880,14 +2891,16 @@ static int con_install(struct tty_driver *driver, struct tty_struct *tty)
 	vc = vc_cons[currcons].d;
 
 	/* Still being freed */
-	if (vc->port.tty) {
+	if (vc->port.tty || !tty_port_get(&vc->port)) {
 		ret = -ERESTARTSYS;
 		goto unlock;
 	}
 
 	ret = tty_port_install(&vc->port, driver, tty);
-	if (ret)
+	if (ret) {
+		tty_port_put(&vc->port);
 		goto unlock;
+	}
 
 	tty->driver_data = vc;
 	vc->port.tty = tty;
@@ -2926,6 +2939,11 @@ static void con_shutdown(struct tty_struct *tty)
 	console_unlock();
 }
 
+static void con_cleanup(struct tty_struct *tty)
+{
+	tty_port_put(tty->port);
+}
+
 static int default_color           = 7; /* white */
 static int default_italic_color    = 2; // green (ASCII)
 static int default_underline_color = 3; // cyan (ASCII)
@@ -3050,7 +3068,8 @@ static const struct tty_operations con_ops = {
 	.throttle = con_throttle,
 	.unthrottle = con_unthrottle,
 	.resize = vt_resize,
-	.shutdown = con_shutdown
+	.shutdown = con_shutdown,
+	.cleanup = con_cleanup,
 };
 
 static struct cdev vc0_cdev;
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 96d389cb506c..25aa37a93f58 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -292,10 +292,8 @@ static int vt_disallocate(unsigned int vc_num)
 		vc = vc_deallocate(vc_num);
 	console_unlock();
 
-	if (vc && vc_num >= MIN_NR_CONSOLES) {
-		tty_port_destroy(&vc->port);
-		kfree(vc);
-	}
+	if (vc && vc_num >= MIN_NR_CONSOLES)
+		tty_port_put(&vc->port);
 
 	return ret;
 }
@@ -315,10 +313,8 @@ static void vt_disallocate_all(void)
 	console_unlock();
 
 	for (i = 1; i < MAX_NR_CONSOLES; i++) {
-		if (vc[i] && i >= MIN_NR_CONSOLES) {
-			tty_port_destroy(&vc[i]->port);
-			kfree(vc[i]);
-		}
+		if (vc[i] && i >= MIN_NR_CONSOLES)
+			tty_port_put(&vc[i]->port);
 	}
 }
 
