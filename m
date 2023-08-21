Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A8CEE4993
	for <linux-serial@archiver.kernel.org>; Mon, 21 Aug 2023 16:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjHUQG3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Aug 2023 12:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjHUQG3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Aug 2023 12:06:29 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE95DB
        for <linux-serial@vger.kernel.org>; Mon, 21 Aug 2023 09:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJKpSxfFBshzP/xoyL9515gctM2de4qnmbMVecZkWfcuEvcbs++lQQSLgMjvHmCpID+M0DcwAuIqHqAg5NupSxcnuHLQqnMPKwq6eXl24ReX2KLbU+4EshSBwLKS/EfwOvLyk1mNzgEn7tbyOiOKU95OWg2DuVdvyu0XoUefXlDDGovHLuf4uoD+dtVAt9HXH//Qm/5t1KVXyizNp0OT5vFWp0akc4dEB5voSt1dr60Cp4ttJRn933XmBR9NSyyqxQeHDLxthZmgkdUANz88G9wpMFv8ZwgXwZmKZnxMsTf/uSk9atpUOgR6ZHO4V0qGJQ8dK+6Brn80xiC91HaErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRw8qfJqON1y3bkeumF+O3lvp6WSCT3gXZeWaHZEXlA=;
 b=eJTP1WBNxO24xX+1vGk4NvVmBSzliyTozYdDNTwNLzl47Q4pbXxDccAVJs54Dnb2fIA36gnfr3mMbU49B8ivpMV++wSYU6rFVN2f11WbTQ93JzF9mIsoNs07aic1ooJEYMffI+sWUQJVIGFjR6H/IW7dBsOgegRylCTR/9WFhAZBOy9P7VrreTnmCqVitW0xM8baHfjUrCKrzYzU+m/8Mysrc0QEECJ5AL7sgEyg44X+Ysz6iX3uBzzWsqCWlm9QO4VHRo/D4khPUifgcdZCLGesF4Nj8ZcP8TNX41ayiiEz3w2mco4rNCUYUoqkwTnUbCSwdr4N986HV4KI98KJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRw8qfJqON1y3bkeumF+O3lvp6WSCT3gXZeWaHZEXlA=;
 b=nYsM15FQCVksmlOE/rtTofeDLIITNbrm4MpPgaImJnuhkTP8Fe/dfSs1NOn0E+dXuv/UDtiiCmgpXXYLD2SUnelEpnFB5JfkyY6Yns01mTs0fcgYlDzU96lL6px4ZAvLsERGlU5VP4KL/laKMhgTI/Vp26fC8inqGeIAeqsyBe9Mxt7TRqnQIFkfzwwsOIhSXyuVYHXbVcnCzyD1cWK12b4huNbsoo6kpwMXEvewYt/G0HLZObf7zybuA5DAMhQw/V1NbjuJ2vTLwswQ5P0XyVui5+g//fqsJcwIv2EqFuba4MHuUxuVzSTHvIIY/SLAJeJGNxiNy8vd3toShNFlCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by PH7PR05MB9777.namprd05.prod.outlook.com (2603:10b6:510:279::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:06:21 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:06:20 +0000
