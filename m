Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582FE18951C
	for <linux-serial@vger.kernel.org>; Fri, 23 Aug 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432404; cv=none; b=mdqJ8ARNIdIQrjO2ThGa1l54MVOgCJDmYt+G/RKHetMca2OMDnNbCbulUWM6M0JHr/bAS4Bgc9sxzvmjGoFAKVzzQSyIr5gf0XAqra+vCI7d3+U08QyABg0S3D/L8eHv2zi95mOnQT6xWEDK4djvyeenItpAZE34KOHN/Q6+w0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432404; c=relaxed/simple;
	bh=71aSqMyY+8n4Hsz11U1n1pKQlpKRxMK97gdfHxV8das=;
	h=Message-ID:Date:From:Subject:To:CC:MIME-Version:Content-Type; b=dDD0L3EAqTVbvUO3NYlvnY1h9tAPmuw6Ekc0dtL+Pe4cSMdpSPRJxcdyK0nVF7tGUxB9Jcoe7pmUnowZFt3b2am5+O48N3YoVzOKqAsTMwjoaAQ/VbwEtV9VJXJ6zJiuRNR+oSqpTZVYmTQ6k13MkzBWMTC2y6k93fbi9u6rmFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=A70FbLCS; arc=none smtp.client-ip=185.58.86.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="A70FbLCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1724432400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+7xb2Zyyu8QWyvP6ycd464RZ4gf+jReIhx99MhLGDi4=;
	b=A70FbLCSN/rFtljzDxbDARnh3H0CzyHsV8Z6ZhhhC4B16A0m8Hypla5oXZRtkz0zBP9Ucf
	0nKT9ZScxCinJk7waMu6+OrN1ugo/WWeyr8XFDedjePJGLn5fmHE6LEvze3qGoI50E4pRH
	Jlz6ijzQxS/AZe16imrubCJrw52BB8M=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2045.outbound.protection.outlook.com [104.47.85.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-248-ahZbjC_pMVybcvxgj-9SYA-1; Fri, 23 Aug 2024 17:53:17 +0100
X-MC-Unique: ahZbjC_pMVybcvxgj-9SYA-1
Received: from LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:20b::7)
 by LO2P123MB6200.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 16:53:15 +0000
