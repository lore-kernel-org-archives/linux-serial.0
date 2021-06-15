Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93237C48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B2B6143D
	for <linux-serial@archiver.kernel.org>; Tue, 15 Jun 2021 17:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFORUm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:20:42 -0400
Received: from mail-eopbgr1300085.outbound.protection.outlook.com ([40.107.130.85]:41991
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229494AbhFORUl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Jun 2021 13:20:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2exfDPK4Qd4dDXR9YmsHG0QxZL2AxD35xlqe8tcIbvZkBS3XBX69sUXBAph28ebQqduRphS6clq4LQV9ZyVh/RmayRhC1F0G7qGbGzYfKLHAsbEq7cCtwOD/KFKodSkB2PuxoAoBkeYcSRlEO6dMSDeRSemiIg9XF6h8zKxvosgR9f0sox4tvQIofCFEnuUpMKwP/zH0+seQ79aUfU6gWGBJaKIa42sJes9YzWRMllRUVNYHxNn/ACsQziAjkbk4nKxL8G80yQ+zZxdCwHgfxbTGdQhoA7NGN3A5vGgtUlWxTwwX8PoM6dEBZFy0Pys8Q3UOBhuGfJ9PNnHZIM7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4OPAl7N+gpo5YahHdrWEN8Vxgc6/YKvtMEJbKkbxcs=;
 b=dW7szNXkctbxFnLG8W5HgoOvEtejLOa5j2xm77T0+oEcJxKSrVTQLS4YEiRMGhdKiBQBU0clpfF9dJmEea+XH3jrafWwHW5n+E9nBpk+WsB0Q1+O31Q37A6mNq9pdt5ll6o9W5Eq9FTStlWIcjf/+a1HJd7v0mqpLCEldVRvymlrAL+3hD/CvObSKQVxuPKnsTaw/ps5cMMzlDMczzmxK7Zzk21KlJPYJO7p50A2foe40OmARBb+AmB4bwehT6YfYasMuSzTYWygceilHLnh27oyTeeETIkORRwdjVaC2y3D6KWVZlaG6OxtjfgU7E06eRkXzpZMOv1hil0Yl3O3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4OPAl7N+gpo5YahHdrWEN8Vxgc6/YKvtMEJbKkbxcs=;
 b=tK/7hN/XfXnvKViIt8xJn6ysrG4KcBu1CDQStRPl0JPuF/JqIpMV02RrALsbqQhfvi8qRbqf3qNKKxBvXlM9z30FBUT96bmOU1Z0BzuQaWbQEn6my4OcqLLnPxKGjKL1/NNmSRiYGc+8AzPa+4VOJCGzqq4RE5ecRTFrvpjPD64=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PSAPR01MB3797.apcprd01.prod.exchangelabs.com
 (2603:1096:301:22::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 17:18:32 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::e9b5:6b16:ec29:6101%2]) with mapi id 15.20.4195.032; Tue, 15 Jun 2021
 17:18:32 +0000
