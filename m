Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012009.outbound.protection.outlook.com [52.103.32.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B69330B0E;
	Mon, 12 Jan 2026 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203784; cv=fail; b=SyzqlqFDKXyJPkTY7Sof7PJdrbdRMop9zUA6igDsVgI7FmLNai0BIoypQEYPHrTI44v4ec15fpnElY1vtKfKGdDE2GVfj+MB8UVqgGpaO8peu9B50iwvFNbSEmNjj4O4IjA2qdsC1zy9p0GniqD7y2ZslsRkhzwgEEFtmc9fhPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203784; c=relaxed/simple;
	bh=RhYMKgsFscdhCNoS/r4Q9pw7cs1EcMWWEDGFoM+r0eU=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t6rl4m5+p5O2fYU6xVuU4bQh53cuKehPldMkn1uuLZF6onzjuSo6aYgAEqVLO5yi9+zIIoeLXXPxBrqBqOTSwHG7SUrt0R4ZW85yGQhuvfGJWo6syFz9cG8kIeP2lqPsCAcOrNjBpiYq4SfLoOCiAUFuYETD6uGisDYpq6JpUXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=OX/tO6Fp; arc=fail smtp.client-ip=52.103.32.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="OX/tO6Fp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rssoABUmQgMNx/qYuJNI2skdh6h8qPzrnJu61xf5Y4P1X1kgx7m5Ou5Tr69OPWPr09Y4zzoC3LdJCB5vWG3AMzAhxTOkdjwqm/NPFT4ZlsZMQg/vxa0nRfM52UOdYBJvDiHce07FiA87J0ULEvxnGBBq30xvUY1gsZnaJXwcjzICXl4zat9boIP6oxX1rSfB6iGB3uspD1Bc9ODiGTqU/3BuOUyGzbPi06SP42QTm8429sKpWoNwQeAxeLRTyL0eI2Lld+Ggx9h88CmCpla3o9+o+4j6iEYN68v6JaulvHVoNi73eB1Y6P6qgKGiCRIsGd6qS7tJutqevCbA7P5+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND+FyYDO9IF1CSNN91laqPlrllN1gpkIGEozX3VKIKA=;
 b=HXXrdSilTDkYJsAG5t0vq8yisGsOFgOzvJ+WeCGnTsr8BAwPsGyNSD2k9y2obtpnEBlkrdY/HxCSdvsHHJQjWgW7a74oLI6nDPn7pmyfrZ96fTQpnKYKlSNDlwF7yaGUNXIzExZmbdb/x6yX4nk+StVRk8zRKUvrx1Ud4QfvyCxCVFyI5ZZdrgRhWWa30BxdJClt9/c85fcg0Wcz7wvF64+znDyb+5PVQjHzJ6imi4BQC5lcgT31dXKkhVtOeaB/vPTDbHIzA/BUGKA8oOCX2jbih5ljX8rnZBvrxJfW1Fsi1lAZBpRUmAqOjge84N6twdyzVdTOF2MsnPEx74cpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND+FyYDO9IF1CSNN91laqPlrllN1gpkIGEozX3VKIKA=;
 b=OX/tO6FplATuY7ZVJXFfMCC2aG4y+jz8UnXOPMybS4LkpHrnrYeu9xKxXh4xezjjPl/b4B+4PrixuXcrsFiRhbS5b+43o7WsQHZndlaLBm335hqJRVrjhu/78EPbmv9X5Gcx3jbscOnNRPSa97B67H0TT9BtxvlGRGJefl2obDVuWPPLOXqao8M3KcddWk8UF675NjPU/AjksQq/rkLQpvxVHI116O43DtlDPuaMbEnoj0VjuYE+imWTrfq/buTRtVy+gNc181Z26f9hq03xEwBevs429Je0hRJvhkr7ov0OGtsXaoSVl4RnwU5Mc8uchPuIerDXOsmfbbMkKS10Yg==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by AS8P189MB2396.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:57f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 07:43:00 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 07:43:00 +0000
Message-ID:
 <AM7P189MB10095424D5EECEF98761C227E381A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Mon, 12 Jan 2026 08:42:54 +0100
User-Agent: Mozilla Thunderbird
To: guodong@riscstar.com
Cc: ajones@ventanamicro.com, alex@ghiti.fr, anup@brainfault.org,
 aou@eecs.berkeley.edu, conor+dt@kernel.org, conor@kernel.org,
 cyy@cyyself.name, daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
 dlan@gentoo.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
 lkundrak@v3.sk, palmer@dabbelt.com, paul.walmsley@sifive.com,
 pjw@kernel.org, robh@kernel.org, samuel.holland@sifive.com,
 spacemit@lists.linux.dev, tglx@linutronix.de, xypron.glpk@gmx.de,
 zhangmeng.kevin@linux.spacemit.com
References: <20260110-k3-basic-dt-v4-10-d492f3a30ffa@riscstar.com>
Subject: Re: [PATCH v4 10/11] riscv: dts: spacemit: add initial device tree of
 SpacemiT K3 SoC
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20260110-k3-basic-dt-v4-10-d492f3a30ffa@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::17) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <4c0e3eb4-ce40-4148-91fe-0ae255a47112@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|AS8P189MB2396:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e7f533-d241-482b-c3af-08de51ae3593
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|19110799012|23021999003|8060799015|5072599009|15080799012|41105399003|40105399003|53005399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUdSbVJKWFYrTDRaeWF2UU16T1ZnSHRFVkRVd01RVENLbGpHRTk1ZzQydENE?=
 =?utf-8?B?TzZYZ3ZaTDFuUXpnZTFOUVpGYWVkY3h4eDltUEJ2V2ptVUV1MUxlN0xndTFB?=
 =?utf-8?B?VCs1Ung4NXB3RTZNVXlCSUZyT2VPSG1nRzYxQ1V5UzlNR2VWc2l5b2srNUor?=
 =?utf-8?B?TWZTdXhseEJSeThRRW9wdkxUR0xScW5ITGxMb3NUd1RwNGJ1N0RZNjM2MVVX?=
 =?utf-8?B?QmNheEZ2RitTVUNLRVJZZnlERkEvWStjQ3dFSk12eGZocllQSzFtT21LNzlj?=
 =?utf-8?B?QWU5S3ZpajVCSUx6S0sxckd2eUNpVklvUmFlRmQ4MFNJcUFZWGIyeTVsQ1A1?=
 =?utf-8?B?WjVyZFd2Y2djQzVvbi8rSVhtK0d4SHVDRHNjbTBQa05JeUZGWGJpRHF1enJv?=
 =?utf-8?B?Mm51VTJDT1RZNFlHS0J0MFBQUUk3ekhNQll3OTY0czVDWnZpWjZ0T2lYMnVC?=
 =?utf-8?B?Q3VRaFNVTGZXK3NSWXVUeUplZDRRblU2bjAvandqRFU1dEdZUjY1MG1Xck8x?=
 =?utf-8?B?MWxndytsT1FpU3dRcUN4Sit6ZzUxVWkwOU1IVWh3WWJMN1k4dDJaT2RWWDd2?=
 =?utf-8?B?ZTNJTUlON2t1SDVnaG05MWowcitQdzdVK3FIL0F0bkFsTWQ0ZGFmNU1GQW92?=
 =?utf-8?B?bUtrVU8raFUxUlRheWFjQmFTTklQbEJlc084aXRsWjNDVC9KdkdmbllFZGcr?=
 =?utf-8?B?aDZYY3o3RWdoYmY1QlRlbFpvQUtpcVFuKzYrdnNOWkNsZmlmL2pVL2ZkSU5s?=
 =?utf-8?B?MWpHLzRmaDBDb21vT2VwZ0FiZGlGL09RK25qelJNQ2RUT0pQZlhrSzVsMVlv?=
 =?utf-8?B?UlE5cHVjanRIaE1CVXdZcC9iS1JmSXZvNTQrM0cyYWtSa2NoWmFnTnRabFVw?=
 =?utf-8?B?VXZaVVJKZ3RPZE91cjRhOFpqM08xcGdid2dCTjNEaFdCdjdqOGU0aDI0Mmd6?=
 =?utf-8?B?ZGZGUis5RndaYXY4VnpWL2d1SENrL1NGdWEwRVllTzZ1cEJNbFc4MmtiL1Uw?=
 =?utf-8?B?dStJaWFIem1rbmdYYjZYR2VMR3c5V2gyd0pDb0diR2NybUlURjM4RklhWjA1?=
 =?utf-8?B?eFRSdHhmYzZlU2E1dTZDWVNZR0M3WURFVXhpWDVTUXdnVW4wR1NUOWMzSktm?=
 =?utf-8?B?Unl5TGJUejJlc003Vm9scWRGbGhqRnB5ZDNJa0Z2d2hsMG5QLzI0ZExPaS9h?=
 =?utf-8?B?UGl4SFhhdEpWdHVWS1F0MlFIWndVbFN3VzQ1bTY4OWVuaFRsR3IvLzVkUGgz?=
 =?utf-8?B?elVZYUcrUDk2YjB3TndMRXJPZlB1cTJ4WU1pNjVZSkNZamxyRXIyK0FWa3oy?=
 =?utf-8?B?L2N0SmREUWc2ZnNqdWRabVlqSDRBZVFMeU8zNW9sRUdhOUp2UFhFZEV0QjRV?=
 =?utf-8?B?NE11bG1JWmxVL3lJRnVhY3NOaXJoUlc1djdxUGREMjR3OElOaE1QUnBWeDZz?=
 =?utf-8?B?aUhMRldROFZ6WVZXYXJHOWZJdGw5dlEybmFhTzVnQXp2a0w2VGlIeU9iemNL?=
 =?utf-8?B?OEJVNGxqLzRHNXRCeHFsQ0F4bHZJNDB5Z2JxY3VETEpKaHk0OHQ2YmhFSEwy?=
 =?utf-8?B?UjNiMjZETFp2alNjeTQ0dXhhZUJZK3czSHY3MEkyWTFmUXVpZUd1OEQ5Smxz?=
 =?utf-8?Q?uGy+Zj+L4xQt0RUrXpUHKYTKQkv/4NEwC+sSRDHMihE8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEVhTmZmN3p4b0hwVXk0WG82YWF0ZGhFSUUwQTJtZysydnU5WG01eXJWQXVG?=
 =?utf-8?B?aW1ybEJ0SEV2U3lBRnV0R25LTzlJVVA2Z2FLWWxSdmtWdFBqVU1pdlRUZms2?=
 =?utf-8?B?TWE0RlBrdUREZnE2Y0libEVXckNOVitVRXNBMEpwRG1mRndlcWNrRFdRL1NF?=
 =?utf-8?B?aFVzNnVpVlA2YWVoaWpnM1pVWHA2cXlONU5SSzM0WDZlTTVUT0s0SldiODNC?=
 =?utf-8?B?Mlk3VkxJRnpYemhsRHZueU5MNDMzZXpQU3U4RkVYMjlrT0w3TlF1ZjJiQjk1?=
 =?utf-8?B?V0lReC9PaGdGUUNCem5YZDkwaGZ6ak93dFF2aTRhOWZqTjRwNHFWRHpOY0tK?=
 =?utf-8?B?QmJlMmdVZ1ovZjkrekJIMzBKZllRV2lOWFF5SHJyQ3dKV1RDMDRGSmJFR2tL?=
 =?utf-8?B?NlpIRm03TmhiRjhMNVphcjA0ZkNoYlF5TWlEeTVxM0ZLWklVRkI4cENlSWNs?=
 =?utf-8?B?VTM2Mml1NmxtQnp0V1NPSWtkWDVZbjN1N1lWckltSUVZblFYYUJ1SFFIWTVk?=
 =?utf-8?B?WUNrSDB0b3YwVE5vS1NUOTVUc0p4YjR1eUNLL0cvbzFMRHgwMzRTWTV4MWJC?=
 =?utf-8?B?YmZpRVkwbVQwZTh1RE5rL2p1NXpSZzZ5UW1PVTVKVHA0ZjdqbllvenR5QXFG?=
 =?utf-8?B?UUtIWDVTODNXQmZ3V05wQTZvMzJQcmVETTBmNFJpbEpDa0l6L29mTmNXNFlJ?=
 =?utf-8?B?ZDJlS0hGY3luVHY3bW5YeklQUERVZWNXTmhCNmovaG1SZEJ3L3g4ZVpjUS9w?=
 =?utf-8?B?TU50cUg0a0dPaDMzQWFLTGdnMVhvVXhYNGRTQ1hvenAyYWFwd21YWEhhRUVW?=
 =?utf-8?B?WklwcWhpVTkxWEtUQ0ZPUkRCTlhWUjFienRZMktNQTlkbXIzbXBLS2Z6YVpy?=
 =?utf-8?B?UGdJdXFET0Jhb1lKS0tWb0NBY1I0ZE1lTWF4NEdDTXQrK2F2ck0yR2lvc29m?=
 =?utf-8?B?TFU1UE5JMzJEY05oVUFEUkVyK3BGZXdKOGFJZjJlTCtNOXJnbmRtaCthOXRS?=
 =?utf-8?B?ZnU0clAyWkVxYmFjMi9JL1VDNFNaWlhFcDlzekY5SHlXOTBnYWdlTVVVc29t?=
 =?utf-8?B?ckxhVVpOYTBGanlJbmZxdk4ySTE3TFp3S1FKckhrTTVFeEdvd2FwQTZtODVL?=
 =?utf-8?B?Y0ZTYmhvLzRqUDNXQWU0alUwRUtsUGRJVXIrYWZNcDBCZmVDQmZkaXNXREt2?=
 =?utf-8?B?UUUxYys5aTVTd1JJZVkrQlVTaFJhVWU1bkozUlJwVXlmNFZKK1VoQUlCQVRy?=
 =?utf-8?B?YXRuWHFFVEVTS2c1VnU4UXdTRTRpZW1wNmtObS9nQkJYQXl0bzQvTms2N1N4?=
 =?utf-8?B?NTFLQm9qMFV0amZWMlpxVW5Fa0lJQ1I1RUdvVkN3U3lZeDZVcERTZ2hnR0V0?=
 =?utf-8?B?NDFFT1BYTUthdmd2Unh2NUo4MWREa0EwSm9CUUJQazFnZ0R3ekRxcWVYanVG?=
 =?utf-8?B?OEFoTFRxeTZaSXQ2UUVYMkJwNG5IdnU3am1xL3I1QkN1dVV0aFp5S0Z5Y05N?=
 =?utf-8?B?UGZDTU8xcG5vVjkzdzg4bXk3eU1FVVIyS1p3dVk2NXVveElkMDlQRXZ4cE82?=
 =?utf-8?B?N29PWEE5bHBxeGVrb01BN2hraXRlRnVzb0d6L1RqUWhjMjdWeUE2eEtmc2hC?=
 =?utf-8?B?Y3RyVmx5bUQ0QnFqWVdFdnRxaHY4WUhsb2Q3QWRUZko3cVFNRWRLSFlrOHZh?=
 =?utf-8?B?MkV6cE5ISDJ3eTVkeDRSdWZDOWhnN0ZQQ0srZm5BN3c5aGdLSjQ1a2o2Rklz?=
 =?utf-8?B?aHRWbTM5aG5tUmlvTFFYcFBURGVBSHE3d29VbGxuMXlyTjU1YmEveFA2enVV?=
 =?utf-8?B?eTdwRW12Q3ZiWVBleG5rMWtGT0hTMVdDbTlhSkRIMDZEYitnMWkzWktpZ3lW?=
 =?utf-8?B?c0VLeEJvR1kvZEEvcjZEVzFMSXBWTTJ2bGpFZjFWT1h6eXN2Y2Zxd2h2OVZk?=
 =?utf-8?B?QW5lRlZJQ2R0L1Z5NC9YNmFpbGVuOGhTMCtjVUlkN1F2eXllUFNtZXdlK2wz?=
 =?utf-8?B?endsd2NkdmZBPT0=?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-645de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e7f533-d241-482b-c3af-08de51ae3593
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 07:43:00.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2396

