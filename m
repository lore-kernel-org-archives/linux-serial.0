Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F324E73500;
	Tue,  7 May 2024 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114638; cv=fail; b=SrE6GyUtl/IvKSBbr3RPHu3nepb/YJOdPIpj+WSXh1gMnkfO7I41lew8LtBQYOTJl+/GJOtdaZohO6ABkz2bpCcmdo4b/8ssKHGDGU3CaBxW9pk1P1wGpd6W4yR5ZpPy02c8fAG+4xcz4xgmm0yLdajltlCd1pfsE6bdPaLw9MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114638; c=relaxed/simple;
	bh=qW3xZSPxV69HhCqaxH4lMTpKrUoMPbR7IONE/5QS6Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R3YCdA9VGQlRVACu8+0IWtBzKiSouPi/TToB9V9F4WspRph/0oBd1VZFpjmYGlxjCjrOyncNEqu4SzxwGiveeQpr5xgwGZBeOph7qKYx+pXVU8Up18R6u8WNzgh5a7XK+/WyfzcX47TpuE+YV2LnSOTV+GzLOq9fih4UIZ01ecU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=D+Y+cebZ; arc=fail smtp.client-ip=40.107.247.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D+Y+cebZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e27HFIpHVn9qNh3OJ4yisChjmVGWpYgfk7zrEOQ63bn1eVwmYclnFoCHCdQomHlwGB4haA7ALB0chSalvdGhOvt+xHsJRzXuA81YmxaUuIgk+tbSgktcVADpP69WF9L1TzJoQIhaMTMUrF3ggKVLd2JlsX0Ng9kQnv46wdyZ3/eUOVgaErw7q6M0jMdhW/w/TXhf7R3gxSBextIjuhaLoJQ9VnFN9TRCI2KpQx+e8Rn5j0Iyhd3SmdAeJFbS7n4in92LAh+IKBapID9qYY0KSTMHZDfw+Ulk7pvM/blNIsTvCJ/tvrBD6M6PVszt1vSXGYFbmxfwmcvc8yMS1fbiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=hpUHu5g57MxX1RE6uU4auj7Yb31brkTk7yp42krNYdPBgl16tgQgqSx9Ak5c3sDCcuCgybpnAxBf5Sr/3USYFq7wrtuJzHGhft6PGCdP0DRiA7Ip3nfBuNcooVf98MQBGxeQQALYwfYVzFQkep71s8Wu8PsTGuydP/ZnzpWo97FXEjB2bsf6rA336i6spLZFfyI3PJ6h0V7aApPHSH+l0MRCN+PxkR7UHDNcXkEbV3GVHb3SAp6nu57jV5pqZ43t6fK62AuX1YAlbK5dRayhxYsbNp1UiyqovzOjugkTKNEsjJtCivve6hjBpTXHpnS4vdgyqK3Yj6PsSTP3Kno2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=D+Y+cebZy55WgtLo7l0QBrwS0KKPrDiqp12I08z3JI1rKX6T7hYaSz2yMTiCtQtm1T1BDMpG53Ri3RD5B3LrZa68FhITq6e4AlI9TGy4whoAaBFDh87NYlw4l67mU0jCPKFXo2z4KX8jpGi4KVsVUSKMaaK68Mf6OnKJxN0AWzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 7 May
 2024 20:43:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 20:43:54 +0000
