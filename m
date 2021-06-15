Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27D6C48BE8
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 13:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E6560FE5
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 13:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhFONiv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 09:38:51 -0400
Received: from mail-eopbgr1310055.outbound.protection.outlook.com ([40.107.131.55]:26965
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231332AbhFONir (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 09:38:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PePvpXt5FdgGEhDho8MIuJhOCYHJPkNiyr6HFABRkOBGlnwfzKD/XurSo7Mp+pWl8eM8l7IZ2a3sZdaoN8ES36eJGAmofoz0oZ1sBOW6qV+9iUWTg863LHGRoxMCs1wpsh7wLz5No0+KvS3LLnFW/3QtifCcMbpAgYPwbLrmE68rmmJne8SbG0LH+ZQv3LS/+add083N9c6GmiiaiC5SzJ0oOJ3YsPx5NxFVVz999+vJwB8CV7ggnkdC1ksUzArxS6RXxgDQ74IRrD5YmQxLRcilvRChqgrZlF2Jxe11Em24+p0QxwVveQwNJfYHo2puO492h0jcuDn6yrQsmeaOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8Wjs/E1MOr8TeAc0Pnv4x8Tp7pBB377exdISLaEf2g=;
 b=Y1rqcM6oXN4rKLHBpMMgVWp5072L7UZeDrXtiX9VsaiyhqZz+kqAJqJF3cn1B8oZ/PpfHR4fu7jhoOnfn+eCK6MLNzrXTvbX9b85Du4t3DvCSeiTUkSRsOWD6cnh1pMMjomUqJYZm0MDdkybJMTAUt4udMBefhSMzl8zzscnc5KZmsIbhSR0dx6iQfBKuaHDsH0R1oMLgs078RtovNqxeldI8zhN/aLeMo4qAZy36J5lvngtxyUlUjFw8nUFDafoiFH1YVfMSuAMtXQxU6K0sjLvC04Pp8DMySfUy40e54aZn+DrfDXddpfvCEg4eJXDDx9UbOX65jhtJhiJUoSiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8Wjs/E1MOr8TeAc0Pnv4x8Tp7pBB377exdISLaEf2g=;
 b=httOltSecBL4qMb/tfc2UWk3Q3uRKVKjsnxBo1lMuexEkzBp/Bid1dhX5iSERMNQdabnKbCZHWWr1QGHK4KG3Snho4w9BXNBCbT+qx5vuEIVCUXAH8Wpzh9pGQcCPN/vNTUih0tFyST9x1bPbPS2riTSOPq5uEtRpKSNR6/Fh14=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PSAPR01MB3928.apcprd01.prod.exchangelabs.com
 (2603:1096:301:4c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Tue, 15 Jun
 2021 13:36:39 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101%2]) with mapi id 15.20.4195.032; Tue, 15 Jun 2021
 13:36:39 +0000
From:   Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jason Li <jason.li@cortina-access.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Thread-Topic: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Thread-Index: AQHXRQOEXSJdPocm00OQib3aojINxasVL/wAgAAc6oA=
Date:   Tue, 15 Jun 2021 13:36:39 +0000
Message-ID: <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
 <YMiUpK/+PjsoCU1W@kroah.com>
In-Reply-To: <YMiUpK/+PjsoCU1W@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca909abb-5768-4eeb-517f-08d930029ac1
x-ms-traffictypediagnostic: PSAPR01MB3928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSAPR01MB39282E5F2892D5387AA14456CB309@PSAPR01MB3928.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQQnxOmliS9Qu6doPA54Z4+gMWj5ZuKF9HNY5fhX7qm78W4zeKbV8IgjWot1SZ0mzERUm/DnobE8PQZEo0/3IQrb0QTQkk980/VYDiO1MTaB8dgd16KlYNPnxnTMNGutbyS84xIUtMQ9wXVQiB+Be51qh7mYWDGXmHcJ56MqtY9zARwk/SAVeijfudJiXxGvwNZUVkSVlSaHvvmMQ3K1C0WtwLJL0/jJPMTyMtBrAp586afMPsTJb1mKuy8rQVmHCQFhh1iJ9k0xK7xpwgV5HiBbPfqSgmiDIZXVFs2NH4gJEip8UlnjPRF7UO2Q1NwmdbzrpjST6SgvyP4OykHtdZI91qE+6dLxSdmTOilktV5VrX3cK9jc8JQhbzsahj5Q6T2TpKYFe5nTBpv76ZE9ymPPF8+CIpc/DllrQoM+h8rm8gFR41W0SL7HqRUJypOWdXrlqSsv6vikU30F68Osqf0XJGahJ/YPhx9sy8C+l+4eLrCHXeMak0g8pHnCeayrk6kB0kLag/FfWP4eG9dhnDusJUINZy+EMcyrodkyStXcOn54sfSAmtNSFaSAG3uabsC/jUd8dycYlOVX+dIr4guZTqccNVBp4rjczBB710E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(76116006)(66446008)(64756008)(53546011)(66476007)(83380400001)(8676002)(36756003)(6506007)(54906003)(6486002)(26005)(38100700002)(6916009)(91956017)(498600001)(66556008)(2906002)(122000001)(86362001)(8936002)(186003)(4326008)(6512007)(2616005)(71200400001)(5660300002)(33656002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8gqsQKqdoFQjJwV2guFLTqoZwZWnTSGyzJBGHr7EdlKsd4djb0eDg0MSPCIp?=
 =?us-ascii?Q?fo/uTsf9shatLJxQMwLcXdAnXJYsFiNV+AkVvfnG0T8peiiSGRKVxmITZkw6?=
 =?us-ascii?Q?mVqou1OF8RglhZvwrlp+pLVNfg0ryyW+YnGLCHsVlIefZB/6kAU682WdVF9v?=
 =?us-ascii?Q?+BiOja+QDwYclozodL0eZzPlsy7j04+gWlerOrM4YraDXtsqB0yUNW5tHI9T?=
 =?us-ascii?Q?i7JqWSiBIVwds0XYIQt2A0UNa3hUuDnXgya7YlD0lWMxj54Yo2mAAdxK1vFU?=
 =?us-ascii?Q?HsLYwQuZBqaWprIroNW9q6bpeaccI9lErCa7EFSL1wsjHL22xKsN4lyi5L0X?=
 =?us-ascii?Q?niP/oEcqLkr1us+IpWLDYLc+c9Cegr0VuAS/qAggzixxygOgGzT4d48PQddJ?=
 =?us-ascii?Q?bWW8X7kiXksRcYPAI9zf6iWoCXkElRA76xP1pMR/A2kt3SiVkZG+2lMhmRdH?=
 =?us-ascii?Q?H/7BBG88U20Kc3aEiB8TmAB8KtLLZiGTgwznwXS+t7IosP21kFo8PZMG9amX?=
 =?us-ascii?Q?sRQg/HkLNf5e0X3Hm/8yWr9QPdTSB4w/TivpvJU3mWVoK7SZcm9TqKmyNIKV?=
 =?us-ascii?Q?mdRFKnoOSKUj8MBBcDj2XB1iFjRd6lDZ0rEDekTVHln4txTs/JT9BMno4B4G?=
 =?us-ascii?Q?KQ9r2QLGZP3vtoyCwkNdlREhY7ajq20IDXvwRLvI+P26ho17e1rpDcHpACxi?=
 =?us-ascii?Q?BueoAVGUMp9h9WVjgafUynOZd2ZzwKYh8tWDICXzOV5U6jkExYKqFJaEpj5l?=
 =?us-ascii?Q?y+3jnG57doz1zVDS+yRz0FlPQ60bzs2AY1OXggcovjmX2WWWfcYqMqVB7gmR?=
 =?us-ascii?Q?g8o6vvCZDLgAydJPikt76lJqpW1WzVIGKflFMWpP/jqQ6I+WNOJ+LrsuEBvB?=
 =?us-ascii?Q?z0oxAnusJLo0aeLfKGgrXqMrs2o+BfZQ/+5K6L+55KHBIgY8QRA1jjsi+yu6?=
 =?us-ascii?Q?4LPfgMHWSRu/MyqbTm8P9YNO+WoBG+kp6W3hLslqSx2zWGBByhdTW4NFI05v?=
 =?us-ascii?Q?/EZMZZ9WJLEsG3trj3ChfLGAA6RfF7njyXsNcSnjZVqTeg1puikjnZOm6eOR?=
 =?us-ascii?Q?eDRhyXC4scpu91iROpGOFeJwDs5QDyjfLnxN8kqgd89rsIVfDXViMOo3ZjZg?=
 =?us-ascii?Q?+3CKeyc7YuwmjaN1Vw0Eepd14A8kJ2eVHIhrXGqAU88GAdAdOmb5VEwC9Jl5?=
 =?us-ascii?Q?Npplprr627zXT4u5P/Htph1ZHMQNDvMIgoQ8B0ctBEg2ZdRNQDooW1tzY3lW?=
 =?us-ascii?Q?zSitQY756KrPshM65q3dOym9UMtLV9XuSCDbU6K0yTu9Uq7awOZIaZ/KKIJ9?=
 =?us-ascii?Q?4Nnupgysgziq4txVWw7CLdC6?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7CEF5F6AF38354F8CC648FA7C8215D8@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca909abb-5768-4eeb-517f-08d930029ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 13:36:39.2285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3u+QnqZCJHzS8eHSFZ7RvWb4wrXoK2c1sQh0yDezG+S3yXCeX7Yc70CwrgQSVc+RpGQ4vCmaLngeS3anM/cDzhmCbbEY6cjAqY0cBGkr16UdVGykBB8pCBZNwGzrzzhh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR01MB3928
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

MAINTAINERS modification was made in the initial version 1.  We made no cha=
nges to it since then,
thus not sure what we could at to  Changelog which would add value or clari=
ty for others
from the v1.

> On Jun 15, 2021, at 4:53 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg> wrote:
>=20
> On Sun, May 09, 2021 at 11:45:17AM -0700, Alex Nemirovsky wrote:
>> From: Jason Li <jason.li@cortina-access.com>
>>=20
>> Convert the Cortina-Access UART binding to DT schema format.
>>=20
>> Signed-off-by: Jason Li <jason.li@cortina-access.com>
>> ---
>> .../serial/cortina-access,serial.yaml         | 46 +++++++++++++++++++
>> .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>> MAINTAINERS                                   |  6 +++
>=20
> You are also adding a MAINTAINERS entry here, which is not listed in the
> changelog text, so I couldn't take it anyway :(
>=20
> greg k-h

