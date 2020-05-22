Return-Path: <SRS0=CVbj=7E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D6FC433E1
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 08:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A067220757
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 08:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590136640;
	bh=j6qtTP5kv+N7sEEXX9Q96Y4lswh83lQW35iSocg99dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s2ASsP0uvEgJOwbX792+T3HN9ZbXQ8pYIrA++d+edm+LOHxzyRjmUqS0gnfrNLPvw
	 19R82J7ZEic/W5jLkxokw3MM/cB7RS3YZbvuOLbXAk51p+zC7S/74xX6WhxAoaOLBW
	 GmjeVg4ZaPPFNeCJe3xxs64yitr+ecSf8yvDv540=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgEVIhS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 May 2020 04:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbgEVIhR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 May 2020 04:37:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F235920814;
        Fri, 22 May 2020 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590136637;
        bh=j6qtTP5kv+N7sEEXX9Q96Y4lswh83lQW35iSocg99dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xgbRAsgTMT3V2eFlfwqVTRSD5KsXdqwPZntM7v++sw+uUuiHNsIvx6ZaaosN/xCpF
         MK+GLjxzYzyPDUSWac6bAu0laPUywevioKUxlHJC2dKNQicn8x1eRyNR4PJygBvOae
         pPSbjsAqOS74g7BaFQVGQn5z0Oso0r8rvK0v0yKM=
Date:   Fri, 22 May 2020 10:37:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     gengcixi@gmail.com
Cc:     jslaby@suse.com, oberpar@linux.ibm.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
Subject: Re: [RFC][PATCH V3] GCOV: profile by modules
Message-ID: <20200522083715.GD1078778@kroah.com>
References: <20200522071917.17163-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522071917.17163-1-gengcixi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 22, 2020 at 03:19:17PM +0800, gengcixi@gmail.com wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
> kernel which will lead to kernel run slower.Use GCOV_PROFILE_PREREQS
> to control part of the kernel modules to open gcov.
> 
> Only add SERIAL_GCOV for an example.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/tty/serial/Kconfig  |  7 +++++++
>  drivers/tty/serial/Makefile |  1 +
>  kernel/gcov/Kconfig         | 13 +++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index adf9e80e7dc9..6df002370f18 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1566,3 +1566,10 @@ endmenu
>  
>  config SERIAL_MCTRL_GPIO
>  	tristate
> +
> +config SERIAL_GCOV
> +	bool "Enable profile gcov for serial directory"
> +	depends on GCOV_PROFILE_PREREQS
> +	help
> +	  The SERIAL_GCOV will add Gcov profiling flags when kernel compiles.
> +	  Say 'Y' here if you want the gcov data for the serial directory,
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index d056ee6cca33..17272733db95 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the kernel serial device drivers.
>  #
>  
> +GCOV_PROFILE := $(CONFIG_SERIAL_GCOV)
>  obj-$(CONFIG_SERIAL_CORE) += serial_core.o
>  
>  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index 3941a9c48f83..4d75fa158726 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -51,6 +51,19 @@ config GCOV_PROFILE_ALL
>  	larger and run slower. Also be sure to exclude files from profiling
>  	which are not linked to the kernel image to prevent linker errors.
>  
> +config GCOV_PROFILE_PREREQS
> +	bool "Profile Kernel subsytem"
> +	depends on !COMPILE_TEST
> +	depends on GCOV_KERNEL
> +	help
> +	  This options activates profiling for the specified kernel modules.
> +
> +	  When some modules need Gcov data, enable this config, then configure
> +	  with gcov on the corresponding modules,The directories or files of
> +	  these modules will be added profiling flags after kernel compile.
> +
> +	  If unsure, say N.
> +
>  choice
>  	prompt "Specify GCOV format"
>  	depends on GCOV_KERNEL


I understand the goal here, but don't you need to have the main GCov
option depend on your new Kconfig option here?  You have it switched
around here, so what keeps all code from being built with gcov support
at the moment?

thanks,

greg k-h
