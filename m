Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCCE3921F6
	for <linux-serial@vger.kernel.org>; Sun,  2 Aug 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785661121; cv=pass; b=FMzFyVmYeXYWZ9o9BDt49T43z3teRBg1RK/SqDMuZrZ0hvGgdsRbqpJgOt+mTcb/CaVZkTDHZ4KXQiK0XdjMbLb90HA3DjTXXSy+/+NsSQiW3+y4u2YdPaEWMvORrymdWQsuE1QI0DMp2wtrv5rHr3c2ax1V/79RWr57aT42IHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785661121; c=relaxed/simple;
	bh=Ry/lAeLC/ioT20sc3lNIdYE1eQI081vuwUnEy6raE6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VU82eedkzE+VTsnyZlkQnHKQd2QqCGCEXshg5/lOMNFLjx/tDahRPgGDuo2D1wcn/YtJwfC2jeMGNXMqHWPUZvBFE5ZcSfkpKM0zvG9IftT8qBg8+5JaHryyW1zUtBVfvXzzNIgWC59g5KYEUH0UC0oB7QKYZp1o++JmuHG/79w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZSLk+G7; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZSLk+G7"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1c4c7ddaf6so369399566b.3
        for <linux-serial@vger.kernel.org>; Sun, 02 Aug 2026 01:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785661118; cv=none;
        d=google.com; s=arc-20260327;
        b=ZH7GOCE75TYeqMvgCA75X2ag+P1vTP5OW8FOK/xvZj6X6Nfr29JHpNg+f5lUnYkiR1
         qYtV9RGzqUcUpRSZzIgvC5yYMKcMNZ/fLaL7B0AD2/Z5F3p5NfvXc98tH/yvGjLbJagt
         AT6JUyJ7yqERvF62SHNOm0S5bWAGqLCZ4zq8+0upCa+b4sCOt2IIDK3J1xIBxg2NcC4R
         wCDXomcZk2HxoPWayKjbfSGnNYIcVPo4JQ5LT8ZOa7rDmR0Kibi+lDOXn3YEN+a6YXgt
         WdEOEoUkbm29yVVSoIDIWBeaxTzEd2eOrIAi67SZVBsE+ZmQ9gewC11I+xG/EKdSCl5B
         X6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1bojE7ONYeuuiWdXdDKXR52UaEgkaIo07M0J3K+DZWE=;
        fh=CqMMbqgNKs6bUtg2Tza0Fp8D1/6wVloucpU80hjfz64=;
        b=Yy5ynGqLx1kFTUHKvrUcywiQe3Yh0FRZu7vnT6UkGGxJjzsS0AqdvJ9pCZu/lqBzlu
         /Gfz8EWGzl5ojvM+6HiSY36vtlrp3HQ91BuoV6EPOi0eyelefoS35SsUx4soVhDpvkMh
         O5/mnRnxeCt0UP7hh8bdbaLN32kHrm+P45L/KgcLkvIgaXh2494oN6Nz9Mik9h9YRPkC
         WpZTRmhBD8TZmY5lG2R69PGdAMBe/zDaUnrr0JfKTfE35j67ScroruXJRliCmPl5m2aD
         pKSdNjLr7vlNN3j0Cjw5/1iro/oOSuvujdIkY1q/sCbEjcb7eUEa1fdayB3SnRL0cNJS
         OZlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785661118; x=1786265918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1bojE7ONYeuuiWdXdDKXR52UaEgkaIo07M0J3K+DZWE=;
        b=aZSLk+G7hnDUvi7bKe/QKig5TOFHGazYKufbMsVasVIuX5uUHzn4JNz73MzM7cVwmi
         Jm1DFJey3BAFeGvt5LHwCzCIFSt+PclBAM1m4hmRqYqgcW9646NzZFQMTnCPcprCskao
         0YF9vsmTF77Qd46WkEBOHRcl3/Ic5B6DRoJL2ZKhRNbJBWEw/YDVkfmhdoFyc1a8EBcz
         sCwFFP1+QCqZdoCTQOgU556BHkfkQTOm4laI/fR3DHGAs4zpuMx7YNvEK+2Q+Ax9kdE3
         7wzV/LhPmd+s/ljtxDBSpwJBLZKeFr0yyKRava/c0wFj5NMher8RzR8wEgCxwh9/IoI9
         9usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785661118; x=1786265918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bojE7ONYeuuiWdXdDKXR52UaEgkaIo07M0J3K+DZWE=;
        b=YyeMHzxmyoHVez0uecf56WLuWHaNpWJF6TueFDlhFHtE1/RZF0LhfHK/eZE4V7ARWA
         qXu1YssmvlF1VqEEHpXicytj7KMRSnTvs2S0bT9qx+51lxnMXN5o/+PQOdmSJrwnaSAY
         PdZS+2UJeRdyQRaLEhDGvFNNKiY961aDJtpxbilw3eS1ELWB8it2ySqsSe9Iz5gGLrU2
         x+3oaHs97Aq+/3cM26REXLWPr86S+ua9M7SptjnKTfg/CukT84YCSLtexBGbXJlFLpAk
         InpvB9VmYHN8PoPmzEX6pUYJqnXCReXid/t7uQTi2tIow9Zab4n7UfP27FzM7fjZyqVj
         4HhA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9JUougiXpDLIPyYwZ52g6faghPKr1/LIt1R7gg9UaKEIHAJQA88RJaab0TwFoW/teeFViGkO7OGRMIEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1y5HNBd/8m3IguvjYHwA9cz4qZl1UXVwjiIgtf1uYHusmHb4
	ofSaeEetMgrtqfK/JcXBMIirY+xdu0OTCSBbF3bnATrAUaX16xMGTEPQn/aANq+ciWlDIbBcW1B
	DHvQOOyynXym0VUVa1UwmgDODB28KxyE=
