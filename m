Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28328460;
	Mon, 27 Jan 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737989678; cv=fail; b=pdDBWT81POQMIvE4AsXGivNTyp+Y/C/OxWkHaajCeLfOWuQo+HkOn0FoEyxZmJ6i8elbf4Xo88HerltKMBoVD5PS1SDUUts8GezjKhMBylGBKBGqf/RBl+JG8Vx0/8vc6U9p9R+6F23H1659sWysGp4yLDD+/Uz5QfezgEYqXW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737989678; c=relaxed/simple;
	bh=PSVS5lzQdDpePyhBp5lrnA50s+/1P1JqwI2a4su8DXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B0thXiYpNHPrhDsy6uRGqJBdwPsInKYTFNBvMshckDYlHtLGuBsVbUnRSXTyjl2eML5ATCKFsxsgUuQFiLZyK6D1p368fvfmKcbY7E7GXTlsKBRJrXeTNQ5CQOWx1Q/E2op6h2ZM9vDX0wRhj7XZDNW+s2ibafzLdS0AS2R+Es0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E9kzu505; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E9kzu505"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5JmX/4ww9/Pze/q4cL+kZG6iSt0BHoq5FZYNeW0yP0ZuBQiQmd9veCtZu4a0O/ny+NPXrORRR9cTi2ZhLePh0co2BFsAYHY3Y32RPU9buUjQQyl8DzUrEfStD1WQvyN3/bUY/ICj/HatIXMUw1UWUPiLeg6/aPgeU6tOcY57qjV7D60p5zNaW3TAdEY2OWJbUpZcyLrqodt/P6EuQ5EX2Zrnc/MbDJrWtTP58G5NC8d0ck1Om1ChX6Bu+FZz4L97yJgbngtV2EhR2To7xsknV9PCpAVd48Qf98vD3Tdgbb4B7lD4Bdl4P+U6AdlAru2FDk84Cj6+JlmvhvXmSWcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50sKYEcOwzwbEAa0P7Cd5bZokBEKSFftVRwzSfoA0ls=;
 b=L3fi2Ie7Sse370mNoqCF7ZHOqc1K35x4Pm308NB77bsNUcosTcdBPpjShM1HH6f7XfjiHe5ObWNCCFwqyOTdq76lAr3p4n4uDvvuukKOGNkcL2I7DSSZSBsM8QD8EJYmCnCi2dcEPa+TdTZTQMd61dNDq0PECzd0RXaAI9wj0ISa8O8wHc+pDrIL22VTDXKIFaRkovqNN+VSuBQvK9zNZkMOclozV9Mw0ixhonLgJoeTbgqhDgRYFUnHXBNWNPo1XNrnJLh4tp3T6gzlY1HZEls05ukPwpNzWSsPLW5X12chwXD7Zzc6+wqnaPTW9swjK1m8kX4XM/WxM08LbZyPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50sKYEcOwzwbEAa0P7Cd5bZokBEKSFftVRwzSfoA0ls=;
 b=E9kzu505nfwg1xVMWryIfYnJJXGcEK8/DowFr4b1x0BGJT13l2CP0a9t5I2ITNz3gAsVm5GWsPperckH5upXiKPEDXyWopB6KRvyq7+87tQFbVuFF++i0KHj1NmvE51BG/KugSkVgxGwryw68qeAH+VyeBmb/kSHu3XQcH2bhMOsSGGz48nejHWKUySLlBC9JmmXb7Ki6yVJGNisxwvI9REztQ9pvverh8u4kiY18ruN9VdRF0XZY3BhU79AmSPYd0C+Mn7AnqaWO5f6rxnyMzDxtc6Rwq7vLxXitD1QWYX8Gm9EAi22uQAAv2su20dYaxzzH0NSFfpqlRh5zNrdhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 14:54:33 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 14:54:33 +0000
