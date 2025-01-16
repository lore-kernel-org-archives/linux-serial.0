Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29F41DE2D4;
	Thu, 16 Jan 2025 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024079; cv=fail; b=fDOnMg4fd6Mg9zX/YI/t+P+UQ0HPrJgm3b2zbPKHfxjfEdMDLzSn9syBZA+caTa4ccc0yuS4n/bLskQPwZHlOII0jnmj5SophKKhlGShqe5oFu36pfvTy4Si4Xj7Xs4hBeTzNU9aFlrKz1rctxG3Bqk5vVCE1ICucwCQxppcBN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024079; c=relaxed/simple;
	bh=x0IOAYCK/m6gHypZ9SOQBvp5Xwomo/gXdkze2wjSGqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l9bzpajyn4XWn9qbQE+gbWFHPxh8ZS/OD6zK04Bpu8cEdp/RBstDRoLeORfMlcJa2ROLoApyy4Le1dP39tjm4bfDarBx1Ayim89nIJSqeClSOraFex8noTRlV+iYOpwx9aWWhi3I9P7WDHdaH3iApH67jfr+aPA90hezp6txKfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QRChTW9Z; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QRChTW9Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb8pWgkwKWAPo0GhNvAQ1/li+ZhvSRgpQ/1Mv0TPWatAEOF6zmbqrd6TuI77Sv/YMtrQOOHTqOIgVmGMMJKJAF3qL13aVP7rWLlytir6k3TJUJ6of7nPUN9VrVyPEUpoiUvhAF3EFYIS57nZgmUWzHmRf2JBevCsdX77dEEQa6XDNUJusXQx4ZjzPwMaGXKqv2yP5hcuFPpaXuarl16sGmVTQPsYhkR4FifKQnbiDAPmiicG8pE8f4S29yi+bVnNFdi2edvg/PL3WtjEECwb4HMUBRJD32WmQTxv7jYan+1dpZGiSNK5CI0SJpEpy85bnflTfeIEdq1tZAqkO1dkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0aDaKG8rEG7AGyGJA4Kb9h7+sxgOvQWOZycBmZnHnk=;
 b=iwU10SW4pQ/+03+fMp2ZXPaldVfE0ff6cYlGHfZ3xcfnQx/TKXdTNRbcS7jNdFRHh69zw0JRlZj/iRExPl/DSIYlvVQnOZWO0YddD4osZ7wkMqE+G4FiWMzM3/W2rDpZacUZk0j7gK4l5PqPV4Zwg73ylF6YfPjPOLP+xnjubyXH1dnDIlrlNfKYdqgA2l3FhLfeOY351/wYt2Ns8R/qs1xT7fw8IIfLhY9yOsGPB6dVgGYdOZ/uTO3fK0mPtTbVjgm42kqvNErXOwwHDPm1i4Qyz0HLF6FRu+2F7c7TECDIiL7uIVRYYebBM2jqVJQWjLcItSg5WXQv7EsOSpPpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0aDaKG8rEG7AGyGJA4Kb9h7+sxgOvQWOZycBmZnHnk=;
 b=QRChTW9ZgnTk82ZtVygAtDEgCQ/DFuDfxanr3OhAs+ke+XB6ArkF7hN2WUZszjp4J5/x5d+0Y/POnTO05jsbMGsjPyBJq5esGnnnTgYCseXXqcYXWLWbIFHD0s+5J1LfdhceqFMW6JyTVPpkl8ufxBsNIdnGdyJNVuhVNGdvubSDnqXZC1/le7Cc5KXXoeYbE0iyQ0iFW3U0rsj3v0A303UBtl1Y2vPZEbH3EVdx/dhRtkFVWbtfLLSqwESg+55stwnzFSqOlQ9iX6d8zj+MV3zxcJddP9T0uRaIdJhs0aOuBSyMXk7bHU+vt1G+bPqzFiImMAo/mX5sNNYwSt6TIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 10:41:15 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 10:41:15 +0000
