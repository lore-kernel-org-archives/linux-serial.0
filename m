Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542B5C43381
	for <linux-serial@archiver.kernel.org>; Thu, 28 Jan 2021 23:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297B664DFC
	for <linux-serial@archiver.kernel.org>; Thu, 28 Jan 2021 23:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhA1XoM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Jan 2021 18:44:12 -0500
Received: from mx0a-002ab301.pphosted.com ([148.163.150.161]:47536 "EHLO
        mx0a-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231310AbhA1Xn7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Jan 2021 18:43:59 -0500
Received: from pps.filterd (m0118791.ppops.net [127.0.0.1])
        by mx0a-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10SNIKgD001348;
        Thu, 28 Jan 2021 18:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 cc : subject : date : message-id : in-reply-to : references : content-type
 : mime-version; s=pps-02182019;
 bh=Ho6ihU5mAKAagObT44VxD83J2PZkR7yepEo4BuVCVRM=;
 b=Ww+R+FPHHZlk51tgmXU0TS6pQA/iqH8GEY1LCmgDt5aep/lHkmgeKj67jwwrPPr/j7Fu
 XwBjsCpprkOTLeVNuBmR6DXrnGGXQ6qRCV8uzcuSMZ8TOj6Io1fqHt3vJrQF/fRxsAOA
 z2B75Cwmb6/01jzGIgb0OL3WwznazZ+A+x4Gxb/wY0Mq+8/ClsTr7PVTV5iOAaalqmHB
 RZdsVtNwiMPRL0/yII5A1X8DD8I2m5QihD/1uRA8i/nToVLoDB1b3LhKedY0MLNbJfh/
 bGBOYzmzMsEpscG/m5rN41y/vywl+oLTa6L9OZsYPkE7GvwFihUV+acEp/16KL1cU8Nj RA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-002ab301.pphosted.com with ESMTP id 36byx98ewf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 18:37:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTz93EMDTO2Gf2e6A3pF5I/rYnux2z1loRSx7614olmEMY7HqDkdhfNDFNGl5wnhFHW9qmGPlX5sV2/HPl7WMNlXnjjT9IL833hMbxQmETpdbPZHBYYVhZmqFTV1jAe4QmFrctylfFaSFBjTA6CV3sMK/z086SwswisMAsVHM3m65kVeHTqhSGX975nyIrlgxo5DCzeFkwoyV2W6+QyaKy/Gsgzyk1tlUutLlmSoDcIwyk8s9BMgiXoHgV6tw1I+CyIcF1JGK9douEqySqRG6LAJG+5uJ1OhHOIOcklFGN5cXDVtX0ff77rjmdHJ43LE53WzVTsod9Iz8VLnk5L7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho6ihU5mAKAagObT44VxD83J2PZkR7yepEo4BuVCVRM=;
 b=XJF3gFOnn1nUqSuI2MjRrSxDXK/TAm39kUo48Z7n6d85W007ZIYRBO7sMUQjCfUkXYBOxfHtqQ0VOnf9uD9fxy4b+LHT07wu2HdLziOZIEKHBM+ihz8rn8q6E3KD+TR2ufvEoKIRB9Qu9qL6Og4R5h/qXlhCEyo+EV6Hpxz9goZm/EJaUfhHojGxxBR7T+qK2Gxk/8Z15EenPcKcUZ3ih/zlwMNgc2F117euz1VgnQ0zyUCDzdKA2WVIZzJY0LmEgWyFzr4RTJV4banGcn3hb/aTdRo5uMfG0mSIWCQqPJ9t580yR6GaPz8qC2GFUybnxW0tw8DqKLjXx6SIjlMfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho6ihU5mAKAagObT44VxD83J2PZkR7yepEo4BuVCVRM=;
 b=Tixymd4bVAgb1G0yxTuJCZYIjjkFT5Pyiaob52r2W9BBvmZE5BMw/3SbrRMrc20IgO1c2xU3b5YBx47265vKJ3cDe6xuP7QSozKk68KwOY2dnoVXhbQlbjt94pCM3lq7xCtkjbrdQZFM5ZhZQ5NCohIuJ8Wasdgfx9FbbUjdqX0=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM5PR0101MB2908.prod.exchangelabs.com (2603:10b6:4:2c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.19; Thu, 28 Jan 2021 23:37:08 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.016; Thu, 28 Jan
 2021 23:37:08 +0000
From:   Eric Tremblay <etremblay@distech-controls.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH 2/3] serial: 8250: add compatible for fsl,16550-FIFO64
Date:   Thu, 28 Jan 2021 18:36:28 -0500
Message-Id: <20210128233629.4164-3-etremblay@distech-controls.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210128233629.4164-1-etremblay@distech-controls.com>
References: <20210128233629.4164-1-etremblay@distech-controls.com>
Content-Type: text/plain
X-Originating-IP: [2607:fa49:6d60:7d00:a56e:4209:76ad:3739]
X-ClientProxiedBy: QB1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::19) To DM5PR01MB2457.prod.exchangelabs.com
 (2603:10b6:3:41::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2607:fa49:6d60:7d00:a56e:4209:76ad:3739) by QB1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 23:37:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0de97cd7-9503-41b4-0f1e-08d8c3e5a057
