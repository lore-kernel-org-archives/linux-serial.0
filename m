Received: from mx0a-00622301.pphosted.com (mx0a-00622301.pphosted.com [205.220.163.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36E46D56C;
	Fri, 14 Aug 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.163.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711168; cv=fail; b=f6+QxYifZgHjhVenCPoaR26z6y7oFaS4TcDId4k3YbuR/rcc12f7mle3kH4pceMw9+JMrLB5daezrtS4UJiVS/epNCBzZVaOurCarsSdtalfn706KHnKzCoBef/+yQ8RJ2o8DoUYlaGRekEy/dGHFgqldJXcKvo+N6GDgQypI9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711168; c=relaxed/simple;
	bh=HAm6ckPTD8pdC+lapgCOuThulc1/KrBh7RmmPnjhesI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EyFMoykMoqQ6s9QFRqgIzW2w2pufUS41zQmL8dNMNoEHwBZmHmJxY/CDH9rrxiQ/o9YgS+RuJ1owRdi/3uSQXItZ1SXHaxsNpEbP7Jf+QRUCV0LuxS4ha4rm3fcecuCbsIbjvzQPf5aofFYd0Q2xUUgD+hrdw1chuKx/ufvF5w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=PbOGDXG6; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=jhrVLK0L; arc=fail smtp.client-ip=205.220.163.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="PbOGDXG6";
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="jhrVLK0L"
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ECUBaR388717;
	Fri, 14 Aug 2026 05:39:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=HAm6ckPTD8pdC+lapgCOuThulc1/KrBh7RmmPnjhesI=; b=
	PbOGDXG6jRC3EkZvRlevbN05YALALwnuKTyGffzsxNvyFoIfm7oO+HlPiNyIx48v
	329UHEgAE1pMjRMMuj4TO157cgYuSe9V/HM7mruiUu4r2Ew6QaZ4Y3FAIP2BpZwp
	f1hczun5QwZLz5xU9ssZib+kyYJl8uqO5jmJsWPNsJAen7+xtHLXjQYEmipMbpXP
	phwTLcPsk7d1FlRAEdfKdrjFZGxZBf1/2H7BlCW2CKm8nGxtNfjsAp3GppD3pxVC
	kwcX+aEoaEEmBNlj7INVQwbS9MMnr95Vyqi+1lnVK3mTKP6PSOS+NaK98sLxYd4W
	2Uy5T9k80DmNc6P1wuuTug==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021098.outbound.protection.outlook.com [40.93.194.98])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fysgd42tp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 05:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cELim/s9ivWW5YtgaXVFqFIO0NUkQp0hshJMG//aN8kzYyeMnt3t2QqoKGXzv3ds3Id3zZdRr06sqrw325Ak/UrHa9L0IsmuK5LD7UKO59DjgTy7zR4p+Sxic3znvmc/pak29V81zf7jkUUchwGNh2nXdPfG+z06s9I5lFG5VvHpV0ASCdo1fEfpDoarswP3lDU6p6XSRfKFdmYZVrh8G3w8x8Ciy0jukyjm7lOLsOTlQ+hxXVwtFVSZ57fk6YjsYWcu1Njmn/WtH7mZNsfjLlt4DabngZAUn1+L8ZjMvN9XTFmByuI2PjVwmFV0+pwJ9pS1jPCX53yMSlFGjJBiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAm6ckPTD8pdC+lapgCOuThulc1/KrBh7RmmPnjhesI=;
 b=Bhbtlzn2nIM0nvgHtvL2TvLL2uDmfZnpBudIRbE4cOFWH31ooaUZ0R5TgESSGGNAy8xtCTPzaWTnxee9Pt4SEzGYh6fQvtubDgQreSfj2WVAYlrJZtgLJbjA3r0/tGCSzQexr+pGIPjIgRYerTUjJn1QgWz0TLj5U6SfXWQGje360lyF+CWbqwgozqGSEqiGDbmzmo1wdftGA6L1UjbqnqQNOTb/QD1K3EropkZIlFs3ZYVZpW2SqHAK48dEcxV+npdXA/kTbO6Gf7AnPvX2KwwRgt/3sci4zPQ66VpHc86+SQkJn32R+jrvUi3SVBax4K7pSxT0Lz/x/bv4c4/Dvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAm6ckPTD8pdC+lapgCOuThulc1/KrBh7RmmPnjhesI=;
 b=jhrVLK0LPoispYFrlU+gILrqthk01g1rzSz9zIp2V/tlukLDdLy8FDic8whXdBCc0LA0PO8PeXz94vDsgVmSvMh2jPLfICK1qYb7Yjl7A+U5iAaH82HF91MG9NEOvbZnefQXE10EEOSg1Q1TeroXz18BzrVm2K8XcT9EZCpiYPim38S1aJUk2rzDEjLbA5nGMFl1uZRSasbUgJuJbAhaMBBlobJHnRfUR6eAVHa2j8B4Aj8KL7Oqe4yMlclfrfC7Ux8fQoQ2QTDTKf5p8JhfK12cmapilHkQ+4RrsPsyOAM5QtLdeQIK7Tdk85EB0uE1TWH+1WqCM0yELLyjYDNV+Q==
Received: from DS0PR19MB7925.namprd19.prod.outlook.com (2603:10b6:8:163::21)
 by DM6PR19MB3738.namprd19.prod.outlook.com (2603:10b6:5:240::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 12:39:12 +0000
Received: from DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b]) by DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 12:39:12 +0000
From: Long Zhao <longzhao@ambarella.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Linus Walleij
	<linusw@kernel.org>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75
 quirks
