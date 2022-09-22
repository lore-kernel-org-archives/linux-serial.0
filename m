Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F2BC6FA86
	for <linux-serial@archiver.kernel.org>; Thu, 22 Sep 2022 11:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIVLXD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Sep 2022 07:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIVLXB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Sep 2022 07:23:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBD0E05F5;
        Thu, 22 Sep 2022 04:23:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MAO95w032068;
        Thu, 22 Sep 2022 11:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=NRKz0OE6ZmtbIUPA4PFPsgAEnmu6fCyJCO31ugTnp3U=;
 b=pdgc9NH/UrAKFimexgcDGGPifkwF+ZG/J8ew2p7thOZmVs+4TdyQB62ww5uZz7PBmRaz
 Tk34thYDvc1CgcTcNpebPnTYZwFEbBNxQf/4fuLAYTH0R88lR5tMI1/poTqsAdDT8WmY
 72WxWtmT8ByvWyMTphuCs5sFv10EKHIXSDc9bUFcq1FtGdrwhVrjtcUUQN7zI3S0cQ1g
 dgMEDyxCC0bL0JlAh2ckYtOse1iP9Hp+0MKdlVZPE1cW3DMOEpAhhcWe86dTIenmo62p
 +sLz+lCeO5hPwO8W3kzP+InsyLf7znW1xO81DnJ5ntaNTfamiHiNWVqjTU/sXyyzk/MV ZQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kw750-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 11:22:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28MBKupX010324;
        Thu, 22 Sep 2022 11:22:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3cb5mtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 11:22:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzeR29P0xvFf9eUTHYTSSBrSgFltMEbaOH0UIzoHfbWmfMJD4OBEQ+wt7UdJgLy3y3h4UI6GTzbtWHjGGOFGLJ+P4zm9qEhC74MWtCXq5wbw59tLptMxBYGMa59i2q2ZRjDE7nyx0P72qSCHXw8UAgAxqjyBXuTFSzoBwiojnm/WOJpRW8CrbFXPbvx/Xndith6sYg648ButByyNJHHChvwzSe4x0itngEPXK+hExsezyUbG2zVjSIuwN1vIlGWnqiyEG/3dASTn9TU5l0hs1L9zhIv1jkAKdMsZRi6mAvgU0ExHg2U+Q1VrGg5MvA5GPDFRqsYr01iw4wI5E9ZTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRKz0OE6ZmtbIUPA4PFPsgAEnmu6fCyJCO31ugTnp3U=;
 b=O7aOWx9Zi3KoPpXEmbx8KPvCjNUz7nbInEhqXYDP6vhJQYd+P8ZInvsGnvJzGpa4pNZwt/uNZf64NYlnBxrArOYj+AdBzZZfSYfWtrdWbK/kqwRNWTSefVK2Xp6g0dQQgWoi2y+NoPB4ilcRZFBqjEpQvJaklpud788x/PO1xOjeAAn/H3aBYTX7KJaO670mugRPVuIooSqI51FvRFAio3ejvlXcz8yz9rFvR+A+v8pfDi8ndm5roVZ7tJpHgT+EYTeEgtCAunCjJdD6/g4TSYH7ZtznGSdkgcyDkcjAB32+jpXYWYBgKmWUhphcwEuLqE35GdzyFPKRFRdoY7vP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRKz0OE6ZmtbIUPA4PFPsgAEnmu6fCyJCO31ugTnp3U=;
 b=DrfAI/6AgbG6h1kQ/YC9107qhx72FA9AdvPRlQ9Pc022ZxFT4DEEX3CfgO4uLjMhBPSrdxuFzOsf4p4+smsWbZ2tVVKRm2cswHE6l7tYP9pFa93s+TZ+Tuca4cJBtaMayi5PsuGFmyOS48exya69kvyYQpAkDhtn6sY048PtT8k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB6347.namprd10.prod.outlook.com
 (2603:10b6:303:1eb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 22 Sep
 2022 11:22:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 11:22:53 +0000
Date:   Thu, 22 Sep 2022 14:22:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Konrad Zapalowicz <bergo.torino@gmail.com>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drivers: serial: jsm: fix some leaks in probe
Message-ID: <YyxFh1+lOeZ9WfKO@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR2P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MW4PR10MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: c969ac0d-9b49-4d08-bac8-08da9c8cca5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJCXJB9brWBiT9xy0OvB0J58UyNDwpRnKMRIVoNhhrrd7lSWtBbNOADCj884xx+9rK/5Gj6y/fhvO4TXyZu7JXpuMUIiT8PsXDnIz5owakWVUrQ7KktvtAyWzlOZcrnzmhR+VJ6q8QVoHTBo+DQ8BET+kPLAbe4YvS1lZb1rlr0ofSsqAPZv+HHevuwabkbwcmWXgDJhQ3KOzoGEPxqAmJLtj9qYslM1PSUxbBX8uQojJJzbRfsduB1o668gcF9oiWUVGjCPwB7X6MEUFx6Wcc+SXwbvmG9U72b0Edh8xs62OqlIMnZk/31yRGiliAHh8e5jir72ri3dCH+qqb7OmqnUN3qUDdibVUoqB4wmZbFsLYSPvG2h0sXz4LREZ9l8eCpaBIZTB/q+EtU9zcqLs7jDqrraJkHZtkJwXO+DoFNqBZiT1WBLfsPFVa+TAuBE5HY0lyDBcMmoRUifa7CkXf9BAdaQaubFekfzcjlSghq0+Hn6DX+PMZEPTEh4vm9yDHvHtLTm2Fa/5s5iU+XICL/QIAqJiylkYx13I7Iybj0o6T/GzTKeo+nSaMjvYpKJZGluOXl2sdsazbzty0U6dwEqp0MLAlHdGIB280D9gfO1NMMtQGDEhhfRhB948YaeOP/exkDg7lVfSaTz3K09WsGFNT219VVScoGsmg6x1pLD4nsqVyNXfk4HC7H8zXLUtjVDf18mwLouMseb0yJdpLPYvrJ+QlySkGU08q0oNxCvLFFG9MuEm3I0XNPVVECFzBFpaa94Ir+LEtySKpXSHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199015)(86362001)(44832011)(4744005)(5660300002)(2906002)(8676002)(54906003)(26005)(316002)(33716001)(6916009)(38100700002)(8936002)(41300700001)(66476007)(66556008)(4326008)(6512007)(66946007)(478600001)(6666004)(6506007)(186003)(83380400001)(6486002)(9686003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Blfk3wdymTc276IT0p6+1Vn8JqC+mMnoweP5gjRWuBtHOAhA6yVixXnkuN31?=
 =?us-ascii?Q?BTcTWVhR223jHzcvsnyFE5vYXHWaFAtGlO01iqIoJj2z72JiCXRZI8/7qwXd?=
 =?us-ascii?Q?N8IhY/C1A0+mEuaOfsDuup6W4ZUN+ArmbHXhgdB/wLsxStaskbmnBbk2JsA+?=
 =?us-ascii?Q?wXIRudCC8trv4bDjYgO7ea3Tr9XPPs4knJzwdfS8G0NDwsE0OGo0F7X7G4az?=
 =?us-ascii?Q?otn63D5z1/LiOMgcO9A7le7ohLzXblKC+p5I8AkKwNSs+A8HiVmLjRCtFQwz?=
 =?us-ascii?Q?IWFlbRoO5gi7+OYEkAV7PMSLVC0PB/OIpueo4Dz+G4dtq1DUcHgjYX/7rOg3?=
 =?us-ascii?Q?anoRQHxrvAvaJQYlglVPOLgmoYXpRTAM9tTl6QJJ7oZKuURwkxspVschA+af?=
 =?us-ascii?Q?Odgpe22k4E22iLNVsSb1Pvop1ZYHt40lMnkXRAQ+ore2L4HRt+dEkYyhvBN0?=
 =?us-ascii?Q?4txp0cr5T+nWb+UXsGrfkMGvCN1V0BjE5j42XMXWrK06l/Ii64sMn2dEvz+J?=
 =?us-ascii?Q?ImursLBzl0bmPqz9DoKQ+qqeDlSL10e2zIhSM2ipdSeVg1tfdHl6aGkYPbyb?=
 =?us-ascii?Q?3q9tNungMyECcUFTldOSj4k9VQbF75IP31E84/9ZgX3ifpYHvW8wCkYIIOuA?=
 =?us-ascii?Q?gNKpgYqb/Bx8vfrdPf+A5SgMLR//3NOhTdEODOibchNAje87bgUziTaYLsLk?=
 =?us-ascii?Q?MIuKm9qkLDAlY+fhygaoxfJSJw1P665Bbyd75cTlpGbRXKaVM0CjhSErXY3Z?=
 =?us-ascii?Q?3xcYGHGWnayMeC9sUuOdNFlmQj+M57so9uLKqQsL7YAkaFnWRYu8CtV5KLPk?=
 =?us-ascii?Q?AB97s+AQEOYX0LZOpFvGlxzhANaYevdYr3RzzI1W38IEj6RdRsIyLvQ1JsHA?=
 =?us-ascii?Q?ZRe/KZlwpfwrKA+p61EJJULCA0INeZs01eJXqyX6qySYTj3mNRK9EDUFocH9?=
 =?us-ascii?Q?Sz4RQcvRMw2ModGNXz/XJzB7DvQtUM6VrxLcw+GXM8+egK2GW/FoP5a87rKQ?=
 =?us-ascii?Q?CQe6tKSsZsJ5YFa2XZqn0wJLYHui0DuBRqGU2PE4eWq5G10yY2KhCcrWJKeA?=
 =?us-ascii?Q?CaOJ+3OsH2eqRqWqlEZ256+0LeyE4PVk1mKTa66kWESo6BjW5OY75hSO60aJ?=
 =?us-ascii?Q?kJ4qPgxK0kWPtz2QOE6BNnq9lUoXZ5X47AKmK6z4m3Nrin46hTtgKrdgOgBx?=
 =?us-ascii?Q?9/wufdGGH0SMuAqm9SWJ8XRE31s9ib9FZWc8h6reCezXS+MSMyzSLB1tVRBk?=
 =?us-ascii?Q?BojKlmA1JiTf9Pq3UTuZBfFQiScWwOF5GDtbGjnrDhDdSPwnmmUSaS7WP7S7?=
 =?us-ascii?Q?eQyb5L7/+XS7f6n6r6899M67zS8Ixv8cY7A+nI09Tzj5QECSgwvXDvvCB5t2?=
 =?us-ascii?Q?4ixTdhEmIPY9PuxUaePh5sogT5goR7rX6LWVBmoqa1OWIdLi7Kp0mYiVkGD5?=
 =?us-ascii?Q?/ob7D9hXmlc+ft3I1mtOkrhZ2eWKkVttGs/28MzXQZTij5FiVJ2d47neeuQr?=
 =?us-ascii?Q?kQIzdHo1Xf6G/YoAkFSKnXWXcIgP6SmYycQGz6YesA3h3pKA5q8kLmeJvyH6?=
 =?us-ascii?Q?b585Fxn32Z8NPulokk1WjjARW552zggjJRQXuCAH8JN4a0qa51QNAlahY20o?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c969ac0d-9b49-4d08-bac8-08da9c8cca5b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 11:22:53.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFIeyg5WrezWdvWfsGDp/ikXudgNu49jc4vGSQCOsoXE3SilAH6Rbduz7vhp3iTDv7L/slUxQn1Vb10imcjpyRXt3EgS34P5LAK8WTlC4Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_07,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220075
X-Proofpoint-ORIG-GUID: naVJq8D0NQjSHG05ZKajl4FIGubk9tXC
X-Proofpoint-GUID: naVJq8D0NQjSHG05ZKajl4FIGubk9tXC
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This error path needs to unwind instead of just returning directly.

Fixes: 03a8482c17dd ("drivers: serial: jsm: Enable support for Digi Classic adapters")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/tty/serial/jsm/jsm_driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
index 0ea799bf8dbb..417a5b6bffc3 100644
--- a/drivers/tty/serial/jsm/jsm_driver.c
+++ b/drivers/tty/serial/jsm/jsm_driver.c
@@ -211,7 +211,8 @@ static int jsm_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		break;
 	default:
-		return -ENXIO;
+		rc = -ENXIO;
+		goto out_kfree_brd;
 	}
 
 	rc = request_irq(brd->irq, brd->bd_ops->intr, IRQF_SHARED, "JSM", brd);
-- 
2.35.1

