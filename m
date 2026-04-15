Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69F03A3E78
	for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241899; cv=pass; b=AMX2n4lmdbL2RBGWD/AoJDgG4VCV3s9daBz827ecUpnNMETQH8jCTTLNG6wzYy/ZQ1pd0rXji/bOeHDge+teYSAlbK6PVvmnqciaQKKy0kFxJnT/UCU6eTGmhnzWq5fEgMiJ9v4j0HMoOvqfRIveXcQadcRy27mENo0zjtZLrYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241899; c=relaxed/simple;
	bh=2vto3FW353Zu82QYk26GNUwn95iDmVTER564VnZJYjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqteitC2bBL5adDgMcVv2WdOUzUDxmGAsZRjeGDWbDY2nqk5bpXrRsg6OcGdG0ndNoseXyx2oPrHKzBUXiBdE4tLuhlTce5PxFRKNr0EG161ToZzCYBGXjcoJMl1G8EEQR1MvFEjaVhUBQCG/dDBVcUfKkz4AP31Tu8r4FdhGss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K5UGAvvF; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K5UGAvvF"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2b636b944so7381495e87.1
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2026 01:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776241896; cv=none;
        d=google.com; s=arc-20240605;
        b=jTt8tqi32WgFCk1EurK1dnc3jXcCFiBQDBlKND6B4jIMGFPNwTGNkn/nhvbhpHLIqH
         HTyLBjIrpe/+YBWfbjDsfl5qmV84jgSk8TY1H3Jwjp6/Qp893LOkvgeQQO+ZRKSHo/0c
         jQZ0gvPxWOnTkWrT/W6ZwNUzuIfSWTXfkqMK7xChUCHi+QebPdcA02bzO2JmBph8hs9k
         qezBK8qU22TOrV7PoPg4DncjM0vbWIIz2NRoUPIYJbubxZ0U3efpLLKMpsQNt/bQa6pN
         zVWwEtLNaov9BF7or203lxvjJz9a33l/RGaAbYaCjmySw4i1gUCFnFhenVLs/IoGt8sd
         BrrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=75qqfi9qSpcNd5UITToYiihcYMMpTHFOID21ZWu5+AE=;
        fh=G3Y2cg9JaWYsaKjVnoHc3+2wCyuAB1gi5y3HxkzyJWc=;
        b=GcJW6uM9zb4iOwydLoQyHSN5jhjL9LVg3pSAQUO9CH2MT82ROJWYniAK3XiMzjYJS9
         Ifxneo0RAAirr09qSZ5spvB5TAyFPjnp1cOIa1ahv4OoiHJ0mupOyvbMdiPtDiWgfCpF
         rl3N6dJrAIUMjDm5v/ajBvpbJ9bg/HGYtM87k6L4gB25fl5Yon+cp56CMr9MfKxUX3TN
         DsFBhcRwAz0Z8aozSJDp89SgqTPo5vKJd7qeoJ6bQrINa2I7PeRYC4gva4zNUQidK1K6
         Ahthy44O7RKpqa6DWTtwnoGtb0foQIgQdIbmhkOdxQqMO5j3TFmaocSHrCLoilnFqeF6
         LHnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776241896; x=1776846696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75qqfi9qSpcNd5UITToYiihcYMMpTHFOID21ZWu5+AE=;
        b=K5UGAvvFYCw1lKIySpdxs+2VhQlu1DNfkQnTJo6uJshdmSwQBoqYPkYm885x67rk5A
         Sj0gGABTH/LttyV0M6yVENkD0MxhWEPS0tm4ubGvXt0SFTGMEnMnxewpxBPr/X9Kr5Cd
         qAZ5aXEbrM+4DvQYOBBKj/rlzLSiDmcR7mKsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241896; x=1776846696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75qqfi9qSpcNd5UITToYiihcYMMpTHFOID21ZWu5+AE=;
        b=FkJWMLQAmOF3KIlfEYqoDHgb0SlX0kX4hVCNuxUdYfwLKP1j0nEJjG9SfEObqRoypN
         Q9UfMUFWXYg6NF+LKfAoKNgqqtURw6Iywrpl/tioXDpYqPVWyiz4256j4motS9aXjoaJ
         nOLVPGf9pr4jpCBHUnpDpxCP0NBoHwRJLXotpNbIo5u1PctRu71T8ap+1P813E19NKQ3
         U/MjyfaxektX+KeSL8DhQJlUgMAQvzgf+LvxB6QcqaNwbyYZe/ydA/68IUi4VsHyDxeJ
         lVZ+dsuaZd5nuCxsOlp4WSebQ9pv18t+bVYvlBf/9ig++1Wke2MDdzxABeFlEUGQhmQK
         XScw==