Thread-Topic: [EXT] Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75
 quirks
Thread-Index: AQHdK8rJqEyvvmBX2k6AaNQ3MZd5ibadRgxAgAApMQCAAAHS0IAACScAgAACBcw=
Date: Fri, 14 Aug 2026 12:39:12 +0000
Message-ID: <7E774305-3920-4BB7-BA46-E0772D6BED84@ambarella.com>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
 <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
 <an7YKyVbe1YDtyL_@ashevche-desk.local>
 <DS0PR19MB7925F03452B896607C0B8F43DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
 <an8BisPHjhqn4g4d@ashevche-desk.local>
 <DS0PR19MB79251D4A473960EE4BFDC642DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
 <an8KvvHWX0naH3Xw@ashevche-desk.local>
In-Reply-To: <an8KvvHWX0naH3Xw@ashevche-desk.local>
Accept-Language: en-US, zh-CN, en-001
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7925:EE_|DM6PR19MB3738:EE_
x-ms-office365-filtering-correlation-id: b5b4e142-2d26-4126-699a-08defa010b20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|10067099003|56012099006|6133799003|4133799003|5023799004|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 ZlE0B64tB32SedcVK9MsUCdV4ptNj4GZPQldy8NnKAm/e+uk7xL7dv5ZqPbqCKyXCUFbCXDnkde9NUXHFqu3xKkAC3LtthdHoT/8NqlOryt8QTDLIZzBvWEjIvoQlwE6bXMvX2GW62e4XoMX5jeCOMtLBkP+FfIy4HEzWUB+91Lq+PMDfiPx0CvS5ea5mB6o/p1oRrdgRZ4X6sEyk3zSplGfctuIs49wL+Wr6plmGeL67zigRejDOKRNDOM7eM7FkKQl1dXjb7YQceAAlrGjP7EVEXycePmIB/KvkYpHLPRmJM2gSQ8TtqRa0/X++xso3ixEwbTAMkTKWLkhAQ+G3Cn0zIeD68ercQV+SGqVPfvunIX0bjBHdAZwrB127N9s1e5+Mrf9nUa1SWQux1Xm6WRrH2q6T+YyxqnQwUQ4y74pImE/mDDG7+QGsMVomMUqZ5QTPq/eDCeIm8vcZD63vmbnqi6ZuHUzVIUu0Tupz1fSEqeK5FrbcLUuhUgc04QsAob8AC9sOtbvbLP0sHDm4UtE344nFeCiRfE2ETkvDsMcBKTe8+MRB7GE9mjqzgfVcD/EGPtzgPiju+7Sq3bKjz7V22Uy3EIWUGkN9Cli7q6y9SfQ31gb9cUziVi7TVfN+7/6AxQGETqdt4Xc65Tc3BwDk9u8AGQUGa8IjOkWmlc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7925.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(10067099003)(56012099006)(6133799003)(4133799003)(5023799004)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWpqakhnUHR1WVF6WjJTRmRPQ3EwNHc0OHBRSlVBOE9sb2dBb3BjZkNteWNT?=
 =?utf-8?B?RytJemF2ZkRqZldLZERqWHIxTG9aREN2ekwvSVFzSlVwYXRzb0dqR0dYblNk?=
 =?utf-8?B?cmxtK2I4bEZKK29mSk5TbTZoNVp0SlNlc2ZEQzdYY2UxV0tVc2J2VHNvRWFz?=
 =?utf-8?B?VGVCQ2IyQ3llU3E3ME56TGVqTU9QOUM1SSszZWxwb2ZYK3k0VDY5b1hNakFx?=
 =?utf-8?B?ZFliTVpld3JZSGxaY3JPeldWbG5Yb3VMQmFjMmpGQWx1V1dURDc4dXI3TlRY?=
 =?utf-8?B?K0c1cWcxbE5RanhXTUlkbWRsbHpvSWprNEZxQ0lUUUMyZTA4Tjh5bjM2VXNu?=
 =?utf-8?B?Z1BpQWZ0clRzTlExOGM0UXZ2T2RpZkVCTjZFNFhRZFdvaW9BTkFkWlp4N2ZH?=
 =?utf-8?B?MTJXcFFtdVVuMHBFeUZ0NFREV0VKUGNkYmw2aEc0ZXhFcTV3dng4ZGg2REJ5?=
 =?utf-8?B?dmhoamtuY3RlRUdFY0pxR0xUL1hBRXdMa2crV0xMUGM2RTdlNVpkSkxiTUNk?=
 =?utf-8?B?dVc1S3RadEw2MXEzaXV3bzY3U0h3UytXbmRqMzA4c0lBaGdGUXZ5WGxZUXRT?=
 =?utf-8?B?cVZWbzh2ZkFIaXVFOGRVL1lSN1EyaDJzYnFZL3V1V3FrSnpKWHdMS01MLzht?=
 =?utf-8?B?QVozeEdiZWtDRlZNbkhZbGdtOXpvR2p1elVneEthY05IKzdENnpYZVozL0Zo?=
 =?utf-8?B?ekRHZ29xcyt6VlFvbXRxMXBkbnJOWmx0TmszMmNPUDgrdERmOWFCVWd3TzFs?=
 =?utf-8?B?TXRzRjJwSXhkdURjVVNQZjJyZG50bVFKVEowWXdyTmFjZU1mWUVvTW5WMDhv?=
 =?utf-8?B?OUNMeXBBd0RIRnVyM3BIaFFCbHVTUlh6c0dwYWhRbWlvVGJkd3dIcHd2MFNw?=
 =?utf-8?B?WFk1RlRCenFwUk9wWGxUN3YzRVprM3hrbk05TUtId0N2U2Jjd0lxcEhSajl1?=
 =?utf-8?B?TXJFa2JLMEEySmE4b0VSTXNjQ1ZPMG5uOXBiV2NGOTZjYS9QTHFleXJPWWo2?=
 =?utf-8?B?ZXVTNW1hdkdhTWdKVDA2WlBBTzVZRnFtejNuSnFiYUI0QjMxckg3VEdwLzZI?=
 =?utf-8?B?cDhVUG1IOHdiZ3ltd25PUkJjSGdhSG1SSm5PeEhkKzdOcjBicjZIaW1yeDFT?=
 =?utf-8?B?eTZUUGJrWi9sOE4vNXRlMGJ4NEFGRmdXcTZJam1nOVlSSFJvVHRKUGZHaG9F?=
 =?utf-8?B?ZVRHSG9tZ3BoSjZ5b2VLTGRxbk1iRko3cG5FeDdnVy9qS1Y4UC9FMDAya2ZO?=
 =?utf-8?B?T1hHZjVCVTFlWVZsOStQdXpqNjU0NFpFSEpkM2NOc3RFR1hUc1h6d1pmMEx4?=
 =?utf-8?B?UU12VzRTM3gyU3BsVDBPTzVZSEdKc2pQMmVyS3NGVTZxVVdpTnhUVUlNU3M4?=
 =?utf-8?B?YWxhNGErajBsbkUxRW03Z0xrRWN2RGx3OVhTbERHNnJSS3p5N1hJaVVscUdu?=
 =?utf-8?B?NWUzWHRPVmRYaXZhakt3ZUxVczZTYTlXTmVaa3BNdFl3dG1na1R5L1p1THR0?=
 =?utf-8?B?WVE4MmM0dU5FNVM4YVNuaGk0RStXaGJYdit0REdaQXQzS0tIWUVkN01qVk9E?=
 =?utf-8?B?dE5IL0dNc2dZLy82NHdjaGN4TnVXclNrUDJGR2FXOWh0UG9INlM0a0Z5dUds?=
 =?utf-8?B?TWtjd2FXZFVhVFZWbVRHUFZvZEFSamN5YVo5em5STVNJQVJOQ2NhZ2trbjd6?=
 =?utf-8?B?RzVFd0NWNTh0WVRCVjR4amU2VXN6K3VJelpNTDV2aUN6SVAwc21IZnZnSDdL?=
 =?utf-8?B?eUwySE14cU02TStwWW9iUkN3OTc2dVlVWU5peTBZNHgzYXlnOVVGMVYzL1Rw?=
 =?utf-8?B?TVVRZm0ycnNRc1lmcGwzaitkVEMvVStld0szZGZFbSsvTXBwWW5jL09hRFNC?=
 =?utf-8?B?YUJ4cDZlUEhjS3JRWHNZQmlxUmJZOC93cWJtQ1VmNWNGOG92c2pRSFdtTUNN?=
 =?utf-8?B?aDBacHpYRXRrd3ZMbUU3MzFqWTFQOVYwY3hZbFF6bXdsNXF0dVlkenpuMmpJ?=
 =?utf-8?B?K2pWZVNHeFhDajlEWHllLzhMdURlMkNJK2RvQ2tyNFBYbk1hUVNSWjRQdW1T?=
 =?utf-8?B?RFFIZE84RCt1ZEkvUTVVTTZLYXM0OENud3ZQSWxlSUlrOXJORkxpNDN0Mm1q?=
 =?utf-8?B?NzFwQ09IbVVzcFNrMFAyTGlIQXp5N0dGb05vdzlzK3I1blFOOUJTR2pCd0w1?=
 =?utf-8?B?TW9jQ3AxMVNINVRSQ2pSM1pwcDlSYmRDK25MUjY4d3BsT2JKTS9tUWJuT25w?=
 =?utf-8?B?U3FtOFlBb0xFS0tiQUxrZFErcE1PZkwvTHJ1NmhvR3h2bTI4TzR0U1EweDBB?=
 =?utf-8?B?a25TZEl2VTNVd05LdndWU2hRMXBaTWd2VWxWTS9EdUIyUFZmWnhSUVRvQ0ov?=
 =?utf-8?Q?B49217o+OXLuxjH7TnMto0jX3njCUVScL4cg+k2cYCZJi?=
