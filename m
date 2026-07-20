Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FBE3A874B;
	Mon, 20 Jul 2026 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784526759; cv=fail; b=LZmizqgfY03Se4j8J7dK7qlrn0P11lLhGtcP9hrX31rx1noPvqwIZ6cIpAgzBhMJUqV8BApexwLRhPoA4aZnqYM6OjaLRAs5Nv06fhPR7Z0zDdY16ZBk/rLjiA8Q28tOoFeqVEfbWoXVAFWjZ9YFaJmBmjwpo29qXx2TDXulkBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784526759; c=relaxed/simple;
	bh=5O3ZFfAIgTgT36gknILjphLVZAyj9P50obiFAuMS6JU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=joTnCJmjcP4u90Om7F6YElCHyHF/JljwnnnTk4mRQVYytwJu7nWvi2NdsOKvDtKXICU04Tf0olTflp3JZm11iZKomPK2KsF8IEYXlWuC1MWq2R+usR2PT4b1bEnYgjSaxwj3JLF26P1BQXffitYqmcyvLpkz/1qtTHK8anUN+0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=fTRFpmQL; arc=fail smtp.client-ip=52.101.57.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="fTRFpmQL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrIlR2kMMmOzZEQdBjSkBKg084cedD45L3VEgTo1dJKg2huV15KN5VzyE2f5iMYVpdTz7RE9tXhEhT7kqNvqRjdlHvXf9L2LtZ2ipDpGR82iIdaO/6cJvrNsVG1EO57KELXK97EA2H/Bt1ThSYCGEMgnALY12CE/QVCED+wFq+yWJSor6ZOrqP0eNh51LgioagTkgxNDUguzyaPWYPxnXbnO2z1RPgVFSOUt3F6MZIvWTXCkc+TXGYP3Y2oWEN5v4rCzP8bPeQFhOOv+Liy8VGBahZHuHGCLC2F+XtgS9SnM4u4GsoXzTgF1csoAGK8+RMJ+RY3/rVrQ10U1i6K2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PB+FMGb14+gkUMv6c5yGGEddr6TntQ/I2Q2ovUpTinc=;
 b=HuZ8iRrcAgMHwSr6q8oGpCD/n9i1tiYLgi6gYC8uZW+lBFmMcMsFgBgCb61NM8m6VNeaDbysf/Tr02uPyXmj6pO6kiU/ScrkminGn7pUb6elQ8zxNJkyyjWLTUe+KYvwW3eXCl2PNSBblEIPnl4CgnlVcRRpajdhOWqsDhwjVMGdWAnqu6ZxduBQLNFF+xJBq+TE7NMjxo9raaBnl2J1NXn0uAuJOg+zzpfIeV4+BigAIzY+wFL1Nuu0IL/wJtw/OTe6+ruGncv7qzHXnVJ9afBdBrPGIHQxRERjOjwXv+awnY7qcf+U3PB+S2qSpbzSqgwojQf1J1oqy5Wz/pBU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB+FMGb14+gkUMv6c5yGGEddr6TntQ/I2Q2ovUpTinc=;
 b=fTRFpmQLgvkqNxALK8wR3pFBfvoXZWidCAQWjgih8HcJHz74vgpG546xnNlPif5Z6DbgtZjY26n/uCp3MT67LhudlHay7wEEGaMHxo+hhID8an0aCkAl7iQ5z/yNQHnna5nlYuT1Pw28kG+Ko+Qj8Jw7UVz2U5TNhkag3aUD251WtvR3UG5AvgU/X4hySRMkKVaL54NYCBmBkNRP9yTnLHpUwg78Ig2G0W0KbQynNzLR3wAmXjAvF49EywPC9JxjAUGgUR10XhzPwKFBqmYrqVkQ1AHLj6PEI5VgC9xWIUijYv9wVv1LM2v5BPIqZt7CejnmzykbGAgArDlFGjo8rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
 by SA1PR18MB6105.namprd18.prod.outlook.com (2603:10b6:806:3e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Mon, 20 Jul
 2026 05:52:21 +0000
Received: from PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::ba9:422:da8:b963]) by PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::ba9:422:da8:b963%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 05:52:21 +0000
Message-ID: <c66256ec-0920-4a16-a272-1239b5fc2cd0@axiado.com>
Date: Mon, 20 Jul 2026 13:52:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: arm: axiado: add AX3005 EVK
To: Swark Yang <syang@axiado.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jan Kotas <jank@cadence.com>, Michal Simek <michal.simek@amd.com>,
 Andi Shyti <andi.shyti@kernel.org>, =?UTF-8?Q?Przemys=C5=82aw_Gaj?=
 <pgaj@cadence.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org,
 linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-usb@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-1-c429095143ec@axiado.com>
