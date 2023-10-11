Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA4CDB483
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 21:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjJKV7C (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjJKV6w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 17:58:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C17D9
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 14:58:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9c496c114so63435ad.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697061528; x=1697666328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84Uf9uELl6ZUNY1fM8dZqGWxG/vDPtGz8bCxaFhiGFg=;
        b=S8xRHp1eeQoeLTxAEXLfVmJR6TNQ3xqS9sv+Tq7T2Dp4SGn9xSoT05qTeRRQup5rrh
         ueDXFzaWWHUYbXDzkZ9359RGgS3lkMeedK2Yy9fflkvXstGLebEvVBUnP/lOYs/QVPs7
         edhw8ZeNGnTTWcW3vvGDmXaDrzmBcvs5ALBCLU0N/VQ5XF4qT13BvuqJoTPCYGBVlUf+
         FSeKU7j/+itiePbkV79NGCwtC+B9n5WQa/ok8+Cphrce5n8emkrNusvZ77b9H5G7gi/n
         f25SxdtGSiDaXX8nYeJZJs/ECdBqgvlD/LGl+Dmjx4r1gy9F7K6ITJrQc2YmLryu7WF+
         XQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061528; x=1697666328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84Uf9uELl6ZUNY1fM8dZqGWxG/vDPtGz8bCxaFhiGFg=;
        b=mduPPgqe5omBdVKHhDf1uiPEn+zgSNcBlniCg4sTZ2QSG8kMxXyRvjVdzhaBCcOLeq
         Ps9meejJmqF9IwR99XHzpzGTyOqMhejsHKIhoXSzYlnUDSOBvubfvVaP6t4zCT5h99uD
         x5pHWIFVIDKS6SZMCso/TF1kd9Gn4tawfNweKiALyP5xs2gNZUjsW1eYFDYyeJG/4h59
         ytB0+Hy1V4EVNcuqfYUJtd2Se5xMtHgV1YAnbCcotpMl2Y8CQhfhNDhVy8DifiKLY2x2
         n2EKlY6+DKgFzH9YvTRklgoqp7F1+2LzTIBTwnJGr3Lebwhj/uuBbBawc4bm5jviAGdC
         Jb7w==
X-Gm-Message-State: AOJu0YxJQ7VNqL64MtcfL2Has39cGw2XoUhnyk2Q7nFsejrDpOZ7XdT/
        wB0giRAJSa8RVY8snHokFJRW4w==
X-Google-Smtp-Source: AGHT+IGizLr+HXYXT7Fe7nzJBHeo3JXLm3dQ9IRSvebWQzrtbzJLQAny19NC+mTlXml8nrFrWFn/JA==
X-Received: by 2002:a17:902:cecc:b0:1c9:b786:4e3d with SMTP id d12-20020a170902cecc00b001c9b7864e3dmr362630plg.24.1697061528346;
        Wed, 11 Oct 2023 14:58:48 -0700 (PDT)
Received: from google.com (13.65.82.34.bc.googleusercontent.com. [34.82.65.13])
        by smtp.gmail.com with ESMTPSA id iw19-20020a170903045300b001c44dbc92a2sm322770plb.184.2023.10.11.14.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:58:47 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:58:44 -0700
From:   William McVicker <willmcvicker@google.com>
To:     Peter Griffin <peter.griffin@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, gregkh@linuxfoundation.org,
        cw00.choi@samsung.com, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, semen.protsenko@linaro.org,
        saravanak@google.com, soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 00/20] Add minimal Tensor/GS101 SoC support and
 Oriole/Pixel6 board
