Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9213C8EE
	for <linux-serial@vger.kernel.org>; Wed, 17 Apr 2024 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352771; cv=none; b=LsyXvX/S9BLB5heCZNS5j+l5WdCrjUfBEQ1rOYk+ESFNaRs+BpSkhs3o1B1M+IioEkYyegxEAl5QpueIpv/TYkXedo1vReqlHsJXIc9C6cUAicNGHu5m9/nHnG4mSYNvL7hkTXBKK5VId/pHmoTyGb2uP8meS74sEJHxptPUR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352771; c=relaxed/simple;
	bh=nShAutHtuE37PrbMJ/3jcXGQkinGfTAuQNwXS5UlpzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHTMtx4BWDudP3baYfwBSSZqnWCFP6Lpc3d38cRf1/QypymgDsDVP3JSMMKY9VrFzB/NdAMt+/v4AtxDT1m9sMAeYbbd8FRWYsS3+TT3lS7R4TzaB0OmekvPT19T3CV0+TvdIVVnbHajw4zuxugFFOC0XMADpQHLBo8o4/nkEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z7z34YSP; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7z34YSP"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69b5a87505cso20086916d6.2
        for <linux-serial@vger.kernel.org>; Wed, 17 Apr 2024 04:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713352768; x=1713957568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nShAutHtuE37PrbMJ/3jcXGQkinGfTAuQNwXS5UlpzU=;
        b=z7z34YSPrpD8V4XxSZ9O5iyVYGJUJk5H9tHkF0p8lvxJeYg71VCT+P6bzC2gFmanp/
         JPgQU/PVdT08T9sYB6jp7COJfoc09m+kMkNW6UNBpkZULb8tx/9tH6AKSeqxgpL7wBWL
         cbDv8smolzN03+eJjepy3cub3MF2kop+HVCg2ogkiHknovUkCphMLbcsZxEgO+nYyBYa
         T6Hb0uKE1B5Lu23GRoWXo/ldJ60jkYVildqHWvOOqiyS5/P+PCuDWrkEDrUODGBugaiG
         ujX2auSNmgTag7MGR1BnY2Wsz06mX1JB1PiX3i4ZyK8ylxtenjmR8uyOnXYz6zNMlH0h
         XgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713352768; x=1713957568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nShAutHtuE37PrbMJ/3jcXGQkinGfTAuQNwXS5UlpzU=;
        b=QdEvCKTHCQ3QMEodqQplq931is3CIxATx3csqj7nrKWv9uRD/Rfw5yc053WJVaV1zC
         YIWmzxJN+NhpWSWVs+LFVPwAGFhdqRt8J7iDSiDdKhG1VCMtfCkGBVcYioE2ZA+pt8Ug
         hnc02cZrigI4yUojg/VsJsX3pYCe2VUjNU6YBVCWr9eq0m/BeQj843bpvUCkWlLG0aLi
         x3OnaxwRF5Q9yoDzCDYWl4K7lxs1TUvbBXISK7RyJeZN3NGlALikCkq/4rElmY1tXRyp
         hLK+d0w8ufilm4SBlYmtD173W1dexhngUiMeQdVgyoy7HNgyBU6AsjaEzHF+i+XV2wDZ
         NXqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiJz42zl0GgP8Ljz42WPLhGVZUXjzWLUNQbmOWTw8jiO4+FBZc7vpXOSKxiT4jnMduyGrrb1OI8+J4xL6i6dO+RfgtvKkampwdL+Nq
X-Gm-Message-State: AOJu0YwZ5ofBHyxh9boXVn6h9HDjCrNd3ytFiBFIwv1mVGRxAUj+AJWm
	RUbvdUaJcNdv42Ut3fOor6DzoyvUVdRYB9ruZY7Wjs21/KlCr4wOXKF4/SBPDg0ef2kEIriweU7
	4Am1AWHHWEXSMa1xJgHK0rGSvgC6556D0w0/ZAA==