x-ms-exchange-antispam-messagedata-1: ZPNwZF3kV5vruA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IHWNHqUwby2YEfgYLNmpllrJl53PqM4nrxBqN39r4WXYF9/lVvO0HUOobcWJclNmHQfzrbTGqvgc72qKGqhjoolWwWvw5uUI+Fran0hn8/pSNNr3HwB3gXjt9N12tLHOwanvCtlZaDa7Mzd4/hOYfqD9JvBygDczXJZrPH4oFHaqtPmCQYxygkT5vXYLmKAYiwQJUoC1I3eyPANxRi5txJqFciw8Wv+3hqIC2Whw/Whm1wBSsCdeENWqdEyF5fadO3C3E7o6SXMEmXeafkSaUjjWDRCX5AQfvF7PO9lKjS/NSesjGW93iyA0lflA6kzC8tTvKuzd4P+QEwOjxM5oQw==
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7925.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b4e142-2d26-4126-699a-08defa010b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 12:39:12.1298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kInEVr5iVwRjyCUcMIfzlmtNYr+Vn6JmoUA9MG5PMhkcdwNNVhA2i2ziMkDzquMV/k7XYbzIqUX51OJvLOUc3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3738
X-Authority-Analysis: v=2.4 cv=PIo/P/qC c=1 sm=1 tr=0 ts=6a7f0c75 cx=c_pps
 a=+Hy52UGsyZjcAHjLWYz0zA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=dkMdDuzY2HgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yXVIz-0bn9infC194UBj:22 a=pzaFphlX3Qn9zwH3AKfV:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=2ywSbcTqm8yqcMcpbYkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5NiBTYWx0ZWRfX0wY1urL+3mg3
 khbFtkANd6QcKfjC+BhWWO2IV4azBD6YlrIuFkRJGP1gLeyGpQgMNgMr1BcL7SAWUdyV3WkDPpe
 T4mQ/n6ddzIAKjXu1NfQAPBV2c+nZ1+II5cd1WtpAOxlm6ijj2XyULRiz5t9NeEQR+2p47/XtO6
 Acf+oNWsVfhKKSgAMMgMdGiuwol7l8rLLQEBxUxXNqVURHoBpyXiEjH2Lx1T/Xv/FFPCWIkleqb
 Vc9LDjjgX2tntWg+bkVFAXCaQaUWnxFnOAOGLzSrsuK1ot9nHHSyC5EwpJk2ADnE1fJog+qKb8C
 W6PFbTYkkQm6VCL+83+ZvYYPG+E9lteLW8GmXZwsbgbsJkZrZO19hO1S8jtmPPyZuBKYrDUOKdu
 vTLSsUzPp7lUnJTGEI5J2dzuSaSTUf1rCteMhB5XTok6gyWkcfRBA6GwZLoAtX8npdQY+2gtHLI
 jxLy8ASbYd4Z3Fn9mtg==
