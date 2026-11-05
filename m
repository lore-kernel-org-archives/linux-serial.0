Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872951;
	b=PE0GgDOfadrjBtEv9aLIDOhbM/2PnfyBFaLJouGN4Vm/b8e60pGMO080yDjAZHgV+3wG
	 CBfbV4QGbN8JuysVv1p2uXCnRYndYT/HR8oW6xZPMV3QoQPgauM/5A1zZt0ohvm/sD2DQ
	 nj4uyRSDHIyC0X/lXyRhYiWVsUR2c6Ej8XCAOutlopPzDE9qHLYaF2ei5eS/G86pKVyNs
	 NC22UmznJfKfNG0PDjkPu6fyYPgeQ0K7otws9rnB5qoFpwvD/Z5BSnkhZ+eo45tsH0vdY
	 D4sLgwAUTcDlXGxqG4ELbPE9yFFM8XtS5gMBid55AIFnbdR1nDOjhIr/AW93wsvsP7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872951;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
	b=mjufvZ7WrMHjuHaDzXPiHCu0e+7uXFe8BJ7H3zA6H5bSDr8XoheCKo4L41cfxNGfvD/u
	 j6cxf3HZrhLwKQkxrEONENwfWomqC68wNwkbF3nl/mNh7BPWLRqhR71y0tOllkrsa9tWK
	 8SHm2BzENhS92jOSS+Uqjj4BM++2vnlg4w8X+CPJwZO3SaAgtY10/bKLfcEMovbDfQk1P
	 XxLFP+1yzuNQU9cIld91kOtzMmQU7qLTzxtRSDfitsa54N+7FZQLGO/WV63r0O7ENz+l5
	 tzz0wN83eDvNlRUSbRhjsW00yqXqmha14zVyOh6eyogVosmc6novfyF2D+Y6cTq3McA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA365606A31B
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 10:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA365606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533778ab0bdso18549861cf.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 02:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872950; x=1794477750;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=uocYjVrxTIahJRVnHEjyXNgk+Ndunp38CnOL4KWFzUSL97a8ZnG4dG8svHDYCgGhE0
         zriH+SXVCrxJ8WFg7wUHDS6HbwwHs8aiEhGRblBkUGUEvlfrklqk6EWTlcr0Fv6xur9x
         MlXquDtRAt+4tfeRXjkneSLmxVcMP7VtziLR4K5fqUUgzWHpgVjIO8bjCCYRtD9qJZ9q
         ZdWygYTGEGSvbo6V9tfMRYW4NHWyaxc3XUg6DYP5kO1IifuKJcp+koqfGz9r1RbvKeE0
         YqHgoNsYMRszDNINa0GprV9Zss84hr4BtQKmQt1hC6XPRXDQS+ujYiM8wU11tuNgXJO9
         2g4g==
X-Forwarded-Encrypted: i=1; AKwUvBzHWUn1H6iioBO9BR/80vrDTzeiYdyGP9wN2vOdDh3mEqr6rpdef/dJbAdGKNFpn0D1i8m6w6ToVTVL3Kg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HZN8ElyIOTEsaey1lkibGp7LYJ7r6iT8F0+ynaEK0TOwP2SAb
	DqyLeGy6NkAbiAGQCUqPnkH63MV+ErJ7jZQ491TvikvvWaPnUL/rB4Xu4ts2rsfalEc=
X-Gm-Gg: AYBFou3kW8RSXXoPK7rmrIhN3ctLaeTuHIfGr5J1MCLv3j1+1nxIOCogRab3d6VSoGp
	njzsSdSMZK/3yqFzadKdarkFPn/lawzKcR+yLWtfN22l9zQ4ziB7THCJOouCC4HzuBHM6vJKMyC
	+8i2nd+OCorfOERJbH+E77rAk7dDs62ebq0/ObZWjFFlhmGGJqBUqXyqVd3RY9Hhi8zXKeNxQga
	P36HVKvbc8AqWKK1LHvbe9NC5SSsjFyM5rnPhwbZTKoAuJMVZdKsklFBuuT3jdgDXXe8gXK+BUE
	RWRQi0u2BKa/6r7xcdHewq+Q5hR5iihXNNzyQ+qz78Wdz6yvnXDJjU2dqNW2CbFuJFAdAvbvEMS
	h4TKsyKsFb1I+yU/VZiUF7XAPKXlrSrJE1ME3MAVeZn5dht2vLosQMkXGGiujYmzRw02LdO9p2o
	B55w8XCEi0iUJF73yIO14oXWJxRFk3mCSh8vw4mjlmW/gOnUhQwfaXQw1v+oGr7AKddUaJCT7J4
	HHxRovX4i9a+XYvXRiypfxT86C6w7ATAnDFz3KnC2prXG6CyuLXLT2/M8AAkSw1+pE3fmeh3CdL
	YuMxQ8bxS8twxTRz5NZbfkiYCuPwMhfWEIcI7aPAmcLTT/2sxD48t20PgcbdcBE3IQ==
X-Received: by 2002:ac8:6549:0:b0:536:990d:79a0 with SMTP id d75a77b69052e-542b7523bc1mr311425851cf.49.1793872949884;
        Thu, 05 Nov 2026 02:02:29 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b0d0758e7sm47485781cf.3.2026.11.05.02.02.28
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:02:29 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c7a0c1617so23383646d6.0
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 02:02:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwjl85j8babmU14znQ1RIJ28PCdcZPDczAs/q3uvBBCJykwTcxCXVhOLrmUO24UkKa+iIEo2QsJO9DfZuU=@vger.kernel.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
