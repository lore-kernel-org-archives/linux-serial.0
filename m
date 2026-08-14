Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAAE34E74B;
	Fri, 14 Aug 2026 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.175.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700037; cv=fail; b=BOAC2NYNu2wfsb5yrJo2CJmx9kUyHGqKBXaiAxZ1+vtbTTp0GVfxt0Wyrv1KSrFL7Awc9aUqCBLdGJXR9+yU2nWwawgscmXeT8tQFd/9WDbaBNEmN2gkU5v459ItF8hJk5BJksKhQva39wCHIEwej8jqN5PwrY8smQTcChqGfbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700037; c=relaxed/simple;
	bh=Ax9mKpuQ62QcmUWVpnoXQV7pIkLhhDRMTpYnMK6lDCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=pIE0asbykqTDIM6FBQkqKY6UGnkqVM+gT/Kg+QPDYVRC8DDb4/NHd44NVsweUhwxASpnh0wc4Yl5jDvMY8RJNAfPGI21CNheVpwGP0lAvqZy/B5sfUxJ0RgscpgSenO70GC2lb3rYiOYfW5l0FWu9o9yKrDnk+TxWtzfNd4STsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=juEmvgY0; dkim=fail (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=o2g/EIgz reason="signature verification failed"; arc=fail smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="juEmvgY0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="o2g/EIgz"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7hAbx3712205;
	Fri, 14 Aug 2026 09:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=Fkap9y6iDINhiTUBC8LVNBmYojfE+Z41LK00R37i7nw=; b=
	juEmvgY0+sdB4IfjdQB8yxzBhZGCtYO6H6N0CtNaKQIZbPcTpQlEnwjBX0FnYguQ
	6Qg/bfqPRXAzjK4mfgkPgj2EppuZLQM7uQHNUyEmdmHhV/JnJwfDF5vd2rtEKF1o
	gjGMaDId9Y4f1HFLDr3FhLUi1FMOE4i5ee0dputVpu/IOT65dTYGO1ztKGunDh5R
	tP5VP/TTknxdj3pIgDI9BM2xT3wX2FUaTIEJIbL1LLMgd7eIAKIEMhk0GDNSdDP6
	aLh8tjZexxmZuLjInE4i71SekCR9FZhmIuW2Ren0vLazNeKyI+P76kA9rv7mrT79
	5S/v1deY5n5CiedKPRO7iw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022129.outbound.protection.outlook.com [52.101.43.129])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fysn1kphc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 09:33:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibqJ2Oxn6vmTvOIRv6LteAd9bahLfaJZVHdSQV2TGiXoNH4Ic03I/RUm1oqpdmp5jQJKezcHw8Ufyr4PbeYCzv3YACkYJd2T6B4k+cCfW8kXjozIdYrRksqvhQnaNtIJkQ+Dee2cLquahU/9Zx+duKq250AB6wEIgF371cLAVYEOEPIcC+EKOnxpY1ivl2vQkrwCRcWafrMXJpLtTk/LFYPE8bUAxBhj9g3LfTRbnnOkvGyWCsrXkoDazI8VZASj+dXGpYGM41DDXbgy4sURojo5o+4j6vQ3/l7Jib7mSGGHstumFGFtgBVLiUPIoQnSYPPf5omJzxryrPF+8ZNS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73UqunTXalMizO0uFvkAAstlI9ogvpoCb9sqPOwAx5g=;
 b=vB3CCpK8pWbfPQagJd5MHflyEDcHRI7O9CnGsvTtqL+L6tkS9ZxMbKCouxZoAJsd8bhA2ubf8naYccPmF0To7ZSULwIQ4YlXbC7/pg1hVvISYw42ha85JTZDik7zGSDhJDuhdPkM0YoQXt/aap0VOnSZS7PRshBDBfXGwF8S4ImSWsyuTk9z8qDk2DIDCpmb8Q6aXVceC4zjeys1DTjAUWGsPRaSh7eWGA0kvG8Wc/gFtnxNS5L4XT0M+uNiHsT0uFY+h+5VbIy3ZXzdc/glkzHKY2pCTYMoq4xL8kw4zexzEGJoGNNuCIdqKbejb9tB9Lqac2EHPeQEv3KWKVrS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73UqunTXalMizO0uFvkAAstlI9ogvpoCb9sqPOwAx5g=;
 b=o2g/EIgzdm3riZrSORNyL+CfxVTIsYaG/Y913SGhzDQIBTI1IcXJHyiz6mIKRrMYxbdq8dpKd59Hg7C9Sc7d30NZ/gmX+upeO0TKyC8qb1WC7+4z9XEysKB8UV48Y6PTjjRuJiHBm/BQUfGkR+xqcMZtqR8atpb+Hx+mfAmYYN4fK2BVs3JA+5q1srCOCjWXIW3uNc6gZ4XftfmqhXXcefJmjWjRX3gUbjSbPeKe2mbRGTE3PqwBrmQHIUu8576w3qHZUJ869MWtQlvc0bxuVPx2r9dn0CylD2MsXdeAVm62wgPyLMgS2UzCWoLWTlM17x21UNHc/FgnKRFgBi7Qrg==
