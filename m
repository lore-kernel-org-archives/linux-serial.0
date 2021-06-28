Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578DCC49EA7
	for <linux-serial@archiver.kernel.org>; Mon, 28 Jun 2021 08:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C76761C2E
	for <linux-serial@archiver.kernel.org>; Mon, 28 Jun 2021 08:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhF1InF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Jun 2021 04:43:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52450 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232312AbhF1InE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Jun 2021 04:43:04 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S8bQvt010675;
        Mon, 28 Jun 2021 08:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=10HkCquknUYYh24TE6Zecf+LWXEYon0nDOutcqkF1WI=;
 b=mHTdwUismudBtpzsTprB7rLlVWZFgRgBfqp2ekBqa4r+T503K7QSntdsQzwNYp1lOX/F
 3D1TM5MZB+FqQDbfmiSUAMelt5PeokYpHe7uGG525JTg3B6mDbseernIRLyOjPGK3teG
 gw8DppgK0Ya8tsQZ9e+HohomHEuqPi+e6uDTbM+xy0NHkY3KyWF6TrYHF7qYlaa1M+uX
 9eDxN9XJXyUZPnBtt4hJ6t/krz1s8sGIKkTeg+mQjbKOyxyqbe/VW9PGm4WaT/aaDOs2
 oOBxG94mYxFYcMQuCoLk/nOIIZFfGgqXXGUAHZhvtaN1UmgTaF6bKe+KJSCnvxbLGqOa ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39esfks2m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 08:40:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15S8djD3043558;
        Mon, 28 Jun 2021 08:40:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39ee0s0rtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 08:40:25 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15S8eO7D046551;
        Mon, 28 Jun 2021 08:40:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 39ee0s0rs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 08:40:24 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.14.4) with ESMTP id 15S8eLhc008152;
        Mon, 28 Jun 2021 08:40:21 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jun 2021 01:40:20 -0700
Date:   Mon, 28 Jun 2021 11:40:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Tamseel Shams <m.shams@samsung.com>,
        krzysztof.kozlowski@canonical.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, Tamseel Shams <m.shams@samsung.com>
Subject: Re: [PATCH v3] serial: samsung: use dma_ops of DMA if attached
Message-ID: <202106260603.rah2UyG9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622091710.44032-1-m.shams@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: bcygtiw3CD7cdfQvPllNa-EdKg44e4KT
X-Proofpoint-GUID: bcygtiw3CD7cdfQvPllNa-EdKg44e4KT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Tamseel,

url:    https://github.com/0day-ci/linux/commits/Tamseel-Shams/serial-samsung-use-dma_ops-of-DMA-if-attached/20210622-195936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: parisc-randconfig-m031-20210625 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/tty/serial/samsung_tty.c:347 s3c24xx_serial_tx_dma_complete() error: we previously assumed 'dma' could be null (see line 344)
drivers/tty/serial/samsung_tty.c:347 s3c24xx_serial_tx_dma_complete() error: we previously assumed 'dma->tx_chan' could be null (see line 344)
drivers/tty/serial/samsung_tty.c:458 s3c24xx_serial_start_tx_dma() error: we previously assumed 'dma' could be null (see line 452)
drivers/tty/serial/samsung_tty.c:538 s3c24xx_uart_copy_rx_to_tty() error: we previously assumed 'dma' could be null (see line 532)
drivers/tty/serial/samsung_tty.c:664 s3c64xx_start_rx_dma() error: we previously assumed 'dma' could be null (see line 661)
drivers/tty/serial/samsung_tty.c:1132 s3c24xx_serial_request_dma() warn: variable dereferenced before check 'dma' (see line 1077)

Old smatch warnings:
drivers/tty/serial/samsung_tty.c:2129 s3c24xx_serial_init_port() warn: missing error code 'ret'

vim +/dma +347 drivers/tty/serial/samsung_tty.c

