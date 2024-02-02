Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43B1DFEF
	for <linux-serial@vger.kernel.org>; Fri,  2 Feb 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885699; cv=none; b=CqoNmS0fZT0McReXV4si7EUo1/p9R5nnBEL4fQlPC3F1a7lDIEjyFl9XWCgV9UqOfBi7EV3axB3ZF4oop3FwsA+chgYtjp4fJftJ4igVPoy+U0Fpf/coVS7u9ve/9t1Zis7iBp+cZuMcLTQ8vwyprTiJFKHiWTU/3Gwiijdn0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885699; c=relaxed/simple;
	bh=MdKH193MLZ1uUjDMsLOJIGIGHHF/3sdAUXTepKp2jrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwbSzm4+LuiFd+lXLrwlPfpd6DFWbTWthXbIVw7BBm+Vmrh28AbYMFPmykYbbXKOoCnXD31YHda1tnZULDsOuazlu/HhPnTVNXpFk/K3licRQd6YLhwgAwaiIDTG4+0ZBN/A0YXRHLJghSAcNcfgsB9XMHNYkp/WsLNV7ki655U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wQr4qiWa; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQr4qiWa"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1355928a12.0
        for <linux-serial@vger.kernel.org>; Fri, 02 Feb 2024 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706885698; x=1707490498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgZY6y3hYltlhybXLFHX3JY6qUiQxBKoDPMqI4ObTdA=;
        b=wQr4qiWallvd3zrm7rcwpIQxb8RSXItV0c1xtQi8an2TrF6mPXfuaREooXpcTpigtJ
         /J97f6b65dR7gf5Zqlg0n1yEy7qFwSBznIhJKdgxNdLX6Fcue/sxxiZOmXdnxZTNjwOR
         aHl8tzjbAJVVGaDe/hDYsZAtT02/99VxV1Tp0DaMh7xy5QuJjf9cTNT/BAxPLc1CaShM
         TSNbk3LZUMeHzUt0IqZOZX7Y6QTwD3fMw12a87VF4A8nYKtsQweeP6VMm02+ty2IkOZY
         IiLC2hMGkEOK+W8abTnQjlFAm+yEzYJDQjTs2mbfkZrLhVbQ9M4PkEYF2ZbMuqqNqwlu
         d3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885698; x=1707490498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgZY6y3hYltlhybXLFHX3JY6qUiQxBKoDPMqI4ObTdA=;
        b=L3lc1VnS7shQhkOEhPPEGNKFb1fpyGvpDb3/JTtaMfT/i8jaL30amxv+sP/OatAMOt
         SQif8AwcF0IOujWFtnrtO5PF+Ck1Swv568EPW9R5zcxzjHwoYxiMcy6zczwofbgdad67
         67VP6HmUbwGdatKmND3wMZGwX9QxzjrH0kV8+gky6lYVIBAOOLCSzMg4fPA/JlDp0Ocu
         cBn35YWQ15fxJbA+KL7OGiyTiibLxcsdVWOa7kYk+YU7sJ2vkwPJ+s6g0j3cnJGQ137D
         fjAxa/rwDJnTee67mcMBW7KtjGF5YDVA2VgcJK4ppbmU1OOxyYoFm4acHrL6+q8J6vmU
         ViQg==
X-Gm-Message-State: AOJu0YxbuqcrKPvoLuP7V9Qzbzx4yblWF7yf7bhUnc+c9Kv1aO4FF16A
	dKJVaVF6sUxzbn2FYAW7IEO4wKhDkPq3bQiMQk8KAMhXmhUKs4usnGnnjElZtmguhNpr78clIgS
	7BM3v1IDoMCZ5e4g2lzF6vvQrSZ2BoWoRuXnvdA==
X-Google-Smtp-Source: AGHT+IFFYDDuTFvmOwr9M8ASQb3hTgoGrlx9OXayKv245V/5FAXMHWqna8B3y+9sdEi69bzIL4D85SyxTGIfNpF0rJM=
X-Received: by 2002:aa7:984b:0:b0:6dd:c1b4:2643 with SMTP id
 n11-20020aa7984b000000b006ddc1b42643mr7914114pfq.28.1706885697829; Fri, 02
 Feb 2024 06:54:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202010507.22638-1-semen.protsenko@linaro.org> <bed3d775-2d80-445f-bf28-b28a17a6370c@linaro.org>
In-Reply-To: <bed3d775-2d80-445f-bf28-b28a17a6370c@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 2 Feb 2024 08:54:46 -0600
Message-ID: <CAPLW+4nPnPywwsjkeJE70GzyBL=smEo5_=0usGwmnaPRgZwdrQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: samsung: Remove superfluous braces in macro
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:49=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/02/2024 02:05, Sam Protsenko wrote:
> > Commit 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
> > removes parameters from EXYNOS_COMMON_SERIAL_DRV_DATA() macro, but
> > leaves unnecessary empty braces. Remove those to fix the style. No
> > functional change.
> >
> > Fixes: 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 8 ++++----
>
> I am pretty sure you did the patch on some old tree, not mainline rc1.
> Please work on maintainers tree (or linux-next).
>

Hi Krzysztof,

I worked on linux-next, and rebased it on top of the latest linux-next
yesterday, right before submitting. I distinctly remember solving a
conflict while rebasing, due to the new commit 0b87a9fd670a ("tty:
serial: samsung: set UPIO_MEM32 iotype for gs101") which just got into
linux-next yesterday. Please let me know if you want me to rebase it
on another tree and re-submit.

Thanks!

> Best regards,
> Krzysztof
>
