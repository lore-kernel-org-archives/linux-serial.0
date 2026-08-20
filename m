Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6299B1E1E16;
	Thu, 20 Aug 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217325; cv=fail; b=OTtMHh/p/GCxI1QRTaBsElCojieC+Axxo+vECKkdu/xgnKQWzww2vq6qFBkP8XRX/GpzZyC81GJkVt1b3It9YiBQ8lZ+ARacLMAatP7hPntZ3fplj6aBQqck3ZdcvhOCPtrq6JJfxqVBorjjVI8iPgtGoEDqiP/elWawJkwU6b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217325; c=relaxed/simple;
	bh=1RwUEIepjVj39K1NPzBKXveiazVeLNL/xKdo5riHYV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DNbba8rvM0CyCVN/ENNEjSWaiRZvY/EX/+SANXToB3bWlC6rOdqiyTMP6QTkHjA3lqgujGv2oRQhMSlbb2t+Qe+lfI5HXZunX1ens7QC7DRMvgzBGw1YEiJcLvI+i+LFYropLZtEbKT25N5dj7HtNYubZ0fmncU/0DhgGTspZa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aUZRruEf; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aUZRruEf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnTPqUvJ+AU/fxjVkZtoZzonvsuotkzn2iSZjR0ZfVHB+WS+NZoF0Z1qp12U3D6V1fXtKrQGAO24kxxcJ2LH7rElQSn1SriIjwHYsf/SoOuymonI6nyYw0I3rpdMy2ztJgUK7hgqtki1GNnNONpIkmEzbnGxlchuR5lqZGka0L6MK+sdQ/yyr6LPAD2TUNhCkbJV4HmDsNTryiX5UKjc7wrZUA5nEPJDUmaAVh1L8ikVOcUBzV4YPWlMybK8xkyScf6jGZROdCFcH27736M1vThRFmeS3J07o5DENcweFiNwu0cm2O7BEEsvqHQJFah9i7PZSWSrRIkE7q0KD25qhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+09Dnwqmh8d9W827x/SSa9aEZib1f53jey8WQidYCkY=;
 b=QQ92s9tmBagQkloQbjY9v6TJyta4I+NPiUTprrDAVqQa+HZEDMBSQRqoMMe1yvhqrw/FaDrd4KfhuGjqGOV3Flzf8pEanxwXKEs3cFaTtoMT/59htkNqMoTCtIuC0eA2rjZaP/M4J03+36nNU3qfut8oG+dAWt5njhr7Jv1NBaQ/Y+QrxVcU/hXKnC4cu49BXE74GUAxGdCMkTiWCY8HGyxrxvPgXU/sAUzV4Gk8DVmntQlbePHuREGKDxlxzg28wfl3zhczmGRG7dKGguQduAJMXpQK2NXv8fnuLHWKgLIMNv/fSutnDV2qjwKMCvwH/xgvso3IHagK/tkWoY6Jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+09Dnwqmh8d9W827x/SSa9aEZib1f53jey8WQidYCkY=;
 b=aUZRruEfuul9Z0HThPYgkE+pW5JMdVuCDl1CDS9f6BTjHMoPCLh9866wXylhkrHyZInKhYv41UHLK8FybepO2lgM/ea7W8Ey6T4E7lD1d0rSJsdRXtqE5KB1c68T3/0dof7dKVmPlpBOF+9grk5FTKjIRmyzL+WHdBB6kgIqF8lz3VPuKHijP3cGmknR1IiKSU8twB0fLBo2uwOirahdMc4LOnt4u2HgigUEwVvTu7BTgi6Re+lPKkggjZTyRkZSJg7Pdz7XSg7owjFQt6YGVkl2quSrKwTUmAPoMAoqBYstsLZqAp6bU3gtnW2XQGpjO6fllc4qYf1amloyPU4Dnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 09:15:14 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 09:15:14 +0000
