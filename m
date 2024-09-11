Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B900A1BB6BA
	for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085994; cv=none; b=YNOZwkszoxbafnrVA8bPZRBL2645PnOBQf8Z9IyuB3Gh8RG22AiCHllZcYD2UCfXzG2j0bX/z4qML9BfRFEv3OWLxzmsgSgTkoFhsgCAN6p7EXg7up0xiV/hpewsOmI3oUmmT8JKUthRyUPHvXihhhpyOeAmcGwF5U/YlTuCUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085994; c=relaxed/simple;
	bh=LNjfIqdnJ7xDwaFYjSU3zgI/rR85Tz4XyQ8E2ga59QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7xy6oXhtMz4S+bZBTdukjeVv//A0s/KJlS4zYgXI8gbXXXua55zyuR5tYSGIEuJCMKcyPwSKtirP2vPhYXZJYc7HWNkEqxDLLnuaULn7BjXm0fobi0gcOiThqUt6mTfhOd4D99g7hB+OdZQDPCrvscEmh6BajdpzJTictI3rtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mWVV6MMU; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mWVV6MMU"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c3561804b5so1344356d6.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 13:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726085991; x=1726690791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ2fUDORmV/sdyoK/2gbNCgI2EeD5lNRSWNYdKecCGo=;
        b=mWVV6MMUA0Zol+1l85DXRzqYPwBYiA/Kvt+N6uPiHR3O4XwwC1yvtIyxnOLC9c8VMF
         cwpPWd8p4LUi4c46+bo9h0nuQHIseMS+cH4cnazfl+5+iZxF0vxzEOTE8gbbFoygz3Ts
         8U0+iZTW/tezO0oCpUG+YSO+DPkuPW0epRa/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085991; x=1726690791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ2fUDORmV/sdyoK/2gbNCgI2EeD5lNRSWNYdKecCGo=;
        b=BDGXhuslUrMpLcGZZ1BV+l9btHw35cvGIuro/UnGt5OPyvF77mE347cCJHkjWx6e6z
         sWR8v9+ZtphuSGHrQalAE+jCf2N3YX0TbsBt9DjVzHON8Elkv523MbkbJV6FFnRi+XLa
         TW04R/SE6GJvgfln9nCi2+t0HRK3gJc3sEJ6QzPNx9FPWKsYsB4uo7W0M1H1oHZRwVo4
         jrD964C6G+3/ELoJ0vyVcQXx4xI30DjYqrSiNRf1IAi0BbkigIDsIdwX+DhREEj5mjp5
         z/g0XrBCwyhfvt/SPRfIuFoH+72DoUUIUWr6qDEzvbnfSLT9IhRKWG+6UgaLfyonqZv4
         lg/g==
X-Forwarded-Encrypted: i=1; AJvYcCV7f60dUZg2vg86L5IAofYMbePSQGV+NzSGh3SKRmlkKbi8TlTCTTAmD80BJYhI8HVQ8BiQHM4YeaWU3lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4HANnArbNvMcoBuEPW07O2SXSjm0+aC/8y5jfB2hdDBWbYytb
	gW/ffqo1QlivPZuKrw0TUsjmXmt9/uhqKNXFTbKbQTKbik73uprvZPdyN8p4twTtHur/w4jCQbw
	=
X-Google-Smtp-Source: AGHT+IHAJ+MUZsdU7kYPQJ+DjGUg47KOMood2ldvnEzRErjRboGGslHx+NQqe3xGRgEuOR3UPS1EZQ==
X-Received: by 2002:a05:6214:498a:b0:6c5:1666:c2d6 with SMTP id 6a1803df08f44-6c57352e313mr9695876d6.22.1726085991000;
        Wed, 11 Sep 2024 13:19:51 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5343491ccsm45810546d6.70.2024.09.11.13.19.50
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 13:19:50 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf92f96f83so1331496d6.3
        for <linux-serial@vger.kernel.org>; Wed, 11 Sep 2024 13:19:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIPGcGarucow9w/87jzmcBHPB0/0VrXj3B/DFqzH3rs299o5DF1m9x81Alj6OKqoNhCn86JkGXa/OrGak=@vger.kernel.org
X-Received: by 2002:a05:6214:448c:b0:6c3:5597:406d with SMTP id
 6a1803df08f44-6c57347eb8dmr12957366d6.0.1726085989561; Wed, 11 Sep 2024
 13:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906131336.23625-1-johan+linaro@kernel.org> <20240906131336.23625-2-johan+linaro@kernel.org>
In-Reply-To: <20240906131336.23625-2-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 11 Sep 2024 13:19:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBVct4e4oe+KP1_2FuFjZ4tsX+FavK56FUnrOfZfP=fw@mail.gmail.com>
Message-ID: <CAD=FV=XBVct4e4oe+KP1_2FuFjZ4tsX+FavK56FUnrOfZfP=fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] serial: qcom-geni: fix fifo polling timeout
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 6, 2024 at 6:15=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The qcom_geni_serial_poll_bit() can be used to wait for events like
> command completion and is supposed to wait for the time it takes to
> clear a full fifo before timing out.
>
> As noted by Doug, the current implementation does not account for start,
> stop and parity bits when determining the timeout. The helper also does
> not currently account for the shift register and the two-word
> intermediate transfer register.
>
> A too short timeout can specifically lead to lost characters when
> waiting for a transfer to complete as the transfer is cancelled on
> timeout.
>
> Instead of determining the poll timeout on every call, store the fifo
> timeout when updating it in set_termios() and make sure to take the
> shift and intermediate registers into account. Note that serial core has
> already added a 20 ms margin to the fifo timeout.
>
> Also note that the current uart_fifo_timeout() interface does
> unnecessary calculations on every call and did not exist in earlier
> kernels so only store its result once. This facilitates backports too as
> earlier kernels can derive the timeout from uport->timeout, which has
> since been removed.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 4.17
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 31 +++++++++++++++------------
>  1 file changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
