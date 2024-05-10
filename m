Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC020446BD
	for <linux-serial@vger.kernel.org>; Fri, 10 May 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357630; cv=none; b=u6FRQQ0rxa7eYqzKM1UY+1avm8lBWqr9c7H2A4svUZMkFBwMk9pgxqcYcrEhdsKwwnsyKLecW315oAYBaClop5Sa7fJv/JNW2CaIaVPVkOX7tNijbuk0dtIJ9Huhu9xgVieB2r8Lg8mX3+Uo8b8afVz9pFxSBobi9vZIMnTH8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357630; c=relaxed/simple;
	bh=b2Vtp/c0wZElNrbeWZjvkBtkRs6Hnk/JEEfb33UNJTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZahnmpGpaUAec17bLmyY9SjuNN+G4oRhomlQyA70uMtS+JrteqeUn3gpsDOchvPAYC4/9yZycA0hVjXMGI5s457aL+ZtZDYw0qay/qfoEk/07MaVc0UBvG2ZnpRIjKDlc5CcFb0JlKNV9sz0bbVZMdNqD5hwlms+OM4qRURatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vbVW3k8b; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbVW3k8b"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7f395ac5b16so1100261241.0
        for <linux-serial@vger.kernel.org>; Fri, 10 May 2024 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715357628; x=1715962428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2Vtp/c0wZElNrbeWZjvkBtkRs6Hnk/JEEfb33UNJTE=;
        b=vbVW3k8b8CuwO2i4y7DDdC8Zwd2VUBt/1Fkc+zhxmi9mpiZMYHAFMTQD9krnxYe7G+
         akkK50WuYKHhx9/u43UnUnHzOMvAyOFKR0KrFqSRUobcdQa6M328zG+E0tkvEb9ZCjI3
         95IRkok8ieJxRhYsRu6rEX5tnTRrp2Tc6mvT9M4jFh8/SjRFd5HQ7Fyi9Ho+oBlguplM
         x/pGU0nwEeXsDsJTyWSI5VMHuM5M1g2Qr60VzLE3l7L4CzgE7MAjwyt2Yb/Dmsq0ifft
         JLOvhguhIHVRXEnstaEBbJcWtNgLsomGjZCEbU96Ps67w6eIME6CBgHnIpkHt+wbIo9I
         /+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715357628; x=1715962428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2Vtp/c0wZElNrbeWZjvkBtkRs6Hnk/JEEfb33UNJTE=;
        b=IoYy94hmTza2cdNRzXbo2eY6bE8AqaVNGDUUC4cPtrv1FAQr7nOmh0cW/HObvn5Eve
         3+lWYp0M5NmOExTRWLZTASST9Ml8LP5ewl2ASjnk95zQsCvSOf0dG1DQ+i6xCyCAUgHM
         dAIiCfvhs4mh2zIAuadzMa0elsJeJEwOHjdFtM2zBYGQwK/1N877SFIH6OMmlYE77cAW
         Kr0hvM4Ec1UA671Hdom2/vo3nlSlkxdQrvxi7G6yvKwlSNlqBZK9sK6N6Zm7/xcC6dBo
         tB9MrwijRzOV8GFslUGRYCVSQ6RBeY+/FsRkBjCk3pZmvN5WWX94phAJRrXc6U98i0r4
         82RA==
X-Forwarded-Encrypted: i=1; AJvYcCVuDDff3I5wdvyxPCfiZjg0OX9ZahakfGJsNopiuqa5D+Kw/T6F09ITPrmWiEtL8MuXobKIfa7Vhi9Xvnj29SwLqYv6qmj93enjsm+A
X-Gm-Message-State: AOJu0Yw9ezTJGdRDlH7XanYLvEyZpjYCl9v2U3qxbBK11OU5UaybpxCi
	xILPX56VFNHjMDjPO8B3NsDnQDeGbQZn9E2om7SCZryqP9vrHfveNsECdWLET/Syey8FbgOSQMN
	pce2tv25UQk1XGdftiLA1Y7I6O+o9mfp/Z7jR
X-Google-Smtp-Source: AGHT+IG41/Va6A/PicQEwVzYdPo29oFPCeD2uQQ0q6aGV6VfwkSy/QFh16mwRnTYc1WroFao7pdgMaWgVuqXaACix2Q=
X-Received: by 2002:a67:ec0a:0:b0:47b:ab0d:b3f2 with SMTP id
 ada2fe7eead31-47fabb4fafcmr5674759137.9.1715357626878; Fri, 10 May 2024
 09:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-b4-sio-scrollback-delta-v1-1-4164d162a2b8@google.com> <2024051039-bankable-liking-e836@gregkh>
In-Reply-To: <2024051039-bankable-liking-e836@gregkh>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 10 May 2024 09:13:34 -0700
Message-ID: <CAFhGd8oo-th9bw-VQQAPva6_zNBHQjmOp+oEcaZOM4uk+xi-oQ@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: saturate scrollback_delta to avoid overflow
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 3:40=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 06, 2024 at 06:55:19PM +0000, Justin Stitt wrote:
> > Using the signed overflow sanitizer with syzkaller produces this UBSAN
> > report:
>
> <snip>
>
> I think you might want to hold off on these until the discussion on the
> hardening list about overflows all settles down to a solid resolution.
> Right now these all seem to be a mess and perhaps you will have a better
> set of primitives to work with once that thread is finished.

Agreed.

I came to the same conclusion once I reached fs/*.

Let's see how folks want to go forward with handling wraparound :thumbs_up:

>
> thanks,
>
> greg k-h

Thanks
Justin
