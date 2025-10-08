Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE0320010A;
	Wed,  8 Oct 2025 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951322; cv=fail; b=BOo6tGhZCtlIxV8bfVne1zdMi2rgyBFB5MpMVm37ZUlXK042kqKbFpmJL3QK1yDEH8X2xk3KW41d4mf34G+5GqWMDTFjwG2leaQxb2ZJPTb+aaozcQ+hfb1oguHSh8rGfGi+7NqOwdwHpI3wNV/YjOUHoud1SEYVgxNfaBN5hvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951322; c=relaxed/simple;
	bh=zoO3/e5wv5f2+nMDCsyiyc3PHA6tOVV60lL3rE3Mae8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KaOtU2kP9d+IZvQMqQRO1mfMgfI8kOrwUnRic8Dwbkn3iiB0/S1lFEIbskR9U0i9Nuuz1l/F2VVe2/sXYvOMVIeCFKBgHFuwvcX0vpq2cf4CqCIiHWpBfS34LQlddWC2Kth0EXOT3/nZN+b3EWpPuVJAoTEtZK2HeQGCHIS+0m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YJ95LX4P; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YJ95LX4P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNvMIYJZsa0xRPxp89QEvb3017uhSouP/UooOE3foa/ZD/Dy72d2D42Pn4pKKQpmjeGOhk21VM7Gc+AB5/hpwqMunsyH7X3/JQwgC/gKA/SwadvGxHvFyJz/DWSHZwXfQzM7YD87f8z4UgROYzVROC9fL0p1b3hTF8cPm6TO74TLMFwVIaVY0sPvZdt1NUhHieVMqa/ahbQoGtYXdAMgC7Kf7Wh92npmCz2FpRqVAWqLPQ9ukEnI7otP19cgiXZPkmV5j5ZjFVV823c8Fw+NWPLdYamiUMH2jk9qswfB5vehdk0ByPbg1+Ukyrq7/UlmeOACtdirgSAJQpgpromL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+FwegbfKEWDmzPlMgFGlE3v7y2v2CHElOaMtGigU08=;
 b=OtQ/80gi9lMAfpwOQS4Vc0VuCgwfxazuQj254uqp8vV1VjLjOsoAxjf2ZO4UvymyxCB6umXlHCR0+V9dzhB2j0EDeMav734gHmPuqvTNYoN2D4zZoBkTdfRrVxvapLgjSQ/migyTvlLJXlGz+7KxZg2V0RI79a5WWYoc1CJLq28+0Kz5st4K4XpxIDuDZmj1D1qdnQ/58YiafpmVyngBGTPIaRglyO0MSO2/mRXuD+3ghgGT8tb+9t4FdSRaPVYaKDxJKR1BRaZPVyUnG3RXpGUAq/l6BmG+hWzXEuKJv+s2FUml2FatfpETc/mL+P4P/GEWGfMsvRUPBKxcXftXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+FwegbfKEWDmzPlMgFGlE3v7y2v2CHElOaMtGigU08=;
 b=YJ95LX4PO5I6byt++vYu/dV1sh3dmMdYAMdqYK23IjpkjbtbLC8ce502QO9tySfIVFuyfNZbsQQ5J3erP6Op9AH1LC9r3Ayk6Fyrn8OUupb2WdFBUtn5hTirIy1eoU4BehRcUIozNMiAn1emcxJHGO+FdZ2ld/sqvTKY/pRcc+FXzW3rZ5HaDBmzCYNIJEk4jBgKJehK/LZSR7ihiPFt4DOHAo0As3z43N/3M98Pu4xiEXlBcWhAdlynpTXluYlgLTZOL4mrOd+gNZQPH4JvKkEq1yqEMyJkp8easnZyaCbYUo30Vv9fTZw5ipIU1ezCdXG9C1eZrTX9kfWIaux0Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 19:21:56 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 19:21:56 +0000
