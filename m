Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263EA205E0E;
	Tue, 18 Mar 2025 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.146.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333977; cv=fail; b=Y5KlAJTI69/OIm6qn+Iwibyw8uNkW5l27AEIv+jZ5JE+PPYXtE5Yq9STXGVEAzLyRv/bu+2QNU+Pb+MCHcaYUOkjs2HlBtUKWzS6cmRqiOoO+8HLp5BCsiD1u62tM1LficXO1WS8L4yANV38MQ+OTEewIEfFu/riHXBwZsSZ9aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333977; c=relaxed/simple;
	bh=q16bldIl7Yc1NZ3enlO54rh4drn6C0F1nEgRKdg6Y3c=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=j3MfGsTnkz2T07QiA6EvGmT25zRucrc9bRVceGfORFAM4NxghTEsIHjAum6A4/jJgjpq8B5YCHlcxu6GPSyxqO3TzWPgQafWC4yANfO3YNPHZ371kfKQJ8AnsPgvknMB1rwix6UOQt5vHDwQUV5nhfZ9aCMSoWcqc184aMUamQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=M7vmLo62; dkim=pass (2048-bit key) header.d=Emerson.com header.i=@Emerson.com header.b=4r3CFr61; arc=fail smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="M7vmLo62";
	dkim=pass (2048-bit key) header.d=Emerson.com header.i=@Emerson.com header.b="4r3CFr61"
