Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733255;
	b=E1IJFAoveorBYPYXyVfTv1W/Vr7A1jtNSWBeBd/p6jQymb1o/9waG+t+WqMBbC6JZ8DD
	 dL7OS5IROehrQACCH76Izl82Fv2Xw5m4SVy1dGvyy9/7OoZP9ottq1qZ6jB10bQpDDBad
	 P7/XjmDaqdbuHJO4qCwuYkHJCF/PJ+jTURtbTsAo4B2XAWQRc3qkFvZZmwa+iOOAlyEJS
	 11u6rh9mslyFDyp3nqWw9i8VzILSEyMbg2l9keyzaO7R8nmU1ivzqufcxcATTFhRkaZps
	 0V4JxFVBUUCzklx/0GwF362lvW2+fcC7hqbzcz35n8T9JGhxn+BQ0rzv7x5S2HTioZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733255;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZvI+4nFpN3qtyujgG6pxLsHDOXRcs/QD5if2ojDqdPs=;
	b=N5Pv7QKklN1GOkCez6YH0eWDg0VzsJMWKP0D2+RcYXUbU8O88wtm6iC7o/a+gIObh0Js
	 7roceZNfqjFdPlVewkx+oFrkvLw+RbRIPfvgNL8YrHvGUwbZZ5WOeV492KixBC7VOFLZG
	 jPOMJUdKoOsW9WWnXKF508f66rKH2teWEbIlIGiXpZ/xZ7sTViylVK9t5kpMz334JyG7w
	 If92tk4IEuAnuAdWtui+Lro3CZrlGkFLLx8Fk1m8ZtFFk16weRR2uoFiFZvwxEByJ4ZFi
	 2+m1ejfWWiNlsJo1VZumZNVpfk+0UW9EOo5bTCT2Pq/zPIM+S6JEIrOmh8y5BP4y+bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b="f5MUU/Pj";
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EACF606A32A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EACF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=f5MUU/Pj
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8302F4013A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 05:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792733251;
	bh=ZvI+4nFpN3qtyujgG6pxLsHDOXRcs/QD5if2ojDqdPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=f5MUU/PjIytUcn28K4zlfezlXbccfh4342/njYhUV5bpOdQsTNHO8GUJYhda9mFOo
	 XhnCK6k7Dno5n5Q6YP6FRGoCoOWM0qKARMwpOlOM8sfBrdRaRJEV+DkFU+L/TPPjbf
	 LyAmWhQvjI+seivjM48eBjVjBTNUYDJBzpN0xorYJN+53gP5as5RMxqWVf1MGReXzT
	 zKChNY/GIi5C7oWANcEBJpcgd/ErhQkT4k4eDwgw5hOhYNzBCUN7g6ZSH8cTo0/x6l
	 i2lBykdffzLcF3773Q1IloXUU/lPHFMxnFQj+aq6pF5x0PL/3vzELeB9ddwA+EBPG1
	 wyE4CYR/ohzqcffCRWAJSCftaGqxj3LrdhNpyzDekH+ggUqrmkEpB7DDC6XGOM24v9
	 FjBBOsTyBGQCamqsK3EVLfzaR+z3Pl6H2AjnTAXcyVX1VP3FuAL5DLvX5XhXd7vwJB
	 GK0+XQAUcPCyJ5q/hZRhE/rqH+K2KMExQfmUBGa9yOvYDEJOj3Ra4c0od0ZRPHxvoA
	 q4xBhg7lkLk9budoPTQWXlH6O44eST/TOW9vUAZGigqXfcYsuSWzaeR7O4191isAqv
	 KcU6PgRaV6ofgM9TzRioW/4u2HjaCLPq6l1VQC0oxSO8oBn8uLQwvo7MLkLUTK4jDt
	 PQRV5a9Sf0/vD1UEgw1H5Fec=
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-313b1501a0aso73580eec.0
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 22:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792733250; x=1793338050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvI+4nFpN3qtyujgG6pxLsHDOXRcs/QD5if2ojDqdPs=;
        b=CSFI4C1XqJIKZHCVbgI6zlxD7I45NZXLgO28Q8VbKacUVuZrobDnGC046JRZhonM1w
         VAxTOunRRQiLAcfAtjDDNQdFeqxJQbbwfKYd+rOo8HIWyPX6yquNXYQcCUi5g4b4Ml4g
         46fnf6Usb0BO7etmicPKvcTH+7mF15VPGHbvDUvCuoBY/Diatfz/A5Yv+c1bK9N5bASS
         GxlVo/YV9e68lM4OvmyZovUmIibO6CMVNW8Li//AvhqAmiwmm6VK6Xeshce7cOP6HTuB
         lATrpsY2m35zzN0A/e4CDDsJ/ej361OsLoyHCc0uJtumklDJBQ7egfczi1Kgb9TH9U8n
         l/Fg==
