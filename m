Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183744CACA
	for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2026 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749909; cv=none; b=S9Z1BxydC9ITqKRA3VNX2S4HH1qTheuFMOf6Sf94BWKYD7/DLd92rh8sNPJswT6+DGdnBBYvvWkt2ThINr6KIIQkVASyrD8ecBNG7/0SgIloQjf8GWMQxqbj8YYtanDpszFTnH4qnIMX9RBZXYBKP5I2DqGIL4mlHg0RxkxFH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749909; c=relaxed/simple;
	bh=ejLXqi+u8ZeqtbdH/Z7gyH3m3KAUVOqkuuXeqQ5sRrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnTmCpC+EaHq6Rkj2k4Ocs20Jgcrd7paBV6Q7XbQQu4O8Wg/1rA9Dr58esMMOv6YHldEiAyro+7UZpjdJJBPRUhxFJ0JEtOJSo1Pzb8js8Thq7vWhUULCda396x4VToFdJiOCO/21t7ZCQvXYnL4dvgZwMHg+L8aEMY50NGCPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfA2nPFO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfA2nPFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8681F00A3A
	for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2026 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782749908;
	bh=RgIicjEg1ypt51fBlP/S1xm/iEKSItks2dewD9TtOQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VfA2nPFO561l2WR/XErzyqC+gdwNoeGLho5jehFX6zpk6rwFywpLNM5hIRlECo7L7
	 0uzUiJVMHgmiG6/70GzhfJfqalP+v8MMLAhPJwukFOkB5w4vhRAF+xpiQfM4P9lWV2
	 Ev7gQgjP6OuLe8smbafG2lHBpsQ1eJ4TbrR6gzJMjuFU1a/xBamvHoPVmKIgvfnVKI
	 mhOyqe8tVM2xyQrANKUtC2h2IkENtuXErMcT7bAFHptiyzaedhpYxn7h+oVylkTnVp
	 qosE31hVuLzyawLlJdD+r2K1k73JG+Np7lJW7b4ayinDfk7GLliGMd++cNncCnmsT5
	 jeHcHCmd9xi3Q==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c0e124d2a21so403275766b.2
        for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2026 09:18:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YyHVMf4EpsuWd1SaTzE4NB0uYoE/ohOchoehJDr5hsb97d4U///
	+s31qKLjZa5n2Q5sW74T4DSNFlfqALAcvpbUROclPX0giqm/JgxRdqvs7x+5aGsuPE5mtZcu7AW
	85hrQ7tyUoI7RNFB94fAzD9V3C9rNnw==
X-Received: by 2002:a17:907:1b0e:b0:c12:4bc8:1b5b with SMTP id
 a640c23a62f3a-c124bc820a3mr273988066b.7.1782749907134; Mon, 29 Jun 2026
 09:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617092515.2649521-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260617092515.2649521-1-andriy.shevchenko@linux.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 29 Jun 2026 11:18:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+8x8fy_3X7+cz344AexWkn4oLcukOcure7iK6b2ce_bg@mail.gmail.com>
X-Gm-Features: AVVi8Cc2ubw-Lp8kA3ld5ya74CWTS-6CXdM-0CnSwqBG9bQiQhK9KPCQ4mcC_K8
Message-ID: <CAL_Jsq+8x8fy_3X7+cz344AexWkn4oLcukOcure7iK6b2ce_bg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] serdev: acpi: Free resource list at appropriate time
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 4:25=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We do unneeded "double free" (emptying an empty list) in one case.
>
> This is not a critical issue at all, the fix just makes code robust
> against any possible future changes in the flow.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serdev/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring (Arm) <robh@kernel.org>
