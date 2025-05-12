Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5FF254869;
	Mon, 12 May 2025 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030963; cv=fail; b=ra6N9BxHftjprnvAeQmDwmQkoQHC4dp6XzAmvAmwI4kXR+CuMJjEAkLUlqEivGk1ed9cYzTBOrCLBKTcurPro5/3NLVFrE+yK+kC6WqljphrJiXOgOWj4oakieWMU2dgKZQpHmK8mOd8/J+I6z0tj415du+WhgAG5HuaM0jd5S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030963; c=relaxed/simple;
	bh=3Vz3PkMjsgSHzf20bvowNT5s2sfFMWmRlRXvvQI+xqs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IQeqrZJPOAQxwFxeEUc+64Zk02I8p4SRZrq6AWH/pwMNlz3jxlEIcXHClvOXYMuzf14JzWyYXFFkLATszdfdSpABE3tlAP4gHO9siZr+I7gKOMG5Klfhhok80+vA0V//dsJE52hGQgvcwPPHe9IzOyi2abJfqnJDV2d6Tmvpvfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADjZzcm0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADjZzcm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747030961; x=1778566961;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=3Vz3PkMjsgSHzf20bvowNT5s2sfFMWmRlRXvvQI+xqs=;
  b=ADjZzcm0e08PDjbh7KgX0lmiKeCRScxGhd6TPuT9zOqaNDT8lKqpAxXX
   yPeGTa/YOa0GQ5ovqFH4Wnft5iC79XtmwFoNwko55iw2Ku7WlwmtsdsP/
   5yfXLjqxMBQWEesfpcm6+ksoPLVDPJ6q+C+PcBbpNc7+TPKgTr9NcfoKH
   T/GzWF/ANvnprUvHMAnBa8TklTKHCdRi1xTmTyYKUadvy2+3EmSS/ELXp
   jDMgRTU6K+ZeJm1ExHG0y8KdLer992LcCYurWCsSFeYAs6cl7E+wkEs1d
   anNBAFlEdhNH0DrYDz1OntweDulWWFCH9wWbSFpx3GgqRSsBGzr2lT73T
   Q==;
X-CSE-ConnectionGUID: jkyyin7LQwS3VN38cBjBCw==
X-CSE-MsgGUID: CyQpOfQvR/m7fLks1o2/SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="60154150"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="60154150"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 23:22:40 -0700
X-CSE-ConnectionGUID: FrmbWQfXR0OpsPx8TxYaxw==
X-CSE-MsgGUID: 6MjIIi0rSZOaCTSktDvEDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142232722"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 23:22:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 11 May 2025 23:22:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 11 May 2025 23:22:39 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 11 May 2025 23:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDV0HsQpUb83ZeHBo//aAn1Rgk51klZfWPj4pI7p7kuS8er5IdaEpLRgZT2y0SXNHyAZcmdtsir4JKHSAbdeLkbiDKnO9/lY43V4aTe8boKM52oJenZd0ihHKRxj3XoWJUkZuMRnQ/cHxBODR7srpkfj42yblYE5YSCepEOLNAJf0jMcCyKuozSA4yI9fG3MDK8sYVPIm7aQNerlAPv/D+IZ8AEmzfI6IH9k/hyY/VTkycgm1RyapvCPNv4TyDzIqWC7vL5yKDaSNoDga9qeIlCQoCHakE9s3uwlQcjYGbna9TWTtxu/7dmt0afq0EAaEuw2iD9DkYlfPHYn/L7sFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26ybJf6kf6SfeR3AY876vGUDnyAXnMOI6RZUeYPRQwg=;
 b=KnHzt+gkpOhBKPqXsRWgvPvyMAZPLokVmKuGgHquc7mjhhS0fsPeKu62ah2dd0Vi98jg/oxsYbRVQPaqgNMYR02Fk4X5hnOuY5Imbx2sCrEGYn7XYNtYr0ss1fj8+ltA4FWUUJTCGPUh2ALow6Fwjt34MJjbRhdiB0EZGWjrWrdZhYlX6m4vg3e55bG6gHOI2lemnd0pZZ7jKQnPPCs7Sb5T85vpaadu/7dSfVXkQIX4D7rvbVFMo4XlzbYJvghdWTKWw0X98fq/FavmjYYv0+nHERylPNZKx9VA54mfsiWqtQiyoNAcVLnljVOeCvqYmQKGEauKDGw54m8PbCnefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 06:21:54 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:21:54 +0000
