Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021123.outbound.protection.outlook.com [40.93.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3236C5B2;
	Wed, 26 Aug 2026 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787722126; cv=fail; b=QH4C+zof42h6M1PEw1cDUbx8z+xY/TtXtkq8TiV08z2RWv26VR6HViFg3wHQn4+chTpXdLXHf4ybxaSgM2W9MmAJ3Yhmrk/zBk23U7euPFZBc9WZLWrAwRV6iZEv5q5vHpE9VDN2eChDyiWaRHcbMmlTAx6ubdz7IJ71snpmfOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787722126; c=relaxed/simple;
	bh=kG3xJHrOK+GiJAjdXQtT9H2++e/1NS6rvCb2cUQ4qXE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SKRJ3AjF9/UL6oWDXKUBonyZbE7V7ePwnTksX29Olq6+7vsOmvE04s8kO7JPEi0yS01W2Oiv4zdfRJZiSDkLPpZp/3mRe9neQ8Cn44YAWPTUpyBGnqWNlkp3/DJwc59K2B6V5Mk0kUVSJujMy8KL43WSPmSL+hV2PeBoAJJ6Q5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=MzMkfJM1; arc=fail smtp.client-ip=40.93.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="MzMkfJM1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJeXavbZLOGxHrzRyQIzfh+vXC75fudktbncDEV6JqqSuBgvP1fq0pCkRAu9bcY2qjACDUFZxYAcY7PnqKQ8/eX54djaSu2LBvUQb9QyQOg0dSWPuXG+CSawDnHLcuFYI9n9+2RaJYaxJAEua9pNHQNO1JoIfLG7S49tLCT+toTGMNX5nGF1zzFFX27tWdjJxNqyx5Js0lfIRJ0ARulIjL+3L45pIlv+hDoaMBSpPRaJya+acu7hMQNK4i043OuLt4gG7e2cmgTwR4UZ3D9Uc42dZDefcD7COwI8JDJ7YJXdJJ2KS0/9UihZ3Wa2jlnO70Cqrf25dlN+7JwRoK0alg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We/A8m+O8iUJFG4MxCEh7QvkTRzTUwRMJFEnh9RMrbw=;
 b=OPLOTsYbdJPDLxmmZ6+YpYEInncaew+OsndFWiF3jYRi/04D8mTicrpbtUd+qhXPMa1c0UvKmQzoZmsFlq+KV42uaB7PKwmR3Xn6dnq4HxIq7D3WLlFxC0CRtGiWrgjffLNmpVibHNYw30Uflgq4m5xEEoxIMJxW1gqt+Owe6WU20UGfwfiTmEdRhniTs+ZsJebV6ONX5XgUfwEeiTRjzRtBlOGBCVUeh+dfnB8g9VTYLddUAOZTXTQFFbKh4uLl+TfRZ4MhXd0xqGdzgsaf3P0X/M92qmgRhIi8nnVCb4h9QxnZ0NrmyEfLIYI8taN9qTOlUzOfd2CB650cIxS0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We/A8m+O8iUJFG4MxCEh7QvkTRzTUwRMJFEnh9RMrbw=;
 b=MzMkfJM1JIsjw/fz2bVHYU9Hp5ZYwklMeSgQUM/TBbH+zA7KiQxTEZxdddi3E8DAMi3j1N3CVSJqGnxPdUuBm6P1d8kUGE5ENfPYY7geq0qKD5IRzvJCGsyUOLkaOnrICu8RJBbH78yDmlpYsfisrmAKR6HHJQ1UItkfhMP1sdx7AL6vVfXOp+ZYer2fb94KTsN5o7WZ9WyBB5OHCwI6i1JZNe5R4oBdgFfLSoRFOM51uKMPytMv/2M+kj50ygxE0NsdEAGIt8nv1i4UeHVRfiFaTrjbNrfMIOxbPzmg5XHeut1LuOyt1SeNqA5uHXk8aKo3hhBRdoZvjtAz1q2Xng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from BL1PPF1B62FD55C.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::d8c) by DS0PR18MB5455.namprd18.prod.outlook.com
 (2603:10b6:8:15a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 05:28:41 +0000
Received: from BL1PPF1B62FD55C.namprd18.prod.outlook.com
 ([fe80::89bc:34fe:3f82:b3f2]) by BL1PPF1B62FD55C.namprd18.prod.outlook.com
 ([fe80::89bc:34fe:3f82:b3f2%4]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 05:28:40 +0000
Message-ID: <ec728e98-799f-4e3e-b023-557c9047fffc@axiado.com>
Date: Wed, 26 Aug 2026 13:28:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: serial: Document Axiado AX3005 UART
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260805-upstrea-ax3005-uart-v4-v4-1-8399f0773b13@axiado.com>
Content-Language: en-US
From: Swark Yang <syang@axiado.com>
In-Reply-To: <20260805-upstrea-ax3005-uart-v4-v4-1-8399f0773b13@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0006.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::6)
 To BL1PPF1B62FD55C.namprd18.prod.outlook.com (2603:10b6:20f:fc04::d8c)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PPF1B62FD55C:EE_|DS0PR18MB5455:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5b41d4-bdde-4e6d-2782-08df0332e2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UJo337SD0bO+LDBXBX0iesaMtdRbWnhyuGXUgixa/PBxSDjnRC/czPviCKvxWsxroSbt78gJ6rbzMSZe7qnSoFcMNShfAZNCbe2ug+NAkAXIqLK1vICJcdo8T9n8i7yknCfQ/2IQm07ukynUtv+0BgZGLY0w9rRqyBClDGVmNHa8KUnr+ZiKbAZ0Tz0rsEvLUtq6fPelk7VWSa2FVgE2U7EeYRuPjkaYHY7uzAwRVyJVwdEcVFxBg7MbdXk/fUhOSxDlQfR6Y0uahZxGc3YnJzWWCv1QOJzMCToUqm0mly2LD7f5htG0z6b3izSJBzeUxMx18BNQgJlDGAPdMQgqrd6A2hkoJxHqbDAvulBa1g+PzCxbWaYzOzntNtxH5B+rb63m78P5X0FKJ0nuxOaJj1bMh2+sFq4rYPF9hjHFD4q82OhbHimMlHtHr0fCl1mvhDvBpHMV8wlxiplxy95eIqs2JzaBz57o5jJFtx5TbwkiXrRTu5ZobS8yFrQ+AYZUIF3rUAGDvcKcnypl8RxnNQl9VwX4nl8FKCM2za6KWWLt+oOkeZGEZTpDCKOr7zbV8nZcvXF3rXP3fr03xrRiZ48CjRVIXYRdKL/g44aOq3z5b6VhgTgsmKuyALmWq9aoLmQpM7EkiNo+IqoFv6tvUpFopSlMwXI378AGnB2V5As=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PPF1B62FD55C.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEJKZ29NdTZMMHBDK0FtK1BpbUcxdDV2Rkk0Ym8vQklEemhTTEtyL1RwWjBa?=
 =?utf-8?B?SWZJZXF6Y0RzbUFabmtJdlo5UHpFS2lZNk40ZHRYbzZmaGw5RnIzTjk4c200?=
 =?utf-8?B?QUFXRnUrL0NWWWJxTEZKbU1pcm9HRjdZQXJTRjFFUlV5ZnQrZ0lqRXRFQnZn?=
 =?utf-8?B?S1hLMHM2N21zNVYwVFZUbWZwSGpuQXZZTU5wcFVLbURrZVFzRGZIalZka1Y2?=
 =?utf-8?B?c3l5YW1IZGh3MGxjSUZDZDczTGtGM0QwWWc0aGJhT2dIbGxZRnlLOVVjNS82?=
 =?utf-8?B?dkVOWmRXOWJvTTlaMFhCckRkMGxIb3N0VjI4TThQOENUdlBXUEptRWZsUzY0?=
 =?utf-8?B?d2E4bE8zVDl1b2M5cXlyU09GeFM1bFNZV2lERkUvbE9pMEJFd0hBdktROEdJ?=
 =?utf-8?B?amJuSTVvT3FycG02RW4vMVJmNzF2cjNMcDJLU3NDSjdvWXVmd3lBRVFseElD?=
 =?utf-8?B?U24yZFFmaGMvMlVPUEQ2Y1BIUWxHYmlJYjJCY1oyMmtSMTlpMUlrcUNGaHc4?=
 =?utf-8?B?RFpqRTRpVk10ZE1mY3NrYm1weUcvU1lEcnZPWGMxTXZvZVpnYVVvOHo3ZC9E?=
 =?utf-8?B?bnF5c2ZXSVVlRzBWNzdZd2V2d0xBYW9rUExZT0pqOWR0M1lGTjcyK0Q4T21M?=
 =?utf-8?B?cGRVS3NiczVNWVk5UjJGN0hla1pHZWFDSU1pbVBEeCtsbXVIeFlVQm5RZThk?=
 =?utf-8?B?NmNzWHBJcHZORnQzeERwRTh0a05pdWxHL2greW5BTUQvc0VKSWZwSGVpU1c1?=
 =?utf-8?B?TkI5QnNFc1dYRWRlUXRYcFk4MWN3K0g3VFd1aklwYlYzMm04V3Q5RWMveDFy?=
 =?utf-8?B?SnBOOEgvcHhPV1JUQVBDUnczMGJDckdlNjJRbTB4czZkQ0xTVGJQNmZzSEdt?=
 =?utf-8?B?K2p5T2hUb2gyREc2RXdVbk15WVY4YkgydW4wUDc0R0g2TnB2YzlIUVlValJK?=
 =?utf-8?B?RW9pZ1J4WWhiVnFZN2hvaEFGRklXbGNGWEZNVjlxRDdGaTVmd3k2TnJyb20w?=
 =?utf-8?B?ZnRjZ2QvTDVCd1poazdqWjV1UWw3bGtCZzR6VlB3aGFHZnBmVU1mYndhNlN4?=
 =?utf-8?B?RjhmN2h0RWRVcFgyZWk1a29oRmVZYmU4cFBqZDNoUEpiMllNUmZiN2VGNFha?=
 =?utf-8?B?SEV2ZDhrQm1MTGZYREsrUGUxTTdSRm5qblpDYjRmU0dXYmlvbEdLZVI1MUFt?=
 =?utf-8?B?UU5sVjVXS2pNSXJ2Q3V3ZHFzU0QzZXppYVZLY21CSzJnMkd4RnAvSUIwYWJG?=
 =?utf-8?B?NjZmOGZyWlBGaEU1dFNSRTk5NWpwTXl5eFg2UjB3SUN3blRUOURGRk9ZUm9K?=
 =?utf-8?B?aFdOY3E1aHVZdDNyQUo1ZWc2N0F0VHF0YW9zVC9YVnNJdzdSNFJnVFIrSTBI?=
 =?utf-8?B?c0k2QlhpbVA4cTM4TnYvblpuTU5uRFBsdnJQdGEzQWlsU0NOcStjdTVCOUcr?=
 =?utf-8?B?TVYwdXdWQm9qSFZreGZ3N2ZZTGozdW04L3N6YUgzNU9HeXJSRTR6QjJRcGgw?=
 =?utf-8?B?Q0hOWDh4SjVRcW5ZU2Y5cmFnTURaRkQybFJyNkZlQ1Q5d2tuSytDRE90bUF3?=
 =?utf-8?B?UWQ3Z0NTbHJDT3ByckFtZ21iNFhFdTJWWVhxWjMvUGZ3R281MDQwNC9jWENL?=
 =?utf-8?B?b1I1OHYwV01IbEJMRjNSTnkwZW1tcWpOUmxaUFhncnFjNVY0c3h5VFpoazNr?=
 =?utf-8?B?bFg4ZjV5R0NveWhoQ3hKSjQ2aEZ6VzNJamJLSmZKK2RHTzhDblkzclBRTC9I?=
 =?utf-8?B?SFpkN2lqRS9sa3pJTlZ1VHpXOGgxT2xwdHdRQklnbG5CNk9xR0trczlGckNq?=
 =?utf-8?B?VUJkS0UxZElLUFArbXQxeGQ0d2ZUbXlNa1RKb0lMNFd6MFk1TmhlRHB5OVB1?=
 =?utf-8?B?MkVlN202V1JjNlZJd2gwL2gwbHg2T0MvTGFjZE1sTC9tWkRKcGg3cVYvM0pu?=
 =?utf-8?B?TTZoZHpLanA3WjV3c1FnR29DRjlmNEl4TzdLbUcwUmd0YUpXM2lFZmNPUUx5?=
 =?utf-8?B?WmVUbFdWbVl3NTk1S1BIaW5QVGwrcjhTdklyRFMxLzNCUmlkQzNmblZiMkpW?=
 =?utf-8?B?dDBRYkF1MDhOVFJ3U2wvMDh1YmJ1aDFKR1d5WHBrazZmK3dFMXlMMktiaVpR?=
 =?utf-8?B?bEtaQm5YczZxZFZ1VUhWc2lzVnF5bTNmMzNYK0hCRHFvMEhncEU2bnFmLy85?=
 =?utf-8?B?ZzAyd3ZCVm9hWExqcEFuN3dRdi9DbnNyMzFlWGd4czcybVZqWW5xWmZROXQ4?=
 =?utf-8?B?Tk5Db3V5VTk1SEtINXRYSUQwcmZTc0xabmdRb0tjM2lzRmVwaTBORGRBeXdj?=
 =?utf-8?B?UG5melRGZFJlcEFuVzBaVG4zb3VPOTNjaWJqZnNYMjRacmM2NVpmdz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5b41d4-bdde-4e6d-2782-08df0332e2e6
X-MS-Exchange-CrossTenant-AuthSource: BL1PPF1B62FD55C.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 05:28:40.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEa7DaQZ8utXqb7K0fP05lxIA907D+ic7Hyns7AukKpWj9j3pTaGVWtCJKv3RRhOIgu+C9avEuj79ThYb8c3Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5455

On 8/6/2026 1:03 PM, Swark Yang wrote:
> The Axiado AX3005 UART is software-compatible with the Cadence r1p12
> UART programming interface.
> 

Hi,

Gentle ping on this patch.

This patch has already received two Acked-by tags, and I wanted to
kindly check if there are any further comments or feedback.

Please let me know if any additional changes are needed.

Best regards,
Swark
