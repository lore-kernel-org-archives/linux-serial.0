Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583CA189509
	for <linux-serial@vger.kernel.org>; Mon, 26 Aug 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686928; cv=none; b=szqnsQllWlriavrAk/pe99h0Do4UjNrn5SDxS2kLP+S/grOp+LLpvj/5zNsCb3qr9SK/XevRCvb0lk+XPptn2kr4lAQWjm09yC+JGjZKKgDVQjHBonzPrqlw93XZWk/a8CfwpT+AJN+nrWDlc9g3wKNrzDUBM+k08VvyGbMwm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686928; c=relaxed/simple;
	bh=xlivHA5ql1it85zYsrc8TIQfQPV0ClIQCYh3/vL6HX4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=EE1Zq2x8lQcfd3cUKDUcW8rQpj5a4w5RQR2LtXiTbHPUk0dE/K5Cq5MFoj0Da+YpNwhY1KvIYQ1vCt+KrdnyIXrKFbZb3CaZzYZJWM5+aR9p5TYnb9j3z+8TbF/5Qh/aWf/zTrXewbwWY47OCYxDgvDbVbbxYSLK6Rz+VRg9BIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=jYvB0l4T; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="jYvB0l4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1724686925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c728VZv6v7K8l+pge5+f5HkAlqnOFc8OqhDpJIZ4pus=;
	b=jYvB0l4TCns0hEy25y3gM2LNnOYAd5tJnRUVgMXvKwD7HdiarcdaR+9cPP+NxYlwFQeA62
	jbuVoKkQhvZJmcXN5atpv7mUVvxEzgYvV/drWF8oIkgTtlwEbuQphiSzIqsUUMsIyhV/gQ
	oJz/+YfrxZ5+i3TLhVj1Q3a13hVJl8U=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2045.outbound.protection.outlook.com [104.47.85.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-306-2Ks6rO9TN5CismZe_a-SOg-2; Mon, 26 Aug 2024 16:42:04 +0100
X-MC-Unique: 2Ks6rO9TN5CismZe_a-SOg-2
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWXP123MB6192.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:42:03 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 15:42:03 +0000
Message-ID: <2986a485-935d-4ab2-9a16-4a85288aa15a@camlingroup.com>
Date: Mon, 26 Aug 2024 17:42:01 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/3] serial: sc16is7xx: fix copy-paste errors in
 EFR_SWFLOWx_BIT constants
