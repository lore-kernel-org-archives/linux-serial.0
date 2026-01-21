Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1265123D281
	for <linux-serial@vger.kernel.org>; Wed, 21 Jan 2026 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014528; cv=pass; b=MrTDYLMntdIOHs66yR5WgxVlGRHtdhGLjW85Th7JMNSkpn7DVX/kGQnZoGGUcee2Aqhs1G29CccW3Bi2Ax0NZOuAUQkM+P4Ejpw9YGPRzjVUosXf+1TlM66xqRzkRkDbG+ZhGqc3f80eOQGfzNXXq0ziZEqC+Ve+2zJS+5Y3Se8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014528; c=relaxed/simple;
	bh=9xwowjAUCKFZAtO+t735tz5wFSL4BFb90yQ+0mFl0rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGcT+zG8/eTEQZdPozmt9xihH3s4REOi9lZlFaOjUWrU8uV23wimEpQRICNzl05iwg47+vdIghFaWRvA6A9BoX9wGNNv13XHchmnFxsJgqkUjr8nYAqsgUTLxsuyMKymo9IBVbRQFTUHgK8gWx2Hu9bobdSj5eUaF/C1+79Eo/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=GN2zIeC0; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GN2zIeC0"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-888872eb53bso130406d6.2
        for <linux-serial@vger.kernel.org>; Wed, 21 Jan 2026 08:55:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769014525; cv=none;
        d=google.com; s=arc-20240605;
        b=cWky0l7T7/+WCfqWhBTO2AFr5M4Gzr8/CPijkDaF81KF3wVWf/RA+wTXR6U0FbUlpt
         dmRq/mwN3+XAcRBQ0FwlcropIPy5SV3tkqKSGwQNhO89AQFO+REzr+Qr0kzs4fr74Ktx
         Eg+rbwDwtYSPS2j2erecNmJhy0fxDFtDye7SY2kWXyRU4Qqy8clYlcXzTnGYPxCKcX1V
         g8c4543k+gUhF8vJsx42auIOlK69T/4Wv7ewIM+XpTxD9zoaYhJpAiXTTZSRZmRwE0RQ
         cLd0UZ/FvF/zS2Zc3CvGLKWAjWfRrnpIO9/52RNmJBMGlseXDKpfLKJeLy0IWMO/nkXX
         Meww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZtJQ0Lb2j/OBJ6m1GNeI83yH3kGj1DbJAq1o/VhIhlk=;
        fh=38j+2nZzdhoJgAr/oL0zHOgbpsK08OuqnASwawGbkgc=;
        b=TVa39AdQsJpJxD1OjJX9VzvH36xfzbzfmHfzRrMQj5zGCPliRJH4vPen3IV3LZIxHP
         tNlomRjPlhNUiFDR5Jmmp8pPTItPWND6QBZn5gG2pU9t0etA2qjR66U0sEB5NXexfBkZ
         zD4+rd2Dzp1Ey37FhjennBM9Y0tFpjuL0ehx1u/RpyLEM1/4XbMwGJimp9TJvZYD9Qdf
         1rjYD7ok/bPtZUBLKeS0qvZOiUbNL5SfiwKsxOUOXSAhFwyvrdRpJDQc0ORbec4+/HlX
         PJmPx3T4n4aAnFbpCrwC70IHm+HdhQIY1748Y1S1na/UZtzgue6eqUAZDdoYVkU3ImyZ
         yrWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1769014525; x=1769619325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtJQ0Lb2j/OBJ6m1GNeI83yH3kGj1DbJAq1o/VhIhlk=;
        b=GN2zIeC04VerqurI52794wfPdUzbPN8IW4U69C9o1wB1c1iLTKko+d4iLcv7wMcoOx
         QlaYgsUPQHXTn183uhrpMXJaAK/kZwhNIDOZRyoEi4rXhcDkthzkl/ZXX9heWuyDCAaq
         pExO1c9Ua/5stRTr0HD7CsFfQt2BrKgXQq7DfvBJbXfcvjHrRVD51CDh1qi1pGToWVGN
         FFpjEFivfy6QKNafDIlLSDGWGCKDbNqJCna7AtO+7IGRJyp7ZjlnWhobokN2MnlBgt92
         aFgFjGIY0GhSc0sIfC1zQDgB/rgNIHDerHr2i1hue2NpGuusUczhPn1wUJkRRIyXy7T2
         rLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014525; x=1769619325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZtJQ0Lb2j/OBJ6m1GNeI83yH3kGj1DbJAq1o/VhIhlk=;
        b=oR0afU8S02xxzMi6pqiqN+Vb4maz/r9RVG8S6pJeHsofoH2ZKzOzligjcmBm0XEn4y
         BJrGORnwZ4IsEOFZXTcvIRoIHoslsGlBJ7SbKFzMQX1wg0tfFb1pFkzguvTm9iX8fq5G
         edzFvQEaNSCgb7UythyTXT0yRyQcB3HppWGGV5cIDtok6WJkncruzKgzuXyjgyuKzt07
         moN37fOeb3orLOEhMtWjAw3q7dqd2v3uIWTv1KSJISPF18Fns0V1tdNAYjGdRBVPkZu0
         52SGqTPDT3ywYhB7H5QDMKRzRpp6/+UuSbMeVHZCAr8GpHHcPLbGeopulRTEZcKM0W5+
         PzEQ==
