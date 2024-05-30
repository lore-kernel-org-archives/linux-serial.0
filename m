Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5867C12C;
	Thu, 30 May 2024 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055195; cv=fail; b=TSl5LExlK0bSMYwQQhj8veMjEpO2kmedqeQ/pZPQzMLeFc557d8Ly5UIJudEmhsCUOZQ5OJBgoQ39T7VKOiUT5sR98IeD3aVYzFnCHcnYSiIqD/2Qm7L9XZcLnaX33GiWe5RMwz26vJjflL8JJtjkJLPPdbUbse2mksH2MFmZdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055195; c=relaxed/simple;
	bh=KDMMOWlVlScvHt7yqYrCHtRSEPzHMzr1tdYYXZ7LDkI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vt7yEoB10nRTyVcyC0d+vQcJ0ku9CnAh04/63HRMZ7Zkn+kyeoPdsAk2xOcaSggzUx4thHru2FFyar3q40LiXhIJ1n/ZXoc/AoJCaXMFRaIY7TWGVUccGRgMqZ2GEd7UMvdvd1Rg3enYk3qfk83Lhq64/STWfJq98+uCCjhD7Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=lPyI9rXc; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="lPyI9rXc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JN1vuC+q/teutnU4pqvVe0h+Y/hg7GDXGOXuZ8ipr13rcYPd+aNjO4iFLiH2286xDAReIdFk8C4MQ/RCK8bDVYTQNHr5SHlcI2a/h2ScAy9wcE6duIN+zIfFRuTeqM5lTGUsDs4xUr9n0ysJ9neTmYYmfqGEs1NrobUkYLtsSvGrv0aECjeJf+nXaPASwHh1SafdGXFV66gQZoC4J749imf9cJcipM1peiTn66MOHeuoEQKlxvKdmP03RdMfP5LGGQaYDytbOkzts1xBjF9GfKDEwHkhwT6CNaElqCXf7hPDBPglLdjHwRvjiHSSeBmEJwdIhLO/iKzzSGS1PnuZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s49Eh1EHKfKxhlfsKv37iTG9tFLQ9xr8cVj8EXURdl0=;
 b=ZC59SNSsIM9JzIVMwNsHvU6OWP7AE5xIZzK9VXWxah6zA3SVoQchg22/JpTeq3FbtVn6+y24ysn7u+2MFhQKCNofqwl4QA6Pi5IuJ3Ns/roIT7kJ+MWwB/wIgeehK5yTii9XWxtAYkwko29bucQWRYT8hUuXj+JKBQxzLfRnRVnQ7RpVVEuPm0txwyvuEh8Gj4UItwzBKCiYujmX0vQHebGW/NjkXxiqmSEQPnvtiJKW2hAN8Z4D4A/bMJrdqSALWeTlhhu5MnQrafnpKUckR39jRaO+kdHfdjQGhCp78P7sjthuSME9g8Njf143xRftIPEjnzB1X308GvsnKJALUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s49Eh1EHKfKxhlfsKv37iTG9tFLQ9xr8cVj8EXURdl0=;
 b=lPyI9rXcn9wWw0Eqh4k4xhEPwx6HsFWPKkZLzv69lgJ8hWArT9qosqWvqmZBc/AofocSwk483Wy1Eltper3cWTq5yoRwQQvwqea/LX9p7X/dTeAxDY8+qcwaTtvNslZUS2gu7iBd5yYvjbav0WljyhXtynH0YyOX7GD4RODgBWw=
