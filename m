Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28027054C
	for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2025 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498853; cv=none; b=g8NPeGQyqb+qX8r4321491E9oGfq1nzwwYyyya65JUrvF9MT3EotA519Gt6qCuoZqTkO3Q4FHWnnALdUnHAV6rtcKnCNAG4kSWLpr8oOTDkJldeutlY513/hUzD7hoUZJiaPvWKIoioTdhqu68bqrQVZWdJTBsuCAemXJ3+05AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498853; c=relaxed/simple;
	bh=jCGii2UgR1DubFjNhVV24kwwJVQu4mE/TURwvMamQJo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iUffM4Fgipo/BQspnBkTrohhhB35v8Bo2nZJOQKaeQMAKqiroImNn1a7SSkmPexR2sZ5dDzEPGDBpeibvGushFOWKQWM5RH461nE4uBYnnw/MZMlE6/1NqzRSCNXgYoTTaEpGrhanmwJafXkAjYONjNgF6lJpzWW5yXgQW2qgyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xw4cWWHh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xw4cWWHh"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9e7437908so3849640f8f.3
        for <linux-serial@vger.kernel.org>; Sun, 17 Aug 2025 23:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755498850; x=1756103650; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vboU5xoEehUgMZFt48gs99Sfg/+NXyB1MrQfEX3BN2Q=;
        b=xw4cWWHhVWDjebedEew7o63WDrm4zYAF2lBSBaUkTpQ3YbsfRslBaiHnlfARibZQDm
         KlwqTVRkzm13M/SZxD3jFrHCutXLy71ddtSw4n6pxPcNGnKnXOwcjE7IebITU0sOZ4Mk
         6q53G3kUx7zHmddEhNU5y9n5TyJtetp36pJon15vzC3FousmRGP98T/DgRNq9cYQ5sCa
         ByNnomT2TwqRwMBFwfxQC6dBh2pl7zcKl77iAx1/ogrmDDIO5KT2VBiy4h7KxVXaufmq
         FZQvt2WKuM8wxYvBLPY3TRZ7CWCBnqdEeGaQPwiEkBRhLsNaimCQivxDtCQrgNnPwKRU
         K9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755498850; x=1756103650;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vboU5xoEehUgMZFt48gs99Sfg/+NXyB1MrQfEX3BN2Q=;
        b=M9A0mwD1+VdHi3Q+wcMuvmawqiL7f1bDxRMTAh7HNgJP5vzHX5T3z4yGh++/RBoeHf
         AoubQtjywA+OIBKb4cisuraXQrppD5iGVptCSIggOceqbQhK+0VrH4Hc5j29au/y9uod
         x8yml0uVmRZk86VkZT1F02WDxwWRakA+nufH6/22eg++yZXt49tyBisv4tty1xJxQYKh
         1DMXZglwAb3jex3mTXZdLbOfdjXVujL7h9vqvJqeJW6mulz+jnNR5JopqidpBXVyQn8+
         Lu0ZjEK68M7WGmidMRbtfErFlPLIv07olLuwoOKPG6kFgmyUkOwizLYZbSFJN844sKCS
         jK8A==
X-Forwarded-Encrypted: i=1; AJvYcCU5dNnsYmR/W0PwGmGqWICvvCUxioWO4aFSGL5RW0XVBZffwtP1idhNBqARnKRj2iFr2i1ZKf5hPRPwVuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAfJiyNBhEitLNYOCbYKLKhtQNu9N5VaSkCE+ZSyzwuBLfZpL0
	hzWWf1yNfev8dxE3/MxBNdv6Szjx9aG+LGMlHW0eX3X0su7itvIjrBU1C3BDamLZAzM=
X-Gm-Gg: ASbGncv1DsdmuI1ncROBY5JQgz6oLy6ZD0M8HRbTLUV1TA02c3Nf/tic76zh5pRczj+
	vPZ+y6KVgnXtW4e2puHuS+QvusPVO10n2xMV8ABlo537sBWdDzxsgLLYYj1a+tk834nyIjffqFm
	WV7RQPnrT7FTmdGKxr7BF4g+l42RhU39jmiRlymvW2dUqReMz7HdxPDe6imO/BXkRg8NfTH+j8I
	KcWN5ZdmMqmBOMvPTkagIU1xYc5WMpIhYgNtju0nJ5Ed+8kVHgk1hbfpyFxPDXXO7BC5aBTx50n
	qLM0eipJwcayyS+2N0wW6s4/632UsKuKFs892NjW+H69EiJg5jGjY/tmyVsruYpdxMOXIMqq1YV
	pD98r9liAapIF+7BY5gZhDwhSQaC61clyf/OTvQrH46M=
