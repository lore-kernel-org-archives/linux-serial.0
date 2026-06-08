Received: from mail-ua1-f65.google.com (mail-ua1-f65.google.com [209.85.222.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD6330307
	for <linux-serial@vger.kernel.org>; Mon,  8 Jun 2026 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938845; cv=pass; b=ot2pq53SY5yMcsoG/pnsPUnKFHngiNBj3AS6MZyh9sRDsmJ174xysC/ct23c6D1Qey0EFa8C009GF94m6gH7p0qU3LAF29G28RvbKVn+qHScTvKY7sPmm53rY2PgwVviKZzIemg4549HFFmdkh1OeQKzOUjyyDzzF7oltwjX7aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938845; c=relaxed/simple;
	bh=EXY2HhbPtnWWjy9ZRBg6fDZvGucC9w5Mnr26sUiKheY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9Fxmh18/Io7jDMvAlryNGQfnJ7LElLtXMxEWK5mqI7EXqe10o7g60SGN09m1ADjERZnPDfZl2Y0GtAKq3Q2WuhIYNhHor4SabIX+pVhWMOm4SPfO9UvgTV5f71nkzaxmoh95z0F1OkX1OC98qJ7+uMMWTwu6rNLFTam8xaSacw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaLmItV3; arc=pass smtp.client-ip=209.85.222.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaLmItV3"
Received: by mail-ua1-f65.google.com with SMTP id a1e0cc1a2514c-963849a4611so1476919241.3
        for <linux-serial@vger.kernel.org>; Mon, 08 Jun 2026 10:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780938843; cv=none;
        d=google.com; s=arc-20240605;
        b=ZXySZVheqskMp2i+Q9QGP5LUlysjT40MWeR8UQgnpVpYW10gzAlMEVJLT9LS3O3wsD
         Al5DQ5v0LXfVdsNJECCEPAyB8XVhts4PkeHVpFGLPu/8HwQKftfR1E8LZJ+iPhHOsvZ+
         iArOEFb5T+tmEJPJSZDP1WDiJ3WNMgoBllyivPamMTKwW4wxowrjZnKNwWZoKBAG/Bmc
         fiBLpPWWvkmwpv+FoQzVbiDj3MnuboZABsVuNmYT8VGb4VnbKf3E2Rm7EgnoMOLK7+BC
         HUgnXM4+hGz+Zk0QAVOgGUhGrF9oh1UOZTJgbXVQP2uX7Yk9BpghX73gorEiPeh6Ri6N
         darQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EXY2HhbPtnWWjy9ZRBg6fDZvGucC9w5Mnr26sUiKheY=;
        fh=CNdPZjlqfV75fvUTIVGq78ghyik2KtI+Appm3GZBtUw=;
        b=QzywK+KIJ+PYbvAqqNhgyeBuY7xm8+GfDt2dh3MMJrSE2UnGe3kNCe706NXkLKt+TJ
         lSzcmOVSmJ6JY4T3vlIwD8fWcyAlcCgHY45uHnEBBxVq0CEPesDMyMXCsqv6gWAOP+Vw
         sadTOphxRkrobleZW2lGHOdxh0PjVnO5O0teof7AxiOvyvj93xNFEJVSqytkQXoFDB3W
         kB2O8u6oFN5ZVuA7X+i8FngawdohbAGJdo86w6t+HADiv7xEv8EwXOuU1so4v6RSuAG+
         3iEXmh4OBXp+stFH20iNzCmydvzoiUplRidWvjtqhE0MoiSDgPloCBVFP/rx0bBTDUzZ
         T7/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780938843; x=1781543643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXY2HhbPtnWWjy9ZRBg6fDZvGucC9w5Mnr26sUiKheY=;
        b=TaLmItV3pzMwr5MpnxgSnNmkPat2OoIab6v6PS6WLQvUvTnuj57+fUZ0qIW1CS0XVK
         ZLdSnvTWci7PbH3SRMMaqMhn2I6hHBe99oyItvzSeasaTBNo22CZB3jSw3kuiWPqId8Z
         y9yk9BIqMZHT187iiuwA0zJeHlN6R6DBFYVCfatL7yxTz9cnTpMTk+LnxLrZTFqydPce
         gWCDrfbey8Qe2BAHQLhLDP89Oq20B1jdeALdbeqCyGWRJXUoXSYrpMI0jBR6s/7ToN4K
         ZnN1tkbWHv2y6gVZ95cQWMzIf7d+JAEgXWyQqsI+Z2hiCl7kDffhB7866iHkZ6VcR+3L
         Rh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780938843; x=1781543643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXY2HhbPtnWWjy9ZRBg6fDZvGucC9w5Mnr26sUiKheY=;
        b=CwBpAVcaKBmlLGPJ3hCrDe4mo+Jhl43SXmDL3L989R36NvXAxp/zRCYXbM/y7IsLZ4
         C6rjcd2sVW0rOW5AcibQA/fi7uVqHKcysXLzKkwpeBSxhMbrLXSEDZKTdmD2tMtQVQLa
         mBChnBCXRUJY1/5kq5Cyh0bQwmh2XwbhtyFTykVbMAFGBRQTTNN8Pdo/5pyQ7Sd4hfZt
         8xvlKnmuCuyWeE1XiqkaBsIgFlSB0tULqNNG/XwTxyv5aL/m95MjsfeoyLta/NR6azq6
         71qL5/BN/1DiYMBtuGkHMP08c0fQLE3Y/E9LOqUcTivhIqgMIuwNypDLJR5lPrb91rhs
         qk3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/d4qTL2RvboctpBr71lMSw7wkudERkhFmhn60vwZ5qh5M6+wKfReSWTzhw5F/3bBS7XFvEjY5cgZMPXt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnzlgXEz7O3DtskD6YohppJwbcMJpqgqfBLYV1SbaN7stM0UC5
	KlFbje/37fVdPtG4CvTvyvk+nFulLTKmxOPnBe5BCNej4ArOK5LKmLz/7ya7twrVGsDat5ewxIT
	6cYYPmxvK5VK4D9gNlrCGNBmyl6HEPsE=
X-Gm-Gg: Acq92OGNnZDsQuh6QwL5+LabewefoSVJBUQa90yBqGZ/mwHwNjkE5ZSRszpHtY2zler
	QTzTE2Yntq4xs95Kv6iimU8xzu00NwfbBv45Tf3kEVLy2A4WOf0zgFFFFHH/bJJgY8jN1h7LZYJ
	W/U25im/pGq+/mtA/1mjV4iyHp9du3hcixLAQwNaf+uhq7HQodkNN5wDnKpKWgs1xqyqwRsqj0J
	qRVaZS9+ESVv0jQUaepj4B5sOHIJVwv2U415k7PeyKbhdcIaedEUQzdvuVHykCfw/Q/10wEQwGM
	8QvMPMa5Q68HjSzeb5zEILoGaAiZ7cTDIr5StxkYJRY8NG4ZvCIPMSPc4qgeEeTv01mbvq9vpjF
	DW0A=
X-Received: by 2002:a05:6102:8028:b0:659:3ae:e6d1 with SMTP id
 ada2fe7eead31-6fef194813cmr8586356137.9.1780938843197; Mon, 08 Jun 2026
 10:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510052107.555825-1-enelsonmoore@gmail.com>
 <aibz3auoiq4CFa9l@google.com> <86765df4-0d2d-435e-85d8-b9bd4f3ea85d@app.fastmail.com>
In-Reply-To: <86765df4-0d2d-435e-85d8-b9bd4f3ea85d@app.fastmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 8 Jun 2026 10:13:50 -0700
X-Gm-Features: AVVi8CcQLZdfGK7GkL8AIz2ceIWRoj45ZqGYOIPBttfj7m0Xg4lz5ZY8Y9K80rk
Message-ID: <CADkSEUhh1NdOMTHVsErhqzyCpDGFA-FkNFaWp94e9LnB3njxqw@mail.gmail.com>
Subject: Re: [PATCH] ARM: footbridge: convert to sparse IRQs
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Arnd,

On Mon, Jun 8, 2026 at 10:11=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
> I think this is correct, as footbridge is the only one that selects
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO and defines I8042_KBD_IRQ on arm.

I came to the same conclusion.

Ethan
