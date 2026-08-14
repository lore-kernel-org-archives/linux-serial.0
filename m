Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948B3DF003;
	Fri, 14 Aug 2026 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.175.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691432; cv=fail; b=QVAqsB3tvzZuIB5PbCDUd23PM/7p2p2f6IF/eZErylk+bcUqxYHM+MLFlfeduPjtKccxx6uJZSHX8LqVoPGM+3NJfsK5pwgtgiD9Jg3z1K7aDmysdSFTF8Vlvb4bxD1cCG1vwRmaBDtMfjCAtLwy6DT1853ShAf2MoyOsrQCzgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691432; c=relaxed/simple;
	bh=vrSVgAgDbN3hHMDkLa0XXcN2fQZXU/ybeF572vZj34A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=EXh5keIbxN3CbHl74gDCW0Q8CPvSQAJ6Mw8bPFwzzXX8nhwS4egq/8lWgItg93Iwk3vtweAUeAlG5tAoW9k8Jn0HbJZ1RAm6Xm/X0M0LG1aua+E745whVQ9hpp9tOuIDMuZdqhX5FAcFwI89fjkuD7RusSV4tFBj7gLRhjiBA18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=y/oDzcdN; dkim=fail (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=jD80q5Nr reason="signature verification failed"; arc=fail smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="y/oDzcdN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="jD80q5Nr"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E6fAw83599930;
	Fri, 14 Aug 2026 07:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=vrSVgAgDbN3hHMDkLa0XXcN2fQZXU/ybeF572vZj34A=; b=
	y/oDzcdNT5aHGO89X7BulFP+76ntw/bb4PlEgfuGoEaZUfA2vW1cSgCZqGa7j2BB
	eFe8T1lQ+VPQEQ+/Fdadge8ewM3knHK1wx+0yEWMB7zfMAIVbCfPDXbvQGxjIJ9u
	BPKb+aob2Xu+Tj82lu+NILRot0TQYsm2o1yPnDdhCEUjdXNcWh08NiFHLgxjgPd0
	WA0rU1xq/fJdfniR/cPrlqWhjUo5D9cRRLWzh+xlG/LhwiS8WZAPL6jNPkhbzQqW
	DAEit12uaGaySZcIQic7kVuU2yvg4p2Dwk1NTd2OVD+GSQV9XLuSmvWTEhxhEuwE
	axYBC+IRgo4ze3MlV+49sg==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021078.outbound.protection.outlook.com [40.107.208.78])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fysn1kkdr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:10:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fX/mdG9O4lPEkUprLFaKZoODUBEtNTTiing6xmYIyids6vzfvHS7sYOWJ/VapuHLCX51Aw335haHJBD+nD/9inld6S2DzitByIDpl92v6vKVrN4/3nhybJlJOWM0m91oQAHhR0zUO2jalz6JvgVzb9Z+ZysDL/CW8pmh+IvvaLY1syo3YUigKLlzUIPhG/Rb1ox7/55EhXssmHdQ1QFfVcTE1bHHEV4l67MaUHOed9hMnplzCA3oUZoyBRjQdzN2UQUkPKsUfY7ZEKHqEBHpjDICpnZA9RbE7wOQx36bk7u4QzcM0d1DOoPtYS8hAKxHoMyCbRFzlNWWdDzbkKluGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01mJuThzoU17DUUP34tGwDA7Ff+NyrjmDZDb8Ss/eaY=;
 b=tuSxqPHVplQ+aRvPvhuks6Lj2hWAFJTC7pVN07dOoihdQ/T89FpVyb6gkJjd2/1RZg6AREOGSzTpDx5JxzOLAI8dduytUIHtO/7Nqa6EYELdknPfX4KAuCbhOYYCRRdmuivPM/r2vWCAexMA0bE8EbkEbLfyWVh0oTCfvvH8Cb5Eknov7JQyDwoef6iZxnAWPU+9XHKJEE7g7XlrSZwDJDXH3tBVtltZ4IgSs+CmanFbSFHVZg33iJVIXL0g0F2+6ZBjjBswRhMPBZYuF66P1NsoUgR8pDI7phEcJ7SnDEgvsliwNwtj0ysTdaYGEF3AolBD0j93HT3NUZ+i5pISNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01mJuThzoU17DUUP34tGwDA7Ff+NyrjmDZDb8Ss/eaY=;
 b=jD80q5NrXvKoiFzgfnK0L97FcmN25xSCYpC+BIwAr07aWq7+D+J0vTJthpp+JBFOYsn/2Amexy6F7N/xjjhCuEUsQ3ddrNV7rQhTG0Oi//hz3w0j02ZDmKs0MR9nyfTZucyKRAbWqJdUPsaU8UoqmXPEUeXav+00UlehwqMbVTmJM3rXQWQsdPzGLCkUhGz1MUxlxLQ3niUpVRDbJzpmC8FjuAGwl9yz7LvYp7sunYiGkAirl2Q+u7HvUrWTn5niYnpWo1Euk6R5HdeVUt1DZzWnSsc1zyPFV7En8DidDExWd4EFA5luyrcqyiQjoHQUAkHJWVkT2sy8dSMi9nXymw==