Message-ID: <fd1802c3-4b38-4127-b988-a9ff059bcebf@nvidia.com>
Date: Thu, 20 Aug 2026 10:15:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>,
 Stepan Ionichev <sozdayvek@gmail.com>, Xin Zhao <jackzxcui1989@163.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Fushuai Wang <wangfushuai@baidu.com>, Marco Felsch
 <m.felsch@pengutronix.de>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
 <aoQPFC7d8mSuNZMh@pathway.suse.cz>
 <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>
 <aoR_9g7W0qyqWbOj@pathway.suse.cz>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <aoR_9g7W0qyqWbOj@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|DS5PPF4ACC15C0E:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcae722-3fdd-4371-674e-08defe9b8b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|18002099003|22082099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	dObEZfbU6uvT2ZbJUqd3FSQTVZ0x2FIX+dHWrWKVixi1mMDlit+XjSvV+stwGDgFKVnfEyyIGQgwxgSn5r5Thn4VCvzLsXarXeuVmMTK94Kpgm+qQ9wSn5b/udJUvcj+i22Qiil31XDaFPf/nUClPXDUZFRFdAePoJZsL1xJxcNHDd6NmKao2uF+aIwQVTJkalYA0FGgPmmMZaGPFjz9t3NwgTxCHYrrtAG8TbFapAVUHeWgYOZHGcfzApNaOo5iqbFY/cqq+er6TarPgD4ZUs4S3F4inNEknauFiK604YnHiz3xvqHLe84/5L6xlO8w87OEh6lZ0NrIlkVCbtmIXNNYDmFzw9Ceq/NsltLcb4zRmhT9oXyPVS2ZqfD59Q26DbgzE5Fox38lYsc50iYfvwuJ7RUUGM4sUH81HSC+Bf42tNws9FS9uoI1B+nBkw7apDf/Vv2jp30eNcjtXxtHiAKrozX4gGKm/uueiR2ZQnzVW5H+de59KADUqnUBJrxtyTq8tlPy1UfhY4mOOEEXNSzALNY+XcS6M5eFsy64QaFxtiGCnUYpZO767my2XrOgBOv8qABQs9wjQArOvx2xm3JMt/sZ/7q7Lzz6bSno8JKP1H3mgu5Sn7ksKPyRV3T9I4QOitWTK7eVOgO6YZu0A1wcZKvpRtALPMhn42B7L/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3NDR2JPMFViU1ZtcDdXeVFwVmc4OUgrSXNTdDQ1MWVScW1TTGdDR0tRcG1D?=
 =?utf-8?B?MVZyaGhTN3JzanZKWEU0VnYvWUR4Qlc5eHRNcEhENTQ4c0pNR2NreHEvMFF6?=
 =?utf-8?B?MnoxS1VDVE80UmdvaVNYdm51d1JPNk1QN0w2NHZUeE5rMlhUTmtDRE55dmhM?=
 =?utf-8?B?aUYyNmYrQXhUU2ttc0Z4QS9BblozczFZbVFLN3lOYWRqbHN4MTh1aE9pbDV0?=
 =?utf-8?B?V0k0eks1RzIzcUUybzh1MnE1ak9lVFM2cGpoV09pVlNYK0R3SFozVncybXBp?=
 =?utf-8?B?VGVHL0M3N3dZcEFmcEhuTElJQzdZRHBRQU9aMHh6eFpTZVFJaE5lSllJUmU3?=
 =?utf-8?B?S005RFJxak4vUTdIL1V1SkxVbjhSWm5aTmVpbFZCZ1hrODBkdGw2ZlhWd08v?=
 =?utf-8?B?bHhVSjVnL1hsdFd0Y1ROblRxOTRIY1dGTDI5OUhIZ3UzYW43Tnh2NEhFMkVn?=
 =?utf-8?B?dWFOb1k2cHJTRlpWYWNNOVh3M0k0bGdlM1g1Wkx0eWp6VjVCZ2ZYTldqUG1W?=
 =?utf-8?B?L3hFdXh0aG5NK01SVVRSbEsvU1dCejdCZ2NwaU5uZkM0QWp1bVRLYnpOdm5N?=
 =?utf-8?B?aUNrR0lCV2JPNEx1d1B2Z04wa1ZYK25FdER1QXJVZTRmY2hQYTloSkg1a2M4?=
 =?utf-8?B?d25OY0FxaDlrUTFjWUFJTDRGYTVvTUlVSGVpcmhmOVJZcWNOWDIzOEN5c1VR?=
 =?utf-8?B?N3kxYnpBUTR6YXMrajlYbTduazhrbWZYK3hKU3FvSnN2aCtHUGpkVGFCUEpN?=
 =?utf-8?B?TnNjNE83VHZaWk1wQk5vQi9XT3JCZmtMQS84bENNbDk5UUF5TG0zSlFMZ0di?=
 =?utf-8?B?RlFiUW9LRkFKTDF4a0RRL1ZvM3FsWW0wcVlNT0o0cm43Q2R5a2QrU2paVUli?=
 =?utf-8?B?WHU1eFNBUzFoYUt6czRwYUtXUm0zTzlCNEgyZW8wYjdlYlhpbXk2SlNJd2Fu?=
 =?utf-8?B?U2srZmdJbmZzdFdYdEJkeno4a0RzZ1RtSXhIbVRDcFZvb25Jd25MNnd4Wlhy?=
 =?utf-8?B?T2o3Q1ZoMDRGVStlb0o4b2R5dmRudFVUOVB0Tkd0aXFIOHNQWHMvODJyZXM2?=
 =?utf-8?B?TnNSMUJ2dkRnSVRCakVXdG9KNGRnd2RGdWtyTXNKVkxuUC9JajF4UnR1SDQy?=
 =?utf-8?B?dW12cVFCK2F1MFFlanZZOVQ4dkRBVkt5VG5LOW1KQm5heXN5K3JoRkVncXRt?=
 =?utf-8?B?UnNXWDZYbzQ4VkUvcEk4NjR1UjVNTDd6dENLa0QzK1FXUWhKT2V1N1kxUS9x?=
 =?utf-8?B?QThwT2poaGdhT0toUWgxZlkxSkthNlJxb2FEd2h6TGFQY01sVmFQUHpoMG04?=
 =?utf-8?B?dGc4Zk1IdHR3WFF5QnhDaE1TOFJkYnh3NCtDVWlOYzg2bHlwRzJMYUVXb2Vi?=
 =?utf-8?B?Sk5FS2sxVzRoNGRtRXQxVmNKNDRSUjBIWVhkRGl2bmFNd2FRdGtuWmZ5dDh4?=
 =?utf-8?B?ZldNaFBPWE9PSDRkb0F3S1dmUVVobVdpUDBJN2JpUkhyTzVvUTJ1KzQxbWNs?=
 =?utf-8?B?WENBeVhKaGFLTW1vS01lbzRPcEs4c0FCbE1hK2tVS0s2RGx5S2dFb0RYZHBm?=
 =?utf-8?B?QXpnaE1lNEc1R1JpdlpyT2lYbE93QlhqU3JrUkM2TVpGSUpET3UyUGVkU0Yv?=
 =?utf-8?B?ZVF0VFlaTi9TTHhLZk1vTlNva1VIL3BCUHVjWEVCT0xMNGpIUmJsMUVJb1Zw?=
 =?utf-8?B?RkIvTTlYM09ZQzQ4em1XdTdkVzd2eG52d0ZGVDJ1SnBYVW12YUg3b09yRHUw?=
 =?utf-8?B?blFTZTFsSGhRZnlHMFdNZjlLWk9qUWcyUXorK0dwWE9hMENwZW5KaU8yUmtj?=
 =?utf-8?B?TkYzQ0VmbVlxSVN1YVJJODdNWmNIVkhhMWhRQUkzTG9HRnF1cWJCVEU4blZO?=
 =?utf-8?B?M0hUaHNkRmpmZm9Ua29rajRNUXkxbjB3WXUyTndrcjFhSnlmdUcvRWJ3WUxE?=
 =?utf-8?B?T0Y2MUtlWllNdjJHRHZLWG53alhrc0NsRHNjeURnanpiWGZXNlNUMG92bE5H?=
 =?utf-8?B?dHpid1lKbUNpL1RSdm8xQUlwb0QrY0djclNqcitkbHkzUzZ1blZ1WmZLMTRs?=
 =?utf-8?B?VXgzU0lnMjhPUkQ1UExGbS90aDZ2MlJiNnVQRWlSbUtGNCsxTVZERFNoTVpz?=
 =?utf-8?B?Sm1CZmhCeVgxUi9temczSW1mNmFVUFJEcmJFcjhSL1dkQjlYVlR6UTVISEho?=
 =?utf-8?B?eEorV0xpVDRjdFp5N1AyV053Z0ZnYUtNbzhUWitlRUgwSzVhSmlEOGZUb05t?=
 =?utf-8?B?clFDV2lBaUdmeVR2MlduVVc4bGNHU3Y0UDdrZW5BWEtkaG9iMGcrWG9IODE5?=
 =?utf-8?B?WlhzVFYrNytDaWlRUXNmQWp4b0hOdzZ1M1ZISTVrbzB5eDVCT0tsUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcae722-3fdd-4371-674e-08defe9b8b59
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:15:14.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fr4ovQaGQ5CCRFv6oBD6UEJJpQ6qTMU/VkD6EWKKJ7+4CzXDN0ZzLfqPz2RKViIQLXIZEJkd1c0TDKd/k9outA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E

