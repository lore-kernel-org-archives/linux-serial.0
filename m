Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D2DC43334
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jul 2022 12:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbiGNMO4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 08:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbiGNMOu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 08:14:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5C157E21;
        Thu, 14 Jul 2022 05:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjk4s9YneQILad0z8TrkbtpKVApied2oJI8A/f/OnkWkpqYClC0gRxNCkaCQiU/U5vn8BbWWH8YcVuTwXEvDHINY+a4H+wuxa6Q5097dWdRuqHuCdKVqDgsuz8FTpXOuVxPXbYoMdOzGOfdjFcbU8NNoocRLA8gQ5FES+pfQogWZrU2jF2rUll4bJ8PZ1ObR+wGYRXvkhY9MltX+H5VK030cbMPjzghAYUnra7bnpCWpeAui7HgEDz8P49ZR76mZ2YBgka4+kfu+F8ggXUtTKROjPGMHxHRP/+MqT40Z8uSQn2sdAHGOA7sLkDl85txonE88gjzaj+ThLEgskiIF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQe4nyS36Tc0Vxrb27XS5sodCsBucWX7XuVM2BYXcXM=;
 b=gUKxCrK0eXNI7hEY7bI+toou8It3E/q2YvfnsSkUFcLoL/FdiNk1ITgRJDJLq363L/OWDTVP1mu4kRGUJmXVtciQdvLg2whKKjFpMupJKsvalK15cFWx3qWZgtpq14NZ3kH3WUhAxGFR95u2VvbSO2WH1C+T3znfdj+MTMHM60eMyffP5z5FvKiJn+Ow6QQ9Dj8ROjA+pDtOBHvxs8OpzpY0RBMyEcJIpljPob26bgKxxr9eEmNokUIACjH0vv0J/SDvWfCvvnE9+euzdwU8fqNRMnPdz1O5qMsvgW+P0PirEIY5BYoK04mwzMJtaLm2GXNYmpW+q605QT1P+n1ZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQe4nyS36Tc0Vxrb27XS5sodCsBucWX7XuVM2BYXcXM=;
 b=3JuG+UW7Q3WaKjZHRUVLvKsaE5wIKSW6HuWW5/LcThnyDmewCq5BG0sqZHGyvCWtcCkbiom8z5FfjHIWL4gveNucOSLxEIjpyeTzwsckLqWchFmqmMVo451Z42DzF1+79ehZecUJZdLkQRI9cJwT3m9gJrKbTjkxGV17+e3A3II=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 12:14:47 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::c070:5fa5:52c4:5d43]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::c070:5fa5:52c4:5d43%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 12:14:46 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Srinivas Goud <sgoud@xilinx.com>
Subject: RE: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Thread-Topic: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Thread-Index: AQHX2tuZuKAQ26hOP0aW5QzRukRvFawbJZYAgBClDzCAZ11GsIA42cGggAmXfoCAeoOVgIAvDfaAgAAR1oCAAAMjwA==
Date:   Thu, 14 Jul 2022 12:14:46 +0000
Message-ID: <BY5PR12MB49022C7A09F42E8B5A1F868881889@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <e1d6913bfe5ce023d7f6ea106d0359142063e694.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <YaVPYiGmDsqY+1at@robh.at.kernel.org>
 <DM6PR02MB663589B3489C53A34DC25A31AA719@DM6PR02MB6635.namprd02.prod.outlook.com>
 <MN2PR02MB6640017950EFB0FD21D2AD91AA339@MN2PR02MB6640.namprd02.prod.outlook.com>
 <DM6PR02MB66352597DBF172ACC5307274AA179@DM6PR02MB6635.namprd02.prod.outlook.com>
 <CAL_JsqLV3De0O2WDq=w_CQbvAiJVvQ-=V9XuC1tJyZNLyneDZw@mail.gmail.com>
 <CAKfKVtGrdh-iQP7YKUBe37HVeZcU-UV3A3BHKjcnggBFR94eNA@mail.gmail.com>
 <50bfd52b-6fe0-546f-9121-0145aac91289@xilinx.com>
 <9d9067f3-5b2d-6434-ec2f-93b4a97a6588@linaro.org>
