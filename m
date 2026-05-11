Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F43C3C12
	for <linux-serial@vger.kernel.org>; Mon, 11 May 2026 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490024; cv=none; b=suBYrvT4Zm5kVnI/fE5xGeoV4rLxTHt7uWj7o/ijumXFFx7+pFccCNi7472FJR9yqXD+V81zKOn5Q8L+3VGngDeRGL4pDVIy8CFgg2xH726BYcOjHjOo7000C+gxGSR6AHcjM2qUpzSdw/GJXEntcKUihiRbYPpsgAISUceATl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490024; c=relaxed/simple;
	bh=CFVno9Nsq/hvsU0eZZtsglitWo5gwSvgnKfW0LBnyoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZORP3T0B6FS2NICNV50kOo/E3zZq3YhvRp2zkpo3vQ45Iy6vIIesyvXfoHrX5ZOe1vB6hwPwMBbkW4CQrfbyEj7dbneqooYPaoF2yEvdxkOUZ+hg4Z7lXzsaxO4fc0KP5uW14uN0QQdrEGc31e15MfumQUOv+li9z4nOZIKJek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adBQELrj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adBQELrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF92C32781
	for <linux-serial@vger.kernel.org>; Mon, 11 May 2026 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778490024;
	bh=CFVno9Nsq/hvsU0eZZtsglitWo5gwSvgnKfW0LBnyoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=adBQELrjXkDuujWs40KxsrFPAbdty+DWYgu39WdyuJG4GC7oVoivxsJh6+6T9uyUG
	 sMHKYx9RR0GTBuqVzz4QiFCR2/pIYTQI1ojDAZ/ayjTiE7y2JgPqN5QFcqpUfWNMx5
	 pKEtGRvH5xmgYxaNRiPVnM0bp2Z8obBpkSbCOMdZ+/j+Z9uromqBoJGYIg1SyD4dB5
	 3FXoxyeXanWVmIFvQdBROjRPHuPJGETkDaOLBiyDqnIqtps98BPJLMRaoi2DnZ6f9y
	 Vg68VW5w5KR7GO3O3fGMT17IQqIuwg2ZA9lxTq3b4KxjD/PfWzMUzSUg6Y01++2rIV
	 r+nW/BO136GNQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a86bfa2a4eso4672702e87.1
        for <linux-serial@vger.kernel.org>; Mon, 11 May 2026 02:00:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9k96993Mb0dSY9gfSYFqpx+oSy69PDWzapB2iAZJQnrYpW3Y2gAd+tqALvKcyFv5oC2T2/DId8mT8m3PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZsGLTzNLrj0Hg+5G7k/xojAskdT2URaS3i3UmOZP+kNeJlTe
	CH3k3BDNvj98Go/Y1HDPRfYrRhL1QAkCqEf/uzqUZw9fATFeO11/nq9uhI0bE2Ow554aWwKwl8f
	S4mipMO/ULN0hieHsJKrXWf94lHwMcoI=
X-Received: by 2002:a05:6512:6181:b0:5a8:d1f3:4f8 with SMTP id
 2adb3069b0e04-5a8d1f30770mr777984e87.26.1778490022755; Mon, 11 May 2026
 02:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-send-v7-0-b432e00d2db8@gmail.com> <5379905.31r3eYUQgx@strix>
 <CAD++jLk02QnkXYwJ0b6x=qw9stR4nPrjD3sYPOvWAQz8t9OsUA@mail.gmail.com> <23095518.EfDdHjke4D@silicon.doe.home>
In-Reply-To: <23095518.EfDdHjke4D@silicon.doe.home>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 11 May 2026 11:00:10 +0200
X-Gmail-Original-Message-ID: <CAD++jLniQfWXGe3dK=StOGv62mi_3fEHVdipUavsFGSrNm6cLw@mail.gmail.com>
X-Gm-Features: AVHnY4KhmRCq90-NzUXRaDHZYtk0xNB10BVaq7CG7fH-NLC_5K23qELlHwCuUpk
Message-ID: <CAD++jLniQfWXGe3dK=StOGv62mi_3fEHVdipUavsFGSrNm6cLw@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] ARM: zte: defconfig: Add a zx29 defconfig file
To: =?UTF-8?Q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Drew Fustini <fustini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 12:09=E2=80=AFAM Stefan D=C3=B6singer
<stefandoesinger@gmail.com> wrote:

> So I read https://docs.kernel.org/process/maintainer-soc.html a few times=
. If
> I understand it correctly at this point "pull request" still means emails=
 sent
> with p4, correct?

No it's the contents of an
git request-pull v7.1-rc1 git://..... tags/my-soc

put into a regular email and sent to soc@kernel.org.

I'm sorry if the terminology isn't always clear on what a pull request
actually is in the kernel world (as opposed to e.g. github). It's just
an email with request-pull contents and some cover letter.

> Or does someone create a git repository on git.kernel.org
> for me that I can use to send actual pull requests?

We can pull from wherever as long as you can sign your tag
with a GPG key that we can (in best cases) trust. We can also
just inspect the result of a pull request from a branch (no tag)
if we wanna, it just involves more inspection and trust.

> As I understand it, my 6 patches then go to the 4 corners of the kernel:
>
> Patch 1 (dt binding) to devicetree@vger.kernel.org

Nah as long as the DT maintianers ACK it (i.e. Reviewed-by) we
can merge that to the SoC tree.

> Patches 2 (platform), 5 (DTS) and 6 (defconfig) to soc@kernel.org, but no=
t in
> one series but 3 independent ones

In an ideal world.

> Patches 3 and 4 (UART) to linux-serial@vger.kernel.org. I think this can =
and
> should be a series of both patches belonging together

Yups. Greg merges those.

Yours,
Linus Walleij
