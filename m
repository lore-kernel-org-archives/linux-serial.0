Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AC74299
	for <linux-serial@vger.kernel.org>; Fri,  2 Feb 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864659; cv=none; b=CaDiUD3Drj0PnjBP7xks+zckkFrKAwtNQt3M1Z2TlhPFe0CTLjoKsmOvgMsnCVsGwkXBPqZ7RRnVCMTaDy5kaoUeMvkqxEN7ZKkVAyo+CkAc2srh8jKpO/3ZIBE7Ih+7mRA7IWBw6Wff4s/oCGiL+WiT3+PXQ5eJhHyu6KxVYEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864659; c=relaxed/simple;
	bh=nwexja8y+dbRiUYzk3G6TelJmwTHizoaFvsFdTnp7bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEawNgLFGHhpJ39HgTRQAZihpW3Wv2if93BryalkqkMMEHzUchk7Be1EysiVvHZf8yH4zp0IdDJPK2b8qhzrhdsb8ZQ4acz0hqlIS4YgQeKhu4sHoFEMyGtyqJUv60jRlHckEQzBt2rDByQ3QbPJPQQHUHFcJKp0lcCpYLL3fNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L50Qfog0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L50Qfog0"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b1bb47c4fso583508f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 02 Feb 2024 01:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706864652; x=1707469452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TDauquzvXWKswKe2TLG79+LxI5z2yAqaKscpNKK+ciQ=;
        b=L50Qfog0nVH34iqmI2uQm2AUrTbBkGP71CcQKop2qV3gS+VJuVEvaTgUSHxiC5LWhs
         VUcZ2NX+5MivzGdMHPYOFtlOu3Yz5uMbz0FoaZB5sjun3rhwB80zN1Sx4s7QqkvQDGy8
         tCsTIM77B0loCJ3tUcpoNImIgR4TaCxqV1Dqz1g/e/c76h+kM0hFjKOF3IxvNxNuy5B5
         n4KPx3AagQG5BsERzgJGH9pPknf1V4sTtakWbv1L0n+mDllXeD8HvqY6gwdiafv12C3G
         NcrIa/R0dIfwCL9tMwtlywEntgiGwuzigmdDyRNLe0z3nf+KtP01d3FqSK7M5AL89N7H
         gK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706864652; x=1707469452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDauquzvXWKswKe2TLG79+LxI5z2yAqaKscpNKK+ciQ=;
        b=sfCAOY+dT4AO1MqUJSZi00CrnFmX80cwofSsLy4Szr+1zZ+RELFUxxUj2QI72XD2Lv
         WnkAtpgKzOMqcTNon48lu/wqCAKXjQTTj9UKKqgTAgWb6LYAYw3h1Epx5puwWirFV2KY
         rKkwvUg+YI5XBCvO2AZjefeiOlOQzCyfyM9rFWvN4vQeceOLgHP3S5jsMrMxilUExcWv
         2XP9r+335oEHwiS4k7KFZl0gwkhDFkEiqkQIlofEjE0BELcywXH+0XpMKAeC7QgASwnX
         QgsR1psrHcZlA4NtDN02cLViqijbpV11X4SBG0verHjDhF7onrOmp6m8K1E5kpYUey/M
         qswQ==
X-Gm-Message-State: AOJu0Yxe8UNswS4ZPMuTtUfancCLyxg5wj4/MYN8Yhsye1ChYGXQCrRA
	k9UvJIvxwTE3Ws5SzwQVRrsPGZi1r4Hi3U+6+73/LiNbYEmPvX7c
X-Google-Smtp-Source: AGHT+IEdRTtGP0pDuZcZ9Uo9gil3ylTO6D0k6X/5aA50jMSW68IuIO4bLgrpMmKZyjOe7Gy8C48YEA==
X-Received: by 2002:adf:a3c8:0:b0:33b:1b0b:9355 with SMTP id m8-20020adfa3c8000000b0033b1b0b9355mr813557wrb.54.1706864651684;
        Fri, 02 Feb 2024 01:04:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVQl8E7bNiEebYV1Eohi2ocov4adNldESwSilBm9MybYcuuSJoUSEGGicWJt/XsASKYn7/TJY1R9/2VRfwKOzPXKkjt37X+VG25s0KtPc06AGFyine9KYztPbcFqfOSwAfn3/n7vKOUdnIOic26T6teMLKwH5sAGtafoftyT5NcMMSFeUQuSZww2JNypEf83aMCD+nKP8CQrEEkbzgJRZ614UJmFonWN9lhfsiO+n9nTYZok3ChqMdgEQon3Uvy6u/3MZwbGtn+WKs1muVQdso0w/FFbnmHJkzb/7xWna5hp03Xii2sq6ZcWRN07xbd3CQAvyd5sqo=
