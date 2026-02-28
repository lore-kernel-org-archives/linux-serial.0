Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022115.outbound.protection.outlook.com [52.101.126.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F937105D;
	Sat, 28 Feb 2026 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772264310; cv=fail; b=lVZweDO63Sk+VeFu6yofrv1XTBIpUTTNuZTQVz8eGFn5/3kbPXC6ucRaf2wi10D+tc6j/BTlyGJxsR3lbAnP+Pd2tGUvFsJyI1YQV/kjxVADBp64UJszZNyUTgeU587KJezq1n9YTmPrQ/rje+UffO3WNxJ/MGNxYWVyQ59Zly4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772264310; c=relaxed/simple;
	bh=vbe0iosbAikv0D+AIT8NU9UFKVXEC1/hN+o8PLg1T3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uj7qYX1bx5uwGbpmJKct94fL74eaWAxcW3t/Rh+xszQ3ALcCJzOQBJMhNIt3iqZNea+vdhbqEtRGkOd9rwvsak+/KOtVkODvXPUCASrAKNdwz+8CJltzM6MSajf8KvxgGubjQTbyCsW5/v6quFovG5oAofR23X0QurAumkByrLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Nx3V1Anh; arc=fail smtp.client-ip=52.101.126.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Nx3V1Anh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l34i/jNcE7kcOk9J+fzqI0N7IrcB8lHls8y4UvOertuN4bkGhoeVFnMHofn3Ic4nE/npS67D/tUL0gVYqma/12P4S5HNZQ7rkHQgEcXJTp6q565jobRNnoEKvGtT+pKsTow2/aJVkRdgN6HrX5G0MpoDfssk2GBbET3NQiFzOei/0k9rzeuYb9Q8GPMyx0oMG0QBvV9hOX0ipeQtr4Gl8z/KJ4Ta2Suy0woPdgRSz1ZJsr1VkhwVUg47XXSa/3Fc5KRL4HWOppjv0JVQUdLaON1mmub57yKxTA5wCm+uwaBSREWqGAt1kXaE/95ONiHAD9AgpNXeQtuza7SL1hOOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ldq32dcltsUd50tnJED6VBErYyfIhkgCldGRQqhwFw=;
 b=mZZOcKRYRLFE+yFdbcIC/tBJTLBTFrXF7+/FcuZYJlBxpezWIZojze+ZE1fXEBURlkoW1HmfrP4oc38defID2Oc2eXIbi+4W7d+NZWKuBk2mkH3vzhsJw7HCF0wvpYatfjt9NC4mzmZ1xlBiukqVOfc3gonVuU0BsVBRzjdAI7Eb0m3ulkReacW2V4Stq2iSNB5rOaawr+W3Y0PH+oqGZyNqX6OnvhQrdYlMyW88N4dLfJl1LBf4qOIm0Fts7SmsrPw2M6blwAOCgouDfNHd1MDO5xgPw8Av5UEtyOv3JBFv6iB7Z9iOmEUuVOowNeMc6/FnhVYVm38MOA69ruihsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ldq32dcltsUd50tnJED6VBErYyfIhkgCldGRQqhwFw=;
 b=Nx3V1AnhcKJyoGoCOn2gN8l2dUYkZcUGjfTsWbDrJxLLcNNjIpcIcZjEaHRTIlZQYuzT8GFBiskZ5js0QKwMnbW2G2aLQ00Fu184QE+2+dL+JmMMYL8cZpDG1NdL3p+HH8gydu5DwTqJGdfTXSd+E9SQmNrQLIOCdQRGHOjrku/CVdDJoPb9BSMuDoUhziq4Rx3N98iJWwiW9RDyMCKbShQp1/9nkHfoiUaHV7YAcmLMyX5zuXpqO7PMGC8GZuFHDR4zRPavG4nJ61pM3jIRjgtGcSzcX2F+cfuAtDNEoYhX+Tzq/wRmjhA23vEsdmfPiFcfKWKcF/oKFSotvcicrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KUXPR03MB9643.apcprd03.prod.outlook.com (2603:1096:d10:5f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 07:38:24 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%6]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 07:38:24 +0000
Message-ID: <1e2f18ac-bba9-41bd-a5b6-3b3a3d870eee@amlogic.com>
Date: Sat, 28 Feb 2026 15:38:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: add support for A9 based Amlogic BY401
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20260205-a9-baisc-dts-v1-0-1212b46f95a7@amlogic.com>
 <20260205-a9-baisc-dts-v1-3-1212b46f95a7@amlogic.com>
 <CAFBinCDmOG74HMTo7AtYPUhWCJu3_e0XjE=CKuDWOdwfq21ygA@mail.gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CAFBinCDmOG74HMTo7AtYPUhWCJu3_e0XjE=CKuDWOdwfq21ygA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::18) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KUXPR03MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: 812f5061-441f-4638-99ba-08de769c5ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	TJGFdRavGrLJuy5gWi8UrtlTxHDH4vi5vdSDe1/jGe0t33VY5pSMgbJ+FchLnP1M575M5gZZH+yFwnGkSHtGcci3o+2fReh1Li8gxXQRhLe3HVGs1SKrAae/j5xIFagYrzSmfqM8t24EB1yHmHB78DI5flehKyiPVVm2uZo68cQZcpCrYXlmy8KqL06ppc2ucsaWlLoG8dlc/1bQ0q9AwdkYt1ONuXEz8mCdwXe5lAcZ1UW970cHXqGqh/C54Y9cBpwOeMIQIVSPtYarkO0dYZ8zf3tVm1VlIzPG0EY7fNpS/0Ik+aX9QnRqJcFYqQjywh0su4cnxdAXO7SJ1V4xdip6mcDmPyUY937KY8c2rSIxZfjYyCdPrCmqQ1xlqjls7MgKegENvni0Gqxig0QbBwWM/JAU0hKGKXmn+Z3uKybea2u1E5W+GxkkLVpkBs/WBRyoSSv32UlylZaqcxMpKiucrfhV39n11jwyiFt6F9ZpNghvFYVvv+uZe4L9pDEKXnlQkVyXIg0++1tsM0h6euUaEqSCwD08IEMNaAjZ4cE+k4SEQNFwB51EmFUuvRtb1XYASMAlZP0eSiqxtpa04THgfCsc3gf46/2I1V1nFbOTxFyU5W5BjM+aG5Hs56q4LXBRJf7NOhsk0bhdCxzHbfYQsIiqYfNgwx1ygCcuxCK442EQbuZIMWLiA0CxeRoXP1JsegRc96gQkTtDdciWpSeH3eQzG4jOnF3SPkpFbmE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1R1VUd1cXU3cFo1Z2JVaTlubWZMWXhiMmJOM0NSM1FoYXVmdVlWTzJRRWlw?=
 =?utf-8?B?Q213R0lzMlZUcFZ1MWNxU1MrK09jMWkybGxxSlUvK2VIZWxlbUgzU245eUYx?=
 =?utf-8?B?UVpkdlJ0cVZkL0M5RzBzd1FlL3EvRjRNK2Z2K3U4Yi9Ed2RDR0hqNFg1ck1T?=
 =?utf-8?B?TDNDcDhLcmVEamFtNlFVNlQ3ZnN4dVk3NzBlc05vOWZEc2lRZlY5eUcrTWE1?=
 =?utf-8?B?ZlEyNmdIWWV3TG1IYWtjK29TSWcydk02ZHp4TkZIdTJ0UHhnN3RIVUVhZnRz?=
 =?utf-8?B?dHVkRHpmUzRUdXlXb0JuRzNkdmQyczFsMS9SZVd4OVlSU01tMEw1QUVzVHE5?=
 =?utf-8?B?b0dZbU9WdHkvUjZvVTZpN0FJRWdvYnF0RDlza1QzUnpCSGZsenIwd0d3ejRx?=
 =?utf-8?B?bmRwcXpjVk5EV3BqUEdPYUtBUWZ1VHExeWdMOHBLUzZNR3RZMzN6VXVuMUcz?=
 =?utf-8?B?eVpLbjMxMnBsb0p2MXdtSGsvM0VzS2l2TjhUbWpDM3BQVzNCTC9QRGxPNUNr?=
 =?utf-8?B?SjZtWWxKTmhOSVhBTHdiVXFvUzZUZ2NEbDRsZTJkTXF4SUtlbVBmV2NjVEw4?=
 =?utf-8?B?eUJkd1R2dkpwYjlJNDdYTVcraERNKzhTSkdOa1ZEcys1V2hzNnIydUQrelZo?=
 =?utf-8?B?ZE1OSGJMZThXeHVybGNad1BuNWxlWStLRllQQ0Z2aTBITUw5aytmVnJCVFo1?=
 =?utf-8?B?d044dUZNNDRmY2duQTBrdmFQR1JacXZmcXNLTUNBVHNOUWNuZCtrb2ovL0Iv?=
 =?utf-8?B?NURucm1sbFgvc0J6Mi9FeFQzR0hFUU81UVRKWlFwbnFkeVZEdGM5ZXExRWdE?=
 =?utf-8?B?VG1ZNS9RM3BxbWQ0M0hTTWpiM29oV2k1cVhYYlRXTU1VM1FWWVVRdVRadWZr?=
 =?utf-8?B?eTQ3T0lSSklFMndEb0R1TXBxQXN0dlVCV1BoeDBmbVlxQ0F3K3JOSnNPYnRB?=
 =?utf-8?B?NG1xczY2R3dveU9pcjhXUDJiNWUyN0orNnl5RnNCeXFnQWxsZ1BhK1AvWjkw?=
 =?utf-8?B?OHJCUWVTS3I3WER6UU1JMkR1c08xOVYrY05hMEJLaDhJVmdBRnRIL3BsZnRu?=
 =?utf-8?B?cWxRUnNIWEgvNXJsMTltMVlPS21tbVJKbkxMdXExRlB1bmpRd3BJdVFZYXFk?=
 =?utf-8?B?QWQ2cExWaEp2Ym1GRnB6VmVMc3NVNkVOTERmSVVOZFczb0I3OFVVOHVtYVMw?=
 =?utf-8?B?cVZJNjZrVytYVlN3TFhkMGFKbEc2WmNKcElxS3pwS21PcWcvbzBxNFNqTFJL?=
 =?utf-8?B?MURlWkNvdFh6aDZsSWRBWWY3Q0xoRXlVdFpmeGgybDY5Z1Fzazl5b0tCRXFq?=
 =?utf-8?B?Vmt2SktGaUlxTDk5cEovRkdVaXd3SG9YaFlkM0xRWW00Zm9LcTJ0ellKYm9Z?=
 =?utf-8?B?RkdVWFlVTCtRM1BUNVJVRjR3L1hQaW1xYU9NYkhSaHNZRi9Ya21nK1U2R1NW?=
 =?utf-8?B?a2pwWEpxN1kwRWlXRjYveDBvUktrTHpSMnNmRXMrRUFodnI5K0ZpdWVkU0J2?=
 =?utf-8?B?VmFwTGdkTWdYd2toV1JmendLaUZLVDNzYWdxM0lMRnFBMHpua1dTQXdxWW9R?=
 =?utf-8?B?YUVOZ2dFcHIzTGUrcUEyNVc5ajdobHJINUVwV241eCtXSjVkM2hCSUdISGZu?=
 =?utf-8?B?S2hlNzFtVmNKQm8xRHJiYnNaNm1hMGF4R0ordWp0MmQzZEkxM29TMno4MVZT?=
 =?utf-8?B?dlFtV21VQmdUdnVkZlNYaHFsbkxUQm1hVDRBd0sxdmhEbGdENHFxTTYzV25F?=
 =?utf-8?B?dmx5cS90ODlNcG92VG9OV1BkbUQvTGNSYkNLUTQwdk5rNWNtdFBqNnlhSnAz?=
 =?utf-8?B?dS9BTGlNWWY0MSsrN29CRUpzblJtTFF4UUpJdmNvWWIvOXM2RlJoNFkrOThj?=
 =?utf-8?B?TGhKb0NrQjY5Qis0OFB4SEhoWDNpSExQR012Z3liTEc4Y09TRW5QT09MWXEv?=
 =?utf-8?B?QzNMNVQ2K2s2RkNVV29BdU1nT1l0UWdldjJXa1BNaXdJMkt2UmhDc3ZiUHVW?=
 =?utf-8?B?TU03VTlmVFJzRWRJZHVLVnFibGdRL21hWm9sbU9QZGU5KzJyaTBmTFpFYXpD?=
 =?utf-8?B?aGxxcXI1dU4zaDJJVWNXbEs5Ti9PRnpTS1RSZlRZYVJidlR6eXBLaFZrcStj?=
 =?utf-8?B?V21iK25xU3lQR3ZCSnhVN3JxaDlPbFRNazZ2T2txakIxU2VXb0dCdURWWitI?=
 =?utf-8?B?Ky9HRE1NRU5yMEJBWWY3RWRJWWVFeUxrR1R0S1E0UU1HU0Y2Vm15aEltZE1P?=
 =?utf-8?B?NzdqMyttODJLbktlR3lPeEdsOWE4M0lsS2kzR1JXZkdyTnFSaWtRSGRxTHdt?=
 =?utf-8?B?SlBxdHdQcEFDK0RrSVRGeFBoL2tRSTlmUVNKUGxNMWtjTC9ZS1R4QT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812f5061-441f-4638-99ba-08de769c5ac3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 07:38:24.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10RSZ2UVt7fiLr+zSYEzMSLEPK58sr88ApTp9X5IqiQAHbjf96QQEjDXSjpQGoem8jMY8MhQ4KOdMWTvOKPqm080Uv1FyzDxlDAtoGn4uRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB9643

Hi Martin,
    Thanks for your reply.

On 2026/2/10 06:19, Martin Blumenstingl wrote:
> On Thu, Feb 5, 2026 at 7:04 AM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org>  wrote:
> [...]
>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts b/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts
>> new file mode 100644
>> index 000000000000..ad35a3292d49
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a9-a311y3-by401.dts
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2026 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "amlogic-a9.dtsi"
>> +/ {
>> +       model = "Amlogic A311DY3 BY401 Development Board";
>> +       compatible = "amlogic,by401", "amlogic,a9";
>> +       interrupt-parent = <&gic>;
> Shouldn't this go into amlogic-a9.dtsi (I can't see why different
> boards may choose a different default interrupt-parent)?
Will do.
