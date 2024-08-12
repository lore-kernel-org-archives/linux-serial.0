Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F44317C
	for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481821; cv=none; b=QuL2OSe9QIIgiDrYz1i8Fqyt9igs5gYVO4UH+uc0rHS8kSRTRDbuEhtE0l71GaKcFuA2APpYIC2nr/d8M0OYRLlCN1Q6sOByG7rrw/kt0prMPxrhCahBS/O4lJQWGe4cCBrRCZo3+ZkVn92fPxtyrkhxoae+JKivwIoIoUX1cpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481821; c=relaxed/simple;
	bh=D9EfQgOOVPTE+lZtsc0tErt15c8/InthfjTwMmKTSMU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BEen3cf7zvBvoKEyxvs/tjf5qlzzpNZ/jLYBp07jVZQ5KqFvKwu1eJun+58vjEN/ss0wXCfFWLLiMifISGeHDNIOa4Ftrk2c0NUFqCq66QErAdGNsOFC1mhogHkVaog2yoA4ATMGngSPnBlLNXXzX1ZsKtQzrPJ/AQNXuEX9is4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=ilewV5va; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="ilewV5va"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1723481817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiQEcsJc0rPQX6UZI77aPHaG50vXe0dvNEzRF8owf+c=;
	b=ilewV5vaZzbKWxItMXovMRSuUoby+AuvfHmCnvVUIGcGr3yUk3AfNzQwyIkbiPWJPHlZeb
	jPdrvvr9D5JnpX61UEA950AJE+SRGwh8WFg6dktnM8IcAuc9vwAcO+yA4RYcr90pW2DO2/
	0+yZHVkC4bpB8jCPmOzjAul4Nfl8TXU=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2041.outbound.protection.outlook.com [104.47.85.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-304-sNOlvkakOYm_ybSZ5HW_YA-1; Mon, 12 Aug 2024 17:56:56 +0100
X-MC-Unique: sNOlvkakOYm_ybSZ5HW_YA-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWXP123MB6004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 16:56:55 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%6]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 16:56:55 +0000
Message-ID: <8cfa1c75-03f8-4071-b277-752006b576ac@camlingroup.com>
Date: Mon, 12 Aug 2024 18:56:53 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/3] serial: sc16is7xx: convert bitmask definitions to use
 BIT macro
