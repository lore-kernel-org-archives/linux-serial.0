Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3B6C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 28 Jan 2021 23:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6DAA6146D
	for <linux-serial@archiver.kernel.org>; Thu, 28 Jan 2021 23:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhA1XnY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Jan 2021 18:43:24 -0500
Received: from mx0a-002ab301.pphosted.com ([148.163.150.161]:43198 "EHLO
        mx0a-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhA1XnR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Jan 2021 18:43:17 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 18:43:14 EST
Received: from pps.filterd (m0118788.ppops.net [127.0.0.1])
        by mx0a-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10SNIKVN021952;
        Thu, 28 Jan 2021 18:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 cc : subject : date : message-id : content-type : mime-version;
 s=pps-02182019; bh=USHO1Aq9UsmyfUr6DOfBnE6xxF9t0cbZv0j2X/uJ53M=;
 b=afuQiaXxTZ0kczDrzhSCSyxF09UeZzZ6DAvPBCp3XzTnX+L+cnpUS/C+yF74CAYS6Dxj
 KG9Yu4pmo2T3XOGJtN50g96wVN42gfZxtUg7YGf8sLhnx54PG6q+njj49h6tDj0eb/e9
 HswBAe8F7Apx0rvbe0QUY5MMYRHM9oXa9dZD2lw6T09KvFM6/gvobQSj+mg6Gu7luXq6
 uxvI1EZEcSikeT70f/i+D2Q4cal5Fmc0FVncb0WRbVAFJQcYEeE8zapRRwQVWRKBFap3
 h11ifZRyWZgs1L50V2qnshRzCQ/w0eAV6yILQ3MbBxqZwW+w/D58/X+SWSQdgy9njRDU 6Q== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by mx0a-002ab301.pphosted.com with ESMTP id 36c11cgc12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 18:37:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgCR4avSMO/UPymh468sQs5ijV6PinoPkrRL8/y4LAb9m2jCrzcQso7yC83QQZ4URwz782S90ERnVzrd5i2NkShTeK+IpcHolBmJze+WNH88QqaYHVrOoL3dZGTSeaPSrIsPDlTcjOsMbzuiC9hlYtDsWoWcoVfDAFMXOR7Ngau0ouoR7wNvPYmESkERTMW4ttIX+/Y2fdRgzahSoqyvsO99VrGkgWkJfuzFxjTwn/KfgJvWBMX13VZ1gh/7mnNG355hLl2DeVtID6qiL3omWDCyTzAjYPMNeYCIY+TURJGIbNWVrP7R/FKJBIRGBc3C/0RDlCcbZrX1Mr7CE0xq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USHO1Aq9UsmyfUr6DOfBnE6xxF9t0cbZv0j2X/uJ53M=;
 b=fvUe9WNEKR5baa30lgngVpRgie2SmBiOdEumRBFm+mVdVwFOF4y3N9mIUqW5zprYWypmjeo919PXf0oNS15GfjXoElxYvv/Zyj8+ZXDTOo+VHic/W060gbNgsX1N6V+dNO5ps24W+Ffb9ttxSwLSAx5hJoqGjhiRxEPJj0rGzdGR/vSoTMQ4ith+KLLDo07ttZ+hPbIMkomYcWQUarP2/Y0s2i74q71rutDAWFS5rwTmiEI/XoK+FM3psEEqZhgc6GjdYBWLA4nHUr9vBRAejBDEzzSSBoNxe4W0fzVn5nNK3Dpl9cQbLSjcY25WWoEeYKoF6ePdXWOLzNBHF2b3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USHO1Aq9UsmyfUr6DOfBnE6xxF9t0cbZv0j2X/uJ53M=;
 b=AxQxk5ivmLACFPbyItbstylFGTSR1u34fK8B0aCCLKICSLJUXdiGZGmLkmKoELnUwvPHpVy9rTZfcbPSJJ4xc7BzLQFuIioPrPMBk8DPMCzxrCcvOzEC720a1BZ4n4AxTMYek74gCnZ4dViQhDOlZy04MrFaRceAZc3GydqydXw=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM5PR0101MB2908.prod.exchangelabs.com (2603:10b6:4:2c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.19; Thu, 28 Jan 2021 23:37:01 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.016; Thu, 28 Jan
 2021 23:37:01 +0000
From:   Eric Tremblay <etremblay@distech-controls.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH 0/3] Handle UART without interrupt on TEMT using em485
Date:   Thu, 28 Jan 2021 18:36:26 -0500
Message-Id: <20210128233629.4164-1-etremblay@distech-controls.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [2607:fa49:6d60:7d00:a56e:4209:76ad:3739]
X-ClientProxiedBy: QB1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::19) To DM5PR01MB2457.prod.exchangelabs.com
 (2603:10b6:3:41::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2607:fa49:6d60:7d00:a56e:4209:76ad:3739) by QB1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 23:37:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 123713aa-ceb5-42f9-f29e-08d8c3e59c8d
