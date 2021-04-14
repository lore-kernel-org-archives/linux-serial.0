Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C39C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 00:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80B76109F
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 00:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhDNASR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Apr 2021 20:18:17 -0400
Received: from mail-co1nam11on2109.outbound.protection.outlook.com ([40.107.220.109]:63165
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229590AbhDNASQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Apr 2021 20:18:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHPETd3jryvYn53OiHHs7xXe6A/rlkVcBS1pvFCC2UfuMtRLVThcN9ILkGQaA7KgY8rwKvyXZ+2QzFzHczMG/R+9svbDKNjviy0xYoVoqwkRTdVraruL6TCsZb7+2E1yWpuCzTqZhXDwwZUQk65aacLPoDOEG8BFsfgNl8sXut2eEnnGGU77jQIF3WCxL/TlPFKq/MHHb18IJLa9UpAbmHD3sP3ssTi038WDYA/foQaGK7HHHRrXSzHPOWV4P0kBIroaYP8i0S+1e2A/iCZiXRcuWNlHMx/0pnZwmxy09s9pDp3x58bZbxbZxBTyn10W6wsb59mKk/PbkAkJc34zqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XHatMit0TWfpQ2p8UsYsrizOltjVnL0H85vcnYh8h8=;
 b=HN3K3VWRmuai4ImjTgf3rirSL19UmCIjDFoyWkdjqSsxZPbmAimeTgdD1v6g685eq9bKLI0m4WAK05H0CQFeq4Pk3sWCy6MkVCQTQDHaZyiR2mFYIPmvjKHmpO4fQ9nb5IXw3JNve0Kxf+SpxMZF/cvjoYzTCaurA/a7iXFV5N2DStStReBUA4RF4eWLzDPm05QFb4YeAJGYjBEkIGfHxrrRNuPV3FCz4lKTdUTncLAbHwOVJX6Xboq2bRb426v0blzLBvLMIOUAWZCR0pPYm80lSD6TL1iMZVapHdkJnVv0QrlIsrKer9nfOPm2oRs1wgES/orD8OzSfN6cQUUeJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XHatMit0TWfpQ2p8UsYsrizOltjVnL0H85vcnYh8h8=;
 b=a9qKS3f8eznys2bf4cTR+Htg0hZtzh4rBypo+2AU44TKGR3JO2YRTqPuVJC0IQ4NooFjvxOj3KXmlz6gKVwclDqFGIGjWvJR77QfhiFwqpfQD1feB8hdC7JjYnqIZDWrRNhL1/CNXeSH4ArnbBXt1GinqNWuDzMkva6PDWGYZPE=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB2005.namprd22.prod.outlook.com (2603:10b6:610:8a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 14 Apr
 2021 00:17:54 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::fd2f:cbcc:563b:aa4f]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::fd2f:cbcc:563b:aa4f%5]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 00:17:54 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "a.darwish@linutronix.de" <a.darwish@linutronix.de>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "johan@kernel.org" <johan@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: A data race between tty_port_open() and uart_do_autoconfig()