X-Gm-Message-State: AOJu0Yyj/8JDqbAdVpLVjVuM45hqbcMsA66O/yXKHjDgXj+WO2Ke8AEe
	9ZUVu2N8vxL0p7BIVGDl5GP1+ZGJfQM8NmqElUnxt34MnmluvJPnQwL0ELgUt7uqtCw04f8mCPi
	Ap8aRNbXzQG1uvEIXD0zXcyHtGPrRstFwTAYzmvO6
X-Gm-Gg: AZuq6aJFRNdT2E7jilVu5Xyomkq1NDw5Z4aDVa9GB6H8TZK7I+0cjxrCTDZ7GtCtjuR
	w5D1ypcRdLdtYx38VMzktyRJSa+GU9DK0mLLUQlWm6ycbnPEbe6SYltasc1v8V1o/r7PnnS2xiO
	kioBj5mrtppvkN7EmdSQ2I2M1VXjO8YLTULszlvJRbU6tPwjCyCim7CUz9pQqihbCRoChIdP5lh
	gpNYHt4/4tbVSL3wDWvutfgjpvVOwvKPJs5/rb61nxIbISJK9Tht9nxQNnZD9TqB2HIoKH7yQVb
	Rnbz8k2P5gR33n/yZN1cIr5gu3s=
X-Received: by 2002:a05:6214:4e1b:b0:888:6dc8:5f96 with SMTP id
 6a1803df08f44-8945eb10363mr81372376d6.7.1769014524005; Wed, 21 Jan 2026
 08:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819182322.3451959-1-adriana@arista.com> <945af1e4-1d43-bd4b-6b07-733c06d18b17@linux.intel.com>
 <CAERbo5zSPSMyfSDQpw9-js=7kZHaB5mS9uib8RSw-Hqzwn3mGQ@mail.gmail.com>
 <6ab9afb2-e308-6231-e938-d28d05d62a9a@linux.intel.com> <CAERbo5xOg4OegoWYid3ZBCX1Fi+MBUMb59EtaQLrYkZy9MzSJA@mail.gmail.com>
 <21796013-0fa1-3d1f-9b89-173ef85c7508@linux.intel.com> <CAERbo5yjKDrVdfAZEAzWqeTSXoZJE_GZqbwov-4KGs1BPpwCiQ@mail.gmail.com>
 <faf3bae5-4656-7c47-d875-9103a5f2079e@linux.intel.com>
