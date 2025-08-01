Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798923507A
	for <linux-serial@vger.kernel.org>; Fri,  1 Aug 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053629; cv=none; b=t9NLkcCYGJ3yHTdljbcRyhdEDq5e4in3ZZd1hYdnijnSLj8p7QvptABM0UwsyB6jtjo334NTbob8vX8loSG9VaDasnD4MLGCtBoRfrP6VLoACtEDAa1ZFdBLwdb4ve7zaj10LAv6IraOnpixmoJoTJbfHbPaSoi4KH5Hx/OE7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053629; c=relaxed/simple;
	bh=dhLqm5KAgRV/PBKdhEzwFav1S/UvZUBhN0YVH3kqHNk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CIyddsf9/4q5+a+/YOn21a268WhiiMJUjmKhTaNyrp5uDJQLsIKVb3C9NVgEm6Z/Q+vhNO3Vqh/AjdC4c8qQl03yMNFdP9JZN0JfPeg4w7+7RLRHCP/f1AbbNX/rhrCGwyGXxTrrftHLY63Ep0LKH05ssKbdHM9Xb2FqDQGNJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d9L5fvkB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9L5fvkB"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so733688f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 01 Aug 2025 06:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754053626; x=1754658426; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sT5TZqnBvyy932eMgwolcD/TOlFL6da1+D6Uopmow5o=;
        b=d9L5fvkBofTdGov9bvyqCmI2E8Bkew3ggrDprZLZuQ/GyaQAUD9JRUHZZ1CgYg4mQJ
         4nGtkssekv/Rv1Y0BUI1aarDsDRWcxLOcw98opBskl8zqRRjZhPc3N2XWUnT6l22P7vC
         kwRyjQx4QcxY3qnQHMc5ywdYX1OKv6HSfcVI018DgGsABWResGosX5HgOWF6LuXOA9VC
         Vz6mMoXXspQ+Y5VusEIyzZgen2phRsVtnWxFkmAHvtkEqd7/rWrREzI13NmoDgHQl1RQ
         NUiIQXrNbDRoT3nj2U0ysbrlEusyv7kpZnTXKk9cZYi6Obkao2SZJfUR1D/5F/Z2eaW0
         M4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053626; x=1754658426;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sT5TZqnBvyy932eMgwolcD/TOlFL6da1+D6Uopmow5o=;
        b=NZiIqupLjKEGCzGtkaED6NIckokSyuRm1+E3Z2SNz8bxhmPUZlabdYUNGcLb7+62RB
         54OkONR9a8g742NJbF/fSbyi/+67qVXR/5LUi14nYxZddokEOJurkeX0sQ3aO9x5c3J8
         DsCIyWjPKhpSC9OozObPlZ7LvdoLv7pFbp7RJG/HxAP9xyhEFVZIqOu6kArlB0jGuI6c
         KyODdU77MlWfZTDg5se6zlevUZdIqqAwAAKm411V9NtKxxKUkOZxXkNWD7UW0JoPpaAF
         Txp8r56Vl/KBcfQJ9MqH5VA+Payq1qzG60NLoubdVkEZdUpmWZjg4APzfkj8N4w4OL5O
         fJkA==
X-Gm-Message-State: AOJu0YyCFYXcLibralM7fLXt5kLZMX0vQklizg5zVi6vTZmtDp1FljIf
	Wvb1OR2lYmCH64UL0zc/opWxAzC2v/s31tFZ79xdi3XYfEblsWvaL7uMS377XJRl8Ko=
X-Gm-Gg: ASbGncsrKKZqWZZxVzJYiSl7/xVVn1oQSzbRtsk5EMqmQAj2Ak4C46tWaKK5f745xW9
	zPgL9aqmDtrtBPUNR13x9NN/1wRrpXBv9/zhZoNaBnpx2wt8tSvv6tlwIcp57zDH/xHFEMoDh03
	kSlocHVkip/vROaeQ+bAjhHnTXYb2lpGkWfZysnp79XUi2WhajMJahvK4Z1iYMKPBtBt7qEorJh
	WchMayu0178S8uNDE6a3GNhJ0ZgqMbv+CD7u4NW0zFtSd9+zlVjflht2pk14ThrLLsvA60ypyUA
	IuHfLQBHZZDImQ40TBGcSX6VyuLk08u2YLvI6wdUyHA9ClxaurxgDJ4iBzlElTW9epvWd3Tnx6b
	NDxyzOoY3ivGG//LGnlfbvft5R6Y=
X-Google-Smtp-Source: AGHT+IF+VtJ9x6LAtQSSJvl2inlzoLuz0O+ZF5IP5jLinVljAFN9gOj3YFbm9sqIHuEh+OkfyfNeqg==
X-Received: by 2002:a05:6000:402b:b0:3b5:f0aa:b1e5 with SMTP id ffacd0b85a97d-3b794fd607bmr9536669f8f.19.1754053625709;
        Fri, 01 Aug 2025 06:07:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3bc12csm6019089f8f.28.2025.08.01.06.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:07:05 -0700 (PDT)
Date: Fri, 1 Aug 2025 16:07:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anup Kulkarni <quic_anupkulk@quicinc.com>
Cc: linux-serial@vger.kernel.org
Subject: [bug report] serial: qcom-geni: Enable support for half-duplex mode
Message-ID: <aIy79bA8hhFXVSgR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Anup Kulkarni,