Thread-Topic: A data race between tty_port_open() and uart_do_autoconfig()
Thread-Index: AQHXMMOddamUYJ7cd024x0cdGKlDkA==
Date:   Wed, 14 Apr 2021 00:17:54 +0000
Message-ID: <1D917C80-937C-4065-81DB-3B64E89C4E7B@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [66.253.158.155]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61bdd8f4-2e89-4f05-0bc7-08d8fedabfc8
x-ms-traffictypediagnostic: CH2PR22MB2005:
x-microsoft-antispam-prvs: <CH2PR22MB2005115FA5E708DBC6E2CF77DF4E9@CH2PR22MB2005.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: thAgsBxw13q/ZGAp0o4abmLWUKTHylFJBMixevCXELUmXA31cd/gXCOICMMUV4tdxPIxAMt0NPiKc9phUepzc4nyohVDufjrWDYkyg2vMq3NiCl3F6uhNOxy8IedeDshZSG65bbpHQLVSBgwqHSAml9MMW4323f7ca6osg4NElxO94/Dx1m5Lr/GjGsea2WcoIJ5NEeqUxknS+e4dQuju0pE2NhAYXvORRFhW50STKlnjwVT79tXQceDq26ndtp7mEyfjyB9b8IoOwBTN9BUzZtSWC7HzD4S7473+Mqm/ziJVie14AYV1yGc0HEFfZrRFl5xLC/YBUoK3u3NE7DIevvC/mkvLGDAfmk54KtMMfjlivz3L9CKhOgzQJxkXI886BXWjT2q3rnY+ixNcNnkk4vUMYP8Wmtp/067zUHOwKyaojJ2nPHkNGNii+8/Q+1+iWTGAduZHo6J4OdWLXOD8v+OLxws9Yx4w4QklMTrMQdVJzEGzP2MyjOYhgNO5n7GFqC1c8CpPPPLFhBS30CH7i9elA40HItnZyNq0+hSnXBabIaKf2HYtVb5IfY7Pjep8Y2cAxhBuervUXQ5BJzSM9fn94gNcpsOM+7+DQkapTnP35gfdmxLmNntQIPjotqJUDLwRMtWbSp1xPmLdSImxA4cR+xurujnVAURx3BcdwI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(136003)(396003)(346002)(186003)(8676002)(4326008)(33656002)(2616005)(75432002)(2906002)(26005)(38100700002)(5660300002)(4744005)(110136005)(8936002)(66446008)(66946007)(316002)(786003)(6486002)(64756008)(66556008)(6506007)(66476007)(71200400001)(76116006)(478600001)(122000001)(83380400001)(86362001)(36756003)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OWdkdWwzUktCN1RwaTRneHprTlVObEcvVkxtdEhRTDdsK0dIRS9DSkM4VHNX?=
 =?utf-8?B?QTJhVHk4a2xSOVR4aEhsZEhiZm5nOEEwY293ajRMT0lMWWlEWjhWRXVpNWhm?=
 =?utf-8?B?Sll5bTR2UXJsTFJpOEZ6ZjlmTEFhNXZEKzVsZzNWbFZHYjd2RDAwaWVvbkFI?=
 =?utf-8?B?YU45d0NBR3ZyTHRNTm5RczNFeUlDQlM4UlFxU21EUzNDd0JTYkdHMjhoZDZP?=
 =?utf-8?B?U3dITWo3eXY4WmJLb0tZTGpNSjVrY2oyamI0UUFBNzdDZC9ab25NZWN1b3cr?=
 =?utf-8?B?RFkvVFlvRzUxUTh1RFdRVFpYTkVVZ1RweGpBRkpOalpXL2crQ3U2WE85VDR4?=
 =?utf-8?B?bEs2OTVaeHhKbENBM2lSczNSdHRFNmJRa3VUNWR3Q01mbTlNL3lFVGZWd1Fv?=
 =?utf-8?B?ZzUvOEdTN1V2QkE2U2VuSW5ubkQ5MUlkY3l2L3ptZ2dsVnNTWVQ2Sk5ZbjRZ?=
 =?utf-8?B?bGM0RVpNRTQ4WmQzWER3YllQTlNhSW9JOUQ3M0VIOXlYWHhETVF0YXZUNDJL?=
 =?utf-8?B?akRTNHFNUmhqN05yVFdmTitYYTY4am1MU29ZSGZaRHdnZ0xjUGxpY1FuR0lr?=
 =?utf-8?B?cWJ6WEtLT0ZwNmRIRGZjT1N6QTNrZkVQVEIwWWc3eENnL2VEZVZtNlE0WVFZ?=
 =?utf-8?B?MWUzL2Y1c2V2a2RBZ205UTI0MW1HOFhnWmJMMldydko1dk96dnEyZ21WaCsy?=
 =?utf-8?B?cEM1TkFWYTdvVWhnWjdWZW5mUnVPUWk2UUhsUUQ2ZXZyV3RCblJiZXM4blpq?=
 =?utf-8?B?aFBCSGhDc3FxZTFHVmo3R080SnN5aGpoNXd0UklYS21CL0ZTYlBkTzI0SmQz?=
 =?utf-8?B?cURJTEZlamVtMGtSZXczbVFhUUFXekZCL21LYXFZeWo3QWVna2tJVWY1Vm5C?=
 =?utf-8?B?OHdQNHkvWnlVSzkrWmtEWTFqSUYyRXJqWHZsTzRPbExRWWxPMXVCWjFNYU1z?=
 =?utf-8?B?MUU3ZDloaXh5WStLSVpjYk9zSFphR1ViL09uV3ZMK3VSellYZ1FBOUg3VWxz?=
 =?utf-8?B?WW90SWNGM1NBYUU5MXd2cC9Ld3ZJU0Y0TU9Hbmx4TzRObXZhSWluSEZyMGdV?=
 =?utf-8?B?ZThGb3ZuYWxBSnFPNjNjdkpBRU1ScFlDMCtnM0g5TTZXUFFlTWk5RUxQd0hs?=
 =?utf-8?B?eFRlWUd0MzVnYmVPVFU3bnd0aGgzUWo0V0dwWWhhUlFwTFVCWDlGZXhTalVu?=
 =?utf-8?B?WkRldStkTVpoK0M2SHBBR2xVckZkZSt5VFFITjNMd0x0NkdHVDVkdHhlUVhN?=
 =?utf-8?B?c2tpZVhYWktiV1NEZUlYc2h0NThQbEMzWjdFVkJFbWZvaGxBVDRHRWVObmgz?=
 =?utf-8?B?VWx2Tzl0dG02MnN2eTNXYW9RQnlRRTRpV1o5ZHhCVVR6N0d1aFNBWTdTbWhW?=
 =?utf-8?B?UGM0SXJrQUZBUExHcHdDNGZ3T2s0UFRPbkxCeFc0eHdRcnVRMURUcXROenlt?=
 =?utf-8?B?aitrb1NCalZieHBJeFI0NWZmbWN5RkVWSnNGTGh3K2VYbVNKcFYxN0E2T0ZR?=
 =?utf-8?B?YWUrbEhiWk1DK1E0NUVFY3pDelZvM3p0Q2dkSHFWa2VKSk93Y0JuOWg4S0xm?=
 =?utf-8?B?d2FjQ3JTczVLa3NsZlY3bkRaVGFmVjA2OHVEUURsZ1ZFYWJvU2h4Zm5Iejhu?=
 =?utf-8?B?aHVIUVZQSTlFOEVlVGhWTldFOWhJZ1lRTHJ6TzdBaTEwUXRROVZWNUNhbmJD?=
 =?utf-8?B?eTFuNFQxM1FKTEwyaUxOUDVGRmlyRmFrSEdzTWl6ZHdUZUZ3cndyTUtqOWl3?=
 =?utf-8?Q?mzN53lF3P36qavLVVXNTUGBGXqCpZ/R929jAWoa?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D7477EC0551A943BD8C04619EC3B396@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bdd8f4-2e89-4f05-0bc7-08d8fedabfc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 00:17:54.5982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2rirX6MMI1abiGhNQTHS1HNK/yyZBVEnqDgTPqnMkmubbiJvtkPedhzZKlssBJnH33fGqZOfsybccAR4nTAhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB2005
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGksDQoNCldlIGZvdW5kIGEgZGF0YSByYWNlIGJldHdlZW4gdHdvIHR0eSBmdW5jdGlvbnMgdHR5
X3BvcnRfb3BlbigpIGFuZCB1YXJ0X2RvX2F1dG9jb25maWcoKSBpbiBsaW51eC01LjEyLXJjMyBh
bmQgd2UgYXJlIGFibGUgdG8gcmVwcm9kdWNlIGl0IHVuZGVyIHg4Ni4gSW4gZ2VuZXJhbCwgd2hl
biB0dHlfcG9ydF9vcGVuKCkgYW5kIHVhcnRfZG9fYXV0b2NvbmZpZygpIGFyZSBydW5uaW5nIGlu
IHBhcmFsbGVsLCB1YXJ0X2RvX2F1dG9jb25maWcoKSBtYXkgZmV0Y2ggYW4gb3V0LW9mLWRhdGUg
dmFsdWUgb2YgcG9ydC0+Y291bnQgYW5kIGVudGVyIGludG8gYSBkaWZmZXJlbnQgZXhlY3V0aW9u
IHBhdGgsIGFzIHNob3duIGJlbG93Lg0KDQpDdXJyZW50bHksIHdlIGhhdmVu4oCZdCBmb3VuZCBh
bnkgZXhwbGljaXQgZXJyb3JzIGR1ZSB0byB0aGlzIGRhdGEgcmFjZSBidXQgd2Ugbm90aWNlZCB0
aGUgZGV2ZWxvcGVyIGhhcyB1c2VkIGxvY2sgdG8gcmVhZCBwb3J0LT5jb3VudCwgc28gd2Ugd2Fu
dCB0byBwb2ludCBvdXQgdGhpcyBkYXRhIHJhY2UgaW4gY2FzZSB0aGlzIGlzIHVuZXhwZWN0ZWQu
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KRXhlY3V0aW9u
IGludGVybGVhdmluZw0KDQpUaHJlYWQgMQkJCQkJVGhyZWFkIDINCnR0eV9wb3J0X29wZW4oKQkJ
CXVhcnRfZG9fYXV0b2NvbmZpZygpDQoNCnNwaW5fbG9ja19pcnEoJnBvcnQtPmxvY2spOw0KCQkJ
CQkJaWYgKG11dGV4X2xvY2tfaW50ZXJydXB0aWJsZSgmcG9ydC0+bXV0ZXgpKQ0KCQkJCQkJ4oCm
DQoJCQkJCQlpZiAodHR5X3BvcnRfdXNlcnMocG9ydCkgPT0gMSkgew0KCQkJCQkJCXVhcnRfc2h1
dGRvd24odHR5LCBzdGF0ZSk7DQoNCisrcG9ydC0+Y291bnQ7DQpzcGluX3VubG9ja19pcnEoJnBv
cnQtPmxvY2spOw0KDQoNCg0KDQpUaGFua3MsDQpTaXNodWFpDQoNCg==
