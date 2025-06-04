Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA762C324C;
	Wed,  4 Jun 2025 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749000205; cv=fail; b=Rss6QkvS7eAncehSjDvoiJ0twO9FMXd+77Xt0t/UKVUxACvH255zDekgJr0YVou7pANvtXSLJ9/k9bnDyttg5uSpDOJ3xGDgj3ORWmHzIYgtm/9OoccUcYxaF7hDbUvPIiJbicmYtbVYKuxX7Lmo1L5YS5F+IJfpamQ/xl860dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749000205; c=relaxed/simple;
	bh=ce1cPRIj1BlCIOthgUmNGHTT6kTIfLLqsfWj/Cb6eis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RULiVFhMSIazmhsKLKfMpLv+luudbc1dVSXpewpAFKsHqqza26UG7McOAdkqKJiEI95gcQeOsobFNfDhVFRVRZXQe8ITVvyBgz8P6B9HxwSNvGudF2hYRx0k1IkVXXnvMXwcd4szRlH2U9r0pz2XIPefVEiH/KBkd43kIEd2Oms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=r0cCIf/g; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="r0cCIf/g"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1749000203; x=1780536203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ce1cPRIj1BlCIOthgUmNGHTT6kTIfLLqsfWj/Cb6eis=;
  b=r0cCIf/g4I3vOtlcq80ElQO+W7AS8TIz4b0V9S8PPpy1NQLao5wCNFCh
   fODdRcPTAq6SqI69uc4SLr1t4IdiJEKOOkBjXUlnGcR20eUCC0ItGca+Y
   pg46s8IGRjOZ78btvZcmM7QSRHGtwctY4ZmEbyQIzv8wrgjtbDp/0XlQ9
   HkNzwFd9xMGjnv8Ma+QAxnMUSKZk3Uwao2PTQ9AXtUecP56US8HZ74U7o
   bBQ+4OgLW9ZX4uojV8Lt9xGnZxAR17iwxVd1Aun//ttkhDytBPkt2ion1
   xucVz1nB6vtVXEsNGy56GVzedf4bP/BXma58Dt4SHXq8Yh/mXHgEdnGt0
   w==;
X-CSE-ConnectionGUID: fDloVt6RS4ipfsS+0EalJA==
X-CSE-MsgGUID: OGZ/evuTQjKYxka/fK6J/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="157059182"
X-IronPort-AV: E=Sophos;i="6.16,207,1744038000"; 
   d="scan'208";a="157059182"
Received: from mail-japanwestazon11010012.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.12])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 10:22:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRoScgfdC4MqBLDiYb/kEsW7wjZDmYFFjTvywR8VW8mshNPvIX1zDdklN21TKYA5BTNvcF+S3I2rLdsj5RJ2A2QRVD7fiINh29JviIiEzLTT4lmomDot2myPFn6idAm5a+PcB2D1cyNO1AVW361d5bdJgSa7HsnKWXVlC45S+C/GeHqN1VhGQmAyFQOEFiz4GK9TgAHGrVwLtSbUP391pPgS1T8eO30VZId8YMOZlgeGwQXYz4XzRvcUgPmQT/osvsVSAuTZE3u1maecHlQhML2DTrWWJBn9DDeGZjG4FtnhBieQV/vBCr7JQSxD75+QePVxodqORMdkOb93lK+bUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5tPJ26E6W0AWU+fNuo24HaLnQwMrC4Oz7piAaws5aA=;
 b=PdgWtnf1WoUqKtkZqdCogwmR32FHO/xXXuEfyOVepQg9sAaA6Kb6YZDIEI4yXHfCxBj60Mf4rJXipYOx2fIQNkVaym/wgMYm3+xX/C1csA4Jzwm4frOcB+Hwnsmklzuo9CMpVTcK3wAvw0RkUOpC+MaMbLY7rxVpQim35wD6e1ENh3HmwKC5ZRHIdN2T0tm49pa5Vyx9rxACFMiXtl7wJUGzL6mE190YYNXBzmsmvLy5UxtN4aRrfcQZoUjtLfW648sQmOVqFJKhJCk+uAb5QazNsWAT5AVXRSpNiTZ2JLO63tNuYb2NNFEsvnUZw1YTUpnKgafIVltdNwXnqwAALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com (2603:1096:405:1f8::9)
 by OSZPR01MB7082.jpnprd01.prod.outlook.com (2603:1096:604:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 01:22:06 +0000
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc]) by TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc%7]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 01:22:06 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: 'John Ogness' <john.ogness@linutronix.de>
CC: 'Michael Kelley' <mhklinux@outlook.com>, "pmladek@suse.com"
	<pmladek@suse.com>, 'Ryo Takakura' <ryotkkr98@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
	<fj6611ie@fujitsu.com>
