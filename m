Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D47E12E71
	for <linux-serial@vger.kernel.org>; Wed,  7 Feb 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301818; cv=fail; b=j9lRiwNBlOvXfr6AqfIJNLvWzdS1W3n154OAL4C1E5uzrXvrhtRJiOJCJ+lJoDf9uUq2XwFPDEbxHrrYGEODZIfLu5fd6E7xFtGY7PDSNI690XqU7v4PTdpBRIS8WbSmDjuRObLtWalzlLStl3ZVeXdpFYRlI4LiOGw7uSzx8As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301818; c=relaxed/simple;
	bh=x185XMse7j9J0vQ5CWN6Z7WiquKhwl1png9CiNCaKKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB9Re6i7FXdN7Nh1xMePMz9NUAOu9N5SLvha0g3xPDisDBMIrO71NpDDwZXImv1swF6OGhJ8nFBKhv3MbKjOuNZFyXCF0p1WzSsmBxvlbNRN1B9HM2lYMkfXaJp5L7COvSFufi1eA6DieVPrydv6v47uAu4O/TS/WczqEVirkQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=WbfgwaPZ; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="WbfgwaPZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sp7CkmlCjZDv1Sbs7MDiSdz8pRyi6VEDo0oePl34RNQ4atZ4ddabnIG/qIrsiSxYliEGk/yPU1t9W0v5uG05USey2R6oTL6mwQQw/gyhPKkzif6IsjcmTs888FxlxZhggiBeS2s4Cs6EvPNS3HF194GFHuDhhh0MoblrgAYvlloJDh+ZRphksEtiEuARqYLO6wrBIoKP1sh9nClUUA32NKf3lpFmWcJVsSNO75RjzAdNQT5/H3FFCzRvrkEy2J4ZJ+5pdx1fxWa6UFEgCdW9YPtgkuqGw/A+dAOehYagg2YKEacWtBaOgTljpBYDNXNvleZvLAsGqqe88yhniPAmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhjftIa9SxbB1tLQwhy6m1U4HR4WlAcV7egukUB9VpU=;
 b=cPVYlQCQ4FBVTZ88S4gqf7cq2f6BXqPUWJMdVzOu68XTPKc1rpvrdTNr0N7jeXH/p6d/SOv4OVvidyCfYt+xFJIQCLaaiiSiyea/mUsOp1C7Hnr6QCTzSEsOiddF/5rW4X5bJcLHI+2NnKQ7k6jVdfnKu17EG86HbVW64a95ttr8xEwilpRLrnH8OrEFcXHmFkS0NYr8+C606Vzxb0/ChnfZX4ns26MBT50zHsIwqJ777pJ1vHd7JsYo0ufyEm3C8jUJhXGW4H7wwz+axJgW6MbycFGnMIS3SsMFoNXDZ+m8LLI4gzCsaHgitr1JMSgZkH75hboBelG+CqTCCeInYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhjftIa9SxbB1tLQwhy6m1U4HR4WlAcV7egukUB9VpU=;
 b=WbfgwaPZkEZOPq38Om3/O2A87v3OTRavigVxzEd2uynCjPzFzyhqVutpVo5+xus1itILWJ5u1X2Qw5emFCQtmbB9TWET8e8G5N6c5/BjaPT+3V77/kZi7JKKIz2RCmM+bwYN3v4QLFZaeLBSMeuL7Z0rYC8gul+8f166StqPSYY=
