Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF591E8830
	for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599818; cv=none; b=GJb0HVGcqhIRVMregRrC1QoIFjjRXTlUa7KuSFJwRNUnFBSwLwvFIyHclj78cKvjn9474bKWyX25a9C+dHLrUsgUuLHI3onfBRE15Xr0OHtX6d95jU/E+Aaus1T/JZgp2Mu1tclluh391jzOOwUEoRY79dPNOhn4hLQg6cGef74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599818; c=relaxed/simple;
	bh=Oxl2smtTASJ6MycM3FoVyfEsgbMMCGZ1Gfzk4oNcX8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7p/TQ74mng3+Az3KvCn6M74h8YubAr0+ET2x21049RYaIbX+CZIxpa5SzFt4pajRqwWUoWzSZZ4erS+qkXL5vswelmSJNsYZrFnSb1S+bMSVNUHT0SbrklTtr9zdm5ta6zxitivTK4VJdzbINJID+mbMkhTnSJeQFMj5p8Osqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CrC4/ZJK; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CrC4/ZJK"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fac187eef2so15841321fa.3
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 15:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599814; x=1729204614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjeDbIjsUK09P9siScyxEtPwzKzblEFE3ZJjqNhSVcQ=;
        b=CrC4/ZJK/XRWlvSVjGUOjlnjIiNfYEIiBTWSO0nUFsTA92R/R38QoZ+lQp8yc9RWhU
         mNwNemzpfbJsUER9ohdpJyFvdyS3aZcXYgRtlN4dfNg4AXN1IEQGkBO2qATTgfUKFXPJ
         LHoe/ghN9kxHqBvpxDB4cS2e8c6hcCXphzfhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599814; x=1729204614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjeDbIjsUK09P9siScyxEtPwzKzblEFE3ZJjqNhSVcQ=;
        b=BsSYKrMlJM4DzKHPnXNiqa1sR9JEPjcEhJuxHitgUNI9pkH8YUutg6is1FRxaNFpzi
         /AA1jSozMbseft68di58ooEZSmDXGGVFMh/GOkCMo+YpWoqWSsNyVEv0VRg5Sjm7WJeQ
         TOY41WNETq6Q3FjqVdGJ/33Y6ZfwBtcNVXGve1s4hUi8szapLk3l1TemUt5qp2bx6P5P
         TAIZvcLYxDl5akdd/2EDXDlu6wTHO76R/oZFijsiPmpcjmKoGXBjjYtxECNILG0xTChZ
         ceBgXMmLxqaZxXhWmoE/YYahxqYt7UzIA6GTM1L41agUXSdhn9zoMNkE/v8DR34CAOfW
         1cAg==
X-Forwarded-Encrypted: i=1; AJvYcCXETqTthkinJkMf0bu3hGaAvXi7T1/HgSQCb02bjyniLCwYES0qsjuSjuMpboQquJCVlmZA/2v1EhfTV7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDX/2DCBr4DRH4SvXkCWdJVzNUDvd/5yCVXFrzZiEBHCKC8IfH
	pcCwDpYU9TyfaaEjnEeBfh17a6XLYluiFc+SQL+a7XfI66Y+JUvPycyFoSar/YNClb07Dc5YtiU
	VoV6Z
X-Google-Smtp-Source: AGHT+IFes/W8Wmrq2hTl8NK0WLtCfs84GUKhUkjQT3hmJYcsxNV62U/9zq4PgYvN9kzQlEmj7/yzAw==
X-Received: by 2002:a05:6512:a95:b0:539:9867:eed7 with SMTP id 2adb3069b0e04-539da3d52d8mr215567e87.24.1728599813718;
        Thu, 10 Oct 2024 15:36:53 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c1186sm419475e87.40.2024.10.10.15.36.50
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:36:50 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb2c68ea2cso5098621fa.2
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 15:36:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWDeJQ1fW3KPglFZSv+YT5RPaHxkPSr+lUgHQXncsOaJJwHoRk3lZfoLukBOF2UslVcJ9gWHojM4XAne4=@vger.kernel.org
X-Received: by 2002:a05:6512:ad4:b0:539:8bc6:694a with SMTP id
 2adb3069b0e04-539da55f2c2mr163074e87.43.1728599809960; Thu, 10 Oct 2024
 15:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009145110.16847-1-johan+linaro@kernel.org> <20241009145110.16847-6-johan+linaro@kernel.org>
In-Reply-To: <20241009145110.16847-6-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:36:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ue8MRvb4h5f0ijRRNORXCrypSbpaNWZdv5S3C2kmYp3g@mail.gmail.com>
Message-ID: <CAD=FV=Ue8MRvb4h5f0ijRRNORXCrypSbpaNWZdv5S3C2kmYp3g@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] serial: qcom-geni: fix receiver enable
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The receiver is supposed to be enabled in the startup() callback and not
> in set_termios() which is called also during console setup.
>
> This specifically avoids accepting input before the port has been opened
> (and interrupts enabled), something which can also break the GENI
> firmware (cancel fails and after abort, the "stale" counter handling
> appears to be broken so that later input is not processed until twelve
> chars have been received).
>
> There also does not appear to be any need to keep the receiver disabled
> while updating the port settings.
>
> Since commit 6f3c3cafb115 ("serial: qcom-geni: disable interrupts during
> console writes") the calls to manipulate the secondary interrupts, which
> were done without holding the port lock, can also lead to the receiver
> being left disabled when set_termios() races with the console code (e.g.
> when init opens the tty during boot). This can manifest itself as a
> serial getty not accepting input.
>
> The calls to stop and start rx in set_termios() can similarly race with
> DMA completion and, for example, cause the DMA buffer to be unmapped
> twice or the mapping to be leaked.
>
> Fix this by only enabling the receiver during startup and while holding
> the port lock to avoid racing with the console code.
>
> Fixes: 6f3c3cafb115 ("serial: qcom-geni: disable interrupts during consol=
e writes")
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for seri=
al engine DMA")
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
