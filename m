Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46AF1D5ACF;
	Tue, 10 Dec 2024 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733802235; cv=fail; b=sNh7h+/x3dJrOtWR1XUWhK1XNP02QenaEwsiVZLg/DXG1LNoYHUxp6KdDRC3HmzCXf2SW54l8t67hNsyQ1XKk2Aj90FRHuniDLzDcj9t4GgUQ2iq4l2iCQmOkasOVEg69t7KXF6xnbOOaDG7s/RI6F/pQPfmJVLxww+fDYwUqS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733802235; c=relaxed/simple;
	bh=5FWXVz4brmyeCv61k3vyQoKWTGtFeLowSlKeBYy3dhA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tzHGz1GaHRsq9m7ixTNLhd94/dC0SPliaF3aznmseImcNtaYSkKGAEF2oPy1sNUBgEpf7x0G4FPcIA0siZ+5zcTBEOS+9RIHyejWAw5LD4/jsTan21f/c3kQFS3tr71kQNlEqo6r/8efSUN125gfZubMoCzpMmL4EPTUe5m2ayY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA3UXuF026669;
	Mon, 9 Dec 2024 19:42:47 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx1u289c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:42:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8FxJ7lnvZCr1lhLVNXZV5NFH+T40tGOOlmQOXK/f1vIUm0suTRU22bj0mPLbkeN0oHQ8hQYSa6L+gdi5Q0JIgb8MSTHoixVu/6bXLM3ruIMyF/a0R4Hkueso4ZLOUyHL1FNDONVCV56UKQqpVqpU4MBPg6QOfkY89LPrUZu6ZrROrLX0ZxDJUtDjdbN3JCtlgkDE07D1ASJNDGrVwLDm/QMOEi39LImeeP0JfU7y+O8dzNAcE4P/SD4OhIwMdNScjI7czWnIzA6a7GIDATSZF0STsquazbhVPTeqSo2w7r7iPUeNT0VPSv9brNguv6/snkKKhWCQPHd6r1mS12Npw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw++dKLPg9Vgms+SjHL6am0G8l2+BsA4sCRbdXZcATM=;
 b=Xizao6MeJ5++wM+3Uu+SPmRMieyZUyjxRcg4pZVpKRnt7PMHRzJ5X2Ha6l4AkE8DG9b1igAyNUebbYq3eia6LmLrjICAXjr2eVhDtMpecmAVHeIK0u65AC8eKu1YG6407xo+RSUQxQyY4AQSJHLJLXB1q6Z1cl6/xs9RLRVW6ty1IndrnhLcFuu41bIUU6w0fWZ8/HW2DkkAhyQ7IvqpMGnreeSvU1WgUZ1YXtCZqRtwy+PZkMRClABih61Ikaprm1QnbpI0Cm0bHwqNxIDfpSPgSwSWnzfctnNJBPxEnvLPfISCadCb8qZKqKpUyu4lQGLEmlquEeY/NO23Bql0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 03:42:42 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%7]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 03:42:42 +0000
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
Subject: [PATCH v2] serial: imx: Use uart_port_lock_irq() instead of uart_port_lock()
Date: Tue, 10 Dec 2024 11:42:23 +0800
Message-Id: <20241210034223.1493522-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MW4PR11MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: a5580fa6-d24c-4769-2448-08dd18ccb38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t7Bi4LaC0OnStBgas5f7efVe8Tp7j09HE/qWuFXa/DdqTs9PTVowVt1+fMHg?=
 =?us-ascii?Q?notBCFlP/fCuGEhc+EYyD0jKw1k0S3dDTYwFuUkkoOcHjetimjvyUouQYsxF?=
 =?us-ascii?Q?NeK6sYVQUlAWsPfducwnrfjedI5exafzWGCi8XenC0FUAMAaMhD/GZGwi0PO?=
 =?us-ascii?Q?Yh8n1P3Jzl11nFXiKgKAq4Ra39nkXwqrXLiXsCfHPzJQ2f+FwE+xsGk//1Cv?=
 =?us-ascii?Q?TxYFfpHD4RljF+WD253db/4ykskIqESX40yQ7PMXj2AqLfB16nun/WD+545Z?=
 =?us-ascii?Q?2VFlPixEtKoUq376/TPZRuNDrTpe6tVo9Rl66q3qs15pGnrDrMzmQwBTD52m?=
 =?us-ascii?Q?bQuslDN0XUUPBg24vPhkTTzZ+V3+PpMYiCAF1N98QjmbmkQiyfjBN2I2mBSQ?=
 =?us-ascii?Q?spRR5w9UYa0jsfwgGUiGOad8w3PM4e38HnlW3CDbZqCG5gIiNjVT1fvl5HOW?=
 =?us-ascii?Q?cwAFuivaXNuZ/5jArXy54LJM75kj3hrxPAnx1W318dQIjy3VnmOpg1AzkCVE?=
 =?us-ascii?Q?Mpiue/P21s8W9LcRYsLWLkmrZLTaMHCFK6CkEOQPRa+2D8TvxvrUJfRdI3v1?=
 =?us-ascii?Q?QjZ+T7Llxcg4KwJIZCSHRbpSErMxAXS7gHMbJ7LX65nctwf+Pb3YzReUT5w6?=
 =?us-ascii?Q?R8mmp3pNB0AUNttr8ZCevNeetZa2Qpps5oJVjYZSvRM6HOSyd1yi+c6oFe8M?=
 =?us-ascii?Q?+TetwSOgrl/3Q21v3f0d5ZSw9t02RNE8kWXcjQeBSE5KwrQf40UyGiZ8dJvd?=
 =?us-ascii?Q?PGLf0BUr/agE0aV9zjgWSD0uOSJ9Jvx8kO26WeRG9BGJdPgnqtrAH2VTTyHc?=
 =?us-ascii?Q?e7uXMOKOpILsTgtUFARgkOtAQO6S+FZAzKhOXywwf2UAfbMn7SpPi4I3O3MN?=
 =?us-ascii?Q?WbEKSB9V6IyL6LI59Ygnmyi2zQh01VBwNnK1xWKmGmnkvgSBLHlWin3tNPIR?=
 =?us-ascii?Q?QhfO1O2s0PUEYlpDtJU/omXjln1eKTdb/PxCqUFOzw05WcRhHlklsbwmj39X?=
 =?us-ascii?Q?zP1YYdvD9vd10CtU7U4AOG/RiaQFSDNYqvyi9SfggE7YK5q3VzAIv8PmzFG4?=
 =?us-ascii?Q?Q3Ht9Vjl96Q5InEbJOf9/QN4HaAV1mDPa2SL376EbtuGz3aUBRcRyq/5ooMY?=
 =?us-ascii?Q?6ScYa58By1z3NJk/+CBfGVONYY5c/4iydWWis67zIvYbEQmvkagT/lkRb+Q3?=
 =?us-ascii?Q?BnhxUodS0fNP3bc+HsniLYBJjZouwwIiBEzyUhNXpvAQFj3M/nszdiTMv3oB?=
 =?us-ascii?Q?j+nMbPfuTFkmv+lluY75L39s16zJRsyGB3kBC7tDLuxkNuH07sCI198ArTWj?=
 =?us-ascii?Q?assfc7GS4T2AkS9icWYKh9BdqYt2Sx0KfK/zZgAcYJticOcyDpxf2m0GmzR7?=
 =?us-ascii?Q?NKKlTkaIyhjAtIhtA83rOYUJhTIjOwhFa5jlsjFo8MXrJvzzenInBSViLWfr?=
 =?us-ascii?Q?dlGj89KVIi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qBj1pwrYqBcooE3zOo0BlnbOASqk/YeLM46pfV/GlVewBr0AMEhxeaE4wnxn?=
 =?us-ascii?Q?q8YqDRGf5TgN7o0n+XDuyP8KO3LgZLjWXjNsRF8+neoNJAJOC4tn5/ysDYNv?=
 =?us-ascii?Q?pAumPTQ0RhpvtsLugeJOXBqe25XbrM2xz13Uk0X+x71KUATS6TJW/ew2foh0?=
 =?us-ascii?Q?7v8egHLWeEnfcZmFG1acUX9LLmUn1z19JijWrkFgiDcUsEYzmZmlw3q5zWpv?=
 =?us-ascii?Q?36WZitFoHVw78Sr7nsvRxu/q6Ezkv0tjRPqA0vUko35yYMdyOP5I37AB9mCF?=
 =?us-ascii?Q?e/Gf570p8QlMbEFpTl41Z92+bxr95olRHrtk85paRXyt1pKbnodgMaZMfRu7?=
 =?us-ascii?Q?xieDVwsoQXNVaOIVA4fkQTh7Y/P7okAXYl8v7sdjpUZvcFaPfulU1r9/BfM0?=
 =?us-ascii?Q?uRXjWU8bCDcpzroY8HlLc+c3Eh4eZgXT1zC7/xHb0RfEjGrNpAICBOpDbXzS?=
 =?us-ascii?Q?NO1mJORcugN9HYavlF8TyvncEt8kj/bzez8lyhwuqooUb3aiefIJ93h9fNxI?=
 =?us-ascii?Q?OqmLqdls6Im123OiXZm144klcsKZDqlRbElA2DTuBsmuNqCFAkoEPfQdtIy8?=
 =?us-ascii?Q?6YVVcIu2izs6J1QpF8tYDM2ikAak7FpC3nndMKykq1sFYCGfKFQTINKdE+Q4?=
 =?us-ascii?Q?e2HF9PfVIVo2yo2nhk3Rk+7qC02Speg/lsURyUZGLlWBzhSapatUdY5M4DWL?=
 =?us-ascii?Q?3dt06nagVDTNiReQTQnWILCPRqmncppO2JVtcqzFJA7F+RimYY3Rk3Bm4no2?=
 =?us-ascii?Q?xWT9Dq6fDT0ncL4JtGzcCDEIwJ3zGhHLBApihRkLVJ0vvA30fXvNEc9B23UE?=
 =?us-ascii?Q?RpD0FfYRG9q9uqVrt4n9KbbD8G/sxEte0zSXDavlwBYZPl6SPUqE/3L9IRIR?=
 =?us-ascii?Q?zZjTe5xn9ENS2XIcGW5X6bFRqQB251AV/DTFEbQdipV8gbaJbfXsoJcSYR2o?=
 =?us-ascii?Q?gJ0eNuRYhYGq5gS7UmhETHCqOX63FK2CE8xDNdrxnyVSabhxXJlVTDx8szNM?=
 =?us-ascii?Q?2MiueDTyDms/k1H1OL2/JBUAofbffKg718vLhhIyZBMCB3ZZVUAKoTTOCBb7?=
 =?us-ascii?Q?1E4wlHZWtIdTbwfmBMGLMxeyz5pi/8FGyXnJ/z2dwlq1q8Bqj+WjVxxk64DO?=
 =?us-ascii?Q?rEKM1ixeMJ/nkNAIZyYqiLdEDIkvXQfPaEumj5l0/SIYYqF7dT5SjzHYnp1W?=
 =?us-ascii?Q?V1q0K8yK0KlsOKPzJpYzah5V8E7qLPUv+7prRQeGBaFz0wkGdijSjiQMk5pd?=
 =?us-ascii?Q?wWiXZUfXPN26USINb9dyQiTclmmiZxEYjY1BppJCiW2M2bLcIg9sNHx63YPI?=
 =?us-ascii?Q?B3STgaWqq35nD7W6HgnpsF7fZGipI/xfxk9giaWfJWqCz6lH26vXE4W1WCqq?=
 =?us-ascii?Q?IVGfHVnTyRPQGd5avmv2QUXsF3xJ3yuK/mUWWrCSAITJmUMhg8MWFmtY7qq4?=
 =?us-ascii?Q?hwHgqpB7tuTUnZm99bPXV/2hTYrrus1KN/n6QZGxbi3Gq10/696FWbTu96CU?=
 =?us-ascii?Q?zF0zdWlENsLZfPnj5fOwNW5OOGIcxU1U+95gjX4wnYpQUhh87Rbj++P5r0LV?=
 =?us-ascii?Q?7qq+Vm8vfRS7WliafbQiCQcS9qX5ieTveAn5AVcQKTYTIGHnkjQuJB4R9aAv?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5580fa6-d24c-4769-2448-08dd18ccb38e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 03:42:42.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlyk7uEAQMohN/QxQZIqXJUUDtai7bRyPJYQIC9UYQpB73eKdI7tHlqPJDeDYPTFxNBc+3UP96qQxXZDdecS6UAlBFuuNYUkrTn/pSqeKIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
X-Authority-Analysis: v=2.4 cv=H/shw/Yi c=1 sm=1 tr=0 ts=6757b8b7 cx=c_pps a=UtaLnOzkojfj4BVWksq/2g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=A__u6bYh_LbSektZ6DAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 7FjK5ft-tOoluzcFAOCOEAlfM8ex3ziY
X-Proofpoint-GUID: 7FjK5ft-tOoluzcFAOCOEAlfM8ex3ziY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_22,2024-12-09_05,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1011
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412100025

When executing 'ehco mem > /sys/power/state', the following
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
---

v1:
  https://patchwork.kernel.org/project/linux-arm-kernel/patch/20241209124732.693834-1-xiaolei.wang@windriver.com/
v2:
  use uart_port_lock_irq() instead of uart_port_lock_irqsave()

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

