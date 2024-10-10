Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D771C172A
	for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599800; cv=none; b=NYoN0cHO5qMdBAS4+WOqlYEE+hyjMhtvyW73/dh6Jg98+ufmtcgYjdHLVUAZ7ntXxxi99GG2DwZFQw0cfdas6vSu+I679cCJ68TB7r9H8BZDDnINJotnWDXlqY5W+ZTlihg8LFh7Jdpa1VBIeSWgwkJAR1d2+zz9bRnwvBmF5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599800; c=relaxed/simple;
	bh=ndGUOdbmf0XLXi5qOt0/OM43ZwpMxj5j0YR7mZtrb0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFMNZqyMq/KqZYhvCwZ3PSje1wgZU/EJg6DxQKdAkxS1VNtnhJzdz4REbocmRv+4yWYVy/jf8aMwq5uwTr1EnjFOi7A14RWJIUNNhn7PG2m8Z6PBmCZyS9ze0GqNQlvVKV/OsnZvrVV4Km+oGvC8yPMec76eLKWj0DL5Rb3pk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WgC8V07C; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WgC8V07C"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fad784e304so16223721fa.2
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 15:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599795; x=1729204595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyyxlBvtxdIx44gC6sdEnPAxTnLbnwRQOcfiWPcHmqE=;
        b=WgC8V07C8FyUyGsFzvl26YdXzFgpXg44wDlmoczMke+xCrNiP0pNWOTPrFmZe8wAOz
         oqyW+Fa6swhKrSFk0/9mcMOiWa9MwpgBZ5Cgx0LZvhgB1YrxtyzKYuRNE77wSGOknP7S
         syjlkDthPhWG/vyfZbA5FKF8ngxCK5ahJ/Bo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599795; x=1729204595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyyxlBvtxdIx44gC6sdEnPAxTnLbnwRQOcfiWPcHmqE=;
        b=V9+c29M8R6JoVWC1b8Bt0rIg0mX6EiKSKw3uGSG7vO5aSjFA+iX/oWKdtD6c1+HzFP
         bhTaHKhJ15/FCZfZlOPSXz35pSW/81a1lttLkyMWfixu4Vt1soEKnYbca56+4sT7ZSSH
         C5DDlu2FO7dRgamErLJw40ELIxF0WqBEtYhOO2CKo4srAHpe1CPS6kn5q3UMpb0D5vzB
         ymAMQyc8liZXVsMVeJR0ErOOnpYqtpHX7InTSYMgAShR+z3++J1Asu9pv74VXm3pwwup
         /King/6zZvv/VgMngu5jajtp8LfeQq1pZ0kC1H+wj4juyLssqEeC7UodwSa+ROEgyZM7
         ahOA==
X-Forwarded-Encrypted: i=1; AJvYcCVGt5fqkRx0cqQTlU7zomO9bwHrrl/WA5xO3I3k15Aw1tI0Tr5hVjstx/1oaHvt5mzo+iGxZEEYZiMKL7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRi3msLooWjzEwTgk7OBAiejFF/42ft6GkJH0TUiV1DY/JXf7V
	v9LCZRP7sqm18SzkjTOXpjiXLn8X8ktubsjtI/vYi5rTpP/M+xDw/kMIUxVQ2iY886YN4dJCtf3
	f2Koa
X-Google-Smtp-Source: AGHT+IGbRu0aF21VPH+QkOPulYtuTKZgmvbXx06Ip+1XXyTDySzXRczRhohXMMDBfqG7H33GgJiMbA==
X-Received: by 2002:a2e:984a:0:b0:2fa:d67a:ada7 with SMTP id 38308e7fff4ca-2fb3272fb09mr1284301fa.23.1728599795528;
        Thu, 10 Oct 2024 15:36:35 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb2457989dsm3402751fa.11.2024.10.10.15.36.34
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:36:34 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso1432763e87.0
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 15:36:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXy2SJqAp2oM2vDWtz5MgVieWhr9FeQSf2IjocF59yggotE064Bt6eB0xR51lw/ougz2LoQnshcNnNFh4=@vger.kernel.org
X-Received: by 2002:a05:6512:3189:b0:535:6cbf:51a3 with SMTP id
 2adb3069b0e04-539da3d5293mr199479e87.25.1728599794291; Thu, 10 Oct 2024
 15:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009145110.16847-1-johan+linaro@kernel.org> <20241009145110.16847-2-johan+linaro@kernel.org>
In-Reply-To: <20241009145110.16847-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:36:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WvpOx1RHFdo7NSss3m922VqRSdsV6G+NnxyCjcp2XMVA@mail.gmail.com>
Message-ID: <CAD=FV=WvpOx1RHFdo7NSss3m922VqRSdsV6G+NnxyCjcp2XMVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] serial: qcom-geni: fix polled console initialisation
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The polled console (KGDB/KDB) implementation must not call port setup
> unconditionally as the port may already be in use by the console or a
> getty.
>
> Only make sure that the receiver is enabled, but do not enable any
> device interrupts.
>
> Fixes: d8851a96ba25 ("tty: serial: qcom-geni-serial: Add a poll_init() fu=
nction")
> Cc: stable@vger.kernel.org      # 6.4
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
