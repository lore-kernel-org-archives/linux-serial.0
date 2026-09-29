Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2588F39A7FE
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676610; cv=pass; b=nBdiAilcA1SATiCNcEY3M8RBGtDfu0fTmHF+PNYaLmA8r/h/g9YNRvONcHRJ8zs3Eg2vgwfbw8lHv8cUht6Rfo4Aoa5+dAMmMyNROA6jiqnWp+9dfC5SRzjOisC3S7YWUTQY6X+AUYNBMYcoGvOZtKlvfrhUY5/1UAosgj24JC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676610; c=relaxed/simple;
	bh=ugqhqlW2+gdWnYyVA2uZcdO8IYtwk8wf07W/RuYSe7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1xF2y6GAaUqRRwMfWhHWfbgNFasu1BhYJCbj3/i1cv8qR2J0tiL5mxQOFnCKEpvroVJXRI91HV6NgLj2EIARMkSw0ttj+x11GJxDo1e1lztsgw9n2XwvGz900uWSi7eUHYF6xSpkD3bZTdPuzAbLlTn8Mg/UlvNzrlCVYD711U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eLfFruuz; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLfFruuz"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa1d00daaaso7022421a12.1
        for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 03:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790676598; cv=none;
        d=google.com; s=arc-20260327;
        b=W9cPQ359CBxw76AKoy8xCz0eGn1mVRkXTUqHlqsPgtpAkpSZCcvV8cqpP3ibYYNCeo
         MTbZCed1QmTUiLwYXWcfoYaTX/EKGlN+vY1fs4supkUkrN4Y3CnTXL5PZFpFpmWlC3nL
         Emou1UIfV4TGFQ/3n15YQP2o3mx1/wP7Lu2l3COACJLjdq32txjTOq7qtYQ1/6L7LPWg
         wrYvyRfC834aobcpyiJ6GqqDXmuv9m44BzG1khoYG45Qr14w0SufpKjH6z1HjP9rX4Lh
         vlJQg37/k4RUYJ8cV7oPsoMGHa8sCrZtQToD4H3FRFiPCSPb9VpyiIXiWYnnQ3wm3cbg
         iwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dCNfmYcGaMILR8c3Q+T+COx/KTeJ3JVks807vI/GCMc=;
        fh=3zeUrBrwk57EVkvohpj+ANPtl+ehPcUxPv4YDb9eK3g=;
        b=hcvDdvUbfixyUBD9XbrJ7ZJ3HtHEI9G95zD2HduI5Nm3PLvi72r17sMiY/p50lzweS
         JupJBn8QBwnPOX7f0x9iGKO490vUTuDyOZQL5FqknQDvhQGXtoCvBydxwe/0U8nK3UOH
         lo/om6cBYGqosR/bZyhnWERVCyThgOJ8GPR5qZl+RJNznctis0z9vj3ihViFUV3aiQBz
         XtETvmB6yoj1/UQsqHjzV5kTKdKpvIbJRYUMcQ0VfCI+I/YxWMwM77LMutOfUv7ADBdy
         Am+/AEfML5VIHi4IN96iSgLmlIgcBx5LA7gFNTf5b0oiauKtl6DGy8gTnHpoP8oqFs7B
         K+/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790676598; x=1791281398; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dCNfmYcGaMILR8c3Q+T+COx/KTeJ3JVks807vI/GCMc=;
        b=eLfFruuzSD6VK94I1ZOgecR5WuCkwCewUnqYwsZjijOYG6HQFD3oaRXZNY0rj7ALsm
         LryYr0dwh1IQar9qi4TPHR11HNDoG8myw+R3WOYYZCWsoZ3NMCVeY6cbAeVFfpfYBp/Y
         eqWmMP4MoUFMm1aJnepVHf+OXMIUap7E6Xz+CJwwlcTYt+oeEDPErANA+ryssPHYlJPN
         DFtDmaleI3Z75Ob5ndQtSvFnoAgQJwh1oFid4CRAsDF/9kGJTgJX7QYM+xSfm6HixnCe
         +BCT+knQ6pUGb8dcr36lqfoq1EVJC1hvfam2udhpMUvrPQnAsDC+q3x0MtRGyjH50P99
         diQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676598; x=1791281398;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dCNfmYcGaMILR8c3Q+T+COx/KTeJ3JVks807vI/GCMc=;
        b=VDka2AB2ncLzTW9tAZ5W/nkbldfa/aB8S8DTwQDest5eBpn8aV6lhFGmrVCm26QLGr
         cASdrNjbeeuK2yPTHsiDNWE4dQ6wfBzlyOHuCdXmbytbegCWQKlAGBKu6loPBO7css0I
         IzPPYzJQDABIKpejyYSZff8/g+RUXr9e70D5KhA5Fey6qIBXuf2M16/oL6pM/6851hR8
         7yw0tJ/+MwdQn6u9Am0dV6gLKYLmSMdXCMrBjGfZopTfXCn8nXabNk+QAZuOW2waAm67
         vkt9/mt3kScRNOju19NvKS16yCkrrLHziqKN9TGlc2ZB5KyhbtkDSxRoA2zmvOUaeWjR
         L1Jw==