Received: from DS0PR19MB7925.namprd19.prod.outlook.com (2603:10b6:8:163::21)
 by LV0PR19MB9212.namprd19.prod.outlook.com (2603:10b6:408:327::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 09:33:45 +0000
Received: from DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b]) by DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 09:33:45 +0000
From: Long Zhao <longzhao@ambarella.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Linus Walleij
	<linusw@kernel.org>,
        =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75
 quirks
Thread-Topic: [EXT] Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75
 quirks
Thread-Index: AQHdK8rJqEyvvmBX2k6AaNQ3MZd5ibadRgxA
Date: Fri, 14 Aug 2026 09:33:45 +0000
Message-ID:
 <DS0PR19MB7925F03452B896607C0B8F43DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
 <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
 <an7YKyVbe1YDtyL_@ashevche-desk.local>
In-Reply-To: <an7YKyVbe1YDtyL_@ashevche-desk.local>
Accept-Language: en-US, zh-CN, en-001
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7925:EE_|LV0PR19MB9212:EE_
x-ms-office365-filtering-correlation-id: 5ed48327-a0c4-4f9e-7823-08def9e7231f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|6133799003|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 iDPYNxa2bq7Ptf9Ppl6FOZ7w1YBLpF3mjZaPRYp4gSC2IAJKKw3GoGYuevlq5pWKo37uvBJvSMSMxj92sLFVZDXMKj7IlU5+iW7FhgugWiCS07WQMnmc7m4ahUPhgD93RkxnzR+HziJTheBGuJCk/eVPqmFVZ+9oy5jwKC5ALyi9ZVGePPZFz76LGUlgt4TxdTB4K0sw69ybebdKcJYWIIYvr0LVB8l5qHTvY955t7fjZIGrSEJBRFbyOOEcKGWAxWMLFDFJkYrSK4kw0JQixD8LG/QkKfT03P5ZvY7BwvfxYv1AIQPwIG1iz6+31rHQPWRoZajHXZPP+u6ulOyeOt24OCiA+mgBC6eJShaGN0Zz4wSMvxoKKk1nJqV7MPz5gXhZzXzUb+/5Ow1hGT2U7b1OeK17jb0O7jFGLujjty9Ow3euBaFFV1ldj7IMz5fMPcFYVHthC+UEMHD/hMU770eQ4p0Xm1j+IOsSIQ2czJUW1HBJMP2fSXVe8kKf/AppnO0PkKFiVW6YzJ7rzJmKWhnvqugB2Q34W/vuZHmFMU1oP0LGNv0Ywsky8XXR5p7Z4ntK9DCyfcNm86/DoOrtPSTGtaLb6WMbbeQn08AV7fJYYTY+0uWxzygaTz/ROWPsf9DveDazTDob25iin44ith1A7N5MaQSmQHbSSm5cI70IqG6pmqlMfDpndVICCJZKreI8kIU1I5sfXHcCxWkU4Y/s27TaqnyxsK+sqApFuU0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7925.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gmpfm5gO70B3RkzmrDR8c6v2PEpEdgOyLOQBKDK4i87o0EZKbBeJcSnS2o?=
 =?iso-8859-1?Q?jilz1o8LWLqxoB1uQArse0Itv1ZzLWO6wUr/c5tb5tI5jQ2ChTQs464NA9?=
 =?iso-8859-1?Q?Fqtu23xFr2qDBAfgXaLUED5stxZeRKFLOAK3fDG9rV73ykJ3vdOrE0DNTC?=
 =?iso-8859-1?Q?8tHhklB7zREYuU2x9Ddg2q/HIHSGRW0jUpwDD4yvy2bOcArAEDPhc6S/p9?=
 =?iso-8859-1?Q?8/M7HfoixyztkOxqjaigCPsFH8hwcDffOL02HsrTrs/fhAmQtCWcxf9AeJ?=
 =?iso-8859-1?Q?vkpeblTjFc5xPXsGVFVZtc0oAd+BAtBCos+MSi2Q+0gyIkqLSXYcDinoTl?=
 =?iso-8859-1?Q?Xb7Sys+EwYIFgLrMNFRfp4FfH4fN24kFC65ozTdt/OeChgLH8RRWcl8fz0?=
 =?iso-8859-1?Q?CEDGyFP43ctGSOjB9qfzRtTF+viveGPCrJyZv5awHnj7InPVw7sCIVQnn7?=
 =?iso-8859-1?Q?b4XZHIF/mleK7LzgLd90/t5+HnVOoL2+Eg6UZggnumuInvDfOiRv0L0oJo?=
 =?iso-8859-1?Q?d18hAPq5eEf5rJiVpmX586MYmzrDC1+e7od9S58rbMQ9yGf0N8bcH4Tu3O?=
 =?iso-8859-1?Q?/PdGK3HZM0Q2pT1z6cYUap+Z44Duf03QU8U9mJ0kCgP15e03AqsUCfhEpZ?=
 =?iso-8859-1?Q?qVxkxksOHrLuYTTS5vkxgNFBqEAVAEYJyfCbxMPOdnscgCxHaCtxbRWT+j?=
 =?iso-8859-1?Q?DrrqN0r6sH8vH9ZWN57BbjGyVspLiQcBNt8a0+9QTzJBHpI0exxk6Y6m9D?=
 =?iso-8859-1?Q?86JOsWlkeYsU3jJRU+pBxjecJ2WEI8JbnGLG12fACIf2aAwsVuP5vC/uFZ?=
 =?iso-8859-1?Q?dpDtx1/qDpd3mXyp07m2DjOdvi9MS2PVq6zq8DOQDDjlg7+ZmU5TZ3eAvO?=
 =?iso-8859-1?Q?30tHGsfVbbXWdG64vZc1weuuUG8i9yWcf/BLzdIFVg8ryLbSNYNQPOkcrX?=
 =?iso-8859-1?Q?VTHS5paXS/EK70DiK7RZ405AXL0c5JcBILy11+625byOAd/rVrOnUkmsQV?=
 =?iso-8859-1?Q?sHWbHOiefWFpThpOvJmXaV+A52fK+EHIwLOPquTRop1OvEo/Kslz8rQMRp?=
 =?iso-8859-1?Q?z3w+HQuw7UgjvgMnalLi6XvClIImYTztsmjJY4va4lvcMM0KxTqaK2BesA?=
 =?iso-8859-1?Q?RHM1gtaA5WFwzhZt6NOlHjQu45+/bRX+kL3o0ZYudq1+TPO6LCiLimEUHo?=
 =?iso-8859-1?Q?019pzUZBOBlmh8VdKgKr20Pdy1OB3ggnWCQVh+UaxbHdS5CuF0/Rnv65t1?=
 =?iso-8859-1?Q?FSq+59Sjhw58ufdWZhDNCBgAqM7eYVsUjsA9lSfkG7aI2HvwMDjWb8m+yU?=
 =?iso-8859-1?Q?/YaGGqY4M7pT9w/x83eMv76Px7uR0gHLUFO7LkrgptyYtjyiTY+nXKPnVR?=
 =?iso-8859-1?Q?f4EQNdhvZKAksBSanR1aeSczthCB2qluMd39X9OvR9417E502huziQRZRF?=
 =?iso-8859-1?Q?ezIhtRQn8l/LNWtMMYGLDl9x0xlX+IL95+UtxxGBOVr5nipPr8FzEiCVIo?=
 =?iso-8859-1?Q?+A1PilRVXDz88C7pTuwBKdZCa7S3b9zc7QyNfVDXDdEPMLYM1AvCSFFLIr?=
 =?iso-8859-1?Q?UMRouURV21qIbyBWYpAT/fg+kiVY/BtEno98tiUfPf1BP3y8+pGK3wKX4Z?=
 =?iso-8859-1?Q?5Tg+RLbA5X9phXr5JHuilwpmyb7vhKX/eX1xjaA1G3GvpmB5q7pn/+Iw5u?=
 =?iso-8859-1?Q?PiY/SAYBiJMEOdBk4KKRC+3Oj1yZDb8eoOzO/pm353EqGYDUu88MNF40Gy?=
 =?iso-8859-1?Q?zXK9L0yTEnLnWtatjhKTxSR5nuZPLpQxYIIwjc868QgqBLiPSJJw75zRHX?=
 =?iso-8859-1?Q?Bbie560fJQ=3D=3D?=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fRzD1ypEiFzBvH/AFqSVUZqMD0oDy0KuspY9k5GajT+hybWhAS+o/sFbpjZZaCTxDvups/dC2jk1TrGKVBsIknChvhSr4xXxsqnp6TSmwGsSuWBl8brl4DRChxx7Zz3lrGVgAf1YSmv+xJaIwFjPn9RxgTqcrH47Ooagv+iFkCwSzpFj1y0ocg3f8VrMxE8RSYwHD9zdAhPSMTbZL334inaEbC45tXDsRVZtOQ/vGfxq8AAUTOHyIHTEsTDgr7uMH9mBMRKmDBBkYB75Y4nTF8ecyw34BsgcXvE9OwACBn3Eu72f3JY1PB1BnihMuaOoXQiFQHe3DL+KNBchU/2Xxw==
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7925.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed48327-a0c4-4f9e-7823-08def9e7231f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 09:33:45.4910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmP0iHQjPkW3pYQfKFWzhCSt12B1wfa2gXdix6dvAe0C6kmis6DEXyv4bB6qmD0Qdi7ASISiKzrSP/rfPnz0UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR19MB9212
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3MiBTYWx0ZWRfXyJmZK+LTPq+y
 LLIrPBX2M2al6hbKoYpOjwZSWhMQ821LoVbnALcLiTd6Z3NKZOd3SGTHkK9ZEmVbSiJAiaI2TRN
 FLL/UniEqkIRTqcWQ2WmfUP4jkTAUhaYCUCiFb+mMbeUmGh01ktqFydqO/jT3LPXmNCJF2EL5sn
 ApAX5gNh+hfht9AOPNvrqgJ8QjAj2oHVDtLGgiMG/CYuN2xLTrVBzpMnHwfQiVTL/7aFQIhk2ha
 8ilKZP0O+b6wpEPio5ONsKB9rECZ4yFSxnttwIU7GZphxWomds6/SDgBnJjN+WYFE1iN0mN7AbZ
 gwqjECYGFftRpQO0N5tJCkkpWiaFuugrZkptwJzm5aRjuUSMPusdELl753W56y2jD9pvnIiFVwl
 TYM45yAA7HvbkpuCZJw04c9UWNGDVa8lKwSdjvHFq2QqRPrGg3S7Zk21YLNU0yb6sZklUAe4vxI
 i/PaIY8nTQ/qY+dV+Nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3MiBTYWx0ZWRfX0yzdq5lXj67V
 uvkM6OBJ2QCAMOMrBs5N0Upg9fOkv7Y+NUgr1ojSY0wVC3rS/SGxw4A2Enh5/8i5PRHD0ADcQc0
 Gw1SoCam0fF5YXECPKSsYVvjXE4n8hTN3zKsLVbzCs8jfwHgzqfq