Commit 4fcc287f3c69 ("serial: qcom-geni: Enable support for
half-duplex mode") from Jun 3, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/tty/serial/qcom_geni_serial.c:1952 qcom_geni_serial_probe()
	warn: missing unwind goto?

drivers/tty/serial/qcom_geni_serial.c
    1844 static int qcom_geni_serial_probe(struct platform_device *pdev)
    1845 {
    1846         int ret = 0;
    1847         int line;
    1848         struct qcom_geni_serial_port *port;
    1849         struct uart_port *uport;
    1850         struct resource *res;
    1851         int irq;
    1852         struct uart_driver *drv;
    1853         const struct qcom_geni_device_data *data;
    1854 
    1855         data = of_device_get_match_data(&pdev->dev);
    1856         if (!data)
    1857                 return -EINVAL;
    1858 
    1859         if (data->console) {
    1860                 drv = &qcom_geni_console_driver;
    1861                 line = of_alias_get_id(pdev->dev.of_node, "serial");
    1862         } else {
    1863                 drv = &qcom_geni_uart_driver;
    1864                 line = of_alias_get_id(pdev->dev.of_node, "serial");
    1865                 if (line == -ENODEV) /* compat with non-standard aliases */
    1866                         line = of_alias_get_id(pdev->dev.of_node, "hsuart");
    1867         }
    1868 
    1869         port = get_port_from_line(line, data->console);
    1870         if (IS_ERR(port)) {
    1871                 dev_err(&pdev->dev, "Invalid line %d\n", line);
    1872                 return PTR_ERR(port);
    1873         }
    1874 
    1875         uport = &port->uport;
    1876         /* Don't allow 2 drivers to access the same port */
    1877         if (uport->private_data)
    1878                 return -ENODEV;
    1879 
    1880         uport->dev = &pdev->dev;
    1881         port->dev_data = data;
    1882         port->se.dev = &pdev->dev;
    1883         port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
    1884 
    1885         ret = port->dev_data->resources_init(uport);
    1886         if (ret)
    1887                 return ret;
    1888 
    1889         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    1890         if (!res) {
    1891                 ret = -EINVAL;
    1892                 goto error;
    1893         }
    1894 
    1895         uport->mapbase = res->start;
    1896 
    1897         uport->rs485_config = qcom_geni_rs485_config;
    1898         uport->rs485_supported = qcom_geni_rs485_supported;
    1899         port->tx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
    1900         port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
    1901         port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
    1902 
    1903         if (!data->console) {
    1904                 port->rx_buf = devm_kzalloc(uport->dev,
    1905                                             DMA_RX_BUF_SIZE, GFP_KERNEL);
    1906                 if (!port->rx_buf) {
    1907                         ret = -ENOMEM;
    1908                         goto error;
    1909                 }
    1910         }
    1911 
    1912         port->name = devm_kasprintf(uport->dev, GFP_KERNEL,
    1913                         "qcom_geni_serial_%s%d",
    1914                         uart_console(uport) ? "console" : "uart", uport->line);
    1915         if (!port->name) {
    1916                 ret = -ENOMEM;
    1917                 goto error;
    1918         }
    1919 
    1920         irq = platform_get_irq(pdev, 0);
    1921         if (irq < 0) {
    1922                 ret = irq;
    1923                 goto error;
    1924         }
    1925 
    1926         uport->irq = irq;
    1927         uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE);
    1928 
    1929         if (!data->console)
    1930                 port->wakeup_irq = platform_get_irq_optional(pdev, 1);
    1931 
    1932         if (of_property_read_bool(pdev->dev.of_node, "rx-tx-swap"))
    1933                 port->rx_tx_swap = true;
    1934 
    1935         if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
    1936                 port->cts_rts_swap = true;
    1937 
    1938         port->private_data.drv = drv;
    1939         uport->private_data = &port->private_data;
    1940         platform_set_drvdata(pdev, port);
    1941 
    1942         irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
    1943         ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
    1944                         IRQF_TRIGGER_HIGH, port->name, uport);
    1945         if (ret) {
    1946                 dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
    1947                 goto error;
    1948         }
    1949 
    1950         ret = uart_get_rs485_mode(uport);
    1951         if (ret)
--> 1952                 return ret;

goto error;

    1953 
    1954         devm_pm_runtime_enable(port->se.dev);
    1955 
    1956         ret = uart_add_one_port(drv, uport);
    1957         if (ret)
    1958                 goto error;
    1959 
    1960         if (port->wakeup_irq > 0) {
    1961                 device_init_wakeup(&pdev->dev, true);
    1962                 ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
    1963                                                 port->wakeup_irq);
    1964                 if (ret) {
    1965                         device_init_wakeup(&pdev->dev, false);
    1966                         ida_free(&port_ida, uport->line);
    1967                         uart_remove_one_port(drv, uport);
    1968                         goto error;
    1969                 }
    1970         }
    1971 
    1972         return 0;
    1973 
    1974 error:
    1975         dev_pm_domain_detach_list(port->pd_list);
    1976         return ret;
    1977 }

regards,
dan carpenter
