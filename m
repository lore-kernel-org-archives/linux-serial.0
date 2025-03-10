Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073911AF0BB;
	Mon, 10 Mar 2025 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573494; cv=fail; b=YOcqlqPclTZDUQ/j3Ju3iYvqspAlcBflD95DYAgFC/6L9YrbXE+1SwQ4oQsLyYrJMghdnfI8T1w5koTNnE/j/u1zv+plZffgl3QtBmuwBTFlOHwoo/Yp2zijGQiln3kUMByJmCMWMXKwaBWMiIIp+BVESVRSR2IeGbm/IuJ1KhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573494; c=relaxed/simple;
	bh=TmIDfBBFhN3wy25iLYI8/hTYl0rWDUiV4/hT6bi/1FM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pfbt4Fi16CEqVqFG6LjdFMO8zMSs5AdOjQ8d0BTxRvPNfvNy6Og1DdgYCnnagspYKdVaboNzcONgoH8owsdF59nJ7S2FmnLHMFsski3UhA5kml4FV2tSiVMVmn1QnK53EAd55VMs1es7u/yTZKHio2P7AIYOqtYZn2l4stiw7D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aZPCD5bZ; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aZPCD5bZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741573492; x=1773109492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TmIDfBBFhN3wy25iLYI8/hTYl0rWDUiV4/hT6bi/1FM=;
  b=aZPCD5bZsLUYcDQF0e98iHU/eMU+HXFm7/UXGXIRVo/d4frQOxxGT+/e
   xyx0en9K0d9378okIsiCL5HHyYuBSr+/gP/IEXx4/gKOnpQ9kouIr/S4k
   dEGDZp7SUGzRJu9nz8AmqfKDIUEca5WkETyx9qTLE0C2Fbe+P1p0KveG+
   g2R/UZoR2Fnz5B1HZGGAmLi8KeO9YYj5V3PZ+iUf0FA8K258QP5b9LM+9
   qT/OVh59rH5JEhzApVo/rxbuMVyEHtkqdlYDfjGFhgvJJDQ3miX0Qsml1
   ZlqsrXT30EtgqGx6w2mdJSVlFnxcCos2F+mN7q6S04sHXqwHt3/H8RoJ3
   g==;
