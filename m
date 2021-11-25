Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3668FC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 25 Nov 2021 13:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355259AbhKYNZP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:25:15 -0500
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:8612
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355280AbhKYNXP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Nov 2021 08:23:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iu6Tl3HIsOdVXA3w4OmY/PFHVfKVdw8eLuvxGKK8/ajR23+JXA7k5CbKRt0TOiZZvPeG4Yjau15G9Ds4xzR2rYUDWXihQKo7qWLC/vkBwed6roFhgKKJLwn3lb8Fuh6mAvgc0bqbW1WHKo7ME0x/yziySbJWUrcSb4GlEbZvSzo14D1BKRQWZt1bpW1omZ+JE5HSZM7EDWAM9LXoZp53mQB6bl0qhmd69Bnh88vI7MDgHckxnD2S8zNPie6mXt9D08Fcm9Qgz1cuy4PQHuX75sjSgKn68wtbR6S+xhPx6tHLyMOfTlITTdfJda94rxu3HKq409Tto9vubRDx/ARupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=055NqZYD8qakwrd/iyi0w9VXHu7O9SBDMdGZD9wN7Kw=;
 b=I0L3IX6dkDyjcNsmH7iolqvP+pO46ZLEH3buAQ5TBbiWyt+GQLCs2E0tnxurS6iq3ClQOj35ODP64I54uOBU9iaqNWnO930O2go8e/RcOzvQGkw4wYEp2+91po86mep9yIDrOkwLb7jnG9PJQx+d/5VOLtgrDx+UuUg/1mm3io4VKIazOu2NFzsoHBXnoc/pkvzZkFgeraH+1M+YhfvCBruQVapAPHETV+LID1ag3DdeGuKbm0g/4gPT2j4raIMW5u0gTkSlYDqg3P1YtH/SKJUA7vt64aIlKMaKw5xwRAiiQQeMvI3yM0g/RGjC1n/eNUhwfA7IbvdMufJ0VFrq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=055NqZYD8qakwrd/iyi0w9VXHu7O9SBDMdGZD9wN7Kw=;
 b=etQrHBYAb5VtvKMqZWpIILHaWrNbpCDmohi7i3RSutPetfc8vNMvVxkLiMFDj3vWomtXaGXsHQvLIogrQqc7II7Fro639p0lzf03OJKsHkKjA5SJmtfHnApv01qhJIPs2M+LN/DeldpmVSYIRzuSZnezCgTikIKDlzvtiQJD9Bo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Thu, 25 Nov
 2021 13:20:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 13:20:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/1] Revert "tty: serial: fsl_lpuart: drop earlycon entry
 for i.MX8QXP"
Thread-Topic: [PATCH 1/1] Revert "tty: serial: fsl_lpuart: drop earlycon entry
 for i.MX8QXP"
