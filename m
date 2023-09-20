Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF65C04FD1
	for <linux-serial@archiver.kernel.org>; Wed, 20 Sep 2023 18:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjITSb0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Sep 2023 14:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjITSbZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Sep 2023 14:31:25 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012011.outbound.protection.outlook.com [40.93.200.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270D1AB
        for <linux-serial@vger.kernel.org>; Wed, 20 Sep 2023 11:31:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdERXyn6O1d0AFhQt9nA4tiRMrwangA4fuxFWuFTLZqDO0oLG21SYaJYLHbX20VihTDYrTJRblD/M4iCaVYvW5LUuMaehej4SKsdai20cBcn5S4314HBUJSVYdPIYKaXkXQgnngs4vZedovQPm1/FvHgNzHh4Dyc8rTwK38Lv37nUyZhs6xavE4/1bx3hovDBhOWHBDUwrNmgv1P6WtnHd7sRKQ/jizMkWVN4Khqj06w6A5Qu/tRzfqI3ou7k2TWcrAoVmEUDaVjpuVXyCtGu9nG52dePtDShkI/2m9WwYg60QqC5PFHMREMgdogXnbcouwBU0MuyAqS7TnCDYKVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbJ3QQwvQe0uNlTFdWaXDrNyKZMAGymcRmn+PiH9kJg=;
 b=JDpS3auGqn+UTSAc7c57Ub3gO4FxAcApLMrTmSRAoIargkyBUGQ7Fls4TUsB3rIVi0+/HojZLsVkZL7upOyMTqpYO9wlKDmg17VgotAVMw3iW984NaI0AiZ5Z+ohtC1iTpMZ4TnYJCCPl2AswLkSAVUvNadpHPxkXZz/y3wzgCoocVTZJV/9+zdfDLYnCn2TKY0ZA6Wpt/RIyluI1LD7o1IV+EnpPp/8A8OPjbLkHtGHQYBtAW+4ZfXqn0ymwXTKCUW6UVyxwbDwoVa0R18kS8FgJF14cevNoJCR7ESp1M2SSHap1RlUm6zqa5aqRJSxPTVqIl2Ro0RLN+wXVGZ/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbJ3QQwvQe0uNlTFdWaXDrNyKZMAGymcRmn+PiH9kJg=;
 b=ThX0fuQZB7NLYmrAp8vh43vEpu5k3dIsmBar+81v7Hrmp9Bwzh5oVdGYEDx/JOdZ2tTPL9V7RdH0pqFyWUcSe0pHshEQnXy+R4+NAb+IgnVZ67C+3NuLnwtAL3CWASuZBH19QfuNe6UTGTo6+dp1QixBJB3tyC3VsM2t4lpoqCOfqf3ia+50NLqPUAcBxMAEyS7IPS7ThUaH24BfX715B7YzwYDCddbwyNhodyP8yciu6oSjK7aK/i5vc5U2daG6Rqrkf1vp5nGAzUoaXKpAumlIBmH0wcNJwgwTZIY48rLzAr1J+bBYi9n9xlpu0O/xDlfoQZ6ACmVq8TwNcD79Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from BY3PR05MB8419.namprd05.prod.outlook.com (2603:10b6:a03:3c6::10)
 by PH0PR05MB8525.namprd05.prod.outlook.com (2603:10b6:510:a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 18:31:13 +0000
Received: from BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4]) by BY3PR05MB8419.namprd05.prod.outlook.com
 ([fe80::f4e4:1bc5:23f6:c9d4%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 18:31:13 +0000
Date:   Wed, 20 Sep 2023 14:31:08 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     gregkh@linuxfoundation.org
cc:     jeff.baldwin@sealevel.com, matthew.howell@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, linux-serial@vger.kernel.org,
        andriy.shevchenko@intel.com, ilpo.jarvinen@linux.intel.com
Subject: [PATCH V7 1/2] serial: exar: Revert "serial: exar: Add support for
 Sealevel 7xxxC serial cards"
Message-ID: <74f33e00-f8bf-5d82-3978-726fb78fca3f@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN1PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:408:e2::17) To BY3PR05MB8419.namprd05.prod.outlook.com
 (2603:10b6:a03:3c6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR05MB8419:EE_|PH0PR05MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 295c73f1-9889-4ebd-5bdf-08dbba07c4e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAfyqP+rzA3ANUh2EEArClCyc1nKg5+IgnbyaITSJlZdbJ4NMQ9mKAuyxmkERUMNr5vaAzM2MKUBk1OSO1plew/CyyuV1LOyQyFyAScb8PYlg6KN5ZESQ7vYWgYZKVLoLQNYLYCe18G8Kk0N65KsLR4mpSBPZYFDq+QMEHTRTCE3yMDRIkR8PuOfOa8pMx8NvR3XBGdSKL2cFzgRbMyitTdelV1DO6udfq9krP+W55GkKqnX3xcUaNK/YoAjF0iQjGna8/yvu38Z+yTzP/I9oli5WqWPrayjLOpKO8pgp5WvJ3EBE4tXfM3zg6jkyLeG9xpnJhwOtG0D6Mo9Tf3zEinghzKv1JdPIdXSm49BCLjXfJg86+Y4tQgDeiymZKHcfB19MakHfysuDPCLAnbiZT8S9Ze0R/0IgU3+PeyK2DqU+qMPdy4+8O/x8Ud98eLOMie4fQ2FhfvKFoIEIFV2J9vjxCOFXIt304JUkB22FNx7+nMNXGcXsO9s+Y31kHZAV76iTZ2WV2FqKeT3b/2776WqKngI7ETzZTtbBe8YdQzFd4E73VgbBpn4N/gM71NzGHhD0RsEkAbrRVyUk3BgwGiZHFmrqKtbRPEE5jRe34l2bu4H9qoYonIelAGjslVL46iYnFKTTPeXn1Tr//PVUIqq8Uf9iL3coFie+Z8jMA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8419.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39840400004)(396003)(1800799009)(186009)(451199024)(6506007)(6666004)(6486002)(478600001)(6512007)(5660300002)(26005)(4326008)(2906002)(2616005)(44832011)(316002)(66476007)(8676002)(6916009)(66556008)(66946007)(8936002)(41300700001)(31696002)(38100700002)(36756003)(86362001)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3IL5qjh5Y0+RA6vLQ9wGXcndRyeSD/hy4BUf0yL9Od2nGIHwjlLCypPOiSXP?=
 =?us-ascii?Q?G4/f7oY671P+K9qlV7vvyty4+glhI5G+VpdxvDjraxmsp157MdUqEkyaYDOt?=
 =?us-ascii?Q?A7IQqPkJ6CygXpsI0PD2nPpDLEOeWkxJAUwpqih522nivm6Xr2l/M6ryv/4J?=
 =?us-ascii?Q?Kuw8syDfoJjamCARG+bmxTqXcbZ7dZMslpZA8AlVfXsVmVsHqGR15JLxx1uF?=
 =?us-ascii?Q?UBKLnXmg/iO+8AzHGbzYo7h5i8B8OwkTXrd55jLKcW8v6TWywqDsw6mdP0Y6?=
 =?us-ascii?Q?r3DaQhVWe5OTqT8/adJbnDLz8X5hZiD/UGWPLBEClhDn8LibPXrFgWagxW/u?=
 =?us-ascii?Q?Twp+5npctcNEFOsI9t/1UjoEwh/XYwlL5QZnm2QOZ7FD2Fb9DNASOq9gXKeo?=
 =?us-ascii?Q?rmQL6QIbNk5E7Gksrcyuf8jbssZUQZhf+6qZg/sC/sCthyWb54pCNGFvdHxb?=
 =?us-ascii?Q?l04sYLn1f0LjgOG4d46MyG9kses4SHrq4c8vP+dmGFG4DvljTvwMmIySEV/N?=
 =?us-ascii?Q?hk/f9QivR+KsVUFipt/1dTHodcB98nay9nJNLpjIKkZHvMsCBMzVTT6QeboY?=
 =?us-ascii?Q?0gCJRICOzzW/3JFOobTtN7xhnnni3K/0oz9w+BkSV1+Tp5QIQlmefieyJ6RF?=
 =?us-ascii?Q?6Gdw50WNlv2jInHpwDPiqdMq39zO33XcG3LTv9FlwZMckatIqfRFIpeUjh3B?=
 =?us-ascii?Q?1L+PDku3sHK172Nlh4WgSIFeYnseq5KVbXdUvXqyUK69p3d+BZNdL8G+l+Oi?=
 =?us-ascii?Q?B082baBPZU153YNy12tXXR+fFSXGr6FoUnUip0AOE66OmsqrypD2UhHfQJao?=
 =?us-ascii?Q?Yd1bbgHrSVSEaz6Yb2L3AOTKa/k+d2YjjsgJf7e/40LGXwzL63io0DiL0rDo?=
 =?us-ascii?Q?i8HrggCDL1eZ79TiVZWHkYJBTx0Anww/HgmuJJnLeGMu5lurVU75LZjn6vbG?=
 =?us-ascii?Q?UahA1uzyVN1D8KjvN29AH8o0RD6mGRjpnNqRb41Acrr7rEoRF1hTwxYHFBoh?=
 =?us-ascii?Q?/z8g1U3TMGtwQ3byoHx3K2+oPf5B2oOolCdNj6aE45I5EMIL7HtKXfROn1H7?=
 =?us-ascii?Q?yf+JXFc8qDyC5vHWMW56D6i3w9mAxA7w0xPyw+X4yiUAqBrTwEM3qYmMWKfC?=
 =?us-ascii?Q?4ihlMt5YsyyCI8Ay+k4fsJsEgGCk+TvlwbPzCdbyuKitfgwjTUYV0c1VMGof?=
 =?us-ascii?Q?JGBQHyij0SQ4ubKpzw0YJceA/mUykkAP2w6nnEXTVHXVBHDThJhxx/3gvJKr?=
 =?us-ascii?Q?AM3mVEeMO5nVFnsUjTGQABo6aUTGj1n7R8JVC5PMj5ZpUmuxEf/RyBD30I+y?=
 =?us-ascii?Q?HAO3Vt2SzniOoOGnkYMvuw+xIu4FudzGPvVuN1WM+wafYrlc0WkTYsd+L2AZ?=
 =?us-ascii?Q?fJCx5i6IzBdAPX885fSfko/lt2pu1SlbzTbXrmuYVRYpk5gtXmumCZ5CyFK9?=
 =?us-ascii?Q?RVl9scoxpp4YQZVZ/ISseQbtMHbVfRqiH4lEPvfMPBSA0MB3zP2Hu01abxUV?=
 =?us-ascii?Q?x4RaYUXmr3AipMcuiKQR+CEmIdZO4KPgC1l6ZMGtPQrfaxI026E12Se2u/ae?=
 =?us-ascii?Q?NVnshILkt/qLB5UG3iAGykgTOzf80aen6aLMvx5IBKiUgJLsJoduOAmSBShQ?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295c73f1-9889-4ebd-5bdf-08dbba07c4e1
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8419.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 18:31:13.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vs6QUBro3SPE6kVEhFJnrbIvpOkwx7vHrUskZaW4YJgPYkyOEIFxYr5rld39UQOMqWJK5CvohWpLNzUnM8mns9jYicWJDtCS/nznqiLfvjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8525
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

Hardware ID of Sealevel 7xxxC cards changed prior to release.
This has rendered 14ee78d5932a redundant.

Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"

This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.

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
