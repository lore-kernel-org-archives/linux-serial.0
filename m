Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36997C2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 12:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A8B6162C
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 12:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFYMOY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 08:14:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9592 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229712AbhFYMOY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 08:14:24 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PC0nlW028687;
        Fri, 25 Jun 2021 12:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=uysn2tlq/rt/c+x0LkCBpI8ImCFpWQ+NZ17v8b2HBsA=;
 b=Wc8yyMvQA2cNovY+UvrudRUdKzlIBbHC80nHWbodpoW4tncOtAhkTg1xfpm6Qb/YAv3x
 JBZTpCAVXYQtcHTm0gBEiqvO1TXhoD/PfPoqCln7xBUX1kAMDgydVdQ07cRqN35UVtCY
 DSZ03f7v7oeW6IFfZXzofbMq47WS0P4oBGITRBKvCSV6qKc/oaVfwCZ957/wvOO/3eJ1
 fic+X6BcTUEcMeUZLcSxY2+hdHc+gnGzZgoTmlLwWrvpntUpHoi4dbEFwPpoMGSfyqCg
 QUWG+PBz7gL3fVqC8NFyaR9N5vKZU7jmEjNVVYXDw/VS3c/WQjBWBLzpxYGeEGMsGkEg fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2ahs66m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:11:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PCBOWG108579;
        Fri, 25 Jun 2021 12:11:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 39d23y07av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:11:56 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15PCBt4M109980;
        Fri, 25 Jun 2021 12:11:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 39d23y07a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:11:55 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15PCBrSF029193;
        Fri, 25 Jun 2021 12:11:53 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 05:11:52 -0700
Date:   Fri, 25 Jun 2021 15:11:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [tty:tty-testing 96/222] drivers/tty/serial/max310x.c:1430
 max310x_probe() warn: 's->clk' not released on lines: 1296.
Message-ID: <202106250724.d9BNqnQl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: 5PJ9o4HmMGdZvPSYrQzallLml3HE27ZV
X-Proofpoint-GUID: 5PJ9o4HmMGdZvPSYrQzallLml3HE27ZV
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   5607fa6c3da3189de1bac356c73bc4fcaf4c0234
commit: d4d6f03c4fb3a91dadfe147b47edd40e4d7e4d36 [96/222] serial: max310x: Try to get crystal clock rate from property
config: x86_64-randconfig-m001-20210622 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/tty/serial/max310x.c:1430 max310x_probe() warn: 's->clk' not released on lines: 1296.

vim +1430 drivers/tty/serial/max310x.c
  1285          }
  1286  
  1287          ret = clk_prepare_enable(s->clk);
  1288          if (ret)
  1289                  return ret;
  1290  
  1291          freq = clk_get_rate(s->clk);
  1292          if (freq == 0)
  1293                  freq = uartclk;
  1294          if (freq == 0) {
  1295                  dev_err(dev, "Cannot get clock rate\n");
  1296                  return -EINVAL;

goto out_clk?

  1297          }
  1298  
  1299          if (xtal) {
  1300                  fmin = 1000000;
  1301                  fmax = 4000000;
  1302          } else {
  1303                  fmin = 500000;
  1304                  fmax = 35000000;
  1305          }
  1306  
  1307          /* Check frequency limits */
  1308          if (freq < fmin || freq > fmax) {
  1309                  ret = -ERANGE;
  1310                  goto out_clk;
  1311          }
  1312  
  1313          s->regmap = regmap;
  1314          s->devtype = devtype;
  1315          dev_set_drvdata(dev, s);
  1316  
  1317          /* Check device to ensure we are talking to what we expect */
  1318          ret = devtype->detect(dev);
  1319          if (ret)
  1320                  goto out_clk;
  1321  
  1322          for (i = 0; i < devtype->nr; i++) {
  1323                  unsigned int offs = i << 5;
  1324  
  1325                  /* Reset port */
  1326                  regmap_write(s->regmap, MAX310X_MODE2_REG + offs,

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

