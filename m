Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022112.outbound.protection.outlook.com [52.101.126.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B341096F;
	Tue, 22 Apr 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322340; cv=fail; b=NONcaqgY06UCTOLMNY6v+qeKhvwpnZJLPuVmyVGDvmLwhxavy9rIqWk0DDplmwnjPUm/HQygoTwYJAwQGlqXXTVt7v1sBKSyySJbkbFuewotrCKrGnyL6ycA0ze/cN/4RPdKfpozk6nn6LRTpyv6AAPK0x83eQU8LAjXkHoZy58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322340; c=relaxed/simple;
	bh=/K5aGrb3A+48cfG6wB1krGwoe0JvnTReUUSAiXZfro4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+6KIShWKMGvpNWOMoRvlTWIuUH8ahHNwmPPyFtmaxBkZs7aLicL6IEoZdohXL2TLEHrkx5piRsd4iI0TAgte6KR7iMNK/YUxJG/XSEs3Mh/p5n+A7Y+wF5+209mz+IhiMnc7bx6epV9oNs+9ttirLaLUH9Fx66dQrHqkj+3DH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=hC7a5M3q; arc=fail smtp.client-ip=52.101.126.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="hC7a5M3q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8tyBu4q9If+T7Szz5phoDpkJ4gwbsvS4eyFqzOwUIQ6VCCyWR9E3dbLKcVeaGmDtP3nmfE0wBTqzt8rsckS0TmJ3poLN50R5zSBua6nP0hc9IOAWV4hmg17YEIrgOxuoJ4AtnTfYqlFSkK9+mPWlO9A5FRfACo1z6CgsO/Zum1Iy6faago5fuVID2+3R+kCaN8jjgE+o3Fw/uO+aM4vE+mj0UuSe/XpGPhPBblTCWKr2BXLB5KA5akKdVGEh21/Uepyv6DHDyNLDDW4MvmgPzXkx4pBtD3WFBXb6Cv+UXMxRpXfflRM25MfzYjxQA74yAP8Xuxed/Yg9NJMw3g9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLJuCGyNc0R0GtueYEuoVTEK3UJrshkSS50nq7FppYM=;
 b=PQDAV+/0QU80cHChHaNXdLbjrbxDwj5uqD33sfOd4vNCDbpS69+fQJCz2O7H/cFwyatwmLDGrPSQUN1y8waXg7ho5Mcj17ug3zOHyFNDZfUVmrPN0kyHx7eATp+tZh8Q9drB01wSXLL8R4tmmrBVB8DOGlf90zt8U22Xy6CG86Vm5NFw/aawPLSVLbrUERJ+hi2iEbUf0Yevlsz0cnkV4kGaM+2/wIDYNPdbk5jnKiMVisQ8XkYbUUMdfszIl0NVuzntf6jw9H7fWHKR28G+5CB2epYNxN0qliq31ZbdyBsWtFSuo0kI6kFtEsM2NvUNDIhVd+2CUodIspWWupwXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLJuCGyNc0R0GtueYEuoVTEK3UJrshkSS50nq7FppYM=;
 b=hC7a5M3qIB74oboszBrnfPaVx4/meXGtFYPK3lKSKrQmKKuymvX7fw0rbPpJuvYT9E6+EFMHSwvB2y0wpm5fhePME44BfFlfHLSCjY91Gx7ayEfibB/LgrgFwVPjwM6cCGr3ud72hgrl/V2eJwPFFO0eGScBowiYNuF0kmccm7IcxN8Mx5Hs7Wka9yREVqNNXWXKeXgJn4eDkj4eNDAIMLcBh+YNk6SHecT40ISaj5sJ2yMh9bVAiXD/46mhmDDyGI3BXrvpl1+kRbRpcnbhC5gUaPblseyC3csx6J6zYNlxW0wBM0LE53WBU+g2hRUaEaAPI9Hz1Rf4HJFY/EFFTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SE1PPFDFE2FD117.apcprd03.prod.outlook.com (2603:1096:108:1::86b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.24; Tue, 22 Apr
 2025 11:45:32 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%5]) with mapi id 15.20.8606.027; Tue, 22 Apr 2025
 11:45:32 +0000
