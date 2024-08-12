Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6BA2B9B5
	for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481648; cv=none; b=OE0CgmB4L2DIx4D8bK1YQxmp1Zz7DpzVAdu0R+zZvzmAI1FiCgV5gmr1HuUAIHMawbCM5BBJcFT7PZPQFLRuCeDfoZBDSyz5Mnb90FjVqC5fsn4TN3XZjJ3bvWe8zJ2G76aek3/cnJvAVelotdBhfJ70vNeqwsTDmCxkWPOqyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481648; c=relaxed/simple;
	bh=WYO/Hr68K8O4+4QcNmxG1hdikMqCdxwSa306jTwohOU=;
	h=Message-ID:Date:From:Subject:To:CC:MIME-Version:Content-Type; b=KKw3ra8Tq+HBQkZvA6ybvVdEgcYVjskU8gTRd6L/NYgTSHa0Tv/Ncb4mnYiM/aG+sZphDpN8ticnBenJD/+M1sGyw1zG5lqrQp+ReVGxREjWinhD2EhDKomHa7ZB3JXv9xMdajD32org93LLnsO1uozxkEs3vJgtrtPoEX1p/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=EGk1Uipz; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="EGk1Uipz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1723481638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=faQ3K1uqWBcMWmNka0gdbTdBgwQqed7P/ONHo8hR2L8=;
	b=EGk1UipzPWG93Ap0pVOFe7orVf+K2/1tS1P4MsUc8ogoWSD/7EGeVER2z6e06WwZT2+JAQ
	A8z9zhmO3WDimzfaPLuS/j5rDQR0fo7PO8J3ZtzOILGIqskQ3fF5xo54FG24lUplaMPvpK
	7rGXR4gqCO9gNGvwNpS8WTpRE12iPQk=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2040.outbound.protection.outlook.com [104.47.85.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-256-qSel-etgM-WsCCGQylggAw-1; Mon, 12 Aug 2024 17:53:51 +0100
X-MC-Unique: qSel-etgM-WsCCGQylggAw-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LO4P123MB6545.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:27c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 16:53:50 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%6]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 16:53:50 +0000
Message-ID: <16b7bff3-71ec-4042-a9a8-755f32b85716@camlingroup.com>
Date: Mon, 12 Aug 2024 18:53:48 +0200
User-Agent: Mozilla Thunderbird
From: Lech Perczak <lech.perczak@camlingroup.com>
Subject: [PATCH v2 0/3] serial: sc16is7xx: cosmetic cleanup
To: linux-serial@vger.kernel.org, linux-serial@vger.kernel.org
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 Pawel Lenkow <p.lenkow@camlintechnologies.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
X-ClientProxiedBy: WA0P291CA0009.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::9)
 To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LO4P123MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e3788b-e548-485a-9878-08dcbaef571a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Veu2XPPex8NEKzy42UB6gpxllZ0K4O4t7fKzj0rfDzPYhhy59WbdlhcTQMiP?=
 =?us-ascii?Q?Erf1g+krUiR02ypnatwtMN/rwyaA9KexVCTNNnz7J14mdSOIV4NDsNFCjrCF?=
 =?us-ascii?Q?QqFI8c8tBLUs1KsQQtYuHesy0uM7AGt/SShCG5dI/qTAWs9BOgQyAvZCTzyl?=
 =?us-ascii?Q?x47X5RGu15+726HHeg5a/Y3zU+z3WhquBxYw3I6toJ0qrRbmbY9jRrQdhQxG?=
 =?us-ascii?Q?snaH6FlKW/7TXwhfPzYi2UEL0QXKV8EIdQ9C/R8NkksNluxIjmL7DmOy8OyO?=
 =?us-ascii?Q?CLpg7kxlCbSsujcVbrEkbyRXXOUvw/wY7kpCg0XMgahaOp9X++CrJJYbHOiQ?=
 =?us-ascii?Q?kgerGMsV/+uCLlHDdcjaiX59PF4+2bOcVBOU3kX4ICrphooPd+LN3QuKR36b?=
 =?us-ascii?Q?uhdFsSjg7MvPSNfeC0Gi527m6P/21DECnXcYXy/tGJItuVCi8ej5Ut97PVZs?=
 =?us-ascii?Q?baaa/2CZnRCqMWt9ignjUupSMwArDB9ZychQBlfyI/vAXcEv9panD8VPb9QW?=
 =?us-ascii?Q?TDKGiP0NmX3PHvlYYBzVPB/KpZ80/DqzJFre6uieK7SQat799n/0r40tmjwm?=
 =?us-ascii?Q?BBrkiQrIHjjCrdFkdMQYvJ2C0CZSlUoUi+VXt27ZXwMAL3h3LsPQW0FsT4GE?=
 =?us-ascii?Q?lYnfHB8PfJ8TCmy9ug3UgUwjQKiG7+i8ltfxwwIcTamf1QF4z5V1iYQBE5N1?=
 =?us-ascii?Q?H4BkkmdbRcZrfn6xQgs1iBWKQQNdeikdkTme/r/bZTP8Sb+oSgxyeB2UIJFu?=
 =?us-ascii?Q?+MWHl/eMenj89I5Hzjg7lx+Sw859Amu0nhY9EaBqGvf6DjWllBE1UVcHeG/p?=
 =?us-ascii?Q?g5Ytr0jOOSvijiboSG8hU9uFal9/SZTVVGUjQCjuJOLHowsglMannMs9daTo?=
 =?us-ascii?Q?BbIub/yrLsJh7EQ99422ee70X3W0SgQlca8wZ7pU6Fjhp7i0kNnoH2MaMEx/?=
 =?us-ascii?Q?srUCDjTG1vKjfKEsFXt3ehhElmavqwrgEUdO0abK0Sn/Vnx0CztN9N+g7ZYB?=
 =?us-ascii?Q?Pbz3OEw2zPUnf4aEvsh6wVKKuJrFu6pXs8pMCVxy+fcC9wL8X7icTXDXxCnq?=
 =?us-ascii?Q?GDKLTGkflkTIDWB41RRjt2BTt9zMR7FknCtshd7yhW9RMBLdPa7HKsBSl2Zc?=
 =?us-ascii?Q?dk8ntZSgFfGOAaZs7XZWkpxAYuh9xZyFiq9pT3sZclOHvpAgux2gRNkKuNOP?=
 =?us-ascii?Q?JW28f6fgEPO2ER6NNiDAaN6pfKGn3EH+75MfJQTXoCYvtCYaY5d/Ip6jXOh5?=
 =?us-ascii?Q?D9f3YRoDtsL4iSobzBLgmmHo5LJW/ePyo8WZX/3jeTx0u/iLZPyq39W9IOcC?=
 =?us-ascii?Q?JMV7RPI0d7saKunOJFNLiJ9tF/Zc25SSgQwv3Hi1xuDHJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yn/XE6BLxoTEf0PMMunhSbLx0VHucUnqBmgabMlbcG9HfeV08pz+YBmoAoyv?=
 =?us-ascii?Q?4ZoZXbgURxc5h87vHvCbX/FKx8ur7ciI1GI4ASWmpYyLqUAc00SA66PkZTwc?=
 =?us-ascii?Q?kxaErFWT+Djn+mp1vdoOqS5GiE7dWUrhCDzgJkCsZNHcHhtyIXEIXPSl21rm?=
 =?us-ascii?Q?bZ+kFsM2FUoTnNpPx4RaANCh0AMGha91+rjW2KBiEwIrGA44SPZ9E/vFopMh?=
 =?us-ascii?Q?lhmbHH9mprzBHDVpTiXjULOZ9yXB0HOf2qaOYAQh6Sa6p8xt3LI24RSvKdN9?=
 =?us-ascii?Q?cAazAQWJDtT+4RoyzZy4jngvWCmyRo/jR8Yu++yh9mEvJP04EiDxZtbDaiy0?=
 =?us-ascii?Q?b5OnLQWxFH6u82jUDZLd8QWyX9TeaQoN5RCrC0wFmQGRwVWo/z4V8ZHhWnoP?=
 =?us-ascii?Q?5ma1g34pxhtbW1DyNJrEA8MEEYIt0z3kTAnWwvHQ1q/ihp+32RBTygxy1x4o?=
 =?us-ascii?Q?GwmvvHdREKOzuaxfaMhDd0fPZ32fPfk7hqbx808QZIDzy3BK1qyvqvnp2B3H?=
 =?us-ascii?Q?y6RFGU3vZIf2K7rgnL/+Iw9cELRochnDWTe7t02z0GpSVFgwpQ2FfhDwi60E?=
 =?us-ascii?Q?zqM5SjmwxF1XWzguatwrMUfRh1dNC/cMGTuYWjYQ7T/ObovOCw9i5beCs6Tc?=
 =?us-ascii?Q?7scXk0kYZrG6kVrCJsJnyUonjM1nktrcNNoe8BavDLHq6+n1I2odzOlVYf1K?=
 =?us-ascii?Q?f0nf4HbQ/E5m27F8xlnOkpHS7eIyXZcATtIa9HrAB7wJ6I9n/rCaMrvtMJ4e?=
 =?us-ascii?Q?pp4LRAd2a/3nPhSAjTN8/xtUMpKxPvAk76UOT7enFUpTDK+7J3XFp+cyUVk3?=
 =?us-ascii?Q?EKyZYjR59t8BhRc3pQlrH8d0WkPVhRmHe80JhsgWy8uNTADR5yD62+wYtY9A?=
 =?us-ascii?Q?+m05gbHzLUld/F2Ht/dxi/5JBIrx2iP3TlzkU62Kx2yfmL9XtZjQyTLFS4Ow?=
 =?us-ascii?Q?igxUydxinHD1gKoiI5b38w40XRkDuQwvDXqlWlxZVG6RXc44eIG7dhoqt05W?=
 =?us-ascii?Q?8gBZKM4Xcp8LyCv4PTzBN/V4f9saPudWFcL0LfjwXQaDx7G/zGothTi6Oxc/?=
 =?us-ascii?Q?Uw4VvxkNybBH53VJqmPt05/eAIIl+v84mePpAbZ0jqmGEDCv3H9UexF88xAa?=
 =?us-ascii?Q?ZMi8G6e4yx5FFHEgv2JXHpjmwCaQL/6GRXJQgdDo4EveXFGjccUVtiwVJNN2?=
 =?us-ascii?Q?KI+mAL4l8IoCvXWp4n2sr5ubAwo5wykuXvUOuGmkhooml84QVc+U8YZynyx3?=
 =?us-ascii?Q?4/TG5VFRaUnQWXT3IkMrQ4hCNDbx0F2sd1H6/oVHx3tVwa/KfiLGzRyjnb2m?=
 =?us-ascii?Q?3hTe6D+P/c1+dDd+FVGvylmANMFI1PdHhImEY2WU6qf+T/ZnBs6Rc0o2I4nm?=
 =?us-ascii?Q?wVKviX5D0we3/E3lWciw1gTX8LI+FPIZHPVg9Xjp7ihKvzF9JonMyfbyt64G?=
 =?us-ascii?Q?rFygLS4lquFor079vs2DLCSJx+bQcigSurnSkMr4SuNJwCrUtW2Adc9euFaH?=
 =?us-ascii?Q?ONu3z2gh/FUsYZboYIru7eo1yVYnYY308cKkdrb/a/D2SJqIXx+IOCsKfVTx?=
 =?us-ascii?Q?/+K3BRcyEAfytoEjhp3cn8hHK5075BsDyB/EaNvDAOwQVsncg5wQRnr+q2Qb?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e3788b-e548-485a-9878-08dcbaef571a
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 16:53:50.2637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx+yVw3+TRIdBDzFZzl2ag8NbsOhnRb8fA2t0IVuHLe/lmRcJ3AlVtLoAVCfPahaqK0diavYbt2uOf6X4lgUzUtam9UXyAqEr8Lzo4pwRGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6545
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

When submitting previous, functional fixes, Tomasz Mo=C5=84 omitted those
two cosmetic patches, that kept lurking in our company tree - likely
by oversight. Let's submit them.
Also convert bitmask definitions to use BIT macro.

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
v2:
- Converted bitmask definitions to use BIT macro
  (thanks Jiri Slaby for the idea).
- Removed redundant comments in patch 2 altogether
- Fixed commit messages (thanks Andy Shevchenko for
  thorough review)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>

Lech Perczak (3):
  serial: sc16is7xx: remove SC16IS7XX_MSR_DELTA_MASK
  serial: sc16is7xx: fix copy-paste errors in EFR_SWFLOWx_BIT macros
  serial: sc16is7xx: convert bitmask definitions to use BIT macro

 drivers/tty/serial/sc16is7xx.c | 144 ++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 72 deletions(-)


base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
--=20
2.34.1

