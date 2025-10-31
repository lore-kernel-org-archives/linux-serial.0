Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB272EC562
	for <linux-serial@vger.kernel.org>; Fri, 31 Oct 2025 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939149; cv=none; b=X0i7nnVf6onHShwJzzid1mCElBLy+AB084G6YmBGMMnWPBxzbFZoN+yUj6JbiPsYaoeq7asKFAZ6QjyPVoHhJhevAujmjXALC5ilMKeIzM0Y01PMNpNPQdqjtRE4bTweQnmmxkosXMgvgeUUjnoi0CvzCq+4Khro94wIEmZQTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939149; c=relaxed/simple;
	bh=MfufaMPEZvOAvpadkKFMcZMnakLrk23FpenwxjV3ztw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpuNeaPAei7/KG0okR09WMaqWgpLRsFRUq5wfFvvryLBhotRYyuqd4hO/KHj3JZidVhLUIyq9lBmv6t1NLC4KIqoQrNamByomcM22mbkh4pqlT849MSJPzvEdjtaUQGhQSwu8hfE4bbGk/WfBsMjk1ZURlGivUgozd5v8ytLpcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=dEEOGX/C; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dEEOGX/C"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3d397a07fa5so376506fac.2
        for <linux-serial@vger.kernel.org>; Fri, 31 Oct 2025 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761939146; x=1762543946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVa5lvcf1ShWgm0I67qSDyyvFSkvQxIjElJuMOuDP/s=;
        b=dEEOGX/ChEgHf75n5whFMal0ezp0bICVBvbzcXINnWi583mPATaDHRM6h45fgt1k9P
         v0S/moWnYvbhTA/Kf/LBqnzVgYtdZc+BE0Ih+AGm4lZ49iAzPfBlU7MVGT1Ne0RG1HEm
         SaSqza9jygbDrf4cM0jyNPqY9Ehoyk3iRSMJ9+N/CiEGc3oZDMbUANeJguTSYPgXmugs
         A3NlRNGp/XxQ9fqdSogtVu2bSWmK62qHQNFd1wABroGTvJc3HywZ8kizqR2sRV9f/tPW
         ftbEdzBUYneqz9qFknBH3xWQALh2eIPI8BFWquCse8mdyWnLUHMotKY2nOOW4Zxv5Fgs
         pxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761939146; x=1762543946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVa5lvcf1ShWgm0I67qSDyyvFSkvQxIjElJuMOuDP/s=;
        b=nKLUMRvyJ1RRzHjDoKWjE411monV+9PRrnQrkBHGiDiVUZcpXF1DCYOpDxHVcbU6T8
         MXYp+rcKP61a7xMY8njVcYeCLbdPC2MOO4Qceyyb6781XCtKbd/RXIJaOkpA6wFNvvdB
         qEQ6MLN8bIKKCjW07Ko0t6R0NoQN9WHozwcCv+4yByt3x6aOHD3vSaeuNRjVLw97y9Lg
         3/A+U6HPSwsSCBRw7jlbt7nWCSSn8C35XW0GN+6vFcLhDfjZKT3sBngPMbXRokeaHoDp
         C/1s64Cf/1Ie2PB/haHaqNxdBWZd6UxFhWDuLtlrazshCyj2UDZBhE7KSJh8TeTZHhce
         3OGw==
X-Gm-Message-State: AOJu0YxbgX+nkbnA8kKgkDI+X5zPR7/G1NnZOPhOEgixjbAE0blNR3Vx
	BeXCMNXLn7i4G5TBWEBRh6qidou344nalOtB2iApjz9SSfC4oNmuA1Q3rCbRuEyDVya80zZVQLl
	VDeja/+QzioRTqP06H+FEdoYbpC8fXYmA0NU7pFKC