Message-ID: <3e93c665-7603-4b64-a64c-a29079d8d11f@nvidia.com>
Date: Mon, 27 Jan 2025 14:54:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
To: Thierry Reding <thierry.reding@gmail.com>,
 John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
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
 <96b02b20-a51e-480f-a0ce-3a1457650ca9@nvidia.com>
 <84y0zbyrf0.fsf@jogness.linutronix.de>
 <bee7de35-e767-4c69-94ad-d09c92a3577a@nvidia.com>
 <sx4nrwuzs3vafnbrkgag4dkapll3itvece4k3ylvobvid2vlpk@oncxz3eq33zk>
 <lrpcbufgu7jnvepqkd3sz2qap2th45ndzv4c4vxh7v4zyhep6k@t635s7vbhkgz>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <lrpcbufgu7jnvepqkd3sz2qap2th45ndzv4c4vxh7v4zyhep6k@t635s7vbhkgz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 7525cd84-b562-4fb3-f9e5-08dd3ee2826b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHVBU1orM3R5VTB6Uk5oY2J2UWFDeUFuN3k2eUJCVUhrb2Q4NVYwR2svWlpE?=
 =?utf-8?B?NTA3OWN5YzM5TEt0a2NmYm02VXhPQzZnQW52TkZkNkJTOFV6TkFtTDNPQW9i?=
 =?utf-8?B?U0FNVTBGZHVJMUpWbmlLMWpRcWd2aUtrcVEwSlB4UlplTUswN21PK1NYeWZk?=
 =?utf-8?B?UW1hV1NCZVVFcGtnTHlta1dVdjJMKzBmN1FaSStLQW12aDBFQi9oMXowZE5i?=
 =?utf-8?B?d2s4TVVURXJwSkFiM0NNQ3V2Z1JUUlN3WVN4SlVVUmRFd0F5OUYzYVhibTY2?=
 =?utf-8?B?ZXAxWHpyeUJhVzJROHpuMHZ1T2Z2QlhYcmFxUDVPRDA1YTZNb2cxTERtenly?=
 =?utf-8?B?REo2eUNCS1JyeG5pd0RUQzl1TkVyVjdEd3V5SWZLa29jVnlpbTRib3BiaFB2?=
 =?utf-8?B?VFdidGdtUURmM2hlZXJSRzFIMHl2TDRGT2tiSnFxWmJQR1J2SngvdzJqK1Rm?=
 =?utf-8?B?Ylh4aHhuUFdPWTdJRkI5MHk3VXZrelY3MEltNWdNb0pWc2c1K29QVHRGSU9Q?=
 =?utf-8?B?cGl2THlrYU9ZcXZjKzd6clpBYWl0ZFowUU0vK0JjRHhxZFJMekxlTzM5bW4z?=
 =?utf-8?B?VHQxcHQvUllVbmFWM0VLaElDSWRpQTdLWnB2c1dZd3dndjlXdkxOMXRiN01u?=
 =?utf-8?B?bVhhaTA5MnBtcnhLVmtyYjVNY2lNSUV1TkR0N3dqcCtZeU4xRzhsS2pDb1R0?=
 =?utf-8?B?QndNb29PcWNpYkVabVJ3UE82UUVXbkFoMFpqbTRweFpXMFZ2UWwrODlNcXVD?=
 =?utf-8?B?ZnlOZGRibTNXRy93dGN0OExhSlpza2JhRlFCVzJIc1duV3FwdmVUYmNQZC9M?=
 =?utf-8?B?b1hRVjlRbGxFNHF3OGViZ3B6bUh2L1o0RmM4OFZ0aUw4c3dyWGc4L3YwK2xF?=
 =?utf-8?B?ckdWN3JnUzhSNUYyNEwzZGxwalJWd28xQmNSVk9iYmNZRDV1anNvWUJPcTBP?=
 =?utf-8?B?ZFpBUVFPWm42SmRhMWJiemlaMWRYYm5rMkxXanZ1Q0dRSVlyTGgyU1VFRkUr?=
 =?utf-8?B?alFYMktJNEJnbHhqRFN1anhPZzhEdTZnLzlZTWZ3NmtGSU9sblM4YTBOcWlR?=
 =?utf-8?B?U2JDOTluQkU1NTVpZzYrRDhIZlQ2ZFEvT1NhNnB3R3poejZrMzhzWTFOZjRm?=
 =?utf-8?B?Q0s4bWhDemVzNUROVXVXTGdvV0hBejFOMm8veFI1VmY1S2djcmpLdWhIdnpV?=
 =?utf-8?B?WjE4NUc0OFM2M290MlRDOWY0QlNuYlpGR2tKQVhIOGtqRnZUUVV2anZwV09Y?=
 =?utf-8?B?eFR0cC9RdnJaUUdKTHlEV0VEQnJZNmRFYjEzNWJSZjJwZ0kvemU3aUppQ2JZ?=
 =?utf-8?B?a3BZMjRwdHRqek42dkJ6TjlWL1I3dExjaFJDaG1xYkk0VTJRV1JDWWhuMkhS?=
 =?utf-8?B?Y0N6Ti96TVJyOWR2STNzSmppeE0zcUJKVnFBUlBFc1ZuVWMzYUtHQ1ZhUXFV?=
 =?utf-8?B?bWNyaE9YWTUrbjZ2UnJTaFlyOXNmSlBqVkNNVld4bk5yQXFRSDMrVXYrTytL?=
 =?utf-8?B?TkpuSWpMKzlQR0pFZE1GOWFKUENBbHlEZzRsdTg3TEtKb2t0aXZoVEtYaXda?=
 =?utf-8?B?QVRtZ2pFSStiVUZCb0VvaTVpeCtBMnFZZHNzU1l4KzY2SElab3hKS01jTzhv?=
 =?utf-8?B?WnRNb2dObGwyVU1EanRKN2lYRWJZSXRxc2NTY0NtSDVJOGsya2pyTTFlVnY0?=
 =?utf-8?B?TEo0V1JKMlhjWTJYUEt6ZnpMOEhjYTd3c1JrRngyWnhFSVlHT0FwaXlDZEll?=
 =?utf-8?B?REtzVVZSUjVWWmZXeUtIZnU3dC82MElwaWJ5bjFrbDdsSmpFSmZwc0ZEdjlw?=
 =?utf-8?B?aE9oQ1BpSDJjNVhPcXNjZFEwZjhwN2pLd3FvY3B2eVMrRmtCbnBrZm5aY3Zp?=
 =?utf-8?Q?nLLXqfjuC8cAq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVZSUjJ2amtMcTVQMWY2Qjh5NmNRMk13R0RHY0dUOVR4WUcyT0dBV1pYakpO?=
 =?utf-8?B?Y2lmQ0YwZ1dRMjV3QVBVa2Rmb0NsYk9pRkxUTE1WS1VzbVVQR0NzR0N4ZStV?=
 =?utf-8?B?dFdDMFBJSFlteWt5bXplbDRLSDBMV2dkbDhEUkxlbEZLTkdwNlU5WXRUZ0lv?=
 =?utf-8?B?QVZOcjBhOHQvZlpRSThCSnNqMEQ1UlN5aW1ENlUvdVdzd2ZkTXdzbW5WcUtW?=
 =?utf-8?B?aEVGNlNUU0R3K2hHSEYvQWVYUzZocm9uNHpwaVhXRkNOOVR2dmd6Um90VERu?=
 =?utf-8?B?UlZtc3VwNkFDb1NmYVByTWdUT2ZGZEJUdzV4bFpaQlNEYXU5aGtKamZIM2NV?=
 =?utf-8?B?OXV1QWVoZTgzK0tWOUN2VTRlNDZEN0RHS0ZZdkxrWCs3WG9OL3VrMXlKZk5S?=
 =?utf-8?B?M1poVzlaclZveCs4WVB0WE43WGN5Rzd4amN0Smx3TE9WZjc5Qy9tV2hMQ3FK?=
 =?utf-8?B?Vkt2MTNlb1pIckpUbVQxaEw2N1U0OG12UmprTE5heG93TzREbWJUaUkzUHBx?=
 =?utf-8?B?clpta3RZbkJjOTBWVU92blNjZGpNT0MrcmhrMkJiRkh1cVovYVNJYnFtaUd0?=
 =?utf-8?B?ZVhzSXIzS0gvSmlMRkptSUtmWjEyWndhVnVlSFFqN0duM3pDbjRYZE1lbUwy?=
 =?utf-8?B?UnUzd3YzVkhaRGNCbW1PUVdyTnFlQXJqVXhKWXJidklRSEY0K1ZjSkdhWU0z?=
 =?utf-8?B?TzBOZEFEazZrTmdJZWlrcmN0Y0NONWpEY0lzcVEyMmtsd1BEb0Z3RDdqVElr?=
 =?utf-8?B?ejhXRjM5SmVZaEZvcnFzWGR5UzVtVDNjd04xQzZ5MmJaT1BuSUhjR013Mnp1?=
 =?utf-8?B?dTJVWkx6MGpLTkNNaDJZWXdqWUU0MEk4aHordzJ4bE15d0pVODA0aDZ6S005?=
 =?utf-8?B?WGxUOGdSM2ppYXpMQnRDcUpBTmhSbGZ2T0dqdUZjSjVXeFdHQ0ZjbjF0aXUz?=
 =?utf-8?B?aFg2Z1hiVjYwUmdjUXZZSll4Q0tHQVNXTUJISW9jeU1neE16ZWJjT2xZNEor?=
 =?utf-8?B?cDhoTk5pUzVJUzFzZ0RmKzVLYkxIYUlzSnQ2Z0VNK3JkUnliNlpNQ0NTSXdK?=
 =?utf-8?B?c3Jsam44WTcxcXp1TjV0NjlSYjkzRkY0RlVqNElCTnBCZXowZ0xnSDBUSUJo?=
 =?utf-8?B?clJrY3JJLzNsTnR6dmJaOXJVSEJqRmZSV2s2SjN0ampwK0lwYmRyeWRCbW03?=
 =?utf-8?B?a0g4NFRDM2MvM2FYeGRzdzl6WXpWZ3RkRFcrZjJhS0tKNWZralk4bTR2Z3VY?=
 =?utf-8?B?QWlaWkd5dy9KeWM5dGpudS9CZ0xBVGxyVXg5Y3ZmM0M4RVpCTHBobzhYV29W?=
 =?utf-8?B?bU9WeU92cnhjTDNiVEt2bEpCOWFCRG1nb043czlDZS9QQTgxcmtvUGk3TklB?=
 =?utf-8?B?VkhLQU5DSzBvN0MwZzVlWXRyMm1LbHkveklFZkJJMi92L3NWOTF1dVJKQXJv?=
 =?utf-8?B?ZlBRYzY2dDhVLzZVVEFabUlpMXJoQW5zV09UY2pwVWQ2M2JCWkZ2UFh6V1kx?=
 =?utf-8?B?ZVlta2huYlluWnI2M1B6MEpuKzgycDE1MVlZc1VXK1NHZCtrdWNjbERTMGZE?=
 =?utf-8?B?VlhSd2h3WlhKT3RhTkphdTZnRVJFSTA2a2JIcWVyTFE3QWVsRS8zcFRMZ0lW?=
 =?utf-8?B?RVpXVHF5L2pBV3Y1dEFqLzFtTEI3WHlUOXpDMmQyOU02Q05IZ2xPTU1wZXpE?=
 =?utf-8?B?dkxXcHJyZVRZTEI1cm5SNmI0WjZSWkQzaUF3K1hYSXFVZGFISExwaGpLY2pa?=
 =?utf-8?B?OWpIQWlmREt0ZUR1Z21BdjBFUXRUazZkUWpabHBQTXFEM0llemV0a0d3YXZv?=
 =?utf-8?B?WHRHeGNtL01WSGxKUlNTZk5sSGREdHo3czh4M0tQdkxMZzNMMlp3a2t5Rlhm?=
 =?utf-8?B?NjlIdDd5TXlDd2ZYZitSM21GNTlXRXZ3VEVISkJjblR1RjB4ZlBrWVRzK2V5?=
 =?utf-8?B?UFVrVFBLdU9SZGw3RCtxOWhmRzRqYWV6T3FNSy9iWjhrN2tGWHhKcXdoU0VE?=
 =?utf-8?B?VUtQMFlnVTIrYm5kU1RDemJHRFJOcXY0TWhVMjhCbnBxRmY1YXBBK1JpQUQ2?=
 =?utf-8?B?T0QzdHo5WTBxUEdWQ2FvanBRVVF6T2l0UmtVMFNid1NEMGljYzA0Y1dwZTl4?=
 =?utf-8?B?U1BqV3BUVEczeTdNSnhoMm9nNlhZd2QzcklCRmZGMEJkV3pEcHNhbjFSYTI4?=
 =?utf-8?Q?Spe5ANUT4IAgKTNcigdHZ9+zWjcl55vceLOmw8iBs36S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7525cd84-b562-4fb3-f9e5-08dd3ee2826b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 14:54:33.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tsiJ+hAtCACltLeSS2cYpdQwqhUw1svbI7TpyksMReqeMxEfiPSxDIoXbujpsk8ei+4dtWisi3QIsWoBYWiwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

