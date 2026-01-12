Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3E33064F;
	Mon, 12 Jan 2026 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205922; cv=fail; b=tl2u05XiVIP3K1jjk7ki3C59hLUTDpVNpiVcc9jBPgWFF3NC8lgeeLSmbuOTeaA3MsBWA20xrm5LGx94GlnvGcvbQJjP0HoT5MV3wSCfbNpO9dcNEoFbOQMuFuUEB6PXYGDn85d1oZGSOsGwjniI2qO07Iae64Z4IGQHVlTQdpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205922; c=relaxed/simple;
	bh=RSOzcgXjyAyLiV5uvEHuxncGbg1I5u/Tw0+hYgLkHe0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xiw8aokXOYxQzNXI1Y+zdWIGVU/KE8UrVroAYbH7eT7hk9WWSG2TZ/E2qUbt5E1o4spXUb3mrXMu+lTbJ4Qb/jTgr7QKbgduAHoX1RthWI4SNLqWqvLmT97JjwHKLo8SnMiETCRJzKssxVUWDoS6uUFwpElGrQrVf7lsNzL3zSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZNXUzjEj; arc=fail smtp.client-ip=52.101.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZNXUzjEj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=relDCacHXIoYDA2forxq9eP49QqFrfUdBOSZFp/0Lvzz8n8/hJG7I76IGv4pWHfnAQ2JOCZWb6QOL+8BsE6imtSxVonQyH1h+H5W3m8+mKJjsNisXE3ds6ubh/oIACmpZgKpDSoyyw2QPAWu6cE+u1bamh/xUo0nXyIs/8M7kHRjADAP0BpQoK/vicMHhsRUCIMjUHpR5TbouBuQvkX4LgYw3tmsdJkz5RrPd9P3EehZeJ6oYX/FXbgv0Uypl/1FI90XUukObgJ1Gn4qOSQRy3RcdcqLbB+wh/18IohHx7dRP+Yfzfay5sVMeF9haeBIkSUQINC+j8squWM/inu3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fys1ARkX06aqYmcodYhNvIKNyz/h3bynqoT8Ru/LKlE=;
 b=UGUZRD2zLQN2AaTbnB2azEpRlGvt/wC5+zmRiMAoKUajKAmKc4vW1dmRSp+CBcNqqCNi6/J+YbuJ2TolbmlIClMFsuk/kRR44HpF2ZsuQZjH4H/JlAhuhkXqy8Ub4FXekFjKseczANyEFtWQpCS8v9dVQ2OdiHMcGKCdAwstnDLReXkhWOiawLxM+MXNCdtFriACerqGh+r+v6Auy7wvhCY0SlUGYnRqbylnyroGeQ1FYQ4Y8oHhCA8mRkUw6l1xqCgc1tnGhygl2jnMz+sXMBd95WbNcuXKNFTYKIJjYUQnk75wuH0XmJpXVLvz4rYVDAjVO8t2reuVOEXy4kz8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fys1ARkX06aqYmcodYhNvIKNyz/h3bynqoT8Ru/LKlE=;
 b=ZNXUzjEjHdJJ6BMEsxiS0tB0WlTdwxY2hFeoVosflPPhS7U30RGMuXaY+KfyzN9T1d6MFPj+sjq6S5JYuHvExPmRd4JNEKNZCh/zdR+Gzhf1XG6qzvx7DOXF1Dhb67F+Us3WIo0eFjstQXFc/6N6DLUSfPvzhVMEdIs9lfcsy4k=
Received: from BL1PR13CA0351.namprd13.prod.outlook.com (2603:10b6:208:2c6::26)
 by BN0PR10MB4837.namprd10.prod.outlook.com (2603:10b6:408:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 08:18:38 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::7d) by BL1PR13CA0351.outlook.office365.com
 (2603:10b6:208:2c6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 08:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 08:18:36 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:18:35 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:18:34 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 02:18:34 -0600
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [172.24.235.46])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C8IUWl171777;
	Mon, 12 Jan 2026 02:18:31 -0600
From: Moteen Shah <m-shah@ti.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<vigneshr@ti.com>, <u-kumar1@ti.com>, <gehariprasath@ti.com>,
	<g-praveen@ti.com>, <j-keerthy@ti.com>, <m-shah@ti.com>
