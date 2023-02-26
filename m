Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D3AC64ED6
	for <linux-serial@archiver.kernel.org>; Sun, 26 Feb 2023 10:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBZKrn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Feb 2023 05:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBZKrm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Feb 2023 05:47:42 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2100.outbound.protection.outlook.com [40.107.7.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51081024D
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 02:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSrgQBu1HGjgnLHireVKPXfucRO9HjSM3BpPV5jHmu1/5Q25K6vB3COYzhHYlIUGMe9gmNeB9lR2ufNlLgWTLZLr9x/UixI4++0QjVwapdeQZ3iV/V2P3DHTm2dRtCKlmV2je1tbSpx5J2WtRxrZF23k0ZKNs5m8j2L4b9SUgd4wJYh0m7GGA3Dfqn80xvkMDNyy3rxdDS6rXIaQvaQ7KEK+Pni07GTzC3u1drH57kDAXFxIe7XjHnT0cJq+UTUGvz6KJBjX+g6Z2a2BuYLyGyUDwancl4v3fg6QuVF4EldS7QtBGaCBV/trBO6mnTuajJ8zbIPCm5wVQKhG2xNHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+m4rtf1mDwxuq3UzfjnRABVkV26VxiaSg5BgmsJjxc=;
 b=O6bmP0+fhNwwIMphaap/wd1trE5o0obOTYsirUbuhPyFYBC6s0NHKjUU30Rwbi3DGGpwWhqlSxO2aQlkHZMylDkyIBre5cjukaruyFrU1ZclilN/Q5+nONtsolwshEhQsagHemGPw2qTgtyv3xMTn4bQuXH/956B2ew3tGGBaGm3PpBw53hAPJLKYa16OEUz9zGI50q7FAQDB+dOyVhHgc3FNkys2TMlFnza1Lj73R2jxdqXAJidhzAtOutkGyubObarWtE4jMN2T/BG08+TW8PbWPRLe5PDY1VSl04UnujC4EuPmrLyQC5Meue9WJm0GZc5XItfM12fYnWvNVtgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+m4rtf1mDwxuq3UzfjnRABVkV26VxiaSg5BgmsJjxc=;
 b=KnPplMaMNrUlS+nFOT8l5Y5xROMdjCMBiWYEP8o5NpS0sH2uL553atDqdqccByVYU/oS0U/ZfQ+xIzULrHkGNNCbiDvnSuZ3moYSxT+UpxGJZI6yp2cvrbwjNs5BPK7Tbo2c3rcUuTiNTKfz3mq73oDiU25w9XPciRR6tC20sGh35SvZz41kRfhWRKZHOZNyxp2iL/72+M3z7PjzaUXShYkmbOTqeNvkt15BZHiMkO9wG8YweNMYBn1SRsvabf9QxxyhIWwvUS9toSQE41BQBMICRYtOGjM9NAYd43K5X+xzefygUbP6xjRWJClhc30pHEDI7kkInTUIMQlbg8huow==
Received: from DB3PR0302MB8966.eurprd03.prod.outlook.com
 (2603:10a6:10:435::20) by GV2PR03MB8677.eurprd03.prod.outlook.com
 (2603:10a6:150:76::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sun, 26 Feb
 2023 10:47:36 +0000
Received: from DB3PR0302MB8966.eurprd03.prod.outlook.com
 ([fe80::6c3:183d:79f7:84ee]) by DB3PR0302MB8966.eurprd03.prod.outlook.com
 ([fe80::6c3:183d:79f7:84ee%5]) with mapi id 15.20.6134.026; Sun, 26 Feb 2023
 10:47:35 +0000
From:   Gerz Burak LCPF-CH <Burak.Gerz@mt.com>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Manuel Traut <manut@mecka.net>,
        Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
Subject: UART RX losing bytes
Thread-Topic: UART RX losing bytes
Thread-Index: AdlJy/RZ7+in9H0UQ8muwX0m1bfJDg==
Date:   Sun, 26 Feb 2023 10:47:35 +0000
Message-ID: <DB3PR0302MB8966B89FA30528D5C0643259E7AE9@DB3PR0302MB8966.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Enabled=true;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SetDate=2023-02-26T10:47:34Z;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Method=Standard;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Name=Confidential;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SiteId=fb4c0aee-6cd2-482f-a1a5-717e7c02496b;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ActionId=623fc355-e6dd-4d5d-bcf8-730d51f10117;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR0302MB8966:EE_|GV2PR03MB8677:EE_
x-ms-office365-filtering-correlation-id: d035e1c7-75b9-418f-503c-08db17e6df31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qE4I2jALoqRiZB9X9Tq2yZCM2NlfEq5VNE3plhTv3IxmUqnjliJprgs25W1pUplOyVvLMQdgrKp3EhU2Fc40oIWYLf4Z/ImcBxuYGu83UODM90ayUnFiiOvktYy8FDFX/6o72y8F8QhoOA2KlwNj+19VLjstKcXLWivl5sk4QehpW4ASDa0UQIN6iqh5Lt89qj4q/02aYO5A+4706xSMjGZXtzL2WvWnkS/NCuSmz3GZvPByHrK6oTkeBN8C756/9bmEFL63PMzTiUAGZeAU5iQUCh5j7jSiw0gQQVjBA88PLzhu9IGtGg4jWf1mfuh0ecxe57f7czAPyMsAAigd9gZ3tXZd19kWGeu4imd59iLkY4qgZslsP0c4pyhetnPCTheEuu5rNfrmpRHd3zJIjsxS2f5DYnqLy5JEP8h39QGHEiHSf7GggkCxfsUPYUrJ45oqD3UCJGjACgi4PiEv9WMUo25MMyQB7bPmtiwTqdVCEjaFS+bDTgHkvHv0xv3j5o/Eac8EbnUwqDxlgOpAWryv9isP5uxW9+pWoehmJptbMPg9NNUy/YYyLhmRqC9oHBsXCvbfLAyKQR9YRso7+44vV0WEAg1oYtTDnKssMFyVZj5W95F4DrwgDrZhEGjaLY5vEFxBOGIQ+5bNBLEGO6QpuXCCDYSEJqeEwwt0KoRMIE6xO+UYMbO8sjXKU0z/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0302MB8966.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(346002)(136003)(396003)(39850400004)(451199018)(8936002)(52536014)(2906002)(41300700001)(5660300002)(33656002)(3480700007)(55016003)(4326008)(38100700002)(122000001)(966005)(38070700005)(66476007)(6916009)(76116006)(316002)(66946007)(54906003)(66556008)(66446008)(7696005)(8676002)(86362001)(64756008)(71200400001)(478600001)(9686003)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Eew/XKNCaoTPQ4xDrUKNdATiUj1DI/d0FWVJR2DQKChFVSdBIevDniZp4hn?=
 =?us-ascii?Q?VGbIUMjPJ0fEIgcZmDrl31rRyWQsbp8zhecLu2GCdXLbrt3kW6LDYXofj2qN?=
 =?us-ascii?Q?Mfw9AbSoTs5pjnAojRdaUQxoJgR9E0Nqu1UTT5QLBtOwoR28IrPnGkerDSUL?=
 =?us-ascii?Q?U+izDKrMvtBmn+NnIwMp6KP7NIJertsdM9OLl86EBY5/XzXHR95tcjYJX5eS?=
 =?us-ascii?Q?owIxPOOGA9I0Csc7Xg69EBb3LTHbjUYPLdt3CoMbRZ8kmuoMHIsm3zIgX/+c?=
 =?us-ascii?Q?U2Wc6UbWWFNIhf/3ha0nrjRCKL9N+Wt3Uk8OGy/49XLjgQCv+3syfThYZA7k?=
 =?us-ascii?Q?Bns3ckGmmbH3b0xh5jYs5rPJJjxxVcNUvuvt3iE7kF0NmcU06oTf8kZqD8c5?=
 =?us-ascii?Q?M5cClGp17ZR/LukeEvwUMaPg67T4ApZSzM77uqdhyonGS0NrdNwm4AwQx4gE?=
 =?us-ascii?Q?Yd8zG9idySKFBpdV3jLqUjzhtOvJ3Xd/3C1aNLgS+V9bea/8nkWbIh8wHJPG?=
 =?us-ascii?Q?otREXu4pxfQl5b3FoKSQEK4JeAUBk/3Lpi1kPdfuaAJFV/qC3xINYVmMcdqj?=
 =?us-ascii?Q?uIxGby8q75rQsbEXodLk+ls27QHdXt1UaiwBiR29sxIN+m7cJV9z8DplbTQQ?=
 =?us-ascii?Q?4SVFHR5WxhnK6S0zLFCoUI2HKxu1DzU8Bo24juk7jrSgJXBvaXPLb0cooDlf?=
 =?us-ascii?Q?Fhx2SzUNX22BHOJqhKzONiJfJdrqweijXQP5W5tr2PbKdbjSfFVaQWuQXL4A?=
 =?us-ascii?Q?uXww0APWpdNB43//cK+6u6SagueToIDDLEQPnAoYOSNx7ylwMna/8IcwcnjU?=
 =?us-ascii?Q?qFf9e9SetXKKdAXMZ/Gso7oFwOofjGokkzoJfwZaIWd+eMZF4s3w708jxffr?=
 =?us-ascii?Q?qyRi8AVlsEYRmGABEq6KnXetHDeAMAQ3Fu+11LwKQ1O+6Gt9+NZ/XnbGsRme?=
 =?us-ascii?Q?vWyc6UKY+yekSAvlFzNCAZ8uY/OW8TvoXvpFmn9oMwrjI6sKxdA+ry9z+ta3?=
 =?us-ascii?Q?c2EqYptG+lnbeQgzsDQHUEz7Lq0EWbnBDasPl6EQlZXI7xmzHij+yD2MX6ur?=
 =?us-ascii?Q?LB2Ax0CsROvkR6JfM+pk6MVK22KK/zljoYUGO/ApDga4lWtbdO6f3OGaiVYm?=
 =?us-ascii?Q?HQ2X9w+/g0nuxOliNKnuf2OcO+vqBHXwL9jgKU78Xd7mrPGXsL8ezHCSmeX8?=
 =?us-ascii?Q?X2k5/Z95pP3Btb7RKgjhw/0HHW2e3UzZNQ+hk/B4sD4vs/WXNaUoOzh4WH7h?=
 =?us-ascii?Q?oVWXSxy9BCr3CR3FZC9c9KbievoVtduLRE0pJcS332DYdZKAYfiDAXAnw8/N?=
 =?us-ascii?Q?Y5iEDRHUeHn/bwga3m25YajS1SxQY0b4fhIGstpOWRCldS6uyfFtZp3EaIEs?=
 =?us-ascii?Q?UgkWkhH01YopYdnywWh/LK3i6DaPKOhBlv1Wcdyk2SI+4NPpR4bnOsCRcfu6?=
 =?us-ascii?Q?qCVAZ1uI5kOLt3i03WhIUTD1ttaRoHKOnAjWBSHSsvgJZUTFcObUp1zZybLL?=
 =?us-ascii?Q?b7K/MKePnvlfhebADlSHYvio6ihgrd1WF81P2DMr04nCbfVtgnR8d4A7Iapx?=
 =?us-ascii?Q?IjCbA2mdBBA0vciEduYG5OA0+Sl8MdA6Lz8xkYcOxSnvhnrJWItCCiQzEmT7?=
 =?us-ascii?Q?fEwZWHc2Aqjr1dignM8ncqA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0302MB8966.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d035e1c7-75b9-418f-503c-08db17e6df31
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2023 10:47:35.7212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdLoVLhZd8RcFraAL4hgLmDB0dSB7r/aIZR5M7JEKQqXd6SsgGbZTzInsimvnESdg0C5CSMH6xBBeS3EecqcmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8677
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

v6.1.14 on a Phytec phyBoard Segin i.MX 6ULL based board [0] is losing byte=
s on UART RX.
imx_v6_v7_defconfig was used.

Minimalistic test to reproduce the issue:

1) Connect imx6ull UART with another machine
2) imx6ull$ stty -F /dev/ttymxc0 115200 raw; cat /dev/ttymcx0
3) othermachine$ stty -F /dev/USB0 115200 raw;=20
    echo "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$%-=
.,()/&" > /dev/ttyUSB0

Expected result:
imx6ull: 1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$%-.=
,()/&

Seen result (Many times, not always):
imx6ull: 1234567890abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUVWXYZ$%-.,()/=
&
or
imx6ull: 1234567890abcdefghijklmnopqrstuvBCDEFGHIJKLMNOPQRSTUVWXYZ$%-.,()/&
or
...

Setting scaling_governor to performance seems to be a workaround for this p=
roblem - but:
We are normally using the PREMPT_RT patch [1], and with this workaround byt=
es will still be lost

Any hints how to track this down further?

[0] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/a=
rch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dts?h=3Dv6.1.14=20
[1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/t=
ag/?h=3Dv6.1.12-rt7