Received: from LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
 ([fe80::55a9:7dae:8812:f567]) by LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
 ([fe80::55a9:7dae:8812:f567%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 16:53:15 +0000
Message-ID: <7deb753f-bf86-47ce-89bf-8277aca4293e@camlingroup.com>
Date: Fri, 23 Aug 2024 18:53:13 +0200
User-Agent: Mozilla Thunderbird
From: Lech Perczak <lech.perczak@camlingroup.com>
Subject: [PATCH v3 0/3] serial: sc16is7xx: cosmetic cleanup
To: linux-serial@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 =?UTF-8?Q?Pawe=C5=82_Lenkow?= <pawel.lenkow@camlingroup.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
X-ClientProxiedBy: BEXP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::11)
 To LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:20b::7)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO4P123MB5272:EE_|LO2P123MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: e94db93d-e480-4da0-ad97-08dcc39414b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v+sypVwJ/gZmWOXMNxHiqmZuUkPk3Py3HvlueaB3uYHui3qcOJk15Le5pax/?=
 =?us-ascii?Q?azJgGM902HLDs/7kQ3k5HXz7/P7iPAwxf6TWzsuMHNqGNc66KpYlOkRIH4fq?=
 =?us-ascii?Q?hO2quhuoTwBp/SvEwntouMVhr5DsUXOAM4nVNa6PrBh31cGy+9HYHhoqDtCG?=
 =?us-ascii?Q?WjTvSOclS1DZyydrFCZ+Nd91+rD4I06lLkCBZtKyAev+MGFYRB8dbn22r8au?=
 =?us-ascii?Q?5W88znDXyAAsgdVYiZLMDIt1JuY++WjT6naZlRiAalcPgzP9Lw3kEyD4sueE?=
 =?us-ascii?Q?47RbkmN/NlxlufQ3Rg89wFrUFPp9fiz9QiiYhsOPjglrF1aLteeitove0iHn?=
 =?us-ascii?Q?9z9fIxWepajXyGy4FBME+RTrze0bKtWxHGFJzkInSeHyfUQLLjDu0A+ggH7m?=
 =?us-ascii?Q?6hgJ8KV8gA93SBN5jXO31FVotc9e6OYH54gpFJbXqdFjWfDFnBOKyKpfXmAA?=
 =?us-ascii?Q?FmMg+2mLAVxQ1snrxsPD36u272Y+ZF3Qd5QiqFd3CT9xTSL45ZHl7IGMOJvF?=
 =?us-ascii?Q?6goFMlujVmaqdChXxJDrbgXRMf/Sd69i6jDkCl62KAFwiQa9zVYDXZOffL1B?=
 =?us-ascii?Q?27E2XkHkVK4SK8W1437PHJhSjOpUY+mQ+V1kk5HNgMnA4/2c36QvWg8R/TvO?=
 =?us-ascii?Q?4dLxpAh3q5FtfNlfpDXAhO8HZKwQqPBIOKDt3OMCO4xenrk+ntI8M3DqX5iB?=
 =?us-ascii?Q?jDD2ycRDBJV2f8i6PvwgNA88TnmC8EljFFZ9SMIhAqiP16JNkxV1oqPkn+cn?=
 =?us-ascii?Q?VxPZhyGGAlk2yFOiiLzrmiGNzDxDVhgbwMPgWhydVXZqvQ0ANLumD969CC0b?=
 =?us-ascii?Q?y1dCCIxjW2sI+4I9YPFzj9be+fLOC9RczMi7unVL+vahJoJtI7676992hoZO?=
 =?us-ascii?Q?0U14tJW8MSBapxumQwF1GHqz3ttl6KeQKNMcYZxf0jOtnkh9oKjIEzXgBpX0?=
 =?us-ascii?Q?0nao/rQ2Y4JEvFtO3SJj8iXM4aP0TqqM8NvT7fc3nmNIAK/r/vMSNpPG2oyj?=
 =?us-ascii?Q?QdeKlZ1hv6xozsKfhwHGcHsEiYkYQL5UNLE2HkaaY/WyYmI+mWjC448FBFkp?=
 =?us-ascii?Q?/1cSxxsEildKBA5VS2aQB4Nr6ok7g34IUjxwKkUO2mTFKL+kpKOi04TWKz7N?=
 =?us-ascii?Q?eb7/RzPoA47CZUBGPH41kEKp1UFhQVmQDhBu0nQJZPXxVL7ZWa01n3FNNoG0?=
 =?us-ascii?Q?5KArnFLlqCRMqIGuPXHtllsGh1CEwupmfFb6i3WJEK/8EL+RiOdJ8SZkLmo4?=
 =?us-ascii?Q?ZAfTsfcPNyF0nB22HZkQj6S80A2DS7Pn9FFkkiwrPa2sRIif4uOG+ozelTx4?=
 =?us-ascii?Q?7hHtS55sKJdIOSnMqNTTXiygaczGFg9CcdaIr9iTf4RVAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?akPB2H2e+wYacU2KRgmCD10EvZbhU8creXg9BaP1agHALDg9KPGfc99P8N1k?=
 =?us-ascii?Q?R6XjRp97lh4JKES34tI+oHi5DYrqF3Pe5EyJZTZ5yS1bc0Ru0cUCo/f+REG0?=
 =?us-ascii?Q?QLRMLEjSy5H8XpeDVdlyClRGncuI5uw4HmSsHSmThR+V8UkpBiVCV/R3SkX9?=
 =?us-ascii?Q?oYuvNvH5j9sFEY+SwkBB8seRJrysXkvwGe1ES461FrA/CJmNNj2v0LqmEZhI?=
 =?us-ascii?Q?JzGrAtSX6UhMmODhwnA9NLq99CXc1Q48Xide6G9Pi+fgoEZsW95bud7LBNCJ?=
 =?us-ascii?Q?EdrfETIqRhppe0pl+wH5BSRgIwx9wCUD3IfLaUhngU0aawQ5mIQgaaTJ+4/q?=
 =?us-ascii?Q?2A4+8hUvI3H9r4hcHFoDg5zd/uzMM1RKe8lACQ2zfw62T+y93V9a68JQJXIx?=
 =?us-ascii?Q?qt930w2Nh8Na4Tih5jLJpl+f4nvTj/ou+aXIvhSzWCgM2MqtA/Rv8QAOawfO?=
 =?us-ascii?Q?cFjK99ur5agzqKHV4xNvLfCDgUyEZLzCIFKGAgNQVlHmNA75d0drlYsQ99x1?=
 =?us-ascii?Q?+bvai6IzUaqW0i6z9LOhaZr/Dih23xZjwITsoQ+o+jFKP3GAsKbtbJi4ApyU?=
 =?us-ascii?Q?QYC1ETSI3zla7epuL+AqxYjXC2gNP7Mtl0f9uImltqPL3nE9kF0hOyDMUIQE?=
 =?us-ascii?Q?y7KQBN4rCukGI0B2q+/qOoe1a3JWQZg+DJ6W0bzuYrG1nOBvfuJw4A9HTC2b?=
 =?us-ascii?Q?KREWeKZJHZq1Inz+SgPFZrcmIW6LpfR0As2kNdDOM0OpZF5ZOosrkdOz1ZjU?=
 =?us-ascii?Q?ZHMQgayl4Kms9XcqFnXLk/u79m27J0lJM7msnDkfZMEkAEVjtKDXanTRg9ys?=
 =?us-ascii?Q?HMyLJIj72KusfRu/OotmGISkf6iQqATrp9JGoDTKTl0yupsNW6lDzXjmZHs9?=
 =?us-ascii?Q?OQnlCD30uVv1K6UUtZjATpwLRfk3DcienSfjLTgOYGKaCKlJh4W9e31VcuHC?=
 =?us-ascii?Q?pBufZvZ+B9fw5sxy3c6hV132mRgjkjtgYwAbvJHDlA0jWK2Y4K1c68wSm2HQ?=
 =?us-ascii?Q?HYY4+1fHqkiiDn7w21rgLqFAC4KkHi0wZEfldw8wnZeo9TmkuVj7exbETrM4?=
 =?us-ascii?Q?teCRY0Z1ZewvZ8Ml8iAscWdNcGnFdNWwFeH5squkn4Nw52HbMNTnD83KQsZJ?=
 =?us-ascii?Q?4q3KzuH+GTGf3kJx8EOAhYTFIZy3UUpiyFuRSujzo2ADCXH/INqo8CCvv9G/?=
 =?us-ascii?Q?C+riCzZ0A1mWW5Cnj0s/rWrI4aRrk13YdAOVoq++AVf+iVHQtQaHrwRaWuFP?=
 =?us-ascii?Q?FxKqKy6tBa0x3ksL02M5DIBNaGfvqenIpiH4EuXwrSC3qfalXfp1saj2FeHG?=
 =?us-ascii?Q?JDxEoCTGFIL/jBMn7KC8VC4bY5Q7dMBMyteZWxLORk9yQqEbSFzmLajhLgs2?=
 =?us-ascii?Q?udwOC4jN9VOj9boI1RUdrj6vYjtqGI02ZZAsfbqCTcZN//5wX06CPMN3iVve?=
 =?us-ascii?Q?PbH61Lkf+W60UbSc+BrjXxYBrjQfq5UNXWbhGLGF5AkshRmX4Dly0LDeNlED?=
 =?us-ascii?Q?N8F51CbaNIhLxtxBuuW8w6Ni9GpYxuY5oZDJ+TvLMjebubplbU8mdbyTOlQC?=
 =?us-ascii?Q?i6YIXqmRMJJAHTgJooRrMDpJawCFZJhVFKplA5DoxHbVwGmq35atdwhi9ppQ?=
 =?us-ascii?Q?Uh2U+VSH18+UoVtoVJan9hkgoy5WQO0wnkhASmv1a38TqcXUZX8dt4kJI56d?=
 =?us-ascii?Q?TadDQQ=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94db93d-e480-4da0-ad97-08dcc39414b6
