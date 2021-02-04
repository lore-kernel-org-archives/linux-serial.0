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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4514CC433E9
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 16:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1633664DEE
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 16:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbhBDQSe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Feb 2021 11:18:34 -0500
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:23752 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237868AbhBDQN6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Feb 2021 11:13:58 -0500
Received: from pps.filterd (m0118797.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114GCJc6028461;
        Thu, 4 Feb 2021 11:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 cc : subject : date : message-id : in-reply-to : references : content-type
 : mime-version; s=pps-02182019;
 bh=AmJSckmRomMiSiH1fbcoIlYpopdk3TttCntECN/fbvA=;
 b=J21hMIcsoOSROKtPNX8K4ceQYH3goVwlPY+0EFVNQjxTSzjZWXuqT4qGB6uXpjmdiJpd
 TnNGXGlTEmEZTVDgUbAbpB52dT9hmTI2alUj8Um7V0Sgw54O6oBax38JS5BpqY/0uhH8
 8WM3s1G5GY5Vv87bZc97k6rBCRtgrIu7bhzeDHdalKcLYxg4+4qqdMFFkzyDaSQQT1VL
 5VEKSTeGngWI53Lm4S19H/6wLBDhYQZCb07b//eRQ6jhR5h122NHFgR5dRJYX1p3YpJ7
 kPiHn1RKAxCnavCB1RwEgK7fEn1mcEYu0qCAyHlo2SWTN4ilyFYLhFGow45M2Yl3/gnm aA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-002ab301.pphosted.com with ESMTP id 36eq0wjvx9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 11:12:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ2MH/7+2HSZpIxjpmyk5YC/0/CZGVzMKYANy3tqEsh+4SWJmgp1EfoQF1yuQiDzm3JUO52wD8xoqpsH5MDqdKNx9RJQyMuzxt4bI9inTtdGYioINhGqx9cI1Rs4BWofUHpV0T1g/tjCumd2Zn3203nFgNF15PVm13W3RcoOkRC1Md8Zc+7q1YqRa3V39M/qFN+zA4gqaYZCzuCoKHJyL6z1ZpLuSbhYAPeL5a4PuvtS2g5UjixPlZpDQMy0PIljaM4izRrQJvpJMZcPBYxGu5I3qT6ZY6kENPlaQV80B8J5a3D1vdhfrryQZij9M18tXUHi/+IhtsIU6MuB3u0lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmJSckmRomMiSiH1fbcoIlYpopdk3TttCntECN/fbvA=;
 b=mrPt+yFSR+WJSuU6M9WEXKvxWRYg0QXOf45wLbXemrbRV7EVuummBC3DkLEUwp1UcRZ+z+K8IvYWtmDfTR5Ip7t0ZwPH0MgD9KM6K7OSv7A3C3bNhgVwnosLjWvxgTzlNfDCHGgsUJXr3wpHPT3aVhigi8B1Sxgzfv2EjbkpCkwqKtTyjj3xReX8vwKhWGJh9nYzwqhY22O8BOaxkDRSqKvYjuuX/ba5/WnbM8onxNpAO2cGRxuXLsD7ek5focoXr6GmyGsQfAWrLnFmdNRoOveqADrC/eW/2vsmaMwrOhDk8kOFp1X3SMl+C3O0/hpyDhFm1bDpFKcYAXXwgyoheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmJSckmRomMiSiH1fbcoIlYpopdk3TttCntECN/fbvA=;
 b=Tcf5b0npuTg6pjVcjryvSYgg6+QkZSFXaU6I3bMWrMtCvq9Px50Zm4p89xmJjUGVNLgt/5JwyjRWSm8bCKLjJcCbxk1b37Xr7rKbuV6tmHuLJKbbW6u+Zp9Nqq9Ai1kpzbklCfazrZtH44G0JfM1JInnsTxUqPFp1jqTMVqKAII=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM6PR01MB4780.prod.exchangelabs.com (2603:10b6:5:6b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.28; Thu, 4 Feb 2021 16:12:17 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 16:12:17 +0000
From:   Eric Tremblay <etremblay@distech-controls.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH v2 1/3] serial: 8250: Handle UART without interrupt on TEMT using em485
Date:   Thu,  4 Feb 2021 11:11:56 -0500
Message-Id: <20210204161158.643-2-etremblay@distech-controls.com>
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
Received: from localhost.localdomain (2607:fa49:6d60:7d00:557e:a58:9777:8e36) by YQBPR01CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 16:12:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 823398d9-5182-4f12-457e-08d8c927a467
X-MS-TrafficTypeDiagnostic: DM6PR01MB4780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR01MB4780F07A56F8D0E39843086895B39@DM6PR01MB4780.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5ZatiavfGHBQacfiUWrvJ6tTJsPs/ozTWSkajliBOVfxS830WJb2X71/gRl8IxdASKFV8udN58i15XC68wVrziGqRid97ReH70JPUkucDsGDT5RugEBPcLp7YsmzNh85z/3XMIA1+sM1CbyoDjChOVIw+0CutZirdpuR0zRuTN9LYRaKmVXt2rCwSs7lDmwTP/KK8V/GMa2bY1ZvE5M051f8WHjfme5vI+CYOS/i8mp/zAKBdevvyosyWyNNAiHPaCyZoEekRWNCE8y/G200k7PC1NVPBIATTJM/ioRVEEsJxSovubZEJFDQWs2xxp7RIvmXcVeSCNvb52xJhBXLeGmAtdwSq8fKXRYSTayvBvKPUU9gmLlp+Gq3Ru0H2wTkak4J8if+L+yyXNCc+QsRMlDi+z9EbW4kpXcO4LlOAtN+92rFf6pp7HHwLx8yVRzK6dB6oyR993ZFnWWmxsX1uQxjPKTtyXq2zgqrNXc3GOqFUy5FaJ0kLSmIuK55RHweZd/rgROfQDdMB7WWOZxROSji+wXkH0wdJu+DvwnHQ35BQmdsrAKomIYrUCqlJZksp8Pw+u7/Bb7OgLuHUMFuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(6506007)(6916009)(316002)(16526019)(478600001)(86362001)(8936002)(83380400001)(66556008)(7416002)(6512007)(2616005)(107886003)(5660300002)(2906002)(36756003)(69590400011)(6666004)(66476007)(66946007)(1076003)(8676002)(186003)(52116002)(6486002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9oBWgJgnmD0dBBxDESPs7/eDwNXHNNzFislncSRw7pMyY1LhRNU7YKxlZzmU?=
 =?us-ascii?Q?dnb7F6Kr+wx1oABWQLJLEkDpfo2RSlDO07zW+QKCgpSZbnZjBLQHrXagQlHB?=
 =?us-ascii?Q?MIOUvFeR8mYwbMBUDZhRScGFlcQq3YF/tcEsEeFEi8QM7bq7iENSX6MYF2uf?=
 =?us-ascii?Q?o51yxVMcbl0D83kkI6Qu49//G+wtSuGnTQF26K2DLlf26Ft0PWw+othEHEku?=
 =?us-ascii?Q?dwL6YTV5JAjlgtPJAz0uTS+jIkqECqyAKcZVS6kJkVZJ7NM/9qBBMxhFOupI?=
 =?us-ascii?Q?6XV0nA1fFxGFkN6PMM5iQ/o/PjTVzvjA4KEn5/gwSP5boTgJ3uxKMK4MuCXf?=
 =?us-ascii?Q?sS+WtwijI0lPFTVJQpjpRC17ObV4jp3MB5ItJDk/mCEteI89+PkAhT1HDvM2?=
 =?us-ascii?Q?xAhmjBnoT6FYK2zm6fpZmm22YILKDd8uYe7jq98MzLr8pb1Mo/vz7/GLByQi?=
 =?us-ascii?Q?+HuRtrlHA5AIjBDn1JrZ6veHyhl2AsdpJDlWGb3aRrhJ7b9bQvfNl5OYdEjT?=
 =?us-ascii?Q?y2sLJ1k5qeUIA/jYr/vqBqMm1lFmDYk50LUK1+XY7MHLmPpqNobZJjFp1T36?=
 =?us-ascii?Q?4tNPr/O9kQ8q1JyBM5+cxNrzdDFvouk/juAWnWwvWLocPbQwqdUHwdDQ4qeb?=
 =?us-ascii?Q?deY5krAvzYv1Xiiopo4kGl3+4+8bgGvCu0az7xqtTlDer+PXiMOzZa9tTC2g?=
 =?us-ascii?Q?Fo/+Ig9yiTr2oQTGb/+tOR81zzWyWKkM/tZXwQUGN6LDz54s6QiLiM5tIiLM?=
 =?us-ascii?Q?Cx/B8Sg9VCPk2TTkuOm/i6zsn5avfhXbfSdSOsQfy+xNuAGcScMN4XShun8N?=
 =?us-ascii?Q?i3VpXc3RFa93A+AXUPbj3BT6s5BTDwGQLjxkcNb4xup6U3/v5g8mopmy77x8?=
 =?us-ascii?Q?GzPPq+HKbEXIxFSNwhhzfm30tTjD/tQZQuSj+lnwmFh1hl20EnUf9PPf00L/?=
 =?us-ascii?Q?pJeap4EKM8kxmmRXqjgph75EvOLS4Q90GQwwd/PWduduqaPrdhxfv7AiQxgu?=
 =?us-ascii?Q?1pcT/bNtg9aJgatTQkEeUMDws8mBZBuT2SkAJuJPToqr5/MW4mkNhEuYR7m5?=
 =?us-ascii?Q?gNQh0P+6mNGvY+Q8XfGwNBnuRKn++Q8f6kVxBd2mnV+KmPY1cQwnHkM9zx/S?=
 =?us-ascii?Q?4BihXoo+S1iKETkfM626wHuZQLSZzCMICPrAumppmep+p4aXclnYynj6t7dT?=
 =?us-ascii?Q?HC8uSMkhhwAr6CMNGqEF+4yHJvy2iiuHXEpeWpCB9WimU4VifrRLDRfHZRn6?=
 =?us-ascii?Q?VFD7lY7iFN92I5QaCdjKGegh2naskCOW9JGkm169zhFJVj/Nxf9u69r+cxuD?=
 =?us-ascii?Q?IYl2XcQxv5Pf3oQcX4bj7+MRr2q798v/NVe1JQ7VLP2WkPxM2aizG1Md+czQ?=
 =?us-ascii?Q?Cb2uOm7mMqAn+VKVszycFNhjCn07?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823398d9-5182-4f12-457e-08d8c927a467
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 16:12:17.4922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4xgxv9gNxE3vijPmGEJROnK7hdWYLedN5X5wqftAX12GDjp/7rhewPyBG5UQHZxzcGsLYSjERHvyS+qf9lDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4780
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=669 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040101
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The patch introduce the UART_CAP_NOTEMT capability. The capability
indicate that the UART doesn't have an interrupt available on TEMT.

In the case where the device does not support it, we calculate the
maximum time it could take for the transmitter to empty the
shift register. When we get in the situation where we get the
THRE interrupt, we check if the TEMT bit is set. If it's not, we start
the a timer and recall __stop_tx() after the delay.

The transmit sequence is a bit modified when the capability is set. The
new timer is used between the last interrupt(THRE) and a potential
stop_tx timer.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
[moved to use added UART_CAP_TEMT]
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
[moved to use added UART_CAP_NOTEMT, improve timeout]
Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
---
 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_port.c | 66 ++++++++++++++++++++++++++++-
 drivers/tty/serial/serial_core.c    | 29 +++++++++----
 include/linux/serial_8250.h         |  2 +
 include/linux/serial_core.h         |  2 +
 5 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 52bb21205bb6..6bb6b7321cfc 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -82,6 +82,7 @@ struct serial8250_config {
 #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
+#define UART_CAP_NOTEMT	(1 << 18)	/* UART without interrupt on TEMT available*/
 
 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b0af13074cd3..00c2cb64e8a7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -558,8 +558,21 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
 	}
 }
 
+static inline void serial8250_em485_update_temt_delay(struct uart_8250_port *p,
+			unsigned int cflag, unsigned int baud)
+{
+	unsigned int bits;
+
+	if (!p->em485)
+		return;
+
+	bits = uart_get_byte_size(cflag);
+	p->em485->no_temt_delay = bits * NSEC_PER_SEC / baud;
+}
+
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
+static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t);
 
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
 {
@@ -618,6 +631,16 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 		     HRTIMER_MODE_REL);
 	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
