From: Oleksandr Shamray <oleksandrs@mellanox.com>
Subject: [patch v1 1/2] drivers: jtag: Add JTAG core driver
Date: Wed,  2 Aug 2017 16:18:37 +0300
Message-ID: <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au, jiri@resnulli.us, tklauser@distanz.ch, linux-serial@vger.kernel.org, mec@shout.net, vadimp@maellanox.com, system-sw-low-level@mellanox.com, Oleksandr Shamray <oleksandrs@mellanox.com>, Jiri Pirko <jiri@mellanox.com>
List-Id: linux-serial@vger.kernel.org

JTAG class driver provide infrastructure to support hardware/software
JTAG platform drivers. It provide user layer API interface for flashing
and debugging external devices which equipped with JTAG interface
using standard transactions.

Driver exposes set of IOCTL to user space for:
- XFER:
- SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
- SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
- RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
  number of clocks).
- SIOCFREQ/GIOCFREQ for setting and reading JTAG frequency.

Driver core provides set of internal APIs for allocation and
registration:
- jtag_register;
- jtag_unregister;
- jtag_alloc;
- jtag_free;

Platform driver on registration with jtag-core creates the next
entry in dev folder:
/dev/jtagX

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 Documentation/ioctl/ioctl-number.txt |    2 +
 MAINTAINERS                          |    8 +
 drivers/Kconfig                      |    2 +
 drivers/Makefile                     |    1 +
 drivers/jtag/Kconfig                 |   18 ++
 drivers/jtag/Makefile                |    2 +
 drivers/jtag/jtag.c                  |  347 ++++++++++++++++++++++++++++++++++
 include/linux/jtag.h                 |   63 ++++++
 include/uapi/linux/jtag.h            |  133 +++++++++++++
 9 files changed, 576 insertions(+), 0 deletions(-)
 create mode 100644 drivers/jtag/Kconfig
 create mode 100644 drivers/jtag/Makefile
 create mode 100644 drivers/jtag/jtag.c
 create mode 100644 include/linux/jtag.h
 create mode 100644 include/uapi/linux/jtag.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 3e3fdae..1af2508 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -321,6 +321,8 @@ Code  Seq#(hex)	Include File		Comments
 0xB0	all	RATIO devices		in development:
 					<mailto:vgo@ratio.de>
 0xB1	00-1F	PPPoX			<mailto:mostrows@styx.uwaterloo.ca>
+0xB2	00-0f	linux/jtag.h		JTAG driver
+					<mailto:oleksandrs@mellanox.com>
 0xB3	00	linux/mmc/ioctl.h
 0xB4	00-0F	linux/gpio.h		<mailto:linux-gpio@vger.kernel.org>
 0xB5	00-0F	uapi/linux/rpmsg.h	<mailto:linux-remoteproc@vger.kernel.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 205d397..141aeaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7292,6 +7292,14 @@ L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	drivers/tty/serial/jsm/
 
+JTAG SUBSYSTEM
+M:	Oleksandr Shamray <oleksandrs@mellanox.com>
+M:	Vadim Pasternak <vadimp@mellanox.com>
+S:	Maintained
+F:	include/linux/jtag.h
+F:	include/uapi/linux/jtag.h
+F:	drivers/jtag/
+
 K10TEMP HARDWARE MONITORING DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 505c676..2214678 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -208,4 +208,6 @@ source "drivers/tee/Kconfig"
 
 source "drivers/mux/Kconfig"
 
+source "drivers/jtag/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index dfdcda0..6a2059b 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -182,3 +182,4 @@ obj-$(CONFIG_FPGA)		+= fpga/
 obj-$(CONFIG_FSI)		+= fsi/
 obj-$(CONFIG_TEE)		+= tee/
 obj-$(CONFIG_MULTIPLEXER)	+= mux/
