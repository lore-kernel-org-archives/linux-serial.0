Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567C49659
	for <linux-serial@vger.kernel.org>; Mon,  4 May 2026 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908096; cv=pass; b=JmCbggJnor1ASx9ffF8tTlvdlaLnJwVFdbsaCTyjPUz/JiJsRFiAqW/FbQT+vVrRsjF01sMdd5MWc8BiVXZkGk5E9nTZI2llROrfL5nTm7Z3pItnlm6B7avHm0MsCilb7wiQ+clZxmZOBlVUa4mvtCx0kKcyH8IAZCxTp489b40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908096; c=relaxed/simple;
	bh=qMyYxdjSmw6x5bnhmtRc12eAICJQbrUWTCK6xu+ebzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARrUxHEKeNr6+nopzuimpV6i5tqx+2NSUOMtwcjKZEFST2YSMgCagOiNUld2Bsz2hb29atntmoySqzckfXt/xKaSEtWkp2Qprs+AKcHvdGt/l2oi0r2dC174wjubp8Mwuw8kZWd88rRemHGVYpXhzIgMGFekZLftb5ISSB/Ho9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr6kpCH9; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr6kpCH9"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67b7c71c165so4750639a12.0
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 08:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777908094; cv=none;
        d=google.com; s=arc-20240605;
        b=Z11vFA4o65LCFDKCJ8VgcLwzuzXceVAlyY1W5mN3sSX1QKLngKKs7nunYaah7MOsfm
         gZ5QXxSC0TtAhrDqiSEgPqMvXbZ8P198t39OnpwlIhsBww3YwPxMox9dOiiu6/+35voq
         7J2sz2ILI4Auztmdg5yHJhOTVluch2DyFvLhIGXtVC3OSxERrxVAtgwU34jjcKRkCOQu
         hlmKyWUX11ES6XxlTH0nTXM0YvUKDBy/8rWyQQEO95r/mS0hYXkaOEB18CJG+jO/iu43
         uExVkz7Ne7M6hBjvNhuvS0ZJeNnyUSATUj5tZRy+WRmYUPkPf3d4luLAhnm3sU82bn8R
         5QcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AAl38ufMDF/VMLi0qgb9Q6cC5vHeQWosUQQW5K/9+/g=;
        fh=QT3RDbpvFnKNSj2tKeO+4V+SaTCd47s1au/HLqhfJKA=;
        b=C29TIWdUXlgxYzJEcJ3MbQMtZYT6Eyww5iozjlyJir118QkC/BFpdHFq1hqur5qVKn
         AxvskMMWE88jBgAUm0HxufqvllJaB5B9warHHTVOqBIU3OMv0lcWzM4hf/Beg7L/4ZRA
         ozEYtZIyyuEu4Be/IZo/Do37i7AaCqUW9CTqwdtiTFD/1afoWJQumMG7pZUnNzjXW30Z
         hNusPoWxcNBwBnv2TZDFvEIN/Ku4+LXlPRr7jo/szxc6nui/HDjCsy54iGaGyyDeR/rR
         V/uwl/Uw0obughUM6iHCju3p0H2KhamDpeAMwCgaDN/hQ2Qt7qNX/S7n+oQ6EOvSSB7S
         hLlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777908094; x=1778512894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAl38ufMDF/VMLi0qgb9Q6cC5vHeQWosUQQW5K/9+/g=;
        b=Mr6kpCH9aLUa58z9Rdfp2TaLIFPE9/iTXgstyTlK1hFNPk8ui4NAINZFQmP5/pLaxt
         7h2DClVSwuO8eoSu3iCShsVDZzaL0Kpuk5wvZjT1Pne9wpJmmP/f7zQ8Lf7HKFaNFtF0
         LiS7sP00FlFr3JNJEokduv1zU3zaNbMcR41Pcv7Mwr3a3ns23Jf8QM+QjwxJqD3wQy6n
         wryVyb4Rvm7GXP8Y4S6FvYVQhCFofsI+ALT8sDIhRw3eO+l+eE1w0iY4i/iOPu2thK8S
         2Tt26InebI0Cqwo7eUeot12We4HpPcexOg/PYkIcdWmM3FXFTCeB/03Pg2s5QS1q3RJT
         bm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777908094; x=1778512894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AAl38ufMDF/VMLi0qgb9Q6cC5vHeQWosUQQW5K/9+/g=;
        b=V0NQmEgx+rtB5d2aHPr7fmprnDZhYy2hr2kRoTVIoSTmPKrmO8Di6GbnOWbwOZlMhx
         OrarUXOaOn7bMeG8Q4yl9zcijTqZM1fT5RGJTdQucxP+SrByFZVrUZSJZpNCGfhbgZXX
         d1S/JBMaB3Lo8GGken3Qg+UTedl1Ml+3ek3AG7VYF88978/5PzU0epyywYCMB9oIJhX0
         SrV9rB6V6ja1cHkk7vVv15jrI9Dc+6oqSFaJUNsLEHSaY5scx53AEoSx7L5xOSpm1Jej
         B2ht6fSxfZ55QfJxk4yAO4bC7zPfa4UXvVrwlnA/8tfsMhEU5iboLE9rgQtU40mZ48X9
         piEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8s/YB9ZBbNFGwThPx/wKAoTWLrnprm3H5NbzJKcf+aNauTipJDD6m6Unb4o1LWRMN+nEQpaSzjf5RqsG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDNW+AU+Cx9vP/taB1iWIJCfyhZLSsU1jI8Kl7jRIaWehBjtb
	JuKIxegZXus7TmPbWPwAZtwqz4YT9Q4NoePBFPl6Ewtu9e0sqJRKk2GgjNcSTyEskfjT5Sat/g/
	ZcnxcobPvOoqPrAfU4iPlgZVhHsYGGhk=
