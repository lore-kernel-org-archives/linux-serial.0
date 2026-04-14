Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8283D564B
	for <linux-serial@vger.kernel.org>; Tue, 14 Apr 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162564; cv=pass; b=DaXddrnEKt6kcs5i98/Vlj2vs1/lCNLHMkVoSFbYASeUk+cVUVByI+MGao8dfuPiSqK5DHlBXgotUb6XWRarrR+Ig+6BoF9jeUfZUcBo13+21RvxCR6gcEB4gWVZCbevL01M4C/MKrONqJdhTlHZ/ZHSetrK1axcE1uygmaU4TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162564; c=relaxed/simple;
	bh=Ido82lTsBObPiLyE+cnbnYTa5RnXovthshiMl4cqqxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ez7mkD2CATGAzquRGA8c7P5NGrb8OCVvKXbKNPFx/FNtYKjHINlIjWG69rcfj/6Hzyp7k6JdSNTBfRdcfkSYEnKovmQP3h2vVSzbp4s2+IRZJRI2EIqlB+DSTpobrJWd0JNE+h9XH7OxzgE3hU/G6J+rdWZv+gNzKch36PqYUkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CAg1W+YC; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CAg1W+YC"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a2beae348eso5882533e87.0
        for <linux-serial@vger.kernel.org>; Tue, 14 Apr 2026 03:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776162554; cv=none;
        d=google.com; s=arc-20240605;
        b=R9U9nUv9yZjKYUxgEOFCz3HU+UIcYE2/KtaHKpZWBVMS4ngMXCUZV1um1SLfaVjbqC
         gqCHX03KBoJFAKmC09dlT3mfPPcQ28k8ZFi6GpY9FFXN/SwnjM4oZrCGKXhBpOdRATZR
         mEfFw+0s6psfPT4Zz3cKGD6EbjaF0pzeLu6akkHnmXMf0kCq9EaX8em999bfuZRAreML
         SLAMGXfghj+ui2q8CJ/NQjy16O8Q8CYTFgsOp+D36ys9X/dmFXwXqCbhPg2qLhmGpxhG
         uVzROd1t7a8SWX1KlCfZtYXtuviGXsKYa4mxETtv4z2l1YBBs9HwsoZYF/C6PqHzNanY
         s7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        fh=4Q7/k1rbwYJW2lW5ZO0Zjf3WIk4MEFnVBYk6BfO6Dhs=;
        b=imneLh7Ak2CnKVrjmd0bk+A2VzzdpAWXSfDbYGJx1VzFF/8dXSqPELCyzS+1484ktb
         VATW+arac4Ie0E9zPfr1nqoudpQGv9yALCJ5jQv+3xR9cEhfq7yyj0w4sA90dkmMLTU2
         gTRm8mBwjfLs7JtnLoJjo9f51OU+AFOpIxZmC6zG2l400/8CvMHeLhHCw5bzbJCJ2awP
         2acFDI/x9hNsVWLlZPtsMUzUwKS98fv1gNKYgaVyBg5MywpvGDAk15/qzIunBF6iUI8k
         D2j4wrdnN2YlHxnEx5k/QPVEqD4RxhFn5feLuqgCmgQI4bXYOYfhY/g88+mrffJwS9ZV
         BKog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776162554; x=1776767354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        b=CAg1W+YCDWa+7hMyoFTX9wrJnea3anbAiHdxWmpDFPNhe7kCyRPxDRCs4+n9KcUSjl
         w6nzvTJigwS7oM6UFv5A3HKxmii0VyJz1d3VSyhkRHh9KbLCHy+zvkfyRpySbb5xZhZu
         JuL3QYV3wyDOI2wfxl8ehTcAnuZZDMlWKsh4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162554; x=1776767354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obCwu9OJRNTUN7BsZbzZ8PH73jQ+TTI+BXXfuHZowXE=;
        b=Fmwoq89r1rSCewAtE8EhKiyc11cEbcan5aOugYWJZVYJhVptkCKMAm+8V9uP1e3RqY
         O5L79CiZ3qiZCNz1n2o89+1G5vuqcgBy6pu1wyXFJ3P6rLkKPpPtqkABNfenUPZGlDh/
         +cVa/EyP9qq2+ZijqfMF9OgpovcFHe6G5j5sd6/dtRZbmfT5Lp3XdzV6WDal+yJUIAkH
         zlyKIZP/LZ1hd5pjSoNLg0jeltZrPYEK0MgNbsXMA7Lw+6CQ/CGLOT1Jp7J++sWYUDne
         CNEUNhrX2aMn+k51GN9U/yqO/2bN0k6RhrbZuOrexPxpdLAn6zAqGfzCWvdYdogBUNDV
         Pvpg==
