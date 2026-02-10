Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A53806C9
	for <linux-serial@vger.kernel.org>; Tue, 10 Feb 2026 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743414; cv=pass; b=o8L256314cRMppVF9U6yo2Km3d8SI1dBi0sNt00oyCdxOAYEE/AtE8J2UrO7RdXqdnw0WPxDGbPnePyg7fx495AwgT40iPX1CaWvn7KELrohD8el53yrb2gQrdza3w/mGh0lyN8zze5UQKdnk1BljSqvgMwImyeovJQKy+ma8SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743414; c=relaxed/simple;
	bh=nknERMTRPevojwk5RhNRl3LATVz+Cc2dJ6elru3Bx6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwZOuLQcY5NPDSHS39WcVVjLT5AoW71VKKA3bE96xUv7boO94llCgRd4zq/sg+lNk4xeb2zQosA6nl3XBXn6AVZ5bpVMaZ4mGq3I/ZaKMd2C46yo1ZEIsYbkd+fMDnlDlEzEjCxwlWj024NQ+wkfJ/iqDptrux5sW1GvFByDZ1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNlKRi2K; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNlKRi2K"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba68df3687so4204561eec.1
        for <linux-serial@vger.kernel.org>; Tue, 10 Feb 2026 09:10:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770743412; cv=none;
        d=google.com; s=arc-20240605;
        b=MYY+XpOdg1qBse+ewAt008+dMy++tEf7omESG4aPkyPh5ZI7eEQaXFGIAv+12fYz7I
         GOy7QVlgA9di9/4YwWSIQ/j2jGRt+if8t2NIpa8Cvzl3NsWVYpO4dhgVikXFBObgkFUh
         gIKY9+a4Fo+DvbJVz1vFJ2zuEDcLDPaC39sXJ9zMRzl/UdZnBBy48I3apHPLLx2PfgWg
         IDC4RIs9JJukmM4MVAUI7IZ3bLsnQiHpj5O4nhFt3h2UYiD1brL4vyIUW49JsvaUSpT1
         Xzk51vM6PQ4zMfDtRY+gWE9J3uE9wTBCfZ8OpicyQhYq/LvZKQ9YyfYZZH8+0t7NH+R7
         Y48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cc+DVhVKXqCne8j9rprRBbjY7AfNTSR37pnlUL+Q12A=;
        fh=RnEidhQgAFnttNwyn5Y+raAyNx3774EBFzaIq53S8Xw=;
        b=PE1pqyn1OdWOVTxrYobIATRIRetfah9lBX9Wwz0K9B220kqoMTpzz2Hk2WNQtMG6N7
         sKf1VspqMVg5e9LuUHOjRxqvBlFkSqKJlhOm8/0i/427P+RxIhFJ6o7cgWmDegFVtX/y
         NdprItCytIZMEN3VhnkqtqbOxWPgtBA5COCcfLCKWg4ntU0/U3ETdOnnKyVPCUUbaibU
         rVg1hmxQIa40TTWFWLQi7v6so8JSSo6YDSmDtUdLDbQvHMhUH3C3/aL86/zJlcjS0PqR
         tpKbAU+gOVPgUtTOaLnlhQh3vR8JUmiZ09ta5hgM7fKCJqCMepvCJ+PZZ5tELd2NxuA+
         a37A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770743412; x=1771348212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc+DVhVKXqCne8j9rprRBbjY7AfNTSR37pnlUL+Q12A=;
        b=RNlKRi2KF765L/9sKgshY0edrh8ALg8pSsAax8plVkvgcQOsBWc4QCYChEZKCIvmEl
         ulP/Eq6pfaGkIEvXHOu98/3puAEtMGxCvA5v4J7ok5qdUp6zOL7HW9RXhgzev4wvX+EA
         ZnzP+tylX4Nc/D8Udrq8PQ3ebvQEcpZxU/bpP0Tw4NwKGhObyWV6tgEKJ8kcMESFcabZ
         9H2Z06JD6SmqYHroWu2sUV2GaaYAT20AcjTrT1zrWikwfBixDJXVHOV8tHp0zXTPvORD
         bvW24UNzXkZLpEG0b8sDsh5/t33L5GfI+l4Ey6sF2Kye3xm8GIkiCYSgaZH6bA8/41MI
         oEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770743412; x=1771348212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cc+DVhVKXqCne8j9rprRBbjY7AfNTSR37pnlUL+Q12A=;
        b=KgentRzJdMFou2GFA8/TZUGbBbNyive1FYpKGaeN2gejJJnLy2IzOiLtqYYAFKJYWv
         T8yuN1JBG8zSQ3PbuYKU1rGg8bfKZDKEbKVEpskNRojNidu5X9/Mdn8QhZ4ivLgkinHn
         eTJINWgcKOk8ikYd2UKs7uxHVfg55IFBI+ZwBGTWojRUm4DDUvWjzuPbLNX0TsXNN0pe
         m+UGC9VqtA44CSKu7oJdttI0Ne1Al1nJBNJlYjQwXTI6II+4tKAbgsMjt1A7aovGafJK
         jvO1ykQA++cb2SJ5h3ZEcjeh/T+kIQYjq8niz50EBGBRlGsLHzuZLdi7vKt9nusW5/Mk
         mtdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXXe8HkNxFuJ3U3sUeTrlwZhp3GQB0orQtG5t2Grm1eZ4f/YRhwSuDv2KPzrcifaUcb1Bzw/jARZWAgns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4g4LWwc+l5qGBu7N9+NQ+WcJp/FAxESwx6voK26GfjjEX1aFl
	w7d1ApZN7vH3uZTBEESJBBE1d5Z8QxHBaIUmx5YECHsupjGLbJNAgXDg4PiOBsHuLmxxo1SaCzT
	rC99jEVIxuRG0uCfVCg/KQ4ZnAbt5+Bk=
