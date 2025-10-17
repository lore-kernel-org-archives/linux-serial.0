Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3F13B58B;
	Fri, 17 Oct 2025 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687831; cv=none; b=MQazmNR8rYGpkkuABMo6pZ2/+k+eP9mPc3B778WprDsNX6f6MTqfdZNc8b2LqJCsWZ4FkBrh6WJw/v4eJVfkiYUyNPzRCPTTJHUiyhS9x8jRAUDHY1NB1rqNpWxx9PFStw+CMKpvfHTfx2zws7tTxN82fTR85ZJERQh+9UpBzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687831; c=relaxed/simple;
	bh=T9V9+6+9nbG76trsipkPX6d2o1N96gvwsqNgwqnTbZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRqzBgpLfI6ZC+4djcEzNDDb0m31c3Pgk6nIZygfABWHWoSwenEGyL/Faru8W0SSIUxN82ry00WADf5e91nE+w50prjGbgVfXI8JMryGFEa4/85YLd02WcNsVg76UP5udONUyOc9kdla0QGNM9Bhe7ZzwZ9FNQfZAFAsjPls1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: db969f9aab2e11f0a38c85956e01ac42-20251017
X-CID-CACHE: Type:Local,Time:202510171554+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:105bdecb-3893-49a2-941b-865f2675d5a3,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:3c6bae45bb7855bd36bad98adcf3d041,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: db969f9aab2e11f0a38c85956e01ac42-20251017
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 916814478; Fri, 17 Oct 2025 15:56:58 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: tj@kernel.org
Cc: changlianzhi@uniontech.com,
	dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	jiangshanlai@gmail.com,
	jirislaby@kernel.org,
	legion@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	mingo@kernel.org,
	myrrhperiwinkle@qtmlabs.xyz,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	pengyu@kylinos.cn,
	syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com,
	tglx@linutronix.de
Subject: [PATCH v3 1/2] workqueue: Add initialization macro for work items that disabled by default
Date: Fri, 17 Oct 2025 15:56:54 +0800
Message-Id: <20251017075655.3781522-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aOVnoCnHa2vzB54g@slm.duckdns.org>
References: <aOVnoCnHa2vzB54g@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In certain scenarios, workqueue tasks that are disabled by default are
required. Similar to DECLARE_TASKLET_DISABLED, the DECLARE_WORK_DISABLED
macro is added to achieve this functionality.

Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 include/linux/workqueue.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 45d5dd470ff6..b6c72d59351b 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -102,6 +102,7 @@ enum wq_misc_consts {
 /* Convenience constants - of type 'unsigned long', not 'enum'! */
 #define WORK_OFFQ_BH		(1ul << WORK_OFFQ_BH_BIT)
 #define WORK_OFFQ_FLAG_MASK	(((1ul << WORK_OFFQ_FLAG_BITS) - 1) << WORK_OFFQ_FLAG_SHIFT)
+#define WORK_OFFQ_DISABLED	(1ul  << WORK_OFFQ_DISABLE_SHIFT)
 #define WORK_OFFQ_DISABLE_MASK	(((1ul << WORK_OFFQ_DISABLE_BITS) - 1) << WORK_OFFQ_DISABLE_SHIFT)
 #define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
 #define WORK_STRUCT_NO_POOL	(WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT)
@@ -110,6 +111,8 @@ enum wq_misc_consts {
 #define WORK_DATA_INIT()	ATOMIC_LONG_INIT((unsigned long)WORK_STRUCT_NO_POOL)
 #define WORK_DATA_STATIC_INIT()	\
 	ATOMIC_LONG_INIT((unsigned long)(WORK_STRUCT_NO_POOL | WORK_STRUCT_STATIC))
+#define WORK_DATA_DISABLED_INIT()	\
+		ATOMIC_LONG_INIT((unsigned long)(WORK_STRUCT_NO_POOL | WORK_STRUCT_STATIC | WORK_OFFQ_DISABLED))
 
 struct delayed_work {
 	struct work_struct work;
@@ -242,6 +245,13 @@ struct execute_work {
 	__WORK_INIT_LOCKDEP_MAP(#n, &(n))				\
 	}
 
+#define __WORK_DISABLED_INITIALIZER(n, f) {					\
+	.data = WORK_DATA_DISABLED_INIT(),				\
+	.entry	= { &(n).entry, &(n).entry },				\
+	.func = (f),							\
+	__WORK_INIT_LOCKDEP_MAP(#n, &(n))				\
+	}
+
 #define __DELAYED_WORK_INITIALIZER(n, f, tflags) {			\
 	.work = __WORK_INITIALIZER((n).work, (f)),			\
 	.timer = __TIMER_INITIALIZER(delayed_work_timer_fn,\
@@ -251,6 +261,9 @@ struct execute_work {
 #define DECLARE_WORK(n, f)						\
 	struct work_struct n = __WORK_INITIALIZER(n, f)
 
+#define DECLARE_WORK_DISABLED(n, f)						\
+	struct work_struct n = __WORK_DISABLED_INITIALIZER(n, f)
+
 #define DECLARE_DELAYED_WORK(n, f)					\
 	struct delayed_work n = __DELAYED_WORK_INITIALIZER(n, f, 0)
 
-- 
2.25.1

