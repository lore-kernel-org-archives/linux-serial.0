Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2133.outbound.protection.outlook.com [40.107.223.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D80221F08;
	Mon, 24 Feb 2025 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399538; cv=fail; b=g8063Ogp6xQUDZxB6eZzK5Xga5Et2Y6dqZRbobs2KYKp9APOPLFsE7pxZI21VlDKncMktpZt3YW41QQ5GS0eHG9jJVO8P/v7kJVmwTQ2fN0GLbv+h6zqrddPtS7dI/R4Y1GdF8XEu0Xa/My5LYRwa9Kz4jidLdflwqFhNFlTJuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399538; c=relaxed/simple;
	bh=u9Tc1jGj5kyCGELwywHPn9U1/Wlq9JKql9LmWsWIluA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q/eq5Z4iysmYxhYaPdOL7FNZ2XSm2H3G0fEAJb4RjCEi8jRpN05bHFjFLAugNLs9FzdprGvbO2Xt0Qh+SF/Ns2jdu5+S+slRZBEJLaTQEF/Ad7m7KEXpgg+VHFu6sOAQP5za3EFpjDtnC51z8qBs98UexGlMIT9OZbnnPLCoYiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=pl87yleP; arc=fail smtp.client-ip=40.107.223.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="pl87yleP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipXtg/goA3KUzkr7+IMSsSIwpef2ptG4JIq6po1ZajSmhk7ObbDuMG1k0J/yHxDQm+Wa9qb3Yr8jLgUADW/PkB6V4bnYXQHbw2/mSJP9+/zhIDOAIrRJ85Nkd2u9sZFS0j9CRVBXKjArB4JN8NyEzzVMwDC1+nAGnifcQNSlNj4iMtufvIbaqRWuOsa+d9F2KCbKrxx5vwA7ESJPkGtfVeq9aKdfUf4ujd3sn9Iec0dDbRlBgC1O4+nfFu32DzzjsHIuxVGCX8cPjplwXcOFq9Z3G00GFryFhVWVWhTN4azc5y/42slhW7RzU/El/ZPuiwd9XBCO4Qj47aZdL/BJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoFxtZmdW4CR7OuBfFWNiF5coB0FIU2w0C1B6r98viI=;
 b=UopGuEDO4NXrkEWz/bd+5JkmIabAqoCnx/iy5uc5nLAWmVcDTYpy5FNzLTx+geoZF10Clv9GOiUbx/GkSxh+rwmb19pKwgS5kQ2loqjz8C+Zy5ltmT+QaPJ7YqiVvzV9rhlZt2KD1kzkCD4X8+UADlD+TnUbcpmDsRWSdHBJZDTq0nh2rJFC/xA40ve+Cssz8nkMAhLQhfAapFXzKOdMUwlATJlMk7Iw3fUELali5tOzLHdl8Iu2eVGwCyR/JeDSXtYnS/AnEl2oaPCMDJ4bXbP0QnTqON4l31X3La6JKXqlEujMJ0BHtyQNQDyyxpp2yQrn8sl9v6MLRgdktFKHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoFxtZmdW4CR7OuBfFWNiF5coB0FIU2w0C1B6r98viI=;
 b=pl87ylePmss3/E7XgccwhqZEz9If36Ztr4PKxhsaqExfb7yJaHosFu/IxdQCgzKNN74deoOCgjCcWDpdVl+6qmHgGb0bpx3VHdRoW6fBD6PZo+kdJZyoz4F5iAvOs0L6tgQ7psuuvDFZuhvoMEfETqrnMiZsGkwiFMDf1SuiOyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by SN7PR08MB8592.namprd08.prod.outlook.com (2603:10b6:806:2ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 12:18:49 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:18:49 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_dma: terminate correct DMA in tx_dma_flush()
Date: Mon, 24 Feb 2025 12:18:30 +0000
Message-ID: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0313.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::12) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|SN7PR08MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: b52b84e7-56aa-495d-da4c-08dd54cd64ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a8yeu7evvtBGbV43JlOg6jTOPrXhTtzdLfJUDA8yErsFEZPg9kFpbF9TBy4B?=
 =?us-ascii?Q?otMJ1P6S2cQONYrZs9gBmFBhJktl4nnvtGhPrXV6AKcucab366++fgUXVXgW?=
 =?us-ascii?Q?xX4tmPuNRr8Xqt5zwSFk6l2W+t+T2f9ch0p+8AUcGZfPzut8D+TRh0DNqkeu?=
 =?us-ascii?Q?/Wbuf7yd+T1hU9kzsKAyRNfSoqmtbIxpWJzc1/zLQ/0t+uayUWJ51bB5/7MQ?=
 =?us-ascii?Q?Qs4X2ytXdpM22r5XnzWZMxp3EG2r9WB1WtYyLHZeAdwNArNMrjH7iDSvp3Ow?=
 =?us-ascii?Q?rO1/Dj7Sdq7kgPsSHBmszdnBfMHN1IUmkWUCVvjdBRO+bBF/lySrgqMgWFJN?=
 =?us-ascii?Q?zxATGndl4uvuiME9y4RC3KMlcT4PNoPZmVq5u6a9PJ7uqo1x8AeWGIN2CIPI?=
 =?us-ascii?Q?W1BAz9PoW/B6gMUr9JQrbvxiVIwvpmy+fr2i/Y5/C63S6dK7iAuxFAp/l7b3?=
 =?us-ascii?Q?5WI+lxIyc06Ir1dozG3Yq3rXOxjfZ8xR3KM9SeWFmGO7++KVOaJGQPnf+kSJ?=
 =?us-ascii?Q?PKwY3StOdMhyHMYZOD5ZquvbwDIxRn+s0FMkjlqOnIti4xSTMUl5yTMbpJ5z?=
 =?us-ascii?Q?vCDjfMEp+PdytxqaQQ0/jtQqMEtjN9F14hg1R8PQxbyJjXPwjBqeGaseUq67?=
 =?us-ascii?Q?FUyvBhrEEmhWwznpEot/aJl3h6qhGaFNHHJc6bUPOydLALvC1aib2Z+76Bil?=
 =?us-ascii?Q?OKoiYWfUlSNna2WVtKhBt+AyoibzxZeYAodZjX6tuPF3Fnus24G2u9euJukV?=
 =?us-ascii?Q?Ni2/hDmnMV5ipD80kc6cG+P/YB96G27bnYoG2wr+IzXir65ipaWdm2RwDUMs?=
 =?us-ascii?Q?tZ2LeltoGlsVggQ1IKRTressey+5BMKWbzhLHykPsy0trBx8bcdjYwNyjYuv?=
 =?us-ascii?Q?g+l6Ge/clVsyOn2gJP6RcSWnLelNjyJBjkDmI8ce027ZvaJMKb4dyTrSBSop?=
 =?us-ascii?Q?OFd3ioEbm7Fu9tjXfmvW8c22ymrpZwzf1OxAX0DeQCWtwZE9iiQv2uIaR0t7?=
 =?us-ascii?Q?Cdp+N4VFLjirQpFujbPrEcayfDDiVMJz8vZntzsRv49iN4fcq6haSq81NvW2?=
 =?us-ascii?Q?q1dhvgkbAamHR8SgnH9K5hZetu5HPE5J7eEfiyTaIujuLaAb8SaZWH51iHXM?=
 =?us-ascii?Q?V5bjGXrohCqZSkY6F00CFKNzd3ld8BzfgoO6qxgQMPwC1HObInw5GmZ4B7YV?=
 =?us-ascii?Q?Cp+YZBvsKu2yn92VMuFubUn6r2MKSFG/kpt7gFPMbKm5DWYCaLAjnALqKyKw?=
 =?us-ascii?Q?SCmJl0FyicKSW2OIs196iTij6xJfrIQczPR+BKkxTErOjV5c/URNvzs5JAWf?=
 =?us-ascii?Q?w7lyRf6BA0PwFTJpXPvY4yYmCx5M0ejoENj3HJnxqtnt1eoGcTHfUBx4vKD3?=
 =?us-ascii?Q?hsRJPJdvHE5BybsQMJD+bx3BJxfHjsmpq5HA6KXJlZhGCmkOwVxN1Waf5LAe?=
 =?us-ascii?Q?YnHalEv0i5xbSwGYQWLoO3P+OiRGOQ7B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FbTCEcfaAV9BqgJD3eH5xfUcVJdp9hvM2jc6bwCUUxkTgx+JQlsiurNDYjAl?=
 =?us-ascii?Q?55z8PuXL/GYaZd0ol1v3WQcfc74MJkxuesYdDv3JT44J9uMBoCyt/NIa8hys?=
 =?us-ascii?Q?bab5vbAxdVqJrhgFcibcV3eYYnuWWo/qWnAeSZrm4f8gZ/CZ0BPsL+7pxN9h?=
 =?us-ascii?Q?p7ffTvdFrQnAQguzZIfRCHYkgE1jBhDZuvogl0zaEHChOc/zERUUugf6x80u?=
 =?us-ascii?Q?4svpWfuxTFO8wxavFRUkTPfISXMMzfWRYuKNYyFS9wKTJDOlaDw8dCHXIxjI?=
 =?us-ascii?Q?5WvyvdtYjJHzgdenw3luNrOM4LUGLVQ18txGIehuiM8EdIPdYQmno8LlFat9?=
 =?us-ascii?Q?nGVSDpS7IRlS91Dg6Etdp77D7h+60pSo0kvoamGJyCWJyLxatyPqEX9N7BSH?=
 =?us-ascii?Q?OAtNkhU8pDskNCYdKD6bZ3GQy652wVHLBgzmX0tFNlt9BoI2dmDcb5cAw7n+?=
 =?us-ascii?Q?TG19uTC5xRMXdGKQScnWE5rk+6GXJg1S/uuiqXJuFIHnen0yBVF6xtzWevIu?=
 =?us-ascii?Q?589DQlbHDkB0xadqP4kKqMaHbUS45J06h3h26VEerhexGOfF+7lQCmDQ72rg?=
 =?us-ascii?Q?iufFF7Ev2emHFZRxbhRL8En4EGB0lxInypZjSjtaEcZL+LisI826UwvV9hhS?=
 =?us-ascii?Q?USnRAhnLkbHTo8GSgD0pvtKG5QoR80TInDIKChPazWR9PMivkdFuGfdVJHuU?=
 =?us-ascii?Q?BzkGTm1qBrVlFde78n7go5oTiwLMHqY9ujYDOt+TnEnqToukIgM7lS5taE79?=
 =?us-ascii?Q?VshGd28uUR6PbgGEQZbtgi0C/omvv1xNp7TYgS3NJ3jL3DPQu9lhA8QTW1th?=
 =?us-ascii?Q?pd72xKEdvOr3eHJi2dOLDoE0Xe5o9I7JlKd032JcT5qHkhiS9S5mDTkc5k6u?=
 =?us-ascii?Q?0kqPohS//h+O8Ugk5XoMMV6gbqHFvtMfye1GJzB7bopvaXuU+0l5+roPHsKb?=
 =?us-ascii?Q?hXBmqRfB5SgMlxit0VH1bwivOeTenD5KVrjdHBz/Gxfk/Dno4hTqCtNa17KQ?=
 =?us-ascii?Q?igV03cF8GTurffpqeyH7OGNGxvLJHGhVmzOy1YWbgHaKT8OO8x5fob+WMDwG?=
 =?us-ascii?Q?LUQJaImqfO601ZqXKVl4fgo4QePILgh1bpdxBsXjkF0qoZ0e9Old2ZOWC/9E?=
 =?us-ascii?Q?8JetWWC8F1PyCraSugtVXSRrvKktPvvOdhnmTaG8LgxFn6PU/Dhrc3wbJVxk?=
 =?us-ascii?Q?aplA2HDcLQhh4C22fPtLm0cdIVpzv9AXTRNLgoloEfcQ0bau5sWliEb+Jwr4?=
 =?us-ascii?Q?N+5hKoMBT6hjqlF0JkDxZf4VhWQFT0wrh2X3KdNKgrdJAATR7u9k0g7Nn0zd?=
 =?us-ascii?Q?NpwxB0ArdyDf48dvqxXgB0lYMWQdVr/RDrLzc+vkAWuhmQpRR9bU4I8k9Z3u?=
 =?us-ascii?Q?RKvqpavEGAIoHPXQj2Lip4bvBLlo63AbEw+/G/13ye+UKBWNj4q2ergz0cLa?=
 =?us-ascii?Q?kg/97CZjZsmxRjjcswsEzpxm71ILWeL95DL7h51Xywfv1oPUrXgChtxO4Ene?=
 =?us-ascii?Q?lY3J3qWys7KBr1Ips6D7xQcsCQfN871BCbHE3g1ICW/0hlOf61NGlgoKHRqm?=
 =?us-ascii?Q?In9rP80BfH8J7p4PxC3gaHjjQXuTnQFeUHBRbHUixbJ94gEPi62cvThiwBwn?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52b84e7-56aa-495d-da4c-08dd54cd64ec
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:18:49.7735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/O22Y/PjR953/aAOVzXD86Jwwpx5Y+BZbZoHCFOC+BFbhVKs+/Sx5QNBsGc7f4Lb9rB+9xtT2J9YY2YK2bhT2LYKZrpB8Ebk+2lYBSDFVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR08MB8592

When flushing transmit side DMA, it is the transmit channel that should
be terminated, not the receive channel.

Fixes: 9e512eaaf8f40 ("serial: 8250: Fix fifo underflow on flush")
Reported-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
 drivers/tty/serial/8250/8250_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index f245a84f4a508..bdd26c9f34bdf 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -162,7 +162,7 @@ void serial8250_tx_dma_flush(struct uart_8250_port *p)
 	 */
 	dma->tx_size = 0;
 
-	dmaengine_terminate_async(dma->rxchan);
+	dmaengine_terminate_async(dma->txchan);
 }
 
 int serial8250_rx_dma(struct uart_8250_port *p)
-- 
2.48.1

