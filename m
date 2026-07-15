Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646F9229B12
	for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2026 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784076135; cv=none; b=iyP3MM7milFTvFMqGkPXZ0dILChrxlEEc7jqSn0d0Jo3h5wGEzVaxOnEI/3Va/SBHqyZLzmsr64UJaVQYEakSPJFLwJej2p2tLqJpwbWALvroNB9trvpPLW3XSOUwC1hnFqS6kbMw+Hdzm/10a/eG8CYGxR/B0z9/0Q+k8MagQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784076135; c=relaxed/simple;
	bh=sL+necVGTYvUx/eD7gGzK0wo54TyzhOOpdT7Ea+Go4o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BWAPsClkj5sCUAarhBkSmZZd9Z/cIDj4kbkyyKKvBXzjjmSkyr9od9WdU2eAq9bDOaUDkKe6POdoT+u/pQoQxMC4WTHZGVSf42TZv8WfgzPlTyet6ZNN+d/LVKdrzgQ/HqcKtTV+44wTaG5WiiCsvSHmWBfJT/SGZMYFz9gqbU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWju8Fmy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWju8Fmy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784076129; x=1815612129;
  h=date:from:to:cc:subject:message-id;
  bh=sL+necVGTYvUx/eD7gGzK0wo54TyzhOOpdT7Ea+Go4o=;
  b=nWju8FmyXGsgTS7j0ZMth8drxdqpRHK3g/p2bqN3clHTaipdEqhpYomo
   zJcts2hfM9grTGobRDlUItQCsF6+0FIqOkcVuh5cSSyJVJFHDMr/ZeWGL
   b1MhBo4mc2ayGI0fkNCaJvDpeqxYWBN0XPiwDVNCYBfshfCSQVgc3aXS3
   W960wepevAe10Cjyg1XZiGLIJZO4OYLggQuEUP7sj+iXakzCuisWRG6xU
   +M0XzqKiYnRi7AtXo0KH2VXH0tQiVv672QmOnqe/zApueQW+c6wtCPHwD
   b/3iUWft5/i+ul9/7PWeqnSaMGek0eZBzkU6ec8VWS0EhjaNSXfLGNmct
   g==;
X-CSE-ConnectionGUID: VieSJNcATYylM8MkN+jtwg==
X-CSE-MsgGUID: kxIQIHMPRfe3NrWC9zEfEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="102129577"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="102129577"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:42:09 -0700
X-CSE-ConnectionGUID: YPP8cwCCRHam6RenG3U4uA==
X-CSE-MsgGUID: QU00GT3LSiOO2h6l6jaJIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="280434822"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jul 2026 17:42:06 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjnhK-00000000NAz-10gc;
	Wed, 15 Jul 2026 00:42:02 +0000
Date: Wed, 15 Jul 2026 08:41:02 +0800
From: kernel test robot <lkp@intel.com>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-serial@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [tty:tty-next 31/41]
 drivers/tty/serial/qcom_geni_serial.c:1925:4: error: cannot jump from this
 goto statement to its label
Message-ID: <202607150830.LsNxeVYw-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   c1d4ce2d9eaeccd7e8aef7ec1109df49eaf4f503
commit: 3d71f8d7eeb374d0eb84c64c6ffd68bdcc0d42d4 [31/41] serial: qcom-geni: remove .pm callback, use runtime PM in startup/shutdown
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260715/202607150830.LsNxeVYw-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project b3e6e6dabdc02153552a64fc74ff5c7532447eed)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260715/202607150830.LsNxeVYw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607150830.LsNxeVYw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/qcom_geni_serial.c:1925:4: error: cannot jump from this goto statement to its label
    1925 |                         goto error;
         |                         ^
   drivers/tty/serial/qcom_geni_serial.c:1931:44: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1931 |         PM_RUNTIME_ACQUIRE_IF_ENABLED(uport->dev, pm);
         |                                                   ^
   drivers/tty/serial/qcom_geni_serial.c:1916:3: error: cannot jump from this goto statement to its label
    1916 |                 goto error;
         |                 ^
   drivers/tty/serial/qcom_geni_serial.c:1931:44: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1931 |         PM_RUNTIME_ACQUIRE_IF_ENABLED(uport->dev, pm);
         |                                                   ^
   drivers/tty/serial/qcom_geni_serial.c:1911:3: error: cannot jump from this goto statement to its label
    1911 |                 goto error;
         |                 ^
   drivers/tty/serial/qcom_geni_serial.c:1931:44: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1931 |         PM_RUNTIME_ACQUIRE_IF_ENABLED(uport->dev, pm);
         |                                                   ^
   drivers/tty/serial/qcom_geni_serial.c:1887:3: error: cannot jump from this goto statement to its label
    1887 |                 goto error;
         |                 ^
   drivers/tty/serial/qcom_geni_serial.c:1931:44: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1931 |         PM_RUNTIME_ACQUIRE_IF_ENABLED(uport->dev, pm);
         |                                                   ^
   drivers/tty/serial/qcom_geni_serial.c:1881:3: error: cannot jump from this goto statement to its label
    1881 |                 goto error;
         |                 ^
   drivers/tty/serial/qcom_geni_serial.c:1931:44: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1931 |         PM_RUNTIME_ACQUIRE_IF_ENABLED(uport->dev, pm);
         |                                                   ^
   drivers/tty/serial/qcom_geni_serial.c:1872:4: error: cannot jump from this goto statement to its label
    1872 |                         goto error;
         |                         ^
   drivers/tty/serial/qcom_geni_serial.c:1931:44: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1931 |         PM_RUNTIME_ACQUIRE_IF_ENABLED(uport->dev, pm);
         |                                                   ^
   drivers/tty/serial/qcom_geni_serial.c:1864:4: error: cannot jump from this goto statement to its label
    1864 |                         goto error;
         |                         ^
   drivers/tty/serial/qcom_geni_serial.c:1931:44: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1931 |         PM_RUNTIME_ACQUIRE_IF_ENABLED(uport->dev, pm);
         |                                                   ^
   drivers/tty/serial/qcom_geni_serial.c:1848:3: error: cannot jump from this goto statement to its label
    1848 |                 goto error;
         |                 ^
   drivers/tty/serial/qcom_geni_serial.c:1931:44: note: jump bypasses initialization of variable with __attribute__((cleanup))
    1931 |         PM_RUNTIME_ACQUIRE_IF_ENABLED(uport->dev, pm);
         |                                                   ^
   8 errors generated.


