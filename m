Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020097.outbound.protection.outlook.com [52.101.189.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07530EF84;
	Mon, 27 Oct 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568287; cv=fail; b=fAExSzGqlyn5cXqijGyPgfOeGR53iDZxZJWx3S+gNtbb462sqz4BEg7MMvrgj5kmh7HP7p+chrCkOPpDer2A282PtJ6FsC3HY3JR5pIkyMHeIu4Gbk7Tx0zqnRVpvBLcMz9VLYMW/AVnSW1f2ZZGk6nrhkcV+5zWdKWRgZS7hfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568287; c=relaxed/simple;
	bh=Uso57QlpRnV8vRCR54og0N/2KUuW6wvlTl5YVpdoQGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AKeA+Wyo5owraEpQ29v8dCWyf83YG7Tvb+6M6KbnPRvRlWiIZVI7i5hertKip5nTwfzP3I1I0ehn7Dhy6b7xUxqcEp583LD+hk5Qg00D2OHEW8hPkwm/v/oaWPg6Rccnmb97RdpeisKtfiENCCCAUd3eKTAz0UyP6JFn12P2LPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=connecttech.com; spf=pass smtp.mailfrom=connecttech.com; arc=fail smtp.client-ip=52.101.189.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=connecttech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=connecttech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dvra8QkVQ0GYxLYpMnvpcNxMqH7SufFfSFtpQgZs27MoLSm0OjqzuPKYRqiVtSDMmbJ37XEGJUs/wMFKj/vQTsb/dGYoLe2HTljeLHRBsDuBl2DEYpgQL+qy5VlWGHMcL4QKQ+l4dbW/z3+e33Hck22MMQelofM8xoq5vSLIxJOS4RD+StNKtcERk5URAnbNPkdLrzOrWmyO7boQUBPv4nBdsLAM24WXcvOhYSa3y54WrVw6S+8i8XljBb8tTJkAd40JgD8Sq6xCmIgEyb7LKwKJSX1sztKXBvTINHa5EkJxfXuoIuRN/tI2pTPLwUibCGwW23MzMdmPuZcdw+ln6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uso57QlpRnV8vRCR54og0N/2KUuW6wvlTl5YVpdoQGM=;
 b=Z4QK7K4GCIFkn/u9gZMUfH6onJDaiUesnSXciy1fQE21YcHT5QzaV6ZqclCY3r5B/QpIyLSnBKXmw75aqmNwGknTyB7e2mGeA2lmB9MZXASpWdRFxx+c+tKrfOmE0qvsNSEI34m7SiLwArGDBd9I/BHTyyH3o34dxdHMypO/RIXek0yo4f+XGD6EUbKohLJDbIFf8h3iBKGeII2jUw0ugK8aHEwdgrC45+0RxMsqpElUpaOu0rYZwt1QmfUZFNhP3KOl8Vm9jJldWSBDtAOT5D7isifU2oEh3grVp7KDt6M3kqP+B+aiuVbftdCOsPV9G46OaqP13ywgMyORg7SAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connecttech.com; dmarc=pass action=none
 header.from=connecttech.com; dkim=pass header.d=connecttech.com; arc=none
Received: from QB1PPF121146BA5.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::216)
 by YT1PR01MB9195.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 12:31:22 +0000
Received: from QB1PPF121146BA5.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::eae2:17ec:d642:cc67]) by QB1PPF121146BA5.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::eae2:17ec:d642:cc67%8]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 12:31:21 +0000
From: Parker Newman <pnewman@connecttech.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Parker Newman
	<parker@finest.io>
CC: Wilken Gottwalt <wilken.gottwalt@posteo.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Subject: RE: [PATCH] tty: serial: 8250: exar: fix kernel warning in
 default_setup function
Thread-Topic: [PATCH] tty: serial: 8250: exar: fix kernel warning in
 default_setup function
Thread-Index: AQHcAUGlvzYErL1c80GNJtXmYjYOLLRUnwEAgAvjIYCAAChOgIB1yqEAgAABo/A=
Date: Mon, 27 Oct 2025 12:31:21 +0000
Message-ID:
 <QB1PPF121146BA5CAAA303D604C459B01F0BFFCA@QB1PPF121146BA5.CANPRD01.PROD.OUTLOOK.COM>
