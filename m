Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F713587A2;
	Fri, 16 Oct 2026 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138765; cv=fail; b=KuWmEg+9hzwnE6ePWP0RQok/5P8tXqvbLw9ehNOwP7m9m/czg9/78Tk+osEh0YsCE3o51qIr8Qrec352DdiCjA5lqgiFdBvQxM+gDE7edjb70Td8ZaB4pOy99+jBkoDQ0vml5V+DrkG+MuMjjlCjkO756SqHsjFHdhJIGbBOjjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138765; c=relaxed/simple;
	bh=sjHwZ90KJSuSHmU1O7d5tr6oGYx2S5K3+Cu5IrRnlWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XUuPxoOyXcKiEMNM/D45zhHH7zMvXUuUCNhu4UgyJ16LJmoVsIRRidIz8KklQg7de5IyQUwHXii2g5gUR3C4eJC1Slqy2A8nb2AcKNHvKaCoMHrJ/rbNyWAIoi1YFL6iFgEaegtBSlCXRbSs4MbamrlLdLY+4EakCDDYt3Hym6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oE6Kg0Nn; arc=fail smtp.client-ip=40.93.196.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oE6Kg0Nn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/Nq4V7tp3kky8v/gdI5ooqOIBLWe7v4pxV3be5mT5hp+/RDig9NNYpECSWIdPC1gXC3PLxWLCyNFysjSpt6fh/3Ei3lxKZYJRkRRi5XY6zMb13FnO2yEb4JryG/+72NGjSEvtX6cpuG/04rhDUbPdOmhoUUfAqLFpz297Sb/GM8+u+JhAHxsepbo/g0/wonyt52uIHXCMgyRIAc2DSHE248dgn5RSSCdNVxt57Eo5wbxWGOM07oUstYptWcu8W2U5ADQGKRwCKB4HeoPiRp7vRbR8jW9QZ4rPad7NEQKoaL3LzxdscbISJ+X3DkiOc8HaTL/dOO9QNCgW1En4SxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjHwZ90KJSuSHmU1O7d5tr6oGYx2S5K3+Cu5IrRnlWw=;
 b=xay/o4LBtc1KRdQIIDUO+KgAUaPCV/GszIx5k1upCsJoi4mUQFR4qAz77T2FseB2u1Ik17RgWkmLkm6Z7/KVAXSpATxIqXmSZCuzntJN3mbW4rZhSTW3pP4DMqb7TH+JComsrr0OoJGBm0VTmZGmTTfvzGdZNkzHEcqv069JY4myBc7+C94X2ZLMEAPUUr1puLeLCAk/S3/AbIzTVoNr5rwaaP8S6z5MlEkyv9XgGtD0ukJL9zk/RPQWmhOviyk/8B70G1rA+ae4GwIUsLwdSC34y5w/aZlofdvhz7rjypgOIxQSb8MkOdT/GGDsY2zbBXgXI/svVtYfruxYJN1ZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjHwZ90KJSuSHmU1O7d5tr6oGYx2S5K3+Cu5IrRnlWw=;
 b=oE6Kg0NnZUt2rwqvpriafS85mQ+6nBtykAFtjYp81ak6GYMdVs4uuh/+wjzcuso4eiHFCRb/eEyA5EqJsy9X9VuUGYua80pqcrkiRY3TGVioCunmoAnNBOQ7pWYnZKNemsAR2rYrw4G5IIlliWmGPxy+3znJd56xw/T+kp0Mzl54LYcOybYF82o5yJBNimGK8sRSF6v67en4ml8fUvSZGgq2PCQ+EMLrOIx4mp6V1oXLQSYq3i1uglep3km26O00YSWibPXDXHcAbpJ2u2hTfUewspSu7kJjVqXYbtuuCHIl+uT9o3VRgGp9djtYsq7+O4x6ktiZsNq0+IKPDq7fiA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 08:19:20 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 08:19:20 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>
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
Date: Fri, 16 Oct 2026 11:19:13 +0300
Message-ID: <20261016081917.1958681-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026101444-corncob-wildcard-6616@gregkh>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com> <2026101310-scuttle-unison-d4c3@gregkh> <c569c912141e9da7530121b8b2fc81527e0518a4.camel@codeconstruct.com.au> <2026101444-corncob-wildcard-6616@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4cbeda-ce6f-4aa0-dd1c-08df2b5e2d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dugudg7Zq0pFQh8JmiHUg5mKZjXq3GWlVCUWkUwJCDS1mee2YzjS763DVFXriVowMGEHbHQIsy01zqMsmusX62vgbR8EV151qb8VknSqTQw/eBWWAU5YbeQWWVWC2cN5vLyeYKT/FBfOO/RVQ60qRbgwJAH7cBmYLvsqW4fIxH7lAMZet8lRSEx2U5HaSaHPUD3XomiQwFsblC7MKJRNcOidnxQER96p2vZmhgwk3lH+NMZCnf7LtbBtfXcpCLk3JCNYOkXSqd6/WtiuH54lpUNfiLDbqDuKYvHJTvHIi7YtMYYSJlPvPM8NkFpjVYUJHtWc9Ku8PzjlrLIPSKfMRN99sRGktZ36EetcZj0qaHAjo0+8ho7kSgAtWNfjypQELJlSUTXs5u0gLmltd3ongSKObgsLxyp4VCzZbR+xXLLwEOpkfARBmgDcGTTO8sMRcWFo635IBdQwaX2IkQ2gUhg3HlIistgKoNFAPXD5ATRQ33oa67dUHUXcz5QXlbgBPclm681+GL/oui+MIeTZsD0jHiVauQ95iNjL5EXSaUJ020r4ZFc0/8NCIKnoH/nkhYhtCAuqP78yyG0ndH9eDGQ+KpQwdd2KDYu7Yse/Qwcqp1YW6cbtdutw+JgIn+/NeVCEJG7L3M6P/6ptK1Eg+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4RPVTciGy3LF65bewQutdbllFOuBeNBQjHKH/ZLyz5oiXLOFJGm9A483Vl/D?=
 =?us-ascii?Q?gz0zj7WH2oJyxBjGQ65VfdBmomsTMZysFuXFXACaWYQhZyp6zfQOHdASjXdS?=
 =?us-ascii?Q?tkDZP71UG/y8HfKhjUQX1BwHdj1U9vsvbksNnp6UJdGB0smM7LdwaBzx96Ql?=
 =?us-ascii?Q?F9m+Hvmjt6ozskSd5LUM2hTNtr1/0ctx5NyRMy5TPS8ZbqZaFzuvmSyChx/N?=
 =?us-ascii?Q?X1FxPp9g462ppKPu5hVBNruW8mT0Q/8zokHVSP/YRXiXBPc4yBqFBxoPMvJD?=
 =?us-ascii?Q?IK65ujU1EqmgEcUBl+vbIwD8Xmed0vX/n+c4KzA63xwjxNNSxaBH854u5UhC?=
 =?us-ascii?Q?mYMJlckcGcP6Jp+k5wgQ7oqEk6pPdjYn0sr62GfrBZpMViJFbbsE3RfcdDty?=
 =?us-ascii?Q?GeddPftgqCljFc58CR+oe3TI2yX4RnaRhk8A5IjwvnfexhIyg4VXmM5uObw0?=
 =?us-ascii?Q?D3uInLgO5jf7+P0MqC7N41ddXxRfHY85ZTLQMDbT++tGGFiyLA2VeQ+Zp0bm?=
 =?us-ascii?Q?j6JQpiHwlSRyOz1Oc4GOGbHULf2BVCHuXL84XAET0uYHHmLjdC5Ge/8l8e32?=
 =?us-ascii?Q?Q5HKuKaBb46YyBNQq7u1LWGyWATTaOg14YsEV1UM2l4+jITLNzxl2ygAnA6M?=
 =?us-ascii?Q?i8LKegYo01zFB6M06Sgv81Nxs0l/BAGk0QTTHqDTOYcGwIt6yweMTA5F17lE?=
 =?us-ascii?Q?A0a7CeCoPKKj2E2MaX8oNTRJaIoFcANYmoqeX5TI+fWDuInLacieqXboszUF?=
 =?us-ascii?Q?QiH8hs1MRkYCliEmKqrjYCqjvzWSAU0sm18alTIFTPG5Fvwq/LWG2HmEPpT5?=
 =?us-ascii?Q?+KBQoMFgyi088Bjvu8HdrL80OXMmnukac3i0En/8H45tLbOc1kvq8WeWh09W?=
 =?us-ascii?Q?wfZN1rziTJ0eZqQn5ag3o+DphczythYxJN9UL8gsvDA4CDtDQrFri7MONnuq?=
 =?us-ascii?Q?78OAMEc/LoaC3TSBeRpaVgihfDWzFZCXpyfOpFJe1epvj1pCxN2Iwp3vJxWU?=
 =?us-ascii?Q?lOyAlQBQlWayTgyEadJxX8r9vHmFGJV/R1CQCo6rmQaLDpjecUA11/+HjROk?=
 =?us-ascii?Q?H0d0qQsGs96gMEgqEmpIteigrkCppIXy92c34s0a8AQDLJg1MjRVzaZE3zpE?=
 =?us-ascii?Q?qSN5mXjMlVaODHgOaKztQXWkUKRd5ANlcgs4eru0LohaeqLXno8ciD8Kya09?=
 =?us-ascii?Q?5sMAUhOM/A9ZWNzll4BCPiIdnEvvdIYJddBAvL1/T3JzJZDkydfgB8pVJnOv?=
 =?us-ascii?Q?MNwNEJ1DSdT2WWWzKvR0k/inHPOrcWCcNAgEr0MGHs4vGnTArhoRlvEEKPTr?=
 =?us-ascii?Q?sBWTax6wg1oYHl+TVVhGGLqi+xqxEGjyWMEq3JL55Grd77TP6f2L5FVphLNN?=
 =?us-ascii?Q?Nt3bKCK2LTttlUUWoeHubLXOYb3/EB1bYotksG5qT8jDjW9Z+7b0bnD2SMp6?=
 =?us-ascii?Q?WaYzYBo6poJAIocrO/FORbOROZjt/6oO9HPqgtTamjxKq/Xv4EojyLF0O4PA?=
 =?us-ascii?Q?j9treQvdmZJqJOXxopLzF2QiBxLjrGmbk2lS6ZUUGSNvs5aCk607g82iTWqK?=
 =?us-ascii?Q?0RFq6893ELqI9FBvhfDRZVyA7J60yFSjiM3IYOX1pRDireyZAOdCMPdbvDrY?=
 =?us-ascii?Q?ATvc5h47pZF931rBWDU/7Vjk3ZYZ4is9YUYu4Cb1oQ9L5A5ObYRvfaxcugM9?=
 =?us-ascii?Q?ItOesjlcBmVH3M8InBoSj5as1CbwES3kgnqnmiX1a2gvpusH10LF3f0c77QV?=
 =?us-ascii?Q?q6okGdX0CA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4cbeda-ce6f-4aa0-dd1c-08df2b5e2d79
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 08:19:20.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+++2LPZnHDH1Kt7vxLQhYGKzOBM2GI49cMiXuRX08Q4Qv6Jf8jewsXPEOukBWncDVzzSL6jMwuXn0W7zYMdzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

Hi Greg, Jeremy,

Thanks for the review, and for the pointers to greybus and OBMF-ICP.

Some background on how LSTP relates to OBMF-ICP: LSTP was developed at
NVIDIA as an implementation of the OBMF model while the OBMF-ICP
specification was still being finalised. That took a while, and the
product could not wait for it, so LSTP ended up as a vendor deviation
from what OBMF-ICP became.

We will evaluate how to bring the LSTP and OBMF-ICP implementations
together, and we intend to work on and contribute to both. Jeremy,
thanks for the offer to look at how LSTP could fit as a set of
divergences from an OBMF-ICP driver; that is one of the options we want
to look at.

Before answering in detail, including the greybus and
one-function-per-interface questions, we need to align internally on
the next steps and the architecture. Expect to hear from us in the
next few days.

The individual patch reviews are not lost in the meantime; I'll answer
those on their own threads.

Thanks,
Adrian
