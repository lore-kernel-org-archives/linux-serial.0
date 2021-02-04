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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F072C433E6
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 16:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED43B64F4D
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 16:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbhBDQSh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:18:37 -0500
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:9542 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237866AbhBDQNz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Feb 2021 11:13:55 -0500
Received: from pps.filterd (m0118797.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114GCJc7028461;
        Thu, 4 Feb 2021 11:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 cc : subject : date : message-id : in-reply-to : references : content-type
 : mime-version; s=pps-02182019;
 bh=Y220pXaR5cKdh4d9eaU5ScVkptnj+f2LRHidnAtR/9c=;
 b=DVLxTVGGBK+Jhzg/OM464dt6FgRwnxvaYjQG++mMNJBrtqPtfoKNa7TaRlscZHrQsYLY
 6lOyRsIw7f06gpC1UvaYoo91ZVjwvADG6DOrkKcY5ZyeMZO4huHdVjYCH4LpsEJe2s4h
 9cP2oxBCT6wPBXpzv9K9Q6ajCC+tKfxa1xWiYfhN3vx/w7SXZlhSeIXLTZUvd48CRPN/
 EsdfvIYGKadqRxddfHtPgVkSkCvlRIZ/4jmLPOl1HETAb16uERD3LSRlXHNgNo6UT8sp
 KRNSeJyC8tv4+HsK+lmLNinZLZmSr9dC8YtGJSoCpdXYPHVWsKP4CHT5MiudWP5oh/O4 Ag== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-002ab301.pphosted.com with ESMTP id 36eq0wjvx9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 11:12:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=andmcJK9JfumQ09LBoTvRaIImF7ABWqd3aB5rEqRo9G3AurDmrBoCIRZQYUAxiYnGfSjLshQAjgpN+Nyeij9bPWzNfDxIZ4VunGE8uqe92STgNBk6waKb1lcF7GAOX+HURCBYqoC/n26Vq1bNNMMeF9Un3+6NDH0dYX0fQG0WHNTPLNClbZq3mJtNkUq3raXJ5PQ+8yED1+LI/fw2AhD6dWJbo4pBpcUe/9NF9dnlAtJKrDFgBKpHVtILVn/4Ht9LtxQZD+sYKEOHfiDcnrCZAYFf173xy//O0/NJl98UCogmzWkDvI8W7ikBlzjWklU0ZnC+U3UY95ElSFR+KtfCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y220pXaR5cKdh4d9eaU5ScVkptnj+f2LRHidnAtR/9c=;
 b=R6fGjeW2k62C4P5NX5GXyLNhsLRt/QdPpHLSUynHBJocirN+1ZkLz610Q5wDB63XSsKg/qagpQRdXVSWAYvYGWAYoKYIgN7ai6eqO6XOLOvWFT5tDWboW2tbCSQLRSa6Nd5SaRdpK63aoAgvpefcizMRipV/0djQab6QhYIELqSnMyTRWWlCBn3NESIi18Q8LLgMBuLaeCHzdCDXadQW12yGXP9J3RcVquQi9kZbRhl07l10NP+phERI5U4P/5axRLAgM633t6DAKquazhYCL6rhInhhV8uVVZSnDlImNVVYjW8PVjdnmH/KMK22+Fjmd7eL5yZNlmeRkAbUsFXCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y220pXaR5cKdh4d9eaU5ScVkptnj+f2LRHidnAtR/9c=;
 b=htn4ZkrzlnpNntutLr1I5SDhOrLeU+kfDLc/MeWdN9aQhbEXjFtdnc1j0qK2l4t50p99Gjmd+Gbj0ShZBKecNbfN2JuyBZvf87TgQS2QDybt5YJ5m9BLLSDlaTbORNonRtQZgF+IQ1a/CX/6jmZkpdLQm8gFSpggHtxs4uAsUic=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM6PR01MB4780.prod.exchangelabs.com (2603:10b6:5:6b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.28; Thu, 4 Feb 2021 16:12:18 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 16:12:18 +0000
From:   Eric Tremblay <etremblay@distech-controls.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH v2 2/3] serial: 8250: Add UART_CAP_NOTEMT on PORT_16550A_FSL64
Date:   Thu,  4 Feb 2021 11:11:57 -0500
Message-Id: <20210204161158.643-3-etremblay@distech-controls.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204161158.643-1-etremblay@distech-controls.com>
References: <20210204161158.643-1-etremblay@distech-controls.com>
Content-Type: text/plain
X-Originating-IP: [2607:fa49:6d60:7d00:557e:a58:9777:8e36]
X-ClientProxiedBy: YQBPR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::34) To DM5PR01MB2457.prod.exchangelabs.com
 (2603:10b6:3:41::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2607:fa49:6d60:7d00:557e:a58:9777:8e36) by YQBPR01CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 16:12:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 762d4b35-6540-49e1-060d-08d8c927a523
