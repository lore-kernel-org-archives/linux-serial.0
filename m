Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54469CDB474
	for <linux-serial@archiver.kernel.org>; Tue, 17 Oct 2023 08:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjJQISv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Oct 2023 04:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQISu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Oct 2023 04:18:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990AD93
        for <linux-serial@vger.kernel.org>; Tue, 17 Oct 2023 01:18:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7450C433C7;
        Tue, 17 Oct 2023 08:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697530729;
        bh=acqlkjdBNTKMXpjASQiU4uaV/xt8NNpSCRDVAm1oAY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDnb4Ff8J+hlQnhISBee+1VWj6RBKnXqyK85dFyV4073220EHomOWx9EaXRmFX5e8
         OAOodXtgKbwhj8w5BUuW15JTxE/4CQX2Q/vDf0U2vNuQN2skSXoMep9r+9o0/RqjyA
         hofh3vXfh+CctNWLk9PBEacsCKpX38UgIHscCHRo=
Date:   Tue, 17 Oct 2023 10:18:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, oe-kbuild-all@lists.linux.dev,
        linux-serial@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [tty:tty-testing 22/24] earlycon.c:undefined reference to
 `screen_info'
Message-ID: <2023101722-outage-outward-a6d6@gregkh>
References: <202310170938.xHIu2lFB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310170938.xHIu2lFB-lkp@intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 17, 2023 at 09:44:58AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> head:   6271f1e8c4cb9a46273ae01ff9cb86a022063f75
> commit: 934d62223da320b3ec012c85b63a6c250f507096 [22/24] efi: move screen_info into efi init code
> config: loongarch-randconfig-002-20231017 (https://download.01.org/0day-ci/archive/20231017/202310170938.xHIu2lFB-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310170938.xHIu2lFB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310170938.xHIu2lFB-lkp@intel.com/

Arnd, I'll drop this commit from my tree now, if you want to fix it up
and resend just it, I'll be glad to apply it.

thanks,

greg k-h
