Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6944FDE4B
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677013; cv=pass; b=N2Y51+TNcuk5kfktKw20kOGR8Ghc30EuZ+bIIWB/Qq7pmdukkuI8/EppLiTR6H2p41NFVorWVkpqMeLxIJUqC0hYVPEhRtXcwm+5eRU3P+4dbJT4YRj+Jzu+8bY3hKpVkG/icrAN6ImnVZs79Zle451pqULP+ZJpHSPWINWXBg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677013; c=relaxed/simple;
	bh=/pURnOfPd01iygyLUjpNk9X+T4L0SeXg5/g8Qb1SX8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJF9Mt66CpCuosnysS7oLKezANVbvap+0GgpU0s29+RujzQKPaqmgVKjL98rkzugGvHlRlN7W7GSPDlVfffYUuvUe9CtG2jWpo5mgs+EMRQNrGS4io94CW0VG/QHQ82je+hEqlxYAPjDEma86LtiDDtvf9hypYXuV4+wkE2BqnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wpepKC9i; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpepKC9i"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb6b726b5so686946a12.0
        for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 03:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790676999; cv=none;
        d=google.com; s=arc-20260327;
        b=NG3rhRxKGCKht+wn/ZBuyrvjoibFLwYd5ixUmgbGckzUU7FH8aW9n8Tn++0e1Oklr/
         yvwUDZx6rmkfKndMOgWtwVsiJS2BzEdDNkdTnvZxT5VCZ/FnKqEB92oeQMW6L8e7RxXH
         I0DHUpU1JeSgmSqZJps2LS9Kk6UYrWf0T3rkKPxOaG0N1IxkB178+bohu+nPNdBCQJd2
         F3gjc5FIKokmY2V+w8dXDKSXsMAh5GZHKivuVbkRT4gB0P658zbhG25GNrvrh+VWL+QM
         8rx2NyITpoxrLr4czJybyVxQ5k1pS92eZfCeKFSKSd06nR/bnLyFtHwWkevzXEv8aYO3
         av4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+Y0oCiGlxm1oUL4ENFDzbHLN3RbL4NXvE+8S8i9hNs8=;
        fh=4wJZs4uuq+KVVUpnw24Afj3ZsoQNTZfixf+f/WXAQ44=;
        b=jRaF2veBIDjtt7DE5nvnL/Vnhxl2GdKcTs7hO1CQrYgX3AwMCuPI+hBgMSnUVLlEoV
         tvZABzPLG+Pt0p3Y0s0VIoyBJuehj8dnLddK7dDXiKXJP27h3RByvApCQzVuUVYnikeH
         GUgOTU257zEPRXAfMR9GrMtnIDurnH1698uksL6Nmh/v7MKYtWXriDItvKsFCQ7m5OHn
         CWkrFzV87cDQnQsFKQQ7oHyiwLOZyJHZI8tjCvRy0fs77u7mdVWPMFfvvfkXqd9kZ2ZX
         W23uhEV5IjRT65XmXvv71yUPYqS4yj4ocqBRfppxf1nQlIL6yRpmaHso38SF1Ilk5QgK
         27eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790676999; x=1791281799; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Y0oCiGlxm1oUL4ENFDzbHLN3RbL4NXvE+8S8i9hNs8=;
        b=wpepKC9ikfKPC9p4CqWROnwComFJNLSxxEXrD7zPrVfvREDbmv3nlsz74LOc9vR6sx
         HgbesHRr1pF2xm3sZQbVhNX7NPp1QdwIJDe78id4bX212RhMbFkP+dX6Io/kLHSMct2M
         50wcgkFmIirIqSUQtWfLjK2/X8NGPjPcU59gc55ztm4vH2ty7WS9CKkIPnTUp8k6y7VT
         F5ozxPCBXrfwvIr+jMS1b2CSWto+90GHhuvzIpUCif8r+p4SE14qkDXtYHvAylxNLu0V
         vZjITdskf6Z7GLtW5V+9bFhDCmlpo4u7DQygL2u8XbUEGj3NACCd73nCKB1oLsYSC+UD
         hhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676999; x=1791281799;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+Y0oCiGlxm1oUL4ENFDzbHLN3RbL4NXvE+8S8i9hNs8=;
        b=cLOr+8S3OEWNcz+xqU5HWuTVILAZKEE0r9pecJncwPtG19skfIw6cDM3bN4cFFxSYH
         8sSXyzfnUdQn5iu9BLa7G9QReUtjaf5OHec8lVdjKUyqjt1fZ/lHZxg4dQYKrNxtcWyF
         dBRPZ/JDaF8mT+dIdW7DkuXBK6mRvMOPzMrIaPwrN+enyObiyOVRY1zIb+9c2cQMV52T
         TaqYb0fRHs9A5THXZ6YqBDlnYIDkoYDBrMrpo9wUbAtCSgZCGLu8KJ5EY4mIqcrL9GH0
         M23bv/HXXU4+thnxCMpSkprNChHaoT2ZnKKausklKDoab96EybDIDirap2NsJMUJ2cqo
         lD6g==
