Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B027A133
	for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212255; cv=none; b=jvasVyOY3hUjcID/Ua+j9PBJOsegMEsK1xiewfwdiVzku7CFNhHWlCLxx7HLhfzEj8NVJv+MYo8k8IJna2W4Tf4+2sGm5/Q2BOkZd4KK7Hke9eLKGeMH1C3h9h3bGArf4r8BQFOXbNNFjodKknAyUVMtIHZ29iZ3R7NCuJkbNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212255; c=relaxed/simple;
	bh=YXvkTMs7FYKmlHlEt2ghltmTgCGigAmWrKGJBHcc/3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLIIWFkszh4sAR+um+3sFghxTydjz85o1kto/QjzCeKggyGDfO+NGUQBgiLj0iA56t+Zo9Z1Y0igjB84F4JoP4Lo9ZBW0fSN+S5IuqFZDSa4BZ45Kof093f2pj9MZhJqA8pgkJHTbscZmDnkWHgm/+83S2clFsGkfIgwhaX3bIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-93f5b804d4aso2486488241.3
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 02:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768212249; x=1768817049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwoWcN+m1SIHUAzNEwGgqH9kzErN7GEblJfgryNXZh0=;
        b=RM9ekkdi+VBfrVGBmBZofI+r+9dtIxi0r3WsNCmUHDBB/mGIEAgq/Enh4C4QWKHJMf
         jM/Wq56Vderqj8VkxuXwgiyjislITN/7+uYl74MLONeDONZwi2ouHo8wrfd1XYyPwx/V
         HoCkE736blFY8zWFatVuq0Uu9KXo6OnbDqqkQiZ2DaOjhn8oCHdsfvtsPipkguDAHXOk
         MOpcIh+nS7OLjgeczJI8ok27DT/BMHGfQMintUs8475gnvQlMn4RE/NqBropeItRLN1N
         O/j+Th32oqzmWuaZN6WF4+j6rSWZT15d79r/kEZ8wLFba/14zdn1NZnKxee9FeTnzII0
         4Jyg==
X-Forwarded-Encrypted: i=1; AJvYcCVLTwbZ79ZbuJgHjWpt8eUbBJmw8wMkJFP5qLPlO5YfQX9ewv81ML9LTLjwpJZ5u/XbU+uocjfDVjLvb1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dg4xQmYWFZRPES60tjIYbHrrdO5KFjkt2r+jKUz1TMzxTrbC
	PhGXGxyTKTNem7GR4wjPOc+Jkq2jKT3c/WZPMiM5ymd2ajtw0NulROh+DdUUKzQw
X-Gm-Gg: AY/fxX5b2ZS3oTAewVGHIYe3UbRU6D2W3hADdJmFZFTiGhXPh/2kMWFw6S4/qsj9s3M
	QRfrbAE0u6y58Zfy+ipRqOu7AJVbMydKBsK8HDZImlLaT84zAYCRgHZVjIVAs/sHOIFFi7u85xo
	xuLYHC0bv8DsQxexxZzc1c3BjanfBPVYSqVs4Z1HHRa0RfXatu7EXBYZDozU6G5uHv8KpkCbecA
	YaBsNXDAWTlTbHU5kqvrhrI9WvMUN532Jjn/H+9EYxwAgCDIV4SWwXH8uXcy6gHg+/pDE2nBfre
	6NIfiHtoXUlmK5zP+REXpUEK4sw4RVPsyvKBvlqTJHhTrE62OVZVs5AjJftdmEhFbXArzWWsZ8c
	S9lbiss0pSPBfm3h163DUfd2pTJ8KKyxcGsdFEfurvZUSRkitUxnBNy10Q+of5KlnbzfEV9iaRF
	M+euZ+MCXVQPu/wyZg0AoSkOo8dY9NQuc1VK4s8MMzuP1yVa3E
X-Google-Smtp-Source: AGHT+IEhjuUy6tlLJdJY2riX3/Sd8KWYIUULf5Twhjm6gc5TLNE7SpHab+kAe/1wBZZSpge8xQ176g==
X-Received: by 2002:a05:6102:419e:b0:5dd:b288:61af with SMTP id ada2fe7eead31-5ecb062436cmr5396388137.0.1768212249167;
        Mon, 12 Jan 2026 02:04:09 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1578d3887sm1680504137.14.2026.01.12.02.04.08
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 02:04:08 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93f5b804d4aso2486480241.3
        for <linux-serial@vger.kernel.org>; Mon, 12 Jan 2026 02:04:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzdLgONWwiQPCQTNM15mQz1yR76k4SZjvQ1N/CYtUthTfjWuhB5k58Km/P/PQbK2vZAdj27T9nN9UsfXI=@vger.kernel.org
X-Received: by 2002:a05:6102:3908:b0:5ee:a6f8:f925 with SMTP id
 ada2fe7eead31-5eea6f90e16mr4318994137.8.1768212248622; Mon, 12 Jan 2026
 02:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110232643.3533351-1-rdunlap@infradead.org> <20260110232643.3533351-5-rdunlap@infradead.org>
In-Reply-To: <20260110232643.3533351-5-rdunlap@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Jan 2026 11:03:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUdXFw0Jc3TLfWoA5xh+=Sf__1=X1_JC=zxc4UE5D1tOQ@mail.gmail.com>
X-Gm-Features: AZwV_Qg-gwZstuUatoNabIDPEYVx2yDEpsKDt7mLTfttF28LQN7nuQ2NTMnM5fY
Message-ID: <CAMuHMdUdXFw0Jc3TLfWoA5xh+=Sf__1=X1_JC=zxc4UE5D1tOQ@mail.gmail.com>
Subject: Re: [PATCH 4/4 v2] serial: SH_SCI: improve "DMA support" prompt
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 Jan 2026 at 00:26, Randy Dunlap <rdunlap@infradead.org> wrote:
> Having a prompt of "DMA support" suddenly appear during a
> "make oldconfig" can be confusing. Add a little helpful text to
> the prompt message.
>
> Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: make the prompt more like the other SH_SCI prompts (Geert)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
