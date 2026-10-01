Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012062.outbound.protection.outlook.com [52.101.126.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F983769F0;
	Thu,  1 Oct 2026 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838239; cv=fail; b=hj4x8xYBqvxTLH49/Cbk3sZjPQ0gKOruoDEKSsvoVv708lGMNGfikDsVE6evD1lK9gdIMtiFDjULbwnbWc4rE81RHsaZz9uhqsgsW4xjF75/YjEHkt3hYq5aQ1CdFG5O2+ioFJCARMKqTLNjgtaMLJZSbQul2IbWtDZ1ehgEpXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838239; c=relaxed/simple;
	bh=5xOUlg2EMS4D7OGAo5aWyGPRULI6DYHh20Tx5AyRiUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQS5M2plYtx04V1kH2EHR/XghDT2ABdcDbpU0pR84Ry4h0kHEJYqnBtjH5A/jRiYwz3WOIl2F/h/0zxaKktWfEnC/k8pZtgGuOKWUPgylA3+R6sm4tRZh3rRV/tJrKOjbXjZJxJwNTdmbcnn6kd0V+z67mpmSjhJSJNR7cq++Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cortina-access.com; spf=pass smtp.mailfrom=cortina-access.com; dkim=pass (1024-bit key) header.d=CORTINA-ACCESS.COM header.i=@CORTINA-ACCESS.COM header.b=o3CeHsUB; arc=fail smtp.client-ip=52.101.126.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cortina-access.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cortina-access.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=CORTINA-ACCESS.COM header.i=@CORTINA-ACCESS.COM header.b="o3CeHsUB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWaCxLuD0TRMsTC+k2VvuVtBve4K2JrAB2I/sPO90uPBfLyBaww2V9YTqqEMcW2DmSHOq7jSIWZTWJk9tN+8n70CG/JFn1kFNjKTcAzl8R36vbP3marpKnJVk1BCacJlIfnDTB2AlMmjOu0qnkP5Uh7YWw9SGQhh8Ik3N42MnWUDdzKXQ6RGeFUELL/ewF/olaoM55fRLTo3CyOGkrNo+9Ksp0/9vC4d3SZCKDn//qx9HvFPZN6dvZVYx//sgk5CVthBWQr+MT13atu6S6NIFmaADP0CWBh34l7WTOSoBj1VftrUPRUmbnpUtQ1+/oONhjlv7WPHWiQ6oBz3V9v4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xOUlg2EMS4D7OGAo5aWyGPRULI6DYHh20Tx5AyRiUE=;
 b=ZwKJJJf06QMnFNqwy3o+6jUQR9m2koX3qNGVaWvCCnN+SizurNJB3ZKTTRHQvYP3g53XJ2xTWcWTK+v9iIuu1FexzTd28Ai9rtEnC2+AbyoslAWFSapQBxlrKjwscjcOAustoXUlCi20l3Yz0ekL3m6IjK+qMnJ8hoBchokf1lH6JJivSmOZWX8H/szDPStuOnPr/X/hFDJ0xwDpHnCOe83qtwrRVrk/uX2Y9rDjDv40j81CByYx/fDHuQqZpl0XUHJ82T4dFFIMokbZbN9FeOd6odixJh4bnSjQjnlH5MpE9HqwOwh9GwYArZE0qzdfQ9bg/Kfh0nvS6uqdfD27Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=CORTINA-ACCESS.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xOUlg2EMS4D7OGAo5aWyGPRULI6DYHh20Tx5AyRiUE=;
 b=o3CeHsUBsPEgHbQj9V3We8KRPzrwC5+PI+xN68gnljxnczVyDmKtN60sKRTZTEbEyrVWxT6lP68aagbqjVZrDzVLGcIPDT694kYjk0nbbnIHcmE0X4xeppm8xJ0nXFr8tl3uJb9m7yGkDgPwAgCGgUOqpIAS++o2dhbfGVkuglk=
Received: from SEZPR01MB4208.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4e::6) by SEZPR01MB7703.apcprd01.prod.exchangelabs.com
 (2603:1096:101:2a0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 07:03:53 +0000
Received: from SEZPR01MB4208.apcprd01.prod.exchangelabs.com
 ([fe80::7087:4bde:9129:725c]) by SEZPR01MB4208.apcprd01.prod.exchangelabs.com
 ([fe80::7087:4bde:9129:725c%4]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 07:03:53 +0000
From: Jason Li <jason.li@cortina-access.com>
To: Fil Dunsky <filipp.dunsky@gmail.com>, Arnd Bergmann <arnd@arndb.de>
CC: Linus Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: RE: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART
 driver
Thread-Topic: [PATCH RFC 07/10] tty: serial: Add Cortina Systems CS75xx UART
 driver
Thread-Index:
 AQHdUMwOK5V3y77FgkSOeOEe0ntIqrbm+wWAgAD5pVCAABL4gIAAHcEQgAAD44CAAA6bAIAAAueAgAAERZA=
Date: Thu, 1 Oct 2026 07:03:53 +0000
Message-ID:
 <SEZPR01MB4208C11DB288933965D7BF83A28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-7-4617c4463529@gmail.com>
 <CAD++jLkzcf7gJB82XT3-xb4jLujtWSNz1kT2r1-4N54rRfRNMA@mail.gmail.com>
 <1d81c2ef-7a5b-4306-83d2-ff96b0eb6a06@app.fastmail.com>
 <179076749140.3134070.3869742286743401078@gmail.com>
 <SEZPR01MB42087271C56AD1C7E926AF35A28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
 <179082517588.138645.14615134489246049313@gmail.com>
 <SEZPR01MB4208B8B4A5A7F48F7FFE0C9FA28A2@SEZPR01MB4208.apcprd01.prod.exchangelabs.com>
 <179083239972.193541.4791387611943615705@gmail.com>
 <3ddf4b8e-14b7-442b-9d4f-5167875e3d64@app.fastmail.com>
 <179083615914.311026.2458351803214458859@gmail.com>
In-Reply-To: <179083615914.311026.2458351803214458859@gmail.com>
Accept-Language: en-US, zh-TW, en-AS
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cortina-access.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR01MB4208:EE_|SEZPR01MB7703:EE_
x-ms-office365-filtering-correlation-id: 2d1a1b8c-91d3-4e7b-fa35-08df1f8a273a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 dwyztSrU/ub77czNAqAWzTfZBKVmVpI72A/agvQgsfqGwC9RL5x2T84a8AbKYet31ovPfJOMhe8VjLIOoVFyLHcyRaCz+7iPDwDQxu1I5fCy6j6aqhm1A2vaYRsTAxVMoTozbZ2fjKm+TJ6jhcF5Q/6EseeRqsYNsXHWcY9JB/XVBMxh/uMRXWZfWZ1gCB9JhIAc8BxnED7xX+WSlfgqqbA8sRnKPuqerSYltK77ZF0g+v6HBku/vb/bTa0rmPgJeRvfySw6L6HjKNygBYnC/JR/lMpUmdko/1cvBf88rpGUT3W5AxMTuwecO7b3DVG/8v6w3VJu8g2q3OWrR7gsWxVFMRmb32Rrb5KgHg35qtBaaEQ3cQb1eHkeVXz9KkP4DpEZxar4vw6RJ5Te7xWnVrtZcLUciSAe5RR25RqrqARcbu59/fmO1XhWRff3ZRIKMIeM/p8qMEUzXTqgFHQR1N+6ApdKuluYy4DvQX5NyiIEkl410K9C4KOgOqWONAaNzS5B0qdBTVbrpaoyUJsgRd6XJBVl1ilqd5Yb9OzMSyAlnyrMaJeWHJe5DjNVECRPU+ZWcxEDXJWoQnk2oBWsdMR+s41FrczdAgaitP6gWDqwWYxYYuzdDktFdHK+RBGapPVdmhZTetOLmn5/qWT7iMBq8jSoDgXHEOku/5mqTBA8Fbz/oWtiw3tFs+EgwqXSx8LH3VujUfmf87AmMPVUSva5mKUMdseZgB8yAdCaMJs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR01MB4208.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFVud3RzekdEanQ1NWw5M0lZTENuemRBYTZGamI0NENlcGk3dTlxQVUvOTJs?=
 =?utf-8?B?YXJxRkJQMVF6UG16UXYybi9YMVhEb3U0QVp4K3huRjlaZmlKT2xmam16RE9C?=
 =?utf-8?B?T1k0c3I1S3hteEZWWnZnancrbG8rc3lHakg1Mi9OZ2t5UHN1WHZoQ0lhQ1M4?=
 =?utf-8?B?RzRQQlV4dWJUclVyRXMwVEV2bVJCaUFBOWJ4bERkK0hrd3NFT3J0aTlBM0Yv?=
 =?utf-8?B?RjNVNThZRHRNZEx3ajkyRHVqdlJHYmlWYzJOaU9sRGVXTTFqb2lhcWlBZldC?=
 =?utf-8?B?azY4WkdLQkRuLzdIVzNBR1hFYkExNzRJT2JnUWlDTXhOTVZDMkUzVlkrbnhP?=
 =?utf-8?B?bUhUQlZaNDUydVMwOUdIRm5vTjFVNUdOKzI4N2poOWlNNjJUU2VNa3MwbXBh?=
 =?utf-8?B?YWdkRmtxTk9vUGs4L1ZBK09JdkFxN0FCTGd4WVlaRDlDSW4xVUc4ZDJMMmZG?=
 =?utf-8?B?YjBSZ2lSQzNHWUN2dHU4LzhDQWhWVlhxMWVIbG5TaTNvdk1KYkEzV2U3ODUx?=
 =?utf-8?B?K1FkWkZON2tlZ0tVUTJUeVUyOE1WNFh6QWZwZnVZdHJxWkJ3Q21lVGZTZU4x?=
 =?utf-8?B?L05LOUh1T0RLUlA3WHpFajRKK3dyTDdNZEZIQjhuYUpzVVQxZFZKS3NpNlF5?=
 =?utf-8?B?ZlloY2VBK1VMK2VYbmpJeUUyR2RoU1FSK0Z5YVhTNnJZdm5SY3hNZkVuS2ZQ?=
 =?utf-8?B?ZndJN2llTVd3MStLK0xMM1NLUGZqbFVEV0lNU00wazVUL0dFaGFKOHk2eHZt?=
 =?utf-8?B?eHV2Y252ZGVja2lKWVpxS1VxRWxuWEl1UmYxVzhJdlRMUkJ2NVVMQk5ESlNt?=
 =?utf-8?B?L0VkbnNYRHpXQ3hZNElJVFFHb0wyRXdzUFZiVmMrejNRSThaRnVSanUyUmNU?=
 =?utf-8?B?QUpubG1wWHV4L1lsdXJBSWpqV3VkejVvb0tFMzBpbm5uLzQyUE1kQitLNmVQ?=
 =?utf-8?B?QzlmWkFrT29IVXF4R0F4YU5QaHp1WlhHNEJWNHZoaHd4T1NoK1Bzc1Y4K2pi?=
 =?utf-8?B?UWRHSis0dHd0Sk53MlZCOUVPbld4TVBiOWgxL1lWU2oxTDRPcENHM2tXdHdN?=
 =?utf-8?B?Y2tTU0xzdGJYMjBRUVN6YTVBMSsveko0OXVxMzRyMlZSSmRuZHZ2OEhSQUZX?=
 =?utf-8?B?czk4eEtod1Y5S3daKzFGTTV3VTJNd0MyTVlheFJ5M0J2RGRmY3RBcXZKUFh3?=
 =?utf-8?B?VmRaYlBFN09oQlQ5dSt4Q1E0UE9lTGJ6bjB2dGZoakFVUEdaa0ZQeElBdlFQ?=
 =?utf-8?B?S2czZUJTNGZuSE9BeVdZemVoN1ppZU8yOS9CMnBpY0dsTy9DbVp6Y1ZLYVMx?=
 =?utf-8?B?ZE12a1RtRG1OSGQ1bEw3M0FTQXBLOVZncG9BY2xpUjI3TFRXNWY1VEhDSU00?=
 =?utf-8?B?azhBbksxVUtFdVJvdW1PTXBRUmYwc01jOU1CQ3FxS2pVMi9HT1NSN0xXSjRQ?=
 =?utf-8?B?WVlaTkFreWZkdlNPNUhMVTFBZEhOLzhqU0FTYmIxd0N4VURZVkxrV09Ub0hY?=
 =?utf-8?B?N2pjS1BocjcvTUZ4amRFUzdGMGxtUmorcDdyOHREdTl3WjVIRjJtT1NXR01Q?=
 =?utf-8?B?NmZEMnk0VGZPd1VOdlEyNlVWNFhSTXhCeG1jR05LYlZBMDZreERpdU5tbGlD?=
 =?utf-8?B?VStpM0E2NmRMdm5rMFJtUGYxbndpVE8vc3dGVkloM1AwUitVNlowWm9qMTdX?=
 =?utf-8?B?OEZLR3N2MWxjSktNM2N5TkFudnFPQlFPckk0Z2lUOC9UUDVFb2d0TW9rMmVz?=
 =?utf-8?B?aWpDSk9sNFQxb2p4TEx0b29XbktCNkQ5NXc4T1BNYXlkZXZNcnJtL0Y3ckdo?=
 =?utf-8?B?UzEraUpjTlVxbnRwUlJpRTF3TE9veERCdmdFc2xoay9DellxZXBNeTBMNGxW?=
 =?utf-8?B?MFNJYlU1akNtRXZ1MzhxRUw1Wk14RGRTS2hxRk5wVTY2YllhUHFidU5RdTBZ?=
 =?utf-8?B?MHpyVXQwa2xkbXJqMjhNdER1MStFRGExVGxybjJ1TE9TY1FhQkNxd1FSTEU5?=
 =?utf-8?B?ekJ5SE9BMlVPajQ3cC9TRHU0V3drZ1phTUdnbm4vN3QxejlBV29jY2lHNFhv?=
 =?utf-8?B?WjhRM2ZlREhsZnV3cGFxbUZzSHliU1RwenkxNEdoTTlYRkN0QlNrbXRBb2Zm?=
 =?utf-8?B?Ry9TNzBudldrOU12ZVE5dkt0NjFRMDJSY1ExdndUekZMNHNNbGtnbFpjSlNC?=
 =?utf-8?B?U3lxV01lU3VUQVNVVnh1dDBZdUl5cnJpOVJkNFNqQ3dkSnRsODNXbXl1em1m?=
 =?utf-8?B?c3VKVTRBY0YxYWtOQWMxendmOGYxUjdVNFQ1QisxZ05GdmVTRDdKRlIybDQ2?=
 =?utf-8?B?b2dOak1aN0pJdTUvYjBybHFEYkNoOUJ5OTNqSW80U1FqOU1UdW1sZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4208.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1a1b8c-91d3-4e7b-fa35-08df1f8a273a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 07:03:53.3116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVHVFjpTbJEKwt93ski4GDQyTd3EoZFcKZO1mCx/Sx6xFrvLXyV5YaJ+9lcmkSy4vw5CD5oDED9Mh3pkNzcnKaqsGgYfzkIHUD0KVs1h5AI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB7703

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGaWwgRHVuc2t5IDxmaWxpcHAu
ZHVuc2t5QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMSwgMjAyNiAyOjI5
IFBNDQo+IFRvOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiBDYzogSmFzb24gTGkg
PGphc29uLmxpQGNvcnRpbmEtYWNjZXNzLmNvbT47IExpbnVzIFdhbGxlaWogPGxpbnVzd0BrZXJu
ZWwub3JnPjsNCj4gS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPjsgUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz47DQo+IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRA
a2VybmVsLm9yZz47IENvbm9yIERvb2xleQ0KPiA8Y29ub3IrZHRAa2VybmVsLm9yZz47IEdyZWcg
S3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+Ow0KPiBKaXJpIFNsYWJ5
IDxqaXJpc2xhYnlAa2VybmVsLm9yZz47IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtbGludXgub3Jn
LnVrPjsNCj4gQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29t
PjsgRHJldyBGdXN0aW5pDQo+IDxmdXN0aW5pQGtlcm5lbC5vcmc+OyBMb3JlbnpvIFBpZXJhbGlz
aSA8bHBpZXJhbGlzaUBrZXJuZWwub3JnPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIFJGQyAwNy8xMF0gdHR5OiBzZXJpYWw6IEFkZCBDb3J0aW5hIFN5c3RlbXMgQ1M3
NXh4IFVBUlQNCj4gZHJpdmVyDQo+IA0KPiBFeHRlcm5hbCBtYWlsIDoNCj4gVGhpcyBlbWFpbCBv
cmlnaW5hdGVkIGZyb20gb3V0c2lkZSB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgcmVwbHksIGNs
aWNrIGxpbmtzLCBvcg0KPiBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRo
ZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMNCj4gc2FmZS4NCj4gDQo+IE9uIFRodSwg
T2N0IDAxLCAyMDI2IGF0IDA4OjE4OjU2QU0gKzAyMDAsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+
ID4gTm8gb2JqZWN0aW9ucyBmcm9tIG1lIGVpdGhlciB3YXksIGJ1dCBJIGRvbid0IHF1aXRlIHVu
ZGVyc3RhbmQgd2hhdA0KPiA+IHRoYXQgd2lsbCBtZWFuIGZvciB0aGUgb2xkZXIgcGFydHMgdGhh
dCB0aGF0IGFyZSBzdGlsbCBzb2xkIGJ5IENvcnRpbmENCj4gPiBBY2Nlc3M6IGNzODAzMiwgY3M4
MDIyIGFuZCBjczgxMjQuIElmIHNvbWVvbmUgbGF0ZXIgYWRkcyBEVCBzdXBwb3J0DQo+ID4gZm9y
IHRob3NlLCB3b3VsZCB3ZSB1c2UgJ2NvcnRpbmEsY3M4MDMyJyBvciAnY29ydGluYS1hY2Nlc3Ms
Y3M4MDMyJz8NCj4gDQo+IEkgd291bGQgZ28gYnkgdGhlIHBhcnQgbnVtYmVyLCB0aGUgd2F5IGZz
bC9ueHAgaXMgaGFuZGxlZDogdGhlIHBhcnRzIHRoYXQgY2FtZQ0KPiBvdXQgb2YgQ29ydGluYSBT
eXN0ZW1zIHdpdGggYSBDU3h4eHggbnVtYmVyIGtlZXAgImNvcnRpbmEiLCBzbw0KPiAiY29ydGlu
YSxjczgwMzIiLCBhbmQgdGhlIENBeHh4eCBwYXJ0cyB0aGF0IENvcnRpbmEgQWNjZXNzIGRlc2ln
bmVkIHVzZQ0KPiAiY29ydGluYS1hY2Nlc3MiLiBUaGF0IGdpdmVzIGEgcnVsZSBhIGxhdGVyIHN1
Ym1pdHRlciBjYW4gYXBwbHkgd2l0aG91dCBrbm93aW5nDQo+IHdobyBzZWxscyB0aGUgY2hpcCB0
b2RheS4NCj4gDQo+IEphc29uLCBpZiBDb3J0aW5hIEFjY2VzcyB3b3VsZCByYXRoZXIgc2VlIGl0
cyBjdXJyZW50IENTODB4eC9DUzgxeHggcGFydHMNCj4gdW5kZXIgImNvcnRpbmEtYWNjZXNzIiwg
bm93IHdvdWxkIGJlIHRoZSB0aW1lIHRvIHNheSBzbzsgSSBoYXZlIG5vIHN0YWtlIGluDQo+IHRo
b3NlIGFuZCBvbmx5IG5lZWQgYSBydWxlIGZvciB0aGUgQ1M3NXh4Lg0KPiANCj4gVGhhbmtzLA0K
PiBGaWwNCg0KSGkgRmlsL0FybmQsDQpDb3J0aW5hLUFjY2VzcyBDb3J0aW5hLUFjY2Vzc+KAmXMg
cHJpbWFyeSBwcm9kdWN0IG9mZmVyaW5ncyBhcmUgUE9OIGFuZCBMMyBnYXRld2F5IHNvbHV0aW9u
cy4NCkF0IHRoYXQgdGltZSwgQ29ydGluYSBTeXN0ZW1z4oCZIHByaW1hcnkgcHJvZHVjdHMgZm9j
dXNlZCBvbiBoaWdoLXNwZWVkIFNFUkRFUy9QSFkuDQpBbmQgd2UgYXJlIG5vIGxvbmdlciBpbnZv
bHZlZCBpbiB0aGUgc3VwcG9ydCBvZiBhbnkgQ1N4eHh4LXJlbGF0ZWQgcHJvZHVjdHMuDQpJJ2xs
IHJlY29tbWVuZCAiY29ydGluYS1hY2Nlc3MsY2F4eHh4IiBmb3IgYWxsIENvcnRpbmEtYWNjZXNz
J3MgcHJvZHVjdC4NCg0KVGhhbmtzLA0KSmFzb24NCg0K
