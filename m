Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BC33DB;
	Wed, 15 Jan 2025 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958099; cv=fail; b=FVGeHgju4Ko0gde1EEpE8hTQ559EGZkVmqXXAMZNqXqnN24pLVEpOPqJ191adkGNAdsOQBVq97rhwIHyFcKfe6eghxpowYBETUW6tetJBXoyE/5VvgVCiRtWruIEc2eBhoAvkAA+PoKsw17AYkV0nHo4fM+F8/ZJJw9Jg24MVnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958099; c=relaxed/simple;
	bh=OuQUS+WFvpCDSAWO2Z13F/BRGCl96SxEtWdHb3iUtao=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IXnVvybiloXaGvWp6tmvn+/gmPqzBQGgIeqpVo4/mxHS3uIxwdyVd5qmXYiwZI/aJpoeTn/XgDCoOx4DIJKuu8PV7egN52bq/ySl0C5e50vWPs0XKF4l4hVmM6pOnA4Bps/MvIdOoBOVdsCBusu7esIJcRIv5nr2WO171yboAPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S0oDyJoF; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S0oDyJoF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMV4v7SMzQKniIOqYLHaKZluXOfgUPmqNLVqSHAhaPMCvsktnUyqgLCmdXJ5dNqK7CMs2xrsafDda1Zide3GPVOeShvrbgsmdbNbo3fuSv9kZXqTWHCDbCmWwUxL/KeH56jWQaZ8vVCX8q/zxQtegLnFq15kuTpzWYNU49NH+52uWcEZOE8Is+U6IViBHKGsiMlXcJgE9WdWX818xXvDNE+53daQpeNwMNpNy1qaxwlpVRPjCbB5/hjFQl+SvhIgZ2QWWVLEEYI7cCznJMCmH4S2smtNHGwu5dK0EYAPIGFMSLqCyl6e5OkCXkDf3G2NNJPinaeKHOX707qNcAF5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVu0taWgMTUaVMeFQVCv72W0JmMIVpczBDFWseiykPk=;
 b=MdavMJRvVdzyeSGaE+tvUgW72S3ycfgcg0EK40egTty5apFoAddkrfR1tAogXqJaiYPtujYq0UbB7obz5iXLErPPvlpI6+Lv8ttLcqSSD4JWdeen/LTZd4HQXLPePc3adPjHrQXDEq7nwAY98ebvbxCCSJveRTHQuoymaipfGoCiCi/cYMEmRv6UKPxLSrraF4LF7SA3waDFz8O5PKEf5QMVjMxmKiK6nn5JxwzWNYLwoUAD5KqZ5r6KMeYpOhxEM0UQGrsW7VyWxej00ZU4L9tVBMmrioeeDYvEdXu3gTJJ7r1IbAdf/SVa2QoxRHOf5R3llPmIZ5fwTutXg6zdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVu0taWgMTUaVMeFQVCv72W0JmMIVpczBDFWseiykPk=;
 b=S0oDyJoF5HsF9lJz6U6bu9zOgLixtZ4AqtkaF6EY4J/0NRNCalcSNn6IwjyNCUV/QAu+FFAr/Ry1EaRFmGXlJch1Dkka2uxpTXigu3Eag366YjvhRlu0Ak92V1lyDqmanTvkpaCM8dXtcAXQHO/XFWOB6BFaHVZWvm5xobMPkL4ELqXol0da4NT5xk6QBvm9xR79eKrukVj/ByeTN8sNU+NIlLTmbaXtCKwk4gy+vo+xH2fM34hMVST3daakPZgrm80dKuGiq7OY7NdPUB8SUsQ0/huibj4pBe1h621RwXnzmgyGjtazdAS0de2S9RKz982480eqUGBAhIl4AmO/wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Wed, 15 Jan
 2025 16:21:35 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 16:21:35 +0000
