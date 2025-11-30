Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88532236EB
	for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764522461; cv=none; b=EYEKx3G6nCkvG/2eMAnBPQWLvMG03tkekkzO4jasmcihHrmLZyCvyD/uu9Aa+jHb65gISuvKXdkSHVkcrhthCaTQsGjrxJ9FziyFkQjqf0CikBr941XtTfEuiIVApxtN63To8pu8FezbG3qg65Fhb/GBc+4xtU9JSE5ZOWvQJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764522461; c=relaxed/simple;
	bh=bMSPVQzwYMsNJSdOOoCBuZXxs4k8wYMaahqafmQXn7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvplW/zXIy1P3n6A72qJyXLXTJGjAF3XGY8YDmnxYcWkylTSHoJCSBDFKcv/KA8yuIbEgoOXlGBzkPRyXfNK4BF6zq1RPEolOciUm/y3oOsFAv/G1O/A8oNzbmCeWo3XPi538bHSnwdMuwweLkTqcHS1VS02WSth77I2iDJubDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux6EC6Ce; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux6EC6Ce"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b735ce67d1dso563442366b.3
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 09:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764522458; x=1765127258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMSPVQzwYMsNJSdOOoCBuZXxs4k8wYMaahqafmQXn7A=;
        b=Ux6EC6CeJ/1fuXkUdD72xoNvseq6WRkWhdze73oM/JX6RiExkNTHjY+cbFFL8fNrL6
         YXVXFJy9dr4Lj1FzFSzFm40shudLomRgAtIr333mKwOsrDzF5b7HDgUSUokHJsarBcaZ
         xGhKdqVNKufsldal7vFlIaqpxKpC+X01+660ghsYYE6HiOhF7aAVIXozGNf+rNdFqC+d
         YwgYfO292+BrvbvlEXhzCNPwhHNGC+8hQqqTF9+XT/t2VV4Juk8DWePVhP9qx08SWm0M
         wKJ9VG7J44CX5thpXhs6/g4hoU7zWaLhzbkMU6x1Q2czZR85yL53+V2jlTmxQ//DCkxn
         pEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764522458; x=1765127258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMSPVQzwYMsNJSdOOoCBuZXxs4k8wYMaahqafmQXn7A=;
        b=hyad6YiDHnHQQ9pF+Np7X3Ixs2G7R9cJyxqLJzPOOrB/sEoIEI2oIHA+J4Up63JmNf
         v89U8zTMeB6KHrs8I3/ROYgJAWmdzegNZqI3lc5gXckWwG8j/5Jgf5S79J2eVqIH404i
         j319xQtO0S1sazSC6b6HrAa+EYIkq2lCX6HS+kp/aJzB8ma+NirrJEqiaSzdTe9Csg6I
         OK6JBafPL1tVQBCmTLrGZ6d+sWJjXqncYhsuQk9PUG1RySajy/JTFTEgOqeMEr0J8f2h
         eSNyR+5hwnP7N2nDDy2SLyKVtkREATyzwFRxhjE/irYYCJYPLTVZcKJWPhG3AwIxurtY
         GLqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVshhVVX43eUwlyD9XdRm8mKiL9rTRu90LIfbtHJ2mKLjaBTrDN0qriMHupwDTJWUIAaToe/ikkxwagKnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLP5FvbV5o+6NBITNoogtng7J2V8BM+O0mtgQ6tGyZlWR9dzIx
	hlJv8U4gq8sEB9b1XNTmhBbcxF/d02tTyxgIhJwOu8eUXm+93nMF+DMVbZRepzeD68FywnNdPCI
	XmO+Wdlpf9XKPfjzamr9n5yT032XB+n4=
X-Gm-Gg: ASbGncvhax+Fx7sYlG61TC3LVjFYcUq3OA7f0QySDPfThYxhvYpD7wtoeIpx3diJe+0
	bjGiTH1oPztr+NkYl1hp+aRqHb+WrZ3clJw6ZqNbVG7XwlNTWDqNuepOePvIVKGVEvfFAwxwsHu
	j70gCZuBcWvaPxOP85nhnJ12MIBMXw0zr4MVqN+J7zkvm9M5bJH6pCv5IdWSj7sdFK7mJi+qLaM
	RW8PzMtEm0X3LGLTsMzpQesyemhRfEnQ7DGNtqTa3jcBzEazGctWa1WQT/mgsAsxe3wk/ei0rxR
	l3FEevek7ySbg6fDZVPpxNxeUAYsr4F8TEIZYR9y4RgO8B6XPd/RLlaxoLGiSlppx/xjgYIoosv
	Gl/DZy4c=
X-Google-Smtp-Source: AGHT+IEi973wB9W6LsNu8Sb409/2N0rJlwbFxsB4MKvePMt/q5gT4L5oS0BemONDHHOS30i+GupjQcGUzlJsNIGpbRY=
X-Received: by 2002:a17:907:969f:b0:b3d:200a:bd6e with SMTP id
 a640c23a62f3a-b76c555d006mr2630562066b.47.1764522457975; Sun, 30 Nov 2025
 09:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-2-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-2-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 19:07:01 +0200
X-Gm-Features: AWmQ_bmXeLBtTbscIJEjrRkA8sIjsL1duspoIW9D5ltyvZgFfM2mFoc3Thkj6No
Message-ID: <CAHp75VdsM4d61wRstO_6FAPno+t+yAmYJ-MqikOdqawrVTDyfA@mail.gmail.com>
Subject: Re: [PATCH v1 01/31] tty: mxser: serial: 8250: replace mxser with
 8250-based driver
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:43=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Remove the legacy mxser driver and replace it with 8250-based
> implementation (8250_mxupci) for Moxa UPCI serial devices.
>
> This simplifies maintenance and improves integration with the existing
> 8250 serial infrastructure.

One obvious question (that I found no clear answer to in the commit
message): Does it mean all functionality is kept the same? (I think I
know the answer and this has to be summarised in the commit message.)
And one potential issue with the change: Please, instead of removing
the old option, use transition Kconfig to make sure users will get the
driver compiled when moving from old kernel configurations to a new
one. However, see above. it might be more tricky to achieve a smooth
transition at the end.


--=20
With Best Regards,
Andy Shevchenko
