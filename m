Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6119006B;
	Thu, 16 Jan 2025 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023241; cv=fail; b=uJci0xyCAncw/7O40ItcpicXMUTNlP0wtDbA7zuqEHrtg347PfYJHXh74zp4h6eS6tydtj2L1wTNs7Zq3Sl/XEh5aUBOdWWClHqL3OIY1nhq+mowWw98zsb6Y6SvzDPsDKqQT7rLSykiLEuZlPOaO6P9/jU9+2wgGcmVn0CAYIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023241; c=relaxed/simple;
	bh=loLhyKceTRsmwSulT0soOU9g5MiMmNTqbWTHAwNx9zI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O+kZTG3wUCYNrO7uxGCskHnzqiBgCgqwleaIZMzV0cDNyeXiH5Ow3N1HY7hdQhC7TH0ZU/XcNtBLbTgNbG4EYvlDM+p25DXnWNFViOYEJRJinaUfRmD6sffcsz+cCMWtsis0FKH83MNnmNy6eR49mImnmceSbTG2x0Gjix1YXAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZaI4aMM; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZaI4aMM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR8lK0c59XzSIXz5FVsyOpGB79Oi43wFKSv2Yq01ixbxF9/90DpllhU+rEnt22BaWnnEchz3sVFKjuEpX+9n1at10Ql/onOLq2KuZfX4KhKCNRTCAcR5ExuuHi8RxIETboZJRNgoRZ2gV3tyuT16rwaSpW/Pe4o1N1UUH57pAuaZGYsA2xA2DXaiutr1krtTAqPbo1Y+bpZkm5NpOHNDQVI3c0zEPJz4s32jgib5u41aj3QYPcJ28DnFNrbiaeb/e1xYv8AKqRmt4hQdHEZA9ArNjthtXr1M0oHqnmPcjZwVG5P9Oqlcf+fG+NLvYx3b/tlY75yxY5hArk1wCgdZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDhaCJf1zWr7dgRI7VKmNgoX/Ll0tCs5JAsGWaKKwcY=;
 b=aGUUa4OAuYFdrhqM4aM7nIeFVoWxn8Lq+WboEDNcywUebFYU3bVrBum7MZDVmHXpv3myj2/68UslVoxkYDzyGDBBpzugO7ffrDEbsRnn/xhgHTmP0P4kJ2n3i1PhvweH5KHRdC2AnTEY1pRqPMsve81vuEVdi8+pwLH5ikpwNHBlEP5qtCZXVKI/23x6yQR/DOQEgJOEZ8bvVbYiihj2EzMcuw+nB69sxKgy5YAlcTviXPETdwq4/IaXDcqUmSP6TQDai1BMtTa7YMQY3fIUZdI/yqrgGWe28HlhVImnbgSzY/OlVjmqLTanjmzwqpo9Oe+mG192u2ol2/l7ApmQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDhaCJf1zWr7dgRI7VKmNgoX/Ll0tCs5JAsGWaKKwcY=;
 b=JZaI4aMM+5R2ZcrMwSrujtRMHtXfM2Z77Ho7TUs9CrjgEg3s79qOoEXgHneh/XY7jpHJID0dKYKRTnyoqbHR7cIRXCzjEh+2Dzyk/FRmWM8pQQVO5rp6oX6kHC/EHeqsuRRejhJONHVlnit4xvhNG3nMsQ0bxU150Vb9oaUkrfmt2ghzFeFY2nlDoeil13uxhqzqGjhu3nzwtX1VusV0aJ7vt2EH3b1F78STLNs2geYEuTxwZCMAc4ERzzNXGfAVO/0wEErCgfRzqQORVR2UByhlKiBwe+qgG25VpAp4v+UTsJrZKMw/y0sZ4SdyGzQXvVdFy/KzONK1CWOegV9rFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 16 Jan
 2025 10:27:16 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 10:27:16 +0000
