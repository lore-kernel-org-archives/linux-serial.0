Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790CFC433DB
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459EA64F4D
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 16:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbhBDQOd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:14:33 -0500
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:61058 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237864AbhBDQNw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Feb 2021 11:13:52 -0500
Received: from pps.filterd (m0118797.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114GCJc5028461;
        Thu, 4 Feb 2021 11:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 cc : subject : date : message-id : content-type : mime-version;
 s=pps-02182019; bh=/LACxhI/uaZump2wVi8Pu4EWtCoR4P9l/BnfoV/UH68=;
 b=umL/3x/kL82JGX7X9d0JHJzeQoG5eW/VKVUEkjgHXvjSO2VWElNOuC0A9ti+qitOT99o
 I9B9t/MtIXBem6IByHEP/GSyTOJhCF8JGspWK1pRiKFNxwdJqqwL9ll6mkhN3GUX3BlK
 eLUCgqNoxaq6izx7FcbyC9vfNvba26FMFmeC6HjJ6rvVDcxF4hmXRbAUCVlfsGsyMu5a
 vTyq8Yp0c0eHkWbKGQZga9mCHtgVJ0Fo3zzcDdNsoXMxcO7qu1JOPKKHEFj6Xn0vpxPJ
 nFdI4dMtXnaCxylGQ0yCMSpM6Z6dd0zJnQhMWR4JSVCDOFXNGiwnXTQrp4pS4ABXiq3h Hg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-002ab301.pphosted.com with ESMTP id 36eq0wjvx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 11:12:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5OHgpPfcQLC2LAxBoNiGP3lxZMWJUnazbKmGetl6Oz1fku1TxlpSW84oCWrHOMw8qcgmHWwNHqot2d1+LDSTE7cqpvnqf0sesI+AeVvM6Bcnhyhki2mRFr+ZkV8YYTL/Sra1yVOeI1JjlON00/W705SUBwgFfwQ2+87K+iC2ffIaZdo55rGDJBg6rCUqHNOUVA7ynwVMSOdDeDvG3ffNbxR7UBfC+JARkKT7CrpGnTj4sP0vUNQbQfzVOYp5KQJijkI0175v8iYFNNZT8opQQOxPRyDRUDlb6ktGY6BjANXRedLRrkfeJF4qXRByUJs0u+HAIhgERNgLcIqbk86dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LACxhI/uaZump2wVi8Pu4EWtCoR4P9l/BnfoV/UH68=;
 b=ZjvZjf0fscI80ZibENM/pe6N5Jtib1NgKa2F6x2qCPuiaBqMbm/Z4YBuGqWsjkkf2avkrt0nVd6ZOyIjF3lledFDqQbZt2haGa0KdoUvAQ5OdQ2DgvB8PNBYG0z1a6fNrsLzq81+dRkgnxOY85fOWwzTIk6E0Lte89vQy0G2IfQ0TlnO6ePeSGkD44nAhn5CMl2+BG40tvYwd7otbcq5vYh72/gvazEpvSIzaGKTjZWjvBhtCq0dSCygNzygDSIn/znRcB6I2YgbYCEAwW69b1nvPDPQsBSAbgHOq5gbywcqVu+yWOtO6m+DJYdqcxdwXNpM0LFtZjPDTIYS4xFzBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LACxhI/uaZump2wVi8Pu4EWtCoR4P9l/BnfoV/UH68=;
 b=KLwhXgCpQ9qyNOIJmfu935c//OA8jLn21G6DjJf2UN49UznGL7V7E82v3zBGaTxqZ4DdZtxq4roLXnDwGIrsxzaM+grTpCqgc3cTDcAsv9fgQjt7X7151Ba/JuW8vwyMnyKj8Y1XEgo6ciZqHruIPq7upxP1p9eFGzj20qwbUPc=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM6PR01MB4780.prod.exchangelabs.com (2603:10b6:5:6b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.28; Thu, 4 Feb 2021 16:12:16 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 16:12:16 +0000
From:   Eric Tremblay <etremblay@distech-controls.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH v2 0/3] Handle UART without interrupt on TEMT using em485
Date:   Thu,  4 Feb 2021 11:11:55 -0500
Message-Id: <20210204161158.643-1-etremblay@distech-controls.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [2607:fa49:6d60:7d00:557e:a58:9777:8e36]
X-ClientProxiedBy: YQBPR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::34) To DM5PR01MB2457.prod.exchangelabs.com
 (2603:10b6:3:41::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2607:fa49:6d60:7d00:557e:a58:9777:8e36) by YQBPR01CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 16:12:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: abe513ee-b14c-45dc-5507-08d8c927a3af
