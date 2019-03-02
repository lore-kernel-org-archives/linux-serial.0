From: Calvin Owens <calvinowens@fb.com>
Subject: [PATCH 4/4] printk: Add a device attribute for the per-console loglevel
Date: Fri, 1 Mar 2019 16:48:20 -0800
Message-ID: <4f71564063a07837e3c4df41326bad25e7dc4db4.1551486733.git.calvinowens@fb.com>
References: <cover.1551486732.git.calvinowens@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1551486732.git.calvinowens@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Calvin Owens <calvinowens@fb.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Calvin Owens <calvinowens@fb.com>
---
 kernel/printk/printk.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 67e1e993ab80..e7e602fa2d0b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2560,8 +2560,48 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct console *con = container_of(dev, struct console, dev);
+	return sprintf(buf, "%d\n", con->level);
+}
+
+static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct console *con = container_of(dev, struct console, dev);
+	ssize_t ret;
+	int tmp;
+
+	ret = kstrtoint(buf, 10, &tmp);
+	if (ret < 0)
+		return ret;
+
+	if (tmp < LOGLEVEL_EMERG)
+		return -ERANGE;
+
+	/*
+	 * Mimic the behavior of /dev/kmsg with respect to minimum_loglevel.
+	 */
+	if (tmp < minimum_console_loglevel)
+		tmp = minimum_console_loglevel;
+
+	con->level = tmp;
+	return ret;
+}
+
+static DEVICE_ATTR_RW(loglevel);
+
+static struct attribute *console_sysfs_attrs[] = {
+	&dev_attr_loglevel.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(console_sysfs);
+
 static struct bus_type console_subsys = {
 	.name = "console",
+	.dev_groups = console_sysfs_groups,
 };
 
 static void console_release(struct device *dev)
-- 
2.17.1