In-Reply-To: <faf3bae5-4656-7c47-d875-9103a5f2079e@linux.intel.com>
From: Adriana Nicolae <adriana@arista.com>
Date: Wed, 21 Jan 2026 18:55:12 +0200
X-Gm-Features: AZwV_QjJo3xhCY1cWr9fdI22exkv_0htJpjMeaVv3W0XAFLc5Uo5klI2h_OJ0us
Message-ID: <CAERbo5z2370GPWUNuSJuwZxga0se7CNH2XAnsnF-vtB7t6XREQ@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250 dw: clear FIFO before writting LCR
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial <linux-serial@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, prasad@arista.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 4:31=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 31 Oct 2025, Adriana Nicolae wrote:
>
> > On Wed, Oct 8, 2025 at 4:12=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Wed, 8 Oct 2025, Adriana Nicolae wrote:
> > > > Hello, Sorry for missing an update, the exact root cause is not cle=
ar, currently the
> > > > brute force method of draining FIFO right before setting or clearin=
g DLAB was stable
> > > > during tests.
> > > >
> > > > The serial stuck seems to be a failed attempt to clear the DLAB.
> > > > This operation fails because the USR indicates the hardware is
> > > > still busy, even though the UART is in loopback mode and should
> > > > be inactive.
> > > >
> > > > To isolate the issue, I tried the following without success:
> > > > - Added delays: I inserted 100 repeated ndelay(p->frame_time)
> > > > calls before and after enabling loopback mode to allow the FIFO
> > > > to clear.
> > > > - Cleared FIFO: I explicitly cleared the FIFO in addition to
> > > > adding the delay.
> > > > - Checked status: I printed the LSR just before the DLAB clear
> > > > attempt and checked the USB busy bit.
> > >
> > > Okay, so the BUSY must be stuck asserted.
> > >
> > > Another idea, maybe test tx + rx over loopback to see if that manages=
 to
> > > de-freeze the BUSY bit. A patch to that effect below.
> > >
> > > (I've only added the new block into dw8250_idle_enter() compared with=
 the
> > > old patch but rebasing to tty-next resulted in some other changes due=
 to
> > > conflicts.)
> >
> > I've tested the new dw8250_idle_enter() sequence, and you're right,
> > the BUSY bit remains set after entering loopback mode.
> >
> > However, the sequence in the patch (including the single loopback
> > tx/rx) wasn't quite enough. I didn't see any kernel panics or console
> > stuck anymore, but I've monitored the traces and there were cases when
> > the trace after "p->serial_out(p, UART_LCR, up->lcr);" showed both
> > BUSY bit set and DLAB bit still enabled.
> >
> > >
> > > Only thing besides BUSY being stuck asserted is something Tx'ing afte=
r the
> > > idle enter sequence. I think we could trap/check that too in
> > > dw8250_serial_out() by using something along these lines:
> > >
> > >         if (d->in_idle && offset =3D=3D UART_TX) {
> > >                 WARN_ON_ONCE(1);
> > >                 return;
> > >         }
> > >
> > > (I think that should catch even console writes but I'm not 100% sure =
of
> > > that and it will should get us where the rogue Tx originates from).
> >
> > I also added the WARN_ON_ONCE check you suggested in
> > dw8250_serial_out(). The warning has not triggered, so it seems we
> > don't have a rogue Tx firing while in_idle is set.
> >
> > >
> > > > The critical finding was that immediately before the DLAB clear
> > > > operation (p->serial_out(p, UART_LCR, up->lcr);), the LSR value
> > > > was 0x6a and the USR busy bit [0] was set. This confirms the UART
> > > > is busy, which blocks the DLAB modification.
> > > >
> > > > This is occurring on a device with a single UART console. The setup
> > > > does not use DMA or modem control; only the Rx/Tx lines are connect=
ed.
> > > >
> > > > The trace below, from a single process, shows one successful DLAB
> > > > clear followed by a failing one. The second attempt repeatedly logs
> > > > "USR still busy" before eventually succeeding. This can lead to
> > > > subsequent failures in dw8250_check_lcr: dw8250_idle_entered.
> > > >
> > > > Trace Log:
> > > >
> > > > <...>-15440  8583.592533: dw8250_idle_enter: in_idle =3D 1
> > > > login-15440  8583.713817: dw8250_idle_enter: in loopback mode
> > > > login-15440  8583.835099: dw8250_idle_enter: LSR in loopback mode i=
s 0x63
> > > > login-15440  8583.835103: dw8250_set_divisor: UART_LCR_DLAB cleared=
 13
