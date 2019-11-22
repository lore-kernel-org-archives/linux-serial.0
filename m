Return-Path: <SRS0=aNI9=ZO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1102C432C0
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 10:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7830B20707
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 10:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WKgwvFXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfKVKCN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:02:13 -0500
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:35485
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbfKVKCM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 05:02:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4DQqhGJTKq5D88NxDFEFhCz/WXrnJquypSQe4aIpcvXcCZdMv/gbh/SoXxceKcGCACNand53DW0Dfv0UiE7lkTFokeBBMQFFy45ybH+ulb2skaDdtJNNFGZm+/U2L50eEArWwLW/mGYtHVVFlNWsrOUR40wxvhQU/5iN0xbsY9yO1oJs6udbX3duln2qYiJppK0mJsOlzHf/jcNHShi3Gtn78ec3N0uCiWawmX5gxRJ6orMxj6xs1pinzHfTH3rlnqXjYKiVVPGOBFRLM9IG7Z2TxshOC6FCfJoBxN96IjhAQ4TNEHX7rU1n7ZvwX4TT5x54XN/HBPyVywK76VrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKJcD36E7HwRdMTCg0LqWCnV+sqQJ2rbu4EE7tRvYm0=;
 b=QNx0T+TP+cL7Vh71VBAWsOLicJJKW6bJShYwtY+lD90UYS6wYYV46x54r1IQjfncJATwlD8viJPmfoXqusvsR+XT0leZRBxSqFFM3WQA/RD/LyxaSWlUdqC0Gc023mmJDGzw8sozKmNco4kvMWIdzn+FKQhpSyhRXt0fwOhJKLbRTFsmHfr0yf45XQZlP2CBN5rjqRKfp1oh5oB+pIrft4Vh+NIokJsBgf0MM9Uxfvno5B8NAio8M2ia5I8foVH7uB1mICrOAaClexwZ5ir2f1SV2lUy4UhCJEISMgW/olKz3QaDdfLlePCft/uCASAtV5b8oyIgmQ/mcmn4v3Ng3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKJcD36E7HwRdMTCg0LqWCnV+sqQJ2rbu4EE7tRvYm0=;
 b=WKgwvFXd1NqPYLcGaE6kQY4O9oxBQ1WTnJaymUnXMCvzumTZNTKvy87rVb+wHURrP2pUsoBcEfUzXgHw0FJctLarCv2fR+EFAAH/zqvbXg+4AAmY4DQdCGPFTtS5Ux5pISq/7w6W3+MFwxE4bRuuPJGKAOJiZE7UZDeuFWrISM8=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB3581.eurprd04.prod.outlook.com (52.134.1.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 10:02:06 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::30e0:6638:e97c:e625]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::30e0:6638:e97c:e625%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 10:02:06 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        Andy Duan <fugang.duan@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: [PATCH tty/serial 1/1] tty: serial: lpuart: fix the sysrq lockdep
 issue
Thread-Topic: [PATCH tty/serial 1/1] tty: serial: lpuart: fix the sysrq
 lockdep issue