Hi John,

On 20/01/2025 16:34, Thierry Reding wrote:
> On Mon, Jan 20, 2025 at 05:23:26PM +0100, Thierry Reding wrote:
>> On Thu, Jan 16, 2025 at 10:41:08AM +0000, Jon Hunter wrote:
>>>
>>> On 16/01/2025 10:38, John Ogness wrote:
>>>> On 2025-01-16, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>>> Do you at least know if it is failing to suspend or failing to resume
>>>>>> (based on power consumption)?
>>>>>
>>>>>
>>>>> Unfortunately, I don't. These are farm boards and so nothing local I can
>>>>> get my hands on. For some reason all the serial console logs are not
>>>>> available and so I am going to talk to the farm team about fixing that
>>>>> because we should at least have serial logs.
>>>>
>>>> Can you confirm that the board is actually booting? The suspend code for
>>>> 8250_tegra.c is quite simple. I am wondering if the farm tests are
>>>> failing somewhere else, such as the atomic printing during early boot.
>>>
>>>
>>> Yes they are all booting fine. I have an independent boot test and that is
>>> passing. It is just the suspend test that is failing.
>>
>> I was able to capture logs, but unfortunately they don't provide much
>> insight either. On the first try it doesn't suspend and goes back to
>> userspace after a second or so:
>>
>> --- >8 ---
>> -sh-5.1# rtcwake --device /dev/rtc1 --mode mem --seconds 5
>> rtcwake: assuming RTC uses UTC ...
>> rtcwake: wakeup from "mem" using /dev/rtc1 at Thu Jan  1 00:01:00 1970
>> [   36.332486] PM: suspend entry (deep)
>> [   36.332832] Filesystems sync: 0.000 seconds
>> [   36.369331] +1.8V_RUN_CAM: disabling
>> [   36.373884] +2.8V_RUN_CAM: disabling
>> [   36.375571] +1.2V_RUN_CAM_FRONT: disabling
>> [   36.380359] +1.05V_RUN_CAM_REAR: disabling
>> [   36.387399] +3.3V_RUN_TOUCH: disabling
>> [   36.390808] +2.8V_RUN_CAM_AF: disabling
>> [   36.393621] +1.8V_RUN_VPP_FUSE: disabling
>> [   36.408218] Freezing user space processes
>> [   36.413660] Freezing user space processes completed (elapsed 0.005 seconds)
>> [   36.413680] OOM killer disabled.
>> [   36.413693] Freezing remaining freezable tasks
>> [   36.415033] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
>> [   36.428474] drm drm: [drm:drm_client_dev_suspend] fbdev: ret=0
>> [   36.428527] drm drm: [drm:drm_atomic_state_init] Allocated atomic state 2e5cd010
>> [   36.428547] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:47:crtc-0] 6a6be0ef state to 2e5cd010
>> [   36.428561] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:63:crtc-1] 00d818c2 state to 2e5cd010
>> [   36.428574] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:32:plane-0] 4e145b7d state to 2e5cd010
>> [   36.428587] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:36:plane-1] dbf67d12 state to 2e5cd010
>> [   36.428597] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:40:plane-2] 763d8809 state to 2e5cd010
>> [   36.428608] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:44:plane-3] b6eabcf1 state to 2e5cd010
>> [   36.428617] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:48:plane-4] 7863878c state to 2e5cd010
>> [   36.428628] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:52:plane-5] 54b8029c state to 2e5cd010
>> [   36.428638] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:56:plane-6] 364063af state to 2e5cd010
>> [   36.428648] drm drm: [drm:drm_atomic_get_plane_state] Added [PLANE:60:plane-7] e1c11dfb state to 2e5cd010
>> [   36.428662] drm drm: [drm:drm_atomic_get_connector_state] Added [CONNECTOR:65:HDMI-A-1] 5cb32770 state to 2e5cd010
>> [   36.428674] drm drm: [drm:drm_atomic_state_init] Allocated atomic state 832943c7
>> [   36.428682] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:47:crtc-0] f09cf73d state to 832943c7
>> [   36.428691] drm drm: [drm:drm_atomic_add_affected_planes] Adding all current planes for [CRTC:47:crtc-0] to 832943c7
>> [   36.428700] drm drm: [drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:47:crtc-0] to 832943c7
>> [   36.428711] drm drm: [drm:drm_atomic_get_crtc_state] Added [CRTC:63:crtc-1] 2700922c state to 832943c7
>> [   36.428720] drm drm: [drm:drm_atomic_add_affected_planes] Adding all current planes for [CRTC:63:crtc-1] to 832943c7
>> [   36.428727] drm drm: [drm:drm_atomic_add_affected_connectors] Adding all current connectors for [CRTC:63:crtc-1] to 832943c7
>> [   36.428737] drm drm: [drm:drm_atomic_check_only] checking 832943c7
>> [   36.428759] drm drm: [drm:drm_atomic_commit] committing 832943c7
>> [   36.428881] drm drm: [drm:drm_atomic_state_default_clear] Clearing atomic state 832943c7
>> [   36.428897] drm drm: [drm:__drm_atomic_state_free] Freeing atomic state 832943c7
>> [   36.429085] r8169 0000:01:00.0 eth0: Link is Down
>> [   36.713236] Disabling non-boot CPUs ...
>> -sh-5.1#
>> --- >8 ---
>>
>> A second attempt soft-hangs:
>>
>> --- >8 ---
>> -sh-5.1# rtcwake --device /dev/rtc1 --mode mem --seconds 5
>> rtcwake: assuming RTC uses UTC ...
>> rtcwake: wakeup from "mem" using /dev/rtc1 at Thu Jan  1 00:01:10 1970
>> --- >8 ---
>>
>> Where "soft-hang" means it doesn't do anything after this and I can't
>> SIGINT out of it or anything. However, the serial seems to still be
>> responsive.
> 
> To clarify, this was on top of next-20250120 and reverting the patches
> that Jon mentioned suspend/resume is fixed for me as well.
> 
> I do have a local device that I can test on, so if there's any patches
> you want me to try, or any options to enable to get more information,
> please let me know.


Any feedback on this? Our boards are still broken with this change.

Thanks!
Jon

-- 
nvpublic

