Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B219EEC6
	for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250767; cv=none; b=A7cQkoct7pS3m7EyOq+0e22QLB4EcQInVCXtEhkxvEbuop5g9o9tQ9co92PdXnNlYZBYVAP28KCoByRCehT/kUeXYI9WYI6xOglErqi6jsPSvkt+aknQ7sh+Ioe6J0SrDtdhapAW218cN5M1/QwqFa6DL31YkXXfMbV7zQpP+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250767; c=relaxed/simple;
	bh=RmWwBKqpQhgnS45GQ4aaZI6SvIbgoTYxZp32M5eQP5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chs8pavqlq9TcmyT18hGjaLcb7dmp/kuQ2qB3FiUnUVbnTDsSez9+2U9WgrOEEQCj+qEemZ3rifHYe0S3NIuzuVHYn+2gkUtWFDJXNe8ihGHgi4pX/ust0yrwuQrGc5ugLP5ZdRyl+BzXiUZlq9gTXn9Qc75PB7YWp83zYJFe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ML0Y+EyK; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ML0Y+EyK"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b2c6291038so36418966d6.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719250764; x=1719855564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bcigEvxElFnNf6XQZ1LGyn+920C2Rwm5nJUAotnto8=;
        b=ML0Y+EyKNiVdw+KpF8EYsjABUHPy2ApYl+20TlGRetEgKhyzKR1uVtdJQ1b6+78ea4
         1GmzoNFlLZXkd/28e1gra9helEvyM3LdVlJdyaEufFwizV+1sE5bh+htAt7hAxbvnz0j
         FoHFC4NweDvyltpghFKryt9BsG77nxUSwLQDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250764; x=1719855564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bcigEvxElFnNf6XQZ1LGyn+920C2Rwm5nJUAotnto8=;
        b=sqYHRM9AMIlTqKwPQKkVEib5bb9TvYpGVTFbZas+yPw1DwGUtRaMqgpkNgax4DvZUx
         ha1QoBPGXCDH4Eat7WO6F0Px42ge4bjkM+nNYnqHqfuenTGHXZacgqdEBMe84dO2kb+2
         My7oplvzb9lA3sw4tT6rkfyBT73KtjX7DAvs0uvqfQlZdbPxSEqoMsfzH6R73Ynt/jGz
         sA3xUm8GGWtWcjhQBoHCTtPofGw3mXdy2lpvKUPxm2DrWeXsN4JOLlrlGWjLcd1KFENt
         tt8XJEw9U0cTLf+YbccTTCu3pgnCQVgebpIqnxmI6jVbyTxklKCyYkEsKXFfmOsw6ypw
         oimQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWX/oHzg3CcX+XHszxxuxVMfR9wTjy+fDKenreaC/Oo8wpRMpc6KTXFUag7DzXJHKgp4xg4djjR3n96sLSmeOr+a/ZUGa2K3Ifjvwc
X-Gm-Message-State: AOJu0YxaVV/LpyrDgpqAeKQwSyjRNDl0myQTZKArtqfhZ2/S3TZGb3dT
	5Q63DM/w2M4Qe6edUA4c0yHy8jkRk3cIjTP1Iog4k5Hr0S/kESVrxXEFAovTgW0ti/duxJ1yna4
	=
X-Google-Smtp-Source: AGHT+IEz+xJhA5WUqWSNaj8VgoJpA/4jprFv4Z+AZHn8vuU3KbkXq5il+RusOEjIyz3x+fvGAx3k0A==
X-Received: by 2002:ad4:4ee7:0:b0:6b5:2aa3:3a7f with SMTP id 6a1803df08f44-6b53223157dmr97728026d6.20.1719250764328;
        Mon, 24 Jun 2024 10:39:24 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef4a12asm35750686d6.104.2024.06.24.10.39.23
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 10:39:23 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-443586c2091so26701cf.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 10:39:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWh48XLMdpGvIh7j5wlQKX8WvCpePfWpTAsYKA3PSh1d+a8iBFl7D6f+0DdrM/jJklPlEpC4GMT/KT1HaNgd/K3j/kpxuz+aJX9Asq7
X-Received: by 2002:a05:622a:4b18:b0:444:e11d:709a with SMTP id
 d75a77b69052e-444f2520e93mr65771cf.20.1719250762638; Mon, 24 Jun 2024
 10:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org> <20240624133135.7445-2-johan+linaro@kernel.org>
In-Reply-To: <20240624133135.7445-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 10:39:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZXnnbwTNc6dSqZvyCUc0=Wjg9mvBYsA1FJK3xR6bDEg@mail.gmail.com>
Message-ID: <CAD=FV=VZXnnbwTNc6dSqZvyCUc0=Wjg9mvBYsA1FJK3xR6bDEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: qcom-geni: fix hard lockup on buffer flush
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The Qualcomm GENI serial driver does not handle buffer flushing and used
> to print garbage characters when the circular buffer was cleared. Since
> commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo") this
> instead results in a lockup due to qcom_geni_serial_send_chunk_fifo()
> spinning indefinitely in the interrupt handler.
>
> This is easily triggered by interrupting a command such as dmesg in a
> serial console but can also happen when stopping a serial getty on
> reboot.
>
> Fix the immediate issue by printing NUL characters until the current TX
> command has been completed.
>
> Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't love this, though it's better than a hard lockup. I will note
that it doesn't exactly restore the old behavior which would have
(most likely) continued to output data that had previously been in the
FIFO but that had been cancelled.

...actually, if we're looking for a short term fix that mimics the old
behavior more closely, what would you think about having a
driver-local buffer that we fill when we kick off the transfer. Then
the data can't go away from underneath us. It's an extra copy, but
it's just a memory-to-memory copy which is much faster than the MMIO
copy we'll eventually need to do anyway... This local buffer would
essentially act as a larger FIFO.

You could choose the local buffer size to balance being able to cancel
quickly vs. using the FIFO efficiently.

-Doug
