Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793139965;
	b=46/rOsMqlspafQHKez92t85AOlDjE8e+1+Jv0wyH6YjyZOaru+Wt97Zt2H1Ov9Ghr4nx
	 WJ7B8H1AII7r2ewzjIALa9stLzJBwa0RaqOJSo950CH0nAafnwb98PMMGoVkXmIHC8qTE
	 714otNCCJOybxjT1MWeCWfr71tF9DTkV91REoCgv6Ti6ViV/GfpfvXGqbIofb9PhN4Rw3
	 KC3sjptq+ZvZ0eur7EOKEkTbwDXxvt9IcBHXrjVXCjVSWKNDZ8CFC+JriQQczV2bSLiiU
	 OPcKGs/bO3a9J3CjjyiqZryHtHRk9XINZZm/qaDiFM7zzYaos//afGrzMAg+Xi2ZNhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=foMtuJXLdxu7UI1j+IPfbjutuzhkAxYfoH1ISosJmU8=;
	b=iFaUoPoI/su8fnKVuwrXa/JwRQZmF1ZIwj+o8bldkPLb5C4W+UnGGBBplMn5RwzeOnW+
	 WedEaEbkMsSjhi4UYgODz2Ijczao12stYFNJ9K/yUHuPMLQGLro5gWu5CW72BjAW0F7me
	 ewjbhXf5A+9VpSrKZvH1gHvka302MgwZMQ4vMNL/1sHLActcdCtZyacWIcL9Lgtav2E7d
	 lItnfON5bvNJ3H5EOmS3Dw676SEEYH15JTs4dd1qsCDvMDQM8sazwU+GGEJyDCxxIYGh4
	 3HHQZMSwebBx6fwsImbxPQZDoI4PZxrWtIuwgIY1crbmoPp2lae1cCGmGbfrsJja1BA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f6G9JLIn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3935D606A31E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 22:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3935D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f6G9JLIn
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso145781e0c.3
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:26:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793139959; cv=none;
        d=google.com; s=arc-20260327;
        b=Vr9bl/wqdWX6DuYlPOW5N1Z4STLufeVBSNvuBML7XL2T8CC4lUxSD79QNmivEZfwbv
         vjq4Zxv/g8Dtb1eAccwDwx+4XQOMEx7JZFxzvOZ6tJyppiTt1Gzf6yZnzLKKRkEutBoF
         HiAdS/N53iJtYj6qDs/xFk7mDyw09TUvACLRff6gsvXw82OM9/MIpF8g4EXPPqfgD4Md
         C+P5NUpUBuHvMemOm6lAvc3pCvItfg7qnfj5R2je9ti4kV35Rml6d8WOFNYcowm6930r
         OtLaZ9BLju4kpAIJEOfeoCJ6brIX1G5FolXMMq6cDKWKCfTdWsvYJc2hUyZ/m2MbE0s9
         ECig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=foMtuJXLdxu7UI1j+IPfbjutuzhkAxYfoH1ISosJmU8=;
        fh=n/s0ZdqnHm6Uo5B0/BWk57jjqN7QreHp6wzw2IaRKcY=;
        b=KPFFI5GoIcyYAF+U61iRlNh/Lj0ZB/bEHXh+vCb5kDSbmj1ASK5o1Kfk8Rt1pvn+7O
         7oUF2PElR3wBRnQ5+6xWsDT9oxpWC4fDgPQ5f8ntgXign58dy67eQtqnFOh2Lj0oIbFV
         2hqM2nn3qXXZaM2YEdCB9nOjdeP4ME62N21Kgv8z1mfhi+avJPJnPm0e/4lvi+zDCHt7
         1FPVN9wP2riOX/Ad0anvksz4JD0zs4lI57Pvt/aZ8WD9GkV+8PNqgpzJI7RoA+Q2vgMq
         MbhyaurRSoO5bMI2aS3XkDQDnoXB/pY4bcL8tfJijH/hmERJTt/ZETULEooukg2ZjwQ2
         /3xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793139959; x=1793744759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=foMtuJXLdxu7UI1j+IPfbjutuzhkAxYfoH1ISosJmU8=;
        b=f6G9JLInPmaSge8xffSf6HZoWcpO8d6qi4TNYFtaxBEN61UfaMNheiokRQ8WIyRVGm
         fqj3gV5AbF8FR49SFOt+++JKsFDpRER2OP73qJqDoL5QOafpFdEtnISaF2buSi2WfuqI
         IrOZClVF7r6IUg2ylW9lpqEx3+AfRt7srQQ7bklsW9RThWKEI4kzVLabZlQxuYyjtXux
         DvOuLTFsRpOwnGufHeV4ugPhxQ1Yb1dxB7v9GbaYaQioisIMmy4Y2pjYydSqwdqXWtLP
         0kREAUAA9ZU4l12AeDUeqefL5uOU0cDxJEpGGZhQIjvQ6Yamtsw/7Q0zoTQENOuPPbu8
         8CHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139959; x=1793744759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=foMtuJXLdxu7UI1j+IPfbjutuzhkAxYfoH1ISosJmU8=;
        b=iSyH3zE8LMWjYGB1kbprLh4oLCEGoa+7W247Sh3A1Yms9EZ874ZHyh/OQMqW1vRchH
         2hFoKpy5thZOe5rQF7kbL2bVN5HLZYG3t+adNGIWFpMdYyV9OfnKnWU9khDzxPR3YPQw
         ZDm+zizkd+dCRgG2SBZgt3bMB4E1PtKMav3numKvb/8szPb1bIZ/nTe9hiOqF0c9Piuh
         4lK0rfx7BYrUJ7p7TUKvbDTwa6hrd7Z64sEdlDNMKDPaBd2+KI23EVs4fjrk1dwAbxlL
         37v/+cWufUTXYVIgZOQmUnBwOVD0SFI1xkff0G2GmgqJEnZnaqwB9rsldsyPd7VmXUxJ
         xmUA==
