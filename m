Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421C19AD5C;
	Thu,  4 Dec 2025 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764827233; cv=fail; b=AB+ym7DfFaTovEEujP3Xtw9qTOjc9YvCUjJ71+AIB2s2oy3rnV51pe8pexaA3kR06pJQMa/KxHx/+wlBSuaGKEyQ9T4jfmqKM+cmlQ786/dmgn9XMct6xF59GTOj/F8ymtrh1l1o3w3lSUFZnsJjtd5BhHwRvYjnKRDpNhh+OAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764827233; c=relaxed/simple;
	bh=cpdhLl2teT+pH0H071JzxCMS7n/zJ08dEJ9vJjlltlA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xkh5OBF7s/r0Bp6zgVp1kDXYpe8gMqo8r2UTFiDiqrUdDZP1eHXmr+TFxMZpDh9MO4s5RUZNL9QqEMMEUFt6XKXJxlep7wrExesiSY4x0Pikxw3C4UNVjnDr7BZtksjw6objxOz9vgd6Tb2r2MFL8y6WJI3rZz+yTxpUZ0mYmag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yc4HN8c9; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yc4HN8c9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764827232; x=1796363232;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=cpdhLl2teT+pH0H071JzxCMS7n/zJ08dEJ9vJjlltlA=;
  b=Yc4HN8c9wULkk+R6sSq2vMyrOS3GHgAiLVss3GbhMnP9foAkoLI0WLvO
   E+HW9iNx4rwmjWkHbIJ+7hRqMyHBEeNzLt/S/K2yS+AfwyFdUCd0jIrpl
   caL02avmRzJ4GFyBhzlztxoi66kR1B3rTUs3oibMe5Ytlg09L0JkR095q
   IHGyEvsIOk5RPpNGsaAcBQZPW3u1Mk2wf28ZePuIVdUsYAR546QJyhKGc
   Y5q94RATA5X+PVUfXiE3YpojROuDBel4n/IgKBfTe8+yyu1sW5/PopM7h
   68KnX0Wrb9N7hngJalLfrdXZY8fC38ksGviZ3PENYtU/3nMu9VhzWfgL3
   w==;
X-CSE-ConnectionGUID: Y1eAJzVAS52fzZ8/XCcrSQ==
X-CSE-MsgGUID: jyJ/Qk0vTYWWT/w+/AnA6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="92316638"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="92316638"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 21:47:11 -0800
X-CSE-ConnectionGUID: SrX1rD7oShSUWDjJtz37GQ==
X-CSE-MsgGUID: wy7pgaY1SSKZ1lGdul5dxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
   d="scan'208";a="194998730"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 21:47:11 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 21:47:10 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 21:47:10 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 21:47:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uC2+M47kqxnbVl9PfpJM8aqujUh6UjlyA4OvGUahj6fKxjeM0GDIE9PUopBm5aR/otmHt24B2N1SqeYizwFN3a/XIrZoN8KvCcB692EzoLot2Sxap7ToD8a83YpT3MGb16QoWSwVnZojeS/5FwsAvwXFwkorcRJC5Mtpia7S6H2bAaf6mS3iIqPuQzxk2n3KtzLmToOQCt/dKQutDd4cZ0VWGbMX0NytbTofdKAVh7fYFhtNSYvsG4IA8LZbZs4Y6yFlkXuo9LS4gNdO0U+W7bPTFFf3Sv7Xorg5qz7dJt/RLhF3Z1q4nkCS/W2ueHCbNQCP4owm8mdDo5b6yjPm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpYbZ8nd0nNMWpkv7PCpVfOyKLS16FYh3rMR6PfK7Yc=;
 b=ATr9Wh54zVDFC6NxPu1WBY3dNo/oGYfYiCq12KjacZjT4+waU3sjmsA+6Bhqz2QlelR/R42oXt0ufcZpm1O9ZHHsZhjgHBx/eBUR/+SUS7w+Kn9aJysVks3H/hzzqNCLcwpk7ZaXu4ApcBCt7e29dxaXYFty/0DK5V+JLA7IpXpTJRdq5xVJ8nXIVlH1U8fJ4JDt29Jxnj2R/I1YUWXzvAtqFM01Fxh8EIEY4hE0hPIu9q4TOMh2dvsBR4A3GNxbX7NQeVP8mjqzATE3hzNEPQglORdItoTgNeEO97/2SCWg3cBItlNVRlIqWRRhKwX4NS7aS4S4Q2aSc2yGmnVCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4627.namprd11.prod.outlook.com (2603:10b6:5:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 05:47:07 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 05:47:07 +0000
Date: Thu, 4 Dec 2025 13:46:56 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xin Zhao <jackzxcui1989@163.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <tj@kernel.org>, <hch@infradead.org>,
	<jackzxcui1989@163.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v4] tty: tty_port: add workqueue to flip tty buffer