Thread-Index: AQHX4QVHD09foMofFkqqHrmARZKeb6wUPBxg
Date:   Thu, 25 Nov 2021 13:20:01 +0000
Message-ID: <DU0PR04MB94172DC7570FC6379BD45A0488629@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211124073109.805088-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20211124073109.805088-1-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9992ed4b-0ed6-458f-2982-08d9b016494c
x-ms-traffictypediagnostic: DB9PR04MB9404:
x-microsoft-antispam-prvs: <DB9PR04MB940472C3F98DDC5B0FD6873F88629@DB9PR04MB9404.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MWDLne4A3SzaBCnJB6nF+EZhggCtCKNxIkaKnRgAtd30Hsea2XdPX6Q5zE5mgKbSk9pEsiibPKRBYbTusjdYpk548aKCuA/X295rISfxfV03ITFmF2SaZq1YXrsW2qFsYpJMQkq2PKNQLIOeNa+MvLhoGyHeDrJWCXaR0HiWCD7Cd+Q8Ed+89QYLCMWY6xzB+fKUHYXUH3CJ5ljvq6PhEimgcztbLAQyEberQQSYBdPN2GyNoruP31QKUCaCq6NrdULOk5W8NpcPO6uhGnnz6EpfKCaBCoLN+Rc3pQoNKQHifUvVSP3VmkcmSqwBoK6oRCZqZgYWSLTyurTcyDnlKO/BNSDWIkzJk5832V+K6LE7Dvx/yBgN23mn7yuvCJfsK4Z7qfPbm414b3qc/1EZv0Ahmlg2ROE90Rntp1eh7ShKY8yMmOfZOyBMd1W5DxEubkIfd96nPNne5bAJtXQMqMpzYqk8aLMpDjQdbkziMTf03YUbaBxMqM+jUcIcpVUnPmRrC31FAeOvMMyqqASv8eP1b3kGSrXWrbtxaLpYAoG2ZSAcJ7ULRvvUv/nAROhhMdhPwOy0KXGFX0BHaiWoqSnCfloLukHfL4Up/lu8xl3ZIbSloiCweQKXvHfdrXbLS4buiBbXmwRAjknIkQU59PeeHHoM48jdr9ClAX8QJZ2tzrnxiHSGi5Mw26LLE+14NoouiZHitpHqHxAnWmv0kPAhKvSX68ZBHr0H1OYJYKK2l3zhF2tm4W6ApLu2RsYvUcyZDX8bAT3llNIcO5rrGv5PFUdwfip54yqdEvZAsk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(122000001)(84970400001)(52536014)(508600001)(9686003)(110136005)(2906002)(54906003)(26005)(71200400001)(45080400002)(83380400001)(5660300002)(66556008)(7696005)(8676002)(6506007)(38070700005)(44832011)(66946007)(64756008)(66446008)(316002)(76116006)(966005)(4326008)(86362001)(8936002)(66476007)(33656002)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VLQUxS55/wScf4ou0fHTvPlmb4KY70JXyd8On1QoJ0sP2kdO+O3sdycZI3Xr?=
 =?us-ascii?Q?7DC7huv0Ae66Jl7kOwraWP7LSVCWZixGIsDGsvCfPghc2Z/wcCqwG3lljfUC?=
 =?us-ascii?Q?FLmBTeNu/kRfr8ghEqNPlJfrEva/shSB4fKNagByW1i5NPi//tXXiDLctecQ?=
 =?us-ascii?Q?yTmDkFndSXTuRFOLT53iGNHJL7RSFceeYc4rNhuAUDoPf3ub0GucKXXkBkBS?=
 =?us-ascii?Q?6173oe28ylRiK+4rpGdml1u+Ywdr0Z+gzECVLYx5sl38GLYdo2fwgSJaib0B?=
 =?us-ascii?Q?TcZwjNCUobLBYUQZE4y4Fh0oaa9kTZI2XLmGNblvCvJ2iZT7efKBVkGueWw9?=
 =?us-ascii?Q?YlLrAYdoypBBJgMk5GnKIGKO+SZs8zDDwhbNZYJX0FPN6BzbTzbwIJEfgEjE?=
 =?us-ascii?Q?28YtVMVYkfNCwWQlT3cp/4kJBALqANeUcIqT1yHcgMSuZVS7YA3M0qukbf4Q?=
 =?us-ascii?Q?phM/VxEqdkLIU8qxv+1wWVD+NhEQpD9stgy1NErdrT6PNK+YysS2JYT5n+MO?=
 =?us-ascii?Q?jJo6K68NtGfLKz4QQ+X4FTOu1HU9Vx12HFikf+SOa+WGVAswgTyOmKooWlJK?=
 =?us-ascii?Q?1Z9ac2zvu3aKX/yeTCo6fNQC79IvhRly5DDZqANQZ27LlrfqzoPzmGEIZAHZ?=
 =?us-ascii?Q?ZZKxnwo6kDt+7oQTKOdk79q+aaiCZls/uHuS1l8Tbi+GGcUiqveovZbOwjI7?=
 =?us-ascii?Q?zyeT+0JgyH9V3k2YSz1/whe6PSMmPX1xbeMlVFR3AXOXcK+w4lefCMJ7xfy9?=
 =?us-ascii?Q?jdPy9Bsx4YH6ypbJPkKSxJh1+Ofauo2baxHS9wsDTVCus25yN9Obs+Pm5I9+?=
 =?us-ascii?Q?4y390g5yZbeNx7nOACJoPqofBY9vMa42zdLeRgIxhaU3z1QVTBdE+Qm39M7t?=
 =?us-ascii?Q?TgQtqEQ2IH15sQkon93wSYA0IdAdqhlX/alVYSI7ae+vaYRYxynkxToY0ZtX?=
 =?us-ascii?Q?UphogdfhOEPUgR+XRiZ8qfOzCWekE3a1FLtf0Dz1TgpT/FTiVmPAyZVH20Pq?=
 =?us-ascii?Q?zE6soBpEozMSEpw3u1DaIVt8a2xKvGrnTh0g0j5pbGonmzpXEpSqBb4THEs4?=
 =?us-ascii?Q?C5wAqt82ULv4NWBrrRL4VXw5zW0Z0QTtsnuIl5gdnMAtg+hAZVHQO73o3NKA?=
 =?us-ascii?Q?03MLIuB67DOBWwGUew31+XY3LJykcHxBMOsRogH14WM811+YHkiu6SwHu/qG?=
 =?us-ascii?Q?B1u4aHaQg0wLYEoY5/q8VAe+V0uzp4RZrhkN7xCnI1TA7mBDYq81EEjg5DM5?=
 =?us-ascii?Q?i8kWAp2ndWlTkckgTAjSr8FnxMNhz+UIcRFYAS7txQECz5qp2SX6Frsxt6Lb?=
 =?us-ascii?Q?o7cIb17TUN2Cp60KXlMJaa4Z/zxf9n9SDWCpXFSF3y30wXd8qfGMLcjknDqS?=
 =?us-ascii?Q?wAICcXpH2T2Y9zdE4xn2T2Yd/YfXXwfsAKCaHiSdzossdwYYUYG7C64fcC+s?=
 =?us-ascii?Q?bWqqmZDRpRdILTROkbtvx73JiIjU2T8mXqjKvBJNWLMWjapcrOVcdUOrw4a1?=
 =?us-ascii?Q?sBpmQN57WHLJX1cA49Y0PVFQJEdSNOoJfbegBNvaTCiv5DRIblkJQXQ6novX?=
 =?us-ascii?Q?3JPpuQySQxoxtgOzHw00bam43cFcObZoV3CyyfS+B/gCsxeMdICsEPwzxzxm?=
 =?us-ascii?Q?SX1Cdq3OYJ4I/J14v9in5qs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9992ed4b-0ed6-458f-2982-08d9b016494c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 13:20:01.4406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDTBXcbzmVdRkMplAmhTGkQnoNUUIowxi6uwMkX3P7ThielVINlmiDQ0wTpwdBwczdTYjqToXMv49/BpyGEVIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> Subject: [PATCH 1/1] Revert "tty: serial: fsl_lpuart: drop earlycon entry=
 for
