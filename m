Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF77230E856
	for <linux-serial@vger.kernel.org>; Fri,  5 Dec 2025 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764923777; cv=none; b=fe/syu+gpNTtf+TuNQLNG9ZKgQdS8/TJjoYAm+G0gi+MFs8dRdXRHpT95XbV0vtOLjiOSegidJ7cjT6+Z9hekm+nBQMhy4oNYqPY1Zepy7+ytBVyTi1UF6m31Zp1Z9szj/k5gsK1A0yZypEdCKjSZQGno+q00486EDrNI8vGkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764923777; c=relaxed/simple;
	bh=6y4+7SP608HdlJoHAr5R8sGhNTwpQNJuxTONs+K+WbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/QJCPJ/zAJw517bP1Kp5KE6nFCHp+19ApLbGUJlqBkt7jhI4y+PCQG6/Ug2pzv9fC4mSAOLvd3Rj80/DkLdp0bQhePod5B5wOn2UiF+jTcryaEfJzYOAdU9ICfT4NjSduEETv3jaNIa4Ol2P8Tp1kLdCtg9ZzFhHjdWT/G+djQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zehs87UV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zehs87UV"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so3053466a12.2
        for <linux-serial@vger.kernel.org>; Fri, 05 Dec 2025 00:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764923768; x=1765528568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WsEibAAOLXIXMNB/I4Bee+8iop+NcyUJNn7OWP7xy4=;
        b=Zehs87UVe6MXavLLpeaI2/l5CyPnby33CIrhoSoL8qpq3mH+XKo0wQZi/MZvHiQJpv
         WHw2ileiNRVa6vRqnqsLV6z5m94sI340qdxynQqBlEnxD28ullLtr2erTuvts12p8lUX
         Bma0HPtP01ZBgIbrRH0HUtCG2lyJfo7NZrLZ2j8NqHKK0xr1D4IlEwf0z9VUfM3Txdjh
         ZDoFnzlQLJZ6xraJNcWuntKmtyH2bwCRNr2b0Klh63AKJQeAln+cMC/rbKRelbduKj4y
         sFJnVRMP0CCx0d7QahKqKzutFOuLrZvPAWJXws/9flNnORDMKVVHweamgka6/GWcfytU
         jaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764923768; x=1765528568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WsEibAAOLXIXMNB/I4Bee+8iop+NcyUJNn7OWP7xy4=;
        b=po7k+yt2yW295qTNBSC1CILTm2E7cztffVBNLCoxt2FitHv2A0x3pP3AxrLRynphuL
         Ym24tf6L6q4F4g8w/22pCOUG13Z7CW9JAAYCqyCxr9iEXofxTQT+5FEdup+QmJHrJ4xc
         rKFpXF1S2vXwDDtrDRNR9714haIXA+fBq8VmKnz35mKsHJula4yetbkoTQXSA1NOXe0D
         1umbjHuI1dgndBtACZqAoMF9RqP0LkJHCgPJ0QW5tS7f71r9neqSi1j2fFjx4lpkKB2v
         abQtaU5sQTpLrr5jSHWYqY6gShigBCHeWI/ehkG8q2CeIXGwLod8/voRe5RGdtOA/Con
         j14Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfUZJGt0ctEmyqdcxW4J9/C7Jcp0UayW6ZLgGEuVLJimnBOnk6LdWj7kTCbONwppkgRJVkMNuyXVTuilQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFnwWoy57S76fOm8YDcsMb+xJxupK1CHG8BGrZM3WsxMQefi6
	U/fv5mOz0vpKjWhXpYbOlO61EKEtLfrH38S+4KS9BaxQlKvPJvaTUy9bxBNfLTAcNlg4tfRsWP9
	iVoVxPcQSUB42jH/bx6ivc+2Vuc3xJ44=
X-Gm-Gg: ASbGncv0N/Au3LbsOw7pzhR39LNq5awLKPkDcp2HlxHNqcWf01NTdtOqG4FBpu42/mi
	CslP7g8dHUVp8id07KaQdRqiY5Vjwu9BRHy2ltY/zVCQ6WMADTIfFBgXFQme8msmPgrTofmPuqW
	s66s3YMcctZjTHUdLS6NFPTkbldMJTCpX9TGyro4NfzQOzwDaEPr/7ItDown9H6tKhJcYrZwFpr
	c0CcwO8WxFBl8dCJRJEhy1BeLOvSUgj6n2CU3lK9Dl4HUM8dQUW4gPy7iv8UTmm4rqcG0XBtidR
	z6oKQJdz8whH6C9fNhFh7TqGhWN4uXWq5gcElsJ+qom4c/9UCLGTETdeRbYn0yQXeKTmz6k=
