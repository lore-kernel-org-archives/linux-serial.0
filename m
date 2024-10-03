Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B51ABEB4
	for <linux-serial@vger.kernel.org>; Thu,  3 Oct 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985360; cv=none; b=haTTUH17c+Lv1+teD4Oo6/fT88AX2rbmxseCj8CFyXXa90CpAWbHkCYhNQY88L2hucUsBJ394NvWjWjIGXZqKZMq0nj4z9uR9GYGCwcU5HeOWmVbbnetwZkTG6kahAyvYYOFhelORiOuvcd4hI6S5O+i7VUJqr+USXjq3kZrdOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985360; c=relaxed/simple;
	bh=5EccGR70GSzvWHC68nC+X+tqsSbWiKZAhks9ypGfRZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjOtDXImaBeHEQXapo2lBJyTIQNRHKnXG2Ud7W95lRj5h4Udb+BqJyc/1mceNtVv+zRA2Z+Zljb8OnPA65NccrDtJxMbZkz+skhythCEJGbWjmN8fYWq+0jLzLnK0phb+QF7Y7EN1hPq1rBWbjykKiFWV5Wmx/pMFi/AnAWx6fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bIqTpKe4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bIqTpKe4"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5389fbb28f3so1442291e87.1
        for <linux-serial@vger.kernel.org>; Thu, 03 Oct 2024 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727985355; x=1728590155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9YMrf0Tzihdplb/RBKwiSK1PmhTX7h2pmpItk8J4v8=;
        b=bIqTpKe4iyhZq9xmUzl5zpJ4G6fRhduh0q3wJWuWhPRbQ8V7ZG2XgbBUYckU7d8esV
         OW8N6Ba9bL1VSaCVUiVLmhAe+p02FPJP7+id43p/HrpbSaPYuLl3t6DA2/4e+AX+4aiv
         rq1WE0f0FRxqzsO/nvvE1+GHW9QLQRoSJ8mjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727985355; x=1728590155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9YMrf0Tzihdplb/RBKwiSK1PmhTX7h2pmpItk8J4v8=;
        b=hCQwQ15Uoyn1pbCkzzxStpPGLsw7v+qmmfUctZNi7bYbT7hzOij9Vtk63t0RXiMZl8
         nL8474/i1Dh931w4n1AV7cI4kHFpT7HlPMXzheJwY/Xi3E/TLkkfDBb/IcoaelRRX9rO
         Qa5xhXYq6Ix1HgjUCYZYXMQApyjAqN6/rAhOUNt+LeWxtKgNy16TP8uPAgwMy7s0rO2l
         WwzEMT22/yT6tYLvGcg26k5RLWb3TmrPXVod2FIWDar3q4pv3x1aZ1JoWzoGqFiZz1rM
         zcMjw51qBFSpEE85FeJW+WzqZRntHZnMBIcFgEUkK6x9O9OviLy1PTsQu9H4slfGrbK6
         TrFg==
X-Forwarded-Encrypted: i=1; AJvYcCUTytUhcezzk6YTX8SlRocbrW6fOUr1qtpig3D1Q+5a+3WQjWZWvx/174ASG4XMMWtqUdkdGJSQ91UE93c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT8ZGJt52qimSZGkW04b7gHMzNgcKJn38bxKLoBrDUPxM289UM
	70gW8WnLVcczQctsLOB/eoa5Yd+/iyMRfyYCFopFjwf0ZlQ9exJi75IwcWZJIIKkQ3YI8OQOTcO
	VG2qh
X-Google-Smtp-Source: AGHT+IHe4Ry2rbbG/m5YfI1aw0PsiQnZMGw+vwqFEE136BYhdAnjWGokqs9PEXXBA0Oo7WjNWYzO0g==
X-Received: by 2002:a05:6512:3da4:b0:52f:260:c459 with SMTP id 2adb3069b0e04-539ac170ea3mr87552e87.22.1727985355307;
        Thu, 03 Oct 2024 12:55:55 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a82aba11sm247462e87.299.2024.10.03.12.55.53
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 12:55:54 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398e58ceebso1372348e87.0
        for <linux-serial@vger.kernel.org>; Thu, 03 Oct 2024 12:55:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8Rtr2VsgBsZU0/FVuj/F6KXovYLZOmlPjxUuuT4TeyaxpYs9kET9zeuaiTfjabZYTIWJcPX0fwQU7dy0=@vger.kernel.org
X-Received: by 2002:ac2:4e06:0:b0:539:9476:25a with SMTP id
 2adb3069b0e04-539a627ba0fmr1592030e87.21.1727985353524; Thu, 03 Oct 2024
 12:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-6-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-6-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 12:55:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9FfwKREBfBbCRiqH3y2K=oTfQPj1Nx1paxrVwFD-efg@mail.gmail.com>
Message-ID: <CAD=FV=V9FfwKREBfBbCRiqH3y2K=oTfQPj1Nx1paxrVwFD-efg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] serial: qcom-geni: fix rx cancel dma status bit
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Cancelling an rx command is signalled using bit 14 of the rx DMA status
> register and not bit 11.
>
> This bit is currently unused, but this error becomes apparent, for
> example, when tracing the status register when closing the port.
>
> Fixes: eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  include/linux/soc/qcom/geni-se.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/ge=
ni-se.h
> index c3bca9c0bf2c..2996a3c28ef3 100644
> --- a/include/linux/soc/qcom/geni-se.h
> +++ b/include/linux/soc/qcom/geni-se.h
> @@ -258,8 +258,8 @@ struct geni_se {
>  #define RX_DMA_PARITY_ERR              BIT(5)
>  #define RX_DMA_BREAK                   GENMASK(8, 7)
>  #define RX_GENI_GP_IRQ                 GENMASK(10, 5)
> -#define RX_GENI_CANCEL_IRQ             BIT(11)
>  #define RX_GENI_GP_IRQ_EXT             GENMASK(13, 12)
> +#define RX_GENI_CANCEL_IRQ             BIT(14)

This looks right, but do you want to fix all the rest of the wrong
bits in this list while you're at it? Things look OK up to the
"RX_FLUSH_DONE" and then they're wrong. Specifically:

* My datasheet doesn't have RX_DMA_PARITY_ERR. Unless maybe it's one
of the "GP" IRQs?

* My datassheet doesn't have RX_DMA_BREAK. Unless maybe it's one of
the "GP" IRQs (though why would it be two bits big?)

* RX_GENI_GP_IRQ is 12:5, not 10:5

* My datasheet has RX_GENI_CMD_FAILURE as BIT(15).

In any case, this does make it better so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug
