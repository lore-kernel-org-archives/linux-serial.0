From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [tty:tty-next 42/62] drivers/tty/serial/sccnxp.c:894 sccnxp_probe()
 error: we previously assumed 'pdata' could be null (see line 887)
Date: Thu, 17 Jan 2013 09:22:42 +0800
Message-ID: <20130117012242.GC7017@localhost>
References: <50f6ed06.V0pPrMkDV2E8vACU%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33041 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755150Ab3AQBWr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 20:22:47 -0500
Content-Disposition: inline
In-Reply-To: <50f6ed06.V0pPrMkDV2E8vACU%fengguang.wu@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org


Hi Alexander,

FYI, there are new smatch warnings show up in

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
head:   e27a7d7977b07d701ba247e2ddb95466d95c898f
commit: ec063899b7b308019afa9f5eb32f0a58a6c6ee53 [42/62] serial: sccnxp: Implement polling mode

New smatch warnings:
drivers/tty/serial/sccnxp.c:894 sccnxp_probe() error: we previously assumed 'pdata' could be null (see line 887)

vim +/pdata +894 drivers/tty/serial/sccnxp.c

1d65c0b1 Alexander Shiyan 2012-08-25  881  	default:
1d65c0b1 Alexander Shiyan 2012-08-25  882  		dev_err(&pdev->dev, "Unsupported chip type %i\n", chiptype);
1d65c0b1 Alexander Shiyan 2012-08-25  883  		ret = -ENOTSUPP;
1d65c0b1 Alexander Shiyan 2012-08-25  884  		goto err_out;
1d65c0b1 Alexander Shiyan 2012-08-25  885  	}
1d65c0b1 Alexander Shiyan 2012-08-25  886  
1d65c0b1 Alexander Shiyan 2012-08-25 @887  	if (!pdata) {
1d65c0b1 Alexander Shiyan 2012-08-25  888  		dev_warn(&pdev->dev,
1d65c0b1 Alexander Shiyan 2012-08-25  889  			 "No platform data supplied, using defaults\n");
1d65c0b1 Alexander Shiyan 2012-08-25  890  		s->pdata.frequency = s->freq_std;
1d65c0b1 Alexander Shiyan 2012-08-25  891  	} else
1d65c0b1 Alexander Shiyan 2012-08-25  892  		memcpy(&s->pdata, pdata, sizeof(struct sccnxp_pdata));
1d65c0b1 Alexander Shiyan 2012-08-25  893  
ec063899 Alexander Shiyan 2012-12-03 @894  	if (pdata->poll_time_us) {
ec063899 Alexander Shiyan 2012-12-03  895  		dev_info(&pdev->dev, "Using poll mode, resolution %u usecs\n",
ec063899 Alexander Shiyan 2012-12-03  896  			 pdata->poll_time_us);
ec063899 Alexander Shiyan 2012-12-03  897  		s->poll = 1;

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
