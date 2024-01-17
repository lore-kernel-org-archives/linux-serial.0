Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064F224DF
	for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508675; cv=none; b=G0dSk4KZy+NdwXpYKfERbAsPxotpoAU5a5TNPjhC5fQzrCigJUfFAWiaDI8jfuS9gMDkYhsmsw84Db6J6XzoJVMfTlsGBQUW+sLSlow2ReBIKEGicFuFoDt6/V1H8P1teXrf1xS9fLlh/j88UuC5vwNSO3TmZ5iuPUmO76QI/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508675; c=relaxed/simple;
	bh=KDVs34GO4s0SScwRMhG5UBy1Y/fJQT5iPNFWwNG4myA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=n4WSGcacQa93299z6Zm1YKth0dsrCbE9uaBcV9BmzV7MAZWrSZAqPexPrTgKG3Su1HH04MuKbHJGnzE5OFV2itxN7nh4MvdoIgefUBK4oou3zOzel92X86E7zT8qs1myZVokaequJtNg2Kmx2EtBqydVyY+gpjHpGwaw69Ks8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FlFdFUpd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlFdFUpd"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28feede2624so1069724a91.2
        for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 08:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705508673; x=1706113473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeZx3Fscyt/CJrkTAocFhl3YvJexR8kYpcsaIA6PI2A=;
        b=FlFdFUpdsXYtlwKvPuG5ssao0qXdobRxEMTwBEbArLKInQzwFo4Wrkr97EAoygHyAW
         t9zf3ukStIM/7m/+KraH63v3P/nIDTs5+HNy9RwtPUoVdr0SgdEYyzPGooQWsbBDXlOx
         BCNf3qPZ7Q8x4gVz3Ka6dzhD2IRxPqkBSPQ410ng1XngudQZa0wCPEgfpdfPKrESWang
         3uyVPJvnwmeUuawLKYAK+J3xtH8OWRbvNa01ex8ge8T5POcb7lfE0VbqU3wFWHlTVWG3
         qPzs76VaHOZKo2lggGCqr0Zk369QaVvgHdJfCkAQdCNTei2iS3r2fv/ojSnlEh5TnLZb
         NkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508673; x=1706113473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeZx3Fscyt/CJrkTAocFhl3YvJexR8kYpcsaIA6PI2A=;
        b=Od3FKyjCEg6KYuC+bbOfqi0V7QLdCZ8czEKm3zb0u0m8cBIF0k8iJUFVBXdLg7yMoc
         PN65PYbeYNrI+iDChIw66zPqv+V3EO1yifZm7IRkoVCNs/9FWmcOv10JKKluE+ohhw7r
         LEYgNE+HDkQgOei0b4U1ft0qEvAo4TIyHcyrKMPThw8UALUWsa4RBV0RSZrCKUGJd91p
         yiDyI6D1YPRT1TCb39u7VT2X2cl99ihfN2e94YkyZO4f0eMHqLLrXO6/mgSd7Tea9inE
         hhJDXjSyYfDu2oDzgn3owlT5b9kSg0Md9EmvNnZdXUdc0X10ZTBOym3RQ7FrzFfkCjHe
         29Ow==
X-Gm-Message-State: AOJu0YxpBNveU7UZ9/bPWIQLnCG0a2P346zm7F/KAU2NGdESDrjzN9H+
	YWubYC9Jo+70bLWSBWSF1lApdZjKbVdljX9rI44sHdkXZifSRg==
X-Google-Smtp-Source: AGHT+IFSn9Nb3Hxdtjn1d44gSRgGrasRJb+KhplONzjBJL4xcy6PVKp6I6qSQuNWAq9mX7JvOUdmjLipam5tAGAc/Fg=
X-Received: by 2002:a17:90b:3594:b0:28f:eeb1:198c with SMTP id
 mm20-20020a17090b359400b0028feeb1198cmr1606818pjb.11.1705508672837; Wed, 17
 Jan 2024 08:24:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org>
 <20240110102102.61587-12-tudor.ambarus@linaro.org> <CAPLW+4mKBwsc9VLrGTd2k6d0n-K9TZAjH6M8trcK3Av8TQ2Ngg@mail.gmail.com>
 <6b6b1512-18a2-48bd-b284-8f4deff84309@linaro.org>
In-Reply-To: <6b6b1512-18a2-48bd-b284-8f4deff84309@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 17 Jan 2024 10:24:21 -0600
Message-ID: <CAPLW+4=k-hrJP5oDVG9+-XmAbNhpRoe-jnjphkk0dnbEH=r9vw@mail.gmail.com>
Subject: Re: [PATCH 11/18] tty: serial: samsung: don't compare with zero an if
 (bitwise expression)
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 9:41=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
>
>
> On 1/16/24 18:38, Sam Protsenko wrote:
> > On Wed, Jan 10, 2024 at 4:24=E2=80=AFAM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> >>
> >> Since an if tests the numeric value of an expression, certain coding
> >> shortcuts can be used. The most obvious one is writing
> >>     if (expression)
> >> instead of
> >>     if (expression !=3D 0)
> >>
> >> Since our case is a bitwise expression, it's more natural and clear to
> >> use the ``if (expression)`` shortcut.
> >
> > Maybe the author of this code:
> >
> >     (ufstat & info->tx_fifomask) !=3D 0
> >
> > just wanted to outline (logically) that the result of this bitwise
> > operation produces FIFO length, which he checks to have non-zero
> > length? Mechanically of course it doesn't matter much, and I guess
>
> that's a bitwise AND with the fifo mask to check if the fifo is empty or
> not, it doesn't care about the length, just if the fifo is empty. IOW if
> any of those bits are set, the fifo is not empty. I think not comparing
> with zero explicitly is better. At the same time I'm fine dropping the
> patch as well. So please tell me if you want me to reword the commit
> message or drop the patch entirely.
>

I'm not opposed to this patch, just don't have any preference in this
case. But the patch is ok with me.

> > everyone can understand what's going on there even without '!=3D 0'
> > part. But it looks quite intentional to me, because in the same 'if'
> > block the author uses this as well:
> >
> >     (ufstat & info->tx_fifofull)
>
> tx_fifofull is just a bit in the register, in my case BIT(24). If that
> bit is one, the fifo is full. Not comparing with zero is fine here, as
> we're interested just in that bit/flag.
>
> >
> > without any comparison operators.
> >
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >> ---
> >>  drivers/tty/serial/samsung_tty.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/sam=
sung_tty.c
> >> index dbbe6b8e3ceb..f2413da14b1d 100644
> >> --- a/drivers/tty/serial/samsung_tty.c
> >> +++ b/drivers/tty/serial/samsung_tty.c
> >> @@ -988,8 +988,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct=
 uart_port *port)
> >>         u32 ufcon =3D rd_regl(port, S3C2410_UFCON);
> >>
> >>         if (ufcon & S3C2410_UFCON_FIFOMODE) {
> >> -               if ((ufstat & info->tx_fifomask) !=3D 0 ||
> >> -                   (ufstat & info->tx_fifofull))
> >> +               if ((ufstat & info->tx_fifomask) || (ufstat & info->tx=
_fifofull))
> >
> > Does this line fit into 80 characters? If no, please rework it so it
>
> it fits
>

Just checked, and it's 1 character off (so it has length of 81
characters). I know it's not a strong rule in kernel anymore, but I
like it personally. If you are going to fix that, be free to add:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> > does. I guess it's also possible to get rid of superfluous braces
> > there, but then the code might look confusing, and I'm not sure if
> > checkpatch would be ok with that.
> >
>
> I find it better with the braces.
>
> Thanks!
> ta
