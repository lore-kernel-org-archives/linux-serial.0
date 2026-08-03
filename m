Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0642D7DF1
	for <linux-serial@vger.kernel.org>; Mon,  3 Aug 2026 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742155; cv=pass; b=u9lHoqkOvosQzNvEqiM5kROiBn6qmaJ3fHqq3Mfc4XbuwlaA83pk+/TOwsoHWc4iOcheS05VDSquE2+5HJtBXhwJ51KsMPv8fxcQkXF+v2gamwVQVs1cBMiWZsxqgKEl3nddHZi+me2/PvlW59dbtlI4TS0XZYrYUhYyjHOJBbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742155; c=relaxed/simple;
	bh=qF82kGnBunMAOiIwxsf/UD/YTw0Jic0HHWDfNS3m0v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7hYNprbgnDkMpAAZKpv1VQI29hhPBap3qdEJEnxl9+sR+cWy5Besr6k/EUa7M6DquWJkyH7YIWjA29W+DZ9OqxYeCdbyX/AAHW28HHctI8IvRmH5bpXnW3OhkszMxVLij1927VCvAbJp6RD44SldJoFufKucLj3aNF7ZqIYZL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr5mYkZk; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr5mYkZk"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1671ec8692so383209066b.0
        for <linux-serial@vger.kernel.org>; Mon, 03 Aug 2026 00:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785742151; cv=none;
        d=google.com; s=arc-20260327;
        b=JNdF5Pbe+mkM3VFZfxrtNkVFkJPh0VtovUmAuBC0Tfbmwg9i12G5kJ+xRJsWdUwoPZ
         8s34zjrWNJH391BoV+rxBXwJDx3VUqul1Q9xTxEozQmbIc0UIyxXQ3QKcCoz75/hOQF9
         mY85uWxX4wgwSa/9Jg/UKKZ+0DddTGTLeQAxZs+cQMzdtnmyQkEmeGW3It1Zpx4GkFgD
         CsWw1Ud8y7ufhkbUFkYtKVBS68jljOr/SCCO2UsMtfIziYwTQlF50RBUszhqhfPa6P+R
         nhZycgJYfJhcw9M77C2Ex45iBhd/UwGbBqb7JSspXZM1GdWa6uby7WjGAJwex6jZ2zsT
         jlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qgQzKdlLRJX3EZKfy+TLLsFYacdulxTSH593Q/l0Al8=;
        fh=ELLaYIzKjhRGX8XJ3vjR0JnRCUbfxHrdghul8kCCn1A=;
        b=cTpS7Czgr6P/wRkuFO+rVYf6F4y6R+AQr8YeFomC2E/8Ecfo0zjLsFD4tlPjPCkbRi
         Q2I+XdnJHxgzpOreZ6TtcGM9bv6q2rZltikb9caaK2L+oV3YjvXZ6N9Cm8lCFvC6Cy8L
         G4DVP6PK9LdllJSL6tIPc54PG9CKVy05pczWf5riR8Y7FZKIKbOszpbkCJn/ZGSnh7ni
         g/v5kZoQo8hO+oglJSpaKTr/vaZbAJf9UEEXlOhPRsOg31dMMebOrePWq57pMhfFe93O
         IWuSt/Nc+U26f0cJsl70sDZd2W2EZuWJMdK7AKrUYg+J45iqV2OD9Psw2y2rQR5wvn2Y
         dxaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742151; x=1786346951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qgQzKdlLRJX3EZKfy+TLLsFYacdulxTSH593Q/l0Al8=;
        b=Cr5mYkZkjLX51m0xDPw8ySvgxTqxp0Y9ye0P5uKR3G5sStvTcK8YRJYfzHhbSCXSwe
         O39E90e1uGtnTJMbQ2ueAJ1epESXaYzJ15jN1cGqh8q/I8ZXElXT8eJSYvcWhDbdo+9w
         5XuBAlZDd2f/nnraD38oQ1riHCy0RXZs7Jv4Ss6CdnduNb8YpPA0+3KvR70l4kkZVQ5B
         /HJDxhpUXiIfroNVT58IY1tnlVdeRqEwYpG+A1dEJUXetBz3LrTj934JwUqQ/1MkuNiq
         DvHOxC5e2gQ7PtttoXiAEIRsAN3GlNMCJf0B/LbiDZhztLg0tzcBcjWw7QH9E1VULLwD
         sGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742151; x=1786346951;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qgQzKdlLRJX3EZKfy+TLLsFYacdulxTSH593Q/l0Al8=;
        b=F9LMvYVYNDlx1ABDThQAztKvI5oDsr8Vu5MqHBn3ICZMb6omTF55fwU/1rXwjobMtJ
         Hn1LLCb2AmuCs89NTfL6djEetOhWzGuRViCRsWfJpo8yPwUwfGQ38fmCUVEK9icrWNnU
         w8jjCQs0GuR9A2gGVuJrmAVgQpRsid98dU3mUMx9OBfnGcd+UA7+xrCCd1YORoS7Yz2p
         gJdOEZ3NoTPtQ6COQc6MqxjB5Y9Oa0MC6St4kpG0T3AyuSr4j8vJxrfcN+GFXV8/UI4r
         xSzHTo0b+Xk3TawUQ/83Aiz7u/yVyAdl2Li2Kn2FBDp47X4IxwnFn1FL43MUpf+StYw7
         IZKQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNCc+Y5EGh8zlUShaSFE8aSIOqnq2+vvdMax0iwZq5JErY3PrDQCWhy0IHuLfgvUsiuLUDnzGpdTpr1Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyytF67BmMG75MIocCKUvnx/gOPZcNGh/sNA5ZD/9zDXZ9Ccjo2
	mZqlVoz25YbrfrmP5wbae4+7hEaTJZd8nUtQbPopU0XLCTyYNkBh/eEF/zsldZCp+7fGsgXiag+
	qtvrt9HRpvybyIWnzkks+dODXrin2wds=