X-Gm-Gg: ASbGncvOVo0yPcJThVwPMjZT6TvXrAmtd/cbOD2ARUY9k3WIr+37nnvaDFB4vVwYj77
	h3Vt6wFS+FKUn6NRS9NCO8YAY0k4SId10R5hz0kn2dqnT5rQsrLyEzIw1iKXVI6/cuETqT+tZc6
	0T0ztrktiS7qcEYi+lagck/ytXj5VplEhrZzoQ7NuW1WJmasimUBJtQykvrct/Ro84xm/tK8G5Y
	lnaqXfaOV/6KH2B4z8xJ4vfYbQ5XxbYTkkWwoi8UJXFjeDCfRoVaJvCj0yFAqARAqGlPoKA7e0G
	VPeabUUa2XDahmU9UJVybuK1d18=
X-Google-Smtp-Source: AGHT+IFqIiw2CJtD0GGcgJfg4Q5yoW6YoSl7ZWvzSdeTAB4VCtuIpsEuEb7prYlt51VPL6ydktn+Xib84UME0d+AWkk=
X-Received: by 2002:a05:6808:18a1:b0:438:1b55:9fd9 with SMTP id
 5614622812f47-44f95fe6ac7mr1099393b6e.6.1761939145794; Fri, 31 Oct 2025
 12:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819182322.3451959-1-adriana@arista.com> <945af1e4-1d43-bd4b-6b07-733c06d18b17@linux.intel.com>
 <CAERbo5zSPSMyfSDQpw9-js=7kZHaB5mS9uib8RSw-Hqzwn3mGQ@mail.gmail.com>
 <6ab9afb2-e308-6231-e938-d28d05d62a9a@linux.intel.com> <CAERbo5xOg4OegoWYid3ZBCX1Fi+MBUMb59EtaQLrYkZy9MzSJA@mail.gmail.com>
 <21796013-0fa1-3d1f-9b89-173ef85c7508@linux.intel.com>
In-Reply-To: <21796013-0fa1-3d1f-9b89-173ef85c7508@linux.intel.com>
From: Adriana Nicolae <adriana@arista.com>
Date: Fri, 31 Oct 2025 21:32:14 +0200
X-Gm-Features: AWmQ_bm5rmcwdx3BJ1_9334JVUR1CaVlyhs4SjeU7Gyke-Jnurr5MA4kwAyv26g
Message-ID: <CAERbo5yjKDrVdfAZEAzWqeTSXoZJE_GZqbwov-4KGs1BPpwCiQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial <linux-serial@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, prasad@arista.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 4:12=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 8 Oct 2025, Adriana Nicolae wrote:
> > Hello, Sorry for missing an update, the exact root cause is not clear, =
currently the
> > brute force method of draining FIFO right before setting or clearing DL=
AB was stable
> > during tests.
> >
> > The serial stuck seems to be a failed attempt to clear the DLAB.
> > This operation fails because the USR indicates the hardware is
> > still busy, even though the UART is in loopback mode and should
> > be inactive.
> >
> > To isolate the issue, I tried the following without success:
> > - Added delays: I inserted 100 repeated ndelay(p->frame_time)
> > calls before and after enabling loopback mode to allow the FIFO
> > to clear.
> > - Cleared FIFO: I explicitly cleared the FIFO in addition to
> > adding the delay.
> > - Checked status: I printed the LSR just before the DLAB clear
> > attempt and checked the USB busy bit.
>
> Okay, so the BUSY must be stuck asserted.
>
> Another idea, maybe test tx + rx over loopback to see if that manages to
> de-freeze the BUSY bit. A patch to that effect below.
>
> (I've only added the new block into dw8250_idle_enter() compared with the
> old patch but rebasing to tty-next resulted in some other changes due to
> conflicts.)
>
I've tested the new dw8250_idle_enter() sequence, and you're right,
the BUSY bit remains set after entering loopback mode.

However, the sequence in the patch (including the single loopback
tx/rx) wasn't quite enough. I didn't see any kernel panics or console
stuck anymore, but I've monitored the traces and there were cases when
the trace after "p->serial_out(p, UART_LCR, up->lcr);" showed both
BUSY bit set and DLAB bit still enabled.

>
> Only thing besides BUSY being stuck asserted is something Tx'ing after th=
e
> idle enter sequence. I think we could trap/check that too in
> dw8250_serial_out() by using something along these lines:
>
>         if (d->in_idle && offset =3D=3D UART_TX) {
>                 WARN_ON_ONCE(1);
>                 return;
>         }
>
> (I think that should catch even console writes but I'm not 100% sure of
> that and it will should get us where the rogue Tx originates from).

