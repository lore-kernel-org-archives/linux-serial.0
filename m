Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7102DC32772
	for <linux-serial@archiver.kernel.org>; Tue, 23 Aug 2022 13:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiHWNMG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Aug 2022 09:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiHWNLg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Aug 2022 09:11:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1F1134901;
        Tue, 23 Aug 2022 03:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao3/ZjtShwAOlqL0dn2qyw3FhaSVyXNr4nM7cTw4EJ+M34f6/TeKdbjHReOGgFomylDTedOm3anafgn3DhmDDKW5oMBaHrzdSfYC8r07ErZicIp3Ah7fR8bl3sB3Po4W+ndqaGivoavLvSskTZXOpPSADAYElaJ/CpIiuOy8orUnRs3DFTdlFYC8I/gDGi5Lt7og9M0a9p3AeQZ5EsiG79JWgkcEXn6M0mjLzeMTGpk9PZ+xvds5ZqoZ1VC0zDGfVfa5F87nfwwcIBe4iqwHmxahKSS0CPDfgvq8Zg1WqgMNuUTXSIC+kDiU7blv2EBh9zejT05Uk1CZS5Neh2OBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8k8eLc5f9tion18JH5aHdroxRxvhJrvuCzV0RkZvc8=;
 b=SN1NLNHlut14mWyoOg7HKQxA4y/SJgWLJwjZbwRJYp+iFJzFE3qZHpDWZkQcu82PJ0M+nmbZkHV6qD69+pbVVwuLocMNTcx8J278gYFeMPa8QIjsinwOMG9dnpNKcxeW4CBSGvYtS0BiB8hPTkBGybmBOo2SoR0mZEr5y1dBkjcev/j6w5WTMICoT8zEogJsoZktFbbrvGsevjRc2mWu/j7Ya8LPnPfD/1wMNo6LYlGQnMisK6katdqvJWTTjX6F4SGTTlxQIfXGnBZNXLcqy77ik6i/2+k+cKV3PLYt9nEzKskOzswGe6fL14BOyx7kcNCm39Js3gQ31FK0yLbniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8k8eLc5f9tion18JH5aHdroxRxvhJrvuCzV0RkZvc8=;
 b=KcNo6QCUmfuQUvP6AB7uhCZo3LNqYjcIfva1lsHc1ELsVfoE90eVSdHG46v4X/BVRCRjVWeXOnK/s879KH0zfHhvwVzX79TGz/E3GEOa9mNY2T8ivaVwbfNwX/J/VL8kUbbU00kRk8Eb/8+sS35D9VlxIoSs/iO9pu9oO0eBK3Q=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by BN6PR1201MB0034.namprd12.prod.outlook.com (2603:10b6:405:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 10:10:15 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::c070:5fa5:52c4:5d43]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::c070:5fa5:52c4:5d43%5]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 10:10:15 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     "git (AMD-Xilinx)" <git@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "shubhrajyoti.datta@gmail.com" <shubhrajyoti.datta@gmail.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: serial: pl011: Add a reg-io-width
 parameter
Thread-Topic: [PATCH v3 1/2] dt-bindings: serial: pl011: Add a reg-io-width
 parameter
Thread-Index: AQHYtifLbRyaybLfYkKPGBJzuXrOy628Q2yAgAABD3A=
Date:   Tue, 23 Aug 2022 10:10:15 +0000
Message-ID: <BY5PR12MB49026922AA85F3AD8508712B81709@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20220822130333.5353-1-shubhrajyoti.datta@amd.com>
 <20220822130333.5353-2-shubhrajyoti.datta@amd.com>
 <17899835-b7fc-fa34-fec4-2462c7829f3d@linaro.org>