From: Lech Perczak <lech.perczak@camlingroup.com>
To: linux-serial@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 Pawel Lenkow <p.lenkow@camlintechnologies.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
References: <16b7bff3-71ec-4042-a9a8-755f32b85716@camlingroup.com>
In-Reply-To: <16b7bff3-71ec-4042-a9a8-755f32b85716@camlingroup.com>
X-ClientProxiedBy: WA0P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::12) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWXP123MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 055de36c-57b9-4795-ab72-08dcbaefc552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGdRTUFvOXlMeWhoSlRUVWtPekU5aERBK2QxTHFGRDlxTGFGLysrK0IxanFq?=
 =?utf-8?B?MnBZSk51SXpYaGZNWnJXWkRtUFJlUWlTdXBOdE0xM3hNaXJVM0p6V2RsWUlK?=
 =?utf-8?B?dDdZRVd5R00xMk1YNitBanJ1SDlYMGI3Umw3bC9yZnZnZUxkaFNEODRldW9p?=
 =?utf-8?B?N0ZNeDV0ZUNIdTBwZm9YOVdVTzZEV3QybXlDQ1F1VFlYa0ZJSE05dG9ESGVM?=
 =?utf-8?B?UzluenNLUnA4eE1JUG8zUTlzWkhha2hTeVNzYWI5SDgyWUwyWE92YVpoeXFB?=
 =?utf-8?B?L29Ga1JkZW9DSWpmY1U4dVBGak1NOXNaQXRGSnhLY095ZHdHakF3MDgzaXYx?=
 =?utf-8?B?SWZPRGZveUpwVUF5QlRId0l1NThrZ2hIUXpqVU00WkEyMk5BQXE0TlhGR3pI?=
 =?utf-8?B?ZWdGbE4zc3RaMG5QdnFRcXpscFdJNld5b3pSV3FvRHA5b2lLa0hhbGVYMjN3?=
 =?utf-8?B?MTRMMVJjWXNGMDl4bHRDY2lFRXEzazRkS05yWHdiamp2Tk5zVERwZzJNUkhs?=
 =?utf-8?B?UzBDbXVqUmFUSnpLWDFIWTJjT1lCVGFUb3o1MkU4emNqdDcvdVQ2d2xBN0FO?=
 =?utf-8?B?bDNQakd3ekkxZ0t4Z2dRWkEzSHN4R1NQVWV3TldYN1hOYzlzZG01amhMSm9x?=
 =?utf-8?B?QWxKVDZ6TS9ISDdBYUJyUDlZRm5yb2lNZTRBeGJOd3NjNnIydkppTWs4TUc2?=
 =?utf-8?B?VklUZEJxbTZSTTN3NEZrZ3ZqMTZVUGxadld3amZLR0ppWnYyUUlUWUJYSFhm?=
 =?utf-8?B?NFJTWlorZEU3eEUvY0FUZnZzSVRCMEx4bkNaa3Jrd3ZjTFFFQVBKNnRrSVN3?=
 =?utf-8?B?bEl1YzV4cW5vMGZZYzg5ZnQzM0pXbGI2aTV0OHNEek96eU10TVF4WjNtN0oz?=
 =?utf-8?B?WHZMRUd0YW1lUXZZRTlBNTVKNXZQSk45cmpLczBIYVB1TzFHNUQzQjhNMDlP?=
 =?utf-8?B?STFhVTM0UFRVWDNvL013UDZzZndwT2Q2d21jZktnZHdJQ0IxMmVsQkwwaFYz?=
 =?utf-8?B?NkxnZDc4SjRra0pPRExKM2UzeGE5dTB2dmlCS2J3RytIUVhOMXQ0QVlCUkty?=
 =?utf-8?B?dlBlcUxhRWxKUVl3WlBTNWtJSTlDSTFWejFRNzVaYWowaFN5SGh5bXFyKzJq?=
 =?utf-8?B?c00vUk9wWjZsWEZhd3dQaFovZUVJc2Q2MEpZNU5BOG9qeC9YOU9xc2c0eUFn?=
 =?utf-8?B?RVkwdVlyR1VDajJtaldTVW1UcFhGL252dS9Tb1E5YzhnQ0hMV2k3WFZRa0o4?=
 =?utf-8?B?SzJHcDgrYzFiZDZTazMrdGdqb2N6V1ZZWW1aQVFNUkJoeUxqaWdlUFR3YWh5?=
 =?utf-8?B?MUdSenZtdG9WVkN1T3JGdFJzVUhqSXltckxZeFpRZnR2bml6ak4xNkFsbjF2?=
 =?utf-8?B?c2NVTXhEUlJUWktlQTJ4TVRUbnFRTFlValNTYy9NbWx2VElOdkEwTVo4d29R?=
 =?utf-8?B?am9oMEVqZURoTHJJcTBtVUlUdWtmMC9yR0dFNkN4eFgwYS8zUHlXMEhYWm9l?=
 =?utf-8?B?ZVY5K09VQmhxYXE2YUVJeC9xTWQ1dEhWQlZZTGE4OS9mKzZLNW5lbFZvN3pT?=
 =?utf-8?B?cEFycVBYN1loeUZzTG85cktxS1Z2TExGUDRzTVl6dm5rNGxlVUh4NmcvRmlS?=
 =?utf-8?B?VmJNV0g1Sm1zVi9VeFc0bEEvR0hXVmZrb29rZWtZeDdoTUp3WU0rNXQvNGJD?=
 =?utf-8?B?WSsyYTFwYlNFUlJkTmsxZGV0TzJ4bFltUXhnUFVhdkE3RVoyM1pKZ3pTcmpX?=
 =?utf-8?B?ZkFQMk5CZnpZQ2V5dXFWdE4zVlJiVnp1NlhrVmhoU29aZUpDTFV6ZFlDZTF4?=
 =?utf-8?B?QzFibk45dURCUzQrWVRxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzdvWmxYWDJhZ0xpQ2dNbVhtY1MzTFptcHF1NTBBWjRaM3dZNHFjdjlsMzVC?=
 =?utf-8?B?Q1pOc1dmbFdjUVN1MHV6SndsWmpTaTVuZU1RbnczSHQ5dGtNRDF3d0NLVkl5?=
 =?utf-8?B?QktiQzgrMUhuNzJnS3dXZ3JNQVVoZjJhbzlIR2RzYWlnU2E2MGxBTDJEZXZH?=
 =?utf-8?B?clk0ZkI0WisxV2VJVGdsOWVpS3pkZmFoQnlsR1VuOXNNYjJ1MHlEN09TL1JQ?=
 =?utf-8?B?QUpsc25aVndzR2JZMHZQVXNVdE5UZHZsbDc1cnFITEJkYlpuQmFjb3RWSnBp?=
 =?utf-8?B?Z1I3ZHBwWWVUekNFcytNYzM5eW9TTDlkcnNNWk1iRTdPeS92R0NQQnFqRHdw?=
 =?utf-8?B?MjkxekIveHlOS1JyQkV2OG1jUDR2MU9NQWdwczVvUmN5TVJBT0JqUXRSM1Jv?=
 =?utf-8?B?RFVBbk9XTElycUhqa08veU92Q1lyVlQ4aU80MTEyMFUwdUlaRlVlSlZDOXUv?=
 =?utf-8?B?eU1XblZjWUpZOFRHbFEvL0daYXVHdWg2a0hqZzJmMGtQMmFDU0VWRnp1UXNQ?=
 =?utf-8?B?R0hpRXFhRHA5NzVnM1Q2Ly96cVMwdjBBbnhsMndYOVhZRFNIbW5OaXpYMjJ0?=
 =?utf-8?B?eXNEN1BuRVB2a3NhYW9TMi9KUmNhRGsyaUVUUThqVnNzKzd4NjNzSVkyRnUx?=
 =?utf-8?B?S1kwOGgrMGd2Z1dnMDdFR0drYjhNc2NMMjRPOU0yeC9RR0hDM29qdFRLakRn?=
 =?utf-8?B?MEEzamsrRjhlVXR1WnBNU3FOTnRZUEpURnlwT210b0xSdTM0dDRpeWgzZFlQ?=
 =?utf-8?B?WEszRUJRSjRmeFVYb0lhbWpSc3lsTXNaWlZleTJQS0tKQVlKZ0Jlem9sZmpW?=
 =?utf-8?B?Wkc1VDdhbTJreG45Y01aYURjZkRjZWt6N3YwR3RybW5rOUhLVVJKM2JKZ0tF?=
 =?utf-8?B?L1FyYmUya2V1WTNQdmc1MytlMDQ2anBJdDJ5UmdwVjVqNE1FSXUxREc1dytO?=
 =?utf-8?B?TjMrblpEUjlGZEFhcXozRk94M2dvSlVJMlZXM0x6bXJLSXExd3BLNXYwakNH?=
 =?utf-8?B?enFFays1cDFRTVNoQnpXTTlPVFJ0YzJmc2hqVEg5Q3lnUGhDdUFvL0h6SURE?=
 =?utf-8?B?cmM4UmRQOWo2TGQrRXdjNm9UYXFFN2xKcVAxWUxhdFV4NEFNQTBIaFBzRXhS?=
 =?utf-8?B?cW5pQ05UaDk1MTRTekg1NTZoT01PaFBqcForT3N6REFEalkwNnd1S1RTUE5P?=
 =?utf-8?B?M1ZPSW5FVTZ2UEpjMHJHNXJLUmh0NmpTQ3MvMW9DNGk5UUtQdklNWXV2WlNp?=
 =?utf-8?B?ekNZaDkvb2VsUG1jS3lsN2tYMDNFVlJTODdLSCtmQUpIN0V5bDI0bjJFQzhr?=
 =?utf-8?B?Z3VVaXR1b2IzTVZwM1FnazJaYWJVTzJmK0xMVkI1dVNxdE5GKzhkcitZL09M?=
 =?utf-8?B?eVJnc2RaZG5qQzFYK2RvdjNxUFRqOG5NZjBsMG5ZeHJ6ZUZlL3V6VkJSZ3Zk?=
 =?utf-8?B?YndqWFVvYVl5NE1WeWphbTIzUlh0cGNjUUZrT1BSdk93UnZVZU5GcmFGdnhE?=
 =?utf-8?B?VFBtcGRETFdrQUtvMzN4NWhWRCtqejhhUE52enZoMTdMVjhJcTFVVldpSUZE?=
 =?utf-8?B?NTJyNmMyeFJEdTlWVlBEQXZOZ3BxdUw5WmFoWm9Vcmg5cTRRa3VydXlDS1pS?=
 =?utf-8?B?WXc5UVRhN092TEZ2SHlkUmJGR21mYkV3U3g0SU1RUS9uaC9jQTdDbG10WEVr?=
 =?utf-8?B?UXFsNjhna1VKbkRwWlpIZ1RlWi8wdkI5anJONXhRMTdYQXhaZjVoaU1mNWJX?=
 =?utf-8?B?NGpVa09aSGFJandSeXZuVU5YWUl0L28xOGxXL25xd2tIeUU0U3VpSVNzWlJD?=
 =?utf-8?B?UnVrT0VWOHdORWxSVmFuYVVYQVlEQTRvaWxWT2NxK1VtU216RUFhZTE2Mndm?=
 =?utf-8?B?UG9iTkpXZ3dvUlNWVi91dWtMT3ZheFY1Q0VOcXVKUkFwWnVZZDl4RGhFcndu?=
 =?utf-8?B?VllVOUhJNjgzQ2ZnUTF5VUVDNkt0RFAycFQrYUxub3AwOVNwWEhKMGNHQ255?=
 =?utf-8?B?QXVqRi93SXBJN1lZQldGam1XblNxSTdnVUlyNHB1em0rNndpQ2RZREZES2R2?=
 =?utf-8?B?ZVhFUVpHNGk5WDdkRWJFZ0hpaVZYMGJaRUsxamVsMXoxdTN2SGtqSFVUVVZC?=
 =?utf-8?B?MEVrVnE0dDZrUG11dVZTMDJZR1k2YzU4ckt1UnFTa25DV0VSV1BPTWNOSnB1?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055de36c-57b9-4795-ab72-08dcbaefc552
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 16:56:55.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AswL2mQ1mmIleXd2OPbcCOrpJSM2DXcBmK+K/oOBFep62b9C9VolAN31DqjC9km1PFJi3KVreqDU54psj75LKr35Qlfa+wHFhU/lthgLNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB6004
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Now that bit definition comments were cleaned up, convert bitmask
definitions to use BIT macro for clarity.

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 137 +++++++++++++++++----------------
 1 file changed, 69 insertions(+), 68 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 36b7c682ae94..a3c2ae112090 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -10,6 +10,7 @@
 #undef DEFAULT_SYMBOL_NAMESPACE
 #define DEFAULT_SYMBOL_NAMESPACE SERIAL_NXP_SC16IS7XX
