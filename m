Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793294139;
	b=aXwLGsDGr2LEsNVRLhTIR07ZJfpcpmzUjYxiF81SiRGd9qe0SIizqV9YUjZwcL2qMRFA
	 8s/CvxeaSbljJTTONiM6zOx0MPbGDR7KPNJU/riXwqfMGoskYrlrvqcdyg+PzCFw6MbZF
	 Oq0QHrPeFGgycvzlBkXOkihEd6OMMgoLs3Ri2kLV523KEox9VZPJ704RYXxy2pTHCxTOs
	 fC7saO2eJJbSc7E1j9RvPEW0u87+IvCtryLCTx2etda9+ZmhddGSYM1zxPkUF7nFVtDwt
	 M4QaHpfH96u4HhAOJd37canPdBUwpQq8lIrwh+8TTzIGWaGmBJLCDK/MsAloCmmDo/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bfkoGr6eHduUtBaHwkrM0dSWX67wyi9EvMSHv231Bb8=;
	b=wTUutAdkrmcnoiRfaazJk2URtwCYtvepZUdMCu6Ov4xXi4IVjpLbFoT8qXNBYR4fCyfn
	 pxdHYUeGiTAhCaiGxR+pR9LAhOSX/vZiV6eMUso+F2zZVElynmjnhR6rQjOS5MS3lZmHj
	 NeOGaxUIdj4fR3r39yy422nJybK3fDtkHmxt0I8jZsyEZTZQ0iZB/AjQ+xnTDndwlgk1Z
	 YTppLMHEoIQrabOKnCDGQ1axhSgddrmOkO3gQ+S0654/nKv3xdWhHOiqvAZe3XCumbRqO
	 plRIm+uXi54Ddlk++y89QnYe2sN1kE99HXAFIRGXJ5NYpzDfuLmgoGUOzNMpKgNZ+/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qg2kzRNb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADBB606A31D
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 17:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ADBB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qg2kzRNb
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so2797214a12.0
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 10:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793294137; cv=none;
        d=google.com; s=arc-20260327;
        b=sXCsNoU+zKAIQ4mZE5tUIPdUhvM7dcMlpiYP01O499yKY4CPBJr3A9J3xk/TIqRsMI
         2RweOPp919EYGI3KDRPScCLxP1nPS65igkLRqrGol2GZJWbYDUHLcR9H6li0gK22zytL
         Zc47fWURtO69dob5RiIGCuVktPcoTdFFz8oJCybenU9JKFssq5F5JWpD84eo48+UULFF
         kEieB+VVHNi56eE/Gnt5sECX+Ty0KTbs00hHyDs8yBjo+2JlTftbJwYT5AcfZyywlfvZ
         Xx2536IEJ6jpHmzlVmBUzcXOazslpCmGDFmzuRkLYZ/hGsdK1lyz9I/8t6yyh4MRSXZ9
         yzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bfkoGr6eHduUtBaHwkrM0dSWX67wyi9EvMSHv231Bb8=;
        fh=jcmivpQjsDiPAAR3w/9Mjl9eaDFJjllgmQuj+VitR3Q=;
        b=BWqqEdxYyAJeXhh3/3fA1HsDZjmgoUYe+TJeR7cqmsfA3NPZTEEmJvFael+C5Ij9ZZ
         O57xRqA3zeSPYlwRDytgL+mqShuDYFJ0tqNlE8aLbYglhmSFDOd9EbJYqsGbo5qry9Py
         n9mV6PuMdyj1LpYFqW5kvoMZZ/eQc+srMJPPCRamRPDopkVbxlnqUnCd4OWPbETmUb4F
         IADzzkzAv0WX9K/TrviZ2MsIWfy6InopIRKMw1C8D0YM2Ls6v3wzOS3Xj4baUBXg35bE
         F64I5ddFcy2WsBTVoxket47c9QIxjEJvxfiYy8EF22ZkLCT7kqwEd0zYuCvejWrT9ipQ
         sZgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793294137; x=1793898937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfkoGr6eHduUtBaHwkrM0dSWX67wyi9EvMSHv231Bb8=;
        b=Qg2kzRNbKHLPWJYfxjKjHkXAfeB0MLO0or0OFQdurJB00WngcgaQU4vvDLCoI0aH2B
         N3ggPFa6Vs0Z5AbGMDAa5CV5wGTnP0SRBhx1Hne0ABkzIRjIoQAV+ZPEqRfPKAD7ocDK
         ImFFvAjsytnE0TKc+HxRS0yh6n5/GyaatdDdqNVfubZ5jUFvqB7TUDYuwq1Z+OG3phTv
         jtI0oKQYFY5769oohWqV78E+yp57ZEaxfyz1vvB7DRWPycHqWXfMJR8KBrm3xEr7oST3
         kSMNXwIhPLnHhKhqnWAT+8ApIxhPz5aOYTykHWTmOl0LQptDHZZLLW+HAfDRUgp1F2kz
         oMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294137; x=1793898937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfkoGr6eHduUtBaHwkrM0dSWX67wyi9EvMSHv231Bb8=;
        b=RFdTgVBELcfOo+LGVoFy4+gGvsSHBURgJwhq2CFY2k91dWotOy3/X8zEYBwHFvOoJ1
         2GTl6/BPoUGjEqvXofx7Q3LmDh2RlYXMKBN7LrvZSaDVwKRw86KID6paPwKTMO2nWvks
         DKgEpmxUrFfqPptA8SHjB37yhMy/AJBHHISUc12w1bYE8anz5RBxzHDZzyqT3j003Cir
         jhDqRDPFxl/R60aNLcKgH6vG/bw93Yn+1YX9UxXANsEINgfOtwlWRqghNb4XzRM4N/+T
         WG92K7M6TUp5ViIxu6z2p3gPYjezz46+iuolqS/kxF/cjAuLN7w/TJPXrRtO36WGhK00
         CpnQ==
