Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC851F8916
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245723; cv=none; b=Ohbc0ks4skO2pZGKf8Q6AvQTE20BysQlxUzP1aR4io8Hd9fQ8XEv9RoOIHrFFaXNPH3VxccyTfKpk8lBIISNZhP6TmY7YyjmyVdxcfMBCJ6SqyzxrLjXbbEIqrYQ9gBVZOIqlKDkggYBK23sWSv1fA+aIS4QhxEZGvawK7cshr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245723; c=relaxed/simple;
	bh=NP8cNgL+fyqg8ZjfW3jq6NL7heqoYkWX5tF9ZORhO7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsfeeIfgDiYp+BjjSM2N3tuTrneJpi8JQmKQ2Dy4BvuWp3evyVvxc235zubxwAcppj2EgMHbgy06bPJ2Ln1DUYqaX+r/Lwlhs1zJMRL94a9PcP7bp4IP+ONJvioGAjMyzvqnW77XlQexP1K/Xf9s6UZiFOYnaucTuWjo9f8d+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG1Gxp3I; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG1Gxp3I"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29e149aff1dso2281829fac.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Dec 2024 09:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733245721; x=1733850521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWZOLcnD848OfgUh4KttNpM7Hk/F3dHoVGRATcyycQg=;
        b=mG1Gxp3I+51WQRWnSIMM4xamfTrJdFNIBCqp4Zs8iUzG3Lp68Jecb3wAfA88RC0xFZ
         tag+8inqAaykLGApO1ifrEzRw1BulZKNa/EU5DqIHESqp76IsQBWgwW8UascakucZupe
         ZtnheAhO+YJh230qtf/pyycP3Vq+EU4K9jij9QGVI7kZejDAApvc5sUWL8/+3V9GWk3I
         Enfo3YdpvJaAMciSPqDQ/eWs/CWHhOLYHyYE3vrr/JQQhdq3zk+emw5y26IIgydeRVH8
         IpmZxpNXuKVg16JtENKd9/f5SByOXEC5RGWsu/l4btAFido1t8UN0EeGT8yF33hKgLNJ
         gaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245721; x=1733850521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWZOLcnD848OfgUh4KttNpM7Hk/F3dHoVGRATcyycQg=;
        b=B7cEFptaV61QmGLFVHh+a1NYpih3RGbKe+dJztLo7mq6Qvfs80RTz4iz68WeYvFz6y
         dCn4ytWqcMTX45dCv4LZKf2KWsJtYD0JpzHvkfaXpciRAjWrdswZhmIhut7GvFWEvsHy
         hDCBB2dxuh6GJytPWdW0PZc5wma2VesKvLXzH5H0cZJ7GzZndXvjLHoj3bV+JHTnTfJA
         8rg2mQAXVuxQnleXRtAoRREJOoiczeA1mJKauP7dfnvtLH26wMnBKiMdzRKpN9FWT/Tb
         DXsBBZ3d4qcRbQpIR3IP1H7irXatEmBaAQ26qFK33wfUYHZUbsQsvbiaNVG8xfIZ4nCn
         qvfw==
X-Forwarded-Encrypted: i=1; AJvYcCVfeRe0slqhA9KEgxzfH0iUcQJqSMCH1KfmJHmh9fqYar7NYvcnWt7T6iH7BzUoikb9SIMxhphAHDNt7y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDXLv9TSJxUaztmGiWRg9y6UqTTLuYXLmNAr0/me8sMZjmBKdg
	au45xddOrFn9oBNg/6kbW0Hi4hL0CdZ01y2IKADKgUPnDz5MWs5fqIogaTDCjvb8F0y4QS50ZGl
	OSl61pRGpyTRhpLbVUrimInaoJqhr2B+z
X-Gm-Gg: ASbGncsyluOa4kqjLdJp7xQ5006+jryWwH7POvpjv3MwbMYNFpiJfGHQ4IHnQuUKBhH
	t3AIy5qaScjKGK8PnlXz2iONRpVJ7xnxm
X-Google-Smtp-Source: AGHT+IE6WDtflI7Y5pKiec2ndPVEeQqndW7W+VH04f+4zjguUfSOv5/Z9OXQfLU9TR+Uy7xaCSdUihikMEQqAcA5y98=
X-Received: by 2002:a05:6870:d205:b0:29e:3132:5897 with SMTP id
 586e51a60fabf-29e885a9493mr3244931fac.5.1733245721009; Tue, 03 Dec 2024
 09:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHhAz+jqTxsMipLLnBvRAC8cyN=QhTe5sToh45FN=AyrZ9XnNQ@mail.gmail.com>
 <2024120338-atrocious-policy-1ce0@gregkh>
In-Reply-To: <2024120338-atrocious-policy-1ce0@gregkh>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Tue, 3 Dec 2024 22:38:30 +0530
Message-ID: <CAHhAz+jk5dzBJfEoWYWAf=UKE-43s=qARFX3MkqmMgEAD8zcXg@mail.gmail.com>
Subject: Re: Query Regarding UART Controller Device Driver in Linux Kernel
To: Greg KH <greg@kroah.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, 
	linux-serial <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:26=E2=80=AFPM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Dec 03, 2024 at 04:47:31PM +0530, Muni Sekhar wrote:
> > Dear Linux Kernel Community,
> >
> > I hope this email finds you well. I need to work on the high speed
> > UART controller driver in the Linux kernel, and I have a few questions
> > that I would appreciate your guidance on:
> >
> > I understand that the Linux kernel tree contains multiple source code
> > files related to UART controller device drivers. Could you please
> > point me to the relevant source code paths for these drivers?
>
> Where have you looked that you did not find them?  (hint,
> drivers/tty/serial is where they are located...)
>
> > What is the maximum supported UART baud rate in the current kernel
> > driver's supports? For example, if the hardware supports high-speed
> > baud rates (e.g., 12 Mbps), are there any specific design strategies
> > or modifications needed in the driver to support such high speeds?
>
> Many different uarts support different high-speed rates, it depends on
> the hardware.  And yes, there are different ways of going that fast, but
> again, it depends on the hardware.
>
> What exact hardware type are you working with?  Does it not already work
> properly with Linux?
The hardware I am working with is Xilinx based UART controller with
DMA capability.
Can you provide examples of hardware platforms or available UART
controller drivers that support speeds up to 12 Mbps or higher? What
specific modifications or configurations are required in the driver to
enable such high baud rates?

>
> > Are there any user-space utilities available for testing UART
> > interfaces in Linux? If so, could you kindly share details on these
> > utilities or provide any resources that would be useful for testing?
>
> There are loads of them, but it depends on what you want to test.  What
> exactly are you wishing to test/validate?
I am looking for test utilities to stress-test high-speed data
transfers between two systems over UART, checking for correct
reception of a large data payload. It includes,  transferring data at
a high baud rate, and verifying its integrity at the receiving end.
Could you clarify which utilities are commonly used for testing UART
interfaces at different levels (e.g., performance, stability, data
integrity, error checking)? Are there any specific utilities or
resources you would recommend for testing high-speed UARTs?
>
> thanks,
>
> greg k-h




--
Thanks,
Sekhar
