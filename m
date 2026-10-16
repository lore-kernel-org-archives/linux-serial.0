Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012000.outbound.protection.outlook.com [40.93.195.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD781DF98F;
	Fri, 16 Oct 2026 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140294; cv=fail; b=pRZq3C7OXx1NLrNxunNV0zsU3VPWaAc1qPSnCg7r8hTol30IInnMzQUQV6tqFa1/oYw0/nrR1RHe8d64IuUM7xPNOJj98gk0ZH/A/XVTQ8wDNEqrxG+v7edcd8P152KNRJCAvomeiLKP2WDDRNitokS0+K3XbOOtGeJ0VZIyqd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140294; c=relaxed/simple;
	bh=ysJUznFCTCT8+Ee1SaSLloSVLG0bbxJ4NdjwRlUxMu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kO0aCY10d+qg4Xx9kLi6qEgaFyM+sS/XeapRCs/iGYFdMQvY72l78OVFAZPvf5Olq6gauYhMi35lD9iuqiJq0drXg1E69Ux8O7Hy2EycVhMxR39qikXiqgGYzx/j4AzZ/TGwgssyYXDvJgmgW/Y/R6dvNU7OjDIB8bahvLI5Mn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YyHCk+BK; arc=fail smtp.client-ip=40.93.195.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YyHCk+BK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuBGJQ/ISbzuwoMgGYQ1vDpZNzygSS8lcupzS0oMuXRBtvPhi8T912+WuRQdcPsUo7odgbheOTU7UK3mvsdxSXYvr78FvK9lhIvxxbFmPoPrX8J53ful26+SaaK6CXV7m3wMpG0A2+r6yYUrccc/YNcUS809ICJ7xhkA7yhUQWJE8YMgUM9cyVZjMaPhQwiMv5MXvhYnRuticYs03UQL66CqGPjMdxc5pclUVf3WOlQ2N21nrqyDptQtpghJyn4sRIX4DXKX0VnPYSqDmt9YvDYRlYUKvMf3kxY96yxiKORcevbgrPnZwRJUhBJA13leOwRNJ/o9Sli0RqsdHhuaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EueZt/DJnfcBw2ZFNVz533fnPN4CBFraG3GzBl1L1Dw=;
 b=iD8FxbmakN81xnOyfS41QQNyvP4c2oFWjzI0KyIqM+0wEqhNisMAuRL7Dr6cZ5tSu7rmQr9p3yvDbl7+HwUiY1gB4NGL3RecVaM0rn33Ml9ekWywQrzGz266aZ2k3elesM+BHHj26PVlWCo4EQSv35oRlmXvJEHotJpOJGTDR2GSGPuzh5f1gmJNXJad3hFLwHMdFoqv2apzu3HYG81UHFDH0uDEvMc9KSJDSJoaFH5r72TgjtBg/rdRn+mPOBJ6mzXVObBz/tTvjYKIM1YzP+5F8twtwtFRTwFaMbzk7m9a+7E1xr1qMCH5pyRd/GbTadqkws2j2BcWnRG3lNlIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EueZt/DJnfcBw2ZFNVz533fnPN4CBFraG3GzBl1L1Dw=;
 b=YyHCk+BK8BdyVqTrVq710Th/QElpPkx58MOKGTx9Thn+ABxT8VQE17mMgkGypcWmCLCH/zmS4lmgvwj633qCl+QyQkDZEL7TroKjKUFeUEUwU76x+FlSr6E0hgWLnU5hlsBWKjMSx7XcdBw+DclEyAayT36e9IE6dMLbgFHLJIiS0Djatd3VnGGAA+nYsfv+mRRdkVcsWCDdZXuLkJOkZhJq13YO+MQ4OpyAwNAo5BaBRUQhRMeeIl/UgTooFrg3ZLaI9tTrGmKLj5Cl6tTyyeoz9CU5qwWAAJEREwvlmymoHAtdV36V5hwLJbCxPWgtwJudv3g7VCLMeccuuN2rCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 08:44:47 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 08:44:47 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Donald Shannon <donalds@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Add NVIDIA LSTP USB adapter drivers
Date: Fri, 16 Oct 2026 11:44:42 +0300
Message-ID: <20261016084443.1972351-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026101355-species-glance-9ff8@gregkh>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com> <2026101355-species-glance-9ff8@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc6f89c-1e77-41ad-6200-08df2b61bba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|22082099003|10067099003|3023799007|18002099003|11063799006|4143699003|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1Wjg1cMo1Ikfy/UkJN8iE6JliVgTmXfqXM1XzUO3aL+6thOt7HJN1e/+LPfh3YP5SW2l4/aZ55l9Ae4in4YkDrFn2ypHZd25PL0NJudYxgFMnIJ09O1r8SoVb+WvBZDli0HsyycpOVU7m/pb1txkMpY4bVz4mrHQYHO0xm7OZpGPkiJbLI+ZQ5BkmqMKsEqgmxCd3hUGmnZujpxKTHDDZLhfA9htyHETcUaSbQ7154MGDZzToVu1v8yOcoHFYiXngAFnujQort6Ld68WkgAF4DgHGoa87OVZMGdmoNk83OUErr1/6Gq9wse2E3kknIBSKpIheDf0HKhX66m0/1YF/cGufkYfEV4BE3SlxSCUnzFEMGwTispqXNFs0YjXI7RuyVtadLU/NlNNLdjmpYKm8uGNDZ2tvYOh8yQqvumE0zuetInFYxpERDR9oTZcHHTlB9zuPAEkta9/YWaOChu4VnUH5XSgRtKPKA/hqLNY2RoTsOORA29V7C3pwXyamvmy8SELN4hAV1/XWRKRV2xzFc/RKugi95meWaqlHaNjthC8CoIMQTmlqeNg+cbQPdI5uiuMDGEccLBcd+4jw3nVpPPrttzyTB81wGIen/tQKFpZUzrfHg4I5bidhayAY0/e8dKL29/WQouemBjqPxvoA1NuUcXRp3GkvQIeTcK8rZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(22082099003)(10067099003)(3023799007)(18002099003)(11063799006)(4143699003)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3zXTc0GsMQEF2TSmDxZh5gX0rIshgh8lqRlC0hrQXUcFjUE6bS33mBrrBHLa?=
 =?us-ascii?Q?hwznllBNoV0KjLONxNaJBj6vPhCBZwMoHMRmxITBzclF0U1YXX15wEnJzkkm?=
 =?us-ascii?Q?aPsI7T1gvpvG2NrWHX3BSP7V+tT1v6rX1s/aIhhOKTQXzIUTRxSo8so+9HNs?=
 =?us-ascii?Q?clqluMR4Zfi8AhpugIbf/ryNO4jkQD3VGm3z5tdtWIv1R6hE6KX3XxSdT2IP?=
 =?us-ascii?Q?d0iLB0CXhCPwZy0KbCwodcje3w4AVZuOdHvJWPp4SyBeKQ/cXU4DeziQpTbH?=
 =?us-ascii?Q?Gqx74iMHhYR7WnX88H11DCExfqwxzFXZ0smY01+Aq2J5mSWFMHDYm+E35tlz?=
 =?us-ascii?Q?KWbHrUnpjFMJKPoIvOyieZHYpw9K9DIrGpglfxPDlfGpZHBPOk6SXZN/ZNYy?=
 =?us-ascii?Q?7i7Umy8xnkkmRz2tttsoiM9fOrhTNqmbMPzZDoh9vJprR8WWtO43DZ32bkQd?=
 =?us-ascii?Q?PMpy444t/xVNCeYG7z7xtzrZ8E7ur+WkoIklQQvsVMJ5mbV0yPj/sd3B4uHw?=
 =?us-ascii?Q?+/IHkhUSzYhshg/Q+3vHMDHnfClKqJ06kJwbHR0PgZVWiUgurTOzU8hKToS1?=
 =?us-ascii?Q?fjjGpt98QCNs3v0cQZDqCE0Ep/qEohsZx/dzZcGAtgu9c2z3aOkr3F6dom6O?=
 =?us-ascii?Q?h5MpioZQbsXrIul4D1xMm27hsY0SLpnhEehTaF/TSaUwOYCe98scZy9yLuC4?=
 =?us-ascii?Q?/A7203loenhXZvaWfKOJ81Cf3fz4pA4FcmtgF2HdzngxcIJxGSUp9PlGh3LY?=
 =?us-ascii?Q?VQCTPjDm0XOU/9LzWHAV/uBItVhM5BKDxwTh09UJnUCVxx9JDyluXb4sYTRB?=
 =?us-ascii?Q?JOKD/WHSnF53SEhtqvzAyM9EDrR9N7X+nib3n+oSKSO3SKStVSKvs/KzR+gl?=
 =?us-ascii?Q?b/bEaQF66l73WXuGUwvwb78U799mQIolzbOotEaykyfuewHjSEkstTnHNg7C?=
 =?us-ascii?Q?/lBr8hEOqmDcrNVPl913HasyiQTtiSyqOTvJB1ZzoqHFZb30ImxBdlU54w8T?=
 =?us-ascii?Q?/IPVU0fgt2AQG79hvNf07fOvxYlgb2+aecERUwg8eDWc7u/DWCBOZ2VFbKIC?=
 =?us-ascii?Q?m7DCwpYUUsuQHbODgpGYFIYHEjHU7efjCCfxQ4NGxZJngbIpDsRILLu93tk+?=
 =?us-ascii?Q?Xqd8MONIbYvA4UZ8Erh+XC5aCSdeZYi1OQul5CZ79Hs9g6mMiNEa7s1RVWN6?=
 =?us-ascii?Q?ofohGSZ9C3tiHIp25D79zPItDStUU0KDqRVE/06UbK6lzZO00R2RfBvQy8fU?=
 =?us-ascii?Q?Jf4ohu6HwHLHqDIYcjq+stxKeR5T/5pQRfkb2dlzqGVzB2Pp1aWZ3lDr0uES?=
 =?us-ascii?Q?mmQoflcMnMHQBiwpj9TEqCkFWLdil30mmaMEal4F0t0MV4kxnprJqKrfC1J8?=
 =?us-ascii?Q?pgCouzzM23b4ald49WHtD3ycsVIyIRJEtvE8O94ZWTBg6J86zkcbES0gKsYc?=
 =?us-ascii?Q?LtT9hU07H2Yg8sf9JJ04jkiK7eR0z4Pj+9LPV4m1ktzsOzGFjA+TY9qgBYEf?=
 =?us-ascii?Q?3yU/hpvzWmwPNbsODSXzPxt+p9bjq/SEshhXz9ICv+MC9qyOs8afnxsbBmuu?=
 =?us-ascii?Q?Yue9GDtaOj7X9pGEJ2TkcSt2HdGW55QMQjP2YXp4lyoLsEFT+IcSOzv00zEn?=
 =?us-ascii?Q?VwMYEWXyH6zIKRhXZX3CBGQHoLucrf93kbeSs2YmGL0AmjdigR6NRL2I+lWd?=
 =?us-ascii?Q?L/OZGH+xVQCxzAQHK4Nll0pcgF73SHVb0BG5ChX6hj/5WoVm+QZaGqkGM8dc?=
 =?us-ascii?Q?kTu1SGmROw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc6f89c-1e77-41ad-6200-08df2b61bba1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 08:44:47.0855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcasrPEVX5r/lPDTX9eVkuQM2OPG4jAWmoUfWgQ6znUyIrq6uqihHYwa6hflfndqI2NAhLN+tior9kvEliI3rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491

Hi Greg,

Sorry for answering in pieces. The DT question came up again in
Krzysztof's review of the bindings, so I'd like to answer that part on
its own. Jeremy asked much the same from the other side, why LSTP
needs static configuration. The rest of your review (one function per
interface, greybus) will follow once we have aligned internally, as I
wrote earlier.

On Tue, Oct 13, 2026 at 01:37:11PM +0200, Greg Kroah-Hartman wrote:
> Why would a USB device have anything to do with device tree?

[...]

> USB devices do not have DT bindings.  It's a dynamic bus, with
> self-describing devices, don't make the mistake of thinking this is
> giong to work.

The device itself is self-describing: the driver reads the channel
table from it, and the channels work without any firmware description.
What DT (or ACPI on host systems) adds is the board wiring behind the
channels, which the device cannot describe, the same as for any other
I2C or GPIO controller:

- I2C channels carry devices the kernel has to instantiate: PMBus
  voltage regulator controllers, EEPROMs, GPIO expanders. Userspace can
  add a client with new_device, but only with a name and an address, no
  interrupt, GPIO or other properties, and only on a bus number that
  changes with USB enumeration. It would also have to repeat that every
  time the adapter re-enumerates; the kernel does it on its own when the
  channel appears.

- GPIO lines get board-specific names from gpio-line-names. The adapter
  firmware reports generic pin names, the same firmware is used on
  different boards, and BMC userspace (power control, GPIO monitoring)
  looks lines up by name.

- A GPIO channel can be the interrupt controller, or the GPIO provider,
  for another device on the board. Such references between devices have
  no userspace interface at all.

On those boards the adapter is part of the board, not something a user
plugs in, which is the case the generic USB device binding
(Documentation/devicetree/bindings/usb/usb-device.yaml) covers; the
LSTP nodes sit below that node.

The DT part probably deserves its own thread with the DT maintainers
rather than being buried in this one. The RFC posted with the series
[1] has the open DT questions; I suggest we continue there, or in a new
thread if you prefer.

[1] https://lore.kernel.org/r/20261012-lstp-dt-rfc-v1-aambrozewicz@nvidia.com

Thanks,
Adrian