X-Forwarded-Encrypted: i=1; AKwUvBymOEHW8qlOA0zM/4eB3oPW1HuvifYneG2e1dR6vDMFs6MfI3+ndPWpZEsdI/GcB3jpL2sbGmGbosd7jpg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLg5+eEJBxL7cHJuW7RXVRqWs8lbhT2ecbPInWmKg17GwXb66RN
	Y+AiunFUCz00g74jGRv2Eo37mBm3vdYkK2z19v0VGx73W7XWH34/scfrvw+EJjMtuJmZqyXIM2D
	yopKrhHzY263enmnRJV1uF1PDsnx1gDI=
X-Gm-Gg: AYBFou289acU9AVEosRA6k4iFjIbnfZ//WQjhIw54YC8sVefhh/cjyVkPgdPLW+up4q
	l4i2dKpxmcTNR3Rzx7Pj6/QMfezk2ihjdrL40bLn+fvBdjVy1zYJ7PdgyUgq4MNWjnpmGTS0kxe
	9uNmFneyFGTM0PJ7to1Fk5zX0v04A00940nhpSkYAJC5/j1As807R3DzQBQi+B6MW1hmHH7Vfyw
	6jUdeKAGCROiOjHJxSXS9bjMu5q1eq02UvsPkOXQuy8cTlAvaSf/AYoK1NcyFvLMHbfkpAnr6SG
	ISombSHpWSF88bdEi2YIz5OuWQnE4VdpUctlyxUWUonm5G13MybkpV5OVoxt6f2c3lRM9WhmcoL
	Jfg03sqF1Nm1myOUN1joAviFe/eLyzI80xeep6uB6qDx/3M2AfKNbs0Dx00MkgHmAejtUFLboIt
	om5+064QC+98NrD8xxRqLBIrM9zTdYTfR8ZAIrG5puqTXytqT7XKVLS7L6eciL6URJEnnamw2ls
	sTTaaHsyZEWix92hBnlJ9y6KaU6RQ==
