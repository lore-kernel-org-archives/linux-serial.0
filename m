Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BBE56A
	for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764522678; cv=none; b=LYZCp5EXs9VzXLVLyeGX3eccYemDShGOEtcX24BE9h3w4lVoKQNsSS2RezvOnQMosCl4xc4CA0HbNonq/X3ABc6RDAy2rj+mBJ1Wq72ctDx5rcLntahoGWOF9gXIElmvmE4D53NZUBQdofa6z11erwrTIn+IDdVOUo0XpWJ9IGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764522678; c=relaxed/simple;
	bh=I27iKvueJ409C6BJne5C1+CMWnKd9BVywBsI8XMqMBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCDZtjw/eEupv9GRx7toXEvhp+s0twN42zdwSDEscrBBJL2avn1r/zuezgOsS+P4J2+j89uyuThauh3iYWXDUL3o7jTS4E2ax+elkVyf7sxUZH8FUOPgT/3Rl2BxCAbhaKKrSKe4bqpE8cmJQLUHHnuIGom1fmxwRw8JER2ok04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYisG8AS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYisG8AS"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b73a9592fb8so880692066b.1
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 09:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764522675; x=1765127475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I27iKvueJ409C6BJne5C1+CMWnKd9BVywBsI8XMqMBI=;
        b=bYisG8AS/xyjuWUxhq7j5IHtlGSxE3qKwy/3KAwHL/ENJXWNhgrQeMgd9etIgn/uUO
         z57BD+iWkvoiGoWg4iQorsM9k9LsDqQWjD/j0SNU0fbgEBrm7uTQ3gh8c6iIbTzc1v7N
         WAmTyvjkRZbrFNP3M3Drax3aNruE3D4mDmJY3SynFzr1TutvHpL3DiF5vYj9DYzGgN8X
         oXi+ydi2rHX+aF/5B3qDi8HHxXdSIn1kPfWEfa83HE2HlawfhaSyJ+rNTlTJKyeR4JlS
         aL8AuoZZTWs1oH9PKX7dEmN71fKQfAyjOc7lfS8cf7/KeK2vWb95zETxzUvG4SOWe1pP
         A4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764522675; x=1765127475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I27iKvueJ409C6BJne5C1+CMWnKd9BVywBsI8XMqMBI=;
        b=reUUasdA7vQBSWpLdll6NfWKw5CLsLyBmiAsGTBToqp9FUOq/E/lusf2HkmHSB4+kG
         JBfcM1/TPqkffb5k68L/sm5H2RglA7FclDGXTd6qpZ3N3+tCnqPq5LCMjGOzStJwRRu9
         0TnyufZSrtvQJepz17NhxmraZ++u/g4YlQEihiq1E/33YRpJu0JXhQY9KUnaSSK9AfoL
         9hi8LJ+x3K9fxBz4ZsXBfzYnNtEIcTzEDlVSSJkdlDClMYwdEEvCNpkZTwb1EE3s25Mv
         qwxvAqHlIuRV8ndeUUwMKuGHM8K4vowmIEMoTncF6h0WslUPijJ7/A5rVsO98BYrnX9t
         S+2g==
X-Forwarded-Encrypted: i=1; AJvYcCWRVdt6agkAlnmX4n6VJacHx6+tE0llDagxM1s7vCZYYGgqxoLRp2ZthXF+MHgiqnC1F79huh6hhvjrZA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUK9boUOBCc4Q7GOvdyFOU/P408j404t+3uP58qFIKXNHU0Aj
	8PXJJpQ5UavfMjtUOFMBg7Ok10lE+8sThW75M4qK+P4fpGHwY+jpuRUNXSFURpWwkovrbNLBoPw
	RYH8kVK5XLUJf7R7HaSVIG0METw/cAiAYItdMv+E=
X-Gm-Gg: ASbGncstvH2VihMYX8+Rbm9YxdpJKGEpdVpU0SJsLk0lNU+XYdf7aLsHiKX8MdmZz7a
	W0CA1AgtWEAWs1AYM7wfqy375i010fYx9Fho+3DsnQ4kb2rcKgESgvBlBblPUo9broarn44JQpG
	r29x8Odq9uyn9r9FrLV5Gej0HwDx5tt6kss2YOFx2qRQoe2oe+GIReJmGKX2wi9ieZzX5jgkAtc
	vg5px+df9x+YjyWf06PuRRdJgkDpPT/Ddk8BlnPoeLZaUIkw1D8u7KfqpszhQPNsZ81Mi9Rjmrq
	cyrguZO5eVFaGGmlyigCX5Yvy+reU3L1urIw0J+nWxW0pBZQwS/o+ljoxYNHCRl24M5Xej1gYY0
	pfM4us0M=
X-Google-Smtp-Source: AGHT+IHY65zodCw3dS7pUbeQ1P4RKt0Quyliqkwh8RcafA9W/z+rFsx7yYcogPmbkz4r0cdcsrjTGcDZnVHOm/M0aEE=
X-Received: by 2002:a17:907:7246:b0:b3a:8070:e269 with SMTP id
 a640c23a62f3a-b766ef1d667mr4258264566b.14.1764522674737; Sun, 30 Nov 2025
 09:11:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-3-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-3-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 19:10:38 +0200
X-Gm-Features: AWmQ_bkB0KXcQ5igMAeualMQXNtSB7pZj70Al7phwDJl3WRTKO0Ohw-d4ooMWRQ
Message-ID: <CAHp75Vc6en+nJgBzHmPcgEaHSM-NcSas6X1iKTrxdV_rU+2+aQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/31] serial: 8250: add MU860 UART configuration
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:43=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> The MU860 UART does not fully conform to PORT_16650V2 or any other

What are the differences? This list should justify the need for the new typ=
e.

> standard UART configuration. This patch introduces a new UART type,

Imperative voice as suggested by Submitting Patch documentation.

> PORT_MU860, to accurately reflect the hardware characteristics of
> MU860-based devices.
>
> The new configuration is applied to Moxa UPCI serial boards to ensure
> correct initialization and operation.

--=20
With Best Regards,
Andy Shevchenko
