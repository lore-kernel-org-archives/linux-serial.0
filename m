Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273621;
	b=U0ECe4szBzeomiGkwsL3h6YYoMVUF4g7pocXyexjRuF/g7edqmcK3JbxR3IfMDuyBana
	 TYuYE4sJVH8Lz8P9NoS55gulNC7xOybK8sOy0waXsh42ZO0CB/spk7ugCMfy1CBVU2qbv
	 JKzKn0w4XcpYljGPQzOJ/uiTmq0T9j6qMDloaQ5pc6ku4xESVbAUWnPzwCKUF2vvUM31G
	 adALkSrhWa3TeE7Pz+LT8eEMHF2e+MYBiAYcuFWn8DjjslfJQl36g3nOkvh72urnfOqdw
	 viPULNdE70GKXbC0fHPyDXba+T4MLcmCWQvdn6IYzwHiRshP7RsIXlkKYQzml92Ohww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	b=gF5HT2XG/KPc8S1ocj52uOhuhYYcOwPUN/9UyQvtgzq8mrYI7sS9mjJY3K7uT5Ymei6m
	 4n6mA4JizgmM5OR0qrm6+mz7ttaI++LhmXOsWIwL8hibWNntPhQnq9B5nBn3f8FuXjdpL
	 c/Csm31UgmNqzmCSPiXsIPP441KH5Qrwu8+CIT+BH63fTbbLjiZi+mLQsNLOXe8j5U2Td
	 oy89OF8pt2dBKiPkhzET2l7d3pBJKM8iuUQjXfTA8penOqwrFc6HPIXi24P1GlbL992XE
	 X07/1qa6wtSrAliqKOH8xNfefhMePr53RLCj5BQ6vE/hNlFRZ718X3ZiB4ZGlVVMA2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=aJlZSBlx;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3C606A326
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 01:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBF3C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=aJlZSBlx
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c450ab1483cso245734166b.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 17:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273619; x=1794878419; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=aJlZSBlx2RVvErg9ZNjUdoT00M3HIUIvcK16eE2Q/vu9u02kz1l5PZdGA/t5FGZopi
         bAdu0vipHruQaTneyhQXeTQpQgN0zR6URyAKZRfpSXmksMEbQ5u/2KLBRQtY/ANFJE+1
         NY1T2LX5BDtSc6HzjT0Zc+TwZDx1y1KrK4hTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273619; x=1794878419;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=SwyQAE7miC5rYPGTfDxgibPadLULOtJvDasmPuMhYYch/iSPOXCI0FqXJG8kwgcdBa
         Cj94taZH55dYCuRZN8ayAgqRS+eISNit/BKdsE9oTMLuWamOVlyxQ+cwFWJla71iCebg
         AxerKgIOLu5E75WhEmkuZXD+004VKFrlUz8lOhlXbi0fosO5Dw/uhY/rMB1cvcTWri81
         39MYJfoPot7/chG6Ti/2Ts+1gcxge3b+V7YmStFwN/BHW5Ng6Eln6tzzdFtVWy75CWU0
         511mJlJL1dIaqCcHIOzMnS9DKp7pCnjUF0CJwLv23PVJn2L74WGUGpI4BQRfMTeCytYB
         ZgDA==
X-Forwarded-Encrypted: i=1; AL+hErHLqCBoMyF9MElj1QHy8+sm59va6FwJRdYJf4cJWkbUeJxYgaCG3n+9ojNafNObRw6P72yuxMAuVL1eHXI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9I8MmZ2DkymrGHQh/zdo/T1QJLmjlkrQ75XjeUUz8ka3eNZ9MU
	5PSDCbWeS1ZYFAIgeeJKLX3cpA+mwGAfxhxAkyJvzYtadFPmuobxm2XhX+CgtMUoMopA+rv33Ga
	kNVSFswGL2Q==
X-Gm-Gg: AYBFou3HenRKUWBWdnoe1AvjtWJ5qiMScMK2Ycc+x5DHoSER1p8AHa3GnTOoAIUz9VY
	G+7+EJv6uTgPlp9R1pYRvf5a5E0kgAs/OlhHR1AQl+DC7BU19WCzT/dFFwCwy0komNwrSZ3UaqI
	edILAlhbZYOH5B8G3TPi13xi7ixXCnQV1L9JSy1z8Uvetyo4BBk4OCNyVxb6Z2nGXXoIdmLSaNE
	zFPxi/Et32WNnvamZCntf06g6UoMUvZXyy1h0NYgVrqR6QSTobyj5QwyKmRHzILCtnHULyENnGj
	0H6UGzJUFLmQpn9X8Gau2F2+MlCJfo5qs3/dVuRw93A3f2s4qvrSJE8HNOjdsvEbremYH687j/5
	+uZ9t9kAb+v3WvwN4GvZgC7sqWw6UB/aKNNNpVDR/LBk4dVfIHAqUF6yl8yUIM2X7wrMoWBHztc
	B2OjnpeHiT8o1VrZwIPgG5kD63kGrErt0r7FF/R88rA7H7HiJONwFkp+okKER6pC4b7K686Gr2g
	DPnzkExHDgKPZQuXnB//qzrCdR9MJH5MyP/mLCjCnSkHbbl9SOOXfhr5BA4zO+yOTNCcBRiF9aU
	CLyAnNu1yDnB3A+a48ULwLgmQtGWCqXBleuGHWuRoZ2nofTkdfZfpVbLLUNcXa7XzRX3sobDWie
	LcnITUu+kShyNLqfS7SJ2vw4=
X-Received: by 2002:a17:907:1788:b0:c31:e958:408c with SMTP id a640c23a62f3a-c50496d0575mr76607066b.38.1794273619347;
        Mon, 09 Nov 2026 17:20:19 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a5cc532sm41780166b.47.2026.11.09.17.20.19
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:20:19 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c450ab1483cso245733466b.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 17:20:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGvtA4O0Y9RqvE9sc3aXpwUX5fZ1b7iYnBTrFfPeYmFUcm+fxz57mRYzcMOrfTlKuI69kSIrl5tpRZRIic=@vger.kernel.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus
