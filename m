Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6D44BC87;
	Fri, 14 Aug 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.175.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709448; cv=fail; b=OYOv/P5Jd2QTgNBIw4X/mkTsagJqoe3f74ZgqCD3UptcNw6nATtyp3YwxVNQ0UEvxpYTTKlNguaxFVijmEy2EpEPAH7lPr4nd9DFi/B2qgTFW2mCLM+UMUy6URRkFlTUnc3tJavo1fOODLFS9ns7+E6jv78j32MB+3CUJWIp0fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709448; c=relaxed/simple;
	bh=w6I2br3knZ03MRsph72ed+09YKIQSzEHfROrFEUjIYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=I27Gal+/6aexAVKPuU6NbwbOwb9sNHdgO68fRTR1s7ExKkDSspSKAJJBNXAgB7UTypDzFX3t+ykmFazQK1gpu/Bg16rhQ/THhrjIIYgvEgnAnL111nzgym0wNT/7UqNKLEK2B48y1cRUDBzMhBfwn922LyEHtcoRdY/4ZdZnlKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=0+jj52hC; dkim=fail (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=KwvRM31C reason="signature verification failed"; arc=fail smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="0+jj52hC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="KwvRM31C"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ECA3WG4187737;
	Fri, 14 Aug 2026 12:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=+/nAP+c3lWMPn36GjQpQsmHqbF+8wMHLA1v2+LjUOPs=; b=
	0+jj52hCat/SpWdyRvR7TWA9bCRRziNBeeAYUGQbdlO1RnYuFb67okr3S+J4bVpZ
	qbNrJ4E12SqqgQyX79BhOWCKxIUoqPtC02AqfdGUXTeVNXPtxPUhoV6OvjuN3W0J
	YdG7pnJKAU6b5JtIhG1GvVnnV+Nq7dr5OYoZoHhMTBtLSrBf2vep488CS5+5He4d
	XKTQTugnft3bTbQqC3dc52lAf8XVIZzk0gofGePNmAxYHiu5LucCMoTPtiALqmQP
	s1KDC0tlAX2aevq8J2yWlA47lAOXMxeG4Aqh09qL7FEPJKohFeydbwAh3R8LBLMJ
	K6EaxH3VtPnPj/M7rZ9qcw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020075.outbound.protection.outlook.com [52.101.56.75])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fysn1ksp5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 12:10:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTURF/mzKWrgIc+BVujPVyqqjwHpD8SRaHuzSU1YNj7EO96px042Q1LMt/rid4+EhYO2lgq/QNnSxLGwDt5lPJ02wZbX3KAlSvV6VtaT+eASI30PCDsSpmEXPAw+NX/CmfVPy7G5v2TlGCeSIavtkjYWGJAaFR7zuE5HbPiv07zpLgeJNwSMamvsbqO9cQuuVeXzPKOpOLxMtzC1FGbN1GRwmJQM5jcuCcnP9BWlJfUBm3lsTOPcNE5FmzllWS0OqbRSaf0/ItP4F4IOtLuBYi4BMCphXYfgPwET0RR42pOjE9qEkjQyhjrr1H3qHn6/QWueqMxT2Hpf4cFDihp+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWeIWOTBhgm/j9TrmidjaMvZcOa1vUHTIGiyinwtlQE=;
 b=TJy00b1h5FqdZkdCc8MXLyRcYreo2+sMGdmIzyI7TYKjT/S5Ct3n4jBonDRUWWSg+W6Rnifn0Wf3vPfP6J5JDmOCOW4Ft2yTVrJVascs3u13HGZB6VDvMrT7ovLcccgoqgEOXM+R5xL377SEysw1Yc94I8szhYmw0u3YYGExjo8ebxjpGCTVtvpUVLKRoBwR2K/nPvWwRW0AfUqgfw8IuXtWCB4Uirm0zO3wyMvnHscv1ykOSzQg54ITitNN0bVP+Z/fa6eMQtVdT8p464Ja0p8C+xuKRgMcrq8WgBdBTV4XnH+f1lWn4Dk7jkG161dHxqVdsPQHqlJKyE3Re4B/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWeIWOTBhgm/j9TrmidjaMvZcOa1vUHTIGiyinwtlQE=;
 b=KwvRM31C3f29ZQXcN/CkZaPHUKgBhWnHbi0KLNGunEvPRLBRu+iC6GsSxu5HK2blK4K22uzpsn83sdODIwzI78n6idVMLqeEr+HOaUnkj3hwjgVhscc1ODS0Q9OfGKOJRqRwmWOKz7lLx9ttAN5MhQXdzNiXDF6iTkFooHGXoqwLUwZPQVNN8vaBHKXGm9q+D96M7bVDTedANLJrl9cUMhP9MOZxcXsDg7k/8bL0PzTpd9nl50jCmMt+xIsff1Jib49vtyrE9aTRcHrZYAwV32LzUtDeT+MD7I+QKb9GZU/2LN01hvRmwGv3gR6jV7vFD5IPIdjAwkQTQE7EhOXHRQ==
