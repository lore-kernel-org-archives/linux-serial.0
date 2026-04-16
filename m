Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB639B95C
	for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776332473; cv=pass; b=WAO/A4HgxyP9WqN/cxCGyFFSDGZEDOJ8yfhb9Z0Ol0X2RZVg5rX9lXoaNs/nrKYsEmIdR4dTb8hRLflg9iBjvOaHcTW/v3SCie1WJNV5pCSfFVwu9pFN6zfS05FTU3TY9yu2KzgMU6dzDd5n42Cpdpwrzgxdk4/yXJhak7nY22c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776332473; c=relaxed/simple;
	bh=cG4548azMUJidAQp6NjVAMNvQq4FIjgWTNc8tKDbEh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJBdyrQ/yl8VIr96+6D7ilpqbch/TfTConc2cD4je27iPgOOA7SAHoIIgT9BOhmrQkZpml4LXY2jhXTsMeYKqXADuMc350y+woUJNGGfMAMAUybZzgwTFZL2YWsSdv2vQg/m8O0VlOODaWacbqMZK8DzP7LhZ/Ro/9550VWZ/nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiF586on; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiF586on"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1350745066b.2
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2026 02:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776332470; cv=none;
        d=google.com; s=arc-20240605;
        b=iHQBYV6eD1YE+HStX3DZY5v30s+4lOrse5IPSYytEKnmGkeOopyNnWrlZalMY/wWJr
         +aO+gOHFHK1JNe6oqpwJyl0dGaUnpDgaXX0Wcw5Q2ZuSYcvD2tawzX/G6EKBhSHpp/Em
         bri4kVobiDIEDm2PLhv3ggGs+gIVLyQQKtGe/Yi8hbyFJa2lALUOrJMRs+XOdTk6+uBY
         ARVJR0VS9ABrDM6ueI2uW/Atk31CAct7+AY7VcoKyR8T8GSSNeSSQYs15ZnswfshHcp5
         JHZvVznUdpLoTRP+MwTOLRJZdO9nA9hrMLv8BjVlCi9SSeW+rNrhOXvW+5LnJBP/V5Sr
         8Ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cG4548azMUJidAQp6NjVAMNvQq4FIjgWTNc8tKDbEh0=;
        fh=g2recCASZ3cjfwl5EJZRP6bGBeMNHtxBTQfCQLEVRa4=;
        b=Am5aVHyP0b6/lKIEuLebUJx2m6HY9dn4Svop83zpSEOlqRAdOXGs4Pqq8KTRgA9T3i
         5bwl6rTiYUn7QupXHyb2huyEAcnbpcpYRiR2xf9wB769UIl0YtjWd9KHAqsHRYIQwSbF
         QelTXjGp27RFVBEhXeTvEJqtjiv9nhozMzL1y91N58vNck3OuLDX11rjjsQtZfy4HISM
         AGK2iwgRiEeC6baKNjKfkA+5Y+VvWeT9xHx6HGC4xsAvIMDmE7nSo0tpMuFmMS5+bD0K
         DSP9x7q9xTn0Dyd7O6EtQQjhpzYkZFlMh7P4ORDEuo1WN6w8bKChVcE8a9IxjXe+fBnB
         /wbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776332470; x=1776937270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG4548azMUJidAQp6NjVAMNvQq4FIjgWTNc8tKDbEh0=;
        b=MiF586onq1Zm6pjf0JIlEDkU4LQc9pVhh+6STxT/ez8cSGHiLYqR9j/x3VT+4p9rdd
         h2oqnMRKD2vZbj5XDLhXB1YvKIaYb6liARLZv5hOINaniB7pjRQXgfl7y9HmZprOvo+U
         EPk337ES45hQUGduXqMGEtYlxFoWnmP2rhxAN2GdM4qb0+l934BF0tcrd4O41PmLn5xO
         9ZWuFAG1zN7D67mbQSlpYMmDXle0N5/PL9pgnfRv0UwGyVY31Q4xr9eIA2ewRzk5GHns
         /41RRQim/me2UEqrSfNvmElkfFIWdMZeUlHYHdSqhOtf/o2wbaJE6gOYttgHA5AIz6ed
         nL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776332470; x=1776937270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cG4548azMUJidAQp6NjVAMNvQq4FIjgWTNc8tKDbEh0=;
        b=R5VzMcfCniwOJJHUL7uTFZPwL8rZK3SLxRjIvzsDoQLngHAtKq3n1yzPG2prjIVv2p
         bGm7dryHu7KFeeuXpddvrHXlDIgdXTKZ80Xbzv4sj6wS0I+eAm/4jCyCeu17p3KOefjy
         65CiYk0Jnt5iX88n3kBb4Yn9rPNcyghx2tOom36GTUWMJf86VRVuhrwkRIb79Nape51s
         wSs54n233DhOamMyA1I8qinZjt8OMjJMc9wyk8dVGz8lwNuXrmUhlgrMZzxy8tde2lmB
         DRnNCr9FMU//yLxUwvoXowyN5O88OcpbKdIpV71UEeOBsKGs0C9/FS9FccZLiIUd+rx8
         9Ccw==
