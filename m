Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDB25B08E
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561918; cv=none; b=mBNAJvaY4R/YGNSX+afjpUNhbfpYd51gw9u2hMSAYq2QrSxm+F2yXK04QVIEyXOvPYi8z9jRQhFwG8JUFl10fcwF7+Jggs5wIBJ1ymmeuL8/OnsqkwrtlhV9bGaFN53oe5y+JZmj8P8AX3XTmhCMBf74GbnbT9d/wCXTpzsbvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561918; c=relaxed/simple;
	bh=GG4yiV9DxJza8/EgbLg1Pcje28lQYBQ37YcNHEdzFw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjX6hiGoGyCFaSyRSew/bLAFrrsXtDDl4sEZlWMoXHH8qp7kv0peeM/U3Mo1YjqWBR/qQN5jLkku10IZ4Qn7ICZLNAGls4rber0R26V4hLRdOkm2kmoptwNu4wKwIP2dETbjF2npo/55qevA8fBiRAJ4GY/k8pX8l0wJKu3YKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzlOQqNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzlOQqNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C911F00AC4
	for <linux-serial@vger.kernel.org>; Fri,  4 Sep 2026 22:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561917;
	bh=uWYUMjGqi5+4yk50gbS8J6hfId+b/zKW8a33FxvQ4nU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HzlOQqNc1Evv0C6JqokOkN7F06aYDZZYMxAYA3OX1KMOe2DXzt4Ncbjy0zZ4al3lR
	 Uoo9Q1oafgAwBFtaKwSGI7sAqFK0w1OrESsnnvUmtUxDw5reYXNwlfG4LqFZCjFVpN
	 L2JroJBKJGy4GCSBxttOwyHciYS6FAfrjsZgSmOOmcka7sb2SpyYKMNie5G8ibdj8C
	 hMb+0N2+2NN9d7sURunryOjJaHOfh1Hnp0gQhyFK0tVRrWuylhDE1CwoaWt1VStb65
	 bbbi/bcsI1NiIZLyq0Ch4HhY3txmOccuRVZR4K8evDbT+f2ENwmGViiZ45ZqVmrmmj
	 1js1XNcJckbLg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b4ab4b4179so1404230e87.0
        for <linux-serial@vger.kernel.org>; Fri, 04 Sep 2026 15:45:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxkzLwaabgpGT6r3KKIG54zDWxSe3oSzTUExPoCMdWfELXxOwFt+v1G4YSQY1SwPa3gsZEfTVEIkaYhMFE=@vger.kernel.org
X-Gm-Message-State: AFuF++nwmOrGbrc1S1kPT7GXoWKU2gHR0v90sPPXrzqem0SOM7iKcK3d
	Y56TBvYWpEolgwVlYoKzWU7Y860WP6xtKhY7cHMCUqMUycMASrOGk6I2w3oOVOJ75i2Uu/karRX
	8hmmwAANyAC0KJ/FcSdhQlTpEDTVKfmU=
X-Received: by 2002:a05:6512:2582:b0:5b6:1a42:7d52 with SMTP id
 2adb3069b0e04-5b61a427dbdmr2174130e87.13.1788561916383; Fri, 04 Sep 2026
 15:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-11-e918514cb3b1@ambarella.com> <20260904065101.17ED31F00A3E@smtp.kernel.org>
In-Reply-To: <20260904065101.17ED31F00A3E@smtp.kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:45:04 +0200
X-Gmail-Original-Message-ID: <CAD++jLkuLQpMb-peBOeGaaQW3Ab_v2DAVd191=UsEa6HWpHziQ@mail.gmail.com>
X-Gm-Features: AcwNN1ULv-94H7UIBduBUR0idoBBCRH3PFxC8xWrAuyRsnVdRS1-1N4JfQMfrz8
Message-ID: <CAD++jLkuLQpMb-peBOeGaaQW3Ab_v2DAVd191=UsEa6HWpHziQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/13] serial: 8250_dw: add Ambarella CV75 quirks
To: sashiko-reviews@lists.linux.dev
Cc: Long Zhao <longzhao@ambarella.com>, linux-serial@vger.kernel.org, 
	mfd@lists.linux.dev, lee@kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:51=E2=80=AFAM <sashiko-bot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:

> New issues:
> - [High] Eagerly writing to UART_IER in the startup callback prematurely =
enables RX interrupts and races with the console lock.

> > +     /*
> > +      * Ambarella keeps variant IER bits (e.g. ETOI) set for correct R=
X
> > +      * timeout behaviour. Force them into the 8250 IER shadow so late=
r
> > +      * generic IER updates do not clear them.
> > +      */
> > +     up->ier |=3D d->pdata->ier_mask;
> > +     serial_port_out(p, UART_IER, up->ier);
>
> [Severity: High]
> Does this eager write to UART_IER race with the console lock or risk caus=
ing
> an interrupt storm?

That looks like a non-issue to me: the comment explicitly says
what this is about and it's not enabling any interrupts... pretty much
the revers of what Sashiko says could happen is happening, right?
It is actually *disabling* all interrupts.

Yours,
Linus Walleij
