Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010AECA0FFA
	for <linux-serial@archiver.kernel.org>; Tue,  5 Sep 2023 16:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbjIEQea (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354254AbjIEQ3c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Sep 2023 12:29:32 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170110001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102571FFC
        for <linux-serial@vger.kernel.org>; Tue,  5 Sep 2023 09:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY9SP2yjtdIFlJmInnJ6yead1gL4JH4QrScAwXOL7gTudPyDQ4gVMMp1F2DYvq69XZZS4lAhfKaoivLhZVy4HmNLNSwjn7+ohuyHWi1FSAEvvmgYnaKG1Y3gLOgrnZa/+zY+mQzqm+TsuL0hSXYsh4TwnV25Y8kjV9p55kDBVH2Htt0+hS5BDw2s5qCoh/aU7hPgXE9fwxoWNYSI7DnwQ6GH4xNZeI5Lf0gWDjOwZ/ADP9/x7U8Dv0Vk2Wrb1gP6wT3hRw24yBY6XZq8lOVWg0Qcrw3Nf6wwB3jRi060nDlz4AnF7aI1TSI+oruBq1T8jUjXrAdGOgQmL4jixsU+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO8d2fDFGJvLsdKXTMQW5I7cXQDWQQ2yyirzR2XKJYA=;
 b=RxxVBpQFszkd0HErbbzgCqC3PbwwX3CsYdh0p0sywJx/4B/e/xwIMTPMTmWstIFzzlqaj9BT47WD9dA1TTjDhE6MYi+cnlS0lUNsBUc0EpmDJtrSq/jsIW8DALGxhe9x3pXyCDGOyM8JM1UuSapzWhbSz7EwQirUf1en6bMWMRIB++VlUtUP5sczu24B4STMm8pyMeaLumGQYxue3xxJTRDVv9xjZvlMP3RA4PElGvXVXXlSRS/o05bdm8SVKMInYzVw2RbGjo5Gm56aRmw+5Btr3t+aY8GpfJ9PVVcfRdNYZooqWT2d4nZ+dyUj3mdE/se4wK19lRHR2F42sPDXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO8d2fDFGJvLsdKXTMQW5I7cXQDWQQ2yyirzR2XKJYA=;
 b=QYXO9TQ5OwrxKYYnWQ00ru9cWewlQluLYZucI5qmeLTQozpCEWrGxHWvK3YJxdwqAHMw4OTMSPaUYXxToX7Q8FpFfMe7tKs7LUp9Lr9sEiC8LMK2GR+DuBdO509EI4xxEacgi5SHpvOH94vYZGmn4wEUV7bEK6CfZ5Zm9Outfg4FSgDY98o3R23XlH1ydsOYoCLsfCFiCXwEU5GNh9JrYiUJLVYXxB0iRLJjyl3zBy+oHzk9WkJrSDlzAjR00i/3Ki8UZjcyIA6+6Vd2GYneERQh+jSxloMBQewbRZr+cXZ/xJ+9gOf/ocMf5+XC6VqkxlWXjFvrld88Bzb8M0qcSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by DM6PR05MB6636.namprd05.prod.outlook.com (2603:10b6:5:175::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 16:04:07 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 16:04:07 +0000
Date:   Tue, 5 Sep 2023 12:04:04 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     gregkh@linuxfoundation.org
cc:     jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        linux-serial@vger.kernel.org, matthew.howell@sealevel.com
Subject: [PATCH V4 1/2] serial: exar: Revert "serial: exar: Add support for
 Sealevel 7xxxC serial cards"
Message-ID: <72b3e74e-ced6-784c-01e0-8a851326a203@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0578.namprd03.prod.outlook.com
 (2603:10b6:408:10d::13) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|DM6PR05MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ce5e4d-08e9-4f4b-088b-08dbae29bbb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TEpYfe23TMJ0/5qST0ZSJOUgYEi3UcHM1W65dnqNV7MhvdIaAftatiVkwlZrm7WFZntUX3Q/gKplmufK7gbpDDALR0K/2clVVblsY6M/l5b3Z/gU3khmjEBJTCGWqRBZx+q+qAqKzJWcBN5t6fecUAKRc4GC7d2vvwfHGIZ+WmAL5TRzhhhwVjYdF/Tb0vW3mH6lbBlfdTmmaEfujFvtLUWpisZ1IOpAbexldv7BWQrGt4J+QNfd6qL+aDN2i2o3SKRzltq2k3RlkB8OxYNVz0VSRRJqFihte6rMdG1ii373gUll7pBUqdCMyGeI/qJVSpf2aq0lQ9NtmTLT1OpZ3+7ZtDVvGL0sp6vthPuNBB1yKsTLRV44U0ue4S42muXOGRSRymjcazlubgVsHJW93GMalIOSBM2lqqCmp6DRxaqYUu1qrGhjtPfvDeRihDyhFEY9VhcDRhAoHO6xYg2UcsXKvUOW2kPJOsPLfjG7IY8x0eLqFYAlla7zkeQpx6YIdVEzSAhrgQhBz/G7lkUpNQzSKBBNv4Hb/NZptgAPrkvc7aJreJTENAKgbrd8BH+E+K3XHdjVcxljaOX6WsSgz0k8DYQdQfhlvy9U5Hxv5uFjerenJ/RyWevJ32W3dxZs+srxvB1M76l/kwT2C5dlIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(376002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(2906002)(6506007)(6916009)(6486002)(66476007)(66556008)(316002)(66946007)(966005)(478600001)(6666004)(26005)(5660300002)(107886003)(44832011)(41300700001)(6512007)(8676002)(4326008)(2616005)(8936002)(36756003)(38100700002)(31696002)(86362001)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xNe+QUJC7N6ISWJXjwE5Xod+lN+DxxkLvbmCG+3LENNnm+KA107IBP3nOfam?=
 =?us-ascii?Q?Zyeklym1+iBzKjhDSIxuAJU3pDmbbOcIEUM9jUX0mWPODIwhvtfzYnnIbahp?=
 =?us-ascii?Q?uA4Q7pi2OwDTy42QS42/cUwH+gdr86wNc5jy4gMSgdKQ6K1NK2EhAB8IT5TW?=
 =?us-ascii?Q?4ELQAzSKWZpk2W1z5/uZRWuWV9/hAIO3bXovXRkmeyKjxnZ+ASlcJQIcS74N?=
 =?us-ascii?Q?+GrHZFNL9mgl5r5jfDmlF34FNMkxHI1m6ilP1StRQBOa6iBuyKFrdj9uxpg7?=
 =?us-ascii?Q?LYb9seBxv7/EW8d8fpvt6ec6sNAil2M/14ExcPvvU6gGY2PcBSZ5LWDYoaUc?=
 =?us-ascii?Q?ZrfIyT1JK5ibFwey4jSNX6GvD9Z1EjXKgMigfuqER694doFH+XwyCsP/S9pQ?=
 =?us-ascii?Q?Kz8ZlI9rEtc0ksLJIrOFq+OXuQV9lOU7DM1A8r9PPrH0dKwJQyI2299mHhIf?=
 =?us-ascii?Q?hJmpE3q5nGNEqotio1ylzi7MOhsRTor8RUWR/HpGjbm5ZwntRb3tYQXkCmjX?=
 =?us-ascii?Q?sws+YfqNHEvgrsAk5Hm7rD6mXfSJtuMoFpFu8jzgjVmjkjFPZluafTH7ozyK?=
 =?us-ascii?Q?++0qE/6TT9RX0lTllBV8NPzuF0kLXvdsrDzCJ0VPsZLsewfVgYB3LjYXQtQV?=
 =?us-ascii?Q?nlKKFKIpwk3Ui7KNjh5xnwWF+RNzkkprrdA624GtRxcNBAJHpcVBqGRreanw?=
 =?us-ascii?Q?hPNacbYxvO0La+2ykt/uKHJEtzsMQgSpgG+r+3h25PrjeNTetvdSsc5aObtU?=
 =?us-ascii?Q?9wInPOtLxE+iGO1hiVHqM1IjTjWE8XN21P2SUHPhhOtQDxpJdFZBvvwEVnQ+?=
 =?us-ascii?Q?npikry5UA1OFphNmYP0Ell++H8Pz42dA5SixTJBvdAfMKNLe7kWczp8/IzLY?=
 =?us-ascii?Q?lV4sRGStMiFCnOcKf8xD39Qr2v0xvc5zqZ4+vwaAsVJ+qUQMaoHaY82tW5eH?=
 =?us-ascii?Q?IVR1Pr88EhuZOgBRIMIuflMNtxmjwvTDByNR9JIiDpR4ldHk6KZ1uCxWtIbW?=
 =?us-ascii?Q?LHAyHHDN5KZSHWlU6V28C2BGl3acSIv9bMz+JyiLHEWDKAShqcWp/a90N22m?=
 =?us-ascii?Q?nphvOoHcIXkHG3PQ3WP6z2q2zIXtLM01Srop7K+PMmjJ4DOgvU/UK0H5JGMA?=
 =?us-ascii?Q?cdIAOlYACisTkkr5r3qj5M0lQ5l5YepkuT7oUUmqCPKuKu+LAGSDH3Mx/mCV?=
 =?us-ascii?Q?dAk4T9XptIW7qMuhG/A0VczytuYyQEJH5qaHisJA3Bru5PVHOw/zspSiEhPI?=
 =?us-ascii?Q?D5mrVQO7fzPcgrrlKuRgNIO0h6jsbBaXW9qn/jRw+GpMoINfKXdAbKBt9nRn?=
 =?us-ascii?Q?YCrWeD5popKac+o3oj4Ru6KZaoC5hxSpxHlVU4SsjwXzuESBcfUPpXEahrao?=
 =?us-ascii?Q?Zr6nIEPC8Z9bcvTGXi90orOYYXNd1LKE24OmLvV84Oe8EM2IYy5c3loUB8zw?=
 =?us-ascii?Q?XzDQygAKRXXTwHhsY/G09nrvCLGlPB2mRLjJqdJ2T6XUIMVLM8CtZRTbhhgy?=
 =?us-ascii?Q?blLcfh5XbHMoV3LmbG/+fGp00sazDsOamHcA/NbQRdMJvAEBFIrVlNbNpXXF?=
 =?us-ascii?Q?R0ao/azYTQO0bFnYoiDdb972xT4ELjVRqv/ygImM7pB65cx2/tipcQB08Fpg?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ce5e4d-08e9-4f4b-088b-08dbae29bbb9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:04:07.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRANu03LT3PfbuFmuBW9961xjyf/9s6tT7n5zkkAbEtpzKio1NCe7VjwD/nM/wAyhRXj482QJNsEscPV76GVL18gIHPxtg6nlHMhb7ami6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6636
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

Hardware ID of Sealevel 7xxxC cards changed prior to release. This has 
rendered 14ee78d5932a redundant.

Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"

This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.

Link: https://lore.kernel.org/all/9b22e58e-182e-fc43-2a08-c01847ff427c@sealevel.com/

Fixes: 14ee78d5932a ("Add support for Sealevel 7xxxC serial cards")
Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 077c3ba3539e..3886f78ecbbf 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -47,12 +47,6 @@
 #define PCI_SUBDEVICE_ID_USR_2980		0x0128
 #define PCI_SUBDEVICE_ID_USR_2981		0x0129
 
-#define PCI_DEVICE_ID_SEALEVEL_710xC		0x1001
-#define PCI_DEVICE_ID_SEALEVEL_720xC		0x1002
-#define PCI_DEVICE_ID_SEALEVEL_740xC		0x1004
-#define PCI_DEVICE_ID_SEALEVEL_780xC		0x1008
-#define PCI_DEVICE_ID_SEALEVEL_716xC		0x1010
-
 #define UART_EXAR_INT0		0x80
 #define UART_EXAR_8XMODE	0x88	/* 8X sampling rate select */
 #define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
@@ -652,8 +646,6 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 		nr_ports = BIT(((pcidev->device & 0x38) >> 3) - 1);
 	else if (board->num_ports)
 		nr_ports = board->num_ports;
-	else if (pcidev->vendor == PCI_VENDOR_ID_SEALEVEL)
-		nr_ports = pcidev->device & 0xff;
 	else
 		nr_ports = pcidev->device & 0x0f;
 
@@ -893,12 +885,6 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
-
-	EXAR_DEVICE(SEALEVEL, 710xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 720xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 740xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 780xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 716xC, pbn_exar_XR17V35x),
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