Date:   Mon, 21 Aug 2023 12:06:17 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     gregkh@linuxfoundation.org
cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com
Subject: [PATCH 1/2] serial: exar: Remove Sealevel 7xxxC IDs
Message-ID: <687157c-3d18-e18b-1936-f3f5b98ae760@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN0PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:408:e8::7) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|PH7PR05MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e94f68-b6f5-49b6-e132-08dba2608f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnuQWB+PGY5gkzIGr2n2ncrnrWi4OOVtueYrTxDn7Ih/QRJ6tdFGyJWtsz7BvrF5TGZsREES6lkGWB8xtApKF71VuBC0BSDNAIcoHWGXEm1jBp4JIm7ahOOG+Vsu9+NcYWg9PtjKtOqAxMeCSV6pA+Hx3cl6NS7kvwJrhbsSZ40hvMUcDhb1scSNsg6uDdbctgw+A4gtslnX+ZkUBLkCuN/EAHQ9cZYMMBlPUL1cYz+3tvKogX8yi3cX1OwgKqsT5+sdLL0GOj+EeNmC1sgk1xvIDu52Cabm5NsXEzSJPYXEe761EJdPxEPDrEaYeUbZXDhqDU5PmoYfpVllZ0woZbhpzoCT9E/Qt6xU8aGRqxYqtDHvt/wnMyggnibk3C3NphesJasEWxri7N4zA/pkJBv3iVdbF9YfQ6i7IFReUYSrGHr3jO0i+nKekWE7HaXxf88khqgm0oVst5flXpsRk1DT90miQVCReKj24NKjkyZOJWSkPRrDpS89pDIhMMJm1ORqIYmPVdf/aDiUo1h+sqcH+UwsbifeG0URIbmHidYH4LK7OYJdjW4sY7eTggb0vGsw6zz8ZCylMWw8RKenCWUEFSD8ftbwpliVyTPnpR03gflLeowhJji/I5zZKhoW42zbbCeboRUnfigZuYovW1bszPXy98UXzYxBxCCUl+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39850400004)(186009)(1800799009)(451199024)(2906002)(38100700002)(6486002)(6506007)(316002)(66946007)(6916009)(66556008)(66476007)(6666004)(41300700001)(6512007)(36756003)(478600001)(12101799020)(86362001)(26005)(5660300002)(107886003)(2616005)(8676002)(44832011)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nhe4UBX1jbi3qI520t4zwIeAI2YW7YfCm1c8saI4TgFZsyGm6RpDfG8YrEsw?=
 =?us-ascii?Q?HbjFBR96fOTkjvl9EYpFM8Q/8D7pouL92Pkz1V9JZed1F1rnsXBgudV8v+dW?=
 =?us-ascii?Q?WIzMbjGU2AMqsE14Nn0z3XYd/9e/PC07ZmIp67YAz84PY22ewJPytDhLahX1?=
 =?us-ascii?Q?B5Gly25du/JXgXYsRXXZba+BIrLVitMduwZYopD3GztwnSo1YjQZIjtFxyaY?=
 =?us-ascii?Q?A5QaPZetX6LGe5xstXI5SEWlkkh506yyIk4FI8Ttxew4gEhdsb5BgfT92Yfc?=
 =?us-ascii?Q?or6meHapuNviHlYBMLuZEvxTeVtajRHEiDIwlHe6S8xtpegl1kgOfQLFZ2FK?=
 =?us-ascii?Q?Njbo+0ZOj/Kx8k8x4M8kyh5FBPczI69/9s+dDAv6kXvjkG8ZwgNRk9YyvO9E?=
 =?us-ascii?Q?jWkwydor1k6/MejINUyiGGqAp2QjLtKPhgDdguJCC2IiDpMu6QMZhjJFqAr8?=
 =?us-ascii?Q?3zKnGuj+b5TB0hjeGHNr16urnQv2tBGuB3ZJ4RfmWTsTCgTXMPw3Wy/JfaRY?=
 =?us-ascii?Q?Ou7+syxiEqs+jldBw0ZCdbL3NRkju87E/FSsY+flsLKGNtQKK3tN52jZgZmC?=
 =?us-ascii?Q?ln0o9hAkYXiqB41JisTr6kZLeF7G+FbcuUxUOxQkRqKN59X4l95GWIEw8q7i?=
 =?us-ascii?Q?XNDCxfXjEfe29SlTQs2KKYv7OK6SH34pkZSMDnVV59L97yJKgwaIyZzVIVE9?=
 =?us-ascii?Q?3KHBe/U/iugw00ETKln/gDP7p1cztOJogz1nS1kWRhng55WrIuWO78qG6NoB?=
 =?us-ascii?Q?DeJ3sJGSDjIPyNhL8sFuTNjdiFkA4Nrn/oZkVTU1EBBP7Fw+SvLkK88xKNQY?=
 =?us-ascii?Q?EGGZckeS7xzYjN0S0u7ORCQrBfoL2TFK5ebsdO72xE+Aqg0pmcP1QnZ3RDmM?=
 =?us-ascii?Q?vOoAdu8CBFGkR8vdSAZbH1Q70XURXFFZtyNMWvNrf9Q/8o4Vp2cqP8KFDtIu?=
 =?us-ascii?Q?bc5bIkqQ8WBG1IbsSRIAR5mi6r3fxKaSjRSWdBhAph6G0wrG/FKI8htBTxzq?=
 =?us-ascii?Q?I23MGsHiDPSqTvGP0VawfhsQMyKi4gOt/xDIgSIoUsSPN3yrfW9E6rf04EQp?=
 =?us-ascii?Q?8GGS85BnyZ1GU+oRC/ZFnXgYk1ripYkn4TijQCfiwX/PEn5JB/ABKRiM3OwR?=
 =?us-ascii?Q?93UpFqMM3vNet0IJmQ9rj/meYlyKUx3yHlOw3K7cnHAWGpJq3MmYlNH89wyJ?=
 =?us-ascii?Q?DErjTTJv3AClLg9M/yZTrSdj0ok/WIrj3PR6l/9eJjzRR08WRU+5YsL7rzvV?=
 =?us-ascii?Q?nXVyGm9s/7DB/TBeYzOtmF85RsuCPbotdTg9eaZhAyH3kGzXK9ZuXX5LhCnU?=
 =?us-ascii?Q?p3dRPpfi4H+Fb3QBFxoVqRNJrfdEHw8861qc8qFRYIbLkMzYpuT9SIDOYDqQ?=
 =?us-ascii?Q?9WmlBp0wPrebFGkbMCYB8CHD+rYLZJFIuhMs243XT6kCoAJhfOKupl6bfLt9?=
 =?us-ascii?Q?BCoOUsMjf1nzQXe9YewIrcOuE5DIfucB2qTpXXdb2rhbFRehY3yN+rD9SbiJ?=
 =?us-ascii?Q?KEBGTlU6jPJBcUrsUSC0K4d7oK2KMjvlqtS1Y+yLzHTM1uRKzmFb4yzliFXY?=
 =?us-ascii?Q?KfM4rC0Bwp3622W0NbMIaS4qSCLlU5VRVc1oDHS9gn52joTQYgbCNMe4MMrE?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e94f68-b6f5-49b6-e132-08dba2608f3c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:06:20.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATKtwRN8CDK6bdnxTLhElwpDnkw7C1gBC6ytY9OCH2eim4CHLP0aEx1y8MrhwWbjiHVQfXd8DNmlPFNafNrwVVbGQIh39g1xy/8zFh6R5Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9777
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

These Sealevel 7xxxC IDs are no longer needed because we (Sealevel) will
be releasing the cards with the standard Exar hardware IDs. This is due
to the selected IDs causing unexpected behaviors on some Windows systems.

Reverts: 14ee78d ("Add support for Sealevel 7xxxC serial cards")
Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
---
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 077c3ba3539e..018cbaaf238c 100644
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
 
@@ -894,11 +886,6 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
 	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
 
-	EXAR_DEVICE(SEALEVEL, 710xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 720xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 740xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 780xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 716xC, pbn_exar_XR17V35x),
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
