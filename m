From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 5/9] tty_port: Add port client functions
Date: Mon, 16 Jan 2017 16:54:32 -0600
Message-ID: <20170116225436.17505-6-robh@kernel.org>
References: <20170116225436.17505-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116225436.17505-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Introduce a client (upward direction) operations struct for tty_port
clients. Initially supported operations are for receiving data and write
wake-up. This will allow for having clients other than an ldisc.

Convert the calls to the ldisc to use the client ops as the default
operations.

Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-By: Sebastian Reichel <sre@kernel.org>
---
v2:
- no change

 drivers/tty/tty_buffer.c | 17 +++--------------
 drivers/tty/tty_port.c   | 39 ++++++++++++++++++++++++++++++++++++++-
 include/linux/tty.h      |  9 ++++++++-
 3 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index f4dc3e296dd5..4e7a4e9dcf4d 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -437,7 +437,7 @@ int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 EXPORT_SYMBOL_GPL(tty_ldisc_receive_buf);

 static int
-receive_buf(struct tty_ldisc *ld, struct tty_buffer *head, int count)
+receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 {
 	unsigned char *p = char_buf_ptr(head, head->read);
 	char	      *f = NULL;
@@ -445,7 +445,7 @@ receive_buf(struct tty_ldisc *ld, struct tty_buffer *head, int count)
 	if (~head->flags & TTYB_NORMAL)
 		f = flag_buf_ptr(head, head->read);

-	return tty_ldisc_receive_buf(ld, p, f, count);
+	return port->client_ops->receive_buf(port, p, f, count);
 }

 /**
@@ -465,16 +465,6 @@ static void flush_to_ldisc(struct work_struct *work)
 {
 	struct tty_port *port = container_of(work, struct tty_port, buf.work);
 	struct tty_bufhead *buf = &port->buf;
-	struct tty_struct *tty;
-	struct tty_ldisc *disc;
-
-	tty = READ_ONCE(port->itty);
-	if (tty == NULL)
-		return;
-
-	disc = tty_ldisc_ref(tty);
-	if (disc == NULL)
-		return;

 	mutex_lock(&buf->lock);

@@ -504,7 +494,7 @@ static void flush_to_ldisc(struct work_struct *work)
 			continue;
 		}

-		count = receive_buf(disc, head, count);
+		count = receive_buf(port, head, count);
 		if (!count)
 			break;
 		head->read += count;
@@ -512,7 +502,6 @@ static void flush_to_ldisc(struct work_struct *work)

 	mutex_unlock(&buf->lock);

-	tty_ldisc_deref(disc);
 }

 /**
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 1d8804843103..232a8cbf47bc 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -17,6 +17,41 @@
 #include <linux/delay.h>
 #include <linux/module.h>

+static int tty_port_default_receive_buf(struct tty_port *port,
+					const unsigned char *p,
+					const unsigned char *f, size_t count)
+{
+	int ret;
+	struct tty_struct *tty;
+	struct tty_ldisc *disc;
+
+	tty = READ_ONCE(port->itty);
+	if (!tty)
+		return 0;
+
+	disc = tty_ldisc_ref(tty);
+	if (!disc)
+		return 0;
+
+	ret = tty_ldisc_receive_buf(disc, p, (char *)f, count);
+
+	tty_ldisc_deref(disc);
+
+	return ret;
+}
+
+static void tty_port_default_wakeup(struct tty_port *port)
+{
+	/* tty_port_tty_wakeup already took a reference to the tty */
+	tty_wakeup(port->tty);
+}
+
+static const struct tty_port_client_operations default_client_ops = {
+	.receive_buf = tty_port_default_receive_buf,
+	.write_wakeup = tty_port_default_wakeup,
+};
+
+
 void tty_port_init(struct tty_port *port)
 {
 	memset(port, 0, sizeof(*port));
@@ -28,6 +63,7 @@ void tty_port_init(struct tty_port *port)
 	spin_lock_init(&port->lock);
 	port->close_delay = (50 * HZ) / 100;
 	port->closing_wait = (3000 * HZ) / 100;
+	port->client_ops = &default_client_ops;
 	kref_init(&port->kref);
 }
 EXPORT_SYMBOL(tty_port_init);
@@ -275,7 +311,8 @@ void tty_port_tty_wakeup(struct tty_port *port)
 	struct tty_struct *tty = tty_port_tty_get(port);

 	if (tty) {
-		tty_wakeup(tty);
+		if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags))
+			port->client_ops->write_wakeup(port);
 		tty_kref_put(tty);
 	}
 }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 21c0fabfed60..1017e904c0a3 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -217,12 +217,18 @@ struct tty_port_operations {
 	/* Called on the final put of a port */
 	void (*destruct)(struct tty_port *port);
 };
-
+
+struct tty_port_client_operations {
+	int (*receive_buf)(struct tty_port *port, const unsigned char *, const unsigned char *, size_t);
+	void (*write_wakeup)(struct tty_port *port);
+};
+
 struct tty_port {
 	struct tty_bufhead	buf;		/* Locked internally */
 	struct tty_struct	*tty;		/* Back pointer */
 	struct tty_struct	*itty;		/* internal back ptr */
 	const struct tty_port_operations *ops;	/* Port operations */
+	const struct tty_port_client_operations *client_ops; /* Port client operations */
 	spinlock_t		lock;		/* Lock protecting tty field */
 	int			blocked_open;	/* Waiting to open */
 	int			count;		/* Usage count */
@@ -241,6 +247,7 @@ struct tty_port {
 						   based drain is needed else
 						   set to size of fifo */
 	struct kref		kref;		/* Ref counter */
+	void 			*client_data;
 };

 /* tty_port::iflags bits -- use atomic bit ops */
--
2.10.1
