Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF21A08DD
	for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267596; cv=none; b=dbQMZaP9wb9RSIkRPeNlo3pEP8YYjjM8UtTSyyaq8rm06fSzJjJY0d4yunKzV0h3zqQOo3MsNRPbvPUh87oclror2GoDT1j95Oxp7Jm8itEPs/RsETCftVMUfV/ucjURr1K30GO0KbvE4JscisZ1NtRkGZn8CqMqj/0mR2Jq+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267596; c=relaxed/simple;
	bh=WbV55czxCzoSTYA/sPnqyvQYpq3855larmC1rOGAf6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiIJyRcgu+o/Vf17k43WTtmN8wQKY4DisDIzIK5bx8ZcKoVVnUlsIZ6V+gme9HS8g/qP1MS72dGlvZAjp8hqB1qUYLUkHcHRiPfiJh1lIfYItgf0OO9Mzzt+x1Deww0opRbmn0R0bk0/VPO+yn2QadMi5/h3Txir/wTUVUm9zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NXf8vkoy; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NXf8vkoy"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4ef69082a20so655321e0c.2
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719267591; x=1719872391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbV55czxCzoSTYA/sPnqyvQYpq3855larmC1rOGAf6c=;
        b=NXf8vkoyUdiLGwE8GXhqfp+i0/XFM/uxv1z+ah3oPd4B0I+Yj8/dPV9jjwO47ZsYYc
         LOTMyyDernxOb7HrZplSnr+/NCsbyISz/heDNl4BKAMJWH9MrIaW4i5pj1A6LmzZodxz
         NKnEge4UouqjZ1rp/7/l3Lsx0smTL1LesgPoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267591; x=1719872391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbV55czxCzoSTYA/sPnqyvQYpq3855larmC1rOGAf6c=;
        b=NOj0hH9WNBpPopW2xJoADNVAok9aUL72w+dWJmNxD4OwYTFUFx6bk7AHTEGEUbncT1
         skSQFWBX/lBAzl4IO+6xGz4Rt8YCLjqffJwxwKsuo/qA2GRIolpmVzw6i+DLqmXVBk8/
         R6MlDtEtCS40cbwplknG7DyBll3jOos7KXH6nIt8/xQZaoL2kwoNgC/Hr9GaiIGuJTR3
         H4gGcMLWpdIyPonSNAFooRb38x+yxyT7PMnLny9myc56MFLMyhObV1WpLFx7CFoob5nU
         4TAwl85C54dqREpiDZdTi9H0IoK4c+ieTOxeNNIL9/c1p1k9HM9PujHrJDH/qdVreZUJ
         Qccg==
X-Forwarded-Encrypted: i=1; AJvYcCW6CacdkzNgyyHZdCPEcAR9tRpicQkI88Z5CqDdvn3yxgmggZMPw9+b8wt+dGZ1pfAHO/KHkbA8U7ylTFo8b4MpIwpgrryQ3fVVnDqI
X-Gm-Message-State: AOJu0YzopjJbI9+krdFZfwO9bfjOam7lx77cqgtqmRPwbGi6zU76GnOK
	etfcZ/NkxxZ4mVHdV4EMTYOTNsleMUwap8pZWnKrkdjlVZTmYT5aECn0PD5gwnDZ7aMTnMzYGuQ
	=
X-Google-Smtp-Source: AGHT+IGu3RIV2krmHWWFSzdyhiLBxugjR/2YeGj7yPr8hJktmtwhddz53w3zhxrN5v0R0YUObL8VhQ==
X-Received: by 2002:a05:6122:45a9:b0:4ef:530b:9d56 with SMTP id 71dfb90a1353d-4ef6d80805emr4881367e0c.6.1719267591420;
        Mon, 24 Jun 2024 15:19:51 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfe944sm38537316d6.16.2024.06.24.15.19.50
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 15:19:50 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-443580f290dso49301cf.1
        for <linux-serial@vger.kernel.org>; Mon, 24 Jun 2024 15:19:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTW3cszSL46LeXVc+KEKmuViC013IjQd4fjqWkjKckQSscCtKHF2RfFBhrCW43IZDUE3kvb0Cn8hJQ2kfbtLEfigUHNz5GSXTEuMN3
X-Received: by 2002:a05:622a:18a9:b0:444:ee24:8dc8 with SMTP id
 d75a77b69052e-444f2566c83mr1037071cf.22.1719267590005; Mon, 24 Jun 2024
 15:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org> <20240624133135.7445-4-johan+linaro@kernel.org>
In-Reply-To: <20240624133135.7445-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 15:19:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UL2NCbxmQALjKbW4BSpf4WkM30ZHLf1eZiMqRP+s-NDg@mail.gmail.com>
Message-ID: <CAD=FV=UL2NCbxmQALjKbW4BSpf4WkM30ZHLf1eZiMqRP+s-NDg@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: qcom-geni: fix garbage output after buffer flush
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The Qualcomm GENI serial driver does not handle buffer flushing and
> outputs garbage (or NUL) characters for the remainder of any active TX
> command after the write buffer has been cleared.
>
> Implement the flush_buffer() callback and use it to cancel any active TX
> command when the write buffer has been emptied.

I could be reading it wrong, but in the kernel-doc of `struct
tty_ldisc_ops` it seems to indicate that flush_buffer() is for the
other direction. Specifically, it says:

This function instructs the line discipline to clear its buffers of
any input characters it may have queued to be delivered to the user
mode process.

It's hard to figure out which direction that matches to, but looking
at the descriptions of "read" and "write" makes me believe that it's
supposed to flush characters that have been read by the UART, not
characters that are being written out to the UART. Maybe I'm
misunderstanding or the kernel doc is wrong/incomplete?

I guess the underlying worry I have is that there's no guarantee that
the flush function will be called when the kfifo loses bytes. If it
ever happens we'll fall back to writing NUL bytes out and that doesn't
seem amazing to me. To me it feels like
qcom_geni_serial_send_chunk_fifo() should detect this situation and
then it should be responsible for canceling, though better (in my
mind) is if we never initiate any big transfers if we can get away
with that and still be performant.

-Doug
