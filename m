Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8973B27FE
	for <linux-serial@vger.kernel.org>; Tue,  7 Jul 2026 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454252; cv=pass; b=ah9BasT0ASruOCUhX+zOWBTuCWKBMID7/xrPRS++pc+fm28lzTO2jdmuwCRT17+GBpfg53uImcO6xsgbQRCvV/y3Qd0pQs89SKufb0kXekxo9+kri9AggG4I0Ucqv03Sj72r8E0UHtFVIPSMEZNDtRea/p1WQ6QrQkAKhqJOXcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454252; c=relaxed/simple;
	bh=+4LGUwruSca6T/12Q76TuwR8e5qnyL223i6zRC1/Kh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwatzfVLOlZmdjyOsg9DYG0tFFJzdsKOWpOJJeiaSs00N/xMQIRAgrzycEi17zp7t3XYdxZnD45Dkz854tbhfERJCcOHr0wOZUa8OthRC6MrlCrOFJT8OSn49DFrlA/m11kcqzNWDkfonQPtNRtmTIztF1zkMbn07bfGx+d/EIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chiejUGP; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chiejUGP"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so63001a12.2
        for <linux-serial@vger.kernel.org>; Tue, 07 Jul 2026 12:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783454249; cv=none;
        d=google.com; s=arc-20260327;
        b=jGhKrDZjp3EvPzZJumL2j9054PKID21pHkxdvWOHPJ+mbqANHM7Vv+p/AhbdVx/rt1
         SjDVJqOMcNjIKgEAnEFniBWAoeIlPZaPQEfSjcmXaCimPlHHOVNIBRRYdkgmZ80ggLWh
         w0nX1PyeEuxrjfzYhgJ2F9gXqPWU3D6EVlMw7x5uGbnA5/0XQnxHatyH3tUN+8bHZcPL
         iH+ADX4+Lk3DNBexU0UVxjOrsu5oQbwkGKCTZ96i8KuARbEdIbk0BoxUgK1cUJWGakHX
         3GsfTgh+v7bqHVSZe/xT5vtwk2UwdhIEv03LmFG8HqfGQOW0Pw1z3mTte9OuDilMbDKQ
         ID8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N6fd1+Z+F0tbkYg37tULYg3QGW6SNWpeWQyaq5mTNYc=;
        fh=LW6qye9T4Cv4Df/D2Sy2lPRxVDBxDp8S1ZQcolgXakY=;
        b=CjgnlD6SRhc+R7qpU5/xZ1tlevexgNOIxGwt1NNQK+7Qubh90yDymspHQbQ2Mk0Hn9
         8sHSlEPEm6whb5zVmlYAw/4EXXoTgTzEp3B6fh3XYUX8yojGVlMiB9SHMKXawieNuwQ3
         ilcdIzGxybTCto9ZdwrxRyWbE/YI8nv7I9lYuJgAIrr2eTLpqKCCZC1j7mqNX1apfwp8
         Df2/+/RvNAGLhIuM8LCNAusW2yVLd9+3DjR5CbF9dkgAD45I6P3q2FUhXcAx3g1CBSvM
         UfGpJu+eLfgp2GLSbG65qOFP6k8jPc5PQBQ9ajTNTNoPMZBXWJ2wYzaKauDaSF8LS+yy
         KnNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783454249; x=1784059049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N6fd1+Z+F0tbkYg37tULYg3QGW6SNWpeWQyaq5mTNYc=;
        b=chiejUGP5tCJvdn9FLQvMZvudScWCx4a/UC/Bv0vhyiMAj1IjObNx5D99sFJWuw5Us
         BflcF8CwifRPihQjXIGMTQ9Z/9lzR04aDywnl6bRqlAv91hr+NPC71VkI2thA1MGShF4
         CymIyG59LsDcuh6FjKb5syKZOty721gnrCiGPqGXcjafMc8qA4JJnN8+6Dczi98wTm6A
         XDM3WwxJnARrHGBCkClfojXwpA06R49243aVRLcJz0UVMHkvRFVvRaQzjA5izIYw5lJx
         nOCAT1YhgV8ADyqIHqisb7mFMOTl7+fzg6jSGnMdOqKearFq1Cwa7fj+ypPdM+/n0+qY
         epLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783454249; x=1784059049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6fd1+Z+F0tbkYg37tULYg3QGW6SNWpeWQyaq5mTNYc=;
        b=cA1MntwtWbyPS891qPuPsjwOpBzqIkBpm6KJkp3eGVpSEcSFjnIXMMRDue+GalY03V
         B2TR6+iYXQ4CK19Scbt+s1AEo226CIspZ4gaYbGLarlRcMTrif+lEfWdF8QU5rw5XA2y
         ox2SGQfxm9PlRfm29g3VKzxbJruIcXczNgy6KHIr4dTPTzmpwOBP3Tjft7qtdi6zcNJd
         swQfePZs3ZFwAnBOkvwPdoakCahcapj3gbfFi0qMJLZjhnT8u5KOJEoNLMBjEqPnqFiv
         X/hBX1F61P/OBw0BvDTYz48yAUTSd5ngwbvmHQQwCG93GjT5vpjinkirxx/vfT++rZTf
         d2IA==