Received: from SA1P222CA0175.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::21)
 by PH7PR13MB5477.namprd13.prod.outlook.com (2603:10b6:510:138::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.10; Thu, 30 May
 2024 07:46:31 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::a1) by SA1P222CA0175.outlook.office365.com
 (2603:10b6:806:3c4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 07:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 07:46:30 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 44U7jnkq026155;
	Thu, 30 May 2024 15:46:12 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 44U7jmZs029077;
	Thu, 30 May 2024 15:45:48 +0800
Received: by mail.sony.com (Postfix, from userid 1001)
	id E8EAA1D8022B; Thu, 30 May 2024 13:15:47 +0530 (IST)
Date: Thu, 30 May 2024 13:15:47 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: pmladek@suse.com, john.ogness@linutronix.de, gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
        daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com
Subject: [PATCH] printk: Rename console_replay_all() and update context
Message-ID: <Zlguq/wU21Z8MqI4@sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH7PR13MB5477:EE_
X-MS-Office365-Filtering-Correlation-Id: 89485cf7-e80b-4bae-6815-08dc807c9f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2jyuc4o8mpqkJzDWY8bnMhAscIGKOuRaGLuHTxS5EAyIiJTa/in9E7ftp81c?=
 =?us-ascii?Q?yHWd/4V159UvC0vp5FfQ6rXXcduFYGjeX3BbZ/UZvEH0FrpKJP7zpdQEHM8t?=
 =?us-ascii?Q?I6DZFvZ5oFlH5+iFfqsU6ycVuuYWvghwl2rJi8t4g/DJR38GRuMluKimb+rI?=
 =?us-ascii?Q?CBmLnYfEPlRLJi6YsvUxm5YmbX2zVkcPvUcyUR4QHFPzJLjiXtvqdBYoSOSi?=
 =?us-ascii?Q?w8h7Pb7U4XzuThBS63b5hBnMkQRC78EXGj8ZcRaicertpOnCQDZDtz7YzSVx?=
 =?us-ascii?Q?ZvL+3olr9+8NuWeOfCEZg5Qwq89EMkPeJe7bnjhwDCJ6V7UqmXddLBvFKhuK?=
 =?us-ascii?Q?QlDqmwREyEUMCdV/CcRYsSqvPMbgq1tf+KMLue0hGjo/riuSadsVnZy/jif8?=
 =?us-ascii?Q?q9IIwtZ3k86uEgW6R0huyD4puwaIf9AooqzLzrFOwCuGGOSctxSGYxGY659f?=
 =?us-ascii?Q?RvJPYhGqMXB4E2WvB8IScqasWantpCSX8NuJZELFj0zYCYScV/BoGylIsw6K?=
 =?us-ascii?Q?08FLa7YSp1yTE39MAsKz92Qs8znNQtBEJvZghEQCJz5PZ+qmcI/p/ZGBQHWY?=
 =?us-ascii?Q?iBKqr4EkMyRFjTVjl9Qif6JO+cpLxfSLkcXnDnRNasLDXYWZllLjR9ioe+Rx?=
 =?us-ascii?Q?NwriivqTiWhOye77KZGCJUrGKCSDULx51mpODEXgvc5whflpbbMm0eEWAZaI?=
 =?us-ascii?Q?GMoXvKMk2QL39m7wUWrWl14i5tBt5uvqiDDcGm9OiLn/m/oLIyqyDHezyll9?=
 =?us-ascii?Q?JzwvqNY4gviEFGFNoJr0j5GtWMjavgcXMGsydRGVMATsCBxoY75im/A+HIzC?=
 =?us-ascii?Q?wLcmn+C12QVSHoJ4Sbo2Mt/2FCJqu5eKo1/zM1b30ppB27anyu3NQSwJwtep?=
 =?us-ascii?Q?xtCzndrUu8q2rOgZr/wSmeN62Z2M1n0rOBJFO4ToYPGzUaymJHBWiAd/JH/F?=
 =?us-ascii?Q?ubISN77ldoG3tkam778EEV/wGuxue+4UER58Jzo19nT0OxjIAWN+PoDrElJS?=
 =?us-ascii?Q?7wXGHUXC05viHa2qUPj/srG4vJ9cb0oJULLwyW3psfBSwvSNRj01q3T8+fqq?=
 =?us-ascii?Q?cmt7OD+SiAT6tORr2x+r0FNEw+5ox8iQ60aUnz/RqkUHlq+lOrmnFqNcTQ5X?=
 =?us-ascii?Q?KFKycBs4KB28EFDCSzaW9S5ExQ59Rf7jPp5NW9y7Zeivq4I3LCxB8JWvpMPn?=
 =?us-ascii?Q?SZOKUWfAKVWKGVzSahSPJnZIvzsXhaw4MB2EY1Pv5F4Ys6qWZVVkCv4ehNbK?=
 =?us-ascii?Q?8Gsgpwyl7d4gaUDT3DscXtKRwy969Piq7W7lNkwuwDE0gsRhyjbxSqxOUhAG?=
 =?us-ascii?Q?J0K/FH1YQhRnyuiOCQrYDt33Bn02AtX+R615WFBHRNn36BkLBCctYYRrfOBI?=
 =?us-ascii?Q?eAPYxE9RedMWWDRAGJM3IqIOrmdg?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 07:46:30.5361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89485cf7-e80b-4bae-6815-08dc807c9f0b
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5477

Rename console_replay_all() to console_try_replay_all() to make
clear that the implementation is best effort. Also, the function
should not be called in NMI context as it takes locks, so update
the comment in code.

Fixes: 693f75b91a91 ("printk: Add function to replay kernel log on consoles")
Fixes: 1b743485e27f ("tty/sysrq: Replay kernel log messages on consoles via sysrq")
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
---
 drivers/tty/sysrq.c    | 2 +-
 include/linux/printk.h | 4 ++--
 kernel/printk/printk.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index e5974b8239c9..53f8c2329c30 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -452,7 +452,7 @@ static const struct sysrq_key_op sysrq_unrt_op = {
 
 static void sysrq_handle_replay_logs(u8 key)
 {
-	console_replay_all();
+	console_try_replay_all();
 }
 static struct sysrq_key_op sysrq_replay_logs_op = {
 	.handler        = sysrq_handle_replay_logs,
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 40afab23881a..ca4c9271daf6 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -195,7 +195,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
-void console_replay_all(void);
+void console_try_replay_all(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -275,7 +275,7 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
-static inline void console_replay_all(void)
+static inline void console_try_replay_all(void)
 {
 }
 #endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 420fd310129d..ed003c06c335 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4314,15 +4314,15 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
 /**
- * console_replay_all - replay kernel log on consoles
+ * console_try_replay_all - try to replay kernel log on consoles
  *
  * Try to obtain lock on console subsystem and replay all
  * available records in printk buffer on the consoles.
  * Does nothing if lock is not obtained.
  *
- * Context: Any context.
+ * Context: Any, except for NMI.
  */
-void console_replay_all(void)
+void console_try_replay_all(void)
 {
 	if (console_trylock()) {
 		__console_rewind_all();
-- 
2.34.1

