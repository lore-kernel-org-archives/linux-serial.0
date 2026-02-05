Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010002.outbound.protection.outlook.com [52.101.228.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A642221540;
	Thu,  5 Feb 2026 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306155; cv=fail; b=tE2a6nXSOqc8KcbsWM7ArzePQDrnQ0TGIKEhA8g8ShTg+oG9HzduOikGFY8URx5uR5ZjT/iSEJAN4/EhmshK9iiftmxyKSwmnflh9KzMh9R6GZJxGDmnWpev4EiUjA1zEf4HdU8R8cPNsW+XOAmLEhCB0ObYngw30tcz/ybNRJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306155; c=relaxed/simple;
	bh=aH4gvRRZBtc8Xz8cuDJisH6ysT2gkHSJqJb/eT7nOVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vg0pjf9XC+80pWOvloQgneZLGS0HVTfwKG3CpXlOG18IZr+4+6zmKJGHwwYJDZK309AxWOxpOmKV2ZXbIetsesMywWD8ZZxliQ4S2Dfn6uq/YrsjxBafju3rJvv1OgtMEFHCSUn4/vl+xDvnOL7nLp8pwx+bQjtNYkWirqMr3iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=a+mnJrig; arc=fail smtp.client-ip=52.101.228.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="a+mnJrig"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zz4l88nU1khTYAdgNtnDg5s+QUq3eA8FQI3Wc3amMfV++mj2gWx0nwL0g+M5j3eXBFV5piKopmjChddj36vFw9FhXekE4ib9N2MMPUrvvZo+wScXNcFt+sz/sQlpFeXprJhehOczh3UKdux9M8BY0PXrcjWuBviV9lQX8bSDjg3a3Ve21b1rv/4IFQ++niq2/N81VuyRtlx0GYLUmZfUOm1b4eOcTzVF0EeVWxeh/qIthGvzxxCgig3H1WQ2lrQewmMpuL/TkpCxLf3Ks4g3i8nLrqaYOKRSvP5WLj1EzgdbWK9tvwPUfWcMgYmLsVRW2rxWyDhRFmo3K5xBlEuUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4DdkGfCw4QVTVWvCk6Rbta/ipKmsYfRNSXr+iOfsfk=;
 b=sLGxAicd1/AZ4Byuza4xShvTBLyoW34LncTGxnAvhGhbCtBZTJqMtK84xuheiEcmx2ebMOwdvAhazmIsU86+/Xu2bw5ztJNtyZ5avFBIywyX5RYY+z+nrV0v0rD4+Y9V5O/GUwvjIZLUbB+imC4/Fe26+SUEhfkGoK3LcYO95h/EYPd9gQ18vPB2uKV8rjNnAm7z4To/q3Ksi/QMXBoPj/7YK/8h7ZztpZ2mEv23z7LolvrEoExwYCBhF+70UeWjGekJhJmyVdyxfXW/AJmSNn/9HyB7EnA1bazFsflasrtTWoNfTocDQUhH1KFv3nbBD5I4RaF+ioH+vc8gTa4xGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4DdkGfCw4QVTVWvCk6Rbta/ipKmsYfRNSXr+iOfsfk=;
 b=a+mnJrigP1iMpEHBQ4HSEGe6XRQG6sdc+0xd3R2U853Jp8MTLcp+F3f2Oc7yzwW50nylwC5GWi5nLNB0R+FCFXvoxDVGxFUosXNVcUoSY8VT75WyTi+L5LdqatpcyxGMjvg675s0767y92Pas/+V3zGFzCfVRXCwSHrbMxntVSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB14023.jpnprd01.prod.outlook.com (2603:1096:405:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:42:30 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:42:24 +0000
Date: Thu, 5 Feb 2026 16:42:08 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	m.szyprowski@samsung.com, geert@linux-m68k.org, hch@infradead.org,
	tj@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v9] tty: tty_port: add workqueue to flip TTY buffer
Message-ID: <aYS6UAUI0_Olqjw-@tom-desktop>
References: <20260205101948.594577-1-jackzxcui1989@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205101948.594577-1-jackzxcui1989@163.com>
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB14023:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f6559a-8676-464c-f6ce-08de64cd285d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8KG1YcLKzYKEoj+Hg37afReCfxnE9uvQ8yEPiV4dieQtRqKLsmFIjF2sEtBH?=
 =?us-ascii?Q?GkYZZmGRhLbbKo13Cp5meVKZORHRfu/rJO8hlGm7vyD0AL+UURiDuClN4iql?=
 =?us-ascii?Q?EcVh49JCb/uY4Y/QxcL5b7KZ0ZPw3B3R4EKS34SBshKiDyQn6ojW4nfp/jip?=
 =?us-ascii?Q?fKmUNRnDdY3WjjvHdFqrVZlhHeUlQY3+vnxIs5KgMFc1LvH8qDazB2JVq9hC?=
 =?us-ascii?Q?oRQre0hnY7CzsS3m17f8B2ejlUiEZqkU0YovJ5MZfs7RJoueDNwhzV1aO9Fh?=
 =?us-ascii?Q?VjKYV/yIW3KsTflpBJBmQMhP4A+vv7OokiK/C8R2ZQUtEc0Kfz2TR6M/TMlD?=
 =?us-ascii?Q?BUZ2Fj18BoZKCoQmRBgMYLf8xX1rR3x/ROUAnF3xI7nk602ebNII1WclFVKH?=
 =?us-ascii?Q?foP3SBjh53BvppXHUMGm4E8ga3lY955piJA6lH2wY5S3KdZ68c8G/mlrBHjF?=
 =?us-ascii?Q?bSU7t/XJMPcUqcgCuvAQMIcsDLkr9wAB9H4u7pL2an62dj6gP5DSiIcMW5Dh?=
 =?us-ascii?Q?J2GTapeIqIUk3EhWOVqg7bYCtG/CKbrL95tAYejN5CZEYwsH2ohLPmidYWSf?=
 =?us-ascii?Q?9RmJe0s3sJDSdfRXcjcu6eMEec92axfoOQdEB30FktmxKmpRJhwWqQynVPJC?=
 =?us-ascii?Q?VZxkg+PMsOBwHDUScH9umQTE+L0mFFiSG7mZ51Qq0Njcfb0ciy0Aajs7xY3k?=
 =?us-ascii?Q?xM0OYw+O7Zsq9eb8V2713fKKKlpNnAV0qKrYhpzQbZq+tB5RsjCpgKBO+jhg?=
 =?us-ascii?Q?xTwsx/c/GRbUftaXLBgELO5s4o52L9ddWBlvLxMNX7IEznaZ0EG1QlBpy832?=
 =?us-ascii?Q?e6FTOuRTLjAqx7PLzXP/ZUhstTdTq4JRRGEAV7xAVjtc/+oepHI8WfMOYfhG?=
 =?us-ascii?Q?FHGnL4Swo1R7hSDYP7bHdwIv5IZwwV7m0pA0ayu8Uv3xNqxNvhGwmA/CcBhP?=
 =?us-ascii?Q?lgwXmVpFV+Qw9Y5rhlVwlrpNcaFVF9NBcdMFgKouZDQtQ5LB/JeAUPMBVit0?=
 =?us-ascii?Q?3PqpKKN56U73AxGf25JYFmsqAEkqLi8u1WnFF+YqxS1cOqGdKZjKXGoDauEz?=
 =?us-ascii?Q?E+0NH1cblbJkcR0F0GlePkJyKPhFEmroamRjwVI7+kbiOmxTqlMGjAVY9HPb?=
 =?us-ascii?Q?veTc91gi5gFbhfBWrES8b9tpl8qzqYgqz4snzYDEvv7UVVpO5gwVM4ICYA+D?=
 =?us-ascii?Q?RCgdipyulRdOZonRI1am9XYgnkud378iiep4cxClnmNPt7tiM8UoxN0Vm+LR?=
 =?us-ascii?Q?PspD0z1jFUOYHcgHX9CSdLxzfOQwwR4qxAqsb7WhTEzup9JJ64IOUuThzVX7?=
 =?us-ascii?Q?3YL/TewQ/5U/L7Vm9Floq1fBdtA8R6EvF/s4MEiF0SRlfDJjTLI/ikSsTPsP?=
 =?us-ascii?Q?iXmGdXYDCYkyvY5kiVNRcHx104MvelN3JipYP7d5EVZAH5SLcCfCsQ0wNwr8?=
 =?us-ascii?Q?7Kz0LtQ8RIAWPmBsktsBzwDL/L/TuFgioQRWo45XCI89t9iPZw5sgRFCSjV2?=
 =?us-ascii?Q?fBLZw97i892a+fH5/M8VBzN5xHXslbeaw7asKQqHtf0t5UfygxzrRyzck5/p?=
 =?us-ascii?Q?4RuV0xKtqvDvqZf7dKQSXVKk2Lwq25tuOLvpkrJDpXDVRASRkwoojRVNYXNn?=
 =?us-ascii?Q?FTvdbFoFlAEwtnbipGz3EKM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I2+hAdgM9OELhlwuv7XOXEGHUZzbacNOi/eID2jsg9JBWNZA5hM6KDvc23ty?=
 =?us-ascii?Q?Ay2NG4VOUhyX2S/KQA+yp2Rp1nyJFXVTeyaV45oqopDtT9sWphPAGP0vnWH1?=
 =?us-ascii?Q?llDc9m5t0MYeJmmPn64TaiBjF9TTp9Npn/v9YETuSD/N+VVBTm2Ft973hQ0v?=
 =?us-ascii?Q?k8zJu6bzbDRSUISlx0LXzO/5a7+ilryxrXAi1UmiwxxpNuoLP7cR0NFfnH3I?=
 =?us-ascii?Q?r+43MP0k0Lc5r6EvC+zDfzhkk1M6QoEYdUqy3VTw+l1xnQCYtj3dLoRuiaia?=
 =?us-ascii?Q?YN/irMEGFLVrfzQnMi7ADzOmEhququ2GR600eHxglTnYlWu+HLO4K8Ob3NpL?=
 =?us-ascii?Q?++FCtV0tQM+r5iD7OdSwjGdmNtHAsy36604o2oYse0tlQHYlHFm8O422D95N?=
 =?us-ascii?Q?jqwJDmb8NenlAICHK1XeEGFyOy8qrwTu3GtiRWiau7ZdgC2pz40Qv7YqG5sP?=
 =?us-ascii?Q?i+1qwNzvz1KZorrfSG51+Gzjl9ywj2r2SI4PLlcFRMBYHd1WJial0lIpad1+?=
 =?us-ascii?Q?oEH4hkBxhgPMd2hOL54vEuzDbYoTM2el2xSUFew3OivCxEKODeNJ3pW6K/8x?=
 =?us-ascii?Q?aKPdXTifBnUzn/Rw8UT3eIqur7W6UO08BT4M/3Fm1ph6/t0xoVqHzBJ/ZPBI?=
 =?us-ascii?Q?4EhwU4gxWAKXggYolSeFzpKcXuWWkUB4eGiK2/glOSnIwLOmtxHhD0AIv3St?=
 =?us-ascii?Q?uskrDZ+mFqYFsTqkF/FCbuvnHKg8X1CVeruSI6VFdx44uLhMfoMSP0dcoXv4?=
 =?us-ascii?Q?mLD2ppFt2Gdq0rBX2JDeJRHA5NTXB85UiVE85bjgPeA23gDH5OWrDZYR7aYO?=
 =?us-ascii?Q?oAYOEgwEFt3XW2TqDXoRQj7REylmm6/zfGNUdS2Hfm4YxhqsLhkDog16IZUc?=
 =?us-ascii?Q?Ayhwg/yICy7MSUdcBEpQA/C53m93WECKqixApMeZISVcHajf/Ti7GMgG5G9r?=
 =?us-ascii?Q?3kt6qrTOkOMP4bfy9T35pUb8QsvcA77Q5vvFLoP2GuLer/yxqy33N/xBr0V/?=
 =?us-ascii?Q?hrS+stI04zM6ycGiPvyJNRGgnWb1Lf+9FbU/vE2VJZxOX9PvVEa0PB8647BC?=
 =?us-ascii?Q?DGqreZI9rzw83HpgS0GwwU+K1vfbF1lxLZwqt2rQqlO8OxmLAmY8RJnvgSnh?=
 =?us-ascii?Q?KdC3XqPSmFqPbyXMhWQYUW2xTu5brWPwVegHztQCY1hY6BSHi8o+UeNJ4E65?=
 =?us-ascii?Q?+e6PKI+GKUpYBFOKgNdPaYJkc7cj360Jpg8dorOEDUxNC8C36MVj7fA6jEme?=
 =?us-ascii?Q?pzreyg3Xviovm7sc7dpoH7LnTnYyZvdCA8ipeHKuLepWiehZwuIE3Sf6YzLd?=
 =?us-ascii?Q?bNmY8iIMmjlYOLaqqNyP/s6Lcu1WHphGoH52S1ux1kHBMzjAwee2gt9lei8p?=
 =?us-ascii?Q?UEKYp00h7b5pEfqxY+FzLnlo11N2PYD/5vSbrYMMSdQTghcNc+e/NTFC2an4?=
 =?us-ascii?Q?/pjRJ/BSLTx4hO3FiaSVtlZDPQigLigO8Zr+A+g6wUxjfPJaA4gZTccTZPZa?=
 =?us-ascii?Q?r2DfrD2HjucjL8nNqm5J7A5pFpuS8m7usz1jSqbrNgHVYe0IXnZ8Vf7QpUjG?=
 =?us-ascii?Q?nXBp7XfUghay9qCsoZGNq+8YjdyJeV7i4Wxq1bdELf20XrSMjCHLn1vceDrP?=
 =?us-ascii?Q?4XIMLX8cdusi0lG5WErqvdSW44OQ1vAV86MgTV2xIp/UqLCCnPVmX/yElPWX?=
 =?us-ascii?Q?s/TVr+yv1N0/IX1VXm8XAb1/nf0iYyjGHB3EeB0nr2h/3NMbTtVnykXW/jOw?=
 =?us-ascii?Q?NirTPw0U/FOcuBmUpDXqOgeRPklkzxneW1GP/0kETsIg25X6eh6f?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f6559a-8676-464c-f6ce-08de64cd285d
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:42:24.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmlgkKbg7SE7Hz7ocm2uvgOFkNLAqzPePELftEEYHdWDSb/OZowVHSWQLbgTYItP7XtRU7NjWGHPox9Xqa3EtWxnrqISZ3vEvbD1GDkkWksY25WdNRnnH2ybArVw/oQs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14023

On Thu, Feb 05, 2026 at 06:19:48PM +0800, Xin Zhao wrote:
> On the embedded platform, certain critical data, such as IMU data, is
> transmitted through UART. The tty_flip_buffer_push() interface in the TTY
> layer uses system_dfl_wq to handle the flipping of the TTY buffer.
> Although the unbound workqueue can create new threads on demand and wake
> up the kworker thread on an idle CPU, it may be preempted by real-time
> tasks or other high-prio tasks.
> 
> flush_to_ldisc() needs to wake up the relevant data handle thread. When
> executing __wake_up_common_lock(), it calls spin_lock_irqsave(), which
> does not disable preemption but disables migration in RT-Linux. This
> prevents the kworker thread from being migrated to other cores by CPU's
> balancing logic, resulting in long delays. The call trace is as follows:
>     __wake_up_common_lock
>     __wake_up
>     ep_poll_callback
>     __wake_up_common
>     __wake_up_common_lock
>     __wake_up
>     n_tty_receive_buf_common
>     n_tty_receive_buf2
>     tty_ldisc_receive_buf
>     tty_port_default_receive_buf
>     flush_to_ldisc
> 
> In our system, the processing interval for each frame of IMU data
> transmitted via UART can experience significant jitter due to this issue.
> Instead of the expected 10 to 15 ms frame processing interval, we see
> spikes up to 30 to 35 ms. Moreover, in just one or two hours, there can
> be 2 to 3 occurrences of such high jitter, which is quite frequent. This
> jitter exceeds the software's tolerable limit of 20 ms.
> 
> Introduce flip_wq in tty_port which can be set by tty_port_link_wq() or as
> default linked to default workqueue allocated when tty_register_driver().
> The default workqueue is allocated with flag WQ_SYSFS, so that cpumask and
> nice can be set dynamically. The execution timing of tty_port_link_wq() is
> not clearly restricted. The newly added function tty_port_link_driver_wq()
> checks whether the flip_wq of the tty_port has already been assigned when
> linking the default tty_driver's workqueue to the port. After the user has
> set a custom workqueue for a certain tty_port using tty_port_link_wq(), the
> system will only use this custom workqueue, even if tty_driver does not
> have %TTY_DRIVER_NO_WORKQUEUE flag. When tty_port register device, flip_wq
> link operation is done by tty_port_link_driver_wq(), but for in-memory
> devices the link operation cannot cover all the cases. Although
> tty_port_install() is dedicated for in-memory devices lik PTY to link port
> allocated on demand, the logic of tty_port_install() is so simple that
> people may not call it, vc_cons[0].d->port is one such case. We check the
> buf.flip_wq when flip TTY buffer, if buf.flip_wq of TTY port is NULL, use
> system_dfl_wq as a backup.
> 
> Introduce %TTY_DRIVER_NO_WORKQUEUE flag meaning not to create the
> default single tty_driver workqueue. Two reasons why need to introduce the
> %TTY_DRIVER_NO_WORKQUEUE flag:
> 1. If the WQ_SYSFS parameter is enabled, workqueue_sysfs_register() will
> fail when trying to create a workqueue with the same name. The pty is an
> example of this; if both CONFIG_LEGACY_PTYS and CONFIG_UNIX98_PTYS are
> enabled, the call to tty_register_driver() in unix98_pty_init() will fail.
> 2. Different TTY ports may be used for different tasks, which may require
> separate core binding control via workqueues. In this case, the workqueue
> created by default in the TTY driver is unnecessary. Enabling this flag
> prevents the creation of this redundant workqueue.
> 
> After applying this patch, we can set the related UART TTY flip buffer
> workqueue by sysfs. We set the cpumask to CPU cores associated with the
> IMU tasks, and set the nice to -20. Testing has shown significant
> improvement in the previously described issue, with almost no stuttering
> occurring anymore.
> 

Tested on Renesas RZ/G3E.

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> ---

Thanks & Regards,
Tommaso

> 
> Change in v9:
> - Fix 'cannot create duplicate filename' problem, when create flip_wq
>   workqueue, use '"%s-%s", ... driver->name, driver->driver_name' as
>   flip_wq workqueue name, as suggested by Marek Szyprowski.
>   driver_name maybe NULL, do not create driver flip_wq workqueue  when
>   driver_name is NULL. Drivers that do not define driver_name are
>   potentially in-memory devices like vty, which generally do not require
>   special workqueue settings.
> - Fix 'NULL pointer panic' problem, tty_flip_buffer_push() now check
>   whether buf.flip_wq is NULL, use system_dfl_wq instead if buf.flip_wq
>   is NULL. Therefore, no longer need to call tty_port_link_wq() to link
>   system_dfl_wq to pty ports.
> - Set buf.flip_wq to NULL in tty_port_destroy() and
>   tty_port_unregister_device().
> 
> Change in v8:
> - Rebase code, use system_dfl_wq instead of system_unbound_wq.
> - Link to v8: https://lore.kernel.org/linux-serial/20260129103129.2928955-1-jackzxcui1989@163.com/T/#m8697be62ae18c8c7bcb677cbd96599c23b3dab4d
> 
> Change in v7:
> - Pty simply link to system_unbound_wq instead of allocating a custom one,
>   as suggested by Jiri Slaby.
> - Modify some inappropriate expressions in the code comments,
>   as suggested by Jiri Slaby.
> - Link to v7: https://lore.kernel.org/all/20251210125028.4174917-1-jackzxcui1989@163.com/T/#u
> 
> Change in v6:
> - Modify many inappropriate expressions in the commit log and code comments,
>   as suggested by Jiri Slaby.
> - Add reasons why need to introduce the %TTY_DRIVER_CUSTOM_WORKQUEUE in
>   commit log.
> - Modify the error handling related to the allocation failure of workqueue in
>   tty_register_driver(), as suggested by Jiri Slaby.
> - Add description of tty_port_link_driver_wq() in the commit log,
>   as suggested by Jiri Slaby.
> - Link to v6: https://lore.kernel.org/all/20251210031827.3771327-1-jackzxcui1989@163.com/
> 
> Change in v5:
> - Do not allocate workqueue twice when CONFIG_UNIX98_PTYS and
>   CONFIG_LEGACY_PTYS are all enabled.
> - Link to v5: https://lore.kernel.org/all/20251205030829.1829987-1-jackzxcui1989@163.com/
> 
> Change in v4:
> - Simplify the logic for creating and releasing the workqueue,
>   as suggested by Tejun Heo.
> - Allocate single workqueue of one tty_driver as default, link it to
>   port when tty_port register device or tty_driver.
> - Introduce tty_port_link_wq() to link specific workqueue to port.
> - Add driver flag %TTY_DRIVER_CUSTOM_WORKQUEUE meaning not to create the
>   default single tty_driver workqueue.
> - Link to v4: https://lore.kernel.org/all/202512041303.7192024b-lkp@intel.com/T/#t
> 
> Change in v3:
> - Add tty flip workqueue for all tty ports, as suggested by Greg KH.
>   Every tty port use an individual flip workqueue, while all pty ports
>   share the same workqueue created in pty_flip_wq_init().
> - Modify the commit log to describe the reason for latency spikes in
>   RT-Linux.
> - Link to v3: https://lore.kernel.org/all/20251027060929.394053-1-jackzxcui1989@163.com/
> 
> Change in v2:
> - Do not add new module parameters
>   as suggested by Greg KH
> - Set WQ_SYSFS to allow properties changes from userspace
>   as suggested by Tejun Heo
> - Link to v2: https://lore.kernel.org/all/20251024155534.2302590-1-jackzxcui1989@163.com
> ---
>  drivers/tty/pty.c          | 12 ++++++++----
>  drivers/tty/tty_buffer.c   | 15 +++++++++++----
>  drivers/tty/tty_io.c       | 25 ++++++++++++++++++++++++-
>  drivers/tty/tty_port.c     | 22 ++++++++++++++++++++++
>  include/linux/tty_buffer.h |  1 +
>  include/linux/tty_driver.h |  7 +++++++
>  include/linux/tty_port.h   | 13 +++++++++++++
>  7 files changed, 86 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 6120d827a..6c406c741 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -532,14 +532,16 @@ static void __init legacy_pty_init(void)
>  	pty_driver = tty_alloc_driver(legacy_count,
>  			TTY_DRIVER_RESET_TERMIOS |
>  			TTY_DRIVER_REAL_RAW |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_NO_WORKQUEUE);
>  	if (IS_ERR(pty_driver))
>  		panic("Couldn't allocate pty driver");
>  
>  	pty_slave_driver = tty_alloc_driver(legacy_count,
>  			TTY_DRIVER_RESET_TERMIOS |
>  			TTY_DRIVER_REAL_RAW |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_NO_WORKQUEUE);
>  	if (IS_ERR(pty_slave_driver))
>  		panic("Couldn't allocate pty slave driver");
>  
> @@ -849,7 +851,8 @@ static void __init unix98_pty_init(void)
>  			TTY_DRIVER_REAL_RAW |
>  			TTY_DRIVER_DYNAMIC_DEV |
>  			TTY_DRIVER_DEVPTS_MEM |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_NO_WORKQUEUE);
>  	if (IS_ERR(ptm_driver))
>  		panic("Couldn't allocate Unix98 ptm driver");
>  	pts_driver = tty_alloc_driver(NR_UNIX98_PTY_MAX,
> @@ -857,7 +860,8 @@ static void __init unix98_pty_init(void)
>  			TTY_DRIVER_REAL_RAW |
>  			TTY_DRIVER_DYNAMIC_DEV |
>  			TTY_DRIVER_DEVPTS_MEM |
> -			TTY_DRIVER_DYNAMIC_ALLOC);
> +			TTY_DRIVER_DYNAMIC_ALLOC |
> +			TTY_DRIVER_NO_WORKQUEUE);
>  	if (IS_ERR(pts_driver))
>  		panic("Couldn't allocate Unix98 pts driver");
>  
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 1a5673acd..1a2b29135 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -59,6 +59,13 @@ void tty_buffer_lock_exclusive(struct tty_port *port)
>  }
>  EXPORT_SYMBOL_GPL(tty_buffer_lock_exclusive);
>  
> +static bool tty_buffer_queue_work(struct tty_bufhead *buf)
> +{
> +	struct workqueue_struct *flip_wq = READ_ONCE(buf->flip_wq);
> +
> +	return queue_work(flip_wq ?: system_dfl_wq, &buf->work);
> +}
> +
>  /**
>   * tty_buffer_unlock_exclusive	-	release exclusive access
>   * @port: tty port owning the flip buffer
> @@ -76,7 +83,7 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
>  	mutex_unlock(&buf->lock);
>  
>  	if (restart)
> -		queue_work(system_dfl_wq, &buf->work);
> +		tty_buffer_queue_work(buf);
>  }
>  EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
>  
> @@ -530,7 +537,7 @@ void tty_flip_buffer_push(struct tty_port *port)
>  	struct tty_bufhead *buf = &port->buf;
>  
>  	tty_flip_buffer_commit(buf->tail);
> -	queue_work(system_dfl_wq, &buf->work);
> +	tty_buffer_queue_work(buf);
>  }
>  EXPORT_SYMBOL(tty_flip_buffer_push);
>  
> @@ -560,7 +567,7 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
>  		tty_flip_buffer_commit(buf->tail);
>  	spin_unlock_irqrestore(&port->lock, flags);
>  
> -	queue_work(system_dfl_wq, &buf->work);
> +	tty_buffer_queue_work(buf);
>  
>  	return size;
>  }
> @@ -613,7 +620,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port)
>  
>  bool tty_buffer_restart_work(struct tty_port *port)
>  {
> -	return queue_work(system_dfl_wq, &port->buf.work);
> +	return tty_buffer_queue_work(&port->buf);
>  }
>  
>  bool tty_buffer_cancel_work(struct tty_port *port)
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index e2d92cf70..a8674a20a 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3446,10 +3446,27 @@ int tty_register_driver(struct tty_driver *driver)
>  	if (error < 0)
>  		goto err;
>  
> +	/*
> +	 * Drivers that do not define driver_name are potentially in-memory devices
> +	 * like vty, which generally do not require special workqueue settings.
> +	 */
> +	if (!(driver->flags & TTY_DRIVER_NO_WORKQUEUE) && driver->driver_name) {
> +		driver->flip_wq = alloc_workqueue("%s-%s", WQ_UNBOUND | WQ_SYSFS,
> +						  0, driver->name, driver->driver_name);
> +		if (!driver->flip_wq) {
> +			error = -ENOMEM;
> +			goto err_unreg_char;
> +		}
> +		for (i = 0; i < driver->num; i++) {
> +			if (driver->ports[i])
> +				tty_port_link_driver_wq(driver->ports[i], driver);
> +		}
> +	}
> +
>  	if (driver->flags & TTY_DRIVER_DYNAMIC_ALLOC) {
>  		error = tty_cdev_add(driver, dev, 0, driver->num);
>  		if (error)
> -			goto err_unreg_char;
> +			goto err_destroy_wq;
>  	}
>  
>  	scoped_guard(mutex, &tty_mutex)
> @@ -3475,6 +3492,10 @@ int tty_register_driver(struct tty_driver *driver)
>  	scoped_guard(mutex, &tty_mutex)
>  		list_del(&driver->tty_drivers);
>  
> +err_destroy_wq:
> +	if (driver->flip_wq)
> +		destroy_workqueue(driver->flip_wq);
> +
>  err_unreg_char:
>  	unregister_chrdev_region(dev, driver->num);
>  err:
> @@ -3494,6 +3515,8 @@ void tty_unregister_driver(struct tty_driver *driver)
>  				driver->num);
>  	scoped_guard(mutex, &tty_mutex)
>  		list_del(&driver->tty_drivers);
> +	if (driver->flip_wq)
> +		destroy_workqueue(driver->flip_wq);
>  }
>  EXPORT_SYMBOL(tty_unregister_driver);
>  
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index fe67c5cb0..54359310e 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -99,6 +99,23 @@ void tty_port_init(struct tty_port *port)
>  }
>  EXPORT_SYMBOL(tty_port_init);
>  
> +/**
> + * tty_port_link_wq - link tty_port and flip workqueue
> + * @port: tty_port of the device
> + * @flip_wq: workqueue to queue flip buffer work on
> + *
> + * Whenever %TTY_DRIVER_NO_WORKQUEUE is used, every tty_port can be linked to
> + * a workqueue manually by this function.
> + * tty_port will use system_dfl_wq when buf.flip_wq is NULL.
> + *
> + * Note that tty_port API will NOT destroy the workqueue.
> + */
> +void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq)
> +{
> +	port->buf.flip_wq = flip_wq;
> +}
> +EXPORT_SYMBOL_GPL(tty_port_link_wq);
> +
>  /**
>   * tty_port_link_device - link tty and tty_port
>   * @port: tty_port of the device
> @@ -157,6 +174,7 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
>  		const struct attribute_group **attr_grp)
>  {
>  	tty_port_link_device(port, driver, index);
> +	tty_port_link_driver_wq(port, driver);
>  	return tty_register_device_attr(driver, index, device, drvdata,
>  			attr_grp);
>  }
> @@ -183,6 +201,7 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
>  	struct device *dev;
>  
>  	tty_port_link_device(port, driver, index);
> +	tty_port_link_driver_wq(port, driver);
>  
>  	dev = serdev_tty_port_register(port, host, parent, driver, index);
>  	if (PTR_ERR(dev) != -ENODEV) {
> @@ -210,6 +229,7 @@ void tty_port_unregister_device(struct tty_port *port,
>  {
>  	int ret;
>  
> +	WRITE_ONCE(port->buf.flip_wq, NULL);
>  	ret = serdev_tty_port_unregister(port);
>  	if (ret == 0)
>  		return;
> @@ -257,6 +277,7 @@ void tty_port_destroy(struct tty_port *port)
>  {
>  	tty_buffer_cancel_work(port);
>  	tty_buffer_free_all(port);
> +	WRITE_ONCE(port->buf.flip_wq, NULL);
>  }
>  EXPORT_SYMBOL(tty_port_destroy);
>  
> @@ -703,6 +724,7 @@ int tty_port_install(struct tty_port *port, struct tty_driver *driver,
>  		struct tty_struct *tty)
>  {
>  	tty->port = port;
> +	tty_port_link_driver_wq(port, driver);
>  	return tty_standard_install(driver, tty);
>  }
>  EXPORT_SYMBOL_GPL(tty_port_install);
> diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
> index 31125e3be..48adcb0e8 100644
> --- a/include/linux/tty_buffer.h
> +++ b/include/linux/tty_buffer.h
> @@ -34,6 +34,7 @@ static inline u8 *flag_buf_ptr(struct tty_buffer *b, unsigned int ofs)
>  
>  struct tty_bufhead {
>  	struct tty_buffer *head;	/* Queue head */
> +	struct workqueue_struct *flip_wq;
>  	struct work_struct work;
>  	struct mutex	   lock;
>  	atomic_t	   priority;
> diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
> index 188ee9b76..f77af6472 100644
> --- a/include/linux/tty_driver.h
> +++ b/include/linux/tty_driver.h
> @@ -69,6 +69,10 @@ struct serial_struct;
>   *	Do not create numbered ``/dev`` nodes. For example, create
>   *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
>   *	driver for a single tty device is being allocated.
> + *
> + * @TTY_DRIVER_NO_WORKQUEUE:
> + *	Do not create workqueue when tty_register_driver(). Whenever set, flip
> + *	buffer workqueue can be set by tty_port_link_wq() for every port.
>   */
>  enum tty_driver_flag {
>  	TTY_DRIVER_INSTALLED		= BIT(0),
> @@ -79,6 +83,7 @@ enum tty_driver_flag {
>  	TTY_DRIVER_HARDWARE_BREAK	= BIT(5),
>  	TTY_DRIVER_DYNAMIC_ALLOC	= BIT(6),
>  	TTY_DRIVER_UNNUMBERED_NODE	= BIT(7),
> +	TTY_DRIVER_NO_WORKQUEUE	= BIT(8),
>  };
>  
>  enum tty_driver_type {
> @@ -506,6 +511,7 @@ struct tty_operations {
>   * @flags: tty driver flags (%TTY_DRIVER_)
>   * @proc_entry: proc fs entry, used internally
>   * @other: driver of the linked tty; only used for the PTY driver
> + * @flip_wq: workqueue to queue flip buffer work on
>   * @ttys: array of active &struct tty_struct, set by tty_standard_install()
>   * @ports: array of &struct tty_port; can be set during initialization by
>   *	   tty_port_link_device() and similar
> @@ -539,6 +545,7 @@ struct tty_driver {
>  	unsigned long	flags;
>  	struct proc_dir_entry *proc_entry;
>  	struct tty_driver *other;
> +	struct workqueue_struct *flip_wq;
>  
>  	/*
>  	 * Pointer to the tty data structures
> diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
> index 660c254f1..d2a7882c0 100644
> --- a/include/linux/tty_port.h
> +++ b/include/linux/tty_port.h
> @@ -138,6 +138,7 @@ struct tty_port {
>  					   kernel */
>  
>  void tty_port_init(struct tty_port *port);
> +void tty_port_link_wq(struct tty_port *port, struct workqueue_struct *flip_wq);
>  void tty_port_link_device(struct tty_port *port, struct tty_driver *driver,
>  		unsigned index);
>  struct device *tty_port_register_device(struct tty_port *port,
> @@ -165,6 +166,18 @@ static inline struct tty_port *tty_port_get(struct tty_port *port)
>  	return NULL;
>  }
>  
> +/*
> + * Never overwrite the workqueue set by tty_port_link_wq().
> + * No effect when %TTY_DRIVER_NO_WORKQUEUE is set, as driver->flip_wq is
> + * %NULL.
> + */
> +static inline void tty_port_link_driver_wq(struct tty_port *port,
> +					   struct tty_driver *driver)
> +{
> +	if (!port->buf.flip_wq)
> +		tty_port_link_wq(port, driver->flip_wq);
> +}
> +
>  /* If the cts flow control is enabled, return true. */
>  static inline bool tty_port_cts_enabled(const struct tty_port *port)
>  {
> -- 
> 2.34.1
> 