X-MS-TrafficTypeDiagnostic: DM6PR01MB4780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR01MB4780C4440C9217640CF0A7A095B39@DM6PR01MB4780.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pBte1UJJvwb+podTQ/3/BwKPEMkPvKG/f7FJrqkydBuUy66PlDFZI8SmqDPVYwr/TEVeY7aKBJ4pfR9zUPZ61utdEdXXhM1TdZqf6SqgPfP1sbNixRL8TAMQxGOtLCjtuy9XIQ8IhNcaQ+Hylna0nsw6hZpfjaF8a/ita5GhAH8HUKvnlW8/btyKotpg/zaEUZ3TMsPSLCxjiNxBzlDbVUfa/oxQEXzzxo1sdHzi4Ed0NhpFmVydMDm0BcTW2E9Z2jZX+vK5zJzZuSvFlYtQVjSuYW+IKSkg3uiKS3ohb/w6NeVfgTGkW7I000hD7Gi9qquZNcvZfVEr1rw5/YAhFKR+jNd74xMNW8nmkYTz28NRYEOiml8burqb/y6cXsxYlvlq4WQq41ErbxGltlNtRN9ZQSHwcbypKJ0GSS+SQpHnaWL/RgY5IjKizWxq/013zZ+o4G+VSH/oZARZ3cFpG/zeDFNbQSCXYhVZ03Lagz63zAZjxquRtGxAhkozQdBbluCdEfktoXI35lTLb50coJmo5wUNPOr1dQEJKG0FIc5zjFAqFk4IFaKgKZFOFKXq3XG72+X2tyj0TA7mMLv7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(6506007)(6916009)(316002)(16526019)(478600001)(86362001)(8936002)(83380400001)(66556008)(7416002)(6512007)(2616005)(107886003)(5660300002)(2906002)(36756003)(69590400011)(6666004)(66476007)(66946007)(1076003)(8676002)(186003)(52116002)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YHy6SgTTNVE1m0MPohWdBKKAEc+QwDj2jrsg7gni1U7ydlyaRDuqc69fJvbd?=
 =?us-ascii?Q?NIu17xlxLYGduw6+INY9vvCw6KrqJUbjKli/mD7n38j6wGCBZWkmHLEx35wM?=
 =?us-ascii?Q?0gRYTaDp61Bd2Sg3KaiJYd4gQqG6fBPTz/X3hcr16eFnecObNTIOvnPWQNMp?=
 =?us-ascii?Q?WiCWYVQKeUH1IqKJaD7Sgh9jlaDmmgw3LREGW1ETj4Yohdc36k57N+htu+Vo?=
 =?us-ascii?Q?rAqCeIFWaUcWF1Rak6DXYp+bpMHANR2QEQLlwWV2xgYC6JvRUWTqbI9OcaXG?=
 =?us-ascii?Q?vKBBNSrcQM/n+I4+G5lrjFzmMQYE8b6C/od0XEUHCthygOOgFGOAsBvTXvVS?=
 =?us-ascii?Q?+QCI0H/vP/Rqwv0BBEmlklsAHoItgCGyrV0pdf8olLaweWzVqgDf40nD/DFo?=
 =?us-ascii?Q?Nu4t0HAz/cAbsGzB7509iWxwuafCCa3dNzZ4upPAgBp5JTx67eV7VyElWVx/?=
 =?us-ascii?Q?eHEMoMFT6dqykwsxhYZkWo+22P9zQk8VxhoGL/t8ikKCpbhkpTITszlQ7XNE?=
 =?us-ascii?Q?v7pgii8H/mfYmzO+0OkM9yIuIbtkWuJ2Raa9oIQLsf2+j+WRpCQHZfZ2CSSv?=
 =?us-ascii?Q?HMPRG2/VbpmF6LHgb/P65Ox0/eOpI3AAIz49rRcyER7/vXWIu/92D2l7V4v+?=
 =?us-ascii?Q?Qi8ehv+WhW9NEJjFye5XJk7NxBImO0w+YrVgf5kHY+hT6R8ooilFMqXm7fPR?=
 =?us-ascii?Q?hT6G1AjA4u6VsTYxwAPvk8aNgUZlYZriXd/I1Pfy/0+k0uX0UD0iLepEp/n3?=
 =?us-ascii?Q?Ey3T1mj7/a0Pj2kco7Qooto72ij0b9bl0arNWoQDPfXiOSIx9e0IUXVhZukd?=
 =?us-ascii?Q?rQo32uOQz1KvWTL+Eg7CHGs3eIzxoprmjEIfG9WOcbsgIfy9+teofjeo/o3y?=
 =?us-ascii?Q?UjlqvhQi5S2ZmX2H2OUo06r4Y8mDjQwyX7ntndDJ9ilxRAlw90oVegzbKg/f?=
 =?us-ascii?Q?6MbG4ek/vzg/+xXyQoIizzjPPOn3VdPdL4kLpr7r6u+f/D8Oe+cSv2cKBTim?=
 =?us-ascii?Q?n6DY649P3stanzv1bNiLEcH7nDvA9pXXumFcIhvrl+HZgJzNI72EHcdHkC1O?=
 =?us-ascii?Q?ne5EOdFmbhp49KxhAUJoA3KcJaPyBQcqg5D5woI6iUd6FJyVFBJDpx+y3SRj?=
 =?us-ascii?Q?lVORV8RVKwt6kTQOWmob8tc9lIsbv4wqj3iU27sjBFdZADubKtR1LILsUOcn?=
 =?us-ascii?Q?JDU1gySxglX2ZlwBiTL17g8/6H6WpW3KDK2bGLggZxrli24qHUkpLZ1AYXYR?=
 =?us-ascii?Q?OWdUa2MnNLW3aLdEZ8P7znkQ0xdvzAhT6MRJhx38Ghmki06ez9pSPxP0g73D?=
 =?us-ascii?Q?neCKL2jz6FeANesrRit5/MmOD12LL2wPxGDNpbS9+kOLlY4fImYAVS5fNauR?=
 =?us-ascii?Q?FfZIJHI44hRxLUQC+yGnnERpSpkF?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe513ee-b14c-45dc-5507-08d8c927a3af
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 16:12:16.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXxWJ6AKp8qdqS1sdhbmplqmDZPUavy/9BLwXwRtTmfBv2XkpY6SQpjJHvB3P/4W3KT2RKvIba1kVNgW7d+7wg==
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