Received: from DS0PR19MB7925.namprd19.prod.outlook.com (2603:10b6:8:163::21)
 by DS6PR19MB997433.namprd19.prod.outlook.com (2603:10b6:8:461::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 12:10:34 +0000
Received: from DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b]) by DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 12:10:34 +0000
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
Thread-Index: AQHdK8rJqEyvvmBX2k6AaNQ3MZd5ibadRgxAgAApMQCAAAHS0A==
Date: Fri, 14 Aug 2026 12:10:34 +0000
Message-ID:
 <DS0PR19MB79251D4A473960EE4BFDC642DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
 <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
 <an7YKyVbe1YDtyL_@ashevche-desk.local>
 <DS0PR19MB7925F03452B896607C0B8F43DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
 <an8BisPHjhqn4g4d@ashevche-desk.local>
In-Reply-To: <an8BisPHjhqn4g4d@ashevche-desk.local>
Accept-Language: en-US, zh-CN, en-001
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7925:EE_|DS6PR19MB997433:EE_
x-ms-office365-filtering-correlation-id: 3112e66b-289c-4caf-294d-08def9fd0b1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|4143699003|56012099006|6133799003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 H++UMYuDiHJriZCKEF3nCxbBLuvmMlHD0RC0E9DOnmDYWC35d4XZ6EklAE8if+URTnKOj5bnGW5VymXN+oECyiwhmoJVNrILhMDWJwJYyZLFE58OuiFVGZ+SQFStbX328J4QG0oU+4QVyx139TlQx9jqr2sH59iGiB9qltmxZ9ZzuOjhqMlC6Y+z8F4zRg8nDStiMrnZiBwtuEtXtC3QJDxdyRrIm/QEMz03X4twpHgjYuEQDdjZ5/yzWWQwJj+DMLdvJxiK9C79c5NC14mc8iO4A95Zx1LkThWUytEVLtohinCalE0oC4p8xjppNBeBFSXB/OVJxFbSGj3yCZJ6OEiryHwktwHCh+P2xMW7CHt2+gIUp6sqemi6gBigxE2ytgs9SAGcv8rVA3AkOm1Ej7UiIun43fkx1pRIaRi2RLjmOzIWav7h7bgCOmuYwfmxnnpGTSEC1KQvQp6n4jKePWfY97cbBP9qYA9epFN2eKLf8+O+X2CZEJV8MkOlanr1W0zQtYeodvfpGuCYrFxGU2YTk0hVclLmIi9d/xncI6Ki3CnQOePoTfr+mVqeHeuDHtRyPt0LfYkhcTM9tsMUdq8gPwvX1KvockGXSKm7sGThiBNTwV05UVC/LdRNSDeOAL3unY0m7GniATCTl27XJ55gzdGCvsCmo8AOSbowPcs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7925.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(4143699003)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9T0TKfvmYjG+uUVbRh8Ubb+OyArPRyuTh160e044jMLIYhATpPnnHTG9Xl?=
 =?iso-8859-1?Q?ozA1IeBwWLuZbX1UZbx3VI/VKD9TzvAl61IYz2o7vR31/VTs/GvWCgLguf?=
 =?iso-8859-1?Q?AsFYbh8IRwhFkS6hhIbbmiThC0Z+LSt4SESNod7m/yjkGYLrSFqI5X1pFy?=
 =?iso-8859-1?Q?n+54UwhD7Dj8j2PBVprMs+X6OjxnH9ia/Txl+Usgmyldq9bjZyDjmh9hDW?=
 =?iso-8859-1?Q?3RaAB7qmw/wr8bPKcf4yzTtoURmvB6ixtsDBmCHRFu0CBpj5/vqE3TTg1Y?=
 =?iso-8859-1?Q?9GHW8nD8ENouLvply0nsacpioCSRzqk8liErk08k3PE8qFzTxA7Vg+Cduv?=
 =?iso-8859-1?Q?RfXxrkrhz/4senSFGKt71+Ht2IqHXnP5MToVCrGuf7raCi6vzJ0InuG7Yf?=
 =?iso-8859-1?Q?TXGkkyKVx6hHTpsYBShMBaAmUApd+jF48W8BGzBJnEcE6v0Khgu/F+7HJQ?=
 =?iso-8859-1?Q?I7Tz3TlNE6mOzPkA9HGs9blIwXIT5wdHSnk7lmhinqvlDEEjcyJvbMDm0X?=
 =?iso-8859-1?Q?Goct1AFaU9sAJJ/gsonlhpJDw/D+fYeadJhCyhSBX3oMwCKeLXBay3Ompq?=
 =?iso-8859-1?Q?iBEw7PN6LhTBBbHhPP4dlgp1t8ea+UwLdUGRNGCVWmxff7AGxF60LUY8uI?=
 =?iso-8859-1?Q?8g2P1XhGFJWQwQZnJGDJpkSgWur0yMM56+kF+uZGbZbw9JVXu7gumxEehB?=
 =?iso-8859-1?Q?RUEmTMqt8cN647ufCkk6Ij9sR2JNAnUB/wqdn8JBGKIk3jv9XYhY4d2JSm?=
 =?iso-8859-1?Q?CoGKfyyFKg3iC0eqhO5f92weFxvUMSDgL0ksfzYpL13VRoFhWs+7J7kp8t?=
 =?iso-8859-1?Q?FJgs+Kcya+9el6+x7ojivEBowndXd2ZWiW9nT7Ga2zh+MZ6mUgKURdQXMi?=
 =?iso-8859-1?Q?Y/Iu9pK/GeHW2K9J46GszA+tpQNsj6+wikbIofI101iGkUDN5X3AAkhq3f?=
 =?iso-8859-1?Q?+FCDiaGTHneactl19nD5rdes/zeOH5UK2/rzD69YIL0Q0Ro8LUZ0G0avtL?=
 =?iso-8859-1?Q?x0K/xY8CZM6Nuo7/63yKg72cgKIbzbM6E9xdkBQCPviZ8AXdVFy1SWePBI?=
 =?iso-8859-1?Q?jEJ2MUloiDzPXNrL5Y4nwoBFIxQjSf9OHw0X5VujA/HeivNUTXSTvExd+J?=
 =?iso-8859-1?Q?c59Tau5PuF/t1C8VGVsuX8pXbIeqLbO4q9492luyUrEHhj1vK+vzLoAmWX?=
 =?iso-8859-1?Q?Hfw7GvUvPdEXhikkxf8XFiKa75RgcUkwZfsHlizPHIP5vZIMBhrbURqurY?=
 =?iso-8859-1?Q?7sD+oV5hNqQMKyPC3Zir1P8KUFElTEUD1bnHWHSpt/59DZZoquWwOUqGgJ?=
 =?iso-8859-1?Q?u3Qi0XK2+EIs/sIJR/r0FmPi25810ahf5GZapUd2bxiJ4lVC+BfaVi87ib?=
 =?iso-8859-1?Q?HhtrSdpuxGKfJhmJdFLIYXXYt+lBvwm1yZXZ2o0fLK3SmzwxyVrdI+D0gQ?=
 =?iso-8859-1?Q?ScpU2U7AH7hB9oo9wIkj7E+B9aiOwmo0I1T/X7zSGe8X+/K29R1ZQu/ptP?=
 =?iso-8859-1?Q?bdm7+9z4BqDta5D2ctrBNm/S3zQ63TSF+P5F5J3fECBS6GQYyyBlOoNx2F?=
 =?iso-8859-1?Q?orm+59XJnRl6PR1vJ7fAHgPPwTKzBBqSLRBCALWnbjExt02U3LBdA97vv4?=
 =?iso-8859-1?Q?P/WJoSNUWgY4aviiQBpkisRitHxfUSfiYHjNYVtfNUPx1g6J+XiPGdH26O?=
 =?iso-8859-1?Q?Z85JOveYAx9m5o375uiC8iaZMNfdGkbQ2eNx6maUjp/nGE5uD1w48OCmxv?=
 =?iso-8859-1?Q?DF4U8fNBJacbXkVHF9gEpCkpJ/XVItN5aZbDw9ceb/7h+mw8Jfat260Amr?=
 =?iso-8859-1?Q?9ez5dm2yow=3D=3D?=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	s2rIMDsJnAnflBt3JzMGu0rTbKuAuo7o7c9iwlxMzKuPF4VblEUuQwZQuVtQC3q0NfH4NWPQLMozfOvcIDqYHz+eZk/mQoLaelkCFghzhKixXQMkFSbb1G1k1uejhYY85HGGRgRuQ4kimLgYwIEvbCJpS4Ot4dfPmW18G49RnUfCvJ4NkzmXgTM/DnROjdpRzKKO6XbwtkSt4gaKLQWq8NQTsz8tdAJ/YgstrgACSanRFxz+G8TlFp/Nnl2FMd0c8up1/+0o/rHtQNgXmk/SoGzZhlE5YD0ruJQeUSyHI9BgwYvmgdXO4pAX15fsFcuukBXq7JC4An6CssBd7kJHRw==
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7925.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3112e66b-289c-4caf-294d-08def9fd0b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 12:10:34.1416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: myWSiC+nGdhuE5BHLQfv/TiUFXo7T/5uJdDd44Q2l4mNm6EDPTKs5070I6Jl8sdChvXPGNgBA9lXDJSxTGXF/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR19MB997433
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MiBTYWx0ZWRfX9c7MN7qpePXS
 IaYlrT1+qmu+eb0GDFwmtsge3OeRRV6+6tm96h8rQrG1ANUHb9F+6hi8amrPjS3JfWSpE+LsL4I
 gy5+wiswS/2NckJo3PK2ti17j3AAC2jUb29sHK0RTvOb1ok+4WHfzzWxBG/g5VqrOB1IISAVy2v
 BEfvrnllRdpufwjko9XeTPft8QSrM99zpqE/HSol6Avf7tfxX3I2iSohV2b8BuekgaVLKL4asom
 uJCvrJ6tD8LZIl3LXywdITDwVXB0NfbO09y+AyWlnvBVdKnrJAhvQROrUOZSq19S7zwX2szzk+I
 m1I/4C5vDoWu6w9T6lEu+4De/D8b5+Dkv+StHCbWg0FkRQ/k8cK3UtsP9TqSULo7RqfJnNvvQnt
 o01quBi1FVsEajN6u3MYha49O2TPdhFc0p/Cpfc/1AuACVcEpTG8kYgwUXWkwGF7ZZfNeZvNiQw
 LbIDcVd7tEb/cM+tn/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MiBTYWx0ZWRfXyRzk8VWpvLkZ
 rY2Y88tPM8bqYoMazcD9dilKDIu6KKIHlAsjkPhg5DERdAuXHbfVQzIn8HJsCxS8gJxBVpFEotk
 xAUwFLkS+xCqAHgzGL8K+6rHzRz5A0rQ27VOXPeAuxROxbKXO6az