X-Google-Smtp-Source: AGHT+IFR6bhoypxiwiBMPF6IZr+uTIkVIpmOnJDANxKEhpPmGSVL/We4VkZgS73RHfl6aXFF1JnugYKsEXaCY4mMUq8=
X-Received: by 2002:ad4:4514:0:b0:6a0:4d4c:2ee3 with SMTP id
 k20-20020ad44514000000b006a04d4c2ee3mr269913qvu.30.1713352767703; Wed, 17 Apr
 2024 04:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405060826.2521-1-jirislaby@kernel.org> <20240405060826.2521-13-jirislaby@kernel.org>
 <CGME20240415125847eucas1p2bc180c35f40f9c490c713679871af9ae@eucas1p2.samsung.com>
 <91ac609b-0fae-4856-a2a6-636908d7ad3c@samsung.com> <d70049d5-d0fe-465f-a558-45b6785f6014@kernel.org>
 <Zh-fgtujwjiSXz7D@monster> <c091da0b-a150-428a-bf96-75f9f3eab2e2@samsung.com>
In-Reply-To: <c091da0b-a150-428a-bf96-75f9f3eab2e2@samsung.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 17 Apr 2024 13:19:16 +0200
Message-ID: <CADYN=9LCJS0SW4PuF+e356HUxhzJYi093K6U+BdErPohq4RDWQ@mail.gmail.com>
Subject: Re: [PATCH 12/15] tty: serial: switch from circ_buf to kfifo
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org, 
	linux-amlogic@lists.infradead.org, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 12:20, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 17.04.2024 12:08, Anders Roxell wrote:
> > On 2024-04-15 15:28, Jiri Slaby wrote:
> >> On 15. 04. 24, 14:58, Marek Szyprowski wrote:
> >>> On 05.04.2024 08:08, Jiri Slaby (SUSE) wrote:
> >>>> Switch from struct circ_buf to proper kfifo. kfifo provides much better
> >>>> API, esp. when wrap-around of the buffer needs to be taken into account.
> >>>> Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for example.
> >>>>
> >>>> Kfifo API can also fill in scatter-gather DMA structures, so it easier
> >>>> for that use case too. Look at lpuart_dma_tx() for example. Note that
> >>>> not all drivers can be converted to that (like atmel_serial), they
> >>>> handle DMA specially.
> >>>>
> >>>> Note that usb-serial uses kfifo for TX for ages.
> >>>>
> >>>> omap needed a bit more care as it needs to put a char into FIFO to start
> >>>> the DMA transfer when OMAP_DMA_TX_KICK is set. In that case, we have to
> >>>> do kfifo_dma_out_prepare twice: once to find out the tx_size (to find
> >>>> out if it is worths to do DMA at all -- size >= 4), the second time for
> >>>> the actual transfer.
> >>>>
> >>>> All traces of circ_buf are removed from serial_core.h (and its struct
> >>>> uart_state).
> >>>>
> >>>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> >>>> ...
> >>> This patch landed in linux-next as commit 1788cf6a91d9 ("tty: serial:
> >>> switch from circ_buf to kfifo"). Unfortunately it breaks UART operation
> >>> on thr Amlogic Meson based boards (drivers/tty/serial/meson_uart.c
> >>> driver) and Qualcomm RB5 board (drivers/tty/serial/qcom_geni_serial.c).
> >>> Once the init process is started, a complete garbage is printed to the
> >>> serial console. Here is an example how it looks:
> >> Oh my!
> >>
> >> Both drivers move the tail using both kfifo and uart_xmit_advance()
> >> interfaces. Bah. Does it help to remove that uart_xmit_advance() for both of
> >> them? (TX stats will be broken.)
> >>
> >> Users of uart_port_tx() are not affected.
> >>
> >> This is my fault when merging uart_xmit_advance() with this series.
> >>
> > I'm trying to run on two dragonboard devices db410c and db845c and both
> > fails to boot see the boot failure from db845c [1], linux-next tag: next-20240415.
> > I tried to apply the patch [2] (that you proposed in this thread) ontop of next-20240415. However, that didn't
> > help bootlog on db845c [3].
>
> This is a different issue, which I've reported 2 days ago. See the
> following thread:
>
> https://lore.kernel.org/all/d3eb9f21-f3e1-43ec-bf41-984c6aa5cfc8@samsung.com/

Oh ok, I did the bisection on db845v, and that led me to this
patch 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")

Cheers,
Anders