I also added the WARN_ON_ONCE check you suggested in
dw8250_serial_out(). The warning has not triggered, so it seems we
don't have a rogue Tx firing while in_idle is set.

>
> > The critical finding was that immediately before the DLAB clear
> > operation (p->serial_out(p, UART_LCR, up->lcr);), the LSR value
> > was 0x6a and the USR busy bit [0] was set. This confirms the UART
> > is busy, which blocks the DLAB modification.
> >
> > This is occurring on a device with a single UART console. The setup
> > does not use DMA or modem control; only the Rx/Tx lines are connected.
> >
> > The trace below, from a single process, shows one successful DLAB
> > clear followed by a failing one. The second attempt repeatedly logs
> > "USR still busy" before eventually succeeding. This can lead to
> > subsequent failures in dw8250_check_lcr: dw8250_idle_entered.
> >
> > Trace Log:
> >
> > <...>-15440  8583.592533: dw8250_idle_enter: in_idle =3D 1
> > login-15440  8583.713817: dw8250_idle_enter: in loopback mode
> > login-15440  8583.835099: dw8250_idle_enter: LSR in loopback mode is 0x=
63
> > login-15440  8583.835103: dw8250_set_divisor: UART_LCR_DLAB cleared 13
> > login-15440  8583.835104: dw8250_idle_exit: idle exit
> > login-15440  8583.835105: dw8250_idle_exit: out of loopback mode
> > login-15440  8583.835105: dw8250_idle_exit: in_idle =3D 0
> > login-15440  8583.835352: dw8250_idle_enter: in_idle =3D 1
> > login-15440  8583.956633: dw8250_idle_enter: in loopback mode
> > login-15440  8583.956638: dw8250_idle_enter: LSR in loopback mode is 0x=
6a
> > login-15440  8583.963918: dw8250_set_divisor: USR still busy dl_write
> > login-15440  8584.000332: dw8250_set_divisor: USR still busy dl_write
> > login-15440  8584.040385: dw8250_set_divisor: USR still busy dl_write
> > login-15440  8584.078012: dw8250_set_divisor: UART_LCR_DLAB cleared 93
> > login-15440  8584.078013: dw8250_idle_exit: idle exit
> > login-15440  8584.078014: dw8250_idle_exit: out of loopback mode
> > login-15440  8584.078015: dw8250_idle_exit: in_idle =3D 0
>
>
>
> --
> From 01df58736a10f7f34aca895ef08e5519953f8572 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.int=
el.com>
> Date: Wed, 8 Oct 2025 15:40:19 +0300
> Subject: [PATCH 1/1] serial: 8250_dw: Ensure BUSY is deasserted
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
> Existance of BUSY depends on uart_16550_compatible, if UART HW is
> configured with 16550 compatible those registers can always be
> written.
>
> There currently is dw8250_force_idle() which attempts to archive
> non-BUSY state by disabling FIFO, however, the solution is unreliable
> when Rx keeps getting more and more characters.
>
> Create a sequence of operations to enforce that ensures UART cannot
> keep BUSY asserted indefinitely. The new sequence relies on enabling
> loopback mode temporarily to prevent incoming Rx characters keeping
> UART BUSY.
>
> Use the new dw8250_idle_enter/exit() to do divisor writes and LCR
> writes.
>
> This issue was reported by qianfan Zhao who put lots of debugging
> effort into understanding the solution space.
>
> Reported-by: qianfan Zhao <qianfanguijin@163.com>
> Reported-by: Adriana Nicolae <adriana@arista.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 159 +++++++++++++++++++++---------
>  1 file changed, 115 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index a53ba04d9770..8e25dfe8e653 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -42,6 +42,8 @@
>  /* DesignWare specific register fields */
>  #define DW_UART_MCR_SIRE               BIT(6)
>
> +#define DW_UART_USR_BUSY               BIT(0)
> +
>  /* Renesas specific register fields */
>  #define RZN1_UART_xDMACR_DMA_EN                BIT(0)
>  #define RZN1_UART_xDMACR_1_WORD_BURST  (0 << 1)
> @@ -77,6 +79,7 @@ struct dw8250_data {
>
>         unsigned int            skip_autocfg:1;
>         unsigned int            uart_16550_compatible:1;
> +       unsigned int            in_idle:1;
>  };
>
>  static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data=
 *data)
