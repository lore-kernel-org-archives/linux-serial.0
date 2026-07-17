Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B39E31AAA3;
	Fri, 17 Jul 2026 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259787; cv=fail; b=tfQNaGMo3Ary4/FkEUIZC+cE9j/DJzc0WEayTeDk3guZ0EURrHkKUiwfBnwLvfGxXgHYVcvhJNGnZySkuelXQlvFzunHQcrz8L0isMkO2qFCNhTgcyC2Aeuw8fDhcrevWnQGKQgdiE4/IeYM0gfqaZI9TCEaEt4+8BVzFkdoqLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259787; c=relaxed/simple;
	bh=4GfgFL8tS98fmHUEaeB5NkZa+UX1MHm+4NsMp8TJLTQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZkIz/In9n9Fgg3Wrcct9BSDgWcDY4tzQiiJA0AsahIQx0mVxjSKSWrwawOWlA0GK2lfiDsCgfjcuZeJ2Eq4jMv7kJJOUdse5TgPO34Q9EPpr6U2lFxkD8+hJqJYFiJ79My+9IMZHgCGYB6B7k1ktgOflrTFKchZF0qltEusUfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=HRSE14u/; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="HRSE14u/"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H35HAn051133;
	Fri, 17 Jul 2026 03:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=4EsBPuJ0RfXIV/o47TFdB1v7TMd9eXcuZ0s9YqGwJc4=; b=
	HRSE14u/76KO3jkv9Sq9ccGSKzdSLPe4S413CT146YnaiFWOYCJ4Co1cY+57zg3M
	VLA0jMqD6UPQbtNDLMMpgAiSKO2lrPkrViraSOwTMyIGWieXZEdw2OLhlBLsxNGJ
	di8AttxwH0N0r0zvyq8FfGQ+Ttjd22Vzxa1viVTm06HIlxiyf/yKWkmmUH2BADvs
	xC/2+DTu7HRybFMv57ZWrBe+wN51byuq+xX3OvdIwwOiv+7K4HeIB0OQRhtvGxIR
	6XoqYRIURZiAjw2ufg0yRvkXayP/4nQtI24tEdR/UYaMn3rBLdvoQSPsMwrsgpQq
	6DjSRhSRReuVb0q6fK+c8g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fbct4se4t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 03:42:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKdGRQbReZ5oSnAQMPGfiymVkj5f5zSFZqPeHc5b3z7C35AXqakD43FkteFKdNfZBFa8LTOSuIVExnBJLwlpJHaI7HFRc/9OCAd/TJStqbWTMsFdyD6W4J7beyCj9skXzW65DvEdJ05JOqtdEBQ+YiqEz6SE8MIbfZYe4+Qy3tBUgHaskL32TW8RLNA3VU2KC2g6BsNPj7JXzh9/hzBLHP5DSZv3TkaIUXY2JYhfRbstUiW/bNMMoVv9J9EqRW2cMY1/Ard6BHyb7Ea6UAq2s9RCrLHr0rebsgi2wUHnUmvUXmjkfZWlMsGz1onv9ro3JWSL4vM/MUEeFN/YcJIMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EsBPuJ0RfXIV/o47TFdB1v7TMd9eXcuZ0s9YqGwJc4=;
 b=r45JVRlP+verrEgeli2fdDAeH6///DN4LxilnTB39Y/SItc8wNeBfrVm8R2IJghEfXSI/rpITVvmgKq29BuaaHfbzVeQZbihto+ZujeHXXN49B68x/BySew9Da9wda8qtDSFEZjLIXmUXMs5SwxBHzrzYpNVnoAw5nHji84qPQ+SPFHxDaH4aLqReBf3iOYGXUZVQNuX6+d8yW80eiGpgCn0gfAyOqCPJfHjXANyXEGAydouZgmzXlmyZrejn7Q6ORp+HxSiMBFKTw8iop0bGgedVLRXu2NmNqBCeFBCRkk+NqrQo5DCd6ozMxViFueM9d+algcUlLyBBxOUW2geKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 17 Jul
 2026 03:42:38 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 03:42:38 +0000
