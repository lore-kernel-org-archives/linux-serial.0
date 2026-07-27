Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010043.outbound.protection.outlook.com [52.101.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8B36E48B;
	Mon, 27 Jul 2026 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120424; cv=fail; b=WrE/p6pSS/W/l6bTewAU3AE0UdVYi9IJudrFIeg9cdUC1NbwGiBQaJ+ooP2wtgtq/fW5pMX+r07lfa7p7XtXeicbwkVupvZ2xnpELMOrcW+jmJyOl9lrU2hkn0QUhS/1Q2JkeFBGwWb8RYoKhjcREjMU5B5Bqvb78JuOhhhqb24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120424; c=relaxed/simple;
	bh=qGh7/bNDEBtjAAc7fk/OpAad9qy9jD7UtOG+1+bgNZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tadpbYg74v88cAykr/uFV6FAHBlyYK4x9h6Se3EG9Cfj+cj7VetqxDoNxkoKNms0buyWdaHUGPHo6z+QQrn+x42VSatq2TjSzD/cu+SRAvsdvuJ/5G+eeHbHak0JZZLHZd9Mpr7ywRc2dZS5AMNpEA7WW/Fh4TQsebCpLtLnPvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dvro6rVP; arc=fail smtp.client-ip=52.101.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dvro6rVP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEGWCfwiK6zpMHg45bojjl/KgNr7apTtZ8pkdHTqqZNHPoB9tqsWlJ+2Pmd2srZ+8ujh9zMgolH0QOV1lnPNtMfflMq7UdYeT7GOiBWicsKLDGHZ2b5n40BztURQwTY4buxY7ZR+YUUQFe1H1ze5lWWN72rmGN1LhV1nBqPXSFeI5+mrhYzMY8QS43VJMqydNHQfzTUN8Kz3kur+/1AfWBIUuR+/qx+ZvmOk4I5SS0/OTerXnnVDmwKnQ5EZvskGgpgVBYah0PFeEYqKqkH+0EMVX/P26PXYjnxhhyl0DC2NYddO/qYyOH27UvmC0Z+X7vO4g/hga3hc5j5b4ca5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGh7/bNDEBtjAAc7fk/OpAad9qy9jD7UtOG+1+bgNZk=;
 b=JfybTGhqujaqK6WopZXuM3BeW6W+eGr3Z6BECteHq7DxaaxZIPhQzIC/BSfZb+q5iZpTNBxs/yFZI2xM42nlmU/q1K9truGCkp2c7j09z9GbPw39t6L7tYt1PF2fJAsTFLxqe0bSKzh9hInhUbIIXa6fhmTwcNxI3iYZ5/xRjxEyrvPeiDcVPZlRX8eXlfF1CyHa8pBWTOt1FR/5bDGqE9it4q+f68JiwR0rCtwgJWvntLV0q0HlGkxF+6aCfdScaG/fNQT39F2AkxL2+59uUstOAfwhM/gASvWOCc/7t2xhm7aovmu0IvU5BoIRXnIM7eln7ioyvqgi2VOSsx5z8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGh7/bNDEBtjAAc7fk/OpAad9qy9jD7UtOG+1+bgNZk=;
 b=dvro6rVPJ2knWK/y+OJddM7PNp34p8FSqRiaEr6t4C+b0n31y5VKoN62T8rANc0S5VAscuvUc2BgqcLzlR0Xe5pUkpAy5qBnEFzIWzp7/fVfOmbn+SnuM/83D0ocjk5s2/SPHDSM1LtXlDL2vyvwz26IPlNsjVQ3eGil+UsWMZmtTY/WkwbO6I0ncJgPoUFSPXWFJ5EwmaeTcFMKHI/sgK2WaxJfLVLSSUm8f3pNn75PAGqQ+22tfbUeYw4OI6f1cDbFOiJYcQ5jSEfqqN8L1vHwpY99RJRKhvKjPQwhYwIl/Bsjy2/a3FJOjuhD9vbvnj0GjY8ycdLa+TmLxI2zyg==
Received: from TYXPR01MB15199.jpnprd01.prod.outlook.com (2603:1096:405:276::5)
 by TYRPR01MB14158.jpnprd01.prod.outlook.com (2603:1096:405:21f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 02:46:57 +0000
Received: from TYXPR01MB15199.jpnprd01.prod.outlook.com
 ([fe80::26d0:293d:651f:7e97]) by TYXPR01MB15199.jpnprd01.prod.outlook.com
 ([fe80::26d0:293d:651f:7e97%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 02:46:57 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: 'Karl Mehltretter' <kmehltretter@gmail.com>
CC: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Clark Williams
	<clrkwllms@kernel.org>, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
Subject: RE: [PATCH v2 2/2] serial: amba-pl011: keep console clock enabled for
 atomic writes
Thread-Topic: [PATCH v2 2/2] serial: amba-pl011: keep console clock enabled
 for atomic writes
Thread-Index: AQHdG7Sg2kAzhTtuz0mZJQg666Kf+7aAqefA
Date: Mon, 27 Jul 2026 02:46:57 +0000
Message-ID:
 <TYXPR01MB15199DA567AF4541DD79359FBD7CC2@TYXPR01MB15199.jpnprd01.prod.outlook.com>
References: <20260724213348.77418-1-kmehltretter@gmail.com>
 <20260724213348.77418-3-kmehltretter@gmail.com>
In-Reply-To: <20260724213348.77418-3-kmehltretter@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=6d4e718b-393b-4f31-8704-5ab0faa0a679;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-07-27T02:35:58Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYXPR01MB15199:EE_|TYRPR01MB14158:EE_
x-ms-office365-filtering-correlation-id: d7505e0f-88e5-4459-a613-08deeb895330
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|4143699003|10067099003|56012099006|11063799006|3023799007|22082099003|18002099003|1580799027|38070700021;
x-microsoft-antispam-message-info:
 xY2++5/BmWEXtHHn0w8rqnisvLnqFgSDAmkRE6rKNxIqN4MeV+1Et2KZY0OdNuRufScLAaSrJ+7zEGdljUeiM2pJ7FWM3zQmcTYeTmLjYluAwD7uclGW6fZZjdlxBE6XKJX0+2l+EVAG13dHZqgXCQBgZaO1lWZNCgzF7lEsWRE4h/oM+XwcHhnpLTkG58QqJfbMy/9LfT6MRsnPPQ7lqx4PFijfcwBR+zjm3g2CWUpJAEeFdcxm5t5ZmP/JEbRLTMxC8YCr9XDHNfPIAy0Mm40YQTw2XIuDNMPkhgVqnEe4Zr1SJ2zcAXjiiDE0u+VfmhSni9bDhkNVJyYOHA9z248g3luq5F8F1nt3WLaw4vJp+48IAyi+G2js0uwSaJpEwvrxxkUHI+os+r8NX/zX4+v1StsnVJW9ro05nzu43GZHY/EbaNzokIhMCipxZmZwEBewvuMfMw3FRxN5Czn1rml/QqbQKGhSDJ846tNFehOcThz0Ia6jMwgpSRq0HHjyH7zb3/4s+HV1ovvo61M5trQui5J561i0SHLhEtQq2EnbdU/FHEK6XRZhium+DtdFgMnj5bzf0nAcMIJKr5cc8faWqm0UO4mHEC2go4cJVew8cc/WpsHBUYL4OBn4Ed2Fgif4rvmXx+dyewY7/NeICnrpuy80ymffiRnSW9YX4Qh3o5jwylX8nGvG6Pm/xLPP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB15199.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(4143699003)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MkllOEpxM2w1SkxPbFEzS09ITnR2b2xZU2NOb3I5ckF5Q3FvZElUZ1oz?=
 =?iso-2022-jp?B?aW1WYlJOUkkrS0RVenlhOHF4a1lJSUszdGZZR1NVTnF2RUUrenFSZ3Vl?=
 =?iso-2022-jp?B?NmVQRG5oaXFWY2M4S2tmQVpxYWVtTEtsL0VqeWwwemZkZVkvUmZVZ05T?=
 =?iso-2022-jp?B?VWlaWVlYQ2N5dURIdTJwUG5xSWR5bFRuaUFDakY4Ky9iUXdnQWNHK2tt?=
 =?iso-2022-jp?B?Z05ucE9xVVkweDF0cnloMng3T2I4RVljU2FSUlBpY0pDV25FbXF5b0pP?=
 =?iso-2022-jp?B?Y3hod2tXVHpXb1ZDTThmZnJxbXh4TVUvVTZ5dEwyTVladnA0RGxjbGZ6?=
 =?iso-2022-jp?B?TFIvUGJkWXExYlIzS1BCWUNOVzlIQTMxRlRiKy9ERzArdHlRaVdTeHQw?=
 =?iso-2022-jp?B?Y29JblU5ZzJjMFJXVy9vanU2SDB6QWxWRGE4b0hWZVdQa0RXTWFXbVd6?=
 =?iso-2022-jp?B?dXlGOE96cjBvTTg0NFV1L0g3MUgrRFhrTk1lWDlqbEVMNXFaNUJFRC8v?=
 =?iso-2022-jp?B?bER2QWliN1JXd3N2TnJ1RG0rVWtVdEFxVnZNQUZDNEM5VWQzQTU3cldk?=
 =?iso-2022-jp?B?czVYZVJ5bzlrbm9YOENvQnFFWWt2SmdXMzBRekJxUnc0SVBiODBCYXZI?=
 =?iso-2022-jp?B?cnY2SCtaQ21TUmpHejkrWlh5cWxWNGlQNDh2cUtiQ1FqYnVicjU4QS82?=
 =?iso-2022-jp?B?bUtzUU9xbjRoczl1TjB3dk9PNm5VTWZsSkxDVlVhV0VaQ0lRKy80a0F0?=
 =?iso-2022-jp?B?dHRUWjh6TFhuTGh2OFFxMStaOWRaK0xmQmV5cU9HYnhFcjB0U1FudjZF?=
 =?iso-2022-jp?B?akpPa3hFZzdoTitVdG5ZN2IrV2pFcDVFVXoyOTNHSWxvRDZwNVRMSUdY?=
 =?iso-2022-jp?B?TjBubUVEZU1YQUg0cklYelU0YzdQMTB6djVYcEN0dUd3dGZzSGlaSG1X?=
 =?iso-2022-jp?B?VGFya0tsbVVQWHhvcXhZZjBzSWZsV2pIc0xUVFVGRS93SGMxNkpyOVFT?=
 =?iso-2022-jp?B?QTJRNWJ3NjNXV0dtaU9JWXRHYWNaekc0emxNaVp1TnFWb3d1UlFrUEIw?=
 =?iso-2022-jp?B?dHZkTG9aN2ZUcG1qMCtCY3JwWUM0dWZteWlzTHZwWGhZZFJYeTdvb0dK?=
 =?iso-2022-jp?B?ZG8zT3hlMkNDK0h4QVRwUjNKSmdzWi8vcmZTNFdadzVGS1ZjbXJySTRu?=
 =?iso-2022-jp?B?L1Q5bEdZMmtHcnNIWUwwSlZldXBSQSt4eitjbFNIc0c2YW1wQ2hCcEV1?=
 =?iso-2022-jp?B?QkJLU1lKYmw0c0k1MUpPVW96RUxrVTBnZjlsRWxJN0ZXL2JjU1YvZ3Fm?=
 =?iso-2022-jp?B?OHMwa0dnVEJ4bzExd2RFUTYxNjhnRllocmMrdUNxaUpqN3lCU1Ryai9s?=
 =?iso-2022-jp?B?c1F2ZElSWWVpbGlzZ2FqNFd4MjFYbksxU1R1OUMvYlVKT0U3LzNsMXE1?=
 =?iso-2022-jp?B?YlJGYmkwQkREaEUraGdrTGc5MG5RNE9pbTBsQ0cwMlNwNHpjUlYwY0w3?=
 =?iso-2022-jp?B?MzR0RndlWGJudTdQbDNGcFFlL2FOeFZrendYbXZGTERkbWtVaURrTnNY?=
 =?iso-2022-jp?B?WERpck5jdWtLd1I5V0JoZGFTM3JvNWdWa0dXKzlQTHQvSzJBaTYrKzNK?=
 =?iso-2022-jp?B?VTJZTzNmQ3hWZUNKcmVNZUNKWnY2ZTJPaTJEUHo1SE1Cb1NXbnYzVm5J?=
 =?iso-2022-jp?B?RWJmZkkyQnpra1MrSXlkbStzdS9DMVQ2RThtZml3a0ZPUEFPY05jb1pO?=
 =?iso-2022-jp?B?cVVUaHpsK0VrT0htL3lqQU1KTzRGRkdnYkMvQ2lhSW1IeC9KdU9rTFl1?=
 =?iso-2022-jp?B?TDJqZzdFVDVKVUNXdWkxcnlmaTRkL3pWWkQwTlR3VldUNTYvVDZ4TDk4?=
 =?iso-2022-jp?B?TXhONytqZEt4OWtXcmgyUFNsUDRGTTBkd2M5eXpuRDUyZmw5S2FNU1hC?=
 =?iso-2022-jp?B?VXgxZ2IydTd1M0tlRmEwVWdjMi9HaGxLOFh5M2JkQWxaQUFDREREMGxK?=
 =?iso-2022-jp?B?cDRIMXB5eHZvVEQ4RWoyb0ovYjk5TlRSd0V3MTA3ak9XWjk4OVBsWHcz?=
 =?iso-2022-jp?B?WS9zN0xhcHZhS1FmVERVc0RVSCt5dXNHRW44TmtNS0VrVVNQemwxYysz?=
 =?iso-2022-jp?B?aGg1U0N1RTRDTGNxRk0ydlhiWnI0cCtwakk5aWpNaURLdThidjRqNzZp?=
 =?iso-2022-jp?B?RE1LWjJ0Rkd6dkUrS3FyVnBHcE1oY1B0bEtGM09NYkRBMTFWYTFBWTNJ?=
 =?iso-2022-jp?B?cVNGVkNVeU5mTi93WkxBWmVJNC90bjJ3b1lWZDV4bW1FWDd4WWkyZ2N6?=
 =?iso-2022-jp?B?cGNROGZUNFI3dEZOcmhNVTJhK2pqc05LNWRoSGRCS3pXRkh2ZksrZDVO?=
 =?iso-2022-jp?B?M1VaQVRKWURUNXBRWTBlNGNPd242bUViRWhabm9MdWd4L2hMTEtrZDJ1?=
 =?iso-2022-jp?B?d0VTUWxLaDNXd2Z3TkdpMXZldzRibmMyRG1pUEdsT3N2aGJhN2VsbVc5?=
 =?iso-2022-jp?B?MjBpRi9nUnd3aGlITmxPZWFkRTROWWJIUzBjdz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WUPvYbsigdc41ghEYu2bG3Vyv0N2aRhgwy/1BRMhYhdkEhv5aQ9EkOryYoESNO0o9lL5/ZE3JvbvLf9EpBI+GvrRWZZbY4coT4mdwIFgRyyrrJl4YFvIDthoVhuGozZNfcyaRSk5FQ0D+YMNUnpai0BhMzIwFo+2nwRHfCZRDptKV3ky7cfR7NDyuzNK1FLf7DrzGDrffymhLNLW2gBloPtt95aIL6zlCSrv942aI+M7pAQM+PCFjGFHVSwMg05c4qVF6hVPNPTzwWPeXbj+puCr2tymgNStWKq3k/BGmxPLFkCWQwcza5gEfcL/0CvmqUo81r2+2LjhPzHLhncHyA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYXPR01MB15199.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7505e0f-88e5-4459-a613-08deeb895330
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 02:46:57.1519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdQe5+rdw1AowFdrDp2aOcxTvPqygR6C12RPAA3pjrOfp0GV48pbQ1n/MnvC57ewiDXTVGGna7E8iZ8UP1ofg3yf8t4iuaRz0q/hDaHm4Vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14158

Hi Karl,

Regarding Petr's comment [1] as well, I'm concerned about the potential imp=
act when the clk remains enabled during periods without console output.
When creating nbcon patch, I saw a similar patchh [2] from the past.
Have you considered coordinating with the clk subsystem implementation for =
this?

[1] https://lore.kernel.org/all/al4KdsU9YLOmwDoV@pathway.suse.cz/
[2] https://lore.kernel.org/all/1359475526-17523-1-git-send-email-walimisde=
v@gmail.com/

Thanks,
Toshiyuki Sato
