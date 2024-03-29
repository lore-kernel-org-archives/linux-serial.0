Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8E69DF4
	for <linux-serial@vger.kernel.org>; Fri, 29 Mar 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722237; cv=none; b=OCoOXmmKDLrd9dmIk56e+o4AhJlKuVFIxTOexmAuBDOHEZj+9BWgfne/gHUCXAXt5NG1HPrRoo9/OYw1mOKCiZoh1PCOZbYZ0kkraLZ/o9QGOxo061Q6zDp1+NGj1TDz4Kefs8nFTFQC8dTEdlZHS6ogB7raUMChyWzTQG8C+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722237; c=relaxed/simple;
	bh=qmdwo0uZTo5Hz0MrRtgqmAITVhPLzO95UNrOrd6I9MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJGWEPc0FiLOimokmNWblpAon13h5pdIQA+nrnOdnvloLuRp36UE3XNkaBb/GKr69uDAyPpr61OCkCNKjuWkGeLDHsTxOoiJxsR96s6XYkXvNFXHQZiVewAGItE4vIsKE0BY/njqUB7fqP9l5dbU8q1B5WcsLlRBh9zvnjmi+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fastcomproducts.com; spf=fail smtp.mailfrom=fastcomproducts.com; dkim=pass (2048-bit key) header.d=fastcomproducts-com.20230601.gappssmtp.com header.i=@fastcomproducts-com.20230601.gappssmtp.com header.b=A0VbHAoC; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fastcomproducts.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fastcomproducts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastcomproducts-com.20230601.gappssmtp.com header.i=@fastcomproducts-com.20230601.gappssmtp.com header.b="A0VbHAoC"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso1384433a12.0
        for <linux-serial@vger.kernel.org>; Fri, 29 Mar 2024 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastcomproducts-com.20230601.gappssmtp.com; s=20230601; t=1711722235; x=1712327035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIC6A0Lm2P1UPx/QiRg3Lr3l/yiPxwSFRW6lPV3c42A=;
        b=A0VbHAoCBr7ouN0MzwbbaQLZeeaEQxT5qgeJ7K8zg1qTgL8NuMaBSPCE7z7XYJ1IEa
         QyGKDBNNmQcstKSgPGdNWBHXOtg/9VenjGdvdTRF/L+t8MVMgFggLStV2KYBj8j5hStH
         W+JHvUYFUOjO8IssPd3mDo1y2w5kLXgwbSSpDFsNF38tE8/FL1xiZnFWGQFEUJOq/SME
         mYqwetH6LJinq5w4cAOqYeFcY3RJmJKYT+LkcMTJiMpytIqhFjb8q2LgxBvlzZ3hETxd
         I4uQKN1AO0TMFSpQlYD3MBbf0LPfJvOJgFsUBZNdFLKPeA2T4Z/8R5JPeM/Nh/wLLWF0
         +nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711722235; x=1712327035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIC6A0Lm2P1UPx/QiRg3Lr3l/yiPxwSFRW6lPV3c42A=;
        b=AoeBXCGWLwllxuCqAlbKnYvSKns/ji6TiT2osPbAwKPGEJWhrCMhx4EVii2Yd2EyPk
         1/nIthdC+5fwHPNqNA976PlXW1ZQXFaZHhdoawPdWM6IYUTb9q23inD65vtRl+1Pyw5b
         CkV43mLbyH044V0HIwkx41Wq8Lj830i+p6R79Z0u4U/3ZSsl7Pyj9WzXm4LGb3rZ3VrO
         vfCyzaaLzM1NZlICRIMM6Tq8hf1tbjdBp2ZXjicBjVgRcvVY2BIrVLtrMHRqgnbnKWWI
         VyJPQTJFEdoqLmkKhZCKpUnXIWJZMp//rWZ9aaGdOQEiydBYhsFkcleTIKYdG9Xkp1dn
         07dw==
X-Gm-Message-State: AOJu0Yx0s7qOWAXoDPggV6r1Gg7KN7Zzy62JBUk+sqGxMKsm3ukm8JnG
	86cM8OOeHjQUNKPFocUjXfyI0j/owNJUhT+N+iKwuM5x8hjXGUMJZkgS6+MJl8aRtt00/TGeYiJ
	ZDWOkSxshalSvJ2+JuidEclgbeLl0rGk3Kw2Fu++jNKgvI9w=
X-Google-Smtp-Source: AGHT+IFnNNBFQdypV0Ei1yUypOXiPZMhrRlRPqTwiXaHFJDD5xAV9+Ah/xE+eVeAp4YLIaFX6NXqdwWXUnt2KpzHyiM=
X-Received: by 2002:a05:6a20:1582:b0:1a3:4635:6aab with SMTP id
 h2-20020a056a20158200b001a346356aabmr2452712pzj.62.1711722234964; Fri, 29 Mar
 2024 07:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJqSBBNc5mPcKfFSH2jXnjp9PB6fQGWN0vB9JPKHENogUw-D+A@mail.gmail.com>
 <2024032920-replay-ruined-d92d@gregkh>
In-Reply-To: <2024032920-replay-ruined-d92d@gregkh>
From: Joshua Droney <josh@fastcomproducts.com>
Date: Fri, 29 Mar 2024 09:23:49 -0500
Message-ID: <CAJqSBBMETm4UVv3F8iUAdMi2tpaSY+-QcxAO2qHOC_O9J=cSqw@mail.gmail.com>
Subject: Re: Incorrect UART in /tty/serial/8250
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would appreciate some guidance on this. I don't know enough about
the kernel's serial driver to be confident about what changes need to
be made, nor anything about creating/submitting a patch.

Thanks!
Josh

On Fri, Mar 29, 2024 at 1:01=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Mar 28, 2024 at 02:34:10PM -0500, Joshua Droney wrote:
> > Hello!
> >
> > My name is Josh. I'm currently employed at Commtech, Inc.
> > (https://fastcomproducts.com/). I'm following the instructions at
> > https://kernelnewbies.org/FoundBug to report this issue. Please let me
> > know if this is incorrect.
> >
> > We (Commtech) have several serial boards, but the board in question is
> > the '422/2-PCIe'. This board does not exist, but someone added it to
> > the Linux kernel at some point in the past. This wouldn't be a
> > problem, except that the board ID that was used for this non-existent
> > board (0x22) was ultimately used for a different REAL board, with a
> > different UART. Instead of a xr172358, we use a 16C950 on the real
> > board. But the Linux kernel finds our other board ID, and tries to
> > initialize it as an exar chip and fails. I don't know much about the
> > kernel, but I believe the lines in question are:
> >
> > https://github.com/torvalds/linux/blob/master/drivers/tty/serial/8250/8=
250_exar.c#L47
> > https://github.com/torvalds/linux/blob/master/drivers/tty/serial/8250/8=
250_exar.c#L925
> >
> > You can see that we have a different board with device ID 0x22 here:
> > https://admin.pci-ids.ucw.cz/read/PC/18f7
> >
> > The 422/4-PCIe exists (0x20), the 422/8-PCIe exists (0x21), but the
> > 422/2-PCIe was never created and its device id was used for a
> > different board (0x22, the SuperFSCC/4-LVDS-PCIe).
>
> Can you please submit a patch that fixes this?  We'll be glad to take
> it.  If you need help making it, please let us know.
>
> thanks,
>
> greg k-h