X-Forwarded-Encrypted: i=1; AFNElJ+N/TzCOjMoPKiZ5Z8xROhdq93h6LCttBME+itfDvM6hBiUkc5OJEgngRSWLesYW1t+KCTjkwiHqE/iZAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6zrwBLUyeArHNocjxvHC80Z3VKJTQGwRlQgPB5o1tWaWYOr4
	/biEHi1dL4LcG/SxN6UE4YiwwhRnxO/Ure5Ul8JYIgDlZjOoGShYyKSTp3giTXCh15T/34eFhgx
	LhjiS5QqqzjyJrfHW7wiypN/mY+/jhCDCoqSh7Sfy
X-Gm-Gg: AeBDieu5B9OFaUnOAEAHnsMJBVGf2TBBkiQbT8mZ2JT0UQ9DIiHuaa+MzZmoqgUGmt7
	IWVJJasoOwhFIH6PxhJVZg7KKS5a+mq3AQbgvgxjSF9aO2LZk8/6KlOBFnrDolxRD9YsWpbu6Og
	70itl+3dAcmtIxyFMxw+7G7BmqoqapedOvOY7zB2R2QwRG+UPr2UuxaPudYV5hbYqTGgn4VTPbS
	P1tRG1PMA0e0npY/KoGpgpcZIyEGhoyOavK2yjTSCMmoXToxYcwk+GnndgKmbbI7DoOzlaeJ9bI
	T6hYfIwCfjkgpkaGQ/U5xi3llJgB3opoMOTkCKk5F6N6Xa9d
X-Received: by 2002:a05:6512:3e26:b0:5a2:a174:8958 with SMTP id
 2adb3069b0e04-5a3efb4968emr7410769e87.35.1776241895968; Wed, 15 Apr 2026
 01:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
 <20260413075459.GA2626902@google.com> <fpcs4p62f35a5qyqwgm5ysa73stbysxcr62tkmmkrrcvsuf4t4@4ivukyqjey57>
 <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
 <CAGXv+5E=tujhtZjwi6Qm7hk3Ks74UzTQHWq82NiTEw1+vYod5g@mail.gmail.com>
 <ad36pIu-0dutL7Nk@ashevche-desk.local> <CAGXv+5EGe59nJctLweEdZjb3MNmMvjuCHngGSfptzN985OiLdg@mail.gmail.com>
 <ad4tJN27opdEooA7@ashevche-desk.local>
In-Reply-To: <ad4tJN27opdEooA7@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 15 Apr 2026 16:31:24 +0800
X-Gm-Features: AQROBzDzEraU5iaeBZSJUdxidhUdHObcnpB5nGLDAzHMGlTf0-gnuExg99lbWBI
Message-ID: <CAGXv+5EPA29G-fsH=wWOD8AK6TZFezFhsE0NHPYj_Pt3nT+d_w@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 8:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 14, 2026 at 06:29:02PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Apr 14, 2026 at 4:28=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Apr 14, 2026 at 01:03:19PM +0800, Chen-Yu Tsai wrote:
> > > > On Tue, Apr 14, 2026 at 12:08=E2=80=AFAM Manivannan Sadhasivam <man=
i@kernel.org> wrote:
> > > > > On Mon, Apr 13, 2026 at 07:33:12PM +0530, Manivannan Sadhasivam w=
rote:
> > > > > > On Mon, Apr 13, 2026 at 03:54:59PM +0800, Chen-Yu Tsai wrote:
> > > > > > > On Thu, Mar 26, 2026 at 01:36:28PM +0530, Manivannan Sadhasiv=
am wrote:
>
> ...
>
> > > > > > > - Given that this connector actually represents two devices, =
how do I
> > > > > > >   say I want the BT part to be a wakeup source, but not the W=
iFi part?
> > > > > > >   Does wakeup-source even work at this point?
> > > > > >
> > > > > > You can't use the DT property since the devices are not describ=
ed in DT
> > > > > > statically. But you can still use the per-device 'wakeup' sysfs=
 knob to enable
