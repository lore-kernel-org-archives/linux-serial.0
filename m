Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B44562A2
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851742; cv=pass; b=BSrUZzLIYmIqNjWDmdzEDoTDBZR2gTEEq915Vn48GS7quEG7AUItDnePMAz9mh2+/oUYAWX5oUBwgb5NbMXuNBbP/RyUgoI0BPhB6XvpVeNLFiLZOV9GTF6dRPFOMeJC5HzmA4F2Y1nXBwVWfu64jWIUvXlzCJ/fcGHm2LEv8cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851742; c=relaxed/simple;
	bh=HDUm59yYe2fE0m3pYKR/0WdYy2OIMCPhbSHIT3YZtmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJcq6nrsjdKA9BwonSHYfmJX5yaVbZs7v2ypgii2HHTgm0j7rQDevtULCg0uQkwQWAB2w8FrdkPDb2UM0G/LLxkbL1Mcko3MnkZtgvBH3C0LtQq4rbtocVVb6yyXWpnfyl5L0hsNt7+jkvrXmfxZwzqQgywORJ5K1yfL//wLPiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pffSzX4C; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pffSzX4C"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a097f5ab95so6193889a12.2
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 06:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851739; cv=none;
        d=google.com; s=arc-20260327;
        b=XTEyhoZhjrOC/o2KKhCJvd4xOcGcz/AwHEnWDbDFb44H7PV/yrD0ZvLlwDzGTmjWbs
         XmSEG4iH+UveyBaHLpQB0LhyZzGuq6Zzr74HlDmzkRDP/FQH9G1PDSTrTZytRYuIgYMI
         NX7gCiiEEtdyNjlPLOh25ZS332dgnMnh/5W7jTLxtx/cEDHrAOtHAOJIgZpHIZgQfc/G
         kOyvv66IQswOriocGcEw1GZ3KUwTD42SRMMFzQCIq2NdiXIL+76TX0KLN5dgUkqiErmh
         AA/WgWl3nVHj7k/OFZQkySmhYZgljjFgWXhyep7tKunhji43bB/a5ekVTjHeGVcC9Ezx
         yLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HDUm59yYe2fE0m3pYKR/0WdYy2OIMCPhbSHIT3YZtmc=;
        fh=GXow/pQNiyess3ewtJg42ODEf3x0IDew5eOeeFSYfQg=;
        b=e3zfzQfZmxHXz5+jTN0GQJ4Wyhvgil1LUB+jHaIHCkVb26vV4zlsJYypVJdWLLeFdF
         Y1N05CT8/A5lUft9Spe32rFGWshrvR3HsJhPLgqlrUxJiRUjQ8bPBHDzY0XcPBbmgNfX
         yBzac2DJqtTXj35eWvk+uZCzmA2tZlYW0SdlMhmusSgjIpuW1Ot+2E1wZ2ESDMw6Vl5C
         OJ3No1QWfwju+QK4FFsq0P2k7Qe2OlbAbzG5RrBmdgnZPQaWxI6AzczwlNUSvXRBMD3E
         Ow53oP8sOmocUIZP4LOACYBvUcvhFguubMUIzCWKAysymutOUP/hirCkxvQY4StRXHKj
         lV2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785851739; x=1786456539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HDUm59yYe2fE0m3pYKR/0WdYy2OIMCPhbSHIT3YZtmc=;
        b=pffSzX4CsLCjJtBzio4AZ3Sc/xFnuxXVjGeR+ljF4EdMFEmMoxg8uexFlyuT7R9QYh
         2qShPsSREunpK9tdaxopOpS0wTIQO4EAclCGYYDj6tHmqV7BZoEOUL17sewM2z6PceWA
         t9qUG6HHuwDxv3Wu8s8HzOYJF22D+NBvbDDe3viQ6pdGAwvuqOVhy2MoG5+NA26dnIku
         gve6cCbgyOpJe2nACfiEUvg/gai7gvxs/rmLD8DZTcqL2mlpeZI+097todcpEoNMywCr
         CgztBSXwAXdns+ZtOyvmwr+Iuz68AWNKW8q5EUJdJWaC+/p5pRaLyG4KovmMOcYeSIeO
         wCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851739; x=1786456539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDUm59yYe2fE0m3pYKR/0WdYy2OIMCPhbSHIT3YZtmc=;
        b=LUVSIEOshwVTzsb4HyFc8XR1i5Q/cMXmVo6pOcQWpS3pbFQREBmagy34OfGBOSWVbM
         /H0b7i0Wm88WblIMV78YNA0n6iRyI/2TV3W2xp9t/vVStWmP2HVawZ3e8YZcssaPluhl
         IKlsfZGyVRX8JIRvekqNMGwaKwuSXN439j9UGdaJk9Q7BPuIhU8mLTIZcBqfproY0j1j
         aYd86QMayn6NnHRhmg+IZ3/lTZ73hlHq4YyEANOz1ZJk4Km5Ky7BPce5SlQYYJ743WPc
         3fFa9gnOi2C/ygDX4qM/TvZ5cKwlc8tOXh/256D/qB2cEAbEhecW2qga8YkuYAPU3l2u
         wYjw==
