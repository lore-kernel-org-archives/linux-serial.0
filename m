Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021143.outbound.protection.outlook.com [52.101.70.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE235E952;
	Wed, 14 Oct 2026 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961950; cv=fail; b=XPpB03UxXOLFhktP/twjLcZIVlhr6pSLnfOkd0HIcbR2nyoY3WlnLGlKgfqxsHrrW4nsgIL9bxTrShN+MhnjL3DbxND+DuXNGb5aqWLxR+T2YKAOcOoMBrApJTAOJgRZD0AbtYwo7dPuNWtNjCOLKC55heiszVxGP14ZBb+4F+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961950; c=relaxed/simple;
	bh=R9w+h5dz70nIwzyrc9GII7qvDBjHKh3StJ0i7MpQLTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T13ePmgtI7Ld/xxZNA2gzCPyUOrdGhHu681lnH4P5DnmAhRRdB/cYMswbhUc7cSyB81PcpPHePOs+KR12lFqIkRZclsNMM2v1NRBvpOrnmxd5X0MMifISwHHDYtEvNnZ/QiHxjd/yOVmZp+8iJg0nqUFe3kaBXWoPwkYIGEO/+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=rBbU/QtN; arc=fail smtp.client-ip=52.101.70.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="rBbU/QtN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roG3uKNoQYyssBI0Ffc1IWWTBvaZ+JuFvnaRInMSkqOX9zQAzFI6TG6CTLGre16THMIdveedeykCUP2dtvTY0Ba42YUFWcfG1My4OOUvzBlx17T2WB8bkFCqtYiNcQe2T6UaTBkp3Q4Dho0o3Ujv0TMVp/xA19SGdRgflPf61zA3nX3aLyIVfOtFw5LZFm42gJxXcMiJrX611LeiYkmP1CVtKW+R24f2OIE3mwI0O/75o9u1T0a/hd13sLi4/XiTJwlMJJ9tKQjPgZbnFdzj0RRHDQVzW7eeYX+JMyHupG7kxa+MRJwCiMySKAeai/G6xlKMzHbnWzNOV158BoUXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IOwPn8U0rx9onwioCtmQl+6raAZn3RZCY57YTL7Z5Q=;
 b=ODS64NxXS1H4yWyrGFtiADAxC0OU70QG5WbgAWYIVdNehIoM/l0g2shAygMwBgdMjxoq2bPqrIhXuZhM4wDuntNoa7ZWYmJSpuKlXaWEvYeKFVJXRTUv23lluNfZ7JHLhY9H83H/cdLW8YCABQc6jHX+ItnnqKDuoBsLT89LqDGvEm/OE1ZH1lUadkIxdXj+PETWxQcz1YI+sVlxQN5CjggmRxJZhsTHvauj1x6mzz133LOtTg24cPPzA8lI7zPhXpFUYkNMH+LpILFJs4b4DA1Js4xbtai2pLDF9bs953QrVyjAUG4nNvdFAPpdkgMXrTsyKFT5fDBiPVQexi8cTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IOwPn8U0rx9onwioCtmQl+6raAZn3RZCY57YTL7Z5Q=;
 b=rBbU/QtN6zTjcvrQYdqui58D4CY3Pv8zUtjKUykEII9WHBFvN3eMp2V8CJDg+c9YwVb1nvlCS4cwwXqdn6jK3B7dlW/LdIY7zeI+/sDBI8CF4Ukgs2dyZlRNmdP6WGmk9X8f5rylHlwxV5IViwtjeP561AMlm9lRhK70L2GLf0FIadh/32150kh8CrglVXl5hc1UGrzdIAnmCdqiDDaJc1LdMut+qagTguGtnIkyWt+Yc9Gsjw9TbWeaF/kH/eaIoilzh6YHJ1548xVDFQVZmpEOWaejUVvY1+oD40xOVZjBMiMIWyR8IuAJcGdYx8FE9O4nUmPKYbHmalt3iC9mAw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PR3PR06MB7036.eurprd06.prod.outlook.com (2603:10a6:102:82::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 14 Oct
 2026 07:12:24 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 07:12:24 +0000
Message-ID: <018d3782-ba8f-498d-a514-382e5cda103f@vaisala.com>
Date: Wed, 14 Oct 2026 10:12:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/9] serial: max310x: drive RTS in software when
 hardware delays are too short
To: sashiko-reviews@lists.linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Maarten Brock <Maarten.Brock@sttls.nl>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, linux-serial@vger.kernel.org
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-8-6ba881f81e1f@vaisala.com>
 <sashiko-outbox-163982@kernel.org>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <sashiko-outbox-163982@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0379.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::22) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|PR3PR06MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c6215b-6279-4841-9fc8-08df29c27f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|10067099003|22082099003|4143699003|261009223027099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	V+2AXBmiytnnJr4kbOCYKKvLTZ6OU2tfNY50Ao5LNRbeOTwMUwzFRsu1GurGnKf2kvNReEqEsTV6L+itDrRrgaSRpe+tv5TwzAGXgjNCjnPR6YvzEUeZ92ngSp0SOdVrRwqY0p6eO98r6LcOvsoMZPlXTEPsTpo1vzR8u59/FZgOAh8Prj+jxsoWqdMmzuQkC/TcSaQEfgWgw1tyV7BPAcXJD7HrYMouU4VbG6XEgf9YxzXH3uVXNGUDAkEdWWTSP5NjcOTTKbSSBXKce5/CQqEkquvC9MC0z/BmwyeaBpatChBye9+dfKh6t28YwNcrOfETWqn/SUvPpY6AxGvYJ7tHlDRsk9K4ZDit/inRNpPbhU3+YNdiSOaRPsy5FCjL31hI8AaN7bwBlPfc6JlihPUy9N1uSuTRkDrD7dOL13QOqiWR0qUibYAataZv54PgXdpH9yeHjgKTrF2rhmPFtG8vZsBPv2mBhE9UmYgIS2NOysfmQ8MxCMd9/h1WYXb/t0ERG3Lrh6VPTdjm4qgh+9XdmYPhETVglvmRzznnp691fTUZTbNWRuuLtoKAJuZeZH0EEeEld6PtbEWg/zAYySPaah1I0JOLMOQ8IqAJyIOY39DOdOid6sp4/uHnAf3Lhe0pgjMkZ6zA8r4ITzT13xIrHf641ET72EAACuykgKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1FoTG80c25UVGRDdW5DUmxEczFtWVdDQVpNL0NrODRUOTd6TGFnNHpSZlZI?=
 =?utf-8?B?ZmtIaTdkWnVoWE05RVFIQVRDS2s4R3laRHlJckV1ZUlDVFU2dGpNdUg5OWZP?=
 =?utf-8?B?bzEveWFNVG9oUmsxNXlsV1ZGaDhHb2owaUNvaG1DckFpNkV0Tzc5QmhXMEpC?=
 =?utf-8?B?cEVRKzE2YzdEdzFHdEtIK0lhZmdTQ0xVVVY2cG5BWm10ekM5SWF4U0picDdH?=
 =?utf-8?B?WDNsUFVqaXptQlIyUkVHa3hhN1kvRS8yN3l0aUVRYXREeGJoUlF4K2lPZ0xD?=
 =?utf-8?B?N1ErTHdnYmZTdzJwbmN6QWx6WjdEQ040SEN5c295NWJYNHlpWUUrN1VySEY1?=
 =?utf-8?B?QUtKMnBpa1NvblowT0w0enpXMVlvVXZnRDF0ZU8wbnA4Uk1QZU1FVnhyTzFY?=
 =?utf-8?B?YUVsaW1nSkdsWldlMlczaHlrK1o3YmRDNFpDQzVMZ2V5YVZTSG11ek9XSTkv?=
 =?utf-8?B?ZlhtSmIvem02V1pDZStFWGprVlFqTUVqTjBlUVBUVWhaaUpIemlvZW9QYWVS?=
 =?utf-8?B?NWNpK1F0RExHdmlERjNLcGZkc0wzNCsrczlRWWxOaGo1NWgrRStyMGo1NDBu?=
 =?utf-8?B?ZlA4ZHhCVEdQVngxcWd1anJlWUxVbHMvODVpQWR4RnUvakR4RXg4MjlaZ3hQ?=
 =?utf-8?B?S2FqTVhKSFhYUW1LRlJrUXZtMGdzcmRUL1NJNkpEV3NUMVRzNEM1Ukt4NTlY?=
 =?utf-8?B?eFg0Z3hPK2syRi9OUTVMcG5FRUViRzlCaGtJM0hWOWRiYjUrckg3UzRiQUFi?=
 =?utf-8?B?ZDVGb01wWXAvdUFwNGVOa3diV3B1a3hMbzVFd1lLTjJCL21aQk41cGM5MURC?=
 =?utf-8?B?SXlqWmROZ3BCSlB0UTd1b3ZiN3FIVGFnZi9kcmZTOGRBTngxTE80ZXh4cU4w?=
 =?utf-8?B?QnNWRFl2TWVzNythd1BtWHlVSTBUdVRSeXczTGtESWpQbUx1UmI1eGxXcHJt?=
 =?utf-8?B?NnpuVjNWQ0pWcUtna2ZqN2p1dWhUSmJoK0F5M2NDb3NhUC9GSWZjYW8wVDRB?=
 =?utf-8?B?cHUvTnhVYXVDazB0MElyUEFZbjA4SU9oUkF5TURvU3MwcXAyNW4rSzJBdHd5?=
 =?utf-8?B?enhVUWZqWG8vays2dzhpTGlWSDdwUnZlQ3o3K3U1cTJVcVRrVkF4Ly90UkVt?=
 =?utf-8?B?NU5QVVRZbjY2STQxNWc0NWpRSTRiWmFiRHdZRWNKa21IRHA0MWNXWERvSGtx?=
 =?utf-8?B?LzFDWHFmaXJyWDhsT2R6TFlyK3FkTlJtQjVYcTdCYmU1OFJSUGtuZUh4VG4w?=
 =?utf-8?B?dU9VODBDa1N5eWVYelZFOU1OaE16WTlpcHFXeWgxanJXVjZsSERiUkgvbDlr?=
 =?utf-8?B?ckdiQndEU2Y1VWZ5emVDcTZTQW1rS0hPa0x5Qys0dlFaY2txS2w4NVZidGhG?=
 =?utf-8?B?MDljTUZ6aVlSVUp4STlLV01udmYzbXE4bTBMY0ZNZytXbm5QUXNqN1NRWEtE?=
 =?utf-8?B?YXRETWpvVWNCSHdveU8xUzNnbTVWclZGdmRvK20xZkpKSGlSS1BaczdXdUdt?=
 =?utf-8?B?TFJ6MVYrb1lKb2ppbnF0S1pUeG8zZTh0dFRWOWNGYUg2VU50d0c1QlYwUmY5?=
 =?utf-8?B?WmdDTnhmb3lLdHRqRllPZzlFazlBcjVZUmpWbjkvMitkUFZwT2Z4eHpuVjJ2?=
 =?utf-8?B?T1NBWEJFL1l0dmJncGpHVXgxeHVlSGRaUnZzNkd3V1ljWXcvZzZydDZlS0Vt?=
 =?utf-8?B?c0tZN053c1NFM3ZLdmMzZmVpL1lyMzVtTjVnQmhtSDZTYThXRytIUElRaExw?=
 =?utf-8?B?bDhvZmpWcVFXdnhzOE9ZcmYwc2ZLOHRETWJuNlhMK0FKS1BmWXZuKzNpS0xw?=
 =?utf-8?B?SWVFNmMzQmh5Wi80U2hZVnlsM05JTmwzc2hhaEl1Y2djbFVwSXV5Mzh6Rmhx?=
 =?utf-8?B?bmN4SkZDSzZDNk91bkRHaWVnUGgvZzVweUM5VkZNLy9JYSt6QUVSZUxyS1pL?=
 =?utf-8?B?TTRaSXBrQVJ1R29GNnhicnh6RmNnaHpXR01hQkJKSXVuQlZ0YkczQ3BBVVdX?=
 =?utf-8?B?UzVuanBuSTBuWjBEZFNncXA2M3o4WGMrUCtWQ002UytYTmdicmVyQkJOdHov?=
 =?utf-8?B?R3VJN3BENWdXY1c1U1dyTS9kWFhudWI5cjFZUHh5T2NqbEszNWg2cXJnRjJo?=
 =?utf-8?B?akduZlhIdjhweHdOd3hwSkgrQ2w3OW1yUEtpUkwzem1lcjdaaXowZ2QyZVEr?=
 =?utf-8?B?anFnb0FDMWJwVTYveHovNi9QWmU1allzODN4MUt5cXhZS2pXYjFTbHYxYjhh?=
 =?utf-8?B?UHFCRUR3cDdqcHRneEJncnBGdHI3dlZtQjRzb3VhYjZVaTlsN0VEZHpzS0hO?=
 =?utf-8?B?cmVTUFk3N2JlMlVBamg5U2hlaVdvK1NiZzJrbytSdnprZTZEcE9PS09HMnoy?=
 =?utf-8?Q?DHwuN9U0fzoyuPpY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c6215b-6279-4841-9fc8-08df29c27f04
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:12:24.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 096Bf/n+zFMf2TfS1Jl5/iSL34EybKHcfdssMSh/4KLPRzKfg4LtzuoNC35zJt+8uA/cMYwjtEc/Nb4KlS556vaNHK3m6aqP1tN2D5Euu84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7036

On 10/8/26 13:03, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:

All six were reviewed; none is introduced by this series, and the
concurrency ones describe windows this patch already bounds by design:

- the "Critical" remove() use-after-free is the pre-existing
  cancel-before-unregister ordering (see the reply on patch 7);
- the RTS worker reads the envelope state lock-free by design and
  re-derives the pin level on every run: a stale run is flushed on an
  RS485 disable, re-queued after the termios settle, and the hold
  expiry re-asserts under break ownership - RS485-disable landing in
  every envelope phase was exercised on hardware, 20/20 with no
  spurious re-assert;
- the delayed-stop check runs from the TX-empty path, where an empty
  FIFO is ground truth, and the armed hold includes one extra
  character for the shift register; the regression matrix and a two
  hour stress soak show no early release;
- the hrtimer-running window resolves inside the timer callback
  itself, which re-checks the cancel flag and state under port->lock.

Tapio
