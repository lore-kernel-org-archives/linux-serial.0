Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948023D47AD
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655067; cv=fail; b=lFCe4fjr0jWv49A6ifOMCXMIejTHmkTfUpNLjk/PXCDT1GgptObNG0HfbMDl6LfnW3y11bc5Rg4gOObfgznCwZSgDoVUcn/u4tlMW/Skl3yKPmVOMzSrAuoMBWMCANeJ24G0Gdmuim5epbE0vLZqNO11AE78g2ouEdKbw8+fUoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655067; c=relaxed/simple;
	bh=gVs4MPpkCY7+gc9NpbPi6/pOtNMg0qIOQGzj6fRtCuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YUSIYjl3k9HEohFxGDyZM3r76u+cRsCv6mxnMCY3mhzH521YswIC+4y/ySYRMgIanaFLZ4+sgKVoRbR5EpDzFdFM/tb2QgXvM31JL9Dg9eFQ9wdOqf7Z2h1aYbc1icjH0JMp0x5fuxVqreWEo5t7szqJmC9k7e/m+6PDKXrf3V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=eYOCwkua; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="eYOCwkua"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4oIhw338454;
	Tue, 12 May 2026 23:50:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=AbH+SX1+F0kRyAa6yJWm0Ue6YyFPANMefyqRy5mBXM8=; b=
	eYOCwkuaAEBzRTil2IrXuJKLmxayPC1UHoUJ32+W/LwpITuHwzIG1pNKidpVpuSz
	koH8aYuf+JTA3rcDapsD3+3LBsveU7e39VgPXwl86B0mVYWTJ5gBN30lO5QyXGK9
	EmDbaQzXW4fKdGYjqhk/L0L+VHyLPHyR2bAFF9PPttmaXqlMgywA7UpjSMKYZB21
	09srVAqoLqbd29vtDl5iBLziPiK8T13ietGNduBv16azzBXWCLXrOIWmLVFET4io
	sTYRqutS3kD30aywTIYwa3i3Z+UE3aJNvZbLvvJHbgPzssIU+aVxZ9pOjlxindah
	i1TghLwg3GjknV5I1pAHEQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ftb8a1j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 23:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGPNtRdnI7QaNYUjxruaOLyHGnwXUvy9xAW+EJyKkZNnRK+8N7KiwEicY9q+UZIwfQahgA5JwHi0xwLXHy06FpvVbpuF6FUIc8MF4yDQYktj7YVN+iCPTHJuAqaSg7FdsH3yfIiD6jTUyLbzLqRImrrid0vYXr4hBqw2hcb6EVXA+Z7ciB+sgf3cUUVsjYp84nJXXqPwXd8uI/Q5U0Uor/CnZ3Os1fROw6hMrTNqkJG0H8YfRDWKcOhz9+9c6iXtgS53OkO8qqdxKF1aOkY+aJg6HchWB4WdIwBzryLMFdM4q4hgREnS/LNBmd34kuVvqZxDFz2/4awDI0s0mD6DYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbH+SX1+F0kRyAa6yJWm0Ue6YyFPANMefyqRy5mBXM8=;
 b=J+ufz+j76aANBMN5rxz06ySV19dhzCp7NCJ3LaZPcZmNBOy7tSa4382g5qrT1bwRBShvHhsNLPzreBLSIJV09YiNKuU+Kx/jrXvlz31Xobehkm0i/a9yKDsITGH+qQqxgXZ8koFkBvWDeBf/HdYPBFcQddSGjJf0MaoDW6zU0n0xZCakhKwsr6Yh3QXM9rHAynckR9pN87+vaZlSY683xYzXJz20lewIwCjjdQ6z39WKmlwZlSspKtWUFAcqlxWDCKHWdJzNNMHP3qnl0xhCcwDQCYbH30M0Lpen4kArjDvh9SUdOfB6jeXXvmeAHixShuqp/vEWnhwLyzZBACaoxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:50:46 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:50:46 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@kernel.org, andriy.shevchenko@linux.intel.com, wander@redhat.com,
        chris.friesen@windriver.com, linux-serial@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 01/10] serial: 8250: use serial_port_in/out() helpers
