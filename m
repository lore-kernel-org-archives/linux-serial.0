Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946DEC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 09:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5015923435
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 09:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbhAOJQS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Jan 2021 04:16:18 -0500
Received: from mail-eopbgr1320040.outbound.protection.outlook.com ([40.107.132.40]:53952
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726829AbhAOJQO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Jan 2021 04:16:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaN4lW41bAXhGwxNMNiOu7IW/fZ4ePTCY1uZWQz3Us+P8h/G5fH/eHc33dGPwZqXbf0FU4C78ygUWWFbrU47hz1ThxR9nQghRlnPsVM1A8UEtbwNDUfwMMOotaOpZKwvtvXpwyiFou6WVNkFOUkKQH2HJkAwj3UWfhLB+MuTl11Jc/l6mDA8Pj6LQgz/xCnV04tbSEi3S7niUvjdClDnwdpfqMGNBpaPK2/DFCQviUnLBHZ6UbtT55iEUMWCiJbsvN8PbNcQJVuKtPPWXbYBy9A6NluOUjsq5ncqHMOj/Fyh2JHJ4nzEn67i7HX43YU1rsKgGp50kl7cexIaoSfwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YJ6C4v9PGlyHFcPa0Jzxpw3ZjVPZ4piJ5YFwGHIgoQ=;
 b=TG1nUOq0JriAgz2b0p3pAQoplfWX+rVvdMgPxKW74/PKZUmi/2P0hFJwk3grFxzhQaLok/37IZsbKpjkS4Tp1AoCQ3CoeXm08dlBt/VWCw1J9O+YcLltZzfZoYTmVWAaMFb/I0X0PBY3Gh9E/6av83XIQpALfiun5ITC/AQP+9VzldS5FpI85Yj4dkZvDIf+oRsoLFUsb8GE3ewTxGdnlwSQW47ieAzb/oVPcoYUd2228TclF9I0m96sPldj5drwq854beUOdNHI2BTBtFCIyCM+NfPfCgjGk4pDwRkj2Wkah6tUs2EDoRCmuyGJqPgf16oKGzFXWTiId4bswZtKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YJ6C4v9PGlyHFcPa0Jzxpw3ZjVPZ4piJ5YFwGHIgoQ=;
 b=a9EajqGpRkVfvM4M+vWVtlWNggZINqLK8dG15ofek1xBPwKOGro7sv2b/gRaHaqyLzYhI6ZLNV3JtNM/COZttnuCAVG3PkpJT3Qv0VnWOPnKCCDeX5HM2EAO2bsbdK2sHoEJlvejf+toClArgDujB9fPyNPaVPEaJOAcwrnvhY4=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PS1PR01MB3467.apcprd01.prod.exchangelabs.com
 (2603:1096:300:79::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 09:14:39 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::a5a3:f135:b16e:7329]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::a5a3:f135:b16e:7329%7]) with mapi id 15.20.3763.010; Fri, 15 Jan 2021
 09:14:39 +0000
From:   Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Jason Li <jason.li@cortina-access.com>
Subject: Re: [PATCH 1/2] tty: serial: Add UART driver for Cortina-Access
 CAxxxx SoCs
Thread-Topic: [PATCH 1/2] tty: serial: Add UART driver for Cortina-Access
 CAxxxx SoCs
Thread-Index: AQHW6wmBM7Axtwu9mkal+OYEt7pmWqooZ58A
Date:   Fri, 15 Jan 2021 09:14:39 +0000
Message-ID: <4E53F74B-5C07-4B91-AE51-E0332579B328@cortina-access.com>
References: <1610673113-14503-1-git-send-email-alex.nemirovsky@cortina-access.com>
 <YAE5L8snkCNU/Lae@kroah.com>
