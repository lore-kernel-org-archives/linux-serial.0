Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A731292D5
	for <linux-serial@vger.kernel.org>; Thu,  9 May 2024 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292262; cv=none; b=i65gaS1ft+ZkYqKokouPvfa2iVCMlZWfIIg0kywdjpExSF4g1TN74nAg0jlaUa4sv88jTeJ5q510WDysW8KzmzgRyQBxC/EmMwhOF3Ki4VfGBvoSYXC1D/n9x0tRmUc7YQWW5W/D4e0M0ZAaaIrJjremRCh1gNr/8dlgor4vbTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292262; c=relaxed/simple;
	bh=OgJHhmIVrHJ1rqU9C9cLleVIC11QJQgCtRwBNIfc5aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYmeWL8kK9WVOR2ottUthdyjnIFjLT3ZXEc4hF7Amm6KZtdjmxyxckevPGqF0aDvI4OzlH0jlmlPf4Ko/C2qn+w8E3viMBCg/7uOqfOWyhchDwzQR3xltV4MN+kKwWPEc7pw4US3Yl7WaFcJ7hq7AxmIxMcDo/awBDzprpWnX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7MkVkAM; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7MkVkAM"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c989d4e84dso910383b6e.0
        for <linux-serial@vger.kernel.org>; Thu, 09 May 2024 15:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715292260; x=1715897060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaMGWwE54MRwQe9MKn89HK8vqNbPvDPLq1+qzXPGB6k=;
        b=i7MkVkAMBzPh/YgcMzJTj0BpTkhKa1M76CkeCG78rwjiARncOTqDqZeN0BjEQq9IGD
         4Fg4h66nw7oSekJh9EP5cg8rMzW1P+Ast8qIBhgvNAzfvPOgS4vMgHvq+UijhdL6UaFn
         hTsNpJ8+Pc/HQDCo0Dn/5EYm4+WdxPNsfeuxNxs33aIQaHi1CIyDISDI6kcwtWZSj6m4
         MZDzdLZK1m6ZtPupVUwIMDkEv4kk0z4GRJ3ZkKRLYum3EytByCr92AkP4T5ZqGr03HyC
         QkLu4CO9Oi080yDa+qq1YMICGGQZ+Bcf7PlOLkvW3nEIufZh6uZqwEwFeMXlwtPqO91u
         Y1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715292260; x=1715897060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaMGWwE54MRwQe9MKn89HK8vqNbPvDPLq1+qzXPGB6k=;
        b=KVqKM/ylcdeN9XqIpqpdRwr3khsGUmpI5x4gSLiZzSn5ZiJr6s2wjgfxWcz4yS8qy5
         J9frtJwueMlAlNbBZu1Q2/Mr3BoZaOyox0v9vR1fnC8aGGx6YkiY/+JStnxf5/GGO5m7
         VP+TfQ8hN1Z0Hs2sEqIpEJl31WTrkxMq5YodG6uSLhvPu6yuuJ/F0zpYnyQxItRTUYSA
         kjfbV7zyH8F+jtH3duy2IlV80shH3BX5F2jcAcsM1q0tSSIHx6O+dZYE63QYPznxwkkj
         dCgs88+RJCddsiT6E7DiNeM7lnhYT5jySfdtBFKB1lZlqB/Q10HdFfl8DKEMBYArxN/A
         /+cw==
X-Forwarded-Encrypted: i=1; AJvYcCUnwLuJobir8EkRdxJiu5ywNe01nf6JAQDmbPKVIDt4yfS0EaMnh4bN93fIR10i23SRky1Y/3O78JmfDs8B7+XtWpLmE6CWTjNt3U4C
X-Gm-Message-State: AOJu0YwNmFoRFtlPnC0Kj1D53f1rJUSHq4xQjOMCMy8WaoWf1PShqwAc
	71DdciQORvZIQgDUXpXsME2JHl1hG2xJ27U8HUpWq+NHb/pdRA34vYDihWEZm0D9eSzUicBuace
	R9c7kEFp43cPIhpbzWfmsJLha+QQiTzZgQ9nN
X-Google-Smtp-Source: AGHT+IGOrX7CymOEEesjDKbsfowT/rCu7eZVPPyV31UhJCy/YotrYfiCNXVJAu6ojtjG96eAKvVU1kdO7vspfPuqgL4=
X-Received: by 2002:a05:6808:1688:b0:3c7:41ba:102f with SMTP id
 5614622812f47-3c997074664mr1087661b6e.34.1715292259867; Thu, 09 May 2024
 15:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-b4-sio-scrollback-delta-v1-1-4164d162a2b8@google.com>
 <f7775510-09d8-41ef-97b2-0457e721a9ec@kernel.org> <CAFhGd8qkYYQZi37Tsj-V5pN5S4xhcyUeAZj1of2kTXG+EtVMgg@mail.gmail.com>
In-Reply-To: <CAFhGd8qkYYQZi37Tsj-V5pN5S4xhcyUeAZj1of2kTXG+EtVMgg@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 9 May 2024 15:04:07 -0700
Message-ID: <CAFhGd8oZy5aKjp-mVhh2d3U3tzTMzVRAfE039gvBACC0AdDNQw@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: saturate scrollback_delta to avoid overflow
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 3:01=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
>
> Agreed.
>
> Does an implementation like this look any better?
>
> static inline void scrolldelta(int lines)
> {
>         ...
>         /* saturate scrollback_delta so that it never wraps around */
>         if (lines > 0)
>                 scrollback_delta =3D min(scrollback_delta, INT_MAX -
> lines) + lines;
>         else
>                 scrollback_delta =3D max(scrollback_delta, INT_MIN -
> lines) + lines;
>         schedule_console_callback();
> }

I apologize for this formatting, gmail ate my tabs.

Note to self, do NOT copy/paste from vim to gmail's web client.

> Thanks
> Justin