From: Frank Li <Frank.Li@nxp.com>
To: alexandre.belloni@bootlin.com
Cc: conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH resend v9 7/8] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date: Tue,  7 May 2024 16:43:10 -0400
Message-Id: <20240507204311.2898714-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507204311.2898714-1-Frank.Li@nxp.com>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: caa5ad46-5716-44a4-d41e-08dc6ed668c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HU9j0foykkUm203WAmr+MC6ZflCYIoG2kHqYfyKeycD2fSVoJlLt1fFAEvdS?=
 =?us-ascii?Q?PJkLlHZqXvDymqxdEvgrp0Kw7v1aX38+dIpFe/rMFba5rRcsWt509KLjENJc?=
 =?us-ascii?Q?j8KAexoGuuMXEe7ez9GMHGGj4TdbIvlM43HCIHp7A7+O9s4j/t4Q+6I1ubHP?=
 =?us-ascii?Q?Kt6A264X/N11N+coXgPJvChTQX4X3UzHfEPVLeo24kzR6OfSFhJq18Hrsil2?=
 =?us-ascii?Q?0wJbL0CYQ1uQpwg/5KB8NqndO7DQy1tE1WF4BB3RAOxwkauwWVwwZTJdZoN8?=
 =?us-ascii?Q?HLrCUc+jgM1inZPrEdj1R6llCLyKhiCvp3cRiO3JABRq4ROopYF9Sr8Xm7eN?=
 =?us-ascii?Q?YgHqEtv9E5IuBpvBkQUvpPFGzTApkVE8E1cUpwbFCfVhaI78efTZzatU2jnO?=
 =?us-ascii?Q?B6P2gpKduy20jO8nFZJfp2WyP3VWjHEwPTA5ClQMF2mjR3Lz6WEJIIlehzJ1?=
 =?us-ascii?Q?ziIZJKVXo1LSI6h+iIo5H8UCallq+NgETHVcACQep5xB0SezjuOmfn1pmpRz?=
 =?us-ascii?Q?3YyjgIg+3U5c4M7Y+dUCG1vpE6MGRsEj2tUoihSde0acz1T1xZUrUrK3Hmuf?=
 =?us-ascii?Q?KhYW7+0PoOhOrOOexyO1/HtyFbsOmmmK2IOGmqjNEb+okQQ8fEMWMFjKCHIx?=
 =?us-ascii?Q?1aJXMDcljrYt610c0ManNei4s60C/2F8ZZ921ovjyp6eq8g8NUIYL/Sm3lY2?=
 =?us-ascii?Q?wl7uB3w+WZJ17M0+RCpKPk7NEIQ1W5K5s70HflhBVhwAHdsLyMyU4GxcXF3a?=
 =?us-ascii?Q?mxXr/eENYoy/CnB3h4XkE+9yg/nJsGZQcc1Ot+0kk+2c8PAXUU0Us3FNBNeS?=
 =?us-ascii?Q?F9ArrTpLYHCtzqryKfZQZRweFsJ3F1Z2NnpQzvsnxYvVXp6DxYJtz75KudCk?=
 =?us-ascii?Q?0K8hSQXHslLN9HYCR196g9ySE1CvQfPEAwg5YsRXA+8cOScPGCCLFv2Bf4EN?=
 =?us-ascii?Q?gPw92/rzSp1iXNdJ/Lzgo4kaxZK8bYNvt9fB36ofC5pxw66ihwmIRbSxUkcq?=
 =?us-ascii?Q?K8vzedwBgnZiOmX/B/pWWig+GoGk5+O4TrUCWEjWSj3l1KrOmT7SRPKMUuQA?=
 =?us-ascii?Q?ccdYVALEL6iUxYUFvHsJAuMc9mBD5G1V414bUbI1dFwap7ZdLNs1TalTDPA7?=
 =?us-ascii?Q?kq1t1qMh2DxNCugWxNvirhMeZ7U8nWyXRV00aF848gNS+yVXzsliMZU+KLQm?=
 =?us-ascii?Q?Vqtx8qN9r5/TZOodhO8YtdvjRzXpKZ9aX3pYvi4lD2xhdbxkcwn5Q6EuGBWD?=
 =?us-ascii?Q?9c2QFwoE0pNzTb/jksRbBINJCSFFyZtqHPK7gG34zFDQ0dinf1fkFLjZ++Xc?=
 =?us-ascii?Q?15UuZFIKGbKHjGzfD53N01/Wd1QQlpm4R3WvWEhhpJHv7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rOxP0S3ymn0oDp+b+jQrCmv9duH7mLlN32Hr2e44YtROTW33cNIrA1VBgq8o?=
 =?us-ascii?Q?5WH2sxKi2Zk3qR98yKdmTI0Um5ZpMhAcUvotAAJxZIHCF1i2uum0DyTDqsvn?=
 =?us-ascii?Q?+U+HU0E4Z9lvDklSZ4NF/EO3y7pFFGiWTr6HKJYY8j7UFNqK20AI6xArABxo?=
 =?us-ascii?Q?lccQ4+tPtn7rKAxNwDi7R01I++JUv4K5IX4RlSIIEmUphNhUKIctjClJ8Bsn?=
 =?us-ascii?Q?dU7emFJ3DZWEGkjE9IS99OxzldyWFfQHfNBXVuyawJds9E7zHBtpOOh6j9oX?=
 =?us-ascii?Q?E+fMoEg29jvI0MYQNY4LnhzFJdL4yiVPxTme0uAPmdeAm5RyFrZcIrtFa/nt?=
 =?us-ascii?Q?q0SdiAs+w3kUmCRwScduZZSCkDRBPuAW8Po2R/zNWyEpTqp+FsK/YSt6CpEF?=
 =?us-ascii?Q?vVr/ns5NVtdus6GSu0MA9sci5RC+8v+O6tDx+d9mZ/Re7tC52neTUDxApLvf?=
 =?us-ascii?Q?xQbtyNBbqxfNcDeosmNcYkW+8LgQ8/P7AVkEtuBdFk8zaF6bPIYbxROlNx5z?=
 =?us-ascii?Q?nIdVcRAowmdp+feb30CJV1d8qlvybrO91bBksklY9s0jI9hrnDMPDEdXCguS?=
 =?us-ascii?Q?b1P21u71Z3hOwHcqFLKzU3XvWOR6cnB+measT03+j8CyRqJgaG46hUB8n3wi?=
 =?us-ascii?Q?UmHSlRNFg+pPMkFfAqBhNBPn+a1geuRjMC0m4v4Hq8kIAKQ9mdiarupVnRwh?=
 =?us-ascii?Q?A0iAp/PZkpGPqqeB7GtszEy9jHzGNZIfaWhWfm9z8vfW/nvl74dux+GuYzSg?=
 =?us-ascii?Q?0JL6YE2yMlbAbmWMkSjSbPzy42xvIve+e5EQbrD6G+HQhSYaxO41l+zrrj0C?=
 =?us-ascii?Q?/G209IvDcJgH0Of3BD3oF84hRyaKf0Ok07bkRWIQHNQ9+YdYsO0Vm2AlObPY?=
 =?us-ascii?Q?2IW1JtB6ab9Qc1zmwlTgkQvJgVRze4aR4Yk8sTo1jZr0+1KSL0HzgSjEeQ4t?=
 =?us-ascii?Q?GSKSNfYFKkf7m39eAl6ALLLxGnNwud6MYLfK12kHodTkO01XvNZa58vBXyDt?=
 =?us-ascii?Q?yR7O1LYVR1KrEy40g45uOsJzfshhx35sFW2Q0ELlE5bYTRSSNv99Ab/cM/JE?=
 =?us-ascii?Q?aXvpIi7i4FkchcuYdA1bSraF+VWDZ+rltsgTUCUf7qeEsfWX9MbLiXkns73Z?=
 =?us-ascii?Q?t9C5oZnvtw5LcWBqgzNbdvNReYgqQdwMdQlwh3RnDdjie0zCfFf4owEZZPYW?=
 =?us-ascii?Q?Rz3uDQVpG0xxuECy+HF4TTjdmPJbBh16rpPPunnSVdY2PvkPl8nCckXnrXIN?=
 =?us-ascii?Q?pARjZ03MLpb3EdK8wT1LXfJoNVq6g8WTgC8R+TAq5jsTFknk4ZouKWf1rPex?=
 =?us-ascii?Q?C0/GDXjYtzjleHFW4nR0cSpQR1wD7VN3sEg0ACY1dxLM1GEMJRtayCE4ftd/?=
 =?us-ascii?Q?CyOJOMz3pp8VU37NilaJIEk8LBS3D7rvl2SMa9xamMKUsxMh4YGEffvo58oZ?=
 =?us-ascii?Q?j9b2UhHqwgK8Rs+HoYKNBcu92aTErJEqqpHEFDQyUW68GMttO/uoKrcPSBpG?=
 =?us-ascii?Q?Bo5mxPcfbxpP4TpKUN6DafhD+X7jg23yglP9WduTs4x+8+fzw5JkdebmJP8M?=
 =?us-ascii?Q?jM40P0MCq8ywRghkgGMbTzusnYYN+8n+DXQq3Nhx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa5ad46-5716-44a4-d41e-08dc6ed668c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:43:54.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+yKNF/dTFfB8dInotsPdC7Xp60KZ1limdGBuP6FnKNzCiawlujjmpZ7ca1Ocv/JMypmv05jbgTgExF4IDCIag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576

