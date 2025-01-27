Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89A5672;
	Mon, 27 Jan 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994436; cv=fail; b=jkZ0Hf9PJ23KqEXzBuwTT8mZDzELPaHEp6yW2jl5aRaQmp1uV5Y7Xi3W0JJrbF283ojBQkFZH55/0jctPZDOOlqYdOuQuLfdwYkhn+0NB5ldoc1Em2GkPcK1iV0vXKYAK95iwGehiiH0G9RwcmuyOFYotffNEb2Nw6LOQwQcxAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994436; c=relaxed/simple;
	bh=kXVBTxKzTxSDI/pAM28nU2H/ECv0GeR70ezhDDbQFkE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lfhsX/pND+6muUaiwmLZLkIv7ZMXFsneCzY9kTWOcBWYDkBxdKAbtER1EftEHJHZ3nvBATIuE+qxl3KC4MTHFkl1+1ibxcrXdG9hh2sP33BJfHuNxNaR0iYWBOaIZji2CcccJyNsxLLFJfm46Ydmy0Gn3/io5fRH3DpU94PJIV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dWJYhwO2; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dWJYhwO2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLjjoAA15XwjQd94rEwU3uciGK5flN9sIdIWbtMNbOlzyS8Dnf64mOrT10C//KPF0Io0EHxKSg0ExWtVbnHPvS0ni0JA6Lz8tFXpUdcWBbDK9e88LgmMvOSviobs3sYCLe6xjRrK5LUJDrYdHurCCcGoTR0JVmdp58NeLf4esF7Kl0vo/Yoff2/q8s7jUe1IaV48zeOsQD/0S8/K5us2QBvfvJZJwmbSk7CBOP/FrGAIIT6bDg7RN/Eo8mxT9NXDq6C9dAJrJLrL260Q25tVzTBlWWap2MZx19YrQ+9DTloM6LWkZgO06bAd2igX03zaZWdf+qoPCFXmpRIeOmW25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Kmeep/2etfXfWEEhhOM3KPrW18LMVa5OZiPaY6/FcY=;
 b=NPhTBWkfnwYj13Mf0r8/rptjbX93g6ZKH4G9sa3slZhwK2DWCIz/Z8m0cJU5GRFmZ5BfpWTdQXg2S/AudjWsWmMg6F6XayzVfhl6jMRiwwbzyz6m4oWiAwUCc3kuJHURVx+70LIe+ZfwV3a8aPNOv+6YRoyjLhJwyGhZIWjy6HK0owl+1rmH13DRp0Qai17FXGhVgK7uU1V5mxf53ef6RkVs7zZVuRFVlP53ozmaJoMPj4tbzS3cKgBoqG1pUCyRPBuB7yi7puXDDSixSoB1KvZxzPLHuYX4RiXxLpuvfhlcsYhIb8mLYVCcX/jBs/SefC1caL0DeFDXI4GBkHbmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kmeep/2etfXfWEEhhOM3KPrW18LMVa5OZiPaY6/FcY=;
 b=dWJYhwO2xEc06NTjw/N6/VVfoJk4m7YJGcufX1CT9wc4QkrPxg/qlxsJdYjrD8kjrCrKVTYG67lUyob4wbv7o/Qq+JKJ65W/tEhTrZsuWWtuGMxpbfrPm+7HN1iOUEfYzfD30QETE3aJSz9QHooQataJx2YMQ/FFL2//9dIuRXavzOoiG/8cOPycUM1MtE7CRAz14INOYdVZc2zwn0pKUs8sV5ciXgqNTFOBvDIQMkUQNInL7qG0YB1yy2b9Wd5/WPF9dART4mz8tthUT4aZ/36w4X0EPafK6DER5cWr7Q3IidNuNuQ014oIAQrXGts8uTHN+ojYHoCpdxsccrF3Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 16:13:44 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 16:13:44 +0000
