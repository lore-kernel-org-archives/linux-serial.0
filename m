Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B01DA10E;
	Thu, 16 Jan 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029783; cv=none; b=NjCIfFNfLpgWXrslwmbmaKH7PJcL29EkLbaWXLtgAZFwa2eKQj+5HEhWnMWZCcIVaBmasaMAK3sSJ0mhMmPA95ZTSvu0Kd5s5wTKqA5NcDwC4J4FsS2ebRGn+A0j3B5og8bj0oBwaPZvbXc6JEBllJN4TY6m7do4e8XgSaqS9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029783; c=relaxed/simple;
	bh=Q5FlTYD68SP9dk1w6IoFfxIabCPHc4WAOL9ydDd2Ywo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFqnaU4ltE4Jpp663OLn8X8CZpM5bgU9Fmbh6b+P+wyrVtZNkFKJzXF8/k37Jf7hkfzohSOi0L1NbUK/TrwvF75yknMm90mk2p9DtoSumLjqteVo86YkvNdfJqRuMoBigvZ8UH4pFKQGBeLmgxA4HxNISoy+7lMO/Fw1evdeIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YYhcv2l5nz67nqN;
	Thu, 16 Jan 2025 20:14:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 97C9D1409EA;
	Thu, 16 Jan 2025 20:16:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 16 Jan
 2025 13:16:11 +0100
Date: Thu, 16 Jan 2025 12:16:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: kernel test robot <lkp@intel.com>
CC: Yenchia Chen <yenchia.chen@mediatek.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <oe-kbuild-all@lists.linux.dev>,
	<yj.chiang@mediatek.com>, <tbergstrom@nvidia.com>, <yujiaoliang@vivo.com>,
	<u.kleine-koenig@baylibre.com>, <treapking@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] serial: 8250_mtk: Add ACPI support
Message-ID: <20250116121610.00004052@huawei.com>
In-Reply-To: <202501160328.DUMWkTOc-lkp@intel.com>
References: <20250114033324.3533292-1-yenchia.chen@mediatek.com>
	<202501160328.DUMWkTOc-lkp@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 16 Jan 2025 03:45:33 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Yenchia,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on tty/tty-testing]
> [also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.13-rc7 next-20250115]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yenchia-Chen/serial-8250_mtk-Add-ACPI-support/20250114-113715
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> patch link:    https://lore.kernel.org/r/20250114033324.3533292-1-yenchia.chen%40mediatek.com
> patch subject: [PATCH] serial: 8250_mtk: Add ACPI support
> config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20250116/202501160328.DUMWkTOc-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250116/202501160328.DUMWkTOc-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501160328.DUMWkTOc-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/tty/serial/8250/8250_mtk.c:662:36: warning: 'mtk8250_acpi_match' defined but not used [-Wunused-const-variable=]  
>      662 | static const struct acpi_device_id mtk8250_acpi_match[] = {
>          |                                    ^~~~~~~~~~~~~~~~~~
> 
> 
> vim +/mtk8250_acpi_match +662 drivers/tty/serial/8250/8250_mtk.c
> 
>    661	
>  > 662	static const struct acpi_device_id mtk8250_acpi_match[] = {  
>    663		{ "MTKI0511", 0 },
>    664		{},
>    665	};
I'd drop the ACPI_PTR() use and just set it unconditionally.  This table
is tiny so not worth complexity of doing anything else.

>    666	MODULE_DEVICE_TABLE(acpi, mtk8250_acpi_match);
>    667	
> 