Thanks everyone for the comments. I apply most of the comments on version 1
but there is still a pending point with the Jiri comment about the safety of:
struct tty_struct *tty = p->port.state->port.tty;
I thought about adding a check with tty_port_initialized() before accessing
the pointer, but I saw some other places where that same pointer is accessed
without further protection, at least from what I see. 

Changes from v1 to v2:
- Use UART_CAP_NOTEMT instead of UART_CAP_TEMT
- Use some predefined macro to reduce magicness
- Reset active_timer in temt timer handler
- add uart_get_byte_size
- set UART_CAP_NOTEMT in uart_config for PORT_16550A_FSL64
- Improve commit messages
- Improve grammar and spelling
- Add Giulio and Heiko SoB to reflect previous work

Eric Tremblay (3):
  serial: 8250: Handle UART without interrupt on TEMT using em485
  serial: 8250: Add UART_CAP_NOTEMT on PORT_16550A_FSL64
  serial: 8250: add compatible for fsl,16550-FIFO64

 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_of.c   |  2 +
 drivers/tty/serial/8250/8250_port.c | 68 ++++++++++++++++++++++++++++-
 drivers/tty/serial/serial_core.c    | 29 ++++++++----
 include/linux/serial_8250.h         |  2 +
 include/linux/serial_core.h         |  2 +
 6 files changed, 94 insertions(+), 10 deletions(-)

-- 
2.17.1

