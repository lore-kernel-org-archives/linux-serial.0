Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A91AAE05
	for <linux-serial@vger.kernel.org>; Thu,  3 Oct 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986273; cv=none; b=WdGVGVCWnZYviUCGCkbARoz1CNZWuKPcb8N7TRfVPbjNakbRlQ2ih+nW59YDtao7g2ZIznK1AmO5PwqoFrkG+sgL93dNcJmVuZGRvcK18DWJossoBptZavxpZGgVv4o+mU9nO6SBdLcv2SlP3FpqybASvxmWqzJgvwOZJNlWojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986273; c=relaxed/simple;
	bh=mFfQYJY4Gj/y2j2eWGpy+miI5FqUx4eMg4Hz/3GPObU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F73tpjO/XqWSXeUKMoDZA50+Gxr4pf3VBKpcCFvNb9HUjuHTUAgkNIrbCCZ0PDhSJkmL1pKshKvd1zvSS8StKbCoJZGJH70sT73xnKAL+7TGuk1PmagIIIDiW0bC2erI4bhbWQYB+6VDWdwM842dO2pjtzFj2oX94r73DH5cZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H6eWEv5p; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H6eWEv5p"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5398b2f43b9so2315219e87.1
        for <linux-serial@vger.kernel.org>; Thu, 03 Oct 2024 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727986266; x=1728591066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJ4SQGwcH2xs9+ZoWZiOyyo2Nn/MvzkFL6Ok3JvG8Eg=;
        b=H6eWEv5pMzlVC/12cV5ri1ylRpij7rKubQ2nHiuzYeBo2qVBG6RyK9wXEgEI4sGl5g
         jrRQZrBPSNwV9AoGFNB/4WpF96IwAYXvqQ321Nlog4pZleV58E+4sTRKjuwoF/MTvOG2
         rjuziZUpcuhOKyXzGcKexvhgLKV9CbkVxOZQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727986266; x=1728591066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJ4SQGwcH2xs9+ZoWZiOyyo2Nn/MvzkFL6Ok3JvG8Eg=;
        b=MLK12zup09OaXevBlwbt8bOqI9USdq/xlU0OnTjIVWAI4dbGxq14YOK9P7LofMHabW
         jXOVImvDoWrysnOrvE+bJqzEH5U6Gr3h5lzx1DF5yXHC+OHFCSv4O53nmXEX4NaOTqtZ
         /zFlkvBK18IFpA1lSBB5ezcun/xKjG5wkIam/OeFxXbZklULivO+hkxmVMGPRNtkpNjB
         rE9QYjN0kADXP+KUVdYXbSdSkKJcrxAFODY2QN0/VeB+Tux0eLtrafrHCiF4/aOUPkjx
         uvcdaVW+GuV0AvOdFC6xslreR2k9Bu3MjP3bTpAZE4KBOXt1tPdOLkZYTlYkMIEMfafZ
         XUqw==
X-Forwarded-Encrypted: i=1; AJvYcCXCYCMWzwzYO00bG/hIVDEcLzv89/Zrc/zqCsLBAxznS3RKcQgEIcghjs3yfNPYX+uD9lIRwVPkKJvGODk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3FLP8YslYnRYlgP715p+15dmfPxMBA7GehS0/QculIYwe7HSc
	pO+NczZq/xAc3euCHXC2nt9ITaHaxh1eb0R9+iytvOsMQBsHKwExDAMnTQcPXG07A5ghkk9pePY
	v7A==
X-Google-Smtp-Source: AGHT+IG+HSnRv7eLxULCdjXPzKxUT4QpRaoicGYY8uDTbosk2KFbBNym8fFv3Yb8FiqjcYbbCPDFBw==
X-Received: by 2002:a05:6512:ad2:b0:52c:ccb3:71f7 with SMTP id 2adb3069b0e04-539ac1439e0mr95938e87.9.1727986266123;
        Thu, 03 Oct 2024 13:11:06 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a82a576dsm253504e87.243.2024.10.03.13.11.04
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 13:11:04 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fac275471dso14660131fa.0
        for <linux-serial@vger.kernel.org>; Thu, 03 Oct 2024 13:11:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbvX6Y7HAo3kFbjId4QFTYbx4AxI2NS2bXLAw+eGnSbNUDmSsRfHYwSFeDyqDAarM2Xwz0WAyt4mqKxeQ=@vger.kernel.org
X-Received: by 2002:a2e:b894:0:b0:2fa:cc50:e6c1 with SMTP id
 38308e7fff4ca-2faea26773bmr14843331fa.22.1727986264213; Thu, 03 Oct 2024
 13:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-5-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-5-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 13:10:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vwmb8Miyca4kE1sdjMCx7LVCYqaXhLmPPqsojUHdEk-g@mail.gmail.com>
Message-ID: <CAD=FV=Vwmb8Miyca4kE1sdjMCx7LVCYqaXhLmPPqsojUHdEk-g@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] serial: qcom-geni: fix receiver enable
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The receiver should be enabled in the startup() callback and there is no
> need to stop it on every termios update.
>
> Since commit 6f3c3cafb115 ("serial: qcom-geni: disable interrupts during
> console writes") the calls to manipulate the secondary interrupts, which
> were done without holding the port lock, can lead to the receiver being
> left disabled when set_termios() races with the console code (e.g. when
> init opens the tty during boot).
>
> The calls to stop and start rx in set_termios() can similarly race with
> DMA completion and, for example, cause the DMA buffer to be unmapped
> twice or the mapping to be leaked.
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
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index dea688db0d7c..5b6c5388efee 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1179,6 +1179,11 @@ static int qcom_geni_serial_startup(struct uart_po=
rt *uport)
>                 if (ret)
>                         return ret;
>         }
> +
> +       uart_port_lock_irq(uport);
> +       qcom_geni_serial_start_rx(uport);
> +       uart_port_unlock_irq(uport);

I _think_ you don't need the locking here. The documentation for the
"startup" callback say:

 * Interrupts: globally disabled.

Other than that, this looks reasonable to me. I seem to recall
previous discussions where _someone_ was relying on the
qcom_geni_serial_start_rx() at the end of termios for some reason
(which always felt like a bad design), but I can't find those old
discussions. I suspect that the fact that you've added the start_rx in
startup() is what we needed.