In-Reply-To: <YAE5L8snkCNU/Lae@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2421d9ee-06af-43a3-6d54-08d8b935fcb0
x-ms-traffictypediagnostic: PS1PR01MB3467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PS1PR01MB346713F4A44000EE85DFDC84CBA70@PS1PR01MB3467.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: atDmiba38ex0QougGGRCHd4qBJlXctW1ahmqbuMLtxLxpUmUpi74siDMikQOMl6hTwnNBsrnUgYvoxzua6zmHplfTX2u2k1eRL2qcYXQ6OUrqpatYrLpuNnFAz9yccn7g+Y+2Rui14/XCo2RcV8NcKG6j9OF/dJf6BSKhOXVJWIYtcX2vOHo539M0dD2TroceAiCLbJgMGc/T+jTQEHekzOjP9Fx8FBLCK0ZiwpdPj7QzdRX+cAIeG4sIeu9Br+vNPWqckXODWKV73OFeqfIVjU2gwcHzyqlDBqxJD/Jr6w9SiZtrLUZtK0huuN8oR+5zkoUEHuGfmFmVte4eXPAFkgXUX+6IpjdxafcG5SZG/UzpT2kDOhrfu22J4pFFUvi0k36aJO86zcWfsiNo7Cgng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(376002)(39850400004)(346002)(396003)(136003)(366004)(107886003)(478600001)(6512007)(6486002)(36756003)(86362001)(4326008)(316002)(2616005)(91956017)(6916009)(76116006)(2906002)(54906003)(71200400001)(6506007)(8936002)(64756008)(66446008)(66946007)(66476007)(186003)(33656002)(53546011)(66556008)(26005)(4744005)(83380400001)(8676002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dlQ3VWxhY0xtZWFEVUs0R1dQbFo2aU1ZWUNKUERPYW9DTk9oNE44WWJRSDJj?=
 =?utf-8?B?VDVPa2RRY2lSZFhMbHgreXhpMWJWa3hqQkF5VlNULzNXc3l2UXpkVDV4WTZM?=
 =?utf-8?B?RHJ6c1d4cFR5b21mSE5ZRWg1akRkUS94SHN0cnk1dlMwK2dMek43dmc2L3Ro?=
 =?utf-8?B?ZWZSNEM0WkZ3ZTlucmZvREVDT3U4MThoanUxQlh0ZnpqR2srNEh2ZC95YkRu?=
 =?utf-8?B?MkNFUTdEc0ptTnJOSmkyby9xQXNhYkl1SmxxUmZyd0NnZTlocUdVajAwUDl6?=
 =?utf-8?B?WUZUeG1ETlRGN3RDZC9SN2thbGFqa1hhWWNzOHdxbVFEbUZSeXU0VStNdGI4?=
 =?utf-8?B?SnVMS2YvSGEvOWVqRS80eS80Z3crL3NIS0ZVMk1NTWZqSHU5eSt5WEpabjZS?=
 =?utf-8?B?bE8rMEM1U1VnMVdHUzFNME1DRXdVYTIxUlVyZGNwc2Zkd0VXeGtPVW9uVTU5?=
 =?utf-8?B?SXBuRjNaWkRST3lrYjhRZFArZDJaUDJ3OVNHQ0VVcEFSOWxXenV5UWl0N1Ew?=
 =?utf-8?B?Ky9vbTNLN2pwSDV1V2xERk1kSy92S1F2OXpPYzFRQ2ZvaXZObGxMRG1xVVVn?=
 =?utf-8?B?VlBsdHBYNDdLNm1IY2Rta1R6c1Z0bEQ2N2pNQmdGUUN0TW0yc3NjUnN6V3B3?=
 =?utf-8?B?TzROYUlMWXFyYlE2dXQrZkpoOVZxT1BpVU51UHFvSWhEbGNiTWorQ1FCY01I?=
 =?utf-8?B?b2pqbCt6a1dNdHZGYzFBVVZhbmI0YjVEbG9CalI5aDljbkE4YVpxVGxCdjBD?=
 =?utf-8?B?aWdsZFFaRWZQK1lzTWg2S2FpR3RkYU5WYW1zZkVBdGxsNGROdnlHc3N6dEw2?=
 =?utf-8?B?ZHgyRTEyeUxsdjFOZU5YaUhRT3RFMGZKN0RFU1pKYnEvNFhNcm91WGlNNGR2?=
 =?utf-8?B?c1VaRGFHTXNXY3BWTE1XVXRuMndtZXQvYkVkSnRkVzRTNVJaMU9kSTlEaUU0?=
 =?utf-8?B?VlFPdE9pUU1kV3h1Vy9YdW5Ed2xIMm9WK2o0WjFUc1Z2UnQ4LzlYUWI3c05C?=
 =?utf-8?B?aHByb0lDRE5jbEl2azVhUFFscFlsQkJOMEx3cWhOd2pLZG5ISStLc0F2TERv?=
 =?utf-8?B?dXlqNXdJMEJ5bTZFL3Y3Z3QxeDVCM2Q5bUpFVTE0SnBlU1BnNHh6TjAwQzcw?=
 =?utf-8?B?dysxMk92YWw2NDI5MjNERmhXZ3V6SVBNK2J5SWVWVUJubFpEWjV6MGtVT1Jj?=
 =?utf-8?B?ZUxDamY2VzhMblF4VUJIK1RISXJ0SnpubWpNR0t2Zkk4TlhWL3dBSjI3Um1w?=
 =?utf-8?B?eGhENFFMVUcrV3VSdDhBZk40WVVoMWtWR2tjbTQ1ODEvaG1kL1U4RW55YTdE?=
 =?utf-8?Q?Mm212VSqKnMQAMT2RLxxPgtbKnMSsAI7JJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8928E5AFDA90FE47B0C7C0DF0B39E43A@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2421d9ee-06af-43a3-6d54-08d8b935fcb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 09:14:39.5302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHMW1fem+eMIncfKea5XvMGRdm8C5ikWwzhO0Yg72b6pqt4HnJ2sccHFCYwk9IS3ZZbrwTkyRRnLyrdTdKkbIboc+2gL6Tnsyz8uCu//3SQoeuusz4c7wyDl3MKu8ZTm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR01MB3467
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

b2suLiB0aGF04oCZcyBteSBiYWQuIEphc29uIGhhZCBpdCBzcGxpdCBpbiB0d28gY29tbWl0cy4N
Cg0KVGhhbmtzIGZvciBhbGwgdGhlIGZlZWRiYWNrLiAg4oCcV2Ugd2lsbCBiZSBiYWNr4oCdLiA7
KQ0KDQoNCg0KPiBPbiBKYW4gMTQsIDIwMjEsIGF0IDEwOjQxIFBNLCBHcmVnIEtyb2FoLUhhcnRt
YW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSmFu
IDE0LCAyMDIxIGF0IDA1OjExOjUyUE0gLTA4MDAsIEFsZXggTmVtaXJvdnNreSB3cm90ZToNCj4+
IEZyb206IEphc29uIExpIDxqYXNvbi5saUBjb3J0aW5hLWFjY2Vzcy5jb20+DQo+PiANCj4+IAlU
aGlzIGRyaXZlciBzdXBwb3J0cyBDb3J0aW5hIEFjY2VzcyBVQVJUIElQIGludGVncmF0ZWQNCj4+
IAlpbiBtb3N0IGFsbCBDQVhYWFggbGluZSBvZiBTb0NzLiBFYXJseWNvbSBpcyBhbHNvIHN1cHBv
cnRlZC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gTGkgPGphc29uLmxpQGNvcnRpbmEt
YWNjZXNzLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBBbGV4IE5lbWlyb3Zza3kgPGFsZXgubmVtaXJv
dnNreUBjb3J0aW5hLWFjY2Vzcy5jb20+DQo+PiAtLS0NCj4+IC4uLi9iaW5kaW5ncy9zZXJpYWwv
Y29ydGluYS1hY2Nlc3Msc2VyaWFsLnlhbWwgICAgIHwgQmluIDAgLT4gODM2IGJ5dGVzDQo+PiAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbCAgICAgICB8ICAgMiAr
DQo+IA0KPiBBbHNvLCB5b3UgbmVlZCB0byBzcGxpdCB0aGlzIHVwLCB3aXRoIHRoZSBEVC1zcGVj
aWZpYyBjaGFuZ2VzIGEgc2VwYXJhdGUNCj4gcGF0Y2gsIGFuZCBjYzogdGhlIGRldmljZSB0cmVl
IG1haW50YWluZXJzIHRvIGdldCB0aGVtIHRvIHJldmlldyBpdA0KPiBwcm9wZXJseS4NCj4gDQo+
IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCg==