Message-ID: <70f854e7-b066-4f30-8ebf-71abdece45c2@windriver.com>
Date: Fri, 17 Jul 2026 11:42:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        sdf.kernel@gmail.com
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com"
 <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260716064719.1401892-1-yun.zhou@windriver.com>
 <PH0PR11MB5902C0DC3D8407F2701948C1F0C72@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <PH0PR11MB5902C0DC3D8407F2701948C1F0C72@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0005.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::16) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|LV4PR11MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: e22ce271-8d25-4634-47f4-08dee3b57253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	kZisLclzfqbmsCzYanEyxm7+hWJkp2aryK0yHIpCF3HhMVR3Q5Kvi2YVx3CgQXMp/DeAaFZwwb1eqa5I+w3cPz+NRPzn79zYLN2+v9E0ITCiFzWJr5yOT75voFyWlBUwWFc5YBpEsAhJYsXXPn8PYP2VzyR1mwRkm0ghaFQWZpqShHz3bBHvmesishGN7pHeIgdlZqNx0EenchQg8wNP0vD+Ugo2RkYKhI3CojOwFi9dv/a0Oz+RziAUOjzKhCN6INtyS+etiShnwzrZhWXW02AVPCJV4lYONWQAtsgDOs83ckkK1s+NqehZ3Gaov8PCRKFpq7IjeaXEVid0jp2dwFBsIimT4WRScQs/UrumgummUELpmDTam5jSra7VyjhoSE+c0FpMg2cfAzJJERdaBdbJBbxZUtYi32XF+i8Shi/oXJw0KsH5p6bgWCNDc925TKH6edM9ZAJ6OOaU88epYDMLEO8iTgFsikRJOpn0nlvsK0AihvWf6YqIpbxfGpdkDErx9v+iXXdsdLjNAZKwbdLu1FiA1S+9a0WscX+gDoyyD66ZwaB2+BfY7Bu0bC6OlxHw8mp8ujySLy1jYwJ3+77wUB+X7xfmfNLTFvJexGCpNKbylPbSlv6PH8t43QPOy5WfGclrtrB27IVC2oPcHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEgyZVk2eUR0cUtLd3l6T0puY0lIK1VCSVREOFlubFZndUFtMm5PZFZmU2hl?=
 =?utf-8?B?OUNDdnNuOGtzZnFzamd2ZXc4ZGJKT3gzRVdodDZzTXVKSEF4VzFGdWVPTVBj?=
 =?utf-8?B?L1FZbE84K0EwNEY3eHN3TEVjQ1dTQUtkYXJCVXVoVXNoeTd3L3M1RllLRW4y?=
 =?utf-8?B?VkVKdG5IdCtBOVpUbG1NN2FIcEhZRWNOK0w3Z3M5eER1L2lOblFFbUxyc1Rt?=
 =?utf-8?B?dWNVNHVOVi9VZGZWb2pFTkpLSnBLRXhlQmVhUitHeDJnQUJCczJsWlQ1MlVT?=
 =?utf-8?B?Y0RtTXExa3ppNzU2bGNHaHF3dHZxbTZIKzhrSml5ZmpucXZBaW1BQVh2cnJR?=
 =?utf-8?B?UnRIS2QzUlZOOVBNR1o4dEFudS81THYySE1QeHVvQllQdDRBK2VFOWFwV2py?=
 =?utf-8?B?emI2MUtIM0FTdXBlaXlLTEo5VVlhMTZHTWlUTHFDTGN1dGJ3Yk4rc2paY095?=
 =?utf-8?B?NTIwQVdxVm1SampMY0FKZFJyZHVFZGdadU1SVjBnU3phem1vT1l4M0RlOTA0?=
 =?utf-8?B?UEM5VmlrYjUxZmZ6WVJybDU0b3F4SGNzbWl3bkVSdWJaY1JOZm5YQ0c2ZmFN?=
 =?utf-8?B?RzhldnNxdTJPZy95VklraEh4dFpPQlBjcVgyU3BIdEZBUFVqR0hZTmVrWTNk?=
 =?utf-8?B?VW5kQ0syYUN5M0VTeElaeUdyUitMM0NRY3lndllSamRtVGNZK3BEOEZuTzRn?=
 =?utf-8?B?M1BXL2cwNUJ1OW1pcTUxWTR0YndnWS9VMVd3VlozZTJRVmFXWGxjNlNqTVJH?=
 =?utf-8?B?dG1qbVdqdDhpNkUrd0V4Q2gxVlZPV2U2aHR3RmtHeStZeFN2YU5uQXJ3blEx?=
 =?utf-8?B?WU9ONTdxbFBGSmdIRGcxQis3ZDlpUVpoSTNmQlZhc3FFTE5qaDNuTG5ncGlr?=
 =?utf-8?B?Kzd4UVlrWkFTcmZtWjV6TzN3RVptK0N6YWswem5ZeHlRV2o0ZmxTajI5Y2x4?=
 =?utf-8?B?THR6UjJNK0NtUHZOMjMvdldmVXR5dkdJTC93MnhmZXY2YzZvanczNktucStL?=
 =?utf-8?B?N2EyenJjblQyaEE1cjhyTDhBQTdzQ0hxQWRKanVxaHhHZUZ1a0xnTmpob210?=
 =?utf-8?B?NWt2M3BBTllmQzVxSjBIU0MrNGxObFBSZ0NVdy9wdm83Y1NaUmcxSU9wbFdo?=
 =?utf-8?B?UTljMytpaU53aWVSQmszUFQxNlU3WkhhZzBRd3YrZExEOXBIVU9qb3huWk1u?=
 =?utf-8?B?VEttSXdwNGg2SDZzemZQNTNTcVV2Vkx6TldFSG5xSzBxYi9kU3ZwUEttSDBT?=
 =?utf-8?B?MnkvK2NTeFkvZnIxc3lUU1VaaEdJR3FzVGJQKzVkQXU0Q1c2WFdXWXdhYktL?=
 =?utf-8?B?YjJ5YVFvWTRmckhpRzdNWjlGMU4vMGhHNVRXbStENU1pNGhjdUJtMFkzOU9D?=
 =?utf-8?B?cnFZK2tWYkh3bEsvak9NNEJYeGFydmZHNW40QzQyTFBLcnVzY2luTnB5bFFi?=
 =?utf-8?B?ODJjWlp4c1ViQ09YcXRJNnVJT0htazRFTnpySHVKV3RqTGgwR2NxZnp6WVJZ?=
 =?utf-8?B?MGUrblFsMTJ6SjhNV2VBU2ZCS0ZGMmMzNWRWcGxITjFrdGdKQVdmVTk4aVhK?=
 =?utf-8?B?Nzl5WXcyOThVaUJpKzJZcjhnYUtrcHdMaDhOVUIxRzMvd1d5RWllZE84TWNM?=
 =?utf-8?B?NnFNcS9vRHJLZ3ZPd2F0WXFqbFdsYjJtVUViN1U4dEpGdjQxdHdFMjI4bHFm?=
 =?utf-8?B?V3pPcVIyR0RvWkFyTG5XekJHOHJsRkkvckNIQ2xBeTRKMUx3YlpRTlVoQ2l3?=
 =?utf-8?B?ZnVnNVR2SWdpdnE2emc2TldRMVIxM21WdkdrbGVuMDRIRkdpUVkyaS8zSStQ?=
 =?utf-8?B?YnVJSUp6SWFtaFgxcFgvdE1zUzNmOVpxMnFPY283QUZta2w3K1JDNzVxL3dH?=
 =?utf-8?B?WkpOYUZhVG1EdjZJaExzN2Zvb24xZTVWYnBZY25neGJodDluSnlrZWdoNEVq?=
 =?utf-8?B?TWZNK0JQMmpBMDhLTFRMRmN2ZlFXNnByaHZ5N0hVWHNSWGZqdXh2RThZcTVm?=
 =?utf-8?B?MEpta2ZoUTBkcDljcU41NTBlYVVqYTI3UGhZSU1Wc1BYWGc3bDEyZU9MZ0w4?=
 =?utf-8?B?ZTVPUCtjRXovY2JOUXFSVVR3aHZzYVpZVWRXMzBVdXFXRXd2N25oRVIyQnZY?=
 =?utf-8?B?dDRkZ0YwdnkwUWdhenJlMVE5a2s3YVJDTHBxY05yNjVFUzhJV1N6S2ZJOVRo?=
 =?utf-8?B?dVNMaWJFN1RkV0hwVGZYUjlsbmh4aFFNQnlNNlg0eGROWDZRblJCckJrSUlC?=
 =?utf-8?B?ektRU3RnRVJQT2ZCcTZPY2dEbExUL05lNDNxWlB2OWh2ZjY5cmdBblRrUWNR?=
 =?utf-8?B?Qkszd0ZFZlJvUThlS2J0L2c1bmNSbkowOVIyaEtSdGp3RHVxcVpRZz09?=