X-CSE-ConnectionGUID: MagsAb8aRMWBCVsuvbuWWQ==
X-CSE-MsgGUID: ckVN79JuTaCGwbaDxr8Izg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="60105323"
X-IronPort-AV: E=Sophos;i="6.14,235,1736780400"; 
   d="scan'208";a="60105323"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 11:23:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPWbcNlO1XDgcNcTT1w5uoFiaSQoSmPqlpU3FZB+mxOPTDXByNGd80lsh7HA8jR9aD2d2SxGRyy/lFFq8qx5NwUEYEkqgNEhEfyRUGvvnBjdMG43hARuwiBUUX/92WxIvHLmY4M/j47Hd5Y1T6wldVTr3Ew+EzHMe50/9UuV+zVRqz1aK8s+w0cWEncuhqgDUf7OoljI9EfJn04i40Iw/jRrj39ULtzRM+0+P9nyiqw17JDa0iORy3t4FQMIg9qJj/o/kZ1s3OSZYUiCj+jkSVWq7us3X9h4tpQ9z802e2pFJsnZGoVOojGcGX6e2hEOt1MqMbDBPtGq3aI73Joi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r85RpC16ME+O4A8wcEdwzdFUzVEFKSA7bqTW9EpE/lw=;
 b=nREWLgRGIGFsP2xHIdhHEE/HgTG4Vw3n2PDZ6vGZlWyPRuqmcEE+Tllpor/43VrbmM84pQEWpnQs51PiKZ4kc6USw1TPpA3eu98+T1/7Zm/pwDK8l2MpTlXYg2bqgDITpy5GmbKzujgeo/vryuK8XC4VlkSF6liOkUwB6Jq3bYmMrHMkaKBiOYhzrJ4XZddxX2eFoiObDFqZqEpSlvvHt5cH3AxS32mj+Ki5ca44b7YvjFVF1F2qDa99Hc1j+Uq8xqR/2br2g6MWDSjBZMLf+4L0V/i/PVV6EhVZiRpiOW05uuP1HRzbn9IRUy7JvBlvaNp6nRwBqhwX6HM9h/PpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com (2603:1096:405:1f8::9)
 by TYCPR01MB8804.jpnprd01.prod.outlook.com (2603:1096:400:18d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 02:23:36 +0000
Received: from TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc]) by TY4PR01MB13777.jpnprd01.prod.outlook.com
 ([fe80::60b7:270b:27c7:4fcc%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 02:23:35 +0000
From: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>
To: Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Toshiyuki Sato (Fujitsu)"
	<fj6611ie@fujitsu.com>
Subject: RE: [PATCH v3] serial: amba-pl011: Implement nbcon console
Thread-Topic: [PATCH v3] serial: amba-pl011: Implement nbcon console
Thread-Index: AQHbdr+P/ilVjo1KfU2BeYco8MFTb7Nr171Q
Date: Mon, 10 Mar 2025 02:23:35 +0000
Message-ID:
 <TY4PR01MB13777DB55F2231F7399E42609D7D62@TY4PR01MB13777.jpnprd01.prod.outlook.com>
References: <20250204044428.2191983-1-fj6611ie@aa.jp.fujitsu.com>
In-Reply-To: <20250204044428.2191983-1-fj6611ie@aa.jp.fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=c97c3413-873c-413f-8be4-6cd03599a34f;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-03-10T02:20:12Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY4PR01MB13777:EE_|TYCPR01MB8804:EE_
x-ms-office365-filtering-correlation-id: b77505a3-c053-494b-1fd1-08dd5f7a8f80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?VVVwU0VqMUNCYU5FOGxpclNjT0pvZVYwUFJsbENOa1piaFZ3TUFYeUQ5?=
 =?iso-2022-jp?B?MTZjemt2RFRtSFRrMngvek4rSVJ1MFhBcEkrL2QzU0R4ZXdNalIvTmxB?=
 =?iso-2022-jp?B?Lzc2dHdRQ3ZqalFQTWh3RGZoYkNSMy9HYzFIOTRnMHdxcHkvZHBZbkx4?=
 =?iso-2022-jp?B?TmVSWUljcWJON01MSXBKbG95eUd0WUk4S2REc3g0dGgzNFAzbHBTS0R1?=
 =?iso-2022-jp?B?d0V1Wk53T1NhTUE2bGZ6czBMd2lLREtuQ010M3pXejdhOWlOQjdVT0hp?=
 =?iso-2022-jp?B?YkREMERZcXlER2tSOE1ubVgvY2xYZHhRdkRmYnJpZURDK055MmpzZEta?=
 =?iso-2022-jp?B?K1BPNmN1eUJEbVZIeHFnSm1Tbjc0cFg3M2w3T2lzQkpGNlhNOExoNVBG?=
 =?iso-2022-jp?B?cGZqVUMwQVY2ZURzU1RPSFg0OXovZ2p5QmR4VWJUVXlnWlNWMVVEMUNL?=
 =?iso-2022-jp?B?UUFOSzNTR2VCNjA2dDA5anozQlpHZzArVVpjRG9aU3p2VVFCektNN0Ny?=
 =?iso-2022-jp?B?dnNUa243NXlxVDJHbmlibUxTV3BqbGVyWjRUUit0cjdxV1RnRmJCNHR4?=
 =?iso-2022-jp?B?QlFjWHVYVmVJTEdDb3JRckdXdjZCU29qWjMvQzlWTU9oclpUSjlvOXo3?=
 =?iso-2022-jp?B?akdtaVhEZE1kNXlRSGZmcjIvUFpyalk2ZE5IcUVNL1d2VHc4WVpaMFly?=
 =?iso-2022-jp?B?WGcxMnZoaWtqSGxZTnAvVXVFNDV1U1hLU21aQ2RTR3ZmSCs3UTB2cWRU?=
 =?iso-2022-jp?B?YnpRb1RTMEZDaDlDVUxBYW5iRURHV2hucmlLK2hJRmNLMGlKbVRTeTdN?=
 =?iso-2022-jp?B?WGhLM2NDYlY1RWFlTERWdkdzN0VYWEllK0E1ZkZ0Yk5sOGxFVnNMam9u?=
 =?iso-2022-jp?B?WmFteklrRGNOcENvT1h0VWFwVmsrQ2k5UE45Q01XeDhJYXJoQTBiYzdN?=
 =?iso-2022-jp?B?YVJJU3FmVENPWlFJMmZLR01GczVKUXNRZ2VuQWJEc295SjIzaVgwRy8w?=
 =?iso-2022-jp?B?NEVaUHEwTU9Gd3FXODJuKzdmTldGMHp6RVdoZGFpY2FLNWJ2Vmw3QmZS?=
 =?iso-2022-jp?B?UVFvZUt4akIzcVVna3FJWElvYkZPTkEwM2Zua3VtZjZwL0xsS1FyWGMy?=
 =?iso-2022-jp?B?QTE5SEZHUklaWG5ZMUc1cWtLUm13Q1BlR3JqV3RoR3VvOFdZRkpOOTl4?=
 =?iso-2022-jp?B?SHlVQVlybjdPR3RoVHF6Mmgvc0dGOWJ4TjlCYjNoMVRCNFpmOFA4SStF?=
 =?iso-2022-jp?B?T2kxQWppczFMVGh1VGpDMWVCejFSK2xlRU1rdGw0ZWtBRytyM3E0WThk?=
 =?iso-2022-jp?B?Yi9rbGxES3Fma3BMMi83OFNwSVpldENUV1pYN1cvdEdDNlJJbEl6Ukx6?=
 =?iso-2022-jp?B?QjhXcWtxLzBXRnAxckh1NVpFWXNYc2gwMjJQZy9RT2l2Q2Rndlk0WVN6?=
 =?iso-2022-jp?B?bExSaXBFRnUraWFpRUp0YlRxY2Z5UnRjb281N2FvNitBWHVmTUYxLy9y?=
 =?iso-2022-jp?B?clg4amk4RlpnNUg2cld1ZXBTRjROY1JKbkVlUFNlY2pOTUZYZzhXZlJ6?=
 =?iso-2022-jp?B?d1NiQUNCYlFDbUpTU0RteHpoSlFjSG5kME1XTUwvZzBvNXNoRERPemZW?=
 =?iso-2022-jp?B?b3Vpb3hhVm01MVBoMjJnejF3bHBQaCs3NHh5b3h2WTA3Mm4wQ0hSVlJ5?=
 =?iso-2022-jp?B?UzVHODFUK2crdDZGQkM4S2YzODJEZ1ZKdlpUTHJtUXpVZjRlNStMREhF?=
 =?iso-2022-jp?B?NGVsVWt6dXdzL2kwanozUkFYNGJRKzRtbG1ldEp5Slc4NFZuZWc3Q0hr?=
 =?iso-2022-jp?B?SnJFdVZCaVRUSUV3TEVsTm8xZ0N3MEM1Y1Nyd29TOVM3bXpKWlh6Z2FN?=
 =?iso-2022-jp?B?eEtSU3pycVFVYXkzaytudW9OWkJ4N0hQdWFNMUFjWHYwazNnYlBOOHl3?=
 =?iso-2022-jp?B?YVFiblh6SVhGWXhDYmdlZXNENVY1RDJUSnBxZ1Zjbk0yOHlhUjBwdnJL?=
 =?iso-2022-jp?B?UWhHeGpkQnhkNmZLNmpCSzA1NnJrZVZxNmVHWlN0dW1HeHdWV3lPNThE?=
 =?iso-2022-jp?B?VEVadUhJV2xKTmV3VTRtVkF1OHdOSXM9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB13777.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?YWJrM2ROYmQ2aE5WMTNoN2xXMXFRN0d4RVFVWnZFSFczOEF4c01zWWNI?=
 =?iso-2022-jp?B?YVlVLzRON2EvWkZmbGlMVno4YUZBYzhXcVpWUmU5RUpKQnhtZlVFT1Aw?=
 =?iso-2022-jp?B?SzU1cjQ0NmpKNUxnSEdIRTZtMFo3UDU1Wk5OVC9iV3p6bHRSRGJhbVRu?=
 =?iso-2022-jp?B?TWd3SVVFWmdTbWQvRXI0bW9KOWtlenZMVXJYSWhqRkM1QnN3dFZoT2tK?=
 =?iso-2022-jp?B?dCszMEwvNE9QOGdRN2E3Slo0Y3hIQUZ4YWRFaVphZ2FqQ1lyTWxvOXhS?=
 =?iso-2022-jp?B?Tnhubng5OGZrekt3WGdxTFU5OWY4SXc5c3JDa1ZPeGJWYWlBUmZ1a3lu?=
 =?iso-2022-jp?B?K3VZVjhtdXBZWlRPUnpBdmlpbVk2WTcxMTBxNnUzc2hRSnZzaHZGaTZQ?=
 =?iso-2022-jp?B?bHRLL2QyUmRQSkt4NTlMUENpZWgwZHNjZTN2N0p5S1Z6cmdIM3c3QzQ2?=
 =?iso-2022-jp?B?eFZaejRsbFlhcjBjUW9pZ3JsbGdSSFc4NFhjKzlTa01uckVCSFdoYjNo?=
 =?iso-2022-jp?B?emp4US90bHY3RmhLemhqSjUxcWJLWnlLcVpIV2NuR1pCYzUxd2NteUt5?=
 =?iso-2022-jp?B?MTRiMUJWZW9MODM5WWoyNEg5ZENEaGFjSXJJSHh1TThuNGxLOEJ3ci82?=
 =?iso-2022-jp?B?OXZBZU9NMmlrZlZwMGNjV1NDeDIzelc3RE9MTDErQ3ROZDdrK3Z5OFRt?=
 =?iso-2022-jp?B?eGEvSTMxS3Y2ZGtVcHQrK0t6WDE3RWsyR3dSVUtPbTdnVFA0Zjh1dVJk?=
 =?iso-2022-jp?B?NUk4ZSt0TmdITmNsRWVyaTlTUjJ4VVlrb1FKcXhaRHltUkRTdnFMQWY0?=
 =?iso-2022-jp?B?R1B6Si9takE1UkJXR1o0NmpTWFduRXUzaTFxMm9nV09CcTI2Y0kwUlZo?=
 =?iso-2022-jp?B?cTEvNjVUbjd6R3VvSlN2Q2IzWHRMRjJYazZSTFNORjJ4elMzdlhxbmV0?=
 =?iso-2022-jp?B?a1RncGNzZCt3akhGUzg0bWhYWUd3dzEyS2dobkZlY0kvSG9ZZVhNV2pB?=
 =?iso-2022-jp?B?ZnV5ZEQweVFxVzhjK2ZMWTdvMy9zK0VwQ3VYMWc1U0JoNlNHcllOVWVh?=
 =?iso-2022-jp?B?VXBUb2ZsMDdNaHZyOXYzWXZndVRSS1c1S1BoK0tIOFUvTXVjYW9jTjdm?=
 =?iso-2022-jp?B?TEVoNlpXUStkUzhQcW1tdHVxSTNJMEpBV2NLaTVNZjV5L0FLSTVjWUlx?=
 =?iso-2022-jp?B?b2xyV01yNDM0VkdBOVhzOWR5STRzcFp0YWtwQXlQa0Y4bVFqTVFMbzNw?=
 =?iso-2022-jp?B?c0hjWUpjcVExWS9vZUp2Y2wydFpBaFRrbXM4VTVrbXRqYXlpSnJtL1pX?=
 =?iso-2022-jp?B?N3psVXBnZTB5WVZtUmZ1THR0RHJCZFhsbzBXQjMvR1R2SEpFc25tZkpG?=
 =?iso-2022-jp?B?SVpleXdKK0t2TUFWOW0yQlFjdkdaaEZNdjhBbG5UOFNUdmlpOVF5OGE1?=
 =?iso-2022-jp?B?L00xZFlST3lveVp0WHRJNjZnS0NycE1DdzlVMVpTdy9ORXJIRlg2Uk1D?=
 =?iso-2022-jp?B?dGViNXNjenQ3SnVyL2RMdGpqU05DQnFENG5MYU1VUGt0azVIZTlDdXlW?=
 =?iso-2022-jp?B?RlJVSlFNZ21SS3BWYkFyaTZOY1k2NlZISVpnV3pzbW1ib2UyUkNVek8r?=
 =?iso-2022-jp?B?VmxscUtyTDBMbXJRZDFKdldESWJqTk1zWExNN1NtUUt6ejNZdWhWcGtM?=
 =?iso-2022-jp?B?UWF0R2VMQ0NENFArZnplSEprRE5pY0RLN0YxdnJRZXJaTFZLUnYvTGNw?=
 =?iso-2022-jp?B?WnJxbWMrcGw5eEtpYmM3aEdvQWszUXlyS0QxNUNmWmJYbTc0UnVqVmhw?=
 =?iso-2022-jp?B?bHg1aUkrVnl0S1NzRDhsdUZsNUZKbFhxZnZ2QmZXaHVDbm5RcDJjeVRF?=
 =?iso-2022-jp?B?NkZCTHlYM25BakNhdDBreTdkbDFCSFRBY1VUMWZwYWhlcWc5SmxmVzMv?=
 =?iso-2022-jp?B?VkswYmdRVDBjNE5VdkNFZklGUmExMzVzdkpoT3lRSlQydkhjeE5RMGli?=
 =?iso-2022-jp?B?TnNiaDY0MElQRTNyMVhVWTNtTFdGNHU0aVpHT1dZQmJIdVJETWczVlAv?=
 =?iso-2022-jp?B?aENUeVZUVStzUDhlS2dEdGFYdXdaTy9GWStUeTdsbWJlVzdyM25JcUo0?=
 =?iso-2022-jp?B?M2JmaVJQbWVyY2RYNTlKR1dUUnptdHlhQUJwTGp5blM2SVdwa3owZ1A4?=
 =?iso-2022-jp?B?OXJJQTZNQkJSbElKR2g3NXVxVCtxS2I5bnVXbG5KWEhZdmdLNk5zMG94?=
 =?iso-2022-jp?B?TVJjZkt3M1VPV0QrL05DUWF0bTdyWWdnOFRRWWtlN2E0a2w0cm1uQ3ZM?=
 =?iso-2022-jp?B?YUNvLw==?=
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
	jJ7tNxPc4OU+rJC2OXtYiaSeAdhHZOHsjOC+gLLbWmhdJC2P6rUU27bGs4znBhZUhZCIRf0yqqofMdu+qRMvifs9R2iTmpaCeiK4JjJSk7C17mcJkR77vhhxsRtnIbjjLaZns5GD8ppiP2ZaumL1nJ0RMgDI6h/VZthZU/Xr5oX+TDUR/L7MQh2FuHFhSZRceEdznAYS3JvdbVti5vYcxXckEcWkOu993urRuD9RhDH8ho4WDe7lgOk3A16cgpGi14o7n1OE9LHw2zpH9zPSn/QDpKVJRLxMhUbMt2FjePDx7Tih36Ogdxsa27JjuKd2LNGkImcXmLoGuoQkE78yX8BA1vEE7eCySAXRYK1mZMEl66034PNkWGPKyD4bE9XI7mnj/8yrJG5abqpUjIQuRC2AiuO3u2A6Ap7dm2dbgBvRSkHBYyGeXUDPmSMBvBwCtVN7SLukR7ptA2EN8DLb+Cz4DQUNkO3x0zbgkmvwmxcw/zRXyebz396bMblxxnBkzJC8nIqeGUsWH8IGbH68TtD0pZHLbcvJLs6lDf3kP8lNyOnXh+xNlRjEcP8M8pMJNigZ5ZLhKyDlDENwNOVJLGObv2loQBH3W6yHYkdLLrmjrCMdlTaJAmz8nukenogl
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13777.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77505a3-c053-494b-1fd1-08dd5f7a8f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 02:23:35.4621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IfuFjWraN9k/kaDpqLlsktJHLqCcocDomi+0YDSMRBeePBBxiXY65b9o8V2LYr/c+bwsRQrjMVU4PIpn1zUBL/gldOqWsAXdfg0z/kUclHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8804

Dear Reviewers,

It has been about a month since this patch was merged into tty-next -> linu=
x-next.
I would appreciate any comments or feedback on this patch.

Regards.
Toshiyuki Sato


> Implement the callbacks required for an NBCON console [0] on the
> amba-pl011 console driver.
>=20
> Referred to the NBCON implementation work for 8250 [1] and imx [2].
>=20
> The normal-priority write_thread checks for console ownership each time a
> character is printed.
> write_atomic holds the console ownership until the entire string is print=
ed.
>=20
> UART register operations are protected from other contexts by uart_port_l=
ock,
> except for a final flush(nbcon_atomic_flush_unsafe) on panic.
>=20
> The patch has been verified to correctly handle the output and competitio=
n of
> messages with different priorities and flushing panic message to console =
after
> nmi panic using ARM64 QEMU and a physical machine(A64FX).
>=20
> Stress testing was conducted on a physical machine(A64FX).
> The results are as follows:
>=20
> - The output speed and volume of messages using the NBCON console were
>   comparable to the legacy console (data suggests a slight improvement).
>=20
> - When inducing a panic (sysrq-triggered or NMI) under heavy contention
>   on the serial console output,
>   the legacy console resulted in the loss of some or all crash messages.
>   However, using the NBCON console, no message loss occurred.
>=20
> This testing referenced the NBCON console work for 8250 [3].
>=20
> [0] https://lore.kernel.org/all/ZuRRTbapH0DCj334@pathway.suse.cz/
> [1]
> https://lore.kernel.org/all/20240913140538.221708-1-john.ogness@linutroni=
x.d
> e/T/
> [2]
> https://lore.kernel.org/linux-arm-kernel/20240913-serial-imx-nbcon-v3-1-4=
c62
> 7302335b@geanix.com/T/
> [3]
> https://lore.kernel.org/lkml/ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2
> i.remote.csb/#t
>=20
> Signed-off-by: Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
> ---
> This patch removes the legacy console code.
> Please comment if you have any concerns.
>=20
> Changes in v3:
> - Add stress test results to patch comments.
> - based on tty-next branch
>   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> v2:
> https://lore.kernel.org/all/20250115052749.3205675-1-fj6611ie@aa.jp.fujit=
su.c
> om/
>=20
> Changes in v2:
> - Remove the module parameter used to switch between legacy and NBCON.
> - Remove codes for legacy console.
> - Fix build errors detected by the test robot.
> - based on 6.13-rc7
> v1:
> https://lore.kernel.org/all/20250108004730.2302996-1-fj6611ie@aa.jp.fujit=
su.c
> om/
>=20
> Thanks Greg for the comment.
> ---
>  drivers/tty/serial/amba-pl011.c | 143
> ++++++++++++++++++++++----------
>  1 file changed, 97 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 04212c823..9a9a1d630 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -272,6 +272,7 @@ struct uart_amba_port {
>  	enum pl011_rs485_tx_state	rs485_tx_state;
>  	struct hrtimer		trigger_start_tx;
>  	struct hrtimer		trigger_stop_tx;
> +	bool			console_line_ended;
>  #ifdef CONFIG_DMA_ENGINE
>  	/* DMA stuff */
>  	unsigned int		dmacr;		/* dma control reg */
> @@ -2366,50 +2367,7 @@ static void pl011_console_putchar(struct uart_port
> *port, unsigned char ch)
>  	while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
>  		cpu_relax();
>  	pl011_write(ch, uap, REG_DR);
> -}
> -
> -static void
> -pl011_console_write(struct console *co, const char *s, unsigned int coun=
t) -{
> -	struct uart_amba_port *uap =3D amba_ports[co->index];
> -	unsigned int old_cr =3D 0, new_cr;
> -	unsigned long flags;
> -	int locked =3D 1;
> -
> -	clk_enable(uap->clk);
> -
> -	if (oops_in_progress)
> -		locked =3D uart_port_trylock_irqsave(&uap->port, &flags);
> -	else
> -		uart_port_lock_irqsave(&uap->port, &flags);
> -
> -	/*
> -	 *	First save the CR then disable the interrupts
> -	 */
> -	if (!uap->vendor->always_enabled) {
> -		old_cr =3D pl011_read(uap, REG_CR);
> -		new_cr =3D old_cr & ~UART011_CR_CTSEN;
> -		new_cr |=3D UART01x_CR_UARTEN | UART011_CR_TXE;
> -		pl011_write(new_cr, uap, REG_CR);
> -	}
> -
> -	uart_console_write(&uap->port, s, count, pl011_console_putchar);
> -
> -	/*
> -	 *	Finally, wait for transmitter to become empty and restore the
> -	 *	TCR. Allow feature register bits to be inverted to work around
> -	 *	errata.
> -	 */
> -	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr)
> -						& uap->vendor->fr_busy)
> -		cpu_relax();
> -	if (!uap->vendor->always_enabled)
> -		pl011_write(old_cr, uap, REG_CR);
> -
> -	if (locked)
> -		uart_port_unlock_irqrestore(&uap->port, flags);
> -
> -	clk_disable(uap->clk);
> +	uap->console_line_ended =3D (ch =3D=3D '\n');
>  }
>=20
>  static void pl011_console_get_options(struct uart_amba_port *uap, int *b=
aud,
> @@ -2472,6 +2430,8 @@ static int pl011_console_setup(struct console *co, =
char
> *options)
>  	if (ret)
>  		return ret;
>=20
> +	uap->console_line_ended =3D true;
> +
>  	if (dev_get_platdata(uap->port.dev)) {
>  		struct amba_pl011_data *plat;
>=20
> @@ -2555,14 +2515,105 @@ static int pl011_console_match(struct console *c=
o,
> char *name, int idx,
>  	return -ENODEV;
>  }
>=20
> +static void
> +pl011_console_write_atomic(struct console *co, struct
> +nbcon_write_context *wctxt) {
> +	struct uart_amba_port *uap =3D amba_ports[co->index];
> +	unsigned int old_cr =3D 0;
> +
> +	if (!nbcon_enter_unsafe(wctxt))
> +		return;
> +
> +	clk_enable(uap->clk);
> +
> +	if (!uap->vendor->always_enabled) {
> +		old_cr =3D pl011_read(uap, REG_CR);
> +		pl011_write((old_cr & ~UART011_CR_CTSEN) |
> (UART01x_CR_UARTEN | UART011_CR_TXE),
> +				uap, REG_CR);
> +	}
> +
> +	if (!uap->console_line_ended)
> +		uart_console_write(&uap->port, "\n", 1,
> pl011_console_putchar);
> +	uart_console_write(&uap->port, wctxt->outbuf, wctxt->len,
> +pl011_console_putchar);
> +
> +	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) &
> uap->vendor->fr_busy)
> +		cpu_relax();
> +
> +	if (!uap->vendor->always_enabled)
> +		pl011_write(old_cr, uap, REG_CR);
> +
> +	clk_disable(uap->clk);
> +
> +	nbcon_exit_unsafe(wctxt);
> +}
> +
> +static void
> +pl011_console_write_thread(struct console *co, struct
> +nbcon_write_context *wctxt) {
> +	struct uart_amba_port *uap =3D amba_ports[co->index];
> +	unsigned int old_cr =3D 0;
> +
> +	if (!nbcon_enter_unsafe(wctxt))
> +		return;
> +
> +	clk_enable(uap->clk);
> +
> +	if (!uap->vendor->always_enabled) {
> +		old_cr =3D pl011_read(uap, REG_CR);
> +		pl011_write((old_cr & ~UART011_CR_CTSEN) |
> (UART01x_CR_UARTEN | UART011_CR_TXE),
> +				uap, REG_CR);
> +	}
> +
> +	if (nbcon_exit_unsafe(wctxt)) {
> +		int i;
> +		unsigned int len =3D READ_ONCE(wctxt->len);
> +
> +		for (i =3D 0; i < len; i++) {
> +			if (!nbcon_enter_unsafe(wctxt))
> +				break;
> +			uart_console_write(&uap->port, wctxt->outbuf + i, 1,
> pl011_console_putchar);
> +			if (!nbcon_exit_unsafe(wctxt))
> +				break;
> +		}
> +	}
> +
> +	while (!nbcon_enter_unsafe(wctxt))
> +		nbcon_reacquire_nobuf(wctxt);
> +
> +	while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) &
> uap->vendor->fr_busy)
> +		cpu_relax();
> +
> +	if (!uap->vendor->always_enabled)
> +		pl011_write(old_cr, uap, REG_CR);
> +
> +	clk_disable(uap->clk);
> +
> +	nbcon_exit_unsafe(wctxt);
> +}
> +
> +static void
> +pl011_console_device_lock(struct console *co, unsigned long *flags) {
> +	__uart_port_lock_irqsave(&amba_ports[co->index]->port, flags); }
> +
> +static void
> +pl011_console_device_unlock(struct console *co, unsigned long flags) {
> +	__uart_port_unlock_irqrestore(&amba_ports[co->index]->port, flags); }
> +
>  static struct uart_driver amba_reg;
>  static struct console amba_console =3D {
>  	.name		=3D "ttyAMA",
> -	.write		=3D pl011_console_write,
>  	.device		=3D uart_console_device,
>  	.setup		=3D pl011_console_setup,
>  	.match		=3D pl011_console_match,
> -	.flags		=3D CON_PRINTBUFFER | CON_ANYTIME,
> +	.write_atomic	=3D pl011_console_write_atomic,
> +	.write_thread	=3D pl011_console_write_thread,
> +	.device_lock	=3D pl011_console_device_lock,
> +	.device_unlock	=3D pl011_console_device_unlock,
> +	.flags		=3D CON_PRINTBUFFER | CON_ANYTIME |
> CON_NBCON,
>  	.index		=3D -1,
>  	.data		=3D &amba_reg,
>  };
>=20
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> --
> 2.34.1

