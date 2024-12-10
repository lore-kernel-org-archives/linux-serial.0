Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBF225A2A;
	Tue, 10 Dec 2024 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873855; cv=fail; b=EEAa+UsvwdbRi9u8GGPKcfDuv2Y9E1JA68kQ8qNaX8SpVGKpPnqlTbVqo42Nu6NAoR/7KJppHiKa4e93o8uhmMGeSZwQVfXvQmeEaP7J3tm4D2G9JbqK4bk63SkbM5B4IYbfdfHBQECtG1uEJ3kPW/bKngXsidRA5JZ8bvsrV2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873855; c=relaxed/simple;
	bh=4b2FYWcZH/9j2f/0CF1IvDGO5jhHfaDTDgraPYfKRFM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K9odjXi3FuY8bkHRJZadjKU68oI9tpT236yjhWP3uixTZcZF9velX1kgBdx15Hi+LpqGm1GOcdYyKYTsAj6yCz+EmKUKuYm0flIe2bt16Hxq4kh6GdeWrZdDtzkHXEnPhj7PZl1NWmYb8gsMD0QGCEtyrQgcAJNPJhPH5P6xHS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAHhb3u005554;
	Tue, 10 Dec 2024 23:36:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3kgnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 23:36:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqdbMJnHco1rGsOw65WrKWo+llH84eCX7GEgUDNbgqrR4A+rDP/KmpstwxBoTfPNXlO0PI5HTdyDA1jszrqdCzCPtFQ0OuXsMRC+7+VeeHfViRGXlz8TeS+KH+qGXX9vbNRCdY842MbvyviBrhCXLMroDPs8M3QMqdbfoiuSRuQC8TyLtZHJCjdqsn4jOyX4vKGRLXtQeezZtH25jgaCtAR5TI2FSPtvts7D4ZqwkjGE4yHf2dDPUKMg7EeCiRp5+kbTTwIj+miObTfsty64rt8fr7sA8k9y858iR/WcOnBLmM563DfKyrrDOHOGfoGn9Iu7WU/DRxWMY7yVWnSn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1E0+uIMwr90c6wyu3dMpH/74kw0d7Pg4ChP3iwymAI=;
 b=c5wMwtGfd6uom7Uujhm/6DqfHR2gSJhkY7A573Mp7Z7e08qnSkn4aIebSaTTYIHuZfHHWyFEKHkFpScvcQuqAxTmHdq4EXH/pE5hBCNWWZypKC4YSHEj0zQ/IH5QohGfafzI8ANa685JOCa8uumxGPH+vRXw3BQY/ueDlzbeAc49O11gQnymbmbzP5CIzbqACrNjwebymqvC/sf0RcdWvcrYst12PzcENcj5oj+lAb8DTIBilvSlxPzn6SfbEZl7oRvQYI2zejVka9UNtxHExxQOwP7GL7jEs4l2BhWhn20kL3bzVpIS/I+vqZiA2QnB5bQBoHAvIq0gnYi3YViphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by CH0PR11MB5284.namprd11.prod.outlook.com (2603:10b6:610:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 23:36:35 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%7]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 23:36:35 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: l.stach@pengutronix.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, esben@geanix.com, marex@denx.de,
        ilpo.jarvinen@linux.intel.com, linux@rasmusvillemoes.dk,
        stefan.eichenberger@toradex.com, l.sanfilippo@kunbus.com,
        cniedermaier@dh-electronics.com, rickaran@axis.com,
        xiaolei.wang@windriver.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] serial: imx: Use uart_port_lock_irq() instead of uart_port_lock()
