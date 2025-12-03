Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A329C326
	for <linux-serial@vger.kernel.org>; Wed,  3 Dec 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753939; cv=none; b=ka1my0GIEnu+8tX1XT1z7V3HJ46GbOgYd9CxdqP3SNN6/Y2zpziDtFCNOtixX9AB24X8jLRbS+BYiMjnkCqbunRyEF6xZjps/R45fP6zYHInnIE0COYsbWqEZ4g1Z4J+YCLcyfMFpTaejaHyXvVnGi/os9nBU2JI2pXpg2V99Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753939; c=relaxed/simple;
	bh=lEAJh8lhiqF5O/Jom8wK85lGiRLFwThRyPMLIqVR7gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWemQ1aKo3hhYRKT8nyG2Swbv2Wiii1/GVkWywFFkIERl3t3i0uv2WYwIHnwUsfKO19WDuEdu4EJraM9r1Sv/u6vHj8ccF16I3IKbvjRpX6cuyWJntx39mAfPxe1iy9mEjtVD/AUoI3yOLxfdKm+Jbc5ADh1+1KSQJxl5pjEq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aog2EC1t; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aog2EC1t"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7373fba6d1so1022371266b.3
        for <linux-serial@vger.kernel.org>; Wed, 03 Dec 2025 01:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764753936; x=1765358736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPgVES09L8PDeps2AFFaB1RPb9Blq2hbkPZaSRFfdkY=;
        b=Aog2EC1t0snJvtOPvqYZgFgNSSFUWSgTbzQljx8HoEy16Xg8Th6ruBxcQjLZD6bFS5
         gLn+hH8cnBB6h0daosPVmsei2fRbsZ8I5p3qY5vf1zPPLxhZOhOID+lgpR3OhpMuyc4B
         HHvDwxLmnYh4V5/d7CS5qhCoxUxWcBk5vsfX/LJgmNMDLh1QXcnzuKT9JY0OsasxvDq1
         V804byh/HVkMe8PYFgol30YynisDvYXIe921U/fj7MYk0Zb3xOUkjUR9xjHWfq7pGMOc
         IN7+/cytcTZDpOWguNbBZl5u1HSpoZqapyvrsZMRmUrE1e4vKDbRMjP23gXe3yw5qtvh
         fHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764753936; x=1765358736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wPgVES09L8PDeps2AFFaB1RPb9Blq2hbkPZaSRFfdkY=;
        b=mk8/y09Xau1KK2XXyspJN3vl7URGS/sX8Y/JbY3Etr6palZWBibKpYdwVysZrPaw9o
         LHGTEtO9UymsDN8VL8ELrYHUplTA60FxzL2nYCrQdgeAHaMRjFvImwfgHjS6CV/9/A9w
         l53p8ZXZICtCubkl6tIwfffp4yTkFjnZaLQyYLaL0fvIarFFiY23C3T4c3o96r84hhCK
         qd4fPzJz/42XnCoBTKS1ALnflufzlS04iqAV1b1C4eaFW9Mrp0EX9eA2YYgByqRlZnRE
         DIDft2rzm6MfocWFouIUjYhw0m+tp15jYJlaQl2rXjSIBbPf11oPdTxfmvnM9ynK1TJ8
         NnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWysgd116sZgDUe65PyzvE/b8BxJLOjTtBj0sCKlxEN53pNkOP+W1GHMt04uZn7XgpEsOVVX5H6yjY+6pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmWN3JL0wdAsjbhaOM3keC0kAcWFk53m77VTfFYOURyq0m7Rch
	lhfXNvtWPHQyxqF/UmKmTQiDJ/xrG1MEhfLEEsW9bK0R9nNkQgZ4tXrMi7ZI6AUeHthrif1e1UU
	BUwU6zbwA+OECXOb6orVI02ArQAutClM=
X-Gm-Gg: ASbGncuv/qHzn+zzk7xu9iXyWmXP7KlujDxiYmHnJBLXToMW5/JuMqDYF56PehU+QE+
	dkFiPpZiHnoabAmo8OXCkDBM1xsYDC9crk6qkkFQcafiEk7sijYCfSrKuxGiH053rAbPyTW4HXE
	H8jcR3cFHOEBd+fKw7NZOIu9Bj/dzVBkA/+z51HM/+JgvR3sDlpPqbUHiLIbeEPC7aO53cYRxNu
	oxZ61ovBH1VoAHfbOI0sr3Uk4wSDrf4nNCeN/e6btwCWCGK8qIm8Pjx8IzpXAXnpq8dJjjzBeSm
	l9tPDVTiO4CidZgQ+m/+N6OGhdSUQJrNAoYc/iW13qM3CtQqM66hpgamxe+SUiG+6oVxde+5nLi
	FYQSBKw==
X-Google-Smtp-Source: AGHT+IGl9T+N25XB741brTUvlq7a0d2wn5371VAmYuaNlDsHysjmrvrsQeC9Wcta66ZomPSuEdJucwdn4Nm31mdVcTE=
X-Received: by 2002:a17:907:7e9e:b0:b53:e871:f0ea with SMTP id
 a640c23a62f3a-b79dc782269mr129945466b.56.1764753935700; Wed, 03 Dec 2025
 01:25:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
 <20251130104222.63077-32-crescentcy.hsieh@moxa.com> <CAHp75Vd4Fr9j3XF3Mxte8NDw_cE+_cyhWh=xs6YMQDTrmn=XnQ@mail.gmail.com>
 <aS-mugqHvS-OJvtU@moxa-ThinkCentre-M90t>
In-Reply-To: <aS-mugqHvS-OJvtU@moxa-ThinkCentre-M90t>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Dec 2025 11:24:58 +0200
X-Gm-Features: AWmQ_bn-jpXJtiF1a6oxwR0mfFSqonNYrnZXHSMf6RIJdUClGik5FyyKLQOe6as
Message-ID: <CAHp75Vfqi3Cqm+vMC=VXWCsVDP1926gpU+xxocHnVgZ6Y2fyEw@mail.gmail.com>
Subject: Re: [PATCH v1 31/31] serial: 8250_mxpcie: add RS485-2W auto-adjust
 sysfs control
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 4:56=E2=80=AFAM Crescent Hsieh <crescentcy.hsieh@mox=
a.com> wrote:
> On Mon, Dec 01, 2025 at 04:45:58AM +0200, Andy Shevchenko wrote:
> > On Sun, Nov 30, 2025 at 12:46=E2=80=AFPM Crescent Hsieh
> > <crescentcy.hsieh@moxa.com> wrote:

...

> > I'm not going to review this, the patch series is already quite big. I
> > suggest you to start from the small things in a different series E.g.,
> > the first series is just converting MOXA from custom to 8250-based
> > (assuming all features are kept working while ABI is being broken,

In case you are wondering what I was talking about in the above, I
meant move from /dev/ttyMIxx to /dev/ttySxx. This will break all the
current kernel command lines and hence setups with the explicit
mention of the /dev/ttyMIxx, such as console=3D.  There might be other
breakages, but I leave it up to you to research and come up with a
solution.

> > which has to be explained in the commit message(s) / cover letter of
> > that series), the second one is about splitting 8250_pci to the other
> > Moxa case. When this is done, we may go forward with the additional
> > features.

> Thanks a lot for spending so much time reviewing this large patch set.
> I appreciate the detailed feedback.

You're welcome!

> I will split this big patch series into smaller and more focused series
> to make it easier to review.
>
> Thanks again for your guidance.

Any time!

--=20
With Best Regards,
Andy Shevchenko
