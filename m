Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE061C84D0;
	Mon, 24 Mar 2025 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.142.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854232; cv=fail; b=FS2WGMBuDqjBpeqOr4JnNTyHh8AbmhseqtDXU7Gl7K60JV/iFarHF44v04WVxYyC+SB1PmZU/uubDZUZTpTP1vHhRVyMj6bYIBk0ezpJANiktktj/bjD2JfxYOBwDiZGzDUnQLa+LQEtFkQQgoJ55+M9mDRW3hiu2LfoK3iR1dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854232; c=relaxed/simple;
	bh=eCQm6cJLXypezbG8kueoxwLZjuYrkCmnLSNdNLHKtlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rgOvm1Kt69EQOg2VNLwQRsvaykmIhbHo1Yz3cUVmz2twstykGXxDTa56IL935mIrm0bLOv/aQzbQyTM+1/GtWc2r3CnrivtDpPzpLkLqCUtx0ROyoHFGLFRjux2ujqe+i96HaDvmeFTSesWzoTJSJ6y1c8u1rCURFPrMJjmNzLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=emerson.com; spf=none smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=MVfdpSj7; dkim=pass (2048-bit key) header.d=Emerson.com header.i=@Emerson.com header.b=1QxOcuIy; arc=fail smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=emerson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="MVfdpSj7";
	dkim=pass (2048-bit key) header.d=Emerson.com header.i=@Emerson.com header.b="1QxOcuIy"
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OM3TxM020475;
	Mon, 24 Mar 2025 22:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=email; bh=foaT
	qHUEDAUyzCePk44dGG1Rt6djOxLBHUP2LJW+Q7s=; b=MVfdpSj7Sk17VeyyVtjN
	n//VUxeQU+a+zpq9D2FdFcV8fKA1RICIidv54xv4qqoSMJULNpAghJ1CRds0yWea
	ACebEXwNXJXxZFbu47iO2gADW98XWjplI2UbRoyDBZ3EJErP6zvuDNNITmsMjAQU
	N3poJTHRLe2C6xVwrDZvPVp/LNzOj7FxuNj1HrdaU5JD5R7r0lWl8MROl6szQiXw
	oiYEvecwfobQI+DiDqwy5m/sRGyhGiIBOipDBVf6QyJsZqGpyQ+v7PQuRS7KDCDA
	Z4StSMT7ZDnjVEFzc2kv3OarRBhX+uN9iOVSuuf/cUIAsRfYex4T+PnqiZXK3jUT
	8g==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 45kf2prqc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 22:10:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiN6pGTaxXgktCbKk73oTu6LZlHSGjoIsmrjknJSawaacKHRiRVFe2f2Kl3PJOMYardwfRK2b2Rc/D5q/5NWzwtTkCPy9JjM2yJVOwbTOOHKnaZfsWzdzDAkuJg5aJcGKPlrdznpg0ofj9+GwpJ5mgwM3CsBCokeNXXl+4cTbGkEpLnm0dy2kn1z2joLY3mQtkc4kFLozW0yX5k6DkLeM1UBysj8WCLD0RJNkLKX9nr4e+Bqst7hfTGtiDg6ABRzaRIX6uePjd7qbDXziKWTbjtwZPpeWLTDNzTBm+LmgnjT0jwZSVPBGCYVWLNLc9kNWMDIjhg79GvB5aZL88c9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foaTqHUEDAUyzCePk44dGG1Rt6djOxLBHUP2LJW+Q7s=;
 b=VgECtf/u8Ss2iG+o7LSAWm2kBap1JEeIrCe4QZozdJDe2Kh1IkjVXPDOrnhQ8zMmuTlesMUDOk15ZQaXSEGZAeUr28mRaZPeWuKOW5cRwJBuEKjUb8obuvqf6uDlDHzJfxZhu6r9jofobx35TbaFUVu0XuirOXD3M0T/Sq8lVyAczK/W+Jdt/eqOAdd5xkkFmRQkx9ZpU9mhHrVZ4pY778REG8WHbgwoJumXEmXc+t3GXi67l9A9X85T0MLemQk3dN+V6bEWa2E4W6a2rXK6OAab9PoBvcG+fhxK8oxtvi82I5/6UgRef3UII0VZHOyxHsqRJnFptY3Kg8lUAqoHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Emerson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foaTqHUEDAUyzCePk44dGG1Rt6djOxLBHUP2LJW+Q7s=;
 b=1QxOcuIyFK9cBUmpC4vR4mV2bPsvmb85c+DFC+t4b/OpcuVEzU2nE7ohJVBxI/fDeExpMpCs9gJHigXBO1RD1id6w2Ecc4kV1yFoOP/wQ4wH09phh0KroOyT2fk8Sr9xACyuTUamI5GN2ksrsXG1v52TVb1YDkHln1usfLtfTKaHVArvYU+7WbHVPqVR8UlnSh/V4giytniDcziPA6ENQSkdrHQ7jX+slR5RD3cs7t/+wiil1Yr9hJ6SnHwbt9oPG4n4YVmmt15C/SRKW7BctgCOv2sDRuFuUvNvcEnwwVkGDIjjKgnLNOme2CW9K4wnRoxIzhT138y+Tr50qpApQg==