X-Gm-Gg: AR+sD11drphgEGU4eX7YdU61PkaacLbBPv+0Xy1uwl7fezz2DduFyfcu3ekgsW/pbAr
	ZOtLX0tzFfwDaPMNQ7YRjizCbSQn87DQs8l6bqCRtoC+xM1UfWYbws20BCopXd5KQ8xOGzCxR3E
	KRwShJiCfyCpkQIpiaTBcntD2NcyaqYlW/CuYNi9jXR2bunoEWnASILTJfDGswlbFZqVktAoxGy
	pIHly/OR7Q0VkWpLtBE08jpKYqCFAz4XUTT3gyZLic/5HrE/n0cTnxevT+Ybq6qT+gIC9cmjW88
	Tx1Qtvanhg8vVPLucvDLKiDLFx4HymZlwpKuqUpqcXVHZOAmBs+p6FEJfz8I5ak23LfoYZ0+8E1
	jE/Roxu0EV/l3j98uPUlDekMy0xS9p9MlBJkyDFZw7OWvdgTtaHECOd3bcAsfAqDn3joh517kNG
	EJO6g+H6eaEhOaps4BpR5RK38oSU0qG9hq8CtPXWEHHQXDoADg04ta2wau0/EBlwM=
X-Received: by 2002:a17:907:95a4:b0:c1f:97f3:7225 with SMTP id
 a640c23a62f3a-c1fe7ea710amr400054566b.6.1785661117954; Sun, 02 Aug 2026
 01:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com> <20260731074820.735619-5-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260731074820.735619-5-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 2 Aug 2026 11:58:00 +0300
X-Gm-Features: AUfX_mwutCuf1t4h7E7xyCPPvQefv1h9vg5bLqPB-INQefTquuBo_zvN9W_0Wc0
Message-ID: <CAHp75Vdfd+6wbDKJhxPOsXRZ9YssGAHZ15kqWs9=whX+0wJaBw@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] serial: 8250_mxpcie: enable automatic RTS/CTS
 flow control
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	FangpingFP.Cheng@moxa.com, Epson.Chiang@moxa.com, EddieSY.Lin@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:49=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The MUEx50 UART supports automatic RTS/CTS flow control via the enhanced
> feature register.
>
> Implement a mxpcie-specific set_termios() callback that enables MUEx50
> auto-RTS/auto-CTS when CRTSCTS is requested and disables it otherwise.
> Keep the 8250 port status flags in sync with the hardware configuration.

...

> +static void mxpcie8250_set_termios(struct uart_port *port,
> +                                  struct ktermios *new,
> +                                  const struct ktermios *old)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);
> +       struct tty_struct *tty =3D port->state->port.tty;
> +       unsigned int cflag =3D tty->termios.c_cflag;
> +       u8 efr;
> +
> +       serial8250_do_set_termios(port, new, old);

> +       up->port.status &=3D ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
> +
> +       efr =3D serial_in(up, MOXA_PUART_EFR);
> +       efr &=3D ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
> +
> +       if (cflag & CRTSCTS) {
> +               efr |=3D (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_C=
TS);
> +               up->port.status |=3D (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);


Don't you want to use FIELD_MODIFY() at least for efr value? Also
if-else looks better, no?

if (..) {
 FIELD_MODIFY(&efr);
 up->port.status ...
} else {
  ...
}

> +       }
> +       serial_out(up, MOXA_PUART_EFR, efr);
> +}

--=20
With Best Regards,
Andy Shevchenko