X-Received: by 2002:aa7:c687:0:b0:6b3:f840:59b5 with SMTP id
 4fb4d7f45d1cf-6b49cc019b3mr3067325a12.27.1793294136580; Thu, 29 Oct 2026
 10:15:36 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-4-3fd56ba352ed@gmail.com> <auNV7Vco5O3vVwRH@ashevche-desk.local>
In-Reply-To: <auNV7Vco5O3vVwRH@ashevche-desk.local>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 11:15:23 -0600
X-Gm-Features: AclHuK8a3pNXQ_IsYXCQfDMZzFxdEUJPDH5qKP3q2TLb8CO-tQBpFEH7zYCUMxU
Message-ID: <CADvTj4oi6dFzWkjFXie1U49A70Y7Mb=4exga-=2SmG7fN2pLrA@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] serial: 8250: drain canceled TX DMA before reusing
 its buffer
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Raul E Rangel <rrangel@chromium.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Tony Lindgren <tony@atomide.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Richard Genoud <richard.genoud@bootlin.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Timur Tabi <timur@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 8:19=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 29, 2026 at 01:37:00AM -0600, James Hilliard wrote:
> > uart_flush_buffer() resets the transmit kfifo before calling the driver=
.
> > serial8250_tx_dma_flush() terminates DMA asynchronously and clears
> > tx_running, allowing a new write to replace tx_size while a detached
> > callback has not yet run. That callback can then consume bytes
> > from the new transmission. Reusing the reset kfifo can also overwrite t=
he
> > source of a transfer that has not stopped yet.
> >
> > Reserve the flushed FIFO storage through serial core before returning
> > from the flush callback. Keep tx_running set until a worker synchronize=
s
> > the terminated channel, suppressing old callbacks and new submissions
> > during that interval. Return the mapping to CPU ownership before releas=
ing
> > the reservation and waking writers. Normal transfers continue to use th=
e
> > FIFO directly.
> >
> > Reuse the locked completion processing after retirement, including OMAP
> > delayed register restoration and transmitter-empty handling. Take a run=
time
> > PM reference around worker UART accesses and drain the worker before
> > releasing the channels. Shutdown releases the FIFO reservation after
> > stopping DMA and unmapping its source. Serial core keeps writes and wak=
eups
> > gated until startup or resume makes the port ready again.
> >
> > Track a flushed FIFO separately from the transfer length. If terminatio=
n
> > fails, retain the reservation until normal completion and account the
> > completed bytes without advancing the reset FIFO. After successful
> > cancellation, process a zero-length completion once callbacks have drai=
ned.
> >
> > The race was found by inspecting cancellation and restart while prepari=
ng
> > H616 UART DMA support.
> >
> > Retain the tx_running check in both completion callbacks. Releasing the
> > reservation relies on the DMA provider draining detached callbacks when
> > dmaengine_synchronize() returns; provider callback-lifetime fixes suppl=
y
> > that guarantee for controllers which previously lacked it.
>
> ...
>
> > -     bool                    shutting_down;
> > +     bool                    shutting_down:1;
> > +     bool                    tx_terminating:1;
> > +     bool                    tx_flushed:1;
>
> What is the meaning of bool XXX:1? Have you checked with `pahole` the res=
ult?

These are one-bit boolean fields, intended to pack the state flags
into one byte.

I've now compared layout probes using the kernel type definitions and
saved build flags, changing only those bitfields to ordinary bools.
For the complete v8 structure, including the RX flags, pahole reports:

                            Bitfields   Plain bool
    ARM32 / Clang               212         220
    ARM64 / GCC                 368         376
    ARM64 / GCC / PREEMPT_RT     368         376

The sizes are in bytes. All six flags share one byte in the packed
version. This saves eight bytes in each checked configuration.

The packing is a layout choice, not an atomicity mechanism; updates
still require the UART port lock. Given the measured saving, I'd keep
it unless there is another concern with using bool bitfields here.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
