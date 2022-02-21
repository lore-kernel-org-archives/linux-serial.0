Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC7CC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 21 Feb 2022 11:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355705AbiBULRL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:17:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356091AbiBULPu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:50 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BE8D63D9
        for <linux-serial@vger.kernel.org>; Mon, 21 Feb 2022 02:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1645441013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ7Aqxscf1ebJzYXvq+ijt0vA7p0BjtSmO7gWSOnhyY=;
        b=Vnki8MeMMFambJgaQwZP1UNuuTex+3iYZ+fxA10abcmOEaKRTEjDUozL/vkTE+CNwiK1hp
        OCj6mx4M3D/M+/JGa05ap+jxORfRjDFyLctViVFXjaIie4XTJU0t95irgkA7FKDFdGlOLN
        oHa7PxemIz/kkxtAst9lcBZHOc0IVa0=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2057.outbound.protection.outlook.com [104.47.21.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-186-sFZuGmm8PL-ZXRndpeuHEA-1; Mon, 21 Feb 2022 10:56:52 +0000
X-MC-Unique: sFZuGmm8PL-ZXRndpeuHEA-1
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
Subject: [PATCH 3/6] sc16is7xx: Separate GPIOs from modem control lines
Date:   Mon, 21 Feb 2022 11:56:15 +0100
Message-ID: <20220221105618.3503470-4-tomasz.mon@camlingroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
References: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
X-ClientProxiedBy: LO4P123CA0469.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::6) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60fd1645-435e-4044-5e4b-08d9f528dd4c
X-MS-TrafficTypeDiagnostic: CWLP123MB6574:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB6574D3EFBDBA8FB80C396ADA923A9@CWLP123MB6574.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: rr2iFqG0UF3t09ydxNLYHnc8KaRIiA3WBuzkysnPU20DtEYpaG6gm3T6Q9tKR0aJeLZbTsru9kHSkReK9I1g2qtNmlxMFuJCHeFIMEdJh2lDizZZo5OQbpn4KqCKzKmSPzWJbbH56pp5YeSBy6yki0oWL3u/nveVuzNDQXY28JBmiEwH13SYAwQ7ft84rTvYy1EszU9mNrZIYzc7Vl4IojWCoUW4/+COvMVndo3/SmiWwkjuotFYfRDoeVXy4cNCsEr6GScWDTV1xzhFlNTz2LXDq8DRN2lN4dpaaJKaiPn6BXcM4gZ57tKiDpP6aRAr3wj7MThaPluMp3R7F9ANBJ+FuYUHAqpmv+O9BLO8BUdkZON6ZWwozONyohyPQ75U/+LnvYc+viHaEUyTI7hFqPD+e3TMED9qFNdpEfzfhmueyca/vMh75KEOrJC09C41QlVpV0sr/onIOUaGk2+juzF0YwwT5uPzdV7KXoIfJoZVhckBMmn9eRcXqVt7gh5+Z3kod7dJ1jFQllLlCYrl+C6JMfEdUd+SvPGBQIHkCVorHkvrxOyghZZgRP/TlhSQUvxOCN/Es+Kswbda0gjbDUPQ/5Pp3Rb1NqjbaEUsxH7csb7kFx4emHDlkyfwIOL4IVTVFdBalqOra2B6E9kCyWVQTmvT/DB1v0b7N3cJkRCJ9k5jk2Kkh+NBfnUz70s8gpYb/L70ItbodvF9En3W3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(52116002)(6666004)(6512007)(6506007)(5660300002)(508600001)(8936002)(38350700002)(38100700002)(36756003)(2906002)(86362001)(4326008)(8676002)(6486002)(54906003)(2616005)(83380400001)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(186003)(1076003);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TJK1GncvJ6///JgcT5QN6DcrwCVgOVQX/tLeua9otO6OQNVTmKf1J2WBZOwn?=
 =?us-ascii?Q?VZifQKiIJPI1Hdpcd2/iFtJpQ8KjBrgOpn8q4DqdYQBy1rNy1x39uq12BYKb?=
 =?us-ascii?Q?254KbjOiI5659eN80TfBoMVltz3Fg23w6xFp1GJ5kdW4gMs0bFfb+k+2fsvT?=
 =?us-ascii?Q?i/EhQ6HrTdlj3XQULVjtngtbiOiJtx4Uf+DsZCKfIUtC35EzTCg3gq4iZUxE?=
 =?us-ascii?Q?2LtKqpgINKlnQ/bcmMmSoJw7Cq4RRefP8GilIqCBJSPzATO1amWY/e792NEj?=
 =?us-ascii?Q?YPZcr4l4vDSM54aQYn3oE6H67mVHqYmnhmqgnU4qJ8BJ88fE7rxSUpj9Ht0C?=
 =?us-ascii?Q?k02iRaZvEBzi/TxBeBNsMicH8ePqoike/R3o8JE6hb7CDoQWlpAg3t1WbSSN?=
 =?us-ascii?Q?IA854EkyVnp7LDfOls9dXbDooriv0xHJXxvOilblzySBMZNgJDImcW1N12Qy?=
 =?us-ascii?Q?lYotN3D2LaHoovq/+saZ/qG0UdQCURDv4J+Fc/7J3qwhaDkoyFJp0fbyGBX5?=
 =?us-ascii?Q?4lRmm8OceT9KRBc06uIs7fUmdiPx6qA1R2ugJdajecMe8B4xxk/gi3V7ajfM?=
 =?us-ascii?Q?LThRtTUDmKl2ItsHLrHPfbJugau3ORPQOsb4VaGzNbztW5+AJ5VnKW5saepW?=
 =?us-ascii?Q?j2A309EwMXoYnod0HEIPC1WzTGC5N8pujLtkiJ9stAiYggkLowc6PZeIv132?=
 =?us-ascii?Q?wVXhd+K3krggtnxwODOrUnCL1RadN1GSY1W503cKl90v/7LE+x9rAHmInf2J?=
 =?us-ascii?Q?cjp0CEhVXwg2ePuW5f9KjORvAT1haw5wbJZRkNfksnax355lp2XJrPqU2ktm?=
 =?us-ascii?Q?AZGocPJlftjOh6cBjBO2iYSzJ0bQ5FjK9jRlNbv3Nl3EWc1RrBTLrgTzt3JL?=
 =?us-ascii?Q?ClauL5NCWrOGBMo4yuVmwzpUNT/kfij1S1nUHf9sLycUi1OxyHZCb/aUnjnB?=
 =?us-ascii?Q?sKijqcmLwu9VW3u/ikFsWoZLd/GObCN75uRg6CJJWBnHRzD0cMVolgDihIsm?=
 =?us-ascii?Q?iyJEVhouWp8rQVuir9nHfE5uj/x1xTgqyaUmFvWldrMhJT6B0RuApKA5DmLf?=
 =?us-ascii?Q?vjOFITemerzSOuoyewJaasA1fHEUivyve3M0OC0Sc/tpiE3FDFN6jLcY+d8W?=
 =?us-ascii?Q?zba5dB+/o3Np45wZWspWlrH7X3NubtGXj/8ZlclsO8mBcxCwoFl6i0Z5rI2n?=
 =?us-ascii?Q?MTgZ8S9g+aJYt4qFJ5veldKPEOkaEcL5B7apN7x4v1Khb8voRbY5FsofFmx/?=
 =?us-ascii?Q?4C6jTXW1Epaj5nShm7q32JbkVEUfy4C+VOjrKJgAyr7rDyaC3e/FfvuCaEQM?=
 =?us-ascii?Q?h4VeIEi9rnD/80G/NxSdrPzhxF65LQ1ahjbA/oAqZO/KEq2LYcz4PGuLqDdF?=
 =?us-ascii?Q?T2FRFmXfL0D6w49DWyKlzLM4xF+6pOtx7B2owUoAx6pSCYOiUyi3Yv2zuZ+I?=
 =?us-ascii?Q?GnSl0P7kiQwE5i/lLEMxRZcgYGiRjD1lT2UYCUlCJVZ4o9yM7Jt3Ji2DCld0?=
 =?us-ascii?Q?a+TZbDnNnlOyPJE4DDAIgphyxFH/BElpXWATEWEjmzaMkCp67K6BfnQZo2mO?=
 =?us-ascii?Q?B/AKy6tWws4UuOuftCuKfa2a9oxWRDfnVuXLVLLck/5UZ2KhCQC0BuwDesTe?=
 =?us-ascii?Q?grSKVk+Jm1R7I/2SOGhzJLyjFMzW+EGVJDaIEUqxZ9SjkdGmqCHqA4WwOo8C?=
 =?us-ascii?Q?siLiFRHfSw/G/3NBfhhZO7O9QaY=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fd1645-435e-4044-5e4b-08d9f528dd4c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:56:51.1152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt5OXJoL67/Mn7UEBicdgL/C7lYafyQ8FOTHsYdhDfeA5hxlRn8s35M7+zvAaeQpgnnMxz4TONnaZ33oxjcPs56QoN7SUr7z1h47+IRkMSU=
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

