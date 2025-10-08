Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C72116F6;
	Wed,  8 Oct 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925817; cv=none; b=h+F1WGV3eTWcvrjZOj0NtKMCMLCPT5bUqqD1B3SDR47G3IckvyakUeXQTp/13aPORYlB9JNqdI2jIgEQqQc5pUobe7GxA0vy32WN4Uqbg4uVv0PN91tXpLm6PoU66FzGCzoBxSL/oBQWjwrCNL9nj3Hcz1qwoAwVWi8nN7Dra0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925817; c=relaxed/simple;
	bh=41Q6dYudRRc1BldM8r7PPMDN3nIYC3sGz9eHv636/GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+hJKhFPWfSzaRekbuoo8ZQUZV/ubDatogfjsY5I8U1VFvdKH7EWh8li7f8cU4jDE1UvA7tYQaN+nWQRFnsnB+cHLgAH6r45npXHDHqg1O9pARH3HtXg0fVCCOB3U+3kWw01J7CsYyJPV27uMTYyJ6dn4PEGVsc4vh3moqVn30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=liOJUmyV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="liOJUmyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6522EC4CEF5;
	Wed,  8 Oct 2025 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759925816;
	bh=41Q6dYudRRc1BldM8r7PPMDN3nIYC3sGz9eHv636/GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liOJUmyVi2ItxLHP/m5OEoyKjYw5r41MGqxA3tKydZ85y/ITbFnG/dKJwMEQQIc0m
	 rbX3LuZHJlZY+T7dIlx8p9/hUhkToReczlr3f47RQa/QgEzOxJ0RBAGri0EGhqnCNg
	 AldM/D7MqkSwWzg9Hw2As38aOQfL4NQvt86y0D9A=
Date: Wed, 8 Oct 2025 14:16:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 2/3] serial: 8250: Add Loongson uart driver support
Message-ID: <2025100838-deskbound-framing-ac6f@gregkh>
References: <cover.1758676290.git.zhoubinbin@loongson.cn>
 <9823e7afe713450e210dab9dba6fa18683dc1fe0.1758676290.git.zhoubinbin@loongson.cn>
 <2025092428-glade-monologue-3663@gregkh>
 <CAMpQs4JgR=iG6LAuYeVxOpE31S6n=dC4+FGUJczOYDVfWHDuFw@mail.gmail.com>
 <b862846d-fb2a-4df4-8457-d858aa63031d@kernel.org>
 <CAMpQs4KVgSFk=B5JtQ1KM02HydTkwaYqi+LzzhdJAyoSUfAxLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4KVgSFk=B5JtQ1KM02HydTkwaYqi+LzzhdJAyoSUfAxLw@mail.gmail.com>

On Tue, Sep 30, 2025 at 11:03:29AM +0800, Binbin Zhou wrote:
> Hi Jiri:
> 
> Thanks for your reply.
> 
> On Mon, Sep 29, 2025 at 2:19 PM Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > Hi,
> >
> > On 28. 09. 25, 4:48, Binbin Zhou wrote:
> > > Hi Greg:
> > >
> > > Thanks for your reply.
> > >
> > > On Wed, Sep 24, 2025 at 6:22 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > >>
> > >> On Wed, Sep 24, 2025 at 02:29:37PM +0800, Binbin Zhou wrote:
> > >>> --- a/include/uapi/linux/serial_core.h
> > >>> +++ b/include/uapi/linux/serial_core.h
> > >>> @@ -31,6 +31,7 @@
> > >>>   #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
> > >>>   #define PORT_RT2880  29      /* Ralink RT2880 internal UART */
> > >>>   #define PORT_16550A_FSL64 30 /* Freescale 16550 UART with 64 FIFOs */
> > >>> +#define PORT_LOONGSON        31      /* Loongson 16550 UART */
> > >>
> > >> Why does userspace need to have this value exported?
> > >
> > > Sorry, this was a cheap mistake.
> > > It should follow the existing latest macro definition as follows:
> >
> > That was not the point. The point was why do you need that at all?
> 
> Emm...
> We attempted to define Loongson UART as a new `uart_config` entry.
> Therefore, `PORT_LOONGSON` is referenced as follows:
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index 719faf92aa8a..53efe841656f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -310,6 +310,14 @@ static const struct serial8250_config uart_config[] = {
>                 .rxtrig_bytes   = {1, 8, 16, 30},
>                 .flags          = UART_CAP_FIFO | UART_CAP_AFE,
>         },
> +       [PORT_LOONGSON] = {
> +               .name           = "Loongson",
> +               .fifo_size      = 16,
> +               .tx_loadsz      = 16,
> +               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
> +               .rxtrig_bytes   = {1, 4, 8, 14},
> +               .flags          = UART_CAP_FIFO,
> +       },
>  };
> 
>  /* Uart divisor latch read */
> 
> Additionally, `uart.port.type` will also be assigned the value `PORT_LOONGSON`.

Yes, but that is the same exact value as PORT_PXA, which means this code
will not really work properly, right?  You can not just redefine an
already used user/kernel value.

thanks,

greg k-h