Received: from MW6PR10MB7640.namprd10.prod.outlook.com (2603:10b6:303:245::13)
 by PH7PR10MB7839.namprd10.prod.outlook.com (2603:10b6:510:2ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 22:10:14 +0000
Received: from MW6PR10MB7640.namprd10.prod.outlook.com
 ([fe80::ba9c:1796:379f:af54]) by MW6PR10MB7640.namprd10.prod.outlook.com
 ([fe80::ba9c:1796:379f:af54%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 22:10:14 +0000
Message-ID: <98ba5ff3-43fe-4178-ba2f-9eff12a47edb@emerson.com>
Date: Mon, 24 Mar 2025 17:10:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] serial: 8250_ni: Clean up the driver
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, jason.smith@emerson.com,
        gratian.crisan@emerson.com
References: <20250321182119.454507-1-andriy.shevchenko@linux.intel.com>
From: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
In-Reply-To: <20250321182119.454507-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:20::21) To MW6PR10MB7640.namprd10.prod.outlook.com
 (2603:10b6:303:245::13)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7640:EE_|PH7PR10MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 69217d8b-3ef3-44c6-9902-08dd6b20a729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjhkUittZU51MmpCMVJCRUcxQno0cnNUczVWQ0tEZDU2WWEraVRuWTlTbVlQ?=
 =?utf-8?B?d3ZPa01qbXVDYUxjMWoyblZZN0RUZFFFWGxFNkhnaFNLcnJpNmVrNUZRaUR6?=
 =?utf-8?B?M2JLOFpTbnRtbDJRMWlxUnhoN1k1RzZIZnZTV1NCZ1pZa0Q4UmkzRXc0RENQ?=
 =?utf-8?B?QWxIYVJOT2ZRQjQrUWtWWE1pdzZKa3k0Q01iOHpiK2FMQmpYTjIxZ2t0TWlD?=
 =?utf-8?B?b0dNQ1gyOXNRUmIzZnBwYytHbjE3cFFDOWFDbGN0Ni9sempBV1pieDRSUDZM?=
 =?utf-8?B?ZVhEZkhoMTVJdXk0c2VLM0R6YUVqanU3L3dKT2hxRHF0OGl2b3JORGZicjJw?=
 =?utf-8?B?b2Y0U1cyMi9HUWZlM3FsdUtHOVlpOXJ0ZE04Um1maGFEc3NEKzZvOXNZQ3pX?=
 =?utf-8?B?NzQwZzJMTk4rZDVBL2J1REFjdVQxVXI1b3hjRHk2aTN1S25uUmQxOVNEa1Aw?=
 =?utf-8?B?a3d2NWx6L3FDcEFmWXdMYmxTTnpEZFNoNHFvYXZNYWVDWmNWSitVaHkvWDB2?=
 =?utf-8?B?K3BaZzlLNHdURUhDSkhVdEJubVBhdUdoaDdjUkhRbHQ5aWtRRGIzY094U3NV?=
 =?utf-8?B?TlNDcitXSjIzUm5EcHFpVGU2MjM0RVorNzBadGIxVXNDTGtpMFF1aWhTdXBM?=
 =?utf-8?B?N2VvczJoVVZwSFg4cFloUTgxL01jZVVjN3ZsakJlTVdsQ1NNUnExbXpIWEhF?=
 =?utf-8?B?NHRpSHZnZVBTRVdFdHkyZXdTQ2pQZDl1NTg0RUtXelB1Y2dtbkhxdzc5eFoz?=
 =?utf-8?B?ZnJSZGtiVWhaQ2x3R2VadlFsVmMzTUlPZnE2MUtycml3eC9LSDVicDJ4Rzh0?=
 =?utf-8?B?dGhvbnZCSW85cUNZczBlZWEvRzBiQ1EzcjU4L3ZwTmZ1ZHYwQ0RxOG9KWWps?=
 =?utf-8?B?QTk0bWdWRmVhejc0UmZyM3o1MnZjVFZRbllkdERaTDkzQUIvSlpGeXZsMmdk?=
 =?utf-8?B?UEVyeDdIaXFvdWpnS3F6WUlBeGovZUpkVlJsNFJiVFZhZ3N2aGdEVThmSlNI?=
 =?utf-8?B?WVl1RHNCa2hZVWFUTkNYd29NTm1adVNIWUh5OGd1UkYzcjkrOWxyUlZBMGxt?=
 =?utf-8?B?OC9BQmdXbEQ5bDdCNWFtSlhabnhLR2lzYTlBZHhiS0VBMUF1YTdKRlBpb2RD?=
 =?utf-8?B?b1k1WUtYWHAwZGdNeTlpekhrQ1hZSkJWdWlIN1drcWF3R1hoUGRBQWNqRTg2?=
 =?utf-8?B?akhRMnN2NG0yUzFrN1V5RExOTEtWZUhXcGZlR3ExUVQ5QjVybXVVKzdJZkk4?=
 =?utf-8?B?WmkyMkVZYURqS2t1RHdBQnVoL3gwNzYxYTFHNzZLKzhCL1BnYkw4TE5ac2Va?=
 =?utf-8?B?Q2NLTmw2cXM1VU9TMmcxdkxSZVhydWI1TDZJTDZEUG9US3kzUFBKQmNDY2JU?=
 =?utf-8?B?YTZVai9oRER6WUdFM3R6Vk9Gb3hIR2JnMER4bXFRRWZvV1NTWU91RkZ1dXd5?=
 =?utf-8?B?YnJYZnVRS0J3dFkxK21GckJPa0s3UFVVSGN5YmVrNlFoUWRjSWZRV1RpSlky?=
 =?utf-8?B?MEpMYnF3Vk8wL2xkeGxqUDRBZ2NkUlZ5UFFKaW44STlwSFJKNzgzS1RSeWNw?=
 =?utf-8?B?K1JFeUxxYWJzc0xSazlPQzdrTE12aFhteEJLNGRrV0ZvTVQ5SHdERERRRzYv?=
 =?utf-8?B?SXgwUDZQUVlId1dkSlp4VnNqNDE4TWFwSHprcTBPTXBKY0JsVnZqcWVITUwy?=
 =?utf-8?B?aU1TaVJFb05Rd2FGVlZlZFlSajVPbE9GRy93UW90NE82NXYwRW40aGp6bUVZ?=
 =?utf-8?B?ekh1bjA2Vy9lZDVVemZ1Sk5KR2F0bGZMSUlGM0NwSVpqUkRnaGtzS2s0enJn?=
 =?utf-8?B?NUtDSlRQQ2o0M1dhRTQzUTNFTjFqdDBmbHVyZE1Gc0RlWnJucXhUWjlTT09z?=
 =?utf-8?Q?E+O2BSXApysKv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7640.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3poN004bUpnSkw0TmkrUE9meEJhdW1FTml4cTlZSEdwb0YxVkxFR1NZYTBP?=
 =?utf-8?B?dmYwN0pxcjMwamx2QklSUnJlUzYvemU1a3ova21rUDJqTFBrTU1kQVdoZVhO?=
 =?utf-8?B?ZnhYdDI4MGwzeXZBa0tSTDVwbDhxNlJoM09WUFNwVVorc1lYVEhWRUFzZk5Z?=
 =?utf-8?B?b1A4U3NKcVNicHVQR1dheVFMblhjVS9XK0NUV25JTEJRb0VwZmM4alFWZ1VF?=
 =?utf-8?B?YUtRdlhaemVWSkd1T29Na2RremZBSGFtT1VHeDJEckpQVTFMY2J3OWNxOEpp?=
 =?utf-8?B?NDJzNzE5OXV3WVgrMmRNNFBmQ2ErQ2lLc1Fmc2xrdDRZeGExQjl2T0Q2aE5n?=
 =?utf-8?B?azE1OGRJbnVROE1MOXpCbVFIUHFlR1VZUzVONnVWaXdMclk1b3VYTjdDRmh3?=
 =?utf-8?B?cGVOVVR4R01PODNOaXVXTStSUUREdmtrMno2OE1nWCtub0ZzUVgvVTNaZjY4?=
 =?utf-8?B?K2RyTnNURGpwcDY5RGR6Z2ZUVmxFRCtOY2tBRTdaTk5wd2lOdUxsQzlKQmF3?=
 =?utf-8?B?T0xwTXk4Rm55Vi9Ob0IrZExlOXFqSGZUZ25PQ01NTk16TFlXNmlrMDZIUWYx?=
 =?utf-8?B?Y1AvZUVBRUp6aEJyT2p3bFFXa1RZa0Vodys0QTZ2bzB3S0dCTmxJOGl4am5s?=
 =?utf-8?B?M2xONjRaclhtN1FUTFU3a29FTWd0SmlOOGlKMmlEQVdhcHlxamo5ZnVvOTIy?=
 =?utf-8?B?cWlkUkMrN21vTXVFbGowQmdjNFY4L01CR0loVkJNMzhpQVlJZXVPSjFzcVVp?=
 =?utf-8?B?NXlaTjZRNWdBZUUzOTZQZExLaW1wOXFTMHNsdyswUCt6ZTNHcnJEbjloeXdC?=
 =?utf-8?B?VkJ1Vjd2TE53TjVnWFI3Mzh6SUpGSUVRQ05xeHZUSUhQSFhXR1RIMmQrRGJR?=
 =?utf-8?B?Q3F1dnY5c1hJdFAvQXE2QWpqT25lZnJpcHZ0aHJReHhWRkJQQTNyRkNyNTFW?=
 =?utf-8?B?S3FRYTg0VldvWHRSaDNwWUVJQ2xpYlJjNEd0RngrMmlvREo3QmRMaFZ4STlv?=
 =?utf-8?B?clc5eWYycldXZWRSUHRTMWkyc05PRWlpVnRSRytDQlNHaE56M3FvOC96RDJn?=
 =?utf-8?B?K2pYZklvSXdYQ2p6UWhxNHFkT2x1N1pKR0hMMC9leFRlTmtxQVRNc1lYYkps?=
 =?utf-8?B?UUk4WFdDcXh3WE9pUFRSdEZCZmYwN29IcHpXelBJTGdJc1cyOHQ2aks5OGtY?=
 =?utf-8?B?OVRnc1dsQi9IVkV6SmxZL0ZiNWxHaXVCN1VITE5tV2RaUHNjcFpiSXJMNG1a?=
 =?utf-8?B?RGpuUTdQc0dzcGxNUE0rRFBieWtyM3dyS2lic041eXBJY1hodjRUMlR4YUR6?=
 =?utf-8?B?SkhvMWlLSm5Mc3B6c1hjaXBKKzdFczN6U01aaUgrMU1lK0M4MUNocjI0dVFm?=
 =?utf-8?B?dUJuai9tU1BZSnM2MFQyTFF5YU5QcXc5Q3hreHpJbFo3QUcxTVBvSzZqRktj?=
 =?utf-8?B?QWpEUFp3d2MwRy9LVkw4UXkyM3pKZVNFZ2pySjZWK2xUVU1wNUxIZ3hCRS94?=
 =?utf-8?B?ejE3a21xN0JOcWF1aWNLNEhwZE5vczZLSXVwajVsdFF2Yk1XOHBLNGR0ZkJp?=
 =?utf-8?B?QUhGZnp1OEYzZ2xEa0lBVXN2bG4xNDczMy9uYlpjcHFNdlpNMXRYdXo4d1Fs?=
 =?utf-8?B?TnYzNys3M0ZQb3ZtRTh2R0xzeW5xdVZrUFppRk55SDBwb2NPTFNsenUvdHNG?=
 =?utf-8?B?Qy9EVTlXNC9LS2xYRUx4US8ybDUwaG92REZlREhmbm5pZWprcUwxMUVhNTlR?=
 =?utf-8?B?RmJpeTN4MDhzSVZHZ05wSXp3c0J6NjRZSkFlN3JwUFBWZitEejVoQ0pVQU1J?=
 =?utf-8?B?SWQzWmxXbHdnRkVOalVjVWo5blNFZFpPcTQyZGcvRzBVdElZWEM2RzBpQ1NO?=
 =?utf-8?B?NlJUcUJweGRXWTFVU0xTVTBCVUhxTHFEcTRYRGNqcGJQR0RCZjNzbVdrUEYz?=
 =?utf-8?B?TFBXMHRLc3Vlb0lIQSszTmtRajlJM2hvbzJBUjE0NDBwTmNVVGhyNUd0Y0ZK?=
 =?utf-8?B?eFZ2T1A5aUE3SnExM3VWRHFvV3hvWFVQc2dERlgvUE9HdFl0ejEwQkt6d1hJ?=
 =?utf-8?B?M0tISWVaeTZGanpJakRKcHdrb3laaU5pMDlEdTlIUStnQ3pZdGxkaHdLUGQv?=
 =?utf-8?B?UE1vaEUyS0xXOW1lcXFsUVh3b3JZSzZuUG9zV0xsOFVISnczNnJqblNnN3VG?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69217d8b-3ef3-44c6-9902-08dd6b20a729
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7640.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 22:10:14.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0uknlYrLbV8UHBRP+W7F6W4iw71rb3aSQS//+2MXJ/EJ7fvyv62l3+7gAr6bizwJAM171DrDitYgc/BNYKUawW9rgy2cgd+mSZfFCuIoPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7839
X-Proofpoint-ORIG-GUID: nqJcDLtwFmbb3KnfD1KGKeqgBrI-Mov6
X-Proofpoint-GUID: nqJcDLtwFmbb3KnfD1KGKeqgBrI-Mov6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240155

> The newly introduced driver inherited almost all same issues
> that 8250_platform had and others. Clean up the driver accordingly.
> 
> Andy Shevchenko (7):
>   serial: 8250_ni: Switch to use uart_read_port_properties()
>   serial: 8250_ni: Remove duplicate mapping
>   serial: 8250_ni: Switch to use platform_get_mem_or_io()
>   serial: 8250_ni: Remove unneeded conditionals
>   serial: 8250_ni: use serial_port_in()/serial_port_out() helpers
>   serial: 8250_ni: Switch to use dev_err_probe()
>   serial: 8250_ni: Tidy up ACPI ID table
> 
>  drivers/tty/serial/8250/8250_ni.c | 89 +++++++++++++------------------
>  drivers/tty/serial/8250/Kconfig   |  2 +-
>  2 files changed, 38 insertions(+), 53 deletions(-)

Thanks for the patches! They look good and tested fine.

For the series,

Tested-by: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
Reviewed-by: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>

Thanks,
Chaitanya

