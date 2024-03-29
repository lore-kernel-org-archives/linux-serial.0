Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C42232A
	for <linux-serial@vger.kernel.org>; Fri, 29 Mar 2024 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711679762; cv=none; b=EtIH+1qBvWVXItqCCoqVXzbE1g1FY0UVDLfoU1TvYOu6lweR7jYAEP1Uu+IK/r8CO7osEN+sYb8OWeSjEqddz13p08UIZHuA3Sdy1sRcHK7tDVXwd9UaOjKhmccJX8RaL8ZobWLzxTSra3UrDhH8gLzZC8DOvY8ZI6ApTWmjU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711679762; c=relaxed/simple;
	bh=xcfrMGOT8OVzPRDXugl28ftjdSmhJvUHQz4i66CAgS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otwmK0GsvsUWI4vAbnH/pSjFiWvtRxZ88Cw9ZSBzOP88eSw1Fyz/aTVe7J5DUq0miZc/rJxL984nxbHOVuTNTzZ8AYenMKLwXgVeizmIVg5HMibnX/DX4NgilMz5onJJhWAxBFz6AC5tBeXV8wztPOAv/T+fxfBH9kOm48fNfoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UbH9rtzD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UbH9rtzD"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e21ddc1911so95905ad.0
        for <linux-serial@vger.kernel.org>; Thu, 28 Mar 2024 19:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711679760; x=1712284560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eptapMuIRJGA6IHStAtLzDLwrTKbT0822tjLajRlP50=;
        b=UbH9rtzDAB3h6RoUarghWbIDQDZgWvEyAXpSelzMPJGEJTW3riHsGj1EkaOrVjn8El
         pbRwla9GTYAgJ/fq2u89Il3zVfBcQme30Ih0nO+oukE6DNSwc7mfVrORg1dqJnnLZq2N
         rwmz8ovWUAkMug1MGQghFA7BK6wU9CzZpP8iH3Fmz3aKSXMzFuHbI1eAPiUjbM3pQ004
         TmWD0YV05KCp2NFo5ptfFl26nHzXtUbLZbSq/a+B3yj+n12bsUdykznX5paqpILzDITC
         yQgd2NB3Me5bf1Sbza0K3DQF8nL0kgSVS56reV69/pWL4KPN68hcYlGJ99eDxR8vFM+X
         9x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711679760; x=1712284560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eptapMuIRJGA6IHStAtLzDLwrTKbT0822tjLajRlP50=;
        b=HGR2jrpVRUq4adBJ6Axxs2DJTxDs3dU0zxa6Un0ZS9jhakl5dFVKLJXYXjGBdE0Xo6
         TytoDvOBIZyJIeJhmyXcb61HsUo9blMjPtQZltLbXkiqFKuoKhuPocWuYTtPi3PcigMl
         PoRFLnXlaeVoCiBC1z2AFwkJpuFyY90W1D2aOKVhDW6qD4DD3IkhDS5jywdka10MuDV2
         8eTqc+CwTk3SK4szT5IrndlSneBFKwBRJOKn78C5LYL05Hm1j+6Ww7+2AajNQ+NVAXRv
         ilm4mywfWOoA0L+26OwG+YEHajrCwJlSsLw99gRb92oBGI8UAq9ySBE0mlWvEVcW5k0k
         BfNA==
X-Forwarded-Encrypted: i=1; AJvYcCXWvqECsb46w1wB8JurNVMqmCnW//tkf+o3ri4fwqWvPyx9/eX0aNiQFlLHINrzwPf0WPZB2+qtGfYqITnV/EkgkQmfGem07KtI2pBK
X-Gm-Message-State: AOJu0Yy2eqphI1vkXaP+AfW3rSwLkCcBIZaak0MqM7o06iA+2uk99LCQ
	T7qVVjX92lP7p/bs0Xr+MkEqIWZcXVLOWY9h0cPtAcId/shYZC4iCL2+QVnzZbseJLgd6d8YyUC
	sFx6dLSxyutUBVaYlyXlSURgjikCoatAAAQ8Y
X-Google-Smtp-Source: AGHT+IHw373yn3JSfqNCPQkcI2k3oDGket5i/LCWXrCABjpkR1y5TpK1yhx14IiDIQwIHoWzaWa/uNeKmfWatVOIGnw=
X-Received: by 2002:a17:903:2285:b0:1e0:bf26:b0ef with SMTP id
 b5-20020a170903228500b001e0bf26b0efmr128700plh.8.1711679760051; Thu, 28 Mar
 2024 19:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317214123.34482-1-hdegoede@redhat.com> <ZfgZEcg2RXSz08Gd@smile.fi.intel.com>
 <CAMn1gO4zPpwVDcv5FFiimG0MkGdni_0QRMoJH9SSA3LJAk7JqQ@mail.gmail.com>
 <35cdaf7e-ef32-470f-ab61-e5f4a3b35238@redhat.com> <33110d20-45d6-45b9-8af0-d3eac8c348b8@redhat.com>