Subject: [PATCH 0/2] Enhancements to UART driver for error handling and DMA RX status
Date: Mon, 12 Jan 2026 13:48:27 +0530
Message-ID: <20260112081829.63049-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|BN0PR10MB4837:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bc70be-f938-4603-b759-08de51b32f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X6W46ImLtjwKgSrhttdbx4SLSfFXtTDTXXc+9/hU162meMYWiEQ7+m+U7vKQ?=
 =?us-ascii?Q?M0yVAfRdUHp14Uf9Xr98UnCQMaRReSLK2fn9HPHdhpZMy8op5kGXjVVu62ub?=
 =?us-ascii?Q?T8jdebM5aydWZUmTVsidhk/eBTN7KdR6nX7HRvQ6Y8joFEYexayJpALLeRwX?=
 =?us-ascii?Q?cj72xosqYTpvZUjCC/9KSfdMIB0KBObvfdOPaWxn7eAcqDxFBMHdudSkpisv?=
 =?us-ascii?Q?1dyY5GlVzGkz2lFR15oWcjJ6md4yjL7Klh6BIoUM0c+tGVUu3l8wkrG782vK?=
 =?us-ascii?Q?VOao44gg+ftYbKSPE2zkm4t/dOnfcnZNMAxm2L8082n2rbqkU/kzU+TMk2iU?=
 =?us-ascii?Q?+U2Ss315jqgd1cLGsuG69GPPw2nWDdxyeBOms090l2cOByI7OfzwiO1RbY1q?=
 =?us-ascii?Q?6tmUoZ9QeER+dL19siMy2NVDSgdo+O82jPH08dFgUdOM7Bxc8iuedrqVzqCJ?=
 =?us-ascii?Q?U5uTTFXI2ePVoD9WPUw56+lofzgLlePYfUTCFKRhpTEXjyUGtQtUJ4Q+Iglx?=
 =?us-ascii?Q?95j/KGDl9i7xtRrFbtIqca2ogboi9SfoQlg71RyId22UwgcynBmm0HWLrnAe?=
 =?us-ascii?Q?MklT4r/RMcY4C0avcA8HeDMOTmFhsujk7wzjhFp5Dap4z6uLyHPQJTLVBh8u?=
 =?us-ascii?Q?/qggkVgjzOuGbjh1SksD0DGSMc2tz6V2HC1HMyRGuVFTRKDtgKilEN8CzFPY?=
 =?us-ascii?Q?l8RwaaGHwyFjFUrDzum9NO1dhNpjgkkrrkp0382jaMCiR2Cje4GSik3Qsfsz?=
 =?us-ascii?Q?kQ7cnSYSW5328eEMqubMNTbo3dR7iyTnzYT6lqt4DPk0/gH4voPF3HeN6Dpd?=
 =?us-ascii?Q?5t2vwzC1QoghQTpGvhb8ysLi230WLXJ5mf9okcOIApfWSQLl8evp0n9cucrk?=
 =?us-ascii?Q?EYXjIHPamnpT75foqWA6IaNPIHQgtyBqhY/ayyaZ7mZHWLIve5m/+ZL7QxFW?=
 =?us-ascii?Q?qExq37D3xzuFzPLW2DgRdkI2toULDr520IgojpbhkvPUYz1T9s62pFU9BIGJ?=
 =?us-ascii?Q?XwfdNbzlfeR6w12tfoT/Usnf7zRvY4ldhNI6IY67AbifQlZgdifiIiXf+3PB?=
 =?us-ascii?Q?4JvyJadnQM3PGnUJgTgJQctPkerqNs50IfD9gCZgGBgrNR6Lb1wobg+G794e?=
 =?us-ascii?Q?PKUfFj9bheIwL20GELQJTODyeE1A8j/eDS2dLaEl8vsdKoEaSTZPx8X7LArS?=
 =?us-ascii?Q?5yNP9p7IEGS5oZVYeQck5Brnbl0sLwA9Wk/gY8XNpcLSgU+7efJAHuxC340U?=
 =?us-ascii?Q?tiVI9DNP2OYrA0DaC9K5vUBTqIBvp1ftDmYIO7tCEhUD2DCGz+hWtWRJm/o5?=
 =?us-ascii?Q?Dx7CcGNI9jfcblSkSDbP5068EOCjwRdUbbzOU19oD/dcOcQ3KorcGmDWry2S?=
 =?us-ascii?Q?tVrCNW+exWZdN6WEFgrpWYDtezL0S7dA4uiUliuViFUjDhE7oADIAZSmbWfe?=
 =?us-ascii?Q?3PbotrOs84FD/jqpta0z9msrZaK9fz46M0JF36kaxWIxMBa/kYHsq9TO/4jx?=
 =?us-ascii?Q?k40CiJV4qzbSb+b/V5TJSAsxJiTbVrKWNTZufSVyDbvhyYG80t0nK1ve5Eqv?=
 =?us-ascii?Q?ZDgej36OO49RTe0dHWo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 08:18:36.2017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bc70be-f938-4603-b759-08de51b32f08
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4837

This series adds support for handling UART error conditions such as
overrun and other error conditions before any DMA transaction is
issued. It also ensures that the DMA RX running status is cleared
only after the DMA termination is fully done to maintain a sync between
software and the hardware states.

Moteen Shah (2):
  serial: 8250: 8250_omap.c: Add support for handling UART error
    conditions
  serial: 8250: 8250_omap.c: Clear DMA RX running status only after DMA
    termination is done

 drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

-- 
2.34.1