Received: from m2 (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.gmail.com with ESMTPSA id j9-20020adfb309000000b0033b26beb10csm80921wrd.1.2024.02.02.01.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:04:11 -0800 (PST)
Date: Fri, 2 Feb 2024 11:04:08 +0200
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Christina Quast <chrysh@christina-quast.de>,
	Jiri Kosina <jikos@kernel.org>
Cc: daniel.beer@igorinstitute.com,
	Christina Quast <contact@christina-quast.de>,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	johan@kernel.org, gregkh@linuxfoundation.org,
	David Lamparter <equinox@diac24.net>,
	Jiri Kosina <jikos@kernel.org>,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
Message-ID: <ZbywCMJyHV8dGRSV@m2>
References: <Zab2aFMlu6ww2jey@michael-VirtualBox>
 <Zab4g5PnwcaferE9@fermat.nev>
 <Zag78CurQQGSLDW3@michael-VirtualBox>
 <ZawT2Onn23CPMeWa@michael-VirtualBox>
 <ZaxFkPY3W/5SFwh6@fermat.nev>
 <ZazgFniD3qXGG1cY@michael-VirtualBox>
 <ZbbQNEC8pWlkshgN@m2>
 <ZbnoiUhM7sOt7/a6@fermat.nev>
 <Zbpr531rSxCsDKck@m2>
 <041c7445-fd59-4615-bb9a-7958b93113e8@christina-quast.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041c7445-fd59-4615-bb9a-7958b93113e8@christina-quast.de>

On Thu, Feb 01, 2024 at 02:03:25PM +0100, Christina Quast wrote:
> Hi Michael!
> 
> The FIXMEs should have been removed before submitting, sorry for that. They were just a reminder to myself to check the kfifo spinlocks.
> 
> The code looks good to me! What's the next steps? Should I include your uart related changes to the patch and resend it to the mailng list?
> 

Hi Christina,

Thanks for pushing the UART support forward. It's much appreciated.

Unfortunately, your latest patchset (V4) had compilation issues, broke
the ft260 I2C driver, and lost the data on the RX line at higher than
4800 baud rates. To shorten the cycle, it will be better that I submit
the code from my repository. Otherwise, I will need to review the new
patch set and retest everything again.

Also, I want to cover more corner cases, and then I will submit the
patchset with your and Daniel's credentials.

Jiri, there is a pending patchset related to the GPIO support -
https://www.spinics.net/lists/linux-input/msg83937.html
The ft260 chip has multifunctional pins, and their configuration affects
the UART operation. The GPIO patchset adds this part. I am considering
rebasing it above the UART code discussed in this email thread.
I wonder whether resubmitting the new patch set that includes UART and
multifunctional pins (GPIO) support will be a better approach.

What do you think?

Thanks,
Michael

> 
> 
> -------- Original Message --------
> From: Michael Zaidman <michael.zaidman@gmail.com>
> Sent: Wed Jan 31 16:48:55 GMT+01:00 2024
> To: Daniel Beer <daniel.beer@igorinstitute.com>, Christina Quast <contact@christina-quast.de>
> Cc: linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com, johan@kernel.org, gregkh@linuxfoundation.org, David Lamparter <equinox@diac24.net>, Jiri Kosina <jikos@kernel.org>, Michael Zaidman <michael.zaidman@gmail.com>
> Subject: Re: [PATCH v4 RESEND] hid-ft260: Add serial driver
> 
> On Wed, Jan 31, 2024 at 07:28:25PM +1300, Daniel Beer wrote:
> > On Mon, Jan 29, 2024 at 12:07:48AM +0200, Michael Zaidman wrote:
> > > I pushed changes into https://github.com/MichaelZaidman/hid-ft260/tree/uart
> > > branch and would appreciate your review and feedback before preparing the
> > > cumulative patch set.
> > > 
> > > I addressed the first FIXME. Please correct me if I did not get right what
> > > you meant.
> > > 
> > > I am still doubting regarding the second FIXME. I see only three tty drivers
> > > are using the kfifo_avail and kfifo_len to retrieve the write room and number
> > > of chars in the buffer, and neither use locking. What was your concern?
> > 
> > I don't see anything obviously wrong, but I'm probably not the best
> > person to be reviewing this -- Christina has spent the most time on it
> > recently, and I think the FIXME comments are hers.
> >
> Thanks, Daniel, for your feedback.
> I see, it's my mistake. I should have reached out to both of you.
> 
> I added multiple fine-grained commits to simplify the review.
> Christina, can you clarify the FIXME issue and review the changes?
> 
> Thanks,
> Michael
> 