In-Reply-To: <33110d20-45d6-45b9-8af0-d3eac8c348b8@redhat.com>
From: Peter Collingbourne <pcc@google.com>
Date: Thu, 28 Mar 2024 19:35:46 -0700
Message-ID: <CAMn1gO5-WD5wyPt+ZKDL-sRKhZvz1sUSPP-Mq59Do5kySpm=Sg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Revert: Do not reclock if already at
 correct rate
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	VAMSHI GAJJELA <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 5:35=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 3/28/24 8:10 AM, Hans de Goede wrote:
> > Hi,
> >
> > On 3/18/24 7:52 PM, Peter Collingbourne wrote:
> >> On Mon, Mar 18, 2024 at 3:36=E2=80=AFAM Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> wrote:
> >>>
> >>> On Sun, Mar 17, 2024 at 10:41:23PM +0100, Hans de Goede wrote:
> >>>> Commit e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at
> >>>> correct rate") breaks the dw UARTs on Intel Bay Trail (BYT) and
> >>>> Cherry Trail (CHT) SoCs.
> >>>>
> >>>> Before this change the RTL8732BS Bluetooth HCI which is found
> >>>> connected over the dw UART on both BYT and CHT boards works properly=
:
> >>>>
> >>>> Bluetooth: hci0: RTL: examining hci_ver=3D06 hci_rev=3D000b lmp_ver=
=3D06 lmp_subver=3D8723
> >>>> Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
> >>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
> >>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
> >>>> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
> >>>> Bluetooth: hci0: RTL: fw version 0x365d462e
> >>>>
> >>>> where as after this change probing it fails:
> >>>>
> >>>> Bluetooth: hci0: RTL: examining hci_ver=3D06 hci_rev=3D000b lmp_ver=
=3D06 lmp_subver=3D8723
> >>>> Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
> >>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
> >>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
> >>>> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
> >>>> Bluetooth: hci0: command 0xfc20 tx timeout
> >>>> Bluetooth: hci0: RTL: download fw command failed (-110)
> >>>>
> >>>> Revert the changes to fix this regression.
> >>>
> >>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>>
> >>>> Note it is not entirely clear to me why this commit is causing
> >>>> this issue. Maybe probe() needs to explicitly set the clk rate
> >>>> which it just got (that feels like a clk driver issue) or maybe
> >>>> the issue is that unless setup before hand by firmware /
> >>>> the bootloader serial8250_update_uartclk() needs to be called
> >>>> at least once to setup things ?  Note that probe() does not call
> >>>> serial8250_update_uartclk(), this is only called from the
> >>>> dw8250_clk_notifier_cb()
> >>>>
> >>>> This requires more debugging which is why I'm proposing
> >>>> a straight revert to fix the regression ASAP and then this
> >>>> can be investigated further.
> >>>
> >>> Yep. When I reviewed the original submission I was got puzzled with
> >>> the CLK APIs. Now I might remember that ->set_rate() can't be called
> >>> on prepared/enabled clocks and it's possible the same limitation
> >>> is applied to ->round_rate().
> >>>
> >>> I also tried to find documentation about the requirements for those
> >>> APIs, but failed (maybe was not pursuing enough, dunno). If you happe=
n
> >>> to know the one, can you point on it?
> >>
> >> To me it seems to be unlikely to be related to round_rate(). It seems
> >> more likely that my patch causes us to never actually set the clock
> >> rate (e.g. because uartclk was initialized to the intended clock rate
> >> instead of the current actual clock rate).
> >
> > I agree that the likely cause is that we never set the clk-rate. I'm no=
t
> > sure if the issue is us never actually calling clk_set_rate() or if
> > the issue is that by never calling clk_set_rate() dw8250_clk_notifier_c=
b()
> > never gets called and thus we never call serial8250_update_uartclk()
> >
> >> It should be possible to
> >> confirm by checking the behavior with my patch with `&& p->uartclk !=
=3D
> >> rate` removed, which I would expect to unbreak Hans's scenario. If my
> >> hypothesis is correct, the fix might involve querying the clock with
> >> clk_get_rate() in the if instead of reading from uartclk.
> >
> > Querying the clk with clk_get_rate() instead of reading it from
> > uartclk will not help as uartclk gets initialized with clk_get_rate()
> > in dw8250_probe(). So I believe that in my scenario clk_get_rate()
> > already returns the desired rate causing us to never call clk_set_rate(=
)
> > at all which leaves 2 possible root causes for the regressions:
> >
> > 1. The clk generator has non readable registers and the returned
> > rate from clk_get_rate() is a default rate and the actual hw is
> > programmed differently, iow we need to call clk_set_rate() at
> > least once on this hw to ensure that the clk generator is prggrammed
> > properly.
> >
> > 2. The 8250 code is not working as it should because
> > serial8250_update_uartclk() has never been called.
>
> Ok, so it looks like this actually is an issue with how clk_round_rate()
> works on this hw (atm, maybe the clk driver needs fixing).
>
> I have added the following to debug this:
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/=
8250_dw.c
> index a3acbf0f5da1..3152872e50b2 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -306,6 +306,8 @@ static void dw8250_clk_work_cb(struct work_struct *wo=
rk)
>         if (rate <=3D 0)
>                 return;
>
> +       pr_info("uartclk work_cb clk_get_rate() returns: %ld\n", rate);
> +
>         up =3D serial8250_get_port(d->data.line);
>
>         serial8250_update_uartclk(&up->port, rate);
> @@ -353,11 +355,15 @@ static void dw8250_set_termios(struct uart_port *p,=
 struct ktermios *termios,
>  {
>         unsigned long newrate =3D tty_termios_baud_rate(termios) * 16;
>         struct dw8250_data *d =3D to_dw8250_data(p->private_data);
> +       unsigned long currentrate =3D clk_get_rate(d->clk);
>         long rate;
>         int ret;
>
> +
>         rate =3D clk_round_rate(d->clk, newrate);
> -       if (rate > 0 && p->uartclk !=3D rate) {
> +       pr_info("uartclk set_termios new: %ld new-rounded: %ld current %l=
d cached %d\n",
> +               newrate, rate, currentrate, p->uartclk);
> +       if (rate > 0) {
>                 clk_disable_unprepare(d->clk);
>                 /*
>                  * Note that any clock-notifer worker will block in
> @@ -593,6 +599,8 @@ static int dw8250_probe(struct platform_device *pdev)
>         if (!p->uartclk)
>                 return dev_err_probe(dev, -EINVAL, "clock rate not define=
d\n");
>
> +       pr_info("uartclk initial cached %d\n", p->uartclk);
> +
>         data->pclk =3D devm_clk_get_optional_enabled(dev, "apb_pclk");
>         if (IS_ERR(data->pclk))
>                 return PTR_ERR(data->pclk);
>
> And then I get the following output:
>
> [    3.119182] uartclk initial cached 44236800
> [    3.139923] uartclk work_cb clk_get_rate() returns: 44236800
> [    3.152469] uartclk initial cached 44236800
> [    3.172165] uartclk work_cb clk_get_rate() returns: 44236800
> [   34.128257] uartclk set_termios new: 153600 new-rounded: 44236800 curr=
ent 44236800 cached 44236800
> [   34.130039] uartclk work_cb clk_get_rate() returns: 153600
> [   34.131975] uartclk set_termios new: 153600 new-rounded: 153600 curren=
t 153600 cached 153600
> [   34.132091] uartclk set_termios new: 153600 new-rounded: 153600 curren=
t 153600 cached 153600
> [   34.132140] uartclk set_termios new: 153600 new-rounded: 153600 curren=
t 153600 cached 153600
> [   34.132187] uartclk set_termios new: 1843200 new-rounded: 153600 curre=
nt 153600 cached 153600
> [   34.133536] uartclk work_cb clk_get_rate() returns: 1843200
>
> Notice how the new-rounded just returns the current rate of the clk,
> rather then a rounded value of new.
>
> I'm not familiar enough with the clk framework to debug this further.
>
> Peter, IMHO we really must revert your commit since it is completely
> breaking UARTs on many different Intel boards. Can you please give your
> ack for reverting this for now ?

That's fine with me. I will try to dig into the code soon to figure
out what is going on unless someone gets there first.

Acked-by: Peter Collingbourne <pcc@google.com>

Peter

>
> Regards,
>
> Hans
>
>
> p.s.
>
> For anyone who wants to dive into the clk_round_rate() issue deeper,
> the code registering the involved clks is here:
>
> drivers/acpi/acpi_lpss.c: register_device_clock()
>
> And for the clocks in question fixed_clk_rate is 0 and both
> the LPSS_CLK_GATE and LPSS_CLK_DIVIDER flags are set, so
> for a single UART I get:
>
> [root@fedora ~]# ls -d /sys/kernel/debug/clk/80860F0A:01*
> /sys/kernel/debug/clk/80860F0A:01      /sys/kernel/debug/clk/80860F0A:01-=
update
> /sys/kernel/debug/clk/80860F0A:01-div
>
> With the 80860F0A:01-update clk being the clk which is
> actually used / controlled by the 8250_dw.c code.
>