References: <aIiDf31HzRBGuMN2@monster.localdomain>
 <2025072929-distant-hardener-0e75@gregkh>
 <20250730130348.082ad53d@posteo.net> <aJJ49CSBqGZM_b1Y@smile.fi.intel.com>
 <20250813130629.03832804@posteo.net>
 <20250813091900.7d4e4e89.parker@finest.io>
 <aP9jEDtIFIzihGYa@smile.fi.intel.com>
In-Reply-To: <aP9jEDtIFIzihGYa@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=connecttech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: QB1PPF121146BA5:EE_|YT1PR01MB9195:EE_
x-ms-office365-filtering-correlation-id: 5e1ff5e3-60ec-4a67-ce3a-08de1554bc64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1o0ZjhBeDNWbmtwekVmZnF5dndpQ05HZGltWmxGRlQxeEprY0RoOXVScmR1?=
 =?utf-8?B?eXZSWnU1TzRaVVBET0NzSzBlL25YSVVNSnNHZ2dqT09LSWVvU1diWHl2MHYy?=
 =?utf-8?B?ZzdBcFJsZDZVQS9Jb244cmxwdE1NZlVZNVZIQTFUd1IyT3pSUnQwWVBFM3RQ?=
 =?utf-8?B?ZEJ0M0NJS0ZmZWsxNGUreWxLTWwzVzRTTzFUeVAvTzhxUFdFWEsrZy9lVzdO?=
 =?utf-8?B?dWRMTWRLVG9nbjJsNFV2aTZESzVjV3Fva0FMMnpHeVJwdkdTNXlVdXg3dTVT?=
 =?utf-8?B?VnU4T0xGWldoQnB3cUFFWDhwamxTdjJSZHMzeTdmNjdJS0xTaDBQbjkvL1hF?=
 =?utf-8?B?eGlSdGxGY2dqTWlkcGtzR0lvQ3JVZUtQbnh2U0M4dWFZaGpUdUZtbEF3ZmNk?=
 =?utf-8?B?UllIWkhpZkZkZ0JFa1B6dWdHSHhva3hKK2JOMlpVWkU4dHpHM3NyWnFYYmM3?=
 =?utf-8?B?U0M4TmNIdHA3SGVjVUlzSUxmbnFpRGkrZXZrMThEVjJRZ2k5NFE1WGdDV21K?=
 =?utf-8?B?M3VuZVgxUlViVWc2VTNKdDJVdU11SWVpR3lTZ0s2NjNsT1lReU5ObWQwM0Zl?=
 =?utf-8?B?eGk5ZUJENUlmRldrdjNmd21iU2gvQ21FVjQ5WTJLM3gxWHBZdWJCdU5vZHYw?=
 =?utf-8?B?TjlWNmhkNjVNKzFPcXdxZXg0RmJhWTFKUThKYkU3TkZ0SXlua1Z3NzJlUjVr?=
 =?utf-8?B?a0FkUTM3R3l3TUNjbXBab1J2MEdlci95a3RaZjF5c09zcjNFT3crQjBXNkZR?=
 =?utf-8?B?SGQ4OUFyQ0RxSWt4MHpEQnFOZVVXdlk1V3JGQ0hucFJ0QjErZ3BmSGNRUHZj?=
 =?utf-8?B?djZrWUU5OG1aWjk2VVdDRjgvbEhwWjcwWEJiWmd6YkdlNlhxQ25aS0V5MmFX?=
 =?utf-8?B?SWc4dlJ4OEJVVXl5amJDZnZvOE5JNjVtRU8rSXdaYnpxSmUweUFCQjY3V1lR?=
 =?utf-8?B?TTV4YlpVMnNzNlRHdXkzZDhFMEQvVk5pcXdDZWZsNnpBOC9ySDBnaXcwUE5V?=
 =?utf-8?B?QU1QMW4zVldPT2dyV3lOVTJIVEZac3hYNEJSMDBRc0lHQ0NnSFhFcklNV2U4?=
 =?utf-8?B?cjBNdlFTb0dpYSs3ZWN0SGFocldmakFlaUhjaHZNRmlRdTBjaUZjRkpHN21t?=
 =?utf-8?B?RXJqdWJ3MitQeGwyc3dsUlVtczJVVmZBb1J1YmViVWdMNEhoK2Jsd3BQUjg1?=
 =?utf-8?B?VVlhSzQvc2pKU2hRTzlmS29xNDg0dkJwWUZWVVVESFNVb2hUNUlnOWM0MTE2?=
 =?utf-8?B?RjVEOUthbXk2QlViUUlFV2hEWnZmNE5Bb3d2aUVETzlkS01WZnRQOU1zbGh5?=
 =?utf-8?B?d3VWeW1RMTdGdXMzWTRJS3B4OW1VdUZuTE0yNlhnSC9JaVFhU25rVWdiOHRX?=
 =?utf-8?B?VnV2T1BiNDVkSjBsaWl5UlV5NWhVb0UrREZpcXUyakJ6bFJkQkhPTjZnbVlm?=
 =?utf-8?B?eFNiVkJ2UVNJUjFOeC9VK2FWRm5BNC9OL09qSkEwK3FHSTdtL3hYUFVFUTZh?=
 =?utf-8?B?MzFTRFVHMlF5MGVUTXVYVCtzamU2MExnK0pLcy9pdjZtd2plTHErZVNPTXZ6?=
 =?utf-8?B?aWtJN2FjSThhMDc3RXZFOVA0c1lsb0l4NGdoYzFXZEdKQk50ejJQUFFuVkNi?=
 =?utf-8?B?U3VjS09nTGFwbHUzUUcwN2k5VHBWRFhEbk51YzlqMlJEdDBubHlleTlmQXNI?=
 =?utf-8?B?SlFtQkp5bUxsZ2tTc3dsbVNjVmtlMzJYVG1TQnBLRGJaVWpuVXVpV3hRMzBF?=
 =?utf-8?B?SmpwQURqM3hJVWcyUGgvWTRjUk9tMHhscG5xZ3NyVi9WZmVyS2p1QnlJWUp3?=
 =?utf-8?B?MUtYOFJncXNOV1ZEUUtYaDNPL0RzV1BsZ2F5NTAvVkVXclZ1dWJ2b3dsRFJu?=
 =?utf-8?B?ekgxYlBrem9Way9HODRJNkRPVStFdGk3U1hGRXFGRWlZcWNGeGNLcTEvY0Uz?=
 =?utf-8?B?MXpCZWtUM2xCbmJoRFZhTytDbUx2OTRmNXZkVUl6VVZVMHd6REhDaExmMG1p?=
 =?utf-8?B?SzZPcFFwazNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PPF121146BA5.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnZ6KzJMaGxKWmlaRE1DMjBFWCtqNkd5YzhmRU4raHFWNFQ5allzSU5MK201?=
 =?utf-8?B?cFJxbis3b0E4RWNhTkJrSTlzTFBUa2pHK0U1eEt4UU9nbExhd3NFQmQxQnpR?=
 =?utf-8?B?cURxb2UvL1RseHBLb3NlSDh4QkwwM2tpTHBUZlg0THBzNjhlcklxU2ZyTkNs?=
 =?utf-8?B?dm5zM05nY0RoMUU2SjU4M09oQUhhU0YzcWdjS294L1dvNGp6cys3eHFNUWhu?=
 =?utf-8?B?MkxKV25WR3F3ZWZnaFQzVzFDamd6SEs3eUxCVWFRZXVCbUlZblBiSWRTaUhQ?=
 =?utf-8?B?NXJQNE15Vmp3NjFnT2NIdS83aytJQllacERNY1BBV290elh4WTV0c3NDeEts?=
 =?utf-8?B?VGFTai9sTzdDSnlEcWxaVmtieDlyY21Kb08xNFdDUE9nMFJwZ01zUld6aWhI?=
 =?utf-8?B?VlkvdDNKMThINjl4T3hNanJGTDdyMlRQV3BjazZ3Q2hEcG5WdVY2SFh5NExx?=
 =?utf-8?B?TFVYZWYvR0QyMUZOelN1YzFLdWErQUNYZVNSdzMyS0RLckgrUzhmYzRrdWlQ?=
 =?utf-8?B?MjlsNWlPRUgvTm9aOE5JY0pHeW05bURZZkx4K3pjUGxJcU53a2k4eXFLV05m?=
 =?utf-8?B?eVRUeVBOcStRcENMOExiVkc3YXE1MHhOdEFULzR1b1hiMWwzeG5ic0lFRGZt?=
 =?utf-8?B?ZmtyWjlqcGtuMlF0R29UT1BrWkVHNVRkZmEwWFBsZFRYWUhONkJNNVRLU3Fo?=
 =?utf-8?B?VjUvaVU0cktXNG1oL3NPY084bDBTM1dOTis3M0pkUEJlTXgydU9XbGRFMlFS?=
 =?utf-8?B?Mk83ckpTTGZ2MEpYVUVYWmRsdzNIRHFDdnNXemR1Vi9sNklZeVJzTlQ2eGU1?=
 =?utf-8?B?WWZNQkpGQmg1LzhhODNGejJKVUFRdTFBMytTUUFHa2NVdTFRZ3M2WXdXTEc1?=
 =?utf-8?B?ZFVjQmg3V2VRVUxoNGpTeXNxemJ1bEVGS2N2cW41bmxmcDdzVEdtU3V6eWN0?=
 =?utf-8?B?ZUFWdk0xdHFicVVzRG9HWjR6RHNCVXVLeDZyTmFCOWhTVmR1K2h1bGJhU2NZ?=
 =?utf-8?B?TDlpUlp5LzYyS203S29VOEFZbXI0ZDlMbXoyOWtGRFdmNkhmMkR0OXYwdFYw?=
 =?utf-8?B?RkI5VDM3dndRRWdvdlhqdjR0NnNZZXpJbEMrSWRYd21TeFkvNkNEUEV1Ympw?=
 =?utf-8?B?ZDEwVDZnZ0dWajdoL3hZMStBYU8zNS9MMlZFbGdqK2dWVzNIcWdYN0c2UmZ1?=
 =?utf-8?B?Y2JVSSs5d2pIL25pSkFjajdEVnNpR08xVXIzQWlWM3VXVzA1ZXJOczVBWUsx?=
 =?utf-8?B?cCsyMVhya25SL3BtQ2hDY1M2V2NvTisrVlV1QWQ4MmZOajljejBGRy9JQm9S?=
 =?utf-8?B?ZURUZVVLV2ZUc29vdVlac0wwLzNGQVBnbEY3UEMvaUh0Z1JmYnl1S3htaXNw?=
 =?utf-8?B?bk1rcnh3dTQwRDF5Zm9KOG1jeGZxY2VuOWtuV0swbDVOVkdnVnhOVUZMQ25o?=
 =?utf-8?B?eE9na2JoRHB6QXlmUUx1Rng0cis5a2lrTlRkSkV3UU1ES2g3eS9FQVZWN3V6?=
 =?utf-8?B?UzlxSEQzSW5MWDJzNlgxcTJmbWgxMGFSMGNHYk5weEpYMFFLVlZhai9RNEpH?=
 =?utf-8?B?R09pZDFPRUh2QndUTWtwQXNYUjBYa1pnSzFMdUJDZ05ZVlk3Zmx4a0tFRjJ5?=
 =?utf-8?B?RDNETXlHZFoxMGh6SCtzMVpIK2ZLelppQnQ2VUtTbUJZWHRmSnZmZ0ZMeW9L?=
 =?utf-8?B?djRpK1VxOW8vRWsvZmF2eDNSUkw0b0tJcGt2Z3dZTHdQTzZrNW12VnA4Tmw5?=
 =?utf-8?B?eW5tLzRuWCt4K2RuT3NLcFVUSERod0FPVVRSa0phVzFwdVpERnAvQ0k2Q0tr?=
 =?utf-8?B?RXY3OHcxRjFBcnRqQVBWcW1yeENRVzhXKzNNUHZ3c2dBQWJPV0QvdnZ3dUl5?=
 =?utf-8?B?blNrYXp1U0tvWldvRVlKcTlucVRFVEFhM3JaazZaS1R2WWFVeDJQUE0rd3l6?=
 =?utf-8?B?VTRVUEVFSUNGNVBTZmJKeWI5YTFDVmwxbkRHK0pnV04vdUI3NTFkc2lnQ2tn?=
 =?utf-8?B?a0I1YjhGZ08ycDF3TGNYQmxKY2hkL3Y0Mmk4M09ZVVlmUzU3SFpBeURFV3Yz?=
 =?utf-8?B?T2JwdHQ5ZGg5OHNTdHNzRmNnV0I1YmZxT2VkZzQvZUc3OUZmd0kvZWczNG8z?=
 =?utf-8?Q?BaPD1M/WST357v4vcUOhAauv8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: connecttech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: QB1PPF121146BA5.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1ff5e3-60ec-4a67-ce3a-08de1554bc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 12:31:21.4675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d33071ec-da55-4b12-8469-920f998c36b3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0XGM3mezYDhH8CJA8uV2OsUKdzvy+zkABVk4WO9A6ubAHfDSMa8VOnO8qAokDTr7AHkeBp+2mzsCU+WpGDgPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9195

