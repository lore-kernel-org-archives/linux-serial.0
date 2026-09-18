Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E076A502D66
	for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750901; cv=pass; b=uyMSW504HsbHPcU0IruBw9ZnpIXIgOt/krCEoaLOBl6YTIuwjNlJu94Ke5An5d/2MA8Hvcxkul/lY5kqM+rXhehM5YSNfc+A937RS3hGkXKrfYEfo/Ueqc5jZPOkAxBtoaewlGfiY0yEag184WhanQ2Obhg8Z0+JC2pzA6+rAYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750901; c=relaxed/simple;
	bh=sXARDWUbBfHUZpPSMaLLZiSIzHg03NzPFsXEQiNHkrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMlUN+Bdwl02/ZAxxA9pxL6+DsL3XcFEI2QmJ3wU6o7k5ws7EhiE3iyWM5OLL8dq9Zzl6ObcL2BjdtJSz14ymsQ/QDuiDeGbwkXVtQqRRowkVnOi4YtevITCjXNSvDt+c2+XoWAB8fN6QAKqPEojIjSB7+8LFYJs7Lp/TyovCpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oINGODjE; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oINGODjE"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e2ff27bso586964e0c.1
        for <linux-serial@vger.kernel.org>; Fri, 18 Sep 2026 10:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789750897; cv=none;
        d=google.com; s=arc-20260327;
        b=Z16MW+QzTTsKyhMva7IX5OdLKd5p0IGpPhzdcXgLm5+sh4wo/mrWI36mqh/Q5fCi1K
         KdQD1/RsDa2+oVuWaSyWGCLvl4Mpb0wFEaCZmEKI8cAHoEDx2rOVPUuuXYuH1AatqG2F
         PM+fLvT2l1ZBtb12yD93a1VX4y4LlZoLsY6zos0a2uj+XwECTXvbKL8ooqmVLT8ys0Qj
         xuKJsExFOrs8znPvM5WB9orGS/vl3yUq9uYKVzgnmH3eklKygN2MH3/KM+EEgmuIQbSH
         AdCISNQ6ZbGi1pynaMeg1mkDW89biwjsce/fPX8/QIE+OzDX/8wbG32D1kkUyTJIW6DO
         IflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XvEzZ5yV9vzGVdbkrsIgJ4kI78ty053dRTiVvQhIbhM=;
        fh=jcjDvesyVovoayRooe0Wpf8vecytGA67CbDxsApXrOw=;
        b=soPwlIbY4kXl+5c6VQplbS9lbxwWZXsAHOJSogE0AofYUZtqQXL/WK511KtZr14us1
         KZ/+FlRXExGh8NKI9oaty+OkyJFqgrNTvE6zuRt6cXYqZlp9L3FRjw3gVBDf8FeNCe4N
         zZ6omtaQf/LUD5UaknqYge5V6HzTtsu6ATeRy5f+/wND98+IOrmBwDROaWlXbI8Q7bSc
         d5TNWWpUapJGbMuLs35YjRCUoibJHn5RfuqIljS9VJ7gjVtCTd2o1gaEfSE9gxe0OB25
         0gGTuuEmrh4naxgPzxAzG7ebk68XUZjliHITqyWMDMKqc8k+S7ActY6Eipwd448MiJsJ
         VIKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789750897; x=1790355697; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XvEzZ5yV9vzGVdbkrsIgJ4kI78ty053dRTiVvQhIbhM=;
        b=oINGODjEKIviW7+4pzM5zUWAHfrl/IVoN2qi/pXtLV3Jnn66i1XeCn/zXF92vedL7S
         6zC9MhrG3/DVRBm6rGHKSavc9qrV7AlkYbScyliEvbFpwwvTxex61CuYMt18dosduPmK
         gbpnuUSsvTTfSsIsHGqlvjxgahGgb/qFfL5+JWs+twO/e1KOPT6GukvzjfUXFuq7Qtz0
         wYlJaRSmIQQc5pBEhKx6mmbKRBb1t/HzmnImOVvFLwnatPY/1HhZnhccMI2XUvMMVYvW
         KtLVjI7du1cPSlQe1QdDbYyIdwIt5u6C5wPihni3fcuuQ19CQV6CyY1GT5pvd1MavyKK
         u2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750897; x=1790355697;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XvEzZ5yV9vzGVdbkrsIgJ4kI78ty053dRTiVvQhIbhM=;
        b=IpgmGrxbN0KZi7/FtxuEciQuTUK84Q8itclZEYD9FS6l8dqF+ToSJtla8Bk2d3w72W
         5f0v0nx6uthEu0EDVDO7T1/rkNzSP+7RqVDOPq2D7UyqKSYe87wOVZbo4GytPiSptHjF
         GzkzX1+qz6XFA4gsrKNGY8uXJGJ6GmVy1GvT1mzKm39pOTCFh5q/f6pDDBFE+KgsoJUw
         kGyW6y+OhqBFaJgZ1yfBGLgJeXTZQX+3DE7YKecwITeRv0XXtMA+otzOuwU4wUwPeZ66
         tzYPygI5AfzTMXRu1ecxPJx5McR13srq3SZ+59bU9LVsJmn3wm6ZU11T6eVlf4JvL0q4
         wjoA==
