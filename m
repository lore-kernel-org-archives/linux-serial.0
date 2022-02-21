Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF09C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 21 Feb 2022 11:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355660AbiBULRI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:17:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356100AbiBULPv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:51 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2952A63E0
        for <linux-serial@vger.kernel.org>; Mon, 21 Feb 2022 02:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1645441015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NHgnWgzte7TRqCFshN3PUXCoAdl6QAwr1aOWK60390=;
        b=iKhnbf4pi7q+nPXKJ0ju46zbmkPo1KILCmMKm87AAGpw4ZQ3f1I88PuxYLX5r7kfbyukQQ
        JWV5t1Y7sajbpIEeibro8hzhmt3+BP4Xp7ehF4MXGinO+4HThcy2jqWSVwwzF/7GKYtpBW
        segIA4J7I2FWcxol5h61fFJ2y4dOf+8=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2057.outbound.protection.outlook.com [104.47.21.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-186-_eFvwl5SNviI3cOqa4hpog-3; Mon, 21 Feb 2022 10:56:54 +0000
X-MC-Unique: _eFvwl5SNviI3cOqa4hpog-3
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 10:56:51 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%8]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 10:56:51 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     linux-serial@vger.kernel.org
CC:     Phil Elwell <phil@raspberrypi.com>,
        Daniel Mack <daniel@zonque.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [PATCH 4/6] sc16is7xx: Properly resume TX after stop