Message-ID: <bee7de35-e767-4c69-94ad-d09c92a3577a@nvidia.com>
Date: Thu, 16 Jan 2025 10:41:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
To: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
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
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <84y0zbyrf0.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::7) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ee364f-94e6-4753-c656-08dd361a4d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUZ4VTBIZDlsZlJ3N0tZbmxkemxZSWpwTzdSYnpjUk16TDU0M3UrR0dKQU5Y?=
 =?utf-8?B?WEl1d09lU3p1dzZmK0NUVjc0YnUvdDJ3M0M3eFpoejFlb2lXS3FvNmVXcXZi?=
 =?utf-8?B?cC8ycW9UUllpbks5ZXZxRUJ5VVdHaWFZR2lwS2JIRjFpKytzOFV2cFdERGVS?=
 =?utf-8?B?c041Z2VvaXNiM21RYzRuSXkwOC9Ubmt3YjFCbnZOQmN4cnlQSnpKaXB6V3Aw?=
 =?utf-8?B?TEk3R0V0MGpmaE1qdUtQU0gvZUVUbG03Smp3THVaWm50Z2ZZNUNkVjFoL2dE?=
 =?utf-8?B?K3FtOUFuN2RBTXVPZHZ6WUFzbEpVeTBzY0V1ajhJOVQ3Q1dDSENUc1AvN2pK?=
 =?utf-8?B?MmYrTWk3TnpqUkFzNE1qVWhaR1dFcWNTeDY1UnI5amtpOWRmQW5OUmlXZWFu?=
 =?utf-8?B?WWlpeUtjR3p0b1UzN1JTQW1KOHVRazZFUUdQZmwrN1FpNUZMa3pUOVp2ZjZm?=
 =?utf-8?B?K0Nxa015T2tGd280YXNScTl6V0ZDSjRXTTFVRERDVjhpQjFDTVNwUjArcjFB?=
 =?utf-8?B?a3phdzhBZ2Zac2htekVOc0x4RCtJT3Zva3JTcG5hM1BZNUZWOHNFd3Jkby9i?=
 =?utf-8?B?MnhwQmlzTEdEcWdSREMvSTU3Y2lsQStPOFovWjVMTG0zV1BTcy8wcjdZTEdp?=
 =?utf-8?B?b2d0M0RhdEFFQVJ0eW5iU0hsaXZnTDNIM1lWNHFodm9UcFR6bUFaWDBTcm5M?=
 =?utf-8?B?dDY3K1RRYjZkR0FHanhiSEhHQUpPeG1ReWhwb3FwTmRVWitnaTJ1TS9PVy9h?=
 =?utf-8?B?c29Db1d4dWh6bUNNWURLQlpPSFZsS3lIU3FtcUdtd2VUWTFnNlRhcnBEdkt3?=
 =?utf-8?B?LzJoMFVaUmpFY0Z6V3FXejE0MlR0S1BxcFFxK1djcHN0dFRhblNXbHdIdDVs?=
 =?utf-8?B?c1Jma2JKZ1B5RE1VdHlzMzNDRXhNVEsrTFJvM3JGd25rYVdKMEhJd0NxdWRp?=
 =?utf-8?B?VnpNREZFMFk4MlFmS2JhRmhaRi9CVXJTc2xZUENKQy9PR3orYzBQVHBicndx?=
 =?utf-8?B?TGhuaU1BemdLVGNRUlhTdm1MSHBLMjd2M01ESUR0YTh4SENibWE1NjZ4R2lz?=
 =?utf-8?B?SFltRnNTVWZuSm9uVTlrQ2pVUTFjd1I4WVJ2amVGTTQ5b010L3ZsRW5RQU96?=
 =?utf-8?B?b3o4SG1VbW96c0lIRE9kb0dKTVRTN1E3NFRVTExkUk8rQ2xUY2N5WGQyd3RH?=
 =?utf-8?B?WlZZZS9scFBiaXF1NlgyS25vMGZjVlF6ZldVQVk1bUJFQ2JpY3Z1SVpEUFBn?=
 =?utf-8?B?ZmNNSXMzcTZTL3dUc2lqamUycjN5VDZseHFZMTJDZGpTeDFOYkxIcGQ1MzBU?=
 =?utf-8?B?WTNvWXZFeklWY1BOaG9jZURVNVh2RVhxWHQ2ZVRXbEpkdklrZlByWUpOb25u?=
 =?utf-8?B?QnlWQlhHVWxVSzJxOHhjQVUwOUFMV3hqd2xmRE11NUpZVFJ6cWdlZnJVdjZ0?=
 =?utf-8?B?ZWJkQmZuUUVwa2ZqSlZQSHdnNHQ5a1NyQk01ZitXY2ZZdDk5RElUNDJ3bkIx?=
 =?utf-8?B?R3lVZldpQVEvODlDUUVLYTJTUi8xaVF4aEl1dHFHbk9FSExuNEYvT3lnc2hF?=
 =?utf-8?B?N09hcVUzalprMUFJekR2T0Vpa0FUekRUN2dXMkwwb05kWURIUUJBOGFzT1Y5?=
 =?utf-8?B?T1JOUnpKRDlsaDlhSDFtekN5K0hCVHJNb0t5VzNyMVlkaG5TTlpiY0ZldnJM?=
 =?utf-8?B?QW54b3lrWkVsd283RnB4bDcwSlRqQ0pIYkw2dUhSNGxWNkVtbUlYOXp3QmRP?=
 =?utf-8?B?K0pINmZtaXFHV0daQ3pyQ1Z6cXMzK1ZWKzZoKzR6UzR5OVc1aTVEYUl0cnFr?=
 =?utf-8?B?MWV2SWM1Smo1TVg4amUybjIxU2ZDWmpQbnJOWW1xTDRJRFJFY0VIN2g1ZVg1?=
 =?utf-8?Q?N1SfWURNyHFjd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzY4QXRFVWRTaEh3NFRFRjF5YVB0a0VsZ1FVYmZKUXNSTmFJWGJnUEdKSVA5?=
 =?utf-8?B?eWxpV2VhbHZvakVvSDZXM0gwbmU4anlKdStEY2ZmMzlrNDRkcThCaEMrS1FR?=
 =?utf-8?B?NVEzWUVJcld2YUlPR1BIN0RLN0ZNQVNZdEZnY3hzeW90V1hGYnE0Q0hYTHBr?=
 =?utf-8?B?SmZTZER1S2Vyak8zYXl1WnpzV0dXVEozOVppN0V2Q1M0YlFaUUZpbjl3d3k1?=
 =?utf-8?B?SVkzNStCVGE5dExYQ3A3RlBjVVVjZGFZVXRoTTVicWJHS3JjbXYxdE0xVk1P?=
 =?utf-8?B?Sk5qWVJ3Z2E2dlpEa01VSnJjbTZTWHRyQ2QvWlFaYVRMOHZFT1I0bXg4MzZz?=
 =?utf-8?B?aWFlNzI1R3plNnRsMU9XcExWeUZEOEE0L0N1c0N6MFUxUnU1Z0lWclAvZG1J?=
 =?utf-8?B?ZkhmR0tIZVlXNlVhUHVWaGZ0Z0FyQTdmaXNiMnY5ck1oQXNBSnR6WFoxa0cy?=
 =?utf-8?B?blZ1ckhDZ1lDemhoS0c0elBrckIrZGs3ekpvUVhPWjZkSWVoN243MEpVY2ly?=
 =?utf-8?B?VnVKRzd2QW9GMTZKY1VtdDAzR3JGNVZBL0QxZUJ2am1FS2J5VFV1TzNCakZo?=
 =?utf-8?B?OEI2Q3J3VEY0ZXNWSDF1akdOR05saUdiYVlrS24rNTlwZU0xK0NGRHdsK3Zh?=
 =?utf-8?B?dWQ5KzMvenlFR01YMFJRcEVlbTJFV2R4MU4xMUQxRWROU3NrZVJ4RlFnN0pS?=
 =?utf-8?B?citVMGhlT1dET293RWNlUk1BRnZwMVNNa0JYMUlDd0psZDFia0FUbG9mdnRZ?=
 =?utf-8?B?Sno1OS9RZW9CNzNWMjNDdGlwK2dSNG5KNFdjTnh2eUk3QzdGM3l2R2dNYTZx?=
 =?utf-8?B?a0lvNW9uNEIzYlRNeUx2bk43MEdLTFQvdVRKdkxPcWdPRS9NQlp5cWdIZ0xy?=
 =?utf-8?B?azg3aFlIRDVLaTdYNHRsTmNDUnhES0s3cGtFSlY2VC9sWFVobVZzOU5QQS9a?=
 =?utf-8?B?b3ozblBqL1JiUGJucWE1a2hqSEdTWnFRY2dlVExkZzFmZW5lOW1vRmFlT0hn?=
 =?utf-8?B?UllDU3ltVER5QStwOTl6Y3JlQ284UjF4S25oempIQVQ0L3VmQitrQWZxWXdt?=
 =?utf-8?B?UXZreWVIYkxHYW5pV2hUR0gzRldmSWR6TG03WlhBYXRDT3BrQ3BhbDRwRE1C?=
 =?utf-8?B?bkNacndEZ25RTjI3U0haTVFYcE9OR29rVmJrYWlnOVdlSi9QSVJUVzNldk1q?=
 =?utf-8?B?RFgyTElyb1FQUHA3NFk2Rmp3MEorT3F1YnJEekg4Vy81Mk1WanhoZC9sRWxB?=
 =?utf-8?B?d3VTdWo2N1ZnLzNwdDZxdVJSQ1NTR21vZlZXaE96TTgzWnlYMGc0S0kwQ0py?=
 =?utf-8?B?VzZhbXV6ZmxqTG12RVJqQ2xicnB4cE44RnBBTVlGM3RpWE5xWXR3RXhtQkps?=
 =?utf-8?B?S212ZFRyaUhuSVl4T3hsdWkwRFEyd29vN09mNS8wQms1YlVSTytSNnVRQldX?=
 =?utf-8?B?cXMyY3daOHY0UGlIeHVlSFBPRTZickZCVDhtaCtqZFVOc0RmcUNQVDRRV2lj?=
 =?utf-8?B?cWh1TnlCNlhxWkh5SCtWakk2TWtWa2ZScmhQSUlGTVpDc2FQM21QbEY1T0VL?=
 =?utf-8?B?MFAxb0tNVzJQT1VaT0kycUhwa0tQMnMyZ1RhMEIwSm9GOXZFU2lqMzlLRTR1?=
 =?utf-8?B?RVR2S3JrQ1IzbDZhYzZPdU5MYmlLQjdxVW55cmhxTExQWkxOYjNiemJHTytK?=
 =?utf-8?B?WllJTWpWeHo1MU9VeE0yQ3VCV3Yyd3dRVVd5WTZUUjA0WnkzalpzUk5XdDVt?=
 =?utf-8?B?M09YYnF4dWw3SUE2cTluQ0lPeGcrWGdLTGNkVXZYOXZQdGdybjBlRk1paHJT?=
 =?utf-8?B?NUdIYm9FQXdSU01vU1FUalhVSFZPYlpRYldKeGJlVDcyY2l5amYzL3RPRVRz?=
 =?utf-8?B?Q1NvZjZhUGtqaytxaUpUTDRib2JsRTVsMWtoZU5HdUlPZ3R2b1JnYUErYmhP?=
 =?utf-8?B?ckRoZnRoQ212TXB3T2pEQ2t6MDFBZTlXSDBKNjRpcmUvbjFuV2NKZkxzdlVC?=
 =?utf-8?B?NmZDa2hSWWlQQU0wRzdJUTBCckIxNXhJSHg5MHp0eXlWSVhRczJSRHB4eXhh?=
 =?utf-8?B?VVAvVC82VGFCL1BZeGU5QlV0OTVMQjU5K3lPcUoybmUxekQ3alVpczN1UGwy?=
 =?utf-8?B?K0hVOTA3RHZPVE9ldFluTFFOME5DdFdDY3NWbm0yS0xXMmdkUmxKVm5FWkRF?=
 =?utf-8?Q?AEI+hdRdZVnRuSy50If8z0OvgyCEU+5T0sMmDANWXypx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ee364f-94e6-4753-c656-08dd361a4d0f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:41:14.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AF9Dy6HoOQqGmZsr6XARv3nnbVwfS4JNmeYZdFX/lA5R5C8v4fRgNu/LiFsLsgEbL0i7EqyfzZWRG2LmgzVSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007


On 16/01/2025 10:38, John Ogness wrote:
> On 2025-01-16, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> Do you at least know if it is failing to suspend or failing to resume
>>> (based on power consumption)?
>>
>>
>> Unfortunately, I don't. These are farm boards and so nothing local I can
>> get my hands on. For some reason all the serial console logs are not
>> available and so I am going to talk to the farm team about fixing that
>> because we should at least have serial logs.
> 
> Can you confirm that the board is actually booting? The suspend code for
> 8250_tegra.c is quite simple. I am wondering if the farm tests are
> failing somewhere else, such as the atomic printing during early boot.


Yes they are all booting fine. I have an independent boot test and that 
is passing. It is just the suspend test that is failing.

Thanks
Jon

-- 
nvpublic

