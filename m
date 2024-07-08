Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5A3C6A6
	for <linux-serial@vger.kernel.org>; Tue,  9 Jul 2024 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483215; cv=none; b=FtyAPuCgE6TvCrYYiyieob4Xz10XxPhDFep+hl0kYPTEEFKOq/nXj/Qj7hO0ImqNYFYaQou+FlaWWA5W1PvUvGBWWmkyZOsfAZGRLVDCOJ0YjnXu6uSxzZ6xE9R01PhMq9gi8I+tuZefTfYBsmau8OiE3ZAEGvh2Y2/MXwGZ8KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483215; c=relaxed/simple;
	bh=/QOqCulkZsfJOvKr8tAyY6TDc5VsuMJQgVKvIy7i6Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWgYPyqtTwV+xWCleoCnoO+mTz0ARRTsFR/b0xo9UctnWu+FI0a7SK7pr974qtIX5xw2GhFimZmhaj+u6qwhUsVGLUAtroZMoNeyOxCgj4q6v6d0qWRF7u7wHq0keUggVQjt4IzK0bOb2afdonqLNLNXFY1zM162NuYc6stvoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N0AlmxtG; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N0AlmxtG"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d934cb84b6so702326b6e.3
        for <linux-serial@vger.kernel.org>; Mon, 08 Jul 2024 17:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720483212; x=1721088012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osmmEbE4YrUJJsgw8B/lNsRFY328cYQyEWy+PHmk7lU=;
        b=N0AlmxtGWogx00M0ebnvDMXvNXVOHpbM+JeaXuuGff3UujfIEnv+9HSLzz3pSVrIJ4
         /Sau7eKa3zFTzlwbNuOzL9ZVcp/jViZmsIwbR85VgcFQ0/f6zXnrH8BlmofulgqTnB7z
         cn7AROibVXQm6cHNRA6O7oMdKZNZ2il9bMm5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483212; x=1721088012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osmmEbE4YrUJJsgw8B/lNsRFY328cYQyEWy+PHmk7lU=;
        b=lyyJRHlfeAQkGZqTibxJLj4cM0PUTIzsPKDbPHVBqetFbaHsbjx5kGr9/zn/pKe4m+
         prEAi0+HTZBga1YFL6oohKZdp8p/75Svj2vLaoekxbN47/mdM2TCgs5hERTvV74qI1bR
         qOO1U/ZSxz1GxVDWNpI6dQGNe/x+DnKB/yXxWV9noLzFeKlw13o9WxKquiYZjc5et3XK
         6XPsON21JD2r3aOfyY2N3F/PsMGB9W8ZyO8C6BGVJYBB1cIVMAjeDCxYLrDHEJorqxpv
         +ERJsEokrZU/zFJ9+rmXUDoy812rxwIqQ0pLVK1gTob87Q/NNyZC5Tyl66gO1YxeKTRS
         lzpw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Dn3L2Sg/e0Pa86zGBUDSw6kV7F71qm+NmcBZheMxxNSzYfheeTrBlwatftUK/FYhvhDAHQPNLj05xxB7meICY4hnWp4jF9sOoH/1
X-Gm-Message-State: AOJu0Yz4HbsDCw14b7IAlVmphU9CYt/xIe9g2aWkQoadPpkfNJ3WlXZ5
	huc2leJqI5LN/RwcwqQZC89heIvYPk193pGapbzMpjhBy0uV9iRHTdc2L5z38dvsFYDK08mTr5Q
	ozgo+
X-Google-Smtp-Source: AGHT+IGgTLn/XH/THOcxzuxGeaJ5A5sI6xCPdGSWkfl+Tz8tHL9GFemuGZ/juKbIKcsFMQmc2zzk8A==
X-Received: by 2002:a05:6808:23d5:b0:3d2:1e7c:c3f3 with SMTP id 5614622812f47-3d93c012b0dmr1010913b6e.20.1720483211977;
        Mon, 08 Jul 2024 17:00:11 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19016cc3sm40538785a.50.2024.07.08.17.00.11
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 17:00:11 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-447df43324fso77031cf.1
        for <linux-serial@vger.kernel.org>; Mon, 08 Jul 2024 17:00:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVViYbAA/LNb3Xhb8t/a5TdDTd89H7soLDNvC+RjwO/4gkeSWAhya+CfYrHPh/+K4CdjprnnjIZD3NUsCq4TmAS0+/fbTEeMp6zXCPc
X-Received: by 2002:ac8:74d:0:b0:447:f21e:4d5b with SMTP id
 d75a77b69052e-447fba68a15mr1320821cf.18.1720483210739; Mon, 08 Jul 2024
 17:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704101805.30612-1-johan+linaro@kernel.org> <20240704101805.30612-4-johan+linaro@kernel.org>
In-Reply-To: <20240704101805.30612-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jul 2024 16:59:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VHOTQKNNbkWX17o57weP_wTm__MCSGPhFHQ+uG1CD+Bw@mail.gmail.com>
Message-ID: <CAD=FV=VHOTQKNNbkWX17o57weP_wTm__MCSGPhFHQ+uG1CD+Bw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] serial: qcom-geni: do not kill the machine on fifo underrun
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 4, 2024 at 3:19=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The Qualcomm GENI serial driver did not handle buffer flushing and used
> to print discarded characters when the circular buffer was cleared.
> Since commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> this instead resulted in a hard lockup due to
> qcom_geni_serial_send_chunk_fifo() spinning indefinitely in the
> interrupt handler.
>
> The underlying bugs have now been fixed, but make sure to output NUL
> characters instead of killing the machine if a similar driver bug is
> ever reintroduced.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index b2bbd2d79dbb..69a632fefc41 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -878,7 +878,7 @@ static void qcom_geni_serial_send_chunk_fifo(struct u=
art_port *uport,
>                 memset(buf, 0, sizeof(buf));
>                 tx_bytes =3D min(remaining, BYTES_PER_FIFO_WORD);
>
> -               tx_bytes =3D uart_fifo_out(uport, buf, tx_bytes);
> +               uart_fifo_out(uport, buf, tx_bytes);

FWIW I would have rather we output something much more obviously wrong
in this case instead of a NUL byte. Maybe we should fill it with "@"
characters or something? As you said: the driver shouldn't get into
this error condition so it shouldn't matter, but if we have a bug in
the future I'd rather it be an obvious bug instead of a subtle bug.
I'm happy to post a patch or provide a Reviewed-by if you want to post
a patch. Let me know.

-Doug
