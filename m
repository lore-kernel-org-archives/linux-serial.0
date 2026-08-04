Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF53C2798
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853590; cv=none; b=jFzWOvdhYRye8rbMQXsPDK3hPCQDPWslw2Z2NZ+g1JomoMKVep7O/wIsxYJJ+D597lnf4/DwYMQTN6AcJ7AXNE02J2NNRD3pd+vvV+GwmIVc1IphW+5z0AnKpm6puz5rsRvWmgHtrmQLhDW9JQOmwuirjuW+GlXWd7F+kcCGJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853590; c=relaxed/simple;
	bh=xi5v7LADZ5lZjgD2F10vINb4GRK0rfnpR06o5Uod98M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERI4K0uCDhRYo+yP/YspDzncrTlbNlmBpqk51VTAOjX00T2xnwBq5G8rwemcO2c1AfrWsdICzuD0A5Fo7rA5nttgaZrXBw47ImGIxNxNGbeB1/JYnymaz+53Zi/DjLJxqSE2RD5mC9wzB1qJZqHrIohJP+XmEJ+OlVeajR7SovY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-74a9ac9cda6so2287427137.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 07:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785853574; x=1786458374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPXk0/edZya7gvnQtK3N3NvmUlbdY/8dXhP9gVxxmf8=;
        b=ancpOkdrF/VV5R4UqdXaeLMCkUZYlIDurbM7vaGtM0Br5VdWTaJCgb4rDpf0bEViOX
         JdnSx4/CuUDksRSzhIIjWktpatgb4bR+fEIf+fPy5YVakjltZFo0FwN/K12rAX51ol0G
         +M1XlmwId5mE5OSl4MvIN1/LFjuFhg/8n2YYgE2Qz66/Gg/fHFOK7ekpDlKXpjaluwL+
         n7EtM4VpNI8uQ9PNNb9yJd6sSkPM27V4dHWqhaaRbGoSm1B50wfDRhx1igq1KBZI3vvZ
         LfDC4S7y+vdVw7BToKIDehcsP74z8s/XnSWwvYGFeBn2pe1WXIrIPHSQ8IypCmeuIIq/
         bBQA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6+w/HNP/8KtDN/SFJc4nMDaWn1PMsa0X7FzIZ3VUSI7Dt8tTEtiBkM4jhwzHnUD+uQWcpImEmm+7BzkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dupVhTQcitQZ82RDOSzM5bw4UmDkqEtwkrrE9ZKNmfKCj1as
	S0fHx1dlVhfxrSOTwK1Woxhuc2DqnNfpwy6hg53o5SFOG+A+hnW1nU1LPjD7y7p3
X-Gm-Gg: AR+sD13Nej9jx6pHG9lnfC1LSH9j5PDXhtNAod2Ya/qakvU9jZFbz+yuLNn/WUsU19i
	trKkpH+79mh9TKQMdD9frd+vN182/vyfKRd3cOOs8CNOlQG/Iv0aRQb+F3kvVjoQuLcg3FiiSID
	7SA1oUkCSwNKaw/ZkCJMVtQOibUrsuXkO+VbiJBQ+msNdvSERQ2E93HcFU3vgzItyNK7SSYCL5p
	SjJPaJcyzGGE1GEVgl35Ti7AbVxVxzFfoRskjYtV6ddsWbEpIi+2IZKY+zw7+XL2FFAracrss0W
	bSAzyRVOzkpJihWGMYFeHG2iZNb8aPwx5b9t/ELeYegA3cxvdYpaAyC41DZdObssHwuysecL25P
	a73BIR6jF0jfRiWPwWSmhmwQhIZL0LGl5O4TMZaypYzTotOg2SiBSA04+MsBAapbuZqzRKCpKIP
	a38ZHdj+1yqC91pGqv9nC3O0V2Ilwr5UcPUC/JLrHRR4e8yOrhCIzWO58en9jjMv6V1/FCIlA5j
	FbWnt9CfsmCYNv9LbomBbQQ1LQJXItgaIri
X-Received: by 2002:a05:6102:94d:b0:74c:11b2:a944 with SMTP id ada2fe7eead31-75b2447389bmr9984513137.14.1785853573946;
        Tue, 04 Aug 2026 07:26:13 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9782c8e8724sm213711241.10.2026.08.04.07.26.12
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 07:26:13 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-966d70b9e1cso2628005241.2
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 07:26:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrTpdH2LMAdar298knMTT749lz0zLd49QTy9z3fZA8baSFe1jPfnW9XVzRqmZSLkkZ/Vt3teZZkJFubptI=@vger.kernel.org
X-Received: by 2002:a05:6102:fa8:b0:73e:9fae:5845 with SMTP id
 ada2fe7eead31-75b1e83a285mr10923817137.0.1785853571914; Tue, 04 Aug 2026
 07:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
 <2165469758f26f79c0267386bc6cd92379fb0e2c.1785832297.git.u.kleine-koenig@baylibre.com>
 <20260804.225236.1648692120067580029.anemo@mba.ocn.ne.jp>
In-Reply-To: <20260804.225236.1648692120067580029.anemo@mba.ocn.ne.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Aug 2026 16:26:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVySB4aDc4k6O8XZmsDpfY3ua+CqxqrDBPLV7jtWNcXyw@mail.gmail.com>
X-Gm-Features: AUfX_mySy6oat3lIq9zehgf8P9fuQfKACVSn7E98lg-55g1VQHNxdLr665ApRZU
Message-ID: <CAMuHMdVySB4aDc4k6O8XZmsDpfY3ua+CqxqrDBPLV7jtWNcXyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] serial: txx9: Drop noop probe function and
 dangerous remove callback
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: u.kleine-koenig@baylibre.com, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, hvilleneuve@dimonoff.com, john.ogness@linutronix.de, 
	alan@redhat.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2026 at 15:52, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Tue,  4 Aug 2026 10:57:53 +0200, Uwe Kleine-K=C3=B6nig (The Capable Hu=
b) <u.kleine-koenig@baylibre.com> wrote:
> > The only platform device that can be bound to the driver is allocated b=
y
> > the driver itself. That device doesn't have platdata, so the probe
> > function only consists of a loop that is never run and thus can be
> > dropped without loss of functionality.
>
> The noop loop might came from old 8250 driver I referenced at that time.
> Now I think it can be removed safely.
> Thank you for this cleanup.
>
> Reviewed-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

TX4927 actually has two serial ports:

    $ cat proc/iomem
    [...]
    fff1f0000-fff1fffff : TX4927
      [...]
      fff1ff300-fff1ff323 : serial_txx9
      fff1ff400-fff1ff423 : serial_txx9

At first sight, I don't see how these are registered, but it still works
after your patch, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
