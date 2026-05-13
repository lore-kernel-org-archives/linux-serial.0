Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAFD3D3492
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655072; cv=fail; b=AGpNPTgrhHaJkLwSHb9+pn91Oc/0MZ9ieEpmbsQ/cGh82nB+QRTLKDRBiodp4Ubz8IswXYhcr4tBF+wcXtaSrPj8LiVBjDHmqMT1gIzMj5QkRUwjFnK5DdJJrpg7p8OISI45NY4fafCPEHyBlDPEwDsh25d292ZyIRsDJux2Lco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655072; c=relaxed/simple;
	bh=iT7XIUqhk4vNx9xB/1s11HVdbPcq+KhHpc4/fj9ObAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jdM2q9q1VfJPMVKX4+/74QowM6GvIa9tldkx0/Ax0Bx6f+8uZue+9VhRpSG6thxGKAP+OSSJ9sermdCKvouW93hVWG1eeSdNBo8IbnZaBv+nGj2yjh3QwtXiX3g9pHSLaKCfOnBw3WUpEmSw5u4mmo07RW7G/spwpGqkWd0S01I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=mN9gzI0L; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="mN9gzI0L"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1bvev009107;
	Tue, 12 May 2026 23:51:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=IrzZFd9rwMn+DpNQ37BO6psK/u2p4AakEv1QSvEO6Lk=; b=
	mN9gzI0L3F663pAyLiKqTFKN4hhbkRm5cCfhCyrHT74y4nkiEru2E+QrQUgnqrOd
	jJQG7axaSAItezBb2gVc/vNcd/z/FHhnc/SL/yaBQerd98SR7CNanYNMoP2oe7XR
	lMGJqo2O4eC2CxT+8OX7/nAjI84DM98oWO5llMpA50A89O3loMzmKnltTC3pY0Bw
	jjJeP9Uoy8uyX+s8r0QVN3nN1SwQBMmPYT0PIf1AHoHYajOZ2nMl3Fb6kxqxDwqm
	lMdgOupF9oOhmzOfGPUlScaGoB0J9l9X426Wqw1Mo1bUZ/75+80EH46d5eG2MP98
	NvVEXBr/Yv89TQ11P4JDXg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ftb8a21-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 23:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9U/S9Ztml6orEEGiRhuNHn/r1dzGP+rnZHY4CVnWGK4RKT3qvWq4GD4unqpUVvyWlXNQUxk7CE+QGcDKDZqoQWbi2o23LyBy77G6da9dCCIJnngV22Ek/efiMuLZz6JW9y8YvYAass75b2NLk1ZkvOvMtNoLjnNAQscD1y2lDBWm4H8nrgidWupA4TFOSn9xeyMFQeHDg3bXZll7ioaI4ObqUf+v+XQxTuDWGpVPbf7+Q8WIw1i4kcZRX0/zdunPCMhVerkl5t1oRlWIG3fmxy+j/b6yBKbb0pEQin6CxIXIrnBdVMIqptbyOn+8ViMD1YdCMv70yrFaNJPfbjEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrzZFd9rwMn+DpNQ37BO6psK/u2p4AakEv1QSvEO6Lk=;
 b=gtvm1uuCVHzvS8VBIOn931S3eWr0vqojraNIRGLwoOcA5noXY9HKDrMLzFPx/J/b2lBgcj/b9t3PL9r0tj1h0n2LvoFKksZU+7t25HLW89kmdJd5msUL+DkkTrYAkCz3x94fnsrSzaSOYwzvzCKw9zN5PVHBDBGQmoygziTFGbml28qvRlivxb7kNPP17hjVfXekatAVC/hgy5KB88bIz7KxKF3biGc9e4lwgjJ4EdEvK70XTDhRuglExY/QywtE5eHFtnxvmiopvu0o3gxycw5hnCm0gZwGdBKqIpinUL0IW4VjL02T0mz2L1xe9uUaqKXVCm4RncMvvebX9Ziacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:51:03 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:51:03 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@kernel.org, andriy.shevchenko@linux.intel.com, wander@redhat.com,
        chris.friesen@windriver.com, linux-serial@vger.kernel.org,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 07/10] serial: 8250: Add serial8250_handle_irq_locked()
