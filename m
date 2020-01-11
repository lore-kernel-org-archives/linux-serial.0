Return-Path: <SRS0=GYIK=3A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3B7C33C9E
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jan 2020 10:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C6320842
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jan 2020 10:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgAKKxP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:53:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:61226 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbgAKKxP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jan 2020 05:53:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2020 02:53:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,420,1571727600"; 
   d="scan'208";a="396678241"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2020 02:53:13 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iqEOG-0006jI-P0; Sat, 11 Jan 2020 18:53:12 +0800
Date:   Sat, 11 Jan 2020 18:52:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Message-ID: <202001111841.jHEbSpeP%lkp@intel.com>
References: <20200109215444.95995-4-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109215444.95995-4-dima@arista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Dmitry,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on next-20200110]
[cannot apply to linux/master usb/usb-testing linus/master v5.5-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Safonov/serial-sysrq-Add-MAGIC_SYSRQ_SERIAL_SEQUENCE/20200110-191606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

New smatch warnings:
drivers/tty/serial/serial_core.c:3105 uart_try_toggle_sysrq() warn: unsigned '++port->sysrq_seq' is never less than zero.

Old smatch warnings:
drivers/tty/serial/serial_core.c:295 uart_shutdown() error: we previously assumed 'uport' could be null (see line 291)
drivers/tty/serial/serial_core.c:2729 uart_get_attr_iomem_base() warn: argument 4 to %lX specifier is cast from pointer

vim +3105 drivers/tty/serial/serial_core.c

  3092	
  3093	static int uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
  3094	{
  3095		if (sysrq_toggle_seq[0] == '\0')
  3096			return 0;
  3097	
  3098		BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= sizeof(port->sysrq_seq)*U8_MAX);
  3099		if (sysrq_toggle_seq[port->sysrq_seq] != ch) {
  3100			port->sysrq_seq = 0;
  3101			return 0;
  3102		}
  3103	
  3104		/* Without the last \0 */
> 3105		if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
  3106			port->sysrq = jiffies + HZ*5;
  3107			return 1;
  3108		}
  3109	
  3110		schedule_work(&sysrq_enable_work);
  3111	
  3112		port->sysrq = 0;
  3113		return 1;
  3114	}
  3115	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
