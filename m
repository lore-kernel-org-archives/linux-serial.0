Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793781242;
	b=2I+wzE9bkWrCKN4vFCdEpWNztcuGMqeFAioxB4KhRILRORVvL5mjjX8KtDe3MGG7fej4
	 O8szRaPA5FQfSy01kjZg4T9Sfxb8CgfWcs+cgpredygGo6EecMExHkGFKF+q5fJYZG+Ji
	 tt75v7QepmzKaI3GWGbgzY+XEDfWrxPFUCk6LYOJyLqTUfINgir25nVx+1AsVp2e2pMqQ
	 gOiWbhFTmifRWAKhgBaFtrigLHLbRdCxcqrM6lIKdJPTNPKzLrthlgJxPTLBNJ9JKnVgS
	 8exyKB4WQZY/P3bqKLz7O1NLK5E3F7WrZZToTnTpKCTIBrOmf/ZA8LIyK+WlaxI9z/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781242;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=aibMGZGbOk/aQTnCetySueMm2VY6qRzvkAWas6OQJsw=;
	b=n5a+PeFcm0VAgubGcrQW33wiGLz06pOr1bQq2iRVovn2zDbEqB8p2i9p6b9gf+t1jTea
	 8kybafIJIUi1mHnp64QZZU4uEPudSi0s6AF+ylqQvvpMWS59ddfZDYMHaFdBNxTCbN/97
	 0D5nB3SVYTZHA6n7X+ynN9o9zKbZGPSgYGEoBzNsnfAwNdW36AXNqvY8PSA3tveNciWP0
	 QtvywvSqJG1n5mVLSKmZZEjcBVXFa0kzEF+eeDB04gg4gV/wsN4v7ddw2AuoRAsVESpn1
	 Gu0ama3TnHAD8pTzArZ7O/bNB5eU5EiSdXKERgiO/8I6GoCYq/DWqt9b0yx8N00NtCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bPaQEYQb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.60
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52775606A31B;
	Wed,  4 Nov 2026 08:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52775606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bPaQEYQb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOG1MV8ZOnrNuIu3BBTETfMtJYswJx9CNY0qtSloPy+OnMUjGPWf0M7XOWNYk4maRUz1PZVH3iHt+HQcRWpUWJ5KpoIfJk2CHtbb8C3DIP7cqMbtbizvxXGNUBd7OoQMyTiSf6NKBeMhEFyB2RKRboyKNhpNQQL7D5kjRotICiV7OsIVdnWBNVe5RR8IZI/C8fd8Gqia2psoBmV7pAnbgfcpXkatCL3RRpcKoqHod/XdQLHLd9hR9+NLSD6t0F8+MwvdPTZtpFsrfWoEabXhwG8pqYA16Qf4KrLx9R1kYt1gDDd1Kw7UQ/rZdm9P7HKytr5+Zwaeb8KsVcgwAdGgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aibMGZGbOk/aQTnCetySueMm2VY6qRzvkAWas6OQJsw=;
 b=cL5JNSW09Z9g5QsUh5p53DF+Zb0I/gOY9c20BPLpNEbsc71JCGzHHGMrJ7KaUtcpHPx1YuwJA+QGs+s16kLruaxMCJnH587HHr0Jc90AtxWyOeSsdFSL4Q72F0rTLmD8Zqz+heGNAVo69o6pI5n5vcxuordeHG2GEYNboVt+wMiG0g61TgWRDMVyGBGaS/6AxIUlkq6EB7Uv6CWZruN4kDAbmpH2sqXlM3X3YWVIhVTHh/j1jHzNFviori9QUvnTnH8FbyRx1cbQ+wsNOm1TmHbP4ECov97Xat1oDtkZMP22Srrxs2u7w7nRdEjPl2XYvSM2XLmYN8/ZnrFRH7Tubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aibMGZGbOk/aQTnCetySueMm2VY6qRzvkAWas6OQJsw=;
 b=bPaQEYQbf5Isgkua0NNBDPiSCYZxnoI5irqzrdDFVBL4WDx7oIqmEooA9Mhys2Jerb6EAQqYpJQ+EVfkoUajEOQz6Kq1YPHvT0+yKFjF2B00jk7XkFQjWHvtOI59h95x56kJrabbSFSTQjR0P7/yW6QtsZbWTz51J7YuKQ5q/g4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS6PR12MB312928.namprd12.prod.outlook.com (2603:10b6:8:532::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 08:33:59 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 08:33:59 +0000
Message-ID: <589aa712-fde3-4f2c-ae07-8c50b8a6ead9@amd.com>
Date: Wed, 4 Nov 2026 09:33:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 01/17] firmware: arm_scmi: Drop the ARM
 architecture dependency