Message-ID: <ZScalKHMRq9gaGOh@google.com>
References: <20231011184823.443959-1-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011184823.443959-1-peter.griffin@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/11/2023, Peter Griffin wrote:
> Hi folks,
> 
> Firstly, thanks to everyone who reviewed the v2/V1 series! V3 incorporates
> all the review feedback received so far.
> 
> As this series spans multiple subsytems the expectation is that Krzysztof
> will apply the whole series through the Samsung SoC tree. If the relevant
> subsystem maintainers can give a acked-by or reviewed-by on the relevant
> patches that would be most appreciated!
> 
> This series adds initial SoC support for the GS101 SoC and also initial board
> support for Pixel 6 phone (Oriole).
> 
> The gs101 / Tensor SoC is also used in Pixel6a (bluejay) and Pixel 6 Pro
> (raven) phones. Currently DT is added for the gs101 SoC and Oriole.
> As you can see from the patches the SoC is based on a Samsung Exynos SoC,
> and therefore lots of the low level Exynos drivers and bindings can be
> re-used.
> 
> The support added in this series consists of:
> * cpus
> * pinctrl
> * some CCF implementation
> * watchdog
> * uart
> * gpio
> 
> This is enough to boot through to a busybox initramfs and shell using an
> upstream kernel though :) More platform support will be added over the
> following weeks and months.
> 
> For further information on how to build and flash the upstream kernel on your
> Pixel 6, with a prebuilt busybox initramfs please refer to the script and
> README.md here:
> 
> https://git.codelinaro.org/linaro/googlelt/pixelscripts
> 
> Note 1: I've removed the dtbo overlay from v2 and later submissions and
> will re-submit once I have appropriate documentation for it.
> 
> Note 2: I've left the bootargs in dts with earlycon for now, for two reasons.
> 1) The bootloader hangs if bootargs isn't present in the dtb as it tries to
> re-write this with additional bootargs.
> 2) there is a issue whereby the full serial console doesn't come up properly
> if earlycon isn't also specified. This issue needs further investigation.
> 
> kind regards,
> 
> Peter.

Thanks Peter for sending the series out and for the quick turn around in
addressing the feedback! I've tested the v3 patch series on my oriole device by
following your README. I was able to successfully boot to the busybox console.

Thanks,
Will

