Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022114.outbound.protection.outlook.com [52.101.101.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BEC3BE627;
	Fri, 17 Jul 2026 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286918; cv=fail; b=llmk3U2tVRk1uVOYmf1xPTuZiMB673ZmuM4MQO3flWzaN2asabPDNatWRxSMWENgna40uZ/bCh3mJ6CEYXBzfPgzDti8oXyq33BLhJ1Fjm8+FXk9q5G+mFF8l+EFaJugOyFWRcGJgAvP05sJx/Zq/wBVobQuLMFS6jGIAiB3EhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286918; c=relaxed/simple;
	bh=a0YjijGByyf/PQdKLgu06nC8YnDENztz+hm9aZBrZpk=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=d7TTEKAWwji7TsQ9gt6lIwngKhcJiUK17rzgcFMOMR4Rm1UkRlN2d0J7LA/Pw7p0EkQlO7mJwH13Ilk1ag9+znYvfByMOt3vnS+EGT6iZGg716ENz93gR/i3+teB+SE088bQYXSDYXO+kuTBpKfF+ZDrJtfbPdlJeJIVCOyN5OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=EVqyHZ1v; arc=fail smtp.client-ip=52.101.101.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="EVqyHZ1v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4QRQ+kCG7lmu2MN90fN9EjHb3oPWBAGPV/cp7nurEjJDntUeI9Pcr/25nmYTqZGlrnNqQEUDesK1+Vv5iI49lXwZpWE3Om7O9XeqqrlYPnOJaKcdmEgJGecVcWncTMLbsUx+NnRglwDx9tlAo+5R9iVIEg7X8Pbuo11Mm20/CcdJKS3qUi3fB9YMMuykVvnyRJMJE6Jo/AUgh8/0DXgvni2uBNxKcJnsRmFJMIbo2N+Y7djt12yO7n7l1zlJ4sC/hyfP6K+SfnakhyjyoMsRAjUmG2Hrh6/Enop9tcLRVtIVBcDg+aXkHQJVumYIFGvh/eTbNkqgAiKVS4Zr1jsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW/uBqik7yhgkvCIFIJULQMXhSJDUH7izW5lCUk4LLc=;
 b=NnQUtykS+Wknbw4n187am6orEyae06AEjwO6xMg0OSJl8K9a6oeTIdyfQ0SPrKK9Mds6HWCvuI7JDNtkOXzB8Zhwtz1YtAs8g2b4OHJf/Q89kFixF4GpgZEqGO99bscXjnJ2XIPToZBdkEvgJIsyVxe9sWpbw/6VwsiX63uwu2HG9OX9EWayLBTDrcGu1JSMbAV6DRVhEcYT06v9u2lhAdcoJmx718J3CJGjASL1xUhTEEgm0tqordFH2VD876zxtFM590B5IhQngkiKx6q7AifpaI0iJATH2F228BEYwhB6ywkOOgHyJmCvueNAWqFcxEVRPerxcWGu9vCH9yTGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW/uBqik7yhgkvCIFIJULQMXhSJDUH7izW5lCUk4LLc=;
 b=EVqyHZ1vxyl+4rLFlCbOu7aeKFD21Se/npby8MNfrMucLpFkkdPdCnOL20QbMrMgS2QAl6tP+5XJFjA5vDIFME/DJ4ZLL7yEXZBGR+G2k7p9dSbUmPbcs+U/Y4No+TZBuggUey0H7dPxpemvCQ7u7vs/GNspqCAp0qe0VM9iAac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2869.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 11:15:05 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:15:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 12:15:03 +0100
Message-Id: <DK0SX3P5K1J6.1OV4ETJMXW83R@garyguo.net>
To: "Markus Probst" <markus.probst@posteo.de>, "Rob Herring"
 <robh@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri
 Slaby" <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Kari Argillander" <kari.argillander@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng"
 <boqun@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v14 1/3] rust: add basic serial device bus abstractions
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <20260715-rust_serdev-v14-1-b4ed5c93606f@posteo.de>
In-Reply-To: <20260715-rust_serdev-v14-1-b4ed5c93606f@posteo.de>
X-ClientProxiedBy: LO4P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2869:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4f53d7-f5c7-49bd-5dc3-08dee3f4a6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|366016|1800799024|921020|6133799003|4143699003|5023799004|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/WyorO+tdf4IQYfwLgl0il0+xwLIkSXrP7pNyvRzpRDtmIfS3qfxIWosbmONGrSNWxZL2fIiQ5JGWFrv2IknuYAwwCP2isoj7eYpXnw543rNZP6/77qiQPJJYg761aHAi7jNG9AiZ+z285PPWodjOQDkI3WEmPhHJ/R3kqLyrHHB3PqYqaZnLVWJvj46vJ2y7+AVmcPLE0ysckcqDFUs0k4cYScoRyNWL71RkngWf5i71Pj5oMGPpBFwaW1XBuUpzQoxmWoAFntPxa9s6Hc7T5rIx6gXFSiyyNA3mQlh36M5PZ1+pN+oFPo2LOfpeJCN7+fMUdbAte69t3onv+oZElD/csxO7TTvraGzmwsRYJXFCakejlRfpPUjoUqxwps+fQwBnKPX9rKvmN3mlOtVdyUHdPkGJm6cxzTyucvtRE8f/Hglvz4UVT5vGFHUN+Ti/KNqqGWmMVzKDAF9xeRFZmmRAhVYLjpuO2Es7TOb8BNt58Z8VNl2QA6YKHH+IeBlyWkXhWfIlkgdujMbqJh+GhTo6/RTRiqhOMNfwtBEc2MQcNLfXZNGCxFjoRjMkYYRmZjEHPTG7hurD2qzaFmJwYa6CxfivepcL5KwP/sXpF5s6T362saOAEIkVWxPtLZQsoLJzWvBVY3+KUgGWQYksTx3NW59DWFNZ38WtpCrnwLTe6iiqF7DcM6qk8f4bF0LrqJzxNf/PurK/0jFMMfStg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(6133799003)(4143699003)(5023799004)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmR1Yks3L0pqSkltalZ4Y0Z3MGVzSU5PdzRyWVl0amw4QlUrcTBpNG1xRlBI?=
 =?utf-8?B?NU45dlhqWW9Jc29XMThkNVNabE10NVJmOUlNZlU4a2FTY0g0RXFjTThmUGV4?=
 =?utf-8?B?N2pQd1dxRUVMZ0c1bFBXOU8xdFJYTTJPTEd0QS81UG5PZ3FidCttYXhCTENR?=
 =?utf-8?B?T0NZalVUTFNLdWRGbUJ3OVFzVjE4NTFxblhnWkVQL0k4QXA4N0xOQXlHQTlH?=
 =?utf-8?B?TE0wYkMrb2l6ZXBGbzVzRDFYUXpObUtzRlVuRWNSdjZyN1p4Mk9wWDY2RVdU?=
 =?utf-8?B?VjZOYWMvUUU5Y252TlhETGd1aCt1RXp1bFNvZzZETTYxd242UGhMVmszMlpj?=
 =?utf-8?B?cXZuaFFmMGhFY0s5YTRYaFdMUkdJN0RVUU1BMUxjbmhDSWh1bElZL3EzZ204?=
 =?utf-8?B?eXpmT2IzbkplOENJK2xLSEMvdmIrZGRJeC9neCt6eDNVT3o3ay9jdUpRRUFl?=
 =?utf-8?B?Q1luOHlsa2N6QXNCOUpic1JRS0xFZmR1RTBMTDhSeFBsVkcyVjdycE1ZN2R3?=
 =?utf-8?B?VGtuWTdXYjQzRjhnWWtJcHhUMnlUTU45MjQ2dFp3VzI0OW00d05MeVNRVVky?=
 =?utf-8?B?b1Y5MjlBdW5iZm00djd5b1J1V04yc1NnUUVnbnhucXpQYk85dG42elVlaWFl?=
 =?utf-8?B?MWZHK0Mrem5XeHJ5UFg0SDY5MlRjc3E0YTBwTmdiR1pBaG9URmpkNE5udHo2?=
 =?utf-8?B?N0lBcDBUNmhyZk5ueHJSRWtySDZhQWoyNHNhUW9ReUczem92UFdnd0VyeHBH?=
 =?utf-8?B?ZEZWZjUrcVNWODBERnNPQ1FmK0ZkcnRmc24rNGZjVHZXcnNlK3gxS05NSTlD?=
 =?utf-8?B?RWkrTEFHcDNsVjBDL2FjV1l1YlFpeVhoejF3SVNETEJnYXlYNDZYUzlsUkVa?=
 =?utf-8?B?WWtOaVc3OEcrbUh6MUdIZk5BNmVMY3pqV1RBTVV3cXVCTkpJcnlzak9IcXha?=
 =?utf-8?B?L0JKZ0k4akNlM2d0T1IyYnF6QU1sODA0Z3orVkR1akREZ245SlIzUU5OSk5H?=
 =?utf-8?B?UjU4dXlCc3lBV1RGWm16L05PbjhRbXJkUFZrQjM4SUtGS3gyQ1FPQnhSYVZk?=
 =?utf-8?B?MzBPbDZ2NHIvT2ZVbXdwWHoraDc1ZEdDL3l0V0YzTG56NUFza3FVZDNkVUow?=
 =?utf-8?B?OWtOclJPem5kNmVGb1NtWGFKMlN5K3FwMmc4bXk4UnozMGQ5aVdlVzMrTHFW?=
 =?utf-8?B?TS80UzNONVVVNHRlZE9qWWxJb2VuQ0tpK1N2SkRXZElZMUF2TDdmclJWeGtq?=
 =?utf-8?B?ZGxyM21PMlc0VlMwOG80QVNYS0x3MFRJWm9nemhxLzloWHp0M3VBZEU5V3Fi?=
 =?utf-8?B?bjZWVlJTVVdJazRCRllBZXpGV1MvNHZUYmJKVkYvTmpRbllXZWNQNWtmZ3FG?=
 =?utf-8?B?V3FBVnJzOFZoWkJ2eXdjUGg0K3c2azJqZHZnRjRSWGhZVWhDUm9meFlnL1pi?=
 =?utf-8?B?ODBYU2RoNnE4aHNCMmh0NkEvcWxjczRRRWNvdTk4WUxPVVh0NlZ4L2ZKMUhx?=
 =?utf-8?B?d0xMU3A5VG9DcWlqKzBKQWM0dVFGdkk1STM1RXlHazRwRkNXaUVabWgwNi9O?=
 =?utf-8?B?bG1JWW1UcGMwR216N205S3plR1gxS3FQSExZZ21QOFNCY2tqRFArMzJEWVlV?=
 =?utf-8?B?UjRHVHJDY3ViRDNGa3lXS3l2Vm5aOUVJVzhFZ2tRSmFkTVJQUkpaMnowNWxp?=
 =?utf-8?B?Q21aTWUxOTJSVkVZTG1ZaEF3dG16bHZ2SnU4VEs0bndTaGozbFRRNldtRWRn?=
 =?utf-8?B?a3VXL2xCcjhIMkRxNHB1NUZuU1kxUWdPWVdPZEczZ21zbnExenFhbXFTRDI4?=
 =?utf-8?B?dzBuUnNoUDd5U1BxYk15N3h3Y2tKY3JHTnZYNmsrVnAvdVhZbHJleThZVGt2?=
 =?utf-8?B?ZG1EcEpsN2cvUW5GdFU1d3ViL1NOdW9zZWxXY0Jhcit6VEV1eXhFWld6QXZh?=
 =?utf-8?B?ejlSdXZqSXlDNVI4NGo5cEI0MXgxN21DTWJ5TzYvc2VhR1BtK3pQU1AzaUlx?=
 =?utf-8?B?R3VHaDhOYTQvd2MvOTRwZ0wrcmVpVEJUMzNYNi9TRFZURmk1RUZzTVgrOTRw?=
 =?utf-8?B?cE01V0NTZlJ2WjNGbmRVSmhOWjJRazQrUlp0cHBlVmJET1U2QUZlN1g5ZFRw?=
 =?utf-8?B?MU50L21BQWJycXlkeEwxQmFUdmxOTXZnQzRNLy81S0JlbWxvSmhHWHM5azVE?=
 =?utf-8?B?bW0rU254eGJXUWUzWFJteFZXNFQ1MGpIczB1d2hlVUhqQit3UmJ2WEluMTVH?=
 =?utf-8?B?Uy85U1ZtMzNPTzVvZ1JFSlhuaXBlYTNwUC9LUGZWQVFRSHVXUC9iZ09XOXlF?=
 =?utf-8?B?SVBMa0Jnd294NXkxMWJ1bkdMZ21QZ3pzNVZIMW5iZjFNem9jUmdOZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4f53d7-f5c7-49bd-5dc3-08dee3f4a6f5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:15:04.6926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOs3nRuLzyZYNm3pY9plil69lFbpCSxKwP8LPAR41aqzc5QbIPq0zBSQj7Seo/seMVtAE4WIlAe953+Ug/kEwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2869