vim +1925 drivers/tty/serial/qcom_geni_serial.c

c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1799  
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1800  static int qcom_geni_serial_probe(struct platform_device *pdev)
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1801  {
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1802  	int ret = 0;
71581242164f112 Colin Ian King              2021-04-23  1803  	int line;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1804  	struct qcom_geni_serial_port *port;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1805  	struct uart_port *uport;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1806  	struct resource *res;
066cd1c4e4b9b43 Karthikeyan Ramasubramanian 2018-04-06  1807  	int irq;
8a8a66a1a18a1db Girish Mahadevan            2018-07-13  1808  	struct uart_driver *drv;
40ec6d41c841e27 Bartosz Golaszewski         2022-12-29  1809  	const struct qcom_geni_device_data *data;
8a8a66a1a18a1db Girish Mahadevan            2018-07-13  1810  
40ec6d41c841e27 Bartosz Golaszewski         2022-12-29  1811  	data = of_device_get_match_data(&pdev->dev);
40ec6d41c841e27 Bartosz Golaszewski         2022-12-29  1812  	if (!data)
40ec6d41c841e27 Bartosz Golaszewski         2022-12-29  1813  		return -EINVAL;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1814  
40ec6d41c841e27 Bartosz Golaszewski         2022-12-29  1815  	if (data->console) {
8a8a66a1a18a1db Girish Mahadevan            2018-07-13  1816  		drv = &qcom_geni_console_driver;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1817  		line = of_alias_get_id(pdev->dev.of_node, "serial");
8a8a66a1a18a1db Girish Mahadevan            2018-07-13  1818  	} else {
8a8a66a1a18a1db Girish Mahadevan            2018-07-13  1819  		drv = &qcom_geni_uart_driver;
08b0adb1ae5456a Dmitry Baryshkov            2021-06-22  1820  		line = of_alias_get_id(pdev->dev.of_node, "serial");
08b0adb1ae5456a Dmitry Baryshkov            2021-06-22  1821  		if (line == -ENODEV) /* compat with non-standard aliases */
8a8a66a1a18a1db Girish Mahadevan            2018-07-13  1822  			line = of_alias_get_id(pdev->dev.of_node, "hsuart");
8a8a66a1a18a1db Girish Mahadevan            2018-07-13  1823  	}
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1824  
c3e7966c60745f8 Zong Jiang                  2025-08-12  1825  	port = get_port_from_line(line, data->console, &pdev->dev);
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1826  	if (IS_ERR(port)) {
6a10635e90e8cb0 Karthikeyan Ramasubramanian 2018-05-03  1827  		dev_err(&pdev->dev, "Invalid line %d\n", line);
6a10635e90e8cb0 Karthikeyan Ramasubramanian 2018-05-03  1828  		return PTR_ERR(port);
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1829  	}
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1830  
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1831  	uport = &port->uport;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1832  	/* Don't allow 2 drivers to access the same port */
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1833  	if (uport->private_data)
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1834  		return -ENODEV;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1835  
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1836  	uport->dev = &pdev->dev;
40ec6d41c841e27 Bartosz Golaszewski         2022-12-29  1837  	port->dev_data = data;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1838  	port->se.dev = &pdev->dev;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1839  	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
4b2601ae3066dab Praveen Talari              2025-07-21  1840  
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1841  	ret = port->dev_data->resources_init(uport);
4b2601ae3066dab Praveen Talari              2025-07-21  1842  	if (ret)
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1843  		return ret;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1844  
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1845  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1846  	if (!res) {
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1847  		ret = -EINVAL;
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1848  		goto error;
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1849  	}
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1850  
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1851  	uport->mapbase = res->start;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1852  
4fcc287f3c69245 Anup Kulkarni               2025-06-03  1853  	uport->rs485_config = qcom_geni_rs485_config;
4fcc287f3c69245 Anup Kulkarni               2025-06-03  1854  	uport->rs485_supported = qcom_geni_rs485_supported;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1855  	port->tx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1856  	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1857  	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1858  
40ec6d41c841e27 Bartosz Golaszewski         2022-12-29  1859  	if (!data->console) {
2aaa43c70778333 Bartosz Golaszewski         2022-12-29  1860  		port->rx_buf = devm_kzalloc(uport->dev,
2aaa43c70778333 Bartosz Golaszewski         2022-12-29  1861  					    DMA_RX_BUF_SIZE, GFP_KERNEL);
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1862  		if (!port->rx_buf) {
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1863  			ret = -ENOMEM;
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1864  			goto error;
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1865  		}
bafe277d6c5a8bc Praveen Talari              2026-07-01  1866  
bafe277d6c5a8bc Praveen Talari              2026-07-01  1867  		port->rx_dma_addr = dma_map_single(pdev->dev.parent, port->rx_buf,
bafe277d6c5a8bc Praveen Talari              2026-07-01  1868  						   DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
bafe277d6c5a8bc Praveen Talari              2026-07-01  1869  		if (dma_mapping_error(pdev->dev.parent, port->rx_dma_addr)) {
bafe277d6c5a8bc Praveen Talari              2026-07-01  1870  			ret = -EIO;
bafe277d6c5a8bc Praveen Talari              2026-07-01  1871  			dev_err(&pdev->dev, "Failed to map RX DMA buffer: %d\n", ret);
bafe277d6c5a8bc Praveen Talari              2026-07-01  1872  			goto error;
bafe277d6c5a8bc Praveen Talari              2026-07-01  1873  		}
f9d690b6ece7ec9 satya priya                 2020-03-06  1874  	}
f9d690b6ece7ec9 satya priya                 2020-03-06  1875  
f3974413cf0209b Akash Asthana               2020-01-06  1876  	port->name = devm_kasprintf(uport->dev, GFP_KERNEL,
f3974413cf0209b Akash Asthana               2020-01-06  1877  			"qcom_geni_serial_%s%d",
f3974413cf0209b Akash Asthana               2020-01-06  1878  			uart_console(uport) ? "console" : "uart", uport->line);
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1879  	if (!port->name) {
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1880  		ret = -ENOMEM;
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1881  		goto error;
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1882  	}
f3974413cf0209b Akash Asthana               2020-01-06  1883  
066cd1c4e4b9b43 Karthikeyan Ramasubramanian 2018-04-06  1884  	irq = platform_get_irq(pdev, 0);
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1885  	if (irq < 0) {
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1886  		ret = irq;
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1887  		goto error;
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1888  	}
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1889  
066cd1c4e4b9b43 Karthikeyan Ramasubramanian 2018-04-06  1890  	uport->irq = irq;
8f122698a64b877 Dmitry Safonov              2019-12-13  1891  	uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE);
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1892  
40ec6d41c841e27 Bartosz Golaszewski         2022-12-29  1893  	if (!data->console)
f3974413cf0209b Akash Asthana               2020-01-06  1894  		port->wakeup_irq = platform_get_irq_optional(pdev, 1);
f3974413cf0209b Akash Asthana               2020-01-06  1895  
9fa3c4b1fa379f2 Roja Rani Yarubandi         2020-03-04  1896  	if (of_property_read_bool(pdev->dev.of_node, "rx-tx-swap"))
9fa3c4b1fa379f2 Roja Rani Yarubandi         2020-03-04  1897  		port->rx_tx_swap = true;
9fa3c4b1fa379f2 Roja Rani Yarubandi         2020-03-04  1898  
9fa3c4b1fa379f2 Roja Rani Yarubandi         2020-03-04  1899  	if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
9fa3c4b1fa379f2 Roja Rani Yarubandi         2020-03-04  1900  		port->cts_rts_swap = true;
9fa3c4b1fa379f2 Roja Rani Yarubandi         2020-03-04  1901  
e42d6c3ec0c7ade Douglas Anderson            2020-06-26  1902  	port->private_data.drv = drv;
e42d6c3ec0c7ade Douglas Anderson            2020-06-26  1903  	uport->private_data = &port->private_data;
f3974413cf0209b Akash Asthana               2020-01-06  1904  	platform_set_drvdata(pdev, port);
f3974413cf0209b Akash Asthana               2020-01-06  1905  
3e4aaea7a0391d4 Akash Asthana               2019-10-10  1906  	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
3e4aaea7a0391d4 Akash Asthana               2019-10-10  1907  	ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
3e4aaea7a0391d4 Akash Asthana               2019-10-10  1908  			IRQF_TRIGGER_HIGH, port->name, uport);
3e4aaea7a0391d4 Akash Asthana               2019-10-10  1909  	if (ret) {
3e4aaea7a0391d4 Akash Asthana               2019-10-10  1910  		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1911  		goto error;
3e4aaea7a0391d4 Akash Asthana               2019-10-10  1912  	}
3e4aaea7a0391d4 Akash Asthana               2019-10-10  1913  
4fcc287f3c69245 Anup Kulkarni               2025-06-03  1914  	ret = uart_get_rs485_mode(uport);
4fcc287f3c69245 Anup Kulkarni               2025-06-03  1915  	if (ret)
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1916  		goto error;
4fcc287f3c69245 Anup Kulkarni               2025-06-03  1917  
f3974413cf0209b Akash Asthana               2020-01-06  1918  	if (port->wakeup_irq > 0) {
f3974413cf0209b Akash Asthana               2020-01-06  1919  		device_init_wakeup(&pdev->dev, true);
f3974413cf0209b Akash Asthana               2020-01-06  1920  		ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
8b7103f31950443 Akash Asthana               2019-10-10  1921  						port->wakeup_irq);
8b7103f31950443 Akash Asthana               2019-10-10  1922  		if (ret) {
f3974413cf0209b Akash Asthana               2020-01-06  1923  			device_init_wakeup(&pdev->dev, false);
a53be6945f5123c Viken Dadhaniya             2025-03-27  1924  			ida_free(&port_ida, uport->line);
abffd1e6c4f1c97 Praveen Talari              2025-11-10 @1925  			goto error;
8b7103f31950443 Akash Asthana               2019-10-10  1926  		}
8b7103f31950443 Akash Asthana               2019-10-10  1927  	}
f3974413cf0209b Akash Asthana               2020-01-06  1928  
fb47423dc7bf433 Praveen Talari              2026-01-08  1929  	devm_pm_runtime_enable(port->se.dev);
fb47423dc7bf433 Praveen Talari              2026-01-08  1930  
3d71f8d7eeb374d Praveen Talari              2026-07-10  1931  	PM_RUNTIME_ACQUIRE_IF_ENABLED(uport->dev, pm);
3d71f8d7eeb374d Praveen Talari              2026-07-10  1932  	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
3d71f8d7eeb374d Praveen Talari              2026-07-10  1933  	if (ret < 0) {
3d71f8d7eeb374d Praveen Talari              2026-07-10  1934  		dev_err(uport->dev, "Failed to resume and get %d\n", ret);
3d71f8d7eeb374d Praveen Talari              2026-07-10  1935  		goto error;
3d71f8d7eeb374d Praveen Talari              2026-07-10  1936  	}
3d71f8d7eeb374d Praveen Talari              2026-07-10  1937  
fb47423dc7bf433 Praveen Talari              2026-01-08  1938  	ret = uart_add_one_port(drv, uport);
fb47423dc7bf433 Praveen Talari              2026-01-08  1939  	if (ret)
fb47423dc7bf433 Praveen Talari              2026-01-08  1940  		goto error;
fb47423dc7bf433 Praveen Talari              2026-01-08  1941  
f3974413cf0209b Akash Asthana               2020-01-06  1942  	return 0;
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1943  
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1944  error:
bafe277d6c5a8bc Praveen Talari              2026-07-01  1945  	if (port->rx_dma_addr) {
bafe277d6c5a8bc Praveen Talari              2026-07-01  1946  		dma_unmap_single(pdev->dev.parent, port->rx_dma_addr,
bafe277d6c5a8bc Praveen Talari              2026-07-01  1947  				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
bafe277d6c5a8bc Praveen Talari              2026-07-01  1948  		port->rx_dma_addr = 0;
bafe277d6c5a8bc Praveen Talari              2026-07-01  1949  	}
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1950  	dev_pm_domain_detach_list(port->pd_list);
abffd1e6c4f1c97 Praveen Talari              2025-11-10  1951  	return ret;
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1952  }
c4f528795d1add8 Karthikeyan Ramasubramanian 2018-03-14  1953  

:::::: The code at line 1925 was first introduced by commit
:::::: abffd1e6c4f1c9746ffd3fb5c659668efc221714 serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms

:::::: TO: Praveen Talari <praveen.talari@oss.qualcomm.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
