Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6672D29DF;
	Wed, 13 Aug 2025 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067913; cv=fail; b=d9QbwVwby7Te0kT92IEgQOws2VXito/WZuytnmC84IvrnWA6mJgMEKgK69qBrTEJirRVMWiB2Y0ar06RFXBCfV9OHc28IY6Rr3ncdv01ykTJTDpzA2rMUUqlZUfamaKbM2lVf3HLBplr8BSyTAzei00NOgE9IwEl2GDXQ9IJwfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067913; c=relaxed/simple;
	bh=N8xu8d8iP96G9XxdY29WNjb0orHBW8LtNpeq/mVOVRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c0xpVzRK8cDx2a8sppdwL7grkj6m19S2ZFDaFKa8/Z8zUvLsgKD1Kb4u5RdOlzD6ikVq4nDBTvjNonj5vsnmMhFOjVB3kaeV3aPFxlcW0uugosstrp5JdZnoOnr9Za2sTDPLNsqEl6EfDZeXah+ktiSYepss/dzbuz1EElO9ibs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UIxnuLQl; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UIxnuLQl"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mSV4027154;
	Wed, 13 Aug 2025 06:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2koBAvKGbWji57e26BuHDmgnn+S1Vi+lkJAMeI6EQQo=; b=UIxnuLQl0QyW4F7V
	u5RWza1H5IwGSw8V/n0z0AfvqEINXMD0NWaptw+YHJo4aWnETilv33aRSfWHC9G0
	Yha+1hC1Z3A4MwlqKyK1pIV4yrjFs8xXgqMivyyoHLtrvEHjLd/YVm76YxubwsIO
	4p18ajTcdzGrOdMZN/pKtAZEEfNCUjLRTMzUVblumzTkagy/gQb/KlhTgvejaacJ
	rsToF4gWmPlBbV9aT7+TnRAH1lEwMsmoS/E78XStDI/tnfFUOW0i11KAJqx32LRX
	tSc0U1UcYdPtykDmB6+ARuDgKyfssb5M6J3MbBYh2q/JqfP6AVC/fOiLj6wR57ql
	tp0eNQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g5hmaqgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 06:51:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKRT2z3fFm02HlXWEAGvP3DLnVDJOhlIMovxKmW4/luqJ4+t+OzBZ78dOM89Dv6bRpHPiSZTZA/R2keKNIC3wHw1B7El+mjUInDOsrm7GobPvNMWfIMpLcsx02iW8C/c81KtTPvVi8WUOF5Gg8j7yc19afI7wyIrDTPjjwJF1eKMYgukDfX+51+2ebdMtXX52N6XvRTrqii5otM52BrOIdz/xz2G95xWXkAm1PDDJxL3FSclzpswpgsjgF3aSmLfwZ3aBS+dtH6+oOXUXw5cpg/bpd4VHYS8D7MZ1+XekVEEWJVVvNOseiuGe4rHfQj13ldvM9Ma3EMJltX19DvFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2koBAvKGbWji57e26BuHDmgnn+S1Vi+lkJAMeI6EQQo=;
 b=fEdaJYrMktwr/rDCYl86+nV6UihI8mrf64IjdYdleOmKFJiNA6UXlvYWGtDSsEJRsKTFKAXk43eKMzjHyYZp0j4ss6RcyWfmYq8deDka2wMEVxBDVmzdSyVHP18X0qWV0CPgU//q9qvp4+s94fV8HJxe/YpaYekXCckpJCD/xNoZXSqOySGBjbRLOdvJ93T1WWkdBEwItsHxqtV3XFIG06VhR7QBguv45IruCMEZSVj1prxzXIEXK9DrLvMGlHdICdF7aGG8KX/QGgmCPQsBU5HqDbH3A0Pau1kEk97xKe8xsJ+n0X/DgwcqHJ0Xdrs8tnYovDi3XynWq5xRE68qXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DS2PR02MB10798.namprd02.prod.outlook.com (2603:10b6:8:2af::14)
 by SA3PR02MB10044.namprd02.prod.outlook.com (2603:10b6:806:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 06:51:47 +0000
Received: from DS2PR02MB10798.namprd02.prod.outlook.com
 ([fe80::6af8:4cc6:4d36:85ee]) by DS2PR02MB10798.namprd02.prod.outlook.com
 ([fe80::6af8:4cc6:4d36:85ee%5]) with mapi id 15.20.9009.013; Wed, 13 Aug 2025
 06:51:47 +0000
From: "Zong Jiang (QUIC)" <quic_zongjian@quicinc.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhiqiang Tu
 (QUIC)" <quic_ztu@quicinc.com>,
        "Anup Kulkarni (QUIC)"
	<quic_anupkulk@quicinc.com>,
        "Mukesh Savaliya (QUIC)"
	<quic_msavaliy@quicinc.com>,
        "Viken Dadhaniya (QUIC)"
	<quic_vdadhani@quicinc.com>,
        "Haixu Cui (QUIC)" <quic_haixcui@quicinc.com>
Subject: RE: [PATCH 2/2] serial: qcom-geni: Make UART port count configurable
 via Kconfig
Thread-Topic: [PATCH 2/2] serial: qcom-geni: Make UART port count configurable
 via Kconfig
Thread-Index: AQHcC0zJFClPQDhsWECqX9fXGOcldrRejnAAgAGYbIA=
Date: Wed, 13 Aug 2025 06:51:47 +0000
Message-ID:
 <DS2PR02MB10798ECB1FF918313884D3117E22AA@DS2PR02MB10798.namprd02.prod.outlook.com>
References: <20250812054819.3748649-1-quic_zongjian@quicinc.com>
 <20250812054819.3748649-3-quic_zongjian@quicinc.com>
 <2025081249-amusement-spongy-e052@gregkh>
In-Reply-To: <2025081249-amusement-spongy-e052@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR02MB10798:EE_|SA3PR02MB10044:EE_
x-ms-office365-filtering-correlation-id: 6ad719d7-ff94-4380-53e1-08ddda35df6e
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mwJkZjwMlRVXOB1HQXp0m4x/5cizjznvgFuO/hxQToa6jPheRSK53Lbb5C33?=
 =?us-ascii?Q?nGX4wY8CIzBxPTgn3oQiVAI1Dxl3XThHPgozki4l9Oklh7Cy3r+NWbpAtrXy?=
 =?us-ascii?Q?9XUwRN2snHMSRQtnqGlz5hm8eQopEPt+HRhOu3w6VTxr2Uz3BsYbeDDTqiNz?=
 =?us-ascii?Q?HR2gz+bYdxHQnSMeaGWRUBqsNetgbc0iI0mb92AuWTFw5hQBK+OIJXeftJEV?=
 =?us-ascii?Q?apKOzItTIjuX+53sZ2m904MdrXourDxWtog91UrITX/peU70t9EvoQ4AjkW+?=
 =?us-ascii?Q?vHuSwynSZ0EWJwp7p5+LfvYwG5YsUfWnLM/pRj+d/SmAsUZCixi4atBtsTiv?=
 =?us-ascii?Q?2iJs5kbMhVkS/sJZFcS95JPZEHnADEY47wO+Hg5d7NXwK2h5hd2AyUm8DxPi?=
 =?us-ascii?Q?Cl0yl66b/f03J4fO9vI4dujeysotsE8gf8DvOpg7kYQloygyUy+rlyBmkpVY?=
 =?us-ascii?Q?iIK+WK3fDDl/5q4zGqTQoLapY7jeo3z1RpVYr2bEPXFI1HCtj4dFwzh/gQPo?=
 =?us-ascii?Q?RfHtlcw5xPFgZOkvLQF2r70fYplFW+AlOa+qt6Lubn+dbS4FyfLEskOe3bMm?=
 =?us-ascii?Q?3n/Io4JtIr0XwCJ1aBHDu/xcJdL7XFyh1Yll0ucbiUExx2Yt3x30IcX2H1Bk?=
 =?us-ascii?Q?hVNd0R1rXB1wNyl/M8m06o6+Xyy8ClG5BN85MVB1UX/S+x7tnPUm8gYRYogs?=
 =?us-ascii?Q?DKRbVg8ruN9vF9YGGlbWeqKp6LqSwUGM/AKeeTJtGpr94k4epIHTOFX3BtwU?=
 =?us-ascii?Q?MX553vTOlSypHueYpo5oQiYkTudzJwp/azHyrQOEPbfnZYNDbIzQ48FYvNr9?=
 =?us-ascii?Q?NTpa5l+G/NazPEY5TS7maHyUIR1odJsZK0NC+kzc0a7pcHNRue+Bgqxbdl09?=
 =?us-ascii?Q?mq/0EZ13YdPXEFJBrVw8iJK3kwzCPywQiHs0I1SiexS7+APZbURshiLRNg0D?=
 =?us-ascii?Q?wnZm/zwN35lt6NeFi7SpRwep1W22MSmy4HxvDT3Xg1sSSh4cYOvSFHDQZ1UO?=
 =?us-ascii?Q?oPJnFpLAJPMYSXrwxq3tiU+vKWXHQPb8++c4+Xlrcy3WFMKj4JiOHctDpDRh?=
 =?us-ascii?Q?usLIVfbqx4Pv7qktXjfJV0HH2wzIS/wI+4xImbDuuY5BB0PQccqIaySAXRRm?=
 =?us-ascii?Q?/Iy1qt5wlc+boFVAcy2W/w5l5EJOaHaZdGxkh9VKFP001q+G/FDITy9WoHkv?=
 =?us-ascii?Q?gEUjNcFL9HsFM/XBqVQ/+pq2I9Jtj2CUIWG7Zr5q0GG6taky7ksTWtWhWkop?=
 =?us-ascii?Q?UCPm2R2UhCKZX0/+yn6L7n7IKv3rvW2kdFHuGhMU0nj3C+O0aeGcGVEutSoS?=
 =?us-ascii?Q?nl6j18DG3TXRf+WrGcSDbOrHMeUaUJnZFpsFmW/1YFB5sLClDvwH/wJ0Y4+1?=
 =?us-ascii?Q?SiB7a9ItGaHZqsb9CAQ53FvhhTc66aydZQTEhRpvrNbaR2WYkaPQTTbNh+BB?=
 =?us-ascii?Q?1osJ1Tx0bRpYYDkcRlirvvhuZ3ukhLRWhcw6gcnFE5ylO4n4aeFzzX42TQ/a?=
 =?us-ascii?Q?PeB9qurEeOUMMxM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR02MB10798.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PXUNuKZt81k/l12mLemG11nXrGdHvIUVVGgWGAExXR6BcSYJB3G1lDyxk0uN?=
 =?us-ascii?Q?tO2WY3z8J6Wnd5cx0Cwq8Ye4r1ZVBHhm3JeyIm1XkLL6zVuYp4hq1utZaHVN?=
 =?us-ascii?Q?m6n5OFU/0ufPMLKHK7lM842fcqRSusza/TZU/Pj9ftSI0JVndEPNTSyRELBJ?=
 =?us-ascii?Q?XZNPYnlnQtZ3ivWYLi0N+a0vvIHsEnbmO1OrqHq4mHNiPRYb4IuS0ka58cXU?=
 =?us-ascii?Q?i1M66PNicEKEP04KPDPpw/jk1QYhIwMXcDqwkWmFYDmpPKER6eowhavBSHNp?=
 =?us-ascii?Q?yi48ftzXECmp+Y3XkGJmCoHeC5EIXcKIJqshghwmgTAvXA/VYUfBFTSyzqH4?=
 =?us-ascii?Q?bWLTh7hG9v1fK6m7b1KgCTBAaEoG9ZYqATC7QSbAUapUiQwPMQKrYsFjTyLA?=
 =?us-ascii?Q?nLt/3EmH8BaUkAr+/225Ihb9pyIDev5R7fxsNWOxXnkRZ6BemX/QoH/o+u6q?=
 =?us-ascii?Q?WGqYal9/MB3z1vlh7I27ZKB9N3khKpBBHL7O1ayZFgHzVnFfw3apyga/gsg9?=
 =?us-ascii?Q?LgsDW4F7XNg3IOv7ZzFvVtC1aTs+4r/oKaQ8iGsHEm/426hPuVSHPlK7YmTX?=
 =?us-ascii?Q?z+uI7CR8LMF39NBGaUMJf8Y4H2AY5+n+WroQR3RePVu1SH15vmoavFVQusog?=
 =?us-ascii?Q?aDb5RYUz91D0gqX7WpMzvQ+ARoVnVdpgTG/+7EY1ty06xJQ92PAdy87DV01e?=
 =?us-ascii?Q?3bkH2XtcHiEDl3tuGYBoJL+VoqhAR6cPKrUzfDVo7Mwj+MqN4t3SMRrvLAQB?=
 =?us-ascii?Q?i2lR/tX8l65He34DRbPuCyrJ7dQWkXi9XgZK8KmzCpC+VbKORl9W0q3n9+1b?=
 =?us-ascii?Q?VXPC9/Tuk0/VkGKIMuVf4JzHkqYcJM4j0NOcFXR1DHpJChVwXxjAbWfLZcZe?=
 =?us-ascii?Q?xD9X2k6u/i+gqBLvO/Gs5nJsJDRzDzom8e0LVtcVr/PXQv/uYsQiAsmlRrX4?=
 =?us-ascii?Q?J1wCajOkU9c7np7jwQRAYazN+7vc3G7stW+ItLq3FLrHiW6HpTF+RDW8Yxzz?=
 =?us-ascii?Q?sCSBf8BQrBWb2thz14OSGu8hrX0XElFNcOdb0JdEfWMkMqKC6GcUgBUM2wEg?=
 =?us-ascii?Q?3VgN0VFJzUIai/GXg62R3v+MtFF9H7V8fRKms7+6SX/nNEEcqPZS/h/QSbnz?=
 =?us-ascii?Q?LITwt0LrIZl6uSduCZ7QZYtPtjRE1ymnpWDhsLuwKhkYiALSL4/4F/KP6Px1?=
 =?us-ascii?Q?xhmKTOhFxH63I24GbNYChMRLlc4Q8lZT9ccZomDEzsn6b/zwhA9BSbgQL6C2?=
 =?us-ascii?Q?+VR5CJbDPxHVEfcVQLVbSU3iuEVGFTytvLiHJ3DVSqXypZzfy4Jzn/d7zy0P?=
 =?us-ascii?Q?wmVko2rsTeN2CgugmSfLpFjC5Tq8g3BoKUVrachTkjFU+Y6LcZsGohl3KuMb?=
 =?us-ascii?Q?xAyyCtIyNrSVbKLcpJ+YPEX6aLVu+c/y4XH4+HO16BEd5J5ZPmnLcS1LmDOT?=
 =?us-ascii?Q?JwLNt6Czim9UDn3OznMiTxzvcFjCkS1T+8q2KpTDCPV3sSf1m+noqY4N76T0?=
 =?us-ascii?Q?VDf6o8eldRrHBDNSOeFkcpqnen4tto3KNzUkDnll8kEzKFWeBKpMCC4A9/cp?=
 =?us-ascii?Q?ACJdko30d+xMAGsX65yaB18dATi76Bg0cHkqHt4U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sqs10tELkdI/SlUBEG1mnKazpu8GV4YxqMDvE35Thm+2SXSX2Y2pV3pNCMhNjeFK5Y1BJmsGt5Nv1ZBbN8rk1asCw2DPN55rUj6GDvITWFm7bv0Lj5J91/4HM57VOMh+VDQU4/njvb6zOq9duJZ2AZOZMndFQEdOCjWgoOKKMEBRRZx0Uapl65cRq9HBt3pLmCyoZ4+C4xgA4zEjfpRlnKW7A4aokwy3c4O5pgoiAVsDRlcMO8as46uYOw2a+aVFK0LOqh6I3sT2kUI5lyc/yRCalpGdPcWAF3oRWG3ZgHZmNDDJccZjU1LH9GWolv7/eE3FP+BlbjnGnJqNjeb66qMA6feSuLNyOfbEOxj8PmAG6rvtIlJwy46kT6mjH60JRIQMtOkaMG9gaM73zzn1WjDeek32QzfZhCMTMkLGahfjWY3IDp997VBZJeh9oPMhun5r0AlBvB2GWuEeC5zSePKSGW+tDnBRyGLJAp0v6JNDc/gQvIqZRwbZOcLSpJRqAv2Thwg58Fu91ArzbBtbpnmDuRiKTp9DkTdo8YJO5pbJkTpntDEW+xRUIWSRpJsNFAFbe2xg5FBn08go85n7KEYH7h/tSq6fZVXyE6nN3qZh+34DChyG375pUvSHUxAn
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS2PR02MB10798.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad719d7-ff94-4380-53e1-08ddda35df6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 06:51:47.2601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVX5BvKwB99pGAjuMoEdu2NoT1zD3qYXSbBq5SNpJnY08xFK3zR0R4sxzlyPpOH+H2HwWOi1rOaGLC+fNZdST0jkSdxxFsEqPah+ordkO6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10044
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExOSBTYWx0ZWRfX59omw6L1ICz2
 dO1wjozCQxwV5JHXrdbBY0jsoh8LCC8Ey4b3Df4NaPV+LRUrVnYD9oBwnsOLg8xMkN/zVrMBJ6z
 JeBAlHN+4ce/Jg6lEZHtO0lHA7hFdHuv722LxxVnW9061xN7t+0nIKRHESu/7768lLLD2U3rssz
 YFNBelF+1eJmTtBb9TkopFINHxM+zp+svAHL1Y0pp8AArllYkMhIW1pcDje1nFzCu/B9ZHFLv3z
 BcBiLHEfN4F1b6ZCtZ/u2JeIPstlK7QqunVu1pvMZJiJqIgbPZC/ozxYY1nLhM8YBShV7iHiQB4
 koK6BUxdUgb/xDqv1mqQVTk34LtZU3YH0nNywW7q00TEsawbugm0g4wul8r3afekeLFBtE+QuI3
 nQuzNzXP
X-Proofpoint-GUID: 3XmWwEaStf_SW5Cjixd4zq4rwAgRFOuM
X-Proofpoint-ORIG-GUID: 3XmWwEaStf_SW5Cjixd4zq4rwAgRFOuM
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=689c3606 cx=c_pps
 a=b6GhQBMDPEYsGtK7UrBDFg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=ag1SF4gXAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=taqSGkpNt2JQK956f44A:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120119

Hi Greg,

Thanks for the question!

Yes, this is indeed due to a restriction in the serial core. Specifically, =
the serial core requires the uart_driver->nr field to be set at registratio=
n time via uart_register_driver(). This value determines how many uart_port=
 slots are allocated internally, it cannot be changed dynamically afterward=
. As a result, we need to define the maximum number of ports up front.

By making this configurable via Kconfig, platforms can tailor the driver to=
 match their actual hardware needs, avoiding unnecessary allocation for unu=
sed ports while still complying with the serial core's expectations.

Thanks again for the feedback!

Best regards,
Zong Jiang


-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Tuesday, August 12, 2025 2:30 PM
To: Zong Jiang (QUIC) <quic_zongjian@quicinc.com>
Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; Zhiqiang Tu=
 (QUIC) <quic_ztu@quicinc.com>; Anup Kulkarni (QUIC) <quic_anupkulk@quicinc=
.com>; Mukesh Savaliya (QUIC) <quic_msavaliy@quicinc.com>; Viken Dadhaniya =
(QUIC) <quic_vdadhani@quicinc.com>
Subject: Re: [PATCH 2/2] serial: qcom-geni: Make UART port count configurab=
le via Kconfig

On Tue, Aug 12, 2025 at 01:48:19PM +0800, Zong Jiang wrote:
> Replace the hardcoded GENI_UART_PORTS macro with a new Kconfig option=20
> SERIAL_QCOM_GENI_UART_PORTS to allow platforms to configure the=20
> maximum number of UART ports supported by the driver at build time.
>=20
> This improves flexibility for platforms that require more than the=20
> previously fixed number of UART ports, and avoids unnecessary=20
> allocation for unused ports.
>=20
> Signed-off-by: Zong Jiang <quic_zongjian@quicinc.com>
> ---
>  drivers/tty/serial/Kconfig            | 8 ++++++++
>  drivers/tty/serial/qcom_geni_serial.c | 5 ++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig=20
> index 44427415a80d..e661f5951f55 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -928,6 +928,14 @@ config SERIAL_QCOM_GENI_CONSOLE
>  	  Serial console driver for Qualcomm Technologies Inc's GENI based
>  	  QUP hardware.
> =20
> +config SERIAL_QCOM_GENI_UART_PORTS
> +	int "Maximum number of GENI UART ports"
> +	depends on SERIAL_QCOM_GENI
> +	default "8"
> +	help
> +	  Set this to the maximum number of serial ports you want the driver
> +	  to support.

Why do you need a static number of ports at all?  Why not just handle how e=
ver many there are in the system at the moment?  Or is this due to some res=
triction in the serial core that requires this?

thanks,

greg k-h
