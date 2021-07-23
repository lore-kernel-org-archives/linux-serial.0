Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B00C4320A
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B18260F25
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 22:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhGWVvq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:51:46 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:51343
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232301AbhGWVvq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 17:51:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh+aysgwIfh147GyDHvLdjaKtmk94uME0Cao3xbXsCOuLH0ghuop9+OXf0yOnQZL7Sy2MkoIX6WfxnpxS0WYBPcG7G5+6oUQuDjp/EY7v3oncQ03Nts4HVKFaUDJPGjQFzSoZibLFXREx7Y6E1MBlrwdtxoAALtk6zaG2TPhdXAm1ZT+RK/wDQMpky9Q59KgXg/Ctc8EwnOGKDqFls9hIjl9HUDrge/YEg78rnlQuyobeTpPjJc0GDErsRon1R9sN6CtRdfy3t73muu/aiM8CkrJvjg9518TLAsuKzpV1o+JQw/5/SiBRwElnD/IT++xbyIZibwS45Fstszd5JTduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtu5cragWjS+0rol8msqzz9d6l18kgzG1WAxZSpmIlQ=;
 b=nmTcOzV6RU24jRIS65ySd8k5a8VIQRxlM7B2c3UuJgRn8+vLfIbGoJDGyYAVgglg/n9p3vT6vxE7WOBo+fZs2QcwAuF8m0lUEm6O+dPQ0GRG01uATdFsTlVWQFv/z96CvoAMrUOaCtvLVl9yoChTjyp03eAYTI8fZYnWCNdUZN7v997hpjmjCM5QzjIMcRjKJk18oH07EuFIBfi6dSfuc/yiIx7Y35cqmUWIkmatcmJOSOm2iUXjBx36lXeiYqUFUwSfe4oTZdfGLNZQE6l9vGwkljBryO0HI520Gm2aQZ/V09nkutiYqI9ltvdxKsz18KFua2dN7p45uDMdsx3Bnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtu5cragWjS+0rol8msqzz9d6l18kgzG1WAxZSpmIlQ=;
 b=Drk+bgArGU8mM2wSoz/wcm09jalRW3SeF9QY/QJWHIdBdaF9wlpQiKBs+OGoh7T96ifBa5wB4sVCpL+sqG7VXpUDd7fb9+G/C50OJoPkI/jex84YASWDK7VQRf2a6s7mVfc+Nv7cM7NNJ0Icl+gnjbkYGUA2jhxi3SrflzJa46E=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7068.eurprd03.prod.outlook.com (2603:10a6:10:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Fri, 23 Jul
 2021 22:32:08 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.025; Fri, 23 Jul 2021
 22:32:08 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 5/5] tty: serial: uartlite: Prevent changing fixed parameters
