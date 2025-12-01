Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C252628D
	for <linux-serial@vger.kernel.org>; Mon,  1 Dec 2025 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764554134; cv=none; b=r6iVYSqNqkkPzqqpRBSoFopRjHNb6+lUap+wfYGEFM1v0lbZo+ntKGYqKEUcsCLqNQBHWzjl1Dvj1F43SJIKOpyyz7FG18A16TAfuZLVI/9AEK+SnczukxSXxFTzrkrJKHH6o+FfXKLzPcbmv6MlzVCtVH8On0UWrSZhuon8e9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764554134; c=relaxed/simple;
	bh=474uzPX05UX2aHTNgnYcqrJxt03gAwvGS+KuNzMecks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2sEwgT/UD8yV6OuGSsVC1stUbCIH7DZHJ3UqWp6j4duzgO2C7CO7miBtY2ETpq56SSLzFVrW5nnO6nwJ4aTTFxDjVXeLhGyztCTiYWwoHN/GCwDX5PMDJgUDZTSEpKZjqv9oL+phDQT/Kri9dM8egIeJTUTIHI6vxsgjO3LNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ds0eeaki; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds0eeaki"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b739b3fc2a0so526906866b.3
        for <linux-serial@vger.kernel.org>; Sun, 30 Nov 2025 17:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764554132; x=1765158932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=474uzPX05UX2aHTNgnYcqrJxt03gAwvGS+KuNzMecks=;
        b=ds0eeakiRTmBZmfen5Wm6kWiK8FRWVtIBlwylc7gcbgS9RckkjL7hgm7ZVU5cb94QN
         u19f3Jn4qpKWYndr4EHWmWODKJ0ztxpc6CPVz/nM+GjT4EDqlqyZQka2BiMgyZk+Pv80
         PszUdmNbxvwaVRFsoo4mTg5QQkxpgUfE9qTGnWIm7OnuXEgE0uB/1o3US8mSUBcM7rgA
         nWrTzDhNtGj6qi3sH0vIhH70NOOZ6B25VK15+eqNWFt0mPWclrQhU5RmZzLAbgmoWcQ7
         MsOEmiJuxmogrvWAGxfbgvrXKsXIX/4QVOR+4PdWksxWXcAJV8VCOihkUZM843OVkSzV
         C7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764554132; x=1765158932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=474uzPX05UX2aHTNgnYcqrJxt03gAwvGS+KuNzMecks=;
        b=RWa3OqIIQJ3KlKQwZXDKgvhDiFy17xiG0qW54KxJiYmgQ4/YbnSZideW3pAq9BLl1O
         /lP2tT04f+06uFh4Zm7M7BG1lgHoh6MMhhkvmnQ1moJZ+MG4xi6NUYdWUOpSE4cQnFdi
         4lyA8iD51fU8v6fy168k35ZrYb5svnjAJl8ltNda1MW0UgTKhfLrMY+OFn0Tcu97VaAV
         nrfMbdxJfiZ0EQ28Es5lQ8TkIh86O6a7/sk1Z1wovT3Vu2Vw91mcEtoqBksc1gLAA547
         CsjzGDDtGQ+6Z0gLawDr2P605KbcKXfxgJZ3Xe19IgPJ/DU6ZW4CIJlBmdrq+tv0yh6C
         a0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZiKscTNsEqv9tYG6ddB0SIkVp5/MCWwxhs50y5B5rCQL/1Am+5BQYP+w5Wa3LyubdvQ/rAshhT0Ehj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPIW2KclkKWAZZdd4gWvlO2Lfy4a69VpK6sESY9UIGiPQK8E4
	ouw35Uy7XpHlbhdmuUv1s5d+eYSZ5DWTe1ZPKpZkAXagH9GtSWCwzKKkIHWguydbKB9xcDQTQKv
	X+hGUaUIV5lQ0/JJ9BZ8y/REO+M4KGFI=
X-Gm-Gg: ASbGncugxfdXvp7QToxEUPHNfn2ZksRVVcdWqCkXrE28iwhTZQKku4rnJYL0Vqlyt/n
	p0ieRNYpBMM4ETlHrcCCEvI6ovqckg4JR8dsw0M5DK1nDdDqH6t7kv/5+oolNO81hWklrqqH8TD
	QXcOQR1zAjeSGjfyohP42HbaH9Wn4OryCIe06XLunanlI9+UA/l2yK512PPsnKx6iYRpH+Q/KGp
	kFTthfhT2xpeLkQDF4S+34o9gWerYVBxel2fj5so3nw8ePLrgM2DgOSejG7MHwwVWHC+e7zKt7a
	D6At2bvQK25Zsl1kJY5m/ewEDWkMXMTwQv+spaDAER0Y8yHGbJGFjKUnTU+I/aYiL9bJ/BE=
X-Google-Smtp-Source: AGHT+IF4mnyGnTV+f9uRw10AEL7q2QBDM4XnWCl+6kTG8XYjo+AVDdk/+RwNIVM5uwVt+33lCEFSh0OqE93f3kJWNo8=
X-Received: by 2002:a17:907:9690:b0:b76:8074:344b with SMTP id
 a640c23a62f3a-b76c5355c41mr2159379966b.8.1764554131388; Sun, 30 Nov 2025
 17:55:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com> <20251130104222.63077-19-crescentcy.hsieh@moxa.com>
In-Reply-To: <20251130104222.63077-19-crescentcy.hsieh@moxa.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 Dec 2025 03:54:55 +0200
X-Gm-Features: AWmQ_blaknqdAZO6F8utuzz69KlVsU5zdEdq4ltaatBezA6RVYqNSSuscUiw2sQ
Message-ID: <CAHp75VdLXH1h_pmCsdn40+r6sBAYmLmHx2zm1E_-oQnF6tOheA@mail.gmail.com>
Subject: Re: [PATCH v1 18/31] serial: 8250: allow low-level driver to override break_ctl()
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 12:45=E2=80=AFPM Crescent Hsieh
<crescentcy.hsieh@moxa.com> wrote:
>
> Moxa PCIe serial boards requires custom break signal transmission under
> RS485 mdoe. However, the current 8250 driver does not provide a way for

mode

> low-level driver to override this behavior.
>
> This patch introduces a break_ctl() function pointer in struct
> uart_port, allowing low-level drivers to customize the break signal
> transmission logic. If no custom implementation is provided, the default
> serial8250_do_break_ctl() function is used. This ensures that
> hardware-specific break signaling can be implemented without affecting
> standard behavior.

...

> +EXPORT_SYMBOL_GPL(serial8250_do_break_ctl);

There is another (scoped) export used in this driver, use it for this
function as well.

--=20
With Best Regards,
Andy Shevchenko
