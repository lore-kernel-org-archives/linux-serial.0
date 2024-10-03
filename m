Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AF5A79B
	for <linux-serial@vger.kernel.org>; Thu,  3 Oct 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980223; cv=none; b=Fl+tbeqZG6dQXcOX75aCP3/aIKJKpbgIIQHLAh+KBSlEIGA6z7+IoOiBN7Bxosyqnme5Ep0CsiBSI2Yig4ogB0BPelib6BZZfTdCjdc6qXI02VAeBThVPjyzSf3BwhD/P/snVGoxPKRCETzIdX4IOFg2RZW6gOc5RyWDzoiSlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980223; c=relaxed/simple;
	bh=Njq0fwvF+5VhnQZ1131zaikWJHtF2S4Q3i8c1LX2lvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdC032yTavE2GZfi56tVxAdB4glGnFG3wt3YYJuy0uJGcnQ2ijxksdvEQou0B4i1gWGv0aLAMIuF2RREd0nXwZ/IIvlZWr34L+qm+FPbDlZlZ3nYE3k5YeOUMuvMJWRBnpetKcoWxnh4wiblLhjgB7szF1MePCr8VI+opqXz65s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fb1SgGiY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fb1SgGiY"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53991d05416so1623995e87.2
        for <linux-serial@vger.kernel.org>; Thu, 03 Oct 2024 11:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727980217; x=1728585017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQhmHIpIANYWDxfaKfnE9P0S3zwxERnpg0mMy9nFKho=;
        b=fb1SgGiY57LbfmRHv1G3tLy50zXrgozh7jEeNshBWKbqaV6FdXUYA8m15zu3s8Qjru
         c9wbzOmIclZu1mqCuzil+qlvsPKlGRuPx/ptEx6KqhZ3bobxwpxhAuVIjla6H8/J0n/0
         q5gxUWq8EVjWmNnpNeCA+JPseHRO6r7WeCBL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727980217; x=1728585017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQhmHIpIANYWDxfaKfnE9P0S3zwxERnpg0mMy9nFKho=;
        b=wKCpJB17j98djf7FIzluvkdNOf32ivgIAO7cB/y9DP34cYBVBBlk1ixR7Y3Ln+5hmU
         AB9CB2/MYn6OaM7dEnqgA7CIPVBHhvIAdVovZKkdQ7SIW4re6eSApJoWanIKkatZw3wJ
         LfN5rUZZmVXwo7r9dpY4UXvmruLt7JU2v7g46cXLBDOmegM4+RcA5iiQtOTYwLgZBigc
         0fAeMwOGq90HvAqySbC/+sYlzyxJ8lHTsyUGxpObKzzPqBYakI0DenmBaXBebIvYfFiu
         SXseKSA/YTBeMOUx5SwSh8hyHc6CA7lgS6i6w3EIT553hbCHGF+BtRNS5I9m2oEPdS14
         HO6g==
X-Forwarded-Encrypted: i=1; AJvYcCXEJ1JmpEOv71kPK3diTPE+fC62vEBI7kGbW/UMRvJeYSJwlmkWaYbD+kK3u1LMn6FCLya6tYKik/inpTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywg3sDzmpDHVPwEPl51X3qE2fLlU1WuEewljRdTcxfMsPSOqvv
	StdbdwHsXOhY3+JNDHP3jgzWgFzmF9KQ2JIeO3HlOgdm2Y8lzylj/IfBG2NfL4Ko2IIMlN/ZIie
	pzVHt
X-Google-Smtp-Source: AGHT+IH+jWJpb2oKWbYKRwhQa+RlRaZMf4JDsIcvOfJECD4gpfxJbuJX3bonh28qdfqxxtoy/7PL9g==
X-Received: by 2002:a05:6512:31c8:b0:539:9510:2b8a with SMTP id 2adb3069b0e04-539ab9e6d07mr263168e87.53.1727980216932;
        Thu, 03 Oct 2024 11:30:16 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a8256b74sm232679e87.81.2024.10.03.11.30.15
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 11:30:16 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fac6b3c220so20056881fa.2
        for <linux-serial@vger.kernel.org>; Thu, 03 Oct 2024 11:30:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxHBrFfkvxRletSDpQwpJCCwyRII4cHuTyY7ivmifd3QBRAYeMeG8AwkFs7+hPu71D8+eEbedLT13nTTg=@vger.kernel.org
X-Received: by 2002:a05:651c:b10:b0:2fa:e52f:4476 with SMTP id
 38308e7fff4ca-2fae52f46b7mr54095681fa.45.1727980214619; Thu, 03 Oct 2024
 11:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-2-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 11:29:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V31VFVoTWstVUnC_qDBmaUCb5Xv7pyUxUto7mquR5U4Q@mail.gmail.com>
Message-ID: <CAD=FV=V31VFVoTWstVUnC_qDBmaUCb5Xv7pyUxUto7mquR5U4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] serial: qcom-geni: fix premature receiver enable
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Aniket Randive <quic_arandive@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The receiver should not be enabled until the port is opened so drop the
> bogus call to start rx from the setup code which is shared with the
> console implementation.
>
> This was added for some confused implementation of hibernation support,
> but the receiver must not be started unconditionally as the port may not
> have been open when hibernating the system.

Could you provide a motivation for your patch in the description? Is
patch needed for something (perhaps a future patch in the series)? Is
it fixing a bug? Does it save power? Is the call harmless but cleaner
to get rid of?


> Fixes: 35781d8356a2 ("tty: serial: qcom-geni-serial: Add support for Hibe=
rnation feature")
> Cc: stable@vger.kernel.org      # 6.2
> Cc: Aniket Randive <quic_arandive@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 6f0db310cf69..9ea6bd09e665 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1152,7 +1152,6 @@ static int qcom_geni_serial_port_setup(struct uart_=
port *uport)
>                                false, true, true);
>         geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
>         geni_se_select_mode(&port->se, port->dev_data->mode);
> -       qcom_geni_serial_start_rx(uport);

FWIW, I found at least one thing that's broken by your patch. If you
enable kgdb (but _not_ "kgdboc_earlycon") and then add "kgdbwait" to
the kernel command line parameters then things will be broken after
your patch. You'll drop into the debugger but can't interact with it.
The "kgdboc_earlycon" path handles this because of
"qcom_geni_serial_enable_early_read()" but it doesn't seem like
there's anything that handles it for normal kgdb. If you drop in the
debugger later it'll probably work if you've got an "agetty" running
because that'll enable the RX path.


-Doug
