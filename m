Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1281286425;
	Thu,  4 Jun 2026 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554120; cv=none; b=H28ExCW+sX9I/IfGU4JSIJgyerqZcc6l2Txg7bQQxgyoqpSTUmujS0EuyhKW4fZZGgwyQ4N3TJWgNZLvfkzFzvWm5UHlJICOmTyvIuDHaNa3MoOuq5Uyuens3yF2blqr9JBahUXSAE9zbmNILXlM69ICAcq8EVkIpzIIQoMijpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554120; c=relaxed/simple;
	bh=d1i74/To1NVb7flSj1PBlNRwGL9scpc0CXe5cda+oLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sUPUhQGtxO4q68D5s9zYTPdWkduq1l77Aa7bnlEthgmrVOIH8z6zm/8G1RJHDwxz/lUSCdQFEQ9nANsQWY02aVkmWtXxHGsj0lpV8KceYt68P8SGD51fCgs9heV5CLyy4pWvuLuOUZLkV9U+lFVAWoYhtu4y3S7buKZBUk6/DPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=W2ROmoGD; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="W2ROmoGD"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MBj0dyJu3xz8/W3luO/kIb3XK+t/C4bIVaHH3xTQByw=;
	b=W2ROmoGDhdFi/OJknDZD/eq7cBvwXCto+GiWbtG928hyrY302rehuORhkTKeVPEpmku3TYF2x
	8nW+VoqbsYeqnBkR6ZY7Q+g1oDQYdHLszZJHAobpU6ZwDr13ELxmqeZKvVQ3Kc9HfkCb86JHoxS
	9fXxwKZSHtZvmrEq0451k4E=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gWDlv6YHRzcb1D;
	Thu,  4 Jun 2026 14:13:47 +0800 (CST)
Received: from kwepemk200016.china.huawei.com (unknown [7.202.194.82])
	by mail.maildlp.com (Postfix) with ESMTPS id C4D3440538;
	Thu,  4 Jun 2026 14:21:48 +0800 (CST)
Received: from huawei.com (10.67.174.78) by kwepemk200016.china.huawei.com
 (7.202.194.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Jun
 2026 14:21:48 +0800
From: Yi Yang <yiyang13@huawei.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <kees@kernel.org>,
	<linux@weissschuh.net>, <george.kennedy@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<lujialin4@huawei.com>, <yiyang13@huawei.com>
Subject: [PATCH] vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write
Date: Thu, 4 Jun 2026 06:07:34 +0000
Message-ID: <20260604060734.2914976-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200016.china.huawei.com (7.202.194.82)

A KASAN null-ptr-deref was observed in vcs_notifier():

BUG: KASAN: null-ptr-deref in vcs_notifier+0x98/0x130
Read of size 2 at addr qmp_cmd_name: qmp_capabilities, arguments: {}

The issue is a race condition in vcs_write(). When the console_lock is
temporarily dropped (to copy data from userspace), the vc_data pointer
obtained from vcs_vc() may become stale. After re-acquiring the lock,
vcs_vc() is called again to re-validate the pointer. If the vc has been
deallocated in the meantime, vcs_vc() returns NULL, and the while loop
breaks (with written > 0). However, after the loop, vcs_scr_updated(vc)
is still called with the now-NULL vc pointer, leading to a null pointer
dereference in the notifier chain (vcs_notifier dereferences param->vc).

Fix this by adding a NULL check for vc before calling vcs_scr_updated().

Fixes: 8fb9ea65c9d1 ("vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/tty/vt/vc_screen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 4d2d46c95fef..7d40eacc21b3 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -686,7 +686,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	}
 	*ppos += written;
 	ret = written;
-	if (written)
+	if (written && vc)
 		vcs_scr_updated(vc);
 
 	return ret;
-- 
2.25.1