Message-ID: <92b787f4-1f51-4974-9e58-231dddd4b8f2@nvidia.com>
Date: Wed, 8 Oct 2025 20:21:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
To: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Reding <treding@nvidia.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
 <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
 <84a521pets.fsf@jogness.linutronix.de>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <84a521pets.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0408.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f59771-4823-466d-4651-08de069ff1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDd4WGI0ZVVVZnlEZGdxOGlVM1hMcDhEOHQyWjY5MHgvTFB4TmtSelh3UHF1?=
 =?utf-8?B?UFR3MVZYNjlRT0tnRzJvSUxuOUU1U0E4RU5KOG10RVJPN3FvV0ZiTmRkOVUy?=
 =?utf-8?B?WVFtZnVqTC8zRVJtWmdMKzh6MkQxeVpuajFRQmhpR0wvQ09lTElQVk1pcms3?=
 =?utf-8?B?WnQ0VmE5eWliazVXUWQybUNIS25WSkNuN0lVeUtnMTNCNzFXTHB1YnZQRldI?=
 =?utf-8?B?QkFUbXVBNEVvUitCSlAxUTVQbzBndllOSDlGV0tpVjNxMm96bkI2RE1XOWgz?=
 =?utf-8?B?d3BSeFgyY283M1lVeVdnK3podzk4VUlIa2JuUVkvd0lGVVRJd3JONWJjOFpp?=
 =?utf-8?B?eDVnYmVKeUpXcXJ0eEdJdnJGZTdmanVZTDRLenF1MWhWMXJtc3IrdUl6U3hw?=
 =?utf-8?B?WHlDVHBTS293L2lURS9RTUFXQ3l6aHhRYUJyd0I1L1JSRGZTODVXeTk1S1hX?=
 =?utf-8?B?SnM5L3M2cWtlWVdtdG5EOUxQY1gxaTNxVXA3ejFxSEF6SitYWTh1VnpsaDFa?=
 =?utf-8?B?WkVTZ1VRUG5jYUxYU3JoTjFMREU3Z2hBcWhnZzcwTk5tZGQyZzZITkNKdUt0?=
 =?utf-8?B?M3ZXeWc4MWJFTnZQVmpHQkxzSUd5VmpQSzRvdHdXeWlOekhURGpJVko0WjY3?=
 =?utf-8?B?a2U4dUtSeGJiZXFRazRCYkdqZDdZT0JUaUNHaE1uQ3RYSUJKR2ZqRmpJNHNN?=
 =?utf-8?B?bEFaVHMxa1duSG9BVU85VUE2SndVOENndUN1VTNQdHdmUnFaZG1IYWRCZ1M4?=
 =?utf-8?B?UVVtanErb2cyelo4Mmh0Ylk4Rko4VVc3SDZmUTJCaEh1aENORlpkcjdHMVhJ?=
 =?utf-8?B?Yk5RbkY0SDFrT1JmQ3BCUThoV2NUYXFjWjNhR0FaOXk4SkN0RkRmWGtjUnhn?=
 =?utf-8?B?dGFWYU9VWHNodmdSWU1MU0V2b1luLzRaOXpEZDB6Vi94U255Tm5lM2VidjI0?=
 =?utf-8?B?SVJOWURZRmU4YmNQWVc0SUQvcEhGUEZDMmpvQVZGbUIwaUxHeVg4djJMb2Fl?=
 =?utf-8?B?bm83em9JWm1UUGs5V1AwNnlIV285bFVpT1V4enQwSG11MDEvcDF3S0I2VC9v?=
 =?utf-8?B?Q0tmZnN0WitlY0ZEbnU2SWt3YXNMNDF0S1A4S0hFa1N0d0l5M25qMDVtZnRE?=
 =?utf-8?B?M2RyUXlSOTVOWmlYL1VISVJxVi90RjlMaDhmVFhNWVJOMVkreTFqUVlqOWtZ?=
 =?utf-8?B?VlltckFmQktqZ3A4NzZpSEpUQjBaNmdPdjNpM0dlVVdBOWc2MlJkbXVtbVVB?=
 =?utf-8?B?NzVtaDV1RXAwa0RJQzQxV3crL3owYzZZN2s3Y1JFODFzRFh0NmNaK2VJdW1W?=
 =?utf-8?B?dVkxN2RsSlVKRy95bys5MjNJejBBR2pISFVUbXpoSkd4amNqc1RoOGtPbyt0?=
 =?utf-8?B?aGZmRTUvUnJNbk53K0xVOURGUkU0RWNONlVlU3RjeVR4TEorVnpyaDhFWlFi?=
 =?utf-8?B?YzNUVmc0clFkVnUzNmErYWVhM3VzSkMzTXhOVm8yVDhoVkI5WmVKWTZOT0lS?=
 =?utf-8?B?b29QR2NNUU1yNVBqS2wvbnZtOVdnQ3ROOTRkZEpRdUtobncrUEZ0cm9PbjV4?=
 =?utf-8?B?L1hsUWhNODJieW9ua08ySEVWc0Y0OXpZY2RCRDNERDhHcU1aK2tUaFFtSDVj?=
 =?utf-8?B?RTB4KzhJRGp5WklLQnI5RTNqVktmcm1rMElSbTRKMG1Rd1dqQkJLWkRuYW5m?=
 =?utf-8?B?Q2RFL0ZsNEE5SXlRWmR5SW15NEpNODlIK1E2Y2hoU2o3SEowbnYvdEhEUVFK?=
 =?utf-8?B?a05mbDF0MXloajd3cElsTmZHaVZPa2Ruemp4Mlc2a2xkLzN2T0FFMTZTclQ1?=
 =?utf-8?B?NENHVUo0QjBHNGhseG5WbnpMUC9mMXpQQXRrOW5xdFNpOGZJaHZkKzlyVjZD?=
 =?utf-8?B?bXZ2SlV4S2Y2NEFUdTg5dVlPaFVRNHVwV040M2xoK1dvVVNBV0JFWG5sOGFM?=
 =?utf-8?Q?mqGBIff8ekHU4otyeX4N6JXEMPoja8a6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3Z1UDVJdUJzbFVFU0l5dXhYV1V5N0RsRTkxOWtWb0w1Yk5SM1BsMzNMRVVW?=
 =?utf-8?B?d1pmbjV1NUY4eEZ4ZHhuemRMRnQzQ0F1b21CcngzcDZldXFwSko5Y2lBaFZt?=
 =?utf-8?B?cnVvejlPSWlzMjgyWEMrbHZkSXM1S2xGVGtSMGZBNStsTURBZ0x4MWJxQUNq?=
 =?utf-8?B?SzBZQkFJVmljRlA5akdEdmlKMFpFZVBxL0c3T1laeDVVZVlSVGN3Y0hzcUdh?=
 =?utf-8?B?aVloRWwxWk5LUW1kaFgwQ3ZSd0paSWRjaXdMbEVJQ0kycS9MdkE0Z1gwV05V?=
 =?utf-8?B?SFBqdUdxaStEM3dzL0kwSnJIelhCL1hJLzJ6OW83bDBXMytWSmRVQ01wdGZ6?=
 =?utf-8?B?SWZDeWhiZlh0VVdrZmNnSDhvTVRUdnBuenM0Q0ZaMkdpQ1RmUHc0eE0vNnhE?=
 =?utf-8?B?QzVGMFNuZ2dsSUk2dUs2VFVVNE9zUXlkdE10WHF6ckVmSlpGd2FKQm9NZDNI?=
 =?utf-8?B?M21DSG1yd1ZrdnovUlRucUtWY3lWMmVIZUpkbmsxLzJPdUkvRDR5WlJ6UzNh?=
 =?utf-8?B?TngxTmdtZjNOTDlsVDE0WmdObTN5R3JYdjllM0V4SC8rWnhGcVFPZkpJa0U1?=
 =?utf-8?B?ckJZeWEzd2psdVFGekdYRW5lNllJM1ZjRVlMNHd6RUZjQjRjUFdyb1NGR2d0?=
 =?utf-8?B?UDRqSStLOVNxK0tsR08wWTVPbC8yMkUvbmM5a2FialJLM01FRVJqMXFjLzFL?=
 =?utf-8?B?bXkvS0FvZk12MXJqMkxOT2ppTmorMFhGWDVTZ2JSYUlkbHFYS1ZCVU1DTHVY?=
 =?utf-8?B?N0hFMi9wd3NuUXFzM1ovSUdFTzZid2hKSnVXZFNYcjdXR2FMYXBZVDJDQ3U1?=
 =?utf-8?B?NU9jVEl1U2hpNytlL3p2b2xRaDJUOEdNckhSQXFROGEyR3NFNGh0cnA1WnQ1?=
 =?utf-8?B?dUtWa01xdUU1dVI4L1JjMFZRUlBXMDNHaDI1QTlORTRUcmg3TklKZGxscm1r?=
 =?utf-8?B?bHpJa2dmeXNtMXhKc0M0OUdET1RMUEFzRHNpR3JtNWlKd3pWNWUxcklYQzVE?=
 =?utf-8?B?eE9WYUIvcUw3WTNUZ3ovekhwcmZTbHhmMVB3Nlo0bGcvSFRUaFNZelJlSFIv?=
 =?utf-8?B?RE9lL0xob2ZmWENVc1FmMGZQT3dHVjdyV2EySUVVd3dlMEdSNnUrWE5OSjJk?=
 =?utf-8?B?T3k5YjlNN2pUTFZxRzJsMnYwMTlEWW54d0hPQUpCdFdFUldkYVpRRUlaSWxH?=
 =?utf-8?B?WWhESVQzclBoUXZZK2QyTkhrTlUyeSs4RmdlWWZLazJxTDhWSVg0WElqV0tP?=
 =?utf-8?B?OE1YV1NWM0xveThXNzBta0R3UGFOT0tPa3AvQVFjckRaSmsrYTIvSDZVR2VG?=
 =?utf-8?B?RzBJMzhZOE8xR1ovVEh6MzgybjNVeGtDUE9hdzRyK1lpaXp4YVhzK3Nlbjdh?=
 =?utf-8?B?aWxlUm4xV3RrdEh4MXR3QkNieTlialJxU1VUWnIwMUxHZ1ljSHpSVkZiVzVH?=
 =?utf-8?B?bHcvcWVaNEZEMXJVSzNnRTFacUZMRWF3V0YzVnAxS0kxckU4c2ZqVjVxM1dJ?=
 =?utf-8?B?WE9YQS9Cay94L0szYzVJSmVMcUlaZVpnd28zVXNDckc3UTRCVzZOVHIxVFZL?=
 =?utf-8?B?cEhHTmxvdDdaNDNkQ2lINEQ2b056RUhWOWVqZVhoYWl3YjhvK0FRRlpNUUw0?=
 =?utf-8?B?TExkNlpad2k0Wm1lS0IvcjNRMEZCdmlzcjh5VUsrczRncmhzS3JMSDlmSE81?=
 =?utf-8?B?c1FVUDNLQTF5enluMzJmYTI4OHdHdHhYS1FkejFLQjBzc3FCa3VzU2FCcmZC?=
 =?utf-8?B?dWl2Q3AvczdpTDFTTHNZT3pqMFNPTFJuTm5md0FwQTF4UVJnNGJpa2wvQWhv?=
 =?utf-8?B?RmxQRXJmUkdGMUFGVEhDdyt5TzJpY1g4Q2dncHAxNDZ3cyt3RkNCaE5BQ2Ir?=
 =?utf-8?B?cTNWWTFTOHR0YllJSHc5cnlUVUUwZllSdDMxUFQ0T24xS3JZZlBUT01PaUNt?=
 =?utf-8?B?bDJRQU5LSU1teS8rWE4zY1FqR2xtRXBnVVk2TG1DRThma1grdG9xbTFsb09y?=
 =?utf-8?B?cEdzQW10ekxmd2dFNmw5dXhkQXIrbzAzRDV0T3ZCTk5wbjdySGFPSU55N3ho?=
 =?utf-8?B?QkpVcVBXT1BLN2hsY0Q3SytCalYvczhKUzFySHI2NjZWclA4OG55U1N3aVBa?=
 =?utf-8?B?blJqZDFuTzNvMElDSjBXUnU0SFE0WDlpYit0Tys2SytFcEdKSEtuWVZncjZ4?=
 =?utf-8?Q?Aj5EYKAk2PcA5tg2XUNy0HmKpMxUwepmHSlyQ41rCI+I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f59771-4823-466d-4651-08de069ff1ce
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:21:56.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWHkQUbX0fVSmlOZknwS5U1y4T8At0GzKyb+GOQP1sYlLomK4WA6zrITQ+1gTTo6xDJo7tSEnOQkHGehaiB4gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

