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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D06EC433DB
	for <linux-serial@archiver.kernel.org>; Thu, 28 Jan 2021 23:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BFB64DFC
	for <linux-serial@archiver.kernel.org>; Thu, 28 Jan 2021 23:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhA1XtJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Jan 2021 18:49:09 -0500
Received: from mx0a-002ab301.pphosted.com ([148.163.150.161]:43954 "EHLO
        mx0a-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhA1XtC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Jan 2021 18:49:02 -0500
Received: from pps.filterd (m0118792.ppops.net [127.0.0.1])
        by mx0a-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10SNIKCZ011343;
        Thu, 28 Jan 2021 18:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 cc : subject : date : message-id : in-reply-to : references : content-type
 : mime-version; s=pps-02182019;
 bh=YLwVX1BXWtactTrz9SAenuej0fEoMnge6Y2AslpNNYQ=;
 b=FRkYgKQmjzq9wpvth9ey7WB00pJl5561sBgy/Xay3XtVQhTUgXTtcjDegD5uC0IyDFeF
 8z9VNJWvJX5E+uLKeeevp9EiddfeyKwwrVJrFM9llkozr4Qj1dnq5NCF0yhy1FwOd36R
 abmp+G8U5aAxHTpp+xanRmrwZp8lFwvQBS1XT+UN8tZPqtw8A6VVDCPNTOc5lLaKq0sQ
 09DxWumte9B8T4DGluGDg1D9QvbRQ8V3lePmUHEqrMxNoZQiK/05RL4ehd4SMgpCOHid
 wNMNsEwc8WcpFKzVVC7gQJkysekcFUi30QUvO/MXyDNGKegm0vRHisdMFaeqGxj9xxQ+ bA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-002ab301.pphosted.com with ESMTP id 36c173rbmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 18:37:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLDi3F6e0sMMXgiGp5nEMAFhPp3t8hKgSHpxs6UWqOiYztBPsWheSTGst8iOrIgpCDqveWGT13IfoTIrofZwnHiLqkvyS4xinufudL29489OW7knf+jEwGxqV7nu0zTM6jfpl/HUTd9Pz2TSkPDJ1ccgPjAfs91puOk/moUv1Pvpo3OgpQ2HWkrP/EzVQbLSiS0aPo5JyTxXSPpmW4bh/OZWeEBKUE1PK4ZW7rYCPab0NRdy3F2OJ8BbK4CZ7m5eJ95GIGAwa1Wce4zE5nDkQw2pe6MLb9V0qdFCWnClbX06znwvwzwV8a8MD1ct679a6g9udpV1TYHVv6/y0Z0h+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLwVX1BXWtactTrz9SAenuej0fEoMnge6Y2AslpNNYQ=;
 b=UrIXGgvUsRao9UQnOik2ioJ779Kaavozz+zXxNlpW5/bIy41Jq9T+pV1fdAW/Q3RFnT1Qu9ZXbMjoCIfwhYxn5hbUK8LyRlJXocLG/fslwMQPbHLroaTSfJPhH8VfkGkt+8oX4fADZvEKmGPncwwlikboF1dt4hu8JI1ShcXJ2Vg2nebnnzACiAXuaFxwd+1TjtMsfoxaV9/WLLeqJO9MZZ4Hj2myag1l2w4M9mKfa8mcrQnmxAhwP1tczE5ZRIFVy6cFbyYGbytPb4Zcw+7jxSmQecM9QfvdlJgrZmuDAoZU1cIBytja3w6fRVq2CqA7Ox0s/L6fnoh2bJ0jPNMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLwVX1BXWtactTrz9SAenuej0fEoMnge6Y2AslpNNYQ=;
 b=Eq8hhpsdX06Q/oyGyd+7wv+yjIZo7fUPEnExSxMOkYmzL0i5auTBy5SsjIeE4y2No8hstP+6ECg0yoTWCTh8v07OlfERrPWArRUgF2CEdBAvpQURuevJMYeqVYcB/rZNZcpz2U1FLF0sBV88Aobs805rJOFfRpOnvQVi5U2p41I=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM5PR0101MB2908.prod.exchangelabs.com (2603:10b6:4:2c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.19; Thu, 28 Jan 2021 23:37:10 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.016; Thu, 28 Jan
 2021 23:37:10 +0000
From:   Eric Tremblay <etremblay@distech-controls.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH 3/3] serial: 8250: remove UART_CAP_TEMT on PORT_16550A_FSL64
Date:   Thu, 28 Jan 2021 18:36:29 -0500
Message-Id: <20210128233629.4164-4-etremblay@distech-controls.com>
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
Received: from localhost.localdomain (2607:fa49:6d60:7d00:a56e:4209:76ad:3739) by QB1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 23:37:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 281a47cd-3a79-4bd5-12de-08d8c3e5a1c0
X-MS-TrafficTypeDiagnostic: DM5PR0101MB2908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR0101MB2908E51C6E1BC3766A1D45B695BA9@DM5PR0101MB2908.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbhoQN/MtDIbpbaahZc3hQ/nmBVtOJvRWxeLCKWHLRTb3KDc63uwSwqpBnihbBC4FdV0hCaVaqwet7baCQDQY2DFlsvHV1Q3d4Dk7ycxatKl6eJqGYCiuhPf8JfY8hLOnG/jACS3ddbpHmLGlSu4B36BISYnBriSSzKM8ydgc4Di1TIR7Tmh28/tOBU+y4nwWUKJtH3eDaaSaEQYI+036/xeL9cCnSWmsZdXmcYYomg9Whvbrtsm+a/czKR8V8KSSqh/pnHPY0BQbjKF1IpGe7CSNybDvA2XDKKwBGPaTB8FGaiUJVrovIwLfELrCLzAI7DoAIv2r8CYfRQhveZBvnXOdoJxo56k/EA4UFRX81Ytc3gW32WJMFWyxLV/74/GVzg1miZrsq/AXdbcz0miy+GThwxuOH09LqWqi4Ry1yiME6uXnZvGqxmO/YPB6fJ8DN9FXjm3GqyyegcWZA1lnYhmO08mhY8bemqvngJjeAoMp0yQBUFo7NDG+llha1GKjgnM9joQFzoV5EB4s/4vwJQHlRMP0kN8rxMF3sEbbirxpWxWehfMm/H/Fx2xzUEHSN/Rv+So9RCLdoDyoIpZjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(16526019)(6486002)(5660300002)(2906002)(186003)(7416002)(8676002)(52116002)(6506007)(86362001)(36756003)(2616005)(8936002)(66556008)(6666004)(66946007)(4744005)(69590400011)(66476007)(107886003)(6512007)(4326008)(478600001)(1076003)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D08MV6jQCwiCeb6+nbS2w/Mc4dMCBJQe6yqBfgHWciGvz4QsbcW8tBIArIC7?=
 =?us-ascii?Q?jYEu1hcALs0WwUj5agasssqeNN3hCEcX/QGoVSEFDEbggmiHzIm1aJtEdJQg?=
 =?us-ascii?Q?Pit6+h28EFnf2wUajMeIS+IXW4l66YTAB0gyjtUT6T2/Rwv40jVtkSqNCeNb?=
 =?us-ascii?Q?e/qmtowu/NtRYTT8bCUZb/d206Yw618wY7Ag6DvUKycgPbzK16nqhmSUSv+f?=
 =?us-ascii?Q?J5s5kR28aIrkEs948yAjv/rSNibfh0fqpmEMNPX/cLXWIC3Ge/zhFFEJxS6h?=
 =?us-ascii?Q?zPwLl+de3yIIpjx57uSoncEsD4WOVvdWddvT7Xbponoha53OuH4YEF6xF2IO?=
 =?us-ascii?Q?1vt5gqNOROS8YjQAvSDk7qZzyIfz1v8VHW1FUX9Y2QbFGBWihdPcOFYCnVk2?=
 =?us-ascii?Q?aFM8+XoFYa2AoYj913vjmXMnQnKCnojOwdZqIdzImijl7RPIpSXRjs+YOMsJ?=
 =?us-ascii?Q?3i/xXtfgZMW7OVSOkOEjO7pLXtwj7ENRrKbtQ3ZhZjp4PUZ4iacRmllZWbZn?=
 =?us-ascii?Q?ysnb8iDLrLz3eVqHLlFoQ8QpjyitavHyqj4wLIfb1mtOidVoLLHPAn0wJFzQ?=
 =?us-ascii?Q?Izc/J7KFmM6Xl7yX2gn+5DgTiZQ6qhKiRA5mRWdjkisZHwZV46LZ/g0cURcw?=
 =?us-ascii?Q?9wgkdCIHsiUwqkmILzfvwprdGTmr93dH6hwveLFmojTBWkPERzDyRHTduGPJ?=
 =?us-ascii?Q?AGoilP5QOgnmfyk3MFxPphjYop+xNxfqwkCj9upJtssPpgxtZYFsG28jLMNE?=
 =?us-ascii?Q?6NyzL943UFSSZ3lb4Vfig/pf3iZM/16TpXxjAYUbHMVku4gq3K8vBDOVhWnT?=
 =?us-ascii?Q?GS2Iyvoetr2/UkkVEM/eKRmgUV+aKQ8aKwIupnwpiE2dJ0CsurO0m5yPBe2K?=
 =?us-ascii?Q?z5ZMNm7yuC9wTh2feUQdrIxJgNH2XnBQrFUXphyDgrfxxyq87BqbVgo5CKyA?=
 =?us-ascii?Q?mpCLn2lJfpkgDwlMSCay7hDorN8aSPFmPagJb/E1U3FGddO0zzwiXZRFasAd?=
 =?us-ascii?Q?RKInPVGZXlFlWWi9OHnWRjzAk/Tb2xYESK5dCj6OCIRoct/3g1F/EmkxKCMq?=
 =?us-ascii?Q?Rx1APcJei39TRZlgYc46jQX1cPa3Up0cZqpF74N0PrdAaBro+vAkMVHeZCSs?=
 =?us-ascii?Q?Kn0QD0uxZi7o?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281a47cd-3a79-4bd5-12de-08d8c3e5a1c0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 23:37:10.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mNJXZMcv/0MzBp/bPsTw5oUmjknKjNnthgWCRCWI+NKkUvHOhmsL08kIUXfkMZUVSfKZwyGx6cr7HD0iBfBjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0101MB2908
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280112
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

That port does not have an interrupt on TEMT when using
the FIFO mode.

Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
---
 drivers/tty/serial/8250/8250_of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 4efc62c0b25c..9a5bb6837949 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -225,6 +225,9 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 			&port8250.overrun_backoff_time_ms) != 0)
 		port8250.overrun_backoff_time_ms = 0;
 
+	if (port_type != PORT_16550A_FSL64)
+		port8250.capabilities |= UART_CAP_TEMT;
+
 	ret = serial8250_register_8250_port(&port8250);
 	if (ret < 0)
 		goto err_dispose;
-- 
2.17.1