Date: Wed, 13 May 2026 09:50:25 +0300
Message-ID: <20260513065028.112468-8-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513065028.112468-1-ionut.nechita@windriver.com>
References: <20260513065028.112468-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0105.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::34) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f18362c-9c85-4265-e3c0-08deb0bbff5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|10070799003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WFcS2yUtDy2rbXKX2fn4ueI5vgXutPumnYloYQP2zMyVD4npJpiqPz8iJ0sqIeOzvFq1lQYTiXPR3ocJBpwrMjlC3rpT6Q8IyKcxZLBW9GhnQ4IUNDOJYk2tbEwuzm6Y72LCoxeE9VCDVNWqmtQmQcaON5NRFIJzkntkcI3TcFClyHu/fe1N10iw6isxz+RxfRm/97ljZurRwkXrf1QgWAD62GWOS6uIVPN3o4Tv6TgC15UV3kaojH3dkKX9Xx2u+Y7Jd1T+WE53fqBAO7Z1QhlXi67u5WqYlOe1Wx5p7Wu7yMhGlv70cMVcvnZ/xeaPwKNSCZMpd30hnae9T1ZJn48DM9jH23LzTbi1i/fizIqq8s3dS/PFEBUV9gTGoDK6YEF3snrGEqUCq4vplg7OOf8j2WhwNCi6rAao/v0Gqce+13/EY/DxdrmWP5+etF368aeGvlgAPPKxxksEb/YDv/gRUB/EhnnAThmtoyOgR2b1kA+nFJX0BOZYyHZHpyI2wWINUAgY62SRBybpUKVLIw5OsKGIEfM49RMRD0SkXAa/roQQ6XCFNjH3vav8lPMVAlAbEBvhxSjDNtxlavP2yhSVV2l4NCJK7ModIjq5bCT7xkAHxRKPSWIOVOB4WXych/fsAN0cuILZIgr/IfTDDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(10070799003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnlFQmdIT3ptd0c2WTFjR0lLc1RESnRhSk05Snkrako5aGl1RnYzYnc1dUFX?=
 =?utf-8?B?NS9QdWorOTl6SzNRVTYvUVV5RGF3YnFNWjh0d1kyR2dNa05MU1ZmZVRmc0tk?=
 =?utf-8?B?NGQveCtnQysrZEVpbUFLUm1PcDVheC90d2o3QU1KcGNZSXQzdWc3d2s2ME9H?=
 =?utf-8?B?QXZCTTBwUWNFeVRNOUErWkVKQmppeWNCUlhnMFlHNEtib3pvN0xVZnlGMUZR?=
 =?utf-8?B?cm9PcXEzWDN2MlF4Mi9JaDAxejBBaUljTWFHeFk2Rk5qcDQ1TzNSemxDUk5s?=
 =?utf-8?B?MXM1WHFZbVQ4N2NrM1NEOHpDSFdJTE9CRXhWVnVmcEloNCttVVhhUTlvQ2RK?=
 =?utf-8?B?MFJUNGxIWXZaMnNFUnlqWXhtV3BHdzU2ZWlyZDE3VDBMNmY0S2IwUTJuZUsr?=
 =?utf-8?B?RG9BNzVTTDVHZ0QyRkY0aFZRZEY2RldlMnJaQ1RiUlJzOVozKzlIRjBOR1Iw?=
 =?utf-8?B?UWVtUFFzcTJSemgrY3RWVzFHbldiSEJaQWcrQU41LzNsSFBpNEpVT1JYTjZF?=
 =?utf-8?B?eHlMZXpiWXhEL0JMSkNRN3ZSQkxOYk51UE9ZeXloS0F1d29mU1hmYk5zRUFl?=
 =?utf-8?B?SFNpL0R2c3c1UmFQcTRVYVJqSnZSdGJ2RUd2L0huVGx1Sm5iaGtDK2VkMkxK?=
 =?utf-8?B?YXNJdDdLYjlQNUN6SEhnL1NXZHpnN0piSGlGQ3VLamplSGk3Y2d3NVNwVzA4?=
 =?utf-8?B?NHh3T3hUZnBPOEtMcGpMMjFScmlJblptNk1GaWV5a2lCVE1ZQmdWUjF2YXlR?=
 =?utf-8?B?VXhsSnZqTnQ0QU5TekdKeUkxcjlPb044VG5BNUVDQ3U4ZTFzUUlVYnZZSU5x?=
 =?utf-8?B?Q2EwQ29hWU1xQ1g2dHlpeFJVVTRMNGhSU1Bodjg5Zko1SWpYQURCV2w5K2Nu?=
 =?utf-8?B?UnRISHRZKzVRclVFNU1OU0NqZ3FHR1NNNm9XbEdGejVjODR4TXlUV1I0UWph?=
 =?utf-8?B?TW9TN0M2MFdvY3pJRURDeHlwbWI2VGkwMm9qK08wcUNrWHdOSW5tWDd1Tm84?=
 =?utf-8?B?MWNNd2Z3c0lzZElMNFZqd0tRRFlqLzY4Ly9OVVJNUVpvYWRiYytvSk0wNmRj?=
 =?utf-8?B?WE1sT2x2MnBMdzRRZW1yWkxlUUM5aytmbjZlRWEzSzFCZW0wb2g3ZWphM3Fl?=
 =?utf-8?B?c1lIUVAxclF5N3hhWkc2TkFZSHFCaStBSUx1ZlM4bGFHcUZNajZ3WUNrUlNE?=
 =?utf-8?B?TnBneUliNWp2VXpvc0FERS8vWmVrdlNZTEhYL2lmYmhGR2tOendPMEpOVWs5?=
 =?utf-8?B?M3lvKzUwYVV4b0l0Y0EyTDRaeStianBPNjZDZjRacFVNWU5rTmFYTXNQYStL?=
 =?utf-8?B?S0p3ejd5a1FBQTUrR3NKNEV4MjdVK1B2UkxnYUQxUld3aFFTekE4OU80Ry84?=
 =?utf-8?B?VnE1QldqbWJhU3RKRjFIcVlxb1Zhc1lYUWxYOFJyTkkvckl2QlBMQTNvcmQ2?=
 =?utf-8?B?a0tqMHgreTVDZzQ3TGMvQ3RtbVNpam90THhRa2NVYUI4OVM2cGdqc1J5elcr?=
 =?utf-8?B?ZWFjcUZMaUFielhxWkhaWFowaU5xVldMTnh4K1lTbWFOMk5CY0VIWlJKWWdO?=
 =?utf-8?B?OTN2Yld1MzdjeFdwcGFiSTVBU3lqTTc5SStZdExoYzBETGRGcCtMVzM4U2FL?=
 =?utf-8?B?L3hUY1hEbmZXcjJiS0FEVzdCeDBiZFhMenNwdXhWSDhQNW4reW52aFFTRmZD?=
 =?utf-8?B?V2h4dStaeHNtbHZIcXFBRFdzaG5jOEI2QlJnMmtGcWFFK09UL3VkaUEzL0NV?=
 =?utf-8?B?ZUJYN2NtejgzNnl2ajBIWUZONU9WWURiMDRhd2dncEUxS09odFZJRHBpTGRP?=
 =?utf-8?B?TFZyVjhJM2tMNFZ3S1JrZVljRzEzVEp1eVJ4V25TNklsSzFMWG00QkplaXpp?=
 =?utf-8?B?NTM5VHdQakpWQjN3QW16MDVzZWJWSDIrVTIxZjBPak1WZ2Y3bHpZT3lkVW5L?=
 =?utf-8?B?WmNmK09YbDVEL2dBTWZmV1BQWnNDOUU5ZUdZTGhmUk9XbU5ZZVFHV0Z3dmJR?=
 =?utf-8?B?cUZwSlo5cmpHc3NvUXVYQ3dvaFZHayswVHNDRng3UlY4RW4vUWtzK0FCYW0y?=
 =?utf-8?B?WHI4aDVVTldYazhqU0lEeXhWWE9nSEhoNmcyS1pWRGE4UUYzZUFsWXBHUU8z?=
 =?utf-8?B?T2dsbEY3cDhqT1BxT0tTM1BEK1Vla3R5OHc3d2RGRGZmbkNtdmoxMzZaZlNF?=
 =?utf-8?B?QWl6YWE1N1N2T29TNmdSS0FEWFhXU1FyWWJxV2hWTDdPb3k1M2JMcTlDYmtT?=
 =?utf-8?B?UGEwY3dRTWhIM01oM3hVNThVTXMvK21kSVlUREN6b2dsNTNEVGVPbFJWYm03?=
 =?utf-8?B?cjd0OGxnYmtQaEMvU0E2bXhEUVpOc1p6OHlnYktUNTFLWEpWN0F0REM3U1ox?=
 =?utf-8?Q?S8e/MMQYb8AqtHokvvOHn9JxX8B5Sl+UiX2viJZ23tVEP?=
X-MS-Exchange-AntiSpam-MessageData-1: EYSBw2Kj2EHwEMZNGxE/rI1ylK2cVX3M3aw=
X-Exchange-RoutingPolicyChecked:
	K2XQfrnSsjPXlb0fXk++E0oYWRJRI+Cges17aVzE0HbBA5ASGVncuto4KI5SHDcxYemHE2XSm1wt/bqNsoTS2rrnvAHy7Ql2BazOHMso6zDgPdfOlQAPkX8heukEqqYvqShKb3bjmCFPYGu+UDIFPoT81WiBmVTO8iQ0+ymnjphpYMOeZ5aEn36AKOWh/l6UDNvnTjf1m8NaEorfbZcKoEBjaLk4+P23faid+mryte4+hRF2jZbqBGiweAD5FTLHpjSobD9k/GVZZzOhudyB53644ftW6iGiu9nJjH/d56ZxD4WSIJLzg7FwGLcWB1gvNenarzSG2qHLvf3YimQxvw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f18362c-9c85-4265-e3c0-08deb0bbff5e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:51:02.4831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzWPkUbN4AT/5itNPX4LLz0d5r7hLMFO7ahoOExdlumuVLgRLxl42EGDHfAJc23mxBgXKZQW1RhurXg94xbN8uL8EIc4w7r/r7qenX4V9TA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2OCBTYWx0ZWRfX77fxkL7avDbx
 TC9N6uoOQaPOkNmKAGCVNoJe8Oepw0Icd1JTEeon6TgayLijX6Gz+THpvWDoeilj6DhcWC/JR4l
 k5fePh+xoY13wyeV2qh2Pm96ye0bKJPwKNj3D37+4OO1vvUXcD73rivXPA1PdV8ulNYE2USxxTq
 XjExb4044vKhpo7UcEdyvUmaciE6ceAacjAoO4GJzzUleOqPKkN05WpLmPZ4tUfstIPFJUZ4udX
 6q8Yd+RRYHwfc2PnKWM2J7u3D/BXdbITrlowUfgfOoF4i/Cq7iIHrOXPWPAj/ylaBZqVQJ3A/Jk
 1dqMFzyT3xOo6FyWTTCbsUQD+jdKSEuZc10bHQZwsfuCC+to2wkMot9UfymbBvr2Pc+FNaUZBF8
 OepTslYxnJ0koAtQrs2f7oBWJ/LtzPPjExCwXrnlaFUXEtabzB/mo5Occ0duN+1tMn33SOalpxe
 FVRwMpZwH07RL2BUumQ==
X-Proofpoint-GUID: ttGb_aGPP49EOAgTtN-tLUcWJH-V4Gz2
X-Authority-Analysis: v=2.4 cv=du/rzVg4 c=1 sm=1 tr=0 ts=6a041f59 cx=c_pps
 a=fOo0+MOGfjr111H4QC4BGg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=t7CeM3EgAAAA:8 a=Q1jSO7_fjeUD-lTkwVEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ttGb_aGPP49EOAgTtN-tLUcWJH-V4Gz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130068

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit 8324a54f604da18f21070702a8ad82ab2062787b upstream.

8250_port exports serial8250_handle_irq() to HW specific 8250 drivers.
It takes port's lock within but a HW specific 8250 driver may want to
take port's lock itself, do something, and then call the generic
handler in 8250_port but to do that, the caller has to release port's
lock for no good reason.

Introduce serial8250_handle_irq_locked() which a HW specific driver can
call while already holding port's lock.

As this is new export, put it straight into a namespace (where all 8250
exports should eventually be moved).

Tested-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Murthy, Shanth <shanth.murthy@intel.com>
Cc: stable <stable@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260203171049.4353-4-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Ionut: adapt to 6.12.y - use bare-identifier form in
 EXPORT_SYMBOL_NS_GPL(serial8250_handle_irq_locked, SERIAL_8250)
 because 6.12.y EXPORT_SYMBOL_NS_GPL() applies __stringify(ns) to
 the namespace argument; the upstream string-literal form fails the
 .vmlinux.export.c link step with "expected ':' or ')' before
 'SERIAL_8250'".]
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_port.c | 24 ++++++++++++++++--------
 include/linux/serial_8250.h         |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4252138ccc3d..d05254fb115a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -18,6 +18,7 @@
 #include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
+#include <linux/lockdep.h>
 #include <linux/sysrq.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
@@ -1884,20 +1885,16 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 }
 
 /*
- * This handles the interrupt from one port.
+ * Context: port's lock must be held by the caller.
  */
-int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
+void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
-	unsigned long flags;
 	u16 status;
 
-	if (iir & UART_IIR_NO_INT)
-		return 0;
-
-	uart_port_lock_irqsave(port, &flags);
+	lockdep_assert_held_once(&port->lock);
 
 	status = serial_lsr_in(up);
 
@@ -1930,8 +1927,19 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		else if (!up->dma->tx_running)
 			__stop_tx(up);
 	}
+}
+EXPORT_SYMBOL_NS_GPL(serial8250_handle_irq_locked, SERIAL_8250);
+
+/*
+ * This handles the interrupt from one port.
+ */
+int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
+{
+	if (iir & UART_IIR_NO_INT)
+		return 0;
 
-	uart_unlock_and_check_sysrq_irqrestore(port, flags);
+	guard(uart_port_lock_irqsave)(port);
+	serial8250_handle_irq_locked(port, iir);
 
 	return 1;
 }
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index e0717c8393d7..7e0439ecd496 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -195,6 +195,7 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot);
 int fsl8250_handle_irq(struct uart_port *port);
+void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
-- 
2.54.0