+
+	if (p->capabilities & UART_CAP_NOTEMT) {
+		struct tty_struct *tty = p->port.state->port.tty;
+
+		serial8250_em485_update_temt_delay(p, tty->termios.c_cflag,
+						   tty_get_baud_rate(tty));
+		hrtimer_init(&p->em485->no_temt_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		p->em485->no_temt_timer.function = &serial8250_em485_handle_no_temt;
+	}
+
 	p->em485->stop_tx_timer.function = &serial8250_em485_handle_stop_tx;
 	p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
 	p->em485->port = p;
@@ -649,6 +672,7 @@ void serial8250_em485_destroy(struct uart_8250_port *p)
 
 	hrtimer_cancel(&p->em485->start_tx_timer);
 	hrtimer_cancel(&p->em485->stop_tx_timer);
+	hrtimer_cancel(&p->em485->no_temt_timer);
 
 	kfree(p->em485);
 	p->em485 = NULL;
@@ -1494,6 +1518,11 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
 	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
 }
 
+static void start_hrtimer_ns(struct hrtimer *hrt, unsigned long nsec)
+{
+	hrtimer_start(hrt, ns_to_ktime(nsec), HRTIMER_MODE_REL);
+}
+
 static void __stop_tx_rs485(struct uart_8250_port *p)
 {
 	struct uart_8250_em485 *em485 = p->em485;
@@ -1531,8 +1560,19 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		 * shift register are empty. It is for device driver to enable
 		 * interrupt on TEMT.
 		 */
-		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
+		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
+			if (!(p->capabilities & UART_CAP_NOTEMT))
+				return;
+
+			/*
+			 * On devices with no TEMT interrupt available, start
+			 * a timer for a byte time. The timer will recall
+			 * __stop_tx().
+			 */
+			em485->active_timer = &em485->no_temt_timer;
+			start_hrtimer_ns(&em485->no_temt_timer, em485->no_temt_delay);
 			return;
+		}
 
 		__stop_tx_rs485(p);
 	}
