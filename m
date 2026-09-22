Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B5B2110E
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061868; cv=none; b=Qo0980+XUm+0qzfLQb4dnTegP98JnOU+U1qbz3UNTjELsDwc1/RCl3+pl29ucPykkx6+JKzNDnBatarHBLnMuSCU2BOj3K6YmpZ/fzz0j9LhUu1aaciIpYxv+J/DfpQUmn6mGkoiyM7nYBsehBP0fAQwKm2Z+fbPu8hZprqyxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061868; c=relaxed/simple;
	bh=dnHoQ9hJxT1jx4dONrAt87VQ3Ef84mxygQ9fqqx65vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnXWN/34XdO8tNAm5EZrLA57T3fYxqn2/tLLCbRZ2+CrImhSaY46WYJMOkkQZCUaRFy5AbviPTdpSLgCQ82ibX4Rpxh1TUP3PwMIjTgDk4rUxNLlQ2Jdy7fI/fpq0OH4FvyE8MaoEkmouZbnwEhE0hxLwI/O0rQ8alz7VZJ/+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+ZiLe9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+ZiLe9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6B61F0089F
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 07:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790061867;
	bh=dnHoQ9hJxT1jx4dONrAt87VQ3Ef84mxygQ9fqqx65vM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f+ZiLe9N+4HhobIOiXEkHSOzJPiavcqREHehqAwNFiC6345vzVqQ0XkFyy0KZLSon
	 mL8vlDLDMcccOzT/PVl1scbUyc58IKW+EpJhksVggpBN7qVRYVOFrfk1dfoi8DTMLq
	 XTsyDObN9lrEAZIOn9ddRz8TKaRrnEs+mS0QUYuqlPXuQqg0i/3o4HQSnBnBN2RlkL
	 t/d7Mf/CRnjOGt/CFEOYqI1b2ZQ3umC3r4HNuAtWJ9HEwmjNVNMvGGPEdmhDctmzKK
	 /MlckJ13teVFVlHezc3sFsPaWvdMGeBM/MWBUTpKBBKPDweGpMgVU1disO8Pej0Myh
	 3y51cbIY09riw==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8d47b5987so247695e87.2
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 00:24:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByesut4ZFcM0UphUZVErYWQaL4IlAM8Smel2Od/sziZPQP2FO8rJw79lYbutMnhiXsBZfciK0TMdtsgCr8=@vger.kernel.org
X-Gm-Message-State: AFuF++mDtDkND9cfxkHPxed+uyM4wfefQEKmsfRbV1lo7kjR+dGmqa02
	vXXDre3Uvchw1risIIFfNkLm0D5tqtQEnUqe+d1fofnwwpXN7XYUhJLIwpER/AXlcUXRjGvF9nl
	X5RfGwbNiRUdiICgzDM3st3Gi4eJOT/U=
X-Received: by 2002:a05:6512:b95:b0:5ae:ba8f:f9fa with SMTP id
 2adb3069b0e04-5b8c18411aemr4246334e87.18.1790061865764; Tue, 22 Sep 2026
 00:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-cv75-v5-v8-0-282ff5d98dda@ambarella.com> <20260921-cv75-v5-v8-11-282ff5d98dda@ambarella.com>
In-Reply-To: <20260921-cv75-v5-v8-11-282ff5d98dda@ambarella.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 22 Sep 2026 09:24:14 +0200
X-Gmail-Original-Message-ID: <CAD++jLk1WEwWRFdLjkbY3YSJmbQ3oLaoNAv3Ca6ZJ2ebubp2jA@mail.gmail.com>
X-Gm-Features: AclHuK9erJBC7wstRYz1ZiKk7AbclZKt0-cY_QBUwQ7InLcjPRkXXHSAcSuac_8
Message-ID: <CAD++jLk1WEwWRFdLjkbY3YSJmbQ3oLaoNAv3Ca6ZJ2ebubp2jA@mail.gmail.com>
Subject: Re: [PATCH v8 11/18] gpio: pl061: use IRQ_TYPE_LEVEL_MASK and IRQ_TYPE_EDGE_BOTH
To: longzhao@ambarella.com
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
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
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 6:23=E2=80=AFAM Long Zhao via B4 Relay
<devnull+longzhao.ambarella.com@kernel.org> wrote:

> From: Long Zhao <longzhao@ambarella.com>
>
> Use the standard IRQ_TYPE_LEVEL_MASK and IRQ_TYPE_EDGE_BOTH helpers
> instead of open-coded edge and level comparisons.
>
> Signed-off-by: Long Zhao <longzhao@ambarella.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