Content-Language: en-US
From: Tzu-Hao Wei <twei@axiado.com>
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-1-c429095143ec@axiado.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0010.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::19) To PH0PR18MB4558.namprd18.prod.outlook.com
 (2603:10b6:510:ac::13)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR18MB4558:EE_|SA1PR18MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 8904d194-5700-43d5-5226-08dee623107d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|42112799006|22082099003|18002099003|4143699003|3023799007|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	rddbCtzLfGhL7n6moQmEFEpWsJJz+uXNIokdKzAReB8SiXqCvR353c3yGOenB1W3/o108n0WZoXGkV6IJsz4jGOvT83qsoXdAjboXMJbH/D1UNgGHCroA+5/Ivbj3VpwcojT7/6JSal2V13svUwlUh/KIMl8ss2i+yn92L6bO5zOFY/Q2JNQ5OHTjbx1a5SPBoc+woox92TplU+8O/on4EJt5GETp7Ndn69DPZLA5ReSxaM7KF4wxkPttBpY8p5fJjYiAIq1vhUXa05a+BwmVwqx+H7I0ST8/sI6zsdyCl0amcWIvmjFwdOuQIdia5F+t3HFG3arI5UrLiaoEIUwVfTy8YSUL9csubaxZ1yog73I+p/mkhlkg6ExrO4VVtEnRlcgKYC6zsz43V6b8cFHfOTEi0wdY7l10Yvj8nZSYypLIUjTyusKu3mtoTQ/k4I5zAXn8GUtnL7xF2N976Da9w7NTOW94J24sgGUcV01K2EZSUhUG97tXeyEWjcXod26bvdQGsFUf3Ew1YtX9VnKPiT7XqV1U78kdU+9a6Yd5iqpEQ0OqjI9Bi0apxSeKImiHFiktPVPDszH3/pzeME8Cj3IHJDgD5SRhapPhUkmKeHJtZHhiAGhIeHpcGPepvFUBUrIbNh4BJJB2ifbaNMFXdDuSZWMzuelPPE96D6u7Nhe+tVwM6AOYIKjzJJhKHWwgIKQ8rBps7oRsFgqas4Lpw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4558.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(42112799006)(22082099003)(18002099003)(4143699003)(3023799007)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGlNeTBvS1NXRmRMSGFHaVpYeUIvRG1pRTlwa0V6M0NIOVJ3OERWK080aWtX?=
 =?utf-8?B?c3k3WmpvRU81NzRscEtZcUtsN3N2TENlYm9KdDBXb3h6Z3A4VWF4c3RrdVdH?=
 =?utf-8?B?eERoNzNnMmcyckRSV2E0K3pVYmRQQjBMZmxraURVdXhKUkRObkNDTSs2U0dO?=
 =?utf-8?B?a3hlNDhDMHI1bk1ybDkrL2NtYVpmNUdoVjVvRXh4UjJiQzJrNjl6VG5hNG9C?=
 =?utf-8?B?N3VadGhLeHJLbUNvYjRnOWpKdnpoZndpcm95QnRXeU9JRWpTcll2RlFnc25T?=
 =?utf-8?B?MG40VGdudTNrNTFxcC9RNnVZek9pZ09EVGxId1F0UmtxVUsvVFdaVmxybW92?=
 =?utf-8?B?a2lPV09pR01qZGZsd3FBaXcwbS93dWNzdGFTcWc3eTd2WGU5WG93YnJCR2w2?=
 =?utf-8?B?WjkrZXlGamNCNTQ5dGF0WUVONnNmcTFpT1BkT0NTSUlGamdOMFlsY1lYc0ww?=
 =?utf-8?B?S21PanExbVVmZnRLbXRkamFNakpSSy9pZ0pGeGpWRWZmUU8vRHArVER4ZGVx?=
 =?utf-8?B?OTVOSzdxRjNETWRMcnBRWWpSdmRsVWFxVUJqK2lDQWdqbUcwVDg4Z1NvYjk0?=
 =?utf-8?B?RjV2SVhBOVpybE9RTnhoZzQzZExJYzlRakpGZG5XSU9Zb1lXU1M5Ulc3UEpu?=
 =?utf-8?B?RGplYm02ejhNZVp5UW0yR2tSZVZLTUtnaWRxbUpjbXIvbmczbFZGcjNsRWhE?=
 =?utf-8?B?WE1YVFM2UzlyOVVJcW43OXZjajFCRHRwUzBHcDNDeW1ZK3Z1T0xBc0dTbFNQ?=
 =?utf-8?B?UjExREJmeTlMOFFmcXNYL3FrKzNLYnFHanN4U3JKd0p4UCtGRGpHK0tyVkpx?=
 =?utf-8?B?WTZyQlhkVFFUZ2dwVUFqejVtaFVlcFFRNnN3bW5rOWJvVnRPaDV1S2gwc1RF?=
 =?utf-8?B?SnZwSllzWmpCV1N4bThXR1JPSUJuaXFMbWluaUhtTFVZWGNqejdCVzFtZ3Na?=
 =?utf-8?B?SDZsSmhrL3B0a0UxYU9PSGxyRElNaVppamJJQWI2ejExWVNzKzFmWis5TjBQ?=
 =?utf-8?B?cklZTWpLSmZVelU2c3RSdmZ0QXhhMHBvNlF6amdhL01qV1F4U2Q5U3NDMGMz?=
 =?utf-8?B?TGRSTDBvd0pMcjl6UVVaKzlaUnhydHd6ZzEzb21KemhlUTRNUnBhM2pTcXBF?=
 =?utf-8?B?RjV0VU9ZNDA0dDZZME1KcXp0eGw5ZWxpVW5rVU0xTFVVN0ppY3Z1a0pKazNo?=
 =?utf-8?B?eWorb1U1a3JMM2VWSjBjZkl4L0xITzJyblZFOUwwTW92K1RhZnFwY1RLdURi?=
 =?utf-8?B?aDVNc3JYNFZ3TTEwSldJZVF6NXNVOHRRamNIMHhBVm93YlhJYXpob2tGTjdC?=
 =?utf-8?B?eHNGUnd0RDBrMXd4dE5UdldVRmRtNm4zN0dxZGNkSzl2NXdsZlVFc1Z2QnZY?=
 =?utf-8?B?ZElhU0FxVjRXOHR4aUdVVjJmaHNPVm0yWjNzbEtLeU9mNmlQOHlMZEJBcUlY?=
 =?utf-8?B?RjVBTUhkYkdkY1E0TzBic0dmU0tUTlh3WXVPRHNITHppSFJVY0grN1BrYVBQ?=
 =?utf-8?B?TFJzRmplYUNieE9xOVNjVjRzdlRXSUU0WUN0ci8xMmFaYTZncklFR1lTZURo?=
 =?utf-8?B?WWloSklCclFieDg3ek5uTis5WEdpYXlpUkZKaXlLOWlOS0hKVmxweGtIYkUy?=
 =?utf-8?B?NldjbEllbzRqdm9SSkxxQThvbDZOZVlPSVlKbkR3UTg0dzdacGtLNzFXR0Ex?=
 =?utf-8?B?YU5WQ2JGNkdQbUxGVys4Z2s1c0daOG43OWIxWGwwTmtFTjVoZWFyWlkvako2?=
 =?utf-8?B?UWVvcFk3b0FLN2JTckM1dlFXMC9wWXJBRVRhVDRHbXpUaXhuYUwxZTNKT2lI?=
 =?utf-8?B?QTdqTDdNM055dW0xSFhkYlRjdHFKN0tJVE82SG5nc3p6aEdVUkV0YUZMK1dT?=
 =?utf-8?B?QmwwRmtXWUFBRmJHcDUwd0EyQVZPUGdLQ1FtVng5SlFtenNqbDlkRTBLQmRk?=
 =?utf-8?B?MG9PQUZ3TVhQZzRnbDgxbGZ3ano3ZVlHdEZaSGpxaGJYNmxSSkUxbWlEOExi?=
 =?utf-8?B?bUh2c2gzNitST3dFYnBtNFRaUis4bW92bVNlL1Y4NmNnRDY0Z2gyYTVra0xy?=
 =?utf-8?B?eFlFTlVoR29YSlZhcFlvazUrWEJOOXh0UlhVSy9GVE5LclhSYmczRVFjL2ZN?=
 =?utf-8?B?NVZUQWUxL2xxVVNSQzBvcDhIODMvYkpPaFUrOFVjR1BBdVJUYXduK2w4bHNi?=
 =?utf-8?B?OHZidG5IckpzLzI2YWMrckdpdFMyVGRrNTNneEdTakZoTEV0YXBJTUFnNFRy?=
 =?utf-8?B?eW1OZGxzRnJCeWhmK2JicXV2R3p6eiszQlp1a2NNbzdLSnZ4NDdHU0gzKzFy?=
 =?utf-8?B?emR0ZDZESktXZ1FySDRMaGEwZGRrWENzN0Zhc0U4Y3F3bU9TbWxrQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8904d194-5700-43d5-5226-08dee623107d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4558.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 05:52:21.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 004oneYJGDj9P0ivpdPeBhI1nlvPktWVO4xatFdXhIRaz76cgSf3Nj7LJQlYcTKG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6105

On 7/17/2026 11:51 AM, Swark Yang wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Add device tree binding schema for the Axiado AX3005 SoC and its
> associated evaluation board. This binding will be used for the
> board-level DTS files that support the AX3005 platforms.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Swark Yang <syang@axiado.com>
> ---
>  Documentation/devicetree/bindings/arm/axiado.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/axiado.yaml b/Documentation/devicetree/bindings/arm/axiado.yaml
> index bfabe7b32e65..008d2b1d4e62 100644
> --- a/Documentation/devicetree/bindings/arm/axiado.yaml
> +++ b/Documentation/devicetree/bindings/arm/axiado.yaml
> @@ -20,4 +20,10 @@ properties:
>                - axiado,ax3000-evk       # Axiado AX3000 Evaluation Board
>            - const: axiado,ax3000       # Axiado AX3000 SoC
> 
> +      - description: AX3005 based boards
> +        items:
> +          - enum:
> +              - axiado,ax3005-evk       # Axiado AX3005 Evaluation Board
> +          - const: axiado,ax3005       # Axiado AX3005 SoC
> +
>  additionalProperties: true
> 
> --
> 2.34.1
> 
> 
Acked-By: Tzu-Hao Wei <twei@axiado.com>