Message-ID: <202512041303.7192024b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251128181048.429570-1-jackzxcui1989@163.com>
X-ClientProxiedBy: KU2P306CA0057.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4627:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da5a402-940a-4e5d-d85c-08de32f88f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VkKasyRXsqx5Dgeuh/mO7+PfgmNpMHpBXtJmTxDplfVlpFzrVOEhLw76RJ8p?=
 =?us-ascii?Q?V8uwH1hC61nCyk+BwELA8oVfsPwQeekRdG1Lts1Wq5KMaSeDZhFRtcVBNTft?=
 =?us-ascii?Q?wBTDMEFxhiXThsnbSt0QQq6fp0Jt3RbNFGg/urfOQlcIcsjnGQPmKzTdcuhC?=
 =?us-ascii?Q?v+gmyOUdK9rtwrdviLugRiHU2lUUYu06ANSZsX28UCuh0/y4YUBL4j5N8MHm?=
 =?us-ascii?Q?AB1UVNWiOdvJnVNXw3Z+aJiK3DXJXBwYMMn0lAm5GEi4gWO4zo257/tY063I?=
 =?us-ascii?Q?40bGev8sw9LlzMtaBSxctkMRTRKDEATc+dGg8ZjZphB9arIuJ7JOxAQukexL?=
 =?us-ascii?Q?Z7ZrWRreby8jkZ/XSAViednkCdWyMQo5koOlXUM1iR/Okz0KD0HDfOVhKZ/c?=
 =?us-ascii?Q?WNcZEF2evKKIG8SUPfCuU0/1RwTFSpl6A9owrbfWxfp+WHFmKaPSI0qP99n+?=
 =?us-ascii?Q?vC5iVCIMSX8onwJ7AWE+ZJcqZ84B4qZlh6hN9x/iiOvYbzCdswo1SXtrPKN+?=
 =?us-ascii?Q?P+9/hHYn3HbYWkSJXvhkuLpwp7C+du7R+3xA18nBworkli/oBV0PriTtplhs?=
 =?us-ascii?Q?w887281d5PFnd332M7C/p+jTmRDenEgOVuwUXjckXwEK91fl3Ip0NEB6DQlH?=
 =?us-ascii?Q?8DNbjpMJb9nGkBSfFc6VCZUuiSHZn7OSk37gYT3Plg//xWqlJeZtEcjEj2XM?=
 =?us-ascii?Q?IHh9Gj0LlbdwdoTQefImGq9vGNipGt+Bb93WpUp+nUCJd8Unvf2hbUYhsnsR?=
 =?us-ascii?Q?KvRltpm7WNH5MaPSUW9Q7X/zn4/xwCXm9/D0GlXzFJIJ5Nc9ofJ0RT9MuX+K?=
 =?us-ascii?Q?xA+xa435WzfBHuJpVQUlgeU6dfc56B3hGIizoY4AasJYkP2CWmQPcv/97Zwc?=
 =?us-ascii?Q?s+Lc2+L9fcoFyuXyodzl3U42Fhdq9eeMbQqBmfMOJjGoFwvYFnqPvCHSsXcw?=
 =?us-ascii?Q?ViQu9sX2ehniqA8LkdM8VmKFGUlAnJ2upOiKHn2C32tjrg6OnEldZb8NojYT?=
 =?us-ascii?Q?QKl4XgAmsVXVuqz4rNC7zREOFT/2VgzK35sHADvko8jQooVL7HuPqZz4OPzg?=
 =?us-ascii?Q?MXo8bV1Sc8KqDzLOq/5saZ3uV5rZF04J+voLurGA1YwdNW+0jwem0LZh4tn/?=
 =?us-ascii?Q?7iWAsiXe1AiJnhEmpsvaYfObDNImIhTrg1Q+4CimvUup5um0MRFYRGpIpmpg?=
 =?us-ascii?Q?dWJFS6VmG9FnOaCqN/iJOMbiNVFReu4Bjz3PH6RMdgo5l3t1xbkuQ0spTmFL?=
 =?us-ascii?Q?Km/wLOP60q51eHCDzCOJTGLYUQdLrA8zs5lxtkTY6I5tHFw2A8kXwrAR4Uxm?=
 =?us-ascii?Q?W5FJXELbXjYv3jcXVJ+gOldK4piA1tAQ0GKMMMSFcV0lDUxuMD//LTFYbc2v?=
 =?us-ascii?Q?KAJL+DaVUFgkYp32mRImNWbpiWaBTjRFmgAhPH9ksh+a1K0Bn1L9G0UsE6IP?=
 =?us-ascii?Q?J3m02Bs0d4lGwgXswA/Cz+TWiKljMpgteEK4uvzlDa/DmZ9eLdKbJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1kBdAV0F4ppF1O3xG9MUm/pOnfWQJP7Bz4lvOySUYa0lZpDJ7oPma4Jf2QzK?=
 =?us-ascii?Q?BgWXr/GcF7ioZ5Rc0H+4ucQ8KbS3ix1l52XgO98IKXgA518tKeDOeaZR21DZ?=
 =?us-ascii?Q?a2ljt2FTWuK+2OjZKpbaYWRbXoauU+toM44T3li8PYiSZeMHgQtHa6Ste6OW?=
 =?us-ascii?Q?L3LU8/9KGcYBCM/y3UHLT4FY6+CFyMlTk6xFCVtfPX0DFyRAjltN1mL5rOjV?=
 =?us-ascii?Q?2azdAtI7ZWdN2Eu/hGpfvMOJjRDHGkStWvGxnHymCCTYti/JpieFY/8VeM3J?=
 =?us-ascii?Q?W3GDIFi+0y4DvPOSKadon62rSPEy2tU3x15a7fpVrR7ZrbW9n1A5MjzNToPg?=
 =?us-ascii?Q?yIER46fJszy9frChnQWkzdVl4xWahttiWwor2ruPwGlqlPQor5qD3tt53Kow?=
 =?us-ascii?Q?bsXhg0h8ioUDZH0VDpevtArUq63cqfSLNBqOoZNgWw2qzopWANeWvoZMUOdq?=
 =?us-ascii?Q?SM4+5pTAK1s7+hGKl2S2VDmK72GoPiDomJRTsWiww1+Hh2fTew8ss+o1io55?=
 =?us-ascii?Q?P9ppHKdxDLSWJh/l/yejocgftPO42EKa4umHZBN1rPsTIZkyfmbtrriMNQiP?=
 =?us-ascii?Q?wJveN8j/461WCuIMGQ5FhxAMxtKtDxi+i0Yz13MRTUpO7TTQ8q1cV4Bhk7X3?=
 =?us-ascii?Q?8i3s5LZKB932S+T80Aubzin6jLBrAMqRc0xV0who2CuCq2ZaHL8SKXt5zmuC?=
 =?us-ascii?Q?Cg7A8+qP9dIj/nPp0gNMfNEOiWXa47R5ZmTiivtEaX7JUI4S2dM2eTvGkL6P?=
 =?us-ascii?Q?v8F6LRgRBFjUubny9duqsSLVZ+cLv8euchBmsyTXVp2HUUDWdeD4sJx5usjE?=
 =?us-ascii?Q?dBnVIDuY4hyo5c/7rh+Y+cdkvR4Nn5/dUUXSy0GtEiOvov0nJ/Gj7hQckrTb?=
 =?us-ascii?Q?VbTtQWWpLBMOz3JFmzrs8lP/1CClDfcuzf2Q8ZjYtfIi2JHDPDg7JPuOq4ef?=
 =?us-ascii?Q?OOlirR6vB6UgwFTsltzfEctF9xpkhwz6tT1Rj1lQ6KR8HcZP92XEi9fvSEPR?=
 =?us-ascii?Q?WZkScfE+9YqlmE3PQzkTyez809B+eM34w8zwnjpxModUO9wnNZhmPgQ6kE4+?=
 =?us-ascii?Q?mrXGl+H5viD/LDt7aPPzRqCWN26Ik72wukHznDztF+9BlBm9WoutWxI60UV2?=
 =?us-ascii?Q?iVMo/8NLX2Tsj60AHX+6X2hAo0s9HUJnMwOBVNjLZYbZ9xeT56TYw8ru+iXw?=
 =?us-ascii?Q?EjafYaR6XxrFyCSWZsSLvZGRYwVXB5pF70YInJvUzPGv/3bb1ZvoRFQd0iFh?=
 =?us-ascii?Q?hpQ31+DuVZZS5x3u0AC+ORinZ4gLvr5nOUIDl/9n/BqR6SiwMBtCqTetMPia?=
 =?us-ascii?Q?WLUFzfBj2scvRmH5O46J3rW9ZvkUr4hGPT+/9E6X2/jwSdCIfvXQBNafGJlj?=
 =?us-ascii?Q?YVX5ZoXi7dxjK/hh9j5z9ecuBxFU6WnyTddDXrTXZclQ3+0RKMV5oFU29IV8?=
 =?us-ascii?Q?myvYw3TPIxPX5FMoqWv20PXTxUsG0RljrOrJgdhAyeau8x/CvlZ1i7gzu/Fo?=
 =?us-ascii?Q?n8rbxaZGp0KGEUllpVUizB0kriTfsfVLlPcfNCPmc8lkpRzRJG23H/GjDFmp?=
 =?us-ascii?Q?Gqo3P74f6FRiNOuGbxmogux9QRLYS6xm28m5gKrNf/GVNOTYKvWUzDJ9ZMnb?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da5a402-940a-4e5d-d85c-08de32f88f5a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 05:47:07.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25mGpHnCxGcNu7K6Gx2oMYhqG/kKWkxD8q5hZFroQerMPxH/eLDK5uSvkuAgs6ZFlNvMHzRr2nC9dGBCn5VSxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4627
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "sysfs:cannot_create_duplicate_filename" on:

