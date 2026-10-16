Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81413C0604;
	Fri, 16 Oct 2026 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138781; cv=fail; b=FY/MyCkX6vjrOYDqDJx19uI6BH0IpHXZQsP9xdzjJ4VbLwjI4GXMvuZ2/7mfK6YI2VP1/RGyKaXruAWdk8cSFJApcb5yWCB29DdpJTGkPdt2BtXXpUH/l3l602+vFgyl1SYGu0fIjUAMkXewD15w0OdNz52OhwoolZm5oxWQojI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138781; c=relaxed/simple;
	bh=aRQDaFw9WEg5+IP0pAxYPSvvDNPeuLf9f1dLjDC0zRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tc/yFlMfEpNXZ5ZC08p7dg20PFE6KUPBoIDrZfUAKeyCkcjwkLcxOONSvk644MCgDvZNVKdGeu2udgMvE7KRpJkbq6e/oLjNRa29WkF/bNco6yQqznsOVqn3hiaGyeWfOqQNlVVzFuIv0NkDP6GN/g+w0KwtVmzg5aUgEzRciRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ErDRAAUr; arc=fail smtp.client-ip=52.101.43.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ErDRAAUr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmIpXxRaV+rfmPmB6VS2JztMNlFOSqrdNvNt1O+dlGgiiSHfb7kOALHH8zPIZ5JFYUmV9+OUGSIsRKHRx6cpG1QRd/Tr7fDkeJx64tEkTMs/Dld4TuFghEAM3WlXo+EausFij6wmBRtHzMhaVEAp3+s8qQwJyARPGXxx0nEHrwZLDLyu/nNyEe7VNPLYYMmQ+vwd5kY9IrvLTBgEm4RvFey8PBnX5J23VNZtLX9d1AJu1ZDgporX7A8OZsgBGQag0xoi7kb2ki7sKs9G55GJbdw9Vxv5B1Mx5USMHCt9N1pZpeKtecUzIU0Rz1OZJxMQ6kRt1KF+hiONr5q2j3v8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXLXFFTO/jhWW5Gntf0QG96jigKPI3ILVIwT8sK9Aps=;
 b=M5yE9j0zEKxuMSZ1d/GPfS7t/Y3m+RYI4pHwVftJfdLWA9EbD4xYrWiN3yWkhVCelWLpNtJPnZfa0t91uVkdUnXJnjZa0RXT94ebqsKihpj4VtYWWcZBWHKjV+W5XJKkVYSStwv9wqJ4HhldxyDClHbeI7VYHnyqE3V9H32aM6xWKRTBTTD+gZUrEggPemU/ZAO3lJ0UWpkYDNdUT/Jo+YNL9TCnTbwTJvGkYbJ7gN50r52iFXhyRIivdSb/9Je5hDVgmzCUOlGjRZkf4oaNI8vMsBICPE5PNbGTRWfqKYBwWRbz09Sde+kbvldm/3u5MmeoNv7pV3pwRW55EV3N3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXLXFFTO/jhWW5Gntf0QG96jigKPI3ILVIwT8sK9Aps=;
 b=ErDRAAUr4xKSpLwneM190q8kSPY1DX9+qc0vKRePNg1pps43Zj2eCsRC4Vjc5OER8JIhoPPCUSXDqzKxi/lpI4SNIAuv37GhlazWQ3C9BeXraVTjr8COSd5m6kZ99R0BfKaKb86PrdmPEFfbcAVhJxNwx277388tIi7u8q8/RJKHQhSwHS6lxASa4DrE4qYO0Y63YwtNA9iLjSabyj1heioDwvp/tCjKPSIdrlQgBSRo3Sa79805VW39ngm/UudgTV7OX1304WBRhjgG/ooJJiN11JWNdiLr9Y6udJ8Fi1f5jfwsGJQQrE5byC/LSPVzVDAL6Fmmyq44QWGghcpPEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 08:19:29 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 08:19:29 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Donald Shannon <donalds@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	llvm@lists.linux.dev,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 10/11] tty: Add NVIDIA LSTP UART driver
