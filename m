Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013020.outbound.protection.outlook.com [40.107.44.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127626FA5B;
	Tue, 19 Aug 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605387; cv=fail; b=jlKv0AK9QRHcWQVGm97xU7hOI5RwJZ3EID4srMpM8uiLqrqxINpkXL+3bu9ELajGxbpOZGHIGmCXW/h4L79lc3CY6eI11xlooDwI3/kqLqVho3XEhxTS201kbkFTOkcvewKr1H340lT1npQ6pKju9s1ctrY8gS7xwecCZ1fFN/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605387; c=relaxed/simple;
	bh=CmmMBPoL2BQQopMF6GDBYoKjHlSPv7/+oIkbTNmiNCw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nN9jog4TS7534mtpdXaRINWF9pvq4ywdIbJf38OnCeX7oGoWTxbIvbJmtERFt6nFo88AKCpNdPyq8qXI8Jcp5tMr5deumWYQKMecZCr7kvS6ckGcSRVOcj5SzppcTMMNW7epSm6Isag03yF104LGFVyEOBayP+KPvV+3jUr3gPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cVitfSFI; arc=fail smtp.client-ip=40.107.44.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cVitfSFI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHlgC0mLRLhCCEFcs3KqKrN7I1bcdRSedFJe6j6uS0927vZSWC/tvqEpL4AccsTU+2gCG1tgOL0CdVmSkVx2v2iSbFDoIqgv0nKPbJSl1Y91hcpzqb+W3gA3iJ6dXuZnQUwku+CoOQojGdtmVlsl4OqWjt7wD2EWUUrAtyvYRmC0Zg+Wb4mskVl034L5X9JBFZm0K4QfXBf7p9EzfJtPaZrzMIN8uAy0eU2MCKU6XMLmQIEuskkZJw7G3L5WhEEcViT/tRBRMFxLjnyxhNAkKZA8/2GHfyOkSanay3csXrcOiDVsHRAreMr+2edOiPo6C++aU74GMOkXbTp8r3aGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13aOdL/HG9g+1QrGUfDkHrNlc40PW3kEcRaV7VabQsA=;
 b=nW65DAi1ttnIs9w723VTvBYPO/nMuwaTsUxEN2ezWA9Ae6Tuiu6dJVH+UD6/BppSfrRm/JE5IvLPZDS5tFnEiHDMyMRYZDVP2Et0FuJFDwi6UIKpQGXseYXDTeIhbo+XMl5OMcVvUDMsQ01FnMvUZKNthREdCIEVnALtuSWlSX3/kMVv+BbF+2cLx0bRL7/J2J4qCbUkkQmqIhTmQhil60zMTz00ZWzDkbLKgwaOcWCOgnRE20P8O3xM5RwEFmZXT+xgxyS2nvrKEAJtw0W4/uQRmLGQUNsXtWG7t8MB8dEX4wP+0a0vjvvI/c5t0+cPmUbZ45EcEBSa37+AwkcB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13aOdL/HG9g+1QrGUfDkHrNlc40PW3kEcRaV7VabQsA=;
 b=cVitfSFIsviEmvgOlxRuruAGAzyCd6KzxFCKDYolmR+wVnFXcRm5vFFfCYmvxOVVq0TUPIonhA6csm96ut37w2rqNhFW+iXMeU1I67BhcBTM6Dw/9YgLlQ/hdRt99qV6UPUXwOxha2bLIw9fnSZljURWRgPZxNIxl4tVohtwVz67mnOohvu9e+BrCjou4Hwsg+Gx59rXmdbR8O7N2nNS4kYWEa/l/ltDSXsF+seVhhOEHrc95sAUEk7xIu7Fzd1dDG1i3cblT9ByuLMn+UW8tCCwii+di7sSakQzcRCesyoQNF1QmYrT6sV2vAJ3138Kh3fQ9oQXx10WocktPi1fAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SG2PR06MB5381.apcprd06.prod.outlook.com (2603:1096:4:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 12:09:38 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Tue, 19 Aug 2025
 12:09:38 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v3] tty: serial: Modify the use of dev_err_probe()
Date: Tue, 19 Aug 2025 20:09:27 +0800
Message-Id: <20250819120927.607744-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::17) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SG2PR06MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc0a7f7-f018-4c73-a4e6-08dddf1944cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b7vdbtgdCNDZYuNk7/qOQzYSRts8QmkItuoisIjmTBJ+m+1YrNqhYR9dFh9a?=
 =?us-ascii?Q?UuI74/G1ThNItAyeVSbiioXr8M+ldNpkK/BApViH4iV7gr7E/sQuYYFYKhYr?=
 =?us-ascii?Q?qbDNuCvw4el/om3nqt2RZEt6g/wpr8I/801gtofuIOeTmeXcuJgXmhj/Y3WN?=
 =?us-ascii?Q?CNFI1ENtLCek1/THWl3451J2i/12yeppE5q7qUWTBvgHWNB5Y4wfvBHfxep8?=
 =?us-ascii?Q?dAy1INIdlEckvPaKSgBqcNhvw2dVR1iUhaKFYIwPdZYmoBIwcefG+u/8gtoD?=
 =?us-ascii?Q?x1kLIxPXlBJTzMRv0bEa3XOmHj5VQldfTfxsGtTywMdi4QepZhLEofkUdDfs?=
 =?us-ascii?Q?J/D3cZs+zjyV2FiV21pOE34/mA1nXvUfYR60FEC/PDBq69ZMM/MHE+OWRGVJ?=
 =?us-ascii?Q?Ia0PWyxkbeQ3MfuK3Wa+QyaEIH7tYnd0XA+yOF3jUPUepS1u3AmPH2r0wHki?=
 =?us-ascii?Q?TDlzaVoPDarRs5WhQx7X0YybkpS6GSjQYbrYvHhJlNsBlFFTOEC/nA3RYn+7?=
 =?us-ascii?Q?hQEYZ7Bjyo9tGVYhFcxrroQKWS2WTgQaAlSnOTJoQtlouOh0QYBIPFLrQ75q?=
 =?us-ascii?Q?ZVzyex2xWTIxlw6sdl/S9LtlVE/j+p/1Hjpe2zdeHjRf5cGgE5jLz9257eUH?=
 =?us-ascii?Q?8QxFFQB9Q3fWbdxN9dJD8/a3JoWRiLkfm8qyEgtCtw/PUUbZ0V+2Wm2gYJ73?=
 =?us-ascii?Q?Me24T2znXKhyI4pkTxv/MGHYnYQ1c/7ldAdD3TixwX7XoYSNwKYL97h6vaDZ?=
 =?us-ascii?Q?zkL9TZuep26ZGkKV14GwHhOoC3orPXys5SayQG2Tx8I4I8hlbm9yYhtYkJUm?=
 =?us-ascii?Q?ok/9YTK/6QQ3/gxTMFY+bNeEY1gL4daiP5uqBSl4SUvuzziJEutNfbpctXb4?=
 =?us-ascii?Q?h3kGnDFLldd30PIe4mr6iJtHjm5fa73XJ0IO5FXhKjZ2sPCWe67/AO0FcT1x?=
 =?us-ascii?Q?CvbPtY0EJDgqgpX/ldBnUZFCUOCZ/kQXkHG5Fvz6OQgpH+XFdu24mDuzngkm?=
 =?us-ascii?Q?r1NVb0Pz7cRrpM8bDHLQ3/Yp/8TEakD0it/Br+sHx+NC96WH61Ztz8GGVTo9?=
 =?us-ascii?Q?QiGDrJFtX70lBpX62NMsTZh/kkwfhDqylBV4j7IC0BTty4XvuEz3BX2Q0tp4?=
 =?us-ascii?Q?rFynCzpFqJ5zreOhZohsXlr9Ztfp24H3nGCDWVEKJdpvgl5EnIZv26eppdVV?=
 =?us-ascii?Q?dhKpFkDDr6V8/6+xoWuqGh4HBZAR3CwG8isLXVLvaEiMF13C6abvYyfVLKhT?=
 =?us-ascii?Q?GJKC36O2M5RqUTPr+ZnwLZ+/0JPdZQ5kvSpGirUCa3mrXQRt62oKb7W8wWpY?=
 =?us-ascii?Q?ObfT6vRMbveayadQLSvmq6n9YtKypygKOY5tuSWVewg++jwfyXfzOJugkwrg?=
 =?us-ascii?Q?0MRqFbmseGi4pkuANDSjpWRFpbK5TIqx7IUTmcnYT5TjKwMb6rrS2h+T4KlF?=
 =?us-ascii?Q?eKx3cDwgFTVMtPZ92Qv4Ahyf1aSc1DqlL12pVXAjkWgP/Y4KD7aYAMFM8wrB?=
 =?us-ascii?Q?7Ihz5bpnNPQUKIc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M33tlN8Qu9dcNtDOyYBK6PQ0GlF9h4hnQDX2aw8BG8jqOcBImQGvdwzizAwY?=
 =?us-ascii?Q?wSvONOPjI8pegQr9oUzWEV8hIfHgCWTYwQsYsYsr5QED4kn68ykrwNkQMCsF?=
 =?us-ascii?Q?/DWXFV2mjQGIEgIo4rMDQQTClIolDjS3nTmbct8MjWAjUikVYcmD1/u7nvZL?=
 =?us-ascii?Q?WCi5sMtKwHWlEz6p9YtHkA3uX5fJkI5sonitZ88LM4U0tXfkanUPEuipQFoQ?=
 =?us-ascii?Q?MIbGAduvINnl9/dQjISWz5XVscx4wRo0QZb3ncn22jTfFvprkSOR0f9vxVGa?=
 =?us-ascii?Q?9mJByEQbjfMuuojwypwMdg0i3YRCOGONANHuYQEwTUJjQWVQ7WcThyMifcMa?=
 =?us-ascii?Q?xnjjtqxhrf+PcOENUOq+6JKIWOs2aQTJsBhjTzsh0KFBIs5yX17AofNMMEQ6?=
 =?us-ascii?Q?CH6UzlkZyYHyBNKSQ7ghH7fEhn0DvlCRJMzySN6ErjGMe2ojKDMV3bQCZpYP?=
 =?us-ascii?Q?vGJ0NyTYOEbrgIejvWfyvEBqraP/i14rmTTxVs7aLKYGywscwxwwyYqHJV6x?=
 =?us-ascii?Q?pjMJv18ekmVw4NkHZhF+WSfUklV/Bk3OyRxaPj2nm6EanSt2HLr8bVo617R5?=
 =?us-ascii?Q?EvbrY599cJpl6a8k+8P0sEv8rLjRXms0J6O1i/mK+O1veGsYmth53kmN0N/6?=
 =?us-ascii?Q?cM7OCX+t91wfZSIYQNbtWCbNFIDZxwA+fxKPu1G4jSNZlda6w2cXaTySfKxa?=
 =?us-ascii?Q?ceVOz7H1fmcqIaV691CuvCW8s53oLTOZilOnvoJLFI9EH51MJeIsp+uO+q1a?=
 =?us-ascii?Q?IdNdkKXN/Zspb6aTLAhkzLAr+TnpRZnlx+jYrBf0RK1+X5lDzXfcLgVFmWU5?=
 =?us-ascii?Q?pYEKOHMy28wGQcX4BtR4x+g5+VaZviSpfDEcy23IAqCqDC5ZVMge9xYaF2fQ?=
 =?us-ascii?Q?RIMCb+/GNB4gmWXbLEs77IYOBwxoJ2wqnJTkrxfKtD+4kQa5VGgTqXGuL3e8?=
 =?us-ascii?Q?SZ3l0jlkH606dbcOirbFk0JXkg+eZE9ShA0srwLYCW3E7iev6rGfNMQsBv3J?=
 =?us-ascii?Q?NqcOaBiNeufNjOyzGE1Yf8i118zA/QZJeBYvFLKUXZsi/7yxlJWiFuMt0M7b?=
 =?us-ascii?Q?9B0t7+PTrYo+pDYavMt/vHpKGgk0xusx0SaDlvIo1sodIeeopKckI0XmNWaL?=
 =?us-ascii?Q?U2iL17wzvrHIn0MwRLqoxqB0O6t09TFu8RGMqGd/wjbj7zE9BfVKj0rJF+gK?=
 =?us-ascii?Q?lrWjdK6cxH73B/2E934kBFIrODH2Xm4dd/uJKXsi9P12zN05u4lpRIFHxdCl?=
 =?us-ascii?Q?B7C7c3FhbMQdx3T6i16ySR/qKm6zogas5zQcxKVgpwo7B+HZq+p93YZ5do04?=
 =?us-ascii?Q?BQ7Ll6WBB2Gazn/Ii/A1B7niobApnTinFqPfjZfm7tCfiaI6AH34ugsfN/QD?=
 =?us-ascii?Q?ROZyi6h1MYcwfeLWOsd5A9t0k2m7ZGnVY8ksNcbvSYK3J8aakBTRZZ5IwyEi?=
 =?us-ascii?Q?4QHPAlLf4hcQ0iIyXP7L9Z6UKI/hOXFLUh4yfaG4If2h7l5RI/rREuJxzyPI?=
 =?us-ascii?Q?LXdqlOZJ2h3Kqcq4JRK6dnn2AxGt48efEZhj0gU0aQ/gAfVEhqN8EIPioTXM?=
 =?us-ascii?Q?g/fUA8AqW9ujat0Ss9Z7sAs5JrIoB9y59fQl87Bm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc0a7f7-f018-4c73-a4e6-08dddf1944cc
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:09:37.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jJw2CpaAmppPVypwJ8GdMN8McBarisPv1Nc4NpAV9m/OqUuZ1xFBwNTpi2vNBl2GbvtVad9B0qbxKtMuuP3aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5381

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Make the following two changes:
(1) Replace -ENOMEM with -ENOSPC in max3100_probe().
(2) Just return -ENOMEM instead in max310x_probe().

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
v2: Replace -ENOMEM with -ENOSPC.
v3: Add modifications to max310x.c.
---
 drivers/tty/serial/max3100.c | 2 +-
 drivers/tty/serial/max310x.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 67d80f8f801e..3faa1b6aa3ee 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -705,7 +705,7 @@ static int max3100_probe(struct spi_device *spi)
 			break;
 	if (i == MAX_MAX3100) {
 		mutex_unlock(&max3100s_lock);
-		return dev_err_probe(dev, -ENOMEM, "too many MAX3100 chips\n");
+		return dev_err_probe(dev, -ENOSPC, "too many MAX3100 chips\n");
 	}
 
 	max3100s[i] = kzalloc(sizeof(struct max3100_port), GFP_KERNEL);
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 541c790c0109..79bec9509154 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1269,8 +1269,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	/* Alloc port structure */
 	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr), GFP_KERNEL);
 	if (!s)
-		return dev_err_probe(dev, -ENOMEM,
-				     "Error allocating port structure\n");
+		return -ENOMEM;
 
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
-- 
2.34.1

