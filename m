Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022087.outbound.protection.outlook.com [40.107.75.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C041CAA4;
	Fri,  5 Dec 2025 03:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764906457; cv=fail; b=BOSEaRIrmGQIlWTB4gbduaec0ZH8XcPhIlxVp21TER81FOv3hpwThjy8EyEDbAhgnA01gNgjLnWcRt0EFAK8jQ2CIMTLQpIONZAgMoR7Ov+R9JmG/GK4r50nFlNIWzTn9mvu7k0z/sEiHvCVTq0+5Cxt8hDg4PmyA2vYWPbadWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764906457; c=relaxed/simple;
	bh=nQeOOr82tey+VjfI3T0kLuMucldirQODAdoPBav1+7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=khoPFN5ldX1+cQXSxGn5tQw3t5RStrct6zEGUSBY264cVVfoB6/3tTY6IkRJz9EoKnVg0uDO15QM23pzObld+biP+DJbfRFxf3KBZzIu52o7e9Od/NiU4GRowm3vJKrt35AiEeS18V8mBLyUhKLPmk1kFRfy3m/yFKtupzzoRz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=FHehEcuZ; arc=fail smtp.client-ip=40.107.75.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="FHehEcuZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojMXIK9iUCOCRVEexGlL3sOIaxwok0To+5IEj2bIHo3XWFRaMJXJW3eX6nUUQ2sSO0Vbq1rIOr9HVdcTuPl01evg7szXBSC2NWjzhBd5vFdIBx/Bea2GQGdcbb8R3FDM1K5aamhwlVjiHmujs4tBsm/MM3kH228ei6eeUu2tWoW/doGWcoqNRQ2upnBa3yAaBX4OOdNlfaeo0zXi30PlBzANamjV+a6Ti+Gf7Wjjte0ua5qlXMA51pqLBIKdfRXCXDl7zx5RUb8sP6FXb4dtxJTwzLQCpRBMND9LeO9CA97UbAtExCIblRt8vwKnc5MbuC1RIKlyst1tGjbgkDLLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7GgCcndph3xxFO1AWmtFsqZlXM89INuCRjARlQJqRo=;
 b=DLOxjBaFXVS2YDtvbHlY5KfGG87olyM6ScuzMgodu3Eqn3EqCK2DWgdCjnp6qCMf1ygLCcutswlSvvmLpdGI5LBT6qwg0j8rZIe3vnS3pWt7lhc08CGL2L1xU0uB6M/uA9p+V6rqe/iFfhL8V0T6qO7hLu4icGmtc0uNk37URhpnnPZ5STP8M010aokH0016aVl0vhPgDvSd+C8iqHZuFtX78/nx8yuJeCTdZ3ypw49n4h6mbns3Iz5ow6EnJDF9tw8hh2Ag3TKz6drtP0l60Yxvt43/Npdhg0zP54u+D1fNoWmURqBVP+rxKIVJPxW9qakV7ANiZRpAdMmzh4VR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7GgCcndph3xxFO1AWmtFsqZlXM89INuCRjARlQJqRo=;
 b=FHehEcuZ5f3zg5YkPxdICn133gasVw8giyCyy/Mihauem7ULSMm3J3y2msDHt9vMsln6l0FFC7jfU5zyroxzM3AFaM5P+s9DtXFV3LhWUaF12baAOKOmLURayX8yme4lRa/6vfzUQmwiL5tzDRkEaFlNJeJUfx7lSpE3E6cDtkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB4456.apcprd01.prod.exchangelabs.com
 (2603:1096:101:73::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 03:47:31 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Fri, 5 Dec 2025
 03:47:31 +0000
Date: Fri, 5 Dec 2025 11:47:27 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 07/31] serial: 8250_mxupci: add GDL-based Rx routine
 for 8250_mxupci
Message-ID: <aTJVz-BZKUjahVSK@moxa-ThinkCentre-M90t>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
 <20251130104222.63077-8-crescentcy.hsieh@moxa.com>
 <CAHp75Vex-YzE-0PydYcSZGd24hkmbBanVHRTSsWQ_X-bc8kW9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vex-YzE-0PydYcSZGd24hkmbBanVHRTSsWQ_X-bc8kW9Q@mail.gmail.com>
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: f04fd4e9-5eef-48e8-edc8-08de33b10474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2U2TVV0ZExSVzdaODZDMDluRklyL3NhWDBaRk42U3ZhdWdNSGpoOUNLSXgr?=
 =?utf-8?B?YU1RVlorVFBFUmxNSm81NnlnR3BtMmRsTkNWTlorcGhQVFQxQjk1cFo1cWJQ?=
 =?utf-8?B?VlFMQ3dpUTRaRjQxTjFoTXk0UGNkTi84M051aTVxdm1udUREMkJOT2NhcWJE?=
 =?utf-8?B?ekY0MldEZjFpdldGbGgxZ0FlN1QySUlpRlk3cjZJZGwwNUgrY3Z6TXlmTzMw?=
 =?utf-8?B?WHpjdDNLOE10RTdIUjNvRGRncGl2Q3BGRmJEK1JzZ3pTOFRUb0U2ZU5qT0ZK?=
 =?utf-8?B?QUloQjdQNVY3b1d3WWlLVmhVWlFjZjVOYk1uVENoUHZ1TVJCUjVqMUZwTHdk?=
 =?utf-8?B?TUFSV1phb01qelU0N1FkYVVIakdPeU5nVUEzNS9tT2ViOWdzdmZCazFaTjVW?=
 =?utf-8?B?czB4bm5sbVFrSmliWm1zMHRIK2hRYldhVWNMK2NmeDVNdGhhNDMwNUd5eGgz?=
 =?utf-8?B?UEdiNEJuQU5scVdsSGJ5NFU4TFJTOVJ1MElqUXBJcDJkeGg5VEM2T1F1YjFm?=
 =?utf-8?B?OEVDeXhJc2ZaQzRmZWlpRkQvLzZ4ZlcxbGwzS0NPSFlUWDh4N1ZjUmJXaTRL?=
 =?utf-8?B?S2dHSitwdUFjQzMzZGJoVUhhZkx0RTF6TU9zTFNTc3J6Nk9Zdktob1dYUG12?=
 =?utf-8?B?UmpETmUxVnZybzJ3ZGVnMW16YXRCemNxQVRtUUczSjRNdFVwdlJIRi80bzNa?=
 =?utf-8?B?VUFlMldCQXdwOXV4Q0MrY3NBejZSN0tKWjRqa3lTRGRyREVTRzFzemEyZW9q?=
 =?utf-8?B?bEt5RC9zVG5ENUhQRmM2Y1I1a1Zpdm4yb3N1TXptUHNUc05vaDBCMmZwclFy?=
 =?utf-8?B?Q05mblRiWHM3RUZBUUZEU2lLeUhFVnlQN1BUWmV3SFdoeTJmT0JUc0RlQmFh?=
 =?utf-8?B?RmYyMGFiOE9zOGxsT3BCbWl4RGNaMjB3c3RmNGQ3TWZrUXhPcnBTQlRicXNw?=
 =?utf-8?B?QVhTN1EvU2lwMlhoUlVvVGxCYXdZVTZ3Z0d6N0w1bktHcGdHU2EySlI3M3FI?=
 =?utf-8?B?MGJuMGYyY2t6aUdQM0tTaGxVbnVsZkxOWkJjWS9iL2xBNTkxMXRzT3BhZStv?=
 =?utf-8?B?UUprZmNZRzcrc25OUkFIQTlMU3Nrd2VWRm1maFQrOVdHYjcrdDA3RzEvMVU2?=
 =?utf-8?B?YUg0cFE3a0o4UVErNmRVK2RWVE5JN1lxWVRIeUZCNHVLbkF0VlVnYllFTlp4?=
 =?utf-8?B?RE5kNkZ6YjlvMXppRFI5dWVHT0RQRlBWaTZSLzM1dXhoZHlldmVGdVp4Qm5G?=
 =?utf-8?B?U3pJQ0JZVDU0SFlNU0gyZWk5YVVCdmM1ZWpBZ1RUSTNzTktsVTFrbUdpN0NB?=
 =?utf-8?B?aXBJQWp0MVZBaThaOE1FTUxPN3F5dER5c1gwY2FzNGNqeTFWd2xXS21ZYjBj?=
 =?utf-8?B?MXlYY0phTkMxSVdpRnFneUdKby9tZk5tZm9FNlI3WTQ2YjVYTjhZc0kyRmli?=
 =?utf-8?B?Nk0xVCtaTjNRU0tTeGJGSXVRSUluK1VlWHNDUXgvU3BuOFZHYnlkODd0M3NO?=
 =?utf-8?B?Vkp4NDhFNkEwQmkwVU94QnNZOVQwVW9hS2puUGdaTGRHMThyYTlJWHdJOG1D?=
 =?utf-8?B?QUZxSVk3MHowVXE4aFd1U1djU294Zzg4bHFLNGJzT1k0Ymt4QWtOWTNRLzNi?=
 =?utf-8?B?QmltWlcyL3hFNjV2WUs4MVVMdk1XSGJBM2lpV3BCUWFTa3hYZVdKeE5NSlMy?=
 =?utf-8?B?eWovbE53NkdmMnMvbVJ5UDVaZ21DRUVpbkFoUGRaMWljSWpHOTRFYmhVOGFn?=
 =?utf-8?B?RGR6amNiY0FSV0dTd2d6Vm1SSGlicWdHc0N5bXFBSjNiV21oTHdFWUpmUnF6?=
 =?utf-8?B?WUs1SnJUb3pCSlc3ZUthbnFBMXU3VW5EQ0RzekFLbXgzblh1NUFXRWJoWTE3?=
 =?utf-8?B?b1pWd3lVWXB6TjlhMUwrTTJwQzVvV2UwYVNJeEx4ZUU1a0ZOYVhnNmtGM2s4?=
 =?utf-8?B?U1I1R2QrS3dXNnRnQmsvZ3Z2T1ZSamFVcUZ2Z2ZuSjF1NXo3S3ZBSm9EWWIx?=
 =?utf-8?B?Zkp5TncwUWZFZURZaFI5bXVyUWRHaXJ3Ump5VUdXalZZOGtJY0U5blZ0aHBX?=
 =?utf-8?Q?fEE5gF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck1xUWVSQ3R5OTd5a0hkNnp3KysreWhMVXk4MDM5b1hRWHhhTzZyYm9xYllU?=
 =?utf-8?B?UjdsNVIrOENUUU1hVjI3YnVtU2F0bCtDR29XdUVmNE9uM3BxQUh5aEE0V2l6?=
 =?utf-8?B?U044SW5QeEhjUy9rZlJrcHU4c1F4am8ydVdyalY1WGt5YThOUm1TMDc4dU1v?=
 =?utf-8?B?YzJNRTFocG5vd3N1TGYzTTJxRVlnQnJDeGZhMXFlY2tsMGora2M2RTFQaDVX?=
 =?utf-8?B?Q243VjhidWFabk5oYzNGdW5wejhRRHdOLzZMVTdnV3oxblo2U1FrZXl5OEhq?=
 =?utf-8?B?dndjcUh4cEhmWUJXWVNmTEJDemVMZW8zNXhnejVuQXdWZnlrNURCTENvOThW?=
 =?utf-8?B?ZFZSMElISHFLTnYzZ250QXlzNGF3TG11WWJxU1JaNlRRUW8xem1lcmg4OXZN?=
 =?utf-8?B?Z2NIME9pNUhzYXEzdTdOTmVOTGNRaDFYUEswbmFwN05KVGVpSFRFS1pQM2l1?=
 =?utf-8?B?eUR5SkFYYzFmSkxBVzRmemhpN09uUlZaQk93aWE4Y3JUTWFMRkxJbGYyNjBw?=
 =?utf-8?B?R0VJTXNybHBod2FDM2owbmNSb2crakhUNTVRUUJCdHdjWDB1c21Ca3JZbi83?=
 =?utf-8?B?MkJHVldmeUVGZDhvNzZtaFF5NzJjcXpXQlJwSEQvZnJVTG56a2lWY0ZLendp?=
 =?utf-8?B?eW1DNWxWUU1pejhLRVE0OFRBckJmQVd5ejRpeis2UG01MFFHckorK2tCYmVl?=
 =?utf-8?B?alBncm00NURERFFJK1UxUVZZTUFtdDJQanptcXFFcWZmWnFuSGZ3bDlCNzM4?=
 =?utf-8?B?dVlVa01YeUlLajF1MFlBd25HYWU1SkRva2RGVzVWdkpycmJ5WXU2aVNHUzhW?=
 =?utf-8?B?bi9xTmdpTktCZkRJUXhqZStpeG9hUFBEQUREcHZJTVJhbEJZSG9scVBWb1Az?=
 =?utf-8?B?MWtwRkp4UTBxbkxsQStxaEUwYWJBREl4cUtieVRRdDhJdkNSUEY5NVd5MGM2?=
 =?utf-8?B?dFRJMHNMbHFoWFFTV0MxbjR2Z1Bpd01lUTRVOW9Da2k3NjN4cE5pZ0Uyc1ZC?=
 =?utf-8?B?cWdRdkZOWlpGRXlzMW9hOFhHUmEzS28wNWZQdGtOampQbmVxbUVnUUdpeXB1?=
 =?utf-8?B?ZCtLaUpZOTRTSnR4UE9KN2dVczQ2S1JvUmhEZEpSZlFYN1IyL1lGVkR3UXVS?=
 =?utf-8?B?VWpkOTVxTXZuUW5lMFVqRWhYdVljUjdXSUlteGJHUmhGam55VGcvN1FBOTV2?=
 =?utf-8?B?RmhWRUJ1TTc1ekdMcDFLQUhIMkFQaGtLaktIM0RPSnd2NzlzM0NnUExvbG9w?=
 =?utf-8?B?S0tTVEN2bG01Y05McVpHV21YTUFQMXhGd0l2bDJLc3dzN0JnM3hYMUlJSU5t?=
 =?utf-8?B?RkptN2IyT2w4NmlZUUtyU3Faam5OVk5PdHlrSkwzRENzbVpIZzRCVWxpMjZD?=
 =?utf-8?B?T3lEVDdjdE9CZlRVNjNoTEZFZy9MVTRwOVVKMDhuNDB4cnkwWHpRem5CUEVH?=
 =?utf-8?B?MU9ORDdadXNkZ1c4RWlybk1VYlJsYnBkUUxvcDY1MnZCOHVJaFUwbUN4aEl3?=
 =?utf-8?B?dGc0V3grRFF0dFBYcUlmOFNNb3ArUEtmU21OZnZqSnlZWTY1d3dKY2tVcVEy?=
 =?utf-8?B?NG5RNjVNY2ZqV1ZRSnRRY2I1aTlpWTJScHR5anEyZWdnNGxIS3VpMUtPWWZV?=
 =?utf-8?B?VGdESERUOU9heTAwb0Q5V3dxRElQRmhSSWVQN2xvMndwNnVDcWJWZmJGeGsz?=
 =?utf-8?B?U3o0Snhrakd6bW9lemU1SjgrVjF5N3JWYUE4NThuQlJZUFRCL2NsZkVzYW8w?=
 =?utf-8?B?MFN6UmRjcUNxTnArU29aL1JuNkl0dGE1Q2NwUTZBZGJsa2JsL3IrczVaU2Qx?=
 =?utf-8?B?TDdoaHFVUTVUWDlXbWpDRm51NHVtVThQRXhmZ2cwaERrVDVMSGpiZ0JTYlJm?=
 =?utf-8?B?WVZsc0hFeGM2cW93cHU4R0ZhR3A1aHNqK01MeFRrVVkyMkRyNjA3SjNVelor?=
 =?utf-8?B?MEVjN3NpVnZiWDJPUGwwSEpjSmdtNURRWnpSL3c0WjM4dnNhcDhSOEE0NFBo?=
 =?utf-8?B?L3o2aUkzNWNMcFNra2VqSVZQWS84WkY1cEE2blg5akVGa01sZUVzMkdDTGFP?=
 =?utf-8?B?WmlXUksyQTZodGhhQnVzNFU1ckUyRTNWR3A0SC8waklDTUxSMGhZaSt2WWZ5?=
 =?utf-8?B?blcwOVJyamljNzkrRjBEZ2JFRUN6OTNmQ2FQS3NqRHlVeHNiWTVYcXQ5eGZj?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f04fd4e9-5eef-48e8-edc8-08de33b10474
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 03:47:31.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUEXQi8mdYFUit65bWZvf1A2IH7z+ZMt4ywLVjObSBVY+TT1OQaQntf0/r+/45Eq7yy742eW1t6HFQBn/RpWBLI35KajD77/ch22pohWpAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4456

On Sun, Nov 30, 2025 at 07:29:47PM +0200, Andy Shevchenko wrote:
> On Sun, Nov 30, 2025 at 12:43 PM Crescent Hsieh
> <crescentcy.hsieh@moxa.com> wrote:
> > -       if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx)
> > -               lsr = serial8250_rx_chars(up, lsr);
> > -
> > +       if (lsr & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
> > +               if (lsr & UART_LSR_BRK_ERROR_BITS)
> > +                       lsr = serial8250_rx_chars(up, lsr);
> > +               else
> > +                       mxupci8250_rx_chars(up);
> > +       }
> 
> Oh, can we reduce ping-pong a bit (the modification of the lines just
> being added earlier in the same patch series)?
> 
> I think you can create a helper to wrap 8250_rx_chars() with split
> version of the almost unreadable conditionals, this will also remove
> the skip_rx variable

I want to confirm whether I understood your suggestion correctly:

Should I first introduce a small wrapper function for Rx processing,
move all the complicated Rx conditions into that wrapper so that
handle_irq() remains short and readable, and then, in a later patch,
introduce the actual custom Rx routine and update the wrapper to call
it?

---
Sincerely,
Crescent Hsieh
