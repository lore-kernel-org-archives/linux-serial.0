Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013000.outbound.protection.outlook.com [52.101.127.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312B3E5EF8;
	Wed, 22 Jul 2026 03:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784692017; cv=fail; b=KyWQot+IkOegQ+VV3fYsLeFZUp9eblzKkil51mOjehPWkp1l6IVzJLmaUtJuHUpPVwCOW9L/xq4PA6kypewLffXYgrEpQYb/Sva0WkBBWtXod7CLL51mEw/klWcAbq1OH/TCFdoWFSf/RaxkM4gp99lEwuo1RbzH3qKowZVWUdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784692017; c=relaxed/simple;
	bh=m23Tm7zAsPayU/cnS1wCiXqKnpmIU+fItslFMoGT3nM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cEDh8UEKgaTSm5qwNvwxG0/irtY/Gc5S2n3/nDVHHZNLr9+NBrMV42fBA4jRPcwB6dpf31SI+l42UgIYSn0GkE2zw3SHGTTsPa6j+ahCgbkVkzLP5VB9eZlEq/Rkkna2B/yi0jUVPFyb/d6DPkEarLgZgAbrxKXKD8D/8jprlrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=N/oMahQf; arc=fail smtp.client-ip=52.101.127.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="N/oMahQf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuWtjXjGCmVkIAArq2/xvtfJ2gtg7e2+djsBfTmLw8WMDkFfVTBUJku4sYLHtC0+g/2oSmyOU8W0+9GRHi+5+q+5COSqxcmpHhjb9kR4lBIgytYDYNDGUarM57JTz8WjsjEuSTS/7yYFpkGILI7OjdAuybNdOjCwBlV2ajDRD1XrnQu6bxKIMSWGrq3pdug5BSWosDAXuJCzWDyB31aWD7Mf5Ta+JNC+M2IaPVU1Wgc3GJ0ggC3ikIsrWuxYnXPkrSqyLYjUinBlHX/4Cd9cV/qlqiylGnOTsM9r9sB/u+ZRfn9E6x6c6EpiMdKIfliBXJrY8N/jiyRIdQkNGbq+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HllCaQAA9Sw78s8S22XffyjiWGbeG9t+JBnIWIqF7wI=;
 b=XcjUiwJwJfVBAEMlynqO4HaqNXX8BTAnDB3o6/GvsH07GD/gDkQ833cDxrJrmxzr+ZJcrZeJfNKex62ZjIrVNiQvyHqFxzC1Z8vzXYv3AcIMUfBSzJnjFHBxjsYVnR8y8RNzoe8bxXZpbJt7Z3kote2UmTsC9DwT9sEgCY1rVYYlPK2pMj/GjgYNwgCSEg6k+GbdJtR9hUc8f33xHiKWbUblgT9RDIQ75ILCeIzPLTH4pFWs3zziAb/B/x6kgiJ/PH0cIZ6449LFjwXpfaR6snf4V6Mv9MNpqLux0brifLPkqfEePkJtuVWYgc47EADk/4ZIBccpbu07sHh2yVHVPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HllCaQAA9Sw78s8S22XffyjiWGbeG9t+JBnIWIqF7wI=;
 b=N/oMahQfpJsK2HnEgfhN4UBLnDYYKQxwVP4mIFeliixdlwSEI9S+vbMOrwW08IODSU9XFaeCZcL3JOGIG3Dwv0m063nasm6TT+veunjiay/b/cg8dgHvY7WUhRxWLs752XZEb/so2wYjMBikBcxg4mGl60xCUR5G2PBvxuI0xkntwd0g75V4d9biYtVayUI2DEisSGZCn43EhQ3iB7POMFQcORHk8uMaceB6enxAUpXJ1oBvXeoXm5R6DX5PDy30B2uF+/cP/U2AQiBKnKA8r5AKprpUATRmk+8uJk1BFfnaDpUwo+gpUTa+c6EcxnglqGrjM4T0Ypkhnqce/ABvgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEZPR06MB8863.apcprd06.prod.outlook.com (2603:1096:101:33a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:46:47 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:46:47 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	Pan Chuang <panchuang@vivo.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Cixi Geng <cixi.geng@linux.dev>,
	Wenhua Lin <Wenhua.Lin@unisoc.com>,
	linux-serial@vger.kernel.org (open list:BROADCOM BRCMSTB UART DRIVER),
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE)
Subject: [PATCH 0/5] serial: Remove redundant error messages on IRQ request failure
Date: Wed, 22 Jul 2026 11:43:28 +0800
Message-Id: <20260722034342.316755-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::19) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEZPR06MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a26c630-e557-4e56-9672-08dee7a3dab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|52116014|921020|38350700014|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GNcOeUXkkgfkvaELM/SrOowrHTCMLc01rc0sQyyx2zehhXPKtWjJ8jilx+uPpFqhiMgC+OIk1xPxQX3OsUvb+oybysBWUsQDV8yRIfMaLmmjKlHZg00oN0e/r6Tqhq1fB7t+i3U1sz1+/I5VtyHwcCE1TxjpTXDGzXCPq+AfdetOU9qkyB7w/cpOq7pzbuOWh+HFv9maz9BQNGZC3bG+oPp/QGylLlW5W4gEkxAKuPt02TIYFuSPotZ1tMl3HyVKkDhDu+UM6Z7+309ny+Zett1TV9+T+zMTDt7ocFQ1j+wbqB2r2qGEwKec3UMTq+CS59b0jO6rO6BsVX0e+bDcZbCbr65pWNy6gIIOcHvhWovxOni+FYrz50t1CACz1X0Nkdc8Vz70HdmptKpsSLtcVoudcTB15iNR3rIcZSZ6xFpkfX9fJawZVM4VYo2xL4ZGrZJZOG+MkHzU95xkR9rCHMwLx/6AV5SXvECqKUW98M2hc0JoreQRqGLmXxAbMVhOBq3sJ06UwrcnT9DIzs7Z8IQGW6IscKCAJaGWgu6RRgogsvbIihFrmtfR9NH6vRvXrncsefjmx9/83TEaQpfRk4sFvR9i9uK0ni/oEvXFmYIvIgFGonymIjAmlyv10ax34ZrhRr7nrYxamsaMJ2ZB8FzIfs/hMNEdrnArsqykVkTe3Ldkv4MJR1CxxyJdZGWGq+3g23nSGviJVhaRrKa4FjEDqjYASe4MbhN6ymwPj02K1bFMHeCQYtJPci4BMn05
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(52116014)(921020)(38350700014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PqvKARG7u2U6Z0rlHyFM71lLrcsLIVmDyzNU/dGksYLE1vRpmP7MUfBMT8K?=
 =?us-ascii?Q?BdPfcQKA6Eeje8P5rbSpi4OsKJcsomUv+gjULaqm18Epm5tYdtDK7UCn0utn?=
 =?us-ascii?Q?iK0jPuEFqpijao1LAAmCfyl5LTb1BDH2QDrtzxoLzpVlE83Df8HdqHLZ4DDm?=
 =?us-ascii?Q?PXqgrkxwjWlzTpJsJwngedmnmhF99VgIkhPvKgoMOK2NqCdPvANzEPSmCQ0k?=
 =?us-ascii?Q?3sfBcj6HEnW+xHS/OZsLMucvYPoTenhfkYGXfbbgMrli8oWPGFfcUuyGEOxo?=
 =?us-ascii?Q?vVJwkRcUmf3kAmue8J7qgq14plqK7jHrI50X8xF0EOkGioUgcYl3pWa+v2tZ?=
 =?us-ascii?Q?KwZWh2JF/klSotF9eX2j+F1XWX3TBhjXre950q47nqnolPvYWKVZPUwuV7P0?=
 =?us-ascii?Q?JPp8+u8NQugnBVuPMwPHpptLwwU3XO60zWUL4nff4i0iMa0YdLPe8nTajm6R?=
 =?us-ascii?Q?g+Ov545joVCF+cXwG84iI9Iek6OxsAmDPJorldmET0QMonXfTKZU+2f0typc?=
 =?us-ascii?Q?o7HipMWCg6RoFlgUovsHimDXRqKgOvLueSWohR4aHvsoHhWUMGjc4T0hzhAi?=
 =?us-ascii?Q?Sp1dquthxXiy7HmqZ1drQpBzJXqz2OTTdR2eeSNDQ21oLDzxoZ5gwGC+naNW?=
 =?us-ascii?Q?fVEaYn0/XsBjvGhV79ZVoQWHj6cDOufoz9z0cVc/NBm7wxEdTAhQOycwOLNe?=
 =?us-ascii?Q?ga6bNG9S1z3cgM4TOdrKeL5byQzxlI5nYYck5eGWra0AtBFTqkFUs2hkNYq6?=
 =?us-ascii?Q?5YGL3CPJzTqOXYLwNNUYBYWAr3U3xOzOTchwiJsifEWMgU4JE4B0MIwyXw4/?=
 =?us-ascii?Q?HemDg5Wby5yR7wLj7A6Bz1Y8uTSPvnI9ADFGuSjxrK47vYZf7Oo+lyTT39yf?=
 =?us-ascii?Q?/ObORo2f3F8ribW074GvOZ89ZiYDG4/VD2lyJplNnFuTxIAQCNPQ3neH42f3?=
 =?us-ascii?Q?o+pow1sxu167dnGZqYHUIgtuzqfZc1feiN3UxrUhIn8qhsFvvkinkVz3q1vy?=
 =?us-ascii?Q?9GDwGfcGpkDnf2TwQfTn2EZbl34OeVniBVw7gWSgtIw9oHCLlAFOvfWpbxxZ?=
 =?us-ascii?Q?HA+esi2ALOWskEHJUnD3g3/B4R2MJak5Ff1eTRsY8a/dKLealxHP/7GerVOZ?=
 =?us-ascii?Q?YHieUsA8oeJp4HTESrjpavx3GE/mGknVLdKDUjL9uOKukBTY69agsbNhxxja?=
 =?us-ascii?Q?uyjkNHfHzKqlzb6fXd+JsA0/0BPHv7Rud4rP+IxCkCWzvwMEC9ArZftIbOpO?=
 =?us-ascii?Q?4bM53TDNWpynMcfTWCXkc2DXDMTIzaM6I6gC0nhgreOS5NilUwQHknYqEgxu?=
 =?us-ascii?Q?T4x5H698p1epYftajmMLsSBvcjmZ7ZgdXo7AYwcwwq9pCtD327P42Ggfl3Ks?=
 =?us-ascii?Q?QYqR0a0Zn6GMooIUXBwJE1BAWwX7vkLpIxMi/NMrlLgcUkPVjV1j861/KiVD?=
 =?us-ascii?Q?JdtHNzFO7QYO7fujtQPWzSfkaNZqekT/j2kSWzrZEpKoohTs92c/NGELG8y8?=
 =?us-ascii?Q?GVJivZTDwUmWqSbH31pS2HPn/dS4P1OsEW4xZXNNXn90owXk+u3EbNWn80b/?=
 =?us-ascii?Q?HRlD/S/avBxdAU453uVK7ZXFgBO96tT++KXPd2rquZl1No+624F09rXFxJkM?=
 =?us-ascii?Q?8n0UHUm0XddNr3ZZW8iLnfjSGTIUomay67ciP0g8teuuaxjfQzrJrq+fnz9t?=
 =?us-ascii?Q?4spgh74VcCBg+0vsv3cQ0dDpKg6LkO1e/SWWEhhs4PETSKlobt+4+akK/FVI?=
 =?us-ascii?Q?nHYiUES8mQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a26c630-e557-4e56-9672-08dee7a3dab0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:46:47.0281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdmnp/I/AHgb8jCKoSH8yA1nn9gWOEdQDtUxq2CWbspNlg0fuZWKtBPxykXoUXArNIsygORfoxMl8fW/hU5+iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8863

Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()") added automatic error logging to
devm_request_threaded_irq() and devm_request_any_context_irq()
via the new devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in tty drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (5):
  serial: 8250_bcm7271: Remove redundant dev_err_probe()
  serial: imx: Remove redundant dev_err()
  serial: mvebu-uart: Remove redundant dev_err()
  serial: mctrl_gpio: Remove redundant dev_err()
  serial: sprd: Remove redundant dev_err()

 drivers/tty/serial/8250/8250_bcm7271.c |  4 +---
 drivers/tty/serial/imx.c               | 19 ++++---------------
 drivers/tty/serial/mvebu-uart.c        | 12 ++----------
 drivers/tty/serial/serial_mctrl_gpio.c |  3 ---
 drivers/tty/serial/sprd_serial.c       |  5 +----
 5 files changed, 8 insertions(+), 35 deletions(-)

-- 
2.34.1

