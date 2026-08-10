Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485A3358AF;
	Mon, 10 Aug 2026 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.175.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786334794; cv=fail; b=VDo+svkZYsb1pd8YbCZl25lw/zcDxwAXV7lQ4LlDJNBns0nwWpe9SmMg/6iw1XKDIRoGtd2ZvbHbYP91PbN72udmwfESNhulazMHkWGJoeACJGU0fKObsU8e0FM3MxsqRlx7IL111ibpFoDroZUbMwRH14ajPMleQFAaBLIaczs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786334794; c=relaxed/simple;
	bh=pFTwf+2F7+IXzRGleOPl9HIxMB4L6LAWpo9cF0k3t0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VL2qI+AupKbeB+KEbQkyMjEplTnx2x96HID8WEf1TsUMH40s+yi1wYFYyoYWjLGpkOa+M97HUEirsSec4tmMPqT4rKE+lgT8Oda57RKzK6t+8KYkfZ9Wd+2N8x802NtxjBIBBNthtzdqdl18aDlOs+Y7VGR+NoAfwkQio62LicA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=IMKFNu77; dkim=fail (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=NBJa44Pv reason="signature verification failed"; arc=fail smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="IMKFNu77";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="NBJa44Pv"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A3nSJv1407438;
	Mon, 10 Aug 2026 04:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=pFTwf+2F7+IXzRGleOPl9HIxMB4L6LAWpo9cF0k3t0E=; b=
	IMKFNu77p9G4N0ttJjG7fDeTxP81lzldXrz0NjY1vH0YLx29RXZuWjmFJFTrBH+P
	tegRJwN338H73CDOw/ddA5SsjWszADpY+JR/s6ba+gC9Tip4RESwfMVMSF0P3//S
	aVMJosfoZX9DsDP3geEWoJdJtmjzIocJ0pizVlp7DLA7O9tuJb/8yFsZs5GiSmB6
	cCWfHd8tmWomG/7bvYXmLlo011dE6Sqb11wnelMBuwuBUVlXEoEOu0CJmE5qI5Jy
	IsUYOmWbWGNs/k6n9oj+Kkt1QWk6/6cyLX3c+P1DWjgY//+h5VLiN8TTIR23yKcT
	to9g+g4w++C0MdepcRMMrQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021133.outbound.protection.outlook.com [52.101.52.133])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fxgnp8fp1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 04:03:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1HgEeg0tGzKF9WdwEOoyEsLhBY0+ZUFblBVPXA8ndOFqcMBUDLbMrljFTDSLCUjpJqFJDx2YWM59atF0iNh1YT53aIYHbzuHtXghbGn7kT0BWIrMtam07me70ti2utplvdVAyiDK2uOJtFQ5bLTU93GQ7RAVOHtEE/0AS8VL8KZiWdp1BIQYF4vAqMF621QszORRumgKDpvqVtB1WKwOj/DL8mduWwQGj/EETcPEXWgQYYZ/HSDuhaF/xx4+rzB0yNMezGqqyAK8/pkvbVgo7SMts4D/hOQCDMRSb1EZXNigwrT+XDV9QF+rJtH4AfjZ4lcnUeSjbLwNJ+EdgyuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+xax74oGszrD8eVXUcwE1vqm1dCyJoCFf3U45gR8K4=;
 b=jM5h29VJ92taH/zcZlbIT1xB9lpToUqlbcmJCcRVSqgcSWIOCLyUOMgi9+wmGD8fhA4rO+KuOZOScxPCY7kZpPZXOTemDTZEcp5U5200mYjfdyEtTvP2oo86MuGWHUskvHxYed7eRX44uoxCmABbx4i0sAWSTLs7W4QhUtW2BcaNcL9vVW6oD/H0bnx7sdv6QoCf6iaq73GAdfuYMttNSJav5/OJ5ty4NGYP3SGM2ox27cXsJynDqREbFF7UGPAE4Am7+QsWpBBMv0QwioH/Ix4OC7B/njDmZ/VkcTrKfA7UpOkUAhonH6nj0W495EquO8OT9gPYctPJYt/jT7cK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+xax74oGszrD8eVXUcwE1vqm1dCyJoCFf3U45gR8K4=;
 b=NBJa44PvV3abZ1Ouw9Ql7yFwi/G0ik0XsWftMcB5vzaRlV/aCJLPZa+0RSp6bciDmCDWXcKnCOm+lu1nUBlXgMTHH0AnwrF1MRdCNvhYwclhCPNKU3QWH64BLy4OC8rH43/0FJJ2gtQ/AgitEiKAdPCb1gBUSzwdHBHPjj+8DEwUfBGw9Br1EWxeQbVIVnVM4XxRhCt9wOQP6G9lULqALNb++jcJbmi82GTgqi7WGJv+TPDjpuhXWnGf5moJT4a6ErkJ0uj6f09a32JUTsEU4FdUs4s92LwKMHWyPc2kM7r9okLn6cfukHuYQVZgpKWBFvI6E+GaPDkU6iL/4L8u+w==