X-Forwarded-Encrypted: i=1; AKwUvBxHdYjPp34nEJhJiRtbIGnhjl3+mb1VxTW8kPrXNU8Tc29PL08VEyKJrAb0vrz7of2rzseujQNjp71SQ5Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lUkEaMllib2/aJ4Fj9L3AJKVIMzflD16Bj+9OO6OnQ6XV7Y6rd
	auCPEBKHebDWBkmE6xTUi0zgflVIbDpx9XGwDEj2uCAa6BndKbyfAo59sTKPL/DsDCMJ/avEC+s
	V/y3zjVl2dGbqJt+tSJ79xV3iOk2Rhiqy/ULEduoCgw==
X-Gm-Gg: AYBFou1mKfprdyyuIeyYZ+JPAdR0oQhlYvcRcyEQTwqluAZWLabmr9JBWhjB+anfvgk
	wY1bRsGPxDaLblDK8COdFpSF65BknSopERB8Y9buLoRhIu4h+iE3MrF3AGmEx8jT6vNZiY4yNSQ
	z7fy9y9IfbNvh+8DDGgUre+tnVneno8eFPqjKMjCUg3luhSQ2AeYCQbwOF2zWyBZrg3CUw2qD0d
	XkjZEjbvOOKjm2nY7LdcsRKdeap/1jFszEndJwvl3vookHNI7kyFIj0JaIcvmNxyC7sGtSPKskQ
	FqcwjtVnSgI8tKKXY3rMOjAQGfx92aQ5dh1JgzfXLtoVbC/5pVH+zFlVpdzHdgr0EOVFxbO0ZVT
	Ud+r8D58/hK62uN4=
X-Received: by 2002:a05:6122:8c5:b0:5c8:2a47:b111 with SMTP id
 71dfb90a1353d-5c9b58bee96mr1899596e0c.3.1789750886990; Fri, 18 Sep 2026
 10:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-contrib-pg-pixel10-initial-dts-v2-0-3abae9717feb@linaro.org>
 <20260722-contrib-pg-pixel10-initial-dts-v2-4-3abae9717feb@linaro.org> <20260724-dancing-skunk-of-novelty-72c1b8@quoll>
In-Reply-To: <20260724-dancing-skunk-of-novelty-72c1b8@quoll>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 18 Sep 2026 18:01:14 +0100
X-Gm-Features: AcwNN1X4yZ0E4jX5loLfFRJVRA0cZleBO7KYxG0RnMrM3HwM6hHoo94HHHxPgno
Message-ID: <CADrjBPr3Z9z43iEpv5dXKR3iBAr0mAP=Gp--9inaiRkn19BDng@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: google: Add initial dts for frankel/blazer/mustang
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	soc@lists.linux.dev, Douglas Anderson <dianders@chromium.org>, 
	Juan Yescas <jyescas@google.com>, RD Babiera <rdbabiera@google.com>, 
	Brian Norris <briannorris@google.com>, William McVicker <willmcvicker@google.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for the time spent reviewing this and review feedback.

