Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42E34EEEE;
	Thu,  6 Aug 2026 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785992813; cv=fail; b=NYxObN826aD0oVrrMTr0S1KlX7+zovrzCN8LJOJ08Ew+T9qQlHbZTYd1WCqPuMwJ6Bm7zGHs2s5KdSDnPfXPRY7dJvv4sVDUh9V9eP1tCobADMcyLMTMWXAvmXobf1lJTRwLT+NUf3pO67UUwhPY3R1nIlpfh5H3P518tFS+tc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785992813; c=relaxed/simple;
	bh=eMqCBiIX1FpBOMqZA8gdhdAWl10jNikxy7J5X65RQGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VTEFm5trDsG2pOv8C9BhqOYBZy6cSlD6V6/35qFF2SpHAiNADkqdhi1hMxJ2nyShdfmG86PdbOtlqKyfG5/ig3UBgrQoZs25oODidDYpYnm7m4wrmC2igjv3uecD3/YA425W4wDPbJDAVPqjYAfxLuX/mcAgh3SERz9X1tkK8ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sdFugO+W; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sdFugO+W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVSwsxNAAMDYyeFE8hwtqXcEfAdd0V7Mk3y1h7Ffeg4ExWTI//pox5xR/6DYbGoDEZMr0VH8wr/lvU0jq0apK9IxjKj3Q8gLJQQziCav2mWLU5FrYBc8JQeTyq+/zK6CpXYBK3UyrfXSSq9MJ9pcpYs6JV2+bDCvk/k5/Z3F2YoiagAjnQfhQoA/8VEOuVUGZX0KRmEkkhWHCV23Q6spgY2lH2M1xZh3IkbRlPAaZSElVbTGCbhtpWeP7pjZphp1v0namwkfM5tpbng/9p6262e+ElIlqVmGlu5y8OQLZgTTcPahloN800TcjT8ySW4yBV4917NJB/LmxlmDyKwG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADAH+PcUAAg7NjNYqpU1bCA0hvi1SDex7cBhCjS8DjM=;
 b=oG0Kg97lWJrjsSNOe/hhVUwaEVbTcxMUUHCXtII7Rpb0X0MDAAS9pD/BsM8HPGsUCV2hVnVPOBsUom62tJw3zOwgMpahF31EfQ7t016iyHxcHIrbwQWvoXZzA+5Gt2J71WrhZoU8YZUcDUGUeKZX/z9Q8VXMSqx6qmkzMZEBeRa0kij2N7ZYJBtyerJO7MrhQjPmYU+//R2LmPfaEVHNzdzY/TBj4nlBeJSTd1TpQu8dqQS27BxzScWuiP5/CStfP+QH0pcXd4Tz7MK6cvSAQIiF/rxjYlXwDs38o0erC6KY0qYzUTcaIHS1z+oupXttqMTRhwIXXqK5C7zipMQk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADAH+PcUAAg7NjNYqpU1bCA0hvi1SDex7cBhCjS8DjM=;
 b=sdFugO+WEcUtvRHGcZ5VCaht6FqfDSa2K1zm6C1EG+Y9fbilzKtfDMp4GcCcJtqeaqH1d8XT1UAYvVD+WgZqmNVtdBlCr4j0FX006NH8CsH+YHssLigbnlrp72RPQrOl2GzXm60KC+uMK7f/ZopUbLximwqN68YZsUjvBBur264=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Thu, 6 Aug
 2026 05:06:48 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 05:06:47 +0000