X-Proofpoint-ORIG-GUID: SEvxdop35SSU5zqUdHFKN9U9_KGMZnK7
X-Authority-Analysis: v=2.4 cv=C4fZDwP+ c=1 sm=1 tr=0 ts=6a7ee0fd cx=c_pps
 a=PUkDgjY5UzxrOFLFu0zltw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Sv0fKeRqtYgA:10 a=dkMdDuzY2HgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yXVIz-0bn9infC194UBj:22 a=KblO7da7ppA7TBl3N-nE:22 a=QyXUC8HyAAAA:8
 a=ppJngBeKAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=vPOuiw2XS82xL9b-0CYA:9
 a=wPNLvfGTeEIA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: SEvxdop35SSU5zqUdHFKN9U9_KGMZnK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140072
Content-Type: text/plain; charset="iso-8859-1"

Hi Andy,

Thanks for the review. Agreed the commit message was too brief.

This is not a silicon erratum. The Ambarella UART is not Synopsys
DesignWare IP; it is an Ambarella 8250-compatible UART. We still use
the snps-dw-apb-uart binding / 8250_dw because the programming model
matches closely enough, with two quirks (ETOI IER bit and
SKIP_SET_RATE). I will expand the commit message and rewrite the
comment to explain why in the next revision.

Best regards!
Long Zhao