X-Gm-Gg: AZuq6aLJrzaQUxCG3di8A+WcNM7XwWjfH4r+XsE74+QLM1A33+tIjIjoDlFaenL4JDZ
	T2nPnyncQwNX3s9OWtLtYblNypMZfBhcIk6Pe40tjIA3pZ4wxt4n8wTXZqbENjdQgyxrN6g8xKV
	V6+CEf92aUZq2p+s1H/FR7FjIRH1GOYNK4DAL4Ft8GmFL/Mm4+xp01YopYHICZNMCoyuwqLzOgX
	T/5cjVPspsyJMvWNWIkXm/i3YnsYwuIWyjR0TULxziY0W4FmLbiOeoDr+8/M7tf5e2v03U34DXL
	VzyglmyjOQ==
X-Received: by 2002:a05:7301:614:b0:2ba:7aed:560d with SMTP id
 5a478bee46e88-2ba7aed60c3mr2133807eec.28.1770743412332; Tue, 10 Feb 2026
 09:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-rearview-hungrily-536a95fc3385@thorsis.com> <aYtVNxZU4tqtj2fo@lizhi-Precision-Tower-5810>
In-Reply-To: <aYtVNxZU4tqtj2fo@lizhi-Precision-Tower-5810>
From: Manikanta guntupalli <manion05gk@gmail.com>
Date: Tue, 10 Feb 2026 22:40:00 +0530
X-Gm-Features: AZwV_QjbKvfyf70mWkfIgb_YjQsj3v2oytyNy4_JkLGqp5ONf6B-sb_fAn62SlE
Message-ID: <CAA0M9UZTVJCSFfB2TQR0Fw_6bgOgVGdDQgkYMnHoGVHHX9cN-w@mail.gmail.com>
Subject: Re: rts-gpios support in fsl_lpuart driver?
To: Frank Li <Frank.li@nxp.com>
Cc: imx@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Roelf-Erik Carsjens <rca@thorsis.com>, Josua Mayer <josua@solid-run.com>, sherry.sun@nxp.com
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

On Tue, 10 Feb 2026, 21:28 Frank Li, <Frank.li@nxp.com> wrote:
>
> On Tue, Feb 10, 2026 at 12:48:05PM +0100, Alexander Dahl wrote:
> > Hello everyone,
>
> Add sherry. look like we have not implemented it at lpuart.
>
> Frank
> >
> > we are currently experimenting with the SolidRun 8XLite SoM featuring
> > an i.MX 8XLite SoC on a custom base board.  Due to how our peripheral
> > hardware is connected we need to use rs485 with uart3, which has no
> > native soc controlled rts line.  On different SoCs you just use
> > 'rts-gpios' in devicetree then, letting the kernel switch this line
> > through gpio.  Alas it does not work on this SoC, the RTS line is not
> > switched at all. :-/
> >
> > According to my analysis the i.MX8 family has different variants using
> > different uarts with different drivers.  For the variants using the
> > imx.c driver, you find dts files using rts-gpios, but for variants
> > using the fsl_lpuart.c driver you find none.
> >
> > The rts-gpios property is evaluated by the serial core in
> > `mctrl_gpio_init()` right?  And the actual switching is also done
> > through that mctrl_gpio interface, right?  As far as I understand the
> > source code, the serial core calls the .set_mctrl function pointer,
> > and then it is up to the driver what to do?  Some (like atmel_serial.c
> > and imx.c) call mctrl_gpio_set() in the function mapped to that
> > pointer, some (like fsl_lpuart.c) don't.  Correct so far?
> >
> > Up to this point I'm somewhat confused this is no generic feature in
> > the core which works for any uart, but there's probably a reason for
> > that?  Maybe interaction with the actual uart registers in some way?
> >
> > If it is like described, I'd say the fsl_lpuart driver currently just
> > does not support this usecase?  Is it possible to implement the
> > necessary things?  Is anybody already working on that?  I looked in my
> > mailing list archive and in the imx downstream kernel, but could not
> > find any hints.
> >
> > Any advice welcome. :-)
> >
> > Greets
> > Alex
> >
>
If we are using gpio as rts line, we need to handle it in the driver sequence.
Please refer to the patch below, that may be helpful.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.19&id=fccc9d9233f918ee50cf2955ae7134a7f3418351

Thanks,
Manikanta.