Message-ID: <ba03724f-d56a-4bba-a7a1-42f8f2bf5962@amd.com>
Date: Thu, 6 Aug 2026 07:06:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: serial: Document Axiado AX3005 UART
To: Swark Yang <syang@axiado.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260805-upstrea-ax3005-uart-v4-v4-1-8399f0773b13@axiado.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260805-upstrea-ax3005-uart-v4-v4-1-8399f0773b13@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::19) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: eda3989d-fcb6-4585-78c0-08def378844c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	HnzkD1Zlq6rIx5InDY9GXMrkUFoGSV0ZusPUMF/KBcY7tn+EBHNXNaEbByNBPmPruacTI1xLwmsjt093OKSK/v12M4dbGgPnHoTYUGIlgyvOC3dEBsESU9s/zzmnw1scLpZXngvBXAPX7eg0Ek8WucZbieecdWeY0TEez4KAoioNW0wvY3KhOchZ482j7vMxh7A4OA/edK12aVrFSlB521TsjbA/DX8r7nGzDlWwebkfQbxtx6km/pwfw8hbwmmE4N6Dbmogwv5HE0GFPcmI6p5n0O9wNXvIqc6qcgJBo8BhC4Hbn3buYNBk9ZwgK9CzOQv/MSid/qE9v6gOEI14pXoeAhiUhJweBngiVVKzb3znwcVgFGfP3ExgN3jBdSlZRsLVkJxYlngcm8+CydVARdWRM61BedDwFMRRGBN0BH84Y1oLtMsmc1hjiwqyIPsaw4rs1iBG3zD//Fyf84rbi+dobqUXPjWyIlgOP1sZOqqJiCJS5bUQwgbEzBoevQsDm5QL2Me7oGulRpoQoPzimmPr7nYQ1aipSyZoz7Khaz6JOqpBRVxxTH2CTIeVFFeyhtRyq63i31ANXHhB04gSbT7pRmAnFrj/uiSKQl+vjBQVy101i115FqSpaXTqFKauByrjcmaKcIpzoxcO+mnOLRGURsqs7rXQbiveahQrKlI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amZKM1ozSkV2RzBhUzlYbVZVc1FTWXQ3M0RnWFVWWW5HdHJGT0tJOWpheFc4?=
 =?utf-8?B?ckxjNkNkeXV4T1Y0Uk5uamoyVUJncVdMR2lHNmFZQWNHRmJMUUV6R3FEOUJt?=
 =?utf-8?B?cFhmZTBubWdKZkRVTTlxbG9Bc204SjZpRlBjV0VOaWtQdDJMRHJKVnF5cVZt?=
 =?utf-8?B?QUN6NUg0azExakdaRVNsdjZYZkNLbEtJUnBwYmxjTG81MTFMNzI5aEoyMkRL?=
 =?utf-8?B?aXBLNmlBdndrb1NZYUE1RnU2N3RHM3RvZGJnS1ZFcjgyQjhlV1VjaTJqTG4y?=
 =?utf-8?B?Y2JtUXZuS2RkVnE5U3V6dnVoYnBPbXcyc2dkZ0dmVVEzSVRqRkpyems1VmYx?=
 =?utf-8?B?QXhTQUVrUy9Jclk3RTNsR21OcVlnTng2SjNscG44d1JWRWZwUC9PSVQxQ2Vl?=
 =?utf-8?B?aHhnclhiYXkrdWlVNjd6V0czZzlxNVg3azdGVlNRWnp2amFoWWk4a0RoUE5i?=
 =?utf-8?B?U3NUNFRTVTFxaENjYklQci9nQWFwdTBmVnRXMHcrSlFRN0pteURtdjNzZUtj?=
 =?utf-8?B?cktrYS9tM2o5MDZHdWNnS2JlQ3FtMmZGT3BTMm9WTTF6ODhzQ0hTTGNGQVRo?=
 =?utf-8?B?OVA4UDFGSVRHckxDK2piMUx0VXNCVXBHVUU2T2ZuZk5ERmgwaFcvdjdkVlQ2?=
 =?utf-8?B?d0NJc1VzdXZzNG9UbWxVTnhFR09kUEF1YUtDNTQzYUppcGV6WmJSTlFHWldu?=
 =?utf-8?B?OHBlQmgzU0RzTE9GdjJpcVB2L3VLRjNST1FhaURoM0JaZC9TeC9VMEpJWlFH?=
 =?utf-8?B?TUhBREJ0bEdwK09pb05XUFZjM1hGejFhZC84dkVKekQxYmdZSlg5TkFmbnN4?=
 =?utf-8?B?Z3krazdqSHMxSFJXWjJNUlA1ZGNjUTlGVUQzdDl6Wk1XOWhMajFHOGNxNUE4?=
 =?utf-8?B?RmZYTzM3M3drZ2VCYW9uaUg3TmxVdjNneVN4eWQrak5kN2p3SWtCVmZXazhT?=
 =?utf-8?B?dTZzNXpSZmcrRThrUlZja3IreFJXQktBZlU0WjFKTGZFMVlCaEg5dHNCVUs1?=
 =?utf-8?B?TGhvMS95akVBbGk2WWxiM2pLOG1LeENjTldhNVl5NUdIWU9VMmt3R2VWUVd5?=
 =?utf-8?B?SEozdDVySzdmNU9RbjZ2dWU2U0VSM2U4MjFST3FxeGJXbVRtaEpBeEp0ZXBi?=
 =?utf-8?B?SEpqaHJuUnBhaFdXQVdiNkJiL3J3bVJUUEZYcE5xWkliemo2Qml2bmhFS29L?=
 =?utf-8?B?Tlk3eTRBdHZQZzJiQ05jQ0pCZThMV2tRcFZwUFhlNURNNnFjSjZzZjRGbUJk?=
 =?utf-8?B?SkdLMWxEMTRjdlA1cTN1aDdnU3NPeGpwd1M3WmRwV0g0cUJ1T1grZHhFVDla?=
 =?utf-8?B?SzdOSkNZbnpSTDRpeWUwSkU0YmZjcnJsd1VidnFoSG04NFp2cjZJUXlrTkps?=
 =?utf-8?B?TTNXZU9mOURQYWY4ZmZPVUkyalpwZDFwY1N0MzdmZW52UmNLL21pbnZ6OEFL?=
 =?utf-8?B?aHhYTzEvUEpRSit1YmZiVUxpSXp4OVlTdXBGRC9BSUc1MGVpQm5TNDlWVU9O?=
 =?utf-8?B?cmFjWWh3ZjhORkl6dEMrVGs5cW41SUxqT0VoYWE4c2lXaXR2RFRuY3Q5L1Zw?=
 =?utf-8?B?d2dXM045UHNMcHMxZDVVRHhPQm93TUx4cGxYRG4xNW5pbUxnNkErMExBckNR?=
 =?utf-8?B?MCtnTjNwaUdDTm52MXVOS3hvUEpSV0k2YjVBN0NCcjF5Tlg5RW1GNzcwZVBS?=
 =?utf-8?B?Z29VVm1xRU9zSzRtWGlhenZ2YkplRlgvNDJvMUZxUlVQRjlrMm9xK3RXWWdr?=
 =?utf-8?B?Z2Q2TjF0elFSNHFzL3EzVVVaSlI0SFk5ZjN5T0RqZkhWcURNdTJsSHZnRFBL?=
 =?utf-8?B?L2dzVFZnNHYzUjk0UVRJV1VoZUFtaUw1SHFhdTd0TzE4L0Y0alJvZWIxR1ZR?=
 =?utf-8?B?ZnhLQy9BOWg0dTF4RTZHWTJwelFsdzJjTTNOM3BCaHF3ZTlrWTg3YUExMmR1?=
 =?utf-8?B?VXFzeURpNjduRFBWbXdPQnpWd0hrdkVvT09icU1LRUtEVDBEZEpycGR5RVEv?=
 =?utf-8?B?VlBqUnpNeUxOMzRjTmE3Q3dtMFl6MVF4UmNaZmpJRjRmSkRldGhGWnF6aDBj?=
 =?utf-8?B?ZDlpYlRvK21Od05nRVNaK2NkRUpwSklNQURYT2ZuL1VuWEZXbHdNT1B3T3Yz?=
 =?utf-8?B?bnJRWDFNSTVjZzJ4djZBZUV5MDFwU0R0dWlRcFhNR0IwU3NpWTZHRjZVVExn?=
 =?utf-8?B?ZFFIbjkvRGFmd1Z2UmN1a0d1R2duTVkzbUdkOUwwNDFtWXhVTXpNRUlXZHY4?=
 =?utf-8?B?MlhwSURnTWg5L3BoVUlhaXpReHByZjIxWWVVYmxQNmYzeTlNamlDaGxDTEpQ?=
 =?utf-8?B?YVYyMlNHNExzWG9sVEo1dnhmUmt5aFErNjQ3bmVmdStzdHFKT3Jodz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda3989d-fcb6-4585-78c0-08def378844c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 05:06:47.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f51FElOYNI+If1kMxfaP3qsUpm6hoIaoNyQKTZph3mAKsgbUYSfLj4fcol9rGxjE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856