Message-ID: <a175ed1d-9e57-4150-af8f-7ca785203108@amlogic.com>
Date: Tue, 22 Apr 2025 19:45:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Baisc devicetree support for Amlogic S6 S7 and S7D
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SE1PPFDFE2FD117:EE_
X-MS-Office365-Filtering-Correlation-Id: cce7eb0a-0eb8-43aa-ae6d-08dd81932f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3RwOVFkZW9VWUhwL0hYeDJDSnFhNjNIbzZKaDNmSkFwdjNrN1Z0bjhmMHA1?=
 =?utf-8?B?QU1Ocmk5VXhmYk5HYUkyV0N4RnFwWjMxRDZEQVNKcEttbGo5WGdUOCtwSDZo?=
 =?utf-8?B?eDBVYlBJVEpZelNYOU9TOENFWDQwVjBwN0k3UTZBREw1STl5S3dLejU1Vk1U?=
 =?utf-8?B?NGNTTjFML2xmMWZaWnZiQ21GdmFYZ3d1N05RQndhbkdtWGNjUWFUbGtISjUx?=
 =?utf-8?B?ZFNxZG9PNFFzeEhlMk0zU0hUV2tBR0FBY0JJREFKWnRQNXJ0UEM4VlhGZTJ5?=
 =?utf-8?B?Nno5TlBJS1JxaUVzelp4VzJsSEZTazlqL2FwdDRPQ3g0QjBTSUc3dzJSNU0w?=
 =?utf-8?B?TXFERFFyK0VrOG90anNRL3BIQVZ5NkRjRU9mekVVSGxJamh6TkFqTEI0QkND?=
 =?utf-8?B?QlBtM2hZWkFMdk5HMzJXNGxGOUFiMUpzaytwcGlWaUZuZEhRS0h2UHlCdS9t?=
 =?utf-8?B?VnBManVoaXZoOUovS2dVaDJ5aTZmRmhUUFVwbGE2eUdGb01hbFhCTDh2Q0kz?=
 =?utf-8?B?U2lJSmhQbTJ3Skp0ODd6VmNjQ2F5dVJpZEJwR21pUlRNQ3ZCd0Q3WFg2MHF2?=
 =?utf-8?B?ajlhQm94bC9ad2F0REQ4UllXak1FeU13UVFnRDBmUzBwMDZQbW5ZT0ZFSGVi?=
 =?utf-8?B?NTc3WmhPUkpTeGVJOVBlTmEzeG4xTG9GbEFvRml4ZXBFY2s5ODZCY1hBejZu?=
 =?utf-8?B?NU9kTVdqR1RqTUtzb0ppM2pHZFNmNWhScXFqUEVMNXY0aEZucDJHZnRpQVdW?=
 =?utf-8?B?MXRXS0dRYkVRYnVnYUZKUkd3STVXTk80Y0FTUitsa3dGTWhYMjBMeG1kZHU2?=
 =?utf-8?B?K0xTM2hmbm1TcHVSWWZ5VmlCOEJXTC9SbXJBTVYxVGZBaXhUMjk4cmE1dUJF?=
 =?utf-8?B?RXpjemZHaVhDYnMwMEhuaXRScWk4angzSlduMEt1bXpnenVFME9MVGJ5VkRs?=
 =?utf-8?B?cTBxZ01VdUI3VUwwNjdyNU1FQVVSdjQ4UWFLYy9VVk9VV2w2dlkzTFVHV2F0?=
 =?utf-8?B?bjVTNndDRDYyS1AvSFQyZFY0cXJVTTdYY3VvZU1UNjgzTHByMmw4OTBHM3Nk?=
 =?utf-8?B?cjBqUHQ0U0Y2QUFMdlN6RFFPQzZrRXVib3UxcHQ5TDVNY3lpK0JIZlloVytS?=
 =?utf-8?B?bEs4UzBIWHNaSmQvRlc2TVNBY2Z5RjdXcGtkSXYwSndEd3NyZUd1OXFtYmVo?=
 =?utf-8?B?eWk3c09DTEthT0pVZStwTGoxeDIyWHpEQ2tyYy9pR043eHhXWGQrcWd0SGgx?=
 =?utf-8?B?TTFpNE1uV2FmVThOVEhPZHBLK2FnUmN0OTV0YUdxOVNvNEtQSlRZU0RZdW1o?=
 =?utf-8?B?b3lxbHlidWlrUXJoL214Y1dMK1pFeEhCQ0lPQmJBM3BJOXF6N000c1pYQjNU?=
 =?utf-8?B?UlpaMmU5RkI1aE1DWnNVSkN5REFUNHUybTk2OUR4M2RDcW93VXBpOFJYbkpt?=
 =?utf-8?B?ZFVyU3kyNDc1ZE5IWkptVXF5L3hMMUlrSzQzcTJjYVhPaStSMFJJOTFZVFNs?=
 =?utf-8?B?YmhpYUNqWFFsVmJzR2R3TTBSNXNoSWF4TVZkQ2VTVUtSUHdvTVJOS2RtZXd1?=
 =?utf-8?B?SjJRazNBTnJITjJ4M0JPS29MQXF1ekZ5ZHlLeUNXNTdYajV4Z0FHUzkzdjF4?=
 =?utf-8?B?MmExS2llakh5d3BCbzgzVEZORVdNOS9FMDlGdnUwcGZnVFIrcDBFbXF2b3ds?=
 =?utf-8?B?NFIyYkhFNGRJVXJkOGhLbEp5SzFlY3ZQRXFsYTI1V1VZWUNBbG1IRXFlWUx3?=
 =?utf-8?B?eGZtT0I3T21nZGFKeFMreEhacThDeWo1QzVxZGpSQVlKdHMvWGpDNmdCRUpJ?=
 =?utf-8?B?M1NOM01BY1VtUmttM2o0WENFcklNN2NFQWNIMmtWeXY2cEsyVkJ6K1RSSkIr?=
 =?utf-8?B?MCtUYytZbTRoS0tzbGtsZnJDVnRnTm9kTzJ3dmtOcUFnZEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGZLTzBzb0VjdEVmYTNOcFRDekgvUzBxc3pPSk41ZjljK3hZczJ2RE5OVUlB?=
 =?utf-8?B?SWczMXB4QXFvdTlXem5XNkVMb3NBS1F4bXRseE9lU2tjZEpYVzFITFFzRUZ3?=
 =?utf-8?B?eFFHK2tvUkpvcDdxZTFGNHNCL2hXZlYyOEY4YWFLbDN4em5Kb1RJMEFzdE00?=
 =?utf-8?B?YzdMWmlkSHNRUzJubXZxRDBUUkNLK29heU9sWEc2M0U0cEdyeFpBU3QyUVJj?=
 =?utf-8?B?U1VZMk0zajQ0bU1DazVkNGlWVm9xSlFzNlNOSEE4ZDhlbEh4WUNCT3phczlh?=
 =?utf-8?B?d3VlWUFGSHZjYXNVcncwVkhmSkNqcDQwSnkxRklRNXBCVFhHU0o5all1UmVu?=
 =?utf-8?B?em9qOXZHN1ZrMkRnRTlyS2Y2MWNSY3phWE9OaEVTRWxKRmJ2a3pSeUhvUWxH?=
 =?utf-8?B?Sm1rNEFEaXl0eHVKbzFWTVZxMWpEd0RrVHZDbkxTelplakQ3Q0EzNnFnZnFv?=
 =?utf-8?B?Q0pOWU83aVY3L01sSWlTbmlIZ2I0bllsVUhSTkhJZ3FkTTU5NUNDSW9XODlp?=
 =?utf-8?B?d0NlaVR1QWxZYkdrK2IySGdzZkxwdE01QjdFMlFPWWVJYXJvUmxtWHZrY1FC?=
 =?utf-8?B?bStqL015a2F1c1Bqbkg2NmMwRGs2MDd6c00yTmllZ1dLS2NUQlhCbWFnbnRt?=
 =?utf-8?B?ckpuWGRranpxTHRnTituU1VnRnpKVFNvZUFPQlhLcVB1cktVdWYzTll1aTVV?=
 =?utf-8?B?NXZSTHJJcXRONXFIV0djbSt0Z0o3YWdSQStwdlhNT0ZkTGJPR3JUMjdUQzls?=
 =?utf-8?B?aWI5b1Q4azMvTDMrdkd3N2J5K0RRZ0ZzNXU2TEljZkUrckFLb1d2WmxKWE9E?=
 =?utf-8?B?TkRTR2dzOXZoWDFrTWVHekpJdStWRml4SEF6RFZrVEs4RDBDOUdvcXYrRFRS?=
 =?utf-8?B?VE9WZUNlOHpWWEZQOURHQ2pMbTNHb2M4UXlmZ1RkdW9VOTZoWGVEaHh4cGRa?=
 =?utf-8?B?MWJsak1ZT29Da3NsTkk0ZkZlcnltdklSdVFGZlVRQkpmM0VRK0lJeHE5WTFB?=
 =?utf-8?B?MXBJNEhxUEdGM2FHZ3ZrTy9saVVPSGR3d0Z2K20ra1UwbkM0bXlNU3VwbldT?=
 =?utf-8?B?OGpIR2RXM2pyTGdvQTdSWWpMdlUyUDZkY1FER3EzTkM5dUhEdUR5RHhxVHBT?=
 =?utf-8?B?UHc4aVpCdnRGcEVBWXU0dDVSQUwvalFUYVp0azdTeXd3S0szY0ExUEZpR3R4?=
 =?utf-8?B?L05ZKzN5LzFvY3RITlZJbTN5VFZtYkFKand5SDRKQkk1bnkzWTFSaGZZNVJa?=
 =?utf-8?B?MUZXbEFLbVJJRGVLTGh1bW5uSC9vR0UwR0lTR1gwRnVjUWIyU1A0K1B6aEp1?=
 =?utf-8?B?cEVjRzVZanl1b3ZNd2ZLM0NTaTVQVFZleWx2Z084Vm5KOVZ4TWhvNXNmNjVw?=
 =?utf-8?B?N2RpdzFneDVsZ0NXUWJiRWlFeVQzcGpKL1ZmOXkrV05DOHRaUll6L2xRTVZQ?=
 =?utf-8?B?SDJ6NVMzR1M3UFpSWitUMHJlakJUWmZONWZUVndDOFpXbzh6VHhnUmIvaUlF?=
 =?utf-8?B?b3NUcmk1UjNIMG9HcDdMQlN6QkJoNnhTbVMxZTM1RnFDY0IwaVBNQXdkaW55?=
 =?utf-8?B?NCtJekVCVXN6TVg4aXRLdjV6OWR3cDZVb21uSkdoZ3VQUjVHSnlKSWVHd1JS?=
 =?utf-8?B?eG96NVNBRUFnRVN5SmwrVEFVZUIwOERHVnZVRHBLZkQ4dUtZZWhOZncrTXlr?=
 =?utf-8?B?YndOSHpkSGRpM3Z0UmxjU3diY3lTZTRob0VMU1o5bDlJQTNDcTJnNU53bW1G?=
 =?utf-8?B?S3dwL3NFR2tkT3JXRGhIUFl2NHo4bU9taHFQUmpQYXYwMktmWEVvRDVsaHBh?=
 =?utf-8?B?RGxBODJ1bDZTSW9qWFlFTmlicmJPWDI0T2JRVHN0T3NLWkE0TUM4bVhjaDgv?=
 =?utf-8?B?ZzFBeStDZGcvRmxSQlhmeCtGdDQwVERvdXpRdDNuU1ZNWGdNcGZBTTQ0OHZo?=
 =?utf-8?B?c2VXMmRHY3BEMCsrT2ZEQkZKNml3TXNKc0JGQUdqa2xsU0FybmRkeTljM2pJ?=
 =?utf-8?B?em14YVRLdnU1SXRsMnJHUHJqOVA4bUZUYXIzWDVwSnkxc09uTU5wRzhTSDh0?=
 =?utf-8?B?U2FYbDhvb1NRamVWWS8yRy92SW5BQ1V1OS9vN3hXaGhPcU94MXBVNDNFUVpq?=
 =?utf-8?B?MEFVYVhNQkJZOHZSamtVRXgrYUFTTk02YU9USWZSTUszOEJVVkN5eHQ0TnNL?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce7eb0a-0eb8-43aa-ae6d-08dd81932f74
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 11:45:32.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8xzsNrVFt7YZ4FTD++d1bECadOf8RLpgjafACWz5HAXROKbz5VAvrgbg1jWVRnd+EP+4xY2FHkxtjHP77yzA5WGZC0c08rNI/Pgvz4NugA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFDFE2FD117