Date: Wed, 13 May 2026 09:50:19 +0300
Message-ID: <20260513065028.112468-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513065028.112468-1-ionut.nechita@windriver.com>
References: <20260513065028.112468-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0105.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::34) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cce7fc-a9ad-4965-0abb-08deb0bbf592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|10070799003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0F+rR3UlWJ/nelFT4prrqVE925+DU2gHsJRHqIDnHVhPYGqnCtHN2EHoW1bKOVXTfzuRr8VepKGpA8M33/RQauHoe+3g/zIKZMwMJpLvgkXYvDVrCT8psfujVif0EnZcFqc8ZS0GEPKARyGKD43Ek5D8zH3J/lL0iy9upUgerbqcsrIMymBGkLtTziCS4HuO7/Npyd/HjF7jYSYFq3dxK49qccPUVZbolrhDEoqqepx7xtniFWzJQpMagVEk8Uo7McKgwmNSlKVpEE96rFBZw9oo/aDCJeZLeBhlP+VtZuBy3iaeHWOFIpI0ygaSoX7aJKfaT8ck5jjq7s85PeDzfJLA9SQu7gJ8U1xXGSQh6apwkNB4sqHcLC1LN53lC+6UTttZ2XfBMUFsJIihHxvR+hRmW+HZR15SAENlFCFYmMHq3hPHpwC+Y3Il+RmvfBQJbcTFmeFhf3dNukIsvKZFvw2Jxigw7jF1i6exveY5pwbM9wWuKLZfg4k7EhOmxqHZ3W0kcH57oFHZCn8kCRc4jWnsy6F73a2EyyHY+yGhwynb2K0DmNfCAdCrYqteKP7fORu1Q5WfD8gFEMP/+lBAI9Zd+ohNtOmCAu+3bw6T4GWbsgfARQzoL/xyaUAdOYUbQvQhZUAohm/vkFuMGZj4vB5RUD98rOGRwPCRP934CYzcIe1MmPXB67f5g4Via3qkEBw+LijjNDoj59zOuQC7IQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(10070799003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K254eWc4eEc0Ykx0MHBQRWZRYnNScHcreE9ObTlHczlwcWg3STZaOXcwOFlL?=
 =?utf-8?B?ZTdjRGgyV3BFTjZDUFJtZEsya2NkQkJpNFJoS0R1b0ZLRUZTMm1SNytBS29J?=
 =?utf-8?B?cGZHdjdNWUpHZ2ZyL011Qms2T2VvUTR2d2xkd0dDbHZlTU5uaGpjYU8wMkVj?=
 =?utf-8?B?TTVaOVk2MEZJQ01oTUM0dHlHcU8zREdUM3ZsNUtucm5mUG5GTXEwS2ZDU2dU?=
 =?utf-8?B?d1RYdnMrWU1xdVl2REpEcUJUYXpCendnbEN5a3I4aFJZTE9EcG9SWlBDQ1cz?=
 =?utf-8?B?QjNoNGM2LzdVVVJTSFJhbzNFcjJUeldocUpEc25kUjhRSXJNV2wrRkJVUVVu?=
 =?utf-8?B?VVllT3hnbERySXlsdmFLV2ROaitPZEEyWno2aG1SSEl1R2R0eFFDdTN4TmE3?=
 =?utf-8?B?Rkg1SlNsVUl2NXRnVWk4dTFPZW4wMnFGUXVhL0pBVmdLeVhTWllPc1RwR0Va?=
 =?utf-8?B?UFkzZ1JZN2NmL2txZStoQnlxdXR5bFdmS0xvL1JLNEQybnM2ajRoaXM5d0Iv?=
 =?utf-8?B?UTRFWVozWm5iN1lXOXo3cE5jclp6VHFrYUo4eU54N3h1YXY4Nk1OV3RUcGxm?=
 =?utf-8?B?Y0VjVFplbnFuNUFUazFBMm1qWnAzdWZVQVFiS0Q4akM1ckxhYzZGNDBaV3Zk?=
 =?utf-8?B?VTZadVpBMXR1SlZqdCt0UUFlVUtmR0JRRkh4Y3ptaFhYUjlrWExPazM4am5P?=
 =?utf-8?B?YSsrcnRUQWRQVTM4SlFqNSt6Mk9LNnVwakhFMGFUWllHRWlURDYxSXVZd0pi?=
 =?utf-8?B?aGZ0bUd6Z0ZRSENLS3plRGdyc2RYVDJHVERGU0d1eHZjYUQ1dFpXUmFJd0kx?=
 =?utf-8?B?YUVwZWJOdFk4UEdNaFNZNGVSQ3FCOGgyUmVIaS9YR3NRbXpRYkJaSExkTFU1?=
 =?utf-8?B?eENEMW1Td0JXeHFYbWtpYkxYbzVqajc2S3NCcGwyTE05dHAzM3h2WExsM1Yw?=
 =?utf-8?B?SkMyQmhnTEpzcjdTdUE1aTBiWjdSV3ZXNGJoMVVQbVBkaEErNjFyeTNKMXZn?=
 =?utf-8?B?cklyU3VTakxlSk5KOGJCTUNJUGpzZHpPVzY2U0l3QUlBMytqQjgrYkk4ampq?=
 =?utf-8?B?bDFhTk0vNEloa200amZyTHdzeUxDQkdUaGNtQlRXeTIzd0pSZEhKVmdhcjF6?=
 =?utf-8?B?YnZPcW10Y0dqVS9rMVdYWHV3dnE4SCs0SnVqbm9CQkY2Z1BpZHpLTjBYc2Y5?=
 =?utf-8?B?YkZ0OERuRm5uNFBNeHRjeU1YZ1FOZ29mRUNaTFZLaXZrRnd2K2pwcS9vYXRJ?=
 =?utf-8?B?UUFmM0NzUndpWlZHTVFxdkhPdDJaYlNWS2RwaDNFeGR6Z0pFMlZGRXkvSWI1?=
 =?utf-8?B?SDBVZlNFNTIxSm5pYXVPcWNQMk1tSEtQUzE5Z1JQcnU4a0RXZnFFSFdNWTNz?=
 =?utf-8?B?SysycktFMTlMRGtucSt6aHZZaVhVeHA1OWJnQWUrOVVVKzRIbzJSNlAzMk15?=
 =?utf-8?B?R1czekhRcHhUYkFvKzRlMWh1SFRZa2w0ZVcyZ3BOQ0lPcXBUL3RlQzlUYndQ?=
 =?utf-8?B?MitobkxIMHhpRHFRS3MvUEhUWlNiOWNGdWVEVkVHZm5FV2dmNVFOSjBNYkpq?=
 =?utf-8?B?b3JsVk5mVkRWWXZ1VXhKMEtKU05hMGlURU9LbDdPMDFZTi85RFRKTm9Kcm9q?=
 =?utf-8?B?cTZUd094Z2h0OElEYUtCVndxV2NVZzBHMHlQSmlDWUt5ZUNqWnNGS1gvdDkr?=
 =?utf-8?B?dGZuM1ZyelJzYllJZUVsTXZoYUIzUXZWK1Nhd1R1SG9TSVhMM0lRN3ZMNHNZ?=
 =?utf-8?B?bVMvTDYwTEY4eWt2eTRnMzBkYUlaOWpQRk9XSDFuUHMxQUp2WlBKRzlqMEx0?=
 =?utf-8?B?NnNEZzl3cHZ0MGYrZERzSm91MVZkVTI4anNiODVKMkZhallyaU01WWVFeHVY?=
 =?utf-8?B?UGMySG90eVo3RnNaaFZsK3pKbURQdSt0SERHNEY2ZjM4Y1RJeFFkOGxzaXJS?=
 =?utf-8?B?Yzk3VjJVVTJWNkJBUFB4Z2wzc0ptdTFjUnZLQ25NMVpDYnlYQndPNVp0R3Zw?=
 =?utf-8?B?U2lhNDl1VCtBZHY4djFnMzRuRmtmQmFYNEI5cFdkL2RDY3RhMlROMCtWN1Jo?=
 =?utf-8?B?ZVd1dDhKQUZCVXNxZEdWSmlOZVdjVkpyR2VQN0M0MlhWYUdqYTRqWnBJQTlQ?=
 =?utf-8?B?TXBMQlZGSkxFWXBkTm92T1VDa2Y3RTNRV1lKTjZocThReU9iL2R6aFlnNHhE?=
 =?utf-8?B?cFRJNi9qNHVqUGhkM1Z2VTArYWxnb0FFRVdSMHJoL1dEeS9zcitwZms2U0pV?=
 =?utf-8?B?OTE2N3FSazFiUmVzZDVFWHIwNlpKdFczOVRvS0poMWVObndTTGlNcHl2NGNQ?=
 =?utf-8?B?TGhtK0drZW5LRW1uNXhLM2Zya0MwdnRnZkZkUU4xQThiQ3NlZ0hVam1YZ3pt?=
 =?utf-8?Q?IWPHtYc1IJ/4j+R+tpWmJKmBvC4juRgWlD6VgIdmQ0VrW?=
X-MS-Exchange-AntiSpam-MessageData-1: diFNPm8SWevyDt8ueOKNV1oOgmEQ1DHTXGM=
X-Exchange-RoutingPolicyChecked:
	BTyTXRGhsEjeJXcVJoGjesHFWvqKpJ+5X1xqCJFt3Tq/ElaUYzETO3OlbZsZcrIk7RQysqs8HxKtswFFumd8f0t1VtE9ian720os5ba8XkvM38tvU0lNx1Ntb07Gp/pSMjhCDaeIWpA3Ue4HRU+/r61YRhBJqvXNwvGjik0Xsz+qHoVFYffbi7WMzhlTVztm2oX6Kx0E5NGi/irwJZlzd3tYGzoOlLMBPnC6SOrVF22DKwQ8fYmSKbeiow6G+WRgr/M7IXsfOjR88BF3BPHtc7SY+csIw8Ip5AsfjNNRAZSNrOHfX5kzoU6LYMITj+d1HRZ3YE8rxuc7n9zVmAI0ZQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cce7fc-a9ad-4965-0abb-08deb0bbf592
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:50:46.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIJ4VOPooiLoqtP656g7031T9AVcoLLLGHt/YB7ljyPpHuAl+spFGrnxhFBxDyH1ythtm5n85czHiXcbhwykptpNaXlwRX7nq4x/lg/HRnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2OCBTYWx0ZWRfXzWzzWCqQFA2M
 mEUYPEMpKx8gJcbaMhcdoQuRtGUwMPQtY+F5K8Gqt6ovjWpWhi5DAp2eduHUWAVnzL1R7yM3rcs
 3m4r/xNxztIPCD9ZX/MJYhEyv48hXWP8JTc18c/YnlvcBS66sNl7FigcbMqEzinHIBeDXfJXmxD
 UizZ4E4p39VE8mB+NZrNM2gOvruMPQLzlGm0PJmwHxR6eb473y/hcpOhGlwt9vwgsL1NGdQKoFA
 PKHo7bb8Y+fuTaUrXov+tMLh8JBuupPs914Kn7sbEH75mVTGu0jiJ/lfSku1Pg5/s/4FQ1tf7Ti
 vIgx+bN1nnFL7U1BgFgzLsCK555dlwMGPJTgR3qSeosmMJc3pFxWuNp6LDWuR0Ahyo+Ne1z4WAI
 ck9FRTVGSLIOFibTB56qIWHKqpJ9M+mdhu1nblB0rQHtQZM96bqnLMDMFaa3YHo1iOs7BBDOIVp
 XhwHdhd+wntI01jSnrw==
X-Proofpoint-GUID: Yusb_w4nmhnT9Htv8_ufjaeYWX2XAWRz
X-Authority-Analysis: v=2.4 cv=du/rzVg4 c=1 sm=1 tr=0 ts=6a041f48 cx=c_pps
 a=IN6nX5sQGDwae/9PVKyrlQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8
 a=bKCr7iAUo_JsmPGjlysA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Yusb_w4nmhnT9Htv8_ufjaeYWX2XAWRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130068

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

commit dbd26a886e94deb7fda9050f9195ccb41f9a5d93 upstream.

There are serial_port_in/out() helpers to be used instead of direct
p->serial_in/out(). Use them in various 8250 drivers.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

--
[v2]
* Use serial_port_in/out() and not serial_in/out() [Andy]

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # 8250_dw
Link: https://lore.kernel.org/r/20250317070046.24386-28-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_dw.c   | 16 ++++++++--------
 drivers/tty/serial/8250/8250_fsl.c  |  8 ++++----
 drivers/tty/serial/8250/8250_omap.c |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f17dc3de020c..3225011fd772 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -120,12 +120,12 @@ static void dw8250_force_idle(struct uart_port *p)
 	 * enabled.
 	 */
 	if (up->fcr & UART_FCR_ENABLE_FIFO) {
-		lsr = p->serial_in(p, UART_LSR);
+		lsr = serial_port_in(p, UART_LSR);
 		if (!(lsr & UART_LSR_DR))
 			return;
 	}
 
-	(void)p->serial_in(p, UART_RX);
+	serial_port_in(p, UART_RX);
 }
 
 static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
