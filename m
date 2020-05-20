Return-Path: <SRS0=iED7=7C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6221FC433DF
	for <linux-serial@archiver.kernel.org>; Wed, 20 May 2020 08:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F14207ED
	for <linux-serial@archiver.kernel.org>; Wed, 20 May 2020 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589964675;
	bh=m6WgH2wUiMinCLHsEKpQVucidQ/rylUlA4pvF2bZGos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MgnqwSfh3YBLKbhom1c4D+WIR9LICtlWWHbBt5yGGJ3O18d0FnLXCZPTX5lbPDYYt
	 2L+JDHMVfrg8ayMUYQ5fxdA7Ivq8WxxOGK77H5fmSuRdxSWt3SCgx5kuPp6MIswHEy
	 Fda4uFtqywUtoTJapLVtTeutoAiTgNY3FWUeILpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETIvO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 May 2020 04:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETIvO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 May 2020 04:51:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4F12075F;
        Wed, 20 May 2020 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589964674;
        bh=m6WgH2wUiMinCLHsEKpQVucidQ/rylUlA4pvF2bZGos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P7xVjdL8CCiApRsAPSCtyHftfAAn0KoMaM5H87JBl8Hh25cR1AMeqcHB3jWNhEt1+
         9cBd32i35AffKFXJPlWLtfemMEHmllZUZiWL2p9/eowHeWldoOu8hIRlwIUeTPFAo2
         kVdlgVKXyUJmjFkUCyC1x6BdNOTAg52syJil9sL8=
Date:   Wed, 20 May 2020 10:51:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     gengcixi@gmail.com
Cc:     oberpar@linux.ibm.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, jslaby@suse.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, Cixi Geng <cixi.geng1@unisoc.com>
Subject: Re: [RFC][PATCH V2] GCOV: profile by modules
Message-ID: <20200520085111.GE2837844@kroah.com>
References: <20200520083821.9602-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520083821.9602-1-gengcixi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 20, 2020 at 04:38:21PM +0800, gengcixi@gmail.com wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> ---
> Replace symbol GCOV_PROFILE_MODULES with GCOV_PROFILE_PREREQS
> ---
> The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
> kernel which will lead to kernel run slower.Use GCOV_PROFILE_PREREQS
> to control part of the kernel modules to open gcov.
> 
> Only add SERIAL_GCOV for an example.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/tty/serial/Kconfig  |  6 ++++++
>  drivers/tty/serial/Makefile |  1 +
>  kernel/gcov/Kconfig         | 14 ++++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index adf9e80e7dc9..964df1a2989c 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1566,3 +1566,9 @@ endmenu
>  
>  config SERIAL_MCTRL_GPIO
>  	tristate
> +
> +config SERIAL_GCOV
> +       bool "open gcov for serial"

What do you mean by "open"?  And Kconfig entries are usually Upper Case" :)

> +       depends on GCOV_PROFILE_PREREQS
> +       help
> +         Say Y here to enable gcov in serial.

I think we need more text here.


> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index d056ee6cca33..7be1202286d2 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -2,6 +2,7 @@
>  #
>  # Makefile for the kernel serial device drivers.
>  #
> +GCOV_PROFILE := $(CONFIG_SERIAL_GCOV)
>  
>  obj-$(CONFIG_SERIAL_CORE) += serial_core.o
>  
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index 3941a9c48f83..91cc8f3c7c43 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -51,6 +51,20 @@ config GCOV_PROFILE_ALL
>  	larger and run slower. Also be sure to exclude files from profiling
>  	which are not linked to the kernel image to prevent linker errors.
>  
> +config GCOV_PROFILE_PREREQS
> +	bool "Profile Kernel subsytem"
> +	depends on !COMPILE_TEST
> +	depends on GCOV_KERNEL
> +	default n

default is always 'n', no need to list that

> +	help
> +	This options activates profiling for the specified kernel modules.
> +
> +	If unsure, say N.
> +
> +	When some modules need Gcov data, enable this config, then configure
> +	with gcov on the corresponding modules configs.The directories or files

'. '?

> +	of these modules will be added profiling flags after kernel compile.

The lines under "help" need to be indented more, right?

thanks,

greg k-h
