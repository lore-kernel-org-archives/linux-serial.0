Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E719066B;
	Thu,  4 Sep 2025 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953216; cv=none; b=h2oo8iD7T76Ih26f+E6YRoZVUVqG9yI4jGjOv4tDa8cM1N7m2IS3Rf49YZL/0fG/Wm9+O7yAjO8HRt9gJPAcrpmt7rfpBXTKTgwMi0YjrZqLU+KZZmYo6OR7/5wxhbzYjuprBNvX5JSrj3zyza9RfUpy501+7Hx4oGPAPebeJgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953216; c=relaxed/simple;
	bh=0FckEIwqaH1XS5zI7t+j848MUA+GCas6siktufN8cwU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SZDT60eFfTvO5n7a86xHgB4jdPGFezqixSZUcjNRngN83wNsrRRCiE9VZX/JB9e0bBENTFXaGuiVkew4DtApDSK0Jb0Dx88SWlpLwAtkKWNp6B1/ob5jZTB+ZleNzFlLewjwNag38S6F9yMRnS8ox2wXgapr+3IXaA3kO+3E9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cHNmf26WxztTSJ;
	Thu,  4 Sep 2025 10:32:34 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BE0F140132;
	Thu,  4 Sep 2025 10:33:30 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Sep
 2025 10:33:29 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<npitre@baylibre.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] vt: remove redundant check on vc_mode in con_font_set()
Date: Thu, 4 Sep 2025 10:33:45 +0800
Message-ID: <20250904023345.13731-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500016.china.huawei.com (7.185.36.197)

Previous commit edab558feba1 ("vt: sort out locking for font handling")
move the vc_mode check into console_lock protect, but forget to remove the
old check in con_font_set(). Just remove the redundant check.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 drivers/tty/vt/vt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 62049ceb34de..e4ae86d7da58 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4855,8 +4855,6 @@ static int con_font_set(struct vc_data *vc, const struct console_font_op *op)
 	int size;
 	unsigned int vpitch = op->op == KD_FONT_OP_SET_TALL ? op->height : 32;
 
-	if (vc->vc_mode != KD_TEXT)
-		return -EINVAL;
 	if (!op->data)
 		return -EINVAL;
 	if (op->charcount > max_font_glyphs)
-- 
2.33.0