Date: Mon, 12 May 2025 14:21:45 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jeongjun Park <aha310510@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, Jeongjun Park <aha310510@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] n_tty: fix data race in n_tty_poll()
Message-ID: <202505121345.9f8944dc-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250510163828.21963-1-aha310510@gmail.com>
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 05408911-f7e7-43f0-a59a-08dd911d4a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3MyQbFIvb34Dn21G+6cw8m51BrJyIypSSHx1F98uyvOnONsQ3YCxgfkyd8jz?=
 =?us-ascii?Q?Yoishfdu+WnYBCIeYxw2b45Q+salaTxYevRGWLZWeZRyeGN7JW0eXrfX3lEy?=
 =?us-ascii?Q?yfgMOVls8g0O4NhdSUrQVrxV1wUhFeM2sqk6pdM2GA9bqxY/As8nUFWZolQb?=
 =?us-ascii?Q?C5SwrmHtcORus63g8+mTRxEX50MPBp6g76WAZyIYe9NjmbXx3/cxMQh1jpRI?=
 =?us-ascii?Q?+c+PuGL8gMk1NHo0UEjwq82bzn5ajOOth8lude8aOi+SlgS5UYUlQU+DJi4N?=
 =?us-ascii?Q?MBj8ssCRHx5tTncGWZ8v927iF+2cDRIdtH519je2+EKANhYbszcjQxzCOWU1?=
 =?us-ascii?Q?5hmBax0JeGiOd2yVysmzSfiN3NxpDgBy++AWfSCiD40lCXnAfElFg7aplq4B?=
 =?us-ascii?Q?yMWQJcbef5havqERTtC+ZbeqRS1lOTe9gKcs4QyoXPhaQiu7NWl7XyrslNn4?=
 =?us-ascii?Q?E2Y/dLv5Ftr7JW5J6rPzK5okw6mTLHDL7FmXEqBEGE7gruBSjm1czP2QOusy?=
 =?us-ascii?Q?NZ0qMUDc2r3wmC3EJiDbqlbP6zZOEfmgt3o8F8zNKiKeApaVJl3TghA5hMk3?=
 =?us-ascii?Q?7zPA6ESbnnabDRG/6KhHuAt5SCu7NRVfzA4Q0nzZs2RbTMiZVhxuQufcJKGE?=
 =?us-ascii?Q?BlfKvouhADEGpfkHgZ7D+9Akh4zeCsC09S3FECAYzJqDP3/DC/jod5oLXFg7?=
 =?us-ascii?Q?vfA4OyYA+Qv0yPE8hPVf1zTAKLlos3Uew/3XYonI3mfN83g+NEKfeFdzg5Z8?=
 =?us-ascii?Q?nuK21m5GpQtH+c0L7NHfHy9X8nDRiJ1z6PfFvPfxcl/HF4hlFb4s4Nbd0pXW?=
 =?us-ascii?Q?/P4L7L2ZECDWuiwuyWoZZR8Bv+1dAQmlFoZbaw1cWBCNMj5nr3wUJKAqJl5m?=
 =?us-ascii?Q?RRDorKy7UgOfGwWmrqV4ZSKXHmwKTLILS0n5Lt3DHQHx31VyO57d8fG13mIL?=
 =?us-ascii?Q?KCC3Q9qEbsxUw14IexpuEO0USpf7K40UdC9pbH8OGkgSCAeufI2eQ8U4VAoa?=
 =?us-ascii?Q?EB+c4gPX7tQAThjDGR5Cv9i2AL84jCR6wjfnOGuVzNd050tekSwGnJDqtYP/?=
 =?us-ascii?Q?+RnW10Fcw5UESOAQ6jwDA3nxuFhImDcgw2ZBddPa/3AiEaSxdYjMUoO36ryj?=
 =?us-ascii?Q?wNzWsylg0pLKl2wVeCkBDGPeZZJYP7Sr3DMNQR6mkVAAMOPXaHe438ThZxay?=
 =?us-ascii?Q?oFoEu3SFUFkxf/LmxocQq5cF55Ar0T/gL4cCOjpNWY23pqsJ5aViZLBDyZQM?=
 =?us-ascii?Q?g+/V7o0WkljWYfAaovKz08ujeHq5uQHJ2zzRizkKkrcyowEgpbW6OM14l5i0?=
 =?us-ascii?Q?qgQgw6dgo5Zr5KGxLP6uX8B5nRcY/5UnS0ny/L6weg9/eyPEk2tJXDZ8J8X5?=
 =?us-ascii?Q?xyMyaYsyczIEGji+0BK5fVpQVqQC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I3Yu31K8XLwxeW7f/c6xDH8dX06/EdtFMfHruvuetmKcRWt9ubBjpf48ioPs?=
 =?us-ascii?Q?6e9R9V8RFEn8vpkd28MMyYf+mCHRPWDSAdJmaaQp57AGjwXwK5wHV0uc7Sxw?=
 =?us-ascii?Q?PqJw/m2ucgVSMv+qpEVNHErNcG8gbhfJQfrO9q2LpcOICaoC3lWQ0EIqOeu8?=
 =?us-ascii?Q?+eA6/nnllee5W8C6KhlCihJyd+0reLxP8+AOfPyKG77lJowPSPnNODugh43m?=
 =?us-ascii?Q?lTuxDGK6t1oBatBAy5b5Fw2un5S0hbAhsgxl7XJPb75uBFloSyi8zY5L18ya?=
 =?us-ascii?Q?w80d4KQ+aakT9EewbjzaAskFjPY8D0Ajdkm3zDrf4H+ci7HIz428fhjgHRFW?=
 =?us-ascii?Q?LtfqIyLXPJa3Y1I4dmOASFmLaNTa21BemKogRpo1XWXKYK39tsoNh+5Mgg9F?=
 =?us-ascii?Q?D1kjWETjtWJncadNGFus83iB1bMq0FDfEJC4tNqH6IYayA464/f1ahmujK0D?=
 =?us-ascii?Q?xDqUS9dd7w4m8W0bX8bAT4TOE2leBhf0kHyQ8X/I49CriHVHQKpkPWzfcWdu?=
 =?us-ascii?Q?7GmoTjyUvsYDrK4T6gdV2ZNUy+MeNK6RcaQ7S/zD2zh+hXi2wbz3s73ZZBER?=
 =?us-ascii?Q?5dhU3F1iP4OKFCkEU+HL05jnX8o1JWAWzVDeYitBu0eH4keqr1JRjmfS+WRu?=
 =?us-ascii?Q?0qyOED9yjI4XrovV7fKrAeyywQmhrovTN48SrYL8MV39bmh3kHrVfzoiKbSN?=
 =?us-ascii?Q?j1ntewzdy/PiuZ5CwNad356hlAChDZhnjM6nrkX0KA5dSTR9QBxZyYQ1VrRK?=
 =?us-ascii?Q?4H+1ftwUlbZcQSabZ6Khu3gDXLHIGZj9cFETihBksY8hxve8NCo/tKzxbKho?=
 =?us-ascii?Q?WmuyJNTvJIAp61h2zVhJNMq8X0p40ryEe6Zw8gQr7ikkj4PW3azi4yKPHr+C?=
 =?us-ascii?Q?irRFCEZLmpktJRi/0TMbSkJx0iJDOIvC5eDYPOpy1qXyucxrJS2kgv7A4Kk5?=
 =?us-ascii?Q?MqsH4XmaeoFt12iuKvTE2jaRyogB/FmchDCdAxU2a6InHyW6WLHJEvsHc5wd?=
 =?us-ascii?Q?atXR/FEb4VjQW8Cy6F3uFEOaRuqv8UOJaxzulJd7dodG3z1sBN6Irgnj1VP+?=
 =?us-ascii?Q?QMJ/qoI8A01O3RQsKey5vw3BeZ61puyQan86TIf1qSND67U9kvVg/4o82i8t?=
 =?us-ascii?Q?93Orst0TrDCIVLD3j5rNqYAloiKFRX9GJm7nNG8WKn/QuB7lbritdj4KMLmV?=
 =?us-ascii?Q?wnQ7fY5Qh1G6wSuiUnbEkkMTCu/i2O4EnkrN3uTsR98KIWjijb3GjgBxt/RJ?=
 =?us-ascii?Q?QaI3Gc0pL9zIEkGrJlz4h8XGXNNVJ+/RJ9Jz4WGG5CSL5QtWW0qUSd3MzMGx?=
 =?us-ascii?Q?HwMDBkI6a34BuDB+gKbgN6D4QXXzkq3SIJIrAcmc95AGi4/d12WQMaREQ6MJ?=
 =?us-ascii?Q?L0UnSBJFmtntuKcu1s4H7+jXjExvUmyv5nTnv4A3khvh1sb1UA14qtofT5/m?=
 =?us-ascii?Q?x9ngxPPrp0MmbnXu4M7/UhcIyOAdOUPG5MCKybBH+yvOuQ4jOgldJKkKstix?=
 =?us-ascii?Q?+kl1mRzKYRoZ3JAz/FLiwORisBYJgOjvRW1LbyfWQ3o/uCRK3oaQc9SKH2Wt?=
 =?us-ascii?Q?eJbRRERY/1MnG9uHT+TkJAzPVO1R7R2kNNYeK7sSBjVZ+x6cmyL9Eq1oFkg1?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05408911-f7e7-43f0-a59a-08dd911d4a3b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:21:54.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arP1SlKDe2L6yG2ve7MbkyUWt4fk7zr/nzuPxdq3mNQnwgHWbkXRiIMM5Yr9vObjYxKvTTAMGpBmJMclY9dQzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: 6145aac371f6e1aae92b20b04bf6f4e7b3c46657 ("[PATCH] n_tty: fix data race in n_tty_poll()")