Date: Wed, 11 Dec 2024 07:36:13 +0800
Message-Id: <20241210233613.2881264-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|CH0PR11MB5284:EE_
X-MS-Office365-Filtering-Correlation-Id: e55a7377-2e87-4ca7-ea99-08dd19737c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|52116014|1800799024|38350700014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BDQg1l12bBJs9E0F+0hAS6E/toJwFFAOAGPOCW6z3bB+8SFHe+Vb1wsCFs8A?=
 =?us-ascii?Q?FcFXn9Ue1IzZ1U+RaDce6tSopa5V3XJX0/ftf+/hOdivrIbvZZD5zDOQ70eV?=
 =?us-ascii?Q?C232xn1/ieu0ZDeUaPp4j5DGvXAWVEKWulKW4rYaE68GqIoI0+qoOLvigDvL?=
 =?us-ascii?Q?IwIbXhWCeN7IkcqxHBv9rJA0DNNcv2NYo4IXuuUfUNPjpPJvoAdG7/f10BBr?=
 =?us-ascii?Q?O94en288D+Xld1IdgEJds+G4O0OxC7iUflgYCva//z9pLKDPNiJixq7JPwZV?=
 =?us-ascii?Q?F+pAHoo954WuhlmEtAIsBJbryiNJY1d9avYNNwa3RIUDOm5T4vRAk5+ppbj7?=
 =?us-ascii?Q?8Df76bgoQ5wAQs9KSPQuuIzilvgB+IYWisbllgResOBDli/FsOi9z60btW6m?=
 =?us-ascii?Q?UVTVJF5nQHYFiIfSNuk++AQK3omoH3qwJ6T5ISD02xpj1/S7g+SzdERHTb1p?=
 =?us-ascii?Q?zCP+auCRbvuKg2bhNTot0DtGbMEgy8igjKxOXMerEvci5yOnZhWyfw/h6bHV?=
 =?us-ascii?Q?lRZsvK3Dy1DwsTxPwomqRutv7sQEBwteXGJlIhmLxjZmg8NF2w6I4TGh93X/?=
 =?us-ascii?Q?BvDYwnaS0clsOqvOtelPccGYz23x38o2MNJhPy9zyAtEx0eQ8ekofPG4PxLT?=
 =?us-ascii?Q?q/3nlYRIg3g/PovcT5+7AA2QbVwSj45Hrsk5Zyd+YRs+ib7xTtHdTUk7fub3?=
 =?us-ascii?Q?pbmB1sih1vAIk9MuvQabnr4kiTOgjiEvIi0IypKDQhSPYGe2qQNIfZ+hy4ue?=
 =?us-ascii?Q?HcMyALzF3AJeTLcMlcG1gFRuZ9bH9/SIjemMWpJrPbLt5DrrdU7VUevMGDWm?=
 =?us-ascii?Q?btU26gp4Y6/c09aVeNWgtUph60WwasAAWx49uhESYZbplsOgdok6fM7sfZTY?=
 =?us-ascii?Q?x+5s9Q+ZkKcrwAd/o78D3aVshUHySpCiyLxPLXDneFZlWGLOiXRIuKYY+Nv0?=
 =?us-ascii?Q?9IPqqK35IvX9wjrpBa+HT5WMlN19j2KORPmsSqpagg3GufjdhunPST2YMvOp?=
 =?us-ascii?Q?N7UE5xSS1glGKG/EoA9zaJan9mx0hwFfgNANA1YfZJeBryncfVn6UdiI0MZt?=
 =?us-ascii?Q?dow1utEc+obmjm0hyuN2PyHLc8Y2uQd7DBhCjxW8SfsV0v+BwH6Z+mjtgNY6?=
 =?us-ascii?Q?8rDrNcLwJkRUBaRLAKsKZFqT870UPRmYgJ8NVDlxfthD+Yfb0g6xv5dx8taX?=
 =?us-ascii?Q?fEx5+PmzSs4oYHoeKPe/CdZOn2V17oukt9NOxac3QwIFkyp3CYJj/CEoqqxz?=
 =?us-ascii?Q?P2Zd6oD7pHNv7cxbzlx+Cz5chCn8wnpINTmBC/sl/HS8Fqi8LD4IByriFiC4?=
 =?us-ascii?Q?2lu/Tjg1dutfpRjrl/9rpnXp2ENkjduPswK4Ffq3Wz/v80R6oXeQx9LBIySl?=
 =?us-ascii?Q?A7gaLPyQEetpFuNU6y4tWUgH8d6IWYw2PICN7xIM1SmWzB0DvV9LnebES1WZ?=
 =?us-ascii?Q?FL/kCGX2CAM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gcXFon8SUKe31bHxMW9hp9JradQWd/KQQ9bUGfpjczVqq/jFLGBrWT3dMqvZ?=
 =?us-ascii?Q?vFOsqMgw9b5iSiazoFb6IMCU6E/11e8WUjLbln953Skqyc8Ap6KxhpYDjqJl?=
 =?us-ascii?Q?7i6PQZln1NBTfCjQZ0K3ziGCA3fU5FzMmY8wQO3r/8RTQHYIuLzEIevb53Y5?=
 =?us-ascii?Q?LPZBtjNIc4l08pv0tHUgj7doxeC7owU6rR/XbYv6uePMWvTFLCXLeW6aPx5U?=
 =?us-ascii?Q?qVRhiXXeyzsp/eDtnOD4396c96Kv1lrrQDZWq22oMWMhmTFDIZacaO09QUrv?=
 =?us-ascii?Q?MkQSjN5mkpVU42iawibfv9fEHev2x2YOcmm6rELpwmCxTsQ5Pl75mBB6Y5Wv?=
 =?us-ascii?Q?5zh9euIHVsUbCDHNcJDi+vLL+nWBRVqj/maMHZH9qQ0d6V0ZBILyuCG7mG/B?=
 =?us-ascii?Q?MvYYyfNpi8lhDdRK2RZxaelP1/b2dSzthuAsGoC/YLdCiokA4z5/W2Hk6Nyf?=
 =?us-ascii?Q?9K/8WmxHXxjDQ9k/lpanrHMljlOhje62kx0RfAvp4F2lRKZ42HL2AeyZ6CZr?=
 =?us-ascii?Q?Vsncs1YXZ6KS8Jsnf+tmZKMjHntIweIpOLgYcq0zoou/yNfiJcS4VLKi91x3?=
 =?us-ascii?Q?as5fcp/KV6IThzAAv3mgy9EZPtLXdWSpKZNBzXN+SJoFzd1blfD5hwxVJta2?=
 =?us-ascii?Q?IAiqh4QH/f701qwN8FVjwQj3FEDoA/oWf2kW7tIcWfxSbc9cd97pOtRK5FHg?=
 =?us-ascii?Q?IOkvYcB/RgKvKwHrvHOCo6kZpb1s9jR//soTjNnAWGJC0bUOhksyhgMLos1K?=
 =?us-ascii?Q?omuZKZNoYujjhlWxuZW3P03cqdd3CDmSJGCaOIOsrAcSUxE45N7XFnAe4Nxw?=
 =?us-ascii?Q?kjtCusXHe1qBD8f6Xz66vHQRa5DVpgt1MvbB4V4hke0IxoIWSQ2Emrmzp5qV?=
 =?us-ascii?Q?W5tCaQf869p4zs46Y2GlXUfk0kIQgpgUk52Cnj/VXg6NrHekiQ2Ad6sHOX9v?=
 =?us-ascii?Q?uD9OQ3+WSf+jjti/egPm38tQR61nxeKCnZ3h9Pp4I7BVoZg6rj9Zsf/sj53d?=
 =?us-ascii?Q?KWj1R4uHmCzbPgOFuxwkEm6tF+jUIJ/GNturZQATbYUvP9TUlH3hc9RblZRS?=
 =?us-ascii?Q?omwO0VVIFbOXlWwxyOkkTEWoX2owh4SAm4VRAPUkE0SYOJuC3lQE6y7/N31G?=
 =?us-ascii?Q?PlNDwv31CTj5Y8pAdOkspB2mjXO4DyoOg+4rDMDSWNFA80wwP2P4Qob7BrcT?=
 =?us-ascii?Q?q81rymxOsomr+O1I1yX9l0DYpEjHoXKJ7XtxWYVgS2/BQEo4P3lTN3+UN0Xi?=
 =?us-ascii?Q?DW6U8A4xNgoo1rkyJFnvG+WU6p1QN9Ps6Tp0mcKSHtDDsGtJqkxRp/gg564L?=
 =?us-ascii?Q?wB2YhGQKvLBQ88S5KAhRl32VR5a67jDGjSEuFcV8wi9aFaIrZg4q8JvMTaS6?=
 =?us-ascii?Q?AqT0RXCsbzKSX/rQB3yIfDCYaCyqGeY6gt8sBFG0TD9O8EJDcjW9vBEddrm+?=
 =?us-ascii?Q?WafzHqbhNuQ4KdAiN9+yCCOqc1DG5snaS9EkyYWMENCRihEX/FG77dy4iAJP?=
 =?us-ascii?Q?zABmqOv1fFake6a0IOWeelSCoGD4Mw4hjms4APySwKF58FtcnQgqkQlSvJlE?=
 =?us-ascii?Q?XKXnvZYTAMwbhP73GZLFGgw1bdBacQ5mR8QRHOyXDDWb3qlCcZ6b55KOzeG2?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55a7377-2e87-4ca7-ea99-08dd19737c3e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 23:36:35.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hg3P1WYVLuuoe/1mOhiQsVc1hrubDeVeW5ODXNDfT+pmpQprsk0yof8OeHT/ng05BNyuB89y8MoyNyjP+DJXA03I7yHrJrXOPD32EWAb/I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5284
