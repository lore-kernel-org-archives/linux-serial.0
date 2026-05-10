Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE837E2EF
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420485; cv=fail; b=mp9rqvNH6BWAgZRA+MxokNXNEYsFKMnQU6RoO8QJfH7pBkX1wmGihh32HK545sYLHxnrVJ/6VY6CXbrJ8rHxH6tJWzOejm2N2gpDTCGiuGkZCGYljjAZIwGtfjTJRkL0i1W4/y56cQKAjQsc6LlugdabcCmWxBkih84hFv59kIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420485; c=relaxed/simple;
	bh=N/iyf1vH5X0fRavhY4gBYuv0StQX3iwRW4SaqHzVEK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ukk/d8ozbRXbL4hmbKqwjHYJzWBU3Qib5w9pkk0VU3B3+k6H8eF7ycZyNT7balBs1FCfzWgNw63+HX/P1TvpomUinJWs/cRLUdK5Vp7Mq2M6n0QHJPY8O+5bfGrz6yZSSK4gD8GUR6WLFVcp2jIH3SDuRypg2eJTAfoyB3sfFzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=gsfs8xEK; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gsfs8xEK"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ADU2GI3124076;
	Sun, 10 May 2026 06:41:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=V/bchEs143eiZ6PEX7kmcWqMdSxNc+rvbZBOi//qriE=; b=
	gsfs8xEKnawtjR+/JJgDgzTQ6JwtMt1u/DqLzylhXfJeBjSI25P4qC+0sN9+hN8J
	TO65rWxiDKWndF7zt1SPGip6yFGYqs0QcU8ZQSFIAA5tF+0imzM2yPTP9DBssHnZ
	0Tax6pXa1gG7LGweUzzi/A/2T9odA6H1AlC2E9o9rebTfaNSQYzlp42cei4pXmKz
	pZWmHokDBDU5RemK2f7PINBY+W7Xm7oP8lImPo+HEDQVcZgpgFd47Kh2qMydfCpJ
	2vdFyteFcMw+95MWaR8rqbEPVgyRfY/qbqleBypmK2S7j2NsYXGPupPMqyrkkL6d
	/oVH5IewEaYDy4NbJACF7Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e206xrvth-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 06:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6YOiDGJGOygTpvtuCkSinbDEX3E+NO7xBOvvEhHryk99NwOiKHPrLPz8A1TYkyPSV5f4IdyPH4nU3IrnvuTRVgp/FtzTo6lZS2htHuGEc8GHMhmKNF6G+2uwI689emwjbXLfPp6rrja37g1OwNM36Hgyx9aozZRRiwoK/rHlr6sov2OKrwcfBZeqI88FORlTUDrGMsYJLpGP5C+8OBMdbkppoeUXEHntxCWHk3iypTevvdVjCzQWbuCGOTX2+ZrEPfyTp2oam4o0AcQlfPv6nzMU/so4aG1NRpjMf6wnVdqr3i/7WIJuFT6+jyg+VDw9P/cOrrBg8kxQQFUFxDcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/bchEs143eiZ6PEX7kmcWqMdSxNc+rvbZBOi//qriE=;
 b=H+FS9uNH4SJfIExhUT018kTlMDRnY44lJrNik8Cf42uM3JyDK+/rm4tY6oxmqrsIt+wNT9k1MmKiPpxaGg03RpW3Asmqr4xUwuBAphtKA7djey5Q6ZVy6mbu6lqcMpy1F1Byv4/AAKSNb3YBky6tlZ2yILsp1yg4wj3d4JNCFzuBdQfU6AdWv7KfPQyOP6Qkoqt2FwklXBbweBy10smx+Dd6eHkBVvhAVl/HKg9yfsx90q9G4Yuh+ZDqg6N7bYEysisq3s3cRW0IkBlOv2IANhTPzPzbFZY2xHLqYqOj/NrjKB4rqZklOVrC7F8UoEbJaMmounoSqN2UEws1ulBZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA1PR11MB8349.namprd11.prod.outlook.com (2603:10b6:806:383::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Sun, 10 May
 2026 13:41:08 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 13:41:08 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>, stable <stable@kernel.org>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 6.12.y 5/8] serial: 8250: Add serial8250_handle_irq_locked()