Hi Petr,

On 18/08/2026 16:53, Petr Mladek wrote:

...

> Summary:
> 
> Almost everything works as expected except for:
> 
>    1. I am not sure why "printk: console [ttyS0] disabled" is printed.
>       It does not make any sense to me.
> 
>    2. The WARNING would be handled with NBCON_PRIO_EMERGENCY.
>       I wonder if this warning happened also with "v5" of this
>       patchset.
> 
> Why is the WARNING important?
> 
>     If the WARNING happened also with v5 of this patchset
>     then it tested emergency mode as well. But the system
>     booted with v5. So that a difference between v5 and v11
>     patchset might be important.
> 
>     If The WARNING did _not_ happen with v5 then we probably did
>     not test the emergency mode in this version. So that
>     the problem might be in the emergency mode handling.
> 
> 
> 
> Ideas for testing:
> 
> 1. I wonder if adding a WARN() with v5 of this patchset
>     would make v5 fail as well.
Thanks for the analysis. I don't think that WARN occurred back in V5 
because this is something I believe is fairly recent and we need to fix. 
Anyway, for testing, I simply removed the warning to see if this has an 
impact and it does. So you are right, this appears to be the cause of 
the issue.

It would be interesting to know if anyone else sees this if an WARNING 
is inserted somewhere during boot.

Cheers
Jon	

-- 
nvpublic