X-Google-Smtp-Source: AGHT+IEcL9XvpvVrTZJabDptBXonFfKX8kZQE+VLqoofN9e3zCBpLdnrziNE+gZOjAV0cFhS0TiOPg==
X-Received: by 2002:a05:6000:3102:b0:3a5:298a:3207 with SMTP id ffacd0b85a97d-3bc6a28004bmr5124234f8f.48.1755498850198;
        Sun, 17 Aug 2025 23:34:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a22210a65sm118913085e9.6.2025.08.17.23.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:34:09 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:34:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Zong Jiang <quic_zongjian@quicinc.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 8/24] drivers/tty/serial/qcom_geni_serial.c:274
 get_port_from_line() error: Calling ida_alloc_range() with a 'max' argument
 which is a power of 2. -1 missing?
Message-ID: <202508180815.R2nDyajs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   7cd9f5d6c5a3f31d2b282d31ddc4d78ff83a5c08
commit: 9391ab1ed9b3fe0d1af7d7858d9bf42f476628c8 [8/24] serial: qcom-geni: Make UART port count configurable via Kconfig
config: parisc-randconfig-r072-20250818 (https://download.01.org/0day-ci/archive/20250818/202508180815.R2nDyajs-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508180815.R2nDyajs-lkp@intel.com/

New smatch warnings:
drivers/tty/serial/qcom_geni_serial.c:274 get_port_from_line() error: Calling ida_alloc_range() with a 'max' argument which is a power of 2. -1 missing?

Old smatch warnings:
drivers/tty/serial/qcom_geni_serial.c:1931 qcom_geni_serial_probe() warn: missing unwind goto?

vim +/max +274 drivers/tty/serial/qcom_geni_serial.c

c3e7966c60745f Zong Jiang                  2025-08-12  260  static struct qcom_geni_serial_port *get_port_from_line(int line, bool console, struct device *dev)
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  261  {
8a8a66a1a18a1d Girish Mahadevan            2018-07-13  262  	struct qcom_geni_serial_port *port;
9391ab1ed9b3fe Zong Jiang                  2025-08-12  263  	int nr_ports = console ? GENI_UART_CONS_PORTS : CONFIG_SERIAL_QCOM_GENI_UART_PORTS;
8a8a66a1a18a1d Girish Mahadevan            2018-07-13  264  
a53be6945f5123 Viken Dadhaniya             2025-03-27  265  	if (console) {
a53be6945f5123 Viken Dadhaniya             2025-03-27  266  		if (line < 0 || line >= nr_ports)
a53be6945f5123 Viken Dadhaniya             2025-03-27  267  			return ERR_PTR(-ENXIO);
a53be6945f5123 Viken Dadhaniya             2025-03-27  268  
a53be6945f5123 Viken Dadhaniya             2025-03-27  269  		port = &qcom_geni_console_port;
a53be6945f5123 Viken Dadhaniya             2025-03-27  270  	} else {
a53be6945f5123 Viken Dadhaniya             2025-03-27  271  		int max_alias_num = of_alias_get_highest_id("serial");
a53be6945f5123 Viken Dadhaniya             2025-03-27  272  
8a8a66a1a18a1d Girish Mahadevan            2018-07-13  273  		if (line < 0 || line >= nr_ports)
a53be6945f5123 Viken Dadhaniya             2025-03-27 @274  			line = ida_alloc_range(&port_ida, max_alias_num + 1, nr_ports, GFP_KERNEL);

ida_alloc_range() range parameters are inclusive so this should be

	ida_alloc_range(&port_ida, max_alias_num + 1, nr_ports - 1, GFP_KERNEL);

a53be6945f5123 Viken Dadhaniya             2025-03-27  275  		else
a53be6945f5123 Viken Dadhaniya             2025-03-27  276  			line = ida_alloc_range(&port_ida, line, nr_ports, GFP_KERNEL);

same here

a53be6945f5123 Viken Dadhaniya             2025-03-27  277  
a53be6945f5123 Viken Dadhaniya             2025-03-27  278  		if (line < 0)
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  279  			return ERR_PTR(-ENXIO);
8a8a66a1a18a1d Girish Mahadevan            2018-07-13  280  
c3e7966c60745f Zong Jiang                  2025-08-12  281  		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
c3e7966c60745f Zong Jiang                  2025-08-12  282  		if (!port)
c3e7966c60745f Zong Jiang                  2025-08-12  283  			return ERR_PTR(-ENOMEM);
c3e7966c60745f Zong Jiang                  2025-08-12  284  
c3e7966c60745f Zong Jiang                  2025-08-12  285  		port->uport.iotype = UPIO_MEM;
c3e7966c60745f Zong Jiang                  2025-08-12  286  		port->uport.ops = &qcom_geni_uart_pops;
c3e7966c60745f Zong Jiang                  2025-08-12  287  		port->uport.flags = UPF_BOOT_AUTOCONF;
c3e7966c60745f Zong Jiang                  2025-08-12  288  		port->uport.line = line;
a53be6945f5123 Viken Dadhaniya             2025-03-27  289  	}
8a8a66a1a18a1d Girish Mahadevan            2018-07-13  290  	return port;
c4f528795d1add Karthikeyan Ramasubramanian 2018-03-14  291  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