=20
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -77,33 +78,33 @@
 #define SC16IS7XX_XOFF2_REG=09=09(0x07) /* Xoff2 word */
=20
 /* IER register bits */
-#define SC16IS7XX_IER_RDI_BIT=09=09(1 << 0) /* Enable RX data interrupt */
-#define SC16IS7XX_IER_THRI_BIT=09=09(1 << 1) /* Enable TX holding register
+#define SC16IS7XX_IER_RDI_BIT=09=09BIT(0)   /* Enable RX data interrupt */
+#define SC16IS7XX_IER_THRI_BIT=09=09BIT(1)   /* Enable TX holding register
 =09=09=09=09=09=09  * interrupt */
-#define SC16IS7XX_IER_RLSI_BIT=09=09(1 << 2) /* Enable RX line status
+#define SC16IS7XX_IER_RLSI_BIT=09=09BIT(2)   /* Enable RX line status
 =09=09=09=09=09=09  * interrupt */
-#define SC16IS7XX_IER_MSI_BIT=09=09(1 << 3) /* Enable Modem status
+#define SC16IS7XX_IER_MSI_BIT=09=09BIT(3)   /* Enable Modem status
 =09=09=09=09=09=09  * interrupt */
=20
 /* IER register bits - write only if (EFR[4] =3D=3D 1) */