Received: from DM5PR07CA0085.namprd07.prod.outlook.com (2603:10b6:4:ae::14) by
 SN4PR13MB5264.namprd13.prod.outlook.com (2603:10b6:806:1eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 10:30:12 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::98) by DM5PR07CA0085.outlook.office365.com
 (2603:10b6:4:ae::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 10:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 10:30:12 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 417ATLWU002203
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Wed, 7 Feb 2024 18:29:54 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 417ATAI9004205;
	Wed, 7 Feb 2024 18:29:10 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 8FEF620C1DBE; Wed,  7 Feb 2024 15:57:40 +0530 (IST)
Date: Wed, 7 Feb 2024 15:57:40 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [tty:tty-testing 28/29] include/linux/printk.h:275:13: error:
 unused function 'dump_printk_buffer'
Message-ID: <ZcNbHNpwnQscX6-J@sony.com>
References: <202402071252.Zj78sTXN-lkp@intel.com>
 <2024020708-unknotted-ceramics-f6ec@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024020708-unknotted-ceramics-f6ec@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SN4PR13MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: 328ee57b-2dd2-48a2-2dd1-08dc27c7c47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3utVbJVdpnvgeSAm8+EkywiIf/jAGza1tMzeqD+j9lztsrtLJo5Ki73ygz7P/HBEfgayixAUxRZXZ4S+HNGBr+7QUw4RbY5ZmYuQQbxH2rS2oOOoZ89TVzeDyexw7kiHduvJDIXJ2ELMIn/1FeuLChrtYxzBr3sCCDvM05keYTtCXcyYrNb8KhMXK/KT/5fYmtsci29Us4FaaE7nRO0GejUhNhGH2d3vw/xk4KpaYzVv/hRGgbG/qMTr6jkjKHw3mp1oWyaZkscYsbvtE0iG98odh6pOEEo0jKQA8bAV6LZLkbY8i/PMpSVa/3O6sNS2zEDcEiExi7PjphxK8OaQh17nk0BuvKehHqyMBi1BS4oJQ95sHuKHCKOLyphREES1S8Lsv9ER0N79EtiHIsPJlWuprbdow0LRJDuMZejYRsoD20ri5UIP6wvifV4cARud727ZH/dC0usXzHVo412zgpuUiIwafNWshV3PzSZXQy/cig5EsHCNp2dUE7hmAlokRiShI676f1OItjTTyy1h2GaQ4l7Yb3O0FV2I5a9idFSiWXXvp0OWJCiWgB9fD3blkwe5sQcWTgZhH71DmP9L6u9OODk4nwOQTMtLDF/THNt/K3h2kbVdXO6R86vj4+MZ5imVgxW3Y80ueCPQv+sj2nmNMKEQDUsxtz95nOox/Y8/+Hex3LK/SobVF4+5RfnHg6Ubmucg8eqJlAtEFD3tnmSOXBtFPDm8VVfDO7qpXgK0jLsDDn4QS2iBxNH61tuB
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(230273577357003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(47076005)(356005)(82740400003)(82960400001)(36860700001)(40460700003)(81166007)(40480700001)(83380400001)(26005)(41300700001)(86362001)(6266002)(426003)(36756003)(336012)(107886003)(2616005)(8936002)(6862004)(4326008)(44832011)(8676002)(2906002)(966005)(478600001)(5660300002)(42186006)(70206006)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 10:30:12.1209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 328ee57b-2dd2-48a2-2dd1-08dc27c7c47a
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5264

On Wed, Feb 07, 2024 at 09:51:42AM +0000, Greg Kroah-Hartman wrote:
> On Wed, Feb 07, 2024 at 12:22:40PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> > head:   014e10bea593b963574d607faa34e7eaaad3c02b
> > commit: 558367b641b3802572132e7ed865f5eb887c41ea [28/29] printk: Add function to dump printk buffer directly to consoles
> > config: i386-buildonly-randconfig-006-20240207 (https://download.01.org/0day-ci/archive/20240207/202402071252.Zj78sTXN-lkp@intel.com/config)
> > compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402071252.Zj78sTXN-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202402071252.Zj78sTXN-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from lib/test_bitops.c:9:
> >    In file included from include/linux/module.h:13:
> >    In file included from include/linux/stat.h:19:
> >    In file included from include/linux/time.h:60:
> >    In file included from include/linux/time32.h:13:
> >    In file included from include/linux/timex.h:67:
> >    In file included from arch/x86/include/asm/timex.h:5:
> >    In file included from arch/x86/include/asm/processor.h:23:
> >    In file included from arch/x86/include/asm/msr.h:11:
> >    In file included from arch/x86/include/asm/cpumask.h:5:
> >    In file included from include/linux/cpumask.h:10:
> >    In file included from include/linux/kernel.h:31:
> > >> include/linux/printk.h:275:13: error: unused function 'dump_printk_buffer' [-Werror,-Wunused-function]
> >      275 | static void dump_printk_buffer(void)
> >          |             ^~~~~~~~~~~~~~~~~~
> >    1 error generated.
> > 
> > 
> > vim +/dump_printk_buffer +275 include/linux/printk.h
> > 
> >    268	
> >    269	static inline void dump_stack(void)
> >    270	{
> >    271	}
> >    272	static inline void printk_trigger_flush(void)
> >    273	{
> >    274	}
> >  > 275	static void dump_printk_buffer(void)
> 
> Ah, inline was missed :(
> 
> I'll drop these from my tree for now, can you resubmit fixed patches
> with all of the collected reviewed tags?
> 
> thanks,
> 
> greg k-h

Sorry for this. I will soon resubmit fixed patches with all of the
collected tags. Will add the inline as well as fix the kernel-doc
related warning reported in
https://lore.kernel.org/linux-serial/202402070957.NsPz3RBO-lkp@intel.com/T/#u

Thanks,
Sreenath
