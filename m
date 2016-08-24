From: Rob Herring <robh@kernel.org>
Subject: [RFC PATCH 1/6] serio: add OF driver binding
Date: Wed, 24 Aug 2016 18:24:32 -0500
Message-ID: <20160824232437.9446-3-robh@kernel.org>
References: <20160824232437.9446-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824232437.9446-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/input/serio/serio.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 1ca7f55..6cfa22f 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/mutex.h>
+#include <linux/of_device.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Serio abstraction core");
@@ -88,7 +89,7 @@ static void serio_disconnect_driver(struct serio *serio)
 
 static int serio_match_port(const struct serio_device_id *ids, struct serio *serio)
 {
-	while (ids->type || ids->proto) {
+	while (ids && (ids->type || ids->proto)) {
 		if ((ids->type == SERIO_ANY || ids->type == serio->id.type) &&
 		    (ids->proto == SERIO_ANY || ids->proto == serio->id.proto) &&
 		    (ids->extra == SERIO_ANY || ids->extra == serio->id.extra) &&
@@ -107,6 +108,7 @@ static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
 {
 	int error;
 
+	printk("%s\n", __func__);
 	if (serio_match_port(drv->id_table, serio)) {
 
 		serio->dev.driver = &drv->driver;
@@ -133,6 +135,7 @@ static void serio_find_driver(struct serio *serio)
 {
 	int error;
 
+	printk("%s\n", __func__);
 	error = device_attach(&serio->dev);
 	if (error < 0 && error != -EPROBE_DEFER)
 		dev_warn(&serio->dev,
@@ -542,8 +545,12 @@ static void serio_init_port(struct serio *serio)
 static void serio_add_port(struct serio *serio)
 {
 	struct serio *parent = serio->parent;
+	struct device_node *parent_node =
+		serio->dev.parent ? serio->dev.parent->of_node : NULL;
 	int error;
 
+	printk("%s\n", __func__);
+
 	if (parent) {
 		serio_pause_rx(parent);
 		list_add_tail(&serio->child_node, &parent->children);
@@ -555,6 +562,8 @@ static void serio_add_port(struct serio *serio)
 	if (serio->start)
 		serio->start(serio);
 
+	serio->dev.of_node = of_get_next_available_child(parent_node, NULL);
+
 	error = device_add(&serio->dev);
 	if (error)
 		dev_err(&serio->dev,
@@ -570,6 +579,8 @@ static void serio_destroy_port(struct serio *serio)
 {
 	struct serio *child;
 
+	printk("%s\n", __func__);
+
 	while ((child = serio_get_pending_child(serio)) != NULL) {
 		serio_remove_pending_events(child);
 		put_device(&child->dev);
@@ -791,6 +802,7 @@ static int serio_driver_probe(struct device *dev)
 	struct serio *serio = to_serio_port(dev);
 	struct serio_driver *drv = to_serio_driver(dev->driver);
 
+	printk("%s\n", __func__);
 	return serio_connect_driver(serio, drv);
 }
 
@@ -902,6 +914,12 @@ static int serio_bus_match(struct device *dev, struct device_driver *drv)
 	struct serio *serio = to_serio_port(dev);
 	struct serio_driver *serio_drv = to_serio_driver(drv);
 
+	printk("%s\n", __func__);
+
+	if (of_driver_match_device(dev, drv)) {
+		printk("matched %s\n", dev->of_node->name);
+		return 1;
+	}
 	if (serio->manual_bind || serio_drv->manual_bind)
 		return 0;
 
-- 
2.9.3
