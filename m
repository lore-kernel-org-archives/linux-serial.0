Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAD11386DA;
	Fri, 29 Nov 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732867127; cv=none; b=khYRyOF7TordxEB1DgPPa5tHkuyjI5B0S9SuBJbpWkrJRYwA4RCxk9IbIZlKvke5DYfiCkLm6WpjIG3XRXrLW2ohhCC5oidtMIdIybIeh50wZU1HUMiN+4jDqmQt6fvp5HqzEy9ul+0/Bt0cqaznzE4xSg35xuuT8THqfteY9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732867127; c=relaxed/simple;
	bh=DGGweeKTa+RH+0DnaUtBC1/0fD3GQ1ZhcpPHK7Zfy7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsbBAFF6eRlArrWDsU1RYxGJrnw5pEqNUcvd9kHU+owdTX9OzjC+7cQMdesjKQmWki409kqLA2L4X7Xfj/8H8MhjZH5tFlYjIG+TGawNQ8p+BkyZy9A3aRgmRAvluhHFD8uGxKpPGZYqyKcJ6b2NSQMORKeXlhanJxg9cUMF90A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51514257e57so426557e0c.2;
        Thu, 28 Nov 2024 23:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732867120; x=1733471920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+Gp1qiNTq0xAIAUyk8qXxpMaz1cYGia2c+m2zi+2Rk=;
        b=LHSuhS4quPTe+DvNOFd3dsYaCfIpL5VkmbwNAMBePQkiPuzkXVec2xToRFOxxWdgJC
         xDcQeOdii9z3jYiturOtDKpre9EAgEGXjVa0FX8gQDfPmO9dOQVQ9e5jpYVGlzn/P2Eq
         kVhfrTLZpQT/qC+FPVJLQcx5jTfxjCfm6wwkxTdVeAh4dXjPCMPlL60u99KGhxe3y8qU
         CW0gTN0o3jfa+GuZ0GMt1NXPl0h/l1Mxz2Zv/JcTPvmGNiSfQ7QQVCGSuktzjOHK9akJ
         BVvX59zCSVUpgV8pHwxdRqlLJgYIusDI2MVQ2qJHgTQfljuN+W3IC+YSH506u4QMZ7UY
         0kdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb9u4EnBXyr65+ZwsOJzVZEoYSy1A433bkkGRINykfMNbT8BVqe2FgK/LdFjVcLwUGYdCjNYQBHNyJV1xE@vger.kernel.org, AJvYcCVtPKlLOIuKfR4vnYXa/Ova3Nh7SZM5Urw/K0dEdfsKQDadidj+7Ubo9JsC65ZG0CCQ/5eV68kWzgu4a8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/qcwxpmCkDHYNIBXKTcxHkXiB0ozgdKJqGIT4l17kHujDZfBO
	qSMThZcGiK8g18dIghMkmzwKohqolM2/oCrFHNjbMJafh/y6xMILHClWVpuDj4o=
X-Gm-Gg: ASbGncuHIc78RbGP4b6ytzOE8GwEMWMurOG+5i6YFaMir2ne/Z0j2QzIw93oBxgw46J
	aRTkYf+qpqkbfkCBIKtYXnnSWe1xZ+fYVArliFxI6oPadFWWpZjkioEDLn61S+KSe0lBylm/DS/
	gawkucD5df8h8RUBNXwG2iVxsY8iXgYKKMF7vdFYONk3X5UWRHWkOGV2gLlqU5wcPk52JyBmCtv
	XdMg0dqtTOrQoPHWHoyYwzTrKul91uMw5hJ7gYpWHLTVrZRHfdY7xxm/fO0lPmqjvzjAE09x3ox
	d9NWoab3Q3Kp
X-Google-Smtp-Source: AGHT+IEN5Mru+x7LyJ/6RxmLLiTi46Tt0KvF/yIkcVNiTr7ssz6fmSSCpHJghLNUiHV6uk6/4g5DZQ==
X-Received: by 2002:a05:6122:458b:b0:515:4fab:b1a3 with SMTP id 71dfb90a1353d-51556762babmr12082065e0c.0.1732867120569;
        Thu, 28 Nov 2024 23:58:40 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5156d0f8bf7sm434714e0c.52.2024.11.28.23.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 23:58:40 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4aefcb3242aso525754137.1;
        Thu, 28 Nov 2024 23:58:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCYixANJr7ZlfC4lK3splcdBRCSSXaiBRDQle7uJgTvZW+2pHU/BuVqGofvoaA8TZ23lnfllWNHSNMm3A=@vger.kernel.org, AJvYcCV8kXv00xSPhLtcWBbGJLOm4M5nwejAGpE6eRG1BABtXhn6TDmGMRTS+l2P4A3czL+FlLjmJqhWttqSxdHj@vger.kernel.org
X-Received: by 2002:a05:6102:cd0:b0:4af:4983:d8c8 with SMTP id
 ada2fe7eead31-4af4983d95cmr10883213137.10.1732867119928; Thu, 28 Nov 2024
 23:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0lCihhE75lE9Zjd@kroah.com>
In-Reply-To: <Z0lCihhE75lE9Zjd@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Nov 2024 08:58:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXwdyb6RA5jksNfw-M9h_nERvm8M4b7XU1_1N-C+bf94A@mail.gmail.com>
Message-ID: <CAMuHMdXwdyb6RA5jksNfw-M9h_nERvm8M4b7XU1_1N-C+bf94A@mail.gmail.com>
Subject: Re: [GIT PULL] TTY / Serial driver changes for 6.13-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, Nov 29, 2024 at 5:26=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> The following changes since commit 42f7652d3eb527d03665b09edac47f85fb6009=
24:
>
>   Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6=
.13-rc1
>
> for you to fetch changes up to b5a23a60e8ab5711f4952912424347bf3864ce8d:
>
>   serial: amba-pl011: fix build regression (2024-11-16 09:52:55 +0100)
>
> ----------------------------------------------------------------
> TTY / Serial driver updates for 6.13-rc1

[...]

> All of these have been in linux-next for a while with no reported
> issues.

Oh, how do I love this boilerplate...

> Claudiu Beznea (1):
>       serial: sh-sci: Clean sci_ports[0] after at earlycon exit

"BUG: spinlock bad magic"
https://lore.kernel.org/all/CAMuHMdX57_AEYC_6CbrJn-+B+ivU8oFiXR0FXF7Lrqv5dW=
ZWYA@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