On Wed Jul 15, 2026 at 10:00 PM BST, Markus Probst wrote:
> Implement the basic serial device bus abstractions required to write a
> serial device bus device driver with or without the need for initial devi=
ce
> data. This includes the following data structures:
>
> The `serdev::Driver` trait represents the interface to the driver.
>
> The `serdev::Device` abstraction represents a `struct serdev_device`.
>
> In order to provide the Serdev specific parts to a generic
> `driver::Registration` the `driver::RegistrationOps` trait is
> implemented by `serdev::Adapter`.
>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  MAINTAINERS                     |   2 +
>  drivers/tty/serdev/Kconfig      |   7 +
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/serdev.c           |  22 ++
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/serdev.rs           | 599 ++++++++++++++++++++++++++++++++++=
++++++
>  7 files changed, 634 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 806bd2d80d15..cd735d227892 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24568,6 +24568,8 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/serial/serial.yaml
>  F:	drivers/tty/serdev/
>  F:	include/linux/serdev.h
> +F:	rust/helpers/serdev.c
> +F:	rust/kernel/serdev.rs
> =20
>  SERIAL IR RECEIVER
>  M:	Sean Young <sean@mess.org>
> diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
> index 46ae732bfc68..e6dfe949ad01 100644
> --- a/drivers/tty/serdev/Kconfig
> +++ b/drivers/tty/serdev/Kconfig
> @@ -9,6 +9,13 @@ menuconfig SERIAL_DEV_BUS
> =20
>  	  Note that you typically also want to enable TTY port controller suppo=
rt.
> =20
> +config RUST_SERIAL_DEV_BUS_ABSTRACTIONS
> +	bool "Rust Serial device bus abstractions"
> +	depends on RUST
> +	select SERIAL_DEV_BUS
> +	help
> +	  This enables the Rust abstraction for the serial device bus API.
> +
>  if SERIAL_DEV_BUS
> =20
>  config SERIAL_DEV_CTRL_TTYPORT
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 1124785e210b..fe7c505da236 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -85,6 +85,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/sched.h>
>  #include <linux/security.h>
> +#include <linux/serdev.h>
>  #include <linux/slab.h>
>  #include <linux/sys_soc.h>
>  #include <linux/task_work.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 998e31052e66..6921a5ecb78a 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -87,6 +87,7 @@
>  #include "regulator.c"
>  #include "scatterlist.c"
>  #include "security.c"
> +#include "serdev.c"
>  #include "signal.c"
>  #include "slab.c"
>  #include "spinlock.c"
> diff --git a/rust/helpers/serdev.c b/rust/helpers/serdev.c
> new file mode 100644
> index 000000000000..c52b78ca3fc7
> --- /dev/null
> +++ b/rust/helpers/serdev.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/serdev.h>
> +
> +__rust_helper
> +void rust_helper_serdev_device_driver_unregister(struct serdev_device_dr=
iver *sdrv)
> +{
> +	serdev_device_driver_unregister(sdrv);
> +}
> +
> +__rust_helper
> +void rust_helper_serdev_device_put(struct serdev_device *serdev)
> +{
> +	serdev_device_put(serdev);
> +}
> +
> +__rust_helper
> +void rust_helper_serdev_device_set_client_ops(struct serdev_device *serd=
ev,
> +					      const struct serdev_device_ops *ops)
> +{
> +	serdev_device_set_client_ops(serdev, ops);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 9512af7156df..d5ca17336739 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -119,6 +119,8 @@
>  pub mod scatterlist;
>  pub mod security;
>  pub mod seq_file;
> +#[cfg(CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS)]
> +pub mod serdev;
>  pub mod sizes;
>  #[cfg(CONFIG_SOC_BUS)]
>  pub mod soc;
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> new file mode 100644
> index 000000000000..0ffcef1849d2
> --- /dev/null
> +++ b/rust/kernel/serdev.rs
> @@ -0,0 +1,599 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Abstractions for the serial device bus.
> +//!
> +//! C header: [`include/linux/serdev.h`](srctree/include/linux/serdev.h)
> +
> +use crate::{
> +    acpi,
> +    device,
> +    driver,
> +    error::{
> +        from_result,
> +        to_result,
> +        VTABLE_DEFAULT_ERROR, //
> +    },
> +    new_mutex,
> +    of,
> +    prelude::*,
> +    sync::{
> +        aref::AlwaysRefCounted,
> +        Mutex, //
> +    },
> +    time::{
> +        msecs_to_jiffies,
> +        Jiffies,
> +        Msecs, //
> +    },
> +    types::{
> +        Opaque,
> +        ScopeGuard, //
> +    }, //
> +};
> +
> +use core::{
> +    cell::UnsafeCell,
> +    marker::PhantomData,
> +    mem::{offset_of, MaybeUninit},
> +    num::NonZero,
> +    ptr::NonNull, //
> +};
> +
> +/// Parity bit to use with a serial device.
> +#[repr(u32)]
> +pub enum Parity {
> +    /// No parity bit.
> +    None =3D bindings::serdev_parity_SERDEV_PARITY_NONE,
> +    /// Even partiy.
> +    Even =3D bindings::serdev_parity_SERDEV_PARITY_EVEN,
> +    /// Odd parity.
> +    Odd =3D bindings::serdev_parity_SERDEV_PARITY_ODD,
> +}
> +
> +/// Timeout in Jiffies.
> +pub enum Timeout {
> +    /// Wait for a specific amount of [`Jiffies`].
> +    Jiffies(NonZero<Jiffies>),
> +    /// Wait for a specific amount of [`Msecs`].
> +    Milliseconds(NonZero<Msecs>),
> +    /// Wait as long as possible.
> +    ///
> +    /// This is equivalent to [`kernel::task::MAX_SCHEDULE_TIMEOUT`].
> +    Max,
> +}
> +
> +impl Timeout {
> +    fn into_jiffies(self) -> isize {
> +        match self {
> +            Self::Jiffies(value) =3D> value.get().try_into().unwrap_or_d=
efault(),
> +            Self::Milliseconds(value) =3D> {
> +                msecs_to_jiffies(value.get()).try_into().unwrap_or_defau=
lt()
> +            }
> +            Self::Max =3D> 0,
> +        }
> +    }
> +}

FWIW this shouldn't be part of serdev abstraction. See
https://lore.kernel.org/rust-for-linux/20260717042247.3634961-1-tomo@flappi=
ng.org

> +
> +/// An adapter for the registration of serial device bus device drivers.
> +pub struct Adapter<T: Driver>(T);
> +
> +// SAFETY:
> +// - `bindings::serdev_device_driver` is a C type declared as `repr(C)`.
> +// - `PrivateData<'bound, T>` is the type of the driver's device private=
 data.
> +// - `struct serdev_device_driver` embeds a `struct device_driver`.
> +// - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `=
struct device_driver`.
> +unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
> +    type DriverType =3D bindings::serdev_device_driver;
> +    type DriverData<'bound> =3D PrivateData<'bound, T>;
> +    const DEVICE_DRIVER_OFFSET: usize =3D core::mem::offset_of!(Self::Dr=
iverType, driver);
> +}
> +
> +// SAFETY: A call to `unregister` for a given instance of `DriverType` i=
s guaranteed to be valid if
> +// a preceding call to `register` has been successful.
> +unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
> +    unsafe fn register(
> +        sdrv: &Opaque<Self::DriverType>,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result {
> +        let of_table =3D match T::OF_ID_TABLE {
> +            Some(table) =3D> table.as_ptr(),
> +            None =3D> core::ptr::null(),
> +        };
> +
> +        let acpi_table =3D match T::ACPI_ID_TABLE {
> +            Some(table) =3D> table.as_ptr(),
> +            None =3D> core::ptr::null(),
> +        };
> +
> +        // SAFETY: It's safe to set the fields of `struct serdev_device_=
driver` on initialization.
> +        unsafe {
> +            (*sdrv.get()).driver.name =3D name.as_char_ptr();
> +            (*sdrv.get()).probe =3D Some(Self::probe_callback);
> +            (*sdrv.get()).remove =3D Some(Self::remove_callback);
> +            (*sdrv.get()).driver.of_match_table =3D of_table;
> +            (*sdrv.get()).driver.acpi_match_table =3D acpi_table;
> +        }
> +
> +        // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
> +        to_result(unsafe { bindings::__serdev_device_driver_register(sdr=
v.get(), module.0) })
> +    }
> +
> +    unsafe fn unregister(sdrv: &Opaque<Self::DriverType>) {
> +        // SAFETY: `sdrv` is guaranteed to be a valid `DriverType`.
> +        unsafe { bindings::serdev_device_driver_unregister(sdrv.get()) }=
;
> +    }
> +}
> +
> +#[doc(hidden)]
> +#[pin_data(PinnedDrop)]
> +pub struct PrivateData<'bound, T: Driver> {
> +    sdev: &'bound Device<device::Bound>,
> +    #[pin]
> +    driver: UnsafeCell<MaybeUninit<T::Data<'bound>>>,
> +    open: UnsafeCell<bool>,
> +    #[pin]
> +    active: Mutex<bool>,
> +}
> +
> +#[pinned_drop]
> +impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let mut active =3D self.active.lock();
> +        if *active {
> +            // SAFETY:
> +            // - We have exclusive access to `self.driver`.
> +            // - `self.driver` is guaranteed to be initialized.
> +            unsafe { (*self.driver.get()).assume_init_drop() };
> +            *active =3D false;
> +        }
> +        drop(active);
> +
> +        // SAFETY: We have exclusive access to `self.open`.
> +        if unsafe { *self.open.get() } {
> +            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a pointe=
r to a valid
> +            // `struct serdev_device`.
> +            unsafe { bindings::serdev_device_close(self.sdev.as_raw()) }=
;
> +        }
> +    }
> +}
> +
> +impl<T: Driver> Adapter<T> {
> +    const OPS: &'static bindings::serdev_device_ops =3D &bindings::serde=
v_device_ops {
> +        receive_buf: if T::HAS_RECEIVE {
> +            Some(Self::receive_buf_callback)
> +        } else {
> +            None
> +        },
> +        write_wakeup: Some(bindings::serdev_device_write_wakeup),
> +    };
> +
> +    extern "C" fn probe_callback(sdev: *mut bindings::serdev_device) -> =
kernel::ffi::c_int {
> +        // SAFETY: The serial device bus only ever calls the probe callb=
ack with a valid pointer to
> +        // a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `probe_callbac=
k()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> +        let info =3D <Self as driver::Adapter>::id_info(sdev.as_ref());
> +
> +        from_result(|| {
> +            sdev.as_ref().set_drvdata(try_pin_init!(PrivateData::<T> {
> +                sdev: &**sdev,
> +                driver: MaybeUninit::<T::Data<'_>>::zeroed().into(),
> +                open: false.into(),
> +                active <- new_mutex!(false),
> +            }))?;
> +            // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
> +            let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::=
<PrivateData<'_, T>>() };
> +            let private_data =3D ScopeGuard::new_with_data(private_data,=
 |_| {
> +                // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
> +                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData=
<'_, T>>() });
> +            });
> +            let mut active =3D private_data.active.lock();

What's this for? This gives me a strong vibe that something is off. Either =
the
serdev subsystem is not having sufficient synchronization or there is an
abstraction issue.

Either way, you really should have more comments about what this active mut=
ex is
for and why it is needed.

> +
> +            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid point=
er to `serdev_device`.
> +            unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(=
), Self::OPS) };
> +
> +            // SAFETY: The serial device bus only ever calls the probe c=
allback with a valid pointer
> +            // to a `serdev_device`.
> +            to_result(unsafe { bindings::serdev_device_open(sdev.as_raw(=
)) })?;
> +
> +            // SAFETY: We have exclusive access to `private_data.open`.
> +            unsafe { *private_data.open.get() =3D true };
> +
> +            let data =3D T::probe(sdev, info);
> +
> +            // SAFETY: We have exclusive access to `private_data.driver`=
.
> +            let driver =3D unsafe { &mut *private_data.driver.get() };
> +            // SAFETY:
> +            // - `driver.as_mut_ptr()` is a valid pointer to uninitializ=
ed data.
> +            // - `private_data.driver` is pinned.
> +            let result =3D unsafe { data.__pinned_init(driver.as_mut_ptr=
()) };
> +
> +            *active =3D result.is_ok();
> +
> +            drop(active);
> +
> +            result.map(|()| {
> +                private_data.dismiss();
> +                0
> +            })
> +        })
> +    }
> +
> +    extern "C" fn remove_callback(sdev: *mut bindings::serdev_device) {
> +        // SAFETY: The serial device bus only ever calls the remove call=
back with a valid pointer
> +        // to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `remove_callba=
ck()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> +
> +        // SAFETY: `remove_callback` is only ever called after a success=
ful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pri=
vateData<'_, T>>() };
> +
> +        // SAFETY: No one has exclusive access to `private_data.driver`.
> +        let data =3D unsafe { &*private_data.driver.get() };
> +        // SAFETY:
> +        // - `private_data.driver` is pinned.
> +        // - `remove_callback` is only ever called after a successful ca=
ll to `probe_callback`,
> +        //   hence it's guaranteed that `private_data.driver` was initia=
lized.
> +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_ref()) };
> +
> +        T::unbind(sdev, data_pinned);
> +    }
> +
> +    extern "C" fn receive_buf_callback(
> +        sdev: *mut bindings::serdev_device,
> +        buf: *const u8,
> +        length: usize,
> +    ) -> usize {
> +        // SAFETY: The serial device bus only ever calls the receive buf=
 callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `receive_buf_c=
allback()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::BoundInternal=
>>() };
> +
> +        // SAFETY: `receive_buf_callback` is only ever called after a su=
ccessful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pri=
vateData<'_, T>>() };
> +        let active =3D private_data.active.lock();
> +
> +        if !*active {
> +            return length;
> +        }
> +
> +        // SAFETY: No one has exclusive access to `private_data.driver`.
> +        let data =3D unsafe { &*private_data.driver.get() };
> +        // SAFETY:
> +        // - `private_data.driver` is pinned.
> +        // - `receive_buf_callback` is only ever called after a successf=
ul call to `probe_callback`,
> +        //   hence it's guaranteed that `private_data.driver` was initia=
lized.
> +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_ref()) };
> +
> +        // SAFETY: `buf` is guaranteed to be non-null and has the size o=
f `length`.
> +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) };
> +
> +        T::receive(sdev, data_pinned, buf)
> +    }
> +}
> +
> +impl<T: Driver> driver::Adapter for Adapter<T> {
> +    type IdInfo =3D T::IdInfo;
> +
> +    fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
> +        T::OF_ID_TABLE
> +    }
> +
> +    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
> +        T::ACPI_ID_TABLE
> +    }
> +}
> +
> +/// Declares a kernel module that exposes a single serial device bus dev=
ice driver.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// kernel::module_serdev_device_driver! {
> +///     type: MyDriver,
> +///     name: "Module name",
> +///     authors: ["Author name"],
> +///     description: "Description",
> +///     license: "GPL v2",
> +/// }
> +/// ```
> +#[macro_export]
> +macro_rules! module_serdev_device_driver {
> +    ($($f:tt)*) =3D> {
> +        $crate::module_driver!(<T>, $crate::serdev::Adapter<T>, { $($f)*=
 });
> +    };
> +}
> +
> +/// The serial device bus device driver trait.
> +///
> +/// Drivers must implement this trait in order to get a serial device bu=
s device driver registered.
> +///
> +/// # Examples
> +///
> +///```
> +/// # use kernel::{
> +///     acpi,
> +///     bindings,
> +///     device::{
> +///         Bound,
> +///         Core, //
> +///     },
> +///     of,
> +///     serdev, //
> +/// };
> +///
> +/// struct MyDriver;
> +///
> +/// kernel::of_device_table!(
> +///     OF_TABLE,
> +///     MODULE_OF_TABLE,
> +///     <MyDriver as serdev::Driver>::IdInfo,
> +///     [
> +///         (of::DeviceId::new(c"test,device"), ())
> +///     ]
> +/// );
> +///
> +/// kernel::acpi_device_table!(
> +///     ACPI_TABLE,
> +///     MODULE_ACPI_TABLE,
> +///     <MyDriver as serdev::Driver>::IdInfo,
> +///     [
> +///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
> +///     ]
> +/// );
> +///
> +/// #[vtable]
> +/// impl serdev::Driver for MyDriver {
> +///     type IdInfo =3D ();
> +///     type Data<'bound> =3D Self;
> +///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(&O=
F_TABLE);
> +///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D Som=
e(&ACPI_TABLE);
> +///
> +///     fn probe<'bound>(
> +///         sdev: &'bound serdev::Device<Core<'_>>,
> +///         _id_info: Option<&'bound Self::IdInfo>,
> +///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +///         sdev.set_baudrate(115200);
> +///         sdev.write_all(b"Hello\n", serdev::Timeout::Max)?;
> +///         Ok(MyDriver)
> +///     }
> +/// }
> +///```
> +#[vtable]
> +pub trait Driver {
> +    /// The type holding driver private data about each device id suppor=
ted by the driver.
> +    // TODO: Use associated_type_defaults once stabilized:
> +    //
> +    // ```
> +    // type IdInfo: 'static =3D ();
> +    // ```
> +    type IdInfo: 'static;
> +
> +    /// The type of the driver's bus device private data.
> +    type Data<'bound>: Send + Sync + 'bound;
> +
> +    /// The table of OF device ids supported by the driver.
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D None;
> +
> +    /// The table of ACPI device ids supported by the driver.
> +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D None;
> +
> +    /// Serial device bus device driver probe.
> +    ///
> +    /// Called when a new serial device bus device is added or discovere=
d.
> +    /// Implementers should attempt to initialize the device here.
> +    fn probe<'bound>(
> +        sdev: &'bound Device<device::Core<'_>>,
> +        id_info: Option<&'bound Self::IdInfo>,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
> +
> +    /// Serial device bus device driver unbind.
> +    ///
> +    /// Called when a [`Device`] is unbound from its bound [`Driver`]. I=
mplementing this callback
> +    /// is optional.
> +    ///
> +    /// This callback serves as a place for drivers to perform teardown =
operations that require a
> +    /// `&Device<Core>` or `&Device<Bound>` reference. For instance.
> +    ///
> +    /// Otherwise, release operations for driver resources should be per=
formed in `Drop`.
> +    fn unbind<'bound>(sdev: &'bound Device<device::Core<'_>>, this: Pin<=
&Self::Data<'bound>>) {
> +        let _ =3D (sdev, this);
> +    }
> +
> +    /// Serial device bus device data receive callback.
> +    ///
> +    /// Called when data got received from device.
> +    ///
> +    /// Returns the number of bytes accepted.
> +    fn receive<'bound>(
> +        sdev: &'bound Device<device::Bound>,
> +        this: Pin<&Self::Data<'bound>>,
> +        data: &[u8],
> +    ) -> usize {
> +        let _ =3D (sdev, this, data);
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +}
> +
> +/// The serial device bus device representation.
> +///
> +/// This structure represents the Rust abstraction for a C `struct serde=
v_device`. The
> +/// implementation abstracts the usage of an already existing C `struct =
serdev_device` within Rust
> +/// code that we get passed from the C side.
> +///
> +/// # Invariants
> +///
> +/// A [`Device`] instance represents a valid `struct serdev_device` crea=
ted by the C portion of
> +/// the kernel.
> +#[repr(transparent)]
> +pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
> +    Opaque<bindings::serdev_device>,
> +    PhantomData<Ctx>,
> +);
> +
> +impl<Ctx: device::DeviceContext> Device<Ctx> {
> +    fn as_raw(&self) -> *mut bindings::serdev_device {
> +        self.0.get()
> +    }

This and many other functions should be `#[inline]`. I am surprised that Sa=
shiko
didn't point out.

Best,
Gary
