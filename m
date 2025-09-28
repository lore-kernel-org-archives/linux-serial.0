Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87891B21BD
	for <linux-serial@vger.kernel.org>; Sun, 28 Sep 2025 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759027715; cv=none; b=o/bddEQUH9ADxZYhKDVoEJMe6SOs/oyRcrQ8Y33cn0DaFiwOkFZg0Jrfz2hMLnQrgcuEUxOWV0qTbaYc9zgYkqROTpOG16OIP0pZGofH3yQd7IZUSh8bOGFl/SEWHZBZTguoKDMwst82f9n39nF5aGYpP5pefZjsCT29NHSe7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759027715; c=relaxed/simple;
	bh=G27Pgv7iGejxXksjp5F8tvsZrk3N83G7riJRNuh7fwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dA45zwf47aVKZHZC3WSUsETXwUteEjyu344fJe5HLDTLiuk0qQwhJewoX44S94/EZvCT+AaeERm0KzJM7+DJfmhGvs+BBeGeUMdHbzJk/CTXDDyI5bgtZPbcNQNe4plBm0d3FG0R3zE9+R95ehZ3gncAp9RTT1t9E5lxUMpfhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwT6uP8G; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwT6uP8G"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso5589869a12.2
        for <linux-serial@vger.kernel.org>; Sat, 27 Sep 2025 19:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759027712; x=1759632512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIqCPbhPlSD4ePjYmkMG9S4moNLTDdS5iBVcgknVqDE=;
        b=jwT6uP8Gm6G1cuYf3Tv68Bzv49JF83PHEQS770YAk1whDTCkhllVYZqSoaOIy0AIa3
         nwLYbQ2jFSvZ6m3vE9XbrDoOd/vS0DSKqkM4NlmlGF4v9cgG7z1HNZOy3gw1Ng05Cn8z
         FXKPnUkeQfwk+WDRMNFvYEuciOeHWtgD9GyCQl6vcRDXAlwb1rycBPVQTcVksXHPJ5ZB
         utdVcmydS5Fk5PK6ibrzdf02XRzSYmg21kvKKO5SjqRk4TPbCJ1VMix8qpRRYla/fUDY
         u5KotZQR696VnmROzLURf6syKCnKtGa0m1wZp9/N7uaPFuq7f17JUS0kMAziItLmHUcN
         cE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759027712; x=1759632512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIqCPbhPlSD4ePjYmkMG9S4moNLTDdS5iBVcgknVqDE=;
        b=p+L5kJdj4P4O8F1M4QrJhsjX9Ew72xszvJ47RyNi5Q2R9gnb3ghWOmFyFCgYSOKAnl
         ZHk0qDJvy5Ptl+q8qlkcXelNELNcU674w9ZgRW9cpEFmLrRvT3zeFPW6t43p/CFPWWyb
         x5pU9DYK+ECUNwfDIypspeO3DaYMfS0NZuSeGPbpveEMtQphJHHB2k4yJgvfaWzofB4+
         5xj098Cw5grdGnBsCZs1Bhv1vsCPc+ZrufAsps+hYuAVA8y3163kpHK1GCP3k1TNOeD0
         IHk+nspTwtZdsksJcluAd4F9RpUGvRlCt6fYq/radKWmD2Q0xGdgE5ojrm5+yIIQLAas
         d0fg==
X-Forwarded-Encrypted: i=1; AJvYcCUKb4up+ILGRZMZIf3sBPE4BxbBNeRdGpmiC2f1Jo8Z6MAcITwB7zNwHtEasgLmcb8roOn+ChuxiNkYlP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUFS5MuUVi9IaZtSeGB323Jot/QO53eSMsErnA3ly9wVdmAba
	rT0Ewp9Fro1Qe4enSZDpMfdiBXR3jXnVX6ye7EZCxcI5d8SmrxKvfN8xAtobpxngUrQr1aUBqpG
	+FPscpQvptGEXmU6QMEF4DVcHvVgLedBg6Vpu
X-Gm-Gg: ASbGncvQaLtxBz6/KIK5QZbn/N1bzm6rKNg8WH7tU4fRgnQ9GPIJoSz1ieTVrki9wuf
	PSBR/oLvVt/W+qZxjxnU1b/nYWNsieRqgKLf4tThY24CKMfey9S5OyRBabT3qM0WAO97fHfu3ap
	o52adlMF5iCHxZ00mXUPZ4Nhu5HboCURmwYLg2PzK3vakQGcRApjiak/ud4wyw7QLRf3TB8SSts
	IVm4GEARYWgVB4s4VQ=
X-Google-Smtp-Source: AGHT+IHYFYzoo2FCZ+R42wdMNXg2gGCTC2KWOlpmGLAOuCsIbKMhKvzoC9v375rVavEqRbumDhQ8AHOLgwbwRq6XFWs=
X-Received: by 2002:a05:6402:5210:b0:634:a546:de45 with SMTP id
 4fb4d7f45d1cf-634a546e2c6mr9764402a12.23.1759027711786; Sat, 27 Sep 2025
 19:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758676290.git.zhoubinbin@loongson.cn> <9823e7afe713450e210dab9dba6fa18683dc1fe0.1758676290.git.zhoubinbin@loongson.cn>
 <2025092428-glade-monologue-3663@gregkh>
In-Reply-To: <2025092428-glade-monologue-3663@gregkh>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Sun, 28 Sep 2025 10:48:19 +0800
X-Gm-Features: AS18NWBz68QzCTskD3KAjHQSqckmCa7a4rjPHTjPL-thUzgT97MtzfY2E2ZY19g
Message-ID: <CAMpQs4JgR=iG6LAuYeVxOpE31S6n=dC4+FGUJczOYDVfWHDuFw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] serial: 8250: Add Loongson uart driver support
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Haowei Zheng <zhenghaowei@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg:

Thanks for your reply.

On Wed, Sep 24, 2025 at 6:22=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 24, 2025 at 02:29:37PM +0800, Binbin Zhou wrote:
> > --- a/include/uapi/linux/serial_core.h
> > +++ b/include/uapi/linux/serial_core.h
> > @@ -31,6 +31,7 @@
> >  #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
> >  #define PORT_RT2880  29      /* Ralink RT2880 internal UART */
> >  #define PORT_16550A_FSL64 30 /* Freescale 16550 UART with 64 FIFOs */
> > +#define PORT_LOONGSON        31      /* Loongson 16550 UART */
>
> Why does userspace need to have this value exported?

Sorry, this was a cheap mistake.
It should follow the existing latest macro definition as follows:

diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_c=
ore.h
index 9c007a106330..5221d86d592a 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -231,6 +231,9 @@
 /* Sunplus UART */
 #define PORT_SUNPLUS   123

+/* Loongson UART */
+#define PORT_LOONGSON  124

I'll double-check and test it again in the next version.

>
> thanks,
>
> greg k-h

--
Thanks.
Binbin