X-Exchange-RoutingPolicyChecked:
	j2tOVRUsT9ZiKSZmv+EHs/OkpZoLjfFigZtLmhrPpJQfBnsXAW8grgW0xodmVXBqpXilcNRFtrD4wFfDnADzsYi8raW08ICad7PTbHkieQvRUiF0yz5k4gdPqS9jdHL6eICWVu0H2XJok4tm9yAOe3CI8S51+2XsFtyHgwMo5KkUdbjTOIq3dzK/4uuZU15N+8PHA6dvghg9KIM3HmMUj0R9Nk29smn6PR+IAyl1V/4h/6MdVOGhTwm+jQOWCsvdNmqDoGx9d5h7Zxazv75p0Ca2ATlzZILoNE8nLWX2H0MDuYZx8NmeUJ2lDsNkYQRkL/nwcisxo8aWnmQVo3aiug==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22ce271-8d25-4634-47f4-08dee3b57253
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:42:38.2741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq6Sji5oPIdzHFLJRANrC3Dj5YhWWej4O/1X/0pFeGJVAgTXnMBOp3OxivLFAoHnQ5ph7+7n3P+MteXeZIMRCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9491
X-Authority-Analysis: v=2.4 cv=J9CaKgnS c=1 sm=1 tr=0 ts=6a59a4b1 cx=c_pps
 a=AUi/O1gD07nBRLizZNiypw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=t7CeM3EgAAAA:8 a=uz8JoZNR0ZDQxNLPMdoA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAzMiBTYWx0ZWRfX9Znwuth0NOfy
 BF77d8fdrOp5WencJmJYbJhaIxwS3Zhu6nOVDsCXAMhYK8sZ7ws6j3onJQRog7ySYEOOFrtEDQ6
 h8Y7HEZK0SWG8TJutEPcnvM/zzIVqmpDJKFUqOuEnQ4ppB2o6McS
