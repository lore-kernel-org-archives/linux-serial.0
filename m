Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EE8C433FE
	for <linux-serial@archiver.kernel.org>; Thu,  3 Nov 2022 02:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKCC2F (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Nov 2022 22:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKCC1x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Nov 2022 22:27:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCAD12AE2
        for <linux-serial@vger.kernel.org>; Wed,  2 Nov 2022 19:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA4661CE7
        for <linux-serial@vger.kernel.org>; Thu,  3 Nov 2022 02:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B4BC433D7;
        Thu,  3 Nov 2022 02:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667442471;
        bh=IpF7qsIuzPoNt2pcicHumqQnTYqJNl2kihF9TkDrmv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEbAj7Tp+LQP9yzInMUy877sFKa98i1ERepcS8vji7hquSD13ieLdgw4vxt3Ka824
         8Rb8SoavMSfdpIQcwKvezcck50i9V+ELaxko6ZnbKzY2j1hluuWppD8gFiUXSh9qCY
         T4kXuynQxZijJqdvnFVXR4KFZnZYKuEjbiRvAkAw=
Date:   Thu, 3 Nov 2022 03:28:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        robh@kernel.org, ztong0001@gmail.com, peter@hurleysoftware.com
Subject: Re: [PATCH] earlycon: Fix compile error when SERIAL_CORE is m
Message-ID: <Y2MnX4nlpKookDx5@kroah.com>
References: <20221020032722.3263846-1-zhangxiaoxu5@huawei.com>
 <Y1DW9Q5HLsh4kBnm@kroah.com>
 <74352a7a-2a3a-c26d-9687-c31eed699a4e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74352a7a-2a3a-c26d-9687-c31eed699a4e@huawei.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 20, 2022 at 09:20:24PM +0800, zhangxiaoxu (A) wrote:
> 
> 
> On 2022/10/20 13:04, Greg KH wrote:
> > On Thu, Oct 20, 2022 at 11:27:22AM +0800, Zhang Xiaoxu wrote:
> > > When set CONFIG_SERIAL_EARLYCON=y and CONFIG_SERIAL_CORE=m, there is
> > > a compile error as below:
> > > 
> > >    ld: vmlinux.o: in function `parse_options.constprop.0':
> > >    earlycon.c:(.init.text+0xba5a3): undefined reference to `uart_parse_earlycon'
> > > 
> > > Since the SERIAL_EARLYCON use 'uart_parse_earlycon' which defined in
> > > SERIAL_CORE, so should select rather than depends on.
> > 
> > No, please try to never use "select".
> > 
> > > 
> > > Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")
> > 
> > So this has been a problem for a very very long time and never been
> > seen until now?  That feels wrong, what changed to cause this to not
> > ever be hit before with all of the tens of thousands of random configs
> > that have been built since this very old kernel?
> > 
> Yes, 0fb9342d06b0 ("tty: serial: earlycon dependency") already fix the
> same issue with add "depends on SERIAL_CORE".
> 
> But there are some other scenarios can trigger the same issue.
> 
> Use the config file in the bugzilla can reproduce the problem.
> https://bugzilla.kernel.org/show_bug.cgi?id=216611
> 
> Bisect with this config, find out the following commit introduce the issue:
>   cdcc41a256efe8 ("tty: serial: Kconfig: Allow SERIAL_QCOM_GENI_CONSOLE to be enabled if SERIAL_QCOM_GENI is a module")
> 
>  config SERIAL_QCOM_GENI
>         tristate "QCOM on-chip GENI based serial port support"
>         depends on ARCH_QCOM || COMPILE_TEST
>         depends on QCOM_GENI_SE
>         select SERIAL_CORE
> 
>  config SERIAL_QCOM_GENI_CONSOLE
>         bool "QCOM GENI Serial Console support"
> -       depends on SERIAL_QCOM_GENI=y
> +       depends on SERIAL_QCOM_GENI
>         select SERIAL_CORE_CONSOLE
>         select SERIAL_EARLYCON
>         help
>           Serial console driver for Qualcomm Technologies Inc's GENI based
>           QUP hardware.

Then this is an issue with that driver Kconfig options, not with the tty
core options.  Please fix it up there.

thanks,

greg k-h
