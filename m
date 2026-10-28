Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.35.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793184738;
	b=CP+FrARoLa72SnMrTpw39gU8Sy2whHaiSZHcjbP/Gf1RsD6l9iRR7bloc/Tn+3oz2KSg
	 hpEFX1Xoj3wZ9eJSMivlAdZnB2TOVgW7X+CmkLOfQ+cE9YWcaExNJCC2H7SUDOl13nVfE
	 XXkIshxYFlzS93OgPyInLTwanNaJue9fA73UZ3cnPc1DpTxDabjq5bFmafNWvl/QS49SB
	 L9XH/m6hQAeuMDEwBm22yWehIsBKg4fwtYykzyBfEM2zjIYlQFBg5khy9TOB747OeAwuH
	 k9c4gVxmn6NHrcpVAZg6F/7HbLBFmatMLE61pdRySwgq2en+9fxVmgpya3kkUk5ZzJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184738;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=B0PJLIg8RnihUxg8nTzahYsJs7Xlu6ICEYUDTi5NmPE=;
	b=qAV7ZhwN0vzY/oQHTmpMIqX82by6xbL5aOEwrXYxz/YrgVRkxy2srC41/zADfT1IZc1R
	 N9OVluXZEd9RnIOvswYht5nNa6banFY31BRIFUTRpHhouX7Hj97Ar6BDidZ4AlihSLVzH
	 Kdp89J/ugnd2MX68aOv673oPoKE7dYop33oyyykQCvNMDBGK9YMQO9xE8s/7fZh7ZKVO+
	 NYJ7NadruQTo2k3GkhoGDf21/NT1u/x208MK0IQT7GnSTOpHDVdXN+XekEF5PL3DkZQD+
	 dMWtT9hVbdHx2VCuT6M12ftn6qD3pQsElRykQ+y1Xg/7ipviTASqxL3nXZkEM9mpVWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=live.co.uk;
	spf=pass smtp.mailfrom=live.co.uk;
	dkim=pass header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.a=rsa-sha256 header.s=selector1 header.b="rD/dR9By";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.35.78
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013078.outbound.protection.outlook.com [52.103.35.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50955606A31A;
	Wed, 28 Oct 2026 10:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50955606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.a=rsa-sha256 header.s=selector1 header.b=rD/dR9By
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dH62boSj1lP+pzFlYJtuB8lFt6WZpv0418ELiSZ4KL76yZMmPIb+mqKwPE7bz03sIC1bRcJFZcsMKHkawGZqaRUmef2CPAZuIUKFLgDo6bJm6iyj6LUdikeUX9zi0/DJj5rhRt4uYe7gTzoUH2D96YCuSPcQhhw+NNlagrsPi/eDGWrr68zf+TYgECZ+RsEG0BUdwocrNPcPQhjCiwdaJrkCyXQsiEzLkD7DU1SCYXKQeAYVuod5Ug0WtGtqbXch9Bdv6B+VWyUpI4X2vnwCeshi6fXCJBGkendy4fp8t373oO0vDbvPQLrH0ZdmV9GTP5gjeDvIB8xX+JiHjG9UMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0PJLIg8RnihUxg8nTzahYsJs7Xlu6ICEYUDTi5NmPE=;
 b=FyQ3bybcxqAMDzst224WIXfW2w9BuMKXe+SuaRMb+aC2BW5VLzXBz0Fh5gQE5b7GkXuJaQ6kYHzYzvD6RZVo5xLjnTI8rjioiPAhvMu5fbud1120kDFmZtZ3r6GGkc6D3keSK0JAVtoguGumyuwmNnQDgkmASnR5GKViMYhwt0IlxBHalREnCKexl9obxzgWEgd7Vd18rzDfNhwemqg3MlKShubrZxjqah/3znhnJs4iZcmdLNKLX96v/LyOVN44Opt4QAn882dyf4e1HzroTSy+UGIkzH/bcZMEPfBP0H3AmWfJk7hIsx+jOI9d85bjBXN4e1TG/k8W/EJo9MEDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0PJLIg8RnihUxg8nTzahYsJs7Xlu6ICEYUDTi5NmPE=;
 b=rD/dR9ByVfE/G85m2rXlnBLf52WQVo3ppmOpjLmkODPxFUWqWk3tC7ek0ZBN+sMweil7zEJrm9lSaN0sW26gH/3q6tKkAo6ckNp6v6QpBJgRgB4vAiKLhIurn5Drl3xKEPT3c4HN978rlFt18nnFkg0cZ+Y/FuI8wOB8IUp6knmDBHekvhp6LY2MAQBDxrfOypvIMbVRnaJa8BOvcJyarXBtoKz5qUR5sQOXyBjXJll6861BEb/V2w4vFhHnh/i4kCCU4Ra2vShrBRKOrhchIR3d51tczB8hnqAlN9nmnQZ3gISQD1v/nxHAcmGvZIQh7XWg5zfbvOtyMAEZgm/3GQ==
Received: from GVXPR02MB12019.eurprd02.prod.outlook.com
 (2603:10a6:150:30f::19) by AS8PR02MB7127.eurprd02.prod.outlook.com
 (2603:10a6:20b:2ea::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 10:52:13 +0000
Received: from GVXPR02MB12019.eurprd02.prod.outlook.com
 ([fe80::d5ec:2c8c:3d7:fdf9]) by GVXPR02MB12019.eurprd02.prod.outlook.com
 ([fe80::d5ec:2c8c:3d7:fdf9%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 10:52:13 +0000
Message-ID:
 <GVXPR02MB12019B3EB555B0F744F294A3EC46F2@GVXPR02MB12019.eurprd02.prod.outlook.com>
Date: Wed, 28 Oct 2026 10:52:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/24] serial: 8250: cap OxSemi Tornado UART count against
 BAR size
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>,
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>,
 Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Peter Hurley <peter@hurleysoftware.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>,
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Robert Baldyga
 <r.baldyga@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>,
 Kukjin Kim <kgene.kim@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
 Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Marnix Rijnart <marnix.rijnart@iwell.eu>,
 stable <stable@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-11-99b0202ae546@linuxfoundation.org>
 <alpine.DEB.2.21.2610271300480.42255@angie.orcam.me.uk>
Content-Language: en-GB
From: Cameron Williams <cang1@live.co.uk>
In-Reply-To: <alpine.DEB.2.21.2610271300480.42255@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::10) To GVXPR02MB12019.eurprd02.prod.outlook.com
 (2603:10a6:150:30f::19)
X-Microsoft-Original-Message-ID:
 <57f91aaa-b275-421c-ac08-0beac1b902dd@live.co.uk>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR02MB12019:EE_|AS8PR02MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: cb041c7e-9870-4c8d-9231-08df34e18641
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|25010399006|4140399003|19110799012|8060799015|25031999004|5072599009|6090799003|15080799012|23021999003|55001999006|39105399006|24021099003|40105399003|31055399003|18071099003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVBidkt6ZEovSTAyS0lJSGdTQWhoOEd1Q09DdEJYVnUra2oybjd3QTB5Ui9u?=
 =?utf-8?B?cjZoZTlFNW9adkZ2dUo1RXBGZUo1aHhONEZSUW8ySE8wR1RQSlphaGYyazdI?=
 =?utf-8?B?Y0lqeXMxR0x0aDJHMkYyVW03VTdSdzUyeUVuZU42S3JzRDZ6b1JLMkVERkhY?=
 =?utf-8?B?aHpnZ2FjKzk0SG83L1Y2b3dvWjlNbllpZVkrVldFSmNHZi9JczFUTEZhNkZ6?=
 =?utf-8?B?Mm1QcERoNlFHdk5wNXdIWkhaVmNFUXhuNHdzUGpMMFdjdmhNVWV5K2J4TXZr?=
 =?utf-8?B?SnZCcEtSM3pUc1lzY3FXWjdnMlFucG4vcTh2eEZSaC9ybXlmQngvQkd4TS85?=
 =?utf-8?B?U1Nva3lvb0dvSDdVMXF3bEdGemtlcFdadmpCbUppT1dROUxpMnVNMFVuY3p1?=
 =?utf-8?B?Y3lWb2cyeCtvaDZsYS9BVWFEOE5xdG5WSlZtSVN2MlpxT2Rrb3RFUXBvK2Na?=
 =?utf-8?B?TVN5NnV6T1B0RUNabHVybmZlWWJXNlhPbHAwUXRFdEZWWUJJcktCNFdtUzB5?=
 =?utf-8?B?b05GeHUvUW13andaTzJ0ckE5SlBsb2JLV1RxSnpLOXBDWG5ONzZLTE5hekFk?=
 =?utf-8?B?N0pCbWdsOXNEeUNBRldPU2JoVkQ3T1VQbFRqWlMrZ0xoTVdxZDJwczJBREd3?=
 =?utf-8?B?Vm5CckRYVXFZQmlQUWlnUnFXY0J3S1ZuM0laTjBOZGthb2s0QVpZazhIdmp1?=
 =?utf-8?B?UlFXZHlwNXVXQUxSZ3MxQW5tc1JOS1ZFb20vVUZhak5CWnpyamFBRjdsMWw5?=
 =?utf-8?B?OCswaHJsZ1VONlEzMzBQSk9kNkQyRXVWclRhL0Y2d0xBYmh6dC9iV0VhS015?=
 =?utf-8?B?Q2tOamlraFNuSGRnNkpoK2RIZE1pMVU5QXVhVlU0RTAzUjBiNy9kUmJ1NXl0?=
 =?utf-8?B?SjFWenpmMGVvd2ROQkdHNUV3QkhvbVB2YWQ1NmRNcTBaUWhjZUUvTFgwNmlM?=
 =?utf-8?B?a1VXcXA0SC9ZVW5oVkpDOXQzanJ4cC9XdGRNVWhFdTFGVHZZSTFHMUU2RnhF?=
 =?utf-8?B?YUxUZStGN21oTW50TFk3TkZnemtDN1hoa3kzZ1I2K3J0SkZicXNLMWxmWW12?=
 =?utf-8?B?QVlVckZaTzhjb25JMFl0alF6S25Gbk4wVE9PcVpONjVIb2ZHUG5CaEUzMy9k?=
 =?utf-8?B?SWxzWUZ6WUpSenFjb1ZkdnFpSllYSjJMeUcwN3RubTNqZ1k0VDRKL0JXdS9k?=
 =?utf-8?B?bE8rK0VNc3Y0Qjl2OHdXak5BVHJVeUhZMGlSbGx5V0pMNFJpWmZPQ3ZlMXhC?=
 =?utf-8?B?bm0vSVhzeWkxUjVCMW45cWNJMWs5UUxLdlRKVnZobCsxc1FEQmhhZkY3aytC?=
 =?utf-8?B?Nmh3NjI2bVh0dHpEK1FEbTE3YWFQWUxCQzdYL3RtdWd0eDRqeW1ZVmlkRHpt?=
 =?utf-8?B?a0Y3UUY3Y3J4dG1EN3JPMTAwM0hHVENSdG1la0RGUjZyYTVJZ1dmUE44d3ZH?=
 =?utf-8?B?OFZZRXdiaExVWXVUbVNPR0VQeU1LU2dMOXRWUllmWlRFU2lFZGRseEs2V2dV?=
 =?utf-8?Q?QbjAsJnpSjKlSZHW0o0xcXBh/U/?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWdFL0Z2R2JOdGF3bVc4WkJVazNhZ0o0OUVabzM2c0FsK3BaVTJIYnNDTlU5?=
 =?utf-8?B?NThqdENMVU5pMmM5YWJVSi95VnliLzVwU3JkUkVobGxHTjlBazJmN0RPU1h6?=
 =?utf-8?B?RmJoNEZyL2RUNFVvUERXSWVQQWlJTUlqb3d6ZklQVDNid3Z2VXJFZFZCWlpY?=
 =?utf-8?B?Tnd2bkZOS1ZGMFN0Vm1kcHBVUC9SNldmTUkwMUNIR1ZkNjQ4UmUvU1ZZT21p?=
 =?utf-8?B?Si9IaFJCV0RDeEw3RHdSd0g4Q1paK1JXQlJSaU9OOTdhNVlrcVAzRXdBcVlJ?=
 =?utf-8?B?a0tZV1paQzNBT0VDOEt1LytOdmZ4ZzNCUnpwRis5UDUwZkhuTHh1Z2ZCazdt?=
 =?utf-8?B?NVZ5bjZ2WXZNZVlQMk5mbXFPUUJZOG5oeHlHYXd1UEVBZFJSWTVxWjhObEVU?=
 =?utf-8?B?ZVRlRGdMWHpTSGRDbXhYSVhFODVQdWdVbEdFRWZJb0VrYnFaUXVKNFA4dHJB?=
 =?utf-8?B?Qyt6TXJwTFBHVmVjLzNuR2x6NlJ5a0ZrZC9LMmI4TVYyWnE1SjlBdm1MbHFn?=
 =?utf-8?B?L1VLczFYYTVhY2VyTzV0NERtUkZzTERtUGVJVHdqRUFJWTA4UWxLU0h1bTUx?=
 =?utf-8?B?TWtQU1hWR0RjempSWWRwMytndFNwWkl6emFFMnVDRzQ3Uk1JQzFUWVc3c2hM?=
 =?utf-8?B?RDFKQnNxWmNVL1dOWmdoTTVWbGVFTW5XdHZOZCtHRGs2R3BNOWdFN1BHQTM1?=
 =?utf-8?B?cjRnYUhVL1prNWlubmVGaWpQSVVwdzdsWTJXSmgxVHA5VnVrV1ZiOUNYT2Rv?=
 =?utf-8?B?b3E1dFV2a3pQeExoZWIrcmc5Z0pHRlpEdDIxWmNCcVBRTmZhempua0RSUmZW?=
 =?utf-8?B?NmRpYjRKZGltTi9uMm5SVEV0VTZBdW44ajFPaVdvNllWV0pDaTd0OTBVWW1P?=
 =?utf-8?B?ZlhUcTV4OHNyZ3NmNENaNWVKQmFPYytLSmpvVTgzMEVZekx5RDB1MlpjSEZ3?=
 =?utf-8?B?cmpQUDBwZ2Z0Z0c0M2ZDZktUQUZ0ekJ4TUJJU1gzMUpZOUY3N3J5TWMyTlVI?=
 =?utf-8?B?S053Uk5yanVheWUyMDNoMWhMQXdacVBnYXlQa1VsTjFsYUZJT3ZvNTJ5eC92?=
 =?utf-8?B?bXl0WG8yRTFHRFRTVC9lRHM3Ym5nMkJYQXI1VmEwUDJBSU54Nm13STNGYW9D?=
 =?utf-8?B?cTBmNkswb0dHOTJPMHNTL2psYURSK2RDS2hTV0xoVnZHYi8xZTVYVVcrcmNi?=
 =?utf-8?B?Y3k2WkVCZUpWY3lTUllUOXJDSlpPS2dIaWo5WHpPT0tKZXp5NmFaSHg5Q2dt?=
 =?utf-8?B?TjJLbUEwdUNzNXkrSzVIV1B0a3cyZ2hpUmNpR2ZHUXdpd2p3TWFlK0ZUZGJJ?=
 =?utf-8?B?UnNPZU4xQ293OEZXcVJ3bkJqQStqZFppdUhPZVNMMkhVbisrSmpnWW83RGVW?=
 =?utf-8?B?U29FR3EwaUlOdWk1cDlUTjljUWFjVTNWUEZuSWZ0djdGWkdCM3QvaktIcGFV?=
 =?utf-8?B?Tm5nUG05RnNHYzlDbkptTE5UYWhaNllYLzIrK0ZhVERzc1NRbFlPOHo4SVVa?=
 =?utf-8?B?c3FzZVpwaFpaWWdGYzg0Nkx1ekl1YThndDMyQzZsWXBXcG43ZnNEU0h2VEt3?=
 =?utf-8?B?V3QwMk5zc2ZneXFlYXorWjFMQnlZRjB4TytCNTVOYzUwL2RxV0lVVzBrT2tr?=
 =?utf-8?B?dUI0dG8wSDVOMnprZkVTNjRTbE92KytIeTdxb2tvN1ptOXcrZEhFT2l5VmVV?=
 =?utf-8?B?amJsSXpxSE5PZDBaY25WU2pTYTlXNjY0aFpkcDZnMkNsSU1BLzJCZ01Ta250?=
 =?utf-8?B?ZnRodjRkdjNQR2NLTmtOUlNvcmV5bGQ4Vk9lMVIwRGpFOUpvdGRFbUR4aGUx?=
 =?utf-8?B?Z1ZZLzFTeEtqQWI4YWhRbEhBZmJnbTJ1OGdpRm5DeVArWWtjUXRSNUo4UTlu?=
 =?utf-8?Q?EuZbzzPYhcJT2?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-9f624.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cb041c7e-9870-4c8d-9231-08df34e18641
X-MS-Exchange-CrossTenant-AuthSource: GVXPR02MB12019.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 10:52:13.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7127



On 27/10/2026 14:29, Maciej W. Rozycki wrote:
> 
>   So I think overall this ought to look like (unchecked):
> 
> static int pci_oxsemi_tornado_init(struct pci_dev *dev)
> {
> 	u8 __iomem *p;
> 	unsigned long deviceID;
> 	int number_uarts = -ENXIO;
> 
> 	if (!pci_oxsemi_tornado_p(dev) || pci_resource_len(dev, 0) < 8)
> 		return -ENXIO;
> 
> 	p = pci_iomap(dev, 0, 5);
> 	if (p == NULL)
> 		return -ENOMEM;
> 
> 	deviceID = ioread32(p);
> 	/* Tornado device */
> 	if (deviceID == 0x07000200) {
> 		number_uarts = ioread8(p + 4);
> 		pci_dbg(dev, "%d ports detected on %s PCI Express device\n",
> 			number_uarts,
> 			dev->vendor == PCI_VENDOR_ID_ENDRUN ?
> 			"EndRun" : "Oxford");
> 		if (number_uarts < 1)
> 			number_uarts = -ENXIO;
> 	}
> 	pci_iounmap(dev, p);
> 	return number_uarts;
> }
> 
> with the FL_REGION_SZ_CAP flag set for the relevant entries, and possibly
> setting ->num_ports to 0 too since we need to determine that at run time.
> 
>   Not sure how this interferes with Brainboxes devices, support for which
> seems not to have been fully merged given that pci_oxsemi_tornado_p() does
> not let PCI_VENDOR_ID_INTASHIELD devices through.  Cameron?

The Oxford cards all work even though not explicitly mentioned in 
pci_oxsemi_tornado_p(). The cards all report 16K for BAR0, so I would 
assume this patch should not cause any issues?
See lspci -nnvvv output below for a 4-port card (PX-420). This should be 
OK? Thanks for checking in.

02:00.0 Serial controller [0700]: Brainboxes Ltd PX-420 3 + 1 port 
RS-232 card [135a:4011] (rev 02) (prog-if 06 [16950])
         Subsystem: Brainboxes Ltd PX-420 3 + 1 port RS-232 card [135a:4011]
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupts: pin B routed to IRQ 16
         IOMMU group: 12
         Region 0: Memory at 70800000 (32-bit, non-prefetchable) [size=16K]
         Region 1: Memory at 70600000 (32-bit, non-prefetchable) [size=2M]
         Region 2: Memory at 70400000 (32-bit, non-prefetchable) [size=2M]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [70] Express (v1) Endpoint, IntMsgNum 0
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<128ns, L1 <2us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 25W TEE-IO-
                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Exit Latency L0s unlimited, L1 unlimited
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt- 
FltModeDis-
                 LnkSta: Speed 2.5GT/s, Width x1
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         Capabilities: [b0] MSI-X: Enable- Count=16 Masked-
                 Vector table: BAR=1 offset=001b3000
                 PBA: BAR=1 offset=001b2000
         Capabilities: [100 v1] Device Serial Number 00-30-e0-11-11-00-02-00
         Capabilities: [110 v1] Power Budgeting <?>
         Kernel driver in use: serial
         Kernel modules: 8250_pci

> 
>   NB BAR0 size is 16k by the spec and the maximum # of UARTs is 16, for a
> dual-OXPCIe958 master/slave setup, still leaving 4k of the available space
> unoccupied.
> 
>    Maciej

Acked-by: Cameron Williams <cang1@live.co.uk>

