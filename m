Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6315786D
	for <linux-serial@vger.kernel.org>; Tue, 20 Feb 2024 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409266; cv=fail; b=kBiTkEzp7Z09d7bb3UhyJrgo8tagtF6K1Hvi+lL/W980lf29OzZDLJ07iiCEbIsNYY3o+WomlD26R+R48E2eaxOs1dZESxIzOsWxXehLSC9bjFItUgwHNwm2KmEsr6CuweXNkgyvs+eGyZnqGtxaogVNgisf/QibAZaAku8SI1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409266; c=relaxed/simple;
	bh=CVcRbIiYOxEjYzEjNFPrcR75pTDnD0kynuk/fqxAb84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iK3fYnDDC3PTknoqUvezCI3LzXTcM042z+gHmc76ThYoQxaC2DPcJATIHnByqXDgpCBMWTt6K/baXWOPJO5vp2FuoEcmQ3BoqaC4VwFStscVFli9C3dpHkw0BGPHOv7Yw92p8bJQH/kcWWTHNFJNa9Y8f3isWE4+kv2NMSFWCrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=a8X7NXhO; arc=fail smtp.client-ip=40.107.8.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="a8X7NXhO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciSxJOxeOPYBs8EX1gds1tdAjezXuOOceX49FPxuQX39GwSfLnyPKXrdW7tYS23gDdvo4XdZGOaxax+ItbtvH4x25BpDuu6nrAiG9L+P+Yuaprn4uAZTefNxYRCnJO7fdU2jX9guTAEhnXtpgfFCK5ltI6PIHlioaTC/+hRaHoR7nd452Ukq6cty1XQPsjPqv27m/e4enCYNipTPVCyyA6ejB2bmmoRb3jLk+VgbKjptLSVPrj3kfoOmZFsn76UzEi/hKBlbcBwMtA3wv1WcVjfj1dHPoWn8jmn1uJPvoyylmFhTKW3OfVsOgrYntGYvTMqHSZa5WDlQplARJmf7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVcRbIiYOxEjYzEjNFPrcR75pTDnD0kynuk/fqxAb84=;
 b=DVhO1dnTfPH/rAFDHYU5tICvYkChMAN1iplbppJrpBawAzz3ZVyk5uCW5BbfSPr1RvXiiZu14UoVGc/JhZEUMG4H0mqTBiqJrQbwARjRNSrpMdYHMtubyWmeux4HlaFHGG3mju1dcC2Qn4XeTA0QkzzItA2HJ8/0aPaGQxIEMfT1oU+5sTpyyTEF/cE+6tG6qGhU4XHpUW0rhBBq1equPnZPcUEctgE5EIxKm6oYVdAnM97/FvlZJH2co53Haon6uG/5PJI2bGI46KZHlrnesG+qR05u9BLk6+qVPPcI6y3oMFRUMoFkyzrJK/6fK2zlKwDyieQDYf0BEVjmni0poQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVcRbIiYOxEjYzEjNFPrcR75pTDnD0kynuk/fqxAb84=;
 b=a8X7NXhOPepsn0zZx87KS3eQJ5NxNP/VKsdQbXfUF6jTAVXbXjveoHRxEp93s8aatJ6Gv4D/bcAzQzq6nJ4rcO3DAD847FczR/KEv0z9VD+b0hAG4c69o79OXOVy1iDK6L70Li4umE1SsEfx51geoxbkTiji1q2w6ou7DFJJ4kY=