Hi Neil,
    A gentle ping, thanks.

On 2025/3/17 15:16, Xianwei Zhao via B4 Relay wrote:
> [ EXTERNAL EMAIL ]
> 
> Amlogic S6 S7 and S7D are application processors designed for
> hybrid OTT/IP Set Top Box and high-end media box applications.
> 
> Add the new S6 SoC/board device tree bindings.
> Add the new S7 SoC/board device tree bindings.
> Add the new S7D SoC/board device tree bindings.
> 
> Add basic support for the S6 based Amlogic BL209 board, which describes
> the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
> booting up into the serial console.
> 
> Add basic support for the S7 based Amlogic BP201 board, which describes
> the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
> booting up into the serial console.
> 
> Add basic support for the S7D based Amlogic BM202 board, which describes
> the following components: CPU, GIC, IRQ, Timer and UART. These are capable of
> booting up into the serial console.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Xianwei Zhao (7):
>        dt-bindings: arm: amlogic: add S6 support
>        dt-bindings: arm: amlogic: add S7 support
>        dt-bindings: arm: amlogic: add S7D support
>        dt-bindings: serial: amlogic,meson-uart: Add compatible string for S6/S7/S7D
>        arm64: dts: add support for S6 based Amlogic BL209
>        arm64: dts: add support for S7 based Amlogic BP201
>        arm64: dts: add support for S7D based Amlogic BM202
> 
>   Documentation/devicetree/bindings/arm/amlogic.yaml | 18 ++++
>   .../bindings/serial/amlogic,meson-uart.yaml        |  3 +
>   arch/arm64/boot/dts/amlogic/Makefile               |  3 +
>   .../boot/dts/amlogic/amlogic-s6-s905x5-bl209.dts   | 42 +++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        | 97 +++++++++++++++++++++
>   .../boot/dts/amlogic/amlogic-s7-s805x3-bp201.dts   | 41 +++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        | 99 ++++++++++++++++++++++
>   .../boot/dts/amlogic/amlogic-s7d-s905x5m-bm202.dts | 41 +++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       | 99 ++++++++++++++++++++++
>   9 files changed, 443 insertions(+)
> ---
> base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
> change-id: 20250221-s6-s7-basic-f300c30877e6
> 
> Best regards,
> --
> Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> 
