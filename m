Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2361FC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 28 Jan 2021 23:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71A764E0C
	for <linux-serial@archiver.kernel.org>; Thu, 28 Jan 2021 23:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhA1XoE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Jan 2021 18:44:04 -0500
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:22230 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhA1Xnx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Jan 2021 18:43:53 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 18:43:49 EST
Received: from pps.filterd (m0118796.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10SNHr0D029085;
        Thu, 28 Jan 2021 18:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 cc : subject : date : message-id : in-reply-to : references : content-type
 : mime-version; s=pps-02182019;
 bh=1ukTAR/u9cC3c7otFBxUkVU6GnwnWIwFe4W+OKWo+sY=;
 b=mT8B0gKAghpVQzWvJNv4Io44WhA9Ab1YGjCavY4GdBK9EfuVKuLrNvU2Asnp32p830N6
 KAL1KUqug7MiWCtt2cDcYyeNSbAnmxsZdlyuuMJhBbiFyt/GemabGHXyoD9U8aIbtGwH
 hdLO/eNkd0k3Kr7D5OPjkGdOUKmHc//+pxaGxnfIGlGOAy5EFZ1AwM5t8veflV/Duvs0
 ffs5AnX4/nRCId/uOD7QbPjVqKOtstS1MabqnVNFheGOuT44hzeyIhRqnYgcyMEBwy2Q
 dbvkVBrFj5hc6LiSgEA2cL7XmqyxQIaxQf0AInLZGKr041HYX2BJREe4uXkvY71k3s2L 5A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0b-002ab301.pphosted.com with ESMTP id 36bwt7gkuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 18:37:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn5KclPCGbBGv2nOaZZqYmC2KYYNPXbJDDI+u71fJO1VoKdZZVwppdeGcLEhg01lXhqPh1pOBPMAm3vaNfKdmzAM9fjG2K4c7xrX3YLJ4LsW2VqftuML7nKXNCELcDhk/11xCaxkk3Pyxv7/ahvDAvwAM0G9HD+FHFnj1nBw5tPM7xNZcnpUj96nusfAm05KAXwrJkr694la4Jsiu70Ka3KkqJkKwHdDcfmD/MJcuoD3S/XXZkrZvBM6ouZ5F643HoO+a9GlGgMBSuYju5apS5GCi79Ogu5UZEMu7N/Pbj7PZ8AC+t82wjgEtoOudm7GK9yH8n7CtG4H/ZwfynTXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ukTAR/u9cC3c7otFBxUkVU6GnwnWIwFe4W+OKWo+sY=;
 b=LCnM9nS08TuCqjJt0JLYhX3Tb444sQpREuXIKfZ+buwfdpdogbfjd3tWScrP1i6TSt/Rdy7LL2TAtZBzjZwisfB2ZM8m+Uo8nq5PQORqyBMIVjF+O3pmiMsS8iJZGft69DuAjnN9VQmGAQK4mGKqMwL9X/R2dmEG4WU6+LE0stLazRfhopkwSv9baGqLHGSXmAYqhLkHXy6C3NpzbwSsPjMQ5DBMLV0aN2bvTD5EaOC4+ctbKcXtvXuSGD2LSuOHm3JfS6oKRVu55KdZwX/BLLy+E0LP2rkC4po8lnxxouxv9B6yfqiSAzIqq2H8N9IxHx007+r/NafR9+OGYoUB7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ukTAR/u9cC3c7otFBxUkVU6GnwnWIwFe4W+OKWo+sY=;
 b=URSUjsMZWCQZl/QlGG8x6mcEplWuZbNDtH2/Vcj7yp5kA8TFWoVxCCcTr8+XvAhv/ZHClGA+bZzZwv11gkHaymfwD4a0zJOUo+gf5TNu17E8K1mvORuBjCej1ig/uQvix4xUcC000IfQx/Kt/8kuHqZKh8GVMV2JWSWJvhbjBNg=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM5PR0101MB2908.prod.exchangelabs.com (2603:10b6:4:2c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.19; Thu, 28 Jan 2021 23:37:05 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.016; Thu, 28 Jan
 2021 23:37:05 +0000
From:   Eric Tremblay <etremblay@distech-controls.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com,
        Eric Tremblay <etremblay@distech-controls.com>
Subject: [PATCH 1/3] serial: 8250: Handle UART without interrupt on TEMT using em485
Date:   Thu, 28 Jan 2021 18:36:27 -0500
Message-Id: <20210128233629.4164-2-etremblay@distech-controls.com>
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
Received: from localhost.localdomain (2607:fa49:6d60:7d00:a56e:4209:76ad:3739) by QB1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Thu, 28 Jan 2021 23:37:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8def888-257e-4251-f965-08d8c3e59efe
X-MS-TrafficTypeDiagnostic: DM5PR0101MB2908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR0101MB2908A802F4452795EE2E89C395BA9@DM5PR0101MB2908.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0znqL6s8vRiEmkNaIYo2e7BauRa8Ju6MJu3il1CtAmU4sBi4eMWEHcFjxR4PgsJ0G7OvNz0ZsP/fkvnrI0GVTaocxNpdS/mWte4vPawszQzW2oYOURnigRZXarsvgL63dMiQdNqcZU31KaekqMbEy46r8RA7rhFrzvxK+vq6Mh+QtdQHv1GoMWSLc5XXBdwJKwFLzN7ZUX/HNN99QrD8kdYxxw0bjnNe8s3dxmYM2sLG3cEo5ymGNbsWNl93B9a/r6SkY0TSrrmV4KoNPiVEd4SF3UgJMCXX0OV93UOVYHUMN4OTJMDjQ0CRaVRPSrFH/vqFRdKXkoEa+Qt/ckNKp8vyg/22feleh8iqIsmY86U9u6YQTogSmjmIBc2oAS3mvJjS4Emg9ydO8Dvca6lESzjJGdqfHiQjA72bEJ7dZsDvtg068uzI/cpFaK8SagepVra12mzDhw5ri1/xfzYQwT1NLYz++7lSo7DfDzbadTPbBV3GyI2kvVK/r3TsoQTCbq9VP8FAmu9vhyYVlcuehg9J8wnTvpCafKHF/wf5pb43BScqcrKJ/N9n5JdNzk/YS+W9V7zQZNriIie6t8KoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(16526019)(6486002)(5660300002)(2906002)(186003)(7416002)(8676002)(52116002)(6506007)(86362001)(36756003)(2616005)(8936002)(66556008)(6666004)(66946007)(69590400011)(66476007)(107886003)(83380400001)(6512007)(4326008)(478600001)(1076003)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ps70xhDV1wThETlTQ++YXW2eVTisApa6OYswv79198/zFt6djtVOocCjrxfL?=
 =?us-ascii?Q?vqR7gi3ppY3RH7yN7jUlG/b4/RVFdjHjQbUWtZYkCMEWO8Wkxt0oAo42/IQl?=
 =?us-ascii?Q?bZP6oN2pcWe+lu/lLCt0Co5viyLhkAeOu9OdimMblISCM/jmB4V4eW61V/lF?=
 =?us-ascii?Q?KFsRaYhu+HjIJ+qOjJqS714qZgYuyiFvhH+DV06CDa8KO8bGxfD2DZn+E2Bk?=
 =?us-ascii?Q?YpwRyOTIrFUippBm8pDov4KwjA1HxNGc3aWU+uUdVdwSGybA8AfUE8Gn55i0?=
 =?us-ascii?Q?I4+p/2LlA0wK65kSs5QNLRViP6Dd+btOKvdU2143zczyS1ne+NAk/reCiw2b?=
 =?us-ascii?Q?cRY8SNCXWpuPw1xdhOYiPCgi3eTSgDykiSoWrRjjCqfaOg4EFXfFiBLrz8w3?=
 =?us-ascii?Q?YKcnJsbJUUN10dF8RV2FEuXtVF691S+FaFJpax+TPYHhFBeySeG2NUbghIuU?=
 =?us-ascii?Q?pHnlmBpPUYBrL42fWwUAyiXckabnAashYtWXWPkSkZ/VD9HvWweJNaOsYcx4?=
 =?us-ascii?Q?1ooV5I2e30o+JL+vmuNlhjdBz3ELatGd/kOaxzXeTuiM+PSAM5qd/RR1akre?=
 =?us-ascii?Q?NP7jjrBiNfhZuGy1ZdMCyIEJcRRej44ZlmZQ+KgKzH8X2lQZLe3l5u+u3cu5?=
 =?us-ascii?Q?p14aVc9samKS2b1lyzJYIekfcZdr/u0mS6MNkAoBeZxi7WuEJc+K/xcT47dd?=
 =?us-ascii?Q?qQcLOmG7zszyGUNF2qcDSavZzZ3VSmKS/veWhFuXBZgkh5caq0ExjSdqyUfz?=
 =?us-ascii?Q?Lzw+1mreym5hvkrR4i/azox8Wo0OQ2AiJlwckXtEEcDpSDcmt7B88Y2LO+LA?=
 =?us-ascii?Q?as4gdU6GhlH2s5RpbNzGKn737Aheb+xroAGlUVk3nSZkmOYJ6cV5lmiWTmr0?=
 =?us-ascii?Q?p/Yga2KUdI15bbRCFn7ZpuGqYuZDPKIsLS3d4qFdlg07HjKRe2KpuMH9XjK5?=
 =?us-ascii?Q?1L8P0yx7dNufaXIe4qFJO6R3R18cuhsKPJHnR+YU/PuhSm9eodPyBthbTmyz?=
 =?us-ascii?Q?YqqpSiJlTWg6GJl8xSqVjaFIrX7NoA6wYK+Su/5Cxojz8UeeOw/xN1VC9fYp?=
 =?us-ascii?Q?zJ1ucE0LdMSzSfp7RRiTveO7ZP85KbK4pk8qFMik90NsvHjIbYw82FPR4bJt?=
 =?us-ascii?Q?UT24HNJQrr3e?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8def888-257e-4251-f965-08d8c3e59efe
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 23:37:05.6371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqeM19zdpsc/czgUwDqLsXKqVzp7XXxGotYWOkpbTOE5VN1e6klKhUypXRV23yhqNZjbH5l1VUVh6fz8VhoFFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0101MB2908
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=931
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280112
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The patch introduce the UART_CAP_TEMT capability which is by default
assigned to all 8250 UART since the code assume that device has the
interrupt on TEMT

In the case where the device does not support it, we calculate the
maximum of time it could take for the transmitter to empty the
shift register. When we get in the situation where we get the
THRE interrupt but the TEMT bit is not set we start the timer
and recall __stop_tx after the delay

Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
---
 drivers/tty/serial/8250/8250.h            |  1 +
 drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
 drivers/tty/serial/8250/8250_omap.c       |  2 +-
 drivers/tty/serial/8250/8250_port.c       | 89 ++++++++++++++++++++++-
 include/linux/serial_8250.h               |  2 +
 5 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 52bb21205bb6..5361b761eed7 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -82,6 +82,7 @@ struct serial8250_config {
 #define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
+#define UART_CAP_TEMT	(1 << 18)	/* UART have interrupt on TEMT */
 
 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index fd95860cd661..354faebce885 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -91,7 +91,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* initialize data */
-	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
+	data->uart.capabilities = UART_CAP_FIFO | UART_CAP_MINI | UART_CAP_TEMT;
 	up.port.dev = &pdev->dev;
 	up.port.regshift = 2;
 	up.port.type = PORT_16550;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 23e0decde33e..1c21ac68ff37 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1294,7 +1294,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.regshift = 2;
 	up.port.fifosize = 64;
 	up.tx_loadsz = 64;
-	up.capabilities = UART_CAP_FIFO;
+	up.capabilities = UART_CAP_FIFO | UART_CAP_TEMT;
 #ifdef CONFIG_PM
 	/*
 	 * Runtime PM is mostly transparent. However to do it right we need to a
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b0af13074cd3..44a54406e4b4 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -558,8 +558,41 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
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
+	/* byte size and parity */
+	switch (cflag & CSIZE) {
+	case CS5:
+		bits = 7;
+		break;
+	case CS6:
+		bits = 8;
+		break;
+	case CS7:
+		bits = 9;
+		break;
+	default:
+		bits = 10;
+		break; /* CS8 */
+	}
+
+	if (cflag & CSTOPB)
+		bits++;
+	if (cflag & PARENB)
+		bits++;
+
+	p->em485->no_temt_delay = bits*1000000/baud;
+}
+
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
+static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t);
 
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
 {
@@ -618,6 +651,18 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 		     HRTIMER_MODE_REL);
 	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
+
+	if (!(p->capabilities & UART_CAP_TEMT)) {
+		struct tty_struct *tty = p->port.state->port.tty;
+
+		serial8250_em485_update_temt_delay(p, tty->termios.c_cflag,
+						   tty_get_baud_rate(tty));
+		hrtimer_init(&p->em485->no_temt_timer, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL);
+		p->em485->no_temt_timer.function =
+			&serial8250_em485_handle_no_temt;
+	}
+
 	p->em485->stop_tx_timer.function = &serial8250_em485_handle_stop_tx;
 	p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
 	p->em485->port = p;
@@ -649,6 +694,7 @@ void serial8250_em485_destroy(struct uart_8250_port *p)
 
 	hrtimer_cancel(&p->em485->start_tx_timer);
 	hrtimer_cancel(&p->em485->stop_tx_timer);
+	hrtimer_cancel(&p->em485->no_temt_timer);
 
 	kfree(p->em485);
 	p->em485 = NULL;
@@ -1494,6 +1540,15 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
 	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
 }
 