X-Gm-Message-State: AOJu0YzU7goyexmDErPYk8uTTBIdlSnd51142s+HQlC06bc/UxUq5GFo
	KVW4OM2gp0s+Do5+T3faDZeQD+SymVdS2V5zcc+X4d1KEeufOcwhZCSInqcG8krGFD1k8XM5bWq
	O0sHtekJhXbxUEA1aFXtWCpfv1k6FWRo=
X-Gm-Gg: AfdE7cmo1VrJER4R7RIojJYnpUCJkLRftsmrgR8nrQhaaaekPkD1LTsxEkCa5j9at0a
	jHgIwHsMrhfgNgzRE+JCHyhg8I23T41QscaS5sWu1FdCiIH9Qaj887omaN3ThoYaLH+ouCidMDj
	dtaB5W9cyZalVYheJ+y9DoFVkRb5B6GXiJoBv6W3743VBEOR6VamBKdxwW9t7mUFw7cLWa0CCRK
	/94+llqpTjzN+N3MyKNbsOqWsCE5bRN7z+j6nz3zgOrbVpD3+/Lq41VLrqHiK+KFDGarvFzkJS0
	zxkROugbZFwkQ+vuEOEuPkC0d7//wcFjbfAaNLOUUbMEvkmsH6tuhGRfEtXnpa86KN38c9/kc/e
	PFrEq4aV0uIpr/i0/vno5BVrD8DE=
X-Received: by 2002:a50:c908:0:b0:695:dcb2:7438 with SMTP id
 4fb4d7f45d1cf-69a85bb6f42mr2799076a12.28.1783454248743; Tue, 07 Jul 2026
 12:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528201250.135691-1-rosenp@gmail.com> <2026070710-bronzing-handwork-33fe@gregkh>
In-Reply-To: <2026070710-bronzing-handwork-33fe@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 7 Jul 2026 12:57:15 -0700
X-Gm-Features: AVVi8CeaIqRF6fJFEAyvv0HZBSS_tjuP3_hlEWu5a78DgN_764QeXBU9rnOAp_I
Message-ID: <CAKxU2N-3AFcyPPuoqQXoNvAO4Ht1Lunhb5q=qdBXYnYLnaH1cA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_pci: fix -Winitializer-overrides for
 Brainboxes UC-260/271/701/756 entries
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 8:21=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, May 28, 2026 at 01:12:50PM -0700, Rosen Penev wrote:
> > PCI_VDEVICE() expands to set .class=3D0 and .class_mask=3D0, but the Br=
ainboxes
> >  UC-260/271/701/756 entries immediately override those fields. This cau=
ses
> >  a build error with clang -Werror,-Winitializer-overrides.
> >
> > Fix by expanding PCI_VDEVICE() manually, omitting the trailing
> >  .class/.class_mask zeroes so each field is set exactly once.
> >
> > Found with W=3D1
> >
> > Assisted-by: Opencode:Big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/tty/serial/8250/8250_pci.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/82=
50/8250_pci.c
> > index 3e5bc9e8d269..0513f4b3c093 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -5394,12 +5394,14 @@ static const struct pci_device_id serial_pci_tb=
l[] =3D {
> >        * Brainboxes UC-260/271/701/756
> >        */
> >       {
> > -             PCI_VDEVICE(INTASHIELD, 0x0D21),
> > +             .vendor =3D PCI_VENDOR_ID_INTASHIELD, .device =3D 0x0D21,
> > +             .subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID,
> >               .class =3D PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
> >               .class_mask =3D 0xffff00,
> >               .driver_data =3D pbn_b2_4_115200,
> >       }, {
> > -             PCI_VDEVICE(INTASHIELD, 0x0E34),
> > +             .vendor =3D PCI_VENDOR_ID_INTASHIELD, .device =3D 0x0E34,
> > +             .subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID,
> >               .class =3D PCI_CLASS_COMMUNICATION_MULTISERIAL << 8,
> >               .class_mask =3D 0xffff00,
> >               .driver_data =3D pbn_b2_4_115200,
> > --
> > 2.54.0
> >
>
> Does not apply to the current tree :(
This appears to have been fixed in 426e83cab1f5d53069ac7030cb03e2d7c6367ef1