X-Proofpoint-GUID: Gv-fkUBtERz3WJyB__ZYQekhBN1LyqMY
X-Proofpoint-ORIG-GUID: Gv-fkUBtERz3WJyB__ZYQekhBN1LyqMY
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=6758d086 cx=c_pps a=WCFCujto17ieNoiWBJjljg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8 a=A__u6bYh_LbSektZ6DAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_13,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412100169

When executing 'echo mem > /sys/power/state', the following
deadlock occurs. Since there is output during the serial
port entering the suspend process, the suspend will be
interrupted, resulting in the nesting of locks. Therefore,
use uart_port_lock_irq() instead of uart_port_unlock().

WARNING: inconsistent lock state
6.12.0-rc2-00002-g3c199ed5bd64-dirty #23 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
sh/494 [HC0[0]:SC0[0]:HE1:SE1] takes:
c4db5850 (&port_lock_key){?.-.}-{3:3}, at: imx_uart_enable_wakeup+0x14/0x254
{IN-HARDIRQ-W} state was registered at:
  lock_acquire+0x104/0x348
  _raw_spin_lock+0x48/0x84
  imx_uart_int+0x14/0x4dc
  __handle_irq_event_percpu+0xac/0x2fc
  handle_irq_event_percpu+0xc/0x40
  handle_irq_event+0x38/0x8c
  handle_fasteoi_irq+0xb4/0x1b8
  handle_irq_desc+0x1c/0x2c
  gic_handle_irq+0x6c/0xa0
  generic_handle_arch_irq+0x2c/0x64
  call_with_stack+0x18/0x20
  __irq_svc+0x9c/0xbc
  _raw_spin_unlock_irqrestore+0x2c/0x48
  uart_write+0xd8/0x3a0
  do_output_char+0x1a8/0x1e4
  n_tty_write+0x224/0x440
  file_tty_write.constprop.0+0x124/0x250
  do_iter_readv_writev+0x100/0x1e0
  vfs_writev+0xc4/0x448
  do_writev+0x68/0xf8
  ret_fast_syscall+0x0/0x1c