@@ -139,7 +139,7 @@ static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 
 	/* Make sure LCR write wasn't ignored */
 	while (tries--) {
-		unsigned int lcr = p->serial_in(p, offset);
+		unsigned int lcr = serial_port_in(p, offset);
 
 		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
 			return;
@@ -260,7 +260,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
-	unsigned int iir = p->serial_in(p, UART_IIR);
+	unsigned int iir = serial_port_in(p, UART_IIR);
 	bool rx_timeout = (iir & 0x3f) == UART_IIR_RX_TIMEOUT;
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
@@ -281,7 +281,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 		status = serial_lsr_in(up);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
-			(void) p->serial_in(p, UART_RX);
+			serial_port_in(p, UART_RX);
 
 		uart_port_unlock_irqrestore(p, flags);
 	}
@@ -303,7 +303,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
 		/* Clear the USR */
-		(void)p->serial_in(p, d->pdata->usr_reg);
+		serial_port_in(p, d->pdata->usr_reg);
 
 		return 1;
 	}
@@ -390,7 +390,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
-	unsigned int mcr = p->serial_in(p, UART_MCR);
+	unsigned int mcr = serial_port_in(p, UART_MCR);
 
 	if (up->capabilities & UART_CAP_IRDA) {
 		if (termios->c_line == N_IRDA)
@@ -398,7 +398,7 @@ static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
 		else
 			mcr &= ~DW_UART_MCR_SIRE;
 
-		p->serial_out(p, UART_MCR, mcr);
+		serial_port_out(p, UART_MCR, mcr);
 	}
 	serial8250_do_set_ldisc(p, termios);
 }
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index b4ed442082a8..59d3d2801c2e 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -32,7 +32,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 
 	uart_port_lock_irqsave(&up->port, &flags);
 