X-MS-Exchange-CrossTenant-AuthSource: LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:53:15.1805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KQYZ+Lygi0SkHyv54gEY3P9AKKWSmEqYYILQnk6lWkDi7eebzDPwYp5D2uiP4lEAZvIeKhBEnLR0MueZ6yPAYhzRjDJAHGzv2cZvPRTmls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6200
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

When submitting previous, functional fixes, Tomasz Mo=C5=84 omitted those
two cosmetic patches, that kept lurking in our company tree - likely
by oversight. Let's submit them.

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
v3:
No code changes in patches 1 and 2.
- Pick up Reviewed-by from Andy in patch 1
- Adjust commit message in patch 2
- Perform further cleanup in bit constants,
  use GENMASK for SC16IS7XX_IIR_* and reuse bit definitions in
  SC16IS7XX_LSR_BRK_ERROR_MASK in patch 3.

v2:
- Converted bitmask definitions to use BIT macro
  (thanks Jiri Slaby for the idea)
- Removed redundant comments in patch 2 altogether
- Fixed commit messages (thanks Andy Shevchenko for
  thorough review)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>

Lech Perczak (3):
  serial: sc16is7xx: remove SC16IS7XX_MSR_DELTA_MASK
  serial: sc16is7xx: fix copy-paste errors in EFR_SWFLOWx_BIT constants
  serial: sc16is7xx: convert bitmask definitions to use BIT() macro

 drivers/tty/serial/sc16is7xx.c | 181 +++++++++++++++++----------------
 1 file changed, 92 insertions(+), 89 deletions(-)


base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
--=20
2.34.1

