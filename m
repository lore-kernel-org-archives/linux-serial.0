Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E4C16F287
	for <linux-serial@vger.kernel.org>; Wed,  4 Sep 2024 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486696; cv=none; b=jagjX+qUY6NDIX+LFrN878ZMWa08cJRVj35Qt9pJC2dYbY0lgSTMKkgxmiAV90wJj5Vye3KF5u64/Zw6Q5Flo2Ue3Tlqcn6MqbWjzC/lUyOFYS1Cd5JS5dFfXFRTvwXABp6pRkJaZMJZ/VFS381zMYw8FU3UWhVPb0F0IDZRQTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486696; c=relaxed/simple;
	bh=52OavEbDbnnXzGVYj1cdimeK3fNcZ3tbnsTSFU90N5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvH6UCD564eUfSvTVJVPPDCWhHaClKoc9Ra9D3zSnigLHacIsh15uHh8uDoPpP2tq4nfT588+f31qKv3fjlyR+L3o1tpR2M7V6udTwVFYFiWN5pOOJBzMQRzz7SzstvuBZXvgYFkdqH9TM9sxQGX6flGq2DIdVb7XZAhxsIVAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C8B4Pu7m; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C8B4Pu7m"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7091558067eso66918a34.3
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2024 14:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486693; x=1726091493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEVB0OaxtEANZF8G4JgUXQ7IBpjIjKgmyEACvOZxq44=;
        b=C8B4Pu7m+yGIBipLecwld/aykc2j6fT05QvwJUKZtzO/gjHu4lqFiM8aCcNcrr3Ayl
         hTAu+A/hSofKApJOjdK5zRnjzBm/UfVzSeNBHyxXnVlPGuLxJ/tPstfRycF8mo3/gYjF
         Rz+gkJVntXToufnGfBlMIAd9F0iiMKm9BFflo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486693; x=1726091493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEVB0OaxtEANZF8G4JgUXQ7IBpjIjKgmyEACvOZxq44=;
        b=uhg1v7cgO5jyQFGhxYMr+dAD2FwPT2x43+972OxxuPPTKImIScZbFtXf1PYDZKw5iB
         uRI5wGGRjP3+L5iYpbwDBbQtcs/hkrpupuogdrfIq3/dganRYXE08Oy+vKrWVX74kwl5
         COxIHGNAPRMYvjUtfEWrB2kNfuW8y2wisplNOB+uqs7GoTkau8yo4vLqjPyMmIslhdes
         EcW/W1rhCM+ytJsUxnGuyCNG2UkwpEQt3Ba2eeJw9xD54rET4Im0zu032b9kv5XTvI6L
         mQdgSG7C15Cobq7hrrxhzvxYeROwfBy4TVqPTNigxHJ/12wUjoTl7a1IWw6BRDzVOyJ0
         j81w==
X-Forwarded-Encrypted: i=1; AJvYcCWSIRDcSvwXK2zf5FbkFRP5Z+sy7EDyhcxmhXcyQ8mbJYG7nycjq3/1BwRR4WGoKeVTrpHXJTFG+xNVKT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTu1zkfsXxu+WWCiGKglcisQHmThEFDTO6pQOLCz/HfOV9xcpU
	sGLUHzXVPg1qd92Qn2CjeFNjhiGLHXZ9ynpDsMs+hieCxwknk58mqmVkQHxhB/t5aAfvrBbKa28
	=
X-Google-Smtp-Source: AGHT+IEaCJm3gWJat0iC+RSTiHx5GoNFBDDA/ZKtagyf/5xhyZ0oM3vVqjk2Jm4o7BcHbaAZukuxsA==
X-Received: by 2002:a05:6830:349d:b0:710:b6be:4279 with SMTP id 46e09a7af769-710b6be4eafmr4137200a34.8.1725486692820;
        Wed, 04 Sep 2024 14:51:32 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f67156964sm3043661a34.22.2024.09.04.14.51.32
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:32 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70f73ca989aso96490a34.2
        for <linux-serial@vger.kernel.org>; Wed, 04 Sep 2024 14:51:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8cyM4r2mZGecndySAdvmFSjMjgsrOzSK6y/1Mc1dKoT7n+b0RYL8Gvkg5+7Yx8L/jXkFo4qwZk2wcmmU=@vger.kernel.org
X-Received: by 2002:a05:6830:6d08:b0:70a:988a:b5fd with SMTP id
 46e09a7af769-70f5c406907mr29012888a34.24.1725486691455; Wed, 04 Sep 2024
 14:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-7-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-7-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:51:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XnpPnSToWV3f2Z-DWm2-1rdgYmDZeicGGRQD-_YjS2Bw@mail.gmail.com>
Message-ID: <CAD=FV=XnpPnSToWV3f2Z-DWm2-1rdgYmDZeicGGRQD-_YjS2Bw@mail.gmail.com>
Subject: Re: [PATCH 6/8] serial: qcom-geni: fix console corruption
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 8:26=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> +static void qcom_geni_serial_drain_fifo(struct uart_port *uport)
> +{
> +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> +
> +       if (!qcom_geni_serial_main_active(uport))
> +               return;

It seems like all callers already do the check and only ever call you
if the port is active. Do you really need to re-check?


> @@ -308,6 +311,17 @@ static bool qcom_geni_serial_poll_bit(struct uart_po=
rt *uport,
>         return qcom_geni_serial_poll_bitfield(uport, offset, field, set ?=
 field : 0);
>  }
>
> +static void qcom_geni_serial_drain_fifo(struct uart_port *uport)
> +{
> +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> +
> +       if (!qcom_geni_serial_main_active(uport))
> +               return;
> +
> +       qcom_geni_serial_poll_bitfield(uport, SE_GENI_M_GP_LENGTH, GP_LEN=
GTH,
> +                       port->tx_queued);

nit: indent "port->tx_queued" to match open parenthesis?

...also: as the kernel test robot reported, w/ certain CONFIGs this is
defined / not used.

Aside from the nit / robot issue, this solution looks reasonable to
me. It's been long enough that I've already paged out much of the past
digging I did into this driver, but this seems like it should work.
Feel free to add my Reviewed-by when the robot issue is fixed.



-Doug
