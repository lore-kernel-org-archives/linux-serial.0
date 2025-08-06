Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B3223311
	for <linux-serial@vger.kernel.org>; Wed,  6 Aug 2025 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470664; cv=fail; b=VWc14sy4jJPG485PVvvJPeDPFCyUNvETc4JiNGht8oRmRIlrHkk32U67jDxjfgXqfTSZEHqTc8KtFhKF1ImTbXw/0hir/D22+BdVySQmtlTdFRqX4ge3egZtL5AjwTWu2jDDz1PvY/zY7hXdCrKf+pCn2sN99vrVEHfjW234WL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470664; c=relaxed/simple;
	bh=Cgf6YOImLum4TFC2kzy45HaaKBvZTo4gOqumN5QqLyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WCJqYTzriK8SYc+Il8PWK4lLnYjbvquclVxCKiyrD4f0M3uPdJeVYjK9WmzZ9JKSB0tavfiBCnfgXvmkQyUm1tq2ls/wLYVhdTOqGfti+oJXMKILknAbNZBmlsp2U74IxmkmD6vnZOI+aQNd+wT3JgDylO2wvS+Oavx4hjlx1BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lrH61G5P; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lrH61G5P"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765wnf0025091
	for <linux-serial@vger.kernel.org>; Wed, 6 Aug 2025 08:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SitvpZbx8kYNXxBYVXfo4at+FZbJdniiBbGLZSW4uXg=; b=lrH61G5Pb+aZomY4
	IxMj+BEMlfFMY/pdwl/h/NkWu/Lrreix4HWhrpaXrQG9AmQeOgRzMwVnI40wRNSE
	CvK4Vyb0Ow4tx1lM9XTgc0qZJUbaztbzzQxU3TI/V0x/i2tXcxkKBPmv4jrIDp6v
	XWVM/5UGJXII8f6BLVdihk6O1tRbx/rBzOlVUeei3b6x/Djm1bU0dy8w1XpIlBVA
	l4w07W40Mz+2i2DLOgb+2686fY/jeDCtX6VzR++1WUJKzvF77EzYuLUuGuw4sy+0
	u2PhAEGdq2ORh73QHq/ZiM5piCCthK51uD3luVklaK6u1f698AhFizy6o9pPWxyF
	lsqHOQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpyaa0ug-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 06 Aug 2025 08:57:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDFBbxGXGsrgBDIWD1vBZYh4kDY73DK0i8KxJTYIUkghP0UpyGpr4ATZf4JhNpAQe6EPDDWIw1MV3tdiybT18bSQG+SiHPH+tYZFmMJ+zhr3furuZxNB3PuyOaOKvDUL1ddOCrrWnzC0dS5FLL42EeK7jAx/SjDQSUj2+nunnvOTphomA4+uNxFTbmm8bqqSTbTuWTj/B4HkhmMzuy0ANKFAboMRsVBjN00/IfOdUfonoMUFFv+iTvqTmt1dxpq1YfB2BY0+Cpp/uTvDM2OVyenlF9O2q+FS1D8tauXRlqZJeGa49Vt8+yD2wnjW6l2C/heC/1BPtsHa/RXUlk56+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SitvpZbx8kYNXxBYVXfo4at+FZbJdniiBbGLZSW4uXg=;
 b=aBInTnozkTxjyw0hcIhl9yDBQJCgDIRLaB3kPMHlJkdOf81UmWWtQUEYG3UvJkv+d66E0O2x3XLA/9+eSZUo7xKnSqzrsBlLIQQ4zP9+w9NZkQoXzoGPjBryL7J3R+faA1t3hYtIdHFxarGjFRQlBO/RYQ2qCb7XLrD2PVTwH5Llz74RnTkBCAKxRRC/gSIujVhDZnPmSMQ3IuGfW+XgL12YllKKglGCqbQiGSTWiA2oFQVdmf5xIse4cVwyHyiIWVUKnInVGOeufCxKwl7Qw7rqDml4HXBQqXQ3Lt5KEsefTUlEc8b5pGQCLZLvPRRQ3tDZWqwKRG3n/6pOWZ4Rvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BY1PR02MB10379.namprd02.prod.outlook.com
 (2603:10b6:a03:5a5::17) by DM4PR02MB9056.namprd02.prod.outlook.com
 (2603:10b6:8:8a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 08:57:38 +0000
Received: from BY1PR02MB10379.namprd02.prod.outlook.com
 ([fe80::884f:e582:c165:e24e]) by BY1PR02MB10379.namprd02.prod.outlook.com
 ([fe80::884f:e582:c165:e24e%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 08:57:37 +0000
From: "Anup Kulkarni (IOT_SW)" <anupkulk@qti.qualcomm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [bug report] serial: qcom-geni: Enable support for half-duplex
 mode
Thread-Topic: [bug report] serial: qcom-geni: Enable support for half-duplex
 mode
Thread-Index: AQHcAuU1vANKvGlvIEagwTm/obOSNbRVWdPg
Date: Wed, 6 Aug 2025 08:57:37 +0000
Message-ID:
 <BY1PR02MB1037986A9629853E3A98C5C3FE12DA@BY1PR02MB10379.namprd02.prod.outlook.com>
References: <aIy79bA8hhFXVSgR@stanley.mountain>
In-Reply-To: <aIy79bA8hhFXVSgR@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR02MB10379:EE_|DM4PR02MB9056:EE_
x-ms-office365-filtering-correlation-id: 6ac904e4-7e8c-4526-8abf-08ddd4c74afe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?30K4Xbm7myIdMNam274qIGDZvvi3BQV3xukhjnI261sbDKnGQ3mQiX0AE0o6?=
 =?us-ascii?Q?kcawdBRAPnMc57W3J6RaM6MT7dcaCSfvusKHwXKeA+Ha0DbVAuLGfVQ9Sov4?=
 =?us-ascii?Q?NBMvnu1PySW0ms2lTmxdATNBJZB395MYJ+SXRkhWgWjE/H82h93HgBo9uRHK?=
 =?us-ascii?Q?9CzmGi/H+/Aju9ApowvK7Puy61qUPNdMRLll5XjLP6JJlr8swqnFS0cKfI67?=
 =?us-ascii?Q?QFnNv87CJUWmn2Gufi4qfH48Xl2Kofw/d0e9lCHkr4Cle1ZK7T8RAztM9yur?=
 =?us-ascii?Q?X0kH0GPNKyUu10NxV7MhVy+Dxa62HAZSZaxahJ3D1Q8aiIZORwObtWUHoCGB?=
 =?us-ascii?Q?CzVL/zlZ5Vbu7c8PuDVsfW43sHdxoDodf6HNKRM5B8rFVeFqIlhBGUPODEIV?=
 =?us-ascii?Q?BRSeNdoMFj7yq+f7VZkxxZT0uifSP7wAta3HsAG474xF0jwv9Vmgk9GvGrwP?=
 =?us-ascii?Q?jCKRcrdxBqTYhHrK2MEwT3XrpA6sJTo1aOkN2HwMUx3erkrdKruqVPEIiLKc?=
 =?us-ascii?Q?IHSH/xWUjMuZKcrThHzpBDcgO+7/xJC43/AD66Bq+dYvn7VOtV8XPmOylDip?=
 =?us-ascii?Q?leyAn0ItiG9NxePpQ59DVi5ceM+t/nKno4CA2NNmyFp5NSJpa8pqYonZoSXm?=
 =?us-ascii?Q?Gm3fcva3sHLB5daFL9sSCMeQ7zJH9iCkHOQbRqdVV9UhWnjJe/JExOF+ZUKI?=
 =?us-ascii?Q?NsFk5CSU3p5dvOyCWJya7fziGJsR7K8KOfCCt2Oy81Aw5Z/5tBbTkAAoNSAv?=
 =?us-ascii?Q?AV+8tYT6CeWEv4zOsghEC91YN5fHCXFOpq2An1bSUpZXy24st/8hK+Zl8ZEo?=
 =?us-ascii?Q?3kw7NnxcmUl9Jm57s1xMbZqbN0RNd/zHp11V+QBu0AB2qeU3CoErT+omzw+g?=
 =?us-ascii?Q?krVs69RdhQ+oT8iTNubr9ZVKhbrttr0nwQWizBnsDeO1wjjw4hX6qsvFXVHg?=
 =?us-ascii?Q?7W/sQus0P7E/Dw4v/zFWJt8NCT1+gqTRGTICeGYswxITXfpdFHtO7vQtjmrb?=
 =?us-ascii?Q?rPL11EDarv39Z59d9F/lcnuKQNoKZKr3CWTXNw9Sdp8m6I3Zg+ficwPnGbYR?=
 =?us-ascii?Q?xsqsEvtPf/5z/9AiCEVwrzi9/IV+OLD6rxpfWXi+8s+AXvaoN9Zinc0iSqvf?=
 =?us-ascii?Q?4l/bypz9COLR30LDC72PzOVZV32wfk4nbV19v1Easi4ZhL3lRj/NcbS71d6m?=
 =?us-ascii?Q?UENn2WB1Evzg2Bvvaiq4KT150DjkOz73IhIlNmAgitge90Wh9teLMuSFCTij?=
 =?us-ascii?Q?I8omAk+rKG1sCe82v2XgOmeVRm5sdBzwLFMl2eoqrQtJu59Fam4Lvm655wS6?=
 =?us-ascii?Q?3kjmCZycUK9PW1YZZLsio327/i1Agls95YFFhzmPd3Ujp48Dt2BFjb591cnb?=
 =?us-ascii?Q?TcZjfXGAn8vXf7RXqzL+wrH4TKaZTOHZqWdIkCDv7erJBHdBkDC2W9ZEmzsh?=
 =?us-ascii?Q?eVYStU8T7j8KAlOcvV7Xo+tOpBcwGngK9+rqFh/UF0hVcO2F6CatgA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR02MB10379.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0H6Et8dvoUv/xeKcchjYkEbhZO7kKcnivXLhQ4dQYW3Mt8cZ7aQ8QrtZP6zB?=
 =?us-ascii?Q?vqo7DQOQgW6jMG18zt0HfSDlv6RDQojFwQwlv4+Lu1kEn1kLe+o6AmBVo0u/?=
 =?us-ascii?Q?zFDSmOvDT6BEncCWJQ5Zej3yzxkeUV/QAiPUe/Fv4UPZHCXLN9a1tmkmuHfw?=
 =?us-ascii?Q?sfObIMg3Xiv70+F77pLjP/PGMPrPmVL2eASA+RMfGA1Gxgm9o0Y6p1qa/wgG?=
 =?us-ascii?Q?E5Vk2X6K8JzroPE/dPlLJwETh4n8uT4c2vVQYVNerCxIBlEoVP+6XPs8Y2YN?=
 =?us-ascii?Q?oM00srK/p0jTH0GEBIaKCe/s44rG4AChL+DGclRW3bsUYbJNas7ti/jKWeZh?=
 =?us-ascii?Q?Zp0/rYOeuFSR8+W/48CKYQoZQPeCypO04+OJocztlZ9VEOPiSki6Q60LaXvz?=
 =?us-ascii?Q?wyN3bHqzLuNWf9naprjM+V+YHtc6HH5HeZygeWscZ74z82+2HFqWUjtUfA78?=
 =?us-ascii?Q?H76cOoEnSmfAQUihazO9u2suH16vn1fQyEHVJ5LKMUOsAfLpVrJ0pXfjauoP?=
 =?us-ascii?Q?3yjBvhEUozTNSeugz3bEQ8Y8N9PUlU3ef8St27mdhm9bgv1QVY49A0zWdhHx?=
 =?us-ascii?Q?zOFzdK/5xJJY1XXsN/kPGIsbyupL2xa5U21QnCDFyU+br3ELT10InikUBKsa?=
 =?us-ascii?Q?y7sQlLteKUEtacswZ6i8zztnf7eX0G6e+wTPYG9YF9w9qZz1aar5wYsblTsx?=
 =?us-ascii?Q?07Lc4zZTuQ8rE+0yAPi+ut5iCpRY6QalXDqLNxgkI70KdjNih10C8yAa8lnm?=
 =?us-ascii?Q?uhfHfy7Q6XPXF+MhmKVJSr7UM2TL8iI+d+1bFbr8yOd1UeHD/X0MwD0h0mZl?=
 =?us-ascii?Q?q9AO2+zFWkvJ/GDLMGYQVAwwl6Q8+Lt7bY23746BfnFqL0Y8EhbGouawH4BZ?=
 =?us-ascii?Q?FSuutq5xKDwHBQARbPmX2aM/AA3a02SZOuK8iNnuDpps2UIHuxe0jCbY1o4b?=
 =?us-ascii?Q?qqrt1pGCfxYzJs1F1i8tgLV0J/zRHaiNuFxLPYmCzCSpVj1uBZTycJq44miV?=
 =?us-ascii?Q?xiUhLQalwyYOUIKQ9kQq14yqbBgLYGIf+ibz5njpBLRIFHAtoJ7KDthDg3ks?=
 =?us-ascii?Q?xYAzVyv9/U9VNh0w2iMgRn3EXdlcCQ8kq2sTicit5SDVqoVXflJi1khg5EJP?=
 =?us-ascii?Q?8b8V6FkgP66EA2fbBFCAnyRo3DyS79rUBcpgueCKUfRACPWyXCGZMgTbUSnT?=
 =?us-ascii?Q?WJESEhNqPqQXHTlQsiK8N81/brKLayzrzs1EhqtQ6vbTTvVYGdFTDzpo2MC1?=
 =?us-ascii?Q?eCD580QS4faxsb7vJFbHyL14jO3EZUmRevxqqRFavfTfTvgZu4hdONkt+Ude?=
 =?us-ascii?Q?CtEnE3jZes+9/66YCBtgAMpcipYhPsxKRNRgEjgbuonfCkpqwsTS0NO/h5fN?=
 =?us-ascii?Q?ni3QuTeE2/Q9bLr+6+viCgfeb5EX6c14yJmXQfUXBLrRCAdX/7Zbeu0Se9kT?=
 =?us-ascii?Q?LnSCP3sd3a6qc8nO0+TbxU/F05ULud2sjamJRy6aHZRBU0xoumft6ZurJ1EM?=
 =?us-ascii?Q?14rWyFNICaIcooh+QVmymzJpxUUbmduSbstt9G7daeblr6np353/b9MKmOP4?=
 =?us-ascii?Q?Acd0IXGFGgxtwZYqob4/RlgExoM3pXHkRwdOEwLn?=
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
	cI7JWAjb4XG7OibZL7/mmIggW009n1oG0nXbEo6H1M623YVAoaWdxF7VObUYbvMQNnI7hZks7FmyxvC3d+HgRqzyMLUDaXonIihKT6mNIDzpBK/ZY4iJ8GPsMWtrHFclzi1g5irAoP7nkI4V4/SaWWwLjO4F8FGV+lESsOHCrEqTmAsAZbdDvZvvr7sEw9RxcxcZ2+F1q5XlCp+yG2vv5V7DiWO+yBPY4gUP3VT/TvS4Zx+yE/jZiylBY/PFGmN8cE9p05mB4Q/ENBxYSUpjqPy+zOSdRNHn/yowirrfYgE7EfolNTtz+ILxi+1G090D/41lXhcca8UJsESOFCPzHMmuONxTRdCdeBO8aum9Ynz1O2huy5NBPDgjWbP2MY8kqA5UvVK4PnJfWgCGOKFcAIeXxOlioKmUZvyp1NEwB9qsdfk/UKjs2wp3puRkXSvUN5HtA/5aBYtIpHdxS1mK8ZnxdDHXMk/5FYtioCdByzgXbLBLtsXnFQ4EnlaKngHCPSws0ALA1B1lZr1GAoXxtWwxApGARvhT8M/SeLLD83v3v7wphVvoJzHdwN112lGQsjjOoCQ8rTeZt1PWyNdRyVNnva0FsA48JUEbnmggEU7lVzqe77LsXsxdZLvHIfwW
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR02MB10379.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac904e4-7e8c-4526-8abf-08ddd4c74afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 08:57:37.7643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75bMEZoeJ44knsnenT2A6BYc9Q/EC5Znx044zsu0qyGSzwoDbePMQwMeaCaMJrmWm8fLWMSdXnu2aJ0wWzN5cjH7YiDYwZ3iYy9/l1spNKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9056
X-Proofpoint-ORIG-GUID: 7vHUPX_vzPvlDySE4owh5VD5nVf17zWI
X-Authority-Analysis: v=2.4 cv=MrlS63ae c=1 sm=1 tr=0 ts=68931906 cx=c_pps
 a=98TgpmV4a5moxWevO5qy4g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=TDdFhwdBAtCIbfOvgKYA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX3cJzroqoVOi/
 BCs8DW6BlfpHEnU4C5CZeG6ytHtWQjccxip0F9rGB2t6ctQV5Y5OJ7XZi8knEAzfG3PyY5BHh7d
 XVlMeprU3xy5smHmnQT3tiieHh3rlYkR7hFhFzhVRC8cymA2j28RETcakomNLLGNsfbcLw9Lw5B
 VyB4uPyUrFR45JLjvdheP7HE2W/wjBYv/vFRX7/QhuR+rIzFCBvYyu+0iGdaAFBznG3NQCvzQaZ
 2URSJC6esSqkzuYjzsWlgOe3vF0vyeEZaaKHL4hmTwQMHEthUoxnxNYHsBlGdxkczpPSK3Dn5gS
 VCKUBjikkWk6PupEzxm9iCZtqDCSkBuD9TZaplilr8hznN4AbqEnr36/GaywZOLaltrxP1vfHD+
 eJKpS7e5
X-Proofpoint-GUID: 7vHUPX_vzPvlDySE4owh5VD5nVf17zWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1011 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

Will update the change in a new patch.

Thanks and regards
Anup Kulkarni

-----Original Message-----
From: Dan Carpenter <dan.carpenter@linaro.org>=20
Sent: Friday, August 1, 2025 6:37 PM
To: Anup Kulkarni (QUIC) <quic_anupkulk@quicinc.com>
Cc: linux-serial@vger.kernel.org
Subject: [bug report] serial: qcom-geni: Enable support for half-duplex mod=
e

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

Hello Anup Kulkarni,

Commit 4fcc287f3c69 ("serial: qcom-geni: Enable support for half-duplex mod=
e") from Jun 3, 2025 (linux-next), leads to the following Smatch static che=
cker warning:

        drivers/tty/serial/qcom_geni_serial.c:1952 qcom_geni_serial_probe()
        warn: missing unwind goto?

drivers/tty/serial/qcom_geni_serial.c
    1844 static int qcom_geni_serial_probe(struct platform_device *pdev)
    1845 {
    1846         int ret =3D 0;
    1847         int line;
    1848         struct qcom_geni_serial_port *port;
    1849         struct uart_port *uport;
    1850         struct resource *res;
    1851         int irq;
    1852         struct uart_driver *drv;
    1853         const struct qcom_geni_device_data *data;
    1854
    1855         data =3D of_device_get_match_data(&pdev->dev);
    1856         if (!data)
    1857                 return -EINVAL;
    1858
    1859         if (data->console) {
    1860                 drv =3D &qcom_geni_console_driver;
    1861                 line =3D of_alias_get_id(pdev->dev.of_node, "seria=
l");
    1862         } else {
    1863                 drv =3D &qcom_geni_uart_driver;
    1864                 line =3D of_alias_get_id(pdev->dev.of_node, "seria=
l");
    1865                 if (line =3D=3D -ENODEV) /* compat with non-standa=
rd aliases */
    1866                         line =3D of_alias_get_id(pdev->dev.of_node=
, "hsuart");
    1867         }
    1868
    1869         port =3D get_port_from_line(line, data->console);
    1870         if (IS_ERR(port)) {
    1871                 dev_err(&pdev->dev, "Invalid line %d\n", line);
    1872                 return PTR_ERR(port);
    1873         }
    1874
    1875         uport =3D &port->uport;
    1876         /* Don't allow 2 drivers to access the same port */
    1877         if (uport->private_data)
    1878                 return -ENODEV;
    1879
    1880         uport->dev =3D &pdev->dev;
    1881         port->dev_data =3D data;
    1882         port->se.dev =3D &pdev->dev;
    1883         port->se.wrapper =3D dev_get_drvdata(pdev->dev.parent);
    1884
    1885         ret =3D port->dev_data->resources_init(uport);
    1886         if (ret)
    1887                 return ret;
    1888
    1889         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
    1890         if (!res) {
    1891                 ret =3D -EINVAL;
    1892                 goto error;
    1893         }
    1894
    1895         uport->mapbase =3D res->start;
    1896
    1897         uport->rs485_config =3D qcom_geni_rs485_config;
    1898         uport->rs485_supported =3D qcom_geni_rs485_supported;
    1899         port->tx_fifo_depth =3D DEF_FIFO_DEPTH_WORDS;
    1900         port->rx_fifo_depth =3D DEF_FIFO_DEPTH_WORDS;
    1901         port->tx_fifo_width =3D DEF_FIFO_WIDTH_BITS;
    1902
    1903         if (!data->console) {
    1904                 port->rx_buf =3D devm_kzalloc(uport->dev,
    1905                                             DMA_RX_BUF_SIZE, GFP_K=
ERNEL);
    1906                 if (!port->rx_buf) {
    1907                         ret =3D -ENOMEM;
    1908                         goto error;
    1909                 }
    1910         }
    1911
    1912         port->name =3D devm_kasprintf(uport->dev, GFP_KERNEL,
    1913                         "qcom_geni_serial_%s%d",
    1914                         uart_console(uport) ? "console" : "uart", =
uport->line);
    1915         if (!port->name) {
    1916                 ret =3D -ENOMEM;
    1917                 goto error;
    1918         }
    1919
    1920         irq =3D platform_get_irq(pdev, 0);
    1921         if (irq < 0) {
    1922                 ret =3D irq;
    1923                 goto error;
    1924         }
    1925
    1926         uport->irq =3D irq;
    1927         uport->has_sysrq =3D IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CO=
NSOLE);
    1928
    1929         if (!data->console)
    1930                 port->wakeup_irq =3D platform_get_irq_optional(pde=
v, 1);
    1931
    1932         if (of_property_read_bool(pdev->dev.of_node, "rx-tx-swap")=
)
    1933                 port->rx_tx_swap =3D true;
    1934
    1935         if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap=
"))
    1936                 port->cts_rts_swap =3D true;
    1937
    1938         port->private_data.drv =3D drv;
    1939         uport->private_data =3D &port->private_data;
    1940         platform_set_drvdata(pdev, port);
    1941
    1942         irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
    1943         ret =3D devm_request_irq(uport->dev, uport->irq, qcom_geni=
_serial_isr,
    1944                         IRQF_TRIGGER_HIGH, port->name, uport);
    1945         if (ret) {
    1946                 dev_err(uport->dev, "Failed to get IRQ ret %d\n", =
ret);
    1947                 goto error;
    1948         }
    1949
    1950         ret =3D uart_get_rs485_mode(uport);
    1951         if (ret)
--> 1952                 return ret;

goto error;

    1953
    1954         devm_pm_runtime_enable(port->se.dev);
    1955
    1956         ret =3D uart_add_one_port(drv, uport);
    1957         if (ret)
    1958                 goto error;
    1959
    1960         if (port->wakeup_irq > 0) {
    1961                 device_init_wakeup(&pdev->dev, true);
    1962                 ret =3D dev_pm_set_dedicated_wake_irq(&pdev->dev,
    1963                                                 port->wakeup_irq);
    1964                 if (ret) {
    1965                         device_init_wakeup(&pdev->dev, false);
    1966                         ida_free(&port_ida, uport->line);
    1967                         uart_remove_one_port(drv, uport);
    1968                         goto error;
    1969                 }
    1970         }
    1971
    1972         return 0;
    1973
    1974 error:
    1975         dev_pm_domain_detach_list(port->pd_list);
    1976         return ret;
    1977 }

regards,
dan carpenter
