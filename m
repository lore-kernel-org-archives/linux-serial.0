Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794585159;
	b=hwdfLro82r5znKIDxaGgbde8p71381EeNwztRi+Ll9XH48DGQmQUsZSE1UoIX2MxQZ59
	 iYfgRsXkBT/qfawYMqaAz2BDplTmU0kYh6NaHyCtp4VhXmOrZnz0OuHDjPQ4qWE4ZEPxn
	 3rg6LMHv8rnsq2s+DieuzM9fZUQg4VpCCmCF9oFzkCNQSgxK1sCN52zyCzrmiHsdjh3po
	 Qzjdglw/ItQxCyuSvnYCb2SloHiYFi7vk7Jnyht686EweSjh730WUbVKINwbhNdIQV7vJ
	 e5jmmT/AuSe/a1Z0ynqetBgM8lPvn8vz9m+LVzLe9a6ksiIxDZ4AQKjvAO1LvIaBddQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585159;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=vOXycpAaL4gid143q7K29D/n616E9o458miSn2hm6ug=;
	b=l4qEFHBGjG/3Iv4/l1en40qIuD3QK70ifXSzg3AygDocEDedwTK4YMNwywoOeje53Qov
	 QztaF5QScXlVU5LsMMSfqhNau/lwz4V7yzBwCle3crfyPjUeZCNKx8E8LnfrF2ngGLBWn
	 OeKqxWv1SjiVjNd04L4jWDAUOhl1jrcj2ox4sPUgc1YYECuFNLgpHBtutdBuRWDTFcX3U
	 yS01S5pmyH2OmatyUYUZSW6Jw4giwyEjmO7ztfnSSjtyn0q2rUC/o0uh4ZjSQBM5n+PDD
	 BX/iiT5NQKfBGMUyTzHSQ36e61GYQgfEJYikJAetKCmP+oGbNPpfUrs4Zq6/N8s1CpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=v22ecSWt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.52
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCEC606A8B7;
	Fri, 13 Nov 2026 15:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DCEC606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=v22ecSWt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQVXgvOIr9kGb5D8fdCL1VKlu0O1kHVZHwWeMgQZtpL8SPMMREZhd2O5JOGPjFyBlG0xRIPGLuTa8ONrrzOSaBZHThgUyOt9LMIvOoZ0qJy72QXpaUprrkR5tEzeY2CXqB0lqPhT7h8d6zNpHBmekn1Jmcgp0+/DdO4u0ktnL5pcw4LY68jqQbUiuRSWAvAZcZiDcDuELh9hl5ee6TLkEZ79z3G4YhSyo5Oo+kaMHnisU+imYS0+y/vLG/LWhrIdlUXD+wWz87qE/GBT4V2nQPzx7NWMO6HtbItbIVywPVkVWg0FGermBjvBB3xtm0hyh5mWmepueDbJ3LWkWKcwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOXycpAaL4gid143q7K29D/n616E9o458miSn2hm6ug=;
 b=cJl3/Oxyxh/AUt2yDeJ15L7fTgqEoIsh1bTF5yYasuui+d39YReoAajXKZmGVj1ZZZjoZ3nJsIU5rtjdFjqA52zioPzI6IeU/ptUYP5b3WH7j7U2PT0dIYXWNO4+KE2O0Vnw4uCoS4ZrW3n+fc3upT85yMr6k+beRTcSSkhOmSNW1HtFfZreZksBYV3BHzGSTepKu5uodSe5DK8W3oYxm/ORX2JFYDBj1Rz4nWM1d+A/0KAOziFhCsjwISUgQ9LRYO+K+NQjQvtJkGdfgONsBingZnd+5oYt6VnxLPUUXGZc1LPyxR7Ttd2pS18vBba+2GtP+GZmJHpqqM+SIa9XMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOXycpAaL4gid143q7K29D/n616E9o458miSn2hm6ug=;
 b=v22ecSWtQKpXb/wKYmd5GD+Ugo32bkNwHHLzYbL+w8zb2nw2byLTcw7kLtFJpQXh5GiOsPirGTc1ouf1lUsr6NtkhsEicW0BGKLTiI5xiLAGkOTDQmIbRuHJV8W8X2wwK2WLIN0v/xNoa2ELwMbX/5JMoO7Li7PpPadDrhW7PtczcXrr4svw7mctRcxvB771WIYpL+G5jx4w693+586FPg3KlzVBaFUcaPQRStkmGEOtsGnWeS6IA2Vym0zuSMiZJjUJJOpU6rElxXhSgEnNelMB6LmyoCz7uE98VHlFSLT5Ud2Bljv+QjTFTierPv9rfSmThMK1XQMznvRVzGfEuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by WA4PR04MB032753.eurprd04.prod.outlook.com (2603:10a6:1d0:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 15:52:35 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 15:52:35 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Date: Fri, 13 Nov 2026 23:55:23 +0800
Subject: [PATCH v3] tty: serial: lpuart: Add port lock for registers read
 in lpuart32_set_termios()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-lpuart_port_lock-v3-1-895c8758a9db@nxp.com>
X-B4-Tracking: v=1; b=H4sIAOoy92oC/32NwQrCMAxAf2X0bGXJ1ome/A8RqW3mirMt7SyTs
 X+320UPYg6BF3gvE4sUDEV2KCYWKJlonM1QbQqmOmlvxI3OzLDEBvLw3j9lGC7e5dU7decltDt
 N8loLkCxrPlBrxjV5OmfuTBxceK0fEizXP7EEHLjQVYVKAOmWjnb0W+UebEkl/Nbxh45ZJ9B7q
 Elg05QffZ7nN57QdRLtAAAA
X-Change-ID: 20261111-lpuart_port_lock-01f7deab451a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jingchang Lu <jingchang.lu@freescale.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, sherry.sun@nxp.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794585328; l=3931;
 i=sherry.sun@nxp.com; s=20260723; h=from:subject:message-id;
 bh=bHp1Z7/QxfQZnc5xrE2U/fm2EE5iiKj9kupH5iHvv6E=;
 b=6XW5ppr6E4kAYAndF7ROkOG1QYY4FVEPOY2sLnTisOq062B9gV1rCms16sPoKY4bU5DOVcV9B
 coU+72ekvsgAZ8LOGbCvja2iQo/zQIn+SGjhQPnIrT9lO0+fN4aV+qK
X-Developer-Key: i=sherry.sun@nxp.com; a=ed25519;
 pk=YnYnIFJ2l+5v951x9shBVfHhminNi+3LTfFa3PxSdnI=
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|WA4PR04MB032753:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e503f6-3e99-446e-cd48-08df419e224b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|19092799006|10067099003|11063799006|56012099006|261021123027099003|261028144727099003|261009223027099003|261026140227099003|261009221227099003|261021121427099003|261026121527099003|261102123227099003|261022105027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cWza5AFtbOmYNDHvC4+WfDFK5vqI3wUczoW3ZUcXDwpU+WRpWPWZA59pa/+RCyaWEz1FgmBWv+j42Kz1gDGFKanDDwbE9IwFzEKFQ5OkyaSZhwJhZOJ2ucLquqf+qduJ9mhbIpw8gSS+Cv7AL+bKxoAZ7ZayP2b0rgmSE4C8zkwyeGn49Ddl2SesZhNhp6NhvvHUNAm7PzqAhe0uIK0KtPxlDej4Pw38H9IEJloGc2FXxES5m2RCPZpUUxU6AFd07jw4TJfHRe14MDYhQQxegmUjifjji0pp9fjzlZ2ybJnKbqQUZ1C4vpJwdMsQ4aq3D4YF1eyd7H3VWADYnm1+0cxooqP2f2BdtBcG23XZ0N/tB5WjU3eqG5Txg6/Ns2CvzXhrdTfR+IE9+KrCXTma2J5X92F629JwA+rVIIv0VGw440LiMLuM9gWU+vCjAyzSEAT3kggCPN+R9EbmKEpnXrauOwAZ8X8OT3YyAb0hBSfgjMXuZFryWeDz4+3OVjQwvJutsjrS6LEM3daqafNdPZiPgLVoYwTInF3w2OWIdw2eAA2dovfewKHfdUT0Crf0jvHTgDIu3vnohMTe2Jy3s9D5RuMDdUMbMpsWDVFzwpN8HJVbklJkb+0A2l1zkm1U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(19092799006)(10067099003)(11063799006)(56012099006)(261021123027099003)(261028144727099003)(261009223027099003)(261026140227099003)(261009221227099003)(261021121427099003)(261026121527099003)(261102123227099003)(261022105027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTJPWWRYQXVneThWeFA4SUZKcGVmVjM2MXNQTURFNjE4QmxRU1ZqRVRnY3RU?=
 =?utf-8?B?SGcwZGlCVXFrSURhQ3kvYjRaeUo5UTNZT01Wa0xNTGVyaU01NTZWT0hkZS9j?=
 =?utf-8?B?Y2MwUlJpd1NCZGVDMk5oN0RXWVcyYU1PVERGRENoMGt6S0NaK3p2MVlDdEdG?=
 =?utf-8?B?RFd3KzlTcGxpczhYdnQ5aWxSYzR1d0s5ZTVuVWhoUlFoN2tJeDVtcHN5WFJr?=
 =?utf-8?B?SkRaMXV1c1ZIZ3RuL013UnFDUGxpWEpEd2ZvQUkwYkh5cGNRamNOL1E0S01v?=
 =?utf-8?B?T0lCS0VUaE04dTNubGpRa3Q3VmVINmxLd3J3K1A4bXhOeS9EMFBCaG54NGxQ?=
 =?utf-8?B?SmRDODh6ZnRwdnNzY0xFQkdrMU96TXhsbDJWZzJ5UjJiSmNIclFLNjRBck5M?=
 =?utf-8?B?M0xYNlROcm9xcFR0Tnc5MURDalh4cDB3Y0twRG9ieEJqUS9haUVaRm4vSU1v?=
 =?utf-8?B?a29qb3I1NU82cW03bVFpZE9jRWw1WDRGekx5NkZvMWdpVFBBVHpXMUlKVjVv?=
 =?utf-8?B?aklSdHhGdTZGNCtUU1IydlFDd21WQmVrQVYvak4yNVBnMitENjZ0Nk1NSmRZ?=
 =?utf-8?B?bEpxWkZXb2RMeDAwZmU1azA3TGZ2TTBIbzZlRUVkOWYzNWpqMXJCQlpUQXRL?=
 =?utf-8?B?Y3I0V2VETG1sdXNhNndCT1R1eUZDbkI2bkRybUw2NE5OemZXOUMwcW9oNXBW?=
 =?utf-8?B?UVB5c05tVkFHOGVzWmZjSlg3MjVvQnYxcFNjbjdOMUJmUjdldFdwQlVKMzRM?=
 =?utf-8?B?djNrNUFjWmxKclhFbVIrSFFqNVByWVhDa3RNZWp6b21ieXIxMXl1OGFKUnNR?=
 =?utf-8?B?MWJHZHdheGtCR1R2RUE1dEw3RkVnSUMrTWRqNWtlbzFWWDU5QVBoSVJWOVdI?=
 =?utf-8?B?K0tVZmFqYXZXT3ZoZlI3dFNnUUtVSFl4Y1h6RWw5K2NlaTV5OG4vY2JZQ2hh?=
 =?utf-8?B?b3BzSmhmTTJya2YzaitMZUJOczNRUmIrTzd2ZXpJQ0F5WFJ2aUd0SGxIdHhR?=
 =?utf-8?B?RmlZN1BxQXpHc2tzSmt4MVo5RXN1MlBLYnFpaGx4UkozOHNkZFpyZElNaWtQ?=
 =?utf-8?B?RnEvUnloU3laYWlMVmg1MXhyWTlYTGl1MVc2SFQwcVlNWFFucUwyYzJCMjRH?=
 =?utf-8?B?K0JaRTBLNndxc3p4TmZ6bm1QL2lyemQ4UlZlYkVoazdLRnNGa1ZrZ29hUDZx?=
 =?utf-8?B?S09KMVdwd1FvYnpkSFNGYmFLbXlrL1VPU0Z3amhkdHhaVnZNWmQ0cDBLRWln?=
 =?utf-8?B?ek1FNDBEc2x5Y0hGa09RaDlLc0tBYXh1SGpHcWNDbjVmNnBJNmpXc1IxMkc5?=
 =?utf-8?B?UnFUVk95b1NXcTJoWEhBTzd6UGRMUVRjRkRVRlVNb2JkNTkrd0xGVXNnOUNs?=
 =?utf-8?B?TWdKeFlZSEJHMG9NenRGVCs4SlZpN3FuTDdSc051YWVCTC90Y1FUVVpaKzg5?=
 =?utf-8?B?bGxXNVBWWFBwMmttYWJ2dmdKMkYwOUVTTlNJSUNRSDJ6YnpZTGZTUVZRblVB?=
 =?utf-8?B?dVdDY2ZHWXFpVXpGV0Y5QUJOaWp4RFpXZWsvU0RhaFdsdzZTVDZBc3BGVmo2?=
 =?utf-8?B?dlVKbGVaUDJnSjR6cHZNNmV6aWMvRy94eUphVTdLNzJ6KzZING1PM0V3R3Zj?=
 =?utf-8?B?WU03OEI1all6TnRYRXNabEwzUWpnQWRySmhTQzVmR3NDTTJtVThFUHNVQzFp?=
 =?utf-8?B?akRkMXROWTlKVUQyMnRDejFpQ1QvdEViQld0c3ZoVzduOEVlVUh3dnhiZzVR?=
 =?utf-8?B?anNuSXJqcHFkZS9wMVhFWDRoZExqVXhReWdhL0FkUU5TUkROMS81L3pxMWxD?=
 =?utf-8?B?SWdhRFAwWDFkdmNNUVRwdVZMYU9WTW1pVWNnRitxZk52SWxFaFBlM2tqeUth?=
 =?utf-8?B?QzYxVldWQXlQajErb3RRVm1SMFVqUWs1QXdBaDlzSDN5TEJpODJXUkU3R0s4?=
 =?utf-8?B?bUdVWWRNSzgyaUJYejVzSUo2YmtudkhXQUJKaGx4Rk9nc0d0S0trV2NXQ1Q4?=
 =?utf-8?B?eCs1K3dkOFp3U05jRkVWZ0tJSGJZb2IzR3F1NHpQdHYvRzdXN0psdWR5U01F?=
 =?utf-8?B?MGQyKzgwb0JnWG5RRTJwRkpoWHJJaGFodWlSb1lyNk42eklCLzhzYjJTaHhU?=
 =?utf-8?B?R1B5QUdYZ2grQ093Z0VUbXRrU1A1Z3EyWjZVK0NXVm9aWVppZU1mVTNuaEZV?=
 =?utf-8?B?MWtOeks3YUprN3FUMjF3ODRicFJLcGwvbThjaWNsZGFWaTBaNjIyb1hGQmNX?=
 =?utf-8?B?b3FRcTY2eGRTaDlQci8vRURIcTFvdG43dzE0ZkVlMzEyOGM2aWIySWI2WXZ3?=
 =?utf-8?B?d0gzVHhaekYrRTlFWEp5N05pdlNDeml1dE9nQVBHTEMrdU9kT2pIaDV0dnZt?=
 =?utf-8?Q?yJyxd6+9rlOj4YYWjd7r8q+UpgkKDVQzAx/I2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e503f6-3e99-446e-cd48-08df419e224b
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:52:35.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BouRCaIckZRV1CrNewaDdD2LehY6N50UqENcQ+ZHb7yI5r9DNksv2iGjfql1fhNMFJ8UEIwG9axmh76hsIkb7fvGaif8GG1evZFNBmtp9GlDQpMDK1MikW/SVADRmhbr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR04MB032753

From: Sherry Sun <sherry.sun@nxp.com>

lpuart32_set_termios() reads UARTCTRL at function entry without holding
the port lock. lpuart32_console_write() can run concurrently on another
CPU and temporarily clears the RIE (Receiver Interrupt Enable) bit while
it polls characters out. If the unlocked read in set_termios lands inside
that window, the stale snapshot is written back, permanently clearing
RIE. Once lost, no normal code path re-enables them, so the UART stops
receiving characters and becomes unresponsive.

Need to add port lock for the registers read in lpuart32_set_termios() to
avoid the unlocked snapshot captured. Since neither uart_get_baud_rate()
nor lpuart_dma_rx_free() uses ctrl, old_ctrl, bd, or modem, the register
reads and bit manipulations could be moved into the existing
uart_port_lock_irqsave() critical section after lpuart_dma_rx_free().

Please note that this only fix the normal printk path, in the
oops_in_progress path of lpuart32_console_write(), when trylock fails,
RIE is cleared and old_cr restored without the port lock held, there is
still a risk of stale snapshot, but it's acceptable for the post-oops
state and the trylock-fail window.

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in v3:
- Fix the typo s/acqur/acquir as Daniel suggested.
- Link to v2: https://lore.kernel.org/r/20261112-lpuart_port_lock-v2-1-e1d914e52660@nxp.com

Changes in v2:
- As suggested by Sashiko, since neither uart_get_baud_rate() nor
  lpuart_dma_rx_free() uses ctrl, old_ctrl, bd, or modem, move the
  register reads and bit manipulations into the existing
  uart_port_lock_irqsave() critical section after lpuart_dma_rx_free().
- Link to v1: https://lore.kernel.org/r/20261111-lpuart_port_lock-v1-1-5d332c51edfe@nxp.com
---
 drivers/tty/serial/fsl_lpuart.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index cd2575a3aef7..6e0da217c404 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2241,6 +2241,20 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 
+	/* ask the core to calculate the divisor */
+	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 4);
+
+	/*
+	 * Need to update the Ring buffer length according to the selected
+	 * baud rate and restart Rx DMA path.
+	 *
+	 * Since timer function acquires port->lock, need to stop before
+	 * acquiring same lock because otherwise timer_delete_sync() can deadlock.
+	 */
+	if (old && sport->lpuart_dma_rx_use)
+		lpuart_dma_rx_free(port);
+
+	uart_port_lock_irqsave(port, &flags);
 	ctrl = old_ctrl = lpuart32_read(port, UARTCTRL);
 	bd = lpuart32_read(port, UARTBAUD);
 	modem = lpuart32_read(port, UARTMODIR);
@@ -2320,21 +2334,6 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 		ctrl &= ~UARTCTRL_PE;
 	}
 
-	/* ask the core to calculate the divisor */
-	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 4);
-
-	/*
-	 * Need to update the Ring buffer length according to the selected
-	 * baud rate and restart Rx DMA path.
-	 *
-	 * Since timer function acqures port->lock, need to stop before
-	 * acquring same lock because otherwise timer_delete_sync() can deadlock.
-	 */
-	if (old && sport->lpuart_dma_rx_use)
-		lpuart_dma_rx_free(port);
-
-	uart_port_lock_irqsave(port, &flags);
-
 	port->read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
 		port->read_status_mask |= UARTSTAT_FE | UARTSTAT_PE;

---
base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
change-id: 20261111-lpuart_port_lock-01f7deab451a

Best regards,
-- 
Sherry Sun <sherry.sun@nxp.com>

