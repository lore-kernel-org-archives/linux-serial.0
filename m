Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD916429
	for <linux-serial@vger.kernel.org>; Wed,  6 Dec 2023 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP64B06h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB38DC433CC;
	Wed,  6 Dec 2023 07:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848254;
	bh=ZOGqEODNjCD+oZi+Lzwv9yxa5ZK3n1WxOSTSeSIxzG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uP64B06hW1cXeR4KmqperTlv+8Cbhb+QPK9aJZWuILPhSXIp8I6g9YhCgDy3+Th3l
	 kcy7sWXJL37DKi4EYGJNIRBEXef4eZOUAVu3MBvyN5B8/Q3kotIFl4Ww0l71gI1YfU
	 PNSgW5ff7MMcHXgtrzEdKHtHLBQ4SGOfg+EF71eb0dSLRVf11D9dLEekhjMMxfwnyG
	 7dMnZYMFI5xivBK04SjzC1fIJhDb58mvZQapm9QP1pnpATlhQ/ke3Pc0KlyiDlOXvb
	 v3Ta+tNfBThvVkUSwa9F5J/eHCbIpnDAGpI6gmwgamZfIih3gmgs6vO2o+OjpuX6Eh
	 AOVpKlwoSfi1Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Scott Branden <scott.branden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/27] tty: bcm: convert to u8 and size_t
Date: Wed,  6 Dec 2023 08:36:52 +0100
Message-ID: <20231206073712.17776-8-jirislaby@kernel.org>
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

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Scott Branden <scott.branden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/bcm-vk/bcm_vk_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
index 2bce835ca43e..59bab76ff0a9 100644
--- a/drivers/misc/bcm-vk/bcm_vk_tty.c
+++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
@@ -64,9 +64,9 @@ static void bcm_vk_tty_wq_handler(struct work_struct *work)
 	struct bcm_vk_tty *vktty;
 	int card_status;
 	int count;
-	unsigned char c;
 	int i;
 	int wr;
+	u8 c;
 
 	card_status = vkread32(vk, BAR_0, BAR_CARD_STATUS);
 	if (BCM_VK_INTF_IS_DOWN(card_status))
@@ -192,7 +192,7 @@ static ssize_t bcm_vk_tty_write(struct tty_struct *tty, const u8 *buffer,
 	int index;
 	struct bcm_vk *vk;
 	struct bcm_vk_tty *vktty;
-	int i;
+	size_t i;
 
 	index = tty->index;
 	vk = dev_get_drvdata(tty->dev);
-- 
2.43.0

