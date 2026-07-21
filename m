Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020106.outbound.protection.outlook.com [52.101.193.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BDE371899;
	Tue, 21 Jul 2026 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784602959; cv=fail; b=MZuoCfK0nPhEY2Mxp5Sm+IfsLAHTuWutaV2nRcGqgE5Vq4ul4RLGKZHyfw3qPoV6soKg2qPoCGmDSpLvCeW/TyV6Nxq3Sd1exX9zsMx+hQKEeH5VYKShPcDdKndXKku6+GSy7MMNGB+9N5abkhhI0xp3II/J+YbvBgcbrlDAahk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784602959; c=relaxed/simple;
	bh=Yd71kw5fHhY3uSJlFFEyvITBnAzYRwIkChSZy8rGR1Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AqdzeJQG1IeOEkw6Za6dpkgGj2fws4AO1RCl6j2R5FYDlITDUITFTROtbkby+nWRToTEt7a6zHxU6HIOTnufUmfTfgLQfTJfKWIyKtq4AWFzx8yhW8h/bYuMXdO4riiXtzrZSfy+AWxIhhZqkXSdCf8i/NXTIrWqQrs9aJotqeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=nmrVObfj; arc=fail smtp.client-ip=52.101.193.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="nmrVObfj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbLW74/+rQvwVporZNgs8Hcs/51PYxb/8qd0Y5mghjdtQs86dJL88OlpYSFIf7JptjbPkAlFwTbsQU9GLRdqIWlXPfV3Y+yjJfS+3IzDKICMRzn4DhPGdtUzCWUgvvOyzhHb9032juj74bBYm26aVdjSQE/YjKK80kQCjDlrTEZAyhWI+HY5Q7VOlEcUjBQHpLkvbAwFW2gWItxLRIWLuRX6LoPemyiqpQ0WNeU+4pOv5KmGq5AjdZ7PJJvOHDWMu1LDqLNYzo4OizO733lnZrejmAG443/UGD55M69vY/ULhcl+0iF2xY5gP/fOaQH0MWJgBj6hGufue6DreRYTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZtDvltXluKEJ7wVN4PEV2DdIqzzBtIGG9p5s5kxfnw=;
 b=ZY0FTFwETeCRMnSfWXL0Dp8MH7OaA8azvdAVOzjfE1zuRC+We2sx1C767fL49QxIYIaDWkP4JxuSeZLZUx98vw3cxBIFzzEaSDoCfmVGaYjaDD0xkzaMWZi2uP2qHmpDvcfXZEsNTrS6wxifj3LLnIQD+trGnh96nmv60kcpoOvt6XJHuwFeyR+1jfut1hJODSAEVbAnkeQAXoeCJ3u7hgC+QeNG4jsvuCDzqTVnpA60n3MTGaxKy+FYuqO53y06OiWP6QJJL91FL9tc087iaXOFb+2y/+AqdZ6p+XKiHA9+8/BvbCpimjiaRZQWMw99kvAMpI9i9qdOgR5HVE5LOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZtDvltXluKEJ7wVN4PEV2DdIqzzBtIGG9p5s5kxfnw=;
 b=nmrVObfjo2ggtDt7AICyf905vrXhGrrXq6R1cACXD4QOPyRbP1GCxtC+8jrV6NrhhldbpZo5HnAWrfx7MxkDTuthHYqmISl/I1KfvYqJvClhuexFP0EexwDHdLMuCw8p4PsKJmu8Qc6e01MrNjJoCh+h/WOG/YYV50zqRzUtJ/YMH+9dY8zbcTggXy8bLvmxuKD0Dq3OXgqkMqTzNiIIhdgdwGp4awn/NzSRVc/onHZG9xPuKi9QTa2xYHvgUBXtFYQ9VWoZrgDR7001HMPHO0BQT8+i0tqTiRAIVAYjHSWf/O62jFqGi0Wa4kL8NCkZZcui9Mlix6YH3IFX2b5evw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from BL1PPF1B62FD55C.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::d8c) by MN2PR18MB3769.namprd18.prod.outlook.com
 (2603:10b6:208:21c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 03:02:35 +0000
Received: from BL1PPF1B62FD55C.namprd18.prod.outlook.com
 ([fe80::8726:2e55:848b:39e]) by BL1PPF1B62FD55C.namprd18.prod.outlook.com
 ([fe80::8726:2e55:848b:39e%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 03:02:35 +0000
Message-ID: <3fd930bb-6bfe-46db-8bcb-5e61d87cb3ea@axiado.com>
Date: Tue, 21 Jul 2026 11:02:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] dt-bindings: usb: generic-xhci: add Axiado AX3005
 xHCI variant
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jan Kotas <jank@cadence.com>, Michal Simek <michal.simek@amd.com>,
 Andi Shyti <andi.shyti@kernel.org>, =?UTF-8?Q?Przemys=C5=82aw_Gaj?=
 <pgaj@cadence.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
 Mathias Nyman <mathias.nyman@intel.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-7-c429095143ec@axiado.com>
 <20260717-sarcastic-hyena-of-music-27cc5d@quoll>
Content-Language: en-US
From: Swark Yang <syang@axiado.com>
In-Reply-To: <20260717-sarcastic-hyena-of-music-27cc5d@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0011.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::17) To BL1PPF1B62FD55C.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::d8c)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PPF1B62FD55C:EE_|MN2PR18MB3769:EE_
X-MS-Office365-Filtering-Correlation-Id: f804f5f0-9704-46bc-17ec-08dee6d4839d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CO2iEna+PaGo+FIzkaiU7C/b+DQDj5B/hbmc8D5fY/YvDALD90z9JmeiJuhMpJ8D1apfVbMPoD98g9wBVWk/dpLJfdJSs/w0hQkPTrdteqyzc5v0LSgQtzvV3QakdkzmKeqD2WlzSo0cE5PH8NRq4/NnHNPPRYCHP+LZOOitg3/iINIwPOTKHZ11d1Hjcg01PTRE5VdG+11U1hjf/4xiML9xnYFWEspBsIc/dQpsRtSxeb1Gj7lCYQPj6QrlnNIUG1tzdceD2NKhPWJxDMvivBdR+UTScfujfWVvJN0gSqli0oJHhyjbc2wN1pqrBbv8pv4oK9/kIzkusT7SACh0HsVXyL2XWMKxXa4/a37dbTRLVRtwDq+D2Lk7VFFAAGFI/sO5hn2hfNQA1GrB+p01gRByNTPtNyNbwJj4lJuV2PBaE5p/4NWKUIFAglwSpEGiM55F8YNwC8WpFUfqUq6ZUdFkCXkK2bujg8aFohkfQOh/dS5ePdgFRWC5G31GG3k9P6XA4Ad7L+Ey8ojXtmf5Cf/+QSLf7dzMYzkXo1t951mKtiMEKpQBF8PqiBUf8/6jGkxFG/GVD1lhNA4WOK9ksLpWtk0wH8v+zKa0xgHYea/RxdgcF/pF/199A6m4iXmYBVhucXdMYpurIkQY++OzcOiPA7RskOEv24yhv1G97zY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PPF1B62FD55C.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VldvdEdqUlpIaXFnNnV0K1lML1RRNHZTOWRtRU9xUGYxMjEzYjBxZGI3UDEz?=
 =?utf-8?B?Kzh3NHM1cE51WFRvYjRPcHNhQThPbHhlSkVaeVpsdlhmOWg3d0Evbkd2S1Za?=
 =?utf-8?B?Y0l6R3Z4TFA0dTBIOVBiT1dqQkdkTVFMYTNaV3V6ajFBbHNvcis2aWdVK0x3?=
 =?utf-8?B?SURhZ0FBcDRJbGwzMFZpdmw5bjRGRGJxeXYwOUFXQUh2c2hHTmlGU2NSNlVh?=
 =?utf-8?B?bHcxYTBaYnZwRWc5dVNGR1BRNTNxUXV4d3BDSXJQb3NUbUI3VWU3V1FHQ0tj?=
 =?utf-8?B?MVpwbXFNWDJFSGR2bUU5eS83YkdaWENmTWx3RDdmbmlrMFRYTGs1MkdvYU95?=
 =?utf-8?B?cjhvQi9hMVdHcjhRWmRlVlVyQ2g3dEovclJxMStkdCtqTUdvRzhEM0orb3BW?=
 =?utf-8?B?QWpJRnpEc1VOV3NYVnlKVWVHaVN2VVlkUFFlL0VWYkxKdEE3QUp1bmtJUkRC?=
 =?utf-8?B?VXU1bk9OV0dBZ0VHL2NVY2VHVEtCU010elFKT0tvUDg5VG5iZThLWEVuU2N3?=
 =?utf-8?B?RW15VndQcGF6UkpKMzNjdUJyQ3ZyZmxBdWo1S3UyWWVKU2lHd1VXZTFpdXFu?=
 =?utf-8?B?czlzVEdrMlVFQk9taE5pbVNNa3RqODA1QmFYV2RLQjNxZVJCck1VNGd5VmI3?=
 =?utf-8?B?WUlQZkZ2ZVdWY2hBdlZsM09NYzU1cnpwYUdsUnRrRDkxMmppVFh1UXRndXBM?=
 =?utf-8?B?WThXWHZZQU5mRjR4TzdNaFZ6ODhocjdTRUN2NVExSWVEZ1NpN0J5R01XYTNX?=
 =?utf-8?B?OHJOWUI0Z3lRT2RzNkVEQ1BGK2phd3dtYnJFRWloZXU1WW9IaFUxcUdJbkV5?=
 =?utf-8?B?bDZRL3FHVHg0eDRHNG5idkNWWmllWXZnc1RLZkFZZDJLMGhvVFBVb3ZiWEIv?=
 =?utf-8?B?ckFkcXVwNllCbDhNYzYybmJYczgrb2ZUUTR6TVcwMnFVbDZxMngzTVFQQmxF?=
 =?utf-8?B?aVBxREdDL08xemxpWmFROUpJVitOekJUcWQvTXlWVmFPNEJxTzdTRmFJcXVh?=
 =?utf-8?B?SGdoSUNxOHNxeFd6NzU0TTMvQnlBajBpelBSMXdEMXRjVUJqckNKSitzQjhG?=
 =?utf-8?B?bXRpL0lTNlR6Vlp2TkpvcThkU2dlRWZmYUh1SWFITDdCWjdSaFlnWWhZYk9l?=
 =?utf-8?B?MVVFdHRILzZxVGpYemhTWU9GdDNSeU12T0pickZFSGd5VkFxTDRWVVkycGVu?=
 =?utf-8?B?Z3NGMVhSTDFLcERnNVNmbFhKMUt3dVNhQkJ3WHVKZzFOajIxc2tvVVBUODNu?=
 =?utf-8?B?YXRXYURrcW1QVGttUDJFdWcwbmxsN2dxUXdSckFGN2M1TkRETTcyMGlJM2Vz?=
 =?utf-8?B?Z0xJVHI0VDRWMkg1Z2FGVXJTVFZMWW5nK0tVNFFvN3dvY2tKMmJtU2d3ejVQ?=
 =?utf-8?B?REJxajJlSlRhVmJwYkNxcjR4TnlyemxSS2ZOdXczS1AvRnZqODZobGIzUkRm?=
 =?utf-8?B?OGVPT2QrYjZHTDg1a1NFSzU0dVFwdzZpVXJRdUFhd0FUWFNidVRtNFdSbjFn?=
 =?utf-8?B?bXBNNFZMU0FBM1Z6TythM2J6V0k0eGFLd1d4bUJBZlFtR1cxMkZZd1ZOdVd0?=
 =?utf-8?B?UEl0cWxCZ0Jva3doVVFFL0Z1YU9wVkEzbXRPSloxbUE3azkrbzc4Z0xkN3Qz?=
 =?utf-8?B?SjZxMzJTNU5UaGFKd0ZqK1dSOFh4N3V1c04wa0NmcUpPcXp6SjhsZ3NCZ1dM?=
 =?utf-8?B?dVZWa3JLQ1RrZkx4ZVBhbjNqSEdNL3V0bHI0TUtXUThkcmdBcTBXazBGelRw?=
 =?utf-8?B?K1BDQnJYSFZsY09BRzFEYXh6WGRlR292NlRET3RJS3k0OWVKQ3A1dWgzWkwr?=
 =?utf-8?B?MGxGMkFFY2RjTEp5YVRTUURSclVUMTluaU85cTBDQWpKMzREU1JnU1RZRExu?=
 =?utf-8?B?OGVkTVhJY3A2SE9VMU9qM0VSRTZ2bVpNQ011V25pK2VjU3FkbUh0aC9iaW1J?=
 =?utf-8?B?RDdxcWRBZkZ5YXBBY2hIZlJuT0UvM0cxeVRyQmo1S0UxcDcyZkN2VkRLek12?=
 =?utf-8?B?bzRaQThqY1A3SmpWRTNzeFRqbVQ5Zmp3S0tTV0thV2FJZk9SZkdidUhDTTJx?=
 =?utf-8?B?bjdaa0ltem1PZXJCSk4rdGdxWmV0ZVFnOUgxT3poNHhXVnNVdmZONGpXRG9X?=
 =?utf-8?B?R25uZW9RZ2VLMEM4SkVubnhVbWovM3pFZnI4dzZITGd3bTMxNjY4eW4xY2xS?=
 =?utf-8?B?OUJBSFJtTlZLNlMvSlBVVmVTZHJDMGpjc3BzbHFZSzJ2OWZEam5UejZvalJE?=
 =?utf-8?B?bkgxRzJyV1A0R3lWeCs5cGYrcTQ2SnphaTNtWkZjZHJmcTRBb253SFVFUmJl?=
 =?utf-8?B?UTY3a0RNQjNBUERCMDBMOG16TkxlN3VXZjdvVFpXMmVIdzk1czJ6dz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f804f5f0-9704-46bc-17ec-08dee6d4839d
X-MS-Exchange-CrossTenant-AuthSource: BL1PPF1B62FD55C.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 03:02:35.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nlq8qfUR2ktgfEo2ZiJ7opaEHIDq8WU7iuvuyNlD1DCaaA9Yguyi96tvXBzQJbfh1a/jhwrHqgFCBfPqeHsHsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3769

On 7/17/2026 4:37 PM, Krzysztof Kozlowski wrote:
> 
> Just add it to the enum in "Armada 37xx/8k SoCs" group while dropping
> that description. Description anyway repeats the compatibles so is
> completely redundant.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

Got it. I'll drop the redundant description and move it to the
"Armada 37xx/8k SoCs" enum.

(This will also be split and sent separately to the USB subsystem in
the next version).

Thanks,
Swark