From: Lech Perczak <lech.perczak@camlingroup.com>
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 Pawel Lenkow <p.lenkow@camlintechnologies.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
References: <9c1f8fd4-a2a5-4f92-9e86-2cf0103b1908@camlingroup.com>
In-Reply-To: <9c1f8fd4-a2a5-4f92-9e86-2cf0103b1908@camlingroup.com>
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWXP123MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ebb7e1-55b0-4366-f868-08dcc5e5a1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2dsZHNkQUUzWkVzU00zbEJkYXNWdE5hVEtpTWFFeFpwUnRScUxGakNUdmxQ?=
 =?utf-8?B?clZhcnUrZTcxd050SGVJSGpaMUNDMWRISVE5MklMcUlvZXMvYXp5aFpwZkhB?=
 =?utf-8?B?eCs2UTFqanNkdDdmb1pIU0s1KzRaVkw2SFJFRGoyQU9BQWxCU2pvUFEvZytW?=
 =?utf-8?B?bGtBTiszTmlaTnYwQ0JGaDhGSGNwVEdLQWdQKzdvTnAxYUNZaU9SQjhjb0hN?=
 =?utf-8?B?aCtNN2xxRWNHVEtzWk9ZWjllQzl6RXM5V2RXODRmYzdXRjJRbmdqR3JScXcz?=
 =?utf-8?B?RFlvWmVKWTJZQ1Jia1NlMjRTWXlpZ3R3dEtIb0FSWDNlaEo3REFlZjRsMnA0?=
 =?utf-8?B?SmlKckFpaVRpcDRFMnd3MndqekZIL2R5UUMrVDVkYTFaVS9Xc2VjZTh2alc2?=
 =?utf-8?B?UVh6YS81MkJEcjRRSVM2eEVoOTFHS1IyTUR3V3ZXWmM1SW1zOUlmMjQ5UHNl?=
 =?utf-8?B?VWhuR09GRDM1RmwzRkpsd0xGSEozbTFYem8vaVRLblh3MWZQQVR6R05VeW1o?=
 =?utf-8?B?cEllT1JLVHBQWnJ3VDBGbmpOeXE5M1FVQ0xGVTB4Qmg2Rm94KzNxRDRvWW9q?=
 =?utf-8?B?RnhjNkxvTlBONmYyMjJUQXBVTHdhd29Pa2ZjaDdHV3FQZk5DZHcrSzA2bGtM?=
 =?utf-8?B?b052Z0lnNGNGaUVOdjVOMnRFTVZkbWV6bWlSODluWUlvTUxLYlhSOGJmNmJG?=
 =?utf-8?B?Q0hXVGk3UGdsVW5XWjRRcklhKzd4K0laZTJtWHdqelhzZjNnNTZwR0ZJYnk3?=
 =?utf-8?B?YWxkbFNBWlpETUc2VzJDY0VSYXIxc2dSQWcwZjJ5SlhlRjlqa0M3TUZzS0xU?=
 =?utf-8?B?cVJOWDgrdlVLUDk5TDRLcWdhWm1NVkt2Um81LzA3VkZEWGZGUFNHcE9BRXdQ?=
 =?utf-8?B?Q2JaRXcyOTJnd3Q5L2Y4VlRBcWNhSDJEMzlHc2psWVNVTU1HWDdzc1hsL2FU?=
 =?utf-8?B?VVVoUy8rUSs3NFRXTEZ6bDZOY3FSczJyTEcyU3RGSi9UOHRUaDhkZlJYR080?=
 =?utf-8?B?VnZ0MWprcXFGN002UU1oN25iZFc4NU1qdnl4Z0FOekhTM3FKZ2V5S3NENXZv?=
 =?utf-8?B?NVN1Y0NDZnUrclhPeUI2SUJzZ3NSNWdiRUF0MWxYMU9KcmZKQUVISnVBamE4?=
 =?utf-8?B?Q3dGSkxDbC9WSEZORStwRE5hQWhtbVVJY3EzT3NHV2RqMUpLVE9tZ2JJYXlp?=
 =?utf-8?B?RXFMS0JIYWdDdEZxNjJ0Vk1SSzZnUzg0enFTTGJqY1lueHRyZ2ROa2lTQUJl?=
 =?utf-8?B?Tm84WHcxc241YTNxdGlwWWJOK1RVbXRtU2JqY1krOTZPdzd1cXZQaFVqa0Rr?=
 =?utf-8?B?c05MMUljZm1XSDVpRkhyTncvL010ZVlmVU1IU1RLbjBKckRrQU1rbHdwM1ph?=
 =?utf-8?B?Sk9DcnQ1L3lCclpzdDRib1luNkZnZFVvT0pJSnJ1RUhQdlNIelE0bzZqZDZk?=
 =?utf-8?B?MkdoVm9DWXhxbUMvK0RtVEJSNzM2aU02VVFXaHplVldiazM1OFB3b3V2UElq?=
 =?utf-8?B?ZHo1bHhNUjdCRi9vTnIwL202dTN2WHA3a1Q5dDJmYWRnV3RZTjNzaXFFZEFR?=
 =?utf-8?B?c1RGQ3hwalRMN2tpbit5d2Z0RkVUVGhpQXBpT3pxUUtacHZBaTAvV1E0S3lj?=
 =?utf-8?B?TkNGSjJickU2cFRxVEZZRUFNUnhsUDZrckQ1NS9BcHRDYVRsQVhuT2FxRE1k?=
 =?utf-8?B?WXNKMFAvd2NCT3NCRlNTcVFNMW1qblJGNGd0T3Avd0RQSE93cWQvZnZBSkEz?=
 =?utf-8?B?cGVhOWkvaEc5eTk2TUtSQ05JR0JEb3BNMGdLOXBVVlg3aVNKK2x4bFZOM3hP?=
 =?utf-8?B?NUZ1LzNUbEVqYTQ0NE84Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmNzdUZibVhxS1B1Z2dwNVdaMjA3SFR6V0k1M1JzSGdnUFcwQWIrNkFuWFRN?=
 =?utf-8?B?OWxQTzZCa0J5SjVZeUhtbmZCajB0RmY0Nm9BY3NOWWdOdjkvbFZNSzJrRnE5?=
 =?utf-8?B?VmxIM1cxSDg0NVBlNXpIL05JUlFLQWozK0toMXcrd2pNdFBUU0pBZEh1NVl4?=
 =?utf-8?B?bHhWa1BZQVRDUFo2eUJUeitFaGNpZWdvNGNqclVUaXdpdlVnUlhVNCszWk9i?=
 =?utf-8?B?Wkp0Rm11cDhLekdaUW9RUHcyaCtsM1hYZ05JK0Vla2wrb0l3WUhVMHpGTDYv?=
 =?utf-8?B?VGs0dHp3YWhBQm9GNlVZaVpVQUh5ZHNKd3pHc05zQTI5TUFWK3N4ZHZVb0Q3?=
 =?utf-8?B?V1luVGJuVUJ2ZnZlcGhkdE5NZ1BKWHJMZk1hOWptU0FvYnB3NjV6RUh4T0N3?=
 =?utf-8?B?WVhYMlQ4d0tHSzJPWEpwMnFxK0hIeHJWb3FxblZyMW9oVkJSMTRJRlFiYm5U?=
 =?utf-8?B?VEhrL3F4enN6M2JmZEk2Nk9tYk1ralg1ZXVxa3hjYXBHNDFtMDFxeWRJWmto?=
 =?utf-8?B?Y0J6MEszcGd0MVhwRWQ2NHp6dTlEVHJLKzN5V2FzbXhzeldwZTMzTk1haUJH?=
 =?utf-8?B?NlNIN0NRWFRWTzRPYmpudDgvRmFEbXhVajF5OVptbjlaYUVIeVdROUk3Vmhn?=
 =?utf-8?B?Z2hKL1h5QVhEUjhxR2YzV2VFbXZxeHNyK09iRkFGYnFuY2JIeXM5eWZPRFNo?=
 =?utf-8?B?SFlJaGQ1RGpCWkk3bkZHVlM2SXQya2xsdVFtcCtWTU9kSW1NNXBXbGVOMloz?=
 =?utf-8?B?VXRnT0pZWTY1OTBQRnBGbUNFWUhPZ0IxVFNOdTZhZExZY09QY29tK25NWDV5?=
 =?utf-8?B?N1hybE1RaG9NcnFDQTNoVGFQNE9GM3FvM3VtNkRtWFZ6YzRjYTBRQlh6T29V?=
 =?utf-8?B?SjJSMG9kejBsRzVrWnptR2U5Nmpsclh5akV5dXZOd3YwQ2J2bDV3Sm85OXJv?=
 =?utf-8?B?TDh6b1BkOWREOGNvWUxvVVpvWXNtYVBBWlYvUFpGbkNqQTNuandIbWhnWWht?=
 =?utf-8?B?ZVFlUjhkakl5MVRTam9Sb2lLa0ZMcGlydGlhNXZVL1BLaGN0MHRxdVNQRHJL?=
 =?utf-8?B?VEJOejllZHpRSUpBcUR6Z2RrOVBlcmlobzF2VUVwaVd2Nks2MTNJTVk3Nloz?=
 =?utf-8?B?TnhLczVacFF3Q1c1QlAzdU1CcFNUYmI4TWZkTDlLZnEyMnlQS011QnI4WVhv?=
 =?utf-8?B?b1phNk5xeTJhQ1lCYVdvenVxeW5UTFFvTnhWUGtKbGc3RjdwN0xUdDBuSjFK?=
 =?utf-8?B?bE9sY2xvWlArZDlLMHRtTytTU2VuSTRiZjNZaDNnVWJZbDE3bnZyb1VRRVNN?=
 =?utf-8?B?RGpNdnRxdzZaMHUvN1hZdEJRMWVyQk84aTRpbmRDdFlHeW41QlZvOStqa0Fq?=
 =?utf-8?B?SFZYbm5EeldjWVJxVlpSTzF0QjIwU1VhOG85TXB2ODdrOXFBSTQyTVJPMk1J?=
 =?utf-8?B?NXRpTUsrN0swS1ZhcHk4ZmNHWWpERDhzVWRBSGJmN0tiMXBaMjZPZEdLdWFW?=
 =?utf-8?B?T3FvRVo5OVhjNENDTVVYSVRJMytLZklDMHZYdlFpVi8rSnAySFNiQWZLbzVv?=
 =?utf-8?B?ZkRveDR4RTMzTmtDSVRTS29aZUlNV00vR0pqNHdFenlmUFNFQitWSGwrRDc4?=
 =?utf-8?B?WHRKUVNrU0dRRHhWWlM2cGlTUVJBNHhYRU9WMlhmSWN1R3J5YW1SRGtsdDBZ?=
 =?utf-8?B?SmpicFVPRURnNVhSSm5ta1dlRHhyQUkwc3BlSWlDQzZtVXExMk1OZDBGdyt3?=
 =?utf-8?B?aEtjTEQ1Q1pDZ0k5bWgrLzkrcmlkMmxFa1BPcm5ZR1Bkdk1XT2lmL1BZYzdH?=
 =?utf-8?B?TnZ0aC9RTG9XclA1OFF4Z2lmMmRuODJFaVBxMEFlanMzQXJTU0J2V0J0Tlps?=
 =?utf-8?B?NVhlWGtOR2U4dWx3Z2lhazlidGpTYk5xZUhUdC9ibXVVa1dTUjRFQ0tZSjNs?=
 =?utf-8?B?MkxHZldCS2haODBiSzc0ei96WVJJUzZFbHhkMkhkcEJpMjU1bCs0amVCV3Y4?=
 =?utf-8?B?TEJMWDlncWU2RmtkbFlTZmRGT1cwcDhIK0tSaklJNlVEcXNENDhMbG4yQXlu?=
 =?utf-8?B?bll1bTJ4eVVvSXAraXI1RTB5OEJrZm1sZ1FEYzRBK1ZvYU5nNEdWejNMdUlJ?=
 =?utf-8?B?WEtaYU45cDZtNG1kY2gwaEhRZWJpL2VTTjRCaWFhckcrUUdCOEZiQjMyVHZy?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ebb7e1-55b0-4366-f868-08dcc5e5a1ff
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:42:03.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: morkmiD8PkL+XwU91Tn8GwrGwhgy+LbnHsLts5x0sZ3m+i8hG6frkS2JQIQMYUN6Gh+wlQ2cgjyyj0Qzhtrio/f2s039JzDXevHZ4GvfYWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB6192
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Comments attached to bits 0 and 1 incorrectly referenced bits 2 and 3,
which don't match the datasheet - fix them.
At the same time remove comments for individual constants, as they add
nothing to the definitions themselves.

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 8a2020f9930e..36b7c682ae94 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -266,9 +266,9 @@
 =09=09=09=09=09=09  * and writing to IER[7:4],
 =09=09=09=09=09=09  * FCR[5:4], MCR[7:5]
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW3_BIT=09(1 << 3) /* SWFLOW bit 3 */
-#define SC16IS7XX_EFR_SWFLOW2_BIT=09(1 << 2) /* SWFLOW bit 2
-=09=09=09=09=09=09  *
+#define SC16IS7XX_EFR_SWFLOW3_BIT=09(1 << 3)
+#define SC16IS7XX_EFR_SWFLOW2_BIT=09(1 << 2)
+=09=09=09=09=09=09 /*
 =09=09=09=09=09=09  * SWFLOW bits 3 & 2 table:
 =09=09=09=09=09=09  * 00 -> no transmitter flow
 =09=09=09=09=09=09  *       control
@@ -280,10 +280,10 @@
 =09=09=09=09=09=09  *       XON1, XON2, XOFF1 and
 =09=09=09=09=09=09  *       XOFF2
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW1_BIT=09(1 << 1) /* SWFLOW bit 2 */
-#define SC16IS7XX_EFR_SWFLOW0_BIT=09(1 << 0) /* SWFLOW bit 3
-=09=09=09=09=09=09  *
-=09=09=09=09=09=09  * SWFLOW bits 3 & 2 table:
+#define SC16IS7XX_EFR_SWFLOW1_BIT=09(1 << 1)
+#define SC16IS7XX_EFR_SWFLOW0_BIT=09(1 << 0)
+=09=09=09=09=09=09 /*
+=09=09=09=09=09=09  * SWFLOW bits 1 & 0 table:
 =09=09=09=09=09=09  * 00 -> no received flow
 =09=09=09=09=09=09  *       control
 =09=09=09=09=09=09  * 01 -> receiver compares
--=20
2.34.1

