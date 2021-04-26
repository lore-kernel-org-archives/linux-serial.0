Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6CCC433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC70E6023E
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhDZMtX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:49:23 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:38307
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233043AbhDZMtW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 08:49:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtqANal40K2WHb1/VpwQLPaf/5h4CcToWeilGex85wxIjmVz+VI7cwIcHVNca2tu+7XgdXp2fssv96D7I6WwivDLHy3NU67FouWvc+LbGqbg3fpbK+hmUL8ByeXVC8cyZSQc2FvJaT1aOkAmsW3eKPAZFl4/bssdOxeB2zbIq5VyZDQ6q2KYf7m/CEj05ms2wds/VbpaUr2mwtcx237T6gZXDlKVp2slxRagbGJg1R8qCM2Im0+AzG1vzNXXR48pOTrmQnChJrLv9e6pmt85TX8GmTsOmAxIGMFK800QmbjUAHWTYjDKj2wl67x0Wd9Y9mMzrlDAdRQOLwBqfG9ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tS4FG+rf7r7Vcr3FeYz4g3eEbTZ9udWHWu8py/8wzhA=;
 b=V6UoWeVDo9noQOCcsIlQUhE3lglms4z3XkpQcz/IIkZlgbX/QVLnrYuyCbSMpyNBaLxl8TQelotxfqHnQs1GDzgCU8/oFdhL+/BYhqgWK/K3LIiG3veeYP6ekCi5KMa8RiDDEo4yC1bDj8C7OEK7VM2/5pcIxD7bQml5OXEmt+X6agbBky0aiVo89XmkKOEgoxPLRsdu8gtcplK8+UKVxY3bIU8X20voxNFGO+CdVWlQbhFYkLusupCcG/E+gcZO0jtvrNlVx3w5uXdloMTT7u3HGKQLQy7tfXfaHiKolERL4h6ORUt6N2dsksiSyxAR3yjKn7vK/zQgtendaUkiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tS4FG+rf7r7Vcr3FeYz4g3eEbTZ9udWHWu8py/8wzhA=;
 b=RGdBkdlk9K1z9hUFsMkH8RuYMSmgKhqViQSRFt+H+8cCXwjFrXwC7v1id+bkzochxzaqIlmsYiSWfj4wx4HZgj6JaGXWWsBIgBEMIdzuRkisMZBBElNP2746cVt88i6qPLbOx8JtZZkWfgN6vTHq3aEsiqyRDq9rI75i3dXBie0=
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM8PR04MB7250.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 12:48:39 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 12:48:39 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of
 dereference null return value
Thread-Topic: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of
 dereference null return value
Thread-Index: AQHXOnDr8/FCGWBm7kWmZDaqq+nPsqrGchAAgAA4RHCAAAd+AIAAATSAgAAD44CAAAinwA==
Date:   Mon, 26 Apr 2021 12:48:38 +0000
Message-ID: <AM0PR04MB49472A623E25693086282B5992429@AM0PR04MB4947.eurprd04.prod.outlook.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-3-sherry.sun@nxp.com> <YIZ1NvISshNHtX/Z@kroah.com>
 <AM0PR04MB4947DAD4EAA84FEAA5A2B28A92429@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <CAOMZO5Bmv2CVZeJbwLhZcH7pb7Tb9FhCrPSjhkbaJO8vYtRHLw@mail.gmail.com>
 <AM0PR04MB49472A690A93C06CE27FFC4692429@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <CAOMZO5DXLoy-PRQW0sYXf+eDOZ1=XqKsC-hcNWMKLg9K2oGQQg@mail.gmail.com>