X-Gm-Gg: AeBDieskIXAzJwsIJhYiwgwCZygIUDTj4qVd6hBY4Ka9kX0qucM6m19U4GZ74fIqZIX
	WVbf1k3p6GrajwTF6kPIr0yP0kfSVdhyWSUFfIKE08dlIYVHz3lJdgHcMZeHU3IQin11uKFvlnq
	nxfH9ALdHKWNnn63Aw7AX5gN9SeflMP23pxa7Dg4MYmDGJEsKMIh/XK8IhaUfNW12l2FIB/84fW
	Ag/OBBTJYZ1WVr03piqhXMR/pPS0zA7l4ZsQYtygJMmm/idWO+V4y1AnCztxhXgMmbrH/DnihrL
	Zc92hqZY4eTKyfG8nYxbT/J0yiVjxrN8tRIGY5eDEYW8cuHKKw83frFsBXqDFnrXtkKPKkpFMoQ
	8uME27Uhx4+Okfx4Wve3d1z4/Eky+
X-Received: by 2002:a17:907:3e1a:b0:bc1:2cdb:5d04 with SMTP id
 a640c23a62f3a-bc12cdb93b3mr341329666b.12.1777908093482; Mon, 04 May 2026
 08:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com> <20260504084900.22380-6-crescentcy.hsieh@moxa.com>
In-Reply-To: <20260504084900.22380-6-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 May 2026 18:20:56 +0300
X-Gm-Features: AVHnY4LdemAAp-0qCYzOIcZ9v2sWOBGO8tuVj_fNWuM_JkWpZ7kRLV8hM9jaalU
Message-ID: <CAHp75VfWMRrthp9ETORVHVRJwf3CL-HsZAevY_CB0G96JmQy5A@mail.gmail.com>
Subject: Re: [PATCH 05/15] serial: 8250_mxpcie: offload XON/XOFF flow control
 to MUEx50 hardware
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, fangpingfp.cheng@moxa.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 11:50=E2=80=AFAM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The MUEx50 UART can handle in-band software flow control (XON/XOFF)
> directly in hardware.
>
> Program the on-chip XON/XOFF characters from termios settings and enable
> the corresponding MUEx50 flow control modes when IXON or IXOFF is
> requested. Provide throttle and unthrottle callbacks so RX can be
> stopped and resumed cleanly.

...

> +static void mxpcie8250_throttle(struct uart_port *port)
> +{
> +       unsigned long flags;

> +       uart_port_lock_irqsave(port, &flags);

You may use guard()() from cleanup.h.

> +       port->ops->stop_rx(port);
> +
> +       uart_port_unlock_irqrestore(port, flags);
> +}
> +
> +static void mxpcie8250_unthrottle(struct uart_port *port)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(port);
> +       unsigned long flags;
> +
> +       uart_port_lock_irqsave(port, &flags);
> +
> +       up->ier |=3D UART_IER_RLSI | UART_IER_RDI;
> +       port->read_status_mask |=3D UART_LSR_DR;
> +       serial_out(up, UART_IER, up->ier);
> +
> +       uart_port_unlock_irqrestore(port, flags);

Ditto.

> +}

--=20
With Best Regards,
Andy Shevchenko
