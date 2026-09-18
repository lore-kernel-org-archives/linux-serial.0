Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1444FE2D5;
	Fri, 18 Sep 2026 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741277; cv=fail; b=BIIr+nuCpjl7HreZJPw/nH+wx3odCfQqooGtSB1Yu60VuHuh5qGEiMJLcLTcGtCWTRuXB6pRIVvBErGESAvp7t32wBB3Mr/x/Fu7UfB6BckznbyB40DrGxeQjo8+VCpkAP7i0PmkRipUskBENjTfUp0Z3kx3ddLCCbbds42HPs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741277; c=relaxed/simple;
	bh=FBRjRFtTBPawkvahLb2KbZudhv/rSQ1Tn43YP4AaPj8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jR0r1C5tHMj31/G3Ho3Yez3GiZUinJ0WS4IUJtgv2xaTTq8Xp/ywDwYQhVm3Ke8jLArweE6awTe0JMs2g7AD0JIzXOnGe4FlZK55RoDh82cryfAc/sXE/as7lQ2sUoHrkt7BBK2HIw8zwc8XjF+ArTZC0AuUAKQOLka0su+0CNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=shcEyYmj; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="shcEyYmj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXxbMWgPRa2qfxm115dhZP8Ul2rI7wMkhVoSAK1DwJ024va/gQ0K8aHm00aUE81Xi7q5HtnJjN6RZOR2+u5GXBkos4g24f8jlYM3yAlqIoIkWo/SCgZ1HyrEinzgykY1PYv+lmguv8/0qBA8FZahlzRm/1L2O8UQ2soY8BKlGZAin+IREDXrlGx3pkfa292quHK2VoD5vFt8BP2JKqhYcAkxDTRiniEk/UJUVKvmnmwNGYPjwKLUSJP6XyAExu3r+Ltq2BsIo/pT4QyOpoEX7YrAk0onZNsHrNCsjptl/4QeTrWfF7YQe1goqPM7cSDl43serL0TrNpG8J32VF0lGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wNuHPtm4JuuIr3zjQAcbbirUuSbdXgYbfwlndLXnRQ=;
 b=l3dExR/Vui9OL3LAcsBbjSOc/4jc/DMLEUApwQ+AcOnqns021EP6dQ4TPCRmGgA0xmriS4qUh+dO1yc7lujsRelALyNEJoJ4nVSMzJQR7/HbK9sgoLbQzjjKHJFFiJE9Bs5J2DzWyIi+8TDgKXxAYScUPPt+bkHm5Y1ewclhE8C/rBS0OXBf6lxdSboUJa+bgw1XMiDVGuufs4+YjMXM/S1VDJy6b5xLP21risfKioVYUcvzAtTurVBASdY/7NN4FWEw1Rg0TIsxJcmjOufuNAXO+QhkpjB88krQN2sNLMiH4h9kH+fSRuNjNrYFwUwUmn9mSOJaX/pi+aFkAce1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wNuHPtm4JuuIr3zjQAcbbirUuSbdXgYbfwlndLXnRQ=;
 b=shcEyYmjIOofQTL/e+kzITm+v6tBQP0TMQE1i/N3h4l/kMpvsKeISpyazEjCM3nmADUtq6qXotZmGPfrSR8oaRVjAhdaw+dCg01ZiN9loeEXFlS5HeM30tvvHbXqkKmgf/c6HFyzzNo9LYXtFifdJPPpzXBzdYoH7TfGftXcJuDjNZNTK/spdEpUOetRkIiHpmAXxw5jXN9++8Z9c2W/M07ZH9BN55+MBFHl0NxvrkxEanDW1rN6RZY4R3SbNdq5lMrSAeVIX1gvRwMOPK0u7JMC93peJ3YUTjOaAH0kHn4um+Ek3D6gPkRs+0JC5aTM2PS2RQaRqauXPxgnzKq55A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GVXPR04MB10069.eurprd04.prod.outlook.com (2603:10a6:150:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:21:10 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 14:21:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: use assign_bit() where applicable
Date: Fri, 18 Sep 2026 22:18:41 +0800
Message-ID: <20260918141842.3023147-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GVXPR04MB10069:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e1dc4c-fcef-450d-fb48-08df15901637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	QhgF0Wf9Yn1yIoeKCXLor/nPEeab46df2/sUowizv2NW6slceGG8Fn/F/Zsusm34fmJiQD62le0Y+db6J8agrCCrWPKiR7obVBx8KdZUNIyIWpE4Pk6H5fkyWoKEjKXiAitIpplUWMB1YlW0Cul5iCXDQYqEIpKw5lS65B0jnGD+i1SscjtVE5vWijCVIIKhGrzf9JQyjksq5QgVwLG+neDX00suu9uS5rb9P//9AN9lSvfo54gQEsUdomvgmLx6V1JKfIOPgBo5offX9BJ2gaCPX0x6laR2hQpnbN/RsH0umkKnh6TG6qy3Lq80KYJDWVqCkgJoJm2kvSE1wWdJWxIXsh77uApoXZK37StT2YGZ+KhWzuMWvr3iwPnpscC+D2vMDLDlAClGXHJa2eLVuheDM+LZFPCQ+AV/WSq3dgONVoRHCigjcf+Yz9NpNLkR3IC4oOlWMgvQCCNGWSRl1YsgCW38rMgV4m19KTGPJMMpVEP5Z9zxfdVGOdTlfw38eXzpBnrJ/4ICFBkDknuPPj4HT3WYhtvUdVOOjLEdMOdudcqK/S3lTM2cpPYef3iIJcIPezjDjI3rBqeFd6KzwkvYyJXZq7agz5b1ekjZiUB+nBIqj8zub1R7Sl3xxfShaSeiGavrjL9tpAgkr3AivgRoo7Be87Q2qbmUN46Kk3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M3P/jeL9zrpO4uDuWpAAcO09Ua+aAAFemzZu9zHJvyRl5LMl8MS9JBPaXdUG?=
 =?us-ascii?Q?2pTHSY9phlNT4BP5BqkJBxIojjxWob2WFT8t/hA+v1sJo170HeX115CVZKaf?=
 =?us-ascii?Q?fA3rN2diQqp2EsY0Ro34VQy4cH3M4hLNX3l4PzNXFaJ8CmUG8slH15kp6e6I?=
 =?us-ascii?Q?G/2duViXp2dFVeJQFHKYGo+YLwiQhNlKs5J7kSjNaHfNa5DlsADZH9BEy2SY?=
 =?us-ascii?Q?PAorIn2OOs25JVnUhQQ7DlwSaSS1eX30mqAzU2zeb/Y66vY5kxfW8gwAwstW?=
 =?us-ascii?Q?vuFMNeabnWIPNySuNFV8nyxXI+jKFQl4cB7EOxz3gJWY2q5llmoBbvwlnm8H?=
 =?us-ascii?Q?x6pKpmqv+ksx71U0RAnTKDuGK0q2kDaVAcnNrWztjmKL82RcHQc4D7UAzCFQ?=
 =?us-ascii?Q?T28ewFxG/2BHW3IjHmSkYXITjaogFvTOkBElfL7jELpqZMi5J3FFzconHUbx?=
 =?us-ascii?Q?J4wVgMEzWH8c7/v/apRrTMgZcMK0QUa+97kBatzsaUL44bkf2RQh2RqiNra3?=
 =?us-ascii?Q?zd0ist9X9Qn6WhLRJ3M6/9Kt9xdc/zdmY4jqbM6Th4VfJDHfo5nRnHAEZHBC?=
 =?us-ascii?Q?W9i9UaeACnQv4x2AyyQq3VWoRCymHHfxvqdr5RCWN4hbYDgR031EzBUr5vEi?=
 =?us-ascii?Q?MoYoQuIp2atSFlEbF7B1BMSWYn/a796t6BdSwkh27tD0g/ZZ+XmzwwUfxCTi?=
 =?us-ascii?Q?Vu2ufloNhywvWj7MmnTOdBPctfrHmzvlwzCF7+7QBOAymhn4paeTEZctQdPf?=
 =?us-ascii?Q?mu6geC7SJfmWi/lAa0P3meGocwG/HaUR2pcuPBF16KD5KNAPEmgl0mtCU9wh?=
 =?us-ascii?Q?L/NhKPtU268fNkTmm8XXKqmn4FSUIIEOy+Q2MAyUTk91AGBN0Amw4CB88vxp?=
 =?us-ascii?Q?wqmkdeVhGToflOA4P8sVGR5m3AyQAhpQku4ujdDmcURK5rBcATb5PgHBx6xh?=
 =?us-ascii?Q?ej7PE8S0UJsfvEbjsnBUzRFUZMdjl7klJ2Gsb3pFDXZhyz7mMYdLK1N1wH+K?=
 =?us-ascii?Q?0zO8kDJPi5Bb/pqTecL49dXgiTGvY6iUHQ5/4MkVHUKrvmG3tlgA8F5ClRux?=
 =?us-ascii?Q?5TNd5Dvi+dYEHCpCRVc74ysXZftwoedV5rDENB8aepj34XHVz4s7LEJEsi8S?=
 =?us-ascii?Q?sv10Neypsb0zGsrl6i2ghcfMsetvqASsI3LLGAMsQAJWZKqAKY5YzBtIzDF6?=
 =?us-ascii?Q?Ur/NFE6OWOmIWcRYGmPrvt6kUYPn/+e5NW0jP9aFwVhF0W/rCTJC4I/mroWH?=
 =?us-ascii?Q?TemHheAq3aOpyrgeMvx4pYxlcwsbBVvJN6kpb0xvdzvY/GlFO7RVHuWegLnr?=
 =?us-ascii?Q?Ig8K3uJBbA8WRZj1sxE0TKfjucvzv8bmFdQI5sCggRhc5+yzcHj4Z6fLF0i8?=
 =?us-ascii?Q?oxzBjkk2BvofRXf8C1hUbQUl7b7AELJK3G4PVTK9MUV3+Ij30cX/DlSv/rD+?=
 =?us-ascii?Q?6fPDBs2/ruTT0FDXAUw8jSdd0zo9gK7ZXx3KLu7AP3RizBFu2rQCw9TwbGRg?=
 =?us-ascii?Q?mLbXbvRnJOzuKw/TGIzBk+Nhda0tKLFw+ITFjXTjlkZdRFIL6VnBXo74b7ck?=
 =?us-ascii?Q?x9CWfcTwcvDmDXsooJFhDkw6rlIYZ3S1y4OzacPIPIzJl1u4lN9ZYKmnZcfw?=
 =?us-ascii?Q?5ZC1hzHKoW+SVyNjinDmFlyjPU+EAyc8xfo0pA71hHK+n10TTQoCzhLcvG8K?=
 =?us-ascii?Q?Jy+WnwilIGLGcVM71hNeZB84EDGu56YkYbn3FMlZ+9Zye2sEmu2nEjkxy/WR?=
 =?us-ascii?Q?Kp6WoSwzvv4wT/Bdza1p/NWCgRRRa8NQi9X/ba/PuVf2cr4uBhb0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e1dc4c-fcef-450d-fb48-08df15901637
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:21:10.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAi/0VppUcWQWl3d0lkCLRpbE9oTcLxUViwoP4zsgfXTykL7HL3Q+Q/nSKd/loAO0eoH19qSXYxQqDEor3o9roRu6z9Lvp0aXZ/UFz7rKj450ff9LVatldDAadNgR32s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10069

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit and their
non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
API.

Done with Coccinelle semantic patch.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/tty/pty.c   | 5 +----
 drivers/tty/sysrq.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index cc7f7091ed9a..9a37008c4e91 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -138,10 +138,7 @@ static int pty_set_lock(struct tty_struct *tty, int __user *arg)
 
 	if (get_user(val, arg))
 		return -EFAULT;
-	if (val)
-		set_bit(TTY_PTY_LOCK, &tty->flags);
-	else
-		clear_bit(TTY_PTY_LOCK, &tty->flags);
+	assign_bit(TTY_PTY_LOCK, &tty->flags, val);
 	return 0;
 }
 
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c2e4b31b699a..f4571d05b496 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -911,10 +911,7 @@ static bool sysrq_handle_keypress(struct sysrq_state *sysrq,
 		 * keyboard state so we can release keys that have been
 		 * pressed before entering SysRq mode.
 		 */
-		if (value)
-			set_bit(code, sysrq->key_down);
-		else
-			clear_bit(code, sysrq->key_down);
+		assign_bit(code, sysrq->key_down, value);
 
 		if (was_active)
 			schedule_work(&sysrq->reinject_work);
-- 
2.51.0

