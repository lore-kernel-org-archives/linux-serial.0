Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE76186E2E
	for <linux-serial@vger.kernel.org>; Tue, 30 Sep 2025 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201426; cv=none; b=GGD0cB7yW8dKDgsZQ0K1Po8TP8DXE/NPZx4svxSz7Kj9iNLqm+i2Qiig5B+i+EMkSqZh3w7DX7tJx+reeWAR546TZ/oTmzJ1yH9HQLtnWlRsQBkxQ7tw6ea3ZQUPFtG1/8HoZjAleBMyJCt5y+mGidxOcv6hH0q6+XloTN2JZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201426; c=relaxed/simple;
	bh=TlSrEI1g4LJ14N4ECMUQYeDV9+p/D6qPn677XjVLXis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pO1tlT+LwUf3w7KoHGXX246mZMoVX4/kHVVkHk0wjKHUl5+pdIZCrlC+5pSjH+xkk3c03DekaArvSshEpGyv2z4WyG8JSNkVrz5jN9YmG4KK2ifSTM4BFz70rD73fvpaOxr2AZ6s2mbaoN7WKh0wZ4uaIF1yqAQFFI6Kfx85tos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK8JxIZQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK8JxIZQ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3e9d633b78so424266866b.1
        for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 20:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759201422; x=1759806222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NFP/aRPpSqSxRRCDSAPryYMxFsX/KQ2AaIdR8RyNrI=;
        b=VK8JxIZQVOn6GH8f8yUZpXfKXgsFg0T7VCBzu8UaPFAptq213KE9rmwtSLoIzeW6lv
         okEgDaRfsW/Jjkdu5qSrt8FplDgOXxb30vUDu8Id/EuaZ9LD7t87cTpJfkTgclHQHSCm
         HBnVKWX76FYP55hJz3ac/rqp9qqBiYwEDGQeGc9YQRllbpV2anKK5wd5T0FRH38hhAWT
         0jdDRAp69nA3q/FwLJHfLRoXxmofvXDmMUXz/e6tHC6+0wSJrkBay5x76K0vJpDpnxvC
         Bwe2LeuxOTPCR0LMXwv1MMkzaL5nwIriw/be1sM1vLZas0PY7WlqQcNZBja3XZe07iA7
         nWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759201422; x=1759806222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NFP/aRPpSqSxRRCDSAPryYMxFsX/KQ2AaIdR8RyNrI=;
        b=BZY/Evq2IzOI/s1nARHlKT0Oz67bpz7zaxdDMPPvnSTqyfktnr9+NmpUA3LE74kvcQ
         yimLAEGJEsyGlR3ir2r/Cl5HMbBKTt6+rV1EORreRMNz3An+Q7b4QRpffOTFuYWzHn5m
         HhXNSku0kC71mrVc4iEq5Pstoa5nnxcqnuEUwBokpOdxh4TK6y3juk7G6R+ikjezpezf
         fiaJsWKABGXhaESmeR96E6ROlRHJNpXaZ9cpczedMReMbF1+6r4ajo6ywESipwR/JayI
         rvRKg25jjZV+JMEjIsBiO0aZbQXpxfMjm9kudPpOZD1cJRl/qkv3IJmHrFXxb+TfSy/3
         1kUg==
X-Forwarded-Encrypted: i=1; AJvYcCW7KGGw2HW1sYj/ADx8+gPvWBxX6zUb0YdxTKhiq+n2dcHjaWfvQazP2udO5gQ7RRpwtPLrhO0ZmxYenno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/o/lW5/UDtI2TlVin3lm79Zi7Aql7iutlsPK5q/MObYf1xCg
	Qiw5GaEaGFR76n2eI8KERzNd0WIpF1vvwG9fQv+CM17fzsXNl+gf3YQ/vJWrVsF8u+hQYu7UmJ7
	ytW99t4KEY3+fmXk56Z1Wno59JEdH+Cs=