Subject: RE: Problem with nbcon console and amba-pl011 serial port
Thread-Topic: Problem with nbcon console and amba-pl011 serial port
Thread-Index: AdvULbS8DdGjT9TLS9OOSVhbv2AtDgAN1+gwAALFDgAAARcagAAYniHQ
Date: Wed, 4 Jun 2025 01:22:06 +0000
Message-ID:
 <TY4PR01MB13777DAC71E234B9E58CC6C0DD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References:
 <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de> <84sekh5cki.fsf@jogness.linutronix.de>
In-Reply-To: <84sekh5cki.fsf@jogness.linutronix.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=65f5f5ba-92cb-476b-a277-2f1e02816b7a;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-06-03T22:31:17Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13777:EE_|OSZPR01MB7082:EE_
x-ms-office365-filtering-correlation-id: 6100f152-928d-4441-9ede-08dda306383c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?VGtwNkNEaXUyZWRmaFV2QU50eXd6YkZKbDRVd1U4L21kanhCVjBNZUl2?=
 =?iso-2022-jp?B?UWZ4NUhHbmt4b1pqb3ZHU1QzZ3A0WlhMellFQkgyVnFKdU0xMnhCQ3pN?=
 =?iso-2022-jp?B?cDU3bXMyVjdDbUwvVEhwT05ZQkt1Njd6YzNnSTRFWlp5SmNOMmdoeXpB?=
 =?iso-2022-jp?B?SmFsWmVlL1JVL3QzRmJCV2ZrTVh4aDJwK2FUMmxKQXZrdkY5NWt0SlZq?=
 =?iso-2022-jp?B?UXpLZjZOT1Z5d2c4QlhXa3pMOFNwaE4wY3h1QUFTY1p2ZE01Uk1iZENx?=
 =?iso-2022-jp?B?R0pqT05LVWtsTUU3SWxzNTRsWW5XeWdySUJBMzY1NEk2ejdYbEtUWWhI?=
 =?iso-2022-jp?B?OU5uR1V5a3JtYm05NHUwUzFrTnRqTlJMRHBjODQ4djBnMWE1Qk1GLzlj?=
 =?iso-2022-jp?B?SDZVWTFQSHlGOE1aVkxFY245cWlpd0tIcEN1K2lvME9rZ0hXN1ZIalZY?=
 =?iso-2022-jp?B?cENIRENFaGNzOFQxQU9BamRVWjFRdXc1R2Vha3BNQS94T1BJS0pjTlJw?=
 =?iso-2022-jp?B?ZWhPSHFGbFJuTnBLckhaOGg1SkFVT3JnbFpZd3lKdVVaQnF1RTlMS2da?=
 =?iso-2022-jp?B?MWR2TlZRMjhlaWlYWEwwUW1uWXRKYk9xVTBINDdSR09xd3J5bXpZQSsr?=
 =?iso-2022-jp?B?RXVLSjZkOWx1dkdpMExEU3pzYWg1YkhqUWVNRll3akxmYnlZZWJvZDBq?=
 =?iso-2022-jp?B?WEdXWmswRCtmRzRmclF4ZmdpbER2Qzg4QXZhKzdwTFN4WWlVKzN4eVFw?=
 =?iso-2022-jp?B?YVZVTFJNZDBXeHJNUjA0Y29jUFlGSEt5QjIrM1ZLaHlEWWJXQ0hmQ0px?=
 =?iso-2022-jp?B?T0dZMXVIcTY4V3pvUmNpL1huc1NXYlZpNllhYWlKYWREd1k2TXl0MGNk?=
 =?iso-2022-jp?B?SUZSWFE1UFQydUlvczlTby9NdHluYXRSWEFFNWp5RU41MDd4MW5mUEpU?=
 =?iso-2022-jp?B?c2gxYnBJSXhjb1ZNU09XRHFpcWQvZktrcUdZSjJncTBDNk45R2x1T3J1?=
 =?iso-2022-jp?B?RzFIS0VuaVFxZFZzdURHM3FTZlBRc2NTMzRTemF0S2pNMlpVR2pJN3Ay?=
 =?iso-2022-jp?B?VGNkTURuaXNQaks1YTMvT3c4L05jUDZySStCTmdkcEpHaVA3UCt2Qkh1?=
 =?iso-2022-jp?B?QTVvMWNVWXZLRXNsMUs1ZkVHaDEyaFh4TDNQQnNKdXRyMGVpWE1JUVVm?=
 =?iso-2022-jp?B?K1RBdndrTld5Mi9RSnNJTzJ4b0hXMnJHNkpoUWxkTW9HcEdIdmxzcmlv?=
 =?iso-2022-jp?B?VlYzWjhSbEJxTE5Ra0NkV0NqOFhRSnl5VUFnNEMreGZQU0F0eXB5TUlY?=
 =?iso-2022-jp?B?TzVLL1l2ZGlOSWVaeU5PYU1Fc3NRTlZPZUpRY3NrbFZpK2o5ZVBCNW0z?=
 =?iso-2022-jp?B?V0ZWZkFFRHJEeVEzbWk4aUllQWovZGRPd010a3NibTg4UzlwL25HL3NH?=
 =?iso-2022-jp?B?V1drQVlwVTh5OWg0elhkaGJGblI5aXpVWTVSZk5NQ1pXU3J5cHRpaG5s?=
 =?iso-2022-jp?B?dExsWHZCRUZnUkNSbzBhR01QVEY5bVNZN0hOWUdFUmhaYktESVNSekZD?=
 =?iso-2022-jp?B?a1hUMjhpenZuMWxwUXRMRXg2V1FBNU5BZGZEVEZRdE5hanJIL21wdVFo?=
 =?iso-2022-jp?B?RWlhQTNEVUlqM2VXSzg0ckdadkJIYW1ncUJNZGwzQTI4M0ErcTMzSklY?=
 =?iso-2022-jp?B?ZkE3UHRLUHZibzBvOG5BWEpFVGtGMVd6MnZCaEQrb2UyZGFFNW5QVmxs?=
 =?iso-2022-jp?B?Y1ZjcjRGQUtmd010ckw4UUhqZkE5WW1RK01MY2owRDVsb0Y5TnlVeHBt?=
 =?iso-2022-jp?B?QjJhS25TeVFDYllpL2xrbHF6S1RLc3VGOGkxbkdDWUxLazc3WDU1S1ZR?=
 =?iso-2022-jp?B?UWc4c3ZCVDBLNUFwNG5yVXBWV0RzODFOY3AvbzE4cVdaQXdkWXpCL0tu?=
 =?iso-2022-jp?B?azA0TDR0STJudkEwbnVWOTlSZDZDaC9KN0FsMUNyTDF5bEtaQzZhNkJj?=
 =?iso-2022-jp?B?R0NCZ2drMUpHYjhJWUJRVTZDcUhPWnAyaXc1aUoySFVPM2lHeGp0Tkpu?=
 =?iso-2022-jp?B?cHZlTTRVa0VaZm1FSkdTSWluRGQwL2VIV00xNmZuZTQ5ZTc4YzRYdVp6?=
 =?iso-2022-jp?B?L0VyNHdTamluVVdkeGdicmpIMWJJQncvNDRGZlN3Qjhqa216QXlJbi9T?=
 =?iso-2022-jp?B?VHB2cXlQdkF6TGxYQVlvYkI0R2YzQmow?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?RU5GVFY3NTMvMTFoKzNyTDQ5UW81eG00OU5KRmc0STVSd0drbGhoTXdC?=
 =?iso-2022-jp?B?VmpkeWRxbXZZVUR1cjQxZm9ZTUZFRVhqanJFT1ZBWGxFWmYvb3psV1Fr?=
 =?iso-2022-jp?B?OWxVcGZrNUVBbHFtL3JpN0hYNlZmVjFYRjkrNzRnczdUNjNsOUZkYnl2?=
 =?iso-2022-jp?B?cnFhSk5vSndHNzlZYTVsOUJPTUdMeHl0NXQrNk9ZKzJOOHlYbUt2aURS?=
 =?iso-2022-jp?B?cDgxT3NieDVHZXhBdXZlOU81VTZ4RjNab2xqM3QvRVFQY1pTKzBEM20r?=
 =?iso-2022-jp?B?UUdwKy9vVHE3alRRSlY2cTBmanNpNkJLVG9XOWZpcG9zRTllbkdYN3Zy?=
 =?iso-2022-jp?B?ZzlPbml2WS9neERrSEY5em0vMjRFM2M5bTE3aTEvL0tsT2dVcmJQVkNF?=
 =?iso-2022-jp?B?MlorWU1wY2lSVHlHWmFqM2VHWHZla3FqaWd2ektndEh4YlFOYXJ4QUda?=
 =?iso-2022-jp?B?M3BBaEo2a1BvL0laUkhmR1BaTUdCZlU0U2JSQkJadkNwbmpoM3BnRTZu?=
 =?iso-2022-jp?B?WnhGdTdmZWI1eE9pSmlFUWtoWGE5ZHVJLzA1RjJHem9vZDJ6Z3R0SnV1?=
 =?iso-2022-jp?B?Vkdnd3RQamhrYUxRM3l4YXJGTTNrSEc1QnpLSW5XZ2NQejg2cnh1UnND?=
 =?iso-2022-jp?B?NUQ1Zndjc001ZHhnWUtZYU1qY1Q0WmRYRm93dDlTWFVxdGlxRFVkOTd1?=
 =?iso-2022-jp?B?WWhsbjQyanZOUTU4ZVZSTURnVkNqMmpvZy9kU3gvMEtRYlJIcU52NDd3?=
 =?iso-2022-jp?B?MVFSZXU0VlN0Z0N3ODdhZkxRRmJ5bTU3aGpuc0pULzYvYjZYTzdURE1r?=
 =?iso-2022-jp?B?dFRuNmE0RGZyZFplVlhmcnhwN3F4MTFQalV4N1YraVBsbFdyQWFsTVFr?=
 =?iso-2022-jp?B?RTYvZWd4bVhTNmhOTXBkbDM2Tk1TZEhtUHVPaThoNzFkMUtCTm1nUUZK?=
 =?iso-2022-jp?B?QitHL0NHKzFNVDd6L0h1c09WQzZqTW0yWXZ5U2tsS3JpeFY1ZjRuc3U4?=
 =?iso-2022-jp?B?Q1dRQnhxN0R5NzZDNWNUcERTOUhMam5MVFpoLzMrbzJ5ampRMVNiUSt6?=
 =?iso-2022-jp?B?NkY1Y1ZqK0FWOURLTlRucHFheFlOUWdLQWgvdmNFUThZL1ZRMXI1QnBG?=
 =?iso-2022-jp?B?MUdka0NkdEZiZXYzS0M4LzN5anB6QmtxeEh6a1ZJbmRHcFIrRXhpamor?=
 =?iso-2022-jp?B?MUpDMU1nRElPdHdZOXdlZXg0Z09xdi8zcWZIdjU5VmowTFBjQjBDYzgx?=
 =?iso-2022-jp?B?RThiS3ZIa2xUeVRtVXRTeHphKytybzZudlZ6K2txQWFucUNjZ1RidFg3?=
 =?iso-2022-jp?B?MjBJWThubjRORmUvam81VUhmekxnTVJNc200SG5wZU5LUkhCUDdiU3dS?=
 =?iso-2022-jp?B?ZHJuem0xNFI5bXpEOWRFVXFTOEVOSWdZUmtYeUlkRmoxRG93UGZ1VGI5?=
 =?iso-2022-jp?B?RFhUM1JzYVZGZXgvV1ZMeTZ2enpYQnpYbmcya21CQ0lLQXQ1cTNEMTYy?=
 =?iso-2022-jp?B?YkJhSERTUGxlL2pXNjNINjJsdTdsWWNOTTBEWkc2c1kxbkRFbVR4Q05v?=
 =?iso-2022-jp?B?NVB1b1lKMDVPUWVwY1Q5aEMxa3pSbE81Q2Z2YVVxemN0bDRlUUZUK2R2?=
 =?iso-2022-jp?B?THYzemkyODF2bnpaV05NalRvOWV6T2hocXZZWDNCZE5EQWhwczBoclJp?=
 =?iso-2022-jp?B?QUlpZG95WVcwVG9pQjVBMm5NWWJOR0pQOWh6aS9hMHBwYWovcU9GZXFV?=
 =?iso-2022-jp?B?NjkvWkhFTEQ4WmZ0RHFLVytwY3NqZUkxV3dEMmovMTRKSk53bnA1dnBZ?=
 =?iso-2022-jp?B?VzBKQWNObUovWkVUVVVaRy9VODFvSFg0bjcwSkRYbUx5MDUzZUdrOW9v?=
 =?iso-2022-jp?B?WXpHNm9aSVA1L3pIWmRnNVJMWWxEWk1KaVl4dWw2V3k2eFFUdFdWQ3o4?=
 =?iso-2022-jp?B?ZEk4eHNvWDZEUEFjdkllR0ZQNnVHM2JXTGZYUzh5WXBrMWlnQ2Uxcnh0?=
 =?iso-2022-jp?B?N0ptc0MzRXZNVkFodkhoU1BiTVZrWC85aHpKNUpRdkFJVFV1VlBpck5M?=
 =?iso-2022-jp?B?eklHcCtseHlIenZGYmpTNmI4MXd1UmMrUDM3V1MrcDNVNUJ5dnFFUHR4?=
 =?iso-2022-jp?B?WWNvZ0lVU1o3NGRRcW9oWVBNY0RWKzhhbWVvSjF4MXRjS2VPRlN1UC9k?=
 =?iso-2022-jp?B?MEwyQ2hwenlVaWx4Tkh1OVd6V0tnYUM2WU5ITDNtNC9Ha0Fjemw4aVRi?=
 =?iso-2022-jp?B?YVVUYWxvTzI2YW9JQnVYK25FZzhtdWNOTUtxU0pCWXFNSjFxWmdWYWpP?=
 =?iso-2022-jp?B?MktmeFRSbEI5TUdaUjZVOXViZklOOGRQMkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NBjdfOSzM1JtPWn0udLR4xiXT0JTdwLr7GmPWm4Kfps+6g2AdLh0ayv7+1mEFNrmgWW8UbGcqxrT30j1QlNiCYucrN0oXLlAQtBybxjMPIM94Y3RPsPcY7usgL0DbwKoDXFmW3C1ZlTRtI635c0+8QELFxZp4LBx7nRC62IntoItqOA2QoqMIUUNAprIf6eP/MRFkvyoSpWsbHs1aiZGYzb255ChESdDwWQEKftSxYneRj7y1GXqWQHEWvvrjSWEXRpIZVhUU5gXT57th/k4ybsuoiTYlSzVTSa65yP62CFcuW7RVyd86ubCezW5M7DqK6CzJVQF+f1N6noe/L73llabbm+CbiplVuvBuy8a7XLIvLLTukg6jMqib4zLE7njChBjKyoZxwIbPSPxM6p+9aG8aCfSO+OCUGJlKX/pCy5I7alQ101xyyoCVtL3Oh9cAlb9P2XGiiN0nRXjVg+CxzVyVXafAKCHWteRW5IppxGAdt7K7/TjwgXyy8JjX/y86Me3aUoW2e8Ao1pvrq56FyxBy+XnoCmibvEJJGlKwjON0EdCpEVDsvHDArP6mwfXvULVEStiytt44xeQnK7mQN2Lkf471+V5RIk6zyk2lYnGbKgrRhfbXa2eAe/fcMTH
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6100f152-928d-4441-9ede-08dda306383c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 01:22:06.4603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7teaY6JdXJ1V0vZ4M4zqPucne0le6062ee140gD14ZKRcANIynVbJMZW6Ka7ljDm6wzt2d1uEPiqhsfufDV2QnpB+9on+9ORJaYgK/jiic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7082

