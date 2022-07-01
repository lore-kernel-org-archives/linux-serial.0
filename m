Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E857EC43334
	for <linux-serial@archiver.kernel.org>; Fri,  1 Jul 2022 08:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiGAI6I (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Jul 2022 04:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiGAI57 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Jul 2022 04:57:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2109.outbound.protection.outlook.com [40.107.117.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF6321813;
        Fri,  1 Jul 2022 01:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aU9A8dNCfSf/dYbqQUMWs86xpp2dNaXVqyLfIlSHJaIRuVhprXeSPTOBUVG9A6hzT5wgNCZIx7uBvPwud+dwbeQG+pQlgHEc6khBh/96q2W9I/DqGRnx/Opc64HAsuB5OD1uOwzGFPuP7lSsPBA9PY7rpvEHPIDZ/W2esN9RZ2PshHtD2P/anp6uMqFz7W/XzfA9AAFSLjljGH2EMPPyPRhS0lKpYgh5rmSCWBTXpOg4vbsccDjFVOzkC/wzuivJ11IQD4lmRf0pAjF82S4WL5RJQ7MiVQwtaenSbVlKh/SjHBnSjEMT6ERW+nG+dVI5r74iVSefv3YFM8LhFdEFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTYGs285OhliNocKjfv30+vduphzv6ofPaoXzjht0LM=;
 b=m4RMaMQmDp9FPMCs9iv9OGCLZZDYhTkUIS7nNvYFzVPZMMuLm7xgX3ZKjBo5q0XdefyeQN4ZSgrZmCUfa8W2E5XXdcVYRkMXwMbC8tDj6MULiOY5As9tPTMmDNZO+9hY/mfmArWARmhufyVpx9fs0QQdPEBx3tTJiUT4K+PTbK+V57yqqCCpGG5PxU5qO7yUGmK4PyyqpnE5JR/G/D8ys5VersIyxsd4ynj2kuYTKiJJv0o+Da1YwHvLP58Z61NlnhRVMnaa3ikb1Dzj4TGlzfB3tzOFABqXC06+NkygWFqUwV8XfBMEkoEOU8/y/sPqgUOQMeQ/KawD5DLTiKylfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTYGs285OhliNocKjfv30+vduphzv6ofPaoXzjht0LM=;
 b=GEcMmfQN/fCuESpcqJsx7ca5ySIbHww67K2IOjM0ktlpp9TkIC2kZGInfNCD6p5qCEFTKBJK6zUgbSDDOTJeyaEL2cimaaHVhbRPhnb4kGRTpVHTxMeIweb4fmVRBdegh4E2GoLBLZg1jeEZprJJlKaA8JevO9eutsQM+Ipe/wYZaEDYTEnqlTWRSYzBI1kFQ/+Bf13xmdbvbelFJj+ZwYa8OI4y3XWL1nT+O+Iiek52h9jyg1MNSoUQbe+86fw32k3xjGlN5RGrThlmyM1d1uS62EuMOfTUJGXyDIgg8gNc0R9H2Blc+CSqd6vBzKciviHqvoIJZklD40XmmKKOXA==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SG2PR06MB2106.apcprd06.prod.outlook.com (2603:1096:4:b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Fri, 1 Jul 2022 08:57:51 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5373.018; Fri, 1 Jul 2022
 08:57:51 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: Questions about usb to serial driver
Thread-Topic: Questions about usb to serial driver
Thread-Index: AdiM+OnNdGp6/p28TOGY715mtlYERwAIYqqAAANDRFA=
Date:   Fri, 1 Jul 2022 08:57:51 +0000
Message-ID: <HK0PR06MB3202364874FC7283767C05D280BD9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <HK0PR06MB3202C7064582E6CB027237BC80BD9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Yr6fQbeo/FDrBmfU@kroah.com>
In-Reply-To: <Yr6fQbeo/FDrBmfU@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 276ef34b-c47e-4d78-88d7-08da5b3fc756
x-ms-traffictypediagnostic: SG2PR06MB2106:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPg9/eZ3pwZJULGj33vYbxGMKBfZ6TllZcC3pbJtti1ifmU0ryHX9EhaeIWSxwZM5a7r6TduAUKeiejPtFgZ5k7R6wizo0+kwm4FDKcq2Y7vbnWUSSdCrgezPi3oISEBkzCi9GCdJsqzKNusmyYluTwnby8ylyiiP/xygtbTIXogX6XoaccaIOhswlj/VdUjcLfjJRkTKFoxY/dYTaI6GPSYoqdWTCoXfd7Y/cuG5fFz/0rsFWPyJWyRbon1qogDg5uJwrEbhap+TrtKPKw/vhY0J9HPYT3gNhoQgB4js09NE6G7RJqWWBnoqoQxT2r27oNi4qtVy4unwPu5LxTow/eMui78b21Bi97xVfDzCeat0QbcXwrsmXdGXDjMKS08Jvc07vKggXwoESLc8vMa1M05LziTW7rff4CZO3LGA5rNfl5io6QaqL1BJTW745WGFd4wXpIjajerL4FQ2A6TjkiVFZuLI6ipezyb2RUzHc3zaXWc1nnrK9knGhcZWBU+LY5phrhjX2wbSU+T/H3SyAlWf/mtXm72OcevDmatS5bYyL0yTWyzkEXm+KsX5JeVBHZdT1Q1sFy1i1Y1TraK85PPssY8t4uu0hYBq/Z59LnDjuaryWf923lzOGVz/izxT11o00p7//gWIwIFb1btCZQFlVGCypyaitWDrz0q7DOJN577HJ7WdUFo60tCbcgSwjrQ/IHDh99ghRS1eGJPkcvRm+sqmKJ05cdco8v8QxrVQck5t7OkpdqxEU8G+hTPZ75eiKluQttFir2aVMbZYZrcBIcEb7nzVu3+OkG84HG5DhYyXYe7/EITNCSZAYgl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(376002)(39850400004)(136003)(71200400001)(186003)(478600001)(55016003)(38100700002)(83380400001)(4326008)(64756008)(38070700005)(316002)(122000001)(6916009)(76116006)(66446008)(66556008)(66476007)(5660300002)(7696005)(6506007)(52536014)(66946007)(33656002)(53546011)(9686003)(26005)(86362001)(41300700001)(8936002)(8676002)(2906002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HFuSzDjasehO1HrzCv+daMFWm/aZQwmKTsPUvTXFjh7Je7YZ/wzomYOVvjJu?=
 =?us-ascii?Q?2bmvnO/EIQW1mx6+ubfPq6Yah5HYC4D4HW+gcRgR3mgiEAFc0yHTQKECzRia?=
 =?us-ascii?Q?NLDims41mADSzPtu6rcundwxqWn/88v/G87f1vUdrONtQsZvkdsSohm3J7Gp?=
 =?us-ascii?Q?L250RnNDkap2l5E9bBpeNNaM8djoadekoVGDB88JZ2vJY8YCN/zTIi5QryZ9?=
 =?us-ascii?Q?L097l0TDv/JFO6NGh0JHlxsLHoMpCEaaxZldeqrKq6WUPpOF5l5Uta7Vvqql?=
 =?us-ascii?Q?t/oue497AtQqjQsD64cYIc2/4popq8bI9LXAOeHFtqfys2XiPgUogWN1XWUT?=
 =?us-ascii?Q?mViHJyAB7bnKzay8rkCXA5CsViCevBvNaj7NZmVxyvRMHxrQ5qA46Srn5Ldz?=
 =?us-ascii?Q?gVwcTItsp+rFMKFKX/A8ltJEqN5VwZ/rU5PFf5U3STmYCXHCgi2atCIWcVmd?=
 =?us-ascii?Q?1mwAw4OXLYiakAMLSeuoJGllvG6lrbUXtG7UgNdv6PMlvL3dzQuVuejUVtSy?=
 =?us-ascii?Q?WacvjZOxudDgQoycXo08KjF4TD0IPPQH6C5SXiNtsgvtWsyyUZziSy4G895a?=
 =?us-ascii?Q?39iDVXcRZdl5CUFLuWsAWIzcOybN0g7zDVhUwZAkIa4a8VbyjbkTZIbPVbjJ?=
 =?us-ascii?Q?aHvWQ0Z4ijqTukIhNNi9PAHxEaV5/1fSvi41AVuGQtsqtL/dw2EEmEv5Crsq?=
 =?us-ascii?Q?TJ6d0+9q3F+pTVkqyozfwKin+Kc1DHWmasK+PY98wmm230AazBR4WEGmShLe?=
 =?us-ascii?Q?KHSBDRM8Bh35L+mS8L6jSMA1XQCYO+pW1JQQFCGmIqE4FM4VpZN2nlfiG6yh?=
 =?us-ascii?Q?nZQF6XXwVtSteu8aq7yubBp8AMQAbrTdgKHX00UUmxJVodE6hB2pUmfkzkfS?=
 =?us-ascii?Q?6o8hpDsA2OZEXKP/kahrM+8vVOnc2YFWD5r8kGMZKP9BOYve3lcB4LlevZe+?=
 =?us-ascii?Q?iE4d1JbkK0P4L7rMJBJ7dhbhg8S5G2XnY/IiyZ+AD+Rs/C01KqEp52Dh07MH?=
 =?us-ascii?Q?uyGR6z77ZP0zRmbhuOVMZFqECbFzmFMt9hcVSULCYVBCAvxMBFs9nmd51fE/?=
 =?us-ascii?Q?liMWQ1rZy5ve/1/C8OQ32oIWlxZIfyaKqKVnRq2xRjfFrEy0hHyaLld88RfP?=
 =?us-ascii?Q?NCF9ctx7lLHSiF3GmMgxM18xcmEJ8+h2I+j122qzLiRNrAuXPp+Mrlj3h8+e?=
 =?us-ascii?Q?kAwbw5dDU8frDEyotFxICc4OcKO55bIQx5zovNsgF4G9OjZaiX0kzf1UFD+2?=
 =?us-ascii?Q?z/G0Yo1U1Kf5MMVeUVHmTWtFFF32QfvZm6yI0nnvby3YqCsz6CybT/5WxXrG?=
 =?us-ascii?Q?VA6uhS4bmKurGqho7/4cBiZTbiaAkTGmb8WuF253Ve65Rs2dZb5H5Setqbm6?=
 =?us-ascii?Q?HCRhwZqO/Wbk8FHX2gAcKFh69kL6r5g9meiKMzD5oqnLHIdmCGaCTg31IgnQ?=
 =?us-ascii?Q?8zFJQc9yuVxAVYbgJGra3Y4AD1RVa8rO/BfInugsxY8hihbFh+RPncxESdoX?=
 =?us-ascii?Q?iY7Hlz4ejB1sjXwEK4iHHF5kStBOORU19W9KTzKF0YVzFNS0EzaCg9MsCoKZ?=
 =?us-ascii?Q?4kEyL7DPZ6XXoLK3P+d3r1SaOr4QhuZ8QWuPAYqF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276ef34b-c47e-4d78-88d7-08da5b3fc756
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 08:57:51.1594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpTYBBHvLeFY7AiWM4q2AUXX9GUpzijpFbV1PuuIYIrI3IMcxtLvL30L6Kc2KFL8Ya3awLDC6LZGWSac0K1pEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2106
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Friday, July 1, 2022 3:16 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: linux-usb@vger.kernel.org; linux-serial@vger.kernel.org
> Subject: Re: Questions about usb to serial driver
>=20
> On Fri, Jul 01, 2022 at 03:16:13AM +0000, Neal Liu wrote:
> > Hi all,
> >
> > I have a question about USB-serial and I hope I can find the answer fro=
m
> here.
> > I'll be appreciated it if there is any feedback from you.
> >
> > My question is If I have a USB device controller (udc) and a uart
> > controller (16550) independently in a SoC, is there any usb-serial driv=
ers or
> applications that could possible to support/connect:
> > -	udc tx to uart rx
> > -	uart tx to udc rx
> >
> > Any chance I can make this SoC as a usb-serial devices?
>=20
> Sure, use the CONFIG_USB_CONFIGFS_SERIAL or CONFIG_USB_CONFIGFS_ACM
> build options and hook your gadget up to the serial port in userspace and=
 you
> will have a very expensive usb-serial converter (there are very cheap chi=
ps that
> do the same thing if you want to make a simpler
> device.)
>=20
> hope this helps,

Thanks Greg!

What the detail steps exactly for "hook your gadget up to the serial port i=
n userspace"?
Assume my system has:
1 system uart: ttyS0
1 uart: ttyS1
1 usb gadget cdc acm: ttyGS0

How to hook up ttyS1 to ttyGS0, so that I could communicate through below p=
ath.
PC1 - usb interface - my SoC (ttyGS0 - ttyS1) - rs232 interface - PC2?

-Neal