url: https://github.com/intel-lab-lkp/linux/commits/Jeongjun-Park/n_tty-fix-data-race-in-n_tty_poll/20250511-004004
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-testing
patch link: https://lore.kernel.org/all/20250510163828.21963-1-aha310510@gmail.com/
patch subject: [PATCH] n_tty: fix data race in n_tty_poll()

in testcase: boot

config: x86_64-randconfig-075-20250511
compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505121345.9f8944dc-lkp@intel.com


[   42.238614][  T205] WARNING: possible circular locking dependency detected
[   42.239002][  T205] 6.15.0-rc4-00081-g6145aac371f6 #1 Tainted: G                T
[   42.239551][  T205] ------------------------------------------------------
[   42.239965][  T205] bootlogd/205 is trying to acquire lock:
[ 42.240305][ T205] ffff88812c1d6428 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: start_flush_work (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:3922 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:4176) 
[   42.240960][  T205]
[   42.240960][  T205] but task is already holding lock:
[ 42.241424][ T205] ffff888185dc0ea8 (&tty->termios_rwsem){++++}-{4:4}, at: n_tty_poll (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/n_tty.c:2454) 
[   42.242126][  T205]
[   42.242126][  T205] which lock already depends on the new lock.
[   42.242126][  T205]
[   42.242789][  T205]
[   42.242789][  T205] the existing dependency chain (in reverse order) is:
[   42.243312][  T205]
[   42.243312][  T205] -> #2 (&tty->termios_rwsem){++++}-{4:4}:
[ 42.243783][ T205] validate_chain (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3286 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3909) 
[ 42.244098][ T205] __lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:5235) 
[ 42.244404][ T205] lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:472 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:5868) 
[ 42.244701][ T205] down_write (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/rwsem.c:1578) 
[ 42.244977][ T205] n_tty_flush_buffer (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/n_tty.c:353) 
[ 42.245369][ T205] tty_buffer_flush (kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/instrumented.h:96 kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/atomic/atomic-instrumented.h:592 kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/tty_buffer.c:243) 
[ 42.245806][ T205] tty_ldisc_flush (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/tty_ldisc.c:389) 
[ 42.246122][ T205] tty_port_close_start (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/tty_port.c:647) 
[ 42.246453][ T205] tty_port_close (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/tty_port.c:698) 
[ 42.246742][ T205] tty_release (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/tty_io.c:1748) 
[ 42.247038][ T205] __fput (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/file_table.c:466) 
[ 42.247308][ T205] fput_close_sync (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/file_table.c:568) 
[ 42.247741][ T205] __do_sys_close (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/open.c:1583) 
[ 42.248156][ T205] do_syscall_64 (kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/entry/syscall_64.c:63 kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/entry/syscall_64.c:94) 
[ 42.248453][ T205] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   42.248829][  T205]
[   42.248829][  T205] -> #1 (&buf->lock){+.+.}-{4:4}:
[ 42.249243][ T205] validate_chain (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3286 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3909) 
[ 42.249545][ T205] __lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:5235) 
[ 42.249834][ T205] lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:472 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:5868) 
[ 42.250121][ T205] __mutex_lock (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/mutex.c:603 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/mutex.c:746) 
[ 42.250402][ T205] flush_to_ldisc (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/tty_buffer.c:470) 
[ 42.250692][ T205] process_one_work (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:3243) 
[ 42.250994][ T205] process_scheduled_works (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:3319) 
[ 42.251317][ T205] worker_thread (kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/list.h:373 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:946 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:3401) 
[ 42.251601][ T205] kthread (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/kthread.c:464) 
[ 42.251859][ T205] ret_from_fork (kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/kernel/process.c:159) 
[ 42.252137][ T205] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   42.252430][  T205]
[   42.252430][  T205] -> #0 ((work_completion)(&buf->work)){+.+.}-{0:0}:
[ 42.252920][ T205] check_noncircular (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:2215) 
[ 42.253211][ T205] check_prev_add (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3167) 
[ 42.253512][ T205] validate_chain (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3286 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3909) 
[ 42.253799][ T205] __lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:5235) 
[ 42.254086][ T205] lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:472 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:5868) 
[ 42.254363][ T205] start_flush_work (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:3923 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:4176) 
[ 42.254660][ T205] __flush_work (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:4208) 
[ 42.254939][ T205] n_tty_poll (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/n_tty.c:2458) 
[ 42.255204][ T205] tty_poll (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/tty_io.c:2199) 
[ 42.255467][ T205] do_select (kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/file.h:62 kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/file.h:83 kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:469 kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:536) 
[ 42.255733][ T205] core_sys_select (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:677) 
[ 42.256025][ T205] kern_select (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:719) 
[ 42.256299][ T205] __x64_sys_select (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:722) 
[ 42.256586][ T205] do_syscall_64 (kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/entry/syscall_64.c:63 kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/entry/syscall_64.c:94) 
[ 42.256861][ T205] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   42.257211][  T205]
[   42.257211][  T205] other info that might help us debug this:
[   42.257211][  T205]
[   42.257768][  T205] Chain exists of:
[   42.257768][  T205]   (work_completion)(&buf->work) --> &buf->lock --> &tty->termios_rwsem
[   42.257768][  T205]
[   42.258538][  T205]  Possible unsafe locking scenario:
[   42.258538][  T205]
[   42.258942][  T205]        CPU0                    CPU1
[   42.259235][  T205]        ----                    ----
[   42.259528][  T205]   rlock(&tty->termios_rwsem);
[   42.259799][  T205]                                lock(&buf->lock);
[   42.260157][  T205]                                lock(&tty->termios_rwsem);
[   42.260556][  T205]   lock((work_completion)(&buf->work));
[   42.260867][  T205]
[   42.260867][  T205]  *** DEADLOCK ***
[   42.260867][  T205]
[   42.261306][  T205] 3 locks held by bootlogd/205:
[ 42.261585][ T205] #0: ffff888185dc0cb0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/tty_ldisc.c:244) 
[ 42.262123][ T205] #1: ffff888185dc0ea8 (&tty->termios_rwsem){++++}-{4:4}, at: n_tty_poll (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/n_tty.c:2454) 
[ 42.262647][ T205] #2: ffffffff851e6d60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/rcupdate.h:331) 
[   42.263222][  T205]
[   42.263222][  T205] stack backtrace:
[   42.263550][  T205] CPU: 0 UID: 0 PID: 205 Comm: bootlogd Tainted: G                T   6.15.0-rc4-00081-g6145aac371f6 #1 NONE
[   42.263560][  T205] Tainted: [T]=RANDSTRUCT
[   42.263562][  T205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   42.263567][  T205] Call Trace:
[   42.263572][  T205]  <TASK>
[ 42.263576][ T205] dump_stack_lvl (kbuild/obj/consumer/x86_64-randconfig-075-20250511/lib/dump_stack.c:122 (discriminator 4)) 
[ 42.263586][ T205] print_circular_bug (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:2082 (discriminator 1)) 
[ 42.263592][ T205] check_noncircular (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:2215) 
[ 42.263599][ T205] check_prev_add (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3167) 
[ 42.263604][ T205] ? local_clock_noinstr (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/sched/clock.c:301) 
[ 42.263610][ T205] validate_chain (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3286 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3909) 
[ 42.263616][ T205] __lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:5235) 
[ 42.263622][ T205] lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:472 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:5868) 
[ 42.263627][ T205] ? start_flush_work (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:3922 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:4176) 
[ 42.263633][ T205] ? mark_held_locks (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:4326) 
[ 42.263638][ T205] ? start_flush_work (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:3922 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:4176) 
[ 42.263644][ T205] start_flush_work (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:3923 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:4176) 
[ 42.263649][ T205] ? start_flush_work (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:3922 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:4176) 
[ 42.263655][ T205] ? tty_buffer_free (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/tty_buffer.c:463) 
[ 42.263660][ T205] __flush_work (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:4208) 
[ 42.263666][ T205] ? start_flush_work (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:4199) 
[ 42.263671][ T205] ? __rwsem_set_reader_owned (kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/include/asm/atomic64_64.h:20 kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/atomic/atomic-arch-fallback.h:2629 kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/atomic/atomic-long.h:79 kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/atomic/atomic-instrumented.h:3224 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/rwsem.c:176) 
[ 42.263679][ T205] ? flush_workqueue_prep_pwqs (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/workqueue.c:3733) 
[ 42.263690][ T205] n_tty_poll (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/n_tty.c:2458) 
[ 42.263696][ T205] tty_poll (kbuild/obj/consumer/x86_64-randconfig-075-20250511/drivers/tty/tty_io.c:2199) 
[ 42.263702][ T205] do_select (kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/file.h:62 kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/file.h:83 kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:469 kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:536) 
[ 42.263712][ T205] ? select_estimate_accuracy (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:484) 
[ 42.263717][ T205] ? validate_chain (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3824 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3877) 
[ 42.263721][ T205] ? mark_lock (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:4726 (discriminator 3)) 
[ 42.263725][ T205] ? validate_chain (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3824 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3877) 
[ 42.263729][ T205] ? mark_lock (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:4726 (discriminator 3)) 
[ 42.263733][ T205] ? __must_check_overflow (kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/err.h:70) 
[ 42.263743][ T205] ? rcu_lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/rcupdate.h:341) 
[ 42.263749][ T205] ? rcu_lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/rcupdate.h:341) 
[ 42.263755][ T205] ? tracer_hardirqs_off (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/trace/trace_irqsoff.c:641) 
[ 42.263762][ T205] ? mark_lock (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:4726 (discriminator 3)) 
[ 42.263767][ T205] ? validate_chain (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3824 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3877) 
[ 42.263771][ T205] ? mark_lock (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:4726 (discriminator 3)) 
[ 42.263776][ T205] ? validate_chain (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3824 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:3877) 
[ 42.263780][ T205] ? mark_lock (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:4726 (discriminator 3)) 
[ 42.263785][ T205] ? __lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:5235) 
[ 42.263790][ T205] ? lock_acquire (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:472 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:5868) 
[ 42.263795][ T205] ? __might_fault (kbuild/obj/consumer/x86_64-randconfig-075-20250511/mm/memory.c:7151) 
[ 42.263804][ T205] ? __might_fault (kbuild/obj/consumer/x86_64-randconfig-075-20250511/mm/memory.c:7151) 
[ 42.263809][ T205] ? kvm_sched_clock_read (kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/kernel/kvmclock.c:91) 
[ 42.263813][ T205] ? local_clock_noinstr (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/sched/clock.c:301) 
[ 42.263817][ T205] ? local_clock (kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/include/asm/preempt.h:85 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/sched/clock.c:316) 
[ 42.263825][ T205] ? __lock_release (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/lockdep.c:5542) 
[ 42.263829][ T205] ? __might_fault (kbuild/obj/consumer/x86_64-randconfig-075-20250511/mm/memory.c:7151) 
[ 42.263835][ T205] ? __asan_memset (kbuild/obj/consumer/x86_64-randconfig-075-20250511/mm/kasan/shadow.c:84) 
[ 42.263842][ T205] core_sys_select (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:677) 
[ 42.263849][ T205] ? __x64_compat_sys_ppoll_time64 (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:623) 
[ 42.263854][ T205] ? _raw_spin_unlock_irqrestore (kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/include/asm/irqflags.h:42 kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/include/asm/irqflags.h:119 kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/include/asm/irqflags.h:159 kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/spinlock_api_smp.h:151 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/locking/spinlock.c:194) 
[ 42.263864][ T205] ? ktime_get_ts64 (kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/seqlock.h:226 (discriminator 1) kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/time/timekeeping.c:891 (discriminator 1)) 
[ 42.263871][ T205] ? timespec64_add_safe (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/time/time.c:854) 
[ 42.263878][ T205] ? nsec_to_clock_t (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/time/time.c:848) 
[ 42.263883][ T205] ? seqcount_lockdep_reader_access (kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/include/asm/irqflags.h:42 (discriminator 1) kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/include/asm/irqflags.h:119 (discriminator 1) kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/include/asm/irqflags.h:159 (discriminator 1) kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/seqlock.h:74 (discriminator 1)) 
[ 42.263890][ T205] ? ktime_get_ts64 (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/time/timekeeping.c:896 (discriminator 4)) 
[ 42.263896][ T205] kern_select (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:719) 
[ 42.263901][ T205] ? core_sys_select (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:702) 
[ 42.263906][ T205] ? tracer_hardirqs_on (kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/trace/trace_irqsoff.c:634) 
[ 42.263911][ T205] ? syscall_exit_to_user_mode (kbuild/obj/consumer/x86_64-randconfig-075-20250511/include/linux/entry-common.h:361 kbuild/obj/consumer/x86_64-randconfig-075-20250511/kernel/entry/common.c:220) 
[ 42.263917][ T205] __x64_sys_select (kbuild/obj/consumer/x86_64-randconfig-075-20250511/fs/select.c:722) 
[ 42.263922][ T205] do_syscall_64 (kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/entry/syscall_64.c:63 kbuild/obj/consumer/x86_64-randconfig-075-20250511/arch/x86/entry/syscall_64.c:94) 
[ 42.263929][ T205] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   42.263934][  T205] RIP: 0033:0x7f0bac4a3e97
[ 42.263941][ T205] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8d 05 a9 a3 0c 00 49 89 ca 8b 00 85 c0 75 10 b8 17 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 61 c3 41 56 49 89 f6 41 55 4d 89 c5 41 54 49
All code


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250512/202505121345.9f8944dc-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