X-Proofpoint-GUID: KP_Ee9t4ktgB-okPlAzpv3RIYfADE5rQ
X-Proofpoint-ORIG-GUID: KP_Ee9t4ktgB-okPlAzpv3RIYfADE5rQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5NiBTYWx0ZWRfX10Ak5v3gKGYB
 sgZc4yNfjU5k9guAHSOH+Vt28vMJm7azXHlmfgb6I9yKE5X4IO9jWAowJKOm4VtszVvjvmIEsYi
 ihkNJ+KjCR9AkabSsbOP1/hQPAggnj0s0026V0dpO9kdB/yR4ahW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140096

T0ssIEFuZHkuIFdlIHdpbGwgc3dpdGNoIHRvIDgyNTBfYW1iYXJlbGxhLmMgaW5zdGVhZCBpbiBW
NC4NCg0KVGhhbmtzLg0KTG9uZyBaaGFvDQoNCuWcqCAyMDI25bm0OOaciDE05pel77yMMjA6MzTv
vIxBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4g5YaZ
6YGT77yaDQoNCu+7v09uIEZyaSwgQXVnIDE0LCAyMDI2IGF0IDEyOjEwOjM0UE0gKzAwMDAsIExv
bmcgWmhhbyB3cm90ZToNCg0KPiBPcmlnaW5hbGx5IHdlIHN1Ym1pdHRlZCBhIGRlZGljYXRlZCBB
bWJhcmVsbGEgVUFSVCBkcml2ZXIuIER1cmluZyByZXZpZXcsDQo+IExpbnVzIHBvaW50ZWQgb3V0
IHRoYXQgdGhlIHJlZ2lzdGVyIGxheW91dCBpcyBiYXNpY2FsbHkgODI1MC1jb21wYXRpYmxlDQo+
IGFuZCBzdWdnZXN0ZWQgcmV1c2luZyB0aGUgZXhpc3RpbmcgODI1MCBjb2RlIGluc3RlYWQgb2Yg
bWFpbnRhaW5pbmcgYQ0KPiBzZXBhcmF0ZSBkcml2ZXIuIFRoYXQgaXMgaG93IHdlIGVuZGVkIHVw
IHdpdGggdGhlIGN1cnJlbnQgYXBwcm9hY2ggb2YNCj4gYmluZGluZyB0aHJvdWdoIDgyNTBfZHcg
cGx1cyBhIHNtYWxsIHNldCBvZiBBbWJhcmVsbGEgcXVpcmtzLg0KDQpSaWdodCwgcGxlYXNlIHJl
LXJlYWQgY2FyZWZ1bGx5IHdoYXQgaGUgd3JvdGUNCg0KIlRoaXMgbmVlZHMgdG8gYmUgcmV3cml0
dGVuIHVzaW5nIHRoZSA4MjUwIGxpYnJhcnkgaW4gdGhlIGtlcm5lbA0KdW5kZXIgZHJpdmVycy90
dHkvc2VyaWFsLzgyNTAvODI1MF9hbWJhcmVsbGEuYw0Kb3Igc2ltaWxhci4iDQoNCllvdSBhbHJl
YWR5IGNvbmZpcm1lZCB0aGF0IHlvdXIgSVAgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB0aGUgU3lu
b3BzeXMuIFdoeSBpcw0KdGhlIDgyNTBfZHcgdG91Y2hlZD8hDQoNCj4gWzFdIGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9yL0NBRCoqQWpMbTZIekVV
MVRNLWM9VnRqdjNGSkVCZWNWUDdUeXhTZ3FfUTB6Ri1Zd1Q2TkFAbWFpbC5nbWFpbC5jb20vX187
S3lzISFQZUV5N25aTFZ2MCFqOExxUFJUMmJ6aW0xaUMyeHJVMEFXNFFVWXZKNG9jNEpxSElQM0RN
ck9KVkktU2RNSE5ZajJLSWlyczh5U0F0dkR3eDEtR2x6NTZEc0dYNnYxdnp6Q3BXT0dPYjlMWVhq
ZyQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVu
a28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBB
dWd1c3QgMTQsIDIwMjYgMTk6NTMNCj4gT24gRnJpLCBBdWcgMTQsIDIwMjYgYXQgMDk6MzM6NDVB
TSArMDAwMCwgTG9uZyBaaGFvIHdyb3RlOg0KPj4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmRy
aXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+PiBTZW50OiBGcmlkYXksIEF1Z3VzdCAx
NCwgMjAyNiAxNjo1Ng0KPj4gT24gVGh1LCBBdWcgMTMsIDIwMjYgYXQgMDY6MzU6MTNQTSArMDgw
MCwgTG9uZyBaaGFvIHZpYSBCNCBSZWxheSB3cm90ZToNCj4+IA0KPj4+IEFkZCBDVjc1IHBsYXRm
b3JtIGRhdGEgd2l0aCBhbiBFVE9JIElFUiBtYXNrIGFuZCBza2lwLXNldC1yYXRlIHNvDQo+Pj4g
dGhlIERlc2lnbldhcmUgODI1MCBkcml2ZXIgY2FuIGRyaXZlIHRoZSBBbWJhcmVsbGEgVUFSVCBm
b3IgY29uc29sZSB1c2UuDQo+IA0KPj4gVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBBZ3JlZWQgdGhl
IGNvbW1pdCBtZXNzYWdlIHdhcyB0b28gYnJpZWYuDQoNCi4uLg0KDQo+Pj4gKyAgICAvKiBLZWVw
IHZhcmlhbnQtc3BlY2lmaWMgYml0cyBpbiB0aGUgc2hhZG93IGFjcm9zcyBzdWJzZXF1ZW50DQo+
Pj4gK3VwZGF0ZXMuICovDQo+PiANCj4+IFRoaXMgc2F5cyB3aGF0IGNvZGUgaXMgZG9pbmcuIElu
c3RlYWQgaXQgbXVzdCBzYXkgIndoeT8iIHRoZSBjb2RlIGlzIGRvaW5nIHRoaXMuDQo+PiANCj4+
PiArICAgIHVwLT5pZXIgfD0gZC0+cGRhdGEtPmllcl9tYXNrOw0KPj4+ICsgICAgc2VyaWFsX3Bv
cnRfb3V0KHAsIFVBUlRfSUVSLCB1cC0+aWVyKTsNCj4gDQo+IC4uLg0KPiANCj4+IEluIGNhc2Ug
dGhlcmUgaXMgYW4gSFcgYnVnLCB3aGVyZSBjYW4gd2UgZ2V0IHRoZSBlcnJhdGEsIHBsZWFzZT8g
KEZvcg0KPj4gYSBiYXJlIG1pbmltdW0gYWRkIGEgcmVmZXJlbmNlIHRvIHRoZSBFcnJhdGEgZG9j
dW1lbnQgeW91IGdpdmUgdG8gdGhlDQo+PiBjdXN0b21lcnMuKQ0KPiANCj4+IFRoaXMgaXMgbm90
IGEgc2lsaWNvbiBlcnJhdHVtLiBUaGUgQW1iYXJlbGxhIFVBUlQgaXMgbm90IFN5bm9wc3lzDQo+
PiBEZXNpZ25XYXJlIElQOyBpdCBpcyBhbiBBbWJhcmVsbGEgODI1MC1jb21wYXRpYmxlIFVBUlQu
IFdlIHN0aWxsIHVzZQ0KPj4gdGhlIHNucHMtZHctYXBiLXVhcnQgYmluZGluZyAvIDgyNTBfZHcg
YmVjYXVzZSB0aGUgcHJvZ3JhbW1pbmcgbW9kZWwNCj4+IG1hdGNoZXMgY2xvc2VseSBlbm91Z2gs
IHdpdGggdHdvIHF1aXJrcyAoRVRPSSBJRVIgYml0IGFuZA0KPj4gU0tJUF9TRVRfUkFURSkuIEkg
d2lsbCBleHBhbmQgdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCByZXdyaXRlIHRoZQ0KPj4gY29tbWVu
dCB0byBleHBsYWluIHdoeSBpbiB0aGUgbmV4dCByZXZpc2lvbi4NCj4gDQo+IE9rYXksIHdoYXQg
ZG9lcyBpdCBtYWtlIHRvIHRoaW5rIHRoYXQgODI1MF9kdyBpcyBhIHN1aXRhYmxlIGNob2ljZT8N
Cj4gV2hhdCBhcmUgdGhlIGZlYXR1cmVzIHRoYXQgYXJlIHJlcGV0aXRpdmUgd291bGQgYmUgaWYg
eW91IHVzZSBhIGN1c3RvbSA4MjUwLWJhc2VkIGRyaXZlciAodXNpbmcgdGhlIGdlbmVyaWMgODI1
MCBjb2RlKT8NCg0KLi4uDQoNCj4gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiBUaGlzIGVtYWlsIGFuZCBhdHRh
Y2htZW50cyBjb250YWluIEFtYmFyZWxsYSBQcm9wcmlldGFyeSBhbmQvb3IgQ29uZmlkZW50aWFs
IEluZm9ybWF0aW9uIGFuZCBpcyBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGlu
ZGl2aWR1YWwocykgdG8gd2hvbSBpdCBpcyBhZGRyZXNzZWQuIEFueSB1bmF1dGhvcml6ZWQgcmV2
aWV3LCB1c2UsIGRpc2Nsb3N1cmUsIGRpc3RyaWJ1dGUsIGNvcHksIG9yIHByaW50IGlzIHByb2hp
Yml0ZWQuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRh
Y3QgdGhlIHNlbmRlciBieSByZXBseSBlbWFpbCBhbmQgZGVzdHJveSBhbGwgY29waWVzIG9mIHRo
ZSBvcmlnaW5hbCBtZXNzYWdlLiBUaGFuayB5b3UuDQoNCllvdSBoYXZlIHRvIGdldCByaWQgb2Yg
dGhpcyB0cmFpbGVyLiBUaGlzIGlzIGxhc3QgdGltZSBJIHJlcGx5IG9uIG1lc3NhZ2VzIHdpdGgN
Cml0LiAoUmVwbHlpbmcgdG8gaXQgbWlnaHQgbGVhZCB0byBzb21lIGxlZ2FsIGNvbnNlcXVlbmNl
cyBmb3IgbWUgYW5kIG90aGVycy4uLikNCg0KLS0NCldpdGggQmVzdCBSZWdhcmRzLA0KQW5keSBT
aGV2Y2hlbmtvDQoNCg0K
