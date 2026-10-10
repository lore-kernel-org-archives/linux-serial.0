Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E47175A68;
	Sat, 10 Oct 2026 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791594677; cv=none; b=Y787kgeOYGh0ZkxD712DJyOQcMxj7i7E/hmNDdm+edIzXk614Up+kBv7BeIkVSXtjz+bLriKtWzh4UpvqKTEMzeTYvU0/p+NgjKYvruJ9jFUWR2G6cPTlc3hKPCZhsbpQlVWPbUVAUoOK0sIvOBaRqz3AHwI5KXbtMEGD6OtaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791594677; c=relaxed/simple;
	bh=UErRGcKL/uGrCfi/20f2xr+wm/BTrybHItYVUX6mDxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odbFu0WH6oLk1dWUoKW5eIXCqXLz8DbLM1FVqeQE7VKBub/ETDG5HZcKTaw6zm1v1tD2y3xeKrBhEoJIWnzMOWptCKHujvum97q3NAVm7mfHP1eThpynXFFOluP4YgudPKd51EDZKhc6BhcJzaj8nDSgpdL61fqit74yegV8Nw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZM0ddwry; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZM0ddwry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791594676; x=1823130676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UErRGcKL/uGrCfi/20f2xr+wm/BTrybHItYVUX6mDxs=;
  b=ZM0ddwry+9gMr5s+mi88tP6EVd7dIHkMW0fLKe3u0NNpiw4QR6kAutI/
   ppbCaQFHB05/tlTIwHblXcw2zAiYI7cpbRsUWIKAycqj4pWRnRVG+Q1S9
   u8NYc25ODqYkfTaFLGSwlIWjdPXHaSDCNFUm+K8mGfJXCUqemsX3RzcMV
   fDd7U+G4RsUBMFotOnQpg62j9Hf1sknK5e6SRJwrTPlhibm7/Fde+ZoZa
   q1SFGbY3gRE7BlSn5veV9fAUDmTHnBgN+KYQ+DQJ+jB3qhSvO/2uj3Zsw
   KUA5RsQ6sHM4CIyhK9NFy08YmUX4XbXxt0JwaKIU7Ju2+tKOWXpK9KJF3
   A==;
X-CSE-ConnectionGUID: KepNQ5PvRaedQ+xBE7MkOA==
X-CSE-MsgGUID: QIWuanScTNGYNea6j4x84w==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="403079"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="403079"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 18:11:16 -0700
X-CSE-ConnectionGUID: yhgaFlczRx+LLewp7pWV7A==
X-CSE-MsgGUID: tA/mBHqkTdaAJHZfKHMDAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="892557"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Oct 2026 18:11:12 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFLcC-000000006MQ-2rJh;
	Sat, 10 Oct 2026 01:11:08 +0000
Date: Sat, 10 Oct 2026 09:11:08 +0800
From: kernel test robot <lkp@intel.com>
To: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>,
	konrad.dybcio@oss.qualcomm.com, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Aniket Randive <aniket.randive@oss.qualcomm.com>,
	chandana.chiluveru@oss.qualcomm.com,
	jyothi.seerapu@oss.qualcomm.com, praveen.talari@oss.qualcomm.com,
	Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Subject: Re: [PATCH 4/4] tty: serial: qcom_geni_serial: Add GPI DMA support
Message-ID: <202610100800.CCtA9f8L-lkp@intel.com>
References: <20261009-add-gpi-dma-support-for-uart-v1-4-c69e728df686@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-add-gpi-dma-support-for-uart-v1-4-c69e728df686@oss.qualcomm.com>

Hi Naresh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aac26bee2287c88af5be5a5ff96d783b19a28790]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Maramaina/dmaengine-qcom-gpi-Add-UART-transfer-support/20261009-122753
base:   aac26bee2287c88af5be5a5ff96d783b19a28790
patch link:    https://lore.kernel.org/r/20261009-add-gpi-dma-support-for-uart-v1-4-c69e728df686%40oss.qualcomm.com
patch subject: [PATCH 4/4] tty: serial: qcom_geni_serial: Add GPI DMA support
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20261010/202610100800.CCtA9f8L-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610100800.CCtA9f8L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610100800.CCtA9f8L-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/qcom_geni_serial.c: In function 'qcom_geni_serial_gpi_tx_unmap':
>> drivers/tty/serial/qcom_geni_serial.c:1424:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1424 |         port->tx_dma_addr = (dma_addr_t)NULL;
         |                             ^
   drivers/tty/serial/qcom_geni_serial.c: In function 'qcom_geni_serial_gpi_tx_xfer_work':
   drivers/tty/serial/qcom_geni_serial.c:1613:37: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1613 |                 port->tx_dma_addr = (dma_addr_t)NULL;
         |                                     ^
   drivers/tty/serial/qcom_geni_serial.c: In function 'qcom_geni_serial_unprepare_gpi_rx_dma':
   drivers/tty/serial/qcom_geni_serial.c:1670:47: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1670 |                         gpi->rx_dma_addr[i] = (dma_addr_t)NULL;
         |                                               ^


vim +1424 drivers/tty/serial/qcom_geni_serial.c

  1414	
  1415	static void qcom_geni_serial_gpi_tx_unmap(struct qcom_geni_serial_port *port)
  1416	{
  1417		struct qcom_geni_serial_gpi *gpi = port->gpi;
  1418	
  1419		if (!port->tx_dma_addr)
  1420			return;
  1421	
  1422		dma_unmap_single(port->se.dev->parent, port->tx_dma_addr,
  1423				 gpi->xmit_size, DMA_TO_DEVICE);
> 1424		port->tx_dma_addr = (dma_addr_t)NULL;
  1425	}
  1426	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
