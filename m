Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BFAC4338F
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 02:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6624610A4
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 02:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhHSCDx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Aug 2021 22:03:53 -0400
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:63150
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235579AbhHSCDw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Aug 2021 22:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivPfBROToeqZ7brIO3E8i+bKQs6OOSCtJZujaigaK7Y99N2hIHf8c6VtcPdlEdWEtMZCETej+RgxxpAtv4tb4jmoiS++SQoXKgnQMe4W1LPrMEzdfO7iwx/HCmufLqE2f6xGQh7JPFjzpspiDBoTiSunAtuvulYf2yQNn6aoabilMVbpfgEAHhbXBt7Xru+x8/ZyfJpv6DjpfwxzRaYlnb3Cv545SWRG/5Eh48B5eQDaWXNsspdxOzv7dcECbnSuGlUhJEF2v3PXAg0Z1JDCmuru7WQq/eprHCoBqEHNrtOY5anO8c9dsChKGS8hxKW6zjJXZesBA+rtKqBR7yuZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWuU78CH6mRGBxQ28/mjjTkjj7PLNTQINSsbnAn+1ko=;
 b=KnEcmpfOgBlG9E0yyQkmeMJiG46iveFfZ3WrQcFCcGUG0YggLiJGBkIuTE4MNKJNFFI3PWh7GTW8J2zmgykHn251mMNc2VY+HIHhF2nGn3vu2JMdTUqAgHNDfKVqr8mtbJgPKMfksq9BvhHpXQS+X/Mmhm6RDFsRHWgnXVHz/xXgC3W7q1uM2H9v/Vk1cPj43Nfq4TMN0lsCs3Lv2XegIRkw+cdoPIKz+2Te6UYwAZiPIgwuxs8Vl+ZtoxyB1VlDTfsHBQf5Q42lmYXkBizVHt65EiwhuQM+SXpx7UqSFR3yR+ql6fC1Y9rbOkVmCUNYdvhTX/MIJq/utRPygS8xWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWuU78CH6mRGBxQ28/mjjTkjj7PLNTQINSsbnAn+1ko=;
 b=r5arLhZWgd0QsfficvUj3phzaW4WYs7kZjKnxukQW1ebkYXQuEzH6ETCdekdof+kdneBrTiU8Pa4SRKgc6xVEqN83ZPjvg5MFOk6kUz+ZiviH3X21/hh+pMal0whw18S/fyw9XXz2ppd73b02a33ytQ7e6BDv8dlU8pdWceSuPI=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB4629.eurprd04.prod.outlook.com (2603:10a6:20b:24::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Thu, 19 Aug
 2021 02:03:15 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::91c1:5ce4:cc:ddcd]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::91c1:5ce4:cc:ddcd%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 02:03:15 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: fix the wrong mapbase value
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: fix the wrong mapbase value
Thread-Index: AQHXkzGZ2pnho/XCxk+AK2PI+8qIXqt6E/aAgAACINA=
Date:   Thu, 19 Aug 2021 02:03:15 +0000
Message-ID: <AS8PR04MB84040DFFBFD83B6E382A4E4E92C09@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20210817063058.4718-1-sherry.sun@nxp.com>
 <CAOMZO5Dq153EYBFYdNZ-fWNkWkqJ3o+oP4y9K9cpcBu+dFChkA@mail.gmail.com>
