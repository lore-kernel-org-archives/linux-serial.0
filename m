Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1A611E;
	Fri,  7 Jun 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760633; cv=fail; b=ZWfceUmS/fHDEf+3CHmuL1RFLxwdVUD+MTOUKQfkKTs1ermiLtkDun+ehKpPuyaFQgkFvxEBRep6Tkc5gVRrVkZ2WyyQGqCHx6lIFZR7Xl+l9dbz/TvxB0+gskTSDLGHBUFAPm9YvnhIaF8nn7k/VfGb7rnTyzbWZWjbtQlueCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760633; c=relaxed/simple;
	bh=1igrwFt6ytDlgszlF9K1/i71Tqkrho05Bhva59vy6cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k2rxD3dqBIJKpuDvrouktaWbFi6xNWqWOOII0Ti7yv2hl048N6kVKkheVfJe8pISxvUCzsHQbf/lRSvuOkI+lmpIDBGCPWbAI7JBVcePUHIkSiD7P3/GCV3jK0XSKvyUWiWQ9yYlHVXUJ0sq9x3jmWqb8Bpv05JdxBQCv0xvrUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=QLpW62LC; arc=fail smtp.client-ip=40.107.215.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="QLpW62LC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEPwxC2cnMQ+9UPXlYPeCLS3/r5XEwe4ZPpK1jahbrEKuGI2WU0X/c4azsHpBVyz/DsKdL5oGx7k4d2tiQxLXSyzQUozQM5btvzKYqXuIHbYL/bxc4atH4/QS51Ou42gnFl00VBjBQoaMrAj0dbuPrBSEHF7GPwC011TF8y9IgWSITzbX0p/UMjy7qyWLGAR6GINY4S0Gw15ImZk6Wglz8iH5fzAOGdItoBnuGOAa0kyurKVvuxGttRBqkEN9aJ8Imu5LdNzcKL1zgTqkHVVdhz7rxk/RjfojKAB+IOC2KUZfobxebj+zOVUCiSbqnDurqQYf0eWeqdt9m0CuTERlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsJK0HI7UA6YRyAT/LLGCLSXKg+kizIppe4YaZr3tAQ=;
 b=hVpzx6ecIISyOCj/PieosAaW40xf+gcYuDUJkDsxuY0+knU/butL1dHYno3+EdopogGoO1iSivZpTUIAijStUmLlQtrqQxCgIRkO+B4dYAd5r/iRhqmTO9WBBMNKE/W4BPD8M2DQxk5/QnrHNfuxkP/+ljCEACOZHyqkbL0MXwj3Np6+barjxyR7ZEVOaChRZ/iYqDUuWRc9v/aeq6dPNG2xhtf5pJhIYMWvPNXz+duDRhHwl4wk7VnFChM4BVHxj7tboszvySSr/kKJI7z5bZ7UW2KETex1Y6n25YiQxNMfBQoFwke9NRJhSudxpCAgEZ8wL0UVJxzGB8cyR9mtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsJK0HI7UA6YRyAT/LLGCLSXKg+kizIppe4YaZr3tAQ=;
 b=QLpW62LC14cpkTIsCR21ZX51woSuticKCFpPKwUKT3EtR1h3YoArHrzha7Di9P82DRPWBHytbSSCqreb4ccp2R7sNji+9sMnQxPiiPECJLagiLpkp2VeBAtA4y64I+N8bm50RJ0prNjYh9tSZ8goAjkg8N8k6QhWiRblVm1iot4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB5588.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 11:43:47 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 11:43:47 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 1/6] tty: serial: 8250: Fix the amount of ports doesn't match the device