In-Reply-To: <17899835-b7fc-fa34-fec4-2462c7829f3d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-23T10:10:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=32a20056-d2c2-41c7-a52b-aeecb9818989;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f85d26dd-d2b4-43bf-0339-08da84efacc3
x-ms-traffictypediagnostic: BN6PR1201MB0034:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lKdStnBecgI3+EZ360zpH12mHUDHpLsLDtHSfMKOBuK+Zqg17FwUP1CddNpRxpy1Zj9W4UAwptwGOWXlMN9PxX+k1ufGQTEhySQb3Zpdt3bLToJdsUFkD0q5idhpU7upV9crjz2QErT5oU8xYca504+JTpjJBa7vIqWMHZNvzS5gCZT/jWXFV5wnawnSMqmE2tC1gKfsTVz2EClbBfpqtCawI7tddOoS7oWEVd3WcOfNJhSMZyfY9wtFVuPGB2dtl3qzA3BTIObw4FlJhKxuGZoFYKn1bXx6alMfJxEUnvRzSiQzQv9OCcrCPga1z6LRQfhNfAOcFJKNqGxg/SYQ3l6o+VTgIZZRa7BqRK+o1ZwFs9Vu1HVEgwN/AmGINh7PacuytsD2pGEsGjnmvhufF1TbZJoVwLMtfqfJbCEb5uFeCsVb8uwULfhwRGot5UFU1gM2IzrWxJkjYN3VoDHCSJcQ+Na6nO7mqbZqhXpQAwgrz6X0j6XNywR8SWvia+2vEX6fv63aNHcD7Chnj2iBu96Xmhzt8DENmPZqZmZxUKIfEhGpuAPCAYLTKfLsQlb1881djTvd8Xkb9ElZAmYmEH4OKJy+KO2MFJi0+xHkEbB86twl2Q+tuBrhw9ctxsqzEKG2UV+XdIkba3NZ7/1wbmhkH0PlV/zo6ss+p43OW6wtztDqwvV6MBMr5M8nmciHP+p4w3Zbui+gvrmrU2BttKzey0pOLs7PlO6wBKKYgmT+Lk1G7k0X+QnLxxvQ3BZQT4xL8chqqJuY0NVCJqkfzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(5660300002)(64756008)(55016003)(4326008)(66946007)(66476007)(8936002)(76116006)(66556008)(66446008)(52536014)(26005)(83380400001)(478600001)(33656002)(53546011)(6506007)(7696005)(9686003)(8676002)(186003)(71200400001)(41300700001)(122000001)(38070700005)(86362001)(54906003)(110136005)(316002)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K25IWm4zRVpSOXlLSEJVajhLL1V6eGg3TElzVnV6SlJLeWhNdmFzcnhLNzNX?=
 =?utf-8?B?Ny9sUHR6TG1URy8vZVVBVUlVTVQ3WlpnQmlBdjJNb0N5S3hBZzM4MEJ4OG9K?=
 =?utf-8?B?L2luMkUrUDNoaEx2ai9wY0hXK0ltZm5zMkVvd1ZOMjllVUZnSzBZeGc3RzJn?=
 =?utf-8?B?VWtmK01HL2VZYzZ1U1ZZTXRvS2lwbTdlZXhMUWpWaCsyMXFnaURldHJ6L3F0?=
 =?utf-8?B?NWdTSytZeEpYNHluSUY4V1loUFNYL3NUNUVCMzNieVVjMkQ1VkdRUjNIc1dS?=
 =?utf-8?B?Y0hkNC9QWnl5L0kwNmw2V0FiVzF1d25lUTdRZlNJVzAxUDhMNUpXUjl2bmNw?=
 =?utf-8?B?MVQwNkFFWGI2YjAwa3J2WFJkcWVkUmJLZnU5bDBOL0syV0RGRVdEeG1YVE5o?=
 =?utf-8?B?YjVFZG5ybDA0NTY5d3lQeU1OZkgzWkUvTkVnM3hPK3NaOC9LRUFSbWVIVUJl?=
 =?utf-8?B?QklDUUlPdWpzV1dwOFFBWERyOFZqRVdwZWlaUi9BL280aGRHSWJWNkw2R1lt?=
 =?utf-8?B?ZGh0T0xEMzVLMlpsczY1eHI0SXk1dUoyZVJ1NFdJa1UvdDFGdTVsalFZcTFi?=
 =?utf-8?B?QjdxTFNKWHpZS2VRaVNiUHZUNlNPSnZPRHFIOGRrQzBrSGtPVGVpbDV0WWdG?=
 =?utf-8?B?SVFIUXlzLzIrN2RnSWZHaGZ6U1phbkg0VXdPQjVtMUhtTFMrQm1XT2VqdFpj?=
 =?utf-8?B?R3JMN2h0L2d2SXdiZXNuZlRkQjQ2bFdmOW1UQWNGV1dZd3BtYzc5bE1RU1JS?=
 =?utf-8?B?NWgreWlvZ3RJK1NVWlFBODA4SUpYWE9oUC9kNGFWUG41NnZLeDgxcloyMGtW?=
 =?utf-8?B?SENab2pORmxQc29iK2x4M3JZUGp5U1JkNVZySUNDMnF1RmxoZ0dYaUNobWcy?=
 =?utf-8?B?NUpaUjVSSUtURmRNckU0azVUQjNCREgwN0tUOFZSR3FGN0hhZzI2Qk80RVdX?=
 =?utf-8?B?bVdpR3FWZ3pCRzRTTThYeVoyOFFqa0lOZkhpZzRZQzk2UDJZNjJFNlFZMjRX?=
 =?utf-8?B?bmZVTGQ1dDZUd0tlbUZ5aUkrMUVCZlk1ZWdpMnhtN29tV2Eza2ViQjN4dWw3?=
 =?utf-8?B?ek5SdlBibUZDVC9oLytIV3dBOWdNU011MjQxeXY4cFBIVjU4M0RNMUZadjZ5?=
 =?utf-8?B?bWVmNWgvTG1WNEFYMHRFd2ZDUnVzWnVKYk1PdEk3OXBib0NuY3hwVjJidVd1?=
 =?utf-8?B?WlJMeXRrQ2JhL2l1dEFGRlUwb0tzWVRhTmJoMTNkMFROWmxud1Q2T1ZqVjEw?=
 =?utf-8?B?L0IvUFN2Smx4dEhjckdacXNhR2JuSDRXV0FKTVZUdUJhS2xNOHFxZ2JncVRu?=
 =?utf-8?B?aWpLbU1Ca0FxbzFHQVBGcGFrZDB4MUZLN1o0eTUzWms5dUdmdjIwOFo1N2ZE?=
 =?utf-8?B?a1BTNlVnUTNzTnprN1l3a1pqSjNsUFBzSHQrTzk1cG55U1VLQU82eFdvZktJ?=
 =?utf-8?B?dkJNejdtblFxdmJrbyszQUFQa29WU2dFWDJJdHo5TXQ4RlVFNFNqb2RSOUtH?=
 =?utf-8?B?MXpnN0dMc0xIcUNBdXRiK1g2c1BKQ25WWFFMU1BubEx6SUR4UnQrc08zVE5i?=
 =?utf-8?B?U3BmTmUxUXBtWGVzSGNLZzM3angzTjgrbjhiT04xczJGQzlnWlA1SVVDd2Rw?=
 =?utf-8?B?NjFYbG5NYVBja0N6ZUFva0xsL1VQNWJTdld2UG1LM2w3NXFlQjhZaERpNmlX?=
 =?utf-8?B?MFhPWDRhYnJkV3EyWlVBVVMzRUY1WWFxejZHcGFhVCtVc0FtdWZnbkZOWjcr?=
 =?utf-8?B?VWdvQVVXdlAyWWNQRW51dlRVUHBtUFc3ZmtXOGl0WlJ2SGd4eGt2RTZHV2NU?=
 =?utf-8?B?MG5ZazVlYzNVS2hwZUhKbS9Qc0Jjb29ZKzk1aG5NS1g4b3BmK25HOG9EeTNO?=
 =?utf-8?B?b204M3VlS2R5SkNvV052R1F1a1ZoUjNPcU5rYkptOWxzUWdsZExvdUNNejVz?=
 =?utf-8?B?NEJOem9LdE00OW9OTzFYcE1OV20zQzc5S0k3TFg4bU4rZWtGdCtreTBDVGMz?=
 =?utf-8?B?Z0xFUndHMVBMVkRiWHk5aDh0dDNqbE9CSk9JMDlXbnB0cHVQWDJSVFNpRlcv?=
 =?utf-8?B?cWwvMVZVbW4ySEhXZDRWTlFhZCtUK2JHMUpKbU1ZcHhGMERqVVFlVW9QbXdZ?=
 =?utf-8?Q?Vwcw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85d26dd-d2b4-43bf-0339-08da84efacc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 10:10:15.6701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NP1L+macqXcp/HSJIEKE/MMPlj6eNapjpqWZ97iUc1wAs7/QYIv5rUeFgIufUSdm1NhNOdTh5YHEdv/YDqbTnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0034
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3ps
b3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDIzLCAyMDIyIDM6MzUg
UE0NCj4gVG86IERhdHRhLCBTaHViaHJhanlvdGkgPHNodWJocmFqeW90aS5kYXR0YUBhbWQuY29t
PjsgbGludXgtDQo+IHNlcmlhbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGdpdCAoQU1ELVhpbGlu
eCkgPGdpdEBhbWQuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IHJvYmgrZHRA
a2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZzsgc2h1YmhyYWp5b3RpLmRhdHRhQGdtYWlsLmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZHQtYmluZGluZ3M6IHNlcmlhbDogcGwwMTE6IEFkZCBh
IHJlZy1pby13aWR0aA0KPiBwYXJhbWV0ZXINCj4gDQo+IFtDQVVUSU9OOiBFeHRlcm5hbCBFbWFp
bF0NCj4gDQo+IE9uIDIyLzA4LzIwMjIgMTY6MDMsIFNodWJocmFqeW90aSBEYXR0YSB3cm90ZToN
Cj4gPiBGcm9tOiBTaHViaHJhanlvdGkgRGF0dGEgPHNodWJocmFqeW90aS5kYXR0YUB4aWxpbngu
Y29tPg0KPiA+DQo+ID4gU29tZSBvZiB0aGUgaW1wbGVtZW50YXRpb25zIHN1cHBvcnQgb25seSAz
Mi1iaXQgYWNjZXNzZXMuDQo+ID4gQWRkIGEgcGFyYW1ldGVyIHJlZy1pby13aWR0aCBmb3Igc3Vj
aCBwbGF0Zm9ybXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHViaHJhanlvdGkgRGF0dGEg
PHNodWJocmFqeW90aS5kYXR0YUB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+IHYzOg0KPiA+IHBh
dGNoIGFkZGl0aW9uDQo+ID4NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NlcmlhbC9wbDAxMS55YW1sIHwgNyArKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc2VyaWFsL3BsMDExLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc2VyaWFsL3BsMDExLnlhbWwNCj4gPiBpbmRleCBkOGFlZDg0YWJjZDMuLmM4
YTRjYmIxNzhmZSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc2VyaWFsL3BsMDExLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc2VyaWFsL3BsMDExLnlhbWwNCj4gPiBAQCAtOTQsNiArOTQsMTMgQEAgcHJv
cGVydGllczoNCj4gPiAgICByZXNldHM6DQo+ID4gICAgICBtYXhJdGVtczogMQ0KPiA+DQo+ID4g
KyAgcmVnLWlvLXdpZHRoOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gDQo+IE5vIG5lZWQg
Zm9yIHwNCldpbGwgZml4IA0KDQo+IA0KPiA+ICsgICAgICBUaGUgc2l6ZSAoaW4gYnl0ZXMpIG9m
IHRoZSBJTyBhY2Nlc3NlcyB0aGF0IHNob3VsZCBiZSBwZXJmb3JtZWQNCj4gPiArICAgICAgb24g
dGhlIGRldmljZS4NCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3VpbnQzMg0KPiANCj4gVGhpcyBpcyBhIHN0YW5kYXJkIHR5cGUsIHNvIG5vIG5lZWQgZm9y
ICRyZWYNCldpbGwgZG8uDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
