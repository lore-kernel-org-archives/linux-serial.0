Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793500859;
	b=oxvPQzmqsWA9aefXZ0FeTR+Rftyaz07BY85LAJlRzV2yO/UNPW4/KLa56siwctLwHvNc
	 8SHtHc5cMhEr1R5Fc89J+ZC60E/o0BRgSMAD7bL4vPoL4xMsIDaXmZ1W+btVbYvdm53W9
	 9GY7EH9BUTtf1oSUffYRfPdK/qCoPEt6w5NzbBZ68titHhJmST+Zwq+1rr9nkFmt2K7N/
	 zDm1zcLZilN4QP79cy961dNX4TC2gXu3uBD+KYixNrRrlMbFt22k0tyLE6abyU9pZdAA/
	 wun9yqx4YhDXtEmeeEJcvwsf+KHaI8r8ppaXOPQnvpD30q8mbrMQ2n+BUKNhjO0TiCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793500859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1IMLP1uSL37pYuVPWPBfoKH2KOXXSQSRBqC/yvZ530o=;
	b=vTkcv4tMwS1yl6OHmJnfZ3i9wRdegrObg9uy3qPKxqRFJDA6UL6en+E3y/MVKt8lB6Vg
	 zzTDC4KG8znMa3YUL0m1zkgJR2j/XSipZxwZ2AeSD+MJD6asSuYNkY7YQNwCU3kKeEJ6g
	 g41+BcqJTNDe84y/PnGuC1E2kHTfnJzsu6KxBSEA93mShDNA8kAd8XssFCluZsbPwqDZM
	 u2fUQUMTiZK/6fUReKN4J1H94qToAPJkX+eEBFbo8YvY4+9uDxLO2YDJZVX/r3oEj0UKT
	 1Xat/y6tyaVzXOGlPPMBLZtGDe4jHrCOvSABIO44bVAB9hhKLAWCuG7ectFMX1VhVJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.136