Date:   Fri, 23 Jul 2021 18:31:51 -0400
Message-Id: <20210723223152.648326-6-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723223152.648326-1-sean.anderson@seco.com>
References: <20210723223152.648326-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::32) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 22:32:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d743082a-28cf-475d-d604-08d94e29b4cc
X-MS-TrafficTypeDiagnostic: DBBPR03MB7068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB7068FAEA9E42E69CA33DC76A96E59@DBBPR03MB7068.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oj07zPLqw5H+rMZaPc4d9FVQTOgxy5vl/w5p37BOL81aS/q3iR231MGf0o4dObRA6kN11/wzeWF/9nkMJDZD6kfpjs7WwpSLIlsa5kf1R11JxAAcch4YqlPmI2Pg9AA0G6G6YgIyis4SYpx7lEZ9Znq919i7wU6HGUrhVSGmSxPwsJHRWZY36MIy5EISYHVTBOe+HU1HOY8sI/vU4X3AZl3SQj6SI2VBZH7eya9fkEjUhn4lgagpQ5b5CGl8MvAY6+FtBrRmHfC/fJ5e0Ida1HGbKjDSdXIzMsRzmI8ceJGgRLLoJXVv+33o/aIsmVKHDAbt6fHdquWuSu/onch1nXtUFREBk6z1AkOudGekMdf9oulcMIpboeBXbBSNiUzu+e9f7dg5G2G+bXjQN/5MTRdBkFaBaQK/B2bra6HCa34dT8EOlGONrFnTWBXquvHFRIEzzhJZxYuMcYGA2y0TSBhu1WfDDw4bqczJPLckcsIT9dO8OJYj5zH49gcBfcsjS8ZI9A9153jDYT+BNBsHFjA79c7F6dkGcWvtWVqhbayahLu/Swj0EsNwvS9wU+j5nU1wNt4+jViZNC1l14LwdRIU5gVUDpd298XFoL33UDJHIN0d7DX4uAftHSL5k1cYL0v6bRQpSU1+Wol/2SlM5XSWnDQVCnrTZ++ziJg1YGjXseS2A4Bi89vwGloyY6sBV5uZo7HI/mrCK3iA4wHLug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39840400004)(52116002)(478600001)(2906002)(2616005)(6512007)(6666004)(186003)(26005)(1076003)(956004)(107886003)(44832011)(5660300002)(36756003)(38350700002)(38100700002)(316002)(8676002)(110136005)(4326008)(86362001)(6486002)(8936002)(83380400001)(66556008)(66476007)(6506007)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79iIBCtrnGtokt9qCj1IJK2+p2EQA/rvb6tZ+f5W5I+487Pg7CDsTTRdo/oq?=
 =?us-ascii?Q?R1q0nzF5WgDv3oD4BtQk0J5nxGJV2uvaJsE8HkE+dOsaAqAzMRFA8x8Nm/Eo?=
 =?us-ascii?Q?xqhK+orLG2kOWUs7PWZmE40FA7ShOPT0773GX4Mh7fFaqCuylfMZ5aLgI9kv?=
 =?us-ascii?Q?uM3QuCx9fWJ7QgbssaX3gsF/siS24bcxYcUf+dXC6Z15m6DiwwgJNZv8wqmP?=
 =?us-ascii?Q?t4x8qRRXvjAUotAvvnyOBza+ua/P0KVHhO+vkG6yQvJ33CkasWclnGuW//fp?=
 =?us-ascii?Q?R2vRVQlKZrvjsYdhFHuNc3E6GWE3F2JE1p0uFdaXesXZshdjC8PFjGhNSVWw?=
 =?us-ascii?Q?f1KeLdcMkROWSK/w2itP+j7Y5RyfCBhLFZYLUajftwzndQMgBkC6O3jVHrLh?=
 =?us-ascii?Q?RGWdoMYzioDvZQ+A0yp/QKz8MkklWnp/x5SUlJWh/lHr0OBCfMRES09P5F7J?=
 =?us-ascii?Q?RbH5E8MlUiqPsKo/uaD6kLXHwN25TVcsQ1eyL0apZy4LvcuawzeUUl/SLG2x?=
 =?us-ascii?Q?X8KtA2fodvn8tl1F9MGw7eYegrWXtVIrna6n89TdZhsklrB6b0oQA1t/9zXF?=
 =?us-ascii?Q?aIM9lB66OzDVslJc3JlcKIGsLQCT11zEKC5qhaELo9sB2xy5VDMWHD8/Xqiz?=
 =?us-ascii?Q?2wCuQRI/RDqBiX+MA9+j876FUewdueKfXhtc7t0pKWiHYBym5mc1y+rj6tcq?=
 =?us-ascii?Q?wixTqhdk6Rp9/AJMv9xEzOfpm50ZnZ2COthfi2BLk7XN5wE7Sm9xq3TLw5sB?=
 =?us-ascii?Q?qDE5ps5Z9dxaI88HEg5Htih7fv9Miovfvh2EfFe7V6QFYSVgiloaROW+1BaT?=
 =?us-ascii?Q?5S9BrZqZ0K2ftrEk74QNHMccOv6ARf4iTYmPcbOz7kQX5zJ9WvWDubbEZWop?=
 =?us-ascii?Q?ML0bei09HBY4/DuiV9o9IRFyoop8aRUlI8aNZjmxQ0wTzC2kryyr2Q5S+ys2?=
 =?us-ascii?Q?UkD40h0Y432Gw2Gft6NCdJu/iC8XKbJdPiC/8OB+nNAzQhVPLxgx2l7ollY9?=
 =?us-ascii?Q?xEGG90wkjUOAWRTSaN/5cy6RM6gcuOaVhFzzRkqhAxEwU1V5+5ApJMsRGMY3?=
 =?us-ascii?Q?6DzFzaKycQLD249xv8ZhXt/enA1AlyYRshMNKQbsg/1WvP35n1qxf490V/LT?=
 =?us-ascii?Q?2T0WAhACU7CPe9N2gQBb4Z08c75xUyAqB04wBWuIlDvtIL893PybyZMvA72T?=
 =?us-ascii?Q?SI1pL5rmpKU3cgMKrZc8XbIqtrAvMdA0i4zimVvZUcfqFO4dI+7FtgbwbKo8?=
 =?us-ascii?Q?POvkzyo8K2E464VaGxOTIrERLlKlPrUol3N6klF0MpZAdiMmjWVKWJRZJStO?=
 =?us-ascii?Q?kYS69nM8sPeiEFptJb4GTATg?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d743082a-28cf-475d-d604-08d94e29b4cc
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 22:32:08.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z13ebU1ILRFEzOYzWTZRmlCn1QeqdG2cH2s2eGSKvtf4vORxkLFWQFsWS0CNmDKX1O/ria5QM4hPv1nQuDE1hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7068
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This device does not support changing baud, parity, data bits, stop
bits, or detecting breaks. Disable "changing" these settings to prevent
their termios from diverging from the actual state of the uart. To inform
users of these limitations, warn if the new termios change these
parameters. We only do this once to avoid spamming the log. These
warnings are inspired by those in the sifive driver.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/tty/serial/uartlite.c | 52 +++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 39c17ab206ca..0aed70039f46 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -314,7 +314,54 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
 			      struct ktermios *old)
 {
 	unsigned long flags;
-	unsigned int baud;
+	struct uartlite_data *pdata = port->private_data;
+	tcflag_t old_cflag;
+
+	if (termios->c_iflag & BRKINT)
+		dev_err_once(port->dev, "BREAK detection not supported\n");
+	termios->c_iflag &= ~BRKINT;
+
+	if (termios->c_cflag & CSTOPB)
+		dev_err_once(port->dev, "only one stop bit supported\n");
+	termios->c_cflag &= ~CSTOPB;
+
+	old_cflag = termios->c_cflag;
+	termios->c_cflag &= ~(PARENB | PARODD);
+	if (pdata->parity == 'e')
+		termios->c_cflag |= PARENB;
+	else if (pdata->parity == 'o')
+		termios->c_cflag |= PARENB | PARODD;
+
+	if (termios->c_cflag != old_cflag)
+		dev_err_once(port->dev, "only '%c' parity supported\n",
+			     pdata->parity);
+
+	old_cflag = termios->c_cflag;
+	termios->c_cflag &= ~CSIZE;
+	switch (termios->c_cflag & CSIZE) {
+	case 5:
+		termios->c_cflag |= CS5;
+		break;
+	case 6:
+		termios->c_cflag |= CS6;
+		break;
+	case 7:
+		termios->c_cflag |= CS7;
+		break;
+	default:
+	case 8:
+		termios->c_cflag |= CS8;
+		break;
+	}
+	if (termios->c_cflag != old_cflag)
+		dev_err_once(port->dev, "only %d data bits supported\n",
+			     pdata->bits);
+
+	old_cflag = termios->c_cflag;
+	tty_termios_encode_baud_rate(termios, pdata->baud, pdata->baud);
+	if (termios->c_cflag != old_cflag)
+		dev_err_once(port->dev, "only %d baud supported\n",
+			     pdata->baud);
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -337,8 +384,7 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
 			| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
 
 	/* update timeout */
-	baud = uart_get_baud_rate(port, termios, old, 0, 460800);
-	uart_update_timeout(port, termios->c_cflag, baud);
+	uart_update_timeout(port, termios->c_cflag, pdata->baud);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
-- 
2.25.1

