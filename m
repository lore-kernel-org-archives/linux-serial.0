Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451DF19B5B1;
	Fri, 13 Jun 2025 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822809; cv=none; b=GfPSseY+i7Sir99pll6EPrg9sRV9bWNW8yU1NCQJlI/sH2SeARWOOOk7Jei4iByH+RjP7WUdZIwqs7ICJiSdHZPLycZz8rs4rLwSxgfsliSBC1CI3uy0BUvBzBb7Ywvd4tq6AbbfqNueRQvDrovzgzyVJHNb6WJAmPrLbh9mEEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822809; c=relaxed/simple;
	bh=KUZfzfZsPE24PRLfx/DqXRXx6K0jTqrrFaXznX8oEdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPebUhp33RIx0OoeELbUxWF5icHfpe0QO218d+HdBLCgqrkLFqSGgPPzIL+VvNdFZ2enBUgHmNTc1Wm8ewMgx+4AIW+9g93A7+jJ+u5/I6Jic4xKR3OB6wElA3610BXryXy/EeApWeN9eQWkEZaE0GoWcFdEAxzMIbFsdlrH/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j04z/oIh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j04z/oIh"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5532f9ac219so2124843e87.1;
        Fri, 13 Jun 2025 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749822805; x=1750427605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujtinyWtMOPXsq5wXbPCOHOmFoKO1rUWjgdXnoqJksw=;
        b=j04z/oIhVo2VPtXwbC0IjJv1RzNBbu5mPHVRHnHrxZsaiWb1hFCV/c/N1Ohy9CX6Em
         bpPGQlbPP45yDEeLlOHQ3A8IkTIll+5fvLQBydcuHFKw0IQdh/G6dTVKTI/9Lv0D/zPn
         UZdHvA4+pP9vP42IAzOSurtliRfRhVJvd0YzmnTwJdEUAw2iuO2gg4+7kaqLqBYuueRG
         /+BwKNgn4fYNuaB7Jg1R0HCBk4iDokpETORCXjU1zZsV8R8kBgB6QZQ83bcbwyind1lA
         3KA+tjVfN2hrvR5kiZAAbWyMSo6WXCOgaxuJb2dCIOyOZJG0Bc2iRnk1smXZdqeHq/Ep
         F2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749822805; x=1750427605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujtinyWtMOPXsq5wXbPCOHOmFoKO1rUWjgdXnoqJksw=;
        b=q0mrJD/Q3CH+rYon1SR9wKo1Wm4pBWOxqQW6bo5KZgSQeY4NPMK1144LbeQUWrQkf/
         6XvhSoqVdgUV89CMIWibfNnr8FKTvh2ME36MAAXNnqC4QXP7KtH32aAjU53b2Hmm2zDj
         FTlQa9sQdJfzti1+9UCsNUDRbp2Psve5APR4V68H/5ioZjdm0sITU0P0TPjS4d3rSGAR
         DHdpTxH8+xFkcx3oKcyLHobD24wj0i5ehI5Fjsd4UwyRGjFGwM97SUFH3ow/o3vCDywg
         Mdupu+1k7S5ObuyY2m7D4O9t4v3ONEdVn1RnL6axvrHID/tUvNwq+QywsWO8MHesBa9C
         0ORg==
X-Forwarded-Encrypted: i=1; AJvYcCWsWy6EZTAYCCH3MZTqxouesDeUMx8PQCOMLbr5eaxACZhvsFMEg9HiMNsyOgoYVzwwj4i5XNmVgTzk5VE=@vger.kernel.org, AJvYcCXq7dJITwyk24WBrvdp+QpumrqpOoEvUqO+Xj3y+mPTT+fsTwKy/PpYqqNI6DaIMjc7NCu+ThcWJQplcJd2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1i3BBnsaLFrtGMdOxirrwWjjIm35svdyDHcvv/72J22uHmcyE
	rj9qOTRJvIJVUvPazmtbEt0DIbbv1SXsFe5gihqrkPzlPeCcPJuXErOnwPRtruuE+8mDV2/2QYl
	x3/xYkPKnGHYLxmXWMOAQ0JPON6/o9+phkfyXTVo=