X-Proofpoint-ORIG-GUID: hvrZZBpwVb4d0hNk-qEEFI4b2YP3jxl-
X-Authority-Analysis: v=2.4 cv=C4fZDwP+ c=1 sm=1 tr=0 ts=6a7f05be cx=c_pps
 a=JPYgw6djPvulOwJF0XPiqQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Sv0fKeRqtYgA:10 a=dkMdDuzY2HgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yXVIz-0bn9infC194UBj:22 a=KblO7da7ppA7TBl3N-nE:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=ppJngBeKAAAA:8 a=ag1SF4gXAAAA:8
 a=QNib-Fx4foFmbRqhZe4A:9 a=wPNLvfGTeEIA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: hvrZZBpwVb4d0hNk-qEEFI4b2YP3jxl-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140092
Content-Type: text/plain; charset="iso-8859-1"

Hi Andy,

Originally we submitted a dedicated Ambarella UART driver. During review,
Linus pointed out that the register layout is basically 8250-compatible
and suggested reusing the existing 8250 code instead of maintaining a
separate driver. That is how we ended up with the current approach of
binding through 8250_dw plus a small set of Ambarella quirks.

[1] https://lore.kernel.org/r/CAD++jLm6HzEU1TM-c=3DVtjv3FJEBecVP7TyxSgq_Q0z=
F-YwT6NA@mail.gmail.com/

