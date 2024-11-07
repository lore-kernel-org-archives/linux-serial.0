Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8852B36D;
	Thu,  7 Nov 2024 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730950186; cv=none; b=dCqbF8cPWJoCLwMx2Q2vT06+VW8G3p9Bb4xQpKWgQlXnVio7eClIDIPPihpr8rfDUE9Tyz8HvILmRcIEhW/E6Ce73tgkeJlJmyB+tviV9rLuopg+7unfuXZCnLgfIqHTd3vEtdp8sWSXRqkKRhBObk2sE43G70OfARKmT14NVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730950186; c=relaxed/simple;
	bh=jW20b5t6LEdHJemnBMkozGR5UN2Que//7oILX1O12lE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mtKXuB8PsvMDnKMBYLCIVBpD9HryFfX4oe86a3sVTRkTUMPVdvnq9gLOPk1m/dW39ejOoYzNySvUSgMdsiP32NG8cqbk4us7Cd30PJm5yhKMuEjCGUKhO5wl8o361c5IIfT8PjyNdu12Ygoe2OJc8/0okqAkJNcZnM1IoSoL8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1672c341f039-b494b;
	Thu, 07 Nov 2024 11:29:38 +0800 (CST)
X-RM-TRANSID:2ee1672c341f039-b494b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea672c34204f8-4f262;
	Thu, 07 Nov 2024 11:29:38 +0800 (CST)
X-RM-TRANSID:2eea672c34204f8-4f262
From: liujing <liujing@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] tty: synclink_gt: Fix incorrect formatted output
Date: Thu,  7 Nov 2024 11:29:36 +0800
Message-Id: <20241107032936.2702-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the struct slgt_info structure, the type of info->tbuf_current
is unsigned int, so the output format is %u.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index bd8d92ee7c53..0c51c6c28080 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -519,7 +519,7 @@ static void trace_block(struct slgt_info *info, const char *data, int count, con
 static void dump_tbufs(struct slgt_info *info)
 {
 	int i;
-	printk("tbuf_current=%d\n", info->tbuf_current);
+	printk("tbuf_current=%u\n", info->tbuf_current);
 	for (i=0 ; i < info->tbuf_count ; i++) {
 		printk("%d: count=%04X status=%04X\n",
 			i, le16_to_cpu(info->tbufs[i].count), le16_to_cpu(info->tbufs[i].status));
-- 
2.27.0



