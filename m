From: Rob Herring <robh@kernel.org>
Subject: [RFC PATCH 5/6] serio: add serial configuration functions
Date: Wed, 24 Aug 2016 18:24:36 -0500
Message-ID: <20160824232437.9446-7-robh@kernel.org>
References: <20160824232437.9446-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824232437.9446-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Just stub functions ATM.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/linux/serio.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/serio.h b/include/linux/serio.h
index 5d0b69f..5bf1754 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -41,6 +41,8 @@ struct serio {
 	void (*close)(struct serio *);
 	int (*start)(struct serio *);
 	void (*stop)(struct serio *);
+	void (*set_flow_control)(struct serio *, bool);
+	unsigned int (*set_baudrate)(struct serio *, unsigned int);
 
 	struct serio *parent;
 	/* Entry in parent->children list */
@@ -170,6 +172,20 @@ static inline void serio_drv_write_wakeup(struct serio *serio)
 		serio->drv->write_wakeup(serio);
 }
 
+static inline void serio_set_flow_control(struct serio *serio, bool enable)
+{
+	if (serio->set_flow_control)
+		serio->set_flow_control(serio, enable);
+}
+
+static inline unsigned int serio_set_baudrate(struct serio *serio, unsigned int speed)
+{
+	if (serio->set_baudrate)
+		return serio->set_baudrate(serio, speed);
+
+	return 0;
+}
+
 /*
  * Use the following functions to manipulate serio's per-port
  * driver-specific data.
-- 
2.9.3
