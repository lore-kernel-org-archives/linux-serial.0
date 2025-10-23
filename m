Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E122C324D
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203987; cv=none; b=FQEEg2+19UP9ddgdbeM0fkk+U7EAZLAzMywzBl26lZNJH4366ivkr6LABbnIqCw2sWy32ARpHWIUyerArtp8OQgq25o5u71ws4a5CThOPaw68Nh2CTAHSy5apFxjV6WoKFmu73Gh/9vUxpx+45NhvZ+JJAP5rxT6Xpfk3L4A03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203987; c=relaxed/simple;
	bh=eKKGOO+EUYU7mFuj7z5lwhNA8rPS+bCTcsDg6/XrPM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtydUNmWNij+IgTR7S+FbliPWAUsS6EEj7tsuLkhXHnSMmnGTeyW0iYRnvBg99AvDhMsWgHqO+NaqgBGosvLJPIfdz179uyGsu89z8Cg/PWTcg/j+rAUOLrO5oJhTNdeNwLlkw/5WTjxoFBjPmVGHlrWeKf2C8Dd2GW7y7cf8xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSjgc91f; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSjgc91f"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47117f92e32so3698965e9.1
        for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 00:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761203984; x=1761808784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKKGOO+EUYU7mFuj7z5lwhNA8rPS+bCTcsDg6/XrPM4=;
        b=BSjgc91fYRnfjP3+xsBySkpSzz9DZ1sMPXXH9X9a00asjdgtPR7K/hh+Cg2vaZhg27
         K9x8IYoIaV4CZUGZ3vkgebNOwUPr196exu/6EZ27zwPbRA8aMrvKXuUOYm0glikKkX3j
         bRkafoxKnnhJ8XoOfrhfFxs7Y+RLZOBXpIl4pc3JJld8q13x4j/9he7cjjz5Ui5JOWkV
         KN6sG25N+ohacgKEXaQgnSELyYW2RMbEvqSY6tW0IuF0TAF7OucvK1C/Mje5/CnnjGOq
         Z5c6dwdYlX44Zu1jEAoyWw1F3GTUac/rRPH96DrGvnIgqSyVAxkv+q3ZiLH3hmfBUsmb
         9Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761203984; x=1761808784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKKGOO+EUYU7mFuj7z5lwhNA8rPS+bCTcsDg6/XrPM4=;
        b=ZD30R2vruxTd40ECtwomlTySrBCDwYHZLXK5xfrPL2Hu20ss2UtpDfInybzR56Ngei
         KjNCJZpcsEXkrdrFmsJUztVbIT7C2Jq2hRUzVLaesWkOvd53LOSnh8RDkIZk97MRj3sL
         2P4mU7SsfQ/KcL+Ji8Gt3ZccvIKF8CNHSXTrRSIWqJssJ0Niyige0+atBI9MVMwD1dLI
         1iiJzvKixGylf89u95I2UMc23d4XuxO6hbOHQkQco8g+GHttdrm0YxkQQOuVZlrIFuA1
         qNZYm1jLVNyZjRltyXVYuJ0m8HzrvSu5+amwJBpZWgPLaDiCBtr2FIQ2axFM9fh40OLs
         uDNA==
X-Forwarded-Encrypted: i=1; AJvYcCX6V5xLSOlCVYp2198uYuYFNF7KQqSFYzB067noFY31SaN8U+ovIrlDynt6sSBsByrc8q9dRvFnCoQnqt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8O4u8aZ9B4FmYYPuLi1VFn4wycN2uIJX8otBOAww0Dl09CV7D
	owgc681QaMlVQrMAvSDhTmaABDuvOvXF8IaefHyx97GpbYI+MGHUTAoKGzPI38+jYaAwA6P6sQ0
	Z7DebRu+/AGlGTtZEhY04twmiR5SknMg=
X-Gm-Gg: ASbGncsb1y3zH9IDjR4K/DYzsgj04yMUI590P7ZsyfOrbToiEZ6fkeWBbtLW5UIs9D7
	sUIJRLNe2RO0woBNoq3dpEzO9C+Eify/6ZPuqLCXsZ0vBkZnLgtPiAc5P9knHYh5Dw2Qx5Mdvfy
	yaGVlR5n1/7wP3V8tUruNK52a7dG1/Vf126QdIo/PfJ9vbiApvR9wAFx6LB5ADfY4lHjMvWWalv
	U2GLskF+jRrp6juBSeZ6voaJdUrGLnfxddrTmI2ZLytXTyclz42wlVuADX0dKDg9qV1/Urc
X-Google-Smtp-Source: AGHT+IH/mkmYloWSl+N3GeTRYAq7ya3Ct20DnnSTnKTWUDECJMSJuulDknWTBXri6ZT9mQCzclYrezLV30aAJPqFoCY=
X-Received: by 2002:a05:6000:22c6:b0:3eb:5ff:cb2e with SMTP id
 ffacd0b85a97d-42704d945afmr16411155f8f.29.1761203983713; Thu, 23 Oct 2025
 00:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923115120.75685-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <2025102218-blinker-babbling-5fcb@gregkh>
In-Reply-To: <2025102218-blinker-babbling-5fcb@gregkh>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 23 Oct 2025 08:19:13 +0100
X-Gm-Features: AWmQ_bmLla7MkDZZGpNbPEINbL9Ov2BbNibp0fEZqdf2JnlACZ-DZdND2GSrAnI
Message-ID: <CA+V-a8tOqZ-1KKgkEtoMnFpYghY+8wpnyr2T6XZFvPY9zG2Byg@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Merge sh-sci.h into sh-sci.c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, Oct 22, 2025 at 11:03=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 23, 2025 at 12:51:20PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Inline the contents of sh-sci.h into sh-sci.c and remove the
> > header file. The header only contained register definitions
> > and macros used exclusively by the sh-sci driver, making the
> > separate header unnecessary.
> >
> > While at it, sort the includes in alphabetical order.
>
> That's two different things, should be two different patches :)
>
Ok, I will split them up and send a new version.

Cheers,
Prabhakar
