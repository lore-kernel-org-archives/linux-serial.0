Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D781BCA1E
	for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599426; cv=none; b=Bd97d6Bcc3pzOgJo8+cxPlJxYVAEUXofJHaRcf+VakHoM/vqkd9uFklArCM8Cj87COQWAfbwJ+TLXO6uCz+Yqji2Yd4ibsMNloAiilPdZ6wQn3QdO0dUoYt8m+640bza+MLdY1Gu1KEiJ2qin+lkhspI6RqLiDb5dZCjfTTQhzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599426; c=relaxed/simple;
	bh=CdmSXbDHAWq8dgUJmRamn05jbHQQT0TVNYOiCJ/xXdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DN5JmSR9BdjeOzR78132oZGJUznVbHF2h0OJG2N2J28k9dS4kzq93fGCvImF5w3IuhVvXkLxW/QpoHpfFbabIcfx3/JEKq1oSxYI18MTX93w4Ma0zix2vC4cQPHLN9s9mtmhoKELJEMdsMlTgUswa8I62tv0dC7kUIDmojPTDLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PE6M7PAN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PE6M7PAN"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9951fba3b4so222654266b.1
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 15:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599420; x=1729204220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tjzEcZp4sdEI4rizDgYHU+pcwb4fTKSCVr7AMb0oZQ=;
        b=PE6M7PANLNqAMURMXJVBC6WFAs2aw1PLurVOSZmQkQgRx+Xdx4vlMg298jctGcPQsM
         FUco1B4ECmWEy9bUWmMw8LK1jkBY2QH+LivIYiKw596AwOTsVPztvNGeD6rIVX/axi3r
         o58Lj/WGgPRuahBCl5exBJRntoKgTjIb2SAUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599420; x=1729204220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tjzEcZp4sdEI4rizDgYHU+pcwb4fTKSCVr7AMb0oZQ=;
        b=MBhgrzxxPblHIBMTp8cNsglR8+wfks/UNlAz8P/uqiXkfyj7bYuPEkVl1eLXjoCh4j
         8+ePzUiyne6pfpT4ib+UOtsjk/J6AfYivo0R7++x+ihg5AqZGNgtzk6+ulVbwhmYhJHe
         0X2dlhi1KvF/zYv0CPWGu9ysBFenIyD9GmrLucGPdJwK1w7vpCd7KWkzV3rubPA6EsYC
         Y8Qf7s0YSFLV+6BcS1cCo2YtwWoi6CJ+q1ioHokch9M97VA6Kdf6twbGV68/+/trlf9u
         UgmRfEkTWICTeqPTGVMmSpKQRoC5OalXuF4ONkdVt6qoCIq/whDXLsTUUCz/xrt7ATob
         /wkw==
X-Forwarded-Encrypted: i=1; AJvYcCUB18MNwJyLbyFwrlrOqZ8mBPOTgLd5kjKfvor/Nm0+NX9PiZyXSc1L7gP3Q1/gM+PXqpujyV6NH6Hd8VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqfcKliN4WaprefiCxRag3D/VszHT9P8S7Va6VRppbYIT8mam
	yeNhaiLPjtlOxk5MUcLA9BuP+cO3xRzlztKZiYPxmN6mlZvNI09r/7B0oTlny4wl3CPA+U2vW9+
	MLg==
X-Google-Smtp-Source: AGHT+IECHO9ztoDUQy3nWDRpn3fOM4xRNVOF4VOz4ARA5LaWgC89z0+fzstYM/6O0vUqa4+CyM7m8Q==
X-Received: by 2002:a17:907:e68a:b0:a99:4ff7:720e with SMTP id a640c23a62f3a-a99b96ad565mr38776366b.47.1728599419887;
        Thu, 10 Oct 2024 15:30:19 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5b09fsm143525666b.91.2024.10.10.15.30.18
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:30:18 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d447de11dso868251f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 15:30:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvNU4ybiXlssGEbgb2mf59z2t9CgKs1OOJ9q3wzpHmfc5RIVL6CaaN2gQHNHE8YxKxvvROjqo0JbEe244=@vger.kernel.org
X-Received: by 2002:a05:6000:181a:b0:37c:cd1d:b87e with SMTP id
 ffacd0b85a97d-37d551d50a7mr437367f8f.18.1728599418059; Thu, 10 Oct 2024
 15:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org>
 <20241001125033.10625-3-johan+linaro@kernel.org> <CAD=FV=UoU5Nd7sW66cjQzor+BP+W_f7uw0MGRaF6y7PH7KRN_g@mail.gmail.com>
 <ZwaO0hCKdPpojvnn@hovoldconsulting.com>
In-Reply-To: <ZwaO0hCKdPpojvnn@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:30:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZtZ1-0SkN2sOMp6YdU02em_RnK85Heg5z0jkH4U30eQ@mail.gmail.com>
Message-ID: <CAD=FV=UZtZ1-0SkN2sOMp6YdU02em_RnK85Heg5z0jkH4U30eQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:10=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Thu, Oct 03, 2024 at 11:30:08AM -0700, Doug Anderson wrote:
> > On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kerne=
l.org> wrote:
> > >
> > > A commit adding back the stopping of tx on port shutdown failed to ad=
d
> > > back the locking which had also been removed by commit e83766334f96
> > > ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> > > shutdown").
> >
> > Hmmm, when I look at that commit it makes me think that the problem
> > that commit e83766334f96 ("tty: serial: qcom_geni_serial: No need to
> > stop tx/rx on UART shutdown") was fixing was re-introduced by commit
> > d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in
> > progress at shutdown"). ...and indeed, it was. :(
> >
> > I can't interact with kgdb if I do this:
> >
> > 1. ssh over to DUT
> > 2. Kill the console process (on ChromeOS stop console-ttyMSM0)
> > 3. Drop in the debugger (echo g > /proc/sysrq-trigger)
>
> Yeah, don't do that then. ;)

The problem is, I don't always have a choice. As talked about in the
message of commit e83766334f96 ("tty: serial: qcom_geni_serial: No
need to stop tx/rx on UART shutdown"), the above steps attempt to
simulate what happened organically: a crash in late shutdown. During
shutdown the agetty has been killed by the init system and I don't
have a choice about it. If I get a kernel crash then (which isn't
uncommon since shutdown code tends to trigger seldom-used code paths)
then I can't debug it. :(

We need to fix this.


> Not sure how your "console process" works, but this should only happen
> if you do not enable the serial console (console=3DttyMSM0) and then try
> to use a polled console (as enabling the console will prevent port
> shutdown from being called).

That simply doesn't seem to be the case for me. The port shutdown
seems to be called. To confirm, I put a printout at the start of
qcom_geni_serial_shutdown(). I see in my /proc/cmdline:

console=3DttyMSM0,115200n8

...and I indeed verify that I see console messages on my UART. I then run:

stop console-ttyMSM0

...and I see on the UART:

[   92.916964] DOUG: qcom_geni_serial_shutdown
[   92.922703] init: console-ttyMSM0 main process (611) killed by TERM sign=
al

Console messages keep coming out the UART even though the agetty isn't
there. Now I (via ssh) drop into the debugger:

echo g > /proc/sysrq-trigger

I see the "kgdb" prompt but I can't interact with it because
qcom_geni_serial_shutdown() stopped RX.


-Doug