> > > > login-15440  8583.835104: dw8250_idle_exit: idle exit
> > > > login-15440  8583.835105: dw8250_idle_exit: out of loopback mode
> > > > login-15440  8583.835105: dw8250_idle_exit: in_idle =3D 0
> > > > login-15440  8583.835352: dw8250_idle_enter: in_idle =3D 1
> > > > login-15440  8583.956633: dw8250_idle_enter: in loopback mode
> > > > login-15440  8583.956638: dw8250_idle_enter: LSR in loopback mode i=
s 0x6a
> > > > login-15440  8583.963918: dw8250_set_divisor: USR still busy dl_wri=
te
> > > > login-15440  8584.000332: dw8250_set_divisor: USR still busy dl_wri=
te
> > > > login-15440  8584.040385: dw8250_set_divisor: USR still busy dl_wri=
te
> > > > login-15440  8584.078012: dw8250_set_divisor: UART_LCR_DLAB cleared=
 93
> > > > login-15440  8584.078013: dw8250_idle_exit: idle exit
> > > > login-15440  8584.078014: dw8250_idle_exit: out of loopback mode
> > > > login-15440  8584.078015: dw8250_idle_exit: in_idle =3D 0
> > >
> > >
> > >
> > > --
> > > From 01df58736a10f7f34aca895ef08e5519953f8572 Mon Sep 17 00:00:00 200=
1
> > > From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux=
.intel.com>
> > > Date: Wed, 8 Oct 2025 15:40:19 +0300
> > > Subject: [PATCH 1/1] serial: 8250_dw: Ensure BUSY is deasserted
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=3DUTF-8
> > > Content-Transfer-Encoding: 8bit
> > >
> > > DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
> > > Existance of BUSY depends on uart_16550_compatible, if UART HW is
> > > configured with 16550 compatible those registers can always be
> > > written.
> > >
> > > There currently is dw8250_force_idle() which attempts to archive
> > > non-BUSY state by disabling FIFO, however, the solution is unreliable
> > > when Rx keeps getting more and more characters.
> > >
> > > Create a sequence of operations to enforce that ensures UART cannot
> > > keep BUSY asserted indefinitely. The new sequence relies on enabling
> > > loopback mode temporarily to prevent incoming Rx characters keeping
> > > UART BUSY.
> > >
> > > Use the new dw8250_idle_enter/exit() to do divisor writes and LCR
> > > writes.
> > >
> > > This issue was reported by qianfan Zhao who put lots of debugging
> > > effort into understanding the solution space.
> > >
> > > Reported-by: qianfan Zhao <qianfanguijin@163.com>
> > > Reported-by: Adriana Nicolae <adriana@arista.com>
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_dw.c | 159 +++++++++++++++++++++-------=
--
> > >  1 file changed, 115 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8=
250/8250_dw.c
> > > index a53ba04d9770..8e25dfe8e653 100644
> > > --- a/drivers/tty/serial/8250/8250_dw.c
> > > +++ b/drivers/tty/serial/8250/8250_dw.c
> > > @@ -42,6 +42,8 @@
> > >  /* DesignWare specific register fields */
> > >  #define DW_UART_MCR_SIRE               BIT(6)
> > >
> > > +#define DW_UART_USR_BUSY               BIT(0)
> > > +
> > >  /* Renesas specific register fields */
> > >  #define RZN1_UART_xDMACR_DMA_EN                BIT(0)
> > >  #define RZN1_UART_xDMACR_1_WORD_BURST  (0 << 1)
> > > @@ -77,6 +79,7 @@ struct dw8250_data {
> > >
> > >         unsigned int            skip_autocfg:1;
> > >         unsigned int            uart_16550_compatible:1;
> > > +       unsigned int            in_idle:1;
> > >  };
> > >
> > >  static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_=
data *data)
> > > @@ -108,36 +111,103 @@ static inline u32 dw8250_modify_msr(struct uar=
t_port *p, unsigned int offset, u3
> > >  }
> > >
> > >  /*
> > > - * This function is being called as part of the uart_port::serial_ou=
t()
> > > - * routine. Hence, it must not call serial_port_out() or serial_out(=
)
> > > - * against the modified registers here, i.e. LCR.
> > > + * Ensure BUSY is not asserted. If DW UART is configured with
> > > + * !uart_16550_compatible, the writes to LCR, DLL, and DLH fail whil=
e
> > > + * BUSY is asserted.
> > > + *
> > > + * Context: port's lock must be held
> > >   */
> > > -static void dw8250_force_idle(struct uart_port *p)
> > > +static int dw8250_idle_enter(struct uart_port *p)
> > >  {
> > > +       struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> > >         struct uart_8250_port *up =3D up_to_u8250p(p);
> > > -       unsigned int lsr;
> > > +       u32 lsr;
> > >
> > > -       /*
> > > -        * The following call currently performs serial_out()
> > > -        * against the FCR register. Because it differs to LCR
> > > -        * there will be no infinite loop, but if it ever gets
> > > -        * modified, we might need a new custom version of it
> > > -        * that avoids infinite recursion.
> > > -        */
> > > -       serial8250_clear_and_reinit_fifos(up);
> > > +       if (d->uart_16550_compatible)
> > > +               return 0;
> > > +
> > > +       d->in_idle =3D 1;
> > > +
> > > +       /* Prevent triggering interrupt from RBR filling */
> > > +       p->serial_out(p, UART_IER, 0);
> > > +
> > > +       serial8250_rx_dma_flush(up);
> > > +       // What about Tx DMA? Should probably pause that too and resu=
me
> > > +       // afterwards.
> > > +
> > > +       p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
> > > +       if (up->capabilities & UART_CAP_FIFO)
> > > +               p->serial_out(p, UART_FCR, 0);
> >
> > Changing this to repeatedly clear the FIFO turned out to reliably
> > clear the BUSY bit , also no kernel panic or device stuck in busy
> > mode.
> >
> > On the device I tested the first clear is not always enough, under
> > high load I saw it cleared on the second iteration. I'm thinking it
> > might be some particular issue with the device I'm using where the
> > first FIFO clear might fail. I never encountered more than 2
> > iterations with a "ndelay(p->frame_time);" in between here to get out
> > of BUSY state.
>
> Hi,
>
> I seem to have missed this email until now (I'm sorry about that, though
> to my defence, IIRC, I was quite sick around that timeframe it was sent
> and clear the email backlog isn't ever fun and may end up missing
> something).
>
> Do you mean changing this to a simple loop or writing something else than
> just 0 to FCR (or perhaps calling serial8250_clear_fifos())?
>
> What is the exact code that you found working?
>
Yes, everything worked ok for me after changing the dw8250_idle_enter
function with the one below. From traces added in the function, it
sometimes reported iterations_in_busy =3D 2 but never higher than that.
The function only has the prepended "while(p->serial_in(p,
d->pdata->usr_reg) & DW_UART_USR_BUSY) {" to iterate forever, although
it was at most 2 iterations when serial was stressed:
static int dw8250_idle_enter(struct uart_port *p)
{
    struct dw8250_data *d =3D to_dw8250_data(p->private_data);
    struct uart_8250_port *up =3D up_to_u8250p(p);
    u32 lsr, iterations_in_busy =3D 0;

    if (d->uart_16550_compatible)
        return 0;

    d->in_idle =3D 1;

    /* Prevent triggering interrupt from RBR filling */
    p->serial_out(p, UART_IER, 0);

    serial8250_rx_dma_flush(up);
    // What about Tx DMA? Should probably pause that too and resume
    // afterwards.
    p->serial_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);

    while(p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY) {
        if (up->capabilities & UART_CAP_FIFO) {
            p->serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
            p->serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
                UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
            p->serial_out(p, UART_FCR, 0);
        }
        ndelay(p->frame_time);
        iterations_in_busy++;
    }

    trace_printk("Not busy got after %d\n", iterations_in_busy);
    lsr =3D serial_lsr_in(up);
    if (lsr & UART_LSR_DR) {
        p->serial_in(p, UART_RX);
        up->lsr_saved_flags =3D 0;
    }

        /*
     * BUSY might still be frozen to asserted, try to de-freeze it by
     * sending a character over the loopback and receiving it.
         */
    if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY) {
        trace_printk("Serial USR still busy\n");
        p->serial_out(p, UART_TX, 0);
        ndelay(1000);
        lsr =3D serial_lsr_in(up);

        if (lsr & UART_LSR_DR) {
            p->serial_in(p, UART_RX);
            up->lsr_saved_flags =3D 0;
        }
        }

     /* Now guaranteed to have BUSY deasserted? Just sanity check */
    if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY) {
        trace_printk("BUSY\n");
        return -EBUSY;
    }

    return 0;
}
> So when you fixed this FIFO clearing thing, everything seemed to work oka=
y
> after that?
>
> In the meantime, this issue has once again been reported to me by somebod=
y
> else, and I've done improvements to shutdown code as well to address a
> few BUSY related problems (I'll be posting a series that solved that
> case soon but I suppose this patch needs amendments based on input from
> your case).
>
> --
>  i.
>
> > > +       if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY)
> > > +               ndelay(p->frame_time);
> > > +
> > > +       lsr =3D serial_lsr_in(up);
> > > +       if (lsr & UART_LSR_DR) {
> > > +               p->serial_in(p, UART_RX);
> > > +               up->lsr_saved_flags =3D 0;
> > > +       }
> > >
> > >         /*
> > > -        * With PSLVERR_RESP_EN parameter set to 1, the device genera=
tes an
> > > -        * error response when an attempt to read an empty RBR with F=
IFO
> > > -        * enabled.
> > > +        * BUSY might still be frozen to asserted, try to de-freeze i=
t by
> > > +        * sending a character over the loopback and receiving it.
> > >          */
> > > -       if (up->fcr & UART_FCR_ENABLE_FIFO) {
> > > -               lsr =3D serial_port_in(p, UART_LSR);
> > > -               if (!(lsr & UART_LSR_DR))
> > > -                       return;
> > > +       if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY) {
> > > +               p->serial_out(p, UART_TX, 0);
> > > +               ndelay(p->frame_time);
> > > +               lsr =3D serial_lsr_in(up);
> > > +               if (lsr & UART_LSR_DR) {
> > > +                       p->serial_in(p, UART_RX);
> > > +                       up->lsr_saved_flags =3D 0;
> > > +               }
> > >         }
> > >
> > > -       serial_port_in(p, UART_RX);
> > > +       /* Now guaranteed to have BUSY deasserted? Just sanity check =
*/
> > > +       if (p->serial_in(p, d->pdata->usr_reg) & DW_UART_USR_BUSY)
> > > +               return -EBUSY;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void dw8250_idle_exit(struct uart_port *p)
> > > +{
> > > +       struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> > > +       struct uart_8250_port *up =3D up_to_u8250p(p);
> > > +
> > > +       if (d->uart_16550_compatible)
> > > +               return;
> > > +
> > > +       if (up->capabilities & UART_CAP_FIFO)
> > > +               p->serial_out(p, UART_FCR, up->fcr);
> > > +       p->serial_out(p, UART_MCR, up->mcr);
> > > +       p->serial_out(p, UART_IER, up->ier);
> > > +
> > > +       // Maybe move the DMA Rx restart check in dma_rx_complete() t=
o own
> > > +       // function (serial8250_rx_dma_restart()) and call it from he=
re.
> > > +       // DMA Tx resume
> > > +
> > > +       d->in_idle =3D 0;
> > > +}
> > > +
> > > +static void dw8250_set_divisor(struct uart_port *p, unsigned int bau=
d,
> > > +                              unsigned int quot, unsigned int quot_f=
rac)
> > > +{
> > > +       struct uart_8250_port *up =3D up_to_u8250p(p);
> > > +       int ret;
> > > +
> > > +       ret =3D dw8250_idle_enter(p);
> > > +       if (ret < 0)
> > > +               goto idle_failed;
> > > +
> > > +       p->serial_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > > +       if (!(p->serial_in(p, UART_LCR) & UART_LCR_DLAB))
> > > +               goto idle_failed;
> > > +
> > > +       serial_dl_write(up, quot);
> > > +       p->serial_out(p, UART_LCR, up->lcr);
> > > +
> > > +idle_failed:
> > > +       dw8250_idle_exit(p);
> > >  }
> > >
> > >  /*
> > > @@ -148,37 +218,37 @@ static void dw8250_force_idle(struct uart_port =
*p)
> > >  static void dw8250_check_lcr(struct uart_port *p, unsigned int offse=
t, u32 value)
> > >  {
> > >         struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> > > -       void __iomem *addr =3D p->membase + (offset << p->regshift);
> > > -       int tries =3D 1000;
> > > +       u32 lcr =3D p->serial_in(p, UART_LCR);
> > > +       int ret;
> > >
> > >         if (offset !=3D UART_LCR || d->uart_16550_compatible)
> > >                 return;
> > >
> > >         /* Make sure LCR write wasn't ignored */
> > > -       while (tries--) {
> > > -               u32 lcr =3D serial_port_in(p, offset);
> > > -
> > > -               if ((value & ~UART_LCR_SPAR) =3D=3D (lcr & ~UART_LCR_=
SPAR))
> > > -                       return;
> > > +       if ((value & ~UART_LCR_SPAR) =3D=3D (lcr & ~UART_LCR_SPAR))
> > > +               return;
> > >
> > > -               dw8250_force_idle(p);
> > > +       if (d->in_idle) {
> > > +               /*
> > > +                * FIXME: this deadlocks if port->lock is already hel=
d
> > > +                * dev_err(p->dev, "Couldn't set LCR to %d\n", value)=
;
> > > +                */
> > > +               return;
> > > +       }
> > >
> > > -#ifdef CONFIG_64BIT
> > > -               if (p->type =3D=3D PORT_OCTEON)
> > > -                       __raw_writeq(value & 0xff, addr);
> > > -               else
> > > -#endif
> > > -               if (p->iotype =3D=3D UPIO_MEM32)
> > > -                       writel(value, addr);
> > > -               else if (p->iotype =3D=3D UPIO_MEM32BE)
> > > -                       iowrite32be(value, addr);
> > > -               else
> > > -                       writeb(value, addr);
> > > +       ret =3D dw8250_idle_enter(p);
> > > +       if (ret < 0) {
> > > +               /*
> > > +                * FIXME: this deadlocks if port->lock is already hel=
d
> > > +                * dev_err(p->dev, "Couldn't set LCR to %d\n", value)=
;
> > > +                */
> > > +               goto idle_failed;
> > >         }
> > > -       /*
> > > -        * FIXME: this deadlocks if port->lock is already held
> > > -        * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> > > -        */
> > > +
> > > +       p->serial_out(p, UART_LCR, value);
> > > +
> > > +idle_failed:
> > > +       dw8250_idle_exit(p);
> > >  }
> > >
> > >  /* Returns once the transmitter is empty or we run out of retries */
> > > @@ -547,6 +617,7 @@ static int dw8250_probe(struct platform_device *p=
dev)
> > >         p->dev          =3D dev;
> > >         p->set_ldisc    =3D dw8250_set_ldisc;
> > >         p->set_termios  =3D dw8250_set_termios;
> > > +       p->set_divisor  =3D dw8250_set_divisor;
> > >
> > >         data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > >         if (!data)
> > >
> > > base-commit: d21b26cad33250be758ea9d860ff9d5c3992c459
> > > --
> > > 2.39.5
> >