Date: Fri, 16 Oct 2026 11:19:15 +0300
Message-ID: <20261016081917.1958681-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <558332ed-b93e-4f0d-abb0-942ca63b0cd6@kernel.org>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com> <20261012-lstp-usb-adapter-v1-10-aambrozewicz@nvidia.com> <558332ed-b93e-4f0d-abb0-942ca63b0cd6@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 318eb57d-c5af-4c7f-1ee2-08df2b5e32fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|10067099003|4143699003|261009223327099003|261009221727099003|261009221227099003|261009220027099003|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	HdcERyvIODJUhuxzrmfOfWyISxBnPUZ3kBfdB5XBWNFKmk6nAmk0Xrqn7MRYqwWpPJaMTX8syXWX3UVN8UeXOsgjus+KyOqJsUV/q1PO7m0slC4ahgBLpZRR+N6eY4VggL6suBMVMqhRaFmYAHqKQNOnP8BNBRJEnOeJCZx+wCfO3IpqD0HPNZ8q4xPPH6XAjSTxK1rStaPodZLoX8LQOdBRrZSCDDje0SofIMK7D4svwRIRetu8M5krWAcEDN4nMMRosUYfQWnzNATMH2jmW1nT+FZ4fVggQOkwcnQxU9I0E6MQE/Dq/z3YZ4NDCsDczopHBT1mWSdzACNXGyL4T43mWNEuEDmoe5B0iAy6lh1fRg+fKji7p5aqMrOsDVLxp9Q4zsW/FXMI6TSnZ+OBWGKeAkPmZOrZxypGJXvfHOJBLURNoCozdbqsLgAdHtDmaFeB/uH5TdumjDi6sZ8nD6QLqgXh99FeDPJoeKesVbmGaqTzILcHPP1RrkP165S67Kr1gLF2tsvzJMOBWgF9o+992BabC30m2TO7KuVQ3ox8K4RduIfBUZqYfwI6LuQW7pEY/MQyKMiSAvmlC5VPbKFpr0EFnVUq/lpjWIA3Rwwqzif85S37d03rYqwTjUn34FZn1fnKmSpbP2xl6GNxz4wVy0D4M24RsUVth6ZPB4k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(261009223327099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223027099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0XAJQ2xZwESOBLh2FwaUZKglNiQF2yl5oJPxbmZg9phHcr7khNTP32Guelaa?=
 =?us-ascii?Q?WsKoHENgY4vlU6mG7WhZWSHOqJnIZ0OpLlFsYDF+XyD3bpRP0C2fiTdjREoO?=
 =?us-ascii?Q?RJaRdpuBsGH2IIPZRh8kOmupeEhTjS/GkfSoAD5gW4rr9agVWAGc6dVEPPJo?=
 =?us-ascii?Q?qGffH8qBmQyrpniDYIUhF2jaiNi+s6Dqs5I6Ngh6nKdCBKTxTYm88FcXZgfd?=
 =?us-ascii?Q?YZp7hArrcqFh9bmJH2By6Q/Go28p/GEHl3QYZGJSUU+425DcuCRo+aFYh/r2?=
 =?us-ascii?Q?XMP/5ItYUMvh8Sm7EoXb32y1D6oZ2EOfat7XB03OLWUCVVvVmIXPFDgaYV+B?=
 =?us-ascii?Q?4B3duOgiHZyQm1vngxdrF8OkvjqiiIgaxd9df1IAgasYoOUWV8FzwgK9JpJx?=
 =?us-ascii?Q?AmKjO15uPGZb5zHQLbNTzX10LHRN5ukWDhi52rVK0msYXiGGg2KH+qq8pk9B?=
 =?us-ascii?Q?29+isw+kP0UDb++8NspyugZpckduXG+9WAiPe/rZaLyuv9I9sdq9V6dLn4DL?=
 =?us-ascii?Q?mnQHyqPwqGEIvw88LdH20KilzgZtvqHD3XKmPWy+vELwuqnN+H6wr+Lx2ELv?=
 =?us-ascii?Q?7a1+ioyvlN9B3jykfxGUJviSXa/NGshL0z/8vpx/cVY5GVW39SVVEy/s7bkT?=
 =?us-ascii?Q?BGumfLS/Nlysblcm7BpABFcjyf0KWMyAqsV6lGeDqluxjfXyv5BRjQXCpGoD?=
 =?us-ascii?Q?BYD6/Eb4P0xDwPR91CWdEOQLX3zeFQLrc9jPxQ2WQ8dB/FPL1BjMpQ7nTLlt?=
 =?us-ascii?Q?UmwN+X1dSoijmtpHTKiHTsvzsOY9+x7Mb9fuqhjKdwWqhxv30rJKACK5WbCn?=
 =?us-ascii?Q?4dOU4omMAFqOYycKoFh4hEQW03cT+tH3NqoEKuFWtY59mGorU2k9HcPZi1rP?=
 =?us-ascii?Q?R0nVeGxeaHEb48C4daHTXPMboB2E7Yq84lzyFeeZX/KgqGgGPXKNDQZcannM?=
 =?us-ascii?Q?myLfoQkHA4ZzLeqWQdPYUH4OyRfmO5nqTcqoz88xehwTbJUWlA7tXQUSkT8Z?=
 =?us-ascii?Q?XBU9RK6fIXQzCjG+i7jAhqlt/A5mFfeodKBuTCQ/TK6ftdtvY0lvy//Nkqtc?=
 =?us-ascii?Q?jCyaIPCwJp29Vqn6w3kIB45fg4UlABGd7iZH2hvrgUuOMKmHBKThyEkRHJ/D?=
 =?us-ascii?Q?rLVFdoxOd2Si36csE1ay1QBvPyrwjPlYe+G/C19NknLt1x7nfxub43/hsHDO?=
 =?us-ascii?Q?zXWDZ2YY7NwbDhVESzhZnLAMZElMgJDgIOd8z9DfniDdhiZGeqAYJoSFyWYT?=
 =?us-ascii?Q?JG0Aw8W3Sb1VC8WV7VbaYEdi1NyybcKF7aJcNOy9HiWxQlkuXnmgA4zGn0s/?=
 =?us-ascii?Q?QLNFQE5OelQrLYQ0ClaPdlTG0YuwvtRT2JF9JDZJq+8zizBq2ZqXK78qfxBP?=
 =?us-ascii?Q?4mH/IIhjyZHhBKP8MQiaYRZCCb9GVD9f1RpiDeVEm3u+ewG7oxj2vlvefZ0Z?=
 =?us-ascii?Q?zm22Xa8ndY/Ik+jBqci70LIxpjoMHI+jDe1JwbH9vSimA4gzF0iJioCzlVEn?=
 =?us-ascii?Q?+Qg3ZzAZWMoBxMhHnLiJHBSo9GKS9+Hspb3gjyvhQoOlr6/jko5jMkrUsXNr?=
 =?us-ascii?Q?ntsxkqB2sYEJgBwPmpaS0cWPe0UaV9gMEWCjW1bkTNnMwmkOwc6Bt+D91HoC?=
 =?us-ascii?Q?XcWmsU4/6ONsA+ElChRavhtEvL5puKak1YUe9uFx5QApUbEv38JD0MCcx4T/?=
 =?us-ascii?Q?Lnty5gu/UugVgD9I9AdnJBisuxrFV4Z6dM7v8uRfIl1pBK00Hjz7CUfPIRe1?=
 =?us-ascii?Q?dLRMQXCt4A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318eb57d-c5af-4c7f-1ee2-08df2b5e32fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 08:19:29.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGssB3Pr/daKnvY3amq8jVJJJczWl63nIX0pI9YkRVrdcepyEA209iBBpoieSxa1ozXAHO56rkqSm5decI0wmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

Hi Jiri,

Thanks for the review.

On 13. 10. 26, 7:49, Jiri Slaby wrote:
>> +static speed_t lstp_baud_to_speed(u32 baud)
>
> Maybe implement this in drivers/tty/tty_baudrate.c on the top of
> baud_table + baud_bits?

tty_termios_encode_baud_rate() already does that lookup on those
tables, including the sparc variant the kernel test robot tripped over
on this patch, and falls back to BOTHER for a rate without a Bxxx
constant (the posted code turns such a rate into B0). So rather than a
new helper, the next version keeps a struct ktermios for the line
settings the device reports and sets its speed with
tty_termios_encode_baud_rate(). Does that work for you, or would you
prefer a helper in tty_baudrate.c that returns only the Bxxx bits?

>> +	dev_info(ch->dev, "%s: ch_%d: Started as %s\n", __func__, ch->ch_id, ch->display_name);
>
> We usually print nothing in case everything went well.

Will drop it, here and in the other LSTP drivers.

>> +		tty_vhangup(tty);
>> +		tty_kref_put(tty);
>
> tty_port_tty_vhangup()?

Yes, will use it.

Thanks,
Adrian
