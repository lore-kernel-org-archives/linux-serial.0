Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61460C433FE
	for <linux-serial@archiver.kernel.org>; Sun, 20 Nov 2022 10:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKTKn1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 20 Nov 2022 05:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTKnZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Nov 2022 05:43:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DED812D04;
        Sun, 20 Nov 2022 02:43:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E264660C26;
        Sun, 20 Nov 2022 10:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E80C433C1;
        Sun, 20 Nov 2022 10:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668941003;
        bh=hLIopbsnkZXEWa0jZnTmGnZwva+kc5FQSOWtuZHmza4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7qtsoZ8b04G25CKrYlSPqXeZ6ut1+TEmOhEW250vBTdI+2Vwci3RJ1pTbi+arrcW
         Ar2vdz7Kn4dCf6/U5gEy+yfg9p8pOYi38pLLZfTp80wre0aNYnLOVDP/h8vJq1Jn2j
         QdZ6hy7vrm9I7cQb29I0eGfbANIswcTiI8loNRO/wMr50QoUOKTGw8YSRQ70hwIqV6
         XhN+bLxPA+gFWV2WAcC3vL1Mg04lZbxblSvsCUXDiUOTj1TMlSCHmxD9FhdKZV+ZzN
         mv7yIwPaZe4WG1icB7lv6c48TfsYAVXBIegt571iVR9y5mKTQva9JoTfxaQmQsv5PF
         JjwAPOwVk4YRw==
Date:   Sun, 20 Nov 2022 10:43:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/7] riscv: add the Bouffalolab SoC family Kconfig option
Message-ID: <Y3oExmuiH95NWGUL@spud>
References: <20221120082114.3030-1-jszhang@kernel.org>
 <20221120082114.3030-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120082114.3030-5-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Nov 20, 2022 at 04:21:11PM +0800, Jisheng Zhang wrote:
> The Bouffalolab bl808 SoC contains three riscv CPUs, namely M0, D0 and
> LP. The D0 is 64bit RISC-V GC compatible, so can run linux.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Could you also add this new SOC_BOUFFALOLAB symbol to defconfig please?

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig.socs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 69774bb362d6..90256f44ed4a 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -1,5 +1,11 @@
>  menu "SoC selection"
>  
> +config SOC_BOUFFALOLAB
> +	bool "Bouffalolab SoCs"
> +	select SIFIVE_PLIC
> +	help
> +	  This enables support for Bouffalolab SoC platforms.
> +
>  config SOC_MICROCHIP_POLARFIRE
>  	bool "Microchip PolarFire SoCs"
>  	select MCHP_CLK_MPFS
> -- 
> 2.37.2
> 