Date: Fri,  7 Jun 2024 19:43:31 +0800
Message-Id: <20240607114336.4496-2-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB5588:EE_
X-MS-Office365-Filtering-Correlation-Id: 46277a71-6139-4222-dffb-08dc86e7175c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R56pBnWuQbsFYeeWBvws2HTKfeVxKLqDsLkKlw38iT3plgdmnkQVHFzIoPXw?=
 =?us-ascii?Q?T9QhjFe+eCK+fOf2fiBpkMgfRQo5bLBSJrNWnh+rctPbSxbSGMuLXP0jHeRn?=
 =?us-ascii?Q?RKFoSVb3vfKiP/ZIS7+a3vRAhXW3yK6/Ta31z2Q4pMRqaJrjGGKo8++lqPmg?=
 =?us-ascii?Q?G9Xk3Ey6qWmLyg1V88OKItQCH9gnJqo+4j0GJwPlx5/KLNUG5ST6qd8ax1tj?=
 =?us-ascii?Q?W8QU86XnPs63xpSknLPApIrYy/SpefgZralbnCoAPM+uY0vBF7tP9uqeDmL+?=
 =?us-ascii?Q?uERXHeaFwBzarWehO6Ah3PBJomEbYIe4qercfb4xeejl3lmYMxzthe8rmwZw?=
 =?us-ascii?Q?R9o8edVVwFGXXq1FZ76Dwo+vQjcM4TfrdFs6qNynte0YEa6QIGngd/Icnbfi?=
 =?us-ascii?Q?0C4QygfJpUQIFtWgMiTCxEkkzGPT8P1VTx+4SdGKpuF9+Vqhq/FWSY94yCD+?=
 =?us-ascii?Q?CxDNovwrVuM6Ydxg0mpTLQGKOzBKCQM7c3KeKh390oQRoHQyGYprPUuNt1QO?=
 =?us-ascii?Q?xYZx3dPW5WM4r96WzBpiI0Z9qitwA4Na0g5XZtAA2ENZWgbZQ0RA2mb5Mir5?=
 =?us-ascii?Q?LHrDfrYLLarZbWMs7JJEL6pEEyYuiXuOp+HEBIwBMjI2zzObiRMwThn2gwOP?=
 =?us-ascii?Q?S29BV5dmOfvauBB5ypxGIO1XwDO2YV9dPTsQK5VhCuvVT6Zczr/tPx4paOnc?=
 =?us-ascii?Q?RgZ5qFx7KwUIg/LSIK4tJ6VWg64drwDdtUytUVccgWyZxR0GO8KEqgnFAgS2?=
 =?us-ascii?Q?dHAFMJOM8Dzfoat11FmG2oMgCTMMlCCeRBcbxwhYkQ7TkfpziVosJUahi/ak?=
 =?us-ascii?Q?BzPgNVzGNI8nksUlj6PKwvNK68YRyi9tGnCp/qGV72RpjS6QV2vp7iqLKipP?=
 =?us-ascii?Q?f2Q7nQTzi08KyzVHKgfKoYFtIKXNKZ/wnQJfAeqySP/iq/OftZln9MiGuzcG?=
 =?us-ascii?Q?0e4qjMUa4UfpF/+wHzY2x21bv/lqeU65uy0M9saLUltAbc1BkkQwRXNbFunM?=
 =?us-ascii?Q?JTwpz3MF8frWVCeZip0tVCMnHmfZLb6gXcSwLJXl8NBRrhSuVvVNVLDi4JU+?=
 =?us-ascii?Q?rWUzB3K2jcyVM86wGDkjcCdFts2HF6fZZsFvZieKa3fRc7RpPrJwJjM9omwf?=
 =?us-ascii?Q?AueiW3zqNgWjjataydkaQYUZd9bsEbmmM+HxY9WjkYPqUT+GfA4dIT2iELvV?=
 =?us-ascii?Q?1vjvnjJwCTJ2ILctKTKxZodN0ju3P6fjpVVXhMRXyVUbLaRFaJTkerl56FKQ?=
 =?us-ascii?Q?CWMS+v/pTl935JfG2x9Kh239gGeB1P9+MJpRhzg2CMgwV4yYiXKuMNaNdjX0?=
 =?us-ascii?Q?Vg4EVkhTx3DFvL9BXxcFKHh5aH2KTqWL5+kGPdAcnTV+a0eLln3bcKRkaRz9?=
 =?us-ascii?Q?/7lwLgI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oPUe7fpOKwu6TrXWVAs+7QM0IBzLejU0WTJOZ9pWP16ZQC7f7V5LPbDbD4Iq?=
 =?us-ascii?Q?rbfAvwfNKWrYyGDoEtaSfdyHcjPu/NIM2b1iT/kxYbKzfAmS+w1tEEKKOZBR?=
 =?us-ascii?Q?FMQi1yGH4ceHP/F5wQa+LTim5q8b76B6ETX5kUuhr0oxvwTT7Kmh0L1g62ve?=
 =?us-ascii?Q?a3cg8NoZGfkWdqePqJhdV46eeIr4hkxIIBn5K/mMuJ2P9Qs6CY+PqO/5rBXX?=
 =?us-ascii?Q?0+J5PP5AwWl82Tg4Pf6NFT+06f9TevHzGS0QMDgNhl8WSm12K/0FoR0ONoSC?=
 =?us-ascii?Q?xvaDc604lnjOscZpDueFXXyhoG+UfvB/RvsP2Y2Wwf8rRa3R1kTmuLGWelKB?=
 =?us-ascii?Q?lwHN/PdsGyScwf01LmiE89wJuKNz7PaknXXuSGF3YwRk0G+Abssnwquv1t1K?=
 =?us-ascii?Q?/Vt9iGRk+gkaqfFpcKdRa6lxIftDqBcsYfzG7jLc5lc3N6N4OGZAkxXQen1u?=
 =?us-ascii?Q?iIUqpf3Xydd9UA5Sn6XKTLrp6QX9KCa+5+J/cMYpDW86+nv3edtZGEExV+GY?=
 =?us-ascii?Q?JTq390TZTB2H7eoFmtXUWbJg3fdhw+UrNnQat+uf4MoQ0oERcpQqz9pvfeWn?=
 =?us-ascii?Q?mVs141LNoomx1JH7nDVXoqIKGFKv4WmaJUcb21rPWAVCeJXz/P1m5qKSaZlw?=
 =?us-ascii?Q?49JU8xIGDXFxrrRy6gYmWkxw02M/T8srWp5X3XJMAu57JMhEO/IR46QFMmYl?=
 =?us-ascii?Q?iFual0SjbIKi6zCzHOcj9c9CRxI6CJkS2Auata2KnS8YGMqtzl/JWoMnR8nr?=
 =?us-ascii?Q?VrtVbQPTAPXjHD15z5DnLhNIcWPytplqh1aYIulemMJ8Cvba49XbBwI1cej4?=
 =?us-ascii?Q?o/6OzqFfZ4ndLsdpENvFIAVuw0jChSq1wtwr59DVv2LbcQoxTcjzp6FJOQm8?=
 =?us-ascii?Q?hPaHqYEqNlSKRWUuaaklW9ukBTe+V2INDestfxGHujm6GouzuaulT2WPGB/S?=
 =?us-ascii?Q?gNudv4elqpI+UqBwjtXhWLZJwRRdNFCHRkazLodF8s2F8mcQPjw0i9KhJN1N?=
 =?us-ascii?Q?jjLchyRD6sU3sTEiOEsDwprJHIiPOlQfhrKi9M3YP/W1ItjTeyi0Iu3PtY7O?=
 =?us-ascii?Q?TD8Kaag/T1BM2XcXVlVB5Rni2iV/fiSQB9PXyVbjnj4hP2OFY1mcxNgxpYSy?=
 =?us-ascii?Q?Y9D+q1nRe+1mExIu103mDV34x7BWjLQfm3797ltsoqe8vs7jBENwpqO0tdjT?=
 =?us-ascii?Q?p0VBun4j+gb4tP+3Jbds8lKIAUYxWVOBB+6yNMcYHHPTnEwDE9uzTn91CGLi?=
 =?us-ascii?Q?d9msngYqLoX6AL9zsPVp+MV7p5+CPZ3us/HMa3rOZzaLm/lSfmDVsRELh6cU?=
 =?us-ascii?Q?5oRH1EZQgCobH8KL+aJtY2Mo1xvl12iCjsEkvDplyG281vQT97kMXPsHcNuU?=
 =?us-ascii?Q?YrHoYW7BXU88IKVFKhDMdVf9IdPUikXr2y4uF/ijduogR4N7+A+75YSuMakd?=
 =?us-ascii?Q?G6mierGfB8r/kc/ATN+kNBb311RmY5ldeBFr5LoQrFkh6SLbduYsCwuihQxx?=
 =?us-ascii?Q?BPtA6BVuNSIM3rYDTla9pD1hp10EOV/57RKZ8YGJwaLsY+N4t0bIi6SJ8n7h?=
 =?us-ascii?Q?grLBD8U495TDGMdxE0Du656suM36wmvAG59vxpSDCErCKwcHlSwZ2UKv3PrE?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46277a71-6139-4222-dffb-08dc86e7175c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:43:46.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnE0UcKqchKAGyeBKdqronT+miRbOkDP7JROQJ9qYhmRUtftWTtA5yNNiBNUep5DZMWpB2fGx05Z+QVtP0BiXks2e+5pdi6OYGa8fYLVmrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5588

Normally, the amount of ports is written at the third digit of device ID
of Moxa PCI boards, for example: `0x1121` indicates a 2 ports device.

However, `CP116E_A_A` and `CP116E_A_B` are two exceptions, which has 8
ports but the third digit of device ID is `6`.

This patch fixes the issue above by adding checks.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 40af74b55933..4e88ee07e548 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2041,6 +2041,10 @@ static int pci_moxa_init(struct pci_dev *dev)
 	unsigned int num_ports = (device & 0x00F0) >> 4, i;
 	u8 val, init_mode = MOXA_RS232;
 
+	if (device == PCI_DEVICE_ID_MOXA_CP116E_A_A ||
+	    device == PCI_DEVICE_ID_MOXA_CP116E_A_B)
+		num_ports = 8;
+
 	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
 		init_mode = MOXA_RS422;
 	}
-- 
2.34.1

