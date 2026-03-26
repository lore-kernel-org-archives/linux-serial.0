Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B33FE64F
	for <linux-serial@vger.kernel.org>; Thu, 26 Mar 2026 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536565; cv=none; b=EhclWKvq0PKr4rA0eFQXbiSY+UDGffJLCO9CLHpKC5P4o4AjgxyUOavL6lhkWjA0WI5bwg1r4p8cCevSyg3HxwZU8lbAo5ufbdoA4U3wtBTZ75N5vyhOxvE8sYRWmD96KsF1Qtb2dm+W4fuh6w6CywEK6Y7ukQMY5OwZjDZeVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536565; c=relaxed/simple;
	bh=LAjDDjYLxBGBKYW9On9dS5WSAEqjQOfiLvmLec0y5VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnKaimiLEbE52dueVRKNat1+ihgzPVTa8VvracN+sCqXrB5dOAGQCQibeJx5/VziwEIOY7a+h+mC19BA0dEyXV2+UnRoan957DJTRkHSHqpSQQMS/5Ppv3PmCqwB9U+sKkHud2C7b8DmILlnPawnmipnvZJB2EAlMMJZu7sPJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6686697f578so1715522a12.0
        for <linux-serial@vger.kernel.org>; Thu, 26 Mar 2026 07:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774536562; x=1775141362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SfvDUd4xZdosPMkUZ31iKqQ7IrFxYHt5vMpaGx7N+g=;
        b=je6JI1he2/jLItUy6s0gbxAiEqP6fupSPMY0dNuuRrZAK3DwJFvXSPJiFd8SEnb6d9
         W//O45DeMN55fZ4Tj+63uDngcDAZid8UJCSDBInEMrifYMD/8cyG5bZpQdqJQiTq1tTD
         yDgpfWWb0dqSoosU2fKIF99x5fOV8gFQYOaEIU/X7ZD5gKA4jR4u4uPXH1w5ZudYTV6p
         TXCg9sVUJnoKSmjK8IkwrxIHVSIB6nDA/kV2CfX9AEzSDfjMBO+s47fm4GeV1JvaHEbc
         LIHBoDrIGAaTq6pXCa1HJf1G4j8845fm3XFT5SyHPmu1JvpEGThjF67i2cQB7j9POWrs
         LjJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx9ktrg3EqOWr7lVeUjSe8qqWzUhcERkAFLhaC2df8sCK+UhqoYaVkBHXjjmmhXUAfFnKOTDp4zk2TOC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxahRpibXI1HhMztYfR2WfCH3SZamy3YQwoVIE9R4u31Mu/q/wD
	TQh/fFs4SFn80jMsH1MWeTRvJo0LkuFEc+OVbrNJPyxNVDWBwEI5DRC79HlKaK0TeqI=
X-Gm-Gg: ATEYQzzKAsylAqGzs5KSRXQXAiXLkHmz2S/zyfysEcrrRLrz5LTcn/CB+EPjMFPbIbD
	L6zjMPDvdqvKfX6BQnPbM5UaoYLVobsQOI0zSOe2tR5sapFvkLdeeSR5Mt2UJdgICL6d7oKsu/W
	LCITU6geSTti8bBCy4giQ0dsjKQ2ajsdp/tZlxOW9IiXK72SPo4Ev+nhK1WI4jNnxLoR2CHEZTw
	99yfA3doGe89N/P4vCIJ+9TDys8CZtYcqcxdYbe8szflFtS0TyHmpFc0keoUkp5hviHYGdfUeXi
	YGTQc/OL6/JvEinjGuifVhxro+Kgg0T+3L0WU1jHnFVc9FtNA7pLMImC2SbJhwRCpXGGZlHlIDe
	XGcbUGU2BmyfWD7jcokReniSLJjYKpYNwJmEpsiU1IpeVbzVxlobsJhySGzR2z7jvtTZfhTKzt4
	CyppzjppOxhxWG5Ll/Gs1f0nzoaV+O8fjZnfZln2+Eehwu4ow150VRwCLSiP+x
X-Received: by 2002:a17:907:1b1f:b0:b98:8fa0:a1ec with SMTP id a640c23a62f3a-b9a542af9ddmr531940866b.54.1774536562320;
        Thu, 26 Mar 2026 07:49:22 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b203ef910sm128948166b.53.2026.03.26.07.49.21
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 07:49:21 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6686697f578so1715372a12.0
        for <linux-serial@vger.kernel.org>; Thu, 26 Mar 2026 07:49:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYz4epYx2ZJLh11IJsmun455EFoLyeH/2DEoT4Xlljz8/mOQZk0knc+Dbsuhiv7jsrq1V4PwupAVRq0ZI=@vger.kernel.org
X-Received: by 2002:a17:907:7a89:b0:b98:3ffc:1c39 with SMTP id
 a640c23a62f3a-b9a542bc0ffmr559718266b.56.1774536561331; Thu, 26 Mar 2026
 07:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312082708.98835-1-biju.das.jz@bp.renesas.com> <20260312082708.98835-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260312082708.98835-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Mar 2026 15:49:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXdxOFoHUqf_fNcj=4A9+EhXAKk2LgjYQGcpY4_-=TOVA@mail.gmail.com>
X-Gm-Features: AQROBzCb1QcDxR_6QXsUfkI4LmWBih6e7SaYIqht2U4adElNYYtE0VKLraUtMyQ
Message-ID: <CAMuHMdXdxOFoHUqf_fNcj=4A9+EhXAKk2LgjYQGcpY4_-=TOVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: sh-sci: Add support for RZ/G3L RSCI
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Mar 2026 at 09:27, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add support for RZ/G3L RSCI. The RSCI IP found on the RZ/G3L SoC is
> similar to RZ/G3E, but it has 3 clocks (2 module clocks + 1 external
> clock) instead of 6 clocks (5 module clocks + 1 external clock) on the
> RZ/G3E. Both RZ/G3L and RZ/G3E have a 32-bit FIFO, but RZ/G3L has a
> single TCLK with internal dividers, whereas the RZ/G3E has explicit
> clocks for TCLK and its dividers. Add a new port type
> RSCI_PORT_SCIF32_SINGLE_TCLK to handle this clock difference.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
