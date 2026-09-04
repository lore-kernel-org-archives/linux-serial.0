Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1D3A6B85
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561684; cv=none; b=GlG1SF/eaASy754paMOscfxQeYftToAWhSHNFLMqTSt3F0ku9ePEqikjAcb5NJWI5mrbri4Q/QOUsatLybSbRxTwqWxQAeXXwkfRHSbTUwGOnrP4UNS5F6iKngMZYvttvcNH+yH0yD/WH1wKyYGmjFozxSFmNQAlw0VnHd1cMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561684; c=relaxed/simple;
	bh=C0myiUlgWF0TZd8+Ku/LAy7GnzKeiD52gDwego64hj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BInioFf4Ij3gG9DqZq9857Z2pil0+L4Tv5+tlKtqGmy9hIVyCWmzznWZgAyNMbhI41ebV8VRDXqzx64qfXsOc0bRbJHjYrHZQE44sj21mfu2bk+ZZyv3xM8BT6Pn5dyH/AAL35fDCC5VCgwRwz/uUNC0WbnQr+4E6LEBft7BY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naSfCtaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naSfCtaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B871F0155F
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 22:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561682;
	bh=C0myiUlgWF0TZd8+Ku/LAy7GnzKeiD52gDwego64hj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=naSfCtaR2p6Ey3hc9gr+m0RTXINQIfLmrYVBFP7Zn60Gab+HjxyVPF+1umfmk3kS5
	 Fr7wiAR8LEGRTHb3HOCmnqiyuxt3nQ/6a557N/lDr5ynq2BWNnEO/2J7W+pe7mWFOP
	 g6TP5F3+pAJfTtukPstuEhnN7TNhHLtSoab2pApfrAkX8ESqyAI/JkMUUS1Ns2iTgP
	 6mQMC+O/k3Ntc629UnIZFwKzf4rXE3tkCGbqQoaGgjmntpEpWWMXupYIEJapm38jBT
	 yvghkqGeMeXd4zVrb2u6/MVXLoCOXIPs/BJRcGhZ60zsODhI2HSEA2lrcRjAwOlrAl
	 piJ9BErTW9euQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so1328056e87.0
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 15:41:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwq99jw58HqDZu307r+3S9z63X2bRrDnXzId+XJGAXgAyaTTigi76a3djQrUUpNObr/QLQLSivGa37ueBU=@vger.kernel.org
X-Gm-Message-State: AFuF++lvhbnu7MizzWZOT+tPHm9uNCLLRtesyVzgyrvt/TNHoNHTHB6+
	yrLp2XXyuYkMNIUbHFyZyzP6hKdVrHNWLxLlN8iG4fp210o1ZU9DdYzbI4gXtBT8Aj2znaxWQrh
	yQjhSlEo+nZGcjSnHycN4fhEf0GcWTsM=
X-Received: by 2002:a05:6512:61a7:b0:5b6:1a7c:aa19 with SMTP id
 2adb3069b0e04-5b61a7cad0dmr907279e87.49.1788561681149; Fri, 04 Sep 2026
 15:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com> <20260904-cv75-v5-v6-6-e918514cb3b1@ambarella.com>
In-Reply-To: <20260904-cv75-v5-v6-6-e918514cb3b1@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:41:09 +0200
X-Gmail-Original-Message-ID: <CAD++jLmnkYaXqD7T3ckO7z9g929DvHyuK04j7VKEgVrnF+1C=A@mail.gmail.com>
X-Gm-Features: AcwNN1VDId_JVjT4HuchtPhHSz9zctXg7JmJYfvX8t2TVwOBsWn_VCTazZMrhFA
Message-ID: <CAD++jLmnkYaXqD7T3ckO7z9g929DvHyuK04j7VKEgVrnF+1C=A@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] dt-bindings: serial: snps-dw-apb-uart: add ambarella,cv75-uart
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, soc@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Long Zhao <zl020895@163.com>, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:39=E2=80=AFAM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> From: Long Zhao <longzhao@ambarella.com>
>
> Add the Ambarella CV75 compatible string to the Synopsys DW APB UART
> binding. The block is Ambarella IP with a DW-like register map, so it
> is described as a DW APB UART variant.
>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