From: Lech Perczak <l.perczak@camlintechnologies.com>

Export only the GPIOs that are not shared with hardware modem control
lines. Introduce new device parameter indicating whether modem control
lines are available.

Signed-off-by: Lech Perczak <l.perczak@camlintechnologies.com>
Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index c62531b2efe2..21ae2c0b7bbe 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -306,6 +306,7 @@ struct sc16is7xx_devtype {
 =09char=09name[10];
 =09int=09nr_gpio;
 =09int=09nr_uart;
+=09int=09has_mctrl;
 };
=20
 #define SC16IS7XX_RECONF_MD=09=09(1 << 0)
@@ -440,30 +441,35 @@ static const struct sc16is7xx_devtype sc16is74x_devty=
pe =3D {
 =09.name=09=09=3D "SC16IS74X",
 =09.nr_gpio=09=3D 0,
 =09.nr_uart=09=3D 1,
+=09.has_mctrl=09=3D 0,
 };
=20
 static const struct sc16is7xx_devtype sc16is750_devtype =3D {
 =09.name=09=09=3D "SC16IS750",
-=09.nr_gpio=09=3D 8,
+=09.nr_gpio=09=3D 4,
 =09.nr_uart=09=3D 1,
+=09.has_mctrl=09=3D 1,
 };
=20
 static const struct sc16is7xx_devtype sc16is752_devtype =3D {
 =09.name=09=09=3D "SC16IS752",
-=09.nr_gpio=09=3D 8,
+=09.nr_gpio=09=3D 0,
 =09.nr_uart=09=3D 2,
+=09.has_mctrl=09=3D 1,
 };
=20
 static const struct sc16is7xx_devtype sc16is760_devtype =3D {
 =09.name=09=09=3D "SC16IS760",
-=09.nr_gpio=09=3D 8,
+=09.nr_gpio=09=3D 4,
 =09.nr_uart=09=3D 1,
+=09.has_mctrl=09=3D 1,
 };
=20
 static const struct sc16is7xx_devtype sc16is762_devtype =3D {
 =09.name=09=09=3D "SC16IS762",
-=09.nr_gpio=09=3D 8,
+=09.nr_gpio=09=3D 0,
 =09.nr_uart=09=3D 2,
+=09.has_mctrl=09=3D 1,
 };
=20
 static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg=
)
--=20
2.25.1