X-Gm-Message-State: AFq9FYJbJiWRnfEduC7M9PbZM7cmKYZ0+pgI6YlaVTGCEC4g8OkpLtDZ
	1yhv3DvpM4PF7XHWBSXpOe+jyqdZLj1WwCkA4mUOFbKEnsP2cgeC9EvbBFA3QpnbliuBw7gVnFM
	tLikNRjde0YcsiAaF9oTmotF12qrQWLytVjGPhXcFdHCjUILW9WCd8vrkA+57hIX+yRs2aZjsED
	5Ggd40d1jLrT+uHg==
X-Gm-Gg: AYBFou2V/8/qqJ/ogHkeS+SeoPLyi1uQ/gF4xIyY56CVaf3PCW7uB8LUrFeKnv1hnIQ
	ysPab18e3UdPBvKi5i7XR5808Olawdad3/AiOYMIJmy4bi4BlKESLhALImQpZhpc38IEuGzNqfJ
	qjVSxT/lSaw+EvnqkV+bLhiY/RBFKumGVVi539XEyq8jgRGzOrNJrkGWpc4GHDxy3sgqqqG7oID
	kMznaDFrWJh3HVByuPuclfIz8zkJf7ImJDlG3/oOrNNQR80W0LZ6+9YGJ96ZnIaslxsrjrkGsPw
	Yu0EWnXugoBYA84PkKW7xNWIZQEz8WFS+p+sKugYZR8yND8/s3rSmviEgojaoDyHssz4enSW2f9
	PVaKyMrOMm2bpZ6w1oaNKoVRtPY1wIj/CXBOcUrm/+fE3SQd7UfxBU/xiU70i8qAawz3Yhm/dOE
	mXHKfuhITXIuJVKyUk5lWeXjfA6Y3iurmg6pr3C/usCyNPOeqmh55kqzrj8A7MRS5VFwJvDUxBl
	aL9CrlyW6/3NFoQiRb2UCouAc8bL44tyu7vOqMAgCc=
X-Received: by 2002:a05:693c:87d1:10b0:367:2bed:e7a5 with SMTP id 5a478bee46e88-369d978c94dmr2892088eec.2.1792733249669;
        Thu, 22 Oct 2026 22:27:29 -0700 (PDT)