From:   Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Thread-Topic: [PATCH v4 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Thread-Index: AQHXYgehbGvZC2LIq0KTrC9ujhAduqsVUA8AgAAAzQA=
Date:   Tue, 15 Jun 2021 17:18:31 +0000
Message-ID: <7478BEEA-DB0A-463B-BE28-AE513B626BA3@cortina-access.com>
References: <20210615165750.31261-1-alex.nemirovsky@cortina-access.com>
 <YMjgOl6dbv2Oxzcg@kroah.com>
In-Reply-To: <YMjgOl6dbv2Oxzcg@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c41dd0e1-a5a5-4307-36cd-08d9302199b1
x-ms-traffictypediagnostic: PSAPR01MB3797:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSAPR01MB379750FCECC4E77516CA128DCB309@PSAPR01MB3797.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /UduOjW1QdkOOVWZEEskS9MgthSgJXkaKF8JwC1YtFrDuCU/swxu7vV65y+fnB8gC43DB1RTSbk0/bCTTzZFyRgmdxE2dTCn45vXn7PhgghMVMG6IsAl8qiVVhafUwTTc/ZjKGGK+7u1hQJwJwht0C97GVTdUl3yIxhXdMsY4ZTwdP7tzVnC2BhHD5uVJJc+dNbGEsBopPg3E163PpqXFw6uqq0ayI62Q6UqvPAahPj9bMUgUpc5YWDhcxLWaHrWbz3LnhbBIyPCZDvlBv7xIAB0rpPy6YhpoRzPHSQTm07bKiw3llp0Ar5F/gp6y1FiwHZKJEnCXgTD5uZxNvfk8tkti4eFnOfnZDR1oxgGIEHMF3oT0P841Gr6zeHJH1/NrBh8kcXNHtNkEIK0bOPojL2hHhwX+HwEYMavDPfNlhGGSspEgU+VE1nz7GbVy/PqbcEaDtRGVplb8U/WvypTZQNJl0EKrPPTKnKRnWAT7NzqW2kwXZ+tuS2U0vj1DJTFRxx4Thx5doFa6OUFyjJipFF+AS4zQi3LsP7gwmKO7BSFQpj/bPcCU3kcU7hw5Q0l7KLd77NDgUcGThU35SVi0GaDpbvDHyw3xnv2nzMX6Ko=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(366004)(376002)(396003)(346002)(38100700002)(122000001)(6512007)(6916009)(5660300002)(4326008)(6506007)(8676002)(478600001)(4744005)(53546011)(6486002)(86362001)(71200400001)(83380400001)(76116006)(64756008)(91956017)(66556008)(2906002)(186003)(66946007)(2616005)(33656002)(36756003)(316002)(26005)(66446008)(8936002)(54906003)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7SzKxbnBeWWq+in4UnEALngb6owOTk0+/8F9CTBQXMsNalmDsEq1bHqbCcaL?=
 =?us-ascii?Q?Epk/ee2IGxs1tgtByRFQyGaNWEli7NKXP/aQYK2WoSJ3MvyLrHqoRPaHpwlo?=
 =?us-ascii?Q?q38rMioKDb8BjjScZCPUvXNC+LtqZZRrAs8dMHyLPYB+htTU4wzpJ5IURcqD?=
 =?us-ascii?Q?I85pUckH+Z5HU6J2/y+nYkS+q7w77/ttKozGzWmi2Hz6Tqe4Kax+p7VYcSfP?=
 =?us-ascii?Q?UKzoTrb+1BAa5A5M3FX5DplODnN+5PgpdBz+35UBrUR6R7I8mubEDkqdO6AH?=
 =?us-ascii?Q?Nh+MQIAi0ce81dZ3UwIO7EIcsChC9hclgj78tyVzms+NbEFYe+MCVLqun8/k?=
 =?us-ascii?Q?iqGuYNF3xUfv5wWiNRDPlrPLor/WJBsDZRJ3/DAQtocDcXGDeexnjPc2r2nb?=
 =?us-ascii?Q?mrs3Jz3aeiUW6N7LlDYeo5cuIgywugL1BkNl52yoz7Vvy7cpgnVmE57+iCNC?=
 =?us-ascii?Q?DvKr44OqrDY0wcQccNv+nNIuPSRLK+E5tV9+oagwZA60+OWSQhRkqarDbnCU?=
 =?us-ascii?Q?6de/nn/YIiirW/HUOQSS2cw+3Bnn96PnM4Bf5+AhT71SfRC914BUsYb0kGls?=
 =?us-ascii?Q?zI3aF4hhHC8JoBLA93TGm56Qgh5dy2Uu+tdy+iBJltFiKZQEi74kjX39eCkX?=
 =?us-ascii?Q?N7x+KnupDP5g8/wmPe469iR54SdcGngTHZOI4ZT2EraTw1cLrjiJVHvCdUuu?=
 =?us-ascii?Q?KgCmnU0yDCOVb5hrbbeZwuloDy+Wr/Wvy6iti1N29yYOQCeiStaTu9n2zOuD?=
 =?us-ascii?Q?lPod/BitMiUhwORr3Xs6iakof2v2dhcwOZmET5PfkdBxqR+selP0J2EGDtzB?=
 =?us-ascii?Q?FxabVMAzXjjEHzi8C0n9j7uIAaCiaCtrqxNy8mTFTVl+IR0rP90l9L1tdQE/?=
 =?us-ascii?Q?uT0tQdoLzVYcc98TqCDSaM6xm1BrKVorKuWq92F8PJOH4mje7oS+QXG0plY/?=
 =?us-ascii?Q?pKwJG6ihk4dlMuPHp/nJdlweJTAU/c2I/Oai76mqZRdhGW1HJbm8AUW4r6+p?=
 =?us-ascii?Q?0B409EzzpE3N9QqWyy5Y5Vaa6VE5NZWDzOKpzvPT9fipqGmjSBgI2g5TGpzN?=
 =?us-ascii?Q?wn+SVLskB3Ix6NTkF2T7gj9FBeKwgOWeaVbudCAiXNCDXTNWYYk69KbAevjN?=
 =?us-ascii?Q?otZZcC1rDJinCI4V6oQygyRfBwOBwVPcL6d0dMQrMg2Ald99W53CKmKMqQwg?=
 =?us-ascii?Q?omyzPab7fX7fPitrRi9djf/zaceOXJ0kN16opOt0f4cB4Zldvv0TrYqbRsCp?=
 =?us-ascii?Q?pzkt4N9IlWV5xtF1NtFIBMnzHAX1mBfWhQYg8NXWr3OBeKIy+TFGcMbGFsnP?=
 =?us-ascii?Q?8/LdDKzhCMYnw3C7YropaihT?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C0B9BF2B135BB4E887259536B0D9E17@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41dd0e1-a5a5-4307-36cd-08d9302199b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 17:18:31.7709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vPlgV6GQZHEk6TJV7onW1aGkVXdUv85uFmvjd6rWgDjZ6ORsCT24vxHjBgwnw96PRBfKhx/Rko7o+6pW8JHZ5SC4O3cMRYuMg9OGxEpTpWpzT0Davn9CrBbYaPU2xC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR01MB3797
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> On Jun 15, 2021, at 10:15 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.=
org> wrote:
>=20
> On Tue, Jun 15, 2021 at 09:57:48AM -0700, Alex Nemirovsky wrote:
>> From: Jason Li <jason.li@cortina-access.com>
>>=20
>> This driver supports Cortina Access UART IP integrated
>> in most all CAXXXX line of SoCs. Earlycom is also supported
>>=20
>> Signed-off-by: Jason Li <jason.li@cortina-access.com>
>> ---
>>=20
>> Notes:
>>    Change log
>>     drivers/tty/serial/serial_cortina-access.c
>>      v4:
>>       - Removed modification to core serial.h which added unique
>>         ID for this driver. Instead used internal assigned ID
>>         similar to the method used by the liteuart driver to
>>         avoid adding additional IDs to the core serial.h file.
>=20
> Note, this is really v5, you added the MAINTAINERS entry.  Please be
> more careful.
still v4.  no changes made.  Making sure that Rob gets this into his DT que=
ue.

