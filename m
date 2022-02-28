Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C87C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 28 Feb 2022 05:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiB1FuJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Feb 2022 00:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiB1FuI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Feb 2022 00:50:08 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C13A57B29
        for <linux-serial@vger.kernel.org>; Sun, 27 Feb 2022 21:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1646027367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KylteGDrN7v0AFRpc+CSis2s0Wn7bHT1vxzklEsQP/k=;
        b=QAvw6ch4WayD11AJGm6RANFVQDpvw4d+h/IudsH9w/v9pZNEnBqiv2kWXCfVmd291KqMOs
        Ofsf7rY8SOvy5z11UNpblzAkVSR3+f4be+5z20rYvj0zsvueXeysfLPfl7y1OCrfFQ80A3
        /6vmBtmBiOWKfAQFVnNsx9w2vRXcZgg=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2056.outbound.protection.outlook.com [104.47.21.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-280-7E42ry_iPzuvKoEA6qCDZA-1; Mon, 28 Feb 2022 05:49:26 +0000
X-MC-Unique: 7E42ry_iPzuvKoEA6qCDZA-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by LO3P123MB3388.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 05:49:25 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6dad:8602:45c5:6747%7]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 05:49:25 +0000
From:   =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
To:     linux-serial@vger.kernel.org
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Krzysztof=20Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Subject: [PATCH] serial: core: fix tcdrain() with CTS enabled
Date:   Mon, 28 Feb 2022 06:49:11 +0100
Message-ID: <20220228054911.1420221-1-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: LO4P123CA0244.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::15) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c491b61-7a4f-4cb3-52aa-08d9fa7e136c
X-MS-TrafficTypeDiagnostic: LO3P123MB3388:EE_
X-Microsoft-Antispam-PRVS: <LO3P123MB3388B2B9992EC2323A6FC78492019@LO3P123MB3388.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: Cqmz/XUn2NFitXXsyoPDtMA1G+tF02rR7vg43wCSdzlDcVYUJktHHKcusUK8KXZGQ1JEb5mgGiKazK5LEh7DR61SyqRfwcS5q6JyeDIrNUDEkfYXfdR1tq+kP9f56DMQtwtbb+toC5z1+tGN7pmDdKX3BrchqkrzG/5x/D92d4dw6+lcNvLRUV3cTzGQwGM9k7XTO42d6tZ0WnxTk3PR63zRKLdYhsFvuB+k40pFfayiG0wtisYq54hMUDDqyHscuKKHz5ZUIKYmasuc1JiQp3Pe8QAK+EVi8UOI9/4KEXXfJBRhgcMP786T8MPy/qSe8U4PvHTCgEWDLpACqXaDY//DcVqi9/Vqc6AVFwiu+YnBxHmAlFCAlLKUxiqR1ZRDSQApLEK7axqqeBF8mGmdlBhUyx+aSkbY8Tr9NJRtmcdy3nOrYbFz08iqltqNmjZps0fGqLLre4G8efcmsXIdhkWvRUW12j5gW9glU+KparWlivv6yG8VQQ2JLiZZGZT4VegAkwqnhzWZcS4cnqBA7YPy24NxTFfxg1cwQsJLSEU5ciSz2lsoNy94ApS/cnrA1PiLOCOQwmqfxg8SlKNeG+CaT7I8P+n8o3Hqd7/FM/w+8AddOT3NAFR10x0Kawyedly/FSdNnVh8qXjuQyFdy3YEskti9+CCxFz3PriyMi20yudAnAC+56kSZiUPTWrQ1SSY49pC/qJCa0k40Puj5682QtC/VnXobrpHT0XjTwXDhkn58/lm14YJP2e9fuKS2Jqypk0ntm1nxBNn8UP64Kn/xdAQ0/4GKg4uLHHJ+vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(1076003)(2616005)(508600001)(6666004)(8676002)(66946007)(6512007)(66476007)(83380400001)(66556008)(5660300002)(4326008)(107886003)(38100700002)(2906002)(38350700002)(186003)(26005)(86362001)(54906003)(52116002)(6916009)(6506007)(966005)(6486002)(316002)(36756003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B8n9Ydm/i14PcCyPMFUIMgojC+a6qLWvjhWelC1qNPzPD7TvD7JKjOIvBfNo?=
 =?us-ascii?Q?LNpfB65OYpBv5mUJYKmH05TUEtOG4Cg4dFAuEj9nB8yp/SlXnOldugBniaVl?=
 =?us-ascii?Q?4mxDO8iMFbJmRAbO+icce07YHMeYVkeBvXo5NabVYFoktjDbXzQzVKARQf/G?=
 =?us-ascii?Q?rRL58PLwNZPrvSpLLvNtgqbsnrWPctx1XVbcxdTAUoLVjOjQvBj8tUD+DiEQ?=
 =?us-ascii?Q?SPKtmXivv6fiCUp57KfSYONxmxhHCCDldRgiYN9GAWa5kl9Dy+DeubMfKIBc?=
 =?us-ascii?Q?S1/tcgepbzTgkiQ6egeYWf4N/AT1WQNUY1mEiIBZV7bZSH2It/k+KsUq77lq?=
 =?us-ascii?Q?O2iAUm7lYQVykaSNxa923Hs4IwHbJML26nA9pZ3pO0G+JKywa0vsowAaMSE+?=
 =?us-ascii?Q?7StzsH3y/WCz14IHKMOtv+STUiHx4nkf+QN6tvx1GmYZw7zsdPSh/7Touc1N?=
 =?us-ascii?Q?8Lrhb+bkDERxgkwfShl3EC5piaMf4T6j0NcFIOd0aPZymE6uxsOn+yOqMjX1?=
 =?us-ascii?Q?hgwdf1OJGvHFc8RaZnuT7DxOiSfpuQ9Wi1ZTiljXr/zcorcGRBLEJU2qGU1h?=
 =?us-ascii?Q?MiAvGJoD1dseApH7YpkVDMqpe6tkZNRSJyKb03G6zvMfNjXiay+WsT4AGuD1?=
 =?us-ascii?Q?9jVsfV40Vo07XZKE72PiV9eWMpn14nynJ7NsNIr8nK9iVhZ33DBVFbEm1k0j?=
 =?us-ascii?Q?oaGj63iotgJo0lu8RiAr2BshGBgzYclWvI0VTipXrV9uFF0nGRCFdfOBuA+6?=
 =?us-ascii?Q?0cGqbDr1bXlihDfi3I+rntSEcugnSAORBTPCOXYkbGO3uqWCqGh8cQ8Hr+M5?=
 =?us-ascii?Q?VT+6yc5AwOU5mNFPpYaoxp9AnRi2BA4NoBNcyRmrZEuQmP3AKLOJK44zV0YG?=
 =?us-ascii?Q?Rdf7NPlbzeItD+ii5RiEgMjIdpAYy5xABTO+MS3h5Ecci1sCraBLJDobzb5H?=
 =?us-ascii?Q?rBJXD+sGukWMiRuNCn6mhfLAh10s0kvj7eetLykooQctjHhgIE/LUjLhbAZo?=
 =?us-ascii?Q?+PgXUqfkeA2INAWOwBEhEGIrS55lQM02wY6Wv2hnuWo8djbOh3Q4JWDDYe1x?=
 =?us-ascii?Q?7gLvyjRA1hnamyaILYAm5bIxC6YaiXm17W0x7+b3+WvZeAJlBVPwTGhVrIJE?=
 =?us-ascii?Q?FGh3DNiAdvrs+at5uML3lISSzAW3BfYY/iPAP+zb3rigQ3YFi9Ly3IwC1o9W?=
 =?us-ascii?Q?ZPCk6A798LzVd5fvHqwJdjQq6AfcYpetHbY8DFZphaGjEf5GnA6aTcp4dNaC?=
 =?us-ascii?Q?mKi9u0hUiztpLMAWMysSDe2X9vUrlG273gr1KLELzAjShynWYL8D5uYQeBj1?=
 =?us-ascii?Q?y9qzBl8kGjTzBEhvcY08P/Lqr4W+HEvyzbp0yiP03Gws8V3Vgw0e81Qkfyw5?=
 =?us-ascii?Q?4ruRp0pZ9sZWB/dqlGEOp+NHmvXqP8OX0lWkMjP/ws60WEF7nIqGqrFCxLYX?=
 =?us-ascii?Q?luaWGDlTxEXmaTrFs7owpXRCWhUHKE80IXztdHIa4lukabCcdxDjtquWYzyZ?=
 =?us-ascii?Q?e3+clDfANl12nnSEemeTFqCc3cuzs+i3dQodSBWPw+vKdklByaD+0kf4m6p0?=
 =?us-ascii?Q?cjRk2mMwX/qVzrxX8zoGIccH7ma7y4Eeg2MisCMyWQx2XaD2hXZ3/JZaDl1e?=
 =?us-ascii?Q?1ZhkHU66uB9eLB9b+/chSCfkiLkUFlMM49DGY08WWchAvnlqmdtGXeXj84Tt?=
 =?us-ascii?Q?cWm5SQ=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c491b61-7a4f-4cb3-52aa-08d9fa7e136c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 05:49:25.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uefYTDjjp2w7goyx3fpf0WpK/yumS+FStWF0orpvtJdeDqhpPpQ6Xn1FypQQJQ3say0sVI0sYZpYM95aCdDOywK1XI3SgLVbivyK+AIfCUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3388
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Do not set timeout to twice the approximate amount of time to send the
entire FIFO if CTS is enabled. If the caller requested no timeout, e.g.
when userspace program called tcdrain(), then wait without any timeout.