X-Received: by 2002:a05:693c:87d1:10b0:367:2bed:e7a5 with SMTP id 5a478bee46e88-369d978c94dmr2892036eec.2.1792733249175;
        Thu, 22 Oct 2026 22:27:29 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-b47a-213f-cf99-45b4.dynamic-ip6.hinet.net. [2001:b011:2008:445c:b47a:213f:cf99:45b4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9e1a085sm3590098eec.29.2026.10.22.22.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:27:28 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: linux-serial@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	markus.probst@posteo.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com
Subject: [PATCH v3 1/3] serdev: handle devices without an ACPI or device tree node
Date: Fri, 23 Oct 2026 13:27:15 +0800
Message-Id: <20261023052717.2577234-2-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023052717.2577234-1-an.wu@canonical.com>
References: <20261023052717.2577234-1-an.wu@canonical.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Serdev clients instantiated by a driver have no ACPI companion and no
device tree node. Their modalias read returns -ENODEV, their add uevent
is suppressed, and they cannot be driver-matched, so creators force a
bind with device_driver_attach().

Resolve both TODOs in the serdev core by modelling matching on the SPI
bus: add a creator-set modalias to struct serdev_device and an id_table
to struct serdev_device_driver. ACPI and OF are still tried first;
clients without their own modalias keep returning -ENODEV. The device
name, derived from the controller, is unchanged.

Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
Changes in v3:
- Rename struct serdev_device::name to ::modalias; dev_name() is unchanged
- Model matching on the SPI bus: add struct serdev_device_id and
  id_table; drop driver->name matching
- Add serdev_device_set_modalias() helper and SERDEV_MODULE_PREFIX
- No MODULE_DEVICE_TABLE(serdev, ...) support: both in-tree firmware-less
  clients are created by the same module that provides their driver, so
  udev has nothing to autoload

Changes in v2:
- Instead of silently returning success with no modalias, use a
  creator-supplied name as a "serial:<name>" modalias fallback and as
  the matching key, so clients can bind through normal serdev matching

 MAINTAINERS                      |  1 +
 drivers/tty/serdev/core.c        | 54 ++++++++++++++++++++++++++++----
 include/linux/device-id/serdev.h | 16 ++++++++++
 include/linux/serdev.h           | 34 ++++++++++++++++++++
 4 files changed, 99 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/device-id/serdev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 917f3f72e31b..06e67aa5d9b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24905,6 +24905,7 @@ L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/serial.yaml
 F:	drivers/tty/serdev/
+F:	include/linux/device-id/serdev.h
 F:	include/linux/serdev.h
 F:	rust/helpers/serdev.c
 F:	rust/kernel/serdev.rs
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 7500efcdfc21..e178dc57d31b 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -29,13 +29,21 @@ static DEFINE_IDA(ctrl_ida);
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
+	const struct serdev_device *serdev = to_serdev_device(dev);
 	int len;
 
 	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
 
-	return of_device_modalias(dev, buf, PAGE_SIZE);
+	len = of_device_modalias(dev, buf, PAGE_SIZE);
+	if (len != -ENODEV)
+		return len;
+
+	if (!serdev->modalias[0])
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%s%s\n", SERDEV_MODULE_PREFIX, serdev->modalias);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -47,15 +55,22 @@ ATTRIBUTE_GROUPS(serdev_device);
 
 static int serdev_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
+	const struct serdev_device *serdev = to_serdev_device(dev);
 	int rc;
 
-	/* TODO: platform modalias */
-
 	rc = acpi_device_uevent_modalias(dev, env);
 	if (rc != -ENODEV)
 		return rc;
 
-	return of_device_uevent_modalias(dev, env);
+	rc = of_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
+	if (!serdev->modalias[0])
+		return -ENODEV;
+
+	return add_uevent_var(env, "MODALIAS=%s%s", SERDEV_MODULE_PREFIX,
+			      serdev->modalias);
 }
 
 static void serdev_device_release(struct device *dev)
@@ -86,16 +101,43 @@ static const struct device_type serdev_ctrl_type = {
 	.release	= serdev_ctrl_release,
 };
 
