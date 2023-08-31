Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B09C83F37
	for <linux-serial@archiver.kernel.org>; Thu, 31 Aug 2023 19:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjHaTno (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Aug 2023 15:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjHaTnn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Aug 2023 15:43:43 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011011.outbound.protection.outlook.com [40.93.199.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B901BF
        for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2023 12:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM6ia8EYo2VKr94eZoen6AznJMS+02ql8B3J7KoZD2qw09mppRQv5zyx5NZQQRPg28TVzqdTCNPqA1d4+LHvpZ64k1WtYGLC9BxfPHtUkXaeYpgowqTTGWMRWTA52L8/u2lozLlSioQdXGsFdAyPgtdzJFssA2xDLMhtxcmO2Ey0jr8AeSzBz/jeN6C5N6YvxPsgmGIclv1P8W9RmzM7M9vq0qrMl75h+/pyaLeX/0v8X11rSQRTJ2m68hFk59jkH5VdS+VpFlZdGv+IwBKSZmI+1oCM6VRU+iut+VGnjSQqxD9iwF8djHGWurggsOqhN1fF59GzVZya82xtLq/gcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ+y504u0u7eMilq3DFwRbDCpNLqYJ0xasrldmQWI0w=;
 b=VTXdi1dxWJjFxypzAtnYbH9QYCtG+Hjmx05yxsu+EdkIGNqiad+zeHHaNN6XFYcnFqabAsK4q67BLgYr0yTYrINfxFbpmlRV3xaDnpASYwakShPlchrnQtpISeKGYaE2yd0UMwmOFlX/BpcUpxuxc33bXf++zITbOc1l0FSu3m/OvN9j5ebROeXRGH297Wyr+qo/3XlmbpCvN+Jz/BzultBMkWiCQtlbb6qNJjahjjLa2KtUf/1EEaeUt7qwpjNRy/xTp98nrMFy/abNuesaH4L4QTxQK9IxG1loXatldAYV0b1sAuhEbKQob+bjWtgcIQo5vPM0YGwRSJ4XC9pd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ+y504u0u7eMilq3DFwRbDCpNLqYJ0xasrldmQWI0w=;
 b=ZGxsbGX3Vwr69e2CZAkao/3kT4mt4Jb9VBtla+ab8nZtuERUDwdU0l8aH2G3RM8fOQjZzkxl8/vuf0g198zyZLhiLmpTkge3JKXfKOaqMi01cu71kD91WgYFe2UEKNNy8QOytkY4l8u+TBHPA0WtXjHZo0rvK6qgpMl2lQJWPR/XraDBGbe5TlwaKngHit5DTB6fEVh144hFpsmbdCqTuDLsEp3uWo6k6yx56ycJhAGnMPReVLQeRu8vVLijSy3+ydV7JKQ4FgZ4Qn7G9lpKkrH5GktkUx8PXfn+13mqkl9f2LfMEshfeyxhddqZBDBSy7yy2TM3B4NCQTHlrJWo5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sealevel.com;
Received: from CO1PR05MB8426.namprd05.prod.outlook.com (2603:10b6:303:e5::11)
 by CO1PR05MB7957.namprd05.prod.outlook.com (2603:10b6:303:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 19:43:36 +0000
Received: from CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669]) by CO1PR05MB8426.namprd05.prod.outlook.com
 ([fe80::2d74:e628:e394:6669%4]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 19:43:36 +0000
Date:   Thu, 31 Aug 2023 15:43:33 -0400 (EDT)
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        james.olson@sealevel.com, ryan.wenglarz@sealevel.com,
        darren.beeson@sealevel.com, matthew.howell@sealevel.com
Subject: [PATCH V3 1/2] serial: exar: Revert "serial: exar: Add support for
 Sealevel 7xxxC serial cards"
Message-ID: <9b22e58e-182e-fc43-2a08-c01847ff427c@sealevel.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BN9PR03CA0865.namprd03.prod.outlook.com
 (2603:10b6:408:13d::30) To CO1PR05MB8426.namprd05.prod.outlook.com
 (2603:10b6:303:e5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR05MB8426:EE_|CO1PR05MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: ded15cf4-f7b0-487a-f8f6-08dbaa5a9127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEW3U4iqNt3nQplC8SySZlbathaFod1A1Hj/OEqTItt/v0SnLXTWuu2p+zKhvcmibzqH3zJuT3gCkq1hnwkFv1O1ZWpCVkzaYxjrlb03AI7dYxG2tGuWFZFkqE4+q2WFn35iajzNgjOMsmoidMIh9KORN/3w/+Jb1jNBkg8SLJcwQpPKr50ao/ncin6Rsa+OVF5tlgqaSP8sygmDDo4JwKkjyzsge2kdTfcPjiP1o2ogwZb2tMvuX111HSxtRi7JygyhlAgPlf7DlPmCyVlvJNJROwGwq7TbKh17fivgfzXnwfLF36vO+cpIF6NMMzwGeXB5xI/3zoWiW3bpHwSj1Aehw/3GzHZHBTyxxyklizt6nwYEvgZ9e9ke1qF9XJigCSg3E6KPFw+TzeGi8pA0x5YvnUF6+XtkNj2X9Ofh0kHJYhI/NAYXTLtsFshqN+pkTWhqzQsT9XDW0Ejt0jJDG+f1Pcdi+xI2P7l7CPN3G1+91uW/1mh5RfuxfIGiRA7dr05e6uoTLcUCH5bByXdUKURvOclNGj3O+FWHCEhqyx5aOD1YYs11BUClEIUQe3+WWXvgPBYZ5ruGvMk7BQokYgrwKw+O4otlFmfdno/MVFtTmu6UJ+97bsnrHBJpi0thQs+fVq6IalLnQXlTIYUQXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB8426.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(346002)(376002)(366004)(1800799009)(186009)(451199024)(6512007)(66556008)(66476007)(41300700001)(86362001)(66946007)(31696002)(2906002)(316002)(8936002)(8676002)(2616005)(26005)(44832011)(36756003)(5660300002)(38100700002)(6666004)(966005)(478600001)(31686004)(6506007)(6486002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8jvk5Croc8c0xRczjcv9szEKT6C2nApIIxwPrmv45nOU49lyHdoGOZZPJ/gF?=
 =?us-ascii?Q?N60gAXefFiXd7+K0aMrqCXUaCSVmSZnW6gM3W/JdEzuJgH1/5mpgUwLWNJTY?=
 =?us-ascii?Q?IstpNXYVUYL+p76mkQQ+DMfrqzMjhBkyflHnuCOIK63PxSc5rVtL733eOwJn?=
 =?us-ascii?Q?jlt0jvBWYMogi2g3VF7QvvruhW/JLu+8ppoSYxeqmvjc8UZqMowjxQKdYT5/?=
 =?us-ascii?Q?PWMHJMbMumJK8hwihB9q4+c0YUDN32Kx9gocg+Lp4Jdl1Ugnir0mQN5ghhP6?=
 =?us-ascii?Q?xVl1p7Zo5C5aTOKNccSLBPs01bQxORR+v8XjT6f9CysNBpiJho7bDp4xFC5R?=
 =?us-ascii?Q?sZ3o8w9wyJR81RMBf66mKMBuO/8O1+RI79ZBX+L5c88P/0XCSSyqZ5G29Sy5?=
 =?us-ascii?Q?2Fzn36OGwAnXpHpW9KLFObjowVQaN6d4dMl2DhzT4JS/mlDm2mAQSrU7FhD5?=
 =?us-ascii?Q?r6nZEXUr1IskcaLwjTAEZYlV1KqhiUm+y4TzU8IjFtXK2/N/Ez5JRkGSWXwK?=
 =?us-ascii?Q?twd4SIIlN5+mwAW7BL1diefjY4krL7RDe9jfiFhc7OZk/1346vcQaBTMcHH3?=
 =?us-ascii?Q?54LZV5Qa6dDV+UbmNQV5453thkaFnWMSFp5dZAFMceZXC+8wka1uqnxq1P/V?=
 =?us-ascii?Q?PeyqJ6nuwJ/jbH1KjfsuvQxj+WQxrddMTVkjNyUZL+XNyIxRriHxU4thPRSa?=
 =?us-ascii?Q?dgHwveTgx8gsPRpD4ufD3xcnKBqu/fYrthOwJsknSLGf6r3JpKm8s3J8MyZo?=
 =?us-ascii?Q?gJrRumkX0VhwU4e4xDaplk5auSdi95Q4o9ryRLgMqrLUcRmcZ+UNu5zyuZtw?=
 =?us-ascii?Q?/md9ubj5vxU9/V28cQt4fO4ivVIzucgOY3M0TkoTLNsRJtmtFle8zQ/DkTEl?=
 =?us-ascii?Q?rP4TvsvI3Z2NDSEAZ5S4KCS04+q2w/OiIVl4qEWhizxf42L1Ycw/BRGZh0XQ?=
 =?us-ascii?Q?QwsSbMYy5LacprdFOtDSuTKm51GtHlSWGq/l/gYmgh8h+MJ7vg9+OLkpHnkS?=
 =?us-ascii?Q?68PsaSaio8GyQGd+0T9tiqnjLUsRYqLnv0FRQBAXN4eVWy6GqOQPMlRh5YFn?=
 =?us-ascii?Q?ddptketsj3VZlPoHWm6WLy+SnO/07eJdJgxR/iJ4JnkEy3iZrvBGOIfZMZsM?=
 =?us-ascii?Q?fgVcGIay1NTtPkVIKffVfhr3q8JBtOzTnVsbdPVCI2dht720Fh/m2QTgpZBR?=
 =?us-ascii?Q?QzPkrndVYaoZgCXYU5Qm8gzOQaCwpOXxVIpXpUOeNFnlwMbnvVoEbFVv03UG?=
 =?us-ascii?Q?IdZJa8/mJSYo2lNh3nmTbtRzzx8SRpUdVBk+FElztzdsBM8S3CXKrdTOhHLR?=
 =?us-ascii?Q?LoeD9AzQ19WFXTQQTSy0k//CIfKfE/aBvXKAy8QCf9JRctGWOZlvv3Dq7joL?=
 =?us-ascii?Q?JB486+qhuMziB+SnoVDExdDyHVS8cgi8brSPYY/fJJnNs5FgL/bCUAn0PqPb?=
 =?us-ascii?Q?8CWZJhgJLEhe1eGoMelrhosxIo69JqULxL+4Cal8bAlgOUYr2olzkss58YhZ?=
 =?us-ascii?Q?QG/SkuuFKEO+8SUs+DIBRSfTmmfrZJuiTJ+E43lGXqmDJgN+zFuUDzyCD1Ku?=
 =?us-ascii?Q?Ir1g7LUFK78/U+q90NsSi1xP4DCK0qT9t/4wdCzyE2Z3NmNqhB32tJaJWDv7?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded15cf4-f7b0-487a-f8f6-08dbaa5a9127
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB8426.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 19:43:36.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOmfqbFIpThFyqK0C9Xn2SdCvP4dNSwYrOYSXqIgDDMPic/3aFul3boG99tjmOPuvuSCVOVR1s1tUsoBPwBaQ/EPPm4hXrIoafj3fiThu/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB7957
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Matthew Howell <matthew.howell@sealevel.com>

Hardware ID of Sealevel 7xxxC cards changed prior to release which 
has rendered the previous commit redundant.

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