> i.MX8QXP"
>=20
> Revert commit b4b844930f27 ("tty: serial: fsl_lpuart: drop earlycon entry=
 for
> i.MX8QXP"), because this breaks earlycon support on imx8qm/imx8qxp.
> While it is true that for earlycon there is no difference between i.MX8QX=
P and
> i.MX7ULP (for now at least), there are differences regarding clocks and f=
ixups
> for wakeup support. For that reason it was deemed unacceptable to add the
> imx7ulp compatible to device tree in order to get earlycon working again.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
> Following the discussion from [1] and [2] lpuart should not be considered
> compatible on i.MX/ULP and i.MX8XQP/i.MX8QM.
>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.=
infr
> adead.org%2Fpipermail%2Flinux-arm-kernel%2F2021-November%2F698082.
> html&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7Ce5fc0a232dd34b172
> 4fd08d9af1c68c1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 37733358817043520%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdat
> a=3DUVjwiXnV3as43VtiHY5Wppy4PiHqX%2FS3BIVqXedxYYE%3D&amp;reserved
> =3D0
> [2]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.=
infr
> adead.org%2Fpipermail%2Flinux-arm-kernel%2F2021-November%2F698318.
> html&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7Ce5fc0a232dd34b172
> 4fd08d9af1c68c1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 37733358817043520%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdat
> a=3DTERDm6qvf%2F47VwHaJvrnw2z6M%2F7dZ3%2BdesoU0PH8wNs%3D&am
> p;reserved=3D0
>=20
>  drivers/tty/serial/fsl_lpuart.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> b1e7190ae483..ac5112def40d 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2625,6 +2625,7 @@ OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart",
> lpuart_early_console_setup);  OF_EARLYCON_DECLARE(lpuart32,
> "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
> OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1028a-lpuart",
> ls1028a_early_console_setup);  OF_EARLYCON_DECLARE(lpuart32,
> "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
> +OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart",
> +lpuart32_imx_early_console_setup);
>  EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
> EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
>=20
> --
> 2.25.1

