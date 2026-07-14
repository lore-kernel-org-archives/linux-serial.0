Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023114.outbound.protection.outlook.com [52.101.83.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20FB36E48B;
	Tue, 14 Jul 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040916; cv=fail; b=pehPEo8MEhPkbrQ1DxRbmqG8b/YOc1AO5o6yj0u7MFurdrGUBuCJnYwBC9JVuyaublR5mAmDI3u9XmJ5rEon8PAJ57NpaAzvHl/0ZokOpn20VaUWTZExVlYEc6C5SrLhTXc441mM96DOmNC+mtuo+wYnBWIaSftWTx+RSalaffc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040916; c=relaxed/simple;
	bh=NZ86igLj/x6uYJmgfEdjAe6gF0PYiqJOn8ejLCCVpnQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ml1npN7fS1GMtVspqJk5rqQ2yugRf78QLAtBZOoYclT8tG97jl1j/7PFG5OMJvtisRC2EGJBv1aE8LgthwudFXwiINrL8PToo5ob3c3KvvJB60zk0efrfyH5M+lgDILDOBKtMmNeOv772GukTrSsUJZkG8iUhiuxw6Oumi3dg3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=fRCVOuUW; arc=fail smtp.client-ip=52.101.83.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="fRCVOuUW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sp7D1/CM0xEuyixf8WJ3AXxOzyDl4iDmY7r0EiHr5olBExR3SGCHck111CtHCrhXS9LOKkWD6AR0uxvxAxNq0uw07ph0/qbZmrWbl7Rkhov7pfM1cHyPnL+4aMYhh67xV87h5Lsa8s2iuuEE2wjrJL5mutxA8LHcwCBYefe2qoGYEbi6POW/xft5jtS8HUcvrNvntzet1T0KP02/3IdBIhGzWK286xdgU0ufg4dNJt2faMq9kwqQYr32NSnbh4FmG9dOSGrJl0jDGq/eHqZdYJq9cWKhrpuaxdzsJWHMDqxt9GLHeOI9u0QhJLpKALY/kNWH0WrS+/aOD0ZrikwngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg/JUNThOTIuVnk/9URAhHIVkgopkEL8vuvZ2626gUw=;
 b=YDEzSF8NQOXJl6iU1HlB4NPsUZwSaNYmaAiHW2hGgRXnlodnHABia2Oann1fWSbEGxtzrZ3iMHuX0tTFHymAP/IK0JDvNd230iVzoU8HQTBxGi50+mgZicLpXOnP1WLULHzBP7ZOvjHMb51H8Jhquz2FDRLGMiv7Qqn5NEcoihYwJHJYNtVFSd9Hut25Ef/UPBgzD9aOmn26ZgEoVuOvYvSZsIAgVEslXv2C8PWTeORWxKPigRhj77U1dOV1isy+6OwZthdXZwncxMxZoLNgn83a0ABt1dR42nsD5NKmps8Mnz4GK75DozLexuoi2WaROfFcG7xKgp5Epy39YtNihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg/JUNThOTIuVnk/9URAhHIVkgopkEL8vuvZ2626gUw=;
 b=fRCVOuUWKCwCjuNbKKKUgE7YHoGukIVdEbzXpw1y87CBgpfzSna2O+D0v7VB2uc/8vBBNdEfoUMtpB5kT/4FbXbw3sdlGN6sc/9E6Jqd02J/87BFFvNbufPxfpVDN00P6ISC6AjsiGBBwZvKCcqvceYwz7k90eYQIwUKvgdSeAa8KTbDpJaTvaVM0MuIBMJPtcEdJl65kWkoHy1chrvUS0U4TwuXpofavynHvad93QjiZZFXHrcWF67PD9DX2DER7b5qYCxZaY0XMt7kM4nmNLNhY/GgXZuQBaJBj6s39+p7w9m/1X1bB1lsQeHkw5JppmZgFiR8bhvLIKAzmxnevA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by DB3PR08MB9135.eurprd08.prod.outlook.com (2603:10a6:10:434::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 14:55:10 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 14:55:10 +0000
Message-ID: <e2d8d438-0710-4796-a5e9-e4c4bc13a9c4@genexis.eu>
Date: Tue, 14 Jul 2026 16:55:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] serial: 8250: Add Airoha SoC UART and HSUART support
To: Jiri Slaby <jirislaby@kernel.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 John Ogness <john.ogness@linutronix.de>,
 Marco Felsch <m.felsch@pengutronix.de>, Gerhard Engleder <eg@keba.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Binbin Zhou <zhoubinbin@loongson.cn>, Rong Zhang
 <rongrong@oss.cipunited.com>, Lukas Wunner <lukas@wunner.de>,
 Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
 <20260709205656.319531-5-ansuelsmth@gmail.com>
 <9062ca8c-e29d-4958-a3d3-c86e2a6a9e86@kernel.org>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <9062ca8c-e29d-4958-a3d3-c86e2a6a9e86@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::8) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|DB3PR08MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a88f56a-d3e1-4654-7ed9-08dee1b7e6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|4143699003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	LmlchOwp1vacozwwjtIYJyqJ0H/uqShkhM/YJK9kzpMPUxVcw/12690tG43C5GEyRDwWfoSZGkp3wPM3eq5X6rJnbL9ka19iZZ03ZbNN+KmQslHFaUSk/ZpYPgChB0pLPkDSnI+FhXXq3r+mb+ThfSvZn68EmV4ehqr6yf/l8yM/+wCna22lQxTmdjBoPFnvxOOsUMcep129cz4ZbDGDfzCaiioQtHRSjiVQoEYXBvSWODsc1dGkOV15naoEp24W8utpk2i6WXr4HOtM89R5kmUuixlkqUq3DO4FSpx4iHeGVxKqhUwOWvbIJtZV+2VFWr8FNWJbJT0TEOVECrMylYxlZMeUZGn2137iWQ50xHUJPhh1JA9VLlM6SCLfcI3RcFmmzz9MymdYJC1POfc1sxpBiCeUgtWUqvMC4ITSz4mhPdw9gK+G4dq6AmkB1qvITKaXEmndWy2P7+FN2KUcbE4hu+or6fk6LvLOfxRJCY3dPvjQasCcHPMXA7DF1K6ImronKlrfgWRYIDcV5HTketciXwVJ1B9tJr5efAMYkcM8UULVKZQ1rJEvakuWkYne/Ok7sIOny1zgSCEFU+c++3EwjBekGb8RZ18fhpx14Q3pgfJO7sS399yHy4aM7yW/n7bztzB91JEfDIuX5FcAGbIuUdHfN0rshQed8rtyN/3ssEQVmTBolUkdELuyMJENFw1CgsEkO3srG8b91alvpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlBIV3ZnQ3RjQmpTRmdNQ0JFZmtJa1h4endPZlg0KzBQd0FoN2wwOVRNcEhx?=
 =?utf-8?B?UlNhSFdoMmRqWG5LMnVtWEFUbDE1eks5ZjltOGVwRkpMdHhPdGM1eWswYjRG?=
 =?utf-8?B?ZGgvd3BCN2Nta1VMVDhsZFJJTVA5TlVJMktUdmxySkhHL3lnd0h6RTNEdWhC?=
 =?utf-8?B?UWhJWGovVTNoVjhDSjB6U0Rud1NuRXpTS3dtamhsK1dkbWp3eE5aUjZpb1VG?=
 =?utf-8?B?Mk9RdUNhUzJaZWR5bW1od3FSNjJISjh1N0RtNE56Q1U5WFFUWElvbFpVRzZG?=
 =?utf-8?B?SHF4SW9hRXhUWlR3dkRUZnZKdnptZ1E4a1ZHUXd5eDNoWlNKZzllMURhNFVO?=
 =?utf-8?B?Y0tZY0FNM1Rkd21tbmJRKzQyeDNHQm84S0Iremk0N25zT2dxRlRlYldpL20y?=
 =?utf-8?B?czJ4RHozZkc3VzNhTS8yL21pYktaVXI4YUpwVmRHSVFrNlVKVVQ1QytSZGV6?=
 =?utf-8?B?eFFGaGkwMWFpc2I1QmdkYWYva1R0dzRTbFhqUzUraHRtc3dtelNOb2NqeHFM?=
 =?utf-8?B?Nmh3ODlOTXdJK3VSMlNLVUpvSUZpa3k1Rnc2YnZWVEhtQWZyQ0NWSUFxNS9F?=
 =?utf-8?B?TGZISXBrYlVCNzkxTWxlRDRzYTNZUk1jaHZKQkU2MkRPTXJ6MFhtbGxVcjZ2?=
 =?utf-8?B?bTdnUFU5Nnd5RlY0UHlwbEtsOWFzY05tMWNmaDlqR2JrRUF5V3l6Z0w1Q3ow?=
 =?utf-8?B?VHUyakorUkV4dndHY3NQWUZTeG82cDNXL1c3SDVJd3BzNzNMQlI0MnRHUkNY?=
 =?utf-8?B?MmorblhkTVhud0g1QnBndHIyRTRQMlhnOWczRmYwZkRYVHc1TEo2cXVKZ0oy?=
 =?utf-8?B?TkFLb3Azc3BubVlvYkJFUG1oMHN0RnZ2bnRWS2RKVG82VnhyZmtXZW1jb1ht?=
 =?utf-8?B?YjJqL3Q5V3loZS9aMmVUa2ZnRVA3dmxmS20zblNnUER5MEgrSTExRjBOdFVV?=
 =?utf-8?B?M1FnOWRjVXNQQ1VOTmw1NjlFbnAyVnBQUmtlZUNHTkpCU0R4VXVnOFR5ZWNr?=
 =?utf-8?B?ZDNMSGJFbjRUMnZ0bjJYRG0ycy9YWmxHbFhPejFNOS9VTytOa3RDd1NERi9k?=
 =?utf-8?B?TmZGQUIyNnJHZHBGN3A3SXV6K1phT0dhaHhVZngrRnhwTDgxZ0tBb0JocUpx?=
 =?utf-8?B?VnVCaE9zNWg0VjFoajJLelJxeXlMS1lzWGpkWWRUVHlqN3g3OStZQ2hyYU5F?=
 =?utf-8?B?S1pqV25rdFgzY3d6ZnBDOTlQU0o2VWxQQndXcXkyTlVkS1lCK3RuWEx1VC9o?=
 =?utf-8?B?WEE1Mm93M0djcHRaWTV5dVRkNURCMEltVTg5YXB3aWNuVG1GTVJqWnhHQ1dX?=
 =?utf-8?B?ejdTSzBpdFVtQ3dwckhTazE3VDZsUWgxbCtkTXFOREVydSs5UkNpcVV2QXBr?=
 =?utf-8?B?UUFBbDFJejFxWkRZSWV3TnRZVTFTajNxcTF4RTJDaVRnSWJvYmd4eGt3aHk1?=
 =?utf-8?B?ZS9HNUdlVEpTaXEwcDU4S2VzV1JmQkZYM1pobjZoQngrZU5kbEp4cTRXUGdi?=
 =?utf-8?B?UnBmSnFjZmM4R0pFWE9TTlpIQnM4MG9aU09YdEdieTdQQnR2K1NvZVdRQmxI?=
 =?utf-8?B?d0E1OEZLd1VSeWxtTnBuZndUVVIzdXpNZVNMZWVwaWFyMTNuMjVpWkV5cXdF?=
 =?utf-8?B?N2tCVFVtYU1HMDdxR3NnNytaalhHbG1RZWRtUnRmc2xCZFVlODdsQzJublJt?=
 =?utf-8?B?UWxXWlI5bmp5dm5EQXpmSkM1Y1ZWcjdaWnY1aDlsTHBEVTVRVFdpeCtpQkR3?=
 =?utf-8?B?TkpUeXpjd2pIcHBTendXNFhOWldBNVNJN01iNkFEL1pVUE5yRndsdnh3SFhD?=
 =?utf-8?B?dWQxQ0NqTTFSUHpxNHcydXFxR3RSS1NRYW4rN01YRTIvMmt0ckJ6UmhSMXZj?=
 =?utf-8?B?OWMxSHU2UUM3Z0dybm9vL29jNDEwUGd5LzFMMzh1R3NtUmtVbTF1RTFZejFZ?=
 =?utf-8?B?OVVMVlE0dnI3a1BvNHAyQUdGMkN5QXRZSFQvajcxUnpXelh5Yi9qNUUxd3Mv?=
 =?utf-8?B?UFpaSTNnSXpBUFhOK00vd2ZLaEIvU1pEZlpXTDJGQ1N2TjZOYmVHckJmMEh4?=
 =?utf-8?B?Y3dYRVROdGVSMEhzQ1V1MTRBcklkVXFwL2djendJKzFtTTV0YjQ2YWxqbTli?=
 =?utf-8?B?eGloTkNwejMzL1ZnV0pVdG1qYkdOZVNnanJkWUYyZ0lMSzFFbXkvNHNwM2NZ?=
 =?utf-8?B?OGNKV0dqelh2aUFvajVueTdxM05TNzhCTEFxY0xaTFBTUWtlb0F4ZXJIY21s?=
 =?utf-8?B?ZjF3UTZvVGJ5SmVEcVY4elVuWEp5V1V0SzF1VnZsL1VIbHVIYzBEN2FRVXZ0?=
 =?utf-8?B?NHBEWGJsVVcyb3VHazNobysxWmtJeE1ia1RqaTFjR0I4RHdraDRKczRtSWFH?=
 =?utf-8?Q?Np/X6n6BOwkVhq2U=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a88f56a-d3e1-4654-7ed9-08dee1b7e6b4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 14:55:10.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euk9AoBmcPM77vHUWJ4lePqamNRi+J8gYbATaJgGbtVd54Bbli8tWP60AUeFGu8tCqtCQnFPr5p35izLurxgBzISUbBKgl5eVdYcceOwFkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9135