-#define SC16IS7XX_IER_SLEEP_BIT=09=09(1 << 4) /* Enable Sleep mode */
-#define SC16IS7XX_IER_XOFFI_BIT=09=09(1 << 5) /* Enable Xoff interrupt */
-#define SC16IS7XX_IER_RTSI_BIT=09=09(1 << 6) /* Enable nRTS interrupt */
-#define SC16IS7XX_IER_CTSI_BIT=09=09(1 << 7) /* Enable nCTS interrupt */
+#define SC16IS7XX_IER_SLEEP_BIT=09=09BIT(4)   /* Enable Sleep mode */
+#define SC16IS7XX_IER_XOFFI_BIT=09=09BIT(5)   /* Enable Xoff interrupt */
+#define SC16IS7XX_IER_RTSI_BIT=09=09BIT(6)   /* Enable nRTS interrupt */
+#define SC16IS7XX_IER_CTSI_BIT=09=09BIT(7)   /* Enable nCTS interrupt */
=20
 /* FCR register bits */
-#define SC16IS7XX_FCR_FIFO_BIT=09=09(1 << 0) /* Enable FIFO */
-#define SC16IS7XX_FCR_RXRESET_BIT=09(1 << 1) /* Reset RX FIFO */
-#define SC16IS7XX_FCR_TXRESET_BIT=09(1 << 2) /* Reset TX FIFO */
-#define SC16IS7XX_FCR_RXLVLL_BIT=09(1 << 6) /* RX Trigger level LSB */
-#define SC16IS7XX_FCR_RXLVLH_BIT=09(1 << 7) /* RX Trigger level MSB */
+#define SC16IS7XX_FCR_FIFO_BIT=09=09BIT(0)   /* Enable FIFO */
+#define SC16IS7XX_FCR_RXRESET_BIT=09BIT(1)   /* Reset RX FIFO */
+#define SC16IS7XX_FCR_TXRESET_BIT=09BIT(2)   /* Reset TX FIFO */
+#define SC16IS7XX_FCR_RXLVLL_BIT=09BIT(6)   /* RX Trigger level LSB */
+#define SC16IS7XX_FCR_RXLVLH_BIT=09BIT(7)   /* RX Trigger level MSB */
=20
 /* FCR register bits - write only if (EFR[4] =3D=3D 1) */