In-Reply-To: <9d9067f3-5b2d-6434-ec2f-93b4a97a6588@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-14T12:14:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4124c7f8-2e04-4bf5-bf4f-1e9de1268d2a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c59e8ea9-e18b-4451-0bc0-08da65927170
x-ms-traffictypediagnostic: SA1PR12MB6895:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pyU1aBrEHXc4ZpyqH1DmbgT/yHecDCKpD5mAKtEu4ZxVccCGosTbkyaRA4PHzbGoYkSkhynbpoQjsrevWhGdLQv2+a5jvYXumRiSONFmpbGU46xz3TjbVpJRfchmMPFn7n+0aeR11JE0hK9FHrJLf6S6YaxbTtaGyQ3ikCr7U3zph5uYt8tq7h/9hz8ge23Xx529mM5C/A4EZ2l5bL5YcHXZXsdYUyrfwfT+ANJJhbTvkgjhby+uJC/nzoSvt9jZVdID6O6cYGJ/Pu8GWwaNwxwPRBw5vsZgkwxb0uDDc4PAyQOUexSUm4TBi4LWfeoKkEvFb7U/5H10Y1WFmTX6kIvG93yecg6v13InAkEh7Gde+cFEp/w7w3mKmNGuzyRNqsC7ziUtUUbDzMQE7vXAJdYJzG3pDYOl5Mb2o4AjaoFmZWkra7Fxli81ktomMWETGmECqTSDEDPrCld2RbQ+rcSJeSG90YUXFXXhKIBl30HLO8sjWrFT6dRvwEV7FCuS26LpybeEOzxcNU7AkqDUPlLupiBgAz0b4Uy0AfjsvVMPB+egr4EcDMZ05uQZSNMFUmLC0kG8L1KR2KDqaZ0df3K3FMeW76r5GaeCJ+EtR96uEytBFtNLCJKArPcJWi901JuwSGJT1tUwWIZRfEW+eSNBj3YPkIRdH9Iy4arbN/YfQeOQE49viCIvb94893PnOO+s9TfqogDcFZ325OBLK+E5NK5yMTQc21U1U3V1+uJSaY5tCzqkT0yG0VsquWNLCtnfdkp5J1CBcnicDNSf4kiRUU1MvPVIdShW9l1E3xQ1J3hP5bjHP0Smf2qd5lKy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(33656002)(9686003)(71200400001)(38070700005)(41300700001)(2906002)(26005)(107886003)(186003)(4326008)(8676002)(53546011)(38100700002)(122000001)(66476007)(76116006)(66556008)(66446008)(66946007)(6506007)(55016003)(54906003)(5660300002)(316002)(110136005)(7696005)(86362001)(64756008)(8936002)(478600001)(83380400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?citqK3FnTjlZWFBEVVVFTURQNlhuSzZYOExwcVdiTXExMTZYUGVJS0t3S1l0?=
 =?utf-8?B?RWhNZVZielVqakZMUlJrNTR1a1pwR2xxNlM2VGltVkFYR3RpNVNBUXhhSno1?=
 =?utf-8?B?VmVKVWpEdGNIRkZoUnNydXhreTZqRXBJeWdsdmhWVll3aUx0WmhqWS9LRS9B?=
 =?utf-8?B?QmpoUWF0a0l4U2x4eVBHbm1GVzluSTRzUlBCSTd3ZE95ajFEMGZtY0pEQTFa?=
 =?utf-8?B?ZW81dlRSZy9hRU01Z240KzA3ak40a0QrdkxIS3AvRzk4QThmbllzN0l2MUo0?=
 =?utf-8?B?aWJmOFZlYjJCZ0pMTmZ5VU5QOG5PL2VrZmYxL0FtejJrN1ljK0NQUVdFa1BU?=
 =?utf-8?B?cUZITHQ3MEtiMjBuRXBac09JOERjdkgrdk5wNU5tczA2Sk4yeWtsS0dZL1o4?=
 =?utf-8?B?MU4vQWR6V0svbUJRVjl1SUR0TCs3ckJlSHZIRUNEc1J3RFJ5a09aODlkOFR2?=
 =?utf-8?B?STNaUDJFdUhkYnc2QVBpZGNNSnFoOXMvZDY4WVVDNnc2YW9WRm5jc2hyWEND?=
 =?utf-8?B?a2U5c1l0VXBUSmZISVhjdUdwR0c2YmxFM1FOajRJTkVRU0lhUFRPVm9DRC9T?=
 =?utf-8?B?RjVOekJBZFQ1dTM4Tk9SM1NBQ2hBMnd2Y1NtdGpjaEhwNzVaTHBNOFlpWUVt?=
 =?utf-8?B?ZWVidnRQeEFkWkp0V1l6aHdWeCtidDNFNEcwZHZtNGNDZDF0Qms5NVgxTjdh?=
 =?utf-8?B?Ync3UDhrUmJBUGdvZ2dOWFZqbFluTHRrTlpFUW1hd3lQMldNMXgxTFhLOHBG?=
 =?utf-8?B?VVFsNnNucHYxSWFxdm94aURGNVhCK0tJNzNDTlRVK1hjMVRPUFhHbU5NSGxz?=
 =?utf-8?B?T2hEbWRLcWFCTHBweER1TjNSbEJHc3hqOExTNTlUc2tvYXYxb2hONkFPcnBL?=
 =?utf-8?B?QWx4ZW41ZGJma2N0d0tHSFhDZ1JjV0pIaWJERlQ3ck05SENzRWpXYUxIelp4?=
 =?utf-8?B?WWVTd0ZCYmYyQlhGbHFYUThacnVVYlBjZ29CRzU3MFdpRGQ2ZnNKdFRIcG9V?=
 =?utf-8?B?TFNkNHQ0aEswUWRUS1VnTzMyeFNhelFKR3k2RXcrWnFrOFRleVp0cXpUdHhq?=
 =?utf-8?B?ZC8yamNzeE1mbmphUk1KU3Z3aW1lWE83KzkwNlBxNXQxVWcwY09rWmIxaTM1?=
 =?utf-8?B?MEh5MTU2b1ZLQnRtQ0dneDcwcjl2ajY3a0IzRFBwZnNKWms4bTZ0OFBZRmJV?=
 =?utf-8?B?WVh0cFJkdVJyZ3JFY0pJakhpdVYrMWowV1BGcW5GMHpqaDBTTGdLRG9OTG1K?=
 =?utf-8?B?Vm1JZk1sWU8zUytsc2tmUk1PV2VJa0x5QndXTXdKN0lDeFlwNGx5Yit0TVlJ?=
 =?utf-8?B?aFR0K3RhbnFoSTQ2cm1xN3Z2REFEMGpDRmRST0paN0ZDMUtGTEp6SmtacVZo?=
 =?utf-8?B?N0xXYU5saGZoUlBkL25Pb3dMUzdZMmNnVFFIZGZNb1dVSkFrZHhlN0EwN1FF?=
 =?utf-8?B?UjVIZjJlem5vT2NCc05UN081VHpOeVdoMkJzajJ6LzV0Qm0rbmdPTitTbjRP?=
 =?utf-8?B?OERvOGRTQmtqMVlzMXhxT0xaZ3YyOWt0K0JLUWVCcThEcDlSOEtMZUcvRzBC?=
 =?utf-8?B?QVlOUUVVSWsva3hmY2xab2FFSlk1L1ViUWx6bFBKSHlNKzJKUlErMjE3c2Vr?=
 =?utf-8?B?ZVlmWk85RjFLUHVIZ1RRbWtQL1RmUUxBNzEvSXVZUVVzeXhFQk14TUd0K1Jo?=
 =?utf-8?B?N0MyZStHK1V6T3l1UmdUVXZDV3hPV1BEK240YVBZSzJ2ZXZJK0x6dVU5aGhl?=
 =?utf-8?B?dmtpMTZDVTJqUG41UFFLK3AwZ1pmY3E4cjZhTysxbDg2UkNMZkpxdWpwWTB1?=
 =?utf-8?B?eHpQMGQ0WW14ekZhQVJwL2QzM0phVXZRV1dvTFFzZytVTC9EbmludnVRd1R2?=
 =?utf-8?B?Qk85Wjl3anB0MjgxdWFzZGh4T1JSTjBIbkQ3Z1ZMTWV0UmVvY0x3L3NHS210?=
 =?utf-8?B?UXd6ZDdZRlZ3RUhRd2J0VUt0OXhYUnZPZWNYOGVWZklmMS9pSlpZT0VtR0JF?=
 =?utf-8?B?MitaVHBJOXdhZFRweUE2N0VGUHNnaUFhM0RrTlgzT0UwNk9PdCtPZlMxWU00?=
 =?utf-8?B?amlnbnY2ZGpkRDRmUTBnVWR4WWYrcG9mNElRbkVNYk5sbmlrU0RnZG14b3ZB?=
 =?utf-8?Q?Rkhc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59e8ea9-e18b-4451-0bc0-08da65927170
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 12:14:46.8674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wv+hcfHkrhEhg2UI23x1IrQwS6H+SRIJjxPVSGbDlIAA6Vavw7HzUNTb9jp3wpzZhmulnYaDgXUen20ePDbyuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3ps
b3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgMTQsIDIwMjIgNToyOSBQ
TQ0KPiBUbzogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT47IFNodWJocmFq
eW90aSBEYXR0YQ0KPiA8c2h1YmhyYWp5b3RpLmRhdHRhQGdtYWlsLmNvbT47IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gS296bG93c2tpIDxrcnp5c3p0b2Yua296
bG93c2tpK2R0QGxpbmFyby5vcmc+DQo+IENjOiBTaHViaHJhanlvdGkgRGF0dGEgPHNodWJocmFq
QHhpbGlueC5jb20+OyBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IFNyaW5pdmFzIEdv
dWQNCj4gPHNnb3VkQHhpbGlueC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkdC1i
aW5kaW5nczogc2VyaWFsOiBwbDAxMTogQWRkICdhcm0seGxueC11YXJ0Jw0KPiANCj4gQ0FVVElP
TjogVGhpcyBtZXNzYWdlIGhhcyBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBQ
bGVhc2UgdXNlDQo+IHByb3BlciBqdWRnbWVudCBhbmQgY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0
YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvcg0KPiByZXNwb25kaW5nIHRvIHRoaXMgZW1haWwu
DQo+IA0KPiANCj4gT24gMTQvMDcvMjAyMiAxMjo1NSwgTWljaGFsIFNpbWVrIHdyb3RlOg0KPiA+
IEhpIFJvYiBhbmQgS3J6eXN6dG9mLA0KPiA+DQo+ID4gT24gNi8xNC8yMiAxNDoyMSwgU2h1Ymhy
YWp5b3RpIERhdHRhIHdyb3RlOg0KPiA+Pj4+DQo+ID4+ICAgPHNuaXA+DQo+ID4+DQo+ID4+Pg0K
PiA+Pj4gTm8sIEkgZG9uJ3Qga25vdyB3aGF0IHRoZSBkaWZmZXJlbmNlcyBhcmUgaW4geW91ciBo
L3cuIFlvdSBoYXZlIElEDQo+ID4+PiByZWdpc3RlcnMsIGJ1dCBjaGFuZ2VkIHRoZSBJUCBhbmQg
ZGlkbid0IGNoYW5nZSB0aGUgSUQgcmVnaXN0ZXJzPw0KPiA+Pj4gSG93IGhhcyB0aGUgSVAgY2hh
bmdlZD8NCj4gPj4+DQo+ID4+DQo+ID4+IFRoZSBJUCBpcyBub3QgY2hhbmdlZCBhbmQgdGhlIElE
IHJlZ2lzdGVycyBhcmUgbm90IHVwZGF0ZWQuDQo+ID4+IFRoZSBsaW1pdGF0aW9uIGlzIGNvbWlu
ZyBmcm9tIHRoZSBBWEkgIHBvcnQgdGhhdCB0aGUgSVAgaXMgY29ubmVjdGVkIHRvLg0KPiA+PiBU
aGUgYXhpIHBvcnQgaXMgYWxsb3dpbmcgb25seSB0aGUgMzIgYml0IGFjY2Vzcy4NCj4gPj4gVGhl
IHNhbWUgaW5mb3JtYXRpb24gd2lsbCBiZSB1cGRhdGVkIGluIHRoZSBWZXJzYWwgVFJNLg0KPiA+
DQo+ID4gQ2FuIHlvdSBwbGVhc2UgZ2l2ZSB1cyB5b3VyIHJlY29tbWVuZGF0aW9uIGhvdyB0byBw
cm9jZXNzIHdpdGggdGhpcz8NCj4gDQo+IFVuZm9ydHVuYXRlbHkgSSBkb24ndCB0aGluayB0aGF0
IGFueW9uZSByZW1lbWJlcnMgY29udGV4dCBmcm9tIGxhc3QgeWVhciwNCj4gZXNwZWNpYWxseSBt
ZSB3aG8gd2FzIG5vdCBDY2VkLiBSb2IgcmVzcG9uZGVkIGF0IGVuZCBvZiBNYXJjaCBhbmQgaXQg
dG9vaw0KPiB0d28gbW9udGhzIHRvIGdldCBiYWNrIGFueSBhbnN3ZXIuIFN1Y2ggc2xvdyByZXNw
b25zZSB0aW1lIGZyb20gc3VibWl0dGVyDQo+IGRvZXMgbm90IGhlbHAgdG8gc3RheSBpbiB0aGUg
Y29udGV4dC4gOigNCg0KSSBoYWQgdG8gY29udGFjdCB0aGUgaGFyZHdhcmUgdGVhbSBhbmQgZ2V0
IHRoZSBkZXRhaWxzIG9uIHRoZSBpc3N1ZSBpdCB0b29rIG1lIHNvbWV0aW1lIHRvIGdldCBhIHJl
c3BvbnNlLg0KDQpJIHdpbGwgc3VtbWFyaXplIA0KDQpXZSBhcmUgdXNpbmcgdGhlIGlwIGZyb20g
QVJNIGJ1dCB0aGUgQVhJIHBvcnQgdGhhdCB3ZSBob29rZWQgaGFzIGEgbGltaXRhdGlvbiB0aGF0
IGl0IGFsbG93cyBvbmx5IDMyIGJpdCBhY2Nlc3Nlcy4NCg0KU28gdG8gdGlkZSBvdmVyIHRoZSBh
bmQgZGlmZmVyZW50aWF0ZSAgSSBhbSBhZGRpbmcgYSBuZXcgY29tcGF0aWJsZSBhcm0seGxueC11
YXJ0Lg0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
