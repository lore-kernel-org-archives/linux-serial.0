Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72511531C8;
	Mon, 17 Nov 2025 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763350725; cv=none; b=OnPlxvyjbkH3WtuexiSxS3TIhGShHbsOuDzLwNa6P8Qui6UJlDu6hbKi0s2fSXLsKRkmFjkjfmc6FuDJdotbup9A81Oyxivy0DC4qDZ+B4aAhkwKmngeohr8xY0Xn6aOtvy+Gx/YGzSq35L7eG0NC+1fTfc2+sIfvQ3HuccKV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763350725; c=relaxed/simple;
	bh=6clw4LVmMs7Kgixus+6ZwFy88Y0oXckvXkDkNbGO8vI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=srBupcHQPrzzOmsBvsKuYCd07MAawBUwLo6/rHKEZk36zhR1Y9E95Mza0wKWq8waW9dK8lqoXs7hmjZfvS4M6SRi+BxyWXWgJ+TU/opFa5mZPbVVp2dhrLFyGVIDBsXlM7QxD5L2PpMlDZNpRmqrLwi1Ynas77f5ZD2a57JcIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NqmHbVSc; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NqmHbVSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GO
	VMNZP75w86KogEWw/Vr4Wf+H+2e+YDtXaPOdssx6M=; b=NqmHbVSc41EbxpQtW7
	v0lZ91TCQasPOAIdeM9wMbAFhVV6ouUYy57Cfv6krl9T+EjTW1H9WnY+AXfMwVOp
	MPg+/5CNy/7Pv9LZcDS7zTs8J+/D8hwwyRf5eGKzTZh6DyvoLhDAPP4mJMghFU+Z
	X2NS4NjSuxlon94VQjmZe+iwc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBH34SmmBppRsMXAw--.24328S2;
	Mon, 17 Nov 2025 11:38:15 +0800 (CST)
From: "jempty.liang" <imntjempty@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	"jempty.liang" <imntjempty@163.com>
Subject: [PATCH] ALSA: core: Fix style issues in sound/core/device.c
Date: Mon, 17 Nov 2025 03:38:07 +0000
Message-Id: <20251117033807.55512-1-imntjempty@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH34SmmBppRsMXAw--.24328S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1UKFy3Kw13Gw1ftrW5Wrg_yoW8Gw4kpr
	4kGa47KFW5Gr17u3WjvanFgr43Wr12yanYv3yfJw17Kr1rCryFyrW0yFy5Aw45G3y5CFWU
	ZrWayr40k3y3Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFXd8UUUUU=
X-CM-SenderInfo: hlpq3yxhps35i6rwjhhfrp/1tbiFBcJAWkakoyhUQAAsW

This patch fixes blank line and trailing whitespace issues in
sound/core/device.c as reported by checkpatch.pl.

Signed-off-by: jempty.liang <imntjempty@163.com>
---
 sound/core/device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/core/device.c b/sound/core/device.c
index cdc5af526739..207dbc8c3242 100644
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -47,6 +47,7 @@ int snd_device_new(struct snd_card *card, enum snd_device_type type,
 	/* insert the entry in an incrementally sorted list */
 	list_for_each_prev(p, &card->devices) {
 		struct snd_device *pdev = list_entry(p, struct snd_device, list);
+
 		if ((unsigned int)pdev->type <= (unsigned int)type)
 			break;
 	}
@@ -130,7 +131,7 @@ EXPORT_SYMBOL_GPL(snd_device_disconnect);
 void snd_device_free(struct snd_card *card, void *device_data)
 {
 	struct snd_device *dev;
-	
+
 	if (snd_BUG_ON(!card || !device_data))
 		return;
 	dev = look_for_dev(card, device_data);
@@ -147,6 +148,7 @@ static int __snd_device_register(struct snd_device *dev)
 	if (dev->state == SNDRV_DEV_BUILD) {
 		if (dev->ops->dev_register) {
 			int err = dev->ops->dev_register(dev);
+
 			if (err < 0)
 				return err;
 		}
@@ -190,7 +192,7 @@ int snd_device_register_all(struct snd_card *card)
 {
 	struct snd_device *dev;
 	int err;
-	
+
 	if (snd_BUG_ON(!card))
 		return -ENXIO;
 	list_for_each_entry(dev, &card->devices, list) {
-- 
2.25.1

