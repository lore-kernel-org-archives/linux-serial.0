Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793803941;
	b=fbzb5OYA7TaHiucmW4jMrZvzhfmD7xlUF3n6vWXiVAtzvWFyxw6z41pL7xozJnOQ8arm
	 wCuWu9Xp2Zug9R1htaPhDjis4o62hW7EahxdDY+uhMKpvozyNFwcJWDP8Jdpfu1v3kcsh
	 FndbW3kbTAc8gx6KF0HGpTg9d6PCP8Eb7mhB7ntpir8+vTJMZ8gDEv6WinV6MHqvdmw6I
	 z4gnl1Ya2ZYec35tavbPKjauk+HQGQVRaplU9/gY0D84KNl0GkQcVia0gtR2N2DvCC1ye
	 LglqXiCs5rAN1zXbC9Ies26WBTY+IvZ12ZbctpwJeFd3cDlliWnRpkVaSyiGKbNIR2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803941;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1gSbwe/rw1E7pfTR15Ze8uler1pIoBCZ5jHqWPhnaFQ=;
	b=WyBRUPCcqUfnwpRYfRCa74AUevO8zSWfgJRH04X0ep4c0Z6x72bEGWvc+mEZubnyMUdo
	 uFNyIvFE5ezaYRi5zmET9qcXlHRtLwAh0GVBVA5FLLgaddz3wVptlImN/v62GyqrBI8QJ
	 rwUE5tBUDWAPw9ULFrrywNPX/r6984esxvpYSGQcMRw0pV49FZHoLXGcJXvnpL/bH0534
	 hqKpDamZxkOsldPApy3A17VIfpU1P4CcsaFp0MCuYchkgFpFdKuaXWAfAw+da78lwkjzk
	 grmqfEDBaWb6//RlW9JgYLh9jroWnS5mBS+G6mUsBHv6V/hRPNooiG0C8Idd87Lm0Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dilGnAyA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.6
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7D606A326;
	Wed,  4 Nov 2026 14:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79C7D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dilGnAyA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toA8UxiIuZ2vq8dBDeEwMMlobNjiVf+UQohIv0rav8EbFjkhgp5Ecizht6nV5iikGG5+fS/46EJJHjzzRCysexit7e2qeKHxHpVaXFC01u97XfEk1ilG8m+D+w90Sv5+Oo9MDAuIMKKoyUg3SyLjD/MflahokcWGAgHQK6d5q59MVDl25NGNI0IPJi75/DpHBU9IXeGxrIvNl5v/EJmj1QtPLjNPTHgsk7IfPGlTOwySSb2eoN4rR8jRra8tU6RJKpjjlKLE0wvbknSheBq6088despFT8fImTmturxG5mDBIJK+k5eiJv8LWFf/p6xFrVWUwWupbkkiDYVvFyFznQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gSbwe/rw1E7pfTR15Ze8uler1pIoBCZ5jHqWPhnaFQ=;
 b=ej2RTc10fc8Ggjnuzc79RfJPelMHeeXIWmz5SJKhD/YeDSJENuN3fRjvX4/V76q/PX/l4yGhoQ75xb19PvPc+ipAwhRXhYf0Gt+97ot14Kqx7RXKIxpkK3Ysdi4SFtDBvsKnGqIEdBOjGdOzBYXGUkUaNyDy4CjfGbS4lrQ0QFM5JxIN3aX85rlH5LV96XVLRdJUzu6kTNol7l8+vQHpMLYs/TQqdAGf0peVVsS4I6OdLEY6qJDCYrL6e6OcO2TXRSM4hfbP90vpYT65jhQRYb3zRi+TDA1cdYKqJalYb8OElQBL8nPm0nRInmRPY1xED6dzkGGKyv6lJpBlpqqtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gSbwe/rw1E7pfTR15Ze8uler1pIoBCZ5jHqWPhnaFQ=;
 b=dilGnAyAuDJLRBzvf4xcu/YxFq+YEgaB1QKkVoPnYs+2kZWSZTgsaLfqmuD6uAUeNbMN8Iq/dWmiTayf0CHlTR4mh/qXEtnss9Amym1OdtRa/1LvOkpjAsqxA+24lv/gjW8C2Q+gVi2u6MXvGq9QjYp5g1EWSOR6ipVZiA9DTSS+Db6GCRLHoQLe5h7zC9WsKQbpdcB6NF66SjuzRfdD44vR8bUtoUy+/dNtyGbV7vHxw1OZvzXVpgGNJ3jpZruQm2DCVRAjdCj8EARS04oB/0VFnmII+1SfX4TmC+WyTADtIPG6STVdxl/M7WbxvEusnGG0M9Yt461jwz1u1Ps+jw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA4PR04MB7949.eurprd04.prod.outlook.com (2603:10a6:102:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 14:52:17 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:52:17 +0000
From: Frank.Li@oss.nxp.com
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	John Ogness <john.ogness@linutronix.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Zhaoyang Yu <2426767509@qq.com>,
	Haoxiang Li <haoxiang_li2024@163.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/2] tty: serial: pch_uart: replace chan->device->dev with dmaengine_get_provider_device()
