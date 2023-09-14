Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4997EEDE993
	for <linux-serial@archiver.kernel.org>; Thu, 14 Sep 2023 12:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbjINM3D (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Sep 2023 08:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbjINM3C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Sep 2023 08:29:02 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012004.outbound.protection.outlook.com [40.93.200.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32541FC8
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 05:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivnAuKekmUeT0VlYYqmDvXS5IP6a8gmb5EDXir6jSOx/Xguj1bvNqBGlZWMdFT8rnE+hApu+zwR14IVqrW73zk2B7WBf8co8soEy1GIjjJBtI8YvggP0nNlfX9oycnB56ooKmSbbSgN3o1MJ0xQz9/yq2fPWjHYDVyMEoozcN643Oari/dr7fIQctlJF0U1gelYLZ9z+WDCTMa6ysQf8sWt6X2c6MSg0y+/dW8Toq3Huc55sge9i2yCMKm0w5ueARsfzaqQYf3VFt+btUyDGgJ4EVFwWZJbleOvmSc3SA4O8HB7gFu8qInouvFCOGnphh8o0g68ZY31ganMbauYNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC47OMvfXFQsayPvUk7dZRTSuCVYLMzRlRgISBHjBY0=;
 b=QfJI0C8kPau+a2GLFeOPEZLTCd+tXhfRntJ3stY13zb/LLKp7QmVlxLKTWDrzSepEKeQ2bVs1FpAA27O99EcSdSICi5b6R6gb+bukPLIRcaOCXI24gPqArO2z0S9fKTIWhRsCWlLPHVKKopr7uSqX6CA372bwYRI2uxV3evoiCHpnnE9aNNWUj43kFm1VkoiHX/T0qQnpRQG1juDvFDidv8o6AyKeBR3p3J8ry3iOIL21cWIwF2uSW6Om6/8ruCfLx4C9HrLL8gnkDXBySq+pdPxtLiyarBMi9AP85MKnMwG2t0qX/Kloeyw2uSx++7k76Hxx5YCdx+fLhYtnCFXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC47OMvfXFQsayPvUk7dZRTSuCVYLMzRlRgISBHjBY0=;
 b=nsMvb4PtiDt83W6Fn06z2qgHhZLGBDGrlu74dBqiwLGDRsT+MSSM7gAomOkZARtKbb5VQg875KinXQxZgWKqBh6l8pYrIOj/OkS1wwql9xwQRIiJhSdSOIu6F3VVs0BNChXjlfRFUucDds4ZsRvZ3KwuU6QTz3fmNXxgBuUwMM0iD3n7u3N7fP5amYDlfGhMb4KGmqi0Oqd8Oy/t2+s2hEcBbUZmNSp1wY1R7ERVSfjFd9N0+1StuvnSKDx7V8ve/YvsBFUDx0kC1TrYLCAi4CyOWPf3RWbkc/QYy3pkDpuxkmxxSrrYk1AQAMxLMBs8piuNNGwi1x4KIGT+v61PGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by PH0PR05MB7510.namprd05.prod.outlook.com (2603:10b6:510:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 12:28:54 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 12:28:54 +0000
Date:   Thu, 14 Sep 2023 08:28:47 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     gregkh@linuxfoundation.org
cc:     jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        linux-serial@vger.kernel.org, andriy.shevchenko@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH V5 1/2] serial: exar: Revert "serial: exar: Add support for
 Sealevel 7xxxC serial cards"
Message-ID: <a804d136-4865-f528-6434-68a7358d7606@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0684.namprd03.prod.outlook.com
 (2603:10b6:408:10e::29) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|PH0PR05MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f3d47d-3e67-45cc-dcde-08dbb51e28d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nM3DaObhsPFbRn4u44gN7jtU/fD7lURemleyQtqw5wKqtJKakfwrkP+u0mhEjbfPrAmBpOtQ1AQJE1RyynIgjOB8jhO4QeQtVrZ+8E9ujXeVXz6j5VxuFIUihjDGt+l64g/VhwwXiu8r+J2e9r2Xo6K0b1FYaAZi8hPuFDJrgdXjHHKcKWOkKBlz8ob+poVrtOjfbd0rJwAWF09CH0dES4A+Bh4U1PO2JXTlb7aRrxOVsmfD8Hu3Gu/Zg6tdolk73cSP7fJtpBjRtbukGoFhC8g1lNGF8l2pAbeoerFBl0gOpyBEW6tZNopJe+6RCuGtwmScSFNJI+CWBzUgVRNE1CMYiRKVoP9aroL7IOuHXqTuPY8bOq9vsA5nkd+THPdKBvHPsoZdeJ00IcfzbvNN/+dULEJRlET9EIhUt8gnaz3QrHqWzeAsqpYZ1m9ZTeCICVeT369ZjmjD0AejJ/b2j6b/P5QhKwhEl3MfZB8rQBMA1ELquRN31OU8eSs46HehlRdA3y9iK+NcT0+wT8ybr2bhgq5UbqElO2Fhgdq9xSpbe1undBswxwxa2L9Bgq7RNWmulEhPWT4SmdAd3IwT3hyZ9r+Ea+d4/pWiBAzOh8WRUtxbeaOZB+K/MfjlkdAR3+hCXOvGJ4i+OH/Syt9t2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39840400004)(376002)(1800799009)(186009)(451199024)(6916009)(66556008)(66476007)(66946007)(44832011)(316002)(86362001)(8676002)(8936002)(41300700001)(5660300002)(36756003)(31696002)(38100700002)(6486002)(6506007)(6666004)(6512007)(31686004)(966005)(2906002)(4326008)(478600001)(2616005)(26005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UZ1BDFrelHgtVKbi6gw61qVFSUYd3L3s0bviw5CbXAqyBMt85hlaA9aZo6S7?=
 =?us-ascii?Q?mgiJZz2QvVpUgVNYVyaWxZ3o9DKs4b6idDfo9Z9805IiyfTm66lapq6nsgs6?=
 =?us-ascii?Q?NWK0A8g/Nkxg6yfeXOH4G4tqa+JDIz5qSlpE1XE0296XTVTOOKQijAeRL+86?=
 =?us-ascii?Q?0Zjg61eL66daNcsxWzQMUNvd6O2QFIimBF7d6pVQiDs7gUG6+voZJNlXKUyz?=
 =?us-ascii?Q?CkDruTAm4tzQ8rpImdMBunmZR+kZJPmziohTRN4Q0drh93PH/8QqIMwPFHzu?=
 =?us-ascii?Q?nHzLsoJPFHoHrPXdvg/D3ui4f7G9kQXQGmhbvxBkttGwDwnqc70laoHD4r14?=
 =?us-ascii?Q?1yMZIDZ1n36qY08JQ3QFBSRXMNyWzWMTABCE6CIk/GwPZYscjqa79bNU/Egd?=
 =?us-ascii?Q?Gjrmy0+/RFNT6q4VBQ+QkuXbif108HCplB2UGFTDxi8YJUxRwiLw3aPVDI9j?=
 =?us-ascii?Q?iwAOHqHTtVSEbBvg7GBjh1FfGG7MIoC++MLQAR0zDCfB4Yrm8i7oR4zJjPgc?=
 =?us-ascii?Q?LzUA8fK0JyXZHeKkYKN4YNysOWRchWb9i5vE70/UrjNDJziNqPRQ/0uyNn8O?=
 =?us-ascii?Q?uXThDkoKR69O8jzhVm5WwTDlQibCx+bL9jf0l+RP62XB6UkzVJS59REVPKgL?=
 =?us-ascii?Q?+oq5KwlK+Q6AcqaGK+4OPRp8ZwSESffNUX51e1AGkeE+UOdACk04mAkyCq11?=
 =?us-ascii?Q?Gy3WLQmxAJc8CRXEGfACm7x92ELexDvCVxtQgYDtZ2ScJ4ZNY5TosEggwKyY?=
 =?us-ascii?Q?qnCeBnyB2rxrn27KPme/tV7Dufs3VXrzks+O1b5exVoKIcoksdvswPieLeDX?=
 =?us-ascii?Q?85OFVS0Uw2C8m3GeTVKEsc1HpN7yCJQ8y+NpXoOfsNMl2r3l0zN8myrLV44g?=
 =?us-ascii?Q?kGNc2ZmBt+hUOWbDx86E2wHChpyeNQniShP3MUbDSjMT3DpPOl2VGd5bARkc?=
 =?us-ascii?Q?4nJWCQRFsEhCQ6FQX7p3sSpxlj9S13dbdFDJNyl1sQ/75xSobE9hC+g1XKLv?=
 =?us-ascii?Q?WT0XqsJpDf4XWH7ZCwgp+XQsDJfnlhEka/ZnCedf8rGn6XH3Hz4wISPAAd4C?=
 =?us-ascii?Q?YpXhG8rFeBuV3VFdQh5e3LgzCRS+yKmho9ZHWeQtqgTtrNNCdNPQJKQQeePl?=
 =?us-ascii?Q?rurvNdGbkwGiX+AFEoAElsSu9IBK67iuteT0I2gV4wPwHBC1zEo/DbVGNPYn?=
 =?us-ascii?Q?Wz0TGhygGePzqd+BlwCAQr9iU4IxGBX5VLOF+kJZf1purEh/HSYQHxEtY1HY?=
 =?us-ascii?Q?9qkPG9y9iei4Tnjvb2Ypt/kslxL+bQqdAnaMmmWmqQYh4oNhpPnmn/3j2hVL?=
 =?us-ascii?Q?SHdyryxtEvzW8kso7YBxYxOFDtGhdRzU0Wr3f/cQvTcKN26wjkhakozZ5T+2?=
 =?us-ascii?Q?l1cCp02CWB1enoxiC/cCG+1UfFcgHIBTEOKR4KQqxRDedY4HGNAIWzgHRy3X?=
 =?us-ascii?Q?qAXOLLYO5TS8eudihRO6i+nGKdX1dL8bjwRhId1a0h+5xQcN15yJUadrtPWm?=
 =?us-ascii?Q?O/AGzsUCF0SgzaTgMZ4Zns00oq6cSnuJ+1AsGRk76kftXoORD5ErqFSIvmcS?=
 =?us-ascii?Q?khSHjkSp/3MYGKk42bxH6/AzOGK7EuOC7baAzAMUq2uAGgLkPo/AwN07Msnd?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f3d47d-3e67-45cc-dcde-08dbb51e28d4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 12:28:54.2914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7/vK15Hb35pmtiQcRjVAD46PBaeMXA3+xbm09JZ4dBLPyY27+TjjcuhP494pMI4+p4WaTyC3QHcbNu/8Zj1XJ6CM3HC566ULlCTbQ96beM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7510
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

Hardware ID of Sealevel 7xxxC cards changed prior to release. This has rendered 14ee78d5932a redundant.

Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"

This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.

Link: https://lore.kernel.org/all/72b3e74e-ced6-784c-01e0-8a851326a203@sealevel.com/T/
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