Message-ID: <96b02b20-a51e-480f-a0ce-3a1457650ca9@nvidia.com>
Date: Thu, 16 Jan 2025 10:27:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
To: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
 <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
 <84ldvcyq41.fsf@jogness.linutronix.de>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <84ldvcyq41.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0158.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b3e4d8-6396-40a5-16e6-08dd3618593d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S04rODhqMGp2emp4WW03VUhMcVRnNXgyYlQ0bmVHMU9maEwvUzFCQkVRSVFN?=
 =?utf-8?B?bWpvUW9PMWFtRlNPUHV0bE5DVFNwdlZNWTYvSmZLcG1rbDdDUFpFbDRlN2Zq?=
 =?utf-8?B?VWZ0Tmx6R1R4a0ZEbXY1UmxVRHlpeTF6UHlmblNoSFIzVWpXcGRjNnRXa05k?=
 =?utf-8?B?aEtVVzlLWnBHeVlhMnBHYVdnc1g0Ykc0eDIydUhVUjZjaTZzbFQyejNRQ2p2?=
 =?utf-8?B?ckkxN2FEeWNRNHU5WWd3UjZ6YS9CTmZkVDVGZ0RreUxscmtHWDFaZURYUklm?=
 =?utf-8?B?SklTN0c2dklERC9mYjlZeVV2dERrVTYyMzJPeU1EZ0FGNUdHNzdCcG1HcDRl?=
 =?utf-8?B?TndFVFFmeGFZQ3F1b3NwWFRBZC84cUNnQWswRXRDeUVVUDNweCtmTGV3Vm5Y?=
 =?utf-8?B?OHlrTXFUV1dwa09zQk85VmZzcUo5TGJ1TzJBNDAzc3dyVzFkV1JNdnZrYTlO?=
 =?utf-8?B?b3hGR29sb0VuVTRnQW1FWmJIbHBON2JJc3J3Y1VXRzBQVWhlcDdmRXdyN1ZD?=
 =?utf-8?B?UCtJM0FsMDNmbks0Ky8xUmIxWURvcjJUencwWXF3Uk1peWkzSElGL3RjcDJi?=
 =?utf-8?B?VGdFL1YrbHUyeXk5MHl2K1lzdTV5UjQ0cWthVkRrVzJJcDh4aE1iUEpOaGx2?=
 =?utf-8?B?K3pQeEVOSitLaFZxeWtIbEl2dVBhemdVbkRjMTdsRklGL056NjF6aG1GUjcw?=
 =?utf-8?B?UitHOHVvRGFQM2pZN1NiREdVTHBVN0tUTjBUdlN4WVV6R1I4K1RtaFRvVUhk?=
 =?utf-8?B?d0xTWEdDT0hWY1R2d2RnMTRUWGJ2cGxJakoyZGZENUFrRWE0cjZpY0l1T29J?=
 =?utf-8?B?VGpGMnNRVC9PbUxXWG0vejFWOUQ3MEJjSDRpVVY0bTZ0MjlVcEgrSHozcU1z?=
 =?utf-8?B?dGFYRnQwWkVtSk1pV1lXbXgwYzRYbEFpZXcvc0thcjhSRkNnSFZPYmV1ZnFv?=
 =?utf-8?B?bFJYZ09pSlplNE5tYW53QURGMDdRVXZ3SkU1aHVpY3hoZ1BNRlo3UkpMMVNi?=
 =?utf-8?B?cXFzaWgwVVFJc1Vvc2xEUEdSVWRES0cwd3lnakJTZDR5UWtIWko1TWRDcmRt?=
 =?utf-8?B?b29uMFRWU2lKamVncS9LQmhaNmlEN29uNnFEa3Q0ZmI1UXpTS0JXVk05My9Q?=
 =?utf-8?B?Q1B4dVcvNjl4QXcyVFZ5cjYwcDRmcVVPaFdhRnRXdVAwM1l4QUlpY1ZMa3JY?=
 =?utf-8?B?Y3BUNjVTWHNobmVWeldKdkEzQU9ZN3ZrRE1qUndKK1ZuWkpOYWhNUVpYdzZH?=
 =?utf-8?B?YjRjVFBOWFh3MnlaT3dxLzA5aWJUYnJiajBtS0UrcXc4ajNSN3BKRzcvbE1T?=
 =?utf-8?B?NmpUdHh5RkFkNkUwV1FOeWE1TGVvSXR2WkZ1b2VHN3ovejd4WFZvVmYxZkRv?=
 =?utf-8?B?bFlpREtxQVRJQ25oeDZISThCWW44QW9xZURDNjJKd2M5dVN5YWhhVHhZV1BU?=
 =?utf-8?B?L2tsTlpidEpDVzRLdWxuNjJZVUM1SFZ3Wm84Qm5NRE1NNUtMcFlsZmJuQkpi?=
 =?utf-8?B?c0Z6RkJ0cTIxMHlZbE5UY0M0eXlzT2wxVVAvUWMvNXVwTnlWVDhEZnRTMW1L?=
 =?utf-8?B?WThHM24yVFVpdXNzekp4M1cyZ2h2TDdEaDgyalZhNmZxNzlkYXBDdEZ3dXJU?=
 =?utf-8?B?N1ZOT2wwbDFzTmwrSGNiZUZxK3c4T3l4KzkzNlBieGZzeFlKMi9tY2hNWjNy?=
 =?utf-8?B?VW5uRjBsSDVkdllXUERnQnBsY2hjYytJU3VPVE13b1ZISjB4dWh6N1A1Y3p0?=
 =?utf-8?B?MUpmRVBteXpwSUUyQzVsd2JMemQ1SmwyMU1vWjVlOXpjMWZ6cjl4bFdpQlRU?=
 =?utf-8?B?UkhmemFVMFR5clZwVHNtanNwYXByaVprSm9Zc3RrWXRxb2NCQ0RVSUVPWXRq?=
 =?utf-8?Q?sLLIaFIs4MS0v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmVvd2RJS1NlT0ZIUXE1L1RFVVdEMlJUbUxLdmFhUFB3MVlUVzJDaktyWkN0?=
 =?utf-8?B?eGpCeE1qaTZPTU5uT29hTUtTOVRvQll0THdmd1NtYXdSdjNrQUdYemVndlBG?=
 =?utf-8?B?UWgxNk9ZQVM0dkpSTm44dDhDVk9oV1VMSktrOG44KzFEZG1WUWdZRklRWnNs?=
 =?utf-8?B?ektFNENkQmNkZmh6b1hmeWdiZnF3TVBkOHJNdWNiQXdhdUlUdWNVZGVIVlhM?=
 =?utf-8?B?TmRHZFJicDFiM0lJUjIrUE5nbE1tQ2YzNjZYelRnTEUyM2VmbkdhamgwYWU3?=
 =?utf-8?B?L0ZoaEQrZWgxMVFSamxCSWdnb0xkd01ISFhUcEVaL0pzSi9hdEpHaTkyMzI4?=
 =?utf-8?B?a2M2K251aW93OXJIeHdvS2ppUERJcThOUFdOZ3VETVl3TkRRRVI1WUxTSC8w?=
 =?utf-8?B?cVMvcVNXSFI1WWhCR3Z6UndpMlRNSUFxSW0zbWQ5SVBQVEpPc1dqbWQvT0M3?=
 =?utf-8?B?eFRJSThxNDNDRWlSWmdMay9rdFVMWElCa1RJMXhuSnpmSllYZkNFRlVaT3JP?=
 =?utf-8?B?ZVdQS1pQdmdhTXRFZWFvelcvdVB6RityYXFpUk5LL0F4clNReW44ck9RVG1I?=
 =?utf-8?B?SE1KZHpmME9HZHMzaXhUaC8rUWhhVDRuTVFhbnk4VEpxT0dIcG1UU0x6clFX?=
 =?utf-8?B?WHNVZUhROFBMV0JrbjE5VHZqenVBZWZneGY4L2wzQUdnVkFqYkE5MHVEM2I5?=
 =?utf-8?B?OHYyYVRCb2lESUpnMzdlL2hYMlBFbjE4aFRGZ2ZiVlJLZUlpeXlvQ1F4dzZr?=
 =?utf-8?B?V1JpcmYxajB2ckxvdVhYSzY3QnVhT2pjK0lUK0p4eDNjdFlnRXBYeVAyL0Mw?=
 =?utf-8?B?bjF4ZldIdUNoaUMzUzJqbWJqS3RkcTlMa3BYakFuRWpncGpHU1Rya2NxY2Iy?=
 =?utf-8?B?KzJIQjVVeTlKRVNITlNKRXBQc3RtaE5Lck4zM3lCc3RLa21lQlpQaFBraFE3?=
 =?utf-8?B?R3M1RmNnd3lCbm5JTW9CS05YZ0dUUlllSXN1NDRlWkcxeWIzNUtGOHoxSFFY?=
 =?utf-8?B?RUYrTEtqL0dPL3NLRDh0bmxaZG1vUHRlMldnVFdhcTVZVXg0QmJoWjcwSHJx?=
 =?utf-8?B?L1dwdVh6MmJVRWlzY3hENGpZOUtFOVoyOGpNYTErb1h3WWJtcXRwZ1pZUUZ5?=
 =?utf-8?B?TVhLRldyOEQ0M3NLamRQRXdGUTdvbnVVTnV0TDlDMHRKUlFtSTJ1YjRXRElT?=
 =?utf-8?B?Z01UMWN4NThpVmhzSUFkV1FnWkRCemJjdG1jSDBNaTllcjVVVVRnQzFINTA5?=
 =?utf-8?B?eWlOci9CTFJnangxa25JNVNvZmRIdEdvR1VVS0NKdG1hdE9vZkNUcDVmN0Vv?=
 =?utf-8?B?T1N3ZHJBS3RTTy9obVNycFJzQmdybHZiWW1oMWhDc2JYU0VGVDNYYWhvY2J4?=
 =?utf-8?B?dW42ekMwdVFUWHVXaXRPU0F1SGlPV09XMzBJcFpwbCtqSXBMSVE3bVhKMXJ5?=
 =?utf-8?B?aTVVQ1pLYllXcjVTTUJZWmpSbHZSdmtGeDg1cng2cTJMcHAyaFBSdklqSDR3?=
 =?utf-8?B?TURIVnV4cU9oOE9OMjdGOW1tSHZoUHF3aEY2VVBwa3VxRVFEeUw1YWZrOUZ0?=
 =?utf-8?B?WkdXeVBpSjlhT0FNclg2MDlDalRNeXU2SitXVVN3c2xGRmlIMlRSc2ZOZmlv?=
 =?utf-8?B?U0hWbTZ5MU1BK1IwMTFnMHdZZ2hMYXRHWnFSRmlVTVFxcVpCSkUva0crWHR4?=
 =?utf-8?B?TkQvMjRtU09lNnFRRTlvUHlRdU90WDRTbXJ2c3djS3BYU0dhVWRHNmRHY05H?=
 =?utf-8?B?cC95YXFPUWFkeGpjREdNNEp0Vmtvd0dUUTFwUk5lTUpkRk9HZndzL3FCbWsz?=
 =?utf-8?B?cmZJWXJSTmhvamJ3MVhySnNRVUdqVEtTenIzcVpqbnVmRXg4QWNZNm5yOFZY?=
 =?utf-8?B?S3RJUnQrQ2FIbDFNTDl6T2FOT0NpS1B0M2hXb3l1d2Z4UG0zMjJwQk1mbzVK?=
 =?utf-8?B?SDMvK3Z6ZkpLblpORjNOVjE1THUxeFN1RnpCWWhucVlHSDhtZGpxd1Y5WmZP?=
 =?utf-8?B?RTMvVDIvRGFCdDhTVHhRRWRZbndHT1VhS3FsLzZHZDhlbjdkek14RnNEQ0Zh?=
 =?utf-8?B?eWEwanBteFJRVDhTZUM3bWthV1I1TU5HSnRWb2M1Z0JyTW1kQWlDbVJQNzd4?=
 =?utf-8?B?dzRuK0FJZ1dXLzRVL0xVRll6NC90WDJCWTFqR0VuRzRLelVKOG11V3BRRWJm?=
 =?utf-8?Q?2fWb/42chPGVZ4K7GikzCko3b95RG5oP8mNR+pUmKewf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b3e4d8-6396-40a5-16e6-08dd3618593d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:27:16.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPOJVHacLe/xueDMLJuCCCjTadOfVKJAGAzvAgFCxeWsEWk3E814SHpWX5r9vX6aZ1W+ifLnFOfSCpN5gyWjIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823


On 15/01/2025 16:54, John Ogness wrote:
> On 2025-01-15, Jon Hunter <jonathanh@nvidia.com> wrote:
>> I have noticed a suspend regression on -next for some of our 32-bit
>> Tegra (ARM) devices (Tegra20, Tegra30 and Tegra124). Bisect is pointing
>> to this commit and reverting this on top of -next (along with reverting
>> "serial: 8250: Revert "drop lockdep annotation from
>> serial8250_clear_IER()") fixes the issue. So far I have not dug in any
>> further. Unfortunately, I don't have any logs to see if there is some
>> crash or something happening but I will see if there is any more info I
>> can get.
> 
> Do you at least know if it is failing to suspend or failing to resume
> (based on power consumption)?


Unfortunately, I don't. These are farm boards and so nothing local I can 
get my hands on. For some reason all the serial console logs are not 
available and so I am going to talk to the farm team about fixing that 
because we should at least have serial logs.

Thanks
Jon

-- 
nvpublic

