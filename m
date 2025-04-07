Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3551E4BE
	for <linux-serial@vger.kernel.org>; Mon,  7 Apr 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030836; cv=none; b=imnIkY1H/2BxmUCyLjyu2qdFoRruhZ16gKcLXOcM2qFGjLAYKfihC0IYCO3Q0MsGdOy16MHAFTL1D7HBShubG/CxPseAVBhmIHSulD/AuxjemIKQIqYjfShNLiqxafPdxmviCIcyQYLD9T0h40TAAV28UdCQU5hZ6qibp3ttKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030836; c=relaxed/simple;
	bh=4NPyf6Ab1VM5I9gb9TUPJo7YffJdWthSv6pwiFj1bHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlTp1dzTZIttlOBGMYQJEmEC6oTONf7Wr/EjvXxIro/lbEObjHl8xsn1diRUMkxWe8juQ7KF7iTnlGJnKbbLBJ6wVvQNcDqM0+rIpp+X1sobLsLK7+pJi7YMtDfiyBpK4jx5ThlP/rpQvTnWu/kSUIj3J28loB3EJg6wqcUxHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OUHbhmSR; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OUHbhmSR"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-601fcbff303so2113278eaf.3
        for <linux-serial@vger.kernel.org>; Mon, 07 Apr 2025 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744030834; x=1744635634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NPyf6Ab1VM5I9gb9TUPJo7YffJdWthSv6pwiFj1bHI=;
        b=OUHbhmSRh4dOtaleifG3n2mFAvEzoQOlwvE8yNka+2diGrAsW0wFLhMFnjfrHsCAXl
         IzcRA3Xd5os8aE7Zs9abiH6gJ1FJwqt/ztPZK5czPmeD1sIzGKJuqrHgJspTB3JBBn8C
         hCXkxV8hy5hj5nyNYZpvczt3Zo5OWZt306Nv2rgUvG4ReB2lGqJw12Y0oVmSTIFrSUfr
         SFs7HhMaMOh4mfG98+LqAJRmah6pwGUmh8bWVqgks2NobUvoDt8/ivZXueno4F9akaDU
         Hchp4ZnWE378zLiUvTQV8OJgQ8aTnDDAFEOtyp3fSkc4Y9vDK3ILDO2mMjMLbTbRUub/
         D6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744030834; x=1744635634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NPyf6Ab1VM5I9gb9TUPJo7YffJdWthSv6pwiFj1bHI=;
        b=fFZlZURCgT6EeN26t90Xlau+8itrj+VYlYuraFeWUjtfi2oT99zrYX30n2vX81te97
         J91TymfbUFKIDP0OIQ/DL4YdBy629p1w4N9Cw0AlHKZiyUrKdtqYXeWQ2LV7VZetqSry
         m4lZVEegW+b+HgJg/B6vJIzY90/DKg6MgQigW2AgSVD2yVLZZ4DwjgH8SIFvB3IKKYiw
         qAO8TC3eYq+WgygK+Q1jzXo8CyooIu3szccNYb58y/i6wK0wHALRHw6a205+boYNE89z
         jov5GbLqq+rc5zWc6N2d937LHYklutOwr1V8ZaUKcgncmMcVy8TXaV+wnRux1O3oPiZs
         0FJg==
X-Forwarded-Encrypted: i=1; AJvYcCVzVm73tkxpGhUV0oW8SpXJdQoi8BvXCoz7tS3WFN4dLpDVxoy6ES2WLTrfeya0zuSqPanl1i4/4iLqTGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRNvDU/S7KDlp/VSPqHglRmx9Mr9hIOR/lBNzt56Z4oAxWJvmH
	sr5Vt0VbtDMMmXgf/SjH4IujPU8Rp6dQURl133iyzdX3jgh+ciW6fxU5AKSYNyHK+mN4UrqJLkP
	U/Wf/MMyn1YRZcoRB79a+6dUFV/Q42pWqZoF4AA==
X-Gm-Gg: ASbGncsm6Bp9QRFCO1SgBlz1xhyNZFsBmiNhvlqX/oLv+MW0hWbvdyM5gWxeuxMaMFf
	hOG7jw2my22O/WYailFi+2Dscd+9rgOav8hh1abdHFZpesq8qF8SeBtSCM61rH6phbi5ccWKUUf
	/DiqK1d/+lBHyT5bXtgNTemfZMqjQ3
X-Google-Smtp-Source: AGHT+IGUMt5w+ucLL4Obxt0SSzw21tJii4m0qT64R9zF1VPyv5ecYKFAOH1yOAgukB8jXcNDRujKwD/jT9J8D/s9RC8=
X-Received: by 2002:a05:6820:1ad6:b0:604:d2b:c585 with SMTP id
 006d021491bc7-604165c24acmr5931841eaf.3.1744030833836; Mon, 07 Apr 2025
 06:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403090336.16643-1-cuiyunhui@bytedance.com>
 <Z-5yr2mFaDt8kxC-@smile.fi.intel.com> <Z-51629pjyiZUIVy@smile.fi.intel.com>
 <CAEEQ3w=xVNuSN-4tHx6ir-i+huN8m1JXgJz672=WHAVBqcP+TA@mail.gmail.com> <Z--yqlI0cRnixWpy@smile.fi.intel.com>
In-Reply-To: <Z--yqlI0cRnixWpy@smile.fi.intel.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 7 Apr 2025 21:00:22 +0800
X-Gm-Features: ATxdqUH2rkCMsQpp9gGxDJ3YFHW6sJInIkL65BBneWufeRCJ-WFejeeX8mWjm-8
Message-ID: <CAEEQ3wmMymsLZGvomkUth_rczdUaHxeDjCV8Vm6P44RpjVzZQA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] serial: 8250: fix panic due to PSLVERR
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	john.ogness@linutronix.de, pmladek@suse.com, arnd@arndb.de, 
	namcao@linutronix.de, benjamin.larsson@genexis.eu, schnelle@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, Apr 4, 2025 at 6:21=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Apr 04, 2025 at 10:31:25AM +0800, yunhui cui wrote:
> > On Thu, Apr 3, 2025 at 7:50=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Apr 03, 2025 at 02:36:16PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Apr 03, 2025 at 05:03:36PM +0800, Yunhui Cui wrote:
> > >
> > > A couple of more questions here:
> > > 1) what is the DW IP version and where did you get the PSLVERR_RESP_E=
N
> > > parameter from?
> > > 2) what is the setting of the UART_16550_COMPATIBLE parameter?
> >
> > 1): Refer to: https://www.synopsys.com/dw/ipdir.php?c=3DDW_apb_uart
>
> I don't understand this. I asked about version of the IP, I have datashee=
ts
> already for many of them, I can't find PSLVERR_RESP_EN there, that's why =
the
> question.

You can check the link:
https://iccircle.com/static/upload/img20240313113905.pdf for the
relevant introduction.

>
> > 2): data->uart_16550_compatible =3D=3D 0
>
> Thanks!
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Thanks,
Yunhui
