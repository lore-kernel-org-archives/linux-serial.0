Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459CBC38142
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 12:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjAWME3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 07:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAWME2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 07:04:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DD623C62
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 04:04:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d2so10556342wrp.8
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 04:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjnmOT38exucKpDnBU3ufQTB3PeDS8pOIxods2RkuqU=;
        b=UUuJSdzFXaxpXgT78bDz8LTpg6wNHB833NRvU1jUgbKWTbM5n9tLmSf1V0MAHV8ikK
         VWDUnIEdUpt9PvolNOKjWtNfqLzL4+ogWsZVhWbTjQa26Xn1MDH8wvzphBfhUcRcKTx+
         2qdLuoSOOHJOTv4DQBR8p/YC3uFjlcFKCvmIlcMsvgpQGbi8o5NRiOgArsHTjL/J030I
         siZ1TC3VtoLx+ZGAp4VqrS378TMzQ0k07GshmhwBp6N5OxBDZ2in3Kw+ajyLYQz7OdqF
         dFoSzZFGNkuP+yHG0EcndNpGAnvr0WOop34du4EFQlybgLhOpxj1QmiaqQQYkOOjY4yL
         x5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjnmOT38exucKpDnBU3ufQTB3PeDS8pOIxods2RkuqU=;
        b=fvrToP8jA/8oJSxqUNHi6E1JOBjg3Yzqi6OYsOqGm76q9evaCy11XrR85NtNirAfSA
         BmOcOFZ6ZRUOHLl6ES5we3Wyyuphn4PKSt0yzabGMVBZcIvU03gMbYi6iaRac7z5j4gf
         LSMcnfd3o5PTAYUaKOj8Aq5FtFUJW9hzNjaeGEasAyNvik8QdwihOfmcxjqDEx+mik2u
         GaacsynUmvA9ABkvCo7oGu7Mb2lLXqLY7NSxhL8YUnsdD7Kukh6f/SYAyU+T11D1+ccX
         uFhbIKr2+uWVzrNokE0tPqANh3YuSeTmOfm7CwuB/zsWlABZgwUrYvPvFU272fY1SQgz
         BAFQ==
X-Gm-Message-State: AFqh2kqpUUQMhae8taVCPyUQMpwN+tf1osqtZyL28c/xmF3aGXRJn2Pj
        5X2GhFde8hdo9Lx8r9ASn/A=
X-Google-Smtp-Source: AMrXdXt9r3PFlHjSFKwd+OygSUaI9ukjcd2mC9i/Q5L3weA7oL+9hWeLk+Fd3hgpYQZVjf/oB+6q3Q==
X-Received: by 2002:a05:6000:1a8f:b0:2be:3fa7:ab4e with SMTP id f15-20020a0560001a8f00b002be3fa7ab4emr18860225wry.38.1674475464786;
        Mon, 23 Jan 2023 04:04:24 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q15-20020a5d574f000000b00272c0767b4asm4156681wrw.109.2023.01.23.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 04:04:24 -0800 (PST)
Date:   Mon, 23 Jan 2023 15:04:20 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Gabriel Somlo <gsomlo@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [tty:tty-next 17/90] drivers/tty/serial/liteuart.c:328
 liteuart_probe() warn: missing unwind goto?
Message-ID: <Y853xOE+Oat1MQZg@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   05e2600cb0a4d73b0779cf29512819616252aeeb
commit: 5602cf99dcdcc0bf8f9a5979b7443fbe46686995 [17/90] serial: liteuart: add IRQ support for the RX path
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20230121/202301210724.SCRcRjOR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/tty/serial/liteuart.c:328 liteuart_probe() warn: missing unwind goto?

vim +328 drivers/tty/serial/liteuart.c