Received: from pps.filterd (m0359308.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ILONPH005949;
	Tue, 18 Mar 2025 21:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=email; bh=UxV+BX2PSdUxuhKWz5qITRrqks
	H8s3C0BNzR8jADgjQ=; b=M7vmLo62J3jy6rTd3jhXzJ+RUIaLTAHZfzDPDZS+6L
	2hVEWCV2iSRpKs2439lsyUGOD95Q1LG4DNYgOJZcrbbikrE7ReVE/rzgNLK+iQsM
	kZqfzzdpy29DDMWhJ+CFeZXsF0/gdeDnI7gs7HtMccBPFpqQpA1+cFsLNWfahiNM
	miUNYvYqemKeJYHVKsNrT/D/h9rsNQRxRFWFsxPGA8pysmYFOrmh4fcNKyha0dpo
	+TZ/jDWoKmxy8+mjKDGBux+eU2UKanlmefSDl8bulsguB0B3wGvXWPxgnmTeO9h7
	aivpiNYiOWwN3U7XOHGNDeKT7lnZodG19RyuTi2/GQIQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 45fgkfg827-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 21:39:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0jZV3rAZHessEl188i+zb4F1do0SvdlKTsAvChKo55kVitYw+gUCMxm0oqUI+Ig//Lv05IONI1a3PIjetC2WkHbSmW9QdeaQyossycczlDlSsIBGJQBv99mGeNOfa1jQh4395oPhdiOC08J8Yji6n4vOl4Nbx7IMntyZbtXn2LSGHVLNHsDoWgeD8XFTgriYLZsNXJwnHOH7FWt5SNT3xpbyEpY3kn/zC1oM9WoKeO+8V84YwR10yIq9rnnMCkv5dhLlFyCvK96EbmBknX1RW51WAuflmI82SqZBnaVzeummOodY9xvAlq/iksWtouViVJz6crl2t8l79cr+MfIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxV+BX2PSdUxuhKWz5qITRrqksH8s3C0BNzR8jADgjQ=;
 b=SPhjRm4H77fAZmmiEifvTyS9h+CjK1HO283E0l62EOIzC0WxZzpXs0uK2AXc7J0mJhdp+WxfI5h+K98Ld78NWt1zjXZuxXETsW/YJU/CeSOn8dY2DVo1LIGu1QwYJJ8aMWxtEcCzeo9oZH3eV3zIY3RDdo4fHtHBaHa/Cdfm2h+1N24CGXgcTN5rGMJdoL/KiuULR/XrVwnC7vFlkCSQ2YnpJgUnNxytJ6xqcHMcK1Du/uY8hUbo+fhOCDV+QqEa7BQqSILTjV3HpcNVK9JN59+iOsB0h1W2Hk7HlxNqDdJlTRQVY6RcWqYQYjUNYjhrupt4J4Pgn9oDDTBfPg1c+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Emerson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxV+BX2PSdUxuhKWz5qITRrqksH8s3C0BNzR8jADgjQ=;
 b=4r3CFr610j0K0kqEVNZSklPTKBxOaPrbXSY3w8CFb9/mZGSM2diKvGyy4p0BcN//6hQO3FDpQfKRBUiOQPxGcxx73I0QVodUanV+nVvnJvFsXLPWOyPg95CSfDxMfFESYfRIuHwknyuep2J9bNaHoQ41pX/pslrt1nisIDAODWooXOBEjddoX6gm2K8iBVcEfV2OpKmqlulQfd2a4qdj3+xKO04P8G+Ph+IUPbg64v3F3S3YmQ1nKx4eCaRqA6ZeCElgOyKRrtZF708YMkMqKrTwGXiBSJLG/li/eWE/47wBCTAprVSTBnmqO2CtWUKmE4AlH//p1O5o3moOG+tvBw==
Received: from MW6PR10MB7640.namprd10.prod.outlook.com (2603:10b6:303:245::13)
 by CO1PR10MB4547.namprd10.prod.outlook.com (2603:10b6:303:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 21:39:14 +0000
Received: from MW6PR10MB7640.namprd10.prod.outlook.com
 ([fe80::ba9c:1796:379f:af54]) by MW6PR10MB7640.namprd10.prod.outlook.com
 ([fe80::ba9c:1796:379f:af54%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 21:39:14 +0000
Message-ID: <a3b0df6d-1dd5-4cc4-a7e1-4ed51fb9e4cc@emerson.com>
Date: Tue, 18 Mar 2025 16:39:12 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: chaitanya.vadrevu@emerson.com, gratian.crisan@emerson.com,
        jason.smith@emerson.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
From: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
Subject: [PATCH] serial: 8250: add driver for NI UARTs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:806:23::25) To MW6PR10MB7640.namprd10.prod.outlook.com
 (2603:10b6:303:245::13)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7640:EE_|CO1PR10MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: be9491c3-a23b-4612-b45c-08dd666553ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?andJZm80UitHcWVld2RxMnphM2tkRDlEdHI3Q3piNkhNV1ZWS3lkY0pCd1Ra?=
 =?utf-8?B?SS9wczd5bG9oRHUxZ0pjNHJZa3UxbW5ITktsUjZsZGtvSFdBNk1YWExPcE9j?=
 =?utf-8?B?N2VRVG52bENRNHh3a2lJNkhLZ25URUk1SzhCZ091ekFybVp6bS9PcEdEZVEy?=
 =?utf-8?B?Tk8vd2d6cko2MUNrcDFQWEdkTmNBTWVSSm8wK0hZcG5RMGZWWnZ6NGFnczQ0?=
 =?utf-8?B?c1FCZ2JBTHFadkM3VVdtSEtLbThHa2JocXk3cXc0a2ZIejNqcjNDTTFWQTlQ?=
 =?utf-8?B?bjFvVGkybEVWbm9PODFZU2hORktabzJwR2U0c1VXcUxBMTRFeXd6c2lVTGds?=
 =?utf-8?B?ak9lV3hNcVQ1eGQ4SERreUFkcFJ0TG96NVNKc3ZIWFJOOW94c2VHTEhXeTVQ?=
 =?utf-8?B?NlRHMEw4d2VwckVuSG5kZXhYYzlKWXdESXBTb3BWR2E2TDJEY0oxQzlPLytt?=
 =?utf-8?B?TFBiSTlSb3MyRTZJRUU3K3lUWWwwbXpLM0Rody9rcDdNM3A0c0kxVjAxSDNZ?=
 =?utf-8?B?OWpTVXFnVUNPRHMxUXdaU3BuUjNXVDV2NThiRUUyd21jM1VGb1FjUFVNK2wy?=
 =?utf-8?B?cU5abTQybXJGWkk2cFJmNnF5SWx0TEZaT3M0QVhCWEJmNHVjVVpYN3RsUmJi?=
 =?utf-8?B?d3YrNnYwZHhqcXpURC9SM1dOTUhXRU9wS0t0dm1zbnN1YWxvY2ZQeXlqMWtt?=
 =?utf-8?B?R3pYeE0zSER5dWp3U3NyTEk4cHd2VWw1NkdlTGZ6VjFJMTRIMTZXbHZJNE9z?=
 =?utf-8?B?SzVBc3NMUnlDQThZVkxOcXM4K3hyU1lvTEovWlJMTWVNVXV4cWtjOFFCQ0VC?=
 =?utf-8?B?azhOZXY3Q09jamhsc3h2ZzFYN0FxanZzSmpzVWlDNGFHZUg4amlWclk1ZGtD?=
 =?utf-8?B?RHQ2b0hMSzZ1UEVadlBMVEs2ejVFUlVKc2lOR2xGY25SVnpuSERjTktRQ21K?=
 =?utf-8?B?b0Nzb3JtNm4vSVQ3akpnOEVvM3BQKzlETXlkRkx5Y3ZDWDZRSFVYQWllNk5D?=
 =?utf-8?B?a254U1V0aWZLaUdvTEd4Z1lYTGZlYm9hQ1dFbDFDSlR6VmlPK0kwUVVMUXI1?=
 =?utf-8?B?K1lheG5RNzJISU5aQmhkMVlPMkxhY3pDSWFjOGJSSG51aHloR0FXMDEzeEln?=
 =?utf-8?B?T3Z5Z1JuT1RvV3UxSmU1L01mNStsb01hQjB6NjVNYXVrY1hjbEkwcVVodWJn?=
 =?utf-8?B?YzFmKzJiMkhjTE16WEhlaTNmWFR5dTdON3J1a1BTb2RQM3RwSkRPU3QwNk82?=
 =?utf-8?B?b0M2RUZnWkdjYnZqWmxNKzhUU2lhZXpub3hqMHNuQjBZNkM5enhYRDVpdmly?=
 =?utf-8?B?VlVPcE80bkxkVU5qRlBUN1ZWRXIrTVY2cnlPb3NQOSt6UWluM1FyOTFyblQx?=
 =?utf-8?B?cU4zbTFqZ3BFQmRDMVhCTUhXZWtGcXYvc1NoVVg4NkZpcE1wejFYdERQVjFC?=
 =?utf-8?B?c0FQbm9ON0doNXFPUmpKYUhTN0kveVk5anVIS2ozUm00a2tiTm1LSUEzaldk?=
 =?utf-8?B?aHZ5TXNIWGxnV201TVlKbnhWUlZlT3lLbHFoTUs1TWppS0lTeUd2NGJwV1RD?=
 =?utf-8?B?dFBmTGdxLzFSam9DVTVVU000SU9yVDZ6eWNvY1dXbjFtaTNqNkhPdlF0aVFj?=
 =?utf-8?B?SUZKOTB1VHZCZVlJVGlzMy9Ebk9CcWM0em9PZjlTSkgxTm9Hd25CWEMxNkZk?=
 =?utf-8?B?SnlMMTcyenR2a0ZyWTF6TThBeWQxaFBSTE9WeDlNY1VlVDloT0ZYTWNNVzY1?=
 =?utf-8?B?WFJZVmwvMVJMSnN6dElxRmc2Nmlyd245aC9qTzd6Sndua3BQOGFKdUJiTkVh?=
 =?utf-8?B?NGV0d1U0TXFCSmlmQm1nWnFLbDdZS24wSU16VElvZHZMOGxRcU1CWEM4ekRV?=
 =?utf-8?Q?9YpxypT8Qxo5d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7640.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDNDU202OUFCdmozN2NXN1o0SVEzOHBnbVVIOWpzQUdheDRuV3pnRVR2MmRQ?=
 =?utf-8?B?YmNEOGtwajNnQmJOTVpWa1BTa2tFZ1Y5YkZqV3F0OSsySDRhTi81Q3NXaXpn?=
 =?utf-8?B?L0MySXJtZXhXcFpibk5ZczA2d1NXQ0c4Nk1JUjdlVVlNMEJxZ3lFUDJja3RP?=
 =?utf-8?B?ck9OcGVXUnFVSzlYYVBub1ZNVTVTaVYyWWRRRlNZY1VQbFpCbzB0RlpHVTkz?=
 =?utf-8?B?NjYzaW50TVowVHQyeFF4TktoREFDSzczYXRsbzBZYmlvMVBDSjVFRmZoNmZO?=
 =?utf-8?B?VTRMZjRVMzFqWmlxbHkwWlZENmttYkwrOUZMblF6R25QQml5SmZkbU95RE9M?=
 =?utf-8?B?UzdVQ2l1VDZOeDIzengzN1NuRGVzMysvdkxwN0g5NkR4R2hnUFdaamlEaHV4?=
 =?utf-8?B?aGlzL1NZdFVXNzNlL2pOY21RRVN5eTJjc3hQdklBL1d4Z1RkeUFnQmVHcWZr?=
 =?utf-8?B?RlhkSTBWSWVscUJyZnFyU01uc2E4M0IydlRycXQ3cG5GazRSbTRoODVRZnRz?=
 =?utf-8?B?ZWFhOHVNLzdXUWE0b0VGTDVkRzhMa3dRaGZKQk5MVFRGWUl0WWpyT0hjV2Z6?=
 =?utf-8?B?VytyTFI0bGo3RnJVTy9Jc2RtN0ZNTGxMblpnZmNtRW41NmlPTDFFaTNxRUJx?=
 =?utf-8?B?d0w3eldRcDNtL3VCL2o5SzVQY21DaUQ4N1Nyc1duTVYxNU5oVWFOQzM0UFE0?=
 =?utf-8?B?bGZlNmRVSzdpUmdIdGxsU2dRYkc0L2RQelR0RlV4N0trTmJFQWVZbm9nYWla?=
 =?utf-8?B?L0t1ZDRURnpVbUE1bWtEa3dpSDE5UXdPUGUxRmFya2pvcVpiQkh1YzRWUkR3?=
 =?utf-8?B?RVJFd1MrdmdBU0EyZHh4T1lRTUVFNzcwQVM2TEZBOHVKTW4xa2g4MS82Vlhr?=
 =?utf-8?B?bUUrMiswM1FVWDdmdVMvb1NVY1V3dWRXdGJ0dGZTSWhBc1NLMEg3NVVTdWJ2?=
 =?utf-8?B?UEVUL1pZQ2ZXbWNVYWxDUWRyVEZjd1M1MzhlYjBUcEt2bWVOcHd6TmswZXh3?=
 =?utf-8?B?TGc5RzJFL3VwK2RqamE1TWJoc0dLQUo3WG5kdThlazcvbk5CRzdielhsQWlK?=
 =?utf-8?B?T2l1RFBGQ0NPN1VvMGl3WkhCdm9mZ3I4Zmc3Z2RLa3Uwc0RacDJhaGhwU2Nh?=
 =?utf-8?B?bVJVNFlDRzBtVlBrbXRQQnVnSTZ5c3RTalhWWStINkJtTjg4Nk1KRHRrbEcx?=
 =?utf-8?B?VnIxcmR6TU9hWlNqZDBkS2J0VkY0azlRdXBVeG1GbG9rS1lkMUNoRnJQcnVo?=
 =?utf-8?B?V2diSGY1NGpHVS9mcUtWRDNOMng2Q3ArQ0hjZEtVSkJyaEE0b3FBaGRJSUJj?=
 =?utf-8?B?MWVZaitOZUJlVmp5NnBkeXV5Rlg0Z3FMNkVEVzA2YmxSLy84TWo4RWt1eXFV?=
 =?utf-8?B?RkU4MzdjK1RNeERSVlZpcHd0emJlUDArK0trK3N3Z1VvMVRzWWpRZ3ViaXR2?=
 =?utf-8?B?QjdWRzJ5M0g1UGpySzBtY29sSUQvOElldkIzMW1BdGFlQTJUY0ZzUkRYZmZJ?=
 =?utf-8?B?cG9EZVZCMnVDTkNXY2NyMWhzVTRhUFc5Sm56dTNqeGgxNkR4cWF4ODAwaHQ1?=
 =?utf-8?B?YVlhL2xEbTZreWZoRmpKb3BIMkV4d1ZWZk1DTHJJS0pSL3FhbDVUMHJHSzVK?=
 =?utf-8?B?SG1xU2d2VDh2T1BSQVJPWEkwVXQ0LzQ4TjJjbFd4cVhwVzA1VnFlQVZ4bUxh?=
 =?utf-8?B?Z3dKaHhUYzIrSlRZQUNUODhGaTFIL1VwWHFsYW5oQWMweXJVUzFxamIveTZz?=
 =?utf-8?B?aE9QU01vMFRHNTBXUVdaS3BUc0hBMXE3OVlkQlhCdWxDWEsydmNjTUluZUdz?=
 =?utf-8?B?WTNkaG9PRG1QcHNRVHo1Q2ltVkQ0UW13QnZxSnRucHdST3cxbC9HaHV0UzBB?=
 =?utf-8?B?VjlFckkwZnpiMVhNOW9kLzU1OEMveUs3cUpPL3Z5TUxjUmZaUGpZT0E0eEF5?=
 =?utf-8?B?bkdLNlRzcFI5WTFDS1BNTm5LWDlwNVEzeHZzRWVLNkhTamEwOFBXRERlQWZU?=
 =?utf-8?B?KzFoUkg0cXVyRXk2eE9CVnA5QXVzbzc1RVFzTDlLaU44NkRQTFg1emJ4M0tx?=
 =?utf-8?B?SEtac2pTdDNsd2Y4dmRPQlVad0hlbFdvaGtGZmFXcE5JUk1TK1dnYVZ0UUJr?=
 =?utf-8?B?azZ0VUZjWnloRC94QzJkeE0rWWEyL1NCaW9RRFRKbGpycGVDckFYNFVkeUxS?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9491c3-a23b-4612-b45c-08dd666553ab
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7640.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 21:39:13.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PDphz1mjDw1frrcKOo/6CVHN39mGbiMoBISs9zL4Jdf/DnX1ylPioAwyxFMx4vsBUexb9mXN+2xRge+x9UIyNPapmX21dj1VCnuNMqkew8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-GUID: mcyTI3Q8Sv7eSPztuItcMFcCz8nnFt7x
X-Proofpoint-ORIG-GUID: mcyTI3Q8Sv7eSPztuItcMFcCz8nnFt7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 clxscore=1011 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180156

The National Instruments (NI) 16550 is a 16550-like UART with larger
FIFOs and embedded RS-232/RS-485 transceiver control circuitry. This
patch adds a driver that can operate this UART, which is used for
onboard serial ports in several NI embedded controller designs.

Portions of this driver were originally written by Jaeden Amero and
Karthik Manamcheri, with extensive cleanups and refactors since by
Brenda Streiff.

Cc: Gratian Crisan <gratian.crisan@emerson.com>
Co-developed-by: Jason Smith <jason.smith@emerson.com>
Signed-off-by: Jason Smith <jason.smith@emerson.com>
Signed-off-by: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
---
 MAINTAINERS                       |   6 +
 drivers/tty/serial/8250/8250_ni.c | 461 ++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig   |  13 +
 drivers/tty/serial/8250/Makefile  |   1 +
 4 files changed, 481 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_ni.c

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..1573151c3cd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16250,6 +16250,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
 F:	drivers/mtd/nand/
 F:	include/linux/mtd/*nand*.h
 
+NATIONAL INSTRUMENTS SERIAL DRIVER
+M:	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	drivers/tty/serial/8250/8250_ni.c
+
 NATIVE INSTRUMENTS USB SOUND INTERFACE DRIVER
 M:	Daniel Mack <zonque@gmail.com>
 L:	linux-sound@vger.kernel.org
diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
new file mode 100644
index 000000000000..b10a42d2ad63
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NI 16550 UART Driver
+ *
+ * The National Instruments (NI) 16550 is a UART that is compatible with the
+ * TL16C550C and OX16C950B register interfaces, but has additional functions
+ * for RS-485 transceiver control. This driver implements support for the
+ * additional functionality on top of the standard serial8250 core.
+ *
+ * Copyright 2012-2023 National Instruments Corporation
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/clk.h>
+
+#include "8250.h"
+
+/* Extra bits in UART_ACR */
+#define NI16550_ACR_AUTO_DTR_EN			BIT(4)
+
+/* TFS - TX FIFO Size */
+#define NI16550_TFS_OFFSET	0x0C
+/* RFS - RX FIFO Size */
+#define NI16550_RFS_OFFSET	0x0D
+
+/* PMR - Port Mode Register */
+#define NI16550_PMR_OFFSET	0x0E
+/* PMR[1:0] - Port Capabilities */
+#define NI16550_PMR_CAP_MASK		GENMASK(1, 0)
+#define NI16550_PMR_NOT_IMPL		FIELD_PREP(NI16550_PMR_CAP_MASK, 0) /* not implemented */
+#define NI16550_PMR_CAP_RS232		FIELD_PREP(NI16550_PMR_CAP_MASK, 1) /* RS-232 capable */
+#define NI16550_PMR_CAP_RS485		FIELD_PREP(NI16550_PMR_CAP_MASK, 2) /* RS-485 capable */
+#define NI16550_PMR_CAP_DUAL		FIELD_PREP(NI16550_PMR_CAP_MASK, 3) /* dual-port */
+/* PMR[4] - Interface Mode */
+#define NI16550_PMR_MODE_MASK		GENMASK(4, 4)
+#define NI16550_PMR_MODE_RS232		FIELD_PREP(NI16550_PMR_MODE_MASK, 0) /* currently 232 */
+#define NI16550_PMR_MODE_RS485		FIELD_PREP(NI16550_PMR_MODE_MASK, 1) /* currently 485 */
+
+/* PCR - Port Control Register */
+/*
+ * Wire Mode      | Tx enabled?          | Rx enabled?
+ * ---------------|----------------------|--------------------------
+ * PCR_RS422      | Always               | Always
+ * PCR_ECHO_RS485 | When DTR asserted    | Always
+ * PCR_DTR_RS485  | When DTR asserted    | Disabled when TX enabled
+ * PCR_AUTO_RS485 | When data in TX FIFO | Disabled when TX enabled
+ */
+#define NI16550_PCR_OFFSET	0x0F
+#define NI16550_PCR_WIRE_MODE_MASK		GENMASK(1, 0)
+#define NI16550_PCR_RS422			FIELD_PREP(NI16550_PCR_WIRE_MODE_MASK, 0)
+#define NI16550_PCR_ECHO_RS485			FIELD_PREP(NI16550_PCR_WIRE_MODE_MASK, 1)
+#define NI16550_PCR_DTR_RS485			FIELD_PREP(NI16550_PCR_WIRE_MODE_MASK, 2)
+#define NI16550_PCR_AUTO_RS485			FIELD_PREP(NI16550_PCR_WIRE_MODE_MASK, 3)
+#define NI16550_PCR_TXVR_ENABLE_BIT		BIT(3)
+#define NI16550_PCR_RS485_TERMINATION_BIT	BIT(6)
+
+/* flags for ni16550_device_info */
+#define NI_HAS_PMR		BIT(0)
+
+struct ni16550_device_info {
+	u32 uartclk;
+	u8 prescaler;
+	u8 flags;
+};
+
+struct ni16550_data {
+	int line;
+	struct clk *clk;
+};
+
+static int ni16550_enable_transceivers(struct uart_port *port)
+{
+	u8 pcr;
+
+	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
+	pcr |= NI16550_PCR_TXVR_ENABLE_BIT;
+	dev_dbg(port->dev, "enable transceivers: write pcr: 0x%02x\n", pcr);
+	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
+
+	return 0;
+}
+
+static int ni16550_disable_transceivers(struct uart_port *port)
+{
+	u8 pcr;
+
+	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_TXVR_ENABLE_BIT;
+	dev_dbg(port->dev, "disable transceivers: write pcr: 0x%02x\n", pcr);
+	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
+
+	return 0;
+}
+
+static int ni16550_rs485_config(struct uart_port *port,
+				struct ktermios *termios,
+				struct serial_rs485 *rs485)
+{
+	struct uart_8250_port *up = container_of(port, struct uart_8250_port, port);
+	u8 pcr;
+
+	pcr = serial_in(up, NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
+
+	if ((rs485->flags & SER_RS485_MODE_RS422) ||
+	    !(rs485->flags & SER_RS485_ENABLED)) {
+		/* RS-422 */
+		pcr |= NI16550_PCR_RS422;
+		up->acr &= ~NI16550_ACR_AUTO_DTR_EN;
+	} else {
+		/* RS-485 2-wire Auto */
+		pcr |= NI16550_PCR_AUTO_RS485;
+		up->acr |= NI16550_ACR_AUTO_DTR_EN;
+	}
+
+	dev_dbg(port->dev, "config rs485: write pcr: 0x%02x, acr: %02x\n", pcr, up->acr);
+	serial_out(up, NI16550_PCR_OFFSET, pcr);
+	serial_icr_write(up, UART_ACR, up->acr);
+
+	return 0;
+}
+
+static bool is_pmr_rs232_mode(struct uart_8250_port *up)
+{
+	u8 pmr = serial_in(up, NI16550_PMR_OFFSET);
+	u8 pmr_mode = pmr & NI16550_PMR_MODE_MASK;
+	u8 pmr_cap = pmr & NI16550_PMR_CAP_MASK;
+
+	/*
+	 * If the PMR is not implemented, then by default NI UARTs are
+	 * connected to RS-485 transceivers
+	 */
+	if (pmr_cap == NI16550_PMR_NOT_IMPL)
+		return false;
+
+	if (pmr_cap == NI16550_PMR_CAP_DUAL)
+		/*
+		 * If the port is dual-mode capable, then read the mode bit
+		 * to know the current mode
+		 */
+		return pmr_mode == NI16550_PMR_MODE_RS232;
+	/*
+	 * If it is not dual-mode capable, then decide based on the
+	 * capability
+	 */
+	return pmr_cap == NI16550_PMR_CAP_RS232;
+}
+
+static void ni16550_config_prescaler(struct uart_8250_port *up,
+				     u8 prescaler)
+{
+	/*
+	 * Page in the Enhanced Mode Registers
+	 * Sets EFR[4] for Enhanced Mode.
+	 */
+	u8 lcr_value;
+	u8 efr_value;
+
+	lcr_value = serial_in(up, UART_LCR);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	efr_value = serial_in(up, UART_EFR);
+	efr_value |= UART_EFR_ECB;
+
+	serial_out(up, UART_EFR, efr_value);
+
+	/* Page out the Enhanced Mode Registers */
+	serial_out(up, UART_LCR, lcr_value);
+
+	/* Set prescaler to CPR register. */
+	serial_out(up, UART_SCR, UART_CPR);
+	serial_out(up, UART_ICR, prescaler);
+}
+
+static const struct serial_rs485 ni16550_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_MODE_RS422 | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND,
+	/*
+	 * delay_rts_* and RX_DURING_TX are not supported.
+	 *
+	 * RTS_{ON,AFTER}_SEND are supported, but ignored; the transceiver
+	 * is connected in only one way and we don't need userspace to tell
+	 * us, but want to retain compatibility with applications that do.
+	 */
+};
+
+static void ni16550_rs485_setup(struct uart_port *port)
+{
+	port->rs485_config = ni16550_rs485_config;
+	port->rs485_supported = ni16550_rs485_supported;
+	/*
+	 * The hardware comes up by default in 2-wire auto mode and we
+	 * set the flags to represent that
+	 */
+	port->rs485.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
+}
+
+static int ni16550_port_startup(struct uart_port *port)
+{
+	int ret;
+
+	ret = serial8250_do_startup(port);
+	if (ret)
+		return ret;
+
+	return ni16550_enable_transceivers(port);
+}
+
+static void ni16550_port_shutdown(struct uart_port *port)
+{
+	ni16550_disable_transceivers(port);
+
+	serial8250_do_shutdown(port);
+}
+
+static int ni16550_get_regs(struct platform_device *pdev,
+			    struct uart_port *port)
+{
+	struct resource *regs;
+
+	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (regs) {
+		port->iotype = UPIO_PORT;
+		port->iobase = regs->start;
+
+		return 0;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (regs) {
+		port->iotype = UPIO_MEM;
+		port->mapbase = regs->start;
+		port->mapsize = resource_size(regs);
+		port->flags |= UPF_IOREMAP;
+
+		port->membase = devm_ioremap(&pdev->dev, port->mapbase,
+					     port->mapsize);
+		if (!port->membase)
+			return -ENOMEM;
+
+		return 0;
+	}
+
+	dev_err(&pdev->dev, "no registers defined\n");
+	return -EINVAL;
+}
+
+/*
+ * Very old implementations don't have the TFS or RFS registers
+ * defined, so we may read all-0s or all-1s. For such devices,
+ * assume a FIFO size of 128.
+ */
+static u8 ni16550_read_fifo_size(struct uart_8250_port *uart, int reg)
+{
+	u8 value = serial_in(uart, reg);
+
+	if (value == 0x00 || value == 0xFF)
+		return 128;
+
+	return value;
+}
+
+static void ni16550_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	up->mcr |= UART_MCR_CLKSEL;
+	serial8250_do_set_mctrl(port, mctrl);
+}
+
+static int ni16550_probe(struct platform_device *pdev)
+{
+	const struct ni16550_device_info *info;
+	struct device *dev = &pdev->dev;
+	struct uart_8250_port uart = {};
+	unsigned int txfifosz, rxfifosz;
+	unsigned int prescaler = 0;
+	struct ni16550_data *data;
+	const char *portmode;
+	bool rs232_property;
+	int ret;
+	int irq;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&uart.port.lock);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = ni16550_get_regs(pdev, &uart.port);
+	if (ret < 0)
+		return ret;
+
+	/* early setup so that serial_in()/serial_out() work */
+	serial8250_set_defaults(&uart);
+
+	info = device_get_match_data(dev);
+
+	uart.port.dev		= dev;
+	uart.port.irq		= irq;
+	uart.port.irqflags	= IRQF_SHARED;
+	uart.port.flags		= UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
+					| UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	uart.port.startup	= ni16550_port_startup;
+	uart.port.shutdown	= ni16550_port_shutdown;
+
+	/*
+	 * Hardware instantiation of FIFO sizes are held in registers.
+	 */
+	txfifosz = ni16550_read_fifo_size(&uart, NI16550_TFS_OFFSET);
+	rxfifosz = ni16550_read_fifo_size(&uart, NI16550_RFS_OFFSET);
+
+	dev_dbg(dev, "NI 16550 has TX FIFO size %u, RX FIFO size %u\n",
+		txfifosz, rxfifosz);
+
+	uart.port.type		= PORT_16550A;
+	uart.port.fifosize	= txfifosz;
+	uart.tx_loadsz		= txfifosz;
+	uart.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
+	uart.capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
+
+	/*
+	 * Declaration of the base clock frequency can come from one of:
+	 * - static declaration in this driver (for older ACPI IDs)
+	 * - a "clock-frquency" ACPI
+	 */
+	if (info->uartclk)
+		uart.port.uartclk = info->uartclk;
+	if (device_property_read_u32(dev, "clock-frequency",
+				     &uart.port.uartclk)) {
+		data->clk = devm_clk_get_enabled(dev, NULL);
+		if (!IS_ERR(data->clk))
+			uart.port.uartclk = clk_get_rate(data->clk);
+	}
+
+	if (!uart.port.uartclk) {
+		dev_err(dev, "unable to determine clock frequency!\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	if (info->prescaler)
+		prescaler = info->prescaler;
+	device_property_read_u32(dev, "clock-prescaler", &prescaler);
+
+	if (prescaler != 0) {
+		uart.port.set_mctrl = ni16550_set_mctrl;
+		ni16550_config_prescaler(&uart, (u8)prescaler);
+	}
+
+	/*
+	 * The determination of whether or not this is an RS-485 or RS-232 port
+	 * can come from the PMR (if present), otherwise we're solely an RS-485
+	 * port.
+	 *
+	 * This is a device-specific property, and there are old devices in the
+	 * field using "transceiver" as an ACPI property, so we have to check
+	 * for that as well.
+	 */
+	if (!device_property_read_string(dev, "transceiver", &portmode)) {
+		rs232_property = strncmp(portmode, "RS-232", 6) == 0;
+
+		dev_dbg(dev, "port is in %s mode (via device property)\n",
+			rs232_property ? "RS-232" : "RS-485");
+	} else if (info->flags & NI_HAS_PMR) {
+		rs232_property = is_pmr_rs232_mode(&uart);
+
+		dev_dbg(dev, "port is in %s mode (via PMR)\n",
+			rs232_property ? "RS-232" : "RS-485");
+	} else {
+		rs232_property = 0;
+
+		dev_dbg(dev, "port is fixed as RS-485\n");
+	}
+
+	if (!rs232_property) {
+		/*
+		 * Neither the 'transceiver' property nor the PMR indicate
+		 * that this is an RS-232 port, so it must be an RS-485 one.
+		 */
+		ni16550_rs485_setup(&uart.port);
+	}
+
+	ret = serial8250_register_8250_port(&uart);
+	if (ret < 0)
+		goto err;
+	data->line = ret;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+
+err:
+	return ret;
+}
+
+static void ni16550_remove(struct platform_device *pdev)
+{
+	struct ni16550_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+}
+
+#ifdef CONFIG_ACPI
+/* NI 16550 RS-485 Interface */
+static const struct ni16550_device_info nic7750 = {
+	.uartclk = 33333333,
+};
+
+/* NI CVS-145x RS-485 Interface */
+static const struct ni16550_device_info nic7772 = {
+	.uartclk = 1843200,
+	.flags = NI_HAS_PMR,
+};
+
+/* NI cRIO-904x RS-485 Interface */
+static const struct ni16550_device_info nic792b = {
+	/* Sets UART clock rate to 22.222 MHz with 1.125 prescale */
+	.uartclk = 22222222,
+	.prescaler = 0x09,
+};
+
+/* NI sbRIO 96x8 RS-232/485 Interfaces */
+static const struct ni16550_device_info nic7a69 = {
+	/* Set UART clock rate to 29.629 MHz with 1.125 prescale */
+	.uartclk = 29629629,
+	.prescaler = 0x09,
+};
+static const struct acpi_device_id ni16550_acpi_match[] = {
+	{ "NIC7750",	(kernel_ulong_t)&nic7750 },
+	{ "NIC7772",	(kernel_ulong_t)&nic7772 },
+	{ "NIC792B",	(kernel_ulong_t)&nic792b },
+	{ "NIC7A69",	(kernel_ulong_t)&nic7a69 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ni16550_acpi_match);
+#endif
+
+static struct platform_driver ni16550_driver = {
+	.driver = {
+		.name = "ni16550",
+		.acpi_match_table = ACPI_PTR(ni16550_acpi_match),
+	},
+	.probe = ni16550_probe,
+	.remove = ni16550_remove,
+};
+
+module_platform_driver(ni16550_driver);
+
+MODULE_AUTHOR("Emerson Electric Co.");
+MODULE_DESCRIPTION("NI 16550 Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 55d26d16df9b..bd3d636ff962 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -569,6 +569,19 @@ config SERIAL_8250_BCM7271
 	  including DMA support and high accuracy BAUD rates, say
 	  Y to this option. If unsure, say N.
 
+config SERIAL_8250_NI
+	tristate "NI 16550 based serial port"
+	depends on SERIAL_8250
+	depends on (X86 && ACPI) || COMPILE_TEST
+	help
+	  This driver supports the integrated serial ports on National
+	  Instruments (NI) controller hardware. This is required for all NI
+	  controller models with onboard RS-485 or dual-mode RS-485/RS-232
+	  ports.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 8250_ni.
+
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 1516de629b61..b04eeda03b23 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
 obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
+obj-$(CONFIG_SERIAL_8250_NI)		+= 8250_ni.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 obj-$(CONFIG_SERIAL_8250_OMAP)		+= 8250_omap.o
 obj-$(CONFIG_SERIAL_8250_PARISC)	+= 8250_parisc.o
-- 
2.43.0