Hi John,

Thank you for your help with this issue.

> On 2025-06-03, Michael Kelley <mhklinux@outlook.com> wrote:
> > The problem is the failure to stop secondary CPU 2.  (The CPU # that fa=
ils
> > to stop varies from run-to-run.) It is mostly reproducible, but not alw=
ays. I
> > bisected to commit 2eb2608618ce ("serial: amba-pl011: Implement nbcon
> > console") in the 6.15 kernel.
>=20
> Unrelated to this particular report, I am looking at commit 2eb2608618ce
> ("serial: amba-pl011: Implement nbcon console") and I do not think it
> implements atomic printing correctly.
>=20
> pl011_console_write_atomic() assumes uap->clk is disabled when it is
> called. However, if it took over ownership from the printing kthread,
> the uap->clk is already enabled. And then after printing its line it
> disables uap->clk, even though the interrupted printing kthread expects
> uap->clk to still be enabled once it regains ownership.
>=20
> The atomic printing needs to track if the clock is enabled or disabled
> and act accordingly. I suppose something like this:
>=20
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 11d65097578cd..914449b46b95b 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2520,11 +2520,14 @@ pl011_console_write_atomic(struct console *co,
> struct nbcon_write_context *wctxt
>  {
>  	struct uart_amba_port *uap =3D amba_ports[co->index];
>  	unsigned int old_cr =3D 0;
> +	bool old_enabled;
>=20
>  	if (!nbcon_enter_unsafe(wctxt))
>  		return;
>=20
> -	clk_enable(uap->clk);
> +	old_enabled =3D __clk_is_enabled(uap->clk);
> +	if (!old_enabled)
> +		clk_enable(uap->clk);
>=20
>  	if (!uap->vendor->always_enabled) {
>  		old_cr =3D pl011_read(uap, REG_CR);
> @@ -2542,7 +2545,8 @@ pl011_console_write_atomic(struct console *co, stru=
ct
> nbcon_write_context *wctxt
>  	if (!uap->vendor->always_enabled)
>  		pl011_write(old_cr, uap, REG_CR);
>=20
> -	clk_disable(uap->clk);
> +	if (!old_enabled)
> +		clk_disable(uap->clk);
>=20
>  	nbcon_exit_unsafe(wctxt);
>  }
>=20
> I am guessing that it is allowed to use __clk_is_enabled() for this
> purpose. Otherwise it can be tracked as a bool in struct uart_amba_port.
>=20
> John Ogness

I believe the Common Clock Framework manages the enable count for clocks.
Specifically, uap->clk->core->enable_count is incremented by clk_enable
and decremented by clk_disable.
Wouldn't the clock remain enabled until enable_count reaches 0?

Regards,=20
Toshiyuki Sato