+static void start_hrtimer_us(struct hrtimer *hrt, unsigned long usec)
+{
+	long sec = usec / 1000000;
+	long nsec = (usec % 1000000) * 1000;
+	ktime_t t = ktime_set(sec, nsec);
+
+	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
+}
+
 static void __stop_tx_rs485(struct uart_8250_port *p)
 {
 	struct uart_8250_em485 *em485 = p->em485;
@@ -1531,8 +1586,18 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		 * shift register are empty. It is for device driver to enable
 		 * interrupt on TEMT.
 		 */
-		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
+		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
+			/*
+			 * On devices with no interrupt on TEMT available
+			 * start a timer for a byte time, the timer will recall
+			 * __stop_tx
+			 */
+			if (!(p->capabilities & UART_CAP_TEMT) && (lsr & UART_LSR_THRE)) {
+				em485->active_timer = &em485->no_temt_timer;
+				start_hrtimer_us(&em485->no_temt_timer, em485->no_temt_delay);
+			}
 			return;
+		}
 
 		__stop_tx_rs485(p);
 	}
@@ -1631,6 +1696,25 @@ static inline void start_tx_rs485(struct uart_port *port)
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
+	if (em485->active_timer == &em485->no_temt_timer)
+		__stop_tx(p);
+
+	spin_unlock_irqrestore(&p->port.lock, flags);
+	serial8250_rpm_put(p);
+	return HRTIMER_NORESTART;
+}
+
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
 {
 	struct uart_8250_em485 *em485;
@@ -2792,6 +2876,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial8250_set_divisor(port, baud, quot, frac);
 
+	if (!(up->capabilities & UART_CAP_TEMT))
+		serial8250_em485_update_temt_delay(up, termios->c_cflag, baud);
+
 	/*
 	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
 	 * is written without DLAB set, this mode will be disabled.
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 9e655055112d..d2c66faff0dd 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -79,7 +79,9 @@ struct uart_8250_ops {
 struct uart_8250_em485 {
 	struct hrtimer		start_tx_timer; /* "rs485 start tx" timer */
 	struct hrtimer		stop_tx_timer;  /* "rs485 stop tx" timer */
+	struct hrtimer		no_temt_timer;  /* "rs485 no tempt interrupt" timer */
 	struct hrtimer		*active_timer;  /* pointer to active timer */
+	unsigned int		no_temt_delay;  /* Value of delay for no TEMT UART */
 	struct uart_8250_port	*port;          /* for hrtimer callbacks */
 	unsigned int		tx_stopped:1;	/* tx is currently stopped */
 };
-- 
2.17.1

