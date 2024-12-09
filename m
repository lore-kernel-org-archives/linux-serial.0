Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999A217F46;
	Mon,  9 Dec 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748533; cv=fail; b=CyF917bN5ryPTN6rNlOyCk9BUqKlVukjjmkmOKxdGIWlq/c7BVSlS0hPA2TE1347GorlL6nOXNaEU/l3cP79h4++Nu3kA2HrTEIhGx3jOfHc64o2bKM0Ht9RYjW036oTLTodzd0naVWIf3NRF1w9MraMari/tgMCfRjATPUthAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748533; c=relaxed/simple;
	bh=ezcT2c7gpBif5GPIie9Q5ZZlnADznhBW3UtMSk8VBNw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mF+u2ebF1Dap4vL+Ao06h2eH0+nSpT9pmpZqJPeP/I9wv45i+8fPjtxfi+xFMI7RSDH2j0E+teJjtuCej2PBUEVbc4SBo46Ea8VUkxDj18JtapzBp8lObRfH+ov43lLwGwk3z0zHrP+htxPHu/YRbQyF6KtcD9ZDeeOxSYvqxNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B958aQG030771;
	Mon, 9 Dec 2024 04:47:56 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1sceq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 04:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEa3KiemLoCYs1TBw4p5534bnJl6agKddE8BWb4Qa41gvJDDhIfF3e1b+tp2Wsjdb4/xWfX8Pxs8zaNRJVZ6w/21bszbb3jVeWzWwFmYapoI3wIGUxutu0+sXnHwYww62EiYoBZ4F0cKD7okyJtO3Wh2gbqe7VVCsqEyzMF2FSFsOlw6iKJG2Q00JERt9BgkR39d2GC88r9gfDi0eRSc+ty6A4KBzgzUvhOHpYTHERD9bxTPwHnyALzK0tWuC9Iaeze3btoc24WbuLssEkNDeNM4ygM4TFgc1eq2D8M0ecB3DVOf5qqah6lvsh1nS+gv9r5/Pmqc+cyZVfKFUrmkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnjxn2z8p/evoXAd4w98tkv2eX8FMIKbXgB2dZ8XO88=;
 b=xLylZcsAtUJZO3i3dXg/dVQ2b5jPTqC54W8yIc1vpJhtxjt5ky9q7BDx4YvBv8dGLJC7rKIpspbhRfzXXvNoP7oumlB/861qD6VgZ9jER5KwAcoE++8nVLk9xMh+sborfH8ijhjdobL2C46/Q0a5k/N0tYCKxVEhnvuKiFKJlbqyraFliCynzuwNKjx2kEgWtXcmS2zI8BC5Ut7/v6P0+vhB5zdFQDd4V9YibvMy2EME+wuWAyAysIHjFNFv6gKfzNtnMTjf3eXkyLrKPcQ+/0WhVJzUNFsLhVvmG5SgLln6HmlnrcKwgBDWujoiuH6M/8KrSAQbES/00ByhVkAgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 12:47:51 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 12:47:51 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        esben@geanix.com, linux@rasmusvillemoes.dk, l.sanfilippo@kunbus.com,
        marex@denx.de, stefan.eichenberger@toradex.com,
        cniedermaier@dh-electronics.com, rickaran@axis.com,
        xiaoliei.wang@windriver.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: imx: Use uart_port_lock_irqsave() instead of uart_port_lock()
