Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012000.outbound.protection.outlook.com [52.101.71.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CC91E104E;
	Tue, 11 Mar 2025 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674499; cv=fail; b=OowC6sitkGarqRDDcmuuGxiFEoNv1Chz3Eo0ti/3SNAXzDIxP+IICEHKCyw7VCQkKY2aVt4B0z8lG5kdC4botiJoLOT9YArJxl1l6YiZsV94uyZi+ZJ1Mocm4h1eBjJStxJqs3j2oCYS9Ds0ruVxw45NfCY/OfciEgQTjxUPc7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674499; c=relaxed/simple;
	bh=01yWB3ne73HU9/0VC1/XEnkEq3Y+Mp/27O9zknP/Fog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lHpwj5qe2JfES3s9QK7nswVBLN/EqQT9VhvqeRYOSxm8XNuaphBnmgDf8AYbTm935Bgrg1hGvg2cthcV7IH6vN6vSt47+5ukh3UV9QG7G56I/byJaCu9iBidmt6nOVSQUvvLW7V7zc5cYepcty1z5VTYXgbCjRw7yiKH89/9GQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oIg9ExtI; arc=fail smtp.client-ip=52.101.71.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oIg9ExtI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAjlTuthJZ/uhmoXKf68IXkVPitc3QKWJXWOF0xqvqxBpPRlnP8AbPIOm7KMTZSJxfxYtEg9M2p+mGjV4qtmev9kKyTYrlqjyzdtN2EKMmfKNV6yyzoLSKLsIQzqelVdhvhbAuLJDkHu1vplfZ2pO4Yc5Pj+jOIJyrEJlXVSfsb/Jq448o6qYCqqfJ32g3VSCtXtdCC8DA0a3X4x7KvKUaFXdti9MdoqW/9Af3UdRopgaYFXj8b+B/JUXQ9eC098wbJyXz6Gu9YRjfXAl5AS9Vbr3hKI4yX3IFO9hyOUEB6reqF4ldktorH8k5RVnvIKwVKPQqTE4QIBCCpHtaNZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01yWB3ne73HU9/0VC1/XEnkEq3Y+Mp/27O9zknP/Fog=;
 b=zSBIjQohkWuRreJnPwf4w5fODrmKuByTbaAQ8SiGRb9pG5mubCW/GPzK0QB/V1ejT/LRamtifzlcJJvNcq87Y0j2iF8ppBcXa6sTfYYO0np2Il8yKjXXHLpLfPe3wrkEaK+rJc5zAYwX9z1R6hxp5+fh2z9ZdZPA5BnnaemNvOVU4o2rSy2gJchmw74pLrN0LopuQYhFpFjvm2S0d9gAB0j4+exgUd1hnrES5FsYnZcN8dwkoROKKEHDoSKRilXl9k238rmpNH2aLbQ65Tl+9kuElo4eUPYYzbNEcij/8jaj/zqVrhYXBqngZBpfmKfdic5X/y8MtPabkP4hOcbOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01yWB3ne73HU9/0VC1/XEnkEq3Y+Mp/27O9zknP/Fog=;
 b=oIg9ExtI8OTooB08b2mtmIBg128W8U/lEo1e1oMOuOFcLoFH2wyjmwWHMjzYTSwq3GTbtmfWwFNTRtvvl8OUkKxK0NW28zGa38RxKQw1+ANrSn3ypGQ8m3M4SCpuakZqK1ul9Qhy+ZykAMCSvXZe5w7cSDPA7m++MH9SRVFt7iklhdKS4zmmRiQ1lknIAY1E3x8fIf3+xJiyJfYQsidtUu8cCovU8xKva8KlyRE6jDUaKvTctKl24/gE6yhCYfmTgRxZL/V7Cds4jnsEWWaaaKL6qGXGjnEV7pWVV0o47CgR+HJbVRJe7rcdLHLk3IKf15ZnvitPISs9RylprDp5Qw==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DU0PR04MB9275.eurprd04.prod.outlook.com (2603:10a6:10:356::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 06:28:13 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 06:28:13 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Jiri Slaby <jirislaby@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Shenwei Wang
	<shenwei.wang@nxp.com>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH V2] tty: serial: fsl_lpuart: disable transmitter before
 changing RS485 related registers
Thread-Topic: [PATCH V2] tty: serial: fsl_lpuart: disable transmitter before
 changing RS485 related registers
Thread-Index: AQHbkjEg36pvy2HlwkSEjhlU60A0SLNtS2wAgAAp7SA=
Date: Tue, 11 Mar 2025 06:28:13 +0000
Message-ID:
 <DB9PR04MB84291DECBCBAC10E5C65C58F92D12@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250311025550.1243569-1-sherry.sun@nxp.com>
 <be728f1f-b9bd-4d42-8ecb-9505d558543c@kernel.org>
In-Reply-To: <be728f1f-b9bd-4d42-8ecb-9505d558543c@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|DU0PR04MB9275:EE_
x-ms-office365-filtering-correlation-id: d4f01143-ff31-43ba-83b6-08dd6065e6db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWNJd25JL21Fc0plbkt2V2MwRU03MEZoMFVzT25oSXRXRWdVejFyWkd0MjNy?=
 =?utf-8?B?UklNanN5ZXJ0M0x2RGtxR2k1VE1XM2xqUmtpUHZwRGJieGF4aVQ5OVk2UHVT?=
 =?utf-8?B?RnlFUExMdmVxTkN6R0piU0M2dnd2YSt0UkZxOU1KR2ltZWlDekplOGdiRm9p?=
 =?utf-8?B?Yis5WXFWVVhiVlF4cXVBajFTa0xRRkpJLzJxWS9iZ3I1dWZaUGloL0Z3WldM?=
 =?utf-8?B?b1c2dnVzZC9aWUd4VDFCR1NnUXRuN0N0U1V5UC9uNEdJTHc3UkxuWVhLdFRB?=
 =?utf-8?B?RXlod3NOTXpvSTU2endsVzBYYWZ1WjB2L0ZMUzVLKzhqR1RZOUdXVGNrbjVm?=
 =?utf-8?B?TDI5b3NMS3NVSVltRmJLMzBCbnp3ZjcvT2FiSERZTnQ5TmRZOUdWSC9xMk9E?=
 =?utf-8?B?U3dqSUtFU0lwMUxQQmx0VHFxSVBhZEdQZXFyOUplWmE5ZllWaXhQOGN5VXBW?=
 =?utf-8?B?eXJBeVJtNGJia0dIN0FzWjlBeE5FY2VlcVlhNUlVYTJtaTY5aFVlejAzVFFU?=
 =?utf-8?B?Si9ZL1RNTis1bHh2MENIVWc4WCsvcWR0Yk1jU2NYbGJYVzlZQzJNODlhNGZP?=
 =?utf-8?B?cTNBQis5V0JScVhWWTN2UGVPUTBvbzdwVlZQdkJzTXRGeW9HdjlDMThtTytX?=
 =?utf-8?B?RjJWOElTVklCa3pUaUUyQU1nMTcydnZDek93N2pyV1Z3eTROS25PdklvMnRB?=
 =?utf-8?B?djNhUVVLWVd1dHVEKzFScllRaGVZelAxUnZnRVQ5VFp2MWw3YVBleDdXUTBm?=
 =?utf-8?B?V3puekFyY29DVHUwSVBXSE9OVXJoa044Q1ZTTnNrQVY4d0lBL3RERUtiVi9v?=
 =?utf-8?B?dWdQdy9XYXJzUXFZNkYzS2tFcndxd0VOZURXMTdrQVpKdlF2RHhYQWY4UGdz?=
 =?utf-8?B?UklidFBmeWtLd28yK1FYY0FxZU43elZQa3F2N3hnZFFwZnB1VE8wVFM0aE1q?=
 =?utf-8?B?YlorOTdCcGpUbWFqSm1sNmRyOXN4SmtwbE9OVUdXKzIxdHVNbEw1YWNDeFRZ?=
 =?utf-8?B?b3FNb1N6S05vdm1IYUM5bysrNm1oR2hIQ2dCNWd0Z25DMDdrSWtkUVRDVUU1?=
 =?utf-8?B?WnFzTzR3Z2U1ZVVRaDQrRnJZbVJTSnVGTHVMTUthSk9qVzZTZjBHMkc2dFUy?=
 =?utf-8?B?K2MxRFNORXRIQWYrM2pabWFETmdZcGs4MWE3cWhNbmJVV1hCRlBrWTJQNHlR?=
 =?utf-8?B?TG54eHcvVXVUWWI4WEdoSXRVc0VjZ3UyTDZvekxHN2dPdTdMQU04TXY1MW5X?=
 =?utf-8?B?NndHWlJ5VW5MSjB6UGV0eHo3VUt1TjJDbkZGU2MrT0xOL1hiTFJ4RGowVktO?=
 =?utf-8?B?TXR5MXEyUzZKQ0ZCYVlLTG1MM1Mwa0pqYnFqQkM3QmQ4N2FXcEdLMFEwSU0z?=
 =?utf-8?B?TDZKY1hmL3N3LzJ0WWxGTVVuS2pDZmxJRCtaK2NSb3p2aWRRdHdTUVF4ejlI?=
 =?utf-8?B?Q1gyWkVBZ2I0bW0zTEJKN1dSVE9PR09wa1A0cGVqd1RaZHZSUHU2c3JGbnhW?=
 =?utf-8?B?TGUvWk5QVTNOOGJ1UTlxN3I4VzVCQXcwWWJxQm5SNENPR2dkSnV6QlNzQk51?=
 =?utf-8?B?b2JZT0NmTm9GelNDSkQ5OTV5Y3hNUTNzQkJhQkx3ZVVxQmdvNWNhU0I1M3pz?=
 =?utf-8?B?RFUrbVlmYy9mUmxzMnJUNGNTd3N5c3M3K3dDOW5Ic3BVT3Fnc21zTnJaOG1N?=
 =?utf-8?B?NUpNVkYzMDNWU1NOTXlrbnZwR2U4WDJ0Uk9lTkEzK2w3ZXlmdEJhVWhwbDRU?=
 =?utf-8?B?MjFreHFhRHhwSitsRW84aTFERTM2bTdZQWgrNWwyYVVpR2p1V05MdlNPWmtU?=
 =?utf-8?B?TGhhZVo1cTZtV1BNT2ZjSi9vZVMxQWJEdFhxWjZCUmM5VzlWU0xVV0hoM1ZN?=
 =?utf-8?B?R3RWN3V5VlV0RVpWNXE5NWJTVUhYVE1VeWRBcWI1RVltMUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUcxNVo3UmRvb2QxWWZ0OHNqV05MTnpNSGI0aXNmaUpYNktHR2MzV202dHNE?=
 =?utf-8?B?NTNDSlFoTWVaZWc5aGVCYWx5cWtyZnlra1ZRMEkrWjc5L0R1WmtsK3NjVVlR?=
 =?utf-8?B?a3JNV0JlTUlOOUdZQUZWNTdwYk94S1htYmFYWFVJZXJzc3F0Q0dkMVRBZ2FX?=
 =?utf-8?B?Zk43Q255TngwWWFWL00zQXJwdnhuQUV3cnlxODI1bmNQNERKWHlkcDhyRnBH?=
 =?utf-8?B?VGRYMVQwQ212NTZoMVpqMGM4NnBXTC92Yy9EMllERHVYRFdDUXZVQkQxU1Fo?=
 =?utf-8?B?TmVyYXJhWnptblQxRko5Q1d0d29FcVFTU0d2VVBvWEFjMDVtVExlYnVNNzg1?=
 =?utf-8?B?VjAwckRTcTR0cjlxc3BwZmNaMnlkUFllUFU0ZndQY01ST2cyZ1FmeVJmVWtN?=
 =?utf-8?B?WVBod090aEJJcERRYklNbEFyZXRuVnBBaXFXQUE5SWhuU3dIN1M1MXh2MEpR?=
 =?utf-8?B?YnZWQkVwNldZL2RnSjQ4WmUzekxXbzh1ZEFHMkFwcE5JMXRYdDFaOEY5eGc1?=
 =?utf-8?B?K1k0RSt5cmFJZXIrVnYwV0dmaFMzVDVuaU10TkFuN2hwUVpKOHpFRjV0UW5F?=
 =?utf-8?B?SjIxcVJGTUExRGljZmhPYnl3ZmoxQ05BektQaVRxYlk3cXNLdFJCb2QvSjIz?=
 =?utf-8?B?blcwYlRCMktYbmNudG9WVXJhb2xvT2lHK2FGNFBvUzRIbCs4ekxtTTJtaGtG?=
 =?utf-8?B?c0Qrd1lNNE1PZ0RqWU0zVVUrZ2xOenhoK0hOVmVjYU9pYldBdXF6Myt3VW1n?=
 =?utf-8?B?RXA2K04rT0FIb1VCMjEzbUFJWnVXWXV0RWFrOHFXTmdRQ1NOLy9uZy91dE1U?=
 =?utf-8?B?cDhIYWsyRXBKMVgwYzRGeW02SW9xeGtSNUFEMCtubFpvcGdFU3dtQS8yMXAx?=
 =?utf-8?B?QSs4M0pjOU1FK1NLOWFxcDQwTHd1MDYyczdqa0ZzWjBXZHVCN2xHK2lScXBE?=
 =?utf-8?B?Szd1cVB0b0x4dHA1Tm52eUIwQ1hieGM1RVdEV0lnNUhwTlVhU3o4emtUajFP?=
 =?utf-8?B?VHZiQ3NGZnN6UStMMy9TcEgvcFR1T3BsV0U0bVZLQXBiZ2VPdDEyYUMrc1BS?=
 =?utf-8?B?R2FkaU9mRVVWeHM0SC9MMjJBWmd6MHNjeHdsQWQ5MHNFcWJXQlRtVzdGTWFU?=
 =?utf-8?B?b2wrU0phc09GQTNGcWpIbk9FNzl1dHNpSGQwUlRDd0w2MWdIZU9sRlRtaHZP?=
 =?utf-8?B?cmgwd291bkl0RHBGVzkrREpFYndiMTFHVXlhS0VqTURyVXdhT3VoT3h6aXVQ?=
 =?utf-8?B?VVJLaGdMLzd2bWEydmwzeHcvbjRzNS81Qk1GNm1ET3RsVENrMjRCb0duc09x?=
 =?utf-8?B?aHRGWXRxZmx2a29wMmJoMHBJVURkUWNsajFqOHFKditMbVA0ZUJYUkRHUzFl?=
 =?utf-8?B?Qytwa0hWUXJBWDZrekJGM3ZWVWNlajZtVHpqakREWHQ0VDNDdWRuK3JJVWxM?=
 =?utf-8?B?QTNvNUlnUmZCRTRlWDNQVFdGdzc0U1hMWElIa0JmSnlCY3NWQ3RTZE9jc3BO?=
 =?utf-8?B?RjNkMCtvaUxJQlkySmZPd0lSK2tJeVNocmowbmlhSHhHV2NROEUzVlNzYkdU?=
 =?utf-8?B?REl3V2FRYVJKQjdFN1VQVno5SjVieE1FVjBTMGwrYVVjeUdwU0VCc3QzSWVl?=
 =?utf-8?B?cGF3aWEyYklTWEZRQURYUjZNT25sSCtaaEJ5b2lCUmlYelVFZFlmbnNUREpP?=
 =?utf-8?B?UGY0Nnd6S1FwZXlvOTBUc1hvbUJ1V3ZhNnNtT0dteUNSdlpOcC9iYVpMNk5M?=
 =?utf-8?B?WFAyS242aDJjNVFPczh2ZUJzQVFZMWp4VnNTZlhYVUQxeHVYcmxHOWV5V09I?=
 =?utf-8?B?VnBLc25SY0NidllISzJIUWFCZVB4WFFRU0VrSlc0VDdqVy9uKzZRd2E1Mmxa?=
 =?utf-8?B?bFZnbjRmN0hZQU5nbWp4VHBPT2xsaithK3hHdnROTkJ4Smk5Q3BzQnV2endM?=
 =?utf-8?B?bC9yUHdOWTd5VkJnMEdRYXVKOEo0T1hzVEFpY200cGVGNkFsaEw5WnVacW5W?=
 =?utf-8?B?MjN5RlJvakphT2J2UW14MW0xYzlOZUR4OVUxa05icDFvVEVOOENxUHc3dUxq?=
 =?utf-8?B?aDdqVGFOMnh3Vi9pemQ5eGg1ZnpLTDIwN1NDV3ZpaFNVcVBHTDlwWDl3cHgv?=
 =?utf-8?Q?AIhM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f01143-ff31-43ba-83b6-08dd6065e6db
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 06:28:13.7554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6CHrWcNUloJ7bd0+nSMec/6CNyj8QECiC3m/L54NjA4535cfxkd4e2t88i7QusQOnGzFkLf542BCnBC+/InpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9275

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlyaSBTbGFieSA8amly
aXNsYWJ5QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDExLCAyMDI1IDExOjQ1
IEFNDQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+OyBncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZw0KPiBDYzogbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgU2hlbndlaSBX
YW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT47IEZyYW5rIExpDQo+IDxmcmFuay5saUBueHAuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSB0dHk6IHNlcmlhbDogZnNsX2xwdWFydDogZGlz
YWJsZSB0cmFuc21pdHRlciBiZWZvcmUNCj4gY2hhbmdpbmcgUlM0ODUgcmVsYXRlZCByZWdpc3Rl
cnMNCj4gDQo+IE9uIDExLiAwMy4gMjUsIDM6NTUsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gQWNj
b3JkaW5nIHRvIHRoZSBMUFVBUlQgcmVmZXJlbmNlIG1hbnVhbCwgVFhSVFNFIGFuZCBUWFJUU1BP
TCBvZg0KPiBNT0RJUg0KPiA+IHJlZ2lzdGVyIG9ubHkgY2FuIGJlIGNoYW5nZWQgd2hlbiB0aGUg
dHJhbnNtaXR0ZXIgaXMgZGlzYWJsZWQuDQo+ID4gU28gZGlzYWJsZSB0aGUgdHJhbnNtaXR0ZXIg
YmVmb3JlIGNoYW5naW5nIFJTNDg1IHJlbGF0ZWQgcmVnaXN0ZXJzIGFuZA0KPiA+IHJlLWVuYWJs
ZSBpdCBhZnRlciB0aGUgY2hhbmdlIGlzIGRvbmUuDQo+ID4NCj4gPiBGaXhlczogNjdiMDE4Mzc4
NjFjICgidHR5OiBzZXJpYWw6IGxwdWFydDogQWRkIFJTNDg1IHN1cHBvcnQgZm9yDQo+ID4gMzIt
Yml0IHVhcnQgZmxhdm91ciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5
LnN1bkBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIFYyOg0KPiA+IDEuIEFkZCBURSBiaXQgcG9sbGlu
ZyByZWFkIHRvIGVuc3VyZSBURSBpcyByZWFsbHkgYmVjb21lIDAgYmVmb3JlIHByb2NlZWRpbmcu
DQo+ID4gMi4gQWRkIFJldmlld2VkLWJ5IHRhZy4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvdHR5
L3NlcmlhbC9mc2xfbHB1YXJ0LmMgfCAxNyArKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gYi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xw
dWFydC5jIGluZGV4IDkxZDAyYzU1YzQ3MC4uNmIyZjNhNzNhMzY3DQo+ID4gMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
dHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gPiBAQCAtMTQ4NCw2ICsxNDg0LDE5IEBAIHN0YXRp
YyBpbnQgbHB1YXJ0MzJfY29uZmlnX3JzNDg1KHN0cnVjdA0KPiA+IHVhcnRfcG9ydCAqcG9ydCwg
c3RydWN0IGt0ZXJtaW9zICp0ZXJtaW8NCj4gPg0KPiA+ICAgCXVuc2lnbmVkIGxvbmcgbW9kZW0g
PSBscHVhcnQzMl9yZWFkKCZzcG9ydC0+cG9ydCwgVUFSVE1PRElSKQ0KPiA+ICAgCQkJCSYgfihV
QVJUTU9ESVJfVFhSVFNQT0wgfA0KPiBVQVJUTU9ESVJfVFhSVFNFKTsNCj4gDQo+IFRoaXMgaXMg
dW5yZWxhdGVkLCBidXQgd2h5IGlzIHRoZSBhYm92ZSB1bG9uZz8NCg0KSGkgSmlyaSwgdGhlIGZv
bGxvd2luZyBscHVhcnQgY2xlYW51cCBwYXRjaCB3aWxsIGNoYW5nZSBhbGwgdGhlICJ1bnNpZ25l
ZCBsb25nIg0KdHlwZSB0byB0aGUgY29ycmVjdCB1MzIuDQoNCj4gDQo+ID4gKwl1MzIgY3RybDsN
Cj4gPiArDQo+ID4gKwkvKiBUWFJUU0UgYW5kIFRYUlRTUE9MIG9ubHkgY2FuIGJlIGNoYW5nZWQg
d2hlbiB0cmFuc21pdHRlciBpcw0KPiBkaXNhYmxlZC4gKi8NCj4gPiArCWN0cmwgPSBscHVhcnQz
Ml9yZWFkKCZzcG9ydC0+cG9ydCwgVUFSVENUUkwpOw0KPiA+ICsJaWYgKGN0cmwgJiBVQVJUQ1RS
TF9URSkgew0KPiA+ICsJCS8qIHdhaXQgdHJhbnNtaXQgZW5naW4gY29tcGxldGUgKi8NCj4gDQo+
IHdhaXQgZm9yIHRoZSB0cmFuc21pdCBlbmdpbmUgdG8gY29tcGxldGUNCg0KVGhhbmtzLCB3aWxs
IGZpeC4NCg0KPiANCj4gPiArCQlscHVhcnQzMl93YWl0X2JpdF9zZXQoJnNwb3J0LT5wb3J0LCBV
QVJUU1RBVCwNCj4gVUFSVFNUQVRfVEMpOw0KPiANCj4gQm90aCB0aGlzIF5eIGFuZDoNCj4gDQo+
ID4gKwkJbHB1YXJ0MzJfd3JpdGUoJnNwb3J0LT5wb3J0LCBjdHJsICYgflVBUlRDVFJMX1RFLA0K
PiBVQVJUQ1RSTCk7DQo+ID4gKw0KPiA+ICsJCXdoaWxlIChscHVhcnQzMl9yZWFkKCZzcG9ydC0+
cG9ydCwgVUFSVENUUkwpICYNCj4gVUFSVENUUkxfVEUpDQo+ID4gKwkJCWNwdV9yZWxheCgpOw0K
PiANCj4gdGhpcyBeXiBhcmUgdW5ib3VuZCBsb29wcyBpbiBjYXNlIHRoZSBoYXJkd2FyZSBnZXRz
IG1hZCA6KC4NCj4gDQo+IEFueXdheSwgSUlVQywgYWZ0ZXIgdGhlIFRFIGNsZWFyIGZyb20gQ1RS
TCBieSB0aGUgYWJvdmUgd3JpdGUsIHRoZSBURSBiaXQgaXMNCj4gcmVhbGx5IGNsZWFyZWQgYnkg
dGhlIEhXIGZyb20gQ1RSTCBvbmx5IGFmdGVyIGl0IGlzIHJlYWxseSBkaXNhYmxlZCwgc28gaGFz
IHRvIGJlDQo+IGNoZWNrZWQ/DQo+IA0KPiA+ICsJfQ0KPiA+ICsNCg0KRGVzY3JpcHRpb24gb2Yg
VEUgYml0IGluIExQVUFSVCBSTTogIkFmdGVyIHRoaXMgZmllbGQgYmVjb21lcyAwLCB0aGUgZmll
bGQgcmVhZHMgMSB1bnRpbA0KdGhlIHRyYW5zbWl0dGVyIGhhcyBjb21wbGV0ZWQgdGhlIGN1cnJl
bnQgY2hhcmFjdGVyIGFuZCB0aGUgVFhEIHBpbiBpcyB0cmlzdGF0ZWQiLg0KDQpJIGFsc28gdHJp
ZWQgdG8gcmVhZCBiYWNrIHRoZSBURSBiaXQgcmlnaHQgYWZ0ZXIgd3JpdGUgMCwgYWN0dWFsbHkg
aXQgZGlkbid0IGJlY29tZSAwDQppbW1lZGlhdGVseSwgc28gSSBhZGRlZCB0aGUgcG9sbGluZyBy
ZWFkIGhlcmUuDQpZb3UgY2FuIGNoZWNrIHRoZSBkaXNjdXNzaW9uIGJldHdlZW4gU2hlbndlaSBh
bmQgbWUgZm9yIG1vcmUgZGV0YWlscy4gVGhhbmtzIQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
aW14LzIwMjUwMzA3MDIxOTUwLjEwMDAyMjEtMS1zaGVycnkuc3VuQG54cC5jb20vVC8jbTE0MDk4
MDU4YjA4MzMzMzIxM2JkNzQ0MTQwOTVhYTFlZjMyOTk3ODANCg0KQmVzdCBSZWdhcmRzDQpTaGVy
cnkNCg0K