> @@ -108,36 +111,103 @@ static inline u32 dw8250_modify_msr(struct uart_po=
rt *p, unsigned int offset, u3
>  }
>
>  /*
> - * This function is being called as part of the uart_port::serial_out()
> - * routine. Hence, it must not call serial_port_out() or serial_out()
> - * against the modified registers here, i.e. LCR.
> + * Ensure BUSY is not asserted. If DW UART is configured with
> + * !uart_16550_compatible, the writes to LCR, DLL, and DLH fail while
> + * BUSY is asserted.
> + *
> + * Context: port's lock must be held
>   */
> -static void dw8250_force_idle(struct uart_port *p)
> +static int dw8250_idle_enter(struct uart_port *p)
>  {
> +       struct dw8250_data *d =3D to_dw8250_data(p->private_data);
>         struct uart_8250_port *up =3D up_to_u8250p(p);
> -       unsigned int lsr;
> +       u32 lsr;
>
> -       /*
> -        * The following call currently performs serial_out()
> -        * against the FCR register. Because it differs to LCR
> -        * there will be no infinite loop, but if it ever gets
> -        * modified, we might need a new custom version of it
> -        * that avoids infinite recursion.
> -        */
> -       serial8250_clear_and_reinit_fifos(up);
> +       if (d->uart_16550_compatible)
> +               return 0;
> +
> +       d->in_idle =3D 1;
> +
> +       /* Prevent triggering interrupt from RBR filling */
> +       p->serial_out(p, UART_IER, 0);
> +
> +       serial8250_rx_dma_flush(up);
> +       // What about Tx DMA? Should probably pause that too and resume
> +       // afterwards.
> +
> +       p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> +       if (up->capabilities & UART_CAP_FIFO)
> +               p->serial_out(p, UART_FCR, 0);

Changing this to repeatedly clear the FIFO turned out to reliably
clear the BUSY bit , also no kernel panic or device stuck in busy
mode.

On the device I tested the first clear is not always enough, under
high load I saw it cleared on the second iteration. I'm thinking it
might be some particular issue with the device I'm using where the
first FIFO clear might fail. I never encountered more than 2
iterations with a "ndelay(p->frame_time);" in between here to get out
of BUSY state.

> +
> +       if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY)
> +               ndelay(p->frame_time);
> +
> +       lsr =3D serial_lsr_in(up);
> +       if (lsr & UART_LSR_DR) {
> +               p->serial_in(p, UART_RX);
> +               up->lsr_saved_flags =3D 0;
> +       }
>
>         /*
> -        * With PSLVERR_RESP_EN parameter set to 1, the device generates =
an
> -        * error response when an attempt to read an empty RBR with FIFO
> -        * enabled.
> +        * BUSY might still be frozen to asserted, try to de-freeze it by
> +        * sending a character over the loopback and receiving it.
>          */
> -       if (up->fcr & UART_FCR_ENABLE_FIFO) {
> -               lsr =3D serial_port_in(p, UART_LSR);
> -               if (!(lsr & UART_LSR_DR))
> -                       return;
> +       if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY) {
> +               p->serial_out(p, UART_TX, 0);
> +               ndelay(p->frame_time);
> +               lsr =3D serial_lsr_in(up);
> +               if (lsr & UART_LSR_DR) {
> +                       p->serial_in(p, UART_RX);
> +                       up->lsr_saved_flags =3D 0;
> +               }
>         }
>
> -       serial_port_in(p, UART_RX);
> +       /* Now guaranteed to have BUSY deasserted? Just sanity check */
> +       if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY)
> +               return -EBUSY;
> +
> +       return 0;
> +}
> +
> +static void dw8250_idle_exit(struct uart_port *p)
> +{
> +       struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> +       struct uart_8250_port *up =3D up_to_u8250p(p);
> +
> +       if (d->uart_16550_compatible)
> +               return;
> +
> +       if (up->capabilities & UART_CAP_FIFO)
> +               p->serial_out(p, UART_FCR, up->fcr);
> +       p->serial_out(p, UART_MCR, up->mcr);
> +       p->serial_out(p, UART_IER, up->ier);
> +
> +       // Maybe move the DMA Rx restart check in dma_rx_complete() to ow=
n
> +       // function (serial8250_rx_dma_restart()) and call it from here.
> +       // DMA Tx resume
> +
> +       d->in_idle =3D 0;
> +}
> +
> +static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
> +                              unsigned int quot, unsigned int quot_frac)
> +{
> +       struct uart_8250_port *up =3D up_to_u8250p(p);
> +       int ret;
> +
> +       ret =3D dw8250_idle_enter(p);
> +       if (ret < 0)
> +               goto idle_failed;
> +
> +       p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> +       if (!(p->serial_in(p, UART_LCR) & UART_LCR_DLAB))
> +               goto idle_failed;
> +
> +       serial_dl_write(up, quot);
> +       p->serial_out(p, UART_LCR, up->lcr);
> +
> +idle_failed:
> +       dw8250_idle_exit(p);
>  }
>
>  /*
> @@ -148,37 +218,37 @@ static void dw8250_force_idle(struct uart_port *p)
>  static void dw8250_check_lcr(struct uart_port *p, unsigned int offset, u=
32 value)
>  {
>         struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> -       void __iomem *addr =3D p->membase + (offset << p->regshift);
> -       int tries =3D 1000;
> +       u32 lcr =3D p->serial_in(p, UART_LCR);
> +       int ret;
>
>         if (offset !=3D UART_LCR || d->uart_16550_compatible)
>                 return;
>
>         /* Make sure LCR write wasn't ignored */
> -       while (tries--) {
> -               u32 lcr =3D serial_port_in(p, offset);
> -
> -               if ((value & ~UART_LCR_SPAR) =3D=3D (lcr & ~UART_LCR_SPAR=
))
> -                       return;
> +       if ((value & ~UART_LCR_SPAR) =3D=3D (lcr & ~UART_LCR_SPAR))
> +               return;
>
> -               dw8250_force_idle(p);
> +       if (d->in_idle) {
> +               /*
> +                * FIXME: this deadlocks if port->lock is already held
> +                * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> +                */
> +               return;
> +       }
>
> -#ifdef CONFIG_64BIT
> -               if (p->type =3D=3D PORT_OCTEON)
> -                       __raw_writeq(value & 0xff, addr);
> -               else
> -#endif
> -               if (p->iotype =3D=3D UPIO_MEM32)
> -                       writel(value, addr);
> -               else if (p->iotype =3D=3D UPIO_MEM32BE)
> -                       iowrite32be(value, addr);
> -               else
> -                       writeb(value, addr);
> +       ret =3D dw8250_idle_enter(p);
> +       if (ret < 0) {
> +               /*
> +                * FIXME: this deadlocks if port->lock is already held
> +                * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> +                */
> +               goto idle_failed;
>         }
> -       /*
> -        * FIXME: this deadlocks if port->lock is already held
> -        * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> -        */
> +
> +       p->serial_out(p, UART_LCR, value);
> +
> +idle_failed:
> +       dw8250_idle_exit(p);
>  }
>
>  /* Returns once the transmitter is empty or we run out of retries */
> @@ -547,6 +617,7 @@ static int dw8250_probe(struct platform_device *pdev)
>         p->dev          =3D dev;
>         p->set_ldisc    =3D dw8250_set_ldisc;
>         p->set_termios  =3D dw8250_set_termios;
> +       p->set_divisor  =3D dw8250_set_divisor;
>
>         data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>         if (!data)
>
> base-commit: d21b26cad33250be758ea9d860ff9d5c3992c459
> --
> 2.39.5