Thread-Index: AQHVoRvlFD1B/nANU0Kz1ZuGJ7KeHA==
Date:   Fri, 22 Nov 2019 10:02:06 +0000
Message-ID: <1574416704-32428-1-git-send-email-fugang.duan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0220.apcprd02.prod.outlook.com
 (2603:1096:201:20::32) To VI1PR0402MB3600.eurprd04.prod.outlook.com
 (2603:10a6:803:7::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4cf684c8-64f6-4ea1-928c-08d76f330801
x-ms-traffictypediagnostic: VI1PR0402MB3581:|VI1PR0402MB3581:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB35815FA27D61314FCECC52DAFF490@VI1PR0402MB3581.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:364;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(199004)(189003)(186003)(66066001)(25786009)(7736002)(305945005)(99286004)(2351001)(3846002)(6116002)(6486002)(2906002)(6506007)(386003)(6512007)(6436002)(5640700003)(26005)(86362001)(4326008)(2501003)(36756003)(14444005)(256004)(102836004)(81166006)(81156014)(1730700003)(8676002)(8936002)(50226002)(478600001)(2616005)(14454004)(316002)(66446008)(64756008)(66556008)(66476007)(5660300002)(66946007)(71200400001)(71190400001)(52116002)(6916009)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3581;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZKI9ggZjtSwL9bI57YSfCYvRzkmPFvPl47MkHu20zDrqdjqegJYexnfGV0?=
 =?iso-8859-1?Q?AYZyUe1yAEuic2At5EpBtegnjzQp0gnIIpWY3hHM68WVds+ge8oCwM6xIS?=
 =?iso-8859-1?Q?xcN5qPXW3RuuqZszdO4lGvs5G7p/2jMaQYZDLT/HEKke4H/A8oxPsUSzxN?=
 =?iso-8859-1?Q?HS+0ceo0N3xi6kRBOs3GNHVGHuhYUz4p4bugXGFLYCZGib8NPV8MgrRRNY?=
 =?iso-8859-1?Q?UCW2vOP8CGyKWnMToJfYK32Jui4WD90sQXLlmnIIFf8CokslCzlRywRSAL?=
 =?iso-8859-1?Q?J+sHcDv51WognkaPgoYDLcWmtC8l/kfaTXtND283hpfVQCkzNtJTipzZjx?=
 =?iso-8859-1?Q?LsEhoZK9VA/bZktzPu5CBT2lut28UPR0/NTruA8em6XZ9Nulte2x56k5+y?=
 =?iso-8859-1?Q?wpu38AMN48t7bvGApc714NxWEQpZbHtl1pKaREYVuFpBMn6brD9CpEpMU1?=
 =?iso-8859-1?Q?NXk9gUJtgYH8ggnws6poKWycYfN1YK26m0e8buGgC6v9kyU3Su/p4Mvcuj?=
 =?iso-8859-1?Q?P2ZgRe4l4e9iPdGF3wVzShmdaTAfwhOjeFmNYO3rTNMjs0WrFUCI7fJ32f?=
 =?iso-8859-1?Q?P1pAb0AjvKtifrIbAjmrm5CY+gcaV86Rfc3Z/7JoOsdW8u9olKG0wuXecH?=
 =?iso-8859-1?Q?U5gCyUKTFV44GuziaADXTOuBxuZJNFqUnTxa+esNYyGEcrAWyr27ugKhaM?=
 =?iso-8859-1?Q?oX/wo+SCQWfF9x9JKpZlJDFy/JKS86lN3dJYYmQJtPVIDv7emUCgSm54Am?=
 =?iso-8859-1?Q?IaiZ8jDRPROMpLJgp+s9Y28B5uM7JjWbqbduj6BbyNhnTTAnAURn9YNeQU?=
 =?iso-8859-1?Q?7H4VQ2t09wMXaeokFHDbPtkxcuhfWGlTNKDkE7l5c6pzQS/n8dnAvF7UHI?=
 =?iso-8859-1?Q?+enzInhQOZP+lgVqWpF///DKFbYNFAEEoxwHjjuJimPd5gBfffnFJNJU+v?=
 =?iso-8859-1?Q?5r48N3d9WbZwPbWFWaVO42ffMuWAk8KLQp5/kiZk25hvbdayjTFlvNkmS1?=
 =?iso-8859-1?Q?UGGohYaq0z6EkH82vr/bImkMItyW9+DAeaB/134yjPZ6A2qcb+aD5frjVL?=
 =?iso-8859-1?Q?ulH+HIwuB9jCtEFEDbjBeeOPec9oE8RASU27DEtDj8RQlxGP6L1G/qOvE1?=
 =?iso-8859-1?Q?c0OGU/yBaAt6yIYPIQGKWYvQ2Qpwt/fa73J5qRr3vQHYgnKhoaWZs+4U/J?=
 =?iso-8859-1?Q?udJZv8UoxbIIEDNM2L9J9yb7X5BKsYGDbJeXKooz73+P2lG+cZggi5b3gw?=
 =?iso-8859-1?Q?xPyDHXYST455TsBDhGv7mGDpgzU4284DcRudzkBukV4DuF9eillzfsk9Qn?=
 =?iso-8859-1?Q?zgb8ptqq3s8Ov+q6cp7a4pFjAAnIPxYgENA8Gxzsd/x0ECkoZMoCBxpHc3?=
 =?iso-8859-1?Q?tulWMRy5QIPrmkch32oGKlW39ynGRMHRQRis9lOI8AcXDOHE7jQbw6n94l?=
 =?iso-8859-1?Q?rOo38YsdHTpGybPwJzqLaR8p+20Wrd632I/hfXkA0IpE6mFN1Lofniw6ug?=
 =?iso-8859-1?Q?DCCYo7kXK1aCLT+pBHxpz0E0t5o+bSPThOJX6o2/1camN7XBCR//MokD9V?=
 =?iso-8859-1?Q?hHCBS/vIMNbxxQ6a3manGTVX7toeu7iXr5kz0DtiiHSr57Fi8rEd5htRAt?=
 =?iso-8859-1?Q?KuAF4djmuSjHvV9moacfEOmnwVYTC4tLpZXjqadojfPtgmrWhWlYyis0zm?=
 =?iso-8859-1?Q?qPuYeCO1wDxygVHnmYHgWftMQk6NcztlQU85PA0LQQFZYLTTeqEe9Ack2S?=
 =?iso-8859-1?Q?DGyLlh2Kg8S7yq2MSaEegk79E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf684c8-64f6-4ea1-928c-08d76f330801
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 10:02:06.6559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7EZGiEBVAa9q35ZPMI1YGqMeKCkVfNftZjRHPDF7iQh93x0SMdbjwsrbTRqRGWfnyk6Z7Tmg0phKjkp4e+aiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3581
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

commit dbdda842fe96 ("printk: Add console owner and waiter logic to
load balance console writes") introduces the lockdep issue for lpuart
serial driver in sysrq case:

     CPU0                    CPU1
     ----                    ----
lock(&port_lock_key);
                             lock(console_owner);
                             lock(&port_lock_key);
lock(console_owner);

It should unlock port_lock_key in handle_sysrq().

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 4e128d1..2ddb777 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -836,7 +836,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
 		sr =3D readb(sport->port.membase + UARTSR1);
 		rx =3D readb(sport->port.membase + UARTDR);
=20
-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+		if (uart_prepare_sysrq_char(&sport->port, (unsigned char)rx))
 			continue;
=20
 		if (sr & (UARTSR1_PE | UARTSR1_OR | UARTSR1_FE)) {
@@ -884,7 +884,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
 		writeb(UARTSFIFO_RXOF, sport->port.membase + UARTSFIFO);
 	}
=20
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_unlock_and_check_sysrq(&sport->port, flags);
=20
 	tty_flip_buffer_push(port);
 }
@@ -918,7 +918,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 		rx =3D lpuart32_read(&sport->port, UARTDATA);
 		rx &=3D 0x3ff;
=20
-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+		if (uart_prepare_sysrq_char(&sport->port, (unsigned char)rx))
 			continue;
=20
 		if (sr & (UARTSTAT_PE | UARTSTAT_OR | UARTSTAT_FE)) {
@@ -955,7 +955,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 	}
=20
 out:
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_unlock_and_check_sysrq(&sport->port, flags);
=20
 	tty_flip_buffer_push(port);
 }
--=20
2.7.4