Premature return from tcdrain() was observed on imx based system which
has 32 character long transmitter FIFO with hardware CTS handling.

Simple userspace application that reproduces problem has to:
  * Open tty device, enable hardware flow control (CRTSCTS)
  * Write data, e.g. 26 bytes
  * Call tcdrain() to wait for the transmitter
  * Close tty device

The other side of serial connection has to:
  * Receive some data, e.g. 10 bytes
  * Set RTS output (CTS input from sender perspective) inactive for
    at least twice the port timeout
  * Try to receive remaining data

Without this patch, userspace application will finish without any error
while the other side of connection will never receive remaining data.

Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
RFC did not receive any comments. The only reason for sending RFC first
was the fact that it touches the comment that dates back to pre-git era.

RFC: https://lore.kernel.org/linux-serial/20220203142337.1993024-1-tomasz.m=
on@camlingroup.com/
---
 drivers/tty/serial/serial_core.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_c=
ore.c
index 0db90be4c3bc..0592e1267642 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1607,17 +1607,19 @@ static void uart_wait_until_sent(struct tty_struct =
*tty, int timeout)
 =09if (timeout && timeout < char_time)
 =09=09char_time =3D timeout;
=20
-=09/*
-=09 * If the transmitter hasn't cleared in twice the approximate
-=09 * amount of time to send the entire FIFO, it probably won't
-=09 * ever clear.  This assumes the UART isn't doing flow
-=09 * control, which is currently the case.  Hence, if it ever
-=09 * takes longer than port->timeout, this is probably due to a
-=09 * UART bug of some kind.  So, we clamp the timeout parameter at
-=09 * 2*port->timeout.
-=09 */
-=09if (timeout =3D=3D 0 || timeout > 2 * port->timeout)
-=09=09timeout =3D 2 * port->timeout;
+=09if (!uart_cts_enabled(port)) {
+=09=09/*
+=09=09 * If the transmitter hasn't cleared in twice the approximate
+=09=09 * amount of time to send the entire FIFO, it probably won't
+=09=09 * ever clear.  This assumes the UART isn't doing flow
+=09=09 * control, which is currently the case.  Hence, if it ever
+=09=09 * takes longer than port->timeout, this is probably due to a
+=09=09 * UART bug of some kind.  So, we clamp the timeout parameter at
+=09=09 * 2*port->timeout.
+=09=09 */
+=09=09if (timeout =3D=3D 0 || timeout > 2 * port->timeout)
+=09=09=09timeout =3D 2 * port->timeout;
+=09}
=20
 =09expire =3D jiffies + timeout;
=20
@@ -1633,7 +1635,7 @@ static void uart_wait_until_sent(struct tty_struct *t=
ty, int timeout)
 =09=09msleep_interruptible(jiffies_to_msecs(char_time));
 =09=09if (signal_pending(current))
 =09=09=09break;
-=09=09if (time_after(jiffies, expire))
+=09=09if (timeout && time_after(jiffies, expire))
 =09=09=09break;
 =09}
 =09uart_port_deref(port);
--=20
2.25.1