X-Forwarded-Encrypted: i=1; AKwUvBy80cqoUQlvy8v9Zrj8IOFPoRm4xrzPkFARO7rNETdnQQpp6o9w4GToGVubmu7iWlOsqcpqk+HcIZSH1m4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAavemaELZGoj3Wb5msm8/h5ngmmEBhlDQvAn5ZCGEF3tO7d9f
	jA5ivy/8Gw0ENRsY9VDrBlI7qglQXaMzR4ic5ZUXU4q426LuMVcCPJrKIt3Axe/ydsTAJHbcdfR
	H0yoUe+EONfbw8/sCnmtcdw2Ps910pSY=
X-Gm-Gg: AYBFou0kLwuKyJqEn3AfyKy9R+igZTpcl6vmEi6xSslUwaJLKfipHVjxNNLRG+zzkCZ
	ITeyb8ZDHDxzIpr9OWLBRZvwlnvNk+3diXk3fa3Fu2akBUYbNvFJiN5GI+rAmhwRR92MEd9jUpF
	2+fBkS8kft+cmVeNrskUpHgCgl2pHE9h/snRHtF2VzRlJen4J5qIAZYv2Zu78AH/fCthT7zmB8A
	IEQNoUcuwldX71aTuZnYinfvDcDcIseUpvoKyIIVfBIt06kgOsHK1K6UNXOCdhX8tvzenAVugSG
	z2fblHYWV1JpVwg6FM0B4sT/Ll3eQMB95LQRDGoOAUq/YKiLJT3GtW04cg07cDI2gyyJquwLYrv
	ZPtFV5hZ3LoCImpsIQ4vKJqk+qNNLlbuLGxFUF7NfFjSxswj43SDd+wDOTA8CxM8oGQQJAg+6q4
	Z0hgQUH2xtGyjLin21rLTZ5910CgmOxtFjMq+6PTXBea+sCrCBbu5eC5p7DACky6BIVFaza67Jr
	glK9+nYgfyQliqoqaV0tS35/lRP8g==
X-Received: by 2002:a05:6122:6602:b0:5ea:c727:11fa with SMTP id
 71dfb90a1353d-5ec4c932ademr347091e0c.0.1793139959098; Tue, 27 Oct 2026
 15:25:59 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-submit-h616-uart-fifo-v1-v3-0-286fc1b8c3c1@gmail.com>
 <20261024-submit-h616-uart-fifo-v1-v3-2-286fc1b8c3c1@gmail.com>
 <20261027-nifty-reliable-octopus-6cbac5@quoll> <CADvTj4qrBYSyT39=xK3_oGgHdFoSH=oyDvTtLCSzW=F9KAgi3Q@mail.gmail.com>
 <3287a7db-fbab-4b23-9ee0-d40c52fe855a@kernel.org> <CAGb2v64Qr-XCRdgi+RNS2XkKUn=F8zW+8WUKaauM2PjzL2XgWg@mail.gmail.com>
 <18f1e637-48de-4962-8a13-65f6597eb2dc@kernel.org>
In-Reply-To: <18f1e637-48de-4962-8a13-65f6597eb2dc@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 Oct 2026 16:25:48 -0600
X-Gm-Features: AclHuK8HgBo8KQle8selMQ5AGJ_mUpjdczBdxOIx6OfVD5T9FzVHNBxWX4VKWiM
Message-ID: <CADvTj4qqwC=HjPmsdHoZdNNWY8GN8TqXnQG9PqKD-GpRZo11Kg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: wens@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:05=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 27/10/2026 11:02, Chen-Yu Tsai wrote:
> >>>>> +  - if:
> >>>>> +      properties:
> >>>>> +        compatible:
> >>>>> +          contains:
> >>>>> +            const: allwinner,sun50i-h616-uart
> >>>>> +    then:
> >>>>> +      properties:
> >>>>> +        fifo-size:
> >>>>> +          const: 256
> >>>>> +      required:
> >>>>> +        - fifo-size
> >>>>
> >>>> Why do you require fifo-size if is const? It is implied by the
> >>>> compatible.
> >>>
> >>> H616 has a fixed depth, but other sunxi integrations have different
> >>> depths between UART instances. For example, D1 has 64-byte FIFOs on
> >>> UART0 and 256-byte FIFOs on UART1=E2=80=935.
> >>>
> >>> Should I keep this explicit for consistency for all sunxi uarts?
> >>
> >> I am confused, there are no other instances here.
> >
> > I think the point is that it is going to be needed in the future when
> > we add the compatibles for the SoCs that do have UARTs with different
> > FIFO sizes.
>
> Then we add it. We don't create code which is not used.

On further investigation it appears the sunxi boards with UARTS with
different FIFO sizes might all have a register for reading the FIFO size
at runtime via FCC capacity bits so I guess we might not even need
a fifo-size device tree property for any sunxi boards if that is the case,
not entirely sure if all mixed FIFO size boards support this however but
I have yet to come across one that doesn't.

>
> Best regards,
> Krzysztof