In-Reply-To: <CAOMZO5DXLoy-PRQW0sYXf+eDOZ1=XqKsC-hcNWMKLg9K2oGQQg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bbe6d01-359a-4a34-4594-08d908b19d64
x-ms-traffictypediagnostic: AM8PR04MB7250:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM8PR04MB72509881FE0939BD9D312CAB92429@AM8PR04MB7250.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EhoHMk8BXASJXycjmDck0fgV6u8WgSXRlHpIvqweSQ1no9IcgIkBPH4FXKUjdBGPxMfz4Iu2iDyOjoJdkEATyN+hC6LIXSg0stWh6YVLAPePGLBh1vlkY7EX0RFVhP6tKZlIeyov/oIUvs7ubeLpPD6gmvaTasjz+dZy6P7/1zja/O88mtvtefzjRVPiBZNepzGce+VCoyvY8pc/7M2Els32VWixEb190oxXTE0lTrS7ijdYnUV/2CPQ7UAc+z456EJA8p0Chxs5IZ6HMx+PpPbP3w1XHWAsRyWbOIQ5zjwWZMBMJItXOJ3nTCPEwq8cK0rC6shdYafHcJfqHleHdERnOOWS7UlQbMlKcKWyfpMuY9WEHwBf0b/Mlq8M79NrTqfthVSUDXrb1FXirEfxigCSgxp35uaD8UYeLeGfpNigBeRj3aUO2/DbZskRH9A9knpPo5ynz1fGGq2dZBPj6MkHDnPgoCFs+SH8JD7zxVSVseSvvQkU7yp7txWdHVzoVKOUV72CbzbiPDRjZhk8AKrbT+mJ/KW1/QYVxNw68ggm6TgSGowJN5uU72tHV/2rk9z00PfLGYwVp5xefQDyyHyitjab5ulo+Zx+aIQuaw8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(186003)(52536014)(6916009)(498600001)(7696005)(86362001)(44832011)(76116006)(55016002)(33656002)(66476007)(64756008)(5660300002)(66946007)(66446008)(66556008)(71200400001)(122000001)(4744005)(8676002)(2906002)(26005)(54906003)(4326008)(6506007)(38100700002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bmp2QUFhRmRBUGpCZ3FzbkZ0YzZpVVNFL3BTYTN6bnBmajFLTGdRNVp2VklZ?=
 =?utf-8?B?eGQzSHp0czY3R2g0QWpyQUhsZzd3cVY5aTFXZnhURDA3bko2Q2NackFkcXcr?=
 =?utf-8?B?NnNOKzB1ZzNoamlBNW5mQitkdktkNDlZRHRPRDJFZG14RzVPL3c2KzlsREtI?=
 =?utf-8?B?a0N0Nk1SbWdvQk5RdXFqNDM3U2Z3K0pmUUhBQm1PYS9qSUZPUlRXRDVUWnNk?=
 =?utf-8?B?RktZRDlDUS9vN1pIWDNTVC9rZlVsZEJBdWRqTUIya0d5dzh4a2VuKzFMby91?=
 =?utf-8?B?RTFvaVNJSlFhSkdWTytLc1JiTnBvN0ZVWHlmS0M2THlMZEIrZ2ZSSzRubnFp?=
 =?utf-8?B?RGxyUSsycUtGMW5JUzNwY2t0REFhdjM0WWdsQmduejBlYVlFMjUyZjZKQXpx?=
 =?utf-8?B?cDB0ZWxnNndZRGtIejV3T2dicEUwK0paRkhDUktsSmUrSDJXTDhIMWc3R2lU?=
 =?utf-8?B?Z0FFeHlPSlYwSjV3dHdmTUJxSkhZMGJ6bUd0TWZ3NllXS2Ryd2luN0cwaE83?=
 =?utf-8?B?TDdQeWg0RnJrbmkxSllUOWxtaVRtL3VWa1JuZjBndjVCbWlYaUttekNsTGJO?=
 =?utf-8?B?ZUtQTDQ5b3lZWDhlU0FZSTJKeTAwOFlKaXlndDhaUDIrZFM0QXl6NjNuMjFC?=
 =?utf-8?B?ek8xR2dXVk53aFIvYmtQL01UejRyVEVnOS9yTGJBdjF6cHVNRXlhK0dYTWZR?=
 =?utf-8?B?OUQ4enJCQ3dSeXJ4RFFycjVrTUxmdnkxaHFQeHB5SUNhR0JzVEwwVC80VWJQ?=
 =?utf-8?B?OVMvWGtjRVZiNGtRS0s3ckdLNXlCeGVxM0NWdURzS1J6OWFiWVdEUzlGU2pI?=
 =?utf-8?B?eVZDVzlsQWlYMFVkZFptVXIvM1oycW9LaTFCVjdERHQvVHVBRkY3clNHT2pD?=
 =?utf-8?B?b3pOamlab214b2FNcEpteDgvbU00V1dMMTlsQlFoUXprSkJIOEkwakpHTXB1?=
 =?utf-8?B?UjZzUEd5L3lvMWtaMkovaHFkaHhJUVNoQ2xGR2dNNXcxYzY5czJubTJuOWQ1?=
 =?utf-8?B?TU5PUXZVRktFNCsveFhLUE9aaWJLRDdMcEppcGo2UHRoOXVybVlqaXVkeWg2?=
 =?utf-8?B?QjZDMjcwOEVwVHBvUDAvemdDSW0wSm1zOXcwZTJDVEdpdFBZZGtORSt4N3VI?=
 =?utf-8?B?TlBTWCtrM1Bmcm5QNWlsR2Q2TGZoWFB6Nmc0bjZOL1JXZUJIV3VZU28wdVBk?=
 =?utf-8?B?TEhjVnRjRVNRQkNvZ1pDVkYrTWU0d3FaN2I3UEZlbHgyODd6WDB6b3llNWJ5?=
 =?utf-8?B?bDRmb01qa1R0UnpleHEvV3RHdHdLSDJUT2duOStKZllJbXhjK0tFb2RvaEp4?=
 =?utf-8?B?KzlBTzdrbWVYbWhna1BxNGh3U1Z3dzJxWGRITGhWc1JOSDJKcDFFMU5NNzhC?=
 =?utf-8?B?L1lDVzBNd3hkK2ZtaHowMVd6dElPejcvRFU4aXFQOVhXTjZlT0dlclVNS2lD?=
 =?utf-8?B?d1FiNjVSNEVHRzF1V3lHMmpFSHFnK3AvcVExUTVtTTYyWWRvVEpuQm53eUJB?=
 =?utf-8?B?cDlNUWYzcFE3L0lidlhWNlpxbWxueWh5azlDbm1FMkU1WkY2UFlGa1NnUXY4?=
 =?utf-8?B?S0RvMnFUejlSeGRvMitTSXV2c0pheGFuWEk5ZXlyL2RkUVR0bld6UzF1azBq?=
 =?utf-8?B?ZS9QZ0ttbyt3bmxzWk1NNE1hMlNGT3B4QndMbkx2Z2lZcy9scVpDSlJXeDU2?=
 =?utf-8?B?QTJMUURSazZydDZEWDRPc2toQS91UXo3L1RmbXE4alFwWWlWQ2FvK1ZGZ2hy?=
 =?utf-8?Q?hoqKFufRcfn9tA9yE+WEMOD0aaL2cWf/bgTwm5m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbe6d01-359a-4a34-4594-08d908b19d64
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 12:48:38.8596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZiyjGKCIOaemlfKGWr5IyxK9cjv65beU0wtuOiEKzkLlV2TuQG1A809qyakjLDaTVUJnBPsVYgXO/+KX+Mqng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7250
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgRmFiaW8sDQoNCj4gDQo+ID4gVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KPiA+IEkgZ3Vlc3Mg
eW91IG1lYW4gdGhlIG9mX21hdGNoX3RhYmxlIHdpbGwgbm90IGJlIE5VTEwgc2luY2UgaXQgY29u
dGFpbnMNCj4gY29tcGF0aWJsZSwgcmlnaHQ/DQo+ID4gQnV0IGZvciB0aGUgbHB1YXJ0IGRhdGEg
LS0gc3RydWN0IGxwdWFydF9zb2NfZGF0YSwgd29u4oCZdCBpdCBtZWV0IHRoZSBOVUxMDQo+IGNh
c2U/IHN1Y2ggYXMgeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1scHVhcnQiLCAgfS4NCj4g
PiBIZXJlIG9mX2RldmljZV9pZCB3b27igJl0IGJlIE5VTEwsIGJ1dCBscHVhcnRfc29jX2RhdGEg
SXMgTlVMTC4NCj4gDQo+IEluIGxpbnV4LW5leHQgd2UgaGF2ZToNCj4gDQo+IHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGxwdWFydF9kdF9pZHNbXSA9IHsgeyAuY29tcGF0aWJsZSA9
ICJmc2wsdmY2MTAtDQo+IGxwdWFydCIsIC5kYXRhID0gJnZmX2RhdGEsIH0sIHsgLmNvbXBhdGli
bGUgPSAiZnNsLGxzMTAyMWEtbHB1YXJ0IiwgLmRhdGEgPQ0KPiAmbHMxMDIxYV9kYXRhLCB9LCB7
IC5jb21wYXRpYmxlID0gImZzbCxsczEwMjhhLWxwdWFydCIsIC5kYXRhID0NCj4gJmxzMTAyOGFf
ZGF0YSwgfSwgeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14N3VscC1scHVhcnQiLCAuZGF0YSA9DQo+
ICZpbXg3dWxwX2RhdGEsIH0sIHsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtbHB1YXJ0Iiwg
LmRhdGEgPQ0KPiAmaW14OHF4cF9kYXRhLCB9LCB7IC8qIHNlbnRpbmVsICovIH0gfTsNCj4gDQo+
IEFsbCBjb21wYXRpYmxlIGVudHJpZXMgaGF2ZSBhIC5kYXRhIGZpZWxkIHBvcHVsYXRlZC4NCj4g
DQo+IEhvdyBzZGF0YSBjYW4gYmUgTlVMTD8NCg0KWW91IGFyZSByaWdodCwgc2VlbXMgaXQgaXMg
aW1wb3NzaWJsZSBmb3IgdXMgdG8gaGl0IHRoaXMgTlVMTC4gV2lsbCBkcm9wIHRoaXMgcGF0Y2gu
DQoNCkJlc3QgcmVnYXJkcw0KU2hlcnJ5DQo=
