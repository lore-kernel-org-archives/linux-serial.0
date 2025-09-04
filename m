Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B773C01;
	Thu,  4 Sep 2025 02:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954144; cv=none; b=S0UDu0+2p5+tVlsLwUsp18cti1UOMLEx6Q9aBrdpjJKwH6BztbWQA+c6/CPf8gn9IiJhndSL/5SUrpCikcdhD/Smec6jyEtIZjrPfiBcRwd+PIQGbRO6Cl2e4cq+jFZe140c+uezCsULNWGBK94K4oFsiHUkOkk3mZApDR16LD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954144; c=relaxed/simple;
	bh=e3bnh0cUUPgQ+9p447dFnwUN08OvIQ4v1sgxWtPlerA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HdHz5ebiigluJMmI9oBK57Nj7HQpecABSLHtrRJC8Do2E7zY/2RXjzJrY3VO9prV5KTMuROpMTiUaMWM+jwKhjTXhYZCc9bX4u2Ca8xl/RW4/iHZizIZbdASZBcDkH7xnwNA6FCLNAIJqqI+tcZ48eDuW1rOshhJ448Qjh1lUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cHP7Z6Fs1zKHMbK;
	Thu,  4 Sep 2025 10:48:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C4DAF1A0E81;
	Thu,  4 Sep 2025 10:48:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncY0Y_rho0tRIBQ--.8034S4;
	Thu, 04 Sep 2025 10:48:58 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	npitre@baylibre.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	yangerkun@huawei.com,
	wozizhi@huaweicloud.com
Subject: [PATCH -next] tty/vt: Add missing return value for VT_RESIZE in vt_ioctl()
Date: Thu,  4 Sep 2025 10:39:55 +0800
Message-Id: <20250904023955.3892120-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncY0Y_rho0tRIBQ--.8034S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XrW7tr1fCFy3WryDKFyUJrb_yoW3AFb_G3
	4xXw1xtw1kAa1Yqw10vr429rZIvw4v9Fn7Xr42qasxJ3y7Xw1xCr92vFyfJr1rJr48tFyk
	CFZ3Jr9Ikr47KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

In vt_ioctl(), the handler for VT_RESIZE always returns 0, which prevents
users from detecting errors. Add the missing return value so that errors
can be properly reported to users like vt_resizex().

Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
---
 drivers/tty/vt/vt_ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index c9f11c4bd9fe..28993a3d0acb 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -908,7 +908,9 @@ int vt_ioctl(struct tty_struct *tty,
 
 			if (vc) {
 				/* FIXME: review v tty lock */
-				__vc_resize(vc_cons[i].d, cc, ll, true);
+				ret = __vc_resize(vc_cons[i].d, cc, ll, true);
+				if (ret)
+					return ret;
 			}
 		}
 		break;
-- 
2.39.2