irq event stamp: 31593
hardirqs last  enabled at (31593): [<c1150e48>] _raw_spin_unlock_irqrestore+0x44/0x48
hardirqs last disabled at (31592): [<c07f32f0>] clk_enable_lock+0x60/0x120
softirqs last  enabled at (30334): [<c012d1d4>] handle_softirqs+0x2cc/0x478
softirqs last disabled at (30325): [<c012d510>] __irq_exit_rcu+0x120/0x15c

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&port_lock_key);
  <Interrupt>
    lock(&port_lock_key);

Fixes: 3c199ed5bd64 ("serial: imx: Grab port lock in imx_uart_enable_wakeup()")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---

v1:
  https://patchwork.kernel.org/project/linux-arm-kernel/patch/20241209124732.693834-1-xiaolei.wang@windriver.com/
v2:
  use uart_port_lock_irq() instead of uart_port_lock_irqsave()
v3:
  update commit log 'ehco --> echo'

 drivers/tty/serial/imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 17f70e4bee43..9c59ec128bb4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2692,7 +2692,7 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 {
 	u32 ucr3;
 
-	uart_port_lock(&sport->port);
+	uart_port_lock_irq(&sport->port);
 
 	ucr3 = imx_uart_readl(sport, UCR3);
 	if (on) {
@@ -2714,7 +2714,7 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 		imx_uart_writel(sport, ucr1, UCR1);
 	}
 
-	uart_port_unlock(&sport->port);
+	uart_port_unlock_irq(&sport->port);
 }
 
 static int imx_uart_suspend_noirq(struct device *dev)
-- 
2.25.1