1da81e5562fac8 Filip Kokosinski 2020-10-13  294  static int liteuart_probe(struct platform_device *pdev)
1da81e5562fac8 Filip Kokosinski 2020-10-13  295  {
1da81e5562fac8 Filip Kokosinski 2020-10-13  296  	struct liteuart_port *uart;
1da81e5562fac8 Filip Kokosinski 2020-10-13  297  	struct uart_port *port;
1da81e5562fac8 Filip Kokosinski 2020-10-13  298  	struct xa_limit limit;
1da81e5562fac8 Filip Kokosinski 2020-10-13  299  	int dev_id, ret;
1da81e5562fac8 Filip Kokosinski 2020-10-13  300  
1da81e5562fac8 Filip Kokosinski 2020-10-13  301  	/* look for aliases; auto-enumerate for free index if not found */
1da81e5562fac8 Filip Kokosinski 2020-10-13  302  	dev_id = of_alias_get_id(pdev->dev.of_node, "serial");
1da81e5562fac8 Filip Kokosinski 2020-10-13  303  	if (dev_id < 0)
1da81e5562fac8 Filip Kokosinski 2020-10-13  304  		limit = XA_LIMIT(0, CONFIG_SERIAL_LITEUART_MAX_PORTS);
1da81e5562fac8 Filip Kokosinski 2020-10-13  305  	else
1da81e5562fac8 Filip Kokosinski 2020-10-13  306  		limit = XA_LIMIT(dev_id, dev_id);
1da81e5562fac8 Filip Kokosinski 2020-10-13  307  
1da81e5562fac8 Filip Kokosinski 2020-10-13  308  	uart = devm_kzalloc(&pdev->dev, sizeof(struct liteuart_port), GFP_KERNEL);
1da81e5562fac8 Filip Kokosinski 2020-10-13  309  	if (!uart)
1da81e5562fac8 Filip Kokosinski 2020-10-13  310  		return -ENOMEM;
1da81e5562fac8 Filip Kokosinski 2020-10-13  311  
1da81e5562fac8 Filip Kokosinski 2020-10-13  312  	ret = xa_alloc(&liteuart_array, &dev_id, uart, limit, GFP_KERNEL);
1da81e5562fac8 Filip Kokosinski 2020-10-13  313  	if (ret)
1da81e5562fac8 Filip Kokosinski 2020-10-13  314  		return ret;
1da81e5562fac8 Filip Kokosinski 2020-10-13  315  
1da81e5562fac8 Filip Kokosinski 2020-10-13  316  	uart->id = dev_id;
1da81e5562fac8 Filip Kokosinski 2020-10-13  317  	port = &uart->port;
1da81e5562fac8 Filip Kokosinski 2020-10-13  318  
1da81e5562fac8 Filip Kokosinski 2020-10-13  319  	/* get membase */
1da81e5562fac8 Filip Kokosinski 2020-10-13  320  	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
dd5e90b16cca8a Johan Hovold     2021-11-17  321  	if (IS_ERR(port->membase)) {
dd5e90b16cca8a Johan Hovold     2021-11-17  322  		ret = PTR_ERR(port->membase);
dd5e90b16cca8a Johan Hovold     2021-11-17  323  		goto err_erase_id;
dd5e90b16cca8a Johan Hovold     2021-11-17  324  	}
1da81e5562fac8 Filip Kokosinski 2020-10-13  325  
5602cf99dcdcc0 Gabriel Somlo    2022-11-23  326  	ret = platform_get_irq_optional(pdev, 0);
5602cf99dcdcc0 Gabriel Somlo    2022-11-23  327  	if (ret < 0 && ret != -ENXIO)
5602cf99dcdcc0 Gabriel Somlo    2022-11-23 @328  		return ret;

Needs to be "goto err_erase_id;"

5602cf99dcdcc0 Gabriel Somlo    2022-11-23  329  	if (ret > 0)
5602cf99dcdcc0 Gabriel Somlo    2022-11-23  330  		port->irq = ret;
5602cf99dcdcc0 Gabriel Somlo    2022-11-23  331  
1da81e5562fac8 Filip Kokosinski 2020-10-13  332  	/* values not from device tree */
1da81e5562fac8 Filip Kokosinski 2020-10-13  333  	port->dev = &pdev->dev;
1da81e5562fac8 Filip Kokosinski 2020-10-13  334  	port->iotype = UPIO_MEM;
1da81e5562fac8 Filip Kokosinski 2020-10-13  335  	port->flags = UPF_BOOT_AUTOCONF;
1da81e5562fac8 Filip Kokosinski 2020-10-13  336  	port->ops = &liteuart_ops;
1da81e5562fac8 Filip Kokosinski 2020-10-13  337  	port->fifosize = 16;
1da81e5562fac8 Filip Kokosinski 2020-10-13  338  	port->type = PORT_UNKNOWN;
1da81e5562fac8 Filip Kokosinski 2020-10-13  339  	port->line = dev_id;
1da81e5562fac8 Filip Kokosinski 2020-10-13  340  	spin_lock_init(&port->lock);
1da81e5562fac8 Filip Kokosinski 2020-10-13  341  
0f55f89d98c8b3 Ilia Sergachev   2021-11-15  342  	platform_set_drvdata(pdev, port);
0f55f89d98c8b3 Ilia Sergachev   2021-11-15  343  
dd5e90b16cca8a Johan Hovold     2021-11-17  344  	ret = uart_add_one_port(&liteuart_driver, &uart->port);
dd5e90b16cca8a Johan Hovold     2021-11-17  345  	if (ret)
dd5e90b16cca8a Johan Hovold     2021-11-17  346  		goto err_erase_id;
dd5e90b16cca8a Johan Hovold     2021-11-17  347  
dd5e90b16cca8a Johan Hovold     2021-11-17  348  	return 0;
dd5e90b16cca8a Johan Hovold     2021-11-17  349  
dd5e90b16cca8a Johan Hovold     2021-11-17  350  err_erase_id:
dd5e90b16cca8a Johan Hovold     2021-11-17  351  	xa_erase(&liteuart_array, uart->id);
dd5e90b16cca8a Johan Hovold     2021-11-17  352  
dd5e90b16cca8a Johan Hovold     2021-11-17  353  	return ret;
1da81e5562fac8 Filip Kokosinski 2020-10-13  354  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

