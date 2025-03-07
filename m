Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011031.outbound.protection.outlook.com [52.101.65.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498F1AD41F;
	Fri,  7 Mar 2025 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334537; cv=fail; b=LGxHkrbDl6uR7FtrPnr6X5Tww6NC9Njw9ORYNGnQ/ZP1Bta8+vZl76amPv7NjhCar27dddH0ujSt2WttFNq6uCpR0oE29SiYxfjkGPZHBJChRQkGA8EmdPsEENp7dH8w56PlrTZQSughhfeFYU/CIs+TgDyQ8fp8GEeMpH83myg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334537; c=relaxed/simple;
	bh=da9EoLuXUffp3IieH3vw9mDmCmZWuY05/WCeJEH2AMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iGIvzJJQzibKz2B7XtJgOVS1Ldu5oCbKs+z+16nLwH4C7u8bOge/+GcutyA94OOZ8iAOVxR/tuh+1RvqohmCTcxPKLOj2bLKNFQ9oM9FldxPAllRCfW2PmXwe4i3PEDlB2ZoF0UhaQz91W6irZYh7QiKtDuPaR8An4f6iKCmgPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lLb8gtNz; arc=fail smtp.client-ip=52.101.65.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lLb8gtNz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FotY7rgKfA2/m+vBcTqUbYKjgIdjrl7xuraRRIDAWeXEHvMDM72wO8ueYQWKQbMiWnWub8/zffeRbWCf4R9oHbcMmlzIKyrVWJPy0M7+vJIEWyA5QBd4TopmNBHdNFfruBTnGrwMG7t6d1VHeLuNLcel8hHr6yo17NRgU62tUEY8w8fA0jT9F4vmqNtM4tldEHnu3CP3HEdHAUVf6dgvdijv61/grcGeoY7i5rcNCmcCwC8aM51U5QuYwTZYgX2vlIhA5iLRnV1jNWM0KEP4lMXdBrsOeUSVSyaYEhbBGPU+PONjG6ZG7GnNSojfrHkRhy0cxueGoKeOLu8pdgIYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da9EoLuXUffp3IieH3vw9mDmCmZWuY05/WCeJEH2AMs=;
 b=wZESsn4mPP4VHN0IoeqI4WaImNzDKoNJZK82OfbRpm5kIMJVOiZ+myLXG3hUTZW8NW0YAhtf3TbGsPFy7KYHNVQaaYTy3UjnAFAKBKI5+PkE5cNGQul8IDmqi8izOmmGlMIqUppjVQDWUKLG+Tc00wKzF/ygg5FKAOvjvLErNT/FDNpgRxEvUL2ioYyvCvxaE7frPB1e+1czK+vUv2RUY3mPhp2Z3cxUzh6G8AUNY30XQCW+TbaCDCrNYvgvIC/cwy+A9T2eh021Og4vObVVR9TtRmVdt+udjvm1gA8x6Bpdyll47aKFN5+YpGi2ORJNosohij9ml1rOGa4aPEnY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=da9EoLuXUffp3IieH3vw9mDmCmZWuY05/WCeJEH2AMs=;
 b=lLb8gtNzjryaOiHTNXMehpBcOy9j/QoRxNTKlzGHb5XFb9lmFZJnOW21KF5zwQHfWEeSANFEXY6w/FgZlni08kwcfi6NiQjYqhzbPFehQhkPMaDoyBkk0IvwdWb2zouQeN675UR61mhaUqtWNPP5nxi/SW2lRyI4AEFvlYJUJdmyTj0fyjwa4z14mipxHB93tvZUoSGuG+ujJ+2vxdj0XgeAOScmnhm6T+eu38Cjj7dIH4ERK+i93wuXG1Ky9mauHuXYRhorDGtOZDQNB0UM84lcKyYIzD6MS8LPUxdn80A6zRZZ9VkqFipVPsqzhK24jlsMozhTO4tyCgJipEhuWA==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by GV1PR04MB10426.eurprd04.prod.outlook.com (2603:10a6:150:1cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 08:02:11 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 08:02:10 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Jiri Slaby <jirislaby@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Shenwei Wang
	<shenwei.wang@nxp.com>
Subject: RE: [PATCH 1/2] tty: serial: fsl_lpuart: Use u32 for register
 variables
Thread-Topic: [PATCH 1/2] tty: serial: fsl_lpuart: Use u32 for register
 variables
Thread-Index: AQHbjwhYZMNdadGWYUeayBBl7Ss2LbNnRiaAgAAJuEA=
Date: Fri, 7 Mar 2025 08:02:10 +0000
Message-ID:
 <DB9PR04MB8429BF55DF50CCF7E9AB827292D52@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250307022547.1000293-1-sherry.sun@nxp.com>
 <20250307022547.1000293-2-sherry.sun@nxp.com>
 <52c99f0a-670c-4e76-a30d-cdb9cb0e83e7@kernel.org>
In-Reply-To: <52c99f0a-670c-4e76-a30d-cdb9cb0e83e7@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|GV1PR04MB10426:EE_
x-ms-office365-filtering-correlation-id: 25021424-a247-4d3e-432e-08dd5d4e5d30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TTJlMUJmckxPWTRkYmxvUkNSb3FyZEFLMFZUbFpOZXp4WFFmbTIxOXlwRHEy?=
 =?utf-8?B?dUJoQkhWZ3R0aFpKK3A3Y0drakVoSlZsZUhmK0tnd2FiRWJpdG0zQXhaWEhT?=
 =?utf-8?B?WjE4bGlNYm14MDVLM3RWL09DVXR4ejk3T0NybEJKNWZjTWs3MDAyTDkzbXRn?=
 =?utf-8?B?eHVWZUJJa1dQalkyQWpyNE9XSTk1NmxoZ2o4bmF0dmdZV0Jzcld5d2Jzc0Jt?=
 =?utf-8?B?WWxEdUNXNGIvaFViM0NGbmtmVE1oeEtPcDNPOWRpWmNqM0xEYWpVRVJxNUs2?=
 =?utf-8?B?RDBqc3J2T05Ba3kzeDREamE2RkVkZU9ZOTF4MktVekROOTAvOVo0WWI2NW9S?=
 =?utf-8?B?Ui9aOURFdDVKU1ZzTjRtdnFmSVIxSVRhZXhmdmxBcjNNd2laM1J0ZS9zcVlt?=
 =?utf-8?B?aHVWTlAreGhIR0R0b0x4Z0pXR3hBVXhpeWYyQnRwZFZPWmZsL0Y2TnlKbWZz?=
 =?utf-8?B?eFRNOTdoTXFVNmdUTXMxUTV6WmNpUnRteFNWWmFvei9LR1ltenRDbnhhY1dM?=
 =?utf-8?B?WVBFbzUrcDEwVk44V2Y2dTF1L3hESmZocEJtYXJ1ZmNiN0t3bWUrRGN5eEkz?=
 =?utf-8?B?NHQ2bmFLajZUUWtXdGFaem9DM0N3M2I2VGQ5S1ZyL1U0eEJyWVFiV2hHOXh6?=
 =?utf-8?B?Y1BXdE1abmJHUFRJeEdUZW45cFlqMW5MN0RPZWMrTENSaVBRQmF4bUVmc0Qx?=
 =?utf-8?B?ZThSdkYvbmtYNHJvWHA0U2hyOXM1Yk04dCtMaUZFNTJZUVI5aWJGSUw4enFn?=
 =?utf-8?B?aVRQTEZVNEhhcUFiZXUrSlZjMFVwMEFTb3JNcWtCeDZ6UG55dVVGZHZwZXVw?=
 =?utf-8?B?NXc1YVZiQU1Gb0xYMkVjb29GV0JxdEIvYnl0dnlYUVNseW5uTTZVVTh0M28v?=
 =?utf-8?B?OFVJQlNZL2NNalNkTUNhc1BFN2IwN3RmenFsRWU1Mkl4aFZQUnFuODRKbjg2?=
 =?utf-8?B?a0E1MERXRHlmM0swSWFuMzdPbE45MHU1M3NGaGgrZWtwdCt0NjFJM0RrVkxp?=
 =?utf-8?B?THB5UUNMMzBFSFZyalRrWTJsaTZmcEJacFNNN1lpTGJuZXdrZldoRjNIRVdz?=
 =?utf-8?B?SC9rNWNQd00zZlUrQnJENXdBRkxzMGlGNW40T3hsRDNPNkViNHZjLytCT2Vw?=
 =?utf-8?B?azZwa29tZGVGazZSV3N1WGZhc2FKdlQxNzhxS094WE1VQWhkSElNLzNRU3Y5?=
 =?utf-8?B?WlRXUVJsSU9qU2hTaVllZDhuajhXc2V1N1VvNmdJZmh3bmZCTU1KSVZKZFZT?=
 =?utf-8?B?ck1VeGc0czFRUkJVVDNqOHFGOGdZNHg0bjUzaHE3aWJIUmNSdGFkRGxPbUZP?=
 =?utf-8?B?OTRuajF5ZFpWeDVzbGRHV1Q0dUY4MHc4ekpsUmVyRmNZY3hCNWtXaE0wcmFY?=
 =?utf-8?B?UllPY3NqbEVLcjg2UXdMMVVLSXlmbFBVYnlEYVFtdnhmNDhWSjJuejh5REtR?=
 =?utf-8?B?RTZGWE4xSDc3RHUzNFA5YzJxZ25ValZYVFpUY010TmhnSVZJcXVjRDVVYTlO?=
 =?utf-8?B?SXB2M0dneUZsV0hLV0toOFE4Z2M5VlhqN1lhOXpLa2VvbnNhSEphZnZTb0lN?=
 =?utf-8?B?MDhtMUVmTFRmS1U0TTR6YXhQaDNQeDM4S2Q1bVdZa1J0b1p3SHU4b1AvQ1RG?=
 =?utf-8?B?SVJjQk1ybDF5YjNjMXJpVUl3OTZNZmpHekNmWTVLREFvWVYwNXYrbk5TaGNj?=
 =?utf-8?B?RHRzOFJrMkNpNjF2SGM0SjNjZ1Z6dW9ZSy82VktyU2RWRlJ5am5ZcFZkdFhH?=
 =?utf-8?B?NTlSVHpTUXc1Wk5lN2JUelA4RldnY0x0enFzMFhoS0VkWHF4U2d6anh2Umpq?=
 =?utf-8?B?bklwSit4d043aEI4M1plS1VoZ3BTbVc4OVFmbkZhZ3ZzUGJkcG1mM3Bwdjgr?=
 =?utf-8?B?UzJQeTNkc21aTXQ0SXhRNHoxTXF4aXFrMi9kMEM0Q0U1NHpuN0tnVkt2WEdm?=
 =?utf-8?Q?mYI5wMnCHyCybKSOl/fDP0c6VypW2RFv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0RrVndST3JWRmFOVXl3d2gwYVNZendJWU8vNUZ3QTZXNWgzR2NjTlltVUcz?=
 =?utf-8?B?bE0wV0hTcmdKbWtPdE04TEhnUWlCWEs4eFMyWTJOUVVlaFFIOTRMUHY1bjBY?=
 =?utf-8?B?VHc0MDZUUnN5c2krSjgrMEhPNmFGaUtJWnQ5ZUVGZndxWnhPM0RTeG9sZ1Rh?=
 =?utf-8?B?bmtiZVVqV1RERDRhZTN3ZEFhQ2U4Y2M3S0o4dUxZbE1kc2YxTWlPaExEY2JZ?=
 =?utf-8?B?dFM3SmhUQ01BSDNtQ2wzQWxFT2I5TE80OG1qM2REMklYOEw2bUp0b3Nnd0FY?=
 =?utf-8?B?ZGYzbjVSRVE4OVNYNFNxVmUrWS8vSHJJSXZPOCtDcTVOZ3g0RVhFWHBja05B?=
 =?utf-8?B?TVV5cDAwVDQvVnh3c2p6WVZOVWhaYUJLYmhiZ1RKZmdTQ3dmdEcwOVY4SkZz?=
 =?utf-8?B?NGRVQkVDUnRGL05YWk1uRlVRTVE4U0w3Y2xpalBiNld0N3FWaGZjYnJCTHlD?=
 =?utf-8?B?ZlkzREY4YWQxWjNPTnIzMUZWTGpvMEVzellYVWtXVTY5MGM3NVRPK1owWTRE?=
 =?utf-8?B?eVErYm92WmZLSlRJODF6MkgyZzBiUnI2eG45U3ZUaTZsQ0JEV3FKYWpBOElI?=
 =?utf-8?B?bUNkRlU4OWhFeEtmYlNaTkVwWjZxd05SYXVwdUF5NUxqQnpubFVpZFNtc1Mz?=
 =?utf-8?B?ODFlNjZIZndja3pSUkF2MWhZcmJ0VnhoODVhMmJOWHNTbFl5d01lUXhvN2Qy?=
 =?utf-8?B?dTQzZExXb0tSVTQ3ZTJhUEVXb0ViZWtVcDdNWHlFVk1POUVuL2RZNTB2aXNN?=
 =?utf-8?B?RjNmTWc0cVJFYWR4d29Kc1prbC9hb25LYnRXR3QrY093eHY1MmdVNEtOWFVW?=
 =?utf-8?B?d2dWN2JPMWpGVnNEYWFGd3BJQnVZQm1nZXRtbjlMeEJ6RndiaGJIcFhpVi9S?=
 =?utf-8?B?M1N0aEYvZmJReElkaUUzSXBpa1F2T1NVWFNZMUZyV2RlMlcvK0hURC9aeWNS?=
 =?utf-8?B?RXRkSC9haFpCYmVURlVFaUpSN0tlTU8xVjEwdE95OHJTZDRrMld3M0xnT3Uv?=
 =?utf-8?B?cW5IUUVwZWROMTVwcVVPSWJJQUNBRlFucTcwY0JVUWpYb1VoNXZmM2VKY1BU?=
 =?utf-8?B?a3dlREN3cHJneVQwb1BpM1VUemduNDc2UHppbGNaNS84YkxReG40MmFZcFZw?=
 =?utf-8?B?aGxhNVM1d2w3OGErNmpWSHdrSkh0QUxEU2lzMDFIRm9xMk9vcHBOTk15VVNH?=
 =?utf-8?B?clJPcTAwc2Z3WC92eE0vNFFxTFJKRHVJYk1EaFpjcDdhYnN5R2FIelk3bFNr?=
 =?utf-8?B?dm9zdXkxZEFVNS9jcWRvT25vYkYyVVEwWkxPa0trOG04QXRCNEJQUFUrR0U4?=
 =?utf-8?B?b3Q2aERWQlpvczZ0RjBQRkNxbSsxdkMrTWJjb3pQQ0IxKzcvc2JmdWtFd0Q2?=
 =?utf-8?B?S1l6UW90dVpzamxkdzNEU2ZVWDlDQlpJY3JaR3IxS2RUWmtNelk4eGZWZlh1?=
 =?utf-8?B?TlI2dGVZZGs2bzE3ZjAwbVBaUmRlc3NwbEV5T3lOendFdDhMNnEyZHhjaDdw?=
 =?utf-8?B?QWNiZ2FoQWJMT2g3YWRkLzBWT2tQV0ttSnRKaGgvVmdOcjNUNnhrekxhdFR2?=
 =?utf-8?B?eDZEZWpUTDVNSE1BblR0aXNlSllVajVuWjhrek5xOXZEazZ2K0x2RDF0TFBU?=
 =?utf-8?B?bDN2OSszNHJ4TDJUazJXbGI4UW1mZElaeDNKUTc4NUdlVXlwZkZIWHZmdFlB?=
 =?utf-8?B?dXIrWlBkWUY3V2pVcFBaTEt1alVsMndRVlQ0a0RtTGQ2K1hSTmtjdHhSZ29O?=
 =?utf-8?B?dGM3amF4dWtRcE5TTWVrQ05scFB2MXNJNU5iNHBVTExIYTdmZ0ZrMDA2OTdZ?=
 =?utf-8?B?NHl1RU1yNnloZ0wzZjlaVGtpMHpVQ05vR04yQ1Q4YlpDTkdabkM5VGFzV2VY?=
 =?utf-8?B?UVQ5TXUrNnZLaThtVDAyTFZoR0FVaTQ0RWZPYm8wdytTbXF0WFdOQmRSTk0x?=
 =?utf-8?B?MHYyU0U3MzJtRU5JcDl5RkF4a3FaRG4vMGZyNzZKRE54WXgyOHZpdzBQVFdu?=
 =?utf-8?B?SmdwYndPWnpTMWNxc1NYRHhnWDA5TWFDaDdITTl6OUF4bzBwNEJRT0JIS3Iv?=
 =?utf-8?B?ZmNjdXdsSGUrR0pNb1N1Z1dQRnE1N1hGeDlWb09tS21Ndk0rVUhKc3Z6QTM2?=
 =?utf-8?Q?bOKo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25021424-a247-4d3e-432e-08dd5d4e5d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 08:02:10.8282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGjX7k4gnbnhEEwPJt3vcCY8VEGFWa5R/yAW7MRqQZJry+ff/w2YqO5ELD7Dq3Az8PHiuGGqnIqe4CFrJMkNGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10426

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlyaSBTbGFieSA8amly
aXNsYWJ5QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggNywgMjAyNSAzOjI2IFBN
DQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+OyBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZw0KPiBDYzogbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgU2hlbndlaSBXYW5n
IDxzaGVud2VpLndhbmdAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHR0eTog
c2VyaWFsOiBmc2xfbHB1YXJ0OiBVc2UgdTMyIGZvciByZWdpc3RlciB2YXJpYWJsZXMNCj4gDQo+
IE9uIDA3LiAwMy4gMjUsIDM6MjUsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gVXNlIHUzMiByYXRo
ZXIgdGhhbiB1bnNpZ25lZCBsb25nIGZvciByZWdpc3RlciB2YXJpYWJsZXMgZm9yIGNsYXJpdHkN
Cj4gPiBhbmQgY29uc2lzdGVuY3kuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3Vu
IDxzaGVycnkuc3VuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3R0eS9zZXJpYWwv
ZnNsX2xwdWFydC5jIHwgNTQgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ID4g
ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiA+IGIv
ZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyBpbmRleCA0ZGMyZjNlMmI4ZTAuLjg4OGQ3
NDQ0OTRkNg0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1
YXJ0LmMNCj4gPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gQEAg
LTQ1MCw3ICs0NTAsNyBAQCBzdGF0aWMgdm9pZCBscHVhcnRfc3RvcF90eChzdHJ1Y3QgdWFydF9w
b3J0ICpwb3J0KQ0KPiA+DQo+ID4gICBzdGF0aWMgdm9pZCBscHVhcnQzMl9zdG9wX3R4KHN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQpDQo+ID4gICB7DQo+ID4gLQl1bnNpZ25lZCBsb25nIHRlbXA7DQo+
ID4gKwl1MzIgdGVtcDsNCj4gDQo+IFRoaXMgcGF0Y2ggaXMgZmluZSBwZXIgc2UuIEJ1dCBjb3Vs
ZCB5b3UgYWxzbyByZW5hbWUgdGhlc2UgdGVtcHMgdG8NCj4gc29tZXRoaW5nIHNhbmU/IChJbiBh
IHNlcGFyYXRlIHBhdGNoLikgTGlrZSBjdHJsIGluIHRoaXMgY2FzZS4NCj4gDQpIaSBKaXJpLA0K
U3VyZSwgd2lsbCBtYWtlIGFub3RoZXIgcGF0Y2ggdG8gY2xlYW4gdXAgdGhlc2UgdGVtcCB2YXJp
YWJsZSBuYW1lcy4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