In-Reply-To: <CAOMZO5Dq153EYBFYdNZ-fWNkWkqJ3o+oP4y9K9cpcBu+dFChkA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a2f4b3a-11db-4ab1-5be8-08d962b581e3
x-ms-traffictypediagnostic: AM6PR04MB4629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB462975611F7375802793E6B092C09@AM6PR04MB4629.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mas59llQlYa1egm+pzww0fav4SYghmqJvS1sojMahe9uqIzH8ayexKo7JD0DJmTcNgNXPMwBOFDJDOQQ5lmtn7B6Rz3sJCe9jIJzuHtNfl5xp1mMXYRQOkQBCFbzHYq7HS6cgTZLWSClqhbXHMP9nX6igVZYUc5qT2LBkWbUWdeD8nn7f/qB3wtiF88WHsIrylec0e/q99PGCiwp/vqtZkiV36jg2JouxtAt5v3+RQVZ0xP7Cew+bsMiKi0irlUygbY0+H+74Te+ZV8hLq2XG3KIRjSMZrfcnih89Ldzl+/TmE5y1+/DTUy476tWuFt8Po6pboyafaTDeCwRZ/LTPlT4UESnXT0w/XL/7rCR9D7/Bxpl5xU/F9Q0BNQOxxsRUMqemudQAGqxo6+JWSUIl7oomIZNu0XXEGxaD7P0JOJZjc4HFqmW7m3xeUrbaJWkTIAJ3yLNHQGOdzt2NnW15phqLTkSVzz6fr/3ZDABoA886szwiNQzIZ1qCGGWoF/myBOzBx4BSXaaUTpBJNhAh27CEurE98A4rHFjMcJpbcAphUjmuFsB5GhTHyTENqxCmwy9Jp8JdUYnrGed9cv+PcPiOftMjuiutS2efLlgFDQdgRu8YtYkBPfU498MHZ5DhTTnLTs1UppelPEOfMN8iP68CLv9vgnNcv4ZFXCS4TUPOAakxFSBmZRXMXmZ3XqfTxvinb59ZsagTDaRlpv6jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(5660300002)(122000001)(316002)(53546011)(7696005)(64756008)(66556008)(26005)(6506007)(38100700002)(54906003)(66946007)(76116006)(66476007)(4326008)(44832011)(66446008)(52536014)(478600001)(83380400001)(71200400001)(186003)(4744005)(6916009)(55016002)(2906002)(9686003)(86362001)(8676002)(8936002)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVV6OGY0aG5mWThoSWJuc0J4RG10UndCUWVSWWd1T0k3NmFkSVBQVk9pQVNx?=
 =?utf-8?B?Q0ZWbHlIVWdVV2N0UzdvblRvQlU4eHZkR05wekpGL0Z6c0d2cVFTay93emZh?=
 =?utf-8?B?R01aeTl2RWNhd0cybFRiUjNHYlU4QVNndHRaT2poUVVmZHJ3NWJwUzBZRkcr?=
 =?utf-8?B?emdyWEVLNXd6dGZwVTBNZzBka1NyZW9NbFE5ZXZDbkdzWTRyYUNiT1JQUUZY?=
 =?utf-8?B?Z0MzUEN1enpZblpYQ3lEcUtTYnpFZzErbE1VOEQxR1BsMHBlV3FQQlBFV05x?=
 =?utf-8?B?ZTB5L0JvU2lGN05ZQWRoTGd6YjVaTXBpcGJLRzdzWUswR0ExZ29zcU5BSkFM?=
 =?utf-8?B?V2c5Lzh1bGsvVjNUdGxTYnFDdE1FamNTenI3TEFTU081L0hneXhEVzVjcERs?=
 =?utf-8?B?V0FCdjdjOFRiTElpSkc4ZFAvVW9TdkZkWHVWMEpCc2NSSjZzYmxuR1BmTFdk?=
 =?utf-8?B?UlVRMkwzbk4rdG9kM1hRVGtxUkpPdWRyNFB2bUJVc2dVUkw0eGNPUERWemh3?=
 =?utf-8?B?cUQ5ZUhLQW42QVZmVlFuSGo5WUkxeG1FeFBid3crRmJEczdQc0xFeElFVHEx?=
 =?utf-8?B?U214NFhGVUFXL0lOamxoZ1BlT21Gb0VkOTFYWWRUT3k3anNIUTEwcXlINm1v?=
 =?utf-8?B?endVNjRmc1VlVzN5b2owSHRhc3Rtdnc2WmZhMGxWYmRGT05hKzRIT2YyZ0sz?=
 =?utf-8?B?SkxvOFNrQitOV011S2hTMlppY0ZEVjhCaFZ3OEYwTG1NQVpFdWhXQU9VOUNK?=
 =?utf-8?B?Um1GOXJicS93d2srKzFrUE1rQVpiamNRN3IxUWJSZElGSmtGR1lvWWJjZktM?=
 =?utf-8?B?NjRWUE5nZ1QvUjhRNVdEQWZ4MmVJRVMwbi9vb2xUeWo0NTJpaXBucklFTlB3?=
 =?utf-8?B?dTNGLysvYlhxRjNIMmZWSVhpM2NOOGZXSWYxMk03K1lCMHRKMmpiKzBwdUZa?=
 =?utf-8?B?R0FsQmJiZ1h6TU9WZ1lhOFdoWG9wNURrZkJ6c3J3RHFqUmVlS2JoUlVYR0VP?=
 =?utf-8?B?cE1HMU02aXE4cUt6OC85UEIvdWw5c25vZTg0K0RmRk1iaDVtcWdtZndOT0Fa?=
 =?utf-8?B?Nk1MNWdVOXJhV25CQ1ZacGgvQ3d1OVBCVTRxQzQ5a0ZNNHZ2OVBBM2ljNUNh?=
 =?utf-8?B?NW1URkgrK3FPT212b0NMK3NFSUxWNmZKeDhFNnVDcit6VEZLRktJcG5QS1Ux?=
 =?utf-8?B?SVRDbGFkSGhzQVVGaFRuS0VpM2JqSXg1YUQzTHJzMW9iMDEyS3psdkNuZzcx?=
 =?utf-8?B?ZWYyR1Z2N3dzRnJtdy9IWHl5S1NxdTU3Q2R0VXdIWGZPdUdjWkl5WXkwYjlh?=
 =?utf-8?B?aVo5UUcwYTN4YSsvOS9aVWh0MVY2bHdJMWUydUc0aU45a2JLd1BSWXkzM0Zz?=
 =?utf-8?B?bWpZUnh5NXZkSWZjMmpaR2thME5YejdlK0NYWEIvQmxHQ2xOakd5RlJSQ1ZK?=
 =?utf-8?B?eUpTSUtadC9Uc3hYc3I2OE5NRUh0K1J6MGlleEpMMjM2QkpWSEZTaTRaaUhm?=
 =?utf-8?B?M0ovSHIwMjZBT1pzMHB3R2QwWDJ3c0luclB0cUNGd0pReTVsWkl4R1JweTFx?=
 =?utf-8?B?VjdESC9za21vY1MrZFd1clhpR1V4b3hacmJKR0loMmtFdDF4Sy9FWHZFeWlx?=
 =?utf-8?B?blJVNXlIT3pYWWVtVzBDK2phTEJmRmRNc2FxRENGc0s2cU55MmxvaDExT0V5?=
 =?utf-8?B?TCtrRU4ySk8vMitqK2x0NmlUcVBtL1RGZlhjQmpFUjRlNGIzbDE1WTFHQ3JS?=
 =?utf-8?Q?3+aaqor7sNA+1hxbSjKZuUb0qP2TsNsTrDTAAEo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2f4b3a-11db-4ab1-5be8-08d962b581e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 02:03:15.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGtyCSn5j+xvPWmbZP2Ts0IrEZb4Caadepl2NB4id5w86FkpEGPiZ22NI6gSAjl/FfGkETgiRD/SQdAZ4p4v+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4629
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgRmFiaW8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiAyMDIx5bm0OOaciDE55pelIDk6
NTUNCj4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IEdyZWcgS3Jv
YWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBKaXJpIFNsYWJ5DQo+IDxq
aXJpc2xhYnlAa2VybmVsLm9yZz47IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBkbC1saW51eC1pbXgg
PGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB0dHk6IHNlcmlhbDog
ZnNsX2xwdWFydDogZml4IHRoZSB3cm9uZyBtYXBiYXNlIHZhbHVlDQo+IA0KPiBIaSBTaGVycnks
DQo+IA0KPiBPbiBUdWUsIEF1ZyAxNywgMjAyMSBhdCAzOjMyIEFNIFNoZXJyeSBTdW4gPHNoZXJy
eS5zdW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBBbmR5IER1YW4gPGZ1Z2FuZy5k
dWFuQG54cC5jb20+DQo+ID4NCj4gPiBSZWdpc3RlciBvZmZzZXQgbmVlZHMgdG8gYmUgYXBwbGll
ZCBvbiBtYXBiYXNlIGFsc28uDQo+ID4gZG1hX3R4L3J4X3JlcXVlc3QgdXNlIHRoZSBwaHlzaWNh
bCBhZGRyZXNzIG9mIFVBUlREQVRBLg0KPiA+IFJlZ2lzdGVyIG9mZnNldCBpcyBjdXJyZW50bHkg
b25seSBhcHBsaWVkIHRvIG1lbWJhc2UgKHRoZQ0KPiA+IGNvcnJlc3BvbmRpbmcgdmlydHVhbCBh
ZGRyKSBidXQgbm90IG9uIG1hcGJhc2UuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogTGVvbmFyZCBD
cmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCj4gPiBBY2tlZC1ieTogRnVnYW5nIER1
YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWRyaWFuYSBSZXVz
IDxhZHJpYW5hLnJldXNAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxz
aGVycnkuc3VuQG54cC5jb20+DQo+IA0KPiBZb3UgcHJvYmFibHkgc2hvdWxkIGFkZCBhIEZpeGVz
IHRhZy4NCg0KVGhhdCdzIHJlYXNvbmFibGUsIEkgd2lsbCBhZGQgaXQuIFRoYW5rcyENCg0KQmVz
dCByZWdhcmRzDQpTaGVycnkNCg==