Date:   Mon, 21 Feb 2022 11:56:16 +0100
Message-ID: <20220221105618.3503470-5-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
References: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
X-ClientProxiedBy: LO4P123CA0469.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::6) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b40b9651-f973-4283-19ff-08d9f528ddae
X-MS-TrafficTypeDiagnostic: CWLP123MB6574:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB657413B3CDB9FFB4A0B76B02923A9@CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: FXsW4hTpTtbqrxh8sPRr+L7NEvdrXY/4P5Bl2+ta2EfoPZXGGVOLX1wHXPdjGw9oVebCHjzoTJPKLy0/UhrJUHejRB/0a0ZewGaKDJOAjEbIobG5PUJhgBFBRfjRay5BPgepvv0Ysgumy/+BFoi+ljeSCi5p7yOMX+Z8SArKpPfDbm0RYKwADrtTq7dmwjg1azVphbQr1ta1lUfGSCqyE/dX66TYWxKUHZWNT7mSO5ijHF98DEVcHPmeCT675UTKLdJ7TwkVqVe9eeqDRQy304CshZhqDmdYKFzdk7JrlPKVjcd+djweKVY3NcJmQc4A2DII0A524260yaEU7LPNzMc7ClQPLXLUzKQe8ycBJ5mSnDXMEsM9D/B37iHqcK/239urZwloA2dWC8wppw8tOkFDdHzFTars+soVHUFs85lAvEtlVpg0Cpwl47sUyRVtctmm05PHotEO+xEUgTzIce28cZaM6kXeMEcrjMserauNu+0ZhxkxGD8R3EpQQclfzh0vk0XtyRvdkE3f8Q33am/Iu20lz8CajSP8TiUYsiWtkrkRHdVKNFmLjDI+rfPP0iP3+mDdKnnGraTK1NTgF0PMbsJw7cG0eCYrxKhnUlDeLQ6hW2ih45BRp0ixu6Hvy8f90KFbg1MyJawhTmy1E0FZzllccZgOAgFhdO1hFRoBmgFzZKaCvWuy6jtUPzQZ5Msw7+8Z9aKl77XEzC/UMVL0Wafs1MFz93PWkJlWLJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(52116002)(6666004)(6512007)(6506007)(5660300002)(508600001)(8936002)(38350700002)(38100700002)(36756003)(2906002)(86362001)(4326008)(8676002)(6486002)(54906003)(2616005)(83380400001)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(186003)(1076003)(326664003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tk/g/EXeGhc1MMw8QpcKmua6853DDM0vL5t9p5evUnvFsnvW9kSE428ep0Jd?=
 =?us-ascii?Q?k0qe9IC2mzcyWwLWmABpsRGZ4yJfh1Dp++zUFVGZDDU1fXBBsIADBVDjXtgu?=
 =?us-ascii?Q?j0mcsnBP3+Gbk3cShrOmrSFyHHcvlMLSTb+/rYLAeoOnPWbXImDv9pAG+7ax?=
 =?us-ascii?Q?Dvl/90Ik2cGqsdMnW/VMG55D009EifCBLStD+27sDfcLaDsEsVDM3kW1lCh+?=
 =?us-ascii?Q?WMuRhM3w3g5yzb75+t8NewSyZ2dBlJh0hXIa/fODZemoD3R4O9htJBJwC15J?=
 =?us-ascii?Q?5ZQy1vLOzDPYLaEKHDv4THlFKlXyRIFfYmR1mTpyVxceQ6rSpAXoNo7jadax?=
 =?us-ascii?Q?3h6ehdGHdXz/M2RyjAEQTPx0KQGuUYWDKf5xNVFXk5Fj7MhmsC/lvhP+RYev?=
 =?us-ascii?Q?vo4jyfr5o58263d9xnsp4rWPaGZQytM6W6X9tJhVGRAS16xVhNScFfjHRlXj?=
 =?us-ascii?Q?KPl4ms+V8WgWY6kob8ofV1FCWTK/4rWJ77VPLHG1BKLUCpX9k87BC8QTGqp0?=
 =?us-ascii?Q?lyxsVeVqGB3bNSSaD3yq6gzFBjx2owyuVKAn/s/D1yafkLi4bqSE6FLcBceP?=
 =?us-ascii?Q?0d/cgsBaGmN0hTxOz2sTTQ9hiFiHPhf392QJtTjSK6y3rAeyTHcP1wXdK02N?=
 =?us-ascii?Q?+xBHH/PycMxhFv/L4did/vjjV7kIAKgg8QkS+qSD03/zmLKxuQP8bEbZbV4o?=
 =?us-ascii?Q?BLtkxby8MAsrFQvZJSfTdRyQUg3ku0cgdBAUMJTbV6/SbsAf60B8iRgVM3vS?=
 =?us-ascii?Q?HpvLZJgnVToVrLjgED15HocNjkNmO5+ah5t/dvqXo1mBvnOKRTJmWEAz4nbJ?=
 =?us-ascii?Q?kp26VApJCdkU06UZ/VDYADd6Ya463SixpxgAh6ovwUYC9LchtOk4u7PXLVK8?=
 =?us-ascii?Q?ajEj6Xc+2AjUA+rl/NrdyRKQpgTqg5yled89AHtJVI9DqxFGMabMihotebN6?=
 =?us-ascii?Q?B94lH/VIdCGgRp+UiTDCdmFVFo1ALi71l1hgPw9PRxUl9EQdoDgIqOXDAxpU?=
 =?us-ascii?Q?MQxRM0d1X/EVM8A5rfXabomN3rrGkLPBijNldZZyRpL0O+DqsuyTQnz58DHv?=
 =?us-ascii?Q?kl7CtbUxhoGwRgzq7VldE9Qo30HENCnYT07LTvyu3kErG9uxKFSGBN4Umn98?=
 =?us-ascii?Q?LapZ/ysn9jo8Pf4B3WmIi9hya49DIk4tZ2nBPVzvbxLeR3JblE1QCL1l+KuG?=
 =?us-ascii?Q?9S28Bz0nX1h7q+aPRSAXmvR/xrZ98O1JdawRbwnUjbY94zh6BOsV9jyWwDYn?=
 =?us-ascii?Q?kih49nWkPePNReWG8kTC+1dFCHE5USB/15Mk6g/xjYQUQThOwEfNYRGV6WwE?=
 =?us-ascii?Q?vxEuED9iF/FFTXDlHkmONzzgUfEdk7IqlCQQe2W7yVs3vDCLoA5ZLPdMxiBA?=
 =?us-ascii?Q?KsRa8rUoJPkY+7O7+eVPUitcr32/W1HI3TGNBdnSzjRwuS6TJui8wlz3XDjq?=
 =?us-ascii?Q?WuJJilQp4bMcvN4cQUaFc9q1ExvoQ7retC2Lv5YPEKirKnt9UwxXi9a0GhH5?=
 =?us-ascii?Q?CPHFgXmtnBRnlokaRpBBnR3dS9zhjJpH/7ebeTLu/NNIztG3E9RCHHkXbY77?=
 =?us-ascii?Q?DVrzP6Q+Os3wOYZR8yaMhMWT972SEuUoq+1aXiT5MWjIsXf+dq5DEOHTRRTr?=
 =?us-ascii?Q?Mkdkf17+JTr6Rh3CemI5qtqjAlrWPGLbV/68EwHr0qSxpPlc09pbcZXMCDYV?=
 =?us-ascii?Q?ye82TzYd8Oy4DU7UlEswV/S/AqQ=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40b9651-f973-4283-19ff-08d9f528ddae
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:56:51.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VweE8vqDlHZAlOTkk8Z6WYY7octFMjM6XGb8MQiLtAgS6C5CNX2J6y9j/at7YHdu1jc7g4zPSwr/pA6D2cCxhcyGbsAQh1CfKY2WcmynO7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6574
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

sc16is7xx_stop_tx() clears THRI bit and thus disables THRI interrupt.
This makes it possible for transmission to cease indefinitely when more
than 64 characters are being sent.

The sc16is7xx_handle_tx() call executed by sc16is7xx_tx_proc() can send
up to FIFO length (64) characters. If more characters are written to the
output buffer, then the THRI interrupt is needed.

Solve the issue by enabling THRI interrupt in sc16is7xx_tx_proc().

Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 47 +++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 21ae2c0b7bbe..17e79af36604 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -315,7 +315,8 @@ struct sc16is7xx_devtype {
=20
 struct sc16is7xx_one_config {
 =09unsigned int=09=09=09flags;
-=09u8=09=09=09=09ier_clear;
+=09u8=09=09=09=09ier_mask;
+=09u8=09=09=09=09ier_val;
 };
=20
 struct sc16is7xx_one {
@@ -349,6 +350,9 @@ static struct uart_driver sc16is7xx_uart =3D {
 =09.nr=09=09=3D SC16IS7XX_MAX_DEVS,
 };
=20
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit);
+static void sc16is7xx_stop_tx(struct uart_port *port);
+
 #define to_sc16is7xx_port(p,e)=09((container_of((p), struct sc16is7xx_port=
, e)))
 #define to_sc16is7xx_one(p,e)=09((container_of((p), struct sc16is7xx_one, =