Received: from DS0PR19MB7925.namprd19.prod.outlook.com (2603:10b6:8:163::21)
 by SJ0PR19MB4400.namprd19.prod.outlook.com (2603:10b6:a03:28b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Mon, 10 Aug
 2026 04:03:28 +0000
Received: from DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b]) by DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 04:03:28 +0000
From: Long Zhao <longzhao@ambarella.com>
To: Linus Walleij <linusw@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>,
        "soc@lists.linux.dev" <soc@lists.linux.dev>
Subject: RE: Re: [PATCH v2 08/10] serial: ambarella: add Ambarella UART driver
Thread-Topic: Re: [PATCH v2 08/10] serial: ambarella: add Ambarella UART
 driver
Thread-Index: AQHdKH0zX8gQQrSzN0qP66x1ecnmGg==
Date: Mon, 10 Aug 2026 04:03:28 +0000
Message-ID:
 <DS0PR19MB7925433DAA9763AB1FF192C1DADE2@DS0PR19MB7925.namprd19.prod.outlook.com>
References:
 <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-8-6b09707c5fe9@ambarella.com>
 <CAD++jLm6HzEU1TM-c=Vtjv3FJEBecVP7TyxSgq_Q0zF-YwT6NA@mail.gmail.com>
In-Reply-To:
 <CAD++jLm6HzEU1TM-c=Vtjv3FJEBecVP7TyxSgq_Q0zF-YwT6NA@mail.gmail.com>