@@ -1631,6 +1671,27 @@ static inline void start_tx_rs485(struct uart_port *port)
 	__start_tx(port);
 }
 
+static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t)
+{
+	struct uart_8250_em485 *em485;
+	struct uart_8250_port *p;
+	unsigned long flags;
+
+	em485 = container_of(t, struct uart_8250_em485, no_temt_timer);
+	p = em485->port;
+
+	serial8250_rpm_get(p);
+	spin_lock_irqsave(&p->port.lock, flags);
+	if (em485->active_timer == &em485->no_temt_timer) {
+		__stop_tx(p);
+		em485->active_timer = NULL;
+	}
+
+	spin_unlock_irqrestore(&p->port.lock, flags);
+	serial8250_rpm_put(p);
+	return HRTIMER_NORESTART;
+}
+
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
 {
 	struct uart_8250_em485 *em485;
@@ -2792,6 +2853,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial8250_set_divisor(port, baud, quot, frac);
 
+	if (up->capabilities & UART_CAP_NOTEMT)
+		serial8250_em485_update_temt_delay(up, termios->c_cflag, baud);
+
 	/*
 	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
 	 * is written without DLAB set, this mode will be disabled.
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 828f9ad1be49..8aab9384e6b4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -322,17 +322,12 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 }
 
 /**
- *	uart_update_timeout - update per-port FIFO timeout.
- *	@port:  uart_port structure describing the port
+ *	uart_get_byte_size
  *	@cflag: termios cflag value
- *	@baud:  speed of the port
  *
- *	Set the port FIFO timeout value.  The @cflag value should
- *	reflect the actual hardware settings.
+ * Get the size of a byte in bits.
  */
-void
-uart_update_timeout(struct uart_port *port, unsigned int cflag,
-		    unsigned int baud)
+unsigned int uart_get_byte_size(unsigned int cflag)
 {
 	unsigned int bits;
 
@@ -357,6 +352,24 @@ uart_update_timeout(struct uart_port *port, unsigned int cflag,
 	if (cflag & PARENB)
 		bits++;
 
+	return bits;
+}
+
+/**
+ *	uart_update_timeout - update per-port FIFO timeout.
+ *	@port:  uart_port structure describing the port
+ *	@cflag: termios cflag value
+ *	@baud:  speed of the port
+ *
+ *	Set the port FIFO timeout value.  The @cflag value should
+ *	reflect the actual hardware settings.
+ */
+void
+uart_update_timeout(struct uart_port *port, unsigned int cflag,
+		    unsigned int baud)
+{
+	unsigned int bits = uart_get_byte_size(cflag);
+
 	/*
 	 * The total number of bits to be transmitted in the fifo.
 	 */
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 9e655055112d..ec8682e8c19e 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -79,7 +79,9 @@ struct uart_8250_ops {
 struct uart_8250_em485 {
 	struct hrtimer		start_tx_timer; /* "rs485 start tx" timer */
 	struct hrtimer		stop_tx_timer;  /* "rs485 stop tx" timer */
+	struct hrtimer		no_temt_timer;  /* "rs485 no TEMT interrupt" timer */
 	struct hrtimer		*active_timer;  /* pointer to active timer */
+	unsigned long		no_temt_delay;  /* Delay for no_temt_timer */
 	struct uart_8250_port	*port;          /* for hrtimer callbacks */
 	unsigned int		tx_stopped:1;	/* tx is currently stopped */
 };
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index e1b684e33841..ecc0bbf5135e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -332,6 +332,8 @@ unsigned int uart_get_baud_rate(struct uart_port *port, struct ktermios *termios
 				unsigned int max);
 unsigned int uart_get_divisor(struct uart_port *port, unsigned int baud);
 
+unsigned int uart_get_byte_size(unsigned int cflag);
+
 /* Base timer interval for polling */
 static inline int uart_poll_timeout(struct uart_port *port)
 {
-- 
2.17.1

