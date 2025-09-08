Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6813A29A309;
	Mon,  8 Sep 2025 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326058; cv=none; b=n6iUjoUrdGPU3lfsqUe6KkhEXHkVFZrht0TKsXkfVFGonP6u/04DhZ/R5SNRUjIEEYtXds+Y48zcetH+epypeOKvy0U2bf1K+tPw0IoCheaD06FUWePqPhl4irHEpnTmM9P4RgF5lrlVu/fURur7WdPJ+T7BU9OFSAUhzLhnNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326058; c=relaxed/simple;
	bh=hZDQx+oaY1alvKhhCifEaFblb8FketN8vRtcuRulYI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9TkDi2EzstwRS3f/ZqpoizX94x2gYL+q7AErbTPWjpimpJScO/c4tjPmftFnqTGBfmpIdy2KO4rqk6ydyWGkulQaeskcC2qYSiBYEAOyaSm6oEBGvyA2+giRsVlvzhNvb6EjR4ouoJhUZdLR7JmCCj+IYolqHh/0b/Mx+594ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-890190c7912so954265241.2;
        Mon, 08 Sep 2025 03:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757326055; x=1757930855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsI2GAvj4+x78jlqCOLVXcSz741txA1wpOaZ/CN3KVc=;
        b=KpE4qv8wiRCshEzINB0RsTxmwUZMM0bkwjUNyeY2pqOsusZ85TOkbRjPWWQZbpm/Aj
         JDgZ/quWtB4X0w7UV72U6aTl0jZHgsIRhjQjdGSHvdBfdnnci02GDgHz9+lC1jnRekLH
         WZtHaZt5vlwAsKDPJMEcJZ1JBaOKAvdmrh1b06KfCHB8dGcZwI71/Ku+MZ+QPlRjyJtB
         ep6Y6ZkA1M6r90VvxRIsIHReJVukYgwivoWVqcpja9aUs+zYAogmjVFkeWchOueJZgp2
         rqiMRJr1cfG9rSW+oDKoAzf68xUOj3eI5UeRde3MiZjCpk0S/BQzAmD2l6NKvTEouISW
         0hwA==
X-Forwarded-Encrypted: i=1; AJvYcCUSK04DgIX7KrF2XHsJVKpGU5wN4/ZhLMS1aIR8Qku2Tr8wejOWp8sa0shPYhDcEPnyUrMlzYb+1N4KFywq@vger.kernel.org, AJvYcCUyDtCW4pTgBhrTOfoMcH9r6cuEN4LzxlNNQXucro8Urpz6Ss2n7IX4Yf6NkrF+TmEbvkivvYJooG4BtYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeqoksPqby1KTzY3ttlsQ1Y+GqV5Jg2PWwCN281gYvE/i605J2
	UqNWuQLHhobOIbu79YaOZqiMLE37X3eFUBOuQXogu1Wk4yUYM0v4cKnNoW+AJbHz
X-Gm-Gg: ASbGnctJcMb/Dz/oTGfc/Dkr+ggXp4CKE7sfXgZiw1weN9CFhX2f5LO6Re4z6qhCQPM
	xfWyQfXp7JdhESzJhdhg+4+r3E9Igi1m8aBNUHSGM13h0WghrWoxK7e/zhYSAm6+JDp4EZpddiy
	2Uh2eokz/wPtz4BqzTsOom4D9QcydzcHZGzPfKOCgG8KiBreOdx2rlLXvLlPitVxENUX2qoub/J
	DqO5GM37C9qr7hDcSFHwYgwXSYhsNBInwKKAEwMMJxDdYw3Vb+iJwdy+GvrPZp8op0whAAPD7hG
	Wn8RKsE+FSNJKqtC6UrN2cP8FJM8u3KIYPApKTDK6De7DIIHyiylRI1ExrMnK2ICSfu7i8PuNFo
	dJ1OkQRe6RgYa2lW7kMxeV0SukJuyyh/n9AJL/ga6B+sDSaigPW6m82hxp4pb
X-Google-Smtp-Source: AGHT+IHtML2h03UYcUp5wwODnfeRLLmjWxLgr/3qbOT6IoxlUhBCEyMo7hLDRSbXRYGLlUn2d7Kdkw==
X-Received: by 2002:a05:6102:80a8:b0:519:534a:6c31 with SMTP id ada2fe7eead31-53d15fdf4a7mr1542045137.31.1757326054817;
        Mon, 08 Sep 2025 03:07:34 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943bba6b6asm9808194241.19.2025.09.08.03.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 03:07:34 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-52a73cc9f97so1211964137.3;
        Mon, 08 Sep 2025 03:07:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIH2lm6ZZMRo9sAbEjDwOlfyyaXZ/9rFpjkae6Ezs/CiL1tjdtmYXf2mPkyPLm2n+1GSrCh414OdNrMvsb@vger.kernel.org, AJvYcCUeCqqydqXG0nwSe49t2QZ1wULPpV4up4Ba7/V+uji6owGPdBNy8WL1ZsiemmH6tNAbskooVNNrJ/jpHeQ=@vger.kernel.org
X-Received: by 2002:a05:6102:54a9:b0:521:760c:7aa8 with SMTP id
 ada2fe7eead31-53d14d8c892mr1786574137.27.1757326054252; Mon, 08 Sep 2025
 03:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757323858.git.geert@linux-m68k.org>
In-Reply-To: <cover.1757323858.git.geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Sep 2025 12:07:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXxT8kjdkEef1VeGEpJjQg249dNQOf_k4ZuZ2O4PJRELA@mail.gmail.com>
X-Gm-Features: AS18NWCSMWBsHIiOtA2g6I0sYdLIzfwc7QSwuWHE8Taxbo1FbOvJViPzbgqr2jI
Message-ID: <CAMuHMdXxT8kjdkEef1VeGEpJjQg249dNQOf_k4ZuZ2O4PJRELA@mail.gmail.com>
Subject: Re: [PATCH 0/2] tty: serial: 8250: Rework HP300 serial Kconfig logic
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Philip Blundell <philb@gnu.org>, Kars de Jong <jongk@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 11:45, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> The HP300 serial driver has a long-standing configuration issue: when
> SERIAL_8250 and HP300 are enabled, but none of HPDCA and HPAPCI is
> built-in:
>
>     drivers/tty/serial/8250/8250_hp300.c:24:2: warning: #warning CONFIG_SERIAL_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure? [-Wcpp]
>        24 | #warning CONFIG_SERIAL_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure?
>           |  ^~~~~~~
>
> This series fixes this by reworking the Kconfig logic to make invalid
> configurations impossible, after moving the HP300 serial suboptions to
> where they really belong.  It is meant as a replacement for "[PATCH]
> m68k: make HPDCA and HPAPCI bools" [1], and was compile-tested only.
>
> Anyone who can test this one real hardware?
> Probably we should add the following to hp300_defconfig:

Scrap it, this doesn't work for the modular case, due to the #ifdefs
in the driver, which should be converted to #if IS_REACHABLE()...

Sorry for the noise...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