X-Forwarded-Encrypted: i=1; AKwUvByQ5UxkidvjjGmhhYYM4iY7ABHnK4D3UT3m42z8fW28PSCjugcHZ6PRGOQos15wnKtyuBT4Uv1Kv7TK6sQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCtFXQqdISjrKF4WVgqIU05vSK6qLBw7QZbJTdd1O1Ag10dmmW
	yRB6T4D0wyvPnIEYDl1geo0znUgPgxntZRPtFRjhfGkFrk+e8Ny1k4H4acGBrUBM21y2gtTewcz
	MzV2zW2AUgyTRXQjAd9tO2c40EzesiWKpQwwi/T9r7Q==
X-Gm-Gg: AYBFou2/9TeNbUfb4UHXNaLDQx0+lqdXk/5HgQE980roxeHpXgbtQywI4SFthd61LCZ
	rUduXlzjkywAG7b4hdpLkIP5vGeL4oLjA4q3d+jPbsXRTF+2BaD83KWTqYUsQLNujkJsWrmbxrM
	GmkIraGLW7dbLtplk7MalW5GpzFAaiE+0hlHTNYb46S9veg3jJxhypFAoa73o/zD41XOGoU4/bS
	5iwLtqy/5K15FzxcP6+7wrpG84jtOuWLXLXF4jL5XYfSxKK5XCDna/SJ7IysLsyevQPRigY4j2h
	libVcqDFj8lCS3nIDHK1WEHgRbsaVB3LrwQYJHA8eLqRW3kL7jyPq089JUAhyL80y6n7GokTztQ
	46Q7JWUwgUwlF6zDHNtKiLHA=
X-Received: by 2002:a05:6402:3059:b0:6aa:9f53:221b with SMTP id
 4fb4d7f45d1cf-6aac8ecf650mr10133940a12.4.1790676598186; Tue, 29 Sep 2026
 03:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
 <179067486422.102650.10176830320558486814.b4-ty@b4> <550a74bc-f0b9-4141-9fc8-db175bb0b1ae@kernel.org>
In-Reply-To: <550a74bc-f0b9-4141-9fc8-db175bb0b1ae@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 29 Sep 2026 11:09:45 +0100
X-Gm-Features: AclHuK9WRHV7MmouzYCiFz5qe8OcNiIlPS3cNCTz_rrKcfw59IxyOBRtgpvUaFE
Message-ID: <CADrjBPo_V1YScLQkgbSrWCaq30k7JoF0GQQ0u5ouBiEipbEg4Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add Laguna/Tensor G5 SoC and Frankel, Blazer &
 Mustang boards
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, soc@lists.linux.dev, 
	Douglas Anderson <dianders@chromium.org>, Juan Yescas <jyescas@google.com>, 
	RD Babiera <rdbabiera@google.com>, Brian Norris <briannorris@google.com>, 
	William McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-serial@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Krysztof,

On Tue, 29 Sept 2026 at 10:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 29/09/2026 11:41, Krzysztof Kozlowski wrote:
> >
> > On Fri, 18 Sep 2026 19:05:01 +0000, Peter Griffin wrote:
> >> This series adds initial basic support for Laguna (Tensor G5 SoC)
> >> found in Frankel (Pixel 10), Blazer (Pixel 10 Pro) and Mustang (Pixel
> >> 10 Pro XL) phones.
> >>
> >> Whilst Tensor G1 to G4 SoCs (found in Pixel 6 to Pixel 9 and Pixel
> >> 10a) were offshoots from the Samsung Exynos family. Laguna is an
> >> entirely in-house Google designed SoC.
> >>
> >> [...]
> >
> > Applied, thanks!
> >
> > [1/4] dt-bindings: arm: google: Add dt bindings for frankel/blazer/mustang
> >       https://git.kernel.org/krzk/linux/c/ecf6405fa6c503c34eb4e7e905957d70d4018e93
> > [2/4] arm64: dts: google: Add dts directory for Google-designed silicon
> >       https://git.kernel.org/krzk/linux/c/cf3df78629f24b40cd0cb2da74e3ea4a944bed82
> > [3/4] arm64: dts: google: Add initial dts for frankel/blazer/mustang
> >       https://git.kernel.org/krzk/linux/c/54edd8698bb1fb40c339d0cb2f15baad6993dd48
> > [4/4] arm64: defconfig: enable Tensor G5 SoC family
> >       https://git.kernel.org/krzk/linux/c/63f674fe8a0a8d6e4bee3e72f7ae658f0e9a0686
> >
>
> This introduces new warnings:
>
> /home/buildbot/kernel/build/arch/arm64/boot/dts/google/lga.dtsi:368.37-391.5:
> Warning (avoid_unnecessary_addr_size):
> /soc@0/interrupt-controller@5880000: unnecessary
> #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg"
> or "ranges" property
>
> https://krzk.eu/#/builders/28/builds/845
>
> Probably you wanted address-cells=0?

Urgh, that must have happened because I removed "ranges". Let me take
a look and get back to you.

Peter