commit: 95d87185a8405310cbbe8062ccd7be5ae753eef0 ("[PATCH v4] tty: tty_port: add workqueue to flip tty buffer")
url: https://github.com/intel-lab-lkp/linux/commits/Xin-Zhao/tty-tty_port-add-workqueue-to-flip-tty-buffer/20251129-021405
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-linus
patch link: https://lore.kernel.org/all/20251128181048.429570-1-jackzxcui1989@163.com/
patch subject: [PATCH v4] tty: tty_port: add workqueue to flip tty buffer

in testcase: boot

config: x86_64-randconfig-012-20251129
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------------+------------+------------+
|                                                                               | 2bf95a9bcb | 95d87185a8 |
+-------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                | 12         | 0          |
| boot_failures                                                                 | 0          | 10         |
| sysfs:cannot_create_duplicate_filename                                        | 0          | 10         |
| Kernel_panic-not_syncing:Couldn't_allocate_pty_flip_workqueue                 | 0          | 10         |
+-------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512041303.7192024b-lkp@intel.com


[    4.498402][    T1] fuse: init (API version 7.45)
[    4.502618][    T1] 9p: Installing v9fs 9p2000 file system support
[    4.547788][    T1] Key type asymmetric registered
[    4.552574][    T1] Asymmetric key parser 'x509' registered
[    4.553270][    T1] Asymmetric key parser 'pkcs8' registered
[    5.571435][    T1] sysfs: cannot create duplicate filename '/devices/virtual/workqueue/pty-flip-wq'
[    5.572557][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.18.0-rc3-00003-g95d87185a840 #1 PREEMPT(lazy)
[    5.573895][    T1] Tainted: [T]=RANDSTRUCT
[    5.574362][    T1] Call Trace:
[    5.574719][    T1]  <TASK>
[    5.575036][    T1]  dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:122)
[    5.575523][    T1]  sysfs_warn_dup.cold (kbuild/src/consumer/fs/sysfs/dir.c:32)
[    5.576047][    T1]  sysfs_create_dir_ns (kbuild/src/consumer/fs/sysfs/dir.c:63 (discriminator 1))
[    5.576591][    T1]  ? sysfs_create_mount_point (kbuild/src/consumer/fs/sysfs/dir.c:41)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251204/202512041303.7192024b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