Message-ID: <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
Date: Wed, 15 Jan 2025 16:21:28 +0000
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
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250107212702.169493-6-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::33) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb5eeb8-9439-402e-2d06-08dd3580adf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z09DUXJoOEJGdnRGZFVidUZJSnhQSW1PeVFIa2RId0NVTTd2ejl0VStacHZX?=
 =?utf-8?B?VmJjTG5BTFRRWmwzUzBucTUzV2I5cXBWemIrUDhnTlZzODBtT1VyRzZnYW05?=
 =?utf-8?B?NlVkUnozRUJ2MG9aczRHTmVkSjZjK0dCV3BZbWh4WTJkSk1RMThqWDhsbnNI?=
 =?utf-8?B?N2NKYXd2ZURCUmpIb1ZtN2Jlb3dwaitMVCtPVWU1NU1HNFRqdXU0eXZzOFNZ?=
 =?utf-8?B?cldybW40S1BCUGRTZldjdXQwOW1kaHdsbkwwNmxLcG5sYzNwQzRjNXpoZDdj?=
 =?utf-8?B?MDh6aXhvVVEwbUFpWW5qTW84NFRiNk0zcUt5c0UxSlJ4OHBtNDVCdk5DQll3?=
 =?utf-8?B?VXArZEhDL2I2WFRZdXdlMWNiWG8vQTNjSzd2SVJFRi9IQUswQ2g1TGlRYmJI?=
 =?utf-8?B?cS9XRlc3cElUdE0vSFNNdUlpdmloTGREUlF0emcrMFRsQkV3VmZONHFhRGtJ?=
 =?utf-8?B?T01PVlROTnVuczRiRWw1U0dEcTJNdk5SeHlTOCtnZkw3YjlYZ0lpcjhCUElQ?=
 =?utf-8?B?NUMwd2pmVnFFcm5nVmI2N3Z2YkJ6SFRTb243MVFTci9xYnFYYjhHYTdYcEZR?=
 =?utf-8?B?NVh0RVFOTWxYS0Z5TjdQeU5aMmc0NTZ1b3JhbkgyWDVZaDArN2pZa2wzTjZT?=
 =?utf-8?B?NDdaYTJLOGJLT0tUbjk2ckZuVzZ3QlRacC9oRHBBdEZxZkt2RjNoK2hPbzlK?=
 =?utf-8?B?cUVOdzF5eWFaKzFoZTRiM25wdXpkdnA3QkNTbVRrZGlXZ0NodTcxcEpMMHFK?=
 =?utf-8?B?b2d6MDRxM3hHNjFoZlFBS2Q0bkdqZUdTQ05qWXhHenFjQXFHcjBoaGtmb1Qy?=
 =?utf-8?B?ZHZZOHM5RG5rTjN4bHVnVGpheEp0eFZhaFlkM1BsQUV5elpLcGgraHdWcnds?=
 =?utf-8?B?Zm1BUXplY2xiL0V1cnpEakdnWkJDTU03ZHBIMGNoYlJZM3NqWkRWa2U2dVZy?=
 =?utf-8?B?UHdpNzgwYXJOUGZDRnFWcE5qVEdaQmUvUlhyVWM5cSs2dk1qUDhzWWVZdkU3?=
 =?utf-8?B?aHJDRU9pd1N5T2JMdm14eU5rVmJFSnowK2ZwNFNMS1BGMjRMWC9UWlAvSURR?=
 =?utf-8?B?RHN6NWRVekZKUjJ1Y3M1MXhXVGhVVkFWWTgxTVJYb2I2RU9waW9DSVVjcDh1?=
 =?utf-8?B?Y1BmSktZZGJwcWxrY0VjblAxWDdMVlpNTE5ZNld1aS95aGduZzViaHFRYURz?=
 =?utf-8?B?cTRHMjZpcEc1R2ZZYndudDlwQmVPK05ldGZicjVKbGFNWFZ5ZnJYM3ZUNWh5?=
 =?utf-8?B?Z09uMHRhZi9HNUJITUI1SjVXWERBUlNsdWFZVWpTcHBlNWsrb051MW5pVWxw?=
 =?utf-8?B?YUFDbk5pc0YyQkF0U1RLMWR6QWNCWnpwL29LeVB1N2dGN1ZCREQ5M01xNy9Y?=
 =?utf-8?B?K0pzZjZvTFhYb04rbkFYTEg1RHpaYU05RmlJOHlXV3JLV2c0aDAzQmRhbXlh?=
 =?utf-8?B?QzBQb1EzOGdjVm90bHZrS1NJcHRsVWZreUNyWjZiQVRzSTdOMU1rRk11bWRl?=
 =?utf-8?B?eTVjZVkveU51TGgrZHJXUVpGZUpicDVYOFhQTExmTU1aekhSL21ESTYwdTBV?=
 =?utf-8?B?Z3BsaG80ZjBHY1pXY1ZzY1NKeURZZjZSWWFlQmI1ZWs5ajNhL2dlSFRsRXhH?=
 =?utf-8?B?S2dLMEJDWXJxd1FSa2RhZ2hTeUFjbGJwdzF6THhZWlZJZTR4eEVrdzVTa0dv?=
 =?utf-8?B?UkhXcVh1SmVIb1ptWGNDYlJuNjM5dXhZM2p0WGlwQ3oxV2VGMDdiSFBtenJl?=
 =?utf-8?B?THlXTTd2YTQyemFDcDM3a2V2MHhzS1prVlduSWZxeWQrT0NXeVRIa3BmdGEv?=
 =?utf-8?B?ZWwxUktnZEw2RGFwZHZWalhKdUF1bnhNVXEvMUpXaFRQVzdsb0REVWpyWGhz?=
 =?utf-8?Q?AXn4sS7OUcUx8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmtwZkpxTlIrd0s4UVVEZmovaTBkZVJmdnk4TmZtc054WDRQSExCNC82V1d6?=
 =?utf-8?B?eVpOZU91Vkw0OXN5Vy9EVUlGSTRGcStQaHlxQmdQVFVoQnZycDZLanhHc2di?=
 =?utf-8?B?MWVBUEZ2SVExNy84eEwwUmRHTVZtRDcyYVl3U3RFN3NuSk5BMTZZeGdKWWh5?=
 =?utf-8?B?RGJibHpYS3pTS3JHRlJmRmQwZnROSTA3eGllUVhQYXV2YnpmSldkbTZmWG9L?=
 =?utf-8?B?YnNxcDBUWGFNb3BSSGlQZXA5ZTRRRCtaMVlEbmUyMmE5WVJQbU01eC9wbGhk?=
 =?utf-8?B?WEliK2VKZmF1cjZJVks1OGV2eHNPaER1UkJnTjNOMGNSZkp6akpoam1mVkZL?=
 =?utf-8?B?WnhjeldFcEwxVTFBblJPenljTXFMSE9zdElCTkJhMnc5OWt6ek1CcWpDcHc5?=
 =?utf-8?B?WU9SdXMyUzJ6ajl1cGRvUzdVeU1GQTE3MUJtdlFyS0NKSFZLVmVxRjdYbStV?=
 =?utf-8?B?YU5zRzlGSW8rdUowdHM4bDVLeTVoVmtKSTM2YW55dkJDaDZlbzBYbDJmSTVF?=
 =?utf-8?B?QkpjQTNYeWJtQ3B2SWZDUmhBM01oazJ3OFozR3FiVzFHOUsyak91Mmo1amU0?=
 =?utf-8?B?TlJYRGJqNTdCemJEc0tFQWdXUllIbGtJa3pRNXJGQ0laaXp2R1JVQmRqWHUy?=
 =?utf-8?B?eWtGQklza2xHUk9zSk9jNkdXdGJsY1VHRkpGcU5VTVJpZ1R0K2c4NmlnUzdP?=
 =?utf-8?B?UGRGbmdRTTI2ZmthOUR3emNWMTFNVDdBQ2xKdnB1eVEzUVFoK0NYcUNTNUxF?=
 =?utf-8?B?L3FvenhUeG9DcmpCNmdKNjd5ci85MlFwVWNoaVlNZ2lDcGFhZkFZZXhMSHZ0?=
 =?utf-8?B?V25SWkhrZ0EzcVAxSEZDL3dOMUgwTXQzRDRUdCtPQzF1bDJFUU5UREhpSnJ2?=
 =?utf-8?B?cU10am5iZnRmcHJCVUFrNjcwR3VzSUtScDd1ejhzRmcwZG9aNGJXcml6eTN0?=
 =?utf-8?B?d3pyRnIwdTJWSFRHU1ljeFR1U0x1Z1dTVW9NcDVQMy9pdDJsWW9NaG10S1ZN?=
 =?utf-8?B?YUFOT2NUcnlvRXVPS28xUFRBSjU3WGdNVWdhcWhxY0ZuWHN5b1JHYVY3T2NM?=
 =?utf-8?B?bXI5eWlNZm1Sc1BCVllVOE9zZkM4ViswbEVJd1JNZVJYSFU3N0JtVXVFTUJu?=
 =?utf-8?B?dXQxZU0vY1p6NVhMTzliMzJndDA5OTA1WXp0SGd5c050M1BRYkk1UlJPUGEr?=
 =?utf-8?B?RU44bERqRUdPaGw4V3lVMEdkOEI1SS9TYnJ0c2Y1eW1scWNhL2Y4VnQ2cXFa?=
 =?utf-8?B?c2dZSTFBRzZKWllpeHNTK0pVRm9vek05KzFWMjVLK2pXVk0wWXRwWEl4TnRD?=
 =?utf-8?B?ZG5TTzFmamg1OHlDaGc3WFptQ0NOWWRHNDVxQVVMWGJRQ1dwK0hJMUZQWGFV?=
 =?utf-8?B?K0tLaFFINUo2YW9oNjdRVm1Pd25jNlZLWkpLSGFrdXFFUmZDdmRxVHg0cHB2?=
 =?utf-8?B?aG56cUJtRXR2RGZzTXFBNmdwbkl2T0hkWmZRMTRGTkFXQVM5aUQ5WGxhL3hs?=
 =?utf-8?B?cm81bklId3V6K1ZKRUIvSzQwbS9sTFE5MjJ4RUlFUjVYbmhKZXkxenNTWGlJ?=
 =?utf-8?B?OGs3bTJiOVNnc1Uyd3Y3UWVqRFdnUld2NGJ1bjlNNWJDR1lBaytBVnMxZnla?=
 =?utf-8?B?ZmhYQW9QUnRhRlFlOTlVK2VkWkYxNFhMUHNzL3NxdmgrLzk5ZGR5K1d3MERq?=
 =?utf-8?B?NW5sSm8zTWw2YnVkWUtzVXk3MWIvWkZEaXdtWUdOOWdCQVZHZGpTK2dIU1Bq?=
 =?utf-8?B?TnJKT3Q1MFpZNCsydU5NMkd3Ni9YWkJuOFhkQ1ZvdVZ6ZUUydERYMGNNOHdo?=
 =?utf-8?B?bG44RHZhNEdlcmlZd2E0d0RhTVZKckhJMDNrb1B4dkh0ZmFMWlVlZXJNYW92?=
 =?utf-8?B?T1NrMmZGQm5iWVE5ajRGQWJuK2wwRnpuV2lpTDdCbGRwenVzQUNYRXprZ2s2?=
 =?utf-8?B?bDFYUTdNQm00ZkZWZGJRbjMzT1NnUzBGdy8xczJhTnZvdlJHdWhLMldGOUl3?=
 =?utf-8?B?Y2kxQW5MQ0JDSDZNT1BzR1QxVnpSWGY4U1VGdEJzZnhLNzFvL28va3FkdmFT?=
 =?utf-8?B?ME1tRG1MaGdna0FZd1RDVitnSHc0OTBtSE01cVJNWThOVFBJWW5UN0VnQmtK?=
 =?utf-8?B?ZDMzMHpGL0tReFc5bG03eUlIL2poeE9CaDFzMnhLTzhXaFFkZlRTREwxaS8w?=
 =?utf-8?Q?60JEfeWsG9IDKkbcOz+h6Ohg6yy5it4Dj8zMIygcNwNz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb5eeb8-9439-402e-2d06-08dd3580adf8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:21:35.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sH9IqTAXnJcbQLgUx2RA12TwWi1F97PHlhtsz9j7LH60bFbbqocKlO2Ud5Mkg0DGRfgHSskVRjTbYy2daBosHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