Received: from AS8PR02MB9505.eurprd02.prod.outlook.com (2603:10a6:20b:5a4::17)
 by PA6PR02MB10850.eurprd02.prod.outlook.com (2603:10a6:102:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 06:07:40 +0000
Received: from AS8PR02MB9505.eurprd02.prod.outlook.com
 ([fe80::206b:6313:195:cea5]) by AS8PR02MB9505.eurprd02.prod.outlook.com
 ([fe80::206b:6313:195:cea5%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 06:07:35 +0000
From: Rickard X Andersson <Rickard.Andersson@axis.com>
To: Marek Vasut <marex@denx.de>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "rickard314.andersson@gmail.com"
	<rickard314.andersson@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-imx@nxp.com" <linux-imx@nxp.com>, "martin.fuzzey@flowbird.group"
	<martin.fuzzey@flowbird.group>, Christoph Niedermaier
	<cniedermaier@dh-electronics.com>
CC: kernel <kernel@axis.com>
Subject: Re: [PATCH] tty: serial: imx: Fix broken RS485
Thread-Topic: [PATCH] tty: serial: imx: Fix broken RS485
Thread-Index: AQHaYNYuUklxWqRruUu9inbC0l9gq7ENFMWAgAWuUCo=
Date: Tue, 20 Feb 2024 06:07:35 +0000
Message-ID:
 <AS8PR02MB950598080305172CFBE4B0D381502@AS8PR02MB9505.eurprd02.prod.outlook.com>
References: <20240216124601.3752039-1-rickaran@axis.com>
 <e39a6ecd-1250-4889-99aa-31a5a219f6a5@denx.de>
In-Reply-To: <e39a6ecd-1250-4889-99aa-31a5a219f6a5@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB9505:EE_|PA6PR02MB10850:EE_
x-ms-office365-filtering-correlation-id: 30cf3fd2-08b0-4083-975c-08dc31da3b8f
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1PKGljxDDLOKPZKpN0uo0asyr43nsNUGOUdE9aoHP9CnN3JYF0HkcMM21g9XjQK+JAeaVofMEnUKklSglNG7kCnqYkUIK85oUzp6A2pmyKdLPtidE5ui1ZUQEs88lEy7zN3thNmxcH5g7B1T5kK5GEshZb/dFgkZwjT1k4pD6UPAsRqHj07QACR0FDHg5GNrWyP3z3K8eh44Js/QZu0YCm5SINl6V3dGY7EaXTajDbocS0QR6HdeDTsPZU/nZbHpnzNMRTOWPvwH9rYMXFl7ltRSf2uAf5SGgh/GY2fwox2V3jSwFaKjdVUvZPqplFhIMGRDqzu952YCsJTNZ3+QKH5a7zns/wd+DpdHgnwPa/zJb25ebqhTqOP9WdXDUc9IDuIRHcUSpHrIVaBCK/tqRIODWXQL1pQ/TMPXma6wOhF4PnpB4H+KLviuw0z56kcQdK05bC4Kf84DpI9FsjNqaRI5E/84H/odXBb75VIw5L2soaDyt5h0PRnEhSHAYvrtkiA7kQI3+VESiUsCUbjqN5zfdS1roDt5FSTmz+3fjlOQvsXIERAoI0GZpOv7eJGI/mkKcbq4+Dpcg9SQKlIr4OxuacJecub0vvr20VGnPKuDRDrsWyHO4sclAe4CS+kpeTXkJkF6SN0VJAN025oquQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9505.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFJzVFRQRHhpc1daWFFZdVRuK3h1TFRoN29wNkVITUI4R0VqcnF2azdIVlZq?=
 =?utf-8?B?SmRoQmpkWCtjVUZMS0puenRDRjVtWFNORDNORFZSUlF2SDVLY08yNkxndWQ4?=
 =?utf-8?B?ZnhZakI3aGY3WTU1aHR3UXl3RUNoYXU2YmJwRnEwYSs0WEo0bVJMaUEyaXR6?=
 =?utf-8?B?R0k5YUtNOE5GQjYzckh5enQxcVVqelFOZFpDZkQ0Mjc4S0FwRllSTVNzWCtk?=
 =?utf-8?B?a3ZlVzhqUFIvZml4UWFLT2FxaEpMM0kwTi9JRjJFcHIvTlNSV2ZrQTZHdWxj?=
 =?utf-8?B?QXd4MWVLTUdMSi9mOFhxTjVtQnU5aUZ3Q094YTRkN1hJcjNXZEF4T3dMdGdh?=
 =?utf-8?B?K3VHazFjbHlubUsvcWFBZmsxUE1ZSGJ5NDZ1NmVEc1lpbnlWYWZoRVBpUHkw?=
 =?utf-8?B?eEN3UnpsUGsrTU1uOUhnMGdEQTFtUGJpU1lSWHQ2RjJGTTFsNWJvanRvdW5K?=
 =?utf-8?B?WDB6V2lTandnQ0lWVTN0MERseTRNek8vTGtjYkdkekpITUlGWjN4WWQrVitT?=
 =?utf-8?B?c05KMDFnVDkwcFdsQUJzUHQ0b3lKOVN4TVozVFlNTVJXdDY3ZjFDWXFhMWxl?=
 =?utf-8?B?eG1rZFk4TVF1emxyc3JuZFJkK09FZ3FCdU04VnYyWHdZbzErOGIwdjlGNS9F?=
 =?utf-8?B?RnhvcUxXWHVFcld5OXhpR09XZ0l6WUhZOFlkSTcyTlVqSVNnN0JqSytNMmE0?=
 =?utf-8?B?amJMeENvUGpHTUlmVkhnbGFPamxDKzRJeVpWN1QwK1ZjK2JRZVUxSExvK25N?=
 =?utf-8?B?Uk1GV04zZ1UzMzZBcE45UXdnTThvSzQvTU1pdG9wSkFHcm16UnJJazhPbmF0?=
 =?utf-8?B?cHJqRUpCR0ZPcXRmYVZReGV0eDlIVTBSbWxHZkxjb2ZZUGRrc3pnMytFMmMz?=
 =?utf-8?B?R0Y4alpuMGZGaTRZTVprM0ZjRTY3SWxvMkRrZDFrNjNmRFZRcWIvYTBDMENF?=
 =?utf-8?B?VXQ1VGZHQUVsYm4rYUp5dVE0ejdGcTc4Nk9uUnZVU3ZhcVBVTGdPdVprdjRY?=
 =?utf-8?B?dm9VUkV2TEE2eWJpcElmMi9HSFlkWmdOalB6d2p4OXFFTjBhaHVwU3F0d0ZM?=
 =?utf-8?B?MXZzK2tvb3NDaEdTVG16NjV0aVo0MGFBcDVaWnNLWmFVOXdpZFR3alB3ckJs?=
 =?utf-8?B?aS9WaGhneHgvektqTi80WFNJSGhlOVY3YmcwejN0R3VqZWxYb1BUSkhXcUl4?=
 =?utf-8?B?WjFoNjJnaVR5SUdaM1p2ZTZTMHhsQmJNUGhvcjhuL2tJcHB1KzFGdEpYOTRH?=
 =?utf-8?B?NlpmTmE4azFlaWlMdForN0UwdE5qRDU3NHlBWUQzODhsenpOT0h4L3dOT0kz?=
 =?utf-8?B?ODExdXhJT0dFeUlwZ0NJYWwya1NaZ3FXY2d4OWdPTEN4NGJ6UUdyKzlmWHdu?=
 =?utf-8?B?R3hFMnZoem8wVUhHZHUxd3lLeko2K0ppOFZaWHFNb1FXakFSSjJtVVNWNjRJ?=
 =?utf-8?B?RSsybUxZSHhoMENuUGg5WkJWelh0Qmh6c2psRmgwRTdsSkNrUG9TOFZNWGVI?=
 =?utf-8?B?QXZhMkpWTEZnMGQrT1I4NWVqVEo3UHMxRit4WnZRSTBnTjV6UzUxY2ZjTUts?=
 =?utf-8?B?ODFQUGZCQ1Y1NHpyTkNTVTBNdVZweTFKcGpsaWNiYWx2VEd3bnYxUXFIQ0J1?=
 =?utf-8?B?UVN2NmI1cGxOV1VoQTBpRDV0MkJSdHNscStCdGY0WWppc2x0NHBkNnZlNlBY?=
 =?utf-8?B?U29qQkxIQUF1cks2VXd0ZGs4ZmpMM2ZMYWlXbXVDalN6K2Y0di93KzVBdE5O?=
 =?utf-8?B?Q3l6MjhZb1R4dGhoZ2cvbVQ5R2ZjQzQwaDljbDRxTURNZmlIdkl1Z2hYbHhj?=
 =?utf-8?B?dG8zdWYxNVFvUXRNSU1ubDFpMlNsTUp2ME9paUFsUmltUzFSRlQyUnFSYnRT?=
 =?utf-8?B?aktWYitoRlJKSm54T1k0Q2ZZZG5BS3NUaWdJZmFuNHZJMDlqV3pQKzRyM0tu?=
 =?utf-8?B?VGhuRURjdURhWUFONTlRRUltck9pZWY4UWh5ajJjYnlqZWdTanozdUZiVG42?=
 =?utf-8?B?SE9UUTFWS3cxdFVteGxYQUptbkpPZFBVd3BIK0hzSUlpRmNqNUFKSWZjSmF0?=
 =?utf-8?B?RW1IMm1jUk5HS3RhRU9vOENVaTQ5TUJtZ2JmNC9MaE8xOTZTRnRweGNkclUw?=
 =?utf-8?Q?vbN4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9505.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cf3fd2-08b0-4083-975c-08dc31da3b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 06:07:35.1248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PB5j4Fa3J07HkDbYb9l8fsrzmxAya05ojoWJryo+BqWzm42eIYl/8pXzXZKzEx3697wT+ZTZLAsMAxYAgTFADw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10850

T24gRnJpLCBGZWIgMTYsIDIwMjQgYXQgNDoxN+KAr1BNIE1hcmVrIFZhc3V0IDxtYXJleEBkZW54
LmRlPiB3cm90ZToNCj4NCj4gT24gMi8xNi8yNCAxMzo0NiwgUmlja2FyZCBBbmRlcnNzb24gd3Jv
dGU6DQo+ID4gRnJvbTogUmlja2FyZCB4IEFuZGVyc3NvbiA8cmlja2FyYW5AYXhpcy5jb20+DQo+
ID4NCj4gPiBXaGVuIGFib3V0IHRvIHRyYW5zbWl0IHRoZSBmdW5jdGlvbiBpbXhfdWFydF9zdGFy
dF90eCBpcyBjYWxsZWQgYW5kIGluDQo+ID4gc29tZSBSUzQ4NSBjb25maWd1cmF0aW9ucyB0aGlz
IGZ1bmN0aW9uIHdpbGwgY2FsbCBpbXhfdWFydF9zdG9wX3J4LiBUaGUNCj4gPiBwcm9ibGVtIGlz
IHRoYXQgaW14X3VhcnRfc3RvcF9yeCB3aWxsIGVuYWJsZSBsb29wYmFjayBhbmQgd2hlbiBsb29w
YmFjaw0KPiA+IGlzIGVuYWJsZWQgdHJhbnNtaXR0ZWQgZGF0YSB3aWxsIGp1c3QgYmUgbG9vcGVk
IHRvIFJYLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgYWJvdmUgcHJvYmxlbSBieSBl
eHBsaWNpdGx5IGRpc2FibGluZyBsb29wYmFjayBpbg0KPiA+IHRoZSBjYXNlIGRlc2NyaWJlZCBh
Ym92ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2thcmQgeCBBbmRlcnNzb24gPHJpY2th
cmFuQGF4aXMuY29tPg0KPg0KPiBGaXhlczogdGFnIGlzIG1pc3NpbmcuDQoNCk9rLCBJIHdpbGwg
YWRkLg0KPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIHwgOSArKysr
KysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2
ZXJzL3R0eS9zZXJpYWwvaW14LmMNCj4gPiBpbmRleCA0YWE3MmQ1YWVhZmIuLjg5OWUzMzFiZGZj
OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCj4gPiArKysgYi9k
cml2ZXJzL3R0eS9zZXJpYWwvaW14LmMNCj4gPiBAQCAtNjgzLDggKzY4MywxNSBAQCBzdGF0aWMg
dm9pZCBpbXhfdWFydF9zdGFydF90eChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICBpbXhfdWFydF93cml0ZWwoc3BvcnQsIHVjcjIsIFVDUjIpOw0KPiA+
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGlmICghKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VS
X1JTNDg1X1JYX0RVUklOR19UWCkgJiYNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICFw
b3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbykNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICFwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3Bpbykgew0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlteF91YXJ0X3N0b3BfcngocG9ydCk7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KiBUaGUgZnVuY3Rpb24gaW14X3VhcnRfc3RvcF9yeCByaWdodCBhYm92ZQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqIHdpbGwgZW5hYmxlIGxvb3BiYWNrLCBidXQgc2luY2Ug
d2UgYXJlIGp1c3QNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBhYm91dCB0
byB0cmFuc21pdCB0aGVuIGRpc2FibGUgbG9vcGJhY2suDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW14X3Vh
cnRfZGlzYWJsZV9sb29wYmFja19yczQ4NShzcG9ydCk7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIH0NCj4NCj4gTWF5YmUgaXQgd291bGQgYmUgYmV0dGVyIHRvIHVwZGF0ZSB0aGUgc3RvcF9y
eCBhbmQgYWRkIHBhcmFtZXRlciwNCj4gd2hldGhlciBpdCBzaG91bGQvc2hvdWxkbid0IGVuYWJs
ZSB0aGUgbG9vcGJhY2sgPw0KDQpTaW5jZSAqc3RvcF9yeCBpcyBwYXJ0IG9mIHN0cnVjdCB1YXJ0
X29wcyBJIGNhbiBub3QgYWRkIGFuIGlucHV0IGFyZ3VtZW50IHRvIHRoZSBmdW5jdGlvbi4NCg0K
QmVzdCByZWdhcmRzLA0KUmlja2FyZA0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCkZyb206IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KU2VudDogRnJp
ZGF5LCBGZWJydWFyeSAxNiwgMjAyNCA0OjE3IFBNDQpUbzogUmlja2FyZCBYIEFuZGVyc3Nvbjsg
bGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgcmlja2FyZDMxNC5hbmRlcnNzb25AZ21haWwu
Y29tOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFp
bC5jb207IGxpbnV4LWlteEBueHAuY29tOyBtYXJ0aW4uZnV6emV5QGZsb3diaXJkLmdyb3VwOyBD
aHJpc3RvcGggTmllZGVybWFpZXINCkNjOiBrZXJuZWwNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHR0
eTogc2VyaWFsOiBpbXg6IEZpeCBicm9rZW4gUlM0ODUNCg0KT24gMi8xNi8yNCAxMzo0NiwgUmlj
a2FyZCBBbmRlcnNzb24gd3JvdGU6DQo+IEZyb206IFJpY2thcmQgeCBBbmRlcnNzb24gPHJpY2th
cmFuQGF4aXMuY29tPg0KPg0KPiBXaGVuIGFib3V0IHRvIHRyYW5zbWl0IHRoZSBmdW5jdGlvbiBp
bXhfdWFydF9zdGFydF90eCBpcyBjYWxsZWQgYW5kIGluDQo+IHNvbWUgUlM0ODUgY29uZmlndXJh
dGlvbnMgdGhpcyBmdW5jdGlvbiB3aWxsIGNhbGwgaW14X3VhcnRfc3RvcF9yeC4gVGhlDQo+IHBy
b2JsZW0gaXMgdGhhdCBpbXhfdWFydF9zdG9wX3J4IHdpbGwgZW5hYmxlIGxvb3BiYWNrIGFuZCB3
aGVuIGxvb3BiYWNrDQo+IGlzIGVuYWJsZWQgdHJhbnNtaXR0ZWQgZGF0YSB3aWxsIGp1c3QgYmUg
bG9vcGVkIHRvIFJYLg0KPg0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBhYm92ZSBwcm9ibGVtIGJ5
IGV4cGxpY2l0bHkgZGlzYWJsaW5nIGxvb3BiYWNrIGluDQo+IHRoZSBjYXNlIGRlc2NyaWJlZCBh
Ym92ZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogUmlja2FyZCB4IEFuZGVyc3NvbiA8cmlja2FyYW5A
YXhpcy5jb20+DQoNCkZpeGVzOiB0YWcgaXMgbWlzc2luZy4NCg0KPiAtLS0NCj4gICBkcml2ZXJz
L3R0eS9zZXJpYWwvaW14LmMgfCA5ICsrKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5
L3NlcmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYw0KPiBpbmRleCA0YWE3MmQ1
YWVhZmIuLjg5OWUzMzFiZGZjOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2lt
eC5jDQo+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYw0KPiBAQCAtNjgzLDggKzY4Mywx
NSBAQCBzdGF0aWMgdm9pZCBpbXhfdWFydF9zdGFydF90eChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0
KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgaW14X3VhcnRfd3JpdGVsKHNwb3J0LCB1Y3IyLCBV
Q1IyKTsNCj4NCj4gICAgICAgICAgICAgICAgICAgICAgIGlmICghKHBvcnQtPnJzNDg1LmZsYWdz
ICYgU0VSX1JTNDg1X1JYX0RVUklOR19UWCkgJiYNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAhcG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8pDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgIXBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvKSB7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlteF91YXJ0X3N0b3BfcngocG9ydCk7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC8qDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIFRo
ZSBmdW5jdGlvbiBpbXhfdWFydF9zdG9wX3J4IHJpZ2h0IGFib3ZlDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAqIHdpbGwgZW5hYmxlIGxvb3BiYWNrLCBidXQgc2luY2Ugd2UgYXJl
IGp1c3QNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogYWJvdXQgdG8gdHJhbnNt
aXQgdGhlbiBkaXNhYmxlIGxvb3BiYWNrLg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW14X3VhcnRfZGlzYWJsZV9s
b29wYmFja19yczQ4NShzcG9ydCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICB9DQoNCk1heWJl
IGl0IHdvdWxkIGJlIGJldHRlciB0byB1cGRhdGUgdGhlIHN0b3BfcnggYW5kIGFkZCBwYXJhbWV0
ZXIsDQp3aGV0aGVyIGl0IHNob3VsZC9zaG91bGRuJ3QgZW5hYmxlIHRoZSBsb29wYmFjayA/DQo=