X-Forwarded-Encrypted: i=1; AFNElJ+uKee2JwQw73GEwrG9BrSmmWakb7U/5Xv245PYrF+OJmIC0gUqq2+ecv3EIoir3rSHZGqa1SkIXtVl8cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUlkgC0v0GfchB6Q0AmDV99yBmuGK7jNR/08zj4ewJVs6GlqQw
	3plmBgh4geJ5078OlrWY5mvohsdnxnY93dNIoACMvRbWaBMQR+OnESvp0IZhHrtmibAZ4GULy50
	NHEDtNUTnDOYWsW2tddKMtkeYzXekV1k=
X-Gm-Gg: AeBDietpyNVJzPEHwk9wIGLfbtVVwVIM5aqcojoRMY9SRewsHgqj0oJVH29fKfpKvA9
	+MAc0UqptucbPLE6cnVstyXNYHjPS+IotyGrRVf+vk2X458LvrS11ZZ3wkd5KJTYENj/wo7foaq
	jD7Eqk3wVG4az+IYYfNrmNSNTp5tEAWUnm9psyXvA28ArIqXihvRkhVNIdSZ1+QE6Ec5n4gdYHB
	kIX3KrSTlZl39xfldWVCK+FfDdQMjCs5Z9FKgG4GQaxZdHKcADdlDpNZX9INF5Q3ikOinDdVCEq
	nYa8h07eWHkourrYulmu/NAeMzT3vVaqFBYF5KOFAfkcX/4HA2xV4ejuEJRXUHjETlcNstgP5DI
	mXAY8ap0dgniZm0xaBg==
X-Received: by 2002:a17:907:c80e:b0:b9c:b475:90ff with SMTP id
 a640c23a62f3a-b9d7298086emr1515467966b.30.1776332469578; Thu, 16 Apr 2026
 02:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416092917.27301-1-fushuai.wang@linux.dev>
In-Reply-To: <20260416092917.27301-1-fushuai.wang@linux.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 16 Apr 2026 12:40:33 +0300
X-Gm-Features: AQROBzClv3-tECA0GUWuoch9Wk6VZN8qul1Q-EnS6OmgD5p8Lf72HFisXPx1M9E
Message-ID: <CAHp75Vfrw6jLWOm6gC3gjMnUrvyd5nxvS16sJj5TP_JxaDSDNQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: Clear CON_PRINTBUFFER on port re-registration
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, osama.abdelkader@gmail.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	wangfushuai@baidu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 12:29=E2=80=AFPM Fushuai Wang <fushuai.wang@linux.d=
ev> wrote:
>
> From: Fushuai Wang <wangfushuai@baidu.com>
>
> When two PnP devices map to the same physical port, the serial8250 driver
> removes and re-registers the console structure for the same port.

Is it a real device out of there? Can you share what that is?

> During re-registration, the console structure still has CON_PRINTBUFFER s=
et
> from the initial registration, which causes console_init_seq() to set
> console->seq to syslog_seq. This results in re-printing the entire
> system log buffer, which may lead to RCU stall on slow serial consoles.
>
> Clear CON_PRINTBUFFER when re-registering a port to prevent duplicate
> log printing.

Seems like the Fixes tag is missing.

--=20
With Best Regards,
Andy Shevchenko
