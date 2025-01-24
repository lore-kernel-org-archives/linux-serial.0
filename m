Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE471DB146
	for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759355; cv=none; b=RWwmhgYTdBXYYSr4rg/eRPWjkC2yP70q70LEvYVnMNX+eDAPxPpdX9JIksygTS2ot64eJDW4+lweYWdC9gY3bj2+DpeKWvQZyzZMpesBj+q9ImUV0+4JTuYCa7kR2IavxtPEx3g9A+EpuxNGY5JavtyYU51CFYK9b0GD8agbiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759355; c=relaxed/simple;
	bh=kCyOKPx9Vs1i6LLFZaKNlUjqggHdygxNLEDk5y3a6RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2RXILGscxmJxqK4KcchUccy8dXZ+LP88/TEbM1kj/HbFBUDlJTt88wTDX8QOY1ss3clYystxRfmG97Bkk6LzgnIiie3jf5jSEi7ACxDlj7wu3ITCsTEwLtlikbTJ7WzJNdbGMtJfaF5/TQhPGP2L53XKOqL1hnjiPWCyqAfUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y1LFYlFI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y1LFYlFI"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53f22fd6832so2794372e87.1
        for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 14:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737759349; x=1738364149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDzAUQkLK+ll9FT+a7j+7HPNHM41+1WxQWQh7x0Fr48=;
        b=Y1LFYlFICUTwd+5L6pZJ9J5lQy8R8TiIvklFIpnDhq8ZZM9kczB1NhDPRbCwWpoxEG
         SsUK8utHY5oGMO8+sD3teugStBgG7+yfV6wn+1mzY3IqaftQDXBQX0JJdZy71V3VyKhX
         D1vlPFChJprXdbpTX4K07b287SrPlM+4M6/YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737759349; x=1738364149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDzAUQkLK+ll9FT+a7j+7HPNHM41+1WxQWQh7x0Fr48=;
        b=TO6c9WRhhMbthyb3o5wsVIDFR0DMUyWXxCySENChexKHnksTfGIcKuGv7S4REvJp9T
         hMA3VtyFTyzCkd+84S3cXzsKjTqQqKt8oGZObAIzd7B/WuvJrGBq2YX2MS+gOMHXinQP
         xkjLgqSh2YsvKPJaywr8sdaNCn5MvQN/8lYKv4ASvIhQjuQ+8vEMH0rQYEAhHQhnS++O
         SQdnxTpiEB2CgFDOqXD6EQTdf8EmRNiGnIpBZC3PEiSEkghduNi0wfX4MyDggQKy9pXR
         KmE/kJOl52e3R8dsHroS0aRvwbrshQKaD/ibZ1YIBQ/Ggot8nFzVsukVDSeRfAnFvMIp
         AJcw==
X-Forwarded-Encrypted: i=1; AJvYcCXb9oG8+DyRh0IC2sCP1fPCsKT0/B2jVW9eqwVrfd0/lpIOZmBb6SAt/AeIy3p47uGVlDtaS2iFW0bOvO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3RcQSoMut/x19iQHJIVvwcF57Rtk6PAmeXC18VOy03vp+8Ea
	wmt5wA3QxveOocIugE01/R6TOPb6HlOfWHQuWYOydTDTjmB2MbsM8hKh/gTw4gsaBoz5RuODP2M
	9yg==
X-Gm-Gg: ASbGncvhATjsWoUKFwQN4AiPHMPMWX9CIoj+7s9Uj+oxuUmU0nod85N64t8hLMizDC6
	vmf35Snv3gW6fKUMPVnw21N0GqytdbkjaoCy/WCObHlvLFcg29K5B5g7bXMcogqT722Wtmd7hf+
	9xaIlFTiccIHhUkafx7ul6C8duvUSnLZ6JrmATaKqaFxypTssEUC/PfJ8nl4YjeKA0FY68XmlC3
	f0FVFeuqjrb3PSfVzP9LjijusIVIVnILTK3e3m3ZAz3IGJz/6PG+jCgMFgehRKGJETGhJ31/5vl
	33Fs2T38M4nnEC+vL+pCGCkzv2cJrNd+dG/KBBIn00rE
X-Google-Smtp-Source: AGHT+IGgGw4atrKDSKBrYdErDkrOVrT0X9+SwMpz2gIvWq+79pwTd2xD74gJlRTd2uMtBqlyHIBkuw==
X-Received: by 2002:ac2:59c8:0:b0:541:1c5f:bf85 with SMTP id 2adb3069b0e04-5439c287510mr10441666e87.50.1737759348809;
        Fri, 24 Jan 2025 14:55:48 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c83683a5sm428159e87.154.2025.01.24.14.55.47
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 14:55:47 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53f22fd6832so2794331e87.1
        for <linux-serial@vger.kernel.org>; Fri, 24 Jan 2025 14:55:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEQD2Ba1BcyJCgMj80gfPH9AqmdkGgmlT/vwGcpMJ82QZTHG+CEJpxiFzATRoSXXyXv3mxcVxUwX/LnKg=@vger.kernel.org
X-Received: by 2002:ac2:4c24:0:b0:542:6507:9778 with SMTP id
 2adb3069b0e04-5439c22cb95mr8643147e87.11.1737759347161; Fri, 24 Jan 2025
 14:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113172936.1434532-1-tjarlama@gmail.com> <20250113172936.1434532-4-tjarlama@gmail.com>
In-Reply-To: <20250113172936.1434532-4-tjarlama@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Jan 2025 14:55:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UnGvwk7EVjDrqQdwUGX43Ep_BaLTbYy6SPNY26=QoLvg@mail.gmail.com>
X-Gm-Features: AWEUYZl5QQEDOJe9pjO5xpM1fvE182XEZ7q11PrSp6eM-M1_YsoDAPLI4evlW54
Message-ID: <CAD=FV=UnGvwk7EVjDrqQdwUGX43Ep_BaLTbYy6SPNY26=QoLvg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] serial: Move LF -> CRLF replacement from serial
 console to kdb
To: Amal Raj T <tjarlama@gmail.com>
Cc: danielt@kernel.org, jason.wessel@windriver.com, 
	stephen.s.brennan@oracle.com, amalrajt@meta.com, osandov@osandov.com, 
	linux-debuggers@vger.kernel.org, linux-serial@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 13, 2025 at 9:29=E2=80=AFAM Amal Raj T <tjarlama@gmail.com> wro=
te:
>
> From: Amal Raj T <amalrajt@meta.com>
>
> The current implementation of `poll_put_char` in the serial console drive=
r
> performs LF -> CRLF replacement, which can corrupt binary data. Since kdb
> is the only user of `poll_put_char`, this patch moves the LF -> CRLF
> replacement logic to kdb.
>
> Link: https://lore.kernel.org/linux-debuggers/Zy093jVKPs9gSVx2@telecaster=
/
> ---
>  drivers/tty/serial/serial_core.c | 2 --
>  kernel/debug/kdb/kdb_io.c        | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)

You seem to have dropped your Signed-off-by? It was there on V2 [1].
...and speaking of V2, I provided my Reviewed-by there. You should
have carried it forward since there are no differences in the code
between V2 and V3. I can give it again, but it would be nice not to
need to repeat when you send the V4.

Once you've added back your own Signed-off-by, you can also add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...also speaking of V2, I did ask if you could maybe add something to
the commit message pointing at the previous discussion. If you really
have a reason not to do this I won't insist, but it would be nice to
include it...

[1] https://lore.kernel.org/all/20241211153955.33518-3-tjarlama@gmail.com/