-#define SC16IS7XX_FCR_TXLVLL_BIT=09(1 << 4) /* TX Trigger level LSB */
-#define SC16IS7XX_FCR_TXLVLH_BIT=09(1 << 5) /* TX Trigger level MSB */
+#define SC16IS7XX_FCR_TXLVLL_BIT=09BIT(4)   /* TX Trigger level LSB */
+#define SC16IS7XX_FCR_TXLVLH_BIT=09BIT(5)   /* TX Trigger level MSB */
=20
 /* IIR register bits */
-#define SC16IS7XX_IIR_NO_INT_BIT=09(1 << 0) /* No interrupts pending */
+#define SC16IS7XX_IIR_NO_INT_BIT=09BIT(0)   /* No interrupts pending */
 #define SC16IS7XX_IIR_ID_MASK=09=090x3e     /* Mask for the interrupt ID *=
/
 #define SC16IS7XX_IIR_THRI_SRC=09=090x02     /* TX holding register empty =
*/
 #define SC16IS7XX_IIR_RDI_SRC=09=090x04     /* RX data interrupt */
@@ -121,8 +122,8 @@
 =09=09=09=09=09=09  * to inactive (HIGH)
 =09=09=09=09=09=09  */
 /* LCR register bits */
-#define SC16IS7XX_LCR_LENGTH0_BIT=09(1 << 0) /* Word length bit 0 */
-#define SC16IS7XX_LCR_LENGTH1_BIT=09(1 << 1) /* Word length bit 1
+#define SC16IS7XX_LCR_LENGTH0_BIT=09BIT(0)   /* Word length bit 0 */
+#define SC16IS7XX_LCR_LENGTH1_BIT=09BIT(1)   /* Word length bit 1
 =09=09=09=09=09=09  *
 =09=09=09=09=09=09  * Word length bits table:
 =09=09=09=09=09=09  * 00 -> 5 bit words
@@ -130,7 +131,7 @@
 =09=09=09=09=09=09  * 10 -> 7 bit words
 =09=09=09=09=09=09  * 11 -> 8 bit words
 =09=09=09=09=09=09  */
-#define SC16IS7XX_LCR_STOPLEN_BIT=09(1 << 2) /* STOP length bit
+#define SC16IS7XX_LCR_STOPLEN_BIT=09BIT(2)   /* STOP length bit
 =09=09=09=09=09=09  *
 =09=09=09=09=09=09  * STOP length bit table:
 =09=09=09=09=09=09  * 0 -> 1 stop bit
@@ -138,11 +139,11 @@
 =09=09=09=09=09=09  *      word length is 5,
 =09=09=09=09=09=09  *      2 stop bits otherwise
 =09=09=09=09=09=09  */
-#define SC16IS7XX_LCR_PARITY_BIT=09(1 << 3) /* Parity bit enable */
-#define SC16IS7XX_LCR_EVENPARITY_BIT=09(1 << 4) /* Even parity bit enable =
*/
-#define SC16IS7XX_LCR_FORCEPARITY_BIT=09(1 << 5) /* 9-bit multidrop parity=
 */