Accept-Language: en-US, zh-CN, en-001
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7925:EE_|SJ0PR19MB4400:EE_
x-ms-office365-filtering-correlation-id: ee109b81-fb44-4166-4954-08def69455a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|4143699003|56012099006|6133799003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 tCP+lR+y4/uWn4GE3FdpUjpB3q7Y6fQEXUw+cKr+mOw66OuRH5pGtgecJNA8WquLV6qpI8JNimO3KdoFga61BoYOAcO0Juc9lX2HOsvSSRIHB2i/QNUc12Wv8yqCUiozh1SKpUCHc4DVKruQtIjHmUb83wIaZdSDv/U3awwt04uORkZx7XaMhSwTminct8tQ+vvIk0iisYTrK1/dFt0sSK8jU/zICTnWNEGY+7EUj8c7A0am8F3+fkerGTo8llOk34uPUFhjt0oCPku5S5TUGFS6PwhU+kaHxmx6/pCZVGKazZ82rQAqLYf6AkjzaivbwVKj31DgeyF09bkLAct/p4jE4mFHOu6bXF0K32oTjLD5nd1VaRsr8aHaiIsqMLfHPGj9MeCuBHhk0lNlmvp66GCDQGca6SZ94scE/s8pavackexrxlEhwxCtYOBqSqXquWXOrusl4cPctd9bg47WaTvZaXhjk8Zyq7gtfKv70jsE6LLJsW6ErGp+uARoQMRmt5m8b1OrHsg9Gse6FFry5/uGRG1yqL8Ux64fvKvk6jcsxtr44uzEnHDXZoIWgvrCGp/lfnDdUrul4+nhFiFBJ/M+ftz19SCWJpjoPwJ0rV4z/Uqk4hnhDw9inW1mkK/Gs/mo2Dz1pxxLvDV7ElhuAGJyout1RBnzKvpYhxpCB//2O03nXymqDmp//8D0KxjXvCvU65izgJlwJ3t32kbaTOhArIFdqSaNSgDF5k2dL1Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7925.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(6133799003)(10067099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UVVQS202bVkzc3R3RWVBKzV2MlkrUjhIbGFaNURSUFRsU09KclBVNjF6d1Y0?=
 =?utf-8?B?WTRnZUJzY3V0aFNhakxSb0hQZldLQ2VudFRJY3JQMVo4RUxtUGpRZzhVN1FY?=
 =?utf-8?B?SEJBWTgwUnJWd21qSXZvSkdvL2QxWDVycWx4STlRVVhVZ0dmNkpCT2dHNjZM?=
 =?utf-8?B?eDZLWFYxd1FXNnpVMndycVlzTFB3d01YMFl6emYxbU0ySmpDbzhmTWZsenR6?=
 =?utf-8?B?MW5yRTdVS2ZpeElVNGQxSkhINTNnZTB6R2hrU3NEWmlna0k1clBBVnNqaHFw?=
 =?utf-8?B?WWJ0cEN5Q0hhUTNjVEFiakUza1pXYzgxdkQzZlF5VThDam5ONWRra3Bacng3?=
 =?utf-8?B?NE9URGZ2aVhEeVZMaXNxdnJQdFRUak5WNUNXclZQWlNYQ3BNTE94cGpRMmgy?=
 =?utf-8?B?RXVHeHZRdm5panlOK1pWclR5QUZna256aEwvZUp0cVVHMklXazhGbTlManJ2?=
 =?utf-8?B?bFNmQSs0TExWNHBJcFZDQjc4R1ptb1JsbFFsRjBGeWJ5RW1BTlNySndrRWZE?=
 =?utf-8?B?eEFlcWVEcG54cmZQcG9rV1o4VHBINFY4K3R3VDNabU85WHErd05ZSWkvM2s3?=
 =?utf-8?B?MTFjTmhmckFESmtxUVFSMW02bC9xQVFyTmRXTUZwSHhEZ3VMdEY3N3JrclBP?=
 =?utf-8?B?TkViYjg3a0czSkI4RVlqYkE5eUQ4cld6ODBsT0lFYzhaTHBEMzN4V2hPN3By?=
 =?utf-8?B?Q1ZDRW9qR2VvTmZzaG9QZEdsT1RobWxJTDFUNTJoSlNGZ01CUXkwWU5LTzV3?=
 =?utf-8?B?NEZBNnVaQWdqOXNEYnErY2F4OXZqNTMwNEoraFUzcUF1TWxPcHE4WXpwNnBB?=
 =?utf-8?B?TERRa3R3TTd1TGtUd2hjaHgzQld6dHRkMFdSM3luaFVWSmJLNkZISExhbitS?=
 =?utf-8?B?ZHh5cnpZNjlmTmpOMzhjVVpqdm5XeG5ZU2wrOUZqTDNmam1PTXdHQ1QwU1dL?=
 =?utf-8?B?Nkt2RkIxUjZWb2VzcGZoTkVaWHR4dWwxQkhMZWhGdnhkTHBKbjZzODU2dkpW?=
 =?utf-8?B?NWJpUndKSDRsbVV6dzdaVDVDck1teUgzbzNDS2U0MGJFbGVYUU00eGNBNUJF?=
 =?utf-8?B?aWZCdU43dHZqTEZGZkFHNXVNWFJERVk5ZG5lclBlSEFUcEg4cGhiYUQzMFgr?=
 =?utf-8?B?d1Uwa01Ob2c0UDMwSnZnMUFMNXVmRGsrYjZoQlhLMzQ5Z2hOSVBQSWtUSGhp?=
 =?utf-8?B?d01NeStnb0xDVnFkVjN6WjVlWENoKzRMaXlLQy9IcWM4S3ZJd3RsTDZBRVNx?=
 =?utf-8?B?bURtbmI4dzNocWppQWZwMGY1YXQ3Tmx1M2tMU28wWGFXVTk3WXJKMUxFRS9h?=
 =?utf-8?B?WTNtNE4rdkZMQjRKbE1qeWRRRFlSY0hLQTViQ1p0dHYxajFlbHpkeCtzVDNW?=
 =?utf-8?B?cmVwMzlIQTBqOHZkKzdjaSt2MUd6VVlGQS9RSUxjWlpmTUFHSUQrN3lvVzdC?=
 =?utf-8?B?TjJsRDZlY3k0dVN2RXNncHV2Ung4NmpvdDN0ekJMSzJNSzBIcXRQVTBLa0pD?=
 =?utf-8?B?SlBiZ0txOEE0STZlYUZZVExTaEk4bkdLa00wV3gzZFVjTzZBeWlNRkFWc0ZE?=
 =?utf-8?B?Zng1OGRnck83M3gySGF5cFpMR0J4ZkFlT1J0UDlRY0pFeUxpMHloS2pLMTA2?=
 =?utf-8?B?NUJxMXVDdmJOMzJnam13d0NOdWpub3J5V1MvYnlxaUYraEpnM1daOEdIVUk0?=
 =?utf-8?B?dXErbTRmRWw4d0R1VjBQMllvMk9QK2FPaUhqYlpRTjR3L0ovNWIvamRVTGZw?=
 =?utf-8?B?SXFvczRhd3dTVzRsakpqbnJYUCtHS0VLQUJvU1ZFVjlnNWIrZmtidnd4K2V5?=
 =?utf-8?B?TU5JbjlrQnF4VUJ5alN5WFdJYnFYVmVkOVFwdkJFbThYMlovVEo4Y2RWbTF1?=
 =?utf-8?B?clIrOHRXalJSYlZSREk2RHhVRXE0UTZFdHdxbmNKTVQySklRZlI2MTd0V0Y2?=
 =?utf-8?B?dUQvbm9ITVNLcW5UbG9DTDJIZEc3U1dGUnA2NzlwdFhVYnM0L3pGUWJsUmdZ?=
 =?utf-8?B?VyszK2NNWWZwNXpZUDVCNUJ6VHBaN3EyVTBVczl4Z3YzK1ZSS0l2dUx4RDFU?=
 =?utf-8?B?d2RmRVV3bTlUdGhUblZNNHJ2MzRaUVljQUVsaXRPZ0Z2dzZ4QzIzT052eFF0?=
 =?utf-8?B?WnJyQU5EcXFSVFNBQW9zLy90V3M2eFRRRDVuRWFkV1JoMjNMYmVybThGM0Fw?=
 =?utf-8?B?Z05sTW5iK3FPaEY5QXdKNXdETzNLaFh3WXdQa2E1ck1tVStxKzNFM2FRbVk4?=
 =?utf-8?B?ZlpGRndST0oxR2p0WDFaZ3NZS1NSVVFYSXhvN3VSTE1qenFld2JpRXJjR0lu?=
 =?utf-8?B?RGVFblZ5clVNSHRuTmhkcHJ2RzQ5dDBsT0ljZGt3VXRPL053MXg0QT09?=
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	AUAEW5whmhi0K4Ky59ywoWplzmfdzjzchDuVvCORsjdoG0Y0smhdxPbtm1LDggIYRErivYQq3RSdm0sGajjOOwWcDjC157NiAcCfBz4i9B1un1Y9Z9WEbIVvVH9zeCKI7+GVvzZmXRxdk66wWtlMxy8OVx4nxhJ3cR5B8fh7h4gRqNk/QHmXQ+h7AU3h1/GBZ7hB3fYuWDj7qtoZ5wRIp/JB5bG4hiP7SS7/jpB0y6g3AteY5OrSJHaLmaDlGxT710k05EqUVGcUWnxr/6CMZG1+GTC/LiTiRkjp0DcPMi8ymXZlqy1jKqkQk5dFNqH14z04kTb+ZbJ+lUr2hQqlMw==
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7925.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee109b81-fb44-4166-4954-08def69455a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 04:03:28.4803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ffLKrbZukk9Z7z6iIk18WlPdlOGwWXh9AwUkq+FjuG/Gf+kkq/seL+dT/lh09BXLXi5ufMhTpVq7Z+WivhkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4400
X-Proofpoint-ORIG-GUID: DHFimCPensHLfmF2HfA_0R2zujovfz2K
X-Proofpoint-GUID: DHFimCPensHLfmF2HfA_0R2zujovfz2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAzMCBTYWx0ZWRfXz04Q3fdXWGve
 1RKvylDGRhrQZ+8/pdcGocWNvDrQw85USUavdSBd9v89JTEQATLor/BXAORlnW9/uKZnX++850v
 Ko4Ktrr5KoLCXpBpa+ZVTYfHuDmK50h/MGriM2idWC3CqglMpbLYRrwPvAcxZqJbB4AkVtJpiQg
 Acn6/vNDKfH4ypClawJW0FRZ1CC2ZamcP7gzMVigoyIUatTh0SV5K5kqW5epINNG7hKg5e69QPe
 NGTEWh78xmE0ekM+bROLXN2bIl+Rf2VAj1ZHc8iRed7DaGrMH9qeGW7FKtAG6vErcDbbvAwDozD
 PCZk++fva4GTNolSG0kjj/HjAl0LpQWaNViFBFGT/DVrfVgfYvmFFAPJN7DLjUePr574dKrXkAs
 QKQD0skb66IFyI6jGWiISzZdCRjr1LJ4ahbt6RfCbFKGe6k4+Ioud+rzs96+7NuHO6vLcPEpI0V
 LyhZWg6pvjL2WaENgAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAzMCBTYWx0ZWRfX6cRrS6uieYre
 S/AUCRho2dsyjUMqYEi/pnSlsXKRVDym+RGSmvc3ohv3hS83pa9KvM5aERr91rSG4ygSdztlX4H
 R7uJuABNgLgbsgF9fhQ80RR14ClOKvoyxHO8phle217/Uscsims7