X-Proofpoint-ORIG-GUID: wTI8WGavlcgPxIVBeib-WOMq7eGBSTg5
X-Proofpoint-GUID: wTI8WGavlcgPxIVBeib-WOMq7eGBSTg5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAzMiBTYWx0ZWRfX0/9ZziMT/v8S
 Hay+eSK1zlheuJ9dv7Zdn2J/GvDsJKc/Gzaore8gA7P8fqZVICGGEgl+d139UPDThOc5+vi4Omb
 7ALni7FtrhdRrf9B2Njep/swLUZyLMDNIXsqQU6RMow2815Cda7QFka0S+323KINdAgDT6rqAA+
 QhBGy8zG2RSnUn5WSL2JqDyN4dIX7N7yR+G91D983uDcw0vaPZN2FUWbhFvNfxXtoCL99p3y3Rz
 qg0F9Ezbini5iyQ5rCb3oXQOV3kYUgaAL0ZseetAWN+fohFgDODPwPOFAbeydo4BsR+4UzvbU6t
 X/K2GEeG4qC6UjAIsGxMBI0jSgh1cXBsqoCtzgh8D18GFmFIqy16mq1XyLtreml1S+TmaISG0lw
 7Fx67uOzus05h66qEdNtZc4gWlrREMOjZBPRkjP3d2ikEvT7gNo1uiafrrzowsXOS/jXLYTa7lJ
 wkEPysd1uqcpqQzP+xA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170032

Hi Jagielski,

On 7/16/26 15:59, Jagielski, Jedrzej wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> From: Yun Zhou <yun.zhou@windriver.com>
> Sent: Thursday, July 16, 2026 8:47 AM
> 
>> syzbot reported a circular lock dependency involving tty ldisc_sem and
>> the networking rtnl_mutex. The full chain is:
>>
>>   rtnl_mutex --> nft_commit_mutex --> ... --> ep->mtx --> ldisc_sem --> rtnl_mutex
> 
> still unclear where the first mutex may come from

   tty_set_ldisc()
     tty_ldisc_lock()        <- hold ldisc_sem
       tty_ldisc_open()
         slcan_open()
           register_candev()
             register_netdev()
               rtnl_net_lock_killable()  <- hold rtnl_mutex

> 
>>
>> +      tty_ldisc_unlock(tty);
>>
>> +      /*
> 
> this blank line is redundant i believe
> 

Isn't it common practice to leave the first line of a multi-line comment 
blank? Does it violate the coding style guidelines?

BR,
Yun