X-Gm-Gg: AR+sD11t9qYQyjcYPLbvmUzrakZhH7oIxiCaOfiNiDMLaTOWppQa7xOBtAiFpB/OkgR
	Vu/ntXT8p3S1yoABlk3sQupA6EphgtR1yb0LnrBp20SP7g05rZUN6W7+2ZLQHfNE+x0yveOR5LS
	YIpxeMijgPFIHO8bma1n2x9fgUCU67phk+QaSuE0q3sl+jCLZk4dlLcxQM4FWinq64OUvpz4xZZ
	Ztk2hYOPPLDvfu3SAY/j5YGSpPm7j8ECqk9yT6IXWID/TTmPUHj/jO2be7O2wNas4+fXm+t/anA
	k7hEWigLbfR6OicSLjcjC/YdiSStJ170DMdN+fh7yoajGpoFLx7mkA426w0jZn2E+yYlPk7U6Rl
	M2fhogDBhYM4VYuEuudL/stapBkYCdS+FOivQZdGfSUEscgI0qPfuF66A7iejfyWHtITzb1gdjX
	jCCVK32QX9Ec1ov1n6V3wiYA4cqJ2Yozj39ccOHUEyuqqRdXgjZl6RWnQe5NDH2No=
X-Received: by 2002:a17:907:e1cd:10b0:c16:66dc:3ab7 with SMTP id
 a640c23a62f3a-c1fe7f0d3eamr446928866b.10.1785742151238; Mon, 03 Aug 2026
 00:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
 <20260731074820.735619-9-crescentcy.hsieh@moxa.com> <CAHp75VdL71oE-E85fOLbz36bhs3EKg1iL_vtNP+TQzek5PNqnQ@mail.gmail.com>
 <7a4900a7-bd31-46ee-81ee-d597899a34de@kernel.org> <CAHp75VdSqLZo+XYr_V6QO-yMUJCvd5+8hKSkHDsNQWFF=KXERQ@mail.gmail.com>
In-Reply-To: <CAHp75VdSqLZo+XYr_V6QO-yMUJCvd5+8hKSkHDsNQWFF=KXERQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 3 Aug 2026 10:28:34 +0300
X-Gm-Features: AUfX_mx6ILj0dNzqefDqXeQg5vvmJP3hbyzcJOtv7vW8pBOeCroZ6wViLC3Wc-Y
Message-ID: <CAHp75VfRWdWcL0NSmQRpVeb5idcLCZCzKD6ynGza7+o7M2VG=w@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] serial: 8250_mxpcie: speed up TX using
 memory-mapped FIFO window
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, FangpingFP.Cheng@moxa.com, 
	Epson.Chiang@moxa.com, EddieSY.Lin@moxa.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:26=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Aug 3, 2026 at 7:46=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> =
wrote:
> >
> > On 02. 08. 26, 11:10, Andy Shevchenko wrote:
> > > On Fri, Jul 31, 2026 at 10:49=E2=80=AFAM Crescent Hsieh
> > > <crescentcy.hsieh@moxa.com> wrote:
> > >>
> > >> The MUEx50 UART provides a memory-mapped TX FIFO data window along w=
ith
> > >> a TX FIFO level counter.
> > >>
> > >> Fill the TX FIFO in bulk via the MMIO FIFO window based on available
> > >> FIFO space, using uart_port_tx_limited() for the common serial-core =
TX
> > >> handling.
> > >
> > > ...
> > >
> > >> +static void mxpcie8250_tx_chars(struct uart_8250_port *up)
> > >> +{
> > >> +       struct uart_port *port =3D &up->port;
> > >> +       unsigned int offset =3D 0;
> > >> +       unsigned char c;
> > >> +
> > >> +       uart_port_tx_limited(port, c, port->fifosize - serial_in(up,=
 MOXA_PUART_TX_FIFO_CNT),
> > >> +                            true,
> > >> +                            serial_out(up, MOXA_PUART_TX_FIFO_MEM +=
 offset++, c),
> > >> +                            ({}));
> > >> +}
> > >
> > > At least three randomly chosen drivers use the empty tx_done, perhaps
> > > it's time to have a helper that embeds this ugly piece in it and hide=
s
> > > from the driver?
> >
> > I haven't tried, can we make the helper a variadic macro?
>
> Since it's last argument it can be done with the variadic, but you can
> also reconsider the others from the same group (the wrappers on top of
> __uart_port_tx() call) to regroup argument list to make more than a
> single optional argument. This can mimic the case of
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
lib/kstrtox.h#n21
> where two optional arguments are possible.

Note, if you see the history of those changes, you can see how it can
be achieved iteratively without breaking the users and having a single
name of the function, say uart_port_tx() for a new approach.


--=20
With Best Regards,
Andy Shevchenko
