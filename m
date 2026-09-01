Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C53B2D0D;
	Tue,  1 Sep 2026 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263297; cv=none; b=fWCyrmRtcMHCFvz1DrOc9OuQzaIcWXF8vOUJ0yGSsktpWSOpWRhph7QR85oEGeILnPPJSwU8g4w+m0pCknAXLnXoifJv9sR8p9hAfs25ns3ymSFRMI9XhczfXAKokIys+6DaEI5xNPZAJGOwIIFUIHPe0RGN3h7o1+277yGfEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263297; c=relaxed/simple;
	bh=410HC93e64jgib+ETc43+ClSzuMYe4b7Onatn6ffXDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R89OSzHaJmZoKt0mJBghRoPGzk8DukIQLhZhBDV0UlNwsee7mqinuEBwFzXzJ+kblcYP6PcxGYhEqyVhU4sJoVbfBbhRSL05h7GPT31s5KkmOErvTe8HNA862+VhIiQdnKKeE1vJc5bBB5IWA5FfTk/MBsqpEdOhTwwOxUjM2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Popvjwet; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Popvjwet"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i+tyjzWVxzVpwb7pVxHOfAufko+RkuLyXqTjvntf9GU=;
	b=PopvjwetuCDxL+N2+uTwP9RWIUEs0OgtsGzyvJHRD4bzdzihO3Pu8e1J5j2FhwHFDqaxZGpXX
	HhwR/NwlmZEJ/MVAsZtf0NeUNXOLSteqtFdWrCGKAzix3N8Z7xh9JKs0JICc3N80gK0J3IdqhAK
	QlN7b+eSH/AerxLJQYy23uQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hZ3k00Y38z1cyPY;
	Tue,  1 Sep 2026 19:37:12 +0800 (CST)
Received: from whupemo200002.china.huawei.com (unknown [7.152.184.22])
	by mail.maildlp.com (Postfix) with ESMTPS id CF9DB4055B;
	Tue,  1 Sep 2026 19:48:00 +0800 (CST)
Received: from huawei.com (10.67.174.78) by whupemo200002.china.huawei.com
 (7.152.184.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 19:47:59 +0800
From: Yi Yang <yiyang13@huawei.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <kees@kernel.org>,
	<rppt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH] vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF
Date: Tue, 1 Sep 2026 11:31:31 +0000
Message-ID: <20260901113131.2760010-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemo200002.china.huawei.com (7.152.184.22)

The reload of 'vc' added by commit 8fb9ea65c9d1 ("vc_screen: reload load
of struct vc_data pointer in vcs_write() to avoid UAF") sits after the
'if (ret)' block, so the copy-failure break path exits the loop without
reloading vc. If the vc was kfree()'d via vc_port_destruct during the
unlocked copy_from_user() window, the post-loop
'if (written && vc) vcs_scr_updated(vc)' is reached with a stale
non-NULL vc. The '&& vc' guard from commit a287620312dc ("vc_screen:
fix null-ptr-deref in vcs_notifier() during concurrent vcs_write") only
handles the NULL case, not this stale-non-NULL case; vcs_notifier() then
reads param->vc->vc_num from freed memory:

  BUG: KASAN: slab-use-after-free in vcs_notifier+0x7c/0xd0
  Read of size 2 at addr ffff888007149190
  Call Trace:
   vcs_notifier+0x7c/0xd0
   atomic_notifier_call_chain+0x70/0xa0
   vcs_scr_updated+0x77/0xa0
   vcs_write+0x71b/0x7e0
  Allocated by task: vc_allocate -> con_install -> tty_open
  Freed by task: kfree <- vt_ioctl (VT_DISALLOCATE -> vc_port_destruct)

Move the reload to immediately after console_lock(), before 'if (ret)',
so every break path below passes a fresh vc to the post-loop
vcs_scr_updated().

Fixes: a287620312dc ("vc_screen: fix null-ptr-deref in vcs_notifier() during concurrent vcs_write")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 drivers/tty/vt/vc_screen.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index bf1502fd5bd4..79453abcf4d9 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -631,6 +631,18 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 		ret = copy_from_user(con_buf, buf, this_round);
 		console_lock();
 
+		/* The vc might have been freed or vcs_size might have changed
+		 * while we slept to grab the user buffer; recheck here, before
+		 * if (ret), so every break path below passes a fresh vc to the
+		 * post-loop vcs_scr_updated(). Return data written so far.
+		 */
+		vc = vcs_vc(inode, &viewed);
+		if (!vc) {
+			if (written)
+				break;
+			return -ENXIO;
+		}
+
 		if (ret) {
 			this_round -= ret;
 			if (!this_round) {
@@ -642,17 +654,6 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 				return -EFAULT;
 			}
 		}
-
-		/* The vc might have been freed or vcs_size might have changed
-		 * while we slept to grab the user buffer, so recheck.
-		 * Return data written up to now on failure.
-		 */
-		vc = vcs_vc(inode, &viewed);
-		if (!vc) {
-			if (written)
-				break;
-			return -ENXIO;
-		}
 		size = vcs_size(vc, attr, false);
 		if (size < 0) {
 			if (written)
-- 
2.25.1

