Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12AB1A7044;
	Mon,  7 Apr 2025 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029571; cv=none; b=I+EMAJy9rCoGr5rZr4QjWsEwGdoxbgt85sRYBEniGB5DIulMTUWyzv8c3oMJXmUp7HdABmn7ccV62qcFMSSX0mOzGfcOhZ00C4HMhlx1Dj+O9X/el9vOno2uLb+4y5jv/Q4o6xdz92+AU9ej5etA1BMUuaP/7jroKVhBQY8fcRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029571; c=relaxed/simple;
	bh=gVwXd919qwdVvBnlix5/kGCGSDzwuyFY8SUtVZrZ+gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSsOcjIa7IzsVFhmj/pFexHa5bZvmGiFJFkZjWyn2FA2lNXnBChKryqMKaGwxxHSqNMxi6c/bijtITQqVzlwuyFYwItZJjshZ23SDjgkvUl7ajaXiAujwQEhfZ1n3iPRePyI7yRCV7zl9eGQqV4lEevUHa6f3smHpoEaiMM7rv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfAT628f; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfAT628f"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2254e0b4b79so51233395ad.2;
        Mon, 07 Apr 2025 05:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744029569; x=1744634369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqcszFjiY+Y27P7zL5H3ARQuOUut/C9C9Lyd9JHvtz8=;
        b=TfAT628f6kuUiRv4Tt8HOnwm3MG4gHHPvVBaZSpXZd7+mttCYhYBuxYAXe0IGn8Bxd
         uExfIGF/yIla1dFMBgrM0iLAOxVdPi6CLgf17YHbPdNtBCL5YY4xHH6ytOA6r8l65EI4
         MB0+gj7MI2iSCD2Jv9Qo+1hUDF0qcMY7dqwQmr+kkPj3hpReNbEQi2igA3h4sfQ+O0vS
         CGKxsmVoGhFDb03WObaPT30KCLw1aBXtNFEUXx5wSGrmNZ7RDlJDKTzPXmAW+oqLIznP
         8dChmEHqNC9HuAnirypnY765hhJhJbulpa5idnP/8J+QqAnT4Ikgw9aDOIEkH2XVN/0z
         lbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744029569; x=1744634369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqcszFjiY+Y27P7zL5H3ARQuOUut/C9C9Lyd9JHvtz8=;
        b=r+MYM7Dcj+4s/14qcxKFsZPz7EYFR0ThcpGAGg2gC3ihYu7ZEnyPJdt+PNS6HHw7MG
         VNm/M1CHrQ7rGb3v1sFlRkO3VXCDN8NXGUmEd+aQdoee0A77WTNnGvzYAZOR6xgwz3qS
         oB8IUAwY2qC8lthxN379bNIu3qy/ugSAMovubh7iRz0pyQcmuyQcW5dGXgsk67X2llc/
         XhC8w9NUAVNQfO31likEYmuL8ZP8BWPe35eh+pfany7w0pihjLd0gCIfYGOr0C3ueR4C
         3oi6dsXyZFTKOw3374Tuu4AjmP/npi4oS5VRpImAnVGcWE6uR8dFxm0qxyC9zyNqpA/j
         zxQg==
X-Forwarded-Encrypted: i=1; AJvYcCUIG0qFygR6U3dDUak0wL2b0oUrUV/NTCIyV3AnvC2AiObsV5eLFxZRwif/p7HG7kBTb7FnbbvZior3cPNG@vger.kernel.org, AJvYcCXqdfwgAZLsZL3R7jUy8FkmH2l2vNe6vkB8t5v6aPAx2d3r+2SVceNwIC4tHMwMay43Prfure1TEA3xvWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfgTX4TChZC6r4KZi2ZEtoD6HQfXsR7SgSaxWyf1PpABzyiePV
	yClLTwxdxyFRPpRQ3BrOlhJPXjVeVm/0GyYFOf1+QChlqwQYxEi/
X-Gm-Gg: ASbGncvnxduzIHls0Kv25TvY+hmonmB5QQ+ibzSCy/Z8Ztg6nKfs7j+zW6ynTC/LR/U
	QqRnvueUn0GMzcnTxiRzBJRkNSDo9xU1o3SCzXDSOGhSlWN89h2j4IFuGOIjFLLGhI+4OKUHGj7
	D03H2Ly1Ky1h0qb3kc5mjXE60FKN92IZ9a6JGxFw97fCfvuTHTQWASzGBQ+5JBomXvf5GsdJNWE
	SsPUShRJJUje9WbNdyD6M5fapbFPUj2yE2jSrTFGZEzwE6J1C3eRCwXxPcGIKS+7w/xIGTpvYqW
	txP3xALB7mJ9rd/DDudJ1Q/Q7p0pr/TGWABSJbA15g/8iqQIxHCJoW1NSzafhehPdzfzBFAv+yX
	n1XWUKxGrGj28gqT+NfYL0gxYNYI/JSmwJ0N7yaqSrTRiTtrJ7S6J
