From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 05/24] serdev: Introduce modalias field
Date: Mon, 11 Jun 2018 13:52:21 +0200
Message-ID: <20180611115240.32606-6-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Name of the driver to use with this device, or an alias for that name,
or an alias for the part.
Required for hardware that is neither an of_node nor part of the ACPI
table.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 include/linux/serdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 62f1b085a794..bb3b9599c652 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -54,6 +54,7 @@ struct serdev_device {
 	const struct serdev_device_ops *ops;
 	struct completion write_comp;
 	struct mutex write_lock;
+	char modalias[SERDEV_NAME_SIZE];
 };
 
 static inline struct serdev_device *to_serdev_device(struct device *d)
-- 
2.17.1
