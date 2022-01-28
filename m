Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9373BC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 28 Jan 2022 13:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiA1ND4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:03:56 -0500
Received: from mail-eopbgr60125.outbound.protection.outlook.com ([40.107.6.125]:39678
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238248AbiA1NDz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Jan 2022 08:03:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deM/4bHvqn5+jyNRkVDyv+OPLXnibIC1Weh6zKuOHPdLNd7la9ANwKbMQLW7GutGqXDB1rLf9crKOVg1A0b6ncydKKBkBQPXOlbTWdXpXHWUMTu9R6pv0svtZ+B/u/mq2id6RbRU/vbJ+5jnsHye7+WJ2go+faxWiydm+nKTPFO75F6RWPsqbkXWmhED0BZgAdY0nsEh5dmCeHIjyOd6uwWQF05wFGUjvKd8u4OmZ50Ok3J2XADAgpHvHC5GIwZ3ht7yrNUI6RntKvlBZ90j9NasAzTqXLwb93XOlTDkcI5ypI1H8Hk5CevSCoy/X72lVcOymW1KLlpm7LpdzuVQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkKTET4x+cLNkhHCu9Wd2IS4MdtH0dLGoM8FMNkYpBA=;
 b=UO4leF3b+qhh0Of8MG0KCI1IVE3zTGwy5tXrBDDMdXkFRYQYMQHJxbRhx2dz5PnABmPyDtbC2mhfj2rD4pNRr1EiML2h/POeYJFJ8sgDAijLR/C85TiH4zoyWD4cQ9qZfyuiZEWkrLWbZYzzSCMRtpqoB53CUYHmEsdnppfvKkslnYr9gri+0hxZdg5WRThGtErJbAlGg/r4Ymp96l3z09gW1Z8YeHhK70oTleCAfRZlDBYeSvU2syHlma8DJKv9gd5UtPDniFwwdJj8zg5qtT3ZrZbeS2z3oaE28bLmIzTDITTiCUWB1ciPfYoSPOSU0Bagqnbx71XU3FA72RbkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codewrights.onmicrosoft.com; s=selector2-codewrights-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkKTET4x+cLNkhHCu9Wd2IS4MdtH0dLGoM8FMNkYpBA=;
 b=SWOOJL1Py9trfaVdbB3d2bbP3Nk5i+A+5oSWG9IqzpMchq7nev4MJMDavTDu0QpeGsodk776gf+g7j2vPbk0+tFxd1Hoj+B1A6MpC9x/rW+VvYXUyVKTJGBAswFx26yMhIwOvAvI54tVmB5sgtzBfqln8ZbtwlsHKLZ99q/bnpw=
Received: from AM9PR03MB6771.eurprd03.prod.outlook.com (2603:10a6:20b:2dc::9)
 by PAXPR03MB7593.eurprd03.prod.outlook.com (2603:10a6:102:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 13:03:53 +0000
Received: from AM9PR03MB6771.eurprd03.prod.outlook.com
 ([fe80::3422:f3da:be12:3ffb]) by AM9PR03MB6771.eurprd03.prod.outlook.com
 ([fe80::3422:f3da:be12:3ffb%4]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 13:03:53 +0000
From:   Benjamin Ulrich <Benjamin.Ulrich@codewrights.de>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: response time of serdev_device
Thread-Topic: response time of serdev_device
Thread-Index: AdgUR39xXvO81U35TDmtPJFuFb7UUQ==
Date:   Fri, 28 Jan 2022 13:03:53 +0000
Message-ID: <AM9PR03MB6771AA9FC0E036F21320400893229@AM9PR03MB6771.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codewrights.de;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a050246-de47-46cc-880f-08d9e25ea2b1
x-ms-traffictypediagnostic: PAXPR03MB7593:EE_
x-microsoft-antispam-prvs: <PAXPR03MB7593252556675A56BEE0372793229@PAXPR03MB7593.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AvCSmA26JSVyBrsLoCov/GEZperBujLDnXD6NstDLkCzHXex17wp5Q2Yissu3F6UDUB0VZOn2qrnbDoqxCkgUirSvwnA4flr+tJH0ZDaPZfop6zfcIku9kBkzE7WgGYD0JNb5kL8+7fdGyWWhHw4z7yI/3reDD478bdlb6ITMClUgZ8Qh/LJD5IYsHoKf9i2uLe1jEl0YvSRhc1QyMex1eOo0abmP2goTI/w8VtysALWGZBHsrHrDupZQ8oz9Nuc8gO2kYEx8WhPb0D3Dpyj3Lgk7atzQjZz8gX5d6SWdYlpdoNDotAXRFFIVM8lkroa2p60xmSgjAa0Xs3CRoFWz7lYrwFbWA0RTwtEJcnVVEx+MTjezclnxyB9oe86esWdrxYaZACvI8ssoVzM2WjtnLGNSNQbs9oCD0zRkzxNIln+XjecOJv6LUyOxQN7N9iXYZ4WgWr/EMx2/jgDF28Zi3ZyVe9uWcd533FcgvkFFDqOuXmAcD7PsPifhFgn39E3NycnF9fcFtDdf2U+1b6CiPYi0jtFNnnX2aWL3oBiq4k6rtMbQVOkqHBMcUrE0LUdCwErsU5w5z7EV42kBWLBdDTkRLB+B6+LEMb9NceF07YlC9xxMeLPiYkaYubeakQUI0zLYJQ/XnYsEj6yu/Kf0fgxPwLU+1mA8WwlBfNNIu2LCsiC77t2UDOWHxVyS7BywV9+wRBk5wK2XvO/bCHXoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB6771.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(39830400003)(136003)(396003)(376002)(366004)(7696005)(38070700005)(6506007)(86362001)(508600001)(122000001)(71200400001)(9686003)(316002)(6916009)(66946007)(66556008)(64756008)(5660300002)(33656002)(55016003)(186003)(2906002)(38100700002)(66476007)(52536014)(8936002)(26005)(8676002)(76116006)(66446008)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6CV7xH6OrXkuzE8eG92K3O2YtNCBvTVJQBfUiFLuYtaFvX+6LDQUCvFtHxV8?=
 =?us-ascii?Q?i5jPGRcOvoDc/JZ3s7pSNsZcNHzZVRtHlAgK1p1YeIje5kvMO+Kof0GFWEg+?=
 =?us-ascii?Q?C99oQYoYc9CRo0IQ5s/63AasJfc7h+yjZT6dZ8yyV5jJBIpp1DedAe+5+lFX?=
 =?us-ascii?Q?qY1MzvjimoCsuzLyPkGzMwJ+8Li0NMRMbqAYPEmzKxHH/kxl9myIwicOwBuo?=
 =?us-ascii?Q?BLij7iJPG7UgHy3mN11KNzjLGPao4bJAmOZXUdys3m97TJqLBcyx69kyvLqV?=
 =?us-ascii?Q?SEFZm6c1ioRVaRKbcrXsvWqQ27ulxB/aRkeMT6GixVL2ZL1w3I3HzGCEqIgB?=
 =?us-ascii?Q?SrwCbK++VuiqW6jtbOzwvutLNEXeo+rMWtCeJ2yxVOQA0htjxeBQjL5QweER?=
 =?us-ascii?Q?UP+25sNWbTIt8Wb+xbQwsGxabIuBmCsRg7O1wjxBfBEQkTWGYhNWE/2b5PL3?=
 =?us-ascii?Q?CkAyfrsLztp8aJ80Sit7tr0xcMGXbd+5qoVsyhDzwalinsbqpt6y8zdr0RtP?=
 =?us-ascii?Q?xSZoV4vczwTP5oGmNv+YcRlh+ImWXJrQExZtnldLsyooDSe9nuv6FxU6slQt?=
 =?us-ascii?Q?UdlcLK1Mqq9UKGp3IQcnR9R7W42/sR6pz5wRd8xBvu6UIWvu0lrKoCT46x8a?=
 =?us-ascii?Q?eDJ6TelZSIg3MePvqkfk8URmAqG/zg4xecN5IQxjocFCwmdqbZ+foAj8qCWX?=
 =?us-ascii?Q?jTB3wHdkFUIB12Hf9asTStdJ2fCOVmTWBJ2gaafr38ox2x7EVzFL26WIA1uL?=
 =?us-ascii?Q?OQ9cOexqQMrfj785A8TNDD3cR/o92a5M1C522fr6Miv+wMDuprrDaP09ydA6?=
 =?us-ascii?Q?C7/g/yNbfkxzCxt80TSsraOlotYHi2NZN++YvBFlYdjTZoW3TpF5A7JuPz2w?=
 =?us-ascii?Q?D5HwXz98peK31+qdszFriyS1sXwErwCfzGQ+KutVH8CK4S0SlxUoAKHa2E7J?=
 =?us-ascii?Q?xXOfYZeOwbnIGJ3sF3P2QFVIJAyStsT8lRY2c3WpABj3tCXtDJJRt0BZ3CSN?=
 =?us-ascii?Q?xYZKStZHWZminmvmaN1uQqeiQ3UsjdPB6RGM9vWyw2HOhGNIiqK+A5aXvTfo?=
 =?us-ascii?Q?Cmtu1GaFRJs/I9Zg4wuAGPPjqBWKle6DsO/N1nh8F8zS9Dh+76MIaB1sjjXg?=
 =?us-ascii?Q?T9p6LV/TpwYMVvVIXTtKFEaC2Aa8faAVNl8cjAShdbKvkZ0BCyaxQuuSenhz?=
 =?us-ascii?Q?As8dfsr9J8kc5R8oDd69Tpb1JQ8+Uy2oSnnSd14Qu4NtUrtebVg/AQavRcEk?=
 =?us-ascii?Q?IleijCEY1G9/d70Zx2NB5XdRTyHDg3QM0M/Egms0kXl0WQdK8XO0qTEu4Skr?=
 =?us-ascii?Q?jo9t3uCTPHp5Jz6gt8EpBAm6crJ4PiuqvnWKM1xOLcT2fhdgyy/GZyPfZCC8?=
 =?us-ascii?Q?I7Y4/CXnSZl1QLlF+lJT/qGr3P7JBAfCahRuF46Q7tYshR1i76DZRDrSBXTz?=
 =?us-ascii?Q?NDWMs2CuYWiN0H87Rh3ZG5KaPpUCIRRRkmWljqOaZS2TvSaXexdvaWEB06hn?=
 =?us-ascii?Q?v0X1+OjGG6WIj5fTvZXlE7zIKBQDRDAKledl7N+zd6T33MZjMyqGiGNeNmuX?=
 =?us-ascii?Q?L+8wuKpIi9BLFCiqlCiDHDBczwE0+c9QYbLzrw+3Q8JRiwrnLnannmW8Kq2C?=
 =?us-ascii?Q?nsQe/zrFUIGM5e59w+4uNO2AzjjaLZ6bfjVdut8/kiXGoENjeiabhl+yEY+t?=
 =?us-ascii?Q?JwWfng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: codewrights.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB6771.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a050246-de47-46cc-880f-08d9e25ea2b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 13:03:53.3201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0974af9b-352b-437c-b606-e9f242c0c227
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNnC5REEMZ7kVFGUo6tK+wNCEGt6sBiGX+Msm4yKBwca1D1N2FL3hPs7WrBuScAP+Lp15kZt03KV4m080t0NdwDO3O6gqcVh6CTxyCLufik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7593
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi all,

I'm using your serdev_device kernel module because it fit my needs pretty w=
ell.
In my application the response delay to an received frame is time critical,=
 because of that I made following observations:

When I'm writing an UART "echo-device" with:
static int device_receive_buf(struct serdev_device *serdev, const unsigned =
char *pbuf, size_t length)
{
    return serdev_device_write_buf(serdev, pbuf, length);
}

I can measure the response delay between the TX/RX UART line.
On my device (IMX8,with preempt-rt) the delay is dependent from the baudrat=
e:
19200b -> 4.6ms
115200 -> 1ms
256000 -> 0.7ms

The result is very surprising to me, at least the baudrate-response depende=
ncy.
I know that there are HW-Flow control stuff for Half-Duplex communication l=
ike in many RS485 applications.=20
Is it possible that there are some old configs left? In the function: stati=
c int ttyport_open(struct serdev_controller *ctrl) the ktermios flags are s=
et properly.

For my driver a response time of 1ms@19200 would be really good.
Can someone help me to archive that?

Best Benjamin
