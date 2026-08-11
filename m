Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020086.outbound.protection.outlook.com [52.101.84.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB48318B9B;
	Tue, 11 Aug 2026 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429907; cv=fail; b=pe0QZPwKaZxcPjLKSJe2zF8TFVG+UZzBz3nVu0WdaQJtuQA9Ie56ELxGMPusFJCeaOXFi6e2Ltj7Mv+ByEvOd7aWvmxKVIQrv25ZKwq1yYfkBkTmc9duHMhRPzJjBlcvQi/9tHu92Q08DkDXba8CrB7aH8aM8v8/ACyZAol9Cwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429907; c=relaxed/simple;
	bh=3nmsvchT5mXH5GNrYTI/wkx0p5mitbt2ZoUD/H1YC7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V16B5d7Lw86ZVwqYxNSbSKBuKlY6z2MWSd6Z4mQ/ZA/N/FpvSkVn7FlYLPOJvihpAnvLKKdJ6Cc2JKkpSZY9bq5l4exTjrDT+V/2wcqCVpJIeGWl6ePryPbIH4dteSOsbuT3vtaqM7K081a1VFvRNH4DJiNuntQg4jwoWvC/2EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Wa0xHAUW; arc=fail smtp.client-ip=52.101.84.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Wa0xHAUW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q03xtlCq7KsEFzQJoEyQbGjLR+rksr77ad359u5ClcErcmxtDbxJJ1Lr8lG1kWwJDgC4Y0yNj4GoHFz2wg3S74CP4bMKWKo1heWP1nvruOv4/3/eI+v6hv3vt8f9Oiw60vTvAifJEDK9VdhVvpbzbbdC/56YpwI57sWy5JO2fH5xnmI59DoqPWz+gHHx55OrPrbvwnlyWy/B4+XZuVYhJ1Rbi5h62EV4srR4c4G7wQuExEGeKOps3GLA3qn4QDQxyql2MyP1fqNYcFMVkvJO2Jc25Kw7xqUgYrf25ldQj/XTFNqwax8CIEOXKCly7Ug5qiMVg/8DDH7mkRJVleiHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryRCZCOSO01f4sYPMZGaMq/PNc7xV9LCjLvwF4uQ4f4=;
 b=Gmgqo9eBDIxNQlmALXPZpi+aPL+MLGDUhqhW2Ey1vn6EDK4lvWDFAQ0U9lT7nf+Om8v7YWa68cykUgCyK7mJHOYeAjly5YHUd89Lf44wb3m7l5iIWjg71egAGhxowE1ny+ERs0eo5fatadfzOGjVB4LYwt1e/S+tLzmVA5L1+Yk3tJ+r/l0rRkGan164xXdN71yO/sg3ASQkcPZJlS0ugaALx8zAHhz48/TgHacAMwIzaS2W0IPP1RN7Q1NVIWp3p3Zl6mLuQ/PM+MXuQt8GfatkWeftjh4aMUOLRFSNN/VK1bsjH8Sl2IIeH8w/aG4jBeHMbJrXcVttuDdo62OdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryRCZCOSO01f4sYPMZGaMq/PNc7xV9LCjLvwF4uQ4f4=;
 b=Wa0xHAUWzUdHdSLO58/eUru91Q6+ibIB6E196Fqi8Scgl4zMQ+lhGDqzdvlxVJAO86uakMuLJ95kB2s7OCfVbyPH64qoGFt7JbNo3JldzugU3ajOjgsnDSWuzASEREfs21wMPepXJbG6Jps7GkcfF4eNvHvdjJWqaqONjDI2g6M7ULpl2Mn/lSuAKWrcGeFGx37xtjCMXIprrDjbhsnOiJJ9wyHLa7PcF351pSFcEMQfO9Wg3rQv0KtGwdq4qKidcfgEmPj6WKkhjWf7+unH+ZfnpoNDRK0eUw8KYIhtYVEcxfpl5TMEWft7EBZ2Wr4M7s8a85W50OevUFNGLH6law==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by AS8PR06MB7862.eurprd06.prod.outlook.com (2603:10a6:20b:3c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:31:41 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:31:40 +0000
Message-ID: <6b571102-2058-4d71-b847-0a9197b303ee@vaisala.com>
Date: Tue, 11 Aug 2026 09:31:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: max310x: drive RTS in software when hardware
 delays are too short
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20260709-max310x-rs485-sw-delay-v1-1-454ac10b937a@vaisala.com>
 <158e6123-46fe-4a8c-9de4-093009a22a02@kernel.org>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <158e6123-46fe-4a8c-9de4-093009a22a02@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF0001DBBB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6fb) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|AS8PR06MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc88953-f4c0-4552-13e3-08def77233b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|4143699003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XnIeUATffkztTnFOrL66vTqtUG4Yi65o/Q1zI/x03ZoV3fCAD5KmA/8dle+gcHFwU3TaxLipavVy7R3QizlRQRYzwtQLUOsmMpgSSkdvarCKItyUZlKXk6vCFVkS0Ns85jJB1fytM8zAMdcztGgBlOqw8Z3trntPn9YkXvWruKFWhhHfqrTjguONnHx7oG87Kp+HURRh2Q/Z3hCXfhhkkx8pq008booKJnvaE4CbQdOXSnk36a3+aU/hRWVvkkdjrdSGnJXaFRpx5NBstEeJq2ifbgXX3Zn+HVZ7J33kf137TtB5vIK7ggrvKzrWAgF2rGBtdN0+nJnbd9QPbn8iOZPfbZ19pw7cVAAvy6O4ZXHAztr4tcIIZ7HizhNOwdqcGgzyDEPs4fPBkCC7aOvbUWFSOZ9IrzAbaI+syz1PAKGcfQPxKpNNRSzME0ODEC6k7JudmgC4/8yqStKFT06ZhhHyB4DIFYEYmVgId1zHJ53rAaMq/q9MrSYw8lw95gFkcRyHdxlLJsDOPEM4yRk0J3mTe9qE2voVqO4LcORZLQBvxTxENI5+92zg4NVq85RVBqLm5+MeieRpD15EEsUdLpYpIWqtP59PsaYTX849lSzOKspohvASTNkAJKRICGKOP2C019j1sbgXhBm48ninnrGrVm7J6y/pfDHTgvx4a1U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkpvWnlmeDU3YUNTYzJLajBMRDBwSmU0dlRWajdRWjM1UC9TYlRCeHFrQ3Fq?=
 =?utf-8?B?TGRObnhvMTdSRmR6c2hRcnJIQVZFQWlBSG5lT2xUN0R6ZGZyOW5idXh2cjJU?=
 =?utf-8?B?LzlibGZqYWMyWXV6RnU2TW4waU13c1hrZ0M0S0lPczJ5c3R3bHdtZWZodWZq?=
 =?utf-8?B?cWFUcnZ6bDB6T3ZvZ3YvQmF5dWtiWFFTWWYrekxNSzNqZ2I1RjlFYWFDM0lY?=
 =?utf-8?B?eUhVcG8yMXp4RDBhMm5SdmRJOUJHODV3L1NVQVVBSnFRRXFyOWREeGtKY0Fs?=
 =?utf-8?B?NncwMXc3Lzg3NWlaNGhMRkpqd1lnZmtFWVpzbWM3Q2JCTkgrNlZOcGFkRzB3?=
 =?utf-8?B?ZDVTWnI3N1M5Mk54dGJlVXFkcUVMQzc1TDZjYjdIaEx0V3JreTR5SndNczBJ?=
 =?utf-8?B?WWNMVWlWQTJ6WXFRdjIzR0hBYVorYk11bmhFalF6VjcxU0hOZGo5YXYzTVpm?=
 =?utf-8?B?dm96OGo4bVh1OTJhMWtvMElWWGZiY0d1RytWekdOUW9KQjdrMEkvQXlwVUVy?=
 =?utf-8?B?anZpZUlINjdnSW5TN3N1bGMwTysvOWozK09RN3RiV1hScVJMZlNpSml2UlhC?=
 =?utf-8?B?akQzemFMcW1QZ1YzdVJmZy9kS2ZlZjMxQkZBNTVVbnZNejMramI4cnpTQ3hh?=
 =?utf-8?B?Y2NVRWxsMlJOY3duRXZzY1BMRkg4MVV3bHQ1clBDbGZuS002ZmM3YlVzVXo1?=
 =?utf-8?B?REFJVDBXS3dtSkFVZmhLTjVXRjViRlB6ZHlGcG9yYVFnUlUxdDIvU2txL2Rx?=
 =?utf-8?B?WENmRlR2NHdCMlB1blFnYXNjQTkrNUpmVFJkSjBmaTNNYmtCb1B6aGQ0Z0sx?=
 =?utf-8?B?M01jMzMyM1lNR0xxaFczeVFWd3QyRkVrSG9OdE1KM0wybFMvM3dBU0xBbHR2?=
 =?utf-8?B?bUdyMFhaeTBOM3ZvSFQ3YzJpUkJUUG41VHpkTFB5YUdIak9UbFAxNkFRMlln?=
 =?utf-8?B?TkVTUE4reTdqcnp5U0JLcmdVd2kydzFjU1BYWEJZS2pLVG40VUo2RDFJN2FO?=
 =?utf-8?B?Z3ErT0lXcjJYS0E2NXh5anNVTmhzNDNLNmY3QXdjNk5vS3dqM2RHU3VTOXcv?=
 =?utf-8?B?M0Y4Kzdldms4ZWhJTkZ4U1FEOXhuendLaWtycGYyaktKMzRkOWtCOHRuZ0x4?=
 =?utf-8?B?WWpxQVZ5MVp3Q0JQc0JNN3ByRXVFZ09TRHVoUnY5cUFuM0p1c2dnaHBxTDdq?=
 =?utf-8?B?aEFGNzZrZUNQblFscGVNYnJMUFM1OHNlWFEwNVF3QzlGTGhpemFtRzhIWVJJ?=
 =?utf-8?B?U3h6RlMwTnR2aDRRQ0crcDQ2Rnl2QWQxcXVnTkZWNlZSckdhdGt0bEFkZWdQ?=
 =?utf-8?B?dWpFQWNCdldpRDdHNVN5dzFVZVlkbnp1em5KejRmaG5VbUhHakREZUkxanRq?=
 =?utf-8?B?MUpTV04xTTJLa0NGMVg4a21XRitUUlhINDhmMDhpWnRBam8xcS9PUW8xUkRF?=
 =?utf-8?B?dUNzTXFoVE80cThXRUZXVVowQ1FEeXA4eGNVQmFCSXRmZjdEWWJaNDFxcmFH?=
 =?utf-8?B?aVRYaEE3NlovcEtydzYydmhhTVJjSElGdU0vbS94ZGRGc1NIb3Z4dVlISk9R?=
 =?utf-8?B?WmhNV3ZBMUMzalFWeGZSRWV3MVF3S1kzUHJTVmdsQ1FUVUpqWDA0OS9DQURV?=
 =?utf-8?B?MnVGZ2lWS2RhaDJvSWdWQVlOTDJHQnZGK2Joc1Nqd0dEa2FsMkRjVU9ETEtF?=
 =?utf-8?B?a2lRV2JCMjRibXdZNXFKL0hMelV5VldOMkdPTUk3NHFyMVRkdjBWbmNUMTgr?=
 =?utf-8?B?S2NSRVdPNCtyeWgwMWhKbTN3K0ZENmIySkV6a3p6UVJkUitlS3BWU3ZwZHhS?=
 =?utf-8?B?SDhDRm1nNExxVFlibkI4cmpVREdUVTRyb1BjaWU0YkRpeDRtYTJ4czFRZFNj?=
 =?utf-8?B?N0p0M21TWU9odXZlQnRPZ3lQUmdtRGpWVlQ2bWdMemNwR1NvOE5xZkN5alZC?=
 =?utf-8?B?cytCUjFSUjJ0Q1UvTUo5aHI3bXBuRWF3cGkrS09Hc2pucUhqUWFzeEVBRngy?=
 =?utf-8?B?akNELzlIZ1JTZUlaUngzSzZyQmlKN2trUndxdE1nUm1qWTRucEFrMDlxZXVE?=
 =?utf-8?B?WkMyd2svZFVIb2xQOWpWK3J1MWptMUNLNWdFVkU4YjIrVSs4K1dpdDJHRXpX?=
 =?utf-8?B?OVhCYlkyUHdOemFSdGdxWm51c0M3S2VNQjN3QldTczY2L0ExTmNpdm9sQ0dm?=
 =?utf-8?B?eWVSbVcvUENUQjl6OUhsM2lNZnVQRkZCMXJNdjRtUzErKzRhbjAwSjFKdXhY?=
 =?utf-8?B?aFRpTnA5UmJYaG0yRnh6K3FJZUVLVVBMMzZ6am9HY3pmU2tYUnlYMkhGQ2Jz?=
 =?utf-8?B?bGxNRWZmdlZla1ZMMzM0cVBKVkFrbXZCNnVocU4xS1Z5MnF6ZTl5SGxZL1M5?=
 =?utf-8?Q?vkBa93PibMQven7Y=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc88953-f4c0-4552-13e3-08def77233b1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 06:31:39.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abkWemviQJcHLzQYu2urDAzJsP5B/E6uSCFMhzj6GcxPXHqSjzUKRWclUWcnNXGf5t4a195p161EZcxdDo5T7IzETNLL/NPrYjkCJhdPIL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7862

Hi,

On 7/9/26 13:41, Jiri Slaby wrote:
> On 09. 07. 26, 10:46, Tapio Reijonen wrote:
>> max310x_rs485_config() rejected delay_rts_before_send and
>> delay_rts_after_send values larger than 0x0f with -ERANGE, which made
>> the UART core wipe port->rs485 in uart_rs485_config() and silently
>> disable RS485. The HDPIXDELAY register holds the setup and hold
>> delays in 4-bit-per-direction bit-times, so even values inside that
>> range only encode a fraction of a millisecond at typical baud rates
>> and the chip's hardware auto-RTS path cannot cover the millisecond
>> range the kernel UART layer expresses.
> ...
>> --- a/drivers/tty/serial/max310x.c
>> +++ b/drivers/tty/serial/max310x.c
> ...
>> @@ -324,6 +345,21 @@ static struct uart_driver max310x_uart = {
>>   static DECLARE_BITMAP(max310x_lines, MAX310X_UART_NRMAX);
>> +static ktime_t max310x_get_character_duration(const struct ktermios 
>> *termios,
>> +                          unsigned int baud)
>> +{
>> +    const unsigned int startstop = 2;
>> +    const unsigned int char_bits = startstop +
>> +        (((termios->c_cflag & CSIZE) == CS5) ? 5 : 0) +
>> +        (((termios->c_cflag & CSIZE) == CS6) ? 6 : 0) +
>> +        (((termios->c_cflag & CSIZE) == CS7) ? 7 : 0) +
>> +        (((termios->c_cflag & CSIZE) == CS8) ? 8 : 0) +
>> +        ((termios->c_cflag & PARENB) ? 1 : 0) +
>> +        ((termios->c_cflag & CSTOPB) ? 1 : 0);
> 
> Is this an open-coded tty_get_frame_size()?
> 
It is, yes. Fixed in v2: the helper is gone entirely and
max310x_set_termios() calls tty_get_frame_size() directly. It also fixes
an omission on my side, since tty_get_frame_size() accounts for ADDRB and
my open-coded version did not.
>> +
>> +    return us_to_ktime(DIV_ROUND_UP(USEC_PER_SEC * char_bits, baud));
>> +}
>> +
>>   static u8 max310x_port_read(struct uart_port *port, u8 reg)
>>   {
>>       struct max310x_one *one = to_max310x_port(port);
>> @@ -680,6 +716,39 @@ static void max310x_batch_read(struct uart_port 
>> *port, u8 *rxbuf, unsigned int l
>>       regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
>>   }
>> +static void max310x_rts_ctl(struct uart_port *port, bool rts_state)
>> +{
>> +    max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_RTS_BIT,
>> +                rts_state ? MAX310X_LCR_RTS_BIT : 0);
>> +}
>> +
>> +/*
>> + * Drive the RS485 RTS line to match the current tx_state. This is 
>> the only
>> + * place that touches RTS, and it reads tx_state rather than a fixed
>> + * assert/deassert intent, so a newer assert is never clobbered by a 
>> stale
>> + * release. It also arms the before-send timer once the RTS edge is 
>> on the wire,
>> + * so data is never shifted before RTS is asserted.
>> + */
>> +static void max310x_rts_work_proc(struct work_struct *ws)
>> +{
>> +    struct max310x_one *one = container_of(ws, struct max310x_one, 
>> rts_work);
>> +    struct uart_port *port = &one->port;
>> +    unsigned long flags;
>> +    bool rts_on = READ_ONCE(one->tx_state) != MAX310X_TX_OFF;
>> +
>> +    max310x_rts_ctl(port, rts_on ?
>> +            (port->rs485.flags & SER_RS485_RTS_ON_SEND) :
>> +            (port->rs485.flags & SER_RS485_RTS_AFTER_SEND));
>> +
>> +    spin_lock_irqsave(&port->lock, flags);
> 
> We use guard()s these days.
Converted in v2. Besides the two sites you quoted I also converted
max310x_delayed_stop_tx(), which has the same pattern further down.
> 
>> +    if (READ_ONCE(one->tx_state) == MAX310X_TX_WAIT_BEFORE_SEND &&
>> +        !one->cancel_tx_delay_tmr && !hrtimer_active(&one- 
>> >tx_delay_tmr))
>> +        hrtimer_start(&one->tx_delay_tmr,
>> +                  ms_to_ktime(port->rs485.delay_rts_before_send),
>> +                  HRTIMER_MODE_REL);
>> +    spin_unlock_irqrestore(&port->lock, flags);
>> +}
>> +
>>   static void max310x_handle_rx(struct uart_port *port, unsigned int 
>> rxlen)
>>   {
>>       struct max310x_one *one = to_max310x_port(port);
>> @@ -776,6 +845,75 @@ static void max310x_handle_rx(struct uart_port 
>> *port, unsigned int rxlen)
>>       tty_flip_buffer_push(&port->state->port);
>>   }
>> +static enum hrtimer_restart max310x_tmr_tx(struct hrtimer *timer)
>> +{
>> +    struct max310x_one *one = container_of(timer, struct max310x_one,
>> +                           tx_delay_tmr);
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&one->port.lock, flags);
> 
> guard() on more places.
> 
>> +    if (!one->cancel_tx_delay_tmr) {
>> +        if (READ_ONCE(one->tx_state) == MAX310X_TX_WAIT_AFTER_SEND) {
>> +            /* After-send hold elapsed: drop RTS via the rts worker. */
>> +            WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
>> +            schedule_work(&one->rts_work);
>> +        } else {
>> +            WRITE_ONCE(one->tx_state, MAX310X_TX_SEND);
>> +            schedule_work(&one->tx_work);
>> +        }
>> +    }
>> +    spin_unlock_irqrestore(&one->port.lock, flags);
>> +
>> +    return HRTIMER_NORESTART;
>> +}
> 
> thanks,
I did leave the two bare spin_lock()/spin_unlock() pairs in
max310x_start_tx() and max310x_rs485_config() alone. Both functions are
called with port->lock already held by the caller and only drop it
temporarily around hrtimer_cancel(), which guard() cannot express. Happy
to restructure those if you would rather see them changed.

Thanks for the review.

--
Tapio

