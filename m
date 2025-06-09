Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A111CF7AF
	for <linux-serial@vger.kernel.org>; Mon,  9 Jun 2025 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500020; cv=none; b=IXTZgfgg3bWOMN9kDib+ltQG/+pNelCt1Cc1XhATpR4Ap217pXypGOD/q1qmGEzLaE/FxF1xnMTukDjqd+qoSwaD0BCAJqcgPwdGOS3xvTs4LWdaTZXUqljDw1DkUbV5Z4is0xCZoHuMye6C/wYtQMyI+V/6jT0QEZ33ezAmzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500020; c=relaxed/simple;
	bh=6NIEMC0xnA+C5jNliqunaIOn/xrFyw0xsARx0C0pKpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uesRmGhqpLWUs1OnDgTZVoP1JNypBeWVLFDjnBdcURzqhjXL20WAl0pPOJrTn9JMD+rgjry706MnsQUaET8EHRAYRxmuCtVGS5rRPVCTHk4BxxJchOCFKa6z1bFeZ97sB5CIVhzh6MM4GNu+u+ujbt5QNTNhBFOGwwZU4h0uM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lsWmM95w; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lsWmM95w"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747d59045a0so3250161b3a.1
        for <linux-serial@vger.kernel.org>; Mon, 09 Jun 2025 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749500016; x=1750104816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yFNgGlGCkVHg1knXwtU8l8k12+pdKexGY49aaidt7U=;
        b=lsWmM95wuh3avqSZS452d5EgDMSss8VmzsVSDAmXHhhLohYGSAAlMdP8G23nM23ich
         F55STEEc0hN3iOzPFS2FkTkNjyA2Omm3gV0kgtkststABzUpbdWNbRos43amymwQScDN
         iYSSfx+T4MMbLpp0tN8m0wSdksn6e+sQ2AUxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749500016; x=1750104816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yFNgGlGCkVHg1knXwtU8l8k12+pdKexGY49aaidt7U=;
        b=GIPWwjPeYdx+e/rUyloOoVUE6eSp+UCcd6r9Etw3OAcF/xpa+OlHTOhmnaw+Lb3vO5
         eOVN7KzF0DgDV+ON5bsiRN6T3Bb1qw3ztIE6lxdtKJ/1Q8nYqCYJyPlBGp8BHaXhNKZ1
         3VKtVxFLUMiybQ+Mc3CPB18s9W9HrrXoV1JQpHNoZO/sJMtaB71HHamL0bmiLHMMkUNU
         dbtOt+hWq/mhYJbBR67WOYQ/8bg7y1eOBiLcpXm1RdP+F25S8ml8mTIdIc9sgCi4MOJb
         we2E/C/uquFa1hLckMw5eevI1ihvufPct51iLu5wFpWAE1URIaGFWVR6w8ntvm0P/wn5
         3GSA==
X-Forwarded-Encrypted: i=1; AJvYcCUhdqfwQtmhV6TXrMT7glUQy78RF9/hQwhxkh7z1nbF9h6KIlYxJEoWubFGIUAh+TeIa36gB2uXooQW7NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyrTIr3RNfka2Oy1Jtlh3Pb5nPmtY2qlp0r2c0LIXK40KKsxpl
	j1m1Y4bFgFRcVsgf7s9wgT7XJt+g4sNqPhEt0ZWYrbnI9iWzj4aFdU6PHELSx//34iptuweCSRh
	bl0I=
X-Gm-Gg: ASbGnctHJMLG8Ep3Gt0f+cO4AnQuBdZsJkqb7MeslXX8qf1q1q2w7yxxofWuZBxwSHb
	YiqSBhBf3s4eT7PDaqYQW3Wvl86/6zUWPs2EzQyRG9D8XoqYg9xSKBdEe0i6G8oFKRHm2c4p6xo
	DXyuuCKLMjjtI+oawDWE6b9C/GLw4GY4INFJT0d2BUTMNDR5Ky6pLbMcIK4qlCkbVIyKtRkPEl+
	uWsk9Q/sczYn2/D/VsZZbPqyG9jTCwpztaD1gVULW/2ZngNyN6SzEjqKn3uIan3+S9ngVZC8twI
	OcZN7Q51qz7YuroXTFYuSD+14+oI+T0Ifv1iqsej7xU5HJeheMO3u6Df6i/Ud07Oya600iGfG8A
	xcwQKrZ8Oq3fW4VLV0q1EKwrAhCzYCA==
X-Google-Smtp-Source: AGHT+IG05eopiiGkKXxT+zKTrJlFJr7lpEKHg8w90oQWmXzuZGN0mNE3y6jPKQq4hdbAkyP7UMAEZQ==
X-Received: by 2002:a05:6a21:339f:b0:21c:fa68:c33a with SMTP id adf61e73a8af0-21ee257aad2mr17902907637.23.1749500016080;
        Mon, 09 Jun 2025 13:13:36 -0700 (PDT)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com. [209.85.215.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af383f9sm6094259b3a.25.2025.06.09.13.13.33
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 13:13:34 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2c49373c15so3230563a12.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Jun 2025 13:13:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHXvnOoV6HuTMn/F+DV+JOmrsfL7KnQqTDWOqIj2+t0sGi/MfEvfmBiWNvQL55ptg8c/ZoWEVy5qvmgn0=@vger.kernel.org
X-Received: by 2002:a17:90b:2d4e:b0:311:afd1:745b with SMTP id
 98e67ed59e1d1-313472e8c6dmr21398818a91.11.1749500013266; Mon, 09 Jun 2025
 13:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com> <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
In-Reply-To: <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 9 Jun 2025 13:13:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
X-Gm-Features: AX0GCFtFMIswKIAvt6rQB2Iu1HAY0gUkQ581gK2nBv_6C3TWCO4_jkt3VeYMeO4
Message-ID: <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
Subject: Re: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED instead
 of CON_ENABLED
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 6, 2025 at 7:54=E2=80=AFPM Marcos Paulo de Souza <mpdesouza@sus=
e.com> wrote:
>
> All consoles found on for_each_console are registered, meaning that all o=
f
> them are CON_ENABLED. The code tries to find an active console, so check =
if the
> console is not suspended instead.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  drivers/tty/serial/kgdboc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 85f6c5a76e0fff556f86f0d45ebc5aadf5b191e8..af6d2208b8ddb82d62f33292b=
006b2923583a0d2 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char *opt)
>         console_list_lock();
>         for_each_console(con) {
>                 if (con->write && con->read &&
> -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> +                   (con->flags & CON_BOOT) &&
> +                   ((con->flags & CON_SUSPENDED) =3D=3D 0) &&

I haven't tried running the code, so I could easily be mistaken, but...

...the above doesn't seem like the correct conversion. The old expression w=
as:

(con->flags & (CON_BOOT | CON_ENABLED))

That would evaluate to non-zero (true) if the console was _either_
"boot" or "enabled".

The new expression is is:

(con->flags & CON_BOOT) && ((con->flags & CON_SUSPENDED) =3D=3D 0)

That's only true if the console is _both_ "boot" and "not suspended".

-Doug
