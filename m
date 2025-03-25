Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2097.outbound.protection.outlook.com [40.107.103.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AC259C9B;
	Tue, 25 Mar 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912354; cv=fail; b=tzRob5HGHyiAOA2fpFk8PsB+c7nLA8TWXF2Y+2o46iWORrGCsXIAN67p0zPVoQcX+9jkDqIDmXx6DCL3fGA2WTYylx/vIRydxSUVb66DHgBGIi93dVhUNzjpQPyp2KRl1DftJpHh/lXMzrdegSZXD52ft6YGvLeITO6+nEmON6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912354; c=relaxed/simple;
	bh=IclWvhvEb8oaLxkygtsDz3aihMVwdxjQlMe8B0gwlIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r2n8GjR06bpwkChHw5ZDOmFy1b8wVCJ2Z7/kkhtecLEWwix5+OIGfCexqVAET+cN+hw7l+tz1CQukmaaJBRs2qspOKq8jE2qroKHtHHWF/osLDYndhrkUZECc7O4445+E2EkBOWPt0aRYxQDhEKGuE2h+MbBnYMocFW4gRcVh3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=PpzrAhqk; arc=fail smtp.client-ip=40.107.103.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="PpzrAhqk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh9uRaBnmZ2ROwO5Ewlfmy9lVVrj7F4hgy/588p0m6b0r9Z9Z1hsSIUvRPJwfQcy+3zPr+JCXfYBfGBp0ue6kUtbbI2rl+VR0pEy5fl0sMFyz+QyCwWxw4CBE20eg3yDSitO/PiOBXCOBli95IYxQCUJUbeUwca7qxTlleF4Zp/sJCTa30jUYtfvVt1LBeyYqYZYROgiXC+15tKLo6khZQR8D7tGUmdXWYT9ptO+PFWfWg6Rpm4LIsozyVcKkdzDwT+4TsFhEXzg5H3N3luaUzCVyH4OQDrU29suWXItOA5mr9JR4TrhZ/I9Y2ULcvYl8BL0eRZdzIokY80FPnqw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJEat551/2CvFVXKBu9jBuTjSCj5d3OIX7NVLaSVXhI=;
 b=p5ScjpMmswdDc6CnG7g/FZdbp+utYUHF4q+zoNrrmpTEQZSBciv2jRKpD5JfSwmaEiI3/J5hJH3gkeAQSgn9mEH4quqMR+F2+0CcqQ7QFUVcegrIr7F/Wx5XHzSzxpHgBkb/gPNVdLqhN9j4zGgfbvrhASH4GdyWbIk0IHm5ya9B2/KtsQpidGpIkQ2ye97/OOtwuZ5uOfmvzqkNPMwNllllrtGQbwM+cNZROyMXoxOaJpFF/ITkUw6UcEPyODmx3HTEGwb2vfJmo5+ATejyNTI+b/uopMA0PcL5GwRk2o9jm2E2buXPZvCPhj9L0WO2d9l0k58l2SAYmiHgrMAw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJEat551/2CvFVXKBu9jBuTjSCj5d3OIX7NVLaSVXhI=;
 b=PpzrAhqksS2Yo25g0rFGl/5GDFBMCSLYgf4l18oW63ehkr8dbsv7tB/XUibyw1FWK/+ZdVa1PzpBJtya3GpF/VdnmyoZZ7kihzeCYy5Ekd5/oQq61Cgx9JbrDflydMmx1ylM9K8YYSXD8okA3IaS5MT+UleDEQbuvEe8VxbBUP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by DB9PR08MB9922.eurprd08.prod.outlook.com (2603:10a6:10:3d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 14:19:06 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:19:06 +0000
Message-ID: <0c8bc7ae-cded-4b52-8965-f6e6487a06ed@genexis.eu>
Date: Tue, 25 Mar 2025 15:19:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 ansuelsmth@gmail.com, lorenzo@kernel.org, gregkh@linuxfoundation.org
References: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
 <20250209210241.2622309-3-benjamin.larsson@genexis.eu>
 <Z98uumXXqj_opuTT@surfacebook.localdomain>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <Z98uumXXqj_opuTT@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF00002BC0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:11) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|DB9PR08MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: e1dd1d67-50ae-4f7f-ff0a-08dd6ba800a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEhtb0VuS0NDaG1VU0NyL3F1ak9QbUdmQVRwUVhpbE14UEVYVUQxWWVlU0dw?=
 =?utf-8?B?c0hCc2pBR3pMbGVhS1BTVHdRSU8rN3hTU3BMYnNpR0toOVAwOWF2VFJMQWFT?=
 =?utf-8?B?VlRPWktWV2JOM2JqTG85R1BmNEFyZGlMek1MT0R6MmhlSXlBb01DNnRZMzFq?=
 =?utf-8?B?WG1YNnZmSkc0V3J2QWc5NjZ4SFFianNXV1NpNGJzZ21YNTBDUlBCdFI5SVJN?=
 =?utf-8?B?eklWa3VtRTk2eFJlaklPbXlJeDZJNU5ka0lQVkEwZUl4SHJHNjhWLzJMRlYx?=
 =?utf-8?B?TVhVbnFPUElYa0VWcXpXVHJsbVBZaiszc2N6SlFKa1pnVDFQd2tnMW53M1N2?=
 =?utf-8?B?TDJlWkdEUXpTODBrZVhQSTFnaU5UazJyM0dNRWgxUXdzeUV2bHQ5RjJ5V21F?=
 =?utf-8?B?OWgrSkhvN3VLVkpNeTZZZGpwM0VsdWN5Vlc1eG80bU5wa3pDWTZmVWI1Nnhm?=
 =?utf-8?B?WWpQWTlwMG1KVGRVUFk4UHZjS0JWYmZYSEVwb2hqTGNYd3ZwWHgzQktvWlo5?=
 =?utf-8?B?STd4VTVyd1hHN1VlQnpnanozbTlBdkF4Znh0RTJnZVpDMnZ6SWRONkxQSjg1?=
 =?utf-8?B?K05HVWJpZVpLQXJQVmY1TmdYRElWMGF0R2hkU1Rpc1hmeU1PSFd2TnFvY0do?=
 =?utf-8?B?Z1FXZ2RHakwwSTFVOWNJeVphbENlbms3UUxQSUllbzZYamk1WDQxUXQwbUNE?=
 =?utf-8?B?Y0N4bmtmanVTd1UwRXhUMGxDVTZXZWgyT2FQc2tzaEhmczl6c24zUENvWUs1?=
 =?utf-8?B?Mk9zRlVQSHBnbkpXeEFkcEw0dHpyNi9lanZuMlJMNXVIdlQ0UGFZT0hWZE0w?=
 =?utf-8?B?QnM2QStCY3Fyc2gycE5wTEthUkxheDNHcG9zemczT2NnUkRYWFNmVHJneTBL?=
 =?utf-8?B?R3BuYWo3YUZaQ09XSUg4TU9uUXpoYWRPMUlOL3M3N3M2d3QycnJERWR1Y3NQ?=
 =?utf-8?B?UjQ4UmxXQ2RSVjlCdTh0cGM3T2VWWjQzOEMyb0s5UHh2ZVJSM1h6L3gvb1Rt?=
 =?utf-8?B?K3ZCbmZuNFh3ei9iVURyZEFJUE5GV0lwMnNlbkluMGNFeS91cnJjN1VhYyti?=
 =?utf-8?B?Tmcrenl1cFhobERLWEZGTEVVdUVEYks3U04wbVloRjlMd1A3b21VMHR3Z0FW?=
 =?utf-8?B?VXNyeEhwM0Yzc2xSZzJHOWtVZFNrejkzRHh1dnFmOHFEZkNVSktZcXpoRzJl?=
 =?utf-8?B?ZVg3dWE0MUkwMVEvTTVGeS9MSW9ZVVEwS0owRUV3eXNzM1JYcktYSTYxNzNK?=
 =?utf-8?B?MFFSZS9KN20zRjFnQ2ZWZUhETVBoZFY4dXBNS1k3YnhCM3VzODl6amVSQWtU?=
 =?utf-8?B?ZEtWTTFjOVZ1aGtYMEdDckp5NzNuRVRQQlgvQjhQSnhaRWJKVDB1VjUzQjR5?=
 =?utf-8?B?alVldDNjVjRScll3SGkybXplS1VrWGE1bUVLY3h5ZGJQSDhnaFZydUJabDFF?=
 =?utf-8?B?QVNyUmV6Slc3a29ha2YxZWtQQ0laZWhtL2xLelFEeE9oazUzY0MvdU9FdmMv?=
 =?utf-8?B?eG00LzVUaW4wTHU1akd4dE56K0VWb1NDSUZWTTN6WkhHbkltN0pJWWdBNFpZ?=
 =?utf-8?B?eTB6b2tiN24rc2NIdkFYN1ZuaWVtckJOaFd3MGZIT0Y5WFkzcXE5a1laazBL?=
 =?utf-8?B?MGlyMURQZjNCRmJBTDJraXlOZzZ0a2RuSk1WdXE3SHMzbXdoSFN4NlFDT3Jo?=
 =?utf-8?B?RTdRQkF3WE8xQVJDeXVORmhNRFlxMEJhQzV2ZlpNL3Qzc05idVBGcGlXVVFh?=
 =?utf-8?B?MUpVaC90S3ViRnNoY0EyNE1zYTdRY1VwZzB0UmM1SldCVkE1RCt6dC9reUpR?=
 =?utf-8?B?L2prenU4SUxYZGo5UTVtWm9Tb0c5WUR4MzhyazJoSlZCMk02U2FlcXJhUUIw?=
 =?utf-8?Q?bXZ3Z3BeSeLql?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFhLQW5SM1dLMm5KZGVPU1V1bTB2KzJQRTFWQ2N2eFN2VmhkK0JZQXRaOHdF?=
 =?utf-8?B?ejNPWUFDOXFubXRJQk5ITG9ENUhsbUd3QlpGU3VXQWhXTXZrbUpGb1ozUmRY?=
 =?utf-8?B?WjUxRXVVMDFicEV6WjFjSXFhVWtKTnQxUmN6ZDBpTEN5azl5RFpOcFVaUVpC?=
 =?utf-8?B?N3c5MDZtT0hpTXRoZlBwSkpleFdFNkNQbGw4Vlo4d0JUUlJPS3VBOGFpTUZ6?=
 =?utf-8?B?MzlyVXRGWkJuVmRUU0xGVDM1bXNQYkJ5bDAzZWg4SEFDNU1ucTB2OEVCYUlt?=
 =?utf-8?B?clR0bmtZbGFEc2Z0UldHWW91b081VlFPWEVTRmxhWUl2MGwydHBWVGd1Y3k1?=
 =?utf-8?B?UW1DQnF5NnJxN0pLcXR5M0dVUGFEeHY0UlQyaWtXMGdxYzZLaDZkQXZMRFpr?=
 =?utf-8?B?dllmK2pLTDZpcmo4YlZpQlovMytCVDlqOHhtcTFLMU5SemJ2N1lDWVdQTi8x?=
 =?utf-8?B?L2tvMEtxT3BVdUp3a0sxRzY4VXZWUTZlOExXWDFEbEtlempaandnaFBPOWlC?=
 =?utf-8?B?WVc1MnNKTXNHUWRESkhGeHFmZzZ0VWEvSER1RnVVMUpRTndMN0RhUnVSNnZT?=
 =?utf-8?B?T1lUQ3RBNGs1NHdYVjBXOUxKUktBRjNuK3ZTSk5sS3hJUkl1Q1ZHbWR6Umdm?=
 =?utf-8?B?YTluUHJzSUFCU09UeFhKZ0hPNnNOVHUzOENvcHkvNGFIdFhPbGtub01BQmZS?=
 =?utf-8?B?R3g1OHE3dGdYakJERUl3K0J5eTdtNlR3bHRtTExYdzFkdlgrV3lRMXJkZmQ2?=
 =?utf-8?B?bi9YeG56d2NjczByVjRZQzNLR0xOZFJOY2RDWHUzSGRTeEZCcytORVVubjFB?=
 =?utf-8?B?aXFyT0lOSkNWZFlxdkZXTVB0OG15azBqeHNIV3FKODVXdllIU24yZ2c1R3lI?=
 =?utf-8?B?ZzZxWXF6TThNTkl5N1dTcGliL3NWV0FPaXVocSs5RXVlQTRTU0NSUmw0LzZB?=
 =?utf-8?B?c2J3MDBTYjU1YmpjL25MVXU0L1JSSWNYa052KzR2OVVYMUZHc1VNV0g1b1NI?=
 =?utf-8?B?QVhmVGF6TjZpWkZIcnRBU3ByRmtUSGRxakgwc2VvdFBPNHdaSGluc1F0LzRL?=
 =?utf-8?B?Q1dLYWtOT2NtZ3B6eXF0TjBvR08yRW1mdm1NTWhEVFNyaTEzci9xZ0xMUWN3?=
 =?utf-8?B?Qk1HRzVodjZreW5KNVk4eGJ0OG9hT043eHpEc3BiK0VuMjQ3UHZXdE1lTjJS?=
 =?utf-8?B?QWFlbEx5ZnQ0cUd6ZW1oOTZRYmtnN1J1RzJGNmJYM3pwdE1YWFFzR29xZk9U?=
 =?utf-8?B?bTJiK0JyZVZ0VFFsVk54ZGJPL0h6UlNyLzg4c2c0K29LMS9JMUd4ZlFhNzdh?=
 =?utf-8?B?QjJjRVhneWJ0aVhHRmR2dWR3K2p1ZnN0TDkxUm4zaWRHTFkvUHd3OTVZdXo5?=
 =?utf-8?B?YnU2aSt2a3pNWHltRVZIeWNubUtkTUxNSlpuM1B4YVNZdjdGcmRidllSZ2Fa?=
 =?utf-8?B?QTE5ZytIM2hiRUUzMkxDUzltdVVsMEVMY2w4cC91eWZ3WTNuVEN0M2pTRk5W?=
 =?utf-8?B?MGRqUnVKWUNPTGI4WGIxdllIWWJuMlhFczZnb3pOMXdiQkQrOEEwTE4rNnNu?=
 =?utf-8?B?RUplYjNCcFl2UzlQY0VVUmlmMkE0dEdHaG1wbzcrTkVEWHhKUjFXaE95dmR6?=
 =?utf-8?B?Ny9RRXUyRExQR2trbW1CS1UxR3VYZTZnVXU4M2l5dC9TYnFxRzFjZ2sydDJG?=
 =?utf-8?B?eEtUeDlTWVArSVBoZUdyWTJJRmx2bXZqaGRxMS9mL25waHROUlFFVGNnZGlP?=
 =?utf-8?B?ZnNXOXBncmJFT3JxTXZEY1lLQ1VXRGErZ3dkVmdaSHp6enN3OVNTVFNHWGYv?=
 =?utf-8?B?SHhnVEh6Lzd5SkRta0xCVlZjSkl1bEdLNFlrRFRQaU1jUjYveThKMDhPaFdy?=
 =?utf-8?B?elRwZVFwNXF1Rm9QdkRUSEExdi9ha1I1ZGFCMWdzS08rL0MwNmJlV09BSUV6?=
 =?utf-8?B?OCtYOG5Gd3JzQkJwcmwxaDRlZEpUN0R5bUFpM2Y2TmxMbXZzYkNWc0U4bFZl?=
 =?utf-8?B?U0NiRUVIVmI0YzBmMDBWMWxSRmdqVHl6Y21TWlVWYjJENTFYcmt6ckc5emFX?=
 =?utf-8?B?Qk1MVjRGc1h3RVZVM0p4eDdCRlQ2QXNKU3pDRnJJVlN3N3JLUkpCOVRyNTg5?=
 =?utf-8?B?OTEvVm9ybFZZdHlhb0h5VWZVbGN0WUxHMG1qN1VGajZ2dFl6NnN2Z0p0eEVV?=
 =?utf-8?B?Y2x3OEtiU3pBMDFwb3pTWkJEdTFYbTlINDZSaDNRNHozV2pVNEtvSkRpZ29z?=
 =?utf-8?B?c1BvcjlpUlJzeStqazZjd01xSDBRPT0=?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dd1d67-50ae-4f7f-ff0a-08dd6ba800a3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:19:06.7196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChXMjwqFbAXq/jJBwuRi5SYj5EES5MUnO8Iw88XNQbxZ9iSIWUbtWymqYwwHLo6eVa4+A/G1FiQfHhcHKoigrMCLxKy5PKEfzbEfU2Z95Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9922

Hi.

On 2025-03-22 22:42, Andy Shevchenko wrote:
> [You don't often get email from andy.shevchenko@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Sun, Feb 09, 2025 at 10:02:41PM +0100, Benjamin Larsson kirjoitti:
>> Support for Airoha AN7581 SoC UART and HSUART baud rate
>> calculation routine.
> ...
>
>>   drivers/tty/serial/8250/8250_port.c   | 26 +++++++++
>> +     /*
>> +      * Airoha SoCs have custom registers for baud rate settings
>> +      */
>> +     if (port->type == PORT_AIROHA)
>> +             airoha8250_set_baud_rate(port, baud, 0);
>> +     if (port->type == PORT_AIROHA_HS)
>> +             airoha8250_set_baud_rate(port, baud, 1);
> Why is this here? Please, make it stay in your module.

I dont add an extra module I extend the already existing one.


> ...
>
>> +config SERIAL_8250_AIROHA
>> +     bool "Airoha UART support"
> Why bool?

Because it is just an extension of an existing module.


>
>> +     depends on ARCH_AIROHA && OF && SERIAL_8250
> What is the purpose of the OF dependency?

I thought it was needed for dts support. I'll remove it.


>
> --
> With Best Regards,
> Andy Shevchenko
>
>
MvH

Benajmin Larsson

