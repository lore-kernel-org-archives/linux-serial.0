Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15016C433FE
	for <linux-serial@archiver.kernel.org>; Sat, 23 Apr 2022 08:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiDWIlj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 23 Apr 2022 04:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiDWIli (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 23 Apr 2022 04:41:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E33111CA6
        for <linux-serial@vger.kernel.org>; Sat, 23 Apr 2022 01:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6D5AB802BD
        for <linux-serial@vger.kernel.org>; Sat, 23 Apr 2022 08:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19459C385A0;
        Sat, 23 Apr 2022 08:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650703118;
        bh=+XzOeAWMvSPBM4K58/BuOs63Zkk85+gbJehWkdpDQIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CsC7P6JeJqu8p8DeZ2+LEj2IOfLecshAJPsBeJzlQcxAdwAdZNPLHnxk67EZj5oOZ
         cYs/iIZpWpTuP46zJiEakGP4p/1ousLGJOJAExuf4k3Gfiag3oa9WcD2BmI//c662A
         5QQ05YLz4a2iH/qmB30Ab9RXHGmxetX387bcE/1w=
Date:   Sat, 23 Apr 2022 10:38:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Daniel Starke <daniel.starke@siemens.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-serial@vger.kernel.org
Subject: Re: [tty:tty-linus 23/26] drivers/tty/n_gsm.c:939:13: warning:
 variable 'size' is used uninitialized whenever 'if' condition is false
Message-ID: <YmO7C2dZTVxSNUQe@kroah.com>
References: <202204230704.5MxboEEo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204230704.5MxboEEo-lkp@intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Apr 23, 2022 at 07:42:41AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
> head:   637674fa40059cddcc3ad2212728965072f62ea3
> commit: c19ffe00fed6bb423d81406d2a7e5793074c7d83 [23/26] tty: n_gsm: fix invalid use of MSC in advanced option
> config: hexagon-randconfig-r035-20220422 (https://download.01.org/0day-ci/archive/20220423/202204230704.5MxboEEo-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=c19ffe00fed6bb423d81406d2a7e5793074c7d83
>         git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
>         git fetch --no-tags tty tty-linus
>         git checkout c19ffe00fed6bb423d81406d2a7e5793074c7d83
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/tty/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/tty/n_gsm.c:939:13: warning: variable 'size' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>            } else if (dlci->adaption == 2) {
>                       ^~~~~~~~~~~~~~~~~~~
>    drivers/tty/n_gsm.c:948:40: note: uninitialized use occurs here
>            msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
>                                                  ^~~~
>    drivers/tty/n_gsm.c:939:9: note: remove the 'if' if its condition is always true
>            } else if (dlci->adaption == 2) {
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/tty/n_gsm.c:934:10: note: initialize the variable 'size' to silence this warning
>            int size;
>                    ^
>                     = 0
>    1 warning generated.
> 

It's not obvious, but this should be fine as adaption is only 1 or 2
from what I can tell.

To make the compiler understand this easier, this should probably be an
enum and use switch statements.  Daniel, want to make that change?

thanks,

greg k-h
