Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACD1FBEA8
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113661; cv=none; b=Z5HUQq3CLsB2yfIvPakh2GphOmxqpJt3VCr1FcJGs8jzzDF5GUS5dFAmw/OR7CO9sJG6K4UY+gUfhlb59HWH0Lhrm5zP0gkazTG3uenOYWAaPBzrUjxDVhgTVOv9Dt8qyH+bn4zAA9Ln5FefckqhWT7AZjh9N3OgeKxvR0TrfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113661; c=relaxed/simple;
	bh=5qDpVkMt4wmJAuvajXr0K3vaIjTuOXwvJrhqj7SsGUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtPh0LxjDcZXOgYuXgJShfZmTpjHlcy3mBozbf92xbcOKCpbdUp8BFf2dMHIv0xMgWO78Rb22xZGqIWR2t5pJ/0D/ay19uKQybQ2kW/t9RMiNrMpjLND2dZ3T/wpavvsg66Oj4BkFIZ/EnMwGjYmku8drwdUryEdeOnHLn+cXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6QG2BYX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6QG2BYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779113659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0PKPpLFUcJ5PNICdj+fODP+ieu23TytLui2uhS6hnY=;
	b=i6QG2BYXKj09OPLAk3GnVux+ExBCGks4czXI+zrCTICAPPNl2O0GRZoetW2lsWe1GbKU22
	mNLmFVMYvIHF2V+npB/e9qzhiIwtWg1lc5glBOfZcGFPuA0NXx4b/Ihz98rozgvRA/oGlZ
	sMnPNWSKRjoHp5sS+I5mCSZ8eMj/log=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-CAHuDEX2P7CGFIUjBvvn4A-1; Mon, 18 May 2026 10:14:18 -0400
X-MC-Unique: CAHuDEX2P7CGFIUjBvvn4A-1
X-Mimecast-MFC-AGG-ID: CAHuDEX2P7CGFIUjBvvn4A_1779113656
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5a870f93c99so207037e87.0
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 07:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779113656; x=1779718456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X0PKPpLFUcJ5PNICdj+fODP+ieu23TytLui2uhS6hnY=;
        b=TFDG2SBGsRjsD29E++ZfBS0at/ANPCvjUox4F4AFOSQK+DDMz14pJw4VHBppUMC9+8
         zPmIOauyI+FXkxJmyKxZmRhgHVeWedBDnI1doJvB4siMnplmZSmXSsQS2u2asdb/+Kgc
         7YeMXFaeVTCdnLslqtBL+JSOnB95iTyWWreTfkT21i4SJnWVwFSlLeoFgBMncXzG/vzo
         Y8HSRBO5nGsQDy45Nps3TSDkhCKJ3u8fvIkV39bqzKpRh2BUStK4yVqOj11vYywS/P8m
         aWO6AB+USCBdV5sIpPNrIGAqScMywBaIwznMO87YmwHa1ZVqza2ZpwwFqN9XX7L8TiKf
         cmkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HfllP+EnzthN+Lznxv1xr1mVtWtLFkLC7Kp0IhEs3H0nCFILjtj8mIrDEkAeKpx/2s9/G3ySJj1D3fak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCaJl/Q+IUdlrQrPV+qTid/HN5zVMYkaztKBEfR4IB+oWYRODr
	1VHJgKW3qJNBVP0nQ6aTNNlOAFWQFOsBl4mI+ftdnIEMXfx+K/SnbY5C3lTVVpjVxzUNGxlo+kA
	W4NhgqNMgtpwnu5zbXA8T2dLx1zEv2GbrDFw2/2GX3ETUDtPpYu07TpZTu3AYroUeLynT3MEMYn
	Mpzl+QjJFWwCX/qnj7duvd3ZkYC9PUBy4tCrpccMkl
X-Gm-Gg: Acq92OEvt4Hw3QWRNyRLsJHA+UUWv8H233Vp28Y/FKxWPNfZs2ReTMGYYdpGRmBBkqm
	g4HOmwSvfhtHoQEU+c33oWyxF1irRG4lBhzZkD+yFRY5vego2HQ3FBcbqeQZM5wbBVmuUGSUmcg
	O7z2uAWqKIZFUk7h+OoHrhzlaheLPMoIi8kFliZlQXEcKxWUfLQDWYEMy9c/QrDaAMu1ohCSRe5
	IhxHQ==
X-Received: by 2002:a05:651c:410e:b0:38f:f6a2:a61d with SMTP id 38308e7fff4ca-39561f2f883mr11802491fa.4.1779113656353;
        Mon, 18 May 2026 07:14:16 -0700 (PDT)