Received: from DS0PR19MB7925.namprd19.prod.outlook.com (2603:10b6:8:163::21)
 by BY1PR19MB7800.namprd19.prod.outlook.com (2603:10b6:a03:527::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 07:10:01 +0000
Received: from DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b]) by DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 07:10:01 +0000
From: Long Zhao <longzhao@ambarella.com>
To: Linus Walleij <linusw@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75 quirks
Thread-Topic: Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75 quirks
Thread-Index: AQHdK7vsO6J0Vd99MkSNwUTrQ4oehQ==
Date: Fri, 14 Aug 2026 07:10:01 +0000
Message-ID:
 <DS0PR19MB7925B2D3BF8D862C7A70A378DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
 <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
 <CAD++jLngKLVtojVtmVkYkdLLZrUojper2H4UEA-jK9gcvCSbMQ@mail.gmail.com>
In-Reply-To:
 <CAD++jLngKLVtojVtmVkYkdLLZrUojper2H4UEA-jK9gcvCSbMQ@mail.gmail.com>
Accept-Language: en-US, zh-CN, en-001
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7925:EE_|BY1PR19MB7800:EE_
x-ms-office365-filtering-correlation-id: 424ac581-b69a-4580-53bb-08def9d30e9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 IMgl5m8O7SH8vIgDN04wBTy+GViNSwFkioQpj7fdiggRHgiuOlB+n1dyapGgHqGHArqssw6dIemw6YiQCjpy6GpVFO189TvJRhSu7ltOi7UCJgjeYRHy42XGorBuWySnKyR4/DsOtZDRZ6NeKpr6bhpbZDMud0AhXv5kw/EDBZua1f/2VkOuDq2wd8kvEDujemc66ZFC+jrj3vWtkl7TeLiy26XPcsMu4I2cwk77llcvhPxQxMyp8T04Zkla6cSwEKl/WYPvmV723/tTp/cEiuyLBS/604yaGwlADuLkcsQF9iudq5kKyltpZJGutlV4bbNfmPTj9WL2vx2wRHWN5dyW6HMuB3cRyPN3Q29E5V9tlUTbuigTjZZLMHjVHuIsjK9yB/qfPOH9QXbxnir0HVgwuyYy+ak2tzak1ODpp//t9XcG/5owNwuqEdzK3V/yb/qpgqYbaCOK7wYU4RS0UNvCY6AN71Iy6UOmogQptu+r5wfHFIQhBVuJJ7+feO6Amr9Rd/FU1asG/blrDjdWgpvkii7IUHfdKVGZeL1nbpUrJhFn82dd5qlrfW/w4lvYrqgaKK4dQeWWJ28TSMYbeaHtCCmSzd1JbMQW4Q+DS5SDw8huKI8QAALYtwXb0/eUaKJQdV48lWCf2qmF796JY55mJ70n6YikD7eJ5+kk18+OIpAx7UHIWNmnTVF7nhsFUCVNGXBAxFvkr3ECLu/E1W9rbn8pImnJiE2f9m4LJBw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7925.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d09reVlaMjBGTm1tSE1KNTFlckVDcjR2WEpJeWZNMGcwVkQ1c3lFN0R1MkhV?=
 =?utf-8?B?NDdJRlI3NlNMc25ISXVQc2tBTWVTSTZVaWM1NitzL0lvZWY5cGRqVytpRnFZ?=
 =?utf-8?B?Vk96Q1lOZzAwRTBUdkJYeisxNUVkYjlGZ2pHNHBvK3dlOHdpMUlNWFV2MTRF?=
 =?utf-8?B?OS9pSENCZTNCVXpyWGpkNnJkWWprdWJYNXNmd1NmUkRGVG1rK1NtalA0UE1G?=
 =?utf-8?B?Rjh0RGhKd3pIcmRFcjBtRjhWVzUycjBHWFc2NFNUeFpNWlJ2S0MzVFIvSW1v?=
 =?utf-8?B?VGhmQ1VaSnRXcU1TN0gzbzIvUFp1R2tkY3k3U3RRbWpITnVFYXl1Qmt1Nkp6?=
 =?utf-8?B?T0IvWTlqZ3I2cTMxOWRMNmRlRU4yZlpGd3NNVGxWWGQyOUVWc0pKd1Z5K0hN?=
 =?utf-8?B?T05RdEcxSXA1ZC9nRFE4S3lucUllL2gybnRjSlhJTFZTa3NWaWZ5RzhZcmtR?=
 =?utf-8?B?TGpNdWx4WWJ6Wk9PZUFGQVA0MWxiLzBJV2dnVHBRZklBMEpSRXBsdXZMSVY1?=
 =?utf-8?B?NTVMTm1QS29FR2g0QVNrVGVEdW8rUzBGSW5oREVrUm5GcFlCT041YmwxS2ti?=
 =?utf-8?B?UWdxbVBpTWxsNnlNeG1pU1NPRkxBUFNoam1qN0hrWk5kVnlRRnhYZnhmTWlv?=
 =?utf-8?B?MTVNcWhRWkJXOEVqeTQvMHpBMlVQNWN2ZFpNdE4xOFVKOU1qSldGajhOZU41?=
 =?utf-8?B?SkpHKzVxUW5oV2lIckdEV05YT0lvQnR0R1BONkg5L1h6b1VxYU5Kek5YbVJW?=
 =?utf-8?B?UEZvZi9jRDYvS0RqUkRwQm5udE9Jcm1jRDVUTVV3R1Y1Q1JDZjd6MHh3M2hx?=
 =?utf-8?B?S2JTb1VDcVZXamdKbGtqNW5mZUExN2p0WEhEVmFDTkI2T3FVQ2Y5aE5vbnRM?=
 =?utf-8?B?RjFkTG45di96YW5lQS9FYWlvTFY5c1lFSHF0WkEyeENFam90RGVQa3pqM3JK?=
 =?utf-8?B?aXJ1UlJ4ME9zRmRDcXhxd0xSaGYwUWl0QlhJTmM4TGZJUmljeDY5a3hmOU5Q?=
 =?utf-8?B?QlhIQkFpa1JXZnRPUXp4NE9Xa1g2bHJhbkpqNUNRbWFPcVZvMElJTlFETVVx?=
 =?utf-8?B?OGxaR1o1TmFaMGl5cjRtanFYa0FKeFROMVM0bW82MFVOYzZjcGRFY3dWekhk?=
 =?utf-8?B?ZVFRWHlDQTY0V0VudHFJYXl2ZmdndExhWDc3Y3lUOXlwU2l6Mk5hRU5SeWhV?=
 =?utf-8?B?SkxpN0NsVHdQMXZuS0xWNlUvSG00Q1VMd2xqTjRlSVpjK0lXZU0rSDR1R2N3?=
 =?utf-8?B?VWdiVDBOaXVzUG1LZTMyZGMrcjFYTDZsbFEwQTZ0SHhkNnRwVWtrd3RON0xU?=
 =?utf-8?B?NlF4d3dlVmtvR0dYZm92c2F5bjE5ODBZeHlKUEhFRnlDa3AxSG5lcHR6Z25v?=
 =?utf-8?B?c0ttOUROQVdabFhkR0dHVXNuSktqQUdhTDMvTjNnczdORHFicXFLbGVUNU1U?=
 =?utf-8?B?ZHNKZWlFZWR1NGlVdGhIWmkzRWx5ekJiUFlXM1FGOXFOeFIzcUhWeTUxRTZO?=
 =?utf-8?B?Nkh2Z3dldldibWEyQjN2Qzc5TThaZkN3R2RrTnFPK3E4TC96Vi83aElCSDRN?=
 =?utf-8?B?eUo2Z09HRlZLSTFTQXJTTUsvNXBPM0k5VzR2c1ZPcjY3alU4MkNNRFhIcW9n?=
 =?utf-8?B?UXRzTkkvUmUwYWd4SUI2U2tjVDE3NnAvL1BNaW5EQ1dVUHRxTUhsczNvazhK?=
 =?utf-8?B?ck1sRys1V04zNUNwV2NvV3JucE9WYkN2a2RtSHk0aGRtR0tjRzMwbFJCUnh2?=
 =?utf-8?B?VDh6ZmprMjVXY2R6ZHFIR2hRVUVqeC9rdDZiSGY5K3dBNm1IeFJrRkVFNFFV?=
 =?utf-8?B?SlpjOHZQUDFjeko5M1hJcjVUckFseDI5QUtBbzJBajR1Y2M2Q1NEZzF3MUI2?=
 =?utf-8?B?TS80WmJrcndBRWlsWTE3N29UVUtVUlowRFMzRG55UFo1dFFpYlI0VnUrWDVL?=
 =?utf-8?B?dDdqV05vSVRhRWs4eGxKY1dCckxLbDBBWTI2MjlvWStqckVqMStRRFlMRUhX?=
 =?utf-8?B?NFdNVHg2cG5jaWlaUlRJZGdEWWZsK1FITDdSM1lQczdrN0luV1VYelczandV?=
 =?utf-8?B?dmhIZDhid05oWXZXUmJMQ0ZOeitRLzVzQzJRcEprUDRGd2dyRCs4blJTL1Jx?=
 =?utf-8?B?Zy85QmFNRm9NK3NDcThEbCtEZXROTE5VUzZsZHdjNS90Um96T3dVYmY3Rmdn?=
 =?utf-8?B?SmF1RjZnelB0ajVqeDZCUUFGQjJSTDFyRGFBaUVHdnZ0NWNlMzJMd2xKVzZy?=
 =?utf-8?B?R1VSLzJFVjFjQk9vOHZKVjNRRWovdnVIcDRpTjQ4UE4rTGs1cFdDK0k3WElI?=
 =?utf-8?B?TXBMUWp2YmlRNFZNNGtTR3d3aVNkZ2lma0lBQXF0WG5nUkRjbzRMUT09?=
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qfpZM8YqBz8wYJdrbDr3tqdd4y29bfjoHlUAjtnMFEjKFE7vhVJHsBVIoHMXTZ9ZbNb12WIvpe7H1EoX7jFTMh5ySnvLh793icjKX8aOR9ps0UVjJZZiEQq1c1ovbQFaEYuboSKPe8D1wZYyA1KGhtAvdf7xCEvIGHrDjSQvAX5D9842cQlU4VaAF1ZUqHBdwsh7cKD+yox0CJWCkamMG040SrDTR5Ld1C+H367mpGbHamE0a8aFXASoAgUbBZXK01AktDMB49Z1AdspgCDR3/FVYK7HOqUcOPKLObrW+WAMRgtd8pdW/ZPusAQYogj55AmAmnBIFd3KE13iwP6Lig==
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7925.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424ac581-b69a-4580-53bb-08def9d30e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 07:10:01.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aygQMoWi/+e6K2rvsEsIcqf1J0lFXF2e7kZqxZkHOdr8SQQqoy+RWNEyLqskO5ykcOKa3N43oBjKOWJlqWmjJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR19MB7800
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1NSBTYWx0ZWRfXxfYTb7A9tn5s
 0NjtVIu6JyP2XAPns5LpokFSauykRtwgZvuLhUJ+vxkuVdQ3aCiJw594Xk9EZtEkcSdn0j76NEk
 dcAKZYC3GCZQWQmN157LghybhrR2MAtKLRBITyAqvUH6Kf+tqQxedum6NfZHa4kxLZHde9jcuEW
 1s5ZWgPYtn558e6OQJMScHHkEi/kwsLH/7yPZqrQzD+YDVtMxtdf3gclvRAEyWTKK8nX7HquXst
 SyK+eAJxF6xNevhKB4qOLXufFORmr58JhKx3LkljbC1kPW8Zlv34CbJgYzlvAyab68XPFrzWvHs
 PhKUFQ0xYbAVV/Ht0r3UuZ6/k+6ujVcv7Qj1GeC3ecx/8+k2jCEkQUBMvhxlGlS3zr0opXxDHC2
 /Vdxtzy+DK3X2Ha/bwa3dsbxqhYXTBb8XaLGYwkQ5x/QYZ090G0Fov+J2YHaVwqKI6y9pyUXl0W
 FVVM1qR2rjs6qsA8h0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1NSBTYWx0ZWRfX6hug+70Zk5q4
 3EYG5aF/XlKcw9sO5cLCsMs6Kew/tSk0M10wkSiO1v94k/orA4Up6H0YA+fvW6BJeotyVnsa5zi
 Pxw4KWR8/yE7tRAL/dFR9F8jXDk2EkYB4N4p66OOxIrcrUoGpRgi
