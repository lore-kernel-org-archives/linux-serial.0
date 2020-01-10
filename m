Return-Path: <SRS0=sEmL=27=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF6DC282DD
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 19:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D680205F4
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jan 2020 19:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgAJTCE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jan 2020 14:02:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:36147 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728457AbgAJTCD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jan 2020 14:02:03 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:02:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="gz'50?scan'50,208,50";a="231804671"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2020 11:02:01 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ipzXk-000DF4-MH; Sat, 11 Jan 2020 03:02:00 +0800
Date:   Sat, 11 Jan 2020 03:01:36 +0800
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
Message-ID: <202001110232.149OcncN%lkp@intel.com>
References: <20200109215444.95995-4-dima@arista.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="izntkxzrgn456fr4"
Content-Disposition: inline
In-Reply-To: <20200109215444.95995-4-dima@arista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


--izntkxzrgn456fr4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dmitry,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on next-20200109]
[cannot apply to linux/master usb/usb-testing linus/master v5.5-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Safonov/serial-sysrq-Add-MAGIC_SYSRQ_SERIAL_SEQUENCE/20200110-191606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: microblaze-nommu_defconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=microblaze 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/serial/serial_core.c:3084:33: error: 'CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE' undeclared here (not in a function)
    const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/serial_core.c: In function 'uart_sysrq_on':
>> drivers/tty/serial/serial_core.c:3088:2: error: implicit declaration of function 'sysrq_toggle_support' [-Werror=implicit-function-declaration]
     sysrq_toggle_support(1);
     ^~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/serial_core.c: In function 'uart_handle_sysrq_char':
>> drivers/tty/serial/serial_core.c:3125:7: error: implicit declaration of function 'sysrq_get_mask'; did you mean 'xas_get_mark'? [-Werror=implicit-function-declaration]
      if (sysrq_get_mask()) {
          ^~~~~~~~~~~~~~
          xas_get_mark
   cc1: some warnings being treated as errors

vim +/CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE +3084 drivers/tty/serial/serial_core.c

  3083	
> 3084	const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
  3085	
  3086	static void uart_sysrq_on(struct work_struct *w)
  3087	{
> 3088		sysrq_toggle_support(1);
  3089		pr_info("SysRq is enabled by magic sequience on serial\n");
  3090	}
  3091	static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
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
  3105		if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
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
  3116	int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
  3117	{
  3118		if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
  3119			return 0;
  3120	
  3121		if (!port->has_sysrq || !port->sysrq)
  3122			return 0;
  3123	
  3124		if (ch && time_before(jiffies, port->sysrq)) {
> 3125			if (sysrq_get_mask()) {
  3126				handle_sysrq(ch);
  3127				port->sysrq = 0;
  3128				return 1;
  3129			}
  3130			if (uart_try_toggle_sysrq(port, ch))
  3131				return 1;
  3132		}
  3133		port->sysrq = 0;
  3134	
  3135		return 0;
  3136	}
  3137	EXPORT_SYMBOL_GPL(uart_handle_sysrq_char);
  3138	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--izntkxzrgn456fr4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--izntkxzrgn456fr4--
