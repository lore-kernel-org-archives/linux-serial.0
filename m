Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C30150996
	for <linux-serial@vger.kernel.org>; Mon,  8 Jul 2024 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483096; cv=none; b=lTSRuSkS7Q/qodiybPKb7ik9clHAd3O8XjatutqhJuLAG6XhqjvjChpDC9JEcSq8JgIAqxWwDXITo5i5l4RqXrLvJAZdeBgdw6Io1q8ahelKU4R3rT9EM+KWwxqFgwjrS5PVUWsNgIdYM2hpRAL/TYWiG3GQF/dH97f1MaahEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483096; c=relaxed/simple;
	bh=7EN+YIsVbTIxzF1Z9SvdOZ/EM3QwsvXIiX7ZgAcuanQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoggaMqf2VsasuLMBSEV1HMt/DO33+exxv8XRzxQR1dodg2JQN87yO55LmMPej+7iDAeaNWgAgIE8XmS7DQXx34/Y4cGJSQBH33Sd0MS8lKRSPMhOjHieeeSZ3upRvikZM/ojEVKU8s7rOafD6gnYb+3EcLvHElG4/iAPBQGVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=muMOU5eM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="muMOU5eM"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-446883be273so24444041cf.1
        for <linux-serial@vger.kernel.org>; Mon, 08 Jul 2024 16:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720483093; x=1721087893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swlwf183naPwNtrfd1IMk+Z2jSuxIkqYhMm0lDWZmQc=;
        b=muMOU5eMOmi4c8QMQXVi1wGbnoOwQ/oM36riQc+wRKquHPDpp92r7F7hAIYbLb4XCd
         NCxnjEkqG2GM6PkyzFGzqHd7hlhHI/3m6R6tjgNT0S14hqvKs+GEIgAQ0QHBrslZJn8v
         MfZZsUiFMFW3RCpmaV2yC5ybXFgeTkVYvp4rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483093; x=1721087893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swlwf183naPwNtrfd1IMk+Z2jSuxIkqYhMm0lDWZmQc=;
        b=nK+31dTGjDUj1oBAl5/DhHJLlW6JiQPzKpsS/P+w42uP25u4OqmixyknvamX/Bi+M/
         aSq4pV6+zi9HtiqkBpIiHZAZHGxC/0td8Jxmn4NvmdLy2XH0n8X778YPeQPsB5s2oNsN
         tCSagAXlqtK0PAFkgiPQciSDKQyIWJLSMaDDfYBv7IRcT/4BA6VcS400yYBQNlr/zdtU
         NKslaALPJS8Ct8zFdjN8a77KYtKBGRtvoI7CGBhLxtO6wwDp3WN56KrFd3H5FBfyEzW4
         KuNpg4Xz1KhEmbBJC+fOWWPpljrVTqUN9ImLA67VAGtxd9vdowvn8a21jzKk18hlqL1j
         zQOg==
X-Forwarded-Encrypted: i=1; AJvYcCWLCTNfrMKptTlyvo5MYyAZ53DJuNH2X9x/ZXbxR2+Woaatr9vtBCMlS8FYvdzeHJcj87x3ejrzQXxWx5uPycZv9xJksgU55uJc57S6
X-Gm-Message-State: AOJu0Yz5FNP3Iw8zu/c832Zh3YtkocjMhfhon0bEUIUcCH3l4D9LCkdT
	4QBya82/kC3DB6zdRDqAHkJP3ICvioQ+t2RQWZg7xLwdpdMc0tuQg3gkrCy8hdYmOaUIKo2KxuE
	k2Ols
X-Google-Smtp-Source: AGHT+IHRJxphk35IQby/9eDlOkA22flf5v1VivymNyY7xPOJpsTCIr7Pfj34tyEDe0/nQ1WgTV70fg==
X-Received: by 2002:ac8:5e0f:0:b0:447:f4e0:8d19 with SMTP id d75a77b69052e-447faab347bmr7918911cf.44.1720483093021;
        Mon, 08 Jul 2024 16:58:13 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bd25c7sm4445591cf.74.2024.07.08.16.58.12
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 16:58:12 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44664ad946eso55211cf.1
        for <linux-serial@vger.kernel.org>; Mon, 08 Jul 2024 16:58:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsdwwk4KUsXmTYw/bPZBd5AM3Yl/UyGNEOdXp6YQwU0SXJE8l2Lwec9+Tl6aXnPCStgu2qWimyr/L28Z5BT5eAnKineEUBBWO6Sqmd
X-Received: by 2002:ac8:7f4e:0:b0:447:d78b:fdf6 with SMTP id
 d75a77b69052e-447fb1ff3abmr1790991cf.10.1720483091723; Mon, 08 Jul 2024
 16:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704101805.30612-1-johan+linaro@kernel.org> <2024070445-stunner-scrawny-1b03@gregkh>
In-Reply-To: <2024070445-stunner-scrawny-1b03@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jul 2024 16:57:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X0Sk0Xkz7Mcna6BNhGpxZQY5KArY=LqMPEwbocvmojQA@mail.gmail.com>
Message-ID: <CAD=FV=X0Sk0Xkz7Mcna6BNhGpxZQY5KArY=LqMPEwbocvmojQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] serial: qcom-geni: fix lockups
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Johan,

On Thu, Jul 4, 2024 at 3:31=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 04, 2024 at 12:18:02PM +0200, Johan Hovold wrote:
> > Since 6.10-rc1, Qualcomm machines with a serial port can easily lock up
> > hard, for example, when stopping a getty on reboot.
> >
> > This was triggered by the kfifo conversion, which turned an existing bu=
g
> > that caused the driver to print discarded characters after a buffer
> > flush into a hard lockup.
> >
> > This series fixes the regression and a related soft lockup issue that
> > can be triggered on software flow control and on suspend.
> >
> > Doug has posted an alternative series of fixes here that depends on
> > reworking the driver a fair bit here:
> >
> >       https://lore.kernel.org/lkml/20240610222515.3023730-1-dianders@ch=
romium.org/
> >
> > This rework has a significant impact on performance on some platforms,
> > but fortunately it seems such a rework can be avoided.
> >
> > There are further bugs in the console code (e.g. that can lead to lost
> > characters) that this series does not address, but those can be fixed
> > separately (and I've started working on that).
>
> I'll take these now, thanks!

Are you going to continue to work on the driver? There are still some
pretty bad bugs including ones that are affecting Collabora's test
labs. Unless you want to try to tackle it some other way, I'm going to
keep pushing for something like my original series to land. I can
re-post them atop your patches since they've landed. This will regress
your performance but correctness trumps performance.

-Doug
