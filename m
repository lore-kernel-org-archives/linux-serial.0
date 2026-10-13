Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE013B71B1
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881086; cv=none; b=CD8LkTxk9MbRmQZJyCUHZlseRpRb9wOjJnMbEJ+/++jnK5awadgMikcMmQOTUlNgTU64TH6jOy2w8cOQgjIv2rbOvNuTR3oD1G2lcHJFas6HLjX0lIpRDg/v9aOTmxGOY8O3J82tM8PjecGk706M/BVSgMz/wrGZRQt2SJ58OKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881086; c=relaxed/simple;
	bh=vxqqcKeLdquDIj2KN23L6bIhx0QnUrefdPPqJUxyJLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahNQmTNqMI3MfyxEL2sSw01/Pxv1jfQo1JSg96dyfuWAUocTnUjZZLiP4hONdQAnzQPc1L/86zI6on3SqsEqtWdtPmyHPDuFjheIaVT2NSURkKak4CDO1M9biOsh2Ws+AbYfUVZ5GF0gmW04ENePW8jECLB84JFKy9DgbCHO8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I49h76bx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I49h76bx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88D71F008A5
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 08:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791881084;
	bh=vxqqcKeLdquDIj2KN23L6bIhx0QnUrefdPPqJUxyJLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I49h76bxM/lZR8p2VMAgIv/gvVy6UbprkYg7xesOZ4S5gyWBPpG6u4HTxJMv57uGJ
	 k8g6aFgvpTUE6kXpWN0vNFPeWi1Syq+lecQZKak3qkJCnIXXyqoamOjLnEHPwLMHE8
	 xRaGKUaKo88JjDzDOLsrHdNww6yj9eMszUmR3izWt1n/Q4XFa08DWFjFSyXIZAOkAn
	 fl3NfTB7if7RgS09qggiygd6M8OfYRYUY2lMeA187+oooKVA3dfNMynbTTj/sJEi4H
	 vgKV/6wHBpGJm81bfFvM+JhuwCKfPGkgm/d5mFGf5ZeZU9yPB3Pa1a/WxtCLvCRx/i
	 GxyAqgQ70H5ag==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a65ed9c7cfso20148831fa.3
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 01:44:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz6H/eeG2vIg1nKrwx8EHN8crcRI47obyIOvi+OnUIfHdOUPbcPbTRyQvFsnBLL1gJVDXLccRbGq2nvitM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnzsyi73N1pjeWboKEEKb3wub+T2ms4fsZQSmhZCNGOnO6KAOA
	Gb/dOgQZCnGql1lg00izzezyEtjHgR0jQv4O9/X+cvzLbW8tg2wIUkbm1KhO5ELEhzgc/uEtJ1Q
	rJ5vUuiyywsYcLNCIljI/iXqQ4/vS+lM=
X-Received: by 2002:a2e:be0b:0:b0:3a9:abd6:1ab9 with SMTP id
 38308e7fff4ca-3a9c514fd25mr26402801fa.8.1791881083577; Tue, 13 Oct 2026
 01:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com>
 <20260921-cv75-v5-v8-4-282ff5d98dda@ambarella.com> <CAD++jLmKF5XxHsJX29sdXC_6JHKn-7HkE=N+TKtk5xODtQj3_w@mail.gmail.com>
 <b2256847-3ec1-47e8-ac79-ceca86eb09e7@kernel.org> <CAD++jLkrXXg9xrhAZ8HETc5Qcv5BbkY-ibjvzBmE5WZVqDEGWQ@mail.gmail.com>
 <a0eca34d-5eb2-4730-b8c7-0f2302bcf265@kernel.org>
In-Reply-To: <a0eca34d-5eb2-4730-b8c7-0f2302bcf265@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 13 Oct 2026 10:44:31 +0200
X-Gmail-Original-Message-ID: <CAD++jLm=T-U07vAVCogMnfOfkDf=i9QhGGc8ok2N-ZUh50WLNA@mail.gmail.com>
X-Gm-Features: AclHuK8uOkUyYpjHvZrw-87c6Tq4ZbkYSTxyMDm1V9n2PMOjyOCFsNCXto0ZE_s
Message-ID: <CAD++jLm=T-U07vAVCogMnfOfkDf=i9QhGGc8ok2N-ZUh50WLNA@mail.gmail.com>
Subject: Re: [PATCH v8 04/18] dt-bindings: pinctrl: add Ambarella CV75 pinctrl
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: longzhao@ambarella.com, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 9:08=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> On 12/10/2026 09:06, Linus Walleij wrote:
> > On Fri, Oct 9, 2026 at 8:17=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >> On 01/10/2026 09:03, Linus Walleij wrote:
> >
> >>> On Mon, Sep 21, 2026 at 6:23=E2=80=AFAM Long Zhao via B4 Relay
> >>> <devnull+longzhao.ambarella.com@kernel.org> wrote:
> >>>
> >>>> From: Long Zhao <longzhao@ambarella.com>
> >>>>
> >>>> Document the CV75 pin controller binding using generic function and
> >>>> groups properties for pinmux configuration.
> >>>>
> >>>> Reviewed-by: Linus Walleij <linusw@kernel.org>
> >>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.c=
om>
> >>>> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> >>>
> >>> This patch 4/18 applied to the pinctrl tree.
> >>
> >> There is a dependency, you cannot take this patch alone.
> >
> > Oops, but is it a DTS dependency so if none of the other patches go in =
through
>
> No, it is a bindings dependency, introducing new DT bindings warning for
> both your tree and next.

Is there a problem with the bindings patch itself?

In that case Long can just send an incremental patch to
fix it right?

> Your tree is fine in this case as long as next
> is also fine... but next is not, because that patch did not make it there=
.

But the patch is in -next?

~/linux-next$ ls
Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml

> We cannot have any new DT bindings warnings in next.

I guess I just don't get it :D

To me it seems like a fairly normal situation: ACKed bindings merged
together with the driver, no dependence on anything.

But if you tell me "revert the patch" I will simply revert the patch
because I trust you, it doesn't really matter why.

Yours,
Linus Walleij
