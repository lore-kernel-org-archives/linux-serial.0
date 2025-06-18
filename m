Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB561E503D;
	Wed, 18 Jun 2025 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750228364; cv=none; b=NzquI/ich9pAnfpM1x5vsZcLaTJXbhNpMXyNq5hNvQ7U9TPNSePkjSgeuptPGR+UHOY97OOTFcrxEhJ9Id7uee+rd+r76Aq85bYNWH1pd1BY1NuGh+V4tdxz2+jxryrjNeDQ9Ku4yv9UP3QOCH/uIXRJ6fZanwzehE+oYKKh/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750228364; c=relaxed/simple;
	bh=Q6R9VpJK+yebI8V2UHdLDoGLpV7IjX7AVke6WGXxh3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGg1jBeekZRv23KfiNYED5YHbaqeliOgzYIe/bmMYjtF8h2HUWCNIAArIec4FYm7s42LmxX2dzg7UPsm1x8YQhCz3NR0JLSfptpi9rvDLKXRjKkaUKe52Pyng5sdy/pYsl7p52VUxgVfvkdthB1Y6uq0VHVdwRafxV+ZH6MU5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKxcITdp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKxcITdp"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54e7967cf67so6701875e87.0;
        Tue, 17 Jun 2025 23:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750228361; x=1750833161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bwqo1Tn/UI5NB53KqrvduG70MhvCcVKMdoEFHbfpgfk=;
        b=KKxcITdp0Jw7bsq0b+w3AJ5emxuZxu+vokIEh23sMJGs6CQoJ2QO6Bo7bie46Pu8NH
         J4AzWswfFLbfx4r7sOyISC6800urIKfO9XmV2yGE5zF7mi8+pZ87W8FBOqDhzYMEfkvn
         fqnq0cYhYutgrOrhp3SaHsfy7/CU17DVElPTIYa3lRv8YrLbPBy6rn1tBR6vt+R5pShL
         kvBbrQ9Mu0AHG4gwzxxgfrhP/xwMpbAPCUIkO00dS5ESCsWYZr+1aWPcoYt046keMH5f
         Fsc+jX76DStJTvmljpWBya7lL4KiLQZf3Yp2WJWFNu8I4Ed2M9hT8NELjMXXS5Nn7Twg
         RTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750228361; x=1750833161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bwqo1Tn/UI5NB53KqrvduG70MhvCcVKMdoEFHbfpgfk=;
        b=OAUNIw9zu31GMIb7hpXaTFlwFXnnC/KDXfBhNftRyO2T56b8D7a5Nzu49JdTj9Bsaa
         aRtWLbmu/qdrMle1FKe+/dATIKMPz+zGuh+3jm4Lpc6/rPADSuQnKWI7G/F7iSvc/C1l
         MIQ+jm9WZ4zKRIXgJkYgtWYVlDoMqKwyHj1YLFp/JO4lgW/PDKjTCQlk9ZODNE9PYaYx
         jKiaU2nH7gMyMIr32TEMx3A5shdTexpD7nqBcs3LRQ3oGBLnn9u3C2kuq4yDv7WcFKSp
         9pxtSh2FyXEWBq7eJMLzwPFMnKRSA4o/806poYniraEFTlV0mNVpKhNS53QAVj3cRPpv
         qtxw==
X-Forwarded-Encrypted: i=1; AJvYcCWFTLisRnj2KtEucCcLBqmeE0LdFEmh/WvZcbZLXrOdl80J84X5O85vKlUvCv9BJAXxrNs7T+u5yF48ETDc@vger.kernel.org, AJvYcCWcoiv+ojyg7qNC/2Ty3/DoQgDUCR6S07OpGGKa8CskHzNI3Y4xa7oIfkeBUk9ItNgqsNykaq4B/n4GB9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvsuRK67cevRYHNjQP+tmoSWR4Fz9dG47YNSmR45MHNchLNNoD
	yJbtvv0+a0Mx9WfNGv6LcuPQ0UUFKWoap2XRnC55D11KUqDilz8LLc0eTdxs+fBMUQbxu3iU+mi
	rQ6WSeiJj3klMbtLNNyjSOMlydBFqi3k=
X-Gm-Gg: ASbGncuadmqSSMtglofvqn+ND64TRer8v79fh/zzIZsg7U/UqEXGkwmpRcPyCIdi4IL
	pBQYStNL16vA+jNSu2N+XlyMqe6YRQ7e+gCroDuGrsxHTCeK9KggYHdPo3O5eSOhUGMzBRillYL
	Ug+rE+kttDmxQFVJrPt42SnvWY2cKqyuUI2fi87YniPhyQUsU9WWyQgV5UUTHbwrWpX+/Oh2Zu7
	sHPbg==
X-Google-Smtp-Source: AGHT+IE9/lVOC9RD5dqHWaSWa1j5VajQRRLgW6hA855xIJmZ/spd0YvrkdXm0ZHnMiUmLACFqGFrlt0hesE7QYoVWtc=
X-Received: by 2002:a05:6512:304d:b0:553:3172:1c23 with SMTP id
 2adb3069b0e04-553b6e75482mr5205429e87.17.1750228360458; Tue, 17 Jun 2025
 23:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607134114.21899-1-pranav.tyagi03@gmail.com> <20250617130431.50f761dc@pumpkin>
In-Reply-To: <20250617130431.50f761dc@pumpkin>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Wed, 18 Jun 2025 12:02:28 +0530
X-Gm-Features: Ac12FXw1swBMxxqP7uL84LhUXsvU1fv-TbWZJqVqxFBuKmhpQqAXjySO2_KEEhg
Message-ID: <CAH4c4j+BEJqMqECPDgOF5vq4hg7_yBRrLBPSuTKnA+CO658SOQ@mail.gmail.com>
Subject: Re: [PATCH] tty: replace capable() with file_ns_capable()
To: David Laight <david.laight.linux@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, kees@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 5:34=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat,  7 Jun 2025 19:11:14 +0530
> Pranav Tyagi <pranav.tyagi03@gmail.com> wrote:
>
> > The TIOCCONS ioctl currently uses capable(CAP_SYS_ADMIN) to check for
> > privileges, which validates the current task's credentials. Since this
> > ioctl acts on an open file descriptor, the check should instead use the
> > file opener's credentials.
>
> Is that right?
> A terminal will have been opened before the login sequence changed the us=
er id.
>
> The 'best practise' might be to check both!
>
>         David

Hi,

You're right =E2=80=94 I hadn=E2=80=99t fully considered that the terminal =
is typically
opened before the user ID changes during login. Checking only the file
opener's credentials may miss important security context.

Best practice would indeed be to validate both: ensure that the current
task has sufficient privileges and that the file was opened by an
authorized user.

Thanks for pointing this out =E2=80=94 I=E2=80=99ll revise the patch accord=
ingly.

Regards
Pranav Tyagi


>
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
> >               return -EPERM;
> >       if (file->f_op->write_iter =3D=3D redirected_tty_write) {
> >               struct file *f;
>
