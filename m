Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011813CFB7
	for <linux-serial@vger.kernel.org>; Mon, 22 Apr 2024 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780367; cv=none; b=kK4SeWlIpIV7wJmCSiQ9zZXiyDqzm+IVyL1g4hMXFt+qQDcMAFEs8KwpWzSG+PmQE0T47cMdP3RRpyRZuIYmMGhh2AtRxYW8T6ALFbHz5oKNDJsUi/62QwaJwXSD3RLb7KTgOc9Yw2qfEQlmAGQnpJuvEqUg7LCnSfX6w1LHsKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780367; c=relaxed/simple;
	bh=bL2hSvdJUbEjiVu8mOzngLcfDSFc2sqN+pYwEXjIoRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dhsm6wtAfYXEV88MmreuNGv0Cy62ZMwq+0N2HtwZ1y1g9TJPQGCS1bAkiNGBDWCAWXBuUYR0w9+OFJr2vgn0RYYAReqk331eQdKcYXDz4eo0QPxr94cmZDWKvaHlvJhW/ULKEDf9m17LHMsOv0OlKtklvF6K1CzGu3UoowJgkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0HotfNE; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0HotfNE"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ad2da2196bso926760eaf.3
        for <linux-serial@vger.kernel.org>; Mon, 22 Apr 2024 03:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713780364; x=1714385164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp9lUQ4HZ5PgJGPmf9IQ95ImHEOQFdQIgczUTfI1TFI=;
        b=u0HotfNEzSISiyO9rtcg9IMvD2AtAwPquxNa0gaCu+VEpQfh6LFtCsS6MuQ0iNqEIj
         8EMRrjwljGu0avUC76OW+0jdg8endhqeaoJXGLa4xo+RsIubY65+Z43iCHosG2KbHI9q
         r9+DMGRdnHsuv88L4olNVnfGnexO9yTRa8ZIlmPrAfMJouw6pSmwzCqnSczoeEa094Vh
         dX5tnK9qXID3lQlsAkMn1KRsVUYEN8R+hIEB7cmL7FkhhnOzGbsdUIA7XQZ3DTewqgHI
         n7D3bHLyxMuepgIot7ooTXLjAfBIs2p3MWJQVVZW9dseLj6DRspMApAfDY4DM87qbKeC
         pALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713780364; x=1714385164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pp9lUQ4HZ5PgJGPmf9IQ95ImHEOQFdQIgczUTfI1TFI=;
        b=KaV9v8GK6JpntkDZUJ2ajLXwHNkROUfhjuh9gUpppp72J7Sq3Df/fS7d0+mPk71IvS
         DX5Tray++b0pcE16HoHhhIkSPNMZDpcRkAf0w65wXt9tD8KRdfArQB4k5cH14wM0celw
         XWymTYZK3Bbk2x0BjeX9j7S+36WHMh7yrsl7SBBBqjTnqC+8P3OniPVvF76bB1qhPIRv
         qMcHWUufmIaIvjhej2jFtFKzHQQvAYz+ppET/eE6Lo7p7D0WIFFuozH2cwp/1TUXCD7C
         DvmHV2KwZPK+Mbw7v4ykFc0qRbfspHmTPtZzdKw6MEQ6eCJ/17YZGR9MRBeRob3ryeW2
         iALw==
X-Forwarded-Encrypted: i=1; AJvYcCW5UywNcdQCiCXYubXAnS/4E8vc7KEpaF/Ps0uCZmJLZskbSS3s/VkmAwrnAAcuNsSoxBCT38hNByXjclIjbZRq3yoIVUwojdjqaVTu
X-Gm-Message-State: AOJu0YxRlP/xV0TPGc+mzZRc8H0PehTtCW0hHijX5gEGkr+XVYSLntKP
	hoDTbiEuyLGKBxYcS4Wa+aTnpeAw6s/2EiNoaqIw3YiSiuvZ/PHvUZcnr88iKkwmu+3aBtvlkyf
	QjSY8gcCsQyQZU0Y/mj+EmVaI2p9az1aYgBPb80RrJcPhonjg
X-Google-Smtp-Source: AGHT+IH2cO2rZIY+HwOOnVAFVGLIKgIBh5VFjqWuGGTbO6sx2Y1eZMlp8KcjvsVT5MV0EfKhJfiXJpIcIBTuwaWiisY=
X-Received: by 2002:a05:6359:4287:b0:183:dda6:4470 with SMTP id
 kp7-20020a056359428700b00183dda64470mr6527469rwb.12.1713780364561; Mon, 22
 Apr 2024 03:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405060826.2521-1-jirislaby@kernel.org> <20240405060826.2521-13-jirislaby@kernel.org>
 <CGME20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae@eucas1p2.samsung.com>
 <91ac609b-0fae-4856-a2a6-636908d7ad3c@samsung.com> <d70049d5-d0fe-465f-a558-45b6785f6014@kernel.org>
 <Zh-fgtujwjiSXz7D@monster> <c091da0b-a150-428a-bf96-75f9f3eab2e2@samsung.com>
 <CADYN=9LCJS0SW4PuF+e356HUxhzJYi093K6U+BdErPohq4RDWQ@mail.gmail.com> <6ef3422c-d931-4993-856d-c080b11d72d5@kernel.org>
In-Reply-To: <6ef3422c-d931-4993-856d-c080b11d72d5@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 22 Apr 2024 12:05:53 +0200
Message-ID: <CADYN=9LtODPtcFiuZ_Zv5O9M4S1+pAYJD8Fu8r5__67bPK98RA@mail.gmail.com>
Subject: Re: [PATCH 12/15] tty: serial: switch from circ_buf to kfifo
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, gregkh@linuxfoundation.org, 
	linux-amlogic@lists.infradead.org, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 08:45, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 17. 04. 24, 13:19, Anders Roxell wrote:
> >> I'm trying to run on two dragonboard devices db410c and db845c and both
> >>> fails to boot see the boot failure from db845c [1], linux-next tag: next-20240415.
> >>> I tried to apply the patch [2] (that you proposed in this thread) ontop of next-20240415. However, that didn't
> >>> help bootlog on db845c [3].
> >>
> >> This is a different issue, which I've reported 2 days ago. See the
> >> following thread:
> >>
> >> https://lore.kernel.org/all/d3eb9f21-f3e1-43ec-bf41-984c6aa5cfc8@samsung.com/
> >
> > Oh ok, I did the bisection on db845v, and that led me to this
> > patch 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
>
> Could you re-test with the today's -next?

Tested todays next and it boots fine.

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

>
> In particular, with this commit:
> commit f70f95b485d78838ad28dbec804b986d11ad7bb0
> Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Date:   Fri Apr 19 10:09:31 2024 +0200
>
>      serial: msm: check dma_map_sg() return value properly
>
>
> thanks,
> --
> js
> suse labs
>