Date: Sun, 10 May 2026 16:40:08 +0300
Message-ID: <20260510134011.618215-6-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510134011.618215-1-ionut.nechita@windriver.com>
References: <20260510134011.618215-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA1PR11MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf9d731-1b98-4437-074e-08deae99ca2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|52116014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C3ZelOj1zsGHQu9J6ZycCU+43xJcLuW3W+KtA6LHT5Nc1GiwAKbhWeDYa6gFHjeL35IDcI9kuuNx0LkxW2c6h6YlK8do7t0Cjj2pp0ejRGnVOck/Z5RNQtZiVrtCZxsq8V1eoHwlVIp8/UgBnbpR+0TvnllbzfGy9isZ81q/96E2Ap2qFe8CS/83tBDiXQMWtbmx+Zl1QHHJpuU+YIeXV71WqY0vbbINNLoaf6mp4YDqhI+SfPcFvCw83oHxkIIBfoINeP6nn0GXYfZ/+70+9yYxmUR/4CRAwzUR4p0EovVzEhao/CXeWPtsl/JqRSfMuSidX2ADnPG4gG1nmmH+IB1VQPpZ2Pli+bkm1XWwC9L+0RFYoij1QxmJYsQWxY2nVBNDjf7FsbiIhPhzTOm3/jCQHqwbRGfFmKw0PIRSoye1euM053p85k+V3UF2FA3+LphFaFhSIYKXVOLfhDceL41qPsDFZPhX/OQGy5OLxKahPkEjLu3qlafNsRpE8XGykYwzK0QYvclq2neTYRNw+0DbDHXLtMByDcgb+2N1UoY1T3zz4lYRZEwvbtVhPBj530bl5Pptlf86IPZr1/ATKz0J6Nl+DdezsxP9Jqq5KONNfZkm61g65x3Y3PVX5uQbcxG8eV/Wq/F2nQTIQanPZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(52116014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3U2cUkxVWY2Z2d5cnBFL2hOUzBRMURoVnNqbEtEbXZCamU1RFdHL1ArR2pF?=
 =?utf-8?B?a2ltSlZlZXlEaTViOU94NUtuUVZ6VDVmempLOFFVUk5UNHR0UnI1VURFSjdx?=
 =?utf-8?B?VzUrMkN3S0VDRnQ2S2JyWjByV01raTc0OGNxSG4vTEdYbkRFSWxHOTk3anFJ?=
 =?utf-8?B?M3Z5dEcvSFJnSnVmbDdydmxUNmptbWJvS3lQQVBOK2R6ckI4eCtpUU11eVhv?=
 =?utf-8?B?NnhTRlhrTkQ5cm9sVmtGa0FlbEZPRGhFWmVmd0I0WnpoVXk0WmhBNk5TdkJu?=
 =?utf-8?B?MTZ1cFRHNEJBMWhONFlaSUoxZys2QjYvRGpVUEp0bi80L3pqc1RWcUdrbkw4?=
 =?utf-8?B?TnJIWGZIWnBrUXZybERlNGxsczYrQnhiQ1FkS0dsNUpkbkRsb1VhTEMvUnAy?=
 =?utf-8?B?NE80VmhxejBFY0dHZkdyOExLa25kenkyY04xRlNjU1lFU1pENUxOSUNhbHJP?=
 =?utf-8?B?NnlpQ2hTVWR2QThFNGdQd2o2cnNNdEs1RHNMSG02Ujc5Tnk4SlBNRDUxRUYr?=
 =?utf-8?B?WUlwRXltYy8rY0hhU2RmNnRYV1haOWYybFVxNlpWUWgyMnBPenN6M3VpNkdC?=
 =?utf-8?B?bjZ4OWxJTnlUaEtqS1l5UnB2S3NXei9meEx5UEVoeFFuZndjNmJWNERKTTFN?=
 =?utf-8?B?K2pvY1JqOFNzclQyU0Vqcnh2MjhnTm1kbGo4NDVTV0hQdGM3NmJLOHpYTDFh?=
 =?utf-8?B?UzI3OHZiM2VZTlM0YStrNHlxblREbkFKaUJjTU9VS0V4azdqUm9NRmFGeUI5?=
 =?utf-8?B?a0oyMEpLVWdNcnhiWksxWHF5eGxpMWwwOVlsNW9ZaWZpbzg2MFRrMys5eEpq?=
 =?utf-8?B?cVh4Sll1ck1hbjcxbE9SNlExZ0FGYVVFZVpXK0prUm10WDRSQUJkNEIyVXBi?=
 =?utf-8?B?akNmajlMSWpoSDhZUTEyTWlEekY3RTJBOGppOFNFMjRYeVJsNDErcit6KzV4?=
 =?utf-8?B?Nm5PanlkbG1STmxidWkrRjlrV2dBMXZueWx2bzVBd1RSSVNMUTM1Y1IwZGRl?=
 =?utf-8?B?d0VNeE5YbFVPTG04OXNsUkhPbWs1WGZQczJhWjAvQWJxV1ZZRmF3a3U1OUxl?=
 =?utf-8?B?eHNBMWpmTnJFSk5VeVJZNGNwTk9ZOXJPZGNkRkVBU0lXTDg5ZlVRNXdQbWpv?=
 =?utf-8?B?L1NDcE82VmcvWE51M2pPOHo0MzRPQXRjeHhWZmtBMElNQURKb1hjc01XbUZR?=
 =?utf-8?B?Z3kzS0I4dlpsTnR2YjNQWDB0b3IyT1BhL05KUFRBY09qaHVVM2wyd0VGd3U1?=
 =?utf-8?B?NGkyK3UzZWZwYll6NGRXSEd3MlRvUlk5UDJKQWgwdGhJc1J1SHBteEdBZGFS?=
 =?utf-8?B?U1pCRVZ3ZWpIdklPcEVlOUVlcWNheGthMlgvdllidjdkTkZ4L0FTNDdIdnkv?=
 =?utf-8?B?aFVHZXZkM0NxNjdUWFR1RG1mL29kSjVnRXg0ekloa042RXJOR05mZFFKZk85?=
 =?utf-8?B?Z3VDY2hCeDYrMEw4SWdIdlRCZDBvZlBZZmkxd0o5bHlJbmxuMUZtbFdrL2pZ?=
 =?utf-8?B?a3ZnbWp6bXNubnNmb2Z2b3oyUzZTTlc3cm1odERha3lwZjR0OXEzaWZlV1Y3?=
 =?utf-8?B?aDdqRDEwVzJuYWtkMWpUaFdRbWRPSUdhbllDb2JhMW9IU1VJNTZLMXN1WHdS?=
 =?utf-8?B?b3VtWG1ZZkUzRUNUUStMTTBHYzgwMHFmR3phdDU1SW1hOVVvVy9hdVVkSVo5?=
 =?utf-8?B?MDNYNHE1bmNZeU9hVG5EUDB3elRZWWJqZ1hqL1BBUFBrNzhiNDlLci95b3Va?=
 =?utf-8?B?V09vSktXRjU2S2poc2dSUktzSXk0Zlh5Tjk2TGtjOEVraElXWC9yNWVDZm9K?=
 =?utf-8?B?SElKRmdBYTMrZXlpbzY0WVovLy9xUmFZV003TnpQRW9oSW16Yi80Y041SjNM?=
 =?utf-8?B?eEpsMW1lSUNTNnVDTWY4L3pPb2pJdW03MWZ0R3kyeXltL0JXdTA4NThnODZn?=
 =?utf-8?B?K3FCQndjZGtnaUhmdkZaQ0VhZHJyYW02ZW13NFJoTjRKOHl1REplbk9sZllZ?=
 =?utf-8?B?SlB5VzBzdUZpTWJoandzLzdTT1M1WWZkSjFlRmpqa2Rqa3FOc2RkVFlTQjc0?=
 =?utf-8?B?VXEvUWhaWCtLZnhPWmFnUkptS1IxaGxxcUs0eFNnaXlWQnA5clFrdkx3S2JB?=
 =?utf-8?B?WExld0dqRkJUVkdLMWZ1d2s4YndWVDIweGo2OG9qeHZISi9ZL1JSRFd6RmpH?=
 =?utf-8?B?RjVtbGdCcUZpYkxGSHR0d1QzMFNza2NlMkVjSzA0cjN0VGtJTXBMOC8yRTBv?=
 =?utf-8?B?MWo4dGk2QjlneVlMN1J5SzlnZmtvWGVnRHFZRXVTNm5hOURkSTFjWWh5MVE3?=
 =?utf-8?B?Y1RjU1NyUTUvVjY3R0RuWmdBL3ZtVFBPYlNSeVdoaHNiVFI3a25XVTZGeTRl?=
 =?utf-8?Q?gSUCPLUQnQ69bqwuXVoJKC+0v1ye+5XmxLkKWJJ55GYng?=
X-MS-Exchange-AntiSpam-MessageData-1: 8PNbQKoIzFfXKNHq8AuOJ1WVyc0Ecff8Mps=
X-Exchange-RoutingPolicyChecked:
	Z5zglIi5BTvB1Q5sdNLTv7d8G9PQMYhvFylUAzJxmorI4bLF1/JNHlcv7bXybNimQIDCJ5qYPI9Nj038HYTEfraJnLOblNCVCjt0dyPCnZqqiIhDZaKJ/jRmmnuo68/BSMRnoRjMbRXTtNpPLQhAT1RwDcHpJv4AcM+bqfV+xrk7RGakJCtLUs+i+1vfNtErqq2T43eogrTO0LLCCBbusDql42F1UQleQQ8WdFOpgMSFK3QlK1lswkVAEgzv6DQefDNOlfMj7WLjLwUdEidjpFXEZay5N1Hwc7d85p0IoWn6jCYuVXATkYTMNlQmmELd1E5aWbHaTFixye/PAfCf0A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf9d731-1b98-4437-074e-08deae99ca2f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 13:41:08.0371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0tFyeDqaN8Ty+bogHc87aM7/Ir//5VlzAwMN4ek5VSTArNtezQwUJNaM7WjEJTtRwBxNMKK89a7YpWGXG7y2pnCY3pFc3BjbAOdvhYmiEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8349
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEwMDE0NSBTYWx0ZWRfXzsRT8jL7clS+
 qapYwpBgry7md0BMwtufwX+PzZwQKyy/ChlxGNOpwcSVXY52yQgKDk08aAoOnl9TU9Vtd2GwcPm
 ytDYv80vwsPKJVcjvZiL3lyxp9/LulImfSefNK6AIBRkK/cmIGslohEHKClYJbgCgJYl7E3rDox
 fA9ErH7EFrhTS9QWK9Jcm5Mu/8jDgfHOMffChFW+pYaWc70F4ZPZwMIbghXqDsO5SKcP2D5HL/L
 fpWMlX29mI+OqWHEF29FzCTYVkAMvgFavSBCTIDD427yiDBO3K3dQ1fEaT1c9S4o4aPyBvqVxcp
 URMbDB8nET3sQDM46Qjd8xJ2p+N3AEwrEbAwRK9nh7T1n9GngnkiAFqMC2af8xA92oxvQmrW5sC
 q1WrzvHignZH0q+MYkZlwl9VNJBl7lQaMQhvj77b+9YXp9peZgfDQ3uSIcemKlD5DzZAHM5dG/d
 yeI32HQkkpb9xDOCN/w==
X-Proofpoint-ORIG-GUID: E0ZcmYR9_2uf90pEd6BJhDzoLhOhIcKa
X-Authority-Analysis: v=2.4 cv=CJMamxrD c=1 sm=1 tr=0 ts=6a008af8 cx=c_pps
 a=OtY9ot+kQuHgQW+LdoSONA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=t7CeM3EgAAAA:8 a=FqfBi2M8hzWcHcbAlokA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: E0ZcmYR9_2uf90pEd6BJhDzoLhOhIcKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-10_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605100145

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
[Ionut: adapt to 6.12.y -
 - replace guard(uart_port_lock_irqsave)(port) in
   serial8250_handle_irq() with explicit uart_port_lock_irqsave/
   unlock_irqrestore; the cleanup-based uart_port_lock_irqsave
   guard class is not present in 6.12.y;
 - use the bare-identifier form EXPORT_SYMBOL_NS_GPL(...,
   SERIAL_8250) rather than the string form ("SERIAL_8250");
   in 6.12.y the macro stringifies the namespace argument via
   __stringify(ns), so it must be an unquoted identifier.]
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_port.c | 27 +++++++++++++++++++--------
 include/linux/serial_8250.h         |  1 +
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d0f2e634ac30..1e6dca739eab 100644
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
 
@@ -1930,8 +1927,22 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		else if (!up->dma->tx_running)
 			__stop_tx(up);
 	}
+}
+EXPORT_SYMBOL_NS_GPL(serial8250_handle_irq_locked, SERIAL_8250);
 
-	uart_unlock_and_check_sysrq_irqrestore(port, flags);
+/*
+ * This handles the interrupt from one port.
+ */
+int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
+{
+	unsigned long flags;
+
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	uart_port_lock_irqsave(port, &flags);
+	serial8250_handle_irq_locked(port, iir);
+	uart_port_unlock_irqrestore(port, flags);
 
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