-	iir = port->serial_in(port, UART_IIR);
+	iir = serial_port_in(port, UART_IIR);
 	if (iir & UART_IIR_NO_INT) {
 		uart_port_unlock_irqrestore(&up->port, flags);
 		return 0;
@@ -54,12 +54,12 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if (unlikely((iir & UART_IIR_ID) == UART_IIR_RLSI &&
 		     (up->lsr_saved_flags & UART_LSR_BI))) {
 		up->lsr_saved_flags &= ~UART_LSR_BI;
-		port->serial_in(port, UART_RX);
+		serial_port_in(port, UART_RX);
 		uart_port_unlock_irqrestore(&up->port, flags);
 		return 1;
 	}
 
-	lsr = orig_lsr = up->port.serial_in(&up->port, UART_LSR);
+	lsr = orig_lsr = serial_port_in(port, UART_LSR);
 
 	/* Process incoming characters first */
 	if ((lsr & (UART_LSR_DR | UART_LSR_BI)) &&
@@ -71,7 +71,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if ((orig_lsr & UART_LSR_OE) && (up->overrun_backoff_time_ms > 0)) {
 		unsigned long delay;
 
-		up->ier = port->serial_in(port, UART_IER);
+		up->ier = serial_port_in(port, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
 		} else {
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 0f4ce0c69114..dc9e3e25d55f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -688,7 +688,7 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 
 		/* Synchronize UART_IER access against the console. */
 		uart_port_lock(port);
-		up->ier = port->serial_in(port, UART_IER);
+		up->ier = serial_port_in(port, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
 		} else {
-- 
2.54.0

