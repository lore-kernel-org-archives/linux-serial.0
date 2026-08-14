Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F453E121A
	for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786701176; cv=none; b=Hd0evBFaWiQS5qToGTRcHudpboeTLQ6qUQunpktlt8DnAubaWIMa3fwZSb0V8bXOdKdj7OjVF/njcqngAHaC6G3KcLVNwIHnad4bSmRl/ob4LqSaLyyu7jiXz4wMnEo1X38EtQoeUM6ObC8+RDCvHKMaAhL1wGH73VHQmzuyn3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786701176; c=relaxed/simple;
	bh=3mVO8pcErMDdU9nZ+haG1q6ZJQC+KACbsUDCyxczTvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYTwH7XKwvzRSVOQdgC1QYDvlNjgmAum9CnZbSBQeG5/wTBAGg7EMrqR0ele3+oMLjIrcC4kErNGljzsrZCpaiDJChP1UZDjk8bVMTpBGCaY0QDGg5LEbHZjdL8OqYyXzEI0y/4lZgg6kwQwBdlMAa9ZrEmkrWfzQXEu+xjYcFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c276bd3692so584897e0c.3
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 02:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786701164; x=1787305964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XM7XWlPcxbEFiiraoviRaIfJM7vTkfTh9svHIGFIg5k=;
        b=ADCAxLOSqitP+lHwvOWKl8AnZaHdKpYXns9XjJc/ohBHfteI0aNM9fB+hklMBVxome
         7tt3eBxUBWGbpmTfGQ/LFn0C9kIuwhHIGhHlItis0+uQJQZPndysf8rQxSZLNwSoJyDC
         Kv5TeioEvDQBZXEMvFIX9PpXNSnkPcieEMTFzn0JUNVulAKxV5jUiQXv07oqFT2GojI2
         yYwXnLt92j+orIXLGbF/VT1JCew9x6qH47/TrJCL+uNDvilZIu+LX1j3qoayUDMt6WV7
         jYFsvxIJHcVqbIU3f1D0i5RrC++E21fSMQV0X6D3BibVZhbKxyxfullqf3mni+BuU8zJ
         Xc5A==
X-Forwarded-Encrypted: i=1; AHgh+RrHqshksfTLQK7J++wDWW1FAwSB95Nn9KP8yc2mbVp0uN63sqkG6xg6jKuMwqUEKoTWnwP55+x/VtjCUSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6NGFOzxr1TbFZcMTaxyi2nTqX5mbc5i71y99dKtQinh9mwh2S
	7pbDk1tZ76Gr0noLNyQrzU04pg0CjHQV5YC23I4DrsOukAynBxUbxyvY/W6R5Ey3yRg=
X-Gm-Gg: AR+sD10ForDIDbPzOWbOV71ZPjd0NXRUA/xDfpW04h3ZxEnwR2vtnlXUHlxEJWldf0V
	+Bn6Cg5cknRU5ZUeBMeNGcfizu452jzMI9JYGtk4ykv4TUdh1tlZtGlwVkW3J+Et5B1yPfWN7kU
	Yw1zHm6wmzgACbLg/huDZQEtoITkPBQll6KgiQ/1LCe/ButivL5LZ7ZdkaL1T52KOc+Nm6MlACn
	+1Hs2/U1bA3KOWil4aHjLSpe7f/VO87eO0Z5KG/m2dVDoXUhv+wQiq18uMmg7XaznY98VxaeqF4
	yZ2xfuN8pZ4O+9dvtfOVpfVSm6u8oXMahygPC9m+WPk1DWYVO09w43TTX9HjI5LPGtJ2T1HyQUv
	nIyLdOvpnIOJnxmp6Yk6B+LCGN0bz2YbFuuZUr2icVeT56NdM8vkcbH36MvCug8Nx8j7+581+mC
	aAcZ1/sOzcxQfk3EfMkN8dEflBVGdePwAk0NqFnr0LBw78o9IL+7bA9crWNt8V5s8fld2hdt4el
	af6cODfFBKigk1mTo+uLYpYlw==
X-Received: by 2002:a05:6122:6c15:b0:5c5:a01f:aeff with SMTP id 71dfb90a1353d-5c5a01fdb13mr163986e0c.9.1786701164393;
        Fri, 14 Aug 2026 02:52:44 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c59423c378sm653078e0c.0.2026.08.14.02.52.44
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 02:52:44 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-97bf91c815bso344098241.3
        for <linux-serial@vger.kernel.org>; Fri, 14 Aug 2026 02:52:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpO6/S4Wdm9ovDJK1+CPAerGBKladYtYNpDTELS6o5u0sY1B6wFSuk9r6e+FbQKOUB2uCPBl4ZTMw1Fbwc=@vger.kernel.org
X-Received: by 2002:a05:6102:14aa:b0:752:757a:96f0 with SMTP id
 ada2fe7eead31-76f2a7ee34fmr1046449137.3.1786701163822; Fri, 14 Aug 2026
 02:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786697789.git.u.kleine-koenig@baylibre.com> <b9287ba4b13b32a11765c0532db5d34843227373.1786697789.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <b9287ba4b13b32a11765c0532db5d34843227373.1786697789.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Aug 2026 11:52:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUyBL-HZbeG_8z9vouZj+exPVyWr-S_7hiTbp3WqsGtzw@mail.gmail.com>
X-Gm-Features: AcwNN1VpPoKg3lIXMnuWrnSSd7c5Hbn3ziz0l2xJghxVVWN4XhDgvXMXlaldS8Y
Message-ID: <CAMuHMdUyBL-HZbeG_8z9vouZj+exPVyWr-S_7hiTbp3WqsGtzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] serial: txx9: Drop usage of uart_match_port()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, 
	John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Aug 2026 at 11:19, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Where the uart_match_port() function is used it's known that .iotype is
> UPIO_PORT. So uart_match_port() is equivalent to comparing .iobase.
> Remove the call to uart_match_port() which then only has a single caller
> that is handled in the next commit.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I don't have the TC86C001FG PCI device (which is presumable present
on the GOKU-S sub-board), so I cannot test this code path.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