Hi John,

On 08/10/2025 16:56, John Ogness wrote:
> Hi Jon,
> 
> On 2025-01-15, Jon Hunter <jonathanh@nvidia.com> wrote:
>> I have noticed a suspend regression on -next for some of our 32-bit
>> Tegra (ARM) devices (Tegra20, Tegra30 and Tegra124). Bisect is pointing
>> to this commit and reverting this on top of -next (along with reverting
>> "serial: 8250: Revert "drop lockdep annotation from
>> serial8250_clear_IER()") fixes the issue. So far I have not dug in any
>> further. Unfortunately, I don't have any logs to see if there is some
>> crash or something happening but I will see if there is any more info I
>> can get.
> 
> I have been looking into reproducing this using other 8250/ARM boards
> (BeagleBone Black and Phytec WEGA). Unfortunately it is just showing me
> all kinds of other brokenness (in mainline) and essentially making it
> impossible to confirm that I am seeing what you are seeing, since
> suspend/resume is randomly dying without my 8250-nbcon patch.
> 
> Before I start spending weeks investigating/fixing most likely totally
> unrelated PM or BSP issues, is it possible that I could receive one of
> the boards you mentioned so that I can reproduce and debug the actual
> problem you are reporting? If this is possible, feel free to take this
> conversation offline so that we can discuss delivery details. Thanks!

These boards are really old now and so I don't really have any that we 
can ship. It would be great to get this change merged as I see that it 
is needed for RT support. I could see if I can resurrect a Tegra124 
Jetson TK1 and test again on that to see if we can get some logs.

Thierry, do you have a Tegra124 Jetson TK1 handy to test this change on?

Jon

-- 
nvpublic