To: gaohan@iscas.ac.cn, Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Samuel Holland <samuel.holland@sifive.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Anup Patel
 <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Drew Fustini <fustini@kernel.org>,
 Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-clk@vger.kernel.org,
 linux-serial@vger.kernel.org, Han Gao <rabenda.cn@gmail.com>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
 <20261103-a210-scmi-v3-1-ee6b31580808@iscas.ac.cn>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20261103-a210-scmi-v3-1-ee6b31580808@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::6) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
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
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS6PR12MB312928:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0c2aff-6de8-4c72-2505-08df3a4e5f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|921020|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261022105027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2pqd1Wl2nWcsQi9TPPgYg973w9Xo5Xx1EMu6uDs/5vZroALLlASXEeoT86leirVT9LCkFDKiBmo/A0io85tGt6g0cDi7vxOFgt3Xi4nVsL5o/POKTS+1QHYnyM94SCniIDA/1/uJQnjStwrlbqdINSp+AcC0kLE+acMLlijlHM5zpYwClR5dTa+8TiHuFTjH9hfXnId1664PAv4WFmMQfNaa8uXE7BqngWHboJRVE8Vovbt+6T1/iswfS8p0g0gbbYkHKCNaPvX9nLE0isWJB3GTUa5P17pO+zvc8JF4Tgj5lwvtHQKFaitJTOghqJuZ0OtxHd8xJjjpEEJ/BSHli4tpoENqI/xcH9fQnxPVzOXGXnw/Ko2+aVkZ4D1FjVvHyt8Oeb9tlCQjOhA1CwHKUgxHofCxM6OEPf3pUpp5I7bAELokLajLMLs+xErSKnmZYcbW1cLgvgivBnGcES4uInZ9SxH0p7+HgKVTv0+7+wdnJxCmLU3xFEl2rDQe7Ree/TyXI1osjZ3W27llov1SM23sQQ6+UY4q6cLoaiENRMJBdubfMlDcGpxoREDsgNEme0pCckA2uwbCSPSQYG52q1FMduqX4a3ayh6I4JnWLYek/XKFtdpQEwhqza11SvmMGqDFF7Ztm5Pv9EUxGLHRGYN3s5YIa2r7hUq/jpwWvq8MwGtablHCzBPgpcSF4NWJr7GUEqYrmBbSrDk2ni9EAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(921020)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCt2VllKZWEzUVgremJRVGlBampyQmJtV0NNYVVnZldyU0piNnM0bGNvSkxm?=
 =?utf-8?B?bzgybFBBdDcxalNDZHdlY3ZTZkhCY3ZxZi8zVjMwa3c4SU8wK1NHVklTVEVo?=
 =?utf-8?B?TXZ1L2NhNVJRS3h6RW00Q25FSnNBWGxoeElGOWhjcHBrd0NJNi81TlQ4dmo4?=
 =?utf-8?B?OWlSbitJSWhnTlZ5QnlURHFhZnFpMktGR1JvdlEwbDF6QkxIUmhieHNBTG5F?=
 =?utf-8?B?bHU4dWFzNzNBbDNRa2VPZVIvcU9FWWdDSHpBaFozSUJLZ0lNTzNWbFNtQm9Z?=
 =?utf-8?B?K2R2bXRZTmxDbHVaZ2NhbDZJZGxuWlBvR2JUeFgyMXlEdnh5aldrRUpkVE81?=
 =?utf-8?B?bVBpMVFxN3EvM3R2eUVCdkpZbDF3eEk3dTl2RHRKdXVUVnBMTUtuZ3hLNGNt?=
 =?utf-8?B?K2x0NnRiYkx2MWpmL0syOWRVQVFFMTV3eWxOaSthcXc1Z050Z0pOak0yWERo?=
 =?utf-8?B?elZwcm02L3VWOWl3VzFGTXdtbUVLRmIxeTlDeG5PVmhESTVRR0wzdzdlYzY4?=
 =?utf-8?B?b25lOC8reVNhZDdlYUZ2VVQrZllLSVNXUVZDSUlTMTF4elB4Yi9sZTFvRHBw?=
 =?utf-8?B?VmxvTThkRExyNFYxb3l4RUFSVGxJdFFnUkU4Ny9JZmZLUkhaV2hLbE9DUFAz?=
 =?utf-8?B?MXVUOHpsRHpCNUNUQ0w4SXE5ZEtSS1pIN0hNdmdWbUtUVk5zdEVqNlpFNm5j?=
 =?utf-8?B?NXFDV2tWSG1XOHRqa2o2aG5oYUh1UmJFa2p5b3VOa0IvRFY5TDlhWTd2alh3?=
 =?utf-8?B?UGh6MDE0OXVLNHdSYjh6eVlYOGVkVzZXY1d6MG1jMTdJMmhveUcyVjExU0VB?=
 =?utf-8?B?UU1adWttNVlFbTg1N3RFTGFrNzFLV3VLbXluTWQzQVZjaUp2ZWdXaEpaZExl?=
 =?utf-8?B?ZXd2bUdDOS85QkpZdDB6Nmk4eENzOGloYWFKTWcwQklaVmtEUXhkbWUzR25T?=
 =?utf-8?B?dUZEYUlhYXBZNlJCVHVKSmpoaE1XRi9XaXZSaFJidFZBMjVYSndFaHUyTWxL?=
 =?utf-8?B?RHBUMmx4VHNLT0xPaEZlM2pjelpYSmo0VUNUMWdOOGlNTzYyVVdFUXAxcUVh?=
 =?utf-8?B?WnBtamtESlF5VHZ3S1Fhb1IyRk92ZTFlQlNEd1B0WEVjb0d0YzF4aTRndVMz?=
 =?utf-8?B?dkxKUzZyaDdLcjZab1hYbktNVy9YeWZWTlJrdGxzNTk2eTFCYVBZdzY1SU1T?=
 =?utf-8?B?dW1TdCtucERGMWdSTEZvWjZOT0dud1AwKytIcFpQaWxERFpjanByNHMvcXZJ?=
 =?utf-8?B?ZTVqQ2tnamFBYTMyOUtwV3Eyd3M3MGN1QnQ4MURyUzBRTTJBTXJrSzFzTzdt?=
 =?utf-8?B?K3RhK2FlczlNekR6cHFkdENrSGZwRzJwSUQzcE5JV01rMDViWWRrc2JHeURs?=
 =?utf-8?B?Q0l5Qjl6NUw1N0pxU0M2TjRvblhsK0d4aXhSZUtrd2h5Y3pCR25wbnlHemtZ?=
 =?utf-8?B?MVNtTkdLVTQ0L3RYSnBndE1HbHRmb2VpY2tTaXVRQURHU003QW5WQ1dQeWVs?=
 =?utf-8?B?dWlnR0JQQ2FkU2NJd2NXMDZ4Mk8vampaMlNFM1FVWWduckQ1aTU0R3hValBn?=
 =?utf-8?B?eGNjNXpwN20rRE5ocitUU3d0bG82a1N2OEQ1UXV1V0dONGNOcGthbXFvbS96?=
 =?utf-8?B?eTgxQzFjZmdJbm9lRlNnYWw0Rjc1dm1YRzRQT1JMWkI4T0F1UjlMdEtjTVZM?=
 =?utf-8?B?S1J0STh3SCtCeTEzWGF4UEpydTQxbjdSWjJwbnQ1N1hSdFRERlF4MURPNFhP?=
 =?utf-8?B?SklvUVFHODd2Y1pVTXJhT0twMkxrQkpqNmdBT1lqei9JREd4U3V5VnZmRWJD?=
 =?utf-8?B?bWUraXZlNHlmSHNZakpvUFhKdmhDaUJKdjZYT0VpdmtwZ3lmL0VYVXpndXJ6?=
 =?utf-8?B?MTh4S2JkcXF2ZjVNdmh2Y1ZPdmhOQUZtUjJ1ODcreGRyY1cwem9WOFZGWSs1?=
 =?utf-8?B?TTczeGZDTHUydlNrYy84WlpnZDJ2SFdzSGxyaXE0VXpCTmhDVjU0VFNONTMv?=
 =?utf-8?B?VzRjLzRxVGl6L2toUWFCTk43T2kwTjc5Nlk3c0l0L3pHQmJCN1VNL1Fxb25Z?=
 =?utf-8?B?dC9RQjJJV09BSXpLRzBWQzZpVmw1dGdpQjRQdjdhUUJnOFI4VStKbGVMVUdr?=
 =?utf-8?B?aDVwNTFkSEZORk5YWjZ6RFR0NFdqSHpQdEF5U0pMOTlxekEyR25tYUVZenRw?=
 =?utf-8?B?VUR4OHZmSWdMZURHQ2V2WjNPQW9hRC9XbmhmaWptaVI3ZVgwUjAxNldtUml4?=
 =?utf-8?B?em51aVBabzN4UUUzOUlHcHptUVdFbnM0clhWanM1V1lIdGovRS83dmJwUzdG?=
 =?utf-8?B?a2FOS1V3OHpWQ3ZzRmJxeE5NY0FDUm03aWRrR0QrT3hTNG14RE1VUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0c2aff-6de8-4c72-2505-08df3a4e5f42
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 08:33:59.1193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAgj7u2nAEAHuzXK2jhqrN+zLR7JSHpkcohq8gk6Soa5L988Vjg8TL5fkGd0Mzd/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB312928



On 11/2/26 20:45, Han Gao via B4 Relay wrote:
> From: Han Gao <gaohan@iscas.ac.cn>
> 
> The SCMI core and the mailbox and shared memory transports only use
> generic kernel interfaces. Transports that need architecture support,
> such as SMC, already carry their own dependencies.
> 
> Drop the ARM and ARM64 dependency so that other architectures can use
> SCMI.
> 
> Suggested-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>   drivers/firmware/arm_scmi/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index 783c24a20e29..b56aed46a387 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -3,7 +3,6 @@ menu "ARM System Control and Management Interface Protocol"
>   
>   config ARM_SCMI_PROTOCOL
>   	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
> -	depends on ARM || ARM64 || COMPILE_TEST
>   	help
>   	  ARM System Control and Management Interface (SCMI) protocol is a
>   	  set of operating system-independent software interfaces that are
> 

I don't think you should be sending it as the part of this series because this 
should go via Sudeep's tree not via riscv tree. It means send it separately.

Thanks,
Michal
