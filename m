Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7716EEAA71
	for <linux-serial@archiver.kernel.org>; Thu, 14 Sep 2023 20:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjINUut (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Sep 2023 16:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjINUus (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Sep 2023 16:50:48 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013004.outbound.protection.outlook.com [52.101.49.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E8B2120
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 13:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHwqYh/3ezDX8QUn+wxKNmkNS0d97rCk8yxQM0IpLte52AL6GiK2w1PUwaS2RQstlD2/wnJl9ptncVxQM4Kv7+t/xHkgnfepDiQ+kXLtD6ocfKCS3aVAwpQryxvAcTBC174lG7wz4meSN7F+IErJ9+ZjdpfMxnA/1K6D8Wl8cNRV/SMmaBVAeIrtbO4jyLbrNlf/vjoDr6u/gITg6ASSQx62B/2FayyrIyYQDhCzRQypyThrhOyUDJoDSL/Tw8yGyruWebbC/LxGHtfeD4DyYee0KOHJzYwxpJ6qHlsP2l2s6JM/ZGVbQlYa4d49c18P7BN6sG9fJwO3sNllX58qyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo/KrtXFiKhjAm+Fee9qBj6p3IFkXTgylI3Aj6G6chc=;
 b=j87GkKz46Pk/JezwvpoI4DpGsYQGln1TTQCsDDF7UMwAooVh9Z3iEMSLlnZYc0FLfMG9vGB5XrvTZGomYEkl7Je09zuOuub7G24lPW3pMD9ypXqPw3V6QkaLzHAawx3FXlCsrOnJsbovTg4SOGbDluO7ohfWD1+ZWs1KbrZyq7PmeT1MO+gRteOiiDEvdcEfL4alMzjL9y/e/nYEpqdANmCV9RnAs5OhJl+OvvkM4kwCoPRLFSgsuM3fOp3EpoBQ3Nb81liEqTqly+MLQhGgvaor338K6uhQdT8alrVnX6TTnGaWYWv7bqJRuu+CWrNP7MV8MQaPt9vHnQLlzfzSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo/KrtXFiKhjAm+Fee9qBj6p3IFkXTgylI3Aj6G6chc=;
 b=Z2aJfWuktXhJt4mCruS99zxGZHRBk3agcr6Cq/sOvCOerDZMXU/OCqYGOqFVwfse2KRDAVoM3zUyLflBdMLJ8mm1mVVV2NZFZfHvh/v8esdx+afuWZ4/kElMmTDd2WiUOZnhEzzcJ7l9kWWtsJK1UHnaqjPojOAQjxVZP9rOU+rHBhpAhlGynNsKGap94tcEg/ulh2UI3m0lSLPCsQG4eJuHmNfqp0p/PkTAZ9fPV+/BzUjEsiPhe7LS9x+P4Bebc6SR95ZNcs4iuleDyETxNB+dDBpAtY5VCGI175wQB3jr4Tn/6FTf4zigUxjTXQtPIw9HKKxtdEq9qzB+7xL9ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by CH0PR05MB10182.namprd05.prod.outlook.com (2603:10b6:610:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 20:50:40 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 20:50:40 +0000
Date:   Thu, 14 Sep 2023 16:50:32 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     jeff.baldwin@sealevel.com, matthew.howell@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com
Subject: [PATCH V6 1/2] serial: exar: Revert "serial: exar: Add support for
 Sealevel 7xxxC serial cards"
Message-ID: <b5c01f33-35fa-e974-8f55-9b19d3b9de18@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN0PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:408:eb::28) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|CH0PR05MB10182:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5bf405-f4fd-4b7b-35fd-08dbb5644139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bo4Pc7lRZsDG5Nw4nL1EI14mf5p+wRLcOIjbPTvZ2psS09WUQiWsoj2QhNt4nm82NLO73t59bUkr1EIm6IV+kkuJanPTLdflqwKUsuRqSQz9MuDaeM28kjb7Pxl2ZavQoTIOwd+quVXugBGT2uR26mQvhU0ePuODu+t65YEL8+Bb6nbhA+WaiwTJ7r0p5teUMmo0P4R1pC69fAa60h8Zi0EDgn6y8xLnJlyyiRnS5WdaQ8gZTB05Wu0a2bFjmMMlI2qUZbd63HHJPl5shEeblg9q46txim8rsAcOmDcVBpzxR3EWWVPKhVFzeWVuvhNrAF7iyPgYPjEyJMqq4jKqa8dlIBimhlUwDNXwT0FGhDdtCElRI5+dp2hQNfmyiF0e3++HUXGx9GM0ZVvwfoUUGpJ9OB3ieQZpTov3BXnN9e+v3LHIt8hwCF+a4fwp2nqjgatjj8j2BWiqbyHCXjLfbuacAYGvRiM+tSlodfhCv3jSOQGliTsFZ9Bc4wkNrVBi1MYRgApHACuH1UWu4qfT90bUUMcXIyo4QIK5nybI3nv13dNvjvWpPyqKN3TCgZ+ZfB+oKq6cm4vaZtnmlnsjT6JaJUfUb3IPlHluem2se5XONtlNgJCYQ7/yMO/Z0q0U4K6dFl8AE9s4MsyZSneIEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39850400004)(1800799009)(451199024)(186009)(31686004)(44832011)(5660300002)(66946007)(2906002)(316002)(36756003)(66556008)(8676002)(8936002)(41300700001)(66476007)(478600001)(6506007)(6512007)(6666004)(31696002)(6486002)(966005)(26005)(38100700002)(2616005)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UUG5zlrD+7NMc6MGHp1PbuMR9Ck+7xJwckB6vP57cYh2hXsDU/e7udj7r6Zh?=
 =?us-ascii?Q?MZk7WRpnRYWrk2SvkxRobggoP/21gLttPrd9+NJoCuRTWpKXtF31Xy9SmdhP?=
 =?us-ascii?Q?4avZS8ZU63an5s60H2CcLvwxIiPKKhFEj2ysMdH+AxPdjevDqR5r27ncv/5j?=
 =?us-ascii?Q?unaIOWXWQod4RuX9C3VamoE4ydzJAS/DrQY3xUz+FDODBOeGKsiI7NGP31An?=
 =?us-ascii?Q?CpeV0q2oMbJnRvraaVSVlPXgWFUTft3l92lxlsy2whRvcnQ4oXcjM0OEuZaS?=
 =?us-ascii?Q?2pjfOiEtAwU7aIDkgTDYLRxIz0chrDO2kyl0996GvW7cYu9o4e4jNTnKPwf0?=
 =?us-ascii?Q?nw4wqaRzVnZdlgfcbmHxCbdeZcWUEDbwQMJEJuwX3vGEKyBU2Jw+ZVSI9roQ?=
 =?us-ascii?Q?GMzG0o1R82iH1Xy+VhGF9/Wpzv/QJrZNV1ld1xsH+HxgTOYITd8d/ktQf775?=
 =?us-ascii?Q?helCTQDqXq1Z4lekYk0lHlltA26av8PwCI/KeRnZuZVAzoKDrkynq21rJdEp?=
 =?us-ascii?Q?qpdhID2/q21BVX4xeWKohXGfp7tLcpqOlNluggBi55MGAqZEti9E9wGdEOzI?=
 =?us-ascii?Q?vYpch4vmHdWn26nMZlfeN4yINCU+iAuoFPKnaBcDQnIrO9NzAnC/eet/wWtV?=
 =?us-ascii?Q?53SmRNlc4PDyurepbNV+HwwmnE9hyd8Ob3mweghKxF6g3Qk34c/2s/A9k2iV?=
 =?us-ascii?Q?E4t5hjMc4QwsyCAqNCfil2//PhhnHwwPgIgFhdjof9ZQ9+dFlqrnX5sEeu56?=
 =?us-ascii?Q?NdPdjy2tPYpvsfvIPBjO/BVDGXTDxwYlbgQUWDeNtCofbItsLVo9WlC2wova?=
 =?us-ascii?Q?GBPfPUGTgJcqb6/Zn1xNJck4eV/ozUk3Iv1fCa1P5aWqTgqQfrfQ1rwXjPeR?=
 =?us-ascii?Q?H6BkdtQYi5fGFIzoZ7Ue5vDtSsJWZhPA99QLmTWFyuC/A3A6tPQnSW1wKXdV?=
 =?us-ascii?Q?jd8B9NJUW4R15E6lmmoJJAzULDm1WwG3GJx35QI1Rhab9zQ8dNIiq8YJcJSj?=
 =?us-ascii?Q?vdTIjCF39W1T1TbtVS4jm/FbxOeMZ9hmG1WvEYhVi6Hh3UjSgW7mVQTc/fIP?=
 =?us-ascii?Q?aZ1axKm9HT4j7GaEsNR9SghgYcevqo+LU6S9OSycIQdugz85fd+PXAElKzVt?=
 =?us-ascii?Q?XNMWNL622TLz4MwrpiaiuqNGnvBj+77CJ94z1yBKqPIUjTlmcLOQCXbtsGwB?=
 =?us-ascii?Q?EciHwBmox6/yCYOYCVUdMLh8oUmjgrqBQC2nn3zR0U1y87+eWniJvoy1hoeU?=
 =?us-ascii?Q?rpzdKtSb3P7Lf8lIvpeXM6LciSHNUgHvDfHs3oKUAk0OClvNKuccuZkO2x5L?=
 =?us-ascii?Q?F+jT1jJXiLleNekl39G/dyOuiQOp6gHAHgMiw5EtrSgRvIe24WC/5qizgjXJ?=
 =?us-ascii?Q?f7A22g6r7Noq5Fir63itG2SlQl4gVMCu+TH+6/WFHiX+iUO5CU1WBZOeuRu9?=
 =?us-ascii?Q?k+YGz8AwgTAKtiINmpPzwDxw3MbjPLZXbNshT0S1bbtVwrx7C8dOLGAMxDDh?=
 =?us-ascii?Q?v8FbhH6RmCC8av44lSuSO2ngRNroppRbBrxh/d2QxsgXYEurViJYqkYMgSf9?=
 =?us-ascii?Q?bzefOv67VtOT0+6X1GzLBE0Omghpb2mVvbtuZRx2AHem0a0PM7Kg5MvPZzVb?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5bf405-f4fd-4b7b-35fd-08dbb5644139
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 20:50:40.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCj88Vydub9cyjAw2z6m9zq/1HKxzXpwV60XjVlLOXQLjqf8DjuAW3gnEa7dY8r1du8e+jbzvnfRP6cmwpAnLp7vAK73kO7/G1pm332OcJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR05MB10182
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

Hardware ID of Sealevel 7xxxC cards changed prior to release. This has 
rendered 14ee78d5932a redundant.

Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"

This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.

Link: https://lore.kernel.org/all/a804d136-4865-f528-6434-68a7358d7606@sealevel.com/T/
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