> > > > > > wakeup.
> > > >
> > > > I see. I think not being able to specify generic properties for the=
 devices
> > > > on the connector is going to be a bit problematic.
> > >
> > > This is nature of the open-connectors, especially on the busses that =
are
> > > hotpluggable, like PCIe. We never know what is connected there _ahead=
_.
> >
> > I believe what you mean by "hotpluggable" is "user replaceable".
>
> From the OS perspective it's the same. From platform perspective
> there is a difference, granted.

Yes. I just wanted to clarify.

> > > In other words you can't describe in DT something that may not exist.
> >
> > But this is actually doable with the PCIe slot representation. The
> > properties are put in the device node for the slot. If no card is
> > actually inserted in the slot, then no device is created, and the
> > device node is left as not associated with anything.
>
> But you need to list all devices in the world if you want to support this

Why would I need to? The PCIe slot representation just describes a
PCIe bridge. Granted this might not be entirely correct, but it's
what we currently have.

And even then, there are properties like memory-region or wakeup-source
that are generic and aren't tied to specific devices.

> somehow. Yes, probably many of them (or majority) will be enumerated as i=
s,
> but some may need an assistance via (dynamic) properties or similar mecha=
nisms.

Even if we wanted to add dynamic properties, there is currently no proper
device node to attach them to.

> > It's just that for this new M.2 E-key connector, there aren't separate
> > nodes for each interface. And the system doesn't associate the device
> > node with the device, because it's no longer a child node of the
> > controller or hierarchy, but connected over the OF graph.
> >
> > Moving over to the E-key connector representation seems like one step
> > forward and one step backward in descriptive ability. We gain proper
> > power sequencing, but lose generic properties.
>
> The "key" is property of the connector. Hence if you have an idea what ca=
n be
> common for ALL "key":s, that's probably can be abstracted. Note, I'm not
> familiar with the connector framework in the Linux kernel, perhaps it's a=
lready
> that kind of abstraction.

I'm not arguing for a even more generic "M.2" connector. The "key" is
already described in the compatible. I'm saying we should have some way
of describing the individual interfaces (PCIe, SDIO, USB, UART, I2S, I2C)
on the connector so further nodes or properties can be attached to them,
either with overlays or dynamically within the kernel. Right now the
are only described as individual ports, but we can't actually tie a
device to a OF graph port.

But maybe I'm overthinking the representation part. AFAICT for Qualcomm's
UART-based BT bit part, Mani just had the driver create a device node
under the UART (by traversing the OF graph to find the UART). If that's
the desired way then the connector binding should mention it. And that
works for me. But I think it's messier and also we're missing an
opportunity to make the M.2 connector a standardized attachment point
for overlays.

Mani, could you also chime in a bit on what you envisioned?

(Added Luca from Bootlin to CC, as I think there are parallels to the
 "Hotplug of Non-discoverable Hardware" work)


Thanks
ChenYu


> > The latter part is solvable, but we likely need child nodes under the
> > connector for the different interfaces. Properties that make sense for
> > one type might not make sense for another.
> >
> > P.S. We could also just add child device nodes under the controller to
> > put the generic properties, but that's splitting the description into
> > multiple parts. Let's not go there if at all possible.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