e)))
=20
@@ -651,6 +655,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 =09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
 =09struct circ_buf *xmit =3D &port->state->xmit;
 =09unsigned int txlen, to_send, i;
+=09unsigned long flags;
=20
 =09if (unlikely(port->x_char)) {
 =09=09sc16is7xx_port_write(port, SC16IS7XX_THR_REG, port->x_char);
@@ -659,8 +664,12 @@ static void sc16is7xx_handle_tx(struct uart_port *port=
)
 =09=09return;
 =09}
=20
-=09if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+=09if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+=09=09spin_lock_irqsave(&port->lock, flags);
+=09=09sc16is7xx_stop_tx(port);
+=09=09spin_unlock_irqrestore(&port->lock, flags);
 =09=09return;
+=09}
=20
 =09/* Get length of data pending in circular buffer */
 =09to_send =3D uart_circ_chars_pending(xmit);
@@ -687,8 +696,13 @@ static void sc16is7xx_handle_tx(struct uart_port *port=
)
 =09=09sc16is7xx_fifo_write(port, to_send);
 =09}
=20
+=09spin_lock_irqsave(&port->lock, flags);
 =09if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 =09=09uart_write_wakeup(port);
+
+=09if (uart_circ_empty(xmit))
+=09=09sc16is7xx_stop_tx(port);
+=09spin_unlock_irqrestore(&port->lock, flags);
 }
=20
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
@@ -751,6 +765,7 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 {
 =09struct uart_port *port =3D &(to_sc16is7xx_one(ws, tx_work)->port);
 =09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+=09unsigned long flags;
=20
 =09if ((port->rs485.flags & SER_RS485_ENABLED) &&
 =09    (port->rs485.delay_rts_before_send > 0))
@@ -759,6 +774,10 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 =09mutex_lock(&s->efr_lock);
 =09sc16is7xx_handle_tx(port);
 =09mutex_unlock(&s->efr_lock);
+
+=09spin_lock_irqsave(&port->lock, flags);
+=09sc16is7xx_ier_set(port, SC16IS7XX_IER_THRI_BIT);
+=09spin_unlock_irqrestore(&port->lock, flags);
 }
=20
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -813,7 +832,7 @@ static void sc16is7xx_reg_proc(struct kthread_work *ws)
=20
 =09if (config.flags & SC16IS7XX_RECONF_IER)
 =09=09sc16is7xx_port_update(&one->port, SC16IS7XX_IER_REG,
-=09=09=09=09      config.ier_clear, 0);
+=09=09=09=09      config.ier_mask, config.ier_val);
=20
 =09if (config.flags & SC16IS7XX_RECONF_RS485)
 =09=09sc16is7xx_reconf_rs485(&one->port);
@@ -824,8 +843,24 @@ static void sc16is7xx_ier_clear(struct uart_port *port=
, u8 bit)
 =09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
 =09struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
=20
+=09lockdep_assert_held_once(&port->lock);
+
+=09one->config.flags |=3D SC16IS7XX_RECONF_IER;
+=09one->config.ier_mask |=3D bit;
+=09one->config.ier_val &=3D ~bit;
+=09kthread_queue_work(&s->kworker, &one->reg_work);
+}
+
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
+{
+=09struct sc16is7xx_port *s =3D dev_get_drvdata(port->dev);
+=09struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
+
+=09lockdep_assert_held_once(&port->lock);
+
 =09one->config.flags |=3D SC16IS7XX_RECONF_IER;
-=09one->config.ier_clear |=3D bit;
+=09one->config.ier_mask |=3D bit;
+=09one->config.ier_val |=3D bit;
 =09kthread_queue_work(&s->kworker, &one->reg_work);
 }
=20
@@ -1067,8 +1102,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 =09=09=09      SC16IS7XX_EFCR_TXDISABLE_BIT,
 =09=09=09      0);
=20
-=09/* Enable RX, TX interrupts */
-=09val =3D SC16IS7XX_IER_RDI_BIT | SC16IS7XX_IER_THRI_BIT;
+=09/* Enable RX interrupt */
+=09val =3D SC16IS7XX_IER_RDI_BIT;
 =09sc16is7xx_port_write(port, SC16IS7XX_IER_REG, val);
=20
 =09return 0;
--=20
2.25.1