X-Forwarded-Encrypted: i=1; AFNElJ+voMHvgWZUuJ3z4+HxYAj0QUOzJK8d7PJA/ByYl+Dc5FJtcA+xKP7AB2qr1sFEVsfCrl7Aanhe7gRI5gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqAk4fjcZxmzN9FgVQmLQndlEkevSIiePDvSaQhgyRW0ZjUSr
	sZ0h+8ngJwgJ7gKLB4q8kpS3Q2FgBryKFAWZWuZ+cpmKQzTtF7oee7B9KST+LXle8tA3iZsFOt+
	dQtp95Wy0o4qzcNDc8xOVZyCz80M+drGXVBmsHxJF
X-Gm-Gg: AeBDietlTp8vHZvQ+u0mj8oCi0XKJjd4UuUVsJ+M6+hGB/JGHB3RSAc6oBxFq8yzWnW
	3AyciJYmzdmcRhN4IKhMGP3Xb4mZ1jFw6O5q5stHrEZ+uPC541uvkMEPBNQTj1S9Y5sEp/eXsUj
	Xj5ESBJOpKIQwwlpJn6Cqu6z4BWHlvhsjf9BiGkYMKDNx9hYXLz6hlfFiQ7OqteqfFYIlx0znRJ
	s00HZg6tbST/Z3WHJIAN06gFdR6YSeHpwh++WZerMj5uHEWYU/GMfd+tgc4JrgllYKgZ02NwtpI
	fgcTAtdsaCCQ9JdAaMSuZNfxsMKXJ6wyryqn/fIiyTJaBiPY
X-Received: by 2002:a05:6512:68e:b0:5a2:ae27:c879 with SMTP id
 2adb3069b0e04-5a3efd7f0d8mr4850095e87.29.1776162554447; Tue, 14 Apr 2026
 03:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
 <20260413075459.GA2626902@google.com> <fpcs4p62f35a5qyqwgm5ysa73stbysxcr62tkmmkrrcvsuf4t4@4ivukyqjey57>
 <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
 <CAGXv+5E=tujhtZjwi6Qm7hk3Ks74UzTQHWq82NiTEw1+vYod5g@mail.gmail.com> <ad36pIu-0dutL7Nk@ashevche-desk.local>
In-Reply-To: <ad36pIu-0dutL7Nk@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 14 Apr 2026 18:29:02 +0800
X-Gm-Features: AQROBzDHB_HCwto4iaprIWgL7mrQWt62yIrtGAtxckKlX4EUkJwTT3ZqPu-YslU
Message-ID: <CAGXv+5EGe59nJctLweEdZjb3MNmMvjuCHngGSfptzN985OiLdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 4:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 14, 2026 at 01:03:19PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Apr 14, 2026 at 12:08=E2=80=AFAM Manivannan Sadhasivam <mani@ke=
rnel.org> wrote:
> > > On Mon, Apr 13, 2026 at 07:33:12PM +0530, Manivannan Sadhasivam wrote=
:
> > > > On Mon, Apr 13, 2026 at 03:54:59PM +0800, Chen-Yu Tsai wrote:
> > > > > On Thu, Mar 26, 2026 at 01:36:28PM +0530, Manivannan Sadhasivam w=
rote:
>
> ...
>
> > > > > - Given that this connector actually represents two devices, how =
do I
> > > > >   say I want the BT part to be a wakeup source, but not the WiFi =
part?
> > > > >   Does wakeup-source even work at this point?
> > > >
> > > > You can't use the DT property since the devices are not described i=
n DT
> > > > statically. But you can still use the per-device 'wakeup' sysfs kno=
b to enable
> > > > wakeup.
> >
> > I see. I think not being able to specify generic properties for the dev=
ices
> > on the connector is going to be a bit problematic.
>
> This is nature of the open-connectors, especially on the busses that are
> hotpluggable, like PCIe. We never know what is connected there _ahead_.

I believe what you mean by "hotpluggable" is "user replaceable".

> In other words you can't describe in DT something that may not exist.

But this is actually doable with the PCIe slot representation. The
properties are put in the device node for the slot. If no card is
actually inserted in the slot, then no device is created, and the
device node is left as not associated with anything.

It's just that for this new M.2 E-key connector, there aren't separate
nodes for each interface. And the system doesn't associate the device
node with the device, because it's no longer a child node of the
controller or hierarchy, but connected over the OF graph.

Moving over to the E-key connector representation seems like one step
forward and one step backward in descriptive ability. We gain proper
power sequencing, but lose generic properties.

The latter part is solvable, but we likely need child nodes under the
connector for the different interfaces. Properties that make sense for
one type might not make sense for another.


Thanks
ChenYu

P.S. We could also just add child device nodes under the controller to
put the generic properties, but that's splitting the description into
multiple parts. Let's not go there if at all possible.