-#define SC16IS7XX_LCR_TXBREAK_BIT=09(1 << 6) /* TX break enable */
-#define SC16IS7XX_LCR_DLAB_BIT=09=09(1 << 7) /* Divisor Latch enable */
+#define SC16IS7XX_LCR_PARITY_BIT=09BIT(3)   /* Parity bit enable */
+#define SC16IS7XX_LCR_EVENPARITY_BIT=09BIT(4)   /* Even parity bit enable =
*/
+#define SC16IS7XX_LCR_FORCEPARITY_BIT=09BIT(5)   /* 9-bit multidrop parity=
 */
+#define SC16IS7XX_LCR_TXBREAK_BIT=09BIT(6)   /* TX break enable */
+#define SC16IS7XX_LCR_DLAB_BIT=09=09BIT(7)   /* Divisor Latch enable */
 #define SC16IS7XX_LCR_WORD_LEN_5=09(0x00)
 #define SC16IS7XX_LCR_WORD_LEN_6=09(0x01)
 #define SC16IS7XX_LCR_WORD_LEN_7=09(0x02)
@@ -153,58 +154,58 @@
 =09=09=09=09=09=09=09=09* reg set */
=20
 /* MCR register bits */
-#define SC16IS7XX_MCR_DTR_BIT=09=09(1 << 0) /* DTR complement
+#define SC16IS7XX_MCR_DTR_BIT=09=09BIT(0)   /* DTR complement
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MCR_RTS_BIT=09=09(1 << 1) /* RTS complement */
-#define SC16IS7XX_MCR_TCRTLR_BIT=09(1 << 2) /* TCR/TLR register enable */
-#define SC16IS7XX_MCR_LOOP_BIT=09=09(1 << 4) /* Enable loopback test mode =
*/
-#define SC16IS7XX_MCR_XONANY_BIT=09(1 << 5) /* Enable Xon Any
+#define SC16IS7XX_MCR_RTS_BIT=09=09BIT(1)   /* RTS complement */
+#define SC16IS7XX_MCR_TCRTLR_BIT=09BIT(2)   /* TCR/TLR register enable */
+#define SC16IS7XX_MCR_LOOP_BIT=09=09BIT(4)   /* Enable loopback test mode =
*/
+#define SC16IS7XX_MCR_XONANY_BIT=09BIT(5)   /* Enable Xon Any
 =09=09=09=09=09=09  * - write enabled
 =09=09=09=09=09=09  * if (EFR[4] =3D=3D 1)
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MCR_IRDA_BIT=09=09(1 << 6) /* Enable IrDA mode
+#define SC16IS7XX_MCR_IRDA_BIT=09=09BIT(6)   /* Enable IrDA mode
 =09=09=09=09=09=09  * - write enabled
 =09=09=09=09=09=09  * if (EFR[4] =3D=3D 1)
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MCR_CLKSEL_BIT=09(1 << 7) /* Divide clock by 4
+#define SC16IS7XX_MCR_CLKSEL_BIT=09BIT(7)   /* Divide clock by 4
 =09=09=09=09=09=09  * - write enabled
 =09=09=09=09=09=09  * if (EFR[4] =3D=3D 1)
 =09=09=09=09=09=09  */
=20
 /* LSR register bits */
-#define SC16IS7XX_LSR_DR_BIT=09=09(1 << 0) /* Receiver data ready */
-#define SC16IS7XX_LSR_OE_BIT=09=09(1 << 1) /* Overrun Error */
-#define SC16IS7XX_LSR_PE_BIT=09=09(1 << 2) /* Parity Error */
-#define SC16IS7XX_LSR_FE_BIT=09=09(1 << 3) /* Frame Error */
-#define SC16IS7XX_LSR_BI_BIT=09=09(1 << 4) /* Break Interrupt */
+#define SC16IS7XX_LSR_DR_BIT=09=09BIT(0)   /* Receiver data ready */
+#define SC16IS7XX_LSR_OE_BIT=09=09BIT(1)   /* Overrun Error */
+#define SC16IS7XX_LSR_PE_BIT=09=09BIT(2)   /* Parity Error */
+#define SC16IS7XX_LSR_FE_BIT=09=09BIT(3)   /* Frame Error */
+#define SC16IS7XX_LSR_BI_BIT=09=09BIT(4)   /* Break Interrupt */
 #define SC16IS7XX_LSR_BRK_ERROR_MASK=090x1E     /* BI, FE, PE, OE bits */