X-Received: by 2002:a05:651c:410e:b0:38f:f6a2:a61d with SMTP id
 38308e7fff4ca-39561f2f883mr11802281fa.4.1779113655655; Mon, 18 May 2026
 07:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150205.212318-1-larisa.grigore@oss.nxp.com> <aaGkGwbk-sh0YJqj@jkangas-thinkpadp1gen3.rmtuswa.csb>
In-Reply-To: <aaGkGwbk-sh0YJqj@jkangas-thinkpadp1gen3.rmtuswa.csb>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Mon, 18 May 2026 16:14:02 +0200
X-Gm-Features: AVHnY4JRP0kGP-z42K5FI0qcb3gAysvgY6dzw7kUR8X3jOVZKVkXLna2nVCi7XY
Message-ID: <CALE0LRuahJy2EKa7YUukGRq1w9iws6kDvjZ7o33ahJUGc2JSsw@mail.gmail.com>
Subject: Re: [PATCH 00/13] Add DMA support for LINFlexD UART driver
To: Jared Kangas <jkangas@redhat.com>
Cc: Larisa Grigore <larisa.grigore@oss.nxp.com>, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com, 
	chester62515@gmail.com, cosmin.stoica@nxp.com, adrian.nitu@freescale.com, 
	stefan-gabriel.mirea@nxp.com, Mihaela.Martinas@freescale.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, s32@nxp.com, 
	imx@lists.linux.dev, clizzi@redhat.com, aruizrui@redhat.com, 
	echanude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -vY20KVEVrZphEKZ5fpNRWdNNd_pSI1PvtnSLtBJO5I_1779113656
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Any chance these series can be considered? They still apply on top of
the mainline kernel.

On Fri, Feb 27, 2026 at 3:03=E2=80=AFPM Jared Kangas <jkangas@redhat.com> w=
rote:
>
> Hi Larisa,
>
> On Mon, Feb 16, 2026 at 04:01:52PM +0100, Larisa Grigore wrote:
> > This patchset enhances the LINFlexD UART driver and its device tree bin=
dings to
> > support DMA transfers, configurable clock inputs, dynamic baudrate chan=
ges, and
> > termios features. It also includes a series of fixes and improvements t=
o ensure
> > reliable operation across various modes and configurations.
> >
> > The changes added can be summarized as follows:
> > 1. Fixes with respect to FIFO handling, locking, interrupt related regi=
sters and
> > INITM mode transition.
>
> Tested this series with the default devicetree configuration by booting
> the board to a login prompt about 200 times. Without the series applied,
> I was seeing a bug roughly every 30-50 boots where the kernel would
> would hang in linflex_console_putchar() waiting for DTFTFF. In my tests
> with the series applied, I didn't see any regressions and the bug no
> longer appeared. Thanks for the fix!
>
> Tested-by: Jared Kangas <jkangas@redhat.com> # S32G3, interrupt-driven
>

FWIW I also reproduced the issue Jared faced. Current state of the
LinFLEX serial driver in mainline seems a bit buggy and I can confirm
that these fix the problem.

Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

> > 2. Removal of the earlycon workaround, as proper FIFO handling and INIT=
M
> > transitions now ensure stable behavior.
> > 3. Support for configurable stop bits and dynamic baudrate changes base=
d on
> > clock inputs and termios settings.
> > 4. Optional DMA support for RX and TX paths, preventing character loss =
during
> > high-throughput operations like copy-paste. Cyclic DMA is used for RX t=
o avoid
> > gaps between transactions.
> >
> > Larisa Grigore (8):
> >   serial: linflexuart: Clean SLEEP bit in LINCR1 after suspend
> >   serial: linflexuart: Check FIFO full before writing
> >   serial: linflexuart: Correctly clear UARTSR in buffer mode
> >   serial: linflexuart: Update RXEN/TXEN outside INITM mode
> >   serial: linflexuart: Ensure FIFO is empty when entering INITM
> >   serial: linflexuart: Revert earlycon workaround
> >   serial: linflexuart: Add support for configurable stop bits
> >   serial: linflexuart: Add DMA support
> >
> > Radu Pirea (5):
> >   serial: linflexuart: Fix locking in set_termios
> >   dt-bindings: serial: fsl-linflexuart: add clock input properties
> >   dt-bindings: serial: fsl-linflexuart: add dma properties
> >   serial: linflexuart: Add support for changing baudrate
> >   serial: linflexuart: Avoid stopping DMA during receive operations
> >
> >  .../bindings/serial/fsl,s32-linflexuart.yaml  |  31 +
> >  drivers/tty/serial/fsl_linflexuart.c          | 972 +++++++++++++++---
> >  2 files changed, 846 insertions(+), 157 deletions(-)
> >
> > --
> > 2.47.0
> >
>

