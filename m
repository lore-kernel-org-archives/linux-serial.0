Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928CCC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 28 Feb 2022 04:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiB1Ehd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Feb 2022 23:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiB1Ehd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Feb 2022 23:37:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C45F54BE5
        for <linux-serial@vger.kernel.org>; Sun, 27 Feb 2022 20:36:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DBE8C212BB;
        Mon, 28 Feb 2022 04:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646023013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfRNTPZQgWipzG+NhAYugx1yIfbOpEw9M196aKUnPe0=;
        b=Kz2VbvzoB24gvTiuKJaq/fXUgMvMfj/SF13Y/diOS4G7tMAG4jD3s3Ra5wi2MhWYWMcam3
        oUvHt3sK2S3yUNxg+/kKJAybWKqDU6+0CdLFgmHiKTfSkgbJuSTcIbN21XvwVcPFpYzqJ9
        IrF0cAVrTYjylW4u8sM6YgXHCJQIL88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646023013;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfRNTPZQgWipzG+NhAYugx1yIfbOpEw9M196aKUnPe0=;
        b=VT7QUuJ+x5A9rGQ/Uv3zw9CM9VlOuWfNogIwIObvtmnBUTXUp3xr31FFlPNw3E4XTN76yY
        fCHHgUBj7l06ToAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9946139BD;
        Mon, 28 Feb 2022 04:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dBgtKGVRHGIlcgAAMHmgww
        (envelope-from <jslaby@suse.cz>); Mon, 28 Feb 2022 04:36:53 +0000
Message-ID: <f3c45778-851b-2a26-afe0-d109adb3667a@suse.cz>
Date:   Mon, 28 Feb 2022 05:36:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [tty:tty-testing 31/42] drivers/mmc/core/sdio_uart.c:253:16:
 error: implicit declaration of function 'UART_LCR_WLEN'; did you mean
 'UART_LCR_WLEN5'?
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <202202260105.p77piygB-lkp@intel.com>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <202202260105.p77piygB-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25. 02. 22, 19:34, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> head:   a6d8f09319fff9e6e7a91cadb19923b8cb2573e0
> commit: b6f8eaea0cf1afe2500f8af7b6cc805647fe4889 [31/42] sdio_uart: make use of UART_LCR_WLEN() + tty_get_char_size()
> config: arc-randconfig-r043-20220225 (https://download.01.org/0day-ci/archive/20220226/202202260105.p77piygB-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=b6f8eaea0cf1afe2500f8af7b6cc805647fe4889
>          git remote add tty https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
>          git fetch --no-tags tty tty-testing
>          git checkout b6f8eaea0cf1afe2500f8af7b6cc805647fe4889
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/mmc/core/sdio_uart.c: In function 'sdio_uart_change_speed':
>>> drivers/mmc/core/sdio_uart.c:253:16: error: implicit declaration of function 'UART_LCR_WLEN'; did you mean 'UART_LCR_WLEN5'? [-Werror=implicit-function-declaration]
>       253 |         cval = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
>           |                ^~~~~~~~~~~~~
>           |                UART_LCR_WLEN5
>     cc1: some warnings being treated as errors
> 
> 
> vim +253 drivers/mmc/core/sdio_uart.c

This is caused by the move to serial.h. Apart from sdio_uart, these 
drivers do not include serial.h directly (but apart from sdio_uart are 
able to compile, i.e. include it via some chain):
drivers/tty/serial/8250/8250_omap.c
drivers/tty/serial/jsm/jsm_neo.c
drivers/tty/serial/omap-serial.c
drivers/tty/serial/pxa.c

thanks,
-- 
js
suse labs