-#define SC16IS7XX_LSR_THRE_BIT=09=09(1 << 5) /* TX holding register empty =
*/
-#define SC16IS7XX_LSR_TEMT_BIT=09=09(1 << 6) /* Transmitter empty */
-#define SC16IS7XX_LSR_FIFOE_BIT=09=09(1 << 7) /* Fifo Error */
+#define SC16IS7XX_LSR_THRE_BIT=09=09BIT(5)   /* TX holding register empty =
*/
+#define SC16IS7XX_LSR_TEMT_BIT=09=09BIT(6)   /* Transmitter empty */
+#define SC16IS7XX_LSR_FIFOE_BIT=09=09BIT(7)   /* Fifo Error */
=20
 /* MSR register bits */
-#define SC16IS7XX_MSR_DCTS_BIT=09=09(1 << 0) /* Delta CTS Clear To Send */
-#define SC16IS7XX_MSR_DDSR_BIT=09=09(1 << 1) /* Delta DSR Data Set Ready
+#define SC16IS7XX_MSR_DCTS_BIT=09=09BIT(0)   /* Delta CTS Clear To Send */
+#define SC16IS7XX_MSR_DDSR_BIT=09=09BIT(1)   /* Delta DSR Data Set Ready
 =09=09=09=09=09=09  * or (IO4)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_DRI_BIT=09=09(1 << 2) /* Delta RI Ring Indicator
+#define SC16IS7XX_MSR_DRI_BIT=09=09BIT(2)   /* Delta RI Ring Indicator
 =09=09=09=09=09=09  * or (IO7)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_DCD_BIT=09=09(1 << 3) /* Delta CD Carrier Detect
+#define SC16IS7XX_MSR_DCD_BIT=09=09BIT(3)   /* Delta CD Carrier Detect
 =09=09=09=09=09=09  * or (IO6)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_CTS_BIT=09=09(1 << 4) /* CTS */
-#define SC16IS7XX_MSR_DSR_BIT=09=09(1 << 5) /* DSR (IO4)
+#define SC16IS7XX_MSR_CTS_BIT=09=09BIT(4)   /* CTS */
+#define SC16IS7XX_MSR_DSR_BIT=09=09BIT(5)   /* DSR (IO4)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_RI_BIT=09=09(1 << 6) /* RI (IO7)
+#define SC16IS7XX_MSR_RI_BIT=09=09BIT(6)   /* RI (IO7)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_CD_BIT=09=09(1 << 7) /* CD (IO6)
+#define SC16IS7XX_MSR_CD_BIT=09=09BIT(7)   /* CD (IO6)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
=20
@@ -239,19 +240,19 @@
 #define SC16IS7XX_TLR_RX_TRIGGER(words)=09((((words) / 4) & 0x0f) << 4)
=20
 /* IOControl register bits (Only 75x/76x) */
-#define SC16IS7XX_IOCONTROL_LATCH_BIT=09(1 << 0) /* Enable input latching =
*/
-#define SC16IS7XX_IOCONTROL_MODEM_A_BIT=09(1 << 1) /* Enable GPIO[7:4] as =
modem A pins */
-#define SC16IS7XX_IOCONTROL_MODEM_B_BIT=09(1 << 2) /* Enable GPIO[3:0] as =
modem B pins */
-#define SC16IS7XX_IOCONTROL_SRESET_BIT=09(1 << 3) /* Software Reset */
+#define SC16IS7XX_IOCONTROL_LATCH_BIT=09BIT(0)   /* Enable input latching =
*/
+#define SC16IS7XX_IOCONTROL_MODEM_A_BIT=09BIT(1)   /* Enable GPIO[7:4] as =
modem A pins */
+#define SC16IS7XX_IOCONTROL_MODEM_B_BIT=09BIT(2)   /* Enable GPIO[3:0] as =
modem B pins */
+#define SC16IS7XX_IOCONTROL_SRESET_BIT=09BIT(3)   /* Software Reset */
=20
 /* EFCR register bits */
-#define SC16IS7XX_EFCR_9BIT_MODE_BIT=09(1 << 0) /* Enable 9-bit or Multidr=
op
+#define SC16IS7XX_EFCR_9BIT_MODE_BIT=09BIT(0)   /* Enable 9-bit or Multidr=
op
 =09=09=09=09=09=09  * mode (RS485) */