X-Gm-Gg: ASbGncthrAk1F30SoXggA5hDdTSGIy5szN22qOQ2NLMq92pZGmPAeN3hZZZAK8I/7f4
	dDW7ECc7/VC5BDZXY1MLcU/6xaOMgimKd3t7laarLE6qdf5w30jOzy9v3kvkMblPouWLmbFI/eW
	5MgHEdF15bnZSK6A1zYqRkjeWDkYOgJjNOh+dnKw//mI4HXYQzwxDc/bMCFBaOHE9OysxAX5Bai
	1WCalm4tBtY6awyurY26TuC3NrrWiduPw==
X-Google-Smtp-Source: AGHT+IF/n5rxioCLmT/RhA4+s+0eSGWB5ynhr3d237Tn0J8d1xLcsm+RN0zUj0iTmh5Xi96u/TsBTy9XttW3rYTj7eY=
X-Received: by 2002:a17:906:6a13:b0:b3d:d30b:39c0 with SMTP id
 a640c23a62f3a-b4138d54e8fmr254813966b.21.1759201421958; Mon, 29 Sep 2025
 20:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758676290.git.zhoubinbin@loongson.cn> <9823e7afe713450e210dab9dba6fa18683dc1fe0.1758676290.git.zhoubinbin@loongson.cn>
 <2025092428-glade-monologue-3663@gregkh> <CAMpQs4JgR=iG6LAuYeVxOpE31S6n=dC4+FGUJczOYDVfWHDuFw@mail.gmail.com>
 <b862846d-fb2a-4df4-8457-d858aa63031d@kernel.org>
In-Reply-To: <b862846d-fb2a-4df4-8457-d858aa63031d@kernel.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 30 Sep 2025 11:03:29 +0800
X-Gm-Features: AS18NWCm6-Znvj04Md8NL1AWVBDpMDNMtoDJ4KZsLhmeYeLRSp3jYSKwZzNeE88
Message-ID: <CAMpQs4KVgSFk=B5JtQ1KM02HydTkwaYqi+LzzhdJAyoSUfAxLw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] serial: 8250: Add Loongson uart driver support
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Haowei Zheng <zhenghaowei@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri:

Thanks for your reply.

On Mon, Sep 29, 2025 at 2:19=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> Hi,
>
> On 28. 09. 25, 4:48, Binbin Zhou wrote:
> > Hi Greg:
> >
> > Thanks for your reply.
> >
> > On Wed, Sep 24, 2025 at 6:22=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Wed, Sep 24, 2025 at 02:29:37PM +0800, Binbin Zhou wrote:
> >>> --- a/include/uapi/linux/serial_core.h
> >>> +++ b/include/uapi/linux/serial_core.h
> >>> @@ -31,6 +31,7 @@
> >>>   #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs=
 */
> >>>   #define PORT_RT2880  29      /* Ralink RT2880 internal UART */
> >>>   #define PORT_16550A_FSL64 30 /* Freescale 16550 UART with 64 FIFOs =
*/
> >>> +#define PORT_LOONGSON        31      /* Loongson 16550 UART */
> >>
> >> Why does userspace need to have this value exported?
> >
> > Sorry, this was a cheap mistake.
> > It should follow the existing latest macro definition as follows:
>
> That was not the point. The point was why do you need that at all?

Emm...
We attempted to define Loongson UART as a new `uart_config` entry.
Therefore, `PORT_LOONGSON` is referenced as follows:

diff --git a/drivers/tty/serial/8250/8250_port.c
b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..53efe841656f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -310,6 +310,14 @@ static const struct serial8250_config uart_config[] =
=3D {
                .rxtrig_bytes   =3D {1, 8, 16, 30},
                .flags          =3D UART_CAP_FIFO | UART_CAP_AFE,
        },
+       [PORT_LOONGSON] =3D {
+               .name           =3D "Loongson",
+               .fifo_size      =3D 16,
+               .tx_loadsz      =3D 16,
+               .fcr            =3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_=
10,
+               .rxtrig_bytes   =3D {1, 4, 8, 14},
+               .flags          =3D UART_CAP_FIFO,
+       },
 };

 /* Uart divisor latch read */

Additionally, `uart.port.type` will also be assigned the value `PORT_LOONGS=
ON`.
>
> --
> js
> suse labs

--=20
Thanks.
Binbin