Best regards!
Long Zhao

Ambarella Shanghai Co., Ltd
-----Original Message-----
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=20
Sent: Friday, August 14, 2026 19:53
To: Long Zhao <longzhao@ambarella.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@=
kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@ke=
rnel.org>; Conor Dooley <conor+dt@kernel.org>; Linus Walleij <linusw@kernel=
.org>; Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>; linux-kernel@vger.k=
ernel.org; linux-serial@vger.kernel.org; devicetree@vger.kernel.org
Subject: Re: [EXT] Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75 q=
uirks

On Fri, Aug 14, 2026 at 09:33:45AM +0000, Long Zhao wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, August 14, 2026 16:56
> On Thu, Aug 13, 2026 at 06:35:13PM +0800, Long Zhao via B4 Relay wrote:
>=20
> > Add CV75 platform data with an ETOI IER mask and skip-set-rate so=20
> > the DesignWare 8250 driver can drive the Ambarella UART for console use.

> Thanks for the review. Agreed the commit message was too brief.

...

> > +	/* Keep variant-specific bits in the shadow across subsequent=20
> > +updates. */
>=20
> This says what code is doing. Instead it must say "why?" the code is doin=
g this.
>=20
> > +	up->ier |=3D d->pdata->ier_mask;
> > +	serial_port_out(p, UART_IER, up->ier);

...

> In case there is an HW bug, where can we get the errata, please? (For=20
> a bare minimum add a reference to the Errata document you give to the=20
> customers.)

> This is not a silicon erratum. The Ambarella UART is not Synopsys=20
> DesignWare IP; it is an Ambarella 8250-compatible UART. We still use=20
> the snps-dw-apb-uart binding / 8250_dw because the programming model=20
> matches closely enough, with two quirks (ETOI IER bit and=20
> SKIP_SET_RATE). I will expand the commit message and rewrite the=20
> comment to explain why in the next revision.

Okay, what does it make to think that 8250_dw is a suitable choice?
What are the features that are repetitive would be if you use a custom 8250=
-based driver (using the generic 8250 code)?

--
With Best Regards,
Andy Shevchenko


**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
