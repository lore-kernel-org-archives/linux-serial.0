Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2B8C47096
	for <linux-serial@archiver.kernel.org>; Thu,  3 Jun 2021 07:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC3460E09
	for <linux-serial@archiver.kernel.org>; Thu,  3 Jun 2021 07:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFCHFQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Jun 2021 03:05:16 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:57778
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229567AbhFCHFP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Jun 2021 03:05:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEZNzVOcZh1Z9vH0UlejBSGkVoroPSMYXYcGrgCgOFABXVEk5G6MDIvQ94T2eYcLq1ynhwFAugDdmA6SiqwkV+X/XkZi6Vx1R4kCSpG3Y9xzVClX1FNPF8DhRCYY+GO6GjtFYFM0y/schweRI7oguCZlE4+CMwVKCFk7mbBgPyqJbDAmelv9Q/hVOMrGAMRwFAk36OOJiAFOokfBAVL9PtjD6MKJ+0cKaAj2IfHKlBFS/LxUsjQjT6+VreEvsu7+z4SucLLbd6wvw69NGn52GS4946EHvHrjujcUp1wdZGUCGGIZPI/yxNWJHfClNRBbPX5J1kOUso0bijgHY9ymXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNOW8ZqUvjSxrofCyt5TucevLePlj6NZ+ZuWyaR6GAg=;
 b=PA3nUQYqTnFDD0xLVg3BGJ5lBCzH3I9mq5JRV9OeY0IjwHLgguPYn/yY3RKboiG/YakNYd66aD2atjQ2xF3QT/gGiK6ESNpa4AeRoviZuvhtpEd6reOJbbizQsbLOs/S1aQwrGVjpv5F0EQ6w2h93F0Gih8qi8qYXF2i0X5rXmoLdBX5EVHhenjOMxHWJ3LmZcegIvCmFXn/tWRtOkso1w3DU+VTBR+wWic/wk6X+FLWqeaN0etJ1f1MRSDw9rbCMKGo8qk7a38U6HPNNeijh1MtlrVcDhVJzVKJG8uzX2vmCd/S6FXMeQIX/WTp//36zRHl1dYLNPGoph2iY4GbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNOW8ZqUvjSxrofCyt5TucevLePlj6NZ+ZuWyaR6GAg=;
 b=ZYuh3Df3DuH74HAvnRnPwoojFFLmgHmhn3UILdSnsI9tX1bwxdZk/oYLZNB2ynnEvh6Vkf4l4LKJSBLqUIbt8+YlTTaDw6EA+4XN7MngkGYfOoEZUmMZgjYqyO2EA1jlsiGQ/6wPT05vFppNYTLBMnDo7npZAICDWdmAznbuI2Y=
