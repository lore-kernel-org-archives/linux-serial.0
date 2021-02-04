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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933AEC433DB
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5538164F4D
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 16:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhBDQOa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:14:30 -0500
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:25524 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237785AbhBDQNt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Feb 2021 11:13:49 -0500
Received: from pps.filterd (m0118797.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114GCJc8028461;
        Thu, 4 Feb 2021 11:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 cc : subject : date : message-id : in-reply-to : references : content-type
 : mime-version; s=pps-02182019;
 bh=NDmpxp2G9XGDYEfCYhLex+9cDXZ70Wp3UFreaJbgvuk=;
 b=JqqkCo9SZi44zH79+zGQA6CCtnbJj27u9AtgW8kmKmCmuifHePZrgZ5QVRS+ImutqZ1R
 wjv4ObX/uQ9Oh/vihMVpMvksh9zPCpeiIF1135WkKFSx2RaEpHyg1+Zd7zzk2OfCaCr4
 leCoQg/nhX2AsBCHLwU1TgwkDfd5cub2zVLNHgJBn4n9HWj1DVppHuBRCfXv5xZG7TGM
 k6D1Jt262b9JHmlbx1dP48iPiH3WrKpcfa5DMwGLUD5L/+eJuEU+Zq38KhF4w+FnLnW4
 rPHcH461kjc5m9czAQXJs0GjwbWDLTBvWaERC175tYab2dT7vJWVDX1LXzE5QivIgWTo XA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-002ab301.pphosted.com with ESMTP id 36eq0wjvx9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 11:12:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9u3df1SSKOuYIGtomVpVhnkiptIC/r53QcOVFnkHgx08cffJVcvFw0pVqRvItm7Om+kMaPa+l+2znl6IGuUnQh/R8FvJc1F6afEDdvbzozOJTksG1tyFjPGl0z8S0+4dR20J1iBxKUIEKl24FUNkQUn83hCso/mJjFJNx7UfP6dF72W9PsJ3FU+AW1fZycehR/a6spJHCbJQ15upXp8e+OgPa2rxG20lWyEmA+62KrjiJm24ItyWTFD6lLmntzMIyOzaoWZm/QapnQh3ixoqxqrybs6llbLzzqqrJxDBmMDCoII70GcLO5liKaoH+R878645gWT0HlgmUv3vbzG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDmpxp2G9XGDYEfCYhLex+9cDXZ70Wp3UFreaJbgvuk=;
 b=SAMR9PkpxtO4T9136XYLYdjizQpCpy8piM3N9u87wbXgqC9fVCwT7XolzjYu4cWFttIptbkzsFUX8gAlNdUg9yEfFjdlsWTCGv6Suc9Qhqen4Pl/4tr5h7TcGRWvkL+s7bv1xFiUMGHdWjm6f6GCTxT/mpAB8S8aQXI0dNSRYPnFdw00ETRqDsA4KIf813qh3Kld0dwr3u6zlJMn/BaxWgJdoO457zRgixt/sfqk1xUM/MbB1koG2QTBlizb9d+pmZHXaomw0xJ3KhfqZgXZ0cUD4jKnwnl7oj+jS6VIcjFKbTOAUc890I7SaCUXwVBDKoricHnC+0sRYMyaMCMogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDmpxp2G9XGDYEfCYhLex+9cDXZ70Wp3UFreaJbgvuk=;
 b=WtXW7ke9NeD0k03/kKg4VaCipsqk8tG6bM4/KravGMGG//1dk3yCLIPHDGvF5K3OvZQINBi10wE/XtG7a9+CgWbknwcZp8mTZzQxOCYlES9cNR+GSE2HZwTbcSjo9lamHz3sHQMsG3cAFToJA5MLjis/X2h+s494uKXcKBWqHek=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM6PR01MB4780.prod.exchangelabs.com (2603:10b6:5:6b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.28; Thu, 4 Feb 2021 16:12:20 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 16:12:20 +0000
From:   Eric Tremblay <etremblay@distech-controls.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH v2 3/3] serial: 8250: add compatible for fsl,16550-FIFO64
Date:   Thu,  4 Feb 2021 11:11:58 -0500
Message-Id: <20210204161158.643-4-etremblay@distech-controls.com>
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
Received: from localhost.localdomain (2607:fa49:6d60:7d00:557e:a58:9777:8e36) by YQBPR01CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 16:12:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f207912-c035-46b4-accf-08d8c927a5d8
X-MS-TrafficTypeDiagnostic: DM6PR01MB4780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR01MB4780A1BF17BEF47DA676F11495B39@DM6PR01MB4780.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4a157gBE5u/3sQK3Z9tV3GD24cQI6kD3ALCpktz7j0r0HpryIDhygRVoh0hFCdo8EQNFTwPko7PCQ8qkYhIkn4QvJxmLQ1Q7S+Y7Kq2Us2ZsjYVdzT0KdTXqZKRXcmTPesOCqnCWl/PPg4KzMQal9iz/U9c8S+IORgA6TbIKZX+nMPvcZKv8KDvUW4HAoITaydL+GDhvV1+BUgGLrdAaTNPKrtRsIo+9NonS+A9DDDBmcbI0fun7p6JZ0p1dqV7px1+BJvK3oOLect7zXepjrYrzJpg2NBVCxoOvgOwfOPgS/7GmrJQDLut56JoeOA/HwL7nyzRlSyZqlF11Nt4cbVa72cpvewzPHg2SY5k+TuRJbZHalPpYIH8SsEst1D7s3fzx2FCGiGY6glc/W+GSr52oERQat4B94GHXZicUSrRloS2SFZyIhv2HPv3u8y+V0cgKpjBUXf0e0crT4B6c0zbImzNzwMACidC4MTsk5MMX93Ml+h93PCcke8ZurG6c4jL5H2BJf2HuwPygt4JL/L2E54hqjkrv7CTMgxEfQrcUVtrhX3z0zBvNwHQyc6ZEdo24ABjJuXspWA/Xbj2eHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(6506007)(6916009)(316002)(16526019)(478600001)(86362001)(8936002)(66556008)(4744005)(7416002)(6512007)(2616005)(107886003)(5660300002)(2906002)(36756003)(69590400011)(6666004)(66476007)(66946007)(1076003)(8676002)(186003)(52116002)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hvLPY0ywh3vSKEfGj7V04hNh/UztTHqAGyrYddgIGmgPilAjrQjgG4RsFEmq?=
 =?us-ascii?Q?/hpdHN/roZETZNzBC4Rf1xhxblNpFSrykdEfkiXCA6Fhou0ZYUQ1OCk0/FF1?=
 =?us-ascii?Q?BQXlvWEFxPOVrl2l+bO1DMShykxfC+BONELpmNYy0fAZpWOyHQUnBdr2wvhV?=
 =?us-ascii?Q?G/LFhyVcv9f0zFPgDFbFsXVX0Cym6Hb9a5GtX7CnDfYLUGZR9t5n9STjWyMT?=
 =?us-ascii?Q?h4+sVrsE+w6P30AKC0855d7RZDgCPxA2Jzgr5eYptQR8hAtxfU3k3/BaSRAz?=
 =?us-ascii?Q?pNmRbuw4M7S6U46nnhbRSsd6pNfdUNd8loaI+YLJXWEoO5Rzod410HWOwWFj?=
 =?us-ascii?Q?YLoJ/sVUdoWEC/id385eYq0y0wX5NkU3s/X25RmX4yACZ56+rDcX4P8YsN5f?=
 =?us-ascii?Q?1AJ38m6zLEn7mUl/zmbfN5BC0K9ua3PRlqnI35cPDYaAwSwMl3qHNmGXDvvW?=
 =?us-ascii?Q?anR8EMQnwbiUwhQNovSxwZBLb9anKDDQ1ym8Ar+yaxjhkhPIkxgH0XJru6EW?=
 =?us-ascii?Q?dFzQBauA8WcEQbN5c1Bp2GLAgFLk+tzShmWXIsVjoLBgnpn+kUsb5vsezTz+?=
 =?us-ascii?Q?EReX8jIvrIYAwqTm7t/Q0n7h2yLh0z5whLwc7Lk/7Kh0XoKaKpxZXj1oKH6v?=
 =?us-ascii?Q?o5SbilvIwGG1Eprx4eSFgL+x2GxXJUFPN73L6t7rJHEsTxgTeAsbQIy1o8qb?=
 =?us-ascii?Q?rkZJ28wA9N1GnQUi5/T/oLW2rAnlMUbJW9I4atw45KXaGHjA4XTXWeCKXaUu?=
 =?us-ascii?Q?KYn1sVVoEP5g/Rbk2tauFdG/0iNdkV9oj/gYq2vPzinp8eTw+apg0Cl1oTtp?=
 =?us-ascii?Q?E+I3NDkXL21irNWIbBGAOCwSQbiXhjuATxhYGoZpEztRMEjLwdkIb68G8uyq?=
 =?us-ascii?Q?N1VDK+ohyrQbKezIXOFMhtyiCuO8Zgl45IZmidmoKAQNJdST0MXTEDjT+112?=
 =?us-ascii?Q?JGm5CtzoOPiqIP+EzEL5eM+WPWduypAIEYdJ9IelJMqHQyEIqBf5dhcMttkl?=
 =?us-ascii?Q?nXMUOfDxk2jtKQMFtGTDGZX5qMFEwnM3XJUgullcIThSDHVfssYeO0NKm5Fq?=
 =?us-ascii?Q?yI94L2eBlQE5UCJtzX1cadw0hbNB57vqubjYu51lCn8oztm9Xqs6ZNezRp0Y?=
 =?us-ascii?Q?nfhVhXL7X6ZEsb6osgLLQsj+xA+56G6ywpwuxu6wrFveXU0yJEogUvijWTYK?=
 =?us-ascii?Q?Acb0HBw5ulHO4D0F+GodgGH6ZgaiVWtbp3BFlB/hJiBFGYHCJCmAwMzdRX8k?=
 =?us-ascii?Q?r+QtSUT7U8MQcxI6Ndcnrr53Fqe2mmOpGFo6KHwYqlNxYihW9LNHy7dVrhP1?=
 =?us-ascii?Q?XYBk1M8oCAJ9Ez0Bdqrr4jY2hBGEMJw+C7fx/AWhnGPJwy1PHf5YLEE8DQ4N?=
 =?us-ascii?Q?xFNNDyy+AQJ1a3hItPhA1HFyBb41?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f207912-c035-46b4-accf-08d8c927a5d8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 16:12:19.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0HSgQI3NsTk2L1sZkp8hSYUHDbnobp2stx7W3HtKrRY6bFAmekBT5uM5ormt7aZQaW1CQ2qBeKi1nBh66ZlVg==
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