X-Proofpoint-ORIG-GUID: MSKggfEVYOq89jalqqqAGQSAjEsWTeC2
X-Authority-Analysis: v=2.4 cv=C4fZDwP+ c=1 sm=1 tr=0 ts=6a7ebf55 cx=c_pps
 a=EX0Xkmt19mXnrP5bPG/VDQ==:117 a=fVfL832+mzDTHoFKNp42fb2xq0E=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=dkMdDuzY2HgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22 a=KblO7da7ppA7TBl3N-nE:22
 a=VwQbUJbxAAAA:8 a=ppJngBeKAAAA:8 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8
 a=maRHS62v3ZjmDFYJF-UA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: MSKggfEVYOq89jalqqqAGQSAjEsWTeC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1011
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140055
Content-Type: text/plain; charset="utf-8"

SGkgTGludXMsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgZm9yIHN0ZWVyaW5nIHVzIHRv
IDgyNTBfZHcuIEknbGwgYWxzbyBsb29rDQppbnRvIHRoZSBTYXNoaWtvIGNvbW1lbnQgb24gdGhl
IGxvY2tsZXNzIFVBUlRfSUVSIHdyaXRlLg0KDQpCZXN0IHJlZ2FyZHMhDQpMb25nIFpoYW8NCg0K
QW1iYXJlbGxhIFNoYW5naGFpIENvLiwgTHRkDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogTGludXMgV2FsbGVpaiA8bGludXN3QGtlcm5lbC5vcmc+IA0KU2VudDogRnJpZGF5LCBB
dWd1c3QgMTQsIDIwMjYgMTU6MDANClRvOiBMb25nIFpoYW8gPGxvbmd6aGFvQGFtYmFyZWxsYS5j
b20+DQpDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47
IEppcmkgU2xhYnkgPGppcmlzbGFieUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2Vy
bmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9y
IERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZp
bmVuQGxpbnV4LmludGVsLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29A
bGludXguaW50ZWwuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtc2Vy
aWFsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6
IFtFWFRdIFJlOiBbUEFUQ0ggdjMgMi8yXSBzZXJpYWw6IDgyNTBfZHc6IGFkZCBBbWJhcmVsbGEg
Q1Y3NSBxdWlya3MNCg0KT24gVGh1LCBBdWcgMTMsIDIwMjYgYXQgMTI6MzXigK9QTSBMb25nIFpo
YW8gdmlhIEI0IFJlbGF5IDxkZXZudWxsK2xvbmd6aGFvLmFtYmFyZWxsYS5jb21Aa2VybmVsLm9y
Zz4gd3JvdGU6DQoNCj4gRnJvbTogTG9uZyBaaGFvIDxsb25nemhhb0BhbWJhcmVsbGEuY29tPg0K
Pg0KPiBBZGQgQ1Y3NSBwbGF0Zm9ybSBkYXRhIHdpdGggYW4gRVRPSSBJRVIgbWFzayBhbmQgc2tp
cC1zZXQtcmF0ZSBzbyB0aGUgDQo+IERlc2lnbldhcmUgODI1MCBkcml2ZXIgY2FuIGRyaXZlIHRo
ZSBBbWJhcmVsbGEgVUFSVCBmb3IgY29uc29sZSB1c2UuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IExv
bmcgWmhhbyA8bG9uZ3poYW9AYW1iYXJlbGxhLmNvbT4NCg0KSSBzZWUgdGhpcyBhcHByb2FjaCB3
YXMgc3VjY2Vzc2Z1bCEgOikNCkxvb2sgaW50byB0aGUgU2FzaGlrbyBjb21tZW50IGFib3VyIGxv
Y2tsZXNzIHdyaXRlIHRvIFVBUlRfSUVSIGJ1dCBmcm9tIG15IFBvViB0aGlzIGlzIGZpbmU6DQpS
ZXZpZXdlZC1ieTogTGludXMgV2FsbGVpaiA8bGludXN3QGtlcm5lbC5vcmc+DQoNCllvdXJzLA0K
TGludXMgV2FsbGVpag0KDQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQpUaGlzIEVYVEVSTkFMIGVtYWlsIGhhcyBi
ZWVuIHNjYW5uZWQgYnkgUHJvb2Zwb2ludCBFbWFpbCBQcm90ZWN0IHNlcnZpY2UuDQoKKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKgpUaGlzIGVtYWlsIGFuZCBhdHRhY2htZW50cyBjb250YWluIEFtYmFyZWxsYSBQcm9w
cmlldGFyeSBhbmQvb3IgQ29uZmlkZW50aWFsIEluZm9ybWF0aW9uIGFuZCBpcyBpbnRlbmRlZCBz
b2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwocykgdG8gd2hvbSBpdCBpcyBhZGRy
ZXNzZWQuIEFueSB1bmF1dGhvcml6ZWQgcmV2aWV3LCB1c2UsIGRpc2Nsb3N1cmUsIGRpc3RyaWJ1
dGUsIGNvcHksIG9yIHByaW50IGlzIHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IGFuIGludGVu
ZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBieSByZXBseSBlbWFpbCBh
bmQgZGVzdHJveSBhbGwgY29waWVzIG9mIHRoZSBvcmlnaW5hbCBtZXNzYWdlLiBUaGFuayB5b3Uu
Cg==