> 
> Changes since v2:
>  - Fixup pinctrl@174d0000: interrupts: [..] is too long DTC warning (Tudor)
>  - Add missing windowed watchdog code (Guenter)
>  - Fixup UART YAML bindings error (Krzysztof)
>  - gs101.dtsi add missing serial_0 alias (me)
>  - samsung_tty.c: fixup gs101_serial_drv_data so fifosize os obtained from DT
>  
> Changes since v1:
>  - Remove irq/gs101.h and replace macros with irq numbers globally
>  - exynos-pmu - keep alphabetical order
>  - add cmu_apm to clock bindings documentation
>  - sysreg bindings - remove superfluous `google,gs101-sysreg`
>  - watchdog bindings - Alphanumerical order, update gs201 comment
>  - samsung,pinctrl.yaml - add new "if:then:else:" to narrow for google SoC
>  - samsung,pinctrl-wakeup-interrupt.yaml - Alphanumerical order
>  - samsung,pinctrl- add google,gs101-wakeup-eint compatible
>  - clk-pll: fixup typos
>  - clk-gs101: fix kernel test robot warnings (add 2 new clocks,dividers,gate)
>  - clk-gs101: fix alphabetical order
>  - clk-gs101: cmu_apm: fixup typo and missing empty entry
>  - clk-gs101: cmu_misc: remove clocks that were being registerred twice
>  - pinctrl: filter sel: rename/reorder variables, add comment for FLTCON bitfield
>  - pinctrl: filter sel: avoid setting reserved bits by loop over FLTCON1 pins as well
>  - pinctrl: gs101: rename bank_type_6/7 structs to be more specific, split from filter
>  - watchdog: s3c2410_wdt: remove dev_info prints
>  - gs101.dtsi/oriole.dts: order by unit node, remove underscores from node name, blank lines
>    add SoC node, split dts and dtsi into separate patches, remove 'DVT' suffix
>  - gs101-oriole.dtso: Remove overlay until board_id is documented properly
>  - Add GS101_PIN_* macros to gs101-pinctrl.h instead of using Exynos ones
>  - gpio-keys: update linux,code to use input-event-code macros
>  - add dedicated gs101-uart compatible
> 
> Peter Griffin (20):
>   dt-bindings: soc: samsung: exynos-pmu: Add gs101 compatible
>   dt-bindings: clock: Add Google gs101 clock management unit bindings
>   dt-bindings: soc: google: exynos-sysreg: add dedicated SYSREG
>     compatibles to GS101
>   dt-bindings: watchdog: Document Google gs101 & gs201 watchdog bindings
>   dt-bindings: arm: google: Add bindings for Google ARM platforms
>   dt-bindings: pinctrl: samsung: add google,gs101-pinctrl compatible
>   dt-bindings: pinctrl: samsung: add gs101-wakeup-eint compatible
>   dt-bindings: serial: samsung: Add google-gs101-uart compatible
>   clk: samsung: clk-pll: Add support for pll_{0516,0517,518}
>   clk: samsung: clk-gs101: Add cmu_top registers, plls, mux and gates
>   clk: samsung: clk-gs101: add CMU_APM support
>   clk: samsung: clk-gs101: Add support for CMU_MISC clock unit
>   pinctrl: samsung: Add filter selection support for alive banks
>   pinctrl: samsung: Add gs101 SoC pinctrl configuration
>   watchdog: s3c2410_wdt: Add support for Google tensor SoCs
>   tty: serial: samsung: Add gs101 compatible and SoC data
>   arm64: dts: google: Add initial Google gs101 SoC support
>   arm64: dts: google: Add initial Oriole/pixel 6 board support
>   arm64: defconfig: Enable Google Tensor SoC
>   MAINTAINERS: add entry for Google Tensor SoC
> 
>  .../devicetree/bindings/arm/google.yaml       |   46 +
>  .../bindings/clock/google,gs101-clock.yaml    |  125 +
>  .../samsung,pinctrl-wakeup-interrupt.yaml     |    2 +
>  .../bindings/pinctrl/samsung,pinctrl.yaml     |   22 +-
>  .../bindings/serial/samsung_uart.yaml         |    1 +
>  .../bindings/soc/samsung/exynos-pmu.yaml      |    2 +
>  .../soc/samsung/samsung,exynos-sysreg.yaml    |    6 +
>  .../bindings/watchdog/samsung-wdt.yaml        |   10 +-
>  MAINTAINERS                                   |   10 +
>  arch/arm64/Kconfig.platforms                  |    6 +
>  arch/arm64/boot/dts/Makefile                  |    1 +
>  arch/arm64/boot/dts/google/Makefile           |    4 +
>  arch/arm64/boot/dts/google/gs101-oriole.dts   |   79 +
>  arch/arm64/boot/dts/google/gs101-pinctrl.dtsi | 1275 ++++++++++
>  arch/arm64/boot/dts/google/gs101-pinctrl.h    |   32 +
>  arch/arm64/boot/dts/google/gs101.dtsi         |  504 ++++
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/clk/samsung/Kconfig                   |    9 +
>  drivers/clk/samsung/Makefile                  |    2 +
>  drivers/clk/samsung/clk-gs101.c               | 2164 +++++++++++++++++
>  drivers/clk/samsung/clk-pll.c                 |    9 +-
>  drivers/clk/samsung/clk-pll.h                 |    3 +
>  .../pinctrl/samsung/pinctrl-exynos-arm64.c    |  163 ++
>  drivers/pinctrl/samsung/pinctrl-exynos.c      |   84 +-
>  drivers/pinctrl/samsung/pinctrl-exynos.h      |   41 +
>  drivers/pinctrl/samsung/pinctrl-samsung.c     |    4 +
>  drivers/pinctrl/samsung/pinctrl-samsung.h     |   24 +
>  drivers/tty/serial/samsung_tty.c              |   13 +
>  drivers/watchdog/s3c2410_wdt.c                |  127 +-
>  include/dt-bindings/clock/google,gs101.h      |  232 ++
>  30 files changed, 4985 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/google.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
>  create mode 100644 arch/arm64/boot/dts/google/Makefile
>  create mode 100644 arch/arm64/boot/dts/google/gs101-oriole.dts
>  create mode 100644 arch/arm64/boot/dts/google/gs101-pinctrl.dtsi
>  create mode 100644 arch/arm64/boot/dts/google/gs101-pinctrl.h
>  create mode 100644 arch/arm64/boot/dts/google/gs101.dtsi
>  create mode 100644 drivers/clk/samsung/clk-gs101.c
>  create mode 100644 include/dt-bindings/clock/google,gs101.h
> 
> -- 
> 2.42.0.655.g421f12c284-goog
> 