X-Forwarded-Encrypted: i=1; AHgh+RpuQerxd0xys1LIGnd+5IluWqf3kRqC8t8c5+f9PshMFGnoZbTHKhSzAkNiSm7RZeSfPHARjwzcxTyzey0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzi0uEpOS7S2aP5CX1h5OLpJ+9NtjzT/saYxwWSpF7nzoRlVc
	BgX/fhSk3R+chJ5D0z7z/fXAJROOCz+vu3XiBTHqBovFMl00OV8u8YpDJ6IVSrCmMbjItzL0QLm
	xhrWASK1yEAeRWKVhxBJ4nZII9joNKg==
X-Gm-Gg: AR+sD13egZswzRm5onqyBP5EhfVXmp3VFCSQMdDZcrDLFm/wafzJ3yv/JVWyHdy/8eZ
	HBlSYU5IkTusYVaegOU/G2/nvdoCoMGqyJfsM+SN++f7J7r4qA9Eel5IENfl5veHep1T8oc6tFt
	rMu740qTt9w0LOGT18BIYPChFp7NxVtAWBdJrBGTIL4Dwx30IMNjppEW0nFFFE1v9KZFMQDYfP9
	qiWEE81iptyeXiQ3YHEISFxGpOovrIvCMNiTMRaea/jEPrZPxoBQEW2WxH/SPIIlOAKC1oVRiKe
	mOwMQyQsNzHWd5PgJmtIKn9/DXIVChKfObNFEwCg23Wgahtb/Mdp5d8m6Y7rbe2294X5rvnLr/2
	SuBd1kk9xxzK/L8VkzhLWF6Ik0afJuyHbTJ867NrTnq9bviEvRI11Jtd5PPA5Jc6ozw==
X-Received: by 2002:a17:907:ea8c:b0:c12:a469:c with SMTP id
 a640c23a62f3a-c1fe81672d1mr1321489066b.9.1785851738996; Tue, 04 Aug 2026
 06:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731161809.45066-1-mhun512@gmail.com> <908e828b-1fbc-4a44-8718-f0e7459b6ed1@kernel.org>
 <2026080347-diaper-uncloak-ced0@gregkh>
In-Reply-To: <2026080347-diaper-uncloak-ced0@gregkh>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Tue, 4 Aug 2026 22:55:25 +0900
X-Gm-Features: AUfX_mzg4abd6aDeysWOgkJNMFUfwJAoCyKRecMOH-c1Blp-df2LuW5ELpjcFCU
Message-ID: <CAGEsz8E7iZZOUXZz+Ga1f+F2yYXxALh4XQQAHQ_rn4O5effVWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tty: moxa: unwind tty driver if PCI registration fails
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri and Greg,

Thanks for the review. I agree that removing the whole MOXA driver is
the better direction, which supersedes this patch. Please drop/ignore
this patch.

Best regards,
Myeonghun

2026=EB=85=84 8=EC=9B=94 3=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 9:41, Gr=
eg Kroah-Hartman <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Mon, Aug 03, 2026 at 08:06:58AM +0200, Jiri Slaby wrote:
> > On 31. 07. 26, 18:18, Myeonghun Pak wrote:
> > > moxa_init() registers the tty driver before registering the PCI drive=
r.
> > > If pci_register_driver() fails, module initialization returns without
> > > unregistering the tty driver or dropping its reference. moxa_exit() i=
s
> > > not called after a failed module initialization.
> > >
> > > Unregister the tty driver and drop its reference before returning the
> > > PCI registration error.
> > I think, we should remove the whole driver instead:
> > https://lore.kernel.org/all/2da84e36-7ac6-407d-8e08-edca82f4cbce@kernel=
.org/
>
> I agree, I'll submit a patch to just drop it.
>
> thanks,
>
> greg k-h