On Fri, 24 Jul 2026 at 07:59, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Jul 22, 2026 at 10:55:55AM +0100, Peter Griffin wrote:
> > diff --git a/arch/arm64/boot/dts/google/lga-pixel-common.dtsi b/arch/arm64/boot/dts/google/lga-pixel-common.dtsi
> > new file mode 100644
> > index 000000000000..57c318ab44c9
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/google/lga-pixel-common.dtsi
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > +/*
> > + * Google Pixel 10 family common dtsi.
> > + *
> > + * Copyright 2024-2025 Google LLC.
> > + */
> > +
> > +#include "lga.dtsi"
> > +
> > +&{/} {
>
> This is overlay style, but the file is DTSI. Just use standard '/ {' -
> that's simple and obvious enough path.

I've fixed this and all the other review points made here in v3 (which
I will send out shortly). After seeing your recent DT cleanup patches
for Exynos/gs101 I've made it pass `dt-check-style --mode=strict ` as
well.

>
> > +     chosen {
> > +             stdout-path = "serial0";
> > +     };
> > +
> > +     aliases {
> > +             serial0 = "/soc@0/serial@db62000";      /* &lsion_cli16_uart */
> > +             ufs0 = "/ufs-placeholder";              /* &ufs - TODO "/soc@0/ufs@3c400000" */
>
> UFS does not have aliases, please drop.
>
> > +     };
> > +};
> > +
> > +&osc {
> > +     clock-frequency = <38400000>;
> > +};
> > diff --git a/arch/arm64/boot/dts/google/lga.dtsi b/arch/arm64/boot/dts/google/lga.dtsi
> > new file mode 100644
> > index 000000000000..343156a8c039
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/google/lga.dtsi
> > @@ -0,0 +1,423 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> > +/*
> > + * Google Tensor G5 (laguna) SoC rev B0
> > + *
> > + * Copyright 2024-2025 Google LLC.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +     interrupt-parent = <&gic>;
> > +
> > +     osc: clock-38400000 {
> > +             compatible = "fixed-clock";
> > +             #clock-cells = <0>;
> > +     };
> > +
> > +     cpus: cpus {
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             hayes_0: cpu@0 {
> > +                     compatible = "arm,cortex-a520";
> > +                     reg = <0x000>;
> > +
> > +                     #cooling-cells = <2>;
> > +                     capacity-dmips-mhz = <258>;
> > +                     device_type = "cpu";
> > +                     enable-method = "psci";
> > +                     power-domain-names = "psci";
> > +                     power-domains = <&cpu_pd0>;
> > +             };
> > +
> > +             hayes_1: cpu@100 {
> > +                     compatible = "arm,cortex-a520";
> > +                     reg = <0x100>;
> > +
> > +                     #cooling-cells = <2>;
> > +                     capacity-dmips-mhz = <258>;
> > +                     device_type = "cpu";
> > +                     enable-method = "psci";
> > +                     power-domain-names = "psci";
> > +                     power-domains = <&cpu_pd1>;
> > +             };
> > +
> > +             hunter_0: cpu@200 {
> > +                     compatible = "arm,cortex-a725";
> > +                     reg = <0x200>;
> > +
> > +                     #cooling-cells = <2>;
> > +                     capacity-dmips-mhz = <891>;
> > +                     device_type = "cpu";
> > +                     enable-method = "psci";
> > +                     power-domain-names = "psci";
> > +                     power-domains = <&cpu_pd2>;
> > +             };
> > +
> > +             hunter_1: cpu@300 {
> > +                     compatible = "arm,cortex-a725";
> > +                     reg = <0x300>;
> > +
> > +                     #cooling-cells = <2>;
> > +                     capacity-dmips-mhz = <891>;
> > +                     device_type = "cpu";
> > +                     enable-method = "psci";
> > +                     power-domain-names = "psci";
> > +                     power-domains = <&cpu_pd3>;
> > +             };
> > +
> > +             hunter_2: cpu@400 {
> > +                     compatible = "arm,cortex-a725";
> > +                     reg = <0x400>;
> > +
> > +                     #cooling-cells = <2>;
> > +                     capacity-dmips-mhz = <891>;
> > +                     device_type = "cpu";
> > +                     enable-method = "psci";
> > +                     power-domain-names = "psci";
> > +                     power-domains = <&cpu_pd4>;
> > +             };
> > +
> > +             hunter_3: cpu@500 {
> > +                     compatible = "arm,cortex-a725";
> > +                     reg = <0x500>;
> > +
> > +                     #cooling-cells = <2>;
> > +                     capacity-dmips-mhz = <891>;
> > +                     device_type = "cpu";
> > +                     enable-method = "psci";
> > +                     power-domain-names = "psci";
> > +                     power-domains = <&cpu_pd5>;
> > +             };
> > +
> > +             hunter_4: cpu@600 {
> > +                     compatible = "arm,cortex-a725";
> > +                     reg = <0x600>;
> > +
> > +                     #cooling-cells = <2>;
> > +                     capacity-dmips-mhz = <891>;
> > +                     device_type = "cpu";
> > +                     enable-method = "psci";
> > +                     power-domain-names = "psci";
> > +                     power-domains = <&cpu_pd6>;
> > +             };
> > +
> > +             hunterelp_0: cpu@700 {
> > +                     compatible = "arm,cortex-x4";
> > +                     reg = <0x700>;
> > +
> > +                     #cooling-cells = <2>;
> > +                     capacity-dmips-mhz = <1024>;
> > +                     device_type = "cpu";
> > +                     enable-method = "psci";
> > +                     power-domain-names = "psci";
> > +                     power-domains = <&cpu_pd7>;
> > +             };
> > +
> > +             cpu-map {
> > +                     cluster0 {
> > +                             core0 {
> > +                                     cpu = <&hayes_0>;
> > +                             };
> > +                             core1 {
> > +                                     cpu = <&hayes_1>;
> > +                             };
> > +                             core2 {
> > +                                     cpu = <&hunter_0>;
> > +                             };
> > +                             core3 {
> > +                                     cpu = <&hunter_1>;
> > +                             };
> > +                             core4 {
> > +                                     cpu = <&hunter_2>;
> > +                             };
> > +                             core5 {
> > +                                     cpu = <&hunter_3>;
> > +                             };
> > +                             core6 {
> > +                                     cpu = <&hunter_4>;
> > +                             };
> > +                             core7 {
> > +                                     cpu = <&hunterelp_0>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             idle-states {
> > +                     entry-method = "psci";
> > +
> > +                     cpu_lit_c2: cpu-lit-c2 {
> > +                             compatible = "arm,idle-state";
> > +
> > +                             entry-latency-us = <132>;
> > +                             exit-latency-us = <296>;
> > +                             min-residency-us = <3610>;
> > +
> > +                             idle-state-name = "cpu-lit-c2";
> > +                             local-timer-stop;
> > +
> > +                             arm,psci-suspend-param = <0x40000003>;
> > +                     };
> > +
> > +                     cpu_mid1_c2: cpu-mid1-c2 {
> > +                             compatible = "arm,idle-state";
> > +
> > +                             entry-latency-us = <130>;
> > +                             exit-latency-us = <274>;
> > +                             min-residency-us = <2720>;
> > +
> > +                             idle-state-name = "cpu-mid1-c2";
> > +                             local-timer-stop;
> > +
> > +                             arm,psci-suspend-param = <0x40000003>;
> > +                     };
> > +
> > +                     cpu_mid2_c2: cpu-mid2-c2 {
> > +                             compatible = "arm,idle-state";
> > +
> > +                             entry-latency-us = <130>;
> > +                             exit-latency-us = <274>;
> > +                             min-residency-us = <2720>;
> > +
> > +                             idle-state-name = "cpu-mid2-c2";
> > +                             local-timer-stop;
> > +
> > +                             arm,psci-suspend-param = <0x40000003>;
> > +                     };
> > +
> > +                     cpu_big_c2: cpu-big-c2 {
> > +                             compatible = "arm,idle-state";
> > +
> > +                             entry-latency-us = <110>;
> > +                             exit-latency-us = <413>;
> > +                             min-residency-us = <3950>;
> > +
> > +                             idle-state-name = "cpu-big-c2";
> > +                             local-timer-stop;
> > +
> > +                             arm,psci-suspend-param = <0x40000003>;
> > +                     };
> > +             };
> > +
> > +             domain-idle-states {
> > +                     cluster_1_c3: cluster-1-c3 {
> > +                             compatible = "domain-idle-state";
> > +
> > +                             entry-latency-us = <325>;
> > +                             exit-latency-us = <553>;
> > +                             min-residency-us = <10000>;
> > +
> > +                             idle-state-name = "cluster-1-c3";
> > +
> > +                             arm,psci-suspend-param = <0x40010033>;
> > +                     };
> > +
> > +                     cluster_2_c3: cluster-2-c3 {
> > +                             compatible = "domain-idle-state";
> > +
> > +                             entry-latency-us = <345>;
> > +                             exit-latency-us = <673>;
> > +                             min-residency-us = <10000>;
> > +
> > +                             idle-state-name = "cluster-2-c3";
> > +
> > +                             arm,psci-suspend-param = <0x40010033>;
> > +                     };
> > +
> > +                     cluster_c4_deep: cluster-c4-deep {
> > +                             compatible = "domain-idle-state";
> > +
> > +                             entry-latency-us = <510>;
> > +                             exit-latency-us = <1027>;
> > +                             min-residency-us = <10000>;
> > +
> > +                             idle-state-name = "cluster-c4-deep";
> > +
> > +                             arm,psci-suspend-param = <0x40020333>;
> > +                     };
> > +             };
> > +     };
> > +
> > +     memory: memory@80000000 {
> > +             device_type = "memory";
> > +             /* We expect the bootloader to fill in the size */
> > +             reg = <0x0 0x80000000 0x0 0x0>;
> > +     };
>
> The memory node should go to the DTS (or common DTSI). It's not part of
> SoC usually.
>
> Also, add short comment why do you need label. It will cause
> dt-style-check warning.
>
>
> > +
> > +     psci {
> > +             compatible = "arm,psci-1.0";
> > +             method = "smc";
> > +
> > +             cpu_pd0: power-domain-cpu0 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states = <&cpu_lit_c2>;
> > +                     power-domains = <&cpu_top_cl>;
> > +             };
> > +
> > +             cpu_pd1: power-domain-cpu1 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states =  <&cpu_lit_c2>;
> > +                     power-domains = <&cpu_top_cl>;
> > +             };
> > +
> > +             cpu_pd2: power-domain-cpu2 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states =  <&cpu_mid1_c2>;
> > +                     power-domains = <&cpucl1>;
> > +             };
> > +
> > +             cpu_pd3: power-domain-cpu3 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states =  <&cpu_mid1_c2>;
> > +                     power-domains = <&cpucl1>;
> > +             };
> > +
> > +             cpu_pd4: power-domain-cpu4 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states =  <&cpu_mid1_c2>;
> > +                     power-domains = <&cpucl1>;
> > +             };
> > +
> > +             cpu_pd5: power-domain-cpu5 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states =  <&cpu_mid2_c2>;
> > +                     power-domains = <&cpucl2>;
> > +             };
> > +
> > +             cpu_pd6: power-domain-cpu6 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states =  <&cpu_mid2_c2>;
> > +                     power-domains = <&cpucl2>;
> > +             };
> > +
> > +             cpu_pd7: power-domain-cpu7 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states =  <&cpu_big_c2>;
> > +                     power-domains = <&cpucl2>;
> > +             };
> > +
> > +             cpucl1: power-domain-cluster-1 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states = <&cluster_1_c3>;
> > +                     power-domains = <&cpu_top_cl>;
> > +             };
> > +
> > +             cpucl2: power-domain-cluster-2 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states = <&cluster_2_c3>;
> > +                     power-domains = <&cpu_top_cl>;
> > +             };
> > +
> > +             cpu_top_cl: power-domain-top-cluster {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states = <&cluster_c4_deep>;
> > +             };
> > +     };
> > +
> > +     reserved_memory: reserved-memory {
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             /*
> > +              * Store ramoops at a known location in DRAM, for access by the ABL
> > +              * following a crash-reset.
> > +              */
> > +             ramoops@95200000 {
> > +                     compatible = "ramoops";
> > +                     reg = <0x0 0x95200000 0x0 0x400000>;
> > +                     console-size = <0x200000>;
> > +                     pmsg-size = <0x200000>;
> > +             };
> > +
> > +             /* bootloader logs */
> > +             bldr_log_reserved: bldr-log-reserved@95600000 {
> > +                     reg = <0x0 0x95600000 0x0 0x100000>;
> > +                     no-map;
> > +             };
> > +
> > +             /* gsa logs */
> > +             gsa_reserved_log: gsa-reserved-log@a61b0000 {
> > +                     reg = <0x0 0xa61b0000 0x0 0x00004000>;
> > +                     no-map;
> > +             };
> > +
> > +             /* Android BootLoader (ABL) for ramdump/coredump processing */
> > +             abl@be000000 {
> > +                     reg = <0x0 0xbe000000 0x0 0x1000000>;
> > +                     no-map;
> > +             };
> > +     };
> > +
> > +     soc: soc@0 {
> > +             compatible = "simple-bus";
> > +             ranges = <0 0 0 0 0x10 0>;
> > +
> > +             dma-ranges = <0 0 0 0 0x10 0>;
> > +
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +
> > +             gic: interrupt-controller@5880000 {
> > +                     compatible = "arm,gic-v3";
> > +                     reg = <0 0x05880000 0 0x10000>,
> > +                           <0 0x05900000 0 0x200000>;
>
> In some other places you use hex everywhere, also for '0' (so '0x0').
> Switch to consistent 0x0 everywhere for new code.
>
> > +                     ranges;
>
> Why ranges? There is no MSI child node with unit address.
>
> > +
> > +                     #address-cells = <2>;
> > +                     #size-cells = <2>;
> > +
> > +                     #interrupt-cells = <4>;
> > +                     interrupt-controller;
> > +                     interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> > +
> > +                     ppi-partitions {
> > +                             ppi_cluster0: interrupt-partition-0 {
> > +                                     affinity = <&hayes_0 &hayes_1
> > +                                                 &hunter_0 &hunter_1 &hunter_2
> > +                                                 &hunter_3 &hunter_4>;
> > +                             };
> > +
> > +                             ppi_cluster1: interrupt-partition-1 {
> > +                                     affinity = <&hunterelp_0>;
> > +                             };
> > +                     };
> > +             };
> > +
> > +             lsion_cli16_uart: serial@db62000 {
> > +                     compatible = "google,lga-uart", "snps,dw-apb-uart";
> > +                     reg = <0 0x0db62000 0 0x100>;
> > +
> > +                     clock-frequency = <200000000>;
> > +                     interrupts = <GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH 0>;
> > +                     reg-io-width = <4>;
> > +                     reg-shift = <2>;
> > +
> > +                     status = "disabled";
> > +             };
> > +     };
> > +
> > +     timer {
> > +             compatible = "arm,armv8-timer";
> > +             interrupts =
> > +                     <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>,
>
> Join line:
>
> interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>,
>
> even if it goes beyond 80 char limit. That's fine, exceptions are
> allowed and one line makes 'greps' or 'seds' easier.
>
> > +                     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>,
> > +                     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>,
> > +                     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW) 0>;
> > +     };
> > +
> > +     /*
> > +      * The Pixel bootloader considers it a fatal error if it doesn't find
> > +      * a `ufs0` alias so it can add calibration data to the node. Until
>
> Fake node is ok, but alias won't fly because aliases are not allowed for
> ufs. Well, would work 10 years ago, but this is a device from ~2025 (so
> SoC maybe a bit earlier), thus Google already knew that they MUST talk
> with upstream open source maintainers before they ship such ABI.
>
> They did not talk, so you reap what you sow.
>
> There is no more excuse for a vendor to ignore open source and push
> whatever-ABI-they-wish into their product, if they ever want to upstream
> that product.
>
> I know it is not your fault, obviously. And I know that not much you can
> do, so that is not rant towards you nor towards Doug.
>
> You will have to keep this part of patch out of tree or fix the Pixel
> bootloader.

I've dropped the ufs0 alias in v3 and added some glue to our build
system so things still boot while we await a new bootloader that
doesn't treat this as a fatal error.

Thanks,

Peter.