Message-ID: <997302dc-8d1b-4464-a7e0-7d8c9c9620b1@nvidia.com>
Date: Mon, 27 Jan 2025 16:13:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
To: John Ogness <john.ogness@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>
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
 <3e93c665-7603-4b64-a64c-a29079d8d11f@nvidia.com>
 <841pwo7065.fsf@jogness.linutronix.de>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <841pwo7065.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0483.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::20) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f9820bd-199f-4e91-a7a0-08dd3eed924d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDJrQnJCbFEwQ0w0bGRLVURNUDBxSVZhTmRpRTZTOUswcGppM3VCWS8zbWxV?=
 =?utf-8?B?cm1NKzRMb1NjNk5uc1Bzb2RYaGJwWFFvNDVaZVZueFBRTWtCYkU4UVhxR0l5?=
 =?utf-8?B?aWZPV2hJU2ZEMnplWUZrMUxZVENEWHN4bGhqRzI2OFZ2TzBWWDNuM2tSaEV4?=
 =?utf-8?B?dVg0RnBROHZ0L21HRXNwNVVuVThVZHFOdnhYeEtYMVJjbDVtbU1XL21Fa2F6?=
 =?utf-8?B?RVpHTE9EL1VBUmxMNFVORitKKzVTN3pLVXVJb1BhN3A2R2hoOERCdi9qV0ZI?=
 =?utf-8?B?U3pCREJaWGFqS2JhU0I3UFcrKzRwZG5ucktuMVE1Q21jNi9ka0tJeHZFV0w0?=
 =?utf-8?B?ZkltZUQ0R3pvS1VLalBuL2VackQrejBGdlB3YU4xWDFmV0xCcHFkRHNRUlJx?=
 =?utf-8?B?V2ZiaDIwbzFVNzVNM2RZa2lTODMrSWdUOWJJMlppNXpPanFBYS8rcFVXR3pm?=
 =?utf-8?B?ZmJ4UHJ3THUzUmFzdjV6bE93UVdObFpOSzdBaXU5VCsrQmRDU0tTeDFESFFa?=
 =?utf-8?B?eEVlblI5Z2xSL3RDRmpScFhxV09ELzlOSGxmWG9XS1B5RWF5S2FabTlDa1gv?=
 =?utf-8?B?OFpXRDlzd0dLMDVvY25tcXVzQm9wcDJ4VENUVVFKNjFyK1BKREtvUitWRk9i?=
 =?utf-8?B?RFdvQncyVlFYU0t5V1pORXZNVnpFMFJVdXBrbkNDeTIvOHBGM2NETU1aSzRU?=
 =?utf-8?B?bHRTTU1BclE0YnF2S1VmR25ZT1Zad245a2ZkYmlibXd4YmhXNVVzWFp4ZHU3?=
 =?utf-8?B?RHIzQnpDVkVkZ2ltK3h4N0hSWkQ4S2pVTnl6TzF4ZVNsZjF2M2J3dUZRN2ZB?=
 =?utf-8?B?WENrSE8vVHRlcmR5UHVTMnpNbUM2eFZaemRpSDBGRzBXOHNya25rR0xGMDRR?=
 =?utf-8?B?a05YemJldGhTanM4ay9vMExudW5XZHdLY1JubFVHaENad0U0QkRhT0NGOUxs?=
 =?utf-8?B?QzhRbDRSaEtnN0FkYzNtZ3lscElYNG5sWTdJekNFZEJpckJVM28zWFlJMXpI?=
 =?utf-8?B?eCtTZVRmOFh2Y3p6by93dnVUVDFtYjkzM2FBNWp0ZEQvZUk2RkVnVUIrVHpC?=
 =?utf-8?B?WU9TZFRvYTl4aTBNZmxMUWNIaXcyUE12VXZhRFZLK0J6aXlwQnhkSGIwbUZm?=
 =?utf-8?B?UjZLMVBXZWFBMGYrVWJsOVlNQndvcm9qYXA1ZldwZVFZZnFSMC80ZkhNVVNR?=
 =?utf-8?B?cFY4aXZTVGkwQWlIU0wzQkszMVJvNEg1VGt2NVp5eTgvMjVDQmFjQXppVlkz?=
 =?utf-8?B?Z0xKd1lPekUxRjJtZDNpR1RSU2RyQ0R3NndPVjMxYWhmaC93RDhiOHI3dm13?=
 =?utf-8?B?aEY4NHVKRkdyODJPK0dxQ0psVURGWVVTT1J6L0tQT2lBZ1BYdHZwQW1wUG1R?=
 =?utf-8?B?dW5udXBIR2hOblY3SmhNNG02YXgvS3RRa21DZG9WRnhVaTZEVG40dDA4dXBL?=
 =?utf-8?B?ZnkzUHk0Zkxib05lUjlxbUZwcWJGNTUxQkg0TURHcUswSGx4SXZqdVVRNWgz?=
 =?utf-8?B?NTNOT1F1OHlJd2FuTW8vd2J4YTllQVJMTUcvZHFpR3lXTVJwVzVjNkdiSzJE?=
 =?utf-8?B?dzVMaTkzNkNYQlVyYUtGS1dCZjk0UTcrWFZIY3ZzKzhwVUxFaXJWTDJXaVQz?=
 =?utf-8?B?RmE1dUVtcjk2L0hUeHo1TnRQbDJYa2JFMStpS05VSjFGSmtuTTZLaytnMW9K?=
 =?utf-8?B?cW9PZTd4cWQyM2lPeUZ1eHdyRS9XNXhKUEF1ck40MCtUeSs1clFFbndrSVBL?=
 =?utf-8?B?U0grTWQ5MUh3WVduM1JuZ3NkOGtUWGRZVHVOZVNQa0crUklTNE8zRW13K2VF?=
 =?utf-8?B?eDNFeEg3L3ZRWlNiYWJoTVVaci8zVWlPT1hzekFZQXB2b01FdnVVZTM5bm9t?=
 =?utf-8?Q?/Y28AFkkT1O9/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWx1bGVJWEdQR1RFUnZxaXlicUk3VDRUVWtJd1JXUWVtMXhoNzh0QzUrZlB3?=
 =?utf-8?B?Z1ZzSHo3THdRQk1HMzY1Tk1qSlpkK2I5ZzJEZG9YN0tXNTdpM0JvK2tpMXRJ?=
 =?utf-8?B?VXU5SG1pRDliZGk1dUhZUDZrTEVyU0U1ZVJaUTAyQ1dNVW1XdWdaaUkyS2hL?=
 =?utf-8?B?UHBORkRsYzJrSndXa0xnR1E4azY0aFRKeUY4OGpmUjlhbVlGaTl2NHFkUEo0?=
 =?utf-8?B?ZXpwamZCbFN3RUtKZjR1VG14VEhBZk9EemN6bElOQXZ1Qmg2YldySCtOOTRY?=
 =?utf-8?B?am55T2tjdjVHYTI3Uy9Qc29DVHdpMFUwUzZTSkhtdjJUMk8xMkFud01wY3hJ?=
 =?utf-8?B?VGYyb3pQdHpuN0lMZjN6VFBHMmw2VURycHFHYnRUTVEyNWZUWm9CVGpHTzFN?=
 =?utf-8?B?TkFyV010WmZURyszakxHSU1TVGhMZmJpZmhaUHN2Mmtjdk5IOG5pL3o2aW1I?=
 =?utf-8?B?YlZNNU50ZGxaZzdFaEY0OUpKUGxpbzdCeENkSkhWaFp5WkJJTkowaTNCZXdR?=
 =?utf-8?B?bmdhV1ZVMkY3c05Ic2cvRG9HSEpnQnE4N3plSjB4Nm93d1VQUmN2QVNaaFp0?=
 =?utf-8?B?TWo5cVFNRFVNMW4rZXFSQVJlaGdyRXFUQTRwOEdBT0E4bi9VUHkxQ2cxMHRy?=
 =?utf-8?B?eE9pTlBLSWE1YmZaY2NOMTlCbUlnWTBTaXREaXo1c3RuSVR4WkJ0aWQ2N3hU?=
 =?utf-8?B?VnJoU1dzMjZsYm5oSFloMlY4aGFyY3BXamVuSE51ZzJNZDh6dFJBajN4TUxy?=
 =?utf-8?B?MGpSUnhVU3RPU2d4TE1rZjU4blJrbG9QbHcxb25PUFgyVGo2b0ZxeHdBbnZF?=
 =?utf-8?B?TWRHaWYvZ1U1VWhDcWhTbjRhMW5MVE90YzZtKzI5bkdOcFIxNndDK0pGbzFE?=
 =?utf-8?B?RTVHdU5YcGl5aHhocXZHdTkyamVzUWU5Y3kzbThKK3RtZXV3Mm5lWFZreURs?=
 =?utf-8?B?dEdlS0JhdjVIU1dwOUdIeUhoRERwRENpTW1DWlpDWU5aaWk1K1NiUHBmTk1t?=
 =?utf-8?B?cm9ZVVNwQ3loTTRKTDVTNkdYVmVWWVh6SU13VCtsenQwUkdnc1BFekZaeDl3?=
 =?utf-8?B?ZUFvQkdQMTQzN21KRmRIV0VZditwbDdsd1liZmVUbU9uUHdsQ2hRaWlnWndp?=
 =?utf-8?B?WU5FS2FnUTVnMnYrNkhGbmk4Sm1kODBMS0tDd1I3YmdINFFFcjNNQWdtdWFm?=
 =?utf-8?B?cnhERVJPU05TVHNxdjgrVlhZYytlQ1RQdmZ0cVh0eUtuQmJqWS96aXc4MEJm?=
 =?utf-8?B?c3BoZTcvWHZkcE9keW1ldnVwUzA1b2JadGloL203M0JlTEI0RnV5c0VWZEFV?=
 =?utf-8?B?WlNmWlNYN2t6R2djbnBiaG1QdUpxSFoyTkJaN0ExMzA1aURIL3FROGliWEtL?=
 =?utf-8?B?R1FmSU4wcURoa3daMzc2T09yVnA5ZlUyRzFSNFRpTkxURDhiWFJ5OGpwVDVC?=
 =?utf-8?B?disyL1dyOCtYQ1JDaXB6SHRqMXYyUGJKc21QNWh4MVZqWlRqc2dNZ0FqUkZr?=
 =?utf-8?B?ZGpaMGJxVmljbFczelNwbGg4aVZaMFlpS2ZtcGxpajRtMFpmVGh0RUlraHNH?=
 =?utf-8?B?VmdrcXpUN3FLV2NjeEtFTHNnSmZQRmFiWHlpZDM0bXptMkE0eENEOXU0UE84?=
 =?utf-8?B?UGYySkFaSGRJb3ZWaXh4eEV2eW9WV2xMbmZ4MUpEWEhBalNKak1ucEtOMUVC?=
 =?utf-8?B?cVNoU0xoNXVSMHpld1BaZnJnSlZFQUJvZDBQYU81aVIrTXJpTWdYbnhTeGYr?=
 =?utf-8?B?bGhLc1pKM3VtenNUU3ZGSzJ6YlpQZXZQMWczSVAxZk9mSXo3Lys2ZFZqV2dQ?=
 =?utf-8?B?Wlowd2hhWmhOYnZ2Qlhyek0yWXY5UVo3QTVNZWVlWlU5Z3d2clMzNGtoaDlR?=
 =?utf-8?B?cjVDSHVucGtaU0xONEtoZ1gxSkpSbHd3Q2VmbHBHbnRhQ1FnRmFaSGpycTZO?=
 =?utf-8?B?K1BPeU1CUzQ5aGxxZ1dKMVBKcUd5b0hRalpsbUdFczZNRW9LSlZha0RqQ2R2?=
 =?utf-8?B?ZUM3QWJiemthdkZQY2dXbklHYnJ0cmM2dE1GNjJia3JWZnhGaHpleElLWVBa?=
 =?utf-8?B?TXVWdjVyYnd0U0F3cjlpbXhYRmhVTWRDKzNVK2lWSE13d2R3TFVxVkUyVlB2?=
 =?utf-8?B?WUM1VWdXU1ppL2duMXRORGM5S1UyYUd5WW9HRS9sZW9GNE1lWldpMXBQMllt?=
 =?utf-8?Q?RoWlqi5xBGblEzIl2XJzkKddLXPasR4hCeBBsFiXwCnv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9820bd-199f-4e91-a7a0-08dd3eed924d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 16:13:44.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2o4Z/9EvWRgTQ47/gcRDRh46Z8zuzykMsGZus5L05suJdReWGry4LDd7sqhSG1cmh3wyNpDD61MmrI81Z6dhsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678


On 27/01/2025 15:21, John Ogness wrote:
> Hi Jon,
> 
> On 2025-01-27, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Any feedback on this? Our boards are still broken with this change.
> 
> I have not yet been able to reproduce it (mostly battling brokenness in
> am335x pm dependencies). For now the change has been reverted in
> linux-next. I will send you a patch once I have something to send.


OK great and yes appears to be passing since next-20250123. I should 
have checked!

Thanks
Jon

-- 
nvpublic

