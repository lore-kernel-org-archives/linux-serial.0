Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793090043;
	b=tFM9IQpv6muOHLiwGlIWb4SkUpaoE5rojSSSjP8g4YIdPc+yvyEmSx/o2xR33wKFYI5Z
	 DOThhQMb68VgbKjvHJAHiwY9br0+5VA2ylfxO6v5sr/06pbKyvJNlKnw5PdKc5SvwzrrK
	 dLuCp60zDABmK3T51i7aEOqMO3OP6k57jhijQEqKZ0GFJNU+zFgYglRKhtxBoa23u26hH
	 cSfH5SpapyXxCfPY2eRmmQnQkNgmEFMVCJTxP1fT4hILOihyDHBtFhFHdmR+7zwnd8jC9
	 QoXrFCUXdKeryN88L7HEAEQDRO9kJrAiP+pd3qI027vQ2N1T6Ub10oI7BnXge1/XhBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090043;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=cTSSHOJrW8E+uqxGO7yhnDWYaa50w2mtP6Pl7PeLZxc=;
	b=bQ0xW7/UsXlm9RfDERzpibG4ykAtYfDhTwctZhHD0XtABuT7IUv60EypHQrFxvj3lcIh
	 X+twmwQUQUCWvPX5MxLgmN9Wmbkprf7hfXe+sSSeTMFGLC3J/dLE4AHavuwNVc+uZnFix
	 QhkXl2PcFYgGS65/90e3yru0QlVKWw5sevHXcV1ilo/0DPJNqhF1Sam9cMMMacYujfP0m
	 UHPcEoJVCJMnWymqCCw+SZ2g6ua4deUKPryDqT5YC1xXyp+MGqoAC/RDP4uogsJm8m3b5
	 3PDwR5He/UbGXQzmHliMDB+K2OUnO3Ok8Lq5W68mepYPfPuSrV7XNuNjAMczRHVNoYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=FLc8GjM5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.59
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010059.outbound.protection.outlook.com [52.101.229.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C766606A31B;
	Tue, 27 Oct 2026 08:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C766606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=FLc8GjM5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9Nu6flDMZsVDUcLRS9FFCHmi5hIAkft+YntAvtfrfphBmcT0VjRE518kzWPXHxngOBm6kBtvMUv5L6ipuj+5tVyRRxc8YrAX6Bnw8d+A546jE6Y1UpTyxdGO6BHLb6hQ9NtxJ5vrbscmhkh5k0/P7sCl6suZYAvREDyy37pAfHW2jDSo/o3avHZxZrnAneir87H/z0oDBWzrYkMZPVL7nR/xCDZIHV7M59CY5hLJkaiLS5C3Cw/YcM7ui8w/tUHW3ln1X4sthjLyAEOTrpX+oTFWTC8ZSqzHqwBHlYouVmIuwrjF+2s+rYXNG9iOTi9eiR+m3LIrFdKPc3r2Ljtcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTSSHOJrW8E+uqxGO7yhnDWYaa50w2mtP6Pl7PeLZxc=;
 b=MeudlWuuX9lHnUHqSWDZn2jbxRr/ED9FI6RfJTPdX0IzthY6KCJyeU2XiJH4+3DbTr5bCb5z4gljgQ/DDwZl0SAi9KOvNOQoYBVGFNg/fLPb1b1lTnRA1ZP6yu4rQ/8riuyI1k9dQ9QNaO96ts3csqQZFx4KM/XqeMD8Of485BukFOAUu37I08oxz6xKFnswmaVILGUWLxDS/wuTtHj6mo7AtW+KkDGpRCIT5SCzWoS4X9iW1jwKrMJC4/noNuV57S+3/hLheE3NMqaoEGb82y5tTDztvqjre5EMahve8Tt3UlJJNbnIchFIvaUf52jyB5BM3CDu2Ia2hS+yAIUY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTSSHOJrW8E+uqxGO7yhnDWYaa50w2mtP6Pl7PeLZxc=;
 b=FLc8GjM5qtUOBnvwoncqYnSUsZSOdgYszwQ9/kx+VMmZ3cJR5a4Qv+tGxrfrEc02fGyMwKesItz1wljOVsw6s+Dkv4XAgmdYBnjsFw0Ii4aBeb5xT3PRc6wHprHwmvz15aWYKSNQjichtheDe6Rt3DC7bPQzLZmJRXyJcyHwzjg=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB18251.jpnprd01.prod.outlook.com (2603:1096:405:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 27 Oct
 2026 08:34:00 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 08:34:00 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"biju.das.au" <biju.das.au@gmail.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Au
 Dang <au.dang.jx@renesas.com>
Subject: RE: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
Thread-Topic: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
Thread-Index: AQHdZTx0nCl6r9+vN06096idU3GgbbcQ5bkAgAAVSvCAAAKsAIAAExbw
Date: Tue, 27 Oct 2026 08:33:59 +0000
Message-ID:
 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
In-Reply-To: <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB18251:EE_
x-ms-office365-filtering-correlation-id: 8fefd492-ec05-43f5-62b9-08df34050c8e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|261009223027099003|10067099003|56012099006|261021123027099003|261026121527099003|261022105027099003|22082099003|18002099003|38070700021|11063799006|4143699003|261021121427099003|261026140227099003;
x-microsoft-antispam-message-info:
 t3l78uqmxDKMoofYI+AgSnpW7+4NNRWLhxg6EEG1oqPUYw5qt7QV+8ryIyFWQvqv0Y1Y6Kvq0cSdoOmIoFJaydYNHWh/xNEz7NYAwGe27RqR27eYyXb3GrJxxoH2sAaw02BF85caZ6NbniJUeXwf9JQiDLWF+p+Z6LN+DGwLEe1cARUFTvSBqZMWhga8DaQ3AHdWsquAYeZUI2QcwPnnk2aVkADZTTz3kTNSPDXOs2Isl+IFnyAAW22LLQuHzQEW2DuaTr2H9Om0g7g6uB1Y48YezKRTXbKWqn47b+jXP3tt8wgYNJuLNhxy3b+Czp0+eO3t30wS1uar9znVLOCnxmacTwmfVOyBi4g2uOfjI+1IKDNUAsS3FIx3VW03P5v2N+JVbqMyjSSgrb4FVCx2dX/fwn+I1jUmH4ojTwEZHZIXD1sTCJ4Uh5C3AXiMvBPHA6xrUxywqPnrV/wR484qfyB/Qid58nlkoqMhqb4YjCfpb3Ycly3Eb+vneAETkB1nDDdkJpCEZrRCg0tCpcieHjvfzxRs5Bc9jdQA5MCfJHare4nwkETwjW+GCOkEBrHwhBdDqwLp3t5YwC0u36bf5v3mQMkQsnhJwvSNYJ4tLC9e4C3AeusgnRa/0eSRMf+Q5Pl7JXLJBk+0Ghfy7fsNYdTYt3IR//nnJmRM9Xcl/qYZw5NkT74PPqfqeeZAx69du8lRNdWZTLwppfvNYGnaReuN8WK4fekbAiuI+SpFkKI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(261009223027099003)(10067099003)(56012099006)(261021123027099003)(261026121527099003)(261022105027099003)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmpSWW1SSlJvT3BiNlZRem05WWhnaS9CQ3FyNWxDVVZrajBVZU5PckJUd2oy?=
 =?utf-8?B?ZUJkcjZvT0g0ZmFnSU5uZEZCL2p6MmRIRFpkNEw3YWJQeWdHVGdDOG8xZGFi?=
 =?utf-8?B?ZUwxbDJkcFNhNHFhZ0laSmgxaUYyK0JSUi9mZGtRTWpISkdBZkR2NTNDdEFO?=
 =?utf-8?B?VjRXdHRPb0NObi9aUE5XdUd1WUI5eUlFUkkvSGg4QkxTWkdpUXlhVGI2MjNL?=
 =?utf-8?B?QUxjUjVxcytMZmF3aWhxVnhSWmdSd0lJRzhvZTFHT1JmUUVQOXZSUnN4Tmpi?=
 =?utf-8?B?RGgzcXdJQ3k5NnFzUlF0ZS9yWjVnNFQ2cTJlZnZOU3o2MnNDS3dqZDZ3bElR?=
 =?utf-8?B?L2ZpcHpsUzUrSVhzSmZaZ2NlVFpWTEZmL3hOYlpTQkRxcjJmbFZ6ZlkzeStq?=
 =?utf-8?B?dFZNTm9TZjRRWkFWaytoUUhNZDI3YkpnY0cvQW5WWCtPOUYxZHRQSmlVTUF1?=
 =?utf-8?B?V0dWTzV3RnpzTm1XblFMek1LRnIraUVNMnk1Y3JIVXV0TmVGbnFwSDNSeWkx?=
 =?utf-8?B?eE1yUkp5akxnK2hwSFh2V1IxMHpoVTUzYzNnYzh5dUwwM3BYbUxvM2dHVUM0?=
 =?utf-8?B?L1lRTEVYWlJ2QmNydHFoNmdBK2dqNkVlSmRyTDlpNFBsaDFiZWpDZ1FuckJM?=
 =?utf-8?B?VzdMb1lmUWd1ZVo5Ujh5UTBNRjR6YTI0bU8zQXRmQWo4a1F6UGc3Z0k0bVhT?=
 =?utf-8?B?RTkvM29wT1Y3V0NYbjY0Q0J5TllpYlJ6bDNCNWNKL0YxaXdRWEJWUDZZN2Ew?=
 =?utf-8?B?bmVITkJROVUwWnpxd3YzRG5sVmNPdFNKRXBBTzRvMkE1TExSRTQxZjhlUTZZ?=
 =?utf-8?B?ZWFZa0krQld4VVd2T3JYZVcvbWk4bFlITjFvbGxwQ2NFZzdRWC9RUFJZUnRK?=
 =?utf-8?B?YkZyb0Z5Vm0wSWdnazdpdk90WlRmcTlRVEt4Y2x4dHhCTS83VXl2bmYwbjVH?=
 =?utf-8?B?SVRsQUo4UkxkMExPMmh6VS9vZ3g0SDcvRS9sTi84ZFpMT1o4dVVISUJ1OENM?=
 =?utf-8?B?MGxpM1RUdVJPUnRmT0JUTExKa1dubFpCRURFSkV3WVJDOUNJRXJ0NW1iWmF1?=
 =?utf-8?B?UlR2UHUybFdkV2phVzgvdENmT05DbUNhKy96UW13K1RWSkdsZ1dvQ1hrUnVr?=
 =?utf-8?B?VXhwL2dYQUtmNEYwU0JuQ0hENFNxeHdIOHo3NXpUVjYwNEpUZFFIa1ZNY1M3?=
 =?utf-8?B?YzJpd0d0RG5xeElYV25FOEo0K3NNdHY4aEZpVUVGY01CSFNoNzZ1M3ZvMDNR?=
 =?utf-8?B?RWxDREp4SkE2V3VXaXcyZ1VMVTMrUkxvWnlTOU04cDZjUnFhb3hMU1NlYU5v?=
 =?utf-8?B?UGM4NlBoOTNjU0pndW5GT0hQY3ozQjJsZnBvRGVMTlRpaUFUalBaMGVCNWVs?=
 =?utf-8?B?R2MzSlAwek9TSDc2dkpGU0hsUVBRZjNhRDdrUjBtem1Uckwvb01uKzJhMEtS?=
 =?utf-8?B?RGxJSXdOd0U2YldyaE1EYVU1STBiQ3NmK2IrTWkyZmo3MUQ0MUFNVkRxbG9k?=
 =?utf-8?B?dytrWkl3b09tb1hpUjdjQW5JQVhTSVMvL0VYMUx6cWV4RXVUNExGWmRDOWVi?=
 =?utf-8?B?WjByUTQwM3B6RXgweEUvdFNUYytmbXF6RzN1RFk0UmdLeFNBbE81dS93OHN2?=
 =?utf-8?B?Qlk5S29WbzIwWlhPMVIybFRwMU1Pc21RM3Z3Y3ovNkQvMVNWbFpxSnhoS2Va?=
 =?utf-8?B?VXNKeUIzT1l4aWRjMjVQOWNKMEFwU2tYNS9nUHZLUk41YytkclhLS2tWUTZI?=
 =?utf-8?B?MnJxYnl1cUhLSDM1OUVXbDZPR0p0WkdYMmlNbU1aN1ViTjhRV1NPRE1IYlZR?=
 =?utf-8?B?V09MUFRCTmxKTk5SOFJIdWQyalVYSXJMdkZrQlpJZ1VESU96amlvU3pmNTgr?=
 =?utf-8?B?ZkhyVFJyQy91TFptMS9sUkRmd3liWUYrektZSFI5QlZHZTFzeDNxM3d4QVRz?=
 =?utf-8?B?emVQYVdCb3RqbDhhOHhMWTdLMWZrR1JRSVpCWlhpNGk0V092Rzd0NlljOUhv?=
 =?utf-8?B?UkRvbm1xMkJ6dG0wWWd0cUU0SjJndk5KTm1iSXhwZEhwZ09YYkowV21qR2RM?=
 =?utf-8?B?cjRZL1kyQytwMnliSlpuSFNRdjVGZ3VLLzZKSVB3TTRhR1daTEJYWm9PcThj?=
 =?utf-8?B?SFRJUStIUDZQUFRpUkZYVVNiSkZNM3VmQ2dieWZ2WG5YSlQyQ2xwaUZ3YXZq?=
 =?utf-8?B?dUVjNSt6Wm5sd1ZWamdGYXFwdEtzT3cvY3h2djgybUMzeDZMQzFyM3ZVMlNC?=
 =?utf-8?B?OFd3WHlNYzhvcXZodm9jckk2anZGc2ZjZVQzU2RuUnBtSVNNWEVmYTJhLys2?=
 =?utf-8?B?SlByZDRPUHN5THF2VWo0bzBXbmx1ZTJqQ2lpMzdkekVaODRNUEdtQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fefd492-ec05-43f5-62b9-08df34050c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 08:33:59.9675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 233SBM5fbgWoL9cZ2BTC2SttLQ76zzHZmVsJR3/rhrOGSkLpgK53Vjnm1XA5UaHyZRAuAAbEEqBlDiy2cQl7yQGeGEjZlcobTOAwc/hNjBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB18251

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5l
bC5vcmc+DQo+IFNlbnQ6IDI3IE9jdG9iZXIgMjAyNiAwNzoyNA0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYzIDAvNF0gRml4IHRyYW5zbWl0IGhhbmRsaW5nIG9uIFNDSS9SU0NJIHBvcnRzDQo+IA0K
PiBPbiAyNy8xMC8yMDI2IDA4OjE5LCBCaWp1IERhcyB3cm90ZToNCj4gPiBIaSBCb3Jpc2xhdiBQ
ZXRrb3YsDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFs
aWVuOC5kZT4NCj4gPj4gU2VudDogMjcgT2N0b2JlciAyMDI2IDA1OjU4DQo+ID4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjMgMC80XSBGaXggdHJhbnNtaXQgaGFuZGxpbmcgb24gU0NJL1JTQ0kgcG9y
dHMNCj4gPj4NCj4gPj4gT24gTW9uLCBPY3QgMjYsIDIwMjYgYXQgMTE6MjM6MzJBTSArMDAwMCwg
QmlqdSBEYXMgd3JvdGU6DQo+ID4+PiAgZHJpdmVycy90dHkvc2VyaWFsL3JzY2kuYyAgICAgICAg
ICB8ICA0ICsrLQ0KPiA+Pj4gIGRyaXZlcnMvdHR5L3NlcmlhbC9zaC1zY2ktY29tbW9uLmggfCAg
NCArKysNCj4gPj4+ICBkcml2ZXJzL3R0eS9zZXJpYWwvc2gtc2NpLmMgICAgICAgIHwgNzEgKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gPj4+ICAzIGZpbGVzIGNoYW5n
ZWQsIDU2IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiAkIC4vc2Ny
aXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtLW5vLXJvbGVzdGF0cyAtZg0KPiA+PiBkcml2ZXJzL3R0
eS9zZXJpYWwvcnNjaS5jICBkcml2ZXJzL3R0eS9zZXJpYWwvc2gtc2NpLSBjb21tb24uaA0KPiA+
PiBkcml2ZXJzL3R0eS9zZXJpYWwvc2gtc2NpLmMgR3JlZyBLcm9haC1IYXJ0bWFuDQo+ID4+IDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5lbC5v
cmc+IEJpanUNCj4gPj4gRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gR2VlcnQgVXl0
dGVyaG9ldmVuDQo+ID4+IDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4gSHVnbyBWaWxsZW5ldXZl
IDxodmlsbGVuZXV2ZUBkaW1vbm9mZi5jb20+DQo+ID4+IExhZCBQcmFiaGFrYXIgPHByYWJoYWth
ci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPj4gRnJhbmsgTGkgPEZyYW5rLkxp
QG54cC5jb20+DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gbGludXgt
c2VyaWFsQHZnZXIua2VybmVsLm9yZw0KPiA+Pg0KPiA+PiBTbyB3aHkgaXMNCj4gPj4NCj4gPj4g
eDg2QGtlcm5lbC5vcmcsIGxpbnV4LWNvY29AbGlzdHMubGludXguZGV2DQo+ID4+DQo+ID4+IGlu
IHlvdXIgQ2M6IGxpc3Q/DQo+ID4+DQo+ID4+IFdoYXQgY2FuIHRob3NlIHBlb3BsZSBkbyBhYm91
dCBSZW5lc2FzLXNvbWV0aGluZy1zZXJpYWwgZHJpdmVyPw0KPiA+DQo+ID4gSSBoYXZlIGJlZW4g
dG9sZCBieSBzb21lIG1haW50YWluZXJzIHRvIHVzZSBiNCBmb3IgZWFzeSByZXZpZXcgcmF0aGVy
DQo+ID4gdGhhbiB1c2luZyAnZ2l0IHNlbmQtbWFpbCcuDQo+ID4NCj4gPiBJZiBJIGRvICdiNCBw
cmVwIC0tYXV0by10by1jYycgYXMgcGVyIHRoZSBiNCBkb2N1bWVudGF0aW9uLA0KPiA+IHg4NkBr
ZXJuZWwub3JnIGlzIGF1dG9tYXRpY2FsbHkgbGlzdGVkLg0KPiANCj4gQWZ0ZXIgJ2I0IHByZXAg
LS1hdXRvLXRvLWNjJyAgeW91IGVkaXQgdGhlIGNvdmVyIGxldHRlciBhbmQgc2VlIHdoYXQgaXMg
dGhlcmUsIG5vPyBZb3UgY2FuIGVhc2lseSBzcG90DQo+IGJvZ3VzIGFkZHJlc3NlZCBhZGRlZC4N
Cg0KWWVzLCB0aGF0IGNhbiBiZSBkb25lIGluIG5leHQgcmV2aXNpb24uIEkgdGhvdWdodCBJIG5l
ZWQgdG8gZm9sbG93IGI0DQpEb2N1bWVudGF0aW9uIHRoYXQgaXMgdGhlIHJlYXNvbiBJIGhhdmVu
J3QgZG9uZSBhbnkgYWRkcmVzcyBmaWx0ZXJpbmcuDQoNCj4gDQo+ID4NCj4gPiBDYW4geW91IHBs
ZWFzZSBndWlkZSBtZSBob3cgdG8gcmVtb3ZlIHg4NkBrZXJuZWwub3JnIGZyb20gYjQgdG9vbGlu
Zw0KPiA+IFNvIHRoYXQgeDg2QGtlcm5lbC5vcmcgd2lsbCBub3QgYXV0b21hdGljYWxseSBsaXN0
ZWQ/DQo+IA0KPiBiNCBkb2VzIG5vdCBhZGQgdGhlc2UgYWRkcmVzc2VzIGZvciB0aGVzZSBmaWxl
cy4NCg0KVGhlbiBob3cgeDg2QGtlcm5lbC5vcmcgYWRkZWQgYnkgJ2I0IHByZXAgLS1hdXRvLXRv
LWNjJz8gYW55IHBvaW50ZXJzPw0KDQpDaGVlcnMsDQpCaWp1DQo=
