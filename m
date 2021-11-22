Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60B0C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 12:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhKVMsk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:48:40 -0500
Received: from buffalo.u-blox.com ([195.34.89.137]:60843 "EHLO
        buffalo.u-blox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbhKVMsj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 07:48:39 -0500
Received: from mail_filter (localhost [127.0.0.1])
        by buffalo.u-blox.com (PF_LO_10026) with ESMTP id D57953A205;
        Mon, 22 Nov 2021 13:45:30 +0100 (CET)
Received: from ASSP.nospam (localhost [127.0.0.1])
        by buffalo.u-blox.com (Postfix) with ESMTP id 743403A1F7;
        Mon, 22 Nov 2021 13:45:30 +0100 (CET)
Received: from unknown ([127.0.0.1] helo=anyhost.local) by ASSP.nospam with
        SMTP (2.4.7); 22 Nov 2021 13:45:30 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRKomBBhsGWjda+Lj1k+MMyCslumqpHC4wQpRvgPcP8EXAGgwHMXoZQ+F+H0rFmwd3iFECVlOCX/hTFbdsaKBp+laj7Xp0FxvhPIW69f+G3Mrx3QjwqYfE9/Kxh5IB1d5EAjRk0tRQEIV45UBd4Zc2OWWa0NYCYsY5ypSl1AWFCsUw7tkCOrrJ2d5oGwP1zB5/rkiIIR63MBHZuNyrfxsmJv44dqU0CWu/das0c7E2vKhyPv7uVkQNt3Kf7PE/l7fpjWwiNj1jxSIDdu3oVDOX70i4KfYhipy8U5MpyuKSX2Wxn1graVJ82WgH+XTIeDeQeBDmdfeMh0WKLAh6qEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3zqhyhurrsFKeHlyXwXT+jdvRVHlcFALdX/Xe7EY8U=;
 b=Oc7k6AXapxnw47rIxnmTmbgOY5YpsIuSi6jSMmn5qtxTBvw4544ESC/SFqECHnWmgp7Sec8TSrVvqh8L7jG1hjL8Z9GBMzl7idQjtyR/w3TI+XyJ6uK+4LmovQrLXp06ltZpuQPLokta3oSHP/QdAKP5f7xaayT3mKGZzSpAYfZ4iaYDMtcWdKIxVXHoP9HuePjYF2e3KmyTRAu1AG/EhCh3KR2LhfW5gfTaVXb5ArHDcvE3i3/gEP1/VtU4LhST7zo3o0IeB1u1SfH6s3pvR0EKOE3E5AZVN5KFcQI2HgOAOVBURNnFJ34/v63fxRi3avW/H77bVcc2IC5Yx+K2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=u-blox.com; dmarc=pass action=none header.from=u-blox.com;
 dkim=pass header.d=u-blox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u-blox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3zqhyhurrsFKeHlyXwXT+jdvRVHlcFALdX/Xe7EY8U=;
 b=mNxOvSoD+OUbCq8yBcHn9k8Yhpivguu/0/MAX+1xYPRC59AkKL2Gf4Xsmw8B1gIBX2kTDqjz3H4utkZdIwzN4hjqKYIXNvRZeNi+WAYgkXJHiXic5dTUUL+tZpmvC6oPtLXejHGXUZNR8qHdjEsSqOP7hHE9ljxmVFtOR40U0d4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=u-blox.com;
From:   Patrik John <patrik.john@u-blox.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathan@nvidia.com>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Patrik John <patrik.john@u-blox.com>
Subject: [PATCH] serial: tegra: Fixes lower tolerance baud rate limit for older tegra chips introduced by d781ec21bae6
Date:   Mon, 22 Nov 2021 13:44:26 +0100
Message-Id: <sig.096060f39c.20211122124425.74031-1-patrik.john@u-blox.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::32) To CWXP265MB2072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:7c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3da21db-f688-4c09-0dee-08d9adb5f6bc
X-MS-TrafficTypeDiagnostic: CWLP265MB4036:
X-Microsoft-Antispam-PRVS: <CWLP265MB40365D8EA24D305B06C13D63CC9F9@CWLP265MB4036.GBRP265.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTmZLRv/oUbDR5DmAQQHG9GkBywlVfTYn2rqCzUYMu2Dk6q8FQxlZONWhPS/BehJqo2yYnTkVyW569KtISd+RJkxXVAXJiXiA35hj4BFyPBVsfJY6rNyeKKdUqWAac/SN7ojkrJoxDCrkZaI/ZsVn+lGV/pDX+OaYzBiblpPRbqpMB/fmkT2lLj+CJQ8+LkA3ZogarzbYfpXEfaH/P1j13ljefH1Uivma0sptB1yFMI4zHrodosTMdLDTbXHdxWzJWJAAzbzoMi7d/8Vuy42BWJ4Yj1nG6d9Q3+q4fditTHirv5swLb737vnqrLdGAyjj9pzOvwUFSjJbxIpRLYFNAOC0Ap5gW+e6SBWXUAH0Q/783CcPSc7tPnIwg1tdp+rM4YFlOL6iud5QGc8GOBvLKVIdOcrVdhqUYMKuHrF+jHz4yIzvoJo/oR/V4g4zQ+pYSVQ9PSSJrQ5S+fceVmA0ihoqj129yrSozsLnGW9kNIBMMPMgXCGpHbkofUNInjw5bn2lrW91gW+gEycoWqaloeSO5CcqQkrB1Ph9CjgiIcQ+66OoKjBE1RLAZGJtFXZ8MpgwVxhEH3BFgs6edReaIYIYM33EPiYx4QwIrnCUk4jxKNsgRWMDBORvlS96UgihVx9tjKM30NiMnj5Yw4uP0gVAQO+DnHaAZ1JgrKkK8t398qtIsLePDRtvMG0pY5vm8bGA2FPaaTL60ddXxegLFvFsyjN6OXBSmA6HbRuU7Gwu2CghkVaaFckj8J5EEwZfXmljdj8QWReZAMxQ7CiFfjcSTXHM7LhVmCEGPRRSOvXkynCDVx7WCkVuPzCW5rAhlGuhjRwWVxyust/EYCOj6U+a30amw1ndI/dqxRzMe8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2072.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(52116002)(38350700002)(107886003)(86362001)(8676002)(38100700002)(966005)(6916009)(66556008)(66476007)(66946007)(44832011)(956004)(2616005)(1076003)(6486002)(6512007)(4326008)(2906002)(508600001)(316002)(83380400001)(26005)(186003)(8936002)(5660300002)(6506007)(16453003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W6kSAXldpUknoght0Bi5UHthsls5OcrxxblWRpMTpqI/rCkugKjZ3ccR25LF?=
 =?us-ascii?Q?ms81vjvFNMd4RoU98Vn6QbH8HcxXQQjRFgAgW8uzH2x1/XntievO2MFtFkyH?=
 =?us-ascii?Q?xOaGw2SZZkiq5xH9NhgdfgIDEpCMO+YROadUPFzOo4RiHQbdxkgmqUFxw3qA?=
 =?us-ascii?Q?eMMyOnqX8XrY/JZali2dSigagWf5dvxdBne+6EBpWFt8D76+vP2+earzjDrH?=
 =?us-ascii?Q?jjKmOQIczS35pPn5nX3ZS3Hw6UrBKc/moErZSEWAFTY/LpIXqMjHee61pxkN?=
 =?us-ascii?Q?nijsFoSRv71T1dq8hQStiMRc73SqlbHQLkfaRyc0uG7PC1PwS2dWgHLnZ6SI?=
 =?us-ascii?Q?7x7Y1XJctfZNnguA06rBleguNCzNBiYrolQ9uLDujDCelXBogzvZRC639Cpz?=
 =?us-ascii?Q?20Pqja93ZsVImgCDnGhGvVVZa2uRa5Gtb0UxGKSrt9fRXE9D7arD1JRkIjea?=
 =?us-ascii?Q?sy5SgqePMUWY5TlmX9otOx+QloSYi3BOipkjknLuCGz0KSivj3ScrqsT67gp?=
 =?us-ascii?Q?UkwVh+/jx38X/NlLKf3rBnncPsCImNBR7G8zt4f0uuCFN+/pCUy4WKRuEtAw?=
 =?us-ascii?Q?LQYRg9kP6w1I8vMxmRZ0ZR9Rl2leqRxWJe1hgeNxt681V4mmNjTEyPlW7PTs?=
 =?us-ascii?Q?9dNVL1YOhsgwzlpCHNIV2OllOA+SSOP5xFPmMxF/G0KHAmU9blZoPG/tBmSV?=
 =?us-ascii?Q?wWL5qExoywtPJ9YVXAFNJ+v6GQG9JQnWXyR9vMTSr3mZ+mYHegBHDcozbhB9?=
 =?us-ascii?Q?zC6lXST/xj6LeF7RCjSWpHVyqFsVLjkUmOT8zBiXmV/aSrwZ7BkrnhtD+p8C?=
 =?us-ascii?Q?plH2Gt7LtwDUOUUBkfV+EUBAvmsa7PqvAwm9GtXfuMPN8C4bFKc9FnQ7K9Fp?=
 =?us-ascii?Q?Ze/YaL02ZClojvWUuES5qVAp+pjfDwIXT0MAz4eugq39gRFBrLMwjL4t7rQ7?=
 =?us-ascii?Q?Pc0cb65fwBiT8Noq7vuBLAV8/GE4jxvGMi/plVnjKV/1tBAWfLU5FMEO4M5q?=
 =?us-ascii?Q?G+wMl4O8yZvpgsoUowZLfgg2kWW/1ccGfwrSC8RFORct/UKZAoDTkMxhXP3m?=
 =?us-ascii?Q?jhRVdUSxTuXCSQjvF68AEDmNNS+QVM56KRmpvF7NV+vGYxphQWP+uJIadNTW?=
 =?us-ascii?Q?n5Eefn9nofaX3+ZNy8yA3KPtFsFNxmBgURVshHrTiMs7pdaVw7gUvY6E6gJw?=
 =?us-ascii?Q?yjGfSBk1WAefsSjTs1Xu251zky/tnMe4PKGlF/OCYLV8Z1bwBwjG5vPZEWE2?=
 =?us-ascii?Q?pHD7P8LfDtiWgemvBsRjDLypdehpMZO1i7vc+RISggVMZPpPHYXss2K33caV?=
 =?us-ascii?Q?TPnjQ0CoRMHVja0wn8Un+Q+nZtltP8drrxXWVXP9fZMfxJsWcFzWsxMs2N7o?=
 =?us-ascii?Q?hoMDyruf05EOvl0jT0LVQqaVTz2+OerOO9issioqfaG+xMWBuxYA/+NcBdJm?=
 =?us-ascii?Q?ytNNvHrOut04uh0ov5NPOJDuzGjwTJtfL2FXvl4o3IYvVXVB8xbAB2oEQgya?=
 =?us-ascii?Q?jCODc/JZP1mX7DSyE0UniiL85+esERnOE9QuuSVExqb1p+H6m2SVG/F5160Q?=
 =?us-ascii?Q?JsuFjn1/6QCMjBMP6nSFGYTHrUw9duy3Ha9ZzbQZ5TzQqTQlRi9HNbdj6Urs?=
 =?us-ascii?Q?BSyGI9ujWCCQ/xLm/PvKTM4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3da21db-f688-4c09-0dee-08d9adb5f6bc
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2072.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 12:45:29.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80c4ffa6-7511-4bba-9f03-e5872a660c9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgtMpxD7hS1kAz+DntN7wG8IIk3aQVdxCvObEH0PHaG5oqb1iPcBIyNUYeHwAdLA31mroOUdQ2pl86AdgGXwGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB4036
X-OriginatorOrg: u-blox.com
X-Assp-Version: 2.4.7(16004) on ASSP.nospam
X-Assp-ID: ASSP.nospam 85130-23316
X-Assp-Session: 66720294 (mail 1)
X-Assp-Original-Subject: [PATCH] serial: tegra: Fixes lower tolerance baud
        rate limit for older tegra chips introduced by d781ec21bae6
X-Assp-Client-TLS: yes
X-Virus-Scanned: clamav-milter 0.99.4 at buffalo
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The current implementation uses 0 as lower limit for the baud rate tolerance which contradicts the initial commit description (https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5) of +4/-4% tolerance for older tegra chips other than Tegra186 and Tegra194.
This causes issues on UART initilization as soon as the actual baud rate clock is slightly lower than required which we have seen on the Tegra124-based Toradex Apalis TK1 which also uses tegra30-hsuart as compatible in the DT serial node (for reference line 1540ff https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next)

The standard baud rate tolerance limits are also stated in the tegra20-hsuart driver description (https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt).

The previously introduced check_rate_in_range() always fails due to the lower limit set to 0 even if the actual baud rate is within the required -4% tolerance.

static int tegra_check_rate_in_range(struct tegra_uart_port *tup)
{
    long diff;
    diff = ((long)(tup->configured_rate - tup->required_rate) * 10000)
        / tup->required_rate;
    if (diff < (tup->cdata->error_tolerance_low_range * 100) ||
        diff > (tup->cdata->error_tolerance_high_range * 100)) {
        dev_err(tup->uport.dev,
            "configured baud rate is out of range by %ld", diff);
        return -EIO;
    }
    return 0;
}

Changing the lower tolerance limit to the actual -4% resolved the issues for the Tegra124 and should resolve potential issues for other Tegra20/Tegra30 based platforms as well.

Signed-off-by: Patrik John <patrik.john@u-blox.com>
---
 drivers/tty/serial/serial-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 45e2e4109acd..b6223fab0687 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1506,7 +1506,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
 	.max_dma_burst_bytes		= 4,
-	.error_tolerance_low_range	= 0,
+	.error_tolerance_low_range	= -4,
 	.error_tolerance_high_range	= 4,
 };
 
@@ -1517,7 +1517,7 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
 	.max_dma_burst_bytes		= 4,
-	.error_tolerance_low_range	= 0,
+	.error_tolerance_low_range	= -4,
 	.error_tolerance_high_range	= 4,
 };
 
-- 
2.25.1