+obj-$(CONFIG_JTAG)		+= jtag/
diff --git a/drivers/jtag/Kconfig b/drivers/jtag/Kconfig
new file mode 100644
index 0000000..a8d0149
--- /dev/null
+++ b/drivers/jtag/Kconfig
@@ -0,0 +1,18 @@
+menuconfig JTAG
+	tristate "JTAG support"
+	default n
+	---help---
+	  This provides basic core functionality support for jtag class devices
+	  Hardware equipped with JTAG microcontroller which can be built
+	  on top of this drivers. Driver exposes the set of IOCTL to the
+	  user space for:
+	  SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
+	  SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
+	  RUNTEST (Forces IEEE 1149.1 bus to a run state for specified
+	  number of clocks).
+
+	  If you want this support, you should say Y here.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called jtag.
+
diff --git a/drivers/jtag/Makefile b/drivers/jtag/Makefile
new file mode 100644
index 0000000..e811330
--- /dev/null
+++ b/drivers/jtag/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_JTAG)		+= jtag.o
+
diff --git a/drivers/jtag/jtag.c b/drivers/jtag/jtag.c
new file mode 100644
index 0000000..a933bc1
--- /dev/null
+++ b/drivers/jtag/jtag.c
@@ -0,0 +1,347 @@
+/*
+ * Copyright (c) 2017 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2017 Oleksandr Shamray <oleksandrs@mellanox.com>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the names of the copyright holders nor the names of its
+ *    contributors may be used to endorse or promote products derived from
+ *    this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/jtag.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/rtnetlink.h>
+#include <linux/spinlock.h>
+#include <uapi/linux/jtag.h>
+
+struct jtag {
+	struct list_head list;
+	struct device *dev;
+	struct cdev cdev;
+	int id;
+	spinlock_t lock;
+	bool is_open;
+	const struct jtag_ops *ops;
+	unsigned long priv[0];
+};
+
+static dev_t jtag_devt;
+static LIST_HEAD(jtag_list);
+static DEFINE_MUTEX(jtag_mutex);
+static DEFINE_IDA(jtag_ida);
+
+void *jtag_priv(struct jtag *jtag)
+{
+	return jtag->priv;
+}
+EXPORT_SYMBOL_GPL(jtag_priv);
+
+static void *jtag_copy_from_user(void __user *udata, unsigned long bit_size)
+{
+	void *kdata;
+	unsigned long size;
+	unsigned long err;
+
+	size = DIV_ROUND_UP(bit_size, BITS_PER_BYTE);
+	kdata = kzalloc(size, GFP_KERNEL);
+	if (!kdata)
+		return NULL;
+
+	err = copy_from_user(kdata, udata, size);
+	if (!err)
+		return kdata;
+
+	kfree(kdata);
+	return NULL;
+}
+
+static unsigned long jtag_copy_to_user(void __user *udata, void *kdata,
+				       unsigned long bit_size)
+{
+	unsigned long size;
+
+	size = DIV_ROUND_UP(bit_size, BITS_PER_BYTE);
+	return copy_to_user(udata, kdata, size);
+}
+
+static struct class jtag_class = {
+	.name = "jtag",
+	.owner = THIS_MODULE,
+};
+
+static int jtag_run_test_idle(struct jtag *jtag,
+			      struct jtag_run_test_idle *idle)
+{
+	if (jtag->ops->idle)
+		return jtag->ops->idle(jtag, idle);
+	else
+		return -EOPNOTSUPP;
+}
+
+static int jtag_xfer(struct jtag *jtag, struct jtag_xfer *xfer)
+{
+	if (jtag->ops->xfer)
+		return jtag->ops->xfer(jtag, xfer);
+	else
+		return -EOPNOTSUPP;
+}
+
+static long jtag_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct jtag *jtag = file->private_data;
+	struct jtag_run_test_idle idle;
+	struct jtag_xfer xfer;
+	void *user_tdio_data;
+	unsigned long value;
+	int err;
+
+	switch (cmd) {
+	case JTAG_GIOCFREQ:
+		if (jtag->ops->freq_get)
+			err = jtag->ops->freq_get(jtag, &value);
+		else
+			err = -EOPNOTSUPP;
+		if (err)
+			break;
+
+		err = __put_user(value, (unsigned long __user *)arg);
+		break;
+
+	case JTAG_SIOCFREQ:
+		err = __get_user(value, (unsigned long __user *)arg);
+
+		if (value == 0)
+			err = -EINVAL;
+		if (err)
+			break;
+
+		if (jtag->ops->freq_set)
+			err = jtag->ops->freq_set(jtag, value);
+		else
+			err = -EOPNOTSUPP;
+		break;
+
+	case JTAG_IOCRUNTEST:
+		if (copy_from_user(&idle, (void __user *)arg,
+				   sizeof(struct jtag_run_test_idle)))
+			return -ENOMEM;
+		err = jtag_run_test_idle(jtag, &idle);
+		break;
+
+	case JTAG_IOCXFER:
+		if (copy_from_user(&xfer, (void __user *)arg,
+				   sizeof(struct jtag_xfer)))
+			return -EFAULT;
+
+		user_tdio_data = xfer.tdio;
+		xfer.tdio = jtag_copy_from_user((void __user *)user_tdio_data,
+				xfer.length);
+		if (!xfer.tdio)
+			return -ENOMEM;
+
+		err = jtag_xfer(jtag, &xfer);
+		if (jtag_copy_to_user((void __user *)user_tdio_data,
+				      xfer.tdio, xfer.length)) {
+			kfree(xfer.tdio);
+			return -EFAULT;
+		}
+
+		kfree(xfer.tdio);
+		xfer.tdio = user_tdio_data;
+		if (copy_to_user((void __user *)arg, &xfer,
+				 sizeof(struct jtag_xfer))) {
+			kfree(xfer.tdio);
+			return -EFAULT;
+		}
+		break;
+
+	case JTAG_GIOCSTATUS:
+		if (jtag->ops->status_get)
+			err = jtag->ops->status_get(jtag,
+						(enum jtag_endstate *)&value);
+		else
+			err = -EOPNOTSUPP;
+		if (err)
+			break;
+
+		err = __put_user(value, (unsigned int __user *)arg);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	return err;
+}
+
+static struct jtag *jtag_get_dev(int id)
+{
+	struct jtag *jtag;
+
+	mutex_lock(&jtag_mutex);
+	list_for_each_entry(jtag, &jtag_list, list) {
+		if (jtag->id == id)
+			goto found;
+	}
+	jtag = NULL;
+found:
+	mutex_unlock(&jtag_mutex);
+	return jtag;
+}
+
+static int jtag_open(struct inode *inode, struct file *file)
+{
+	struct jtag *jtag;
+	unsigned int minor = iminor(inode);
+
+	jtag = jtag_get_dev(minor);
+	if (!jtag)
+		return -ENODEV;
+
+	spin_lock(&jtag->lock);
+
+	if (jtag->is_open) {
+		dev_info(NULL, "jtag already opened\n");
+		spin_unlock(&jtag->lock);
+		return -EBUSY;
+	}
+
+	jtag->is_open = true;
+	file->private_data = jtag;
+	spin_unlock(&jtag->lock);
+	return 0;
+}
+
+static int jtag_release(struct inode *inode, struct file *file)
+{
+	struct jtag *jtag = file->private_data;
+
+	spin_lock(&jtag->lock);
+	jtag->is_open = false;
+	spin_unlock(&jtag->lock);
+	return 0;
+}
+
+static const struct file_operations jtag_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.unlocked_ioctl	= jtag_ioctl,
+	.open		= jtag_open,
+	.release	= jtag_release,
+};
+
+struct jtag *jtag_alloc(size_t priv_size, const struct jtag_ops *ops)
+{
+	struct jtag *jtag = kzalloc(sizeof(*jtag) + priv_size, GFP_KERNEL);
+
+	if (!jtag)
+		return NULL;
+
+	jtag->ops = ops;
+	return jtag;
+}
+EXPORT_SYMBOL_GPL(jtag_alloc);
+
+void jtag_free(struct jtag *jtag)
+{
+	kfree(jtag);
+}
+EXPORT_SYMBOL_GPL(jtag_free);
+
+int jtag_register(struct jtag *jtag)
+{
+	int id;
+	int err;
+
+	id = ida_simple_get(&jtag_ida, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	jtag->id = id;
+	cdev_init(&jtag->cdev, &jtag_fops);
+	jtag->cdev.owner = THIS_MODULE;
+	err = cdev_add(&jtag->cdev, MKDEV(MAJOR(jtag_devt), jtag->id), 1);
+	if (err)
+		goto err_cdev;
+
+	/* Register this jtag device with the driver core */
+	jtag->dev = device_create(&jtag_class, NULL, MKDEV(MAJOR(jtag_devt),
+				  jtag->id), NULL, "jtag%d", jtag->id);
+	if (!jtag->dev)
+		goto err_device_create;
+
+	dev_set_drvdata(jtag->dev, jtag);
+	spin_lock_init(&jtag->lock);
+	mutex_lock(&jtag_mutex);
+	list_add_tail(&jtag->list, &jtag_list);
+	mutex_unlock(&jtag_mutex);
+	return err;
+
+err_device_create:
+	cdev_del(&jtag->cdev);
+err_cdev:
+	ida_simple_remove(&jtag_ida, id);
+	return err;
+}
+EXPORT_SYMBOL_GPL(jtag_register);
+
+void jtag_unregister(struct jtag *jtag)
+{
+	struct device *dev = jtag->dev;
+
+	mutex_lock(&jtag_mutex);
+	list_add_tail(&jtag->list, &jtag_list);
+	mutex_unlock(&jtag_mutex);
+	cdev_del(&jtag->cdev);
+	device_unregister(dev);
+	ida_simple_remove(&jtag_ida, jtag->id);
+}
+EXPORT_SYMBOL_GPL(jtag_unregister);
+
+static int __init jtag_init(void)
+{
+	int err;
+
+	err = alloc_chrdev_region(&jtag_devt, 0, 1, "jtag");
+	if (err)
+		return err;
+	return class_register(&jtag_class);
+}
+
+static void __exit jtag_exit(void)
+{
+	class_unregister(&jtag_class);
+}
+
+module_init(jtag_init);
+module_exit(jtag_exit);
+
+MODULE_AUTHOR("Oleksandr Shamray <oleksandrs@mellanox.com>");
+MODULE_DESCRIPTION("Generic jtag support");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/jtag.h b/include/linux/jtag.h
new file mode 100644
index 0000000..29c1076
--- /dev/null
+++ b/include/linux/jtag.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2017 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2017 Oleksandr Shamray <oleksandrs@mellanox.com>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the names of the copyright holders nor the names of its
+ *    contributors may be used to endorse or promote products derived from
+ *    this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __JTAG_H
+#define __JTAG_H
+
+#include <uapi/linux/jtag.h>
+
+struct jtag;
+/**
+ * struct jtag_ops - callbacks for jtag control functions:
+ *
+ * @freq_get: get frequency function. Filled by device driver
+ * @freq_set: set frequency function. Filled by device driver
+ * @status_get: set status function. Filled by device driver
+ * @idle: set JTAG to idle state function. Filled by device driver
+ * @xfer: send JTAG xfer function. Filled by device driver
+ */
+struct jtag_ops {
+	int (*freq_get)(struct jtag *jtag, unsigned long *freq);
+	int (*freq_set)(struct jtag *jtag, unsigned long freq);
+	int (*status_get)(struct jtag *jtag, enum jtag_endstate *state);
+	int (*idle)(struct jtag *jtag, struct jtag_run_test_idle *idle);
+	int (*xfer)(struct jtag *jtag, struct jtag_xfer *xfer);
+};
+
+void *jtag_priv(struct jtag *jtag);
+int jtag_register(struct jtag *jtag);
+void jtag_unregister(struct jtag *jtag);
+struct jtag *jtag_alloc(size_t priv_size, const struct jtag_ops *ops);
+void jtag_free(struct jtag *jtag);
+
+#endif /* __JTAG_H */
diff --git a/include/uapi/linux/jtag.h b/include/uapi/linux/jtag.h
new file mode 100644
index 0000000..70789ec
--- /dev/null
+++ b/include/uapi/linux/jtag.h
@@ -0,0 +1,133 @@
+/*
+ * Copyright (c) 2017 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2017 Oleksandr Shamray <oleksandrs@mellanox.com>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the names of the copyright holders nor the names of its
+ *    contributors may be used to endorse or promote products derived from
+ *    this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef __UAPI_LINUX_JTAG_H
+#define __UAPI_LINUX_JTAG_H
+
+/**
+ * enum jtag_xfer_mode:
+ *
+ * @JTAG_XFER_HW_MODE: hardware mode transfer
+ * @JTAG_XFER_SW_MODE: software mode transfer
+ */
+enum jtag_xfer_mode {
+	JTAG_XFER_HW_MODE,
+	JTAG_XFER_SW_MODE,
+};
+
+/**
+ * enum jtag_endstate:
+ *
+ * @JTAG_STATE_IDLE: JTAG state machine IDLE state
+ * @JTAG_STATE_PAUSEIR: JTAG state machine PAUSE_IR state
+ * @JTAG_STATE_PAUSEDR: JTAG state machine PAUSE_DR state
+ */
+enum jtag_endstate {
+	JTAG_STATE_IDLE,
+	JTAG_STATE_PAUSEIR,
+	JTAG_STATE_PAUSEDR,
+};
+
+/**
+ * enum jtag_xfer_type:
+ *
+ * @JTAG_SIR_XFER: SIR transfer
+ * @JTAG_SDR_XFER: SDR transfer
+ */
+enum jtag_xfer_type {
+	JTAG_SIR_XFER,
+	JTAG_SDR_XFER,
+};
+
+/**
+ * enum jtag_xfer_direction:
+ *
+ * @JTAG_READ_XFER: read transfer
+ * @JTAG_WRITE_XFER: write transfer
+ */
+enum jtag_xfer_direction {
+	JTAG_READ_XFER,
+	JTAG_WRITE_XFER,
+};
+
+/**
+ * struct jtag_run_test_idle - forces JTAG sm to
+ * RUN_TEST/IDLE state *
+ * @mode: access mode
+ * @reset: 0 - run IDEL/PAUSE from current state
+ *         1 - go trough TEST_LOGIC/RESET state before  IDEL/PAUSE
+ * @end: completion flag
+ * @tck: clock counter
+ *
+ * Structure represents interface to JTAG device for jtag idle
+ * execution.
+ */
+struct jtag_run_test_idle {
+	enum jtag_xfer_mode	mode;
+	unsigned char		reset;
+	enum jtag_endstate	endstate;
+	unsigned char		tck;
+};
+
+/**
+ * struct jtag_xfer - jtag xfer:
+ *
+ * @mode: access mode
+ * @type: transfer type
+ * @direction: xfer direction
+ * @length: xfer bits len
+ * @tdio : xfer data array
+ * @endir: xfer end state
+ *
+ * Structure represents interface to Aspeed JTAG device for jtag sdr xfer
+ * execution.
+ */
+struct jtag_xfer {
+	enum jtag_xfer_mode	mode;
+	enum jtag_xfer_type	type;
+	enum jtag_xfer_direction direction;
+	unsigned short		length;
+	char			*tdio;
+	enum jtag_endstate	endstate;
+};
+
+#define __JTAG_IOCTL_MAGIC	0xb2
+
+#define JTAG_IOCRUNTEST	_IOW(__JTAG_IOCTL_MAGIC, 0,\
+			     struct jtag_run_test_idle)
+#define JTAG_SIOCFREQ	_IOW(__JTAG_IOCTL_MAGIC, 1, unsigned int)
+#define JTAG_GIOCFREQ	_IOR(__JTAG_IOCTL_MAGIC, 2, unsigned int)
+#define JTAG_IOCXFER	_IOWR(__JTAG_IOCTL_MAGIC, 3, struct jtag_xfer)
+#define JTAG_GIOCSTATUS _IOWR(__JTAG_IOCTL_MAGIC, 4, enum jtag_endstate)
+
+#endif /* __UAPI_LINUX_JTAG_H */
-- 
1.7.1