Date: Mon,  9 Dec 2024 20:47:32 +0800
Message-Id: <20241209124732.693834-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|IA1PR11MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb8ecf2-bbca-4d94-457a-08dd184fb136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CPMztvMFq6tsXPCXQC+aVMhkiHr5/+/JkKS+0flqJUTcYzPv5Z4ONsXIrqEy?=
 =?us-ascii?Q?+QlScD0iOhdwTTHWUtbUCJN42KlolIN6/Kx6ZgWdLIEZOORNiKp45uZu/wdX?=
 =?us-ascii?Q?0XvnK67DhRE9NOe4PPD9mFxn1nQwBNhqBIy8bP4x8xBiS0sm6v2CLCb04HUe?=
 =?us-ascii?Q?I1EXcwElXDpMDwi6+t909jDFnWPQRmxbalXt8x+AZLovRk+1chW9VJW7jxB0?=
 =?us-ascii?Q?zX6iWhTGlgAvXq+Zutm7sELodcZ3sV9MiT4Q8CVqYcsfXAwJkqE8E7CviNk6?=
 =?us-ascii?Q?usyEaxW4zQjM6KoW2v4sXZ5AG91HZnbsjMMxld2OWerY3TAhxI5i1u7PkVXZ?=
 =?us-ascii?Q?t35Ae9n6PnMbjbfNNAOVqjFAIstbH/kCyQpOZSMpBdHg+ixaOM/nfl/uNMSb?=
 =?us-ascii?Q?K4fLoC66N6QT/HmvGlw9tCwqbEvYL8s03KrD4Pgjoqzmjm3mgb7vLpbdq8Or?=
 =?us-ascii?Q?qPfdhz4ORTeiz5Vsif8TRlO32ZOvuFz3JWv7eMFMJSIJUlNIMezmXNOmzunJ?=
 =?us-ascii?Q?Peb5pWvOZ4Ap3xrTmqTDyaB9Kn2A31tdhd4LzpoPbhB7igGoYjCk5QUByHOr?=
 =?us-ascii?Q?/KaI5ZIeQvCVWMisfOUmFWcuu6fw48VF7hwnZHpKmDHfFM56QRWdMCMH4sgi?=
 =?us-ascii?Q?Bi/mYxzKkd4Fh1J3GIpGqTGF39/BiZuw3qZ8GvymaM1gJltBB+Bd9pMgsEJe?=
 =?us-ascii?Q?Ji+tUbj+Zy9A4j2dTIo8TkltjKNjzFiqsLMdzNgpo7p2l39wuszoVz3XSkfl?=
 =?us-ascii?Q?CTtnSIkuPzzSfRCSaUeOb25DXCiitU2CUvFx1j3XnwDNrwGbENb7WGQfXMJG?=
 =?us-ascii?Q?gPOhdd/s+cyB5UiP7PMqz26kQa8DvAuEidYLaCjTZv1rEUA6zvXEpPSNTY+F?=
 =?us-ascii?Q?isveWXbHlmRuRdLNnHmgVwZppSHnEKQ28IVen98z/xLOYhUy+9fkxGVr75jN?=
 =?us-ascii?Q?DIKEsT0K233Oi+4YyT3HiS1QHHC2WGT1G+JDQB/AAaz9pmND6IYiL01i9dAH?=
 =?us-ascii?Q?1a1BgstGAatQjg0vKIYZdJzMGgF/2k7edJOicPf/9JgSpnuLIo+iFAhR3EEI?=
 =?us-ascii?Q?Tmx7OODjKVGIF/zkiXXDnjCRHQC/q9TLsdDlFXWrvElfJ6pDeuS3HOGWWIAd?=
 =?us-ascii?Q?K5l9A9NbX8f4wfoDHDe4h1fd/LFcnuAMhnwzhy6IPOD2GJqzD+P7eSw0kvAX?=
 =?us-ascii?Q?nwDbNuNBa2BYBfbEG5pIQ1VqQI5Gz1Q2ORvYKZqJsGIPwpCYTdUxHgVHVgV9?=
 =?us-ascii?Q?uYzMkTAXNWK9OnhJF8azjI+X5DNlKBU+U10gDKLwlKxOQZ4ULfmT+i0ox1/j?=
 =?us-ascii?Q?Ji2Oyt7XM/7TwWfpPZo5Gfh+aFMcIdeTw715HM6a2xdW8ch3c73Okf7bbPvx?=
 =?us-ascii?Q?GlqaCkdI/EhKY08UKnYRPaoO57sJOETfUC+kkWjzQhjAV9d7UTi2Tim9xST9?=
 =?us-ascii?Q?loaocvn8KjI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gCZbb/WFM7dJRd/l0QQsD6FLoVngs+jrXuJc7Eg8F9z9GEgjh3i5ykw4FX06?=
 =?us-ascii?Q?HZV/sXJFrpqNiOXKbC9mn+VxAOnHa+b4xwFZs/95XyQw5shNovJj0ZAcLLfL?=
 =?us-ascii?Q?IilayikyZswDT9yqxk9PIkz4p85t1hoadeJ1TfYabjb1kZ7uean/027t0QnU?=
 =?us-ascii?Q?VuOp5o2my/CY0E8v6SVC0XVd8SBKFN7ZzYd3pGojYcwulQfa8Olgesle6UeQ?=
 =?us-ascii?Q?/R5QHqCwEvwQCpfafhWlEuxYei3Bb43SJsucG+9+8JYF3WsyvvssxR4PWeGb?=
 =?us-ascii?Q?DoyFz2hwD9OwwWKkG1EoTYBYCUBYfKnnC9wVLBbDJVxWxM0Lc3Wp7WiV2vwD?=
 =?us-ascii?Q?V+zh8MeK2d79CF+q22IbsdNWkXiYOwsCvpn4Xly0k0Vt+6n0U7zAdY+4uSFZ?=
 =?us-ascii?Q?PWipDGw8IreWWADQhZk/1k+d4wtqt30iAgb3VzwK0GRJ0SPQMWVI0q0B5ffh?=
 =?us-ascii?Q?O2/XGDW7G4r5C0EhT22/6vaZ+sLWD6eGnhjP3eLuiKJLHOhCf5FQ7lbjXagn?=
 =?us-ascii?Q?5Tid/m7UCSXd7b3Rv7bqjOXQyvgtrhLkIW7ayVtNAK+5cs1loXLk3V+ZGl/1?=
 =?us-ascii?Q?al5T6B3z/ri8FCn+jxFZLJtg2gUHJv3xEoiaLG9E5UUaw4D8oG7zq+RJtRxc?=
 =?us-ascii?Q?FnZQa3kz+Qk8b0qFD4Vmmd7akOq73pbSixe20PwX7rSDGed2IccuThQOE/Xw?=
 =?us-ascii?Q?xDxZKAh+qrzb+OugmiINFcjITnX53IueZ6mPnaxkDxUEzmMBQUVj8Okn9vZB?=
 =?us-ascii?Q?Qia2gdoHP+rd7B70UluNx59DY9iAfoYCXptPB2dKEymIJK0p5Yh8M8/i/ae/?=
 =?us-ascii?Q?ytaYIWa8VaOowMxkKSPgPfDd9R0oKfVsUVfWa/o2tZFo8hvfRSzYKXy8hIXk?=
 =?us-ascii?Q?+q/zBtHymBfNBSYfBbfQjGbDXz932T6oUGrrip1TgiDt3dLft5MZHTkT46Z6?=
 =?us-ascii?Q?WZRYwAadyWA+qbzj6R5E6loFzXul8k8LQlf9UCSAVHdE8UIGKSSswBWyBI5b?=
 =?us-ascii?Q?FksqnpZdwBM75eUsQBP5YzIh3axIOArfWGK2ikNVldFeJKYBkoLm5r/eOh7w?=
 =?us-ascii?Q?Bd8NYPmWmPVtbhoibYYOYn5nSNXSQrM/CK164Mrwm+mX2uBr9JHxlhDdeVRD?=
 =?us-ascii?Q?rwPmVOJ+MZsRJ5KyR+QFfTroDfLFxzWc0IbzNb3beRMsVO96g+BWQ5g5MCyE?=
 =?us-ascii?Q?pS36GgeME/R5VhjBcLI2yyxTD73a0CIgnfiaPY7Yb0ei/xe7CnIdEGWAgu7Q?=
 =?us-ascii?Q?i6GLJHgWqC5Sfg4lL5bVP/fe3mj0cuvFiK7fSx4NFBzZr9ZO+Igl6TihOu+W?=
 =?us-ascii?Q?ma4sXH2aC2j2bc6aoavn94qDJgqIksDp0yiRjClTcAhT8AGr9bAji0jkGmeQ?=
 =?us-ascii?Q?L7ilbYR3ymM1bB24xvmN57TP6Br+rdBjbysLY52P60n1xY8hL1ZhM0E3Uv2Z?=
 =?us-ascii?Q?cCFQtJP0y2IB5J1altSx/Shd6nJkclam/t6yTrPn8+8LJ5byyUrFyy93mAN0?=
 =?us-ascii?Q?7iRtn0o4gNT3+l6OUwAIRX2bUrrDwZYnN2dhx/0HEqj1VYxbEw/UcRPWRoLj?=
 =?us-ascii?Q?SzSa7vrr+wsUh6Fwvjf3sMWm2XKtU7PZy07PzKZ2vMDh+LfOiHVEPDndEapD?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb8ecf2-bbca-4d94-457a-08dd184fb136
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 12:47:51.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UzNGkd0B3GCnAxDhG9jSUklPpTlDpSt8GK0iOcvvSneSi/w2vaYr6ieuLy+hE9oAo8fqfEF9ASIN9dWE+dYnbfMaOyNO8pyIuUNScwmWTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-Proofpoint-ORIG-GUID: Px7yKHB3ymZlLA6LKN3Yt8TNQFfmxSax
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=6756e6fc cx=c_pps a=Bc47kgIQ+uE7vzpOcRUeGA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8
 a=A__u6bYh_LbSektZ6DAA:9 a=EgV5L4Ra9ea3rcF7PrT8:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Px7yKHB3ymZlLA6LKN3Yt8TNQFfmxSax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_09,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412090101

When executing 'ehco mem > /sys/power/state', the following
deadlock occurs. Since there is output during the serial
port entering the suspend process, the suspend will be
interrupted, resulting in the nesting of locks. Therefore,
use uart_port_lock_irqsave instead of uart_port_unlock.

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
 drivers/tty/serial/imx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 17f70e4bee43..4470bcb3ef19 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2691,8 +2691,9 @@ static void imx_uart_save_context(struct imx_port *sport)
 static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 {
 	u32 ucr3;
+	unsigned long flags;
 
-	uart_port_lock(&sport->port);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	ucr3 = imx_uart_readl(sport, UCR3);
 	if (on) {
@@ -2714,7 +2715,7 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 		imx_uart_writel(sport, ucr1, UCR1);
 	}
 
-	uart_port_unlock(&sport->port);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static int imx_uart_suspend_noirq(struct device *dev)
-- 
2.25.1

