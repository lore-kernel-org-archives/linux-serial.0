Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87013E05B;
	Tue,  4 Jun 2024 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484914; cv=none; b=icNiAB0n5IunuM9U6qpilsfaKhpeLucxGoOFsP1pE0n1Z70TGR68jz6Wr3kXCnR3HmuSWSPAFy12H1x1RBiqa6BGbRPGYsEVRN6KTpb3i3ROjetdwhVCk8g108oMy6DqP9tSUKiKsJrVOT4TH1eq3bdkmdp+3wKRkXzu+6c5KZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484914; c=relaxed/simple;
	bh=8ylGpk81HGWaR4ucvdzGGtqUFC0eznPY76KdxBBdV1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfiKXMZUj7qkVu22Rb9yQFCSj/EfUOMpzEptVe5wNOBZcpyNIqkpyJneAAaaWGofp3zgjjbQ0UQKQdIcARFS+I/em2tA+ZvZ3QlTiceZhAlJBfUAdcuyuDPVYD3dZ6Yc4vX48YyrDahpUEfVxWKyDOMvf/XZqa7zw26qgX1fbQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a0849f5a8so51985217b3.2;
        Tue, 04 Jun 2024 00:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717484910; x=1718089710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5X6u+stsd+tfYvF8pXNh8WFecifUW8/FZJLC/QeGp5E=;
        b=sikoKhoWPQprunm/bwUCV7AWrg4NbWoOkuFdLUDgwwFNxCtHKeqMRUzQqAfvj7JWtM
         y/Mr+hS+C0qK3NWGxc5BwU0S0LpqULNVEy8kWFOpJFBdMBH81sPmErSMUbUaVot2Qg6U
         G+o4S8W+7gWRqUUXHT9QhCmVPBX40qBbohB0n06SarngJS/5biy0Wwj93XjTC5bgClYk
         oBy6668KogwwgMpD6o3MZo0trKfFKa+DY59DtdCVa3elpQLJEXFy+9eE1HPiGv4c57B0
         ulPaKZ5z0AEjwC8AmDvyflm1BhjS/sqllLttVD6hlDW+jquYqPEk6H7dEOms90ycAMUs
         2W0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+LePO3bJQ4cdnF7aH6AIFNdN1LcbyQ2Ei9RB+HmFo8pk+E3KXyadIF/mO7G0V1coMutEnQbsGEqUNBWDhLxylWHE1DFvCPme+d+HBrPPVNqgyw5w8HWNM9lK2awCURDrt1q+C4uG0IwWU
X-Gm-Message-State: AOJu0Yx7L2IwMuxWmgaWeLpCRDky9pNaGHc9/osBs7Zi1CWf1vp9RjBs
	9jFQsdEr2JMEwqZOs2Q5KUx5i9tjUi9bYSymUuEEbXa/3RP+/A3BjOyr0K88
X-Google-Smtp-Source: AGHT+IHG6sLq69djTYwVLvY55htVHu3eNTGjpRYkhVYuy4pYsqLwyYgGjZBFq/YBsPChN/UzB9QW0w==
X-Received: by 2002:a81:eb0d:0:b0:622:d6af:2555 with SMTP id 00721157ae682-62c796bf74dmr109287557b3.2.1717484909854;
        Tue, 04 Jun 2024 00:08:29 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c766b3286sm17570767b3.113.2024.06.04.00.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 00:08:29 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfa4876a5bbso4742434276.2;
        Tue, 04 Jun 2024 00:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfeK7Z7AucFMuzsgkA5xT/QayGXyJ9P7WBV+f1+2vD9lRVwUizqv7bD+fkcUr/EiP9OjkAXfJLOTjn/a39yXnQcbTyGVnkxLNelJR2/ox3UfYMFvYXJnD9vtfF1R39onNqpPZL/+fAY2jW
X-Received: by 2002:a25:242:0:b0:dfa:85e4:c8bc with SMTP id
 3f1490d57ef6-dfa85e4ccddmr7649646276.6.1717484909249; Tue, 04 Jun 2024
 00:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603152601.3689319-1-hugo@hugovil.com> <20240603152601.3689319-2-hugo@hugovil.com>
In-Reply-To: <20240603152601.3689319-2-hugo@hugovil.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Jun 2024 09:08:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWqTiAUp4Pxdo9bSP4Au7yKHq0v2BrCMXU1k7KbRnigBQ@mail.gmail.com>
Message-ID: <CAMuHMdWqTiAUp4Pxdo9bSP4Au7yKHq0v2BrCMXU1k7KbRnigBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: sc16is7xx: rename Kconfig CONFIG_SERIAL_SC16IS7XX_CORE
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 5:26=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Commit d49216438139
> ("serial: sc16is7xx: split into core and I2C/SPI parts (core)")
> renamed SERIAL_SC16IS7XX_CORE by SERIAL_SC16IS7XX. This means that some
> configs should have been updated when I submitted the original patch, but
> unfortunately they were not. Geert mentioned for example:
>     arch/mips/configs/cu1??0-neo_defconfig
>
> Rename SERIAL_SC16IS7XX to SERIAL_SC16IS7XX_CORE so that existing configs
> will still work correctly.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: d49216438139 ("serial: sc16is7xx: split into core and I2C/SPI part=
s (core)")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