X-Google-Smtp-Source: AGHT+IFEVGUSoYS1JmDqtU019RQE7MA11l/maqzFklmFLnc6Zt4IppcP3qxlg0IP1WUL3SYihQNhrw==
X-Received: by 2002:a17:902:e541:b0:224:24d5:f20a with SMTP id d9443c01a7336-22a8a8d3173mr178795425ad.48.1744029569090;
        Mon, 07 Apr 2025 05:39:29 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22978777259sm79456365ad.251.2025.04.07.05.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 05:39:28 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: lkp@intel.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	bigeasy@linutronix.de,
	conor.dooley@microchip.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pmladek@suse.com,
	ryotkkr98@gmail.com,
	samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v2] serial: sifive: Switch to nbcon console
Date: Mon,  7 Apr 2025 21:39:20 +0900
Message-Id: <20250407123920.14443-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202504060816.EWk91sJS-lkp@intel.com>
References: <202504060816.EWk91sJS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 6 Apr 2025 08:48:12 +0800, kernel test robot wrote:
>kernel test robot noticed the following build warnings:
>
>[auto build test WARNING on tty/tty-testing]
>[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.14 next-20250404]
>[If your patch is applied to the wrong git tree, kindly drop us a note.
>And when submitting patch, we suggest to use '--base' as documented in
>https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Ryo-Takakura/serial-sifive-Switch-to-nbcon-console/20250405-230051
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
>patch link:    https://lore.kernel.org/r/20250405145915.493173-1-ryotkkr98%40gmail.com
>patch subject: [PATCH v2] serial: sifive: Switch to nbcon console
>config: arm-randconfig-002-20250406 (https://download.01.org/0day-ci/archive/20250406/202504060816.EWk91sJS-lkp@intel.com/config)
>compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
>reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250406/202504060816.EWk91sJS-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202504060816.EWk91sJS-lkp@intel.com/
>
>All warnings (new ones prefixed by >>):
>
>>> drivers/tty/serial/sifive.c:155: warning: Function parameter or struct member 'console_line_ended' not described in 'sifive_serial_port'

Thank you for reporting.
I overlooked this... I'll add a description for it.

Sincerely,
Ryo Takakura

>vim +155 drivers/tty/serial/sifive.c
>
>45c054d0815b15 Paul Walmsley 2019-04-12  131  
>45c054d0815b15 Paul Walmsley 2019-04-12  132  /*
>45c054d0815b15 Paul Walmsley 2019-04-12  133   *
>45c054d0815b15 Paul Walmsley 2019-04-12  134   */
>45c054d0815b15 Paul Walmsley 2019-04-12  135  
>45c054d0815b15 Paul Walmsley 2019-04-12  136  /**
>180bb243de730c Lee Jones     2020-11-04  137   * struct sifive_serial_port - driver-specific data extension to struct uart_port
>45c054d0815b15 Paul Walmsley 2019-04-12  138   * @port: struct uart_port embedded in this struct
>45c054d0815b15 Paul Walmsley 2019-04-12  139   * @dev: struct device *
>45c054d0815b15 Paul Walmsley 2019-04-12  140   * @ier: shadowed copy of the interrupt enable register
>45c054d0815b15 Paul Walmsley 2019-04-12  141   * @baud_rate: UART serial line rate (e.g., 115200 baud)
>180bb243de730c Lee Jones     2020-11-04  142   * @clk: reference to this device's clock
>45c054d0815b15 Paul Walmsley 2019-04-12  143   * @clk_notifier: clock rate change notifier for upstream clock changes
>45c054d0815b15 Paul Walmsley 2019-04-12  144   *
>45c054d0815b15 Paul Walmsley 2019-04-12  145   * Configuration data specific to this SiFive UART.
>45c054d0815b15 Paul Walmsley 2019-04-12  146   */
>45c054d0815b15 Paul Walmsley 2019-04-12  147  struct sifive_serial_port {
>45c054d0815b15 Paul Walmsley 2019-04-12  148  	struct uart_port	port;
>45c054d0815b15 Paul Walmsley 2019-04-12  149  	struct device		*dev;
>45c054d0815b15 Paul Walmsley 2019-04-12  150  	unsigned char		ier;
>45c054d0815b15 Paul Walmsley 2019-04-12  151  	unsigned long		baud_rate;
>45c054d0815b15 Paul Walmsley 2019-04-12  152  	struct clk		*clk;
>45c054d0815b15 Paul Walmsley 2019-04-12  153  	struct notifier_block	clk_notifier;
>328ee9dbff3941 Ryo Takakura  2025-04-05  154  	bool			console_line_ended;
>45c054d0815b15 Paul Walmsley 2019-04-12 @155  };
>45c054d0815b15 Paul Walmsley 2019-04-12  156  
>
>-- 
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki
