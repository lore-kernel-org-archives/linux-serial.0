Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88D22156C
	for <linux-serial@vger.kernel.org>; Tue, 14 Apr 2026 05:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776143015; cv=pass; b=hXIYTIztjWDcT8I0fE94eJB1e1YFwWIvw6Kda1XGx78ZYkOuBy9nVLZ08MmCm1pM3jJhdF8Qg1LP6e45yOOGWa71sX6NeHYMHEMdUWcxUcyrHzocajObjAJvX10EgLdxF8d9ZatGuaaFo61iBkdiht5dPpijM+/n89vDqleiwAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776143015; c=relaxed/simple;
	bh=/ONKg0B1L6p4zm87A4DLLkuv8Uix/xcFzs6/+rsavpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6U5BYu0vn3wotd+iYFNuqz1c3vPxt/+aqQWl1vKOzOJ6CE3fT3s6qYK+97pqQ8In6DTi7pZFP9gnQgSKX5WbaMQG8W4cP7ksR2rOnIomET5ROow4wI65Vx4kS8M1EM2Nbb3FeusRbi2pxE3KV/C2vCYJOdHbLs7MOk55a7t2No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k9UhoHTv; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k9UhoHTv"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so7064767e87.3
        for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2026 22:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776143011; cv=none;
        d=google.com; s=arc-20240605;
        b=I17+ZYLAJHZ2Y2+PtdRwRnlT9r6QAEqOoNzdEQuFuuLQMOThKBH8HiKUuU/AAe5iU0
         bS9HCUtMbvdbUITBvLECzNb6JZEAHhvOmNakzebLqyITOsXtaR6uBPDit5UiF2hbtaZf
         i0bMz2Ucb8IWAt84npYs5q6CD3+JxEfEEtoCkNdgv5HELEp+qGL0FRL843p9gj6k8Dfa
         GWeTGEmpFVhFYXqQlKqr0wTWI0M1YtM0Oac04OBlu9pad67zeZvmnTd2jSsKxyELEZYn
         gXTCs9d1rq7MYwlCtq2NCCtwJxtPonOtADb+b1Wqk1krOAJsVlBPsFcLvg0sXlIxqYOG
         gf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        fh=17zfzAxFRIMVhOx3gwG7/VJVqEmhw/Blgfa65Gdln3I=;
        b=eXuRTnCe2l6c7TNzifIEYIe6XwIN8v753mU/akrvI9C+syImhfPnjoiYK2jtYrsgZZ
         BeWudPiDzLDa/rw62SUrGivOcQTAQDkghZEjdoyZJFd8ensy+v6aOIY5Ux0ghzFtCFAj
         lTT9fDJLjMjJgn/NNqI+OKh1mM8mVGnT19Z9c5TdiMU3KmdzRoseW7t2+l33apl2RJVQ
         3b6t45epaAOxF8xg8JUHlSrBqGou6JccgzrDiidqYUozk28h8vdBatPkzlvdITjeRKJx
         BThPvCUTnovQFVzN6/EuzSqGxIzNJjfJCZtpl8n/qR+fRVlpebCA1JTBsm9S+H1CHpk0
         xjsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776143011; x=1776747811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        b=k9UhoHTvwzyqW/zmjESMuicoMoBBYBtJZXWbq6QFAeMa4+SEzlP6xCid/jUtzhFNq3
         xJyIyFiHJqJBGmq6f4Ky9U44OV4gO45TCYbUBhdVkQgRk0UOyIW4aLZGwJkQoWb01xih
         L3eOsn1bPR/InfQYoUdHiO8laGxXIXZU4L1Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776143011; x=1776747811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        b=nl/DMQJ5dOdZ6hRMfq2Ou02VX1H1y530EVDA53G9hghgGqJDgGFHFUisVEScHuMjyJ
         itojWiMgVVwIN1JYlRe25f8DaVRt11M+zl0ubevRVvZe/uQUJcdSyXJt0grLMg5R/9uc
         lf0zrWhEDc0dKoc48TTtpyWMuiniNAf7kPBOqovFZVAj28eL5DGu1q6CZKwSbSoBd8ks
         Nv3y82a8R0R3tuHnWcCxj9a1K70IAcXcnmXScjGtnMKvX07i8G81y5Gx8aIy2RdouOzp
         u9lvww0f6HWh31i39oMKRV62ACFsP1zEYm4Ubh2Yh/1geK2OIJq8+UFv3fvLagvRB/ud
         nWJw==
X-Forwarded-Encrypted: i=1; AFNElJ/pXXKrrsSUyDeVTkMNKAlK8FgnXjCCDsGnVe5gaM4WuOOQRVGZCmUcgBWpi/nDJgZwZGXZto24JxIl0tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSWiz/h5gTHLraSt1eG6AcUnbEVz/qmOXvQgyQUV4MFJz3aDP
	h84ZhTrdm1Hbwukkbgn71jvZgBUi5ekq39yeJ+ZDV3nGNBO8adN7NWHVlvO1E690orCZakK31Bm
	OBZp4is8WGVRw1lxTf8jf0Rp6cJ7VXdhv73WNS6T+
