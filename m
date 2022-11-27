Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0712C43217
	for <linux-serial@archiver.kernel.org>; Sun, 27 Nov 2022 17:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiK0Rfu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Nov 2022 12:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiK0Rft (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Nov 2022 12:35:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB8DEE05;
        Sun, 27 Nov 2022 09:35:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D7160E05;
        Sun, 27 Nov 2022 17:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55508C433C1;
        Sun, 27 Nov 2022 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669570547;
        bh=hmMSrdZQRZh8vLDgc2r5Hj6yJHQNACP222q36LVyHeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzqzjaoFO1pCq7Zv9JCPZYOvn2NluPSyi+TvYx70iCHWr+ATTwd1/iULM+biiKY/6
         4lGFhyWwYMUpQ70LofK7OIyJV9k3FplewgMkB9pvpOiXNQhED05KCIyWGwZ1uz/YD6
         Jxfkt4hvPSYqZ+TLO2Hk58XuvLAuKKfOi8R2JIpSwEByeUmqKGNjDdru93u6+4wXlY
         GfQplffVhozVK/aArNOkVuKmSZC1yq+cHatwE6CE5hyXzIbh035TXZrNMXdoVY/2BS
         1YoUl5LJhIctScVrblNiI82hnvMfnOSaUCUhgOgjVR6zxFlmQEQJVVhrkvNYSDecYg
         xX68OpiCzZBrw==
Date:   Sun, 27 Nov 2022 17:35:42 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 8/9] MAINTAINERS: riscv: add entry for Bouffalolab SoC
Message-ID: <Y4Of7s6UGpD0/Iga@spud>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-9-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127132448.4034-9-jszhang@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hey Jisheng,

On Sun, Nov 27, 2022 at 09:24:47PM +0800, Jisheng Zhang wrote:
> Add Jisheng Zhang as Bouffalolab SoC maintainer.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00ff4a2949b8..a6b04249853c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17729,6 +17729,15 @@ F:	arch/riscv/
>  N:	riscv
>  K:	riscv
>  
> +RISC-V BOUFFALOLAB SOC SUPPORT
> +M:	Jisheng Zhang <jszhang@kernel.org>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> +F:	Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
> +F:	arch/riscv/boot/dts/bouffalolab/
> +F:	drivers/tty/serial/bflb_uart.c

I think I asked last time but I didn't see an answer on lore or my
mailbox - if you intend sending Arnd PRs for this stuff, please add a
git tree here. Otherwise, LMK and I'll bundle it with the other "misc
riscv devicetree" stuff.

Thanks,
Conor.

>  RISC-V MICROCHIP FPGA SUPPORT
>  M:	Conor Dooley <conor.dooley@microchip.com>
>  M:	Daire McNamara <daire.mcnamara@microchip.com>
> -- 
> 2.38.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
