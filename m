Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A932253FC;
	Fri, 21 Mar 2025 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560650; cv=none; b=fEAGU0xX5LiGVL5nY3taxjCKci4yKQ163qKThJy1wqdQEHTFIm8GmA+t3wQqHYxueUpqrgDsHDf4G5Tk/BRilFGTuCz4FBhEM044cjyR4ttU4RA0gjP2W7MDptFMkQtzlr0eaVquWFBiCrlCz0t0xZoCXe+ZLXPWykXFiV2rf0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560650; c=relaxed/simple;
	bh=Or6QuG77bV09z00Zjh/yMMBjENRVafR4XgVliURaVO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS8fIacqsZOIHQxJqyg8CnsQ/aKfiAxzLZWDGvXrsEcAZ7+jPg4F0oit0f36YrFwNbtEOL0fVsnNrWNhJD2oCywkO8vGQkDcfGlGZleAfODc3QG9YVxbh4I8gOkQGEe+wnJTsE8nIRJqznRumBbV3u+kB9Tpi/ROWTDMBMmcIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCf19iYW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCf19iYW"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54963160818so2427439e87.2;
        Fri, 21 Mar 2025 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742560646; x=1743165446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or6QuG77bV09z00Zjh/yMMBjENRVafR4XgVliURaVO8=;
        b=dCf19iYWMHEuCpUaM78dx361q3dBU2a1nRWN+b/THYeE9jo/FmMAMCbbHSDo0JmP94
         zOoouL0sOgqk8Zi8OJzs8o6I8DCeEjF3b0ZXzbcHG+bBPkUo0swD+bBQnxo72qmwj6CE
         37FAzFXzEcMkmGLbzBasf5wSuLAuwS5DkucW65ZYkfQ4oUjUN+izydiIX4qanyJoYXZd
         rgg0pzvNU78/HWm+/wLX8Pp/iuQPVYMFBGIIGUpddVZCd6+qeUxY24yKNMqlnSnoNq5A
         nHt7gSY8ZVLknfE+3+CvpTmZyDbx2zGmpFalwxQ8JelhXgUw11V3ZGKBFVICk9fqpG4v
         9myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560646; x=1743165446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Or6QuG77bV09z00Zjh/yMMBjENRVafR4XgVliURaVO8=;
        b=IwyLEIw9Fd8d/DIZnbJIExeZlP5Pi3i7V+Te4MznoRoa61OtmiABAuSxfELAfo9E9w
         MSrDzT1XoxxyyzMWtANr9OUUckAUU726lPLzexFn29NFaEOtdUYqKhsvzlGKIRbe8rTM
         AbdLIRli6IJhQvz5QVxm/h1cr7K1mFNbsV3MypdtS+Myl2718nhacYAlOUILwa0LxhtJ
         E2rl32mbS1k2coEddtscHliGfhu1OLxdEbb/LbeipLfXyppPui6vKKXHmoA3AmpJaxAS
         Z/8JnF4iyhe/dKY2EMw/G8SOL/btEt539AQJ2uLzjUdsXFvgd+f10iRMZsSsPAh6IjqK
         W3yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0im2ltt3JtHJrjqLyX9Wdege7LOyzX7BTX0StlTc36KlN2viRQCtG4Xs16P+dabbv6NUkApLOekILRXc=@vger.kernel.org, AJvYcCWkVgCGz4qcn/9fzWGByGSZ4aMVeUsE12ln5hGSjx9XpLjwcK6OfmCvrFlskAz9ZcJqps3xIOQp+qh1yFnr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8ocgnpeNaLiO0vlzPzhB5ijKjiJWaQJX4TLZ7Ov3MD2apgL/
	TgE2VSodwT5QM8ZAtKqAeOEegYau03mbLF9EEkw3Qoj0aJtE9Qt0X8hLi0PuRIZ6yakKZRH11AA
	z0MLmmKHBChTyNE1pTCcHSyNuRywSYg==
X-Gm-Gg: ASbGnctVicMBmbL2YnQDIo7jfZmdemGiPELkdZ7MZKPN88Zluc/zplRfv/nIfCnWskd
	YCmqqvGdRT34ol3xRqP+3fTwxNZXaM1vla8EqH3nzNfcQT/do8RD8IyJY+sK2IeDMgfe4oQkfrD
	PEfVzNP+PGdQ0kDkS3JOv4B+XgB9nT2MhKnU9FFY3xnXkZyuirOafN/i8o8Q==
X-Google-Smtp-Source: AGHT+IF5ZhvHNp9WkOfM+Q8diZfXaNlHoCdnWVMGrImaIEqIs1NM7JfBS6ONLUiVtVtJjKYMBeXX2rGQei/E5BktgGw=
X-Received: by 2002:a05:6512:12cb:b0:54a:c4af:29 with SMTP id
 2adb3069b0e04-54ad650348fmr1331856e87.52.1742560646266; Fri, 21 Mar 2025
 05:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321073950.108820-1-sherry.sun@nxp.com>
In-Reply-To: <20250321073950.108820-1-sherry.sun@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 21 Mar 2025 09:37:14 -0300
X-Gm-Features: AQ5f1JoXo2ejsWQ1aGN1zM--X22HsVKpWU6VSj_zLDkLidKs307tqtN72kTPvf4
Message-ID: <CAOMZO5Bo82YfE-4S=FboLhg5yJPFmGVKjx4XmYuf8MLZYLRgZQ@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] tty: serial: fsl_lpuart: cleanup lpuart driver
To: Sherry Sun <sherry.sun@nxp.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, shenwei.wang@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 4:42=E2=80=AFAM Sherry Sun <sherry.sun@nxp.com> wro=
te:
>
> Do some cleanup for lpuart driver, no functionality change.
>
> Changes in V4:
> 1. Fix unused variable 'sport' warning in patch#2 reported by kernel test=
 robot.

For the series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