X-MS-TrafficTypeDiagnostic: DM5PR0101MB2908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR0101MB29083EE6A0CB92659E8C2F8C95BA9@DM5PR0101MB2908.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tCSyJTUYD/DtsGAevHO50bjWcf6sK1rQabjIN/qRGNa5Tue7ZlXXPyer7V5DVZCZMsIAYaKotSp3cmT7iOWn8KFAW957s1+yzdr3VeCBXkfdFpKm20x1Ias6/2OxmrLBqky7MOqXevnQ0S1Ooh7zPU6nq2V5Yb8luQhMigj6HD9PE8G4xGn1j3f9i+S1TF8xBhNmN2pnHnmqSTx+1QKG7hKgyPnxt7A31L4ErsVJcHmCvRwn6J8SkzSrGi1nNxk1olsubPDsWR2HfHzZgRORM/4NPzj8AwaV5BBgLboQseTLGLHflZJJoWYUXg1QRO1W1oYyuNZtAOQvrCH1XDLh0APA9L+gmGBTmbQ8a7Vw5aBFp+qMC28d96PJ6+vWGHxLffZUBJLuerbsfbbmK0N0ykqM1FHmSpazviGRzOrTgZ4939c2wMvVNuSD1h6bGhObDX428A2T65n1Au+4ApcOKB7KG4B+8cjSuUeOjaY/9clbEAsYFa1o6NgWQq0JMhSxUPPyDrBDTVS16GeikpzYhX7J4um8Qu8p7aGavUW0Ybz/nHhs/TBslkBtwq2d1qIPorufuc4/fu5z2kHcFrp/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(16526019)(6486002)(5660300002)(2906002)(186003)(7416002)(8676002)(52116002)(6506007)(86362001)(36756003)(2616005)(8936002)(66556008)(6666004)(66946007)(69590400011)(66476007)(107886003)(83380400001)(6512007)(4326008)(478600001)(1076003)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0LTcaGy1fzcNhlP8ntsftDzoB/gglfs5pJWxwXgTIZSuPZKEroa7v7IbXWFy?=
 =?us-ascii?Q?efik+ANz9GCH+rp++nofuRJSzOKOhlDzplLbqxSu3qfzOQ+YgtUF6VF3DvPH?=
 =?us-ascii?Q?DQIMoV9lsPVggYo5sym3BCo7OA2QmY7PZxagpmJmTEUoHXqxk+r1AVJyQh10?=
 =?us-ascii?Q?m7PvHN6EP4Om7SYsW98XjqGM1AcOZ6yrmq2i1c9mmqZ3+HWX5bfv/nq5VD4i?=
 =?us-ascii?Q?T0h8mhHclCnc8zIQGQk05xBSMgtDZaCjmCgXrTNpJNJ8Mum/QVJI9OWZSpkg?=
 =?us-ascii?Q?Ea2adb8Q+oSpwsowJPxUc9nCd/I7qfjgBt7vG74aFp1Pse42t8EUOf421+Zo?=
 =?us-ascii?Q?TVxNbgMt27zEHcxDbomZcRZeZPrdrmDRA2HfuCFN5WEalyLbSgcF/CvbFQMg?=
 =?us-ascii?Q?4uAxWpGM0vNYxBCUVdbjY78ntg3qihdrvoUnL/h1JJY/rRAaPRq2xrqGbQDI?=
 =?us-ascii?Q?YwNqeTb4GcdaOoPnLyQGcWTLXhFxv2FXY9QxcZnTn+CV/9dZmCW4MYynYl99?=
 =?us-ascii?Q?C8eE3owP0oMiAJcUloACMWwe/IeDFev3GoSqET4VyzF/JNcRP7pmLrPmKxwk?=
 =?us-ascii?Q?EcXxFHpv4GCPjqVzs9bk4VcQk/ZLeuRkxrhIQmbZ1ydsb/NAxFucS5rrtd4V?=
 =?us-ascii?Q?LvLMtu6jsQlLMce4akGEQoKoSfVN3di21cqcyP0Q4emr+/x4EctEQrGYGO8M?=
 =?us-ascii?Q?Vf5zkd+uyPzFenJqDo6AbdQl0Dx6h9MToRBZgiZ97+6QSAzYHrieTH0ql2sQ?=
 =?us-ascii?Q?coBwttJVDP9G/3Ux4hfiIz/OJiD/NDug1/09yb0OIWMqXFJFwxkCs86YSgcF?=
 =?us-ascii?Q?HwUJ/VnZ06Hvcdk5vtMH6VnmTYCppKbedzdj+oVwwNZc1bX/wyxycXrLH0ZD?=
 =?us-ascii?Q?Ork/3VO20rsvpvKKvLEutZcujmUeBb+jgCBqyv6OyeqdnISqW8yHM39weDHS?=
 =?us-ascii?Q?To7Na7Ie8wt+FehDL6qAUSM2oSeJLcpIt3K3S5dDKLWlJJeTtZTj4qVQFbQt?=
 =?us-ascii?Q?Xo8TY/SNp3qaZJvhilpRotKmOJRvtAZDkF8HfqhMZWxBjMk2uvE4Rhi7XhRH?=
 =?us-ascii?Q?FeBmMjh2D6AK40GJ+ttaZBVv17eAcKq3KScKUqg8tV6Ieia4ya89a+Mwweb6?=
 =?us-ascii?Q?MxtmmZCr8RAw?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123713aa-ceb5-42f9-f29e-08d8c3e59c8d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 23:37:01.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PX61bJHGMFBan+DdwEYXpkD4iPJ8ukrQ3whO3phFbp2GQEvYqjrBeWqU+CtHNYYCWRRdQoZXh1DnUDvwGaeD8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0101MB2908
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=874 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280112
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The series is mainly about the support of 8250 UART without TEMT
interrupt. I saw that there was some development in the past but
it was never merged. Since the last discussion were quite some
time ago, I was not sure if I should post a v4 over the
last v3 or start from scratch so I decided to post a new patch. Please
advice if I should have done the reverse.

The approach is a little different from the last proposed patch which was
doing using a polling at 100us. I tought that it could be really long on 
some fast baudrate and really not that long on slow baudrate. The current
approach is to calculate the time of a bytes when the settings are changed.
When we get the interrupt for the empty FIFO, it's the longer it can take
to empty the shift register.

The other two patches are to use that features with the PORT_16550A_FSL64
found on some chip like the LS1043A.

Thanks

Eric Tremblay (3):
  serial: 8250: Handle UART without interrupt on TEMT using em485
  serial: 8250: add compatible for fsl,16550-FIFO64
  serial: 8250: remove UART_CAP_TEMT on PORT_16550A_FSL64

 drivers/tty/serial/8250/8250.h            |  1 +
 drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
 drivers/tty/serial/8250/8250_of.c         |  5 ++
 drivers/tty/serial/8250/8250_omap.c       |  2 +-
 drivers/tty/serial/8250/8250_port.c       | 89 ++++++++++++++++++++++-
 include/linux/serial_8250.h               |  2 +
 6 files changed, 98 insertions(+), 3 deletions(-)

-- 
2.17.1

