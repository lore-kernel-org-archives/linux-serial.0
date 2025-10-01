Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D03D6F;
	Wed,  1 Oct 2025 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314470; cv=none; b=EqJLvdKz2tXnfNpxIXosEz4AwINyPHsDDph/0c9rotzg3FV6LubKpY//kYe3KV+CTzjkIR0KshPueZtmGl1J8NiGlA6YwJ6Gjf6FV4bwYwjYjS9Ec/QnJ78KL1rijvXJUJ4oRaA3TvPYymqjnJ8KQTm8Mg4YIQKUR+cbfCS3tjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314470; c=relaxed/simple;
	bh=hOhbvOuB9xX15ewmHB0NCurTEP2o/mUQ2PvITYw/qc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q70QVsk+BThdJ8VEjid7GiZhwDxo978EmdWo7Aap8Gk6abCqMDFqr3Or+80b/Lx96PXEg10kzKVYFZRVtRi1avz2ivKCY3bSa/AXPTrf06qs8M+DN4ONiq0tAzw+KPLWQh4+NY0CxdI8kjbFjmAjfM6SvxbxkDr5KG/v6HVGpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3d47aae89eb111f08b9f7d2eb6caa7cf-20251001
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b2f3825a-54ff-447c-8974-0017c9e1af58,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:7063d4e6da54a6d2203a4296ff57f84a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3d47aae89eb111f08b9f7d2eb6caa7cf-20251001
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1312932590; Wed, 01 Oct 2025 18:27:32 +0800
From: pengyu <pengyu@kylinos.cn>
To: tj@kernel.org,
	jiangshanlai@gmail.com,
	oliver.sang@intel.com
Cc: changlianzhi@uniontech.com,
	dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	legion@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	mingo@kernel.org,
	myrrhperiwinkle@qtmlabs.xyz,
	oe-lkp@lists.linux.dev,
	pengyu@kylinos.cn,
	syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com,
	tglx@linutronix.de
Subject: [PATCH v2 1/2] workqueue: Add initialization macro for work items that disabled by default
Date: Wed,  1 Oct 2025 18:23:40 +0800
Message-Id: <20251001102341.600251-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202509301323.34d956e1-lkp@intel.com>
References: <202509301323.34d956e1-lkp@intel.com>
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

Signed-off-by: pengyu <pengyu@kylinos.cn>
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

