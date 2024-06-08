Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B517BBA
	for <linux-serial@vger.kernel.org>; Sat,  8 Jun 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856666; cv=none; b=epViVXFmv4ADqBL7HyGgHY7TQvtQXiiG1RaJdguAgE0DLUNOIdeocyzdkdfKGtg58chYeAtxW/RNah6/CYn+fwL+HHaPlR768JDLNyIZobYOvKKTxw7DGorcJ9TqY4PRY0xX8kd9Kig+jP0r+Blp1kZL4aGmuRrXPiN2Rls66V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856666; c=relaxed/simple;
	bh=5qCd9RgGeFF3+kQrCNwhsYrnlBShXsGu6sqjuHYgSSc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j4ae3jW+7jj1DCt/VAIiw7is4plkSpK9Wm+uomuRbAONNLDnJplJYIsWqVAT43kKEfwPgtVIWHlsa11b73zVlCpS6l9JEDLQvj+poyS2i4/pBUuzpEXGXiqYrQob+e8ZVcfJQsMWLCATPtsrKnGFN8NcXtJLO4ma2suV5ayQ1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kb4QDXL9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kb4QDXL9"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354f3f6c3b1so2441916f8f.2
        for <linux-serial@vger.kernel.org>; Sat, 08 Jun 2024 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717856663; x=1718461463; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IezBDoDWffdB2RRRd7GgBHOLuaeqSuuL70ECBc6p2tU=;
        b=kb4QDXL9FhglMrf25dg6pYpEHxidJIQnKviFqMb71hyOoaqOyI9M75Q1tDwSkUfJdC
         HWKac8Art7hdNBGfbl1Chf+BvyxLAvBhzqKmTOwCTa/TAwvzLnYwL4FKQUVy1J6hUyri
         +s4MUqIkOwTHaZHg/ywqAluM9d4cR2UuBjkvZnEQJC0Y6zLEc7QHpevq5NeXnHGGuDZw
         fGn4NELFv6FtIJtRKlCPIQXTaKuKXncqNvdBFsdEpRv5w+xT15zNrpLAjGnoUnbWomqN
         tnx9Kzd2um42lx99fen7sSqETLyIabuCeQeGYD6gLpglLZRBZwBxzfv3nvFyMO5cHFyk
         02zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717856663; x=1718461463;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IezBDoDWffdB2RRRd7GgBHOLuaeqSuuL70ECBc6p2tU=;
        b=FPKuUEGILdRzuPc+uhF7LfhtS+UOGNuBE0tu2XYxXUrwsn+uIViPyAEFOu75HTkCaj
         wNvAHeYYgWwxpSIUR51y3QXOa8xehDKqqdWrtqiCVDSuay/9pwU23uJzNiDrwY5H+s92
         oDpyfqYOPEfvcC1AYpgmCjrZXrqrfh2/CooYiA+Kkj4PtXa+gauBcHjhNbjSW66yFR5G
         ys6J2mSG65rXpd+lSR7kTq/mJkptvqtDTUEx5iu1syBchystzZyIfA2BNe4ECmSNHqpY
         ku5dl8lBx1pbhtWNxhsH0ZRRyKbWC+nlCbpPHoPiuPhwWPPuuE7/oGHYQOgSUIHJv04h
         RvtA==
X-Gm-Message-State: AOJu0YykZOEXMPRw33oDCYfDqhPiP8o+Wi3QsmdcIeMnUOJfhgvMXML8
	C3Q06Jt/KVU/4EXDLbgnKoKxiMSCnd7wkXPEPJ/ABO789WsTa85VW2PnAsyGzZM=
X-Google-Smtp-Source: AGHT+IFqVLLGyO0QSWfkZj7o5aXqw24pK4lo5Up2GH1w87nl5cchDH4PYR5UIn57Mo07E/CF5aUYYA==
X-Received: by 2002:a5d:5f4a:0:b0:354:f9f0:a7ed with SMTP id ffacd0b85a97d-35efee03d44mr4095958f8f.47.1717856663244;
        Sat, 08 Jun 2024 07:24:23 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1d74b065sm150504f8f.84.2024.06.08.07.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 07:24:22 -0700 (PDT)
Date: Sat, 8 Jun 2024 17:24:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacky Huang <ychuang3@nuvoton.com>
Cc: linux-serial@vger.kernel.org
Subject: [bug report] tty: serial: Add Nuvoton ma35d1 serial driver support
Message-ID: <8df7ce45-fd58-4235-88f7-43fe7cd67e8f@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jacky Huang,

Commit 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver
support") from Jun 19, 2023 (linux-next), leads to the following
Smatch static checker warning:

	drivers/tty/serial/ma35d1_serial.c:713 ma35d1serial_probe()
	error: we previously assumed 'pdev->dev.of_node' could be null (see line 691)

drivers/tty/serial/ma35d1_serial.c
    685 static int ma35d1serial_probe(struct platform_device *pdev)
    686 {
    687         struct resource *res_mem;
    688         struct uart_ma35d1_port *up;
    689         int ret = 0;
    690 
    691         if (pdev->dev.of_node) {
                    ^^^^^^^^^^^^^^^^^
Check for NULL

    692                 ret = of_alias_get_id(pdev->dev.of_node, "serial");
    693                 if (ret < 0) {
    694                         dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
    695                         return ret;
    696                 }
    697         }
    698         up = &ma35d1serial_ports[ret];
    699         up->port.line = ret;
    700         res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    701         if (!res_mem)
    702                 return -ENODEV;
    703 
    704         up->port.iobase = res_mem->start;
    705         up->port.membase = ioremap(up->port.iobase, MA35_UART_REG_SIZE);
    706         if (!up->port.membase)
    707                 return -ENOMEM;
    708 
    709         up->port.ops = &ma35d1serial_ops;
    710 
    711         spin_lock_init(&up->port.lock);
    712 
--> 713         up->clk = of_clk_get(pdev->dev.of_node, 0);
                                     ^^^^^^^^^^^^^^^^^
Unchecked dereference inside function

    714         if (IS_ERR(up->clk)) {
    715                 ret = PTR_ERR(up->clk);
    716                 dev_err(&pdev->dev, "failed to get core clk: %d\n", ret);
    717                 goto err_iounmap;

regards,
dan carpenter
