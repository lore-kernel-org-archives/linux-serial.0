Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013001.outbound.protection.outlook.com [40.107.44.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC5364949;
	Wed,  2 Sep 2026 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315788; cv=fail; b=XSb7lYA+kjA9rT8G+j7dhgZFaos9FDqgA7YoE+5B/ZqkBSaNr5pEvXnePUpzhy70Jxa/MpP/hGrXcCmxB121cP68zRfoIJbygERjanBfN/9EkQz2j6JHBORsw3S6iKVKOouq4q92hJHuJb1idM6CRzZu0QCYGPzcxkTMVtUmT/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315788; c=relaxed/simple;
	bh=w1/7xXRkSTL31TV4bz8UouWGfXQ+JgHAIF+zz73cVos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BdLqO7JHBxo10SGAYq+RqqT0S8AVFWZVSsgW0oYI6bbae8PRlxAeyCKJg5ulnZ92JavOgoRAPehEN/4Jr2P6UKI97jEWCW+TlS2vlLBPWRa3Gg2u2xXuoaTC9LJchTejYfjopYVExLKF2plenf2EA59Lfvs4/LExgb2HW+5rq5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Cdmkgs79; arc=fail smtp.client-ip=40.107.44.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Cdmkgs79"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olhtQhtOlKuTt4wyaaFUp0MRsHIJNUCj2/A/2WOozMt3/yXtG9zdNZc0w3eu5ZMWnRKlswFYvyAOydIz/I3wV92u4CUtV0rjUDf+5a4OERDfPGzy7IafR6hUxQt3D24B3xoDB+crd+JOHIVeTfPKwNAZTHTqhLe2G7TyivsgtWNaBaV5l4NPXJvmSB1G3g54x44i28V7tkvPr4ZSjavGQ7mhxJzuzLJRWRWhMI9Yqjy27ceSt3pZYeBDIn/OXrCxBP87mymDVT3/YEEbOJzotUuA6E9lNbMfdZpJtoQMdTwTaQZSXzCjaTEwLzmi+2nwU1ofetVOkc3VVZUPKsNFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDQdd7NHM5Mwl9FQXHubYYOZlCEhBy+ws5baL8Ry9l4=;
 b=RxthniFJGtfx1IrV4uV9FQbldQakZKFzrBdgyAMYV9EsKD9DrNfEVUoou3SLjwi7FtpMVBOwK1FqF4nvDcrDlcwdNvcBW9dIEzc05wsGTUIf0Tc/B6qO7H9ESOaKinlfS81ljmrjfQnauYAoeD/X3vOjoMx0Kp/bNkzdGUlZ7LhzSKgmOscs7HK7rT9jeyPlbKhGxdY4DFy0S4M2J3bAiVvJPoeiIER87KWkWcx+Gv8xfdN30WF4kln0qgSG7zaCcWhJbW0ccsCzIN4RrUPbrHHwlGFWbtDZ9j0wQ+I7DBuStZ93V0w44I9L+mcbKJchPqyHFaly1o4Y3q8DS7Mhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDQdd7NHM5Mwl9FQXHubYYOZlCEhBy+ws5baL8Ry9l4=;
 b=Cdmkgs7975+gXELuldLbFOKZ8r2QchgsF3NlCNoDt0oVNP7IuZ5xCSzolhr40HHmPH5kxhO4IwzkoS+G7ptrDHjys7HtTzwfDSLuJy5Ashs8yTF2QUxzR4T7rAaqIKxzS/J+6pE2ujDKHZj+xJXg+vsvJD4DPW9rQ4xsuZri7Lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY0PR01MB5860.apcprd01.prod.exchangelabs.com
 (2603:1096:405:19::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:23:00 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:23:00 +0000
Date: Wed, 2 Sep 2026 10:22:57 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] serial: 8250_mxpcie: probe and console fixes
Message-ID: <apeIgeYdBag2dvtP@moxa-KabyLake-H>
References: <20260901041519.114737-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901041519.114737-1-lilinmao@kylinos.cn>
X-ClientProxiedBy: SL2P216CA0194.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::19) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TY0PR01MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fdd091a-625f-4ce7-7a48-08df08991bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|10067099003|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	wGuLVzyi0pK8eEZXME6+mPQcr+Df5/6F9XHt7BNks0cKn/LgY000UnggOGJEpAz9vzejdxPitcxaWCXNpmFxZ1QbGXIw1JuozGrA85cFWewGbfnSBVefkCpm94b2G+sX3f6ZMfGyPUGXTR8ht1gdnuOMs3PuGLoqlbSHESwv2EIP6NtXhgOcOW1Ud7+p7+f+/1SqEkoA91IvTnsoN1IH/YwJWIHAUvLYMwtb4Sww/MvPwJXK+LwOGAGTqNF5u7T+KFjUp2IN3pD3z0HUduoE+cDZC3+EzAPdv0peqOwkl2jsvBrbbk90UYVkgiFZDtI0sr086R7RxC8uXN0ycgHIVF16VscIcut+zXa0uIIz8xZpgettySvOR2qNb/IwYBuSBlwznGvUQ+L3PVVWC7hql0QeUqEDp5Ml5hRIHR0Pt0TMcLjAfCOblXKF2P/Zv4AoNoqOPU7WvavirG3p9+Qloo3pVzQHz96/iBztL2Z7PRxhPv6XhTfYqwDf3IgU26RCwgNqDBIpfwNRfxzhpJqnbzpjavVSz3XnTTBQY3hJitw4C9tA1VS6V7hDq3Py52p107NsT088v1TULy1nTQ34u3EqgdufpHKYOaS92sUqsLoSkV09P6rXg0708auNOQ9tYQLCG89x4/Hc3/aZ5QHalosZxdYiwWSlbzHtxt0caU0wR3CuoCaEpePaKoVCH4OVM9Ww2iInFPGAe3TP9poCd+E2Z9Z87rfy9ZGl1bkb+yQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9w5CgsLHCT4EiED53TaHdzcaNk2hH8dEn/De3UwiZCo9LYcWu8lgAmVsUYTI?=
 =?us-ascii?Q?AGQzf0LxLtklLVjvvLiPbQVMg4ay8gNg146uLGT2xe3J1zUx9PscQgLhjjBy?=
 =?us-ascii?Q?C6XQYjW5tPVNOxK1Aoh9VKmr5Tg48OdxR046l2/aTcui2kzc+sWADAICGalO?=
 =?us-ascii?Q?jERRN4r6Hj7ZqgYB2l5prphu9RgTDjX9/A0DmdO7SezsyKdXb/VKIMUqUm1d?=
 =?us-ascii?Q?etDVf6yzr30iq60YmSMCamHwbfQy6RAK31NkZFGfoOixIoLMx4u/Uc/ZFM4H?=
 =?us-ascii?Q?oQSSPGJ0muTt9MsxUSQbrwSpgAbUhVXXGPngyVhr+XZ9GRrYYMis6GBaOvEL?=
 =?us-ascii?Q?fteq9YHpMjRidVlZknS4QIytKIiCSyX2PRYWk9beahix6EXYQCPRSaaUioGv?=
 =?us-ascii?Q?0iM7BohfXp+nI7YEwA3xxfIgv/2S2xDPCVeG3p9+ipOtxsO+T7+CH/fXWmn/?=
 =?us-ascii?Q?7kYkqAjbSye6XrUUXh1SI+O8RTF1ST36usXqdeB7iwoYEu8Ww7j3kqwm94uA?=
 =?us-ascii?Q?D4UwOHXJ7L1TAXJ4+K4XwoChiUbzbCOq9osed7uTqcsLSCBpxIhW64jw0hUH?=
 =?us-ascii?Q?jW5+GTVScUiicoGXf8B4u2b2DUgvvrIA9NJHdNBq+FRzA8l8vScDoAEyhodB?=
 =?us-ascii?Q?IXB8MF7ZA9opvT0H99TMlKKEV48XWWomTc8F9To4X2CMx8GClZ10xo5z3pae?=
 =?us-ascii?Q?KGTOPNmi2DKdPJG94pSFJKm5zZYU9tkxh2UwhS2lVHyaVC/Fh1/ehu2LvZkI?=
 =?us-ascii?Q?2anxxf/jYeGSaE6GTdUjeuDuId3t57eu7nGv7aPYEc7qGj368zAM7ZmpAdAo?=
 =?us-ascii?Q?nxeSYXSCX8oC31xBkUUnGY7DawnKztzduENyGMAsvKERzeq4P8tq1xAfCNM4?=
 =?us-ascii?Q?bzaZJ9Q+Ng1OH78ZW/vBhHYXiVL8JY3kCxs7r/1PP9ZO/b20KZhlmtpchXGH?=
 =?us-ascii?Q?+Sa8T/ku4CbnFrCBCmcPjf/2+EmKc3tHEgHu8sG6rFT6tMEn5+/gIOwZrNo2?=
 =?us-ascii?Q?wthjAeRxZQKmXZFW9ch5+V3MiKvJkLyQ/UqXaNeKmVI3ejemdXG4a5Thhp8y?=
 =?us-ascii?Q?D6HIbklkDI0h0Zd33/52qn5/w1sLpQP/WcV1YPK+YkPt4q0nvIi1cWqcuVCL?=
 =?us-ascii?Q?qWNdy9bsjWxmg/WCZ/K82IP0LSMAY0/B2aGXYN91LTQjRfr0TFBAKsI7SXws?=
 =?us-ascii?Q?/6PUsvuP2H+vnffSvOQI5q+TcSWYrXuEfJRWLKMXQjRHrnoMHvuOBywDQD9f?=
 =?us-ascii?Q?XpoOe/eCMBlj31qQKZkuCop5E2YZBxtKrs8mFdAaUC2EtgteFA33M8vNi6Cq?=
 =?us-ascii?Q?Q0Nvl1uA6nr30oFhTU50mCUTXBKki5Ho14teg8Fypd3j9wc8A5jLHdbbgQFw?=
 =?us-ascii?Q?xYg1Vx2yI9aWv3eEehZSYnp/POH/izR03xMzIXymgnD04m2kIxNQEpSt2iou?=
 =?us-ascii?Q?YgDplXSCKauQDlad9mAmWuOdn9wenQGIi6JWXTvM2L1f+VCgREtt6VKGuntp?=
 =?us-ascii?Q?ckKcjOYU+3/6MipXb13sujuSWOV3Wdz4mnRIxBKsZ56WHAwPHRvAJXpdGd//?=
 =?us-ascii?Q?Fd0AD5mc/LXRbBe0LkpIm/ioThXb+tHlYoFuLhDkb0ZV9oUMGfnRMWEL/NAw?=
 =?us-ascii?Q?lyjpN5cDgR4rlTjhkb0UE6aO5AxpUPui5R9oSjhcxa/dvEBjxirfnczBo9gN?=
 =?us-ascii?Q?x1lek3i6kvNr+cYQjybV5Y7ueiJA1UAKs9RNTdG+KEX2VJxeAtcyQEdXNOuP?=
 =?us-ascii?Q?NI6/MOJKYsoG16IoDT3wwOAOz9MjFEA=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdd091a-625f-4ce7-7a48-08df08991bca
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:23:00.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DeLizl0J5ZqTMqpXkUgvdBkst+aVVyxbUDWQkySwIIljWpaVwLfgpZ3lJVQiziDcSVuZyZGlElbqVjw9OhlOLcQ0ZhLZNAARHs321f1M9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR01MB5860

On Tue, Sep 01, 2026 at 12:15:16PM +0800, Linmao Li wrote:
> Three fixes for the Moxa PCIe serial driver, found by reading the code
> that was split out of 8250_pci.c and extended during the 7.3 merge
> window.  That code is in mainline now but has not been in a released
> kernel, so the series is against tty-linus.
> 
> Patch 1 fixes a NULL pointer dereference during probe: the serial core
> calls ->rs485_config() from within serial8250_register_8250_port(),
> before pci_set_drvdata() has published the board.  It takes a board
> without RS232 support and SER_RS485_ENABLED still set once
> uart_get_rs485_mode() has run - on Crescent's ACPI machine the firmware
> node clears that flag, which is why it does not crash there.
> 
> Patch 2 makes removal unregister only the ports that were registered.
> v1 failed the probe instead; as Andy pointed out that is a behavioural
> change, and keeping the ports that do work is what pciserial_init_ports()
> in 8250_pci.c does, so v2 keeps it and restores only the missing count.
> 
> Patch 3 stops set_termios() from dereferencing port->state->port.tty,
> which is NULL when the serial core sets the line up for a console or for
> kgdboc.
> 
> I have no Moxa board here.  Crescent Hsieh tested patch 3 with kgdboc on
> a CP-168EL-A, and looked for patch 1's crash on a CP-134EL-A; the rest is
> compile-tested only, W=1 allmodconfig build of drivers/tty/serial/8250/
> and checkpatch --strict, both clean.

The series looks good to me.

For the series:

Reviewed-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>

The additional pre-existing issues identified by Sashiko are independent
of this series. I will investigate them further and determine the
appropriate follow-up fixes.

--
Thanks,
Crescent Hsieh