29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  332  static void s3c24xx_serial_tx_dma_complete(void *args)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  333  {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  334  	struct s3c24xx_uart_port *ourport = args;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  335  	struct uart_port *port = &ourport->port;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  336  	struct circ_buf *xmit = &port->state->xmit;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  337  	struct s3c24xx_uart_dma *dma = ourport->dma;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  338  	struct dma_tx_state state;
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  339  	struct device *dma_map_ops_dev = ourport->port.dev;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  340  	unsigned long flags;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  341  	int count;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  342  
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  343  	/* Null pointer check for "dma" and "dma->tx_chan" */
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22 @344  	if (dma && dma->tx_chan)
                                                                                            ^^^
Check for NULL

36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  345  		dma_map_ops_dev = dma->tx_chan->device->dev;
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  346  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10 @347  	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
                                                                                                            ^^^^^^^^^^^^
Unchecked dereference

29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  348  	count = dma->tx_bytes_requested - state.residue;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  349  	async_tx_ack(dma->tx_desc);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  350  
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  351  	dma_sync_single_for_cpu(dma_map_ops_dev, dma->tx_transfer_addr,
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  352  				dma->tx_size, DMA_TO_DEVICE);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  353  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  354  	spin_lock_irqsave(&port->lock, flags);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  355  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  356  	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  357  	port->icount.tx += count;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  358  	ourport->tx_in_progress = 0;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  359  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  360  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  361  		uart_write_wakeup(port);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  362  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  363  	s3c24xx_serial_start_next_tx(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  364  	spin_unlock_irqrestore(&port->lock, flags);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  365  }
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  366  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  367  static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  368  {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  369  	struct uart_port *port = &ourport->port;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  370  	u32 ucon;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  371  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  372  	/* Mask Tx interrupt */
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  373  	switch (ourport->info->type) {
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  374  	case TYPE_S3C6400:
bbb5ff91225dfb drivers/tty/serial/samsung.c     Matthew Leach       2016-06-22  375  		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  376  		break;
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  377  	case TYPE_APPLE_S5L:
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  378  		WARN_ON(1); // No DMA
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  379  		break;
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  380  	default:
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  381  		disable_irq_nosync(ourport->tx_irq);
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  382  		break;
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  383  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  384  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  385  	/* Enable tx dma mode */
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  386  	ucon = rd_regl(port, S3C2410_UCON);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  387  	ucon &= ~(S3C64XX_UCON_TXBURST_MASK | S3C64XX_UCON_TXMODE_MASK);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  388  	ucon |= (dma_get_cache_alignment() >= 16) ?
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  389  		S3C64XX_UCON_TXBURST_16 : S3C64XX_UCON_TXBURST_1;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  390  	ucon |= S3C64XX_UCON_TXMODE_DMA;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  391  	wr_regl(port,  S3C2410_UCON, ucon);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  392  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  393  	ourport->tx_mode = S3C24XX_TX_DMA;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  394  }
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  395  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  396  static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  397  {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  398  	struct uart_port *port = &ourport->port;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  399  	u32 ucon, ufcon;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  400  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  401  	/* Set ufcon txtrig */
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  402  	ourport->tx_in_progress = S3C24XX_TX_PIO;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  403  	ufcon = rd_regl(port, S3C2410_UFCON);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  404  	wr_regl(port,  S3C2410_UFCON, ufcon);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  405  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  406  	/* Enable tx pio mode */
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  407  	ucon = rd_regl(port, S3C2410_UCON);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  408  	ucon &= ~(S3C64XX_UCON_TXMODE_MASK);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  409  	ucon |= S3C64XX_UCON_TXMODE_CPU;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  410  	wr_regl(port,  S3C2410_UCON, ucon);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  411  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  412  	/* Unmask Tx interrupt */
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  413  	switch (ourport->info->type) {
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  414  	case TYPE_S3C6400:
bbb5ff91225dfb drivers/tty/serial/samsung.c     Matthew Leach       2016-06-22  415  		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD,
bbb5ff91225dfb drivers/tty/serial/samsung.c     Matthew Leach       2016-06-22  416  				  S3C64XX_UINTM);
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  417  		break;
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  418  	case TYPE_APPLE_S5L:
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  419  		ucon |= APPLE_S5L_UCON_TXTHRESH_ENA_MSK;
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  420  		wr_regl(port, S3C2410_UCON, ucon);
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  421  		break;
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  422  	default:
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  423  		enable_irq(ourport->tx_irq);
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  424  		break;
aaf144059ba474 drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  425  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  426  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  427  	ourport->tx_mode = S3C24XX_TX_PIO;
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  428  
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  429  	/*
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  430  	 * The Apple version only has edge triggered TX IRQs, so we need
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  431  	 * to kick off the process by sending some characters here.
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  432  	 */
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  433  	if (ourport->info->type == TYPE_APPLE_S5L)
fcbba344907afe drivers/tty/serial/samsung_tty.c Hector Martin       2021-03-05  434  		s3c24xx_serial_tx_chars(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  435  }
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  436  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  437  static void s3c24xx_serial_start_tx_pio(struct s3c24xx_uart_port *ourport)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  438  {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  439  	if (ourport->tx_mode != S3C24XX_TX_PIO)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  440  		enable_tx_pio(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  441  }
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  442  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  443  static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  444  				      unsigned int count)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  445  {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  446  	struct uart_port *port = &ourport->port;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  447  	struct circ_buf *xmit = &port->state->xmit;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  448  	struct s3c24xx_uart_dma *dma = ourport->dma;
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  449  	struct device *dma_map_ops_dev = ourport->port.dev;
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  450  
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  451  	/* Null pointer check for "dma" and "dma->tx_chan" */
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22 @452  	if (dma && dma->tx_chan)
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  453  		dma_map_ops_dev = dma->tx_chan->device->dev;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  454  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  455  	if (ourport->tx_mode != S3C24XX_TX_DMA)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  456  		enable_tx_dma(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  457  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10 @458  	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  459  	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  460  
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  461  	dma_sync_single_for_device(dma_map_ops_dev, dma->tx_transfer_addr,
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  462  				dma->tx_size, DMA_TO_DEVICE);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  463  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  464  	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  465  				dma->tx_transfer_addr, dma->tx_size,
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  466  				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  467  	if (!dma->tx_desc) {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  468  		dev_err(ourport->port.dev, "Unable to get desc for Tx\n");
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  469  		return -EIO;
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  470  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  471  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  472  	dma->tx_desc->callback = s3c24xx_serial_tx_dma_complete;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  473  	dma->tx_desc->callback_param = ourport;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  474  	dma->tx_bytes_requested = dma->tx_size;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  475  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  476  	ourport->tx_in_progress = S3C24XX_TX_DMA;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  477  	dma->tx_cookie = dmaengine_submit(dma->tx_desc);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  478  	dma_async_issue_pending(dma->tx_chan);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  479  	return 0;
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  480  }
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  481  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  482  static void s3c24xx_serial_start_next_tx(struct s3c24xx_uart_port *ourport)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  483  {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  484  	struct uart_port *port = &ourport->port;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  485  	struct circ_buf *xmit = &port->state->xmit;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  486  	unsigned long count;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  487  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  488  	/* Get data size up to the end of buffer */
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  489  	count = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  490  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  491  	if (!count) {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  492  		s3c24xx_serial_stop_tx(port);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  493  		return;
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  494  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  495  
81ccb2a69f76b8 drivers/tty/serial/samsung.c     Marek Szyprowski    2015-07-31  496  	if (!ourport->dma || !ourport->dma->tx_chan ||
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga      2015-07-31  497  	    count < ourport->min_dma_size ||
736cd79f483fd7 drivers/tty/serial/samsung.c     Robert Baldyga      2015-07-31  498  	    xmit->tail & (dma_get_cache_alignment() - 1))
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  499  		s3c24xx_serial_start_tx_pio(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  500  	else
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  501  		s3c24xx_serial_start_tx_dma(ourport, count);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  502  }
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  503  
75781979f8d33e drivers/tty/serial/samsung.c     Krzysztof Kozlowski 2015-05-02  504  static void s3c24xx_serial_start_tx(struct uart_port *port)
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  505  {
b73c289cc90138 drivers/serial/samsung.c         Ben Dooks           2008-10-21  506  	struct s3c24xx_uart_port *ourport = to_ourport(port);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  507  	struct circ_buf *xmit = &port->state->xmit;
b73c289cc90138 drivers/serial/samsung.c         Ben Dooks           2008-10-21  508  
8336240ebb248b drivers/tty/serial/samsung_tty.c Greg Kroah-Hartman  2019-12-17  509  	if (!ourport->tx_enabled) {
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  510  		if (port->flags & UPF_CONS_FLOW)
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  511  			s3c24xx_serial_rx_disable(port);
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  512  
8336240ebb248b drivers/tty/serial/samsung_tty.c Greg Kroah-Hartman  2019-12-17  513  		ourport->tx_enabled = 1;
ba019a3e2ad53d drivers/tty/serial/samsung.c     Robert Baldyga      2015-01-28  514  		if (!ourport->dma || !ourport->dma->tx_chan)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  515  			s3c24xx_serial_start_tx_pio(ourport);
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  516  	}
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  517  
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  518  	if (ourport->dma && ourport->dma->tx_chan) {
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  519  		if (!uart_circ_empty(xmit) && !ourport->tx_in_progress)
29bef79908459d drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  520  			s3c24xx_serial_start_next_tx(ourport);
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  521  	}
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  522  }
b497549a035c2a drivers/serial/samsung.c         Ben Dooks           2008-07-03  523  
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  524  static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  525  		struct tty_port *tty, int count)
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  526  {
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  527  	struct s3c24xx_uart_dma *dma = ourport->dma;
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  528  	struct device *dma_map_ops_dev = ourport->port.dev;
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  529  	int copied;
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  530  
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  531  	/* Null pointer check for "dma" and "dma->rx_chan" */
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22 @532  	if (dma && dma->rx_chan)
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  533  		dma_map_ops_dev = dma->rx_chan->device->dev;
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22  534  
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  535  	if (!count)
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  536  		return;
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  537  
36f392dcc64c96 drivers/tty/serial/samsung_tty.c Tamseel Shams       2021-06-22 @538  	dma_sync_single_for_cpu(dma_map_ops_dev, dma->rx_addr,
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  539  				dma->rx_size, DMA_FROM_DEVICE);
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  540  
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  541  	ourport->port.icount.rx += count;
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  542  	if (!tty) {
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  543  		dev_err(ourport->port.dev, "No tty port\n");
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  544  		return;
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  545  	}
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  546  	copied = tty_insert_flip_string(tty,
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  547  			((unsigned char *)(ourport->dma->rx_buf)), count);
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  548  	if (copied != count) {
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  549  		WARN_ON(1);
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  550  		dev_err(ourport->port.dev, "RxData copy to tty layer failed\n");
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  551  	}
b543c301c2c5fb drivers/tty/serial/samsung.c     Robert Baldyga      2014-12-10  552  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