On 10/07/2026 09:13, Jiri Slaby wrote:
>> +static void airoha_set_termios(struct uart_port *port, struct 
>> ktermios *termios,
>> +                            const struct ktermios *old)
>> +{
>> +     const struct airoha_8250_clk_div_info *clk_div_info;
>> +     struct uart_8250_port *up = up_to_u8250p(port);
>> +     unsigned int xyd_x, nom, denom;
>> +     unsigned int baud;
>> +     int i;
>> +
>> +     serial8250_do_set_termios(port, termios, old);
>> +
>> +     baud = serial8250_get_baud_rate(port, termios, old);
>> +
>> +     /* Set DLAB to access the baud rate divider registers (BRDH, 
>> BRDL) */
>> +     serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
>> +
>> +     /* Set baud rate calculation defaults (BRDIV ([BRDH,BRDL]) to 1) */
>> +     serial_port_out(port, UART_AIROHA_BRDL, UART_BRDL_20M);
>> +     serial_port_out(port, UART_AIROHA_BRDH, UART_BRDH_20M);
>> +
>> +     /*
>> +      * Calculate XYD_x and XINCLKDR register by searching
>> +      * through a table of crystal_clock divisors.
>> +      */
>> +     for (i = 0 ; i < ARRAY_SIZE(airoha_clk_div_info) ; i++) {
>> +             clk_div_info = &airoha_clk_div_info[i];
>> +
>> +             denom = (XINDIV_CLOCK / 40) / clk_div_info->div;
>> +             nom = baud * (XYD_Y / 40);
> 
> Are these "/ 40" to avoid overflow? Add a comment.

Yes, this is to keep it in 32bits.

> 
>> +             xyd_x = ((nom / denom) << 4);
> 
> * don't you want to round to closest instead of down?
> * I don't understand the purpose of the shift though.

IIRC this is the vendor calculation logic scaled to fit 32bits. With 
this rounding/calculation we hit the baud rate exactly for the baud 
rates that people actually use.

> 
>> +             /* For the HSUART xyd_x needs to be scaled by a factor 
>> of 2 */
>> +             if (port->type == UART_PORT_AIROHA_HS)
>> +                     xyd_x = xyd_x >> 1;
> 
> Do not use shifts for div/mul.
> 
>> +             if (xyd_x < XYD_Y)
>> +                     break;
>> +     }
>> +
>> +     serial_port_out(port, UART_AIROHA_XINCLKDR, clk_div_info->mask);
>> +     serial_port_out(port, UART_AIROHA_XYD, (xyd_x << 16) | XYD_Y);
>> +
>> +     /* unset DLAB */
>> +     serial_port_out(port, UART_LCR, up->lcr);
>> +}
> 
> thanks,
> -- 
> js
> suse labs

MvH
Benjamin Larsson