> +		mimsic: interrupt-controller@f1000000 {
> +			compatible = "spacemit,k3-imsics", "riscv,imsics";
> +			reg = <0x0 0xf1000000 0x0 0x10000>;
> +			#interrupt-cells = <0>;
> +			#msi-cells = <0>;
> +			interrupt-controller;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu1_intc 11>,
> +					      <&cpu2_intc 11>, <&cpu3_intc 11>,
> +					      <&cpu4_intc 11>, <&cpu5_intc 11>,
> +					      <&cpu6_intc 11>, <&cpu7_intc 11>;
> +			msi-controller;
> +			riscv,guest-index-bits = <6>;
> +			riscv,hart-index-bits = <4>;
> +			riscv,num-guest-ids = <511>;
> +			riscv,num-ids = <511>;
> +
> +			status = "disabled";
> +		};
> +
> +		maplic: interrupt-controller@f1800000 {
> +			compatible = "spacemit,k3-aplic", "riscv,aplic";
> +			reg = <0x0 0xf1800000 0x0 0x4000>;
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +			msi-parent = <&mimsic>;
> +			riscv,children = <&saplic>;
> +			riscv,delegate = <&saplic 1 512>;
> +			riscv,num-sources = <512>;
> +
> +			status = "disabled";
> +		};


from reading the chatter on v3 I think the right status here may be 
"reserved", for elements that are reserved by firmware. But I could be 
mistaken.

Kind regards,
Maud