X-Authority-Analysis: v=2.4 cv=BaXoFLt2 c=1 sm=1 tr=0 ts=6a794d93 cx=c_pps
 a=zQVrRFDx79pk1Kc/J51lMQ==:117 a=fVfL832+mzDTHoFKNp42fb2xq0E=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=dkMdDuzY2HgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22 a=KblO7da7ppA7TBl3N-nE:22
 a=VwQbUJbxAAAA:8 a=ppJngBeKAAAA:8 a=IpJZQVW2AAAA:8 a=ag1SF4gXAAAA:8
 a=7CQSdrXTAAAA:8 a=P-IC7800AAAA:8 a=JfrnYn6hAAAA:8 a=5SUWIsU8UPIHWLGH4Y8A:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=d3PnA9EDa4IxuAV0gXij:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100030
Content-Type: text/plain; charset="utf-8"

SGkgTGludXMsDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuIEkgd2lsbCByZXdvcmsg
dGhlIFVBUlQgc3VwcG9ydCBvbiB0b3Agb2YNCnRoZSA4MjUwIGNvcmUuIEkgd2lsbCBmaXJzdCBl
dmFsdWF0ZSB3aGV0aGVyIDgyNTBfZHcgY2FuIHN1cHBvcnQgdGhlDQpoYXJkd2FyZSBkaXJlY3Rs
eSB3aXRoIHJlZy1zaGlmdCA9IDIsIGFuZCBhZGQgb25seSBhIHNtYWxsIEFtYmFyZWxsYQ0Kd3Jh
cHBlciBpZiBhbnkgU29DLXNwZWNpZmljIHF1aXJrcyByZW1haW4uDQoNCkJlc3QgcmVnYXJkcywN
CkxvbmcgWmhhbw0KDQpBbWJhcmVsbGEgU2hhbmdoYWkgQ28uLCBMdGQNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBMaW51cyBXYWxsZWlqIDxsaW51c3dAa2VybmVsLm9yZz4gDQpT
ZW50OiBTYXR1cmRheSwgQXVndXN0IDgsIDIwMjYgMDI6MzcNClRvOiBMb25nIFpoYW8gPGxvbmd6
aGFvQGFtYmFyZWxsYS5jb20+DQpDYzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEty
enlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleSA8Y29u
b3IrZHRAa2VybmVsLm9yZz47IE1pY2hhZWwgVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJl
LmNvbT47IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz47IEdyZWcgS3JvYWgtSGFydG1h
biA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBKaXJpIFNsYWJ5IDxqaXJpc2xhYnlAa2Vy
bmVsLm9yZz47IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+OyBXaWxs
IERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47
IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT47IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwu
b3JnOyBzb2NAbGlzdHMubGludXguZGV2DQpTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYyIDA4
LzEwXSBzZXJpYWw6IGFtYmFyZWxsYTogYWRkIEFtYmFyZWxsYSBVQVJUIGRyaXZlcg0KDQpIaSBM
b25nLA0KDQp0aGFua3MgZm9yIHlvdXIgcGF0Y2ghDQoNCkkga25vdyB0aGlzIGRyaXZlciBoYXMg
YSBsb25nIGhpc3RvcnkgYW5kIGhhcyBiZWVuIHJlZmluZWQgaW5zaWRlIEFtYmFyZWxsYSBmb3Ig
bWFueSB5ZWFycy4gSG93ZXZlciB0aGlzIGlzIGNsZWFybHkgYW4gODI1MCBVQVJUIGRlcml2YXRp
dmU6DQoNCk9uIFRodSwgQXVnIDYsIDIwMjYgYXQgMTE6MzTigK9BTSBMb25nIFpoYW8gdmlhIEI0
IFJlbGF5IDxkZXZudWxsK2xvbmd6aGFvLmFtYmFyZWxsYS5jb21Aa2VybmVsLm9yZz4gd3JvdGU6
DQoNCj4gKyNkZWZpbmUgVUFSVF9SQl9PRkZTRVQgICAgICAgICAgICAgICAgIDB4MDANCj4gKyNk
ZWZpbmUgVUFSVF9USF9PRkZTRVQgICAgICAgICAgICAgICAgIDB4MDANCj4gKyNkZWZpbmUgVUFS
VF9ETExfT0ZGU0VUICAgICAgICAgICAgICAgICAgICAgICAgMHgwMA0KDQpSQiwgVEgsIERMTCBz
aGFyaW5nIHJlZ2lzdGVyIDB4MDAuDQoNCj4gKyNkZWZpbmUgVUFSVF9JRV9PRkZTRVQgICAgICAg
ICAgICAgICAgIDB4MDQNCj4gKyNkZWZpbmUgVUFSVF9ETEhfT0ZGU0VUICAgICAgICAgICAgICAg
ICAgICAgICAgMHgwNA0KDQpJRSwgRExIIHNoYXJpbmcgcmVnaXN0ZXIgMHgwNC4NCg0KPiArI2Rl
ZmluZSBVQVJUX0lJX09GRlNFVCAgICAgICAgICAgICAgICAgMHgwOA0KPiArI2RlZmluZSBVQVJU
X0ZDX09GRlNFVCAgICAgICAgICAgICAgICAgMHgwOA0KDQpJSSwgRkMgc2hhcmluZyByZWdpc3Rl
ciAweDA4Lg0KDQpDb21wYXJlOg0KDQppbmNsdWRlL3VhcGkvbGludXgvc2VyaWFsX3JlZy5oDQoN
CiNkZWZpbmUgVUFSVF9SWCAgICAgICAgIDAgICAgICAgLyogSW46ICBSZWNlaXZlIGJ1ZmZlciAq
Lw0KI2RlZmluZSBVQVJUX1RYICAgICAgICAgMCAgICAgICAvKiBPdXQ6IFRyYW5zbWl0IGJ1ZmZl
ciAqLw0KI2RlZmluZSBVQVJUX0RMTCAgICAgICAgMCAgICAgICAvKiBPdXQ6IERpdmlzb3IgTGF0
Y2ggTG93ICovDQoNCiNkZWZpbmUgVUFSVF9JRVIgICAgICAgIDEgICAgICAgLyogT3V0OiBJbnRl
cnJ1cHQgRW5hYmxlIFJlZ2lzdGVyICovDQojZGVmaW5lIFVBUlRfRExNICAgICAgICAxICAgICAg
IC8qIE91dDogRGl2aXNvciBMYXRjaCBIaWdoICovDQoNCiNkZWZpbmUgVUFSVF9JSVIgICAgICAg
IDIgICAgICAgLyogSW46ICBJbnRlcnJ1cHQgSUQgUmVnaXN0ZXIgKi8NCiNkZWZpbmUgVUFSVF9G
Q1IgICAgICAgIDIgICAgICAgLyogT3V0OiBGSUZPIENvbnRyb2wgUmVnaXN0ZXIgKi8NCg0KVGhp
cyBoYXJkd2FyZSBpcyBjbGVhcmx5IHVzaW5nIHRoZSBvcmlnaW5hbCA4MjUwLzE2NDUwLzE2NTUw
IHRyaWNrcyB0byBzYXZlIGFkZHJlc3Mgc3BhY2UuDQoNClRoZSBvbmx5IGRpZmZlcmVuY2UgaXMg
dGhhdCB5b3VyIHJlZ2lzdGVycyBhcmUgc3BhY2VkIG91dCB3aXRoIGEgcmVnaXN0ZXIgc2hpZnQg
b2YgMiBzbyAxIGJlY29tZXMgMHgwNCwgMiBiZWNvbWVzIDB4MDggZXRjLg0KDQpJdCdzIG5vdCBl
dmVuIHRoZSBmaXJzdCBkb2luZyB0aGlzLCBlLmcuIHRoZSBEZXNpZ25XYXJlIDgyNTAgZHJpdmVy
IGRvZXMgdGhlIHNhbWUgdGhpbmcuDQoNClRoaXMgbmVlZHMgdG8gYmUgcmV3cml0dGVuIHVzaW5n
IHRoZSA4MjUwIGxpYnJhcnkgaW4gdGhlIGtlcm5lbCB1bmRlciBkcml2ZXJzL3R0eS9zZXJpYWwv
ODI1MC84MjUwX2FtYmFyZWxsYS5jDQpvciBzaW1pbGFyLg0KDQpQcm9iYWJseSB5b3Ugd2lsbCBn
ZXQgbXVjaCBsZXNzIGNvZGUgdG8gbWFpbnRhaW4gYW5kIGEgZmV3IGZlYXR1cmVzIGZvciBmcmVl
IHdoZW4geW91IGRvIHRoaXMuDQoNCllvdXJzLA0KTGludXMgV2FsbGVpag0KDQojIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjDQpUaGlzIEVYVEVSTkFMIGVtYWlsIGhhcyBiZWVuIHNjYW5uZWQgYnkgUHJvb2Zwb2ludCBF
bWFpbCBQcm90ZWN0IHNlcnZpY2UuDQoKKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgpUaGlzIGVtYWlsIGFuZCBhdHRh
Y2htZW50cyBjb250YWluIEFtYmFyZWxsYSBQcm9wcmlldGFyeSBhbmQvb3IgQ29uZmlkZW50aWFs
IEluZm9ybWF0aW9uIGFuZCBpcyBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGlu
ZGl2aWR1YWwocykgdG8gd2hvbSBpdCBpcyBhZGRyZXNzZWQuIEFueSB1bmF1dGhvcml6ZWQgcmV2
aWV3LCB1c2UsIGRpc2Nsb3N1cmUsIGRpc3RyaWJ1dGUsIGNvcHksIG9yIHByaW50IGlzIHByb2hp
Yml0ZWQuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRh
Y3QgdGhlIHNlbmRlciBieSByZXBseSBlbWFpbCBhbmQgZGVzdHJveSBhbGwgY29waWVzIG9mIHRo
ZSBvcmlnaW5hbCBtZXNzYWdlLiBUaGFuayB5b3UuCg==
