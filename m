Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF72C83F1D
	for <linux-serial@archiver.kernel.org>; Wed, 30 Aug 2023 18:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjH3Sil (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245300AbjH3PGB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Aug 2023 11:06:01 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011000.outbound.protection.outlook.com [40.93.199.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0BBAC
        for <linux-serial@vger.kernel.org>; Wed, 30 Aug 2023 08:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UozuLXmGWQf7Zp1x5EuQkLuqrF0K5kUrS29JRa7kdU4pvvlAaGhhkk6v3UDIjBEE108z5ZKcKmWUZnORKJjWdOJS+NW/f4GpWopDFfFg7pPdr2nNwVDjusPoKsxb6IoukHQDE2ZY7kVzB0S68YJmYido5cCqH5C14iVoCXfzGdySWlxMLwIIGczyxl6ZDe3/tPFhYFZltVOrtQ+HdoiJWpXETIpsTiZkzCcKkIBM23d53O4qbteZf9Sj80D7NmwmJ095W83GplxhY51BvH3tS9wQ/JtKiZBiTNVa8Dbn1DAP12zeUXa38GctKEt097EwsHa513Rrbl+F4sU0YcVa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJVy2iJ+L1kYIu1EQmCly+qY8u35DNnIQ/nh7FvkJ8Q=;
 b=M0mjkOMbnVfolyArbEa/SV7kkD7rRhb79AM/ReDP5y4EIKdR4Bsk7H99ZVIFYTXkM+WCVebDTWbqyLeaoXqrZTyZwhy9v0s4vrd5+GTOT3EcjkxIjJGqoY+Yyb0K6n29bPbyfBk2SA5G+mCCOyFv1v5QQqaTOAc8P8guEwhAyVjFznpzOzpeEaeTbuveGFdeCHaYVwoYBn94zF6AOdPXDbsWEY5bf8YitmGWR1dpH/30HE7CbBiT2bQ/3sNs/z5rxcPiK8bHC8/VmoOBdqz/Bl58G+jd9qmDa18H12Ac1N7DMrRtCyZrh2Z4gs+n8sgiLB9cVQCuKShVFEr0o/0Z7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJVy2iJ+L1kYIu1EQmCly+qY8u35DNnIQ/nh7FvkJ8Q=;
 b=lDuy4DVGyIMOoB9AavxlR99MLNSd6F4CEoMxorkv+zLMSWFTwGso6kjHBrfIYstMTzb/AojIsFY9URaWFOW8bF4GP7RODypk9oxMUrjxe70mnY3IariClUSR7Tn8o1ArHhb02/vLN53rFOrvHsPT1DxZNN8YNKmiKugK6XgLwOJiwVuzCZIXZlLxkLlZZH5bfPuE2ewk/49i7wXhRCIHaTukZ74xn9ozaWEsFYfwX+R/YxFj0+AygYIrWtlmILEnInzivzk8/+UDE4p3uuhBx+F0cnSo6rEIjE2GRurEyQujWKlIXvXb4+SFAGnFNSQG91psEB1JNMovGFlzVyXUCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by PH7PR05MB9978.namprd05.prod.outlook.com (2603:10b6:510:1b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 15:05:54 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 15:05:54 +0000
Date:   Wed, 30 Aug 2023 11:05:51 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     gregkh@linuxfoundation.org
cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, matthew.howell@sealevel.com
Subject: [PATCH V2 1/2] serial: exar: Revert "serial: exar: Add support for
 Sealevel 7xxxC serial cards"
Message-ID: <b2a721-227-14ef-75eb-36244ba2942@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:408:fe::12) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|PH7PR05MB9978:EE_
X-MS-Office365-Filtering-Correlation-Id: 788894f5-4f03-4e13-a9cf-08dba96a9b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XekguSIOOsc6Cb74twSeZlCGuOLsUI7YMHi21SZ2rJKbHfrgv88gGDeKd0R+cbbNcTU3xs5NlmaCbFDt+P4ocpIStbHtkQCbDV99uvNHhfMUP2ACaDb5r0bRVc3WvPpgXNUfkGdCqnyiaNAO0iduRRHDNcJrPg4AQiDlL6GS01HgsPOR4JjS9V8mwf24f/ZuXdr8sZyRK2fg5QHN8F5oMr8b07ltx4HI2igIf0ourKvCZ68u3wDHnCMZCvEsZpyM5hMmYIv9SW+oskk3OgPz0lLhHDUJhCHXdUQHhvpoXDX0woF6k1dmtjiK8ueCjFZF0DVlwlrabOI16ZOkRzObY0SoVDXtUNzwDZuFDhpXD9UkH6QhQXTLU6NK5deDU1zYxZcqO1weK+VXtNOcr2jFauvXdI8fA7w/TtsilZdcUv+xnDqEUBqVt0hgfzs1mwW9JzGSDdNOhrXpUxqkpWsrzlU5Nhjw3adc7oWpa9SjATj5VCFyNbyEW6ER4tY0bIX8KPePD/FLZpaojFbnhS+rq5nF1xT4UeCAYcRy8Xh5HySQIbw5NfvahI3ePFKqEjGm3Ust2cpw58Cj9yR645pZ69fyJSq6uz/+fVVYEoY8qhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39850400004)(186009)(1800799009)(451199024)(8936002)(6666004)(478600001)(66946007)(66556008)(66476007)(6486002)(6506007)(966005)(6512007)(6916009)(316002)(41300700001)(38100700002)(36756003)(8676002)(26005)(44832011)(5660300002)(2616005)(86362001)(107886003)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gcwBUZph38uFqqwmxrssZMumZoA4k5H4vQ6yRS9N6chHJ5JkRLJB/thmhdui?=
 =?us-ascii?Q?VGFMonS7y+HFJDXtgce21Kmdeow54pesZOE25CKc6I4QfqkRYPIDCFNWZ2Yi?=
 =?us-ascii?Q?/bfq1/ietd19k4j/cQ+Mls1uZbSiil2ul7kJNlzy+/9iK2H71p847tFZ2PEZ?=
 =?us-ascii?Q?GcUHNUrQo3eRG7Uk2HBZL/vZjJ1fy8x3kp9egI2BXmY1mVpnrH1kZ662zISJ?=
 =?us-ascii?Q?g7+3LPEoXJhN9iyvwSnrfy+A8SNUrpzSmqfmq8+4bRZgJEUGzogR71w93ggv?=
 =?us-ascii?Q?k9+74QG5lAbq+foEAxaL6347eaIMrsMYj9XWi5HKY5ks0al1jide/0YAluyJ?=
 =?us-ascii?Q?ZLQhgEE+3jlv9/rUmKTZ6in1D1WgdPAif30st9YxgFMI1t+7R7xzhl46PQas?=
 =?us-ascii?Q?O+6QAjUoBVZkluCyMG8BalFigSrsZylp0MK9QVv+MIeLEFbyCGgw96XQ8yD2?=
 =?us-ascii?Q?ivVElsHfBgRkQa8yuiL/WNju/XkbNCjg7/y1cVWlYVjCRgBarSGoWcpV8/ZA?=
 =?us-ascii?Q?fqBaUk+T0aN0QAbmR5MqizG9ocg957HAEtT8TXjH7eooMtEEJKEoJTA6bLvY?=
 =?us-ascii?Q?hk0I5ODJPgQ4WAiyCVmCDHEf3hIfm1/vYtD57BouHoba2fcY4y0br+DllFHO?=
 =?us-ascii?Q?V1gVtGidtiFLVVReb/TsjbuoutxgHoKbsiH+7klYaHE5Xt1xHwSiTph+TPKB?=
 =?us-ascii?Q?/DTdNloUcXxFP3e6l9xv94LCa+A824IcYLoG2RltBHZLjhHq0LpeVg6CWGEJ?=
 =?us-ascii?Q?zGLpsZ53Woxps3xEFdrBx5jD7r7NNzJLv8/+SHXG12Xa+X0SIKj2ERr06nDH?=
 =?us-ascii?Q?FOJ1M76tI7YuT75V3gjh+7OZo5ewghbjPdMLmqYYC9jykiKfAq/p1eJ1Ikul?=
 =?us-ascii?Q?TuEXu6rlMch2PEkn7qUQt8OtAmE9wruxzIWqHtof4nEEAO1QyaqP99zurQUx?=
 =?us-ascii?Q?9PCy2YXtstJsHMoHhQe4NvEG/oNau0yeZbqakrMa0nAPTbskb2GEW0EfV4kH?=
 =?us-ascii?Q?H0o0QP1X4VBT7DmGbbwd4b1J4qT5O388yikDQdcNT1al/yCNX9rNgcTb8hPm?=
 =?us-ascii?Q?JsioFwL1JfeNqnUENCJsKQQ6n4FCj/lFEzbcXZ5MS5opfm8Agu7bvGSGumS3?=
 =?us-ascii?Q?NCHh5DE2F4GsC0skwcSP4PHQLMBtUxuYtoeoonmrUMziSiZjXLI8v964Y2aD?=
 =?us-ascii?Q?cW4F8AxiRR3DMKkeDNP61aZR0OMx71ORw0TTXIm6V3fkDTT2Wu6PGkAxQSX3?=
 =?us-ascii?Q?vIXos6vB3p2j4YEmx6kJUBKvMBuhtO9ZkXRRZD6LGhp5vmrHD0GDcv0G4D3u?=
 =?us-ascii?Q?p9hBJ6aZCFGe18sw+CDZHWppnys4vgrKP1GqsFwmOm9fXKd6/qzu4opUKzT+?=
 =?us-ascii?Q?+dQ8rjgU0cwx+1F1L4SrSuiupCp9OlBx5rMQcz1pQxN1jQjaZzscLcwwWn6f?=
 =?us-ascii?Q?necxEEZHvqDhALykMotJu1Wk4TBMF4f4/i3GuFzZmeYP/i7o6XBminWKHM9V?=
 =?us-ascii?Q?HofvOTUZbxAdD8S+lMP0kw5O7jpqnvs9jpUdiHsZzdj+I0PliIhjSTqORtTl?=
 =?us-ascii?Q?j/5a3C29bPfz7llSp0oMBEhsnpU919TLu3bmsg7nMb9SCcxcHxhWqfDP0Dy+?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788894f5-4f03-4e13-a9cf-08dba96a9b58
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:05:54.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4uBFpV5Y+0zI7xuD5MApgf45a7AD4/ZVR5FBj+FxgqQ0BgkfzJYdf7PGJy8HJZKR0k6aoio5ufFuqpXgBGGWD3n60Y24BJii4oELdZXJ+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9978
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

Hardware ID of Sealevel 7xxxC cards changed prior to release, rendering 
the previous commit redundant.

Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"

This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.

Link: 
https://lore.kernel.org/linux-serial/687157c-3d18-e18b-1936-f3f5b98ae760@sealevel.com/

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