Date: Wed,  4 Nov 2026 09:52:06 -0500
Message-ID: <20261104145211.3209669-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:8:23f::15) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA4PR04MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: a9cb9f2a-dd51-4b96-48e3-08df3a833895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|366016|1800799024|23010399003|261102123227099003|18002099003|10067099003|921020|11063799006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261028144727099003|261026140227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	i1BDGgLYxUp80ksFjGcz3Dry19wehSZI/EJYnjUtr96pUFxUbtKae9LGIQOxiEgFokh/0XW8jI43JUngLiMabeN8yVvZIj8sed3NpLlP3BWD1HUSldMp74j32lsXvw5r0zxUoMpYK4kkdVVWXzFrDgYdJajqL2+ewsTopZ5msNwGDzBtO4KtOEpd8ZYPARKekzyadncbyUsOkMEQ3PjzzGAzPOAp8KMzqcTQ5WvV4rbZc6h/lCXxhrF2aSOXAdZHsd7xpdj5R6vcvz/IiI7YH+JcTJx5HfbgCNr4DtAQW0e4jjLxw5/2kiiX0PRESofSgAumZ/Fk3nIU0H/84k03uzSILgQhgRpJH2ckUoJdt1+BP9AOwVQZmVJs/L1cs6nRDo8+HXZo17y0IDAqPBQw5kWClx7p1x/EmF/TQZjdzpOcGWl40qHkdEUsuiRR8vi7Rvt45QTrOU8/TfSXDWH6qJienqwS5eEJ6nss2+jSmDcwYBSWzbTV86f3UhDVNkYaLGcm8Rz6t49cj17BJ6OtEmV/PwcFibAuAPf9vz/OJuXUCYDVnttSvqdFzcGIOhJ4Qxo26DLtt9V0i+qojnZHIE7wYZMFn10U7kbZ0kpQJVesw5iWFpMp4qhN3qXWUW+AA5qJ6MfM74NEq6jjVSanvBI5ZtmulD/8sTSGO7H/EMeyAkGHVS/141QxY7bTwOQShUyEZ/fJ5ZMZKKOOp+MKDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(366016)(1800799024)(23010399003)(261102123227099003)(18002099003)(10067099003)(921020)(11063799006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261028144727099003)(261026140227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QHXGJIlRS8wimtjoGs5uFSIT//asNzOl1kQY3T1fvyq7lv5pfbkxo2DWN37Q?=
 =?us-ascii?Q?gcyT67UBs36ZKCs+bNEMbZhgy8uRzVBtq6wEArJc3g5qqkM2otJ8xdgcAvoh?=
 =?us-ascii?Q?26xjy9pAvyOPfdhNNVIK+Zg3D+4MP4X1cgLQEIePuq5qolmEC2DQYkxP5+Ox?=
 =?us-ascii?Q?kBXQo7J94GAVXH8+/pQvHsOyztGDheEwizD96Wj7KJG4ppQwlW9++1vN/RVv?=
 =?us-ascii?Q?8K3E6x4ziW/EY4kTCJyla38wHn831j6fIPDJt3yeuZ0kYs7j9WP8VVRHnqO6?=
 =?us-ascii?Q?TB/yOj1z21nV6dVLuwcUCZY4qzxcSps6h+ulZvehw2DBQYB3RZjJvo55XhmQ?=
 =?us-ascii?Q?4+MxQAmSlTow4bIKaNT/gRxpcyFpYfFYPYmsQpw8FiTYMcTn42Z8gjarzA73?=
 =?us-ascii?Q?CVJN0/Lho+DlO6aC0amKX5cbtK/gDiFvKe/aqtSWYYBd6ysyjB2T8q4c2O6i?=
 =?us-ascii?Q?GHSivVCnuajbfJQViI2HvnbnpCq+o5VUcWotZ2uxDkGn45RVeDIGfCS3Y59a?=
 =?us-ascii?Q?ASophH9CDI4HKPyubI9AzUK87tkrCb7l9eJa/Urlbm1uoCJVnyiw76iGxPHG?=
 =?us-ascii?Q?omlnw4joBjFIcHqQ2f9bt5ji4+YYhP70cOb3OtfnrRDim6BFBrMHLn3OS8dE?=
 =?us-ascii?Q?2etBb5b5ZN0JVRzHSa1CKvMJNH5RcTHYM3IvFtf/64FS7VCHrgCyEIkyN7pu?=
 =?us-ascii?Q?P91o2ZlkAmUX5xS7qYdtLR/nBTbuzZgciGf5dMJ323EHdjkR8mO4LGmThQw5?=
 =?us-ascii?Q?ANKjM21u9hvHCsKMAZupdN0SAX9uU+285yGNi6RZ5wSVyXby8SZgrSbb71lc?=
 =?us-ascii?Q?TtqKJDIxXi4zgdxH7XcJP92kX+x41DG1wHjgy6MIbjtNUAtqJA7ucX2OqGZl?=
 =?us-ascii?Q?N5esLvRlRk/3/9zipqe+/1M6y6fji5dgWJDKKW5QNVmq9xBnkBhK63abSxQp?=
 =?us-ascii?Q?Ppz52hDnVJySuxDPkLfbFCMjirzHGBCftxDNoMww/3HLp8FIWwdN56jHWcRS?=
 =?us-ascii?Q?Pc9JB4UENbwzhmSilL5spoezfdZx+rO6QyXFQW91xIV9FAIhpLxvZbAt9svK?=
 =?us-ascii?Q?8draUw4qGW8aotR8JfAAzJT+L3PBNYl/eRywiWT+apFrJtR9525C4OQQwfu0?=
 =?us-ascii?Q?KhheYnQTHwtuUYEpzho9ZAKiUCnHp3mszddrjexDGc9vsF67eWM3RRMeXQLq?=
 =?us-ascii?Q?zoNMmm0WdOCJhv5gHOcFukItK8jjIjvpQiu+4fd07GXz4Hbh03KfqkocsPaA?=
 =?us-ascii?Q?g7vYMovxd74t6ujHdxXEJhXCKOAyrMK6sKqDyDxPvmfwrWjOG8oP2h27p3ib?=
 =?us-ascii?Q?58fXqHDcws1/YXQbT6pTvDAc0qUiGk8YW/ofZyQ5KgQ1ulO7kyhF7hWY6naI?=
 =?us-ascii?Q?D+4Uim7/heLcFQOF/2LbNmnkXr+kpgRSHoTYjFvjVu1oWG7v9mg06WtDhkbG?=
 =?us-ascii?Q?sbY9Jfgn8zEhTW56oDhWRnrcXoGIiKRbGeEhoidsnwBjzbzU/MAXf1cin/q2?=
 =?us-ascii?Q?aYTdeZF+AR/1MuQN23+oqZYty1A6RHCCx19pinwTcrDsvdDshqA0ASyAzECS?=
 =?us-ascii?Q?GiS0zr7P4k54c7hK3f39qP6XPGZ1OZCXkbuVf35cdVr8e6ck6Y7AcCkjnTQc?=
 =?us-ascii?Q?WG5VuY+D3xsfMOwPT+ONww9kFuSXRlNx88h8ic0IMVeLOmrC1Z7ioM7h7VVJ?=
 =?us-ascii?Q?8udopfVaJzMReAUWSJ37TyiKyHmXYOFEuyiap1TSa/ixp94mIu/pLt9WWBgv?=
 =?us-ascii?Q?DetTU2b5Bdxh8D74HxZmxtDm9YAYHH1S7uvXR0/fQvPouHgdHpUz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cb9f2a-dd51-4b96-48e3-08df3a833895
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:52:17.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eifnR6Cs/JbEqF+wwTPoDCNA+rUVjRGnvoXfWA3eGP38yDLd6rQNr6yJHju9ij1kU3PtKN3O0KfrlE91lpoy3b3uM7o9ZinP4WOwGblLNAfHYc+RbunHjeGB/JeENod3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7949

From: Frank Li <Frank.Li@nxp.com>

Use the dmaengine_get_provider_device() API instead of directly
accessing chan->device->dev to get the DMA provider device.

No functional change. Prepare make to struct dma_device private to the DMA
engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- split pch_uart.c to new patch
- fix indentation
---
 drivers/tty/serial/pch_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 9505d255f09c5..c53e6b46de4d7 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -655,8 +655,8 @@ static bool filter(struct dma_chan *chan, void *slave)
 {
 	struct pch_dma_slave *param = slave;
 
-	if ((chan->chan_id == param->chan_id) && (param->dma_dev ==
-						  chan->device->dev)) {
+	if ((chan->chan_id == param->chan_id) &&
+	    (param->dma_dev == dmaengine_get_provider_device(chan))) {
 		chan->private = param;
 		return true;
 	} else {
-- 
2.43.0