X-Google-Smtp-Source: AGHT+IG04VmPy9dMr6ehZfnq/e/wJ+xI+lynpamKtF7Aczr02JvZkxHH+d1kaKH9i9QiOFMoi44boL4xp7wBdoOIMuE=
X-Received: by 2002:a17:906:4fc9:b0:b73:2a77:3128 with SMTP id
 a640c23a62f3a-b79ec4882e0mr582546766b.27.1764923768066; Fri, 05 Dec 2025
 00:36:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
 <20251130104222.63077-32-crescentcy.hsieh@moxa.com> <CAHp75Vd4Fr9j3XF3Mxte8NDw_cE+_cyhWh=xs6YMQDTrmn=XnQ@mail.gmail.com>
 <aS-mugqHvS-OJvtU@moxa-ThinkCentre-M90t> <CAHp75Vfqi3Cqm+vMC=VXWCsVDP1926gpU+xxocHnVgZ6Y2fyEw@mail.gmail.com>
 <aTJtEmUycXeGrYPJ@moxa-ThinkCentre-M90t>
In-Reply-To: <aTJtEmUycXeGrYPJ@moxa-ThinkCentre-M90t>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Dec 2025 10:35:31 +0200
X-Gm-Features: AWmQ_bnIgh4OeIrq7THoiyz7BG-NnMndETRSgFRGPXiHapuS426eHPZuMu3uJaM
Message-ID: <CAHp75VdnC5FmXzf3oTqo0ZGZzwkd_+GAioTAss8EBCcVhC5Kww@mail.gmail.com>
Subject: Re: [PATCH v1 31/31] serial: 8250_mxpcie: add RS485-2W auto-adjust
 sysfs control
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 7:26=E2=80=AFAM Crescent Hsieh <crescentcy.hsieh@mox=
a.com> wrote:
> On Wed, Dec 03, 2025 at 11:24:58AM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 3, 2025 at 4:56=E2=80=AFAM Crescent Hsieh <crescentcy.hsieh=
@moxa.com> wrote:
> > > On Mon, Dec 01, 2025 at 04:45:58AM +0200, Andy Shevchenko wrote:
> > > > On Sun, Nov 30, 2025 at 12:46=E2=80=AFPM Crescent Hsieh
> > > > <crescentcy.hsieh@moxa.com> wrote:

...

> > > > I'm not going to review this, the patch series is already quite big=
. I
> > > > suggest you to start from the small things in a different series E.=
g.,
> > > > the first series is just converting MOXA from custom to 8250-based
> > > > (assuming all features are kept working while ABI is being broken,
> >
> > In case you are wondering what I was talking about in the above, I
> > meant move from /dev/ttyMIxx to /dev/ttySxx. This will break all the
> > current kernel command lines and hence setups with the explicit
> > mention of the /dev/ttyMIxx, such as console=3D.  There might be other
> > breakages, but I leave it up to you to research and come up with a
> > solution.
>
> Just to clarify my intention: the in-tree UPCI serial driver (mxser) has
> been unmaintained for years, and my goal is to replace it with a clean
> 8250-based implementation that preserves reasonable user expectations
> while following the upstream serial framework. This will require some
> analysis to reconcile the legacy behavior with what upstream expects.

Right, so it's a good justification to break the above on the
expectations that the users most likely don't use the in-kernel driver
as it's unmaintained and has received no bug fixes, etc.

> I=E2=80=99d also like to ask about patch ordering. Since the PCIe serial =
driver
> is much simpler to migrate and has minimal user impact, would it be
> acceptable to upstream the PCIe conversion first, before the more
> complex UPCI transition? I=E2=80=99m happy to follow whichever order make=
s
> review easiest for you.

I don't see the downsides of this order. I believe the order of these
big parts is not so important per se.

--=20
With Best Regards,
Andy Shevchenko
