Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45642298C1C
	for <linux-serial@vger.kernel.org>; Fri, 23 May 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024565; cv=none; b=mmhnoBJYaDKDxCc7tNaHZWoIxhM9CuyxLHbr6YsJThLDJHZtkdd+2iwzbfDgaV2Cz+orDpgA5tSGuusuBLoECPy1j/VYVjg3EFhxv/rlhdyoSRh/e21oRRiNZAHweTLGVe/zMADvHh9PEr8/sN8+WePNc7aEgPt8FIq1GdCbvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024565; c=relaxed/simple;
	bh=s/6eqYOTLrxmW0LGX7eGemIDLzBddKua1DF2bww+zAo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=anLkKWUt/XhHSjFYlOP5cWz71xMMZoyQXIiWgccMdWpT3Ff2oZvjIdWgUQr9Qs6+6w/7kqbQiRC14Ds/RLEgDksCDwk82jxnBvZxZZmdvc/nf1wCxN7ArEZRjT6NeiuVDQmr7OuV5V8DrNTk3GSCk3/jw9HD9oXovhnv5BCo4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1M3Gq0sB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1M3Gq0sB"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fa9dced621so220286d6.1
        for <linux-serial@vger.kernel.org>; Fri, 23 May 2025 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748024562; x=1748629362; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BClPbehAu6JBgNUB0ZQty6Cn+WSxNViJiPjUPJj/yCw=;
        b=1M3Gq0sBFkRYElwIstMMRFgXHLwAT7q0n0q6HybokgkH4buOU9ce3/qUMheQIiddgE
         wxpBPFsnsTSg/xTpG01JsO6ED44qToFo1AjBnYHrP/IrLhuNuaovvgi3nlxKjjX964LQ
         ZAw/NLGgXPW4WyA+bOOjOv3Mk/0Jzy4GiBKxhaGdWUOKl3Gf1/v7qv19yeaDRvRDnfif
         KZOKe+Z/GAF8lwTFOZFtZ23RFyZYK59/Wwm6idyvXIwKpoh96XMNDuaD2AtBpuWvatoG
         GPdUcDc7Lrcof2osxKHPTJSe48StG/ubpOcMjYdBNYR+tB7rjdQZOaYOb/ByYLXkdRGQ
         TojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748024562; x=1748629362;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BClPbehAu6JBgNUB0ZQty6Cn+WSxNViJiPjUPJj/yCw=;
        b=s5tARnf1Rc5iwPzQpfDaWX7HLwE3nNpiyvO/G5VFI1ca0xJDXzf+7gvF8imXzFCK50
         fWDxfhsZpIkVD0ujLmIcGHf2nM6nhoMjqKWzDFt9OA3VMOeNxexdVwhPnq4s6EKsMIj3
         aoNLjjT1Fq3uc3xG2oa1TQROB5INYyH81hqF90jSxbEkuUwqI6woqjjKgaTw8FKCVwtw
         GxuWVKiJxF9N3EaHM6XwEL+J9FC6cbNY7npnpaRAdKRg41XsHPBfcKaTDtTjserE1uTn
         B29CGe1LInKHzXpIaEPU/3tbXY8GQjxGxfel2tAWaqy8jp3Zfe8tGWJKrG38ZYZ4oKnY
         Nzyg==
X-Gm-Message-State: AOJu0YzDFlO4JIUCn9EIADJNoHjQnd7Ufrtrox+B2kPduYMvIPXgBcVw
	MojTXC4rDrOddmPIZfUM9ydhRh5x1uHx4ioK79ge7cIwhGJe25Q+66PVzuK9mdiE+O0=
X-Gm-Gg: ASbGncvoYdkOYiuOs2QewEhoTx+MzFTnLrV0HmAnO9v67TqgJA1jEyDVoH32ClhJNoD
	F8vc0nyfvPB7TXqlFCwWI7oh87P1Hwp/csf+cPgbGt7rxFBQ5dqk7attVhG6WermlMXO089BVqM
	n9ZfSqAY4Tho+y+cDOamKMjvZz6dnQQdgsSO0DFDTUATvUz+nMT1VwxiAvWoPzw3Dw9BnrWitJI
	sXlwtUAN2MylN1pJEL88Vu8BmjcGk232l436gBlnpuhcb++VTVZgSM1cruKGiyWc0ISxYape+G4
	o1V+gHwS5/U7W0IDhI20nv6OSUl1R622ia//0n1a64UYFKEiR1B/xDKDkJcFqzNYzw3uF/BeMSL
	rTcUIOdXOJZuBlQ==
X-Google-Smtp-Source: AGHT+IHtcqZzqfWbk5o/UzOJDRxNNio2Z/lxjmpT3kSO+7xSuTcmZ2FTV0xn5lzDCf4Hua7Q5fv9Ug==
X-Received: by 2002:ad4:5dc4:0:b0:6f5:1192:ccdf with SMTP id 6a1803df08f44-6fa9d139408mr6440336d6.6.1748024562089;
        Fri, 23 May 2025 11:22:42 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b0898f66sm118824496d6.27.2025.05.23.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:22:41 -0700 (PDT)
Date: Fri, 23 May 2025 14:22:40 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: remove redundant condition from redraw_screen()
In-Reply-To: <n58o097s-s20p-4222-nqo5-2qp26843rs35@onlyvoer.pbz>
Message-ID: <srp75229-623q-q31s-79op-076nqs4so36q@onlyvoer.pbz>
References: <n58o097s-s20p-4222-nqo5-2qp26843rs35@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 May 2025, Nicolas Pitre wrote:

> Given !con_is_visible(vc) is the equivalent of *vc->vc_display_fg != vc
> we have:
> 
> 	struct vc_data *old_vc = vc_cons[fg_console].d;
> 	if (old_vc == vc)
> 		return;
> 	*vc->vc_display_fg = vc;
> 	if (*vc->vc_display_fg != old_vc) /* !con_is_visible(old_vc) */
> 		...

Please disregard this patch. Obviously the last if substitution should
rather be:

        if (*old_vcvc->vc_display_fg != old_vc)

and there is no guarantee that vc->vc_display_fg and
old_vc->vc_display_fg have the same value.


Nicolas