I3C standard 5.1.9.3.15 Get Device Status (GETSTATUS):
Get request for one I3C Target Device to return its current status.

Add API to fetch it with format1.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/device.c       | 24 ++++++++++++++++++++++++
 drivers/i3c/internals.h    |  1 +
 drivers/i3c/master.c       | 26 ++++++++++++++++++++++++++
 include/linux/i3c/device.h |  1 +
 4 files changed, 52 insertions(+)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 1a6a8703dbc3a..aa26cf50ab9c6 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -196,6 +196,30 @@ void i3c_device_free_ibi(struct i3c_device *dev)
 }
 EXPORT_SYMBOL_GPL(i3c_device_free_ibi);
 
+/**
+ * i3c_device_getstatus_format1() - Get device status with format 1.
+ * @dev: device for which you want to get status.
+ * @status: I3C status format 1
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status)
+{
+	int ret = -EINVAL;
+
+	if (!status)
+		return -EINVAL;
+
+	i3c_bus_normaluse_lock(dev->bus);
+	if (dev->desc)
+		ret = i3c_dev_getstatus_format1_locked(dev->desc, status);
+
+	i3c_bus_normaluse_unlock(dev->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_getstatus_format1);
+
 /**
  * i3cdev_to_dev() - Returns the device embedded in @i3cdev
  * @i3cdev: I3C device
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 908a807badaf9..976ad26ca79c2 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status);
 #endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3afa530c5e322..ff61a218bcc6d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2988,6 +2988,32 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
 	dev->ibi = NULL;
 }
 
+int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	struct i3c_ccc_getstatus *format1;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	format1 = i3c_ccc_cmd_dest_init(&dest, dev->info.dyn_addr, sizeof(*format1));
+	if (!format1)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETSTATUS, &dest, 1);
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	*status = be16_to_cpu(format1->status);
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
 static int __init i3c_init(void)
 {
 	int res;
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index e119f11948efe..66920045ff042 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -345,4 +345,5 @@ void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
 
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status);
 #endif /* I3C_DEV_H */
-- 
2.34.1