X-Gm-Gg: ASbGncvlRmz7LUq+acEPCRyRkQMh0t1nmEJJa5weoNGDpKK2H7uLhnXF9si293uYiVG
	39v8zZbpno2OcZHv89QaSYAoLt/8WClapqkWXMtrq87E5qDvu48rn77/9RU8e3TeYNm73yVU7O+
	a5VRQLNvdupKLWAbTWuG/nM4E6GnB/SRw9hC0lY/DYxPpeHvCpfGBpo4oZVRi8E1bFM+dDOC1NZ
	S88pBo0zdbU4EzE
X-Google-Smtp-Source: AGHT+IEl9qUXSspxpoaRt1cWqMw9LrrkgkBou8E8RGmOH7wcmz4yJUesGfCY+Lzvcz6mFzDt9o/Pi/NbzEKE8A2bXvU=
X-Received: by 2002:a05:6512:3ba3:b0:553:3654:3319 with SMTP id
 2adb3069b0e04-553af96da66mr960902e87.43.1749822805033; Fri, 13 Jun 2025
 06:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607134114.21899-1-pranav.tyagi03@gmail.com> <2025060848-exact-sasquatch-a899@gregkh>
In-Reply-To: <2025060848-exact-sasquatch-a899@gregkh>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Fri, 13 Jun 2025 19:23:13 +0530
X-Gm-Features: AX0GCFuGnNvyr6p72H6rynUnhfvQazx12X4BcJBVJRGB_9dMoCuBvt4-i8OKev4
Message-ID: <CAH4c4jLRcjceC2tynp5h9zFv9ev+usUrKO2Titnup1SPe_aNBg@mail.gmail.com>
Subject: Re: [PATCH] tty: replace capable() with file_ns_capable()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, kees@kernel.org, skhan@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 3:55=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Sat, Jun 07, 2025 at 07:11:14PM +0530, Pranav Tyagi wrote:
> > The TIOCCONS ioctl currently uses capable(CAP_SYS_ADMIN) to check for
> > privileges, which validates the current task's credentials. Since this
> > ioctl acts on an open file descriptor, the check should instead use the
> > file opener's credentials.
> >
> > Replace capable() with file_ns_capable() to ensure the capability is
> > checked against file->f_cred in the correct user namespace. This
> > prevents unintended privilege escalation and aligns with best practices
> > for secure ioctl implementations.
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > Link: https://github.com/KSPP/linux/issues/156
> > ---
> >  drivers/tty/tty_io.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index e2d92cf70eb7..ee0df35d65c3 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -102,6 +102,9 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/termios_internal.h>
> >  #include <linux/fs.h>
> > +#include <linux/cred.h>
> > +#include <linux/user_namespace.h>
> > +#include <linux/capability.h>
> >
> >  #include <linux/kbd_kern.h>
> >  #include <linux/vt_kern.h>
> > @@ -2379,7 +2382,7 @@ static int tiocswinsz(struct tty_struct *tty, str=
uct winsize __user *arg)
> >   */
> >  static int tioccons(struct file *file)
> >  {
> > -     if (!capable(CAP_SYS_ADMIN))
> > +     if (!file_ns_capable(file, file->f_cred->user_ns, CAP_SYS_ADMIN))
>
> As you now are affecting the user/kernel api here, how was this tested
> and are you _SURE_ this is the correct thing to be doing?  Did you audit
> all userspace users of this ioctl that you can find (i.e. a Debian code
> search) to verify that they can handle this change in behaviour?
>
> I need a lot of assurances before being able to take a change like this,
> for obvious reasons.
>
> thanks,
>
> greg k-h

Hi,

Thank you for the feedback.

I could not find any existing selftests specifically targeting
TIOCCONS. If there are any related ones, I=E2=80=99d appreciate it if you
could point me in the right direction.

Given that, I had to write a standalone functional test to exercise
this ioctl and validate the permission behavior with the proposed
change. I=E2=80=99ll share the test code and output shortly.

I'm also in the process of auditing userspace tools that use
TIOCCONS, using Debian Code Search as suggested. That is taking a
bit of time, but I=E2=80=99ll include the findings in my next update.

In addition, I plan to run integration tests with a few known tools
that rely on TIOCCONS and will report those results as well.

I=E2=80=99d appreciate a bit more time to complete this work and ensure all
bases are covered before resubmitting.

Regards
Pranav Tyagi
