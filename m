Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421B21ABCD;
	Mon, 17 Mar 2025 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194875; cv=none; b=HGxL9bAYBKUWjyp8B2jaW8af5ZcLVMB514JGXSi4vep1Sbz/J+c4uQMQ4/nFTrQMqz+xJvEMBBRLUlYAFksNZ5NneJZUiYPj9DUMF7HrWh7gGgNid+6W+o7bRPbDLFsNF5sQ6M08UMTl02U3OqdkZ8jiE2SqV2JYakUNOvOtrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194875; c=relaxed/simple;
	bh=oqmCinDwG4nsNPhnUAmEMB1q3PmaAl9+aZ6ithpsXHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JH03l5rnNWIIiSJ3vnVnZj8e8hSRPLZ8ngDNOTfVZxaCjoDXoKRnKoemXv1AqL7ftRD9eOD1zTazT2g1tYYBY8HA+yhDMHJQrh69/U46LhaVjSiJVEfhLD8finCR63P7WYGokXknrcnkBE6DuRUoXdFA/U3bCsIQruV6e0FmWTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/E1JZv7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/E1JZv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B52C4CEE3;
	Mon, 17 Mar 2025 07:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194875;
	bh=oqmCinDwG4nsNPhnUAmEMB1q3PmaAl9+aZ6ithpsXHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/E1JZv753Gtwfph/GTpuXqNcGAyAO/j8q5grjPxMR4RcY/7v4ONU/Cg37COHzbU2
	 lMKLKHiRvcAlLa1Q/3RaNeVSWqY1bigLtopKrluR/c+2akbPvpU0VicSD0hDkolmPR
	 iOrMcx/TMVBaVIf2krNbIeYe+NqCHZShGDdBNL0SQHmcSSQOZTzbp4LotD6AA6ZHq5
	 DlI6Ym4acO/lunJXdKMJWx12gptji++KtlfBNFzFPYgshxOvDfSHHVA7tBaU0XC3sZ
	 wC77lC3gq2S86l0jm0iwd8+Ho7vavYJ4CTqXUJuLThJjxq2c46uz4oTSR3e1G/wLFV
	 csa2jubrwNyMQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 16/31] tty: serdev: drop serdev_controller_ops::write_room()
Date: Mon, 17 Mar 2025 08:00:31 +0100
Message-ID: <20250317070046.24386-17-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In particular, serdev_device_write_room() is not called, so the whole
serdev's write_room() can go.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/tty/serdev/core.c           | 11 -----------
 drivers/tty/serdev/serdev-ttyport.c |  9 ---------
 include/linux/serdev.h              |  6 ------
 3 files changed, 26 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index ebf0bbc2cff2..eb2a2e58fe78 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -316,17 +316,6 @@ void serdev_device_write_flush(struct serdev_device *serdev)
 }
 EXPORT_SYMBOL_GPL(serdev_device_write_flush);
 
-int serdev_device_write_room(struct serdev_device *serdev)
-{
-	struct serdev_controller *ctrl = serdev->ctrl;
-
-	if (!ctrl || !ctrl->ops->write_room)
-		return 0;
-
-	return serdev->ctrl->ops->write_room(ctrl);
-}
-EXPORT_SYMBOL_GPL(serdev_device_write_room);
-
 unsigned int serdev_device_set_baudrate(struct serdev_device *serdev, unsigned int speed)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 3d7ae7fa5018..bab1b143b8a6 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -92,14 +92,6 @@ static void ttyport_write_flush(struct serdev_controller *ctrl)
 	tty_driver_flush_buffer(tty);
 }
 
-static int ttyport_write_room(struct serdev_controller *ctrl)
-{
-	struct serport *serport = serdev_controller_get_drvdata(ctrl);
-	struct tty_struct *tty = serport->tty;
-
-	return tty_write_room(tty);
-}
-
 static int ttyport_open(struct serdev_controller *ctrl)
 {
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
@@ -259,7 +251,6 @@ static int ttyport_break_ctl(struct serdev_controller *ctrl, unsigned int break_
 static const struct serdev_controller_ops ctrl_ops = {
 	.write_buf = ttyport_write_buf,
 	.write_flush = ttyport_write_flush,
-	.write_room = ttyport_write_room,
 	.open = ttyport_open,
 	.close = ttyport_close,
 	.set_flow_control = ttyport_set_flow_control,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index ff78efc1f60d..34562eb99931 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -84,7 +84,6 @@ enum serdev_parity {
 struct serdev_controller_ops {
 	ssize_t (*write_buf)(struct serdev_controller *, const u8 *, size_t);
 	void (*write_flush)(struct serdev_controller *);
-	int (*write_room)(struct serdev_controller *);
 	int (*open)(struct serdev_controller *);
 	void (*close)(struct serdev_controller *);
 	void (*set_flow_control)(struct serdev_controller *, bool);
@@ -212,7 +211,6 @@ int serdev_device_break_ctl(struct serdev_device *serdev, int break_state);
 void serdev_device_write_wakeup(struct serdev_device *);
 ssize_t serdev_device_write(struct serdev_device *, const u8 *, size_t, long);
 void serdev_device_write_flush(struct serdev_device *);
-int serdev_device_write_room(struct serdev_device *);
 
 /*
  * serdev device driver functions
@@ -273,10 +271,6 @@ static inline ssize_t serdev_device_write(struct serdev_device *sdev,
 	return -ENODEV;
 }
 static inline void serdev_device_write_flush(struct serdev_device *sdev) {}
-static inline int serdev_device_write_room(struct serdev_device *sdev)
-{
-	return 0;
-}
 
 #define serdev_device_driver_register(x)
 #define serdev_device_driver_unregister(x)
-- 
2.49.0