On 8/6/26 07:03, Swark Yang wrote:
> The Axiado AX3005 UART is software-compatible with the Cadence r1p12
> UART programming interface.
> 
> Document the "axiado,ax3005-uart" SoC-specific compatible with
> "cdns,uart-r1p12" as its fallback. This preserves identification of the
> AX3005 integration while allowing the controller to use the existing
> Cadence r1p12 UART support.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Swark Yang <syang@axiado.com>
> ---
> This UART binding was previously submitted as patch 5/8 of the AX3005
> v3 multi-subsystem series.
> 
> Following maintainer feedback, the binding updates are now submitted
> separately to their respective subsystem maintainers, as there are no
> cross-subsystem dependencies requiring them to be submitted together.
> 
> This submission contains only the AX3005 UART binding. The corresponding
> UART controller nodes remain in the separate AX3005 arm64 Devicetree
> series.
> 
> Changes in v4:
> - Submit the UART binding separately from the previous multi-subsystem
>    AX3005 series.
> - Expand the commit message to explain compatibility with the Cadence
>    r1p12 UART programming interface.
> - Add Krzysztof's Acked-by tag.
> - No binding schema changes.
> 
> Previously submitted as:
> 
> [PATCH v3 5/8] dt-bindings: serial: cdns: add Axiado AX3005 UART variant
> 
>   https://lore.kernel.org/all/20260716-upstream-axiado-ax3005-upstream-v3-5-c429095143ec@axiado.com/
> ---
>   Documentation/devicetree/bindings/serial/cdns,uart.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> index 9d3e5c1d8502..11292de42c67 100644
> --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> @@ -19,6 +19,7 @@ properties:
>         - items:
>             - enum:
>                 - axiado,ax3000-uart
> +              - axiado,ax3005-uart
>                 - xlnx,zynqmp-uart
>             - const: cdns,uart-r1p12
>   
> 
> ---
> base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
> change-id: 20260804-upstrea-ax3005-uart-v4-fc15932c6cbd
> 
> Best regards,

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
