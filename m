Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660010A25
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRv3JCid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD35C433AB;
	Wed,  6 Dec 2023 07:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848283;
	bh=6MHA95AINcNO/MxuYgxxeekz4INpU176dtIrh3sOkVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRv3JCidGg5EOg+Z2d6SWS9vxRrW9F7rTAGnJ+a4Fs/YzgNgYiaRSyP9/KAzKCyJb
	 uF1U1wIcS3hGrXV4tWZvvyGyTYzRMuiw+AuT/dkyacgiAIloikP2ATJSGArGEbYr8F
	 d2nh+CeWDhLJi1lUz0cF+hyguRYAjX0YsNFPPfdYyjTJdnClTGqJy/JxyEWBcDStCi
	 LOFH7Np47LKbH04s+AUvandasooe0NkqRC+UEFNssByPwAsWk7Mi78TmsJt6r0cWBz
	 sMw2Tbp4aFTCm8F4WoksHCwIa6G2UF++2HwEOkPKHX9w6ibWhwj8ZQmgRAwxbkTHkB
	 m2Tpq796B4gfQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 22/27] tty: serdev: convert to u8 and size_t in serdev_controller_ops
Date: Wed,  6 Dec 2023 08:37:07 +0100
Message-ID: <20231206073712.17776-23-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

In this patch, only struct serdev_controller_ops hooks. The rest will
follow.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 2 +-
 include/linux/serdev.h              | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index c5381fe15e1c..e94e090cf0a1 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -74,7 +74,7 @@ static const struct tty_port_client_operations client_ops = {
  * Callback functions from the serdev core.
  */
 
-static int ttyport_write_buf(struct serdev_controller *ctrl, const unsigned char *data, size_t len)
+static ssize_t ttyport_write_buf(struct serdev_controller *ctrl, const u8 *data, size_t len)
 {
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
 	struct tty_struct *tty = serport->tty;
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 0ebf53bb254f..8cdab2c3b6d5 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -82,7 +82,7 @@ enum serdev_parity {
  * serdev controller structures
  */
 struct serdev_controller_ops {
-	int (*write_buf)(struct serdev_controller *, const unsigned char *, size_t);
+	ssize_t (*write_buf)(struct serdev_controller *, const u8 *, size_t);
 	void (*write_flush)(struct serdev_controller *);
 	int (*write_room)(struct serdev_controller *);
 	int (*open)(struct serdev_controller *);
@@ -185,9 +185,9 @@ static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl
 	serdev->ops->write_wakeup(serdev);
 }
 
-static inline int serdev_controller_receive_buf(struct serdev_controller *ctrl,
-					      const unsigned char *data,
-					      size_t count)
+static inline ssize_t serdev_controller_receive_buf(struct serdev_controller *ctrl,
+						    const u8 *data,
+						    size_t count)
 {
 	struct serdev_device *serdev = ctrl->serdev;
 
-- 
2.43.0