Ambarella Shanghai Co., Ltd
-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
Sent: Friday, August 14, 2026 16:56
To: Long Zhao <longzhao@ambarella.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@=
kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@ke=
rnel.org>; Conor Dooley <conor+dt@kernel.org>; Linus Walleij <linusw@kernel=
.org>; Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>; linux-kernel@vger.k=
ernel.org; linux-serial@vger.kernel.org; devicetree@vger.kernel.org
Subject: [EXT] Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75 quirks

On Thu, Aug 13, 2026 at 06:35:13PM +0800, Long Zhao via B4 Relay wrote:

> Add CV75 platform data with an ETOI IER mask and skip-set-rate so the=20
> DesignWare 8250 driver can drive the Ambarella UART for console use.

...

> +	/* Keep variant-specific bits in the shadow across subsequent=20
> +updates. */

This says what code is doing. Instead it must say "why?" the code is doing =
this.

> +	up->ier |=3D d->pdata->ier_mask;
> +	serial_port_out(p, UART_IER, up->ier);

...

In case there is an HW bug, where can we get the errata, please? (For a bar=
e minimum add a reference to the Errata document you give to the customers.)

--
With Best Regards,
Andy Shevchenko



######################################################################
This EXTERNAL email has been scanned by Proofpoint Email Protect service.

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