SGkgQW5keSwNCkZsb3JpYW4gZW5kZWQgdXAgaW1wbGVtZW50aW5nIHRoaXMgZml4IGluIHRoaXMg
cGF0Y2ggYmVmb3JlIEkgaGFkIGEgY2hhbmNlIHRvIGxvb2sgYXQgaXQ6IA0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtc2VyaWFsLzIwMjUwOTMwMDcyNzQzLjc5MTU4MC0xLWZlQGRldi50
ZHQuZGUvDQoNClRoaXMgaXNzdWUgc2hvdWxkIGJlIHNvbHZlZCDwn5iKLg0KDQpUaGFua3MsDQpQ
YXJrZXINCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFuZHkgU2hldmNoZW5r
byA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiANClNlbnQ6IE9jdG9iZXIgMjcs
IDIwMjUgODoxOCBBTQ0KVG86IFBhcmtlciBOZXdtYW4gPHBhcmtlckBmaW5lc3QuaW8+DQpDYzog
V2lsa2VuIEdvdHR3YWx0IDx3aWxrZW4uZ290dHdhbHRAcG9zdGVvLm5ldD47IEdyZWcgS3JvYWgt
SGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBKaXJpIFNsYWJ5IDxqaXJp
c2xhYnlAa2VybmVsLm9yZz47IFBhcmtlciBOZXdtYW4gPHBuZXdtYW5AY29ubmVjdHRlY2guY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSF0gdHR5OiBzZXJpYWw6IDgyNTA6IGV4YXI6IGZpeCBrZXJu
ZWwgd2FybmluZyBpbiBkZWZhdWx0X3NldHVwIGZ1bmN0aW9uDQoNCk9uIFdlZCwgQXVnIDEzLCAy
MDI1IGF0IDA5OjMwOjQ3QU0gLTA0MDAsIFBhcmtlciBOZXdtYW4gd3JvdGU6DQo+IE9uIFdlZCwg
MTMgQXVnIDIwMjUgMTE6MDY6MzEgKzAwMDANCj4gV2lsa2VuIEdvdHR3YWx0IDx3aWxrZW4uZ290
dHdhbHRAcG9zdGVvLm5ldD4gd3JvdGU6DQoNCi4uLg0KDQo+IEkgY2FuIHRyeSB0byBnZXQgdGhp
cyBkb25lIGluIHRoZSBuZXh0IGZldyB3ZWVrcyBpZiB0aGlzIG1ha2VzIHNlbnNlIA0KPiB0byBl
dmVyeW9uZS4gSSBjYW4gdGVzdCB0aGUgODI1MF9leGFyIGRyaXZlciBhbmQgcG90ZW50aWFsbHkg
Y2FuIGZpbmQgDQo+IGEgODI1MF9wY2kgYmFzZWQgY2FyZCBidXQgSSBkb24ndCB0aGluayBJIGhh
dmUgYWNjZXNzIHRvIGFueXRoaW5nIHRoYXQgdXNlcyA4MjUwX3BjaTF4eHh4Lg0KDQpEdW5ubyBp
ZiBJIG1pc3NlZCB0aGlzIHNlcmllcywgYnV0IGlmIG5vdCwgSSB0aGluayBpdCBtYWtlcyBzZW5z
ZSB0byBnbyB0aGlzIHdheS4NCg0KLS0NCldpdGggQmVzdCBSZWdhcmRzLA0KQW5keSBTaGV2Y2hl
bmtvDQoNCg0K