X-MS-TrafficTypeDiagnostic: DM6PR01MB4780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR01MB47807B13C7B5AA76C9511F0E95B39@DM6PR01MB4780.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRj92peAygSjEGczb8YVDJrFc+JP8AUOdspD5+y8njZF6N3iwOC5oEf+7tX9UsAMTgPDo/1n318uFes1hmet/QkL4bJfx4Za6kohW7rXzv64moxkAXocfma5fztOLXnFokzKlvwpOVrNuyGyRzLxlKjrfd73HmkZ34oqsBSVCNTID3ke4BcbtTcApKAj8SP4KagMrCiHCikMRnyMayrEA5ICfsxVRvWXu/efElgaYZO6pwBFZR47TJh4TfdqdeTCbHekEoutnlngQwHZwCOiXyDeGYyyZJFDtLC+E5xBW/kP4RAMUqHqaQ004qHxQ9anG38t6xCBAB0kcfu+d+Ne8N5+1qe1/ZFcq5yB+vAjlq+E72/5kXjmMAqWUpM9+2PfoLYAE9slc/+XrdGdJMy7ii90jOrQza442DYtz5qBT3+Y5ZphmliJtoGhe/RXtf0MfVFHYqcUfFPB3JOkBMZHjXZADhDbhSLpBXosEETBMQ360hLTLXI0NZXjnw0LJu1pDXxvTROFHW7/lUoruLIya+ScWpRvbz31f2TKJ9K2JAcUxonL1gPka98qS7UAdi73JxsKa6kFOWzq1Y1TUK2cQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(6506007)(6916009)(316002)(16526019)(478600001)(86362001)(8936002)(83380400001)(66556008)(4744005)(7416002)(6512007)(2616005)(107886003)(5660300002)(2906002)(36756003)(69590400011)(6666004)(66476007)(66946007)(1076003)(8676002)(186003)(52116002)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W2aORDPxZ8VOlB3SIMlsMm2L0di4ZiDpwGGNEJXxqwlcG1BJnC+X9q+tDhae?=
 =?us-ascii?Q?+Of2YJx8y0iGNeCKKr5AOlSNITislVYsX13uUHSKVHAA3oRPEbVftlkaCPFb?=
 =?us-ascii?Q?x3D8U7N/AAhH4t2qbKAZuQ/PvVXHZ98CARdnt/HZCUkDpUypVH+s9YzsYCrV?=
 =?us-ascii?Q?WuYYxttXTiyoXw5erYu240JYHwWP11g/H0xTitfn2sNKy97JgGhOO62sCy2r?=
 =?us-ascii?Q?ih7nqp+QQ10w72CCLYUSu8FjAIchsVKFqJJ7RBbPBj6upijP2TIVzk9+MPA7?=
 =?us-ascii?Q?t4tGVfm9H7nonkYZTOM/Z87pNFV8HCoSqRA8kABRsIjyuses/y4KIMiK0wGd?=
 =?us-ascii?Q?OoxL0I5fEnFDaxB83BwvfPkk2SScEncJopJZJvYVL/uzhIIwdwY2afmr+dOj?=
 =?us-ascii?Q?wIgUWWuMoYbrhGjuTyVG8POCQCY8kpknQJ+vYEEACvRZblZ1cL1j36E2r79c?=
 =?us-ascii?Q?QiR2I3hLgPlTbcgz5KUTNEUn26DBNB71uoa8Q9py6wMZbexpRQEzB/spqaqm?=
 =?us-ascii?Q?R4urn9K7keka02BgfLyN+tz4/lmo5RBFyNfvTqeLZqL7t9XfMkEt9ETfz76t?=
 =?us-ascii?Q?YaSeyDtlUhM1vjZ4zl8e+1a75QMUykqIM7DuCXtV5TVbl2r9YzM93IEgNH3D?=
 =?us-ascii?Q?Ma2VGlZysNFNIw+2kCEz1XV3Gfrmgs8Qv1EAJvh2SQG54yNsPM0VKVOu6ZiC?=
 =?us-ascii?Q?FyUSLTW4xYWUC2h8FBsd8a1rSrg4l7gaQubLtAE8UkxXf6cKIuQfXK9o/LCJ?=
 =?us-ascii?Q?YPh37mPabmGGWQCKG9bPBO09LnMcaDxWoO1bZZ4uD92c9tYbCZ0b/AAmUkXr?=
 =?us-ascii?Q?CcpAVdo8wgupBiDmscewcnSxI5b+YTvMek8Ne7ryCTzRD39KmVqvN6mAuBMi?=
 =?us-ascii?Q?aZJcNGWyhCbDuYwXpkCRwL17Zz3pmh97s7yRS0z48CISyWBqIUdjtkSiz3VX?=
 =?us-ascii?Q?7R02C77oALCDo1DaaTpv9irWfJrBT8F6AQ2/bCM1AqbCNGksCanM3RofYc89?=
 =?us-ascii?Q?KcjC/AXiZkgPTHwFF8ykZXOqgw/vJnxbwEzhsMQV71zCsoJ4Hy90N0jKB5LO?=
 =?us-ascii?Q?VChrbLkjA7eonYyaADOwUDl5NPbZyBs+OHaDdtmDJkJD5vfjCBHbazE8m68l?=
 =?us-ascii?Q?JsuDkKq5agajOmgehuwWXeQrpvevhiGR+6RIanypebVssOwEUFPccnZGm/mb?=
 =?us-ascii?Q?b38XjlgLsnWB8BgJ9rKUOe4HiHROiC/BHDtrgtZADkcugsqYtQS6rlO/WnhD?=
 =?us-ascii?Q?Ghve/dCZnF4tA2hosHAlJlhFiTD9xHCLy+kWqKYBB4XBeTeh7iaa/injnN2n?=
 =?us-ascii?Q?UmbA42lgy03Vpc+btCr/eVZF4G0spJVQUk/KKI5+JsJ7VPAKHhDJaq3TT5M8?=
 =?us-ascii?Q?bNv24Zhau79MBJvlTrJU/p3lJCod?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762d4b35-6540-49e1-060d-08d8c927a523
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 16:12:18.6867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3charzB78LlA0IANGKrjEsJ44OA3ASI1GFRyrtkUnH2TAOoFHVoO6gbdsf46U3Wl6vddCTnZW2E/YIYzm6kEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4780
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040101
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This port doesn't have an interrupt on TEMT available when using
the FIFO mode.

Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 00c2cb64e8a7..dd904f736c61 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -262,7 +262,7 @@ static const struct serial8250_config uart_config[] = {
 		.tx_loadsz	= 63,
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
 				  UART_FCR7_64BYTE,
-		.flags		= UART_CAP_FIFO,
+		.flags		= UART_CAP_FIFO | UART_CAP_NOTEMT,
 	},
 	[PORT_RT2880] = {
 		.name		= "Palmchip BK-3103",
-- 
2.17.1