-#define SC16IS7XX_EFCR_RXDISABLE_BIT=09(1 << 1) /* Disable receiver */
-#define SC16IS7XX_EFCR_TXDISABLE_BIT=09(1 << 2) /* Disable transmitter */
-#define SC16IS7XX_EFCR_AUTO_RS485_BIT=09(1 << 4) /* Auto RS485 RTS directi=
on */
-#define SC16IS7XX_EFCR_RTS_INVERT_BIT=09(1 << 5) /* RTS output inversion *=
/
-#define SC16IS7XX_EFCR_IRDA_MODE_BIT=09(1 << 7) /* IrDA mode
+#define SC16IS7XX_EFCR_RXDISABLE_BIT=09BIT(1)   /* Disable receiver */
+#define SC16IS7XX_EFCR_TXDISABLE_BIT=09BIT(2)   /* Disable transmitter */
+#define SC16IS7XX_EFCR_AUTO_RS485_BIT=09BIT(4)   /* Auto RS485 RTS directi=
on */
+#define SC16IS7XX_EFCR_RTS_INVERT_BIT=09BIT(5)   /* RTS output inversion *=
/
+#define SC16IS7XX_EFCR_IRDA_MODE_BIT=09BIT(7)   /* IrDA mode
 =09=09=09=09=09=09  * 0 =3D rate upto 115.2 kbit/s
 =09=09=09=09=09=09  *   - Only 75x/76x
 =09=09=09=09=09=09  * 1 =3D rate upto 1.152 Mbit/s
@@ -259,15 +260,15 @@
 =09=09=09=09=09=09  */
=20
 /* EFR register bits */
-#define SC16IS7XX_EFR_AUTORTS_BIT=09(1 << 6) /* Auto RTS flow ctrl enable =
*/
-#define SC16IS7XX_EFR_AUTOCTS_BIT=09(1 << 7) /* Auto CTS flow ctrl enable =
*/
-#define SC16IS7XX_EFR_XOFF2_DETECT_BIT=09(1 << 5) /* Enable Xoff2 detectio=
n */
-#define SC16IS7XX_EFR_ENABLE_BIT=09(1 << 4) /* Enable enhanced functions
+#define SC16IS7XX_EFR_AUTORTS_BIT=09BIT(6)   /* Auto RTS flow ctrl enable =
*/
+#define SC16IS7XX_EFR_AUTOCTS_BIT=09BIT(7)   /* Auto CTS flow ctrl enable =
*/
+#define SC16IS7XX_EFR_XOFF2_DETECT_BIT=09BIT(5)   /* Enable Xoff2 detectio=
n */
+#define SC16IS7XX_EFR_ENABLE_BIT=09BIT(4)   /* Enable enhanced functions
 =09=09=09=09=09=09  * and writing to IER[7:4],
 =09=09=09=09=09=09  * FCR[5:4], MCR[7:5]
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW3_BIT=09(1 << 3)
-#define SC16IS7XX_EFR_SWFLOW2_BIT=09(1 << 2)
+#define SC16IS7XX_EFR_SWFLOW3_BIT=09BIT(3)
+#define SC16IS7XX_EFR_SWFLOW2_BIT=09BIT(2)
 =09=09=09=09=09=09 /*
 =09=09=09=09=09=09  * SWFLOW bits 3 & 2 table:
 =09=09=09=09=09=09  * 00 -> no transmitter flow
@@ -280,8 +281,8 @@
 =09=09=09=09=09=09  *       XON1, XON2, XOFF1 and
 =09=09=09=09=09=09  *       XOFF2
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW1_BIT=09(1 << 1)
-#define SC16IS7XX_EFR_SWFLOW0_BIT=09(1 << 0)
+#define SC16IS7XX_EFR_SWFLOW1_BIT=09BIT(1)
+#define SC16IS7XX_EFR_SWFLOW0_BIT=09BIT(0)
 =09=09=09=09=09=09 /*
 =09=09=09=09=09=09  * SWFLOW bits 1 & 0 table:
 =09=09=09=09=09=09  * 00 -> no received flow
@@ -307,9 +308,9 @@
 #define SC16IS7XX_FIFO_SIZE=09=09(64)
 #define SC16IS7XX_GPIOS_PER_BANK=094
=20
-#define SC16IS7XX_RECONF_MD=09=09(1 << 0)
-#define SC16IS7XX_RECONF_IER=09=09(1 << 1)
-#define SC16IS7XX_RECONF_RS485=09=09(1 << 2)
+#define SC16IS7XX_RECONF_MD=09=09BIT(0)
+#define SC16IS7XX_RECONF_IER=09=09BIT(1)
+#define SC16IS7XX_RECONF_RS485=09=09BIT(2)
=20
 struct sc16is7xx_one_config {
 =09unsigned int=09=09=09flags;
--=20
2.34.1

