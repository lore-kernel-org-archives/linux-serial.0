Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792665637;
	b=pqdPDwrUvN8rBoLcT0ZCozdsth6YFT2u1JhNvZFvlT+BkhUzvOBBKsNQ1CYHcGkSAxJz
	 nObMRFvfAD/h2yMoECSiQNNfQS+91+dhd34f0pQ1joiB19P7+IdhFEW7zNLrgW39lpS7n
	 h3cGC3m0TVplKYgY+7ee1crTT/Nq2qxaDKSse19tC3Y9xUHQyU+1N7NJ2OGpAvuuIfFIU
	 5p7xoku6N+g4FAUuvkszf6YHlVpJ66TAwH1id/a4/TivPUSqMdc2IzB3cX7HvReO3uH/5
	 S/dkcVMpD5A7jzHPCwgM4TFmVrYS6LCE+85SYK5i0YtCWNNCEKWAmGoJTGkm3xraWkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665637;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=kboHgt19Dz1TK6Pl0RY67RPVWyrBDrK2fm2eftb+nXQ=;
	b=cEZzoSCZ8WAQij0SKZcFUDeYx1LXNP864n5hJPgRJyfTPEcoGrJRUwtSQY5tDxLEULkS
	 CTRcLfkFWai9ChOi22sWPJ2G30UVOP6eESM1pX7wYPQR1ESexO/ko2+4TDX5YPlXg4pOG
	 HjI+3BG/QM0s7FwjTIQRpFS86wuQE4mvK7BKbH2DSDYC/Zx2IKTmnI8q2D7w90eADvLhg
	 /ARKIbB0u9/5X1iV3XmEhKjvQz0iw/fXMBZrEuOy4dGLtAiYTYkmrUAwc/NnL/JulPxiD
	 YmQT9+Zdu2cxm1j1ipWkxxYRNrBMSGxSaoqrYEoo2QXedkNmLGamzU/kobIPzljcuMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pfJe5FLa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.7
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010007.outbound.protection.outlook.com [52.101.193.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7326B606A319;
	Thu, 22 Oct 2026 10:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7326B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pfJe5FLa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCp5t3GM2v2uPmKoOGUHKtsHWMMgGMRTz8b4AGmOykXPzxMXj/Y2D+Lu9cO/krumh7BGfOGG9QhMmaS69yVTmhYcybN7hOikcG3aE2kUWOi1kzY3jOBZgck7kXZfejavYZ/miAp+2oX7pIwy+xpLxVmcjZI1PuEJKQ8si2nclfpPbKybn0xH+W0xcL3fwCQVXLKceC3xkRtp6Hb/Mh7vxuuCvYbc7ddeN6/Utg8FmM2VJdlkEgTxFAWHQKN5Hh6xKdBY5hJWXMvXYK6NwIprTSd9h6I7wu/O0pDXSr2Yp7iJpPuF8PPIojOH+xlig45c3CX2a8nus17IsHd3xJb62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kboHgt19Dz1TK6Pl0RY67RPVWyrBDrK2fm2eftb+nXQ=;
 b=R4sqdSdiDw5X9jJpB6lWJO+7e5C7p0QYFT90g1FlvAcCliQRpPqX3RjudXmcmpu/DPL5SKnCFwtrA5feIk4VarLn+4AS4PclJ1/M5MfLR4FAW7FxtV8b6JBPemeFfYKZSEhj0wG/4X6s9yvjLGbmIKzwRyWgJRS9DdfpLmWRcTGIUc7B0tt8PkrbrZjWkv18Zm8GN3FG8T/JPsenzNsWIVJWp0pDlGZxZNlyz030IyFFyG6JfuGAT+6J+7PDMZCIliOCux9yeGOW164vXb5a96pT1Gn21c1VYid4/z59KEw594U4JmQhB82jzCadNLu0WNhvsO2v3GFl0UQ9UQ1VDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kboHgt19Dz1TK6Pl0RY67RPVWyrBDrK2fm2eftb+nXQ=;
 b=pfJe5FLakhkUWA+yf6vlQpMVWMKzlYC/+qCSP5+L7UBphGYUKDSOam46D3mgMspLFmrfxVfeWXrBNodzZREhLWBfaE2RHl3PIGhjwixxr/M/Da9ngyjmApv5CZsKAAXOAIRQkRpoOgUDTXhzpewxB7T5EkmbbqzHpgpVAeCa5YDwJSDv//lJZxOjGklvwryCvVRTB2RwuxkS+S3o1qIoUBtuHfyc/OfTbVKiaqpHlV6ZsHF6Ad7X1QF9LaCJueNqqQBUxWOF6911PLg5Tom0Pn0yPu3mOtUr6ln+OKEFjHJv/6GTyEXbqa4rdrXP2j6Hc/HcOsq2sMXxwaf2Vwk5Qw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 10:40:30 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 10:40:30 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Donald Shannon <donalds@nvidia.com>,
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
	Jeremy Kerr <jk@codeconstruct.com.au>,
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
Date: Thu, 22 Oct 2026 13:40:26 +0300
Message-ID: <20261022104025.3956402-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026101355-species-glance-9ff8@gregkh>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com> <2026101355-species-glance-9ff8@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::16) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f1465f-9a94-45e1-e61d-08df3028e4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|10067099003|18002099003|22082099003|261021123027099003|261009223027099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+OnPK/ZkKADamwuB/xW7WSQqdzcrb/H0j5vW+0COGwU6r3VdZcZF91SL8N9riWodjFYbEWrxGHL/u2er0vCr2xaVWb+dJMP2l+L0AvzRcP+iolS5oqaiWgUXrLbncFoY+MB4NB4GiDCD9liRmUyp95whTvJGfMwezF94eu5GM1ch9pG4tGLVpnINM38sDV8BE8/4OhXa4YaeLr6iDe6luItBZbNzrVNFboZVIAWwWv2uxmAoh/hAf/VOydGVKDBRiD7+oEj9pY6I4b0fACqY4j9dbQwxgsr0tJaYCpMFZHkyb6FgqXDlYhNUmY3+smUAOjFUSwXp3zB0Miq/4kMwC3C+q6dZZ3GtYOdE3oUaMwe0ym9xQ+rgwOdKFJfRthaBf1B3hyov5VyywkrkiGsg1nqmTUWrVFLLAup7zcJhYDPISILKskt7IskHsnXj2PKdp4Oy3d8JC2hKVJ8a3oI0pCEWiKDmiWT/snYaoXjUUOZqwkQiq1jOF3cwHD0wpqm/AND7kbA7t7Z5aytRKrh8tBT5C2NLbJnAqSC+vIZWiTCnjYK4oBWvbAdOpiKXyKiNGDdb2+AD56sYfn0X0U071YszKun2mgTBOJSa52cibGx93cYeFhoTrUxoQFbsjJLGrf99W1/MyVsoW9iQXlyaxkZA9YyqBHlsjlZThM/bStQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(10067099003)(18002099003)(22082099003)(261021123027099003)(261009223027099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gVYd9T3606e6+ZUoYrgJQDFtt74E1gp+2mZ1QyAEiz6aOuf9oJYPSfBAO1y1?=
 =?us-ascii?Q?3upxoEvhNE/6rCiNNJIH+H9Ma9a0jpIuZS88v2B9lltVZhkoAVyFkzHFQ6Fz?=
 =?us-ascii?Q?TqPD1B5ZmexGR3NhaJw6w8ntDnCB5x11LFIKHzjCvfXxp3u3Grh8HoY5oa/S?=
 =?us-ascii?Q?aDDXqkxAdvIKdjR96Su0QliIrQ4O7UWX5/xhiuwXPF8tZqpVZh46K56YygqW?=
 =?us-ascii?Q?L7Am0rZkf+Ff0Yb/VomPai+Mn1lLPCpGTwybGhHh/oAqa176IZvtxTWkquCa?=
 =?us-ascii?Q?Aua9ajpwWlay5GVfRLZdIJ6gAUWL7yGAIRNaWd42LoYuFsBwKCs3ui1n//xU?=
 =?us-ascii?Q?JLHfCQbBWTPLMcSkKD71Nrv2Imy3jAnFaRqafPrevvbaXsslA57uTx7H5rvb?=
 =?us-ascii?Q?nhPBRmoG/Yf+nwMAg42W/g99Gw/RKAJdLc8ILerP1lS+8ZjGUhT8M6Dh35Dk?=
 =?us-ascii?Q?53p4AM8fNVsmN9jiIYzuJbq3Uql8mEapfVc0o2K4NfpnID1HZa6Qd0yssKno?=
 =?us-ascii?Q?s1eU8hunxc2gDofOwLuvVl/YLzfBQbX1jH2E4dvIfUqpYBDCJTQ4SBGQq0aq?=
 =?us-ascii?Q?iSbV3MQk7nuIUn/CZRePksIQOgr4pYrIx2qnNzv7s6TjSEW00dWFHLdngzm1?=
 =?us-ascii?Q?5iDvMtYjsufgevTklSgokourIfqpos3YqOebqyPgeuiPre3AJ/qwZCzcBttI?=
 =?us-ascii?Q?EmE+FB9qMR33Alote3Qgfi87mieYWyR8A23ZFnmFB874SITanrNUAiqoMzGI?=
 =?us-ascii?Q?1SO9oJiPZKTodv7mam0tqWxgkXN4SGalVH72WWfkgUt3ZhC9A9taYid/H6p5?=
 =?us-ascii?Q?w0zdrOSeJqUKDxV+QPq0nzMcxrcQXC/2B+20HoFdyEN3G+/dpxUsoTAzeC4m?=
 =?us-ascii?Q?+0YEMrTUEaY9ou6XjDdohOma2LQpbFtdE1bRckcnAGVz53BfxZiOSSttpPGW?=
 =?us-ascii?Q?w1YAzadBtfajXb8APTz7cIxv1sLWSiUZUHzxNq2v/PhC/BJYL2NhChplgIfh?=
 =?us-ascii?Q?QFDZwBPlbOOiX+gCadzZlzo6Qshew/NZ77bH/Ff2xOJXha6Qk2oYnZClIj/6?=
 =?us-ascii?Q?pYVvzyyFqY9+jak3D1iQlYc1GDCctZ7ccNBCjRk0/blY7nIog3hxvuFlPrzN?=
 =?us-ascii?Q?COXjpEZCBeElncg/ALwwqTtOV7h3QNjG1DCIHzQ5DWIeMlOVahPG0oyTIb3X?=
 =?us-ascii?Q?mVvBxh7DeVEdlu0TlBkgWH8YPbXC/PhMyhyIFKWu7XQUypQ7XYURTQQcw0sp?=
 =?us-ascii?Q?6gzbXifnTJgGG51PPduAeNt2zFyTDOMRmJMLBZm2RhWnRRZY4Gnzl/mfhqSC?=
 =?us-ascii?Q?VGmGWHILAF04HyV95WTPtj9RnvV9vqWxBLnyaSy1e5Lsu5bB3HwixnkftWfc?=
 =?us-ascii?Q?A0NoJyNFL0g30ucOhTy+uuphxDAk8iTybi84J6FUFZiFJlfWRW0k2O2qDHCO?=
 =?us-ascii?Q?WzB5zf91qFw3QCqV1IC6VJgM8oYnph0MsFSGLWVum9MY7qCK/xxgNPvqABbG?=
 =?us-ascii?Q?2nIf50IZP+/Mewx2rEFqiUi5REUyZzN4mq7GMWeOkDOko+0KF517ydg2QIvj?=
 =?us-ascii?Q?I7iowG1MnrkVj3ilwiAWZsUhvxwMwSecIoAI1zV5SjsjNRT4rPLRBcjF14qT?=
 =?us-ascii?Q?2AQ23Xzq99k/ENcKkMF7W/8sWyABdD/OeWu+nRv2TTBBzbmsXv9O9KBr3yo1?=
 =?us-ascii?Q?Uzlw6snIBKQZ0ck8XBTaM5w3fZlqPvc1GBTkTPo7gdfzniyMF/DbOef3GAJ1?=
 =?us-ascii?Q?lVV3jxI6Lg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f1465f-9a94-45e1-e61d-08df3028e4a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:40:30.5211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryGnCtbVz5eGlNgsfw9MqyG4REoD0G8hTFbkwRbDISxH2zP0uHTAXYLzNUr5LuKEovHbvR9LkB7iipUPee8ghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756

On Tue, Oct 13, 2026 at 01:37:11PM +0200, Greg Kroah-Hartman wrote:
> > Why the auxiliary bus, and why not MFD
> > --------------------------------------
>
> Neither is ok for USB devices, that's not an argument either way.

Here USB only carries the traffic. The I2C, SPI and GPIO channels are
ordinary controllers on the board, and their drivers register with
those subsystems; hosts describe what is wired to them with ACPI, BMCs
with device tree [1].

usb-ljca is a recent driver for a very similar device, so we modelled
the core on it: one interface carries GPIO, I2C and SPI, and the core
creates an auxiliary device per function and attaches its ACPI node.
LSTP extends that model to device tree.

Whether the next version stays LSTP or becomes a set of divergences
from an OBMF-ICP driver, as Jeremy suggested, the need is the same: a
device behind a tunnelled channel is described like one wired straight
to the BMC, so a board can move between the two without rewriting its
description.

We don't see an architecture that fits better. If you would rather see
this done differently, what would you suggest? One function per
interface I'll answer separately.

[1] https://lore.kernel.org/r/20261016084443.1972351-1-aambrozewicz@nvidia.com

Thanks,
Adrian
