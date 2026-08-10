Received: from mx0a-00622301.pphosted.com (mx0a-00622301.pphosted.com [205.220.163.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD604C6D;
	Mon, 10 Aug 2026 04:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.163.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786334553; cv=fail; b=b+nnpjpK/RqlneuFKsdutnimGjVb4QMjxcGAPYs+QiWmi2EuTFR0H6jqBnUN9uEXganO/8taVhpSXCVGmaGR+FlBkI4/MPD/oFyrc+PR60MK4zR+/AvlJ5MF0EzQKdejMuStnf4sy1zf1hM8rCCBSmJOaeS4EUjJewVv54EtL4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786334553; c=relaxed/simple;
	bh=oCfChCD1lPl2Nn4SDjes43Xg6GfF6QsN3DGAWZoYIOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=X/PCI4IjyhCEsbhdBO5dGnosHSLqeC8TIpxqyV7CWanjypAL2kY+ReJOC3rwUZH/7Wupdz6TPKxKouHoFeVkV16CSwQdu+6uwBe96F8DPTSe/JewXKNd9rJxySn7hn0fqFtGHEVgZMIy5uPjWMeaBL6Q0FJdIDBnKo+dMB6lTVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=St0jwkMP; dkim=fail (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=rpDOJTX6 reason="signature verification failed"; arc=fail smtp.client-ip=205.220.163.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="St0jwkMP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="rpDOJTX6"
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A3tSwE1750567;
	Sun, 9 Aug 2026 21:01:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=oCfChCD1lPl2Nn4SDjes43Xg6GfF6QsN3DGAWZoYIOI=; b=
	St0jwkMPtjqGr5HfFO2zmzt5TvJLma/xyyHuJu5zZouS2cMTHY5NepGSHn9i2DKE
	XZo4cfCR28hwb6P2WYnxBXZGoF4ld7xvsdkvnUTkemFg7fdYlXrnc9aetyhP/N/+
	ASoF3z39SEvgcOIlGO6FvI97u3qJ4lYto95gmno77tHDe1Z7Kx+5V9tz5Vi/W9CX
	kT4mYGhO6paxUzqsUxFz3+dMUhPdtEE8jYiFuwtwL22gNgazdyPXEzYSOq7TW96k
	FBXxQN0t4lZDgZAMzlF6FWaIjTsJrB2AfFJ7zs5CNH8zhvh/s9oIMn9Z82VN4GJK
	CGOzWl+Igxl2nAVzOuAh2Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021121.outbound.protection.outlook.com [40.93.194.121])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fx1eb8ysp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 21:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs7JWcoQDw1MLIHYrkIrx41CnACWS5ebHvcMlTUw8sFFlc6RxRq8OciZopx+z4AUNOqUlkiNjUy7gHSfvy45D5lwQrUuuimfrlyW1xjkSj8CgT5SoaTa5vgsbKgCSX/5rg0sYz6BGqcAWVPRP/S4LUvrpr91F6mKcsKrag8UlVt58fw74lGwY1NnXAKlblhBOcVVu2yQIdxXglAtDSGcSgQKMwGO+N7RyK0am8bA+HmkkQPxMYRnAdAGN047LRg04jasvjBLgKWsMWretP0Q1fY8jzamiIIppUzxR2qvi21e3xLMEmE/byU/Qyo8t0U8LPOOP9nk683190qpUvWDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFlqvDHny+iFvWwkZNMqKvqH22ODG3IGYWW+l+gTKy4=;
 b=xZw9yc2fr6eByOITLI4dItvDxE522GCfWmlYRC5pahZSwGXF/iEHkNe1hiB5+XHjh6GzORpHBWS+xizsQk0CcrxcxlVHigY4usZF1+BvvFVnHbpKNbQlTkczbzizlktqspYcSv/3Tf9NATlWBy3+J+mmeGP88k/Uzr2p+tRGutWfXPJCF5Cv2h101qLcySt/gntfsOV9Q+gCbYLUbVAgdv8hE2jpiN1R/dIc6yYKaVFaR3g6Q+c5+UKovH1XwRhIMf9ejAnw0bifmR8k6KSkhRfcpjdbgjVKZNGQtXIg9jbW4BjHBczqtWEWjxWkIxj82Y+KNuXafmpOWJcRAh84TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFlqvDHny+iFvWwkZNMqKvqH22ODG3IGYWW+l+gTKy4=;
 b=rpDOJTX6gXViwsz80MWory9mNZR8pmTc830tJ+SylvjNlvIjNh1O68FVsa2ZjRoACynllgzSSnfpovGia3pYnk0E4Uf0UhbKIIRll8HBTuIIchv8D/8Im+GbC/0fzn3uMFBoZ77oBr10C8a/0Sl0rvJxvuN0pSUez9UuyAmzw1MMOBtkFI9oXaUi4Qi/w8nBnGO+jSb26CWAg2Kfz9kTs8xtL1UriXEWBf4mMq7XHQ1H1prwfogJTJkz9eOVVrdGJWT56rjMz3fhxP3EQgSJIUyJi+i2U0jC/23LwbBNRpP9mc178nVOQ7eI9tP7VutUxZE5NCICVncs5PKZvo+1vw==
Received: from DS0PR19MB7925.namprd19.prod.outlook.com (2603:10b6:8:163::21)
 by SJ0PR19MB4400.namprd19.prod.outlook.com (2603:10b6:a03:28b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Mon, 10 Aug
 2026 04:01:52 +0000
Received: from DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b]) by DS0PR19MB7925.namprd19.prod.outlook.com
 ([fe80::dede:8f9c:d33e:6b8b%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 04:01:52 +0000
From: Long Zhao <longzhao@ambarella.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
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
Subject: RE: Re: [PATCH v2 07/10] pinctrl: ambarella: add Ambarella pin
 controller
Thread-Topic: Re: [PATCH v2 07/10] pinctrl: ambarella: add Ambarella pin
 controller
Thread-Index: AQHdKHz52LqwP35ofUyh1/WoQLt1aA==
Date: Mon, 10 Aug 2026 04:01:52 +0000
Message-ID:
 <DS0PR19MB7925690FD29D578D8AC5D10EDADE2@DS0PR19MB7925.namprd19.prod.outlook.com>
References:
 <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-7-6b09707c5fe9@ambarella.com>
 <CAD++jLk0LoOJk=TXin42AL3_z_7eVVkvMnYr1S8090C6A_B+dQ@mail.gmail.com>
In-Reply-To:
 <CAD++jLk0LoOJk=TXin42AL3_z_7eVVkvMnYr1S8090C6A_B+dQ@mail.gmail.com>
Accept-Language: en-US, zh-CN, en-001
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR19MB7925:EE_|SJ0PR19MB4400:EE_
x-ms-office365-filtering-correlation-id: 962fc15d-2779-4258-5086-08def6941c44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|4143699003|56012099006|6133799003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 p7jEhP7/tk0Y/u4jCHNax0x5ZOUa3YB95KCRvxEjkacgtorpl1J0zdjdLzxvE8fsIli1fB4vMosUVxn+KDHHaX3UaqpkUZfAmxzHf/WMx1EYcY/fe1BxLyj8iwIMZpDLcdXjLbN0W1DtxRISDcG+NHvVtWMn8ACd9IcdBNhNTBX3JNCrrc2o+qounXv+XoerIu3jYNGC0Dwz5xO2zi6mRUEoXlFhHMgIPiDRbT0EltG1/Nt54Em4GBRRruMcCpjfvy/VcZvZ0yIHFZdmdIDKrhmkwDN2JKa1jp6Fhx/kQKus/Jh5cmviLSERipkVeatHjSrpu9S/n+ysQwXadmWECwWEZ+nRIsZOD4LT3v5ATgftGHx4PpPZjk1sTQ+DZW/qpYiAW4WSw1il2cB3z1g1/ng4tPsP+jWvmcU3a62rYcJMK067T98Op92b4oy5IxagWeSFrvJeu7sjMURsX6coDyMQNsDbMGhZgUzwO+SZQDGdvf+3zS9Li+2/WsS7O5sRHkr9ST+HkRICqe1a/6/4lj9ClB+JuFbCKFJSPY+POTMM96YzECFVmfqk2BbPcs5La/xKIZ+nnYE9Wm0qc6sbvbByfo+9aJN89v501Gbaq8yeoivlfPR7Fk9SLuQPGus/LiRrzbvcw7i3PPw7Le1rj3I0tskA1n+QNQMbUPhGCr4rcSL06TlfzjbLOnjS/sklZ+GWL2wNqAKN3r6l2glw9QIZ2pFT2f19DywQvNyFUfA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR19MB7925.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(6133799003)(10067099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blo3VmZXbk4yZFRpenIyOERzd0JiVkkzNkhEOXpvTTlwL3c5UTJvWldXc1Ew?=
 =?utf-8?B?KzR5TVlxcTVFeEJ4ZTFwcHFsa29UWTJwbzZqNUkwZHNHRzV6dGlEY0NCeEJi?=
 =?utf-8?B?dnJXK0NHa0kxTWFQWjNkck1yRmpUUGpoRjZES2YzYlUrcndLMlpHc0drUGtO?=
 =?utf-8?B?SkZvL1hHRDJXZy9raWs4QWZqcC9ndlNISTk4SFRjYUZqaUdpeDFPNXV0enNx?=
 =?utf-8?B?WG5uZmtFWGRJc0t3M3NWdW02Vjh6Mlp5dEd1clYvYjNYVnZOSDJ5QVFyRWE3?=
 =?utf-8?B?R25ZWkQ1SEQvVjVld0JCU3UyOW1ZcmF3YWhvTmNrSGhxaHRuOC9nbnNHcGJQ?=
 =?utf-8?B?UVpVUTVWYmpNbUZDM2lhY3hBZ0ZZaytHNFd2R09yRGpsa1lCdkRQMWcwWlpY?=
 =?utf-8?B?T0RWOFh4ak1lZHJkemN5bVNnOXhrdDQ1VGNoT2Y1aDhtNWFBRDB4anJOKzlp?=
 =?utf-8?B?TFVvTUM1UVFDU3MwTWVuUlF4UUpuYS90a095cjltU3ZjV0p4a0NNL2dNRVV3?=
 =?utf-8?B?UjBhcEZnS1A1aElqdFBRRXRkSTVQa3pSSGM5d3Q1bXNDelFzWno4d29tTlRT?=
 =?utf-8?B?Y3JpVnV4cUNLZ2oxVzhjdVlmVnR6dE51WGFwaWR6cDBMTWdCQit1VlBrMGJw?=
 =?utf-8?B?RGRGWHR2dEI5bmRHK2FXMy9RVUhVeHdKUERKaHFDZWZYYU1yNzQ5cGVGdnFl?=
 =?utf-8?B?S3JyWlNWVTloQmIyR3ZmbGV6dmJjRHNGRy9MSHFaU2RJUDN0WExsMWpoRjhl?=
 =?utf-8?B?eEhWNnJsVU5EekVTditHZlZ1T0dGYW5zbDZ5ZUUrcWZHTGFzVCtRTUVmT1E5?=
 =?utf-8?B?aUNPTjRNQUJQU0E1ZnNYOVZibjdzMGpJS2VLMVVvN1JpWGxWL3QySTJpUDV5?=
 =?utf-8?B?TGQvUkh1VWhXN1lOUWxvNTk5a0NPTUorQmhsYTdPQXd3bnlrcDlHRFBFTkp0?=
 =?utf-8?B?Yk80NDk1aVo4SWJIT3dRWnNsS3duK0FSQTZaOVJCTzltZ1V2aHV6dm4xS0VC?=
 =?utf-8?B?UEpTbCtWd2Q2SVZ6emlPdHQwcnhlU0ppaDZzL1YxN0RNRUFUMEdmNUd1eE4z?=
 =?utf-8?B?N0dlQVI0b29GQkVUeGl4QmZNSU1GZG5OWmgwUytXOFJaQXRPaU1nZVUvUUhm?=
 =?utf-8?B?L3o4MlFqbVo3TnM4MnF2SFgyVllkdXc2QTB5UUJSdUZuai9HRGNhTEwvK282?=
 =?utf-8?B?Z01ueGZ2akxqKzFxcTBmSjYrY0RPeVUxL2lUZTdmVWU2U2MvVWtxVXAxZGFX?=
 =?utf-8?B?RS9IbXFCMW5DZm1nbk9nV0V4eUEyZGtxdVZEczgxazUrY3R2dDgzcWZQcysz?=
 =?utf-8?B?OVB6UTNLSGJYeGUyVk16VjZielVpUXhzNUxKSmpiY3hnbDUwbzdFQUc0NmdJ?=
 =?utf-8?B?c3FSZi9iREY2eDkyRjVmSGxRUGxsa1FOZGNMR2JKSkdzYjZod1JsUndTeUQr?=
 =?utf-8?B?MCtVMVBCb09MbjVpVTN5WGRFWVJCNncxcUFudEs2eVJMYk9JeDlvekdnVjh4?=
 =?utf-8?B?NlFkb2xtOEhsTWRTUFRydUFLUHRUZXJva0JTUk1iR2p6UzYvcWgyUmVNSkU0?=
 =?utf-8?B?aFNuWGpUVllMU3p0OGg2K2h5V1Z5RkRyanE3TGMzUUYwb1FsYUl0VG1aQ3J1?=
 =?utf-8?B?aGVOcmx0QzFPQXBNYlRBMW44b1ZkV240b1UrT2g2aEwzaTBEdFk5bExWWWRT?=
 =?utf-8?B?azNzcmdVaWhIb2lRckNsTnpVUjZNT3lZQU5QTWo0YWJaanMwdXJGQVNRYU4w?=
 =?utf-8?B?WmxwMEIwVDVtVVdhZkQ2OEtuNHVFZzBiSE44M2VxYThRZnVtUytmNlVYQjBJ?=
 =?utf-8?B?SWxuWFBRRHJrL0V3amY2VU5MelFQYTFDRk4zaks2NVNsRmtXbDZkLzJhWGE0?=
 =?utf-8?B?dGNXYi8xdXhDTEp1YkRuWGRrT0JOYVBDVDUwL2wzdW1MNUhodWhCYjhSNVk5?=
 =?utf-8?B?Qk9CY1pPN29HSWJBTTJCZVBHcDR4RUJYV1IxMlpuSmVmTlA5cTlIYVUzTUY5?=
 =?utf-8?B?Y1RDcjJiYUJ5S0c4aURyUUNuMFJxTTZPZ1kvTmFqcS9yeHZZRDc3a0JwK1Jl?=
 =?utf-8?B?eDlFRTBlZmh6Z01rY2hjWFpYYVlPQ2l4R295NlhaSS9ZODBXb3R3OENKNmdi?=
 =?utf-8?B?TXNzUEhzYXlrc3ZHeU5KTVEvZVpLVTNRcDdHbXNpQXdGbVhZOVEwcEszNVpS?=
 =?utf-8?B?WG14UElxeEdHaEdPa2U4Kzg4WXBIVVprcjVUTERLRWtJdVhBQUlRQlRGa0ZD?=
 =?utf-8?B?ZDlKakpmNVJ5MWgxazBQMDVyM3p3T2pJblFvcXhsRVZTN3RzaGduN0ZTN2dV?=
 =?utf-8?B?NENBKzQwREVENkF0enQzcVFKcW83TTJOTUZCcmZrMFRIeCtVNUJxUT09?=
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ns9dV7M65piYYt65Kdixu33jXfkic/bqCn3PSuQxOzd8B+Ukwn4sc/3tuP2jYP0ssQMLg5293fX+fzzC5egQj7fwRTF1A3Hl8hVyLfvG1nAn/pwogC/ULySZPesOID9VwAM40SCVccoW6rZHuuZahu7K9kkjJsHuTg3lGClsrnhFC0XIfylpi2qg/fLdPt9Uce4djaNIRPuMJwnLnjlJt4eso0R8XjzcdpBmbB0Q8vGYGQfGt3PPLApcsPCD0Vnsm8dBcBH6iJKAPemnY8MQP9QDBrWDpDjTVr9xrEeEUgaYeCUqYAecbARBOwugWhoL8QjcahJiugdIVdCTvuJNlw==
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR19MB7925.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962fc15d-2779-4258-5086-08def6941c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 04:01:52.2864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: os9GFJiYrmhDfilxVeKi7QEJzxhXNU9ATvJUmOPEHMdaootmYga/q8jYW4pYsBNNoP+WKjQsAV1vYvOIfjSx7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4400
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyOSBTYWx0ZWRfX/oot37qB2XDa
 0GiYkLTf/bNzYHpFkVUqqFSs0/VaDN/rj2cyjGW1K1TH5zkbFqSTiXeNhQdZTBcSPUK2yV2kNFt
 YqX/hAcOvxNJzRr16wXi0lOxpDNw9qJrLqQ4a/HtZCCAJ3fes0GUGjjSl5hVXYhcJEdI0WMCOUd
 gqjREpbRrCC/0O4Q4EkywVXNk8yxBUSCXkil/OGNb7jazUKfoebeRbM+kxWyAlHF7OnyeNBMDtZ
 YLK19ddWkfGLLJV3DPJ/AfrBI9XkvSr2YnERbx1aOfqbR/tI+eDwDuSfhdNfDHc707vkGN0rBnZ
 qV4BO8oZ0E4c2B//XR+M+1H6fy/cHcyBEEMh+xHvjgAbYbW8h4gESJ8kka0LOEIUbVPkI+Hs/bC
 gqnLLur/ecvmI6m1FsZKmtyazm7JYUXwsHnh03Q2Y/cF14Ga/dCKlKu0VmgGQQuKr4G8E8g4epu
 SnjcWI5CL13qfIz5IHg==
X-Proofpoint-ORIG-GUID: S_jn3_TlDdBNn5b2M18debA-EbrFxcUj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyOSBTYWx0ZWRfX9HzimrfEd012
 gXeAjwQhZLp/D03GOJsOQT/TLgSTEzb4jC8+eKcc0xNuQS8NH8rIf13zbS8x86Fgda4jGPHiR8a
 QsOXHgqQSQAMS7mgByaFS6jjPt/O0pIZzs4DPucDOjCBpPPIHe8e
X-Proofpoint-GUID: S_jn3_TlDdBNn5b2M18debA-EbrFxcUj
X-Authority-Analysis: v=2.4 cv=Y+jIdBeN c=1 sm=1 tr=0 ts=6a794d36 cx=c_pps
 a=GRNSBXvNJw0HWouCR8jgEQ==:117 a=fVfL832+mzDTHoFKNp42fb2xq0E=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=dkMdDuzY2HgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22 a=pzaFphlX3Qn9zwH3AKfV:22
 a=VwQbUJbxAAAA:8 a=ppJngBeKAAAA:8 a=IpJZQVW2AAAA:8 a=ag1SF4gXAAAA:8
 a=7CQSdrXTAAAA:8 a=P-IC7800AAAA:8 a=JfrnYn6hAAAA:8 a=baHzRV-oNzLVrs8r5KsA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=d3PnA9EDa4IxuAV0gXij:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100029
Content-Type: text/plain; charset="utf-8"

SGkgTGludXMsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gSSB3aWxsIHJld29yayB0aGlzIHRv
IHJldXNlIHRoZSBQTDA2MSBkcml2ZXIgd2l0aA0KcGVyLXZhcmlhbnQgcmVnaXN0ZXIgb2Zmc2V0
cywgYW5kIGV2YWx1YXRlIG1vZGVsaW5nIGVhY2ggR1BJTyBiYW5rIGFzIGENCnNlcGFyYXRlIERU
IGVudGl0eS4gVGhlIGR1cGxpY2F0ZWQgR1BJTyBpbXBsZW1lbnRhdGlvbiB3aWxsIGJlIHJlbW92
ZWQuDQoNCkJlc3QgcmVnYXJkcywNCkxvbmcNCg0KQW1iYXJlbGxhIFNoYW5naGFpIENvLiwgTHRk
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGludXMgV2FsbGVpaiA8bGludXN3
QGtlcm5lbC5vcmc+IA0KU2VudDogU2F0dXJkYXksIEF1Z3VzdCA4LCAyMDI2IDAxOjQ1DQpUbzog
TG9uZyBaaGFvIDxsb25nemhhb0BhbWJhcmVsbGEuY29tPjsgQmFydG9zeiBHb2xhc3pld3NraSA8
YnJnbEBrZXJuZWwub3JnPg0KQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9y
K2R0QGtlcm5lbC5vcmc+OyBNaWNoYWVsIFR1cnF1ZXR0ZSA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5j
b20+OyBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+OyBHcmVnIEtyb2FoLUhhcnRtYW4g
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5l
bC5vcmc+OyBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBE
ZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBB
bGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+OyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsgbGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9y
Zzsgc29jQGxpc3RzLmxpbnV4LmRldg0KU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MiAwNy8x
MF0gcGluY3RybDogYW1iYXJlbGxhOiBhZGQgQW1iYXJlbGxhIHBpbiBjb250cm9sbGVyDQoNCkhp
IExvbmcsDQoNCnRoYW5rcyBmb3IgeW91ciBwYXRjaCENCg0KT24gVGh1LCBBdWcgNiwgMjAyNiBh
dCAxMTozNOKAr0FNIExvbmcgWmhhbyB2aWEgQjQgUmVsYXkgPGRldm51bGwrbG9uZ3poYW8uYW1i
YXJlbGxhLmNvbUBrZXJuZWwub3JnPiB3cm90ZToNCg0KPiArI2RlZmluZSBHUElPX0RBVEFfT0ZG
U0VUICAgICAgICAgICAgICAgMHgwMA0KPiArI2RlZmluZSBHUElPX0RJUl9PRkZTRVQgICAgICAg
ICAgICAgICAgICAgICAgICAweDA0DQo+ICsjZGVmaW5lIEdQSU9fSVNfT0ZGU0VUICAgICAgICAg
ICAgICAgICAweDA4DQo+ICsjZGVmaW5lIEdQSU9fSUJFX09GRlNFVCAgICAgICAgICAgICAgICAg
ICAgICAgIDB4MGMNCj4gKyNkZWZpbmUgR1BJT19JRVZfT0ZGU0VUICAgICAgICAgICAgICAgICAg
ICAgICAgMHgxMA0KPiArI2RlZmluZSBHUElPX0lFX09GRlNFVCAgICAgICAgICAgICAgICAgMHgx
NA0KPiArI2RlZmluZSBHUElPX0FGU0VMX09GRlNFVCAgICAgICAgICAgICAgMHgxOA0KPiArI2Rl
ZmluZSBHUElPX1JJU19PRkZTRVQgICAgICAgICAgICAgICAgICAgICAgICAweDFjDQo+ICsjZGVm
aW5lIEdQSU9fTUlTX09GRlNFVCAgICAgICAgICAgICAgICAgICAgICAgIDB4MjANCj4gKyNkZWZp
bmUgR1BJT19JQ19PRkZTRVQgICAgICAgICAgICAgICAgIDB4MjQNCj4gKyNkZWZpbmUgR1BJT19N
QVNLX09GRlNFVCAgICAgICAgICAgICAgIDB4MjgNCj4gKyNkZWZpbmUgR1BJT19FTkFCTEVfT0ZG
U0VUICAgICAgICAgICAgIDB4MmMNCg0KQXMgZXZlcnlvbmUgY2FuIHNlZSBmcm9tIGEgbWlsZSBh
d2F5IHRoaXMgaXMgYSBtb2RpZmllZCBBUk0gUEwwNjEgcHJpbWVjZWxsLCBzZWUgZHJpdmVycy9n
cGlvL2dwaW8tcGwwNjEuYy4NCg0KSSdtIG5vdCB2ZXJ5IGludGVyZXN0ZWQgaW4gaGF2aW5nIHR3
byBkcml2ZXJzIGZvciBwcmV0dHkgbXVjaCB0aGUgc2FtZSBoYXJkd2FyZSBpbiB0aGUga2VybmVs
LiBPZGRzIGFyZSB0aGF0IHRoZXJlIHdpbGwgYmUgbmV3IHF1aXJrcyBhbmQgZml4ZWQgdG8gb25l
IG9mIHRoZSBkcml2ZXJzIHRoYXQgdGhlIG90aGVyIG9uZSBkb2Vzbid0IGdldCA6LyBBbHNvIHRo
ZSBQTDA2MSBkcml2ZXIgaXMgcHJldHR5IGNvbXBsZXggYW5kIHNwZWNpYWxpemVkIGFzIEdQSU8g
ZHJpdmVycyBnbyBhbHJlYWR5LiBJIGNlcnRhaW5seSBkb24ndCB3YW50IHRvIGhhdmUgYSBzZWNv
bmQgY29weSBvZiB0aGF0Lg0KDQpXZSBuZWVkIHRvIGZpbmQgYSB3YXkgdG8gcmUtdXNlIHRoZSBQ
TDA2MSBkcml2ZXIgd2l0aCB0aGlzIHBpbiBjb250cm9sbGVyLg0KDQoxLiBNb2RpZnkgdGhlIGV4
aXN0aW5nIFBMMDYxIGRyaXZlciB0byB1c2UgYSBkeW5hbWljIHJlZ2lzdGVyDQogIGxheW91dCwg
aS5lLiBtYWtlIHRoZSBkaWZmZXJlbnQgcmVnaXN0ZXIgbG9jYXRpb25zIHBhcnQgb2Ygc29tZQ0K
ICBwZXItdmFyaWFudCBkYXRhOg0KDQpzdHJ1Y3QgdmVuZG9yX2RhdGEgew0KICAgIHUzMiBkYXRh
X29mZnNldDsNCiAgICB1MzIgZGlyX29mZnNldDsNCi4uLg0KfTsNCg0KQWRkOg0KDQpzdHJ1Y3Qg
cGwwNjEgew0KICAgIHN0cnVjdCB2ZW5kb3JfZGF0YSAqdmFyaWFudDsNCi4uLg0KfTsNCg0KQWRk
IHZlbmRvciBkYXRhIHRvIHRoZSBQTDA2MSB2YXJpYW50Og0KDQpzdGF0aWMgc3RydWN0IHZlbmRv
cl9kYXRhIHZlbmRvcl9hcm0gPSB7Li4ufTsNCg0Kc3RhdGljIHN0cnVjdCB2ZW5kb3JfZGF0YSB2
ZW5kb3JfYW1iYXJlbGxhID0gey4uLn07DQoNCnN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1iYV9pZCBw
bDA2MV9pZHNbXSA9IHsNCiAgICAgICAgew0KICAgICAgICAgICAgICAgIC5pZCAgICAgPSAweDAw
MDQxMDYxLA0KICAgICAgICAgICAgICAgIC5tYXNrICAgPSAweDAwMGZmZmZmLA0KICAgICAgICAg
ICAgICAgIC4gZGF0YSA9ICZ2ZW5kb3JfYXJtOw0KICAgICAgICB9LA0KICAgICAgICB7DQogICAg
ICAgICAgICAgICAuaWQgPSAvKiBtYWtlIHNvbWV0aGluZyB1cCwgc2VlIGluY2x1ZGUvbGludXgv
YW1iYS9idXMuaCAqLw0KICAgICAgICAgICAgICAgLm1hc2sgPSAuLi4uDQogICAgICAgICAgICAg
ICAuZGF0YSA9ICZ2ZW5kb3JfYW1iYXJlbGxhOw0KICAgICAgICB9LA0KDQoNCkVzc2VudGlhbGx5
IGZvbGxvdyB0aGUgcGF0dGVybiBmcm9tIGRyaXZlcnMvc3BpL3NwaS1wbDAyMi5jLg0KDQoyLiBD
b250ZW1wbGF0ZSBpZiB0aGUgR1BJTyBzaG91bGQgYmUgYSBzZXBhcmF0ZSBlbnRpdHkgaW4gdGhl
ICBkZXZpY2UgdHJlZSBvciBub3QuIElmIG5vdCwgTGludXggbmVlZHMgdG8gc3Bhd24gdGhlIG5l
dyBBTUJBICBkZXZpY2Ugd2l0aCB0aGlzIHBpbiBjb250cm9sIGRyaXZlciB1c2luZyBlLmcuDQog
YW1iYV9kZXZpY2VfYWxsb2MoKSBhbmQgYW1iYV9kZXZpY2VfcmVnaXN0ZXIoKSBldGMsICBzZWUg
ZHJpdmVycy9vZi9wbGF0Zm9ybS5jDQoNCjMuIHNlbGVjdCBHUElPX1BMMDYxIGluIEtjb25maWcg
Zm9yIHRoaXMgcGluIGNvbnRyb2xsZXIuLi4NCg0KVGhpcyBpcyBub3QgYSBzaW1wbGUgc29sdXRp
b24gYnV0IGl0IGlzIHRoZSByaWdodCBvbmUuDQoNCllvdXJzLA0KTGludXMgV2FsbGVpag0KDQoj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjDQpUaGlzIEVYVEVSTkFMIGVtYWlsIGhhcyBiZWVuIHNjYW5uZWQgYnkgUHJv
b2Zwb2ludCBFbWFpbCBQcm90ZWN0IHNlcnZpY2UuDQoKKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgpUaGlzIGVtYWls
IGFuZCBhdHRhY2htZW50cyBjb250YWluIEFtYmFyZWxsYSBQcm9wcmlldGFyeSBhbmQvb3IgQ29u
ZmlkZW50aWFsIEluZm9ybWF0aW9uIGFuZCBpcyBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ug
b2YgdGhlIGluZGl2aWR1YWwocykgdG8gd2hvbSBpdCBpcyBhZGRyZXNzZWQuIEFueSB1bmF1dGhv
cml6ZWQgcmV2aWV3LCB1c2UsIGRpc2Nsb3N1cmUsIGRpc3RyaWJ1dGUsIGNvcHksIG9yIHByaW50
IGlzIHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCwgcGxl
YXNlIGNvbnRhY3QgdGhlIHNlbmRlciBieSByZXBseSBlbWFpbCBhbmQgZGVzdHJveSBhbGwgY29w
aWVzIG9mIHRoZSBvcmlnaW5hbCBtZXNzYWdlLiBUaGFuayB5b3UuCg==