+static const struct serdev_device_id *serdev_match_id(const struct serdev_device_id *id,
+						      const char *modalias)
+{
+	if (!id || !modalias[0])
+		return NULL;
+
+	while (id->name[0]) {
+		if (!strcmp(modalias, id->name))
+			return id;
+		id++;
+	}
+
+	return NULL;
+}
+
 static int serdev_device_match(struct device *dev, const struct device_driver *drv)
 {
+	const struct serdev_device *serdev;
+
 	if (!is_serdev_device(dev))
 		return 0;
 
-	/* TODO: platform matching */
 	if (acpi_driver_match_device(dev, drv))
 		return 1;
 
-	return of_driver_match_device(dev, drv);
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	/*
+	 * Devices which are instantiated by a driver instead of by firmware
+	 * have no ACPI companion and no device tree node, match them by the
+	 * modalias their creator gave them.
+	 */
+	serdev = to_serdev_device(dev);
+
+	return !!serdev_match_id(to_serdev_device_driver(drv)->id_table,
+				 serdev->modalias);
 }
 
 /**
diff --git a/include/linux/device-id/serdev.h b/include/linux/device-id/serdev.h
new file mode 100644
index 000000000000..1c3b03b7d501
--- /dev/null
+++ b/include/linux/device-id/serdev.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_DEVICE_ID_SERDEV_H
+#define LINUX_DEVICE_ID_SERDEV_H
+
+/* serdev */
+
+/* Large enough to hold the KBUILD_MODNAME of any serdev client driver */
+#define SERDEV_NAME_SIZE	40
+#define SERDEV_MODULE_PREFIX	"serial:"
+
+struct serdev_device_id {
+	char name[SERDEV_NAME_SIZE];
+	unsigned long driver_data;	/* Data private to the driver */
+};
+
+#endif /* ifndef LINUX_DEVICE_ID_SERDEV_H */
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index b6c3d957ec15..9f91aa3e875d 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -7,7 +7,9 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/device-id/serdev.h>
 #include <linux/iopoll.h>
+#include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/termios.h>
 #include <linux/delay.h>
@@ -35,6 +37,10 @@ struct serdev_device_ops {
  * struct serdev_device - Basic representation of an serdev device
  * @dev:	Driver model representation of the device.
  * @nr:		Device number on serdev bus.
+ * @modalias:	Name of the driver to use with this device, or the alias
+ *		for it. Empty for devices enumerated from firmware, which
+ *		are identified through their ACPI companion or their device
+ *		tree node instead. See serdev_device_set_modalias().
  * @ctrl:	serdev controller managing this device.
  * @ops:	Device operations.
  * @write_comp:	Completion used by serdev_device_write() internally
@@ -43,6 +49,7 @@ struct serdev_device_ops {
 struct serdev_device {
 	struct device dev;
 	int nr;
+	char modalias[SERDEV_NAME_SIZE];
 	struct serdev_controller *ctrl;
 	const struct serdev_device_ops *ops;
 	struct completion write_comp;
@@ -58,12 +65,15 @@ struct serdev_device {
  * @probe:	binds this driver to a serdev device.
  * @remove:	unbinds this driver from the serdev device.
  * @shutdown:	shut down this serdev device.
+ * @id_table:	List of serdev devices supported by this driver, used to
+ *		match devices which are not enumerated from firmware.
  */
 struct serdev_device_driver {
 	struct device_driver driver;
 	int	(*probe)(struct serdev_device *);
 	void	(*remove)(struct serdev_device *);
 	void	(*shutdown)(struct serdev_device *);
+	const struct serdev_device_id *id_table;
 };
 
 #define to_serdev_device_driver(d) container_of_const(d, struct serdev_device_driver, driver)
@@ -135,6 +145,30 @@ static inline void serdev_device_set_client_ops(struct serdev_device *serdev,
 	serdev->ops = ops;
 }
 
+/**
+ * serdev_device_set_modalias() - set the modalias of a serdev device
+ * @serdev:	serdev device.
+ * @modalias:	non-empty modalias to use, typically KBUILD_MODNAME of the
+ *		client driver.
+ *
+ * A serdev device is identified by its ACPI companion, by its device tree
+ * node, or by a modalias set by its creator. Serdev devices which are
+ * instantiated by a driver rather than by firmware have neither of the
+ * former, so they must set a modalias before serdev_device_add() to be
+ * identifiable. Doing so reports a SERDEV_MODULE_PREFIX modalias to
+ * userspace and makes the device match an id_table entry of a serdev
+ * device driver.
+ *
+ * Devices enumerated from firmware have no modalias of their own and keep
+ * deriving their modalias and their driver match from firmware only. The
+ * device name is not affected either way.
+ */
+static inline void serdev_device_set_modalias(struct serdev_device *serdev,
+					      const char *modalias)
+{
+	strscpy(serdev->modalias, modalias);
+}
+
 static inline
 void *serdev_controller_get_drvdata(const struct serdev_controller *ctrl)
 {
-- 
2.34.1