X-Gm-Gg: AeBDiesufFNUSsK4tRnvNL5qHEJ2BCcSb7Za/oKBAjJEhlxTS9/VXAdRbjm9A5NwbjY
	3AbohlMWW/JW3gDkqTdRAcJFugDhTYVjF8LNFv3KEGEZzaofIMALu/bo16JIwGjcSFn2w1vtwI8
	XiHklwtNKUxz2YSrq+BVRHk/Lkk6XD7QOCgoRb4VM3hqf43KNr+pbuAMN1wrSNcA3dSrplEGlTr
	ru+kawLsSCqcyLAPtRxchI2Pp0h3J8/aZrssDOK5v3t1DgVfNBUv/Wr68hiOOJ6ENqWY5zOqL+9
	UefJ3KnZUg4dTfl+aHFgOV1TKJki44Vg5mEv1oDUxA5ifMNH
X-Received: by 2002:a05:6512:3d07:b0:5a2:bebd:45b5 with SMTP id
 2adb3069b0e04-5a3ef702ba7mr4942397e87.4.1776143011315; Mon, 13 Apr 2026
 22:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
 <20260413075459.GA2626902@google.com> <fpcs4p62f35a5qyqwgm5ysa73stbysxcr62tkmmkrrcvsuf4t4@4ivukyqjey57>
 <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
In-Reply-To: <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 14 Apr 2026 13:03:19 +0800
X-Gm-Features: AQROBzBGpczfuo3hb4EM0V1LAlLdphdlu-SZQrzKHBW63mwHzThEUJagiFr7yFk
Message-ID: <CAGXv+5E=tujhtZjwi6Qm7hk3Ks74UzTQHWq82NiTEw1+vYod5g@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
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

On Tue, Apr 14, 2026 at 12:08=E2=80=AFAM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
> [Resending as my previous reply got bounced]
>
> On Mon, Apr 13, 2026 at 07:33:12PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 13, 2026 at 03:54:59PM +0800, Chen-Yu Tsai wrote:
> > > Hi,
> > >
> > > On Thu, Mar 26, 2026 at 01:36:28PM +0530, Manivannan Sadhasivam wrote=
:
> > > > Hi,
> > > >
> > > > This series is the continuation of the series [1] that added the in=
itial support
> > > > for the PCIe M.2 connectors. This series extends it by adding suppo=
rt for Key E
> > > > connectors. These connectors are used to connect the Wireless Conne=
ctivity
> > > > devices such as WiFi, BT, NFC and GNSS devices to the host machine =
over
> > > > interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds su=
pport for
> > > > connectors that expose PCIe interface for WiFi and UART interface f=
or BT. Other
> > > > interfaces are left for future improvements.
> > >
> > > Thanks for working on this. I started playing with it now that it is =
in
> > > -next. The PCIe part works fine. I'm looking into how to fit the pwrs=
eq
> > >
> > > A couple questions:
> > >
> > > - Given that this connector actually represents two devices, how do I
> > >   say I want the BT part to be a wakeup source, but not the WiFi part=
?
> > >   Does wakeup-source even work at this point?
> > >
> >
> > You can't use the DT property since the devices are not described in DT
> > statically. But you can still use the per-device 'wakeup' sysfs knob to=
 enable
> > wakeup.

I see. I think not being able to specify generic properties for the devices
on the connector is going to be a bit problematic. Another use case I have
requires specifying a bounce buffer / SWIOTLB for the PCIe WiFi card. The
PCIe controller does not have an IOMMU behind it.

> > > - Are there plans to do the SDIO part?
> > >
> >
> > No, not at the moment. Feel free to take it up if you have the hardware=
 and
> > motivation :)

Ack. I think I still need to figure out what the plan is after mmc-pwrseq
is deprecated.

> > > - The matching done in the M.2 connector driver for pwrseq_get() seem=
s a
> > >   bit naive. It simply checks if the remote device in the OF graph is
> > >   the same as the requesting device.
> > >
> > >   I think this would run into issues with USB hubs. If I have a USB h=
ub
> > >   and two M.2 connectors, with both connectors connected to the same
> > >   hub, pwrseq_get() is going to always return only one of the instanc=
es.
> > >   This is because the USB hub has one device node with multiple OF gr=
aph
> > >   ports.
> > >
> >
> > Yeah, this is a known limitation. I'm trying to improve this part now a=
nd have
> > the WIP commits here: https://github.com/Mani-Sadhasivam/linux/tree/pwr=
seq-bt-en-fixes
> >
> > Once the merge window closes, I'll submit these.

I couldn't tell which commit would help with this.

In my head I think we would need to extend pwrseq_get() to add something
like an index parameter that the provider is free to interpret. The M.2
connector driver could interpret it as the USB port number on the remote
end.


Thanks
ChenYu