X-Forwarded-Encrypted: i=1; AKwUvBwkCT3/Svi4/lZpTb9KhM1fOdUz6PRE/+fBg2zzBNiC+YcFu0YmCwOcZ41jAVFZncrOiQHHGvG5YUBHQUk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1xC2arubdLBfRaGi4whv4Ip6PpMWj305SJHC70OkAMRyN89tx
	BN8G669sUoJu6fbJKxg+ohrt1dnFHmDALgx7Arc8Y43Lw6LZyrt2wuc2EaIo0kTfOlKYb3wa5lr
	HC5QHjU1kRlem46Hm8hYv3Y1MHFeH96TJMf2F4tTaxQ==
X-Gm-Gg: AYBFou3PvT/RBKcjzDSmr2CMCXskFfj5m+LDEhd6fTl41KCGdkIgFUovFmlqdAXkxX4
	iRty4zeo+qOnAoRPAUZMIoABO6Gla/XUQI3DD5GxMSdxNJ5LCSgiaUarJc7X0iJPcjKEuODu0t0
	3+ZZgf3DUelfYg1qO3RFfjqkJUMFXlkZ5Fl9rtPDQzEmROBp45vBYu/aDsAy5fvfKscY7ItAApO
	QiqVOhJEuBufgHDmNYWXNwmNy1LtBr3y/DMPXaT1dnnEhojONFGI9Lh605EGNWKIR3fL3t3C8wc
	8USO6Sov+yTtnotLYRYl5iAVCw/5pRWXM3Oc5+mr46AHOYdx1zvcFVJVO63uD7+lnFP8M8HdliS
	u+ZWFsoWNatGxkt8GRw0eq5s=
X-Received: by 2002:a05:6402:c212:b0:6aa:e589:87de with SMTP id
 4fb4d7f45d1cf-6aae5898986mr6832193a12.20.1790676998743; Tue, 29 Sep 2026
 03:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918-contrib-pg-pixel10-initial-dts-v4-0-745eaca28b1a@linaro.org>
 <179067486422.102650.10176830320558486814.b4-ty@b4> <550a74bc-f0b9-4141-9fc8-db175bb0b1ae@kernel.org>
 <CADrjBPo_V1YScLQkgbSrWCaq30k7JoF0GQQ0u5ouBiEipbEg4Q@mail.gmail.com>
In-Reply-To: <CADrjBPo_V1YScLQkgbSrWCaq30k7JoF0GQQ0u5ouBiEipbEg4Q@mail.gmail.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 29 Sep 2026 11:16:27 +0100
X-Gm-Features: AclHuK9G694Ra3CWigev-SgKIG1dKrfnmFi4vSCyiq_Xo-NTi_Nls6PiXAbko7k
Message-ID: <CADrjBPrErWJR_01+Qhuw6mu0Kpe8-tvBMjci=rBO13RaSqnfZQ@mail.gmail.com>
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

On Tue, 29 Sept 2026 at 11:09, Peter Griffin <peter.griffin@linaro.org> wrote:
>
> Hi Krysztof,
>
> On Tue, 29 Sept 2026 at 10:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On 29/09/2026 11:41, Krzysztof Kozlowski wrote:
> > >
> > > On Fri, 18 Sep 2026 19:05:01 +0000, Peter Griffin wrote:
> > >> This series adds initial basic support for Laguna (Tensor G5 SoC)
> > >> found in Frankel (Pixel 10), Blazer (Pixel 10 Pro) and Mustang (Pixel
> > >> 10 Pro XL) phones.
> > >>
> > >> Whilst Tensor G1 to G4 SoCs (found in Pixel 6 to Pixel 9 and Pixel
> > >> 10a) were offshoots from the Samsung Exynos family. Laguna is an
> > >> entirely in-house Google designed SoC.
> > >>
> > >> [...]
> > >
> > > Applied, thanks!
> > >
> > > [1/4] dt-bindings: arm: google: Add dt bindings for frankel/blazer/mustang
> > >       https://git.kernel.org/krzk/linux/c/ecf6405fa6c503c34eb4e7e905957d70d4018e93
> > > [2/4] arm64: dts: google: Add dts directory for Google-designed silicon
> > >       https://git.kernel.org/krzk/linux/c/cf3df78629f24b40cd0cb2da74e3ea4a944bed82
> > > [3/4] arm64: dts: google: Add initial dts for frankel/blazer/mustang
> > >       https://git.kernel.org/krzk/linux/c/54edd8698bb1fb40c339d0cb2f15baad6993dd48
> > > [4/4] arm64: defconfig: enable Tensor G5 SoC family
> > >       https://git.kernel.org/krzk/linux/c/63f674fe8a0a8d6e4bee3e72f7ae658f0e9a0686
> > >
> >
> > This introduces new warnings:
> >
> > /home/buildbot/kernel/build/arch/arm64/boot/dts/google/lga.dtsi:368.37-391.5:
> > Warning (avoid_unnecessary_addr_size):
> > /soc@0/interrupt-controller@5880000: unnecessary
> > #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg"
> > or "ranges" property
> >
> > https://krzk.eu/#/builders/28/builds/845
> >
> > Probably you wanted address-cells=0?

Yes, it should be:

#address-cells = <0>;

and no size-cells line

How would you like to handle it? Shall I send a v5, or would you
prefer to fix it up locally since you already applied it?

Peter.
