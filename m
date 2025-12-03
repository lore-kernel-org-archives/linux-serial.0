Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5182DE6F7
	for <linux-serial@vger.kernel.org>; Wed,  3 Dec 2025 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754135; cv=none; b=qk5H5ORtMaMHytMqou2FwTzE4DOXM0HxlW+9UsN1FwiRXSTnFHybk0a/+mx9O/TgFftDFwvqaBuGRP5iwhiHjPJpohUNhaaZjd3C4TZWyttaBTyo8CSAmO3xm8vtyvs5yK6dKf2O6AFDtsYCwtp0lZ/UQqHyDLmxTMHOxHRcMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754135; c=relaxed/simple;
	bh=BDToOCIH5xTOtXV+nLCDcmNfqHeR0yw3F3MI96OBPF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5RQr/qDhdJl2nhTQqP/BkkXj5wEuXjw1BZWQFpzl+tXSKSRYjGCvw3w4B2itzVBg0ygzEjvv+OTu0VOqhZw5uz4YVaE49DLATfnIJ8XgB43NTXYyXQ/f6IUtIziJH68QZf/4NrfFIotThPK3Bgis2825gAL45ZYjckrEV+/rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMzTtAZS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMzTtAZS"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7373fba6d1so1022925966b.3
        for <linux-serial@vger.kernel.org>; Wed, 03 Dec 2025 01:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764754131; x=1765358931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YuW6FaHX+QSnb/Uo0MBVSpTHYhpNNL64PfuqITsrWE=;
        b=HMzTtAZSBDOV3ll8dXgtQJ8QXFNjNHJIS4cU0A15hH9FVLvjP2nT6z4tHzkejOo6/A
         z5eD+Dslz8O8nP+1Q0NQGA3Yw8R9G9OiUbad5281QyjVnMk1dn/GIKZ1TgN4McMKppKL
         gqCqloBN/ux6DgXzOZKn8P0QXwZngC3/JTKLBIk3QdRZ9z3G6mvts/gKmBJEGV5Dd8SR
         5wfx0P3Q3jiaXhmcmHLdOY6qml723Y5/kYAnqq3CGXh/h2R7cMhmhBdziZBbQDOvafKm
         RIlqXA7eTLZVONumNdVg+OVd/iS4uW9GIH+Hg/qXX0arIs5Qe4wnwYqdr/vJhPkkYlwl
         JZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764754131; x=1765358931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9YuW6FaHX+QSnb/Uo0MBVSpTHYhpNNL64PfuqITsrWE=;
        b=S0bBME3GhOzcuyvoIfAjUktiyRCOA29ZOpdiuI7Clq+nBAO2qD0x8oxhJywBSUyqwq
         JA9KxbtdTudlzdtwLLG7y9zzNx3KNjYUIhXyPQ+tf7ZzkulutxqeqXZ4lf+X3Ep8DUyS
         GNSREKxj2Vj3TQ7RKfyzwt7mA10ua1fe5Y9qQG8hOTObvXRXttek3WpFf4n00ZAQ/qUd
         AawKpuM5Vb2HA0iT3EBruGR6oNXk1vPClVlO8uUPl8L++pm6IJn6TVfcPRP4MipqSHZJ
         K37pMOjkkKsMpkNqmF5B5LFWwG0iNVgFejmJOCg6vWxSwkaXC2KDVnL9yqf+/lnZkSan
         jgEg==
X-Forwarded-Encrypted: i=1; AJvYcCXTMWep1hq2UNX3Tcg7jCqtOkJ1aerRmMXm2oodkT1VaaLg9CtRbHcWBli4O1oH04hBdmxDBah8uzz+m14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH121f5k58T7lpUOhMZUxbEIBQ8JR0hK0bvtAOXVPrbWkCBvpb
	VJeZJyEMUyR2TgXBfjPd+lPq3dqgIECL1S84/dru8aXnQUASLJK405WJ/KC8RCGvNsM1BoxyaOJ
	AHBydn+mTLnPmDnry4vrzXUnAGDHE9z8=
X-Gm-Gg: ASbGncuKeH5BnU/XXw4b5oCbmGNn5Bp8YJaJf1NCxBR7skHjGVbBYudaWIhLsLzLwcJ
	FHmHfdG3kJ4fjZZ3TVz5P5o9ECsIw4NaFtK53Lrm9a/pnoQF6ljvFJ7M5y3Pu9dTE9spPDRjy9P
	UGx+ZuJ4KkKUAKf0HeM6TEykypLBGCKhlBkQvKupHUzbfB/Kgk0FzafW5y/jwWKFm7Rl1L2s8dp
	TELljDi+64TqtfmWLrpwIP4OR56fJmajAMhKYZH9jSvS2wKun3N51ed1EhNWIgY+9+rWcKBDvRp
	hU+vBDPkKlSSNCbyV7yNI/g6gIK1NhK4HNPYdFSQpQOI/MSXv25lTNzFYf22/i72d+z1Ug2MtCr
	omYiZow==
X-Google-Smtp-Source: AGHT+IFoTS6AMamh0oE3R1bplcL+6AiNiAZnIm4fm/Y84WRE/Wx9U+TmbWFAY4gbSKbzCt8DpRNgFktDa7myF1Qc9rs=
X-Received: by 2002:a17:906:f596:b0:b72:9d0b:def4 with SMTP id
 a640c23a62f3a-b79dbe8e7e2mr172316466b.18.1764754131222; Wed, 03 Dec 2025
 01:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
 <20251130104222.63077-32-crescentcy.hsieh@moxa.com> <CAHp75Vd4Fr9j3XF3Mxte8NDw_cE+_cyhWh=xs6YMQDTrmn=XnQ@mail.gmail.com>
 <aS-mugqHvS-OJvtU@moxa-ThinkCentre-M90t> <CAHp75Vfqi3Cqm+vMC=VXWCsVDP1926gpU+xxocHnVgZ6Y2fyEw@mail.gmail.com>
In-Reply-To: <CAHp75Vfqi3Cqm+vMC=VXWCsVDP1926gpU+xxocHnVgZ6Y2fyEw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Dec 2025 11:28:14 +0200
X-Gm-Features: AWmQ_bmyu8YrhJfqTTyeeoQzdwlWD8m-WlrWKXhnYYVHGbovmhnzpQum4fcJ8po
Message-ID: <CAHp75VeVxtGCMX0_Bxcq2vEBtWcp+Q340b4egD6xBERqFcna8g@mail.gmail.com>
Subject: Re: [PATCH v1 31/31] serial: 8250_mxpcie: add RS485-2W auto-adjust
 sysfs control
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 11:24=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Dec 3, 2025 at 4:56=E2=80=AFAM Crescent Hsieh <crescentcy.hsieh@m=
oxa.com> wrote:
> > On Mon, Dec 01, 2025 at 04:45:58AM +0200, Andy Shevchenko wrote:
> > > On Sun, Nov 30, 2025 at 12:46=E2=80=AFPM Crescent Hsieh
> > > <crescentcy.hsieh@moxa.com> wrote:

...

> > >  while ABI is being broken,
>
> In case you are wondering what I was talking about in the above, I
> meant move from /dev/ttyMIxx to /dev/ttySxx. This will break all the
> current kernel command lines and hence setups with the explicit
> mention of the /dev/ttyMIxx, such as console=3D.

FWIW, we used to have in the past more than one case like this, so if
it's well justified and customers are aware of the change, it may go
in.

--=20
With Best Regards,
Andy Shevchenko