Received: from SN6PR02MB4093.namprd02.prod.outlook.com (2603:10b6:805:31::31)
 by SN4PR0201MB3439.namprd02.prod.outlook.com (2603:10b6:803:43::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 3 Jun
 2021 07:03:26 +0000
Received: from SN6PR02MB4093.namprd02.prod.outlook.com
 ([fe80::e020:cfc6:6016:386e]) by SN6PR02MB4093.namprd02.prod.outlook.com
 ([fe80::e020:cfc6:6016:386e%6]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 07:03:25 +0000
From:   Raviteja Narayanam <rna@xilinx.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: Need suggestion for 'access_type' of AMBA pl011 serial driver
Thread-Topic: Need suggestion for 'access_type' of AMBA pl011 serial driver
Thread-Index: AddYOoJ1+f35KOMhSAyKzX3LNtybFg==
Date:   Thu, 3 Jun 2021 07:03:25 +0000
Message-ID: <SN6PR02MB40936F8F2879AD5CFDFC80D2CA3C9@SN6PR02MB4093.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [103.106.181.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a8f5509-0f9e-4b3b-8e6e-08d9265daf03
x-ms-traffictypediagnostic: SN4PR0201MB3439:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0201MB3439937F825B8517D89DF44ACA3C9@SN4PR0201MB3439.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k194QuhTsYElJcd/UWVOZh5VQxQlQt9XZvfXwVTbkl40HQHdG9vGn/7lTcjcWOAUlivNvKFs+rAIr1haTp+3s4BBtya6ozEvBT9egrZSh8VVf2pC5g1GUA6K/TQCuY5SNKwpjO8CGHMrI1puAhya1sIuKpH55u9/v8YvkR1zl9ZZwFi+evUn1CliJ62DZbrYDgwojV8AgWMrnpUy2GPL+6JMJc57O4yAFgT+42B3ufB/0v1jsjNHKDg7WKdNCR6VACsfwwp36+GyHUbLYncvwY5h+YpGN2/OZ9YIR/bfjEFski4Wnj/F4JcraDHR3zrM535HqQluq2iO+DBEGvTlVjfrHwnbju0IgHwskKuGPPQ2lkcIPkfkpvmuy5OyWhG6bGILkz4k3EVHW6SoYdxVLzB40gCXjtKx4Qz2FHnY/UkZlsn2BS/2rflCY3zQzC/H7OxmcpngG4iQn6XZuqYqWfRVDuzqAjpe/gNggZOkLmeAoQEU0cndEWJtYe8OJuJjbutC+v6hNsvew+7T5MW0CCXlTzsFsFqzv+WKvJmYWYbB/nGB+ybEfSj64Dw8pxSRGhqyx4gG655ldQJ7tZns6f7+SOWHmNilQWWDLv1A6OJVLnZdRf4lbG34XBT/obIDfjcojSL2JM0lgtRq8uztGoV2zjSnSJNZq4XskydVozKMyfzmCzKpcw5RQLWTV/Ba55OZUorJLmSW5OiQ8dpN+Iwf+byQkm/yQE0tM6WyKII=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4093.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39850400004)(396003)(52536014)(83380400001)(8676002)(71200400001)(54906003)(7696005)(86362001)(4326008)(26005)(66476007)(33656002)(107886003)(2906002)(55016002)(8936002)(478600001)(38100700002)(64756008)(316002)(5660300002)(66946007)(9686003)(66446008)(76116006)(66556008)(186003)(122000001)(6506007)(110136005)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JwJao9ETlHczU0etZXObFL0aeyFcBottlD22nAJhSU25wOKIxZjREodIh4yB?=
 =?us-ascii?Q?7MNN+kcg1Min/GR5okOvSwEaMp9ZWinDEHmJJ/bt1WFkFyDzhb5fhcHVDbw0?=
 =?us-ascii?Q?DYAxYl2BuDweSxj85Xhc7iaVF8ZYieWeN4/C8h+6NTL8RuAwOGKoRf1o5hgC?=
 =?us-ascii?Q?pVwnSvNIjzjd29JWM3R2aaurV9S195jCvv7gmwxz3smvj+fCMmdLtP1qhld9?=
 =?us-ascii?Q?ZmWjaaGRrHZzapug1JAsarQmo6/pnS//7WPP85ywrsc9XTLQ8LIXQnkTkKU1?=
 =?us-ascii?Q?yjolA2Y9msXUt8mHY4bzO6XXDGUl9HqNPOE3gGf0aTHvaq8MTZMfXWJY9JJi?=
 =?us-ascii?Q?6j+czM3E3Qsdoo5TmtfkmJ08dVA37PL2YEw8KPWa/oYTUmAqy4HbvWLKQrZ1?=
 =?us-ascii?Q?6s/0WMSILell5hzvl82WqO2bMTRUB2BtQaBebyxX4IZhhaQoFYdI0q8YSZop?=
 =?us-ascii?Q?vtW3qIISUmlSjdXNZ/LT9JTo5qc0jFaMf1TiQ5NZl9/+Fh4XqOvqNATib19y?=
 =?us-ascii?Q?TcCjotfzpmqifPEH6AZlidiW2dOXTMMPVl4McgM4+skssYCLfuhRtmUyHmv5?=
 =?us-ascii?Q?OrTXxB1niBktkGWRqvn19bHJrEE6caFgnXFUFMh4Jso+zxRkSRF5YCvYZ9n2?=
 =?us-ascii?Q?8zizYPYoOoUJzqGLCm5NUhTzypmFHQxQvQisxj6Uo68fRl/f3MBfYWKxZdwq?=
 =?us-ascii?Q?bkxkkoxBgTTFdMWYE0t0Kx0UQNXgpI+naos0Wc686NvO9vHy7QOQJNdI7uyo?=
 =?us-ascii?Q?qKEVk3aefF8r2xpTzHvKWhzUkasZ7mO4tv14dtqUYUmfDKawl4VgelhVs3kj?=
 =?us-ascii?Q?Bz/jk3wX0wXkD1wxCMMhv32Pp9iA2EhKSrzTuUn+mGM53PsFwQuuG5iRl8ii?=
 =?us-ascii?Q?2C/0K/gYjsNJOkiPUN7WRCks8OjxUPn9tvncMl2ugoek0d0x2OJd7bRrfDdi?=
 =?us-ascii?Q?QnaaextjdasU8TKKx1qtPpwMVQJjNYro0oDYArL1BY/W6uLiUT5pdsCYKUnz?=
 =?us-ascii?Q?mFmiVnF3hkgb0+dhLv1QljZC5SEYNsIW9ZRrIEVZrjr4WrEpQ61t4X5HidkO?=
 =?us-ascii?Q?DFxbZyk1wozXHpzBDGH6cEYUh3kIVlheTTbWi7RGq0nDYxvSiNT4YbApG7fU?=
 =?us-ascii?Q?DTR86RrgBUEYr9V6+6kwjzSlamnP4T9vU276COxaC86X/51hvmir7+emKEUl?=
 =?us-ascii?Q?TL9J9jRDmowYcjYa3+ULKJSYIO2mRqKDqO0lAuqhG8k+VBqaao8UoCaZKEzs?=
 =?us-ascii?Q?Z4BITYOgO7q24iJJH7ATOSUM+1n4/s/V/rHjSdJ/sOQiv6tOahzTTSCmSdsH?=
 =?us-ascii?Q?6szOeHHTY8lqlkL7BD8mBJYp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4093.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8f5509-0f9e-4b3b-8e6e-08d9265daf03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 07:03:25.7307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgSC61khf3opKUT0f+prabYU0IBkGx66LhYx4eHklEnqyNa+blVnMWp4Fac4Fyjs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3439
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

The uart peripheral on Xilinx Versal platform is ARM primecell.
Our environment is 32-bit access type but the ARM primecell uart in pl011 d=
river has default 16 bit access type.=20
(https://github.com/torvalds/linux/blob/master/drivers/tty/serial/amba-pl01=
1.c#L2665 access_32b is false for 'vendor_arm')
This is causing asynchronous abort on our platform when any UART register i=
s written from the pl011 driver.

Need suggestion on how we can address this issue and if the below approach =
is fine.

As this is platform specific issue, we can have a new device tree property =
(memory_access_type), specifying the 32 bit type.
In the probe function, override the behavior (uap->port.iotype) if this pro=
perty is present in DT.
In this way, we can have support for our SOC, without breaking any legacy o=
nes.

Regards,
Raviteja N