Hi John,

On 07/01/2025 21:27, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks:
> 
>    ->write_atomic()
>    ->write_thread()
>    ->device_lock()
>    ->device_unlock()
> 
> and add CON_NBCON to the initial @flags.
> 
> All register access in the callbacks are within unsafe sections.
> The ->write_atomic() and ->write_thread() callbacks allow safe
> handover/takeover per byte and add a preceding newline if they
> take over from another context mid-line.
> 
> For the ->write_atomic() callback, a new irq_work is used to defer
> modem control since it may be called from a context that does not
> allow waking up tasks.
> 
> Note: A new __serial8250_clear_IER() is introduced for direct
> clearing of UART_IER. This will allow to restore the lockdep
> check to serial8250_clear_IER() in a follow-up commit.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>


I have noticed a suspend regression on -next for some of our 32-bit 
Tegra (ARM) devices (Tegra20, Tegra30 and Tegra124). Bisect is pointing 
to this commit and reverting this on top of -next (along with reverting 
"serial: 8250: Revert "drop lockdep annotation from 
serial8250_clear_IER()") fixes the issue. So far I have not dug in any 
further. Unfortunately, I don't have any logs to see if there is some 
crash or something happening but I will see if there is any more info I 
can get.

Thanks
Jon

-- 
nvpublic