Received: from mail-yx2-f8.google.com (mail-yx2-f8.google.com [74.125.224.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F890606A329
	for <linux-serial@vger.kernel.org>; Sun,  1 Nov 2026 02:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F890606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx2-f8.google.com with SMTP id 956f58d0204a3-6798922d252so821333d50.1
        for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 19:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793500853; cv=none;
        d=google.com; s=arc-20260327;
        b=QRY05f/FYqfP2te02fGzvyPjh3/VDf9KfuzgzPXYB9rzvkd3/Sy9cIvvlmLscNep9r
         RT7yfUCzIa7fs0fsGOk/PW7ZYLeJZzbOITOMKdV81yuMllj8d3boWQaAnrrt/NSo16by
         CaOXqKMVAp65+YPfx7la7RlY7Guqo/ekb72dU/ZYpRigP1xkroEzb5Ge4D4MzSLDNW+z
         fQNwQg/VGkzpgnqC30X4xLbHZIQhYWXA+XC7Oe5Imgf5prE51LVatyg5QSzc3BZHgDka
         uz9MDnt43qEFctDY+qA5/V+RAF3cdpQLGYeY0Ek4L9Sb3GBTdJDReFPYh3InucWypsDA
         cywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=1IMLP1uSL37pYuVPWPBfoKH2KOXXSQSRBqC/yvZ530o=;
        fh=EYW2+qCQCNCe+OKxrizKErFrjufVCbiOb6aAuHRL59s=;
        b=IswE1emUd3PsD1waKCKFfgvtS+q5MF7zyvdnMa+dQ9k46WSFLJP/69JtMHodVk05iT
         HMhk8ua2+XMinI3/GCfzXV7Mrs1gg+qZIFRUP3FgeK/OEviPnoKQzYEGAeNefuNCimxl
         m5pGHBDhpvjLXoOelGAPhIwm7YyCBqFhk9QRwtjCpkcePJ7pVbv7aUANtfdICa4/wCxW
         LTYzPeMZFhU2KzaSHcd+eA6YUiuXV76ZVV1lxWojQmhle/eZD/0mDEA5BjrgsGat0OXN
         3VmWl6vuXsil+841PsumaQanzyODMFU7Ex/0scoDSEBQhX72BzVCm/qIxCIUt/edPmyf
         30ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793500853; x=1794105653; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1IMLP1uSL37pYuVPWPBfoKH2KOXXSQSRBqC/yvZ530o=;
        b=BdFFyetvdnDEMnfGsoIWQiMtKPBtPDTFhUEhcQqmNX3fsNX9e+lwkasxGFsEy8ZtHU
         9bdAuna3av4LHkc1kFrP58sIUjq3UyEONkdZHf+un0JfQXRcqd66h5LeQmAjGv34E5NS
         eXJ0gDEAqh3L2m/g2OQ8ILmrL4vT3BBtev9ZRcsjIPT09N+qh+xo4JYhcbnWMzIER31K
         zM5D3VfhSCMVXG+Ak9S9qpIpfEkAuk/05B3Qlvzfg5ys1twUAl1fNw9iJ0MKWpYWYOux
         +OKkYhgTfBrml388WlM3d7x9nkOK9jjc1uFw1iMTWCosMy7KWl/aFChbt1Npo2dJrXJU
         ZO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793500853; x=1794105653;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1IMLP1uSL37pYuVPWPBfoKH2KOXXSQSRBqC/yvZ530o=;
        b=Ab4l+jU5OKz26mYXn904g0PvJS0pYbpu8FFEbu/U/JI+Fh16/CfSa03JH0JV5ozOyw
         jiBR/D7jEhKVIml5WrvJr2GCQDR7ynrKcUz/mKUl7YhRIjYIYkvoGqyQsdqnsBuEtZOl
         SPkWd27xWZPdBIOgRYbCbyP+8yqdNFcGpOTNRFermQ0lX7QCp/0XbOxM9L2sykJTFOZR
         0HPC/JxFofz/sV+8tOZ1ZXwInb2klaAkIRy53evwP/hC1svDlmi6aVbI5RcqlpVfg6Tb
         BlF/2YLEENe5tckPD+5N8M7k+yPq01UFAaTH0ZRhtYP9wzhKUG7u2GvTmxBF4NuQ0a8+
         HBoA==
X-Forwarded-Encrypted: i=1; AKwUvBxfpHe6tlZq2wOzTEQqYaT2ITX09c/DPxyaMFiqYZTRzYtoHPLcYcchrhPO4YKx7haOun6z96a4qt/t9r0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DuODTXXjFGjlzj8fwwD+BMmJVpaRKgvjRG2pn8lA3XO1pDtHu
	gtJueg9POZQS6cUD2NAk+U9TdXVwYfhKIETyeKxXq5wiWkREIc6oe3vn0R4F+7IcQcZXUEQlzgp
	hKXp5r8KwH1Tm4OfYBDxh/rB2NYu8iqU=
X-Gm-Gg: AYBFou2eKgLaG4g8o77gM4Hm4LmtDuwmFcQ9bMFaWPiCgIIQY7EFNTIsoJ+IM8bNgTr
	6L+lC/4bnoHo0KTgvntwbvvD5DuHt2plXKrRFD7tvBId6ossYXkDPDjv1UY/Fc3UwSmjU/alUpL
	OQcFip2jirlGv9eBX+E6TmFznxblDcDJcvOj6n1M/C5mC50udbcHEDQiFOAhS2YmRatYlqQ7JuN
	NI9Amset4fNQHS0l9TZOkJx5Bir/CAbRd3HnQUh5KY1/Z8XiqF/5hGcXZqr3jJ+2fC35bFwobEQ
	1XSodBGUEvauZPiNUL5vegPePTpdt17qDEvgi4De8/MNTirVrDRbE1hZ1N3MclfZW/ycDB4ZApV
	1oRbwWfh2OC1ALWflbCwVjKHGwXX92XjgUyA=
X-Received: by 2002:a05:690c:6989:b0:8b0:ecb2:884b with SMTP id
 00721157ae682-8b2b6707c48mr49035517b3.26.1793500852565; Sat, 31 Oct 2026
 19:40:52 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 31 Oct 2026 21:40:52 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 31 Oct 2026 21:40:52 -0500
In-Reply-To: <2026103142-shorten-shindig-bedc@gregkh>
References: <2026103122-repurpose-cost-2da7@gregkh> <20261031152656.1422-1-xiex16070@gmail.com>
 <2026103142-shorten-shindig-bedc@gregkh>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: akari Akaza <xiex16070@gmail.com>
Date: Sat, 31 Oct 2026 21:40:52 -0500
X-Gm-Features: AclHuK_3PZPlhb8eWBRsqZBFCzLH4zAeC2-QvNwLLojfXV5DV2NRjTLb-47rKFM
Message-ID: <CAJePJ2c8b400Q15=GrdDsJ=aF03g+ZwcTx8ZsJCDM5uHTH3k4Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] tty: serial: samsung: fix TX fifo underflow on flush race
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org, krzk@kernel.org, peter.griffin@linaro.org, 
	alim.akhtar@samsung.com, m.szyprowski@samsung.com, samarth.colleges@gmail.com, 
	linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

Thank you for your honest feedback.

To answer your question, I'm still a student learning Linux and how
the kernel works. I've always been deeply inspired by the generosity
and dedication of the open-source community, where so many developers
freely share their knowledge and work for the benefit of others.

That spirit made me want to try contributing something myself, even
though I still have a great deal to learn.

Looking back, I realize I was too hasty in submitting this patch
without having a proper environment to test it. I sincerely apologize
for my carelessness and for taking up the maintainers' time with
insufficiently tested work.

I have great respect for the rigorous standards of Linux kernel
development, and I understand why those standards are necessary. I
take your criticism seriously, and I appreciate you being direct with
me.

I'll work on obtaining a suitable Linux testing environment as soon as
I can, and I won't resubmit this patch until I can provide more
thorough and meaningful testing.

For now, I'd like to step back from this submission and focus on
learning and improving my testing practices.

Thank you again for your time and for the work you and the other
maintainers do for the Linux community.

Best regards,
tianci xie

On Sat, 31 Oct 2026 21:28:16 +0100, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Oct 31, 2026 at 11:26:55PM +0800, tianci xie wrote:
> > I do not have a Linux machine of my own. The x86_64 build above was run
> > on a rented Linux server, and the arm64 build was cross-compiled there
> > with a no-libc aarch64 toolchain; that is as far as I can take testing
> > without hardware. There is no Exynos or Apple board available to me, so
> > the model is what stands in for a runtime reproduction. If you would
> > rather have the flush modelled as a KUnit test in the tree, say so and I
> > will send that instead.
>
> Sorry, but stuff like this you are going to have to test on your own
> system. Why would you do linux kernel work without that?
>
> greg k-h