X-MS-TrafficTypeDiagnostic: DM5PR0101MB2908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR0101MB2908FD6D5EEEDF3CE554E72595BA9@DM5PR0101MB2908.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhbOKQsgy3Swsz1acH6Tlu7PgcTGOeFR6YVSUQen8QSoST31Qp4jerpzB9DmOC9HCSM4h+PZYsrmPl0bou7eS2tTqgq3UYxbimg4QUkXTs7ERO0CiBNHSoLw62eYrdW5Jvud6EElFYCYBkOGoaGmad/D2UnZMCTW/fTbiyQV9B8MeyMbk4Ay8hzp9Q8Plge76XeZAKnidFC4q0YZEy0668E8SnDHr2Je+MTehFqQerbBth7VkWZDDsUeslmHSF4MpF3BCrhVrasVPapEQUGod8jRTYYpNZOsDq8r0wMrTo0qptx5nCrySOAjqpMzJ5jPEyrrEEsLJ0W8bJzzpZAsWaK661E8bSPNnia8Zk6IkaBf4nAY2fvczokJDMIovHnZNzbVlrk5tJTrhGJksfKOQL+KZw+YIBGgdbzFvKO3IRXPcN7qF71q8tsx+xaIWvift5AILxzC8r8gCo0g2zv5eE4uIBcZrjf8ZFJQEoik5B+02bDtxtxPMUIUBnb0qUqzAvnsXxZ30Q6Fz+B6bXC4znUKdeFztLBaBkgfNrzByVyDSJjxtS9z2MVT/oI0ckdEwhhDMrU+ZEKPJVaq1QJ6Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(16526019)(6486002)(5660300002)(2906002)(186003)(7416002)(8676002)(52116002)(6506007)(86362001)(36756003)(2616005)(8936002)(66556008)(6666004)(66946007)(4744005)(69590400011)(66476007)(107886003)(6512007)(4326008)(478600001)(1076003)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vJGEvnvds3SE21L27kgUCDwYKhSUnTxOV+69uLnA/XktBv4Oms5Hi5CjZkAu?=
 =?us-ascii?Q?oTOHkAFKiogUSyXZlXwzxQj6eBF7yX7I644OMpRo6ZdtrZmeIM/TFsic8Fmv?=
 =?us-ascii?Q?YnjiTbGieJCOTw+Q7owTF5s8/j/t0eB28BBFyu/Jgk+osVQ1+UuGk3pygMxT?=
 =?us-ascii?Q?GvOQCGQRfGvtLwQ9pUMGeuFNAozftQE/TZrX9aa/KyNHzSmypQOe3/5wY30G?=
 =?us-ascii?Q?FvWxv+4u+wZn2jUIdiDiybzgsF2ICpZBPW0mBWW5dAHphyzJUbykGRoRNEtT?=
 =?us-ascii?Q?N3/yQqCnfIlNmhhxY0pgoqiOUhgm01jTv9Xr5rzmIRym5rBLODzvucbo+aN9?=
 =?us-ascii?Q?GCYbV5GaGxLjx29zafF4AxerVQMn+o96/WRSopzJNhM8c3sCpqy9xmhJwiGR?=
 =?us-ascii?Q?2IgY6ajvQkIgoN9VwsKm4RuixWho0ODnO8dzvYorfwqDFQ767KQ3jJSDcOlS?=
 =?us-ascii?Q?+MZiz8VVb3QhbeB7uA7zzGm6NXUOcTnWh1u2p+YVkMoTo0+uW6y+ptgtZYGX?=
 =?us-ascii?Q?LOVptG/98r4JsrXXvRu4RTZ61NyXDZTXSIRKFZC7KdaaO8lp6AsY7ZeKhOj8?=
 =?us-ascii?Q?ybZLPTRddikbKnFHkS2oqN47fHQNhUuysKk2XR7Xd3QJTInkIuiRrGIBwZl2?=
 =?us-ascii?Q?6fGQHeaKm0L3SmKjExsMo5bi3opDtyaoEcblBq2+nyeI+XRvGNFaVhmKCHuM?=
 =?us-ascii?Q?01RSUoDKAOe+vbg44P8FsfeCV0kzCs/lLqUAROIu6HttBTDynANSJRRnMVS0?=
 =?us-ascii?Q?NPTu27tzy8V5KkAxkiwAI+wCacxcZq4eOoxf5gJqTipykwzaU/Zz7SfQAxfE?=
 =?us-ascii?Q?7+7KuMp2yDWbikrBA9rXVr/047JeNwCEIUcPu7Squ4WitC/4GP0ejiKU76qZ?=
 =?us-ascii?Q?HHRhpmsVpVeaR9wPhBzB0te+7pwoqfyicvrIwaOngqFiLV6lUyCiatijG0Co?=
 =?us-ascii?Q?HkrdHz87Z7BR6b2ubYdm3y90OoTokMLGRix/DEexkcOcb6poxC1BPR0wMa0R?=
 =?us-ascii?Q?QIZk4DbX8ZILROeK52OfsXZ5+FLQA787oRjrA4Kx8Wpr2icU35wnAN6kfJRJ?=
 =?us-ascii?Q?GgARzONkTTeYVGL+yDwUd4uxkY3q1AoE7RX2mmRHJq/578juRh6WWP7rbTP6?=
 =?us-ascii?Q?VFnJgRUPmGHf?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de97cd7-9503-41b4-0f1e-08d8c3e5a057
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 23:37:08.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DH9Ovb2NRbLkeNODRY1f/6quCCyjQ5+YngJjic+UG2wE+4oyCSJ12mHMrHfMGjxkc1zohqOu/QcJpjrB0JhHtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0101MB2908
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280112
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the fsl,16550-FIFO64 compatible to be able
to use the port from device-tree

Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
---
 drivers/tty/serial/8250/8250_of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 65e9045dafe6..4efc62c0b25c 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -313,6 +313,8 @@ static const struct of_device_id of_platform_serial_table[] = {
 		.data = (void *)PORT_ALTR_16550_F64, },
 	{ .compatible = "altr,16550-FIFO128",
 		.data = (void *)PORT_ALTR_16550_F128, },
+	{ .compatible = "fsl,16550-FIFO64",
+		.data = (void *)PORT_16550A_FSL64, },
 	{ .compatible = "mediatek,mtk-btif",
 		.data = (void *)PORT_MTK_BTIF, },
 	{ .compatible = "mrvl,mmp-uart",
-- 
2.17.1

