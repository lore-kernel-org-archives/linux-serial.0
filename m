Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872943;
	b=l5epBMvk28VPAiLhu119yC81sao3imgtjvsQl1iHeErD19i7nqWuz3b/mKeUcvMESsiX
	 YYqCFysHc9eNx11Rwi1bb+zRndzvLc+Cg/gPSkpj+deW9rwYcpBGpqLqNecKtBMXYGPgc
	 /ahUHpm1QGc7ORXfvAlDRjfx+ceniuqRQaGTz8yNEavbdBoGIUqxDjmCajR9OLCbYT5zn
	 frupcaoNQN4o1G5CUEC1A8SbtgbYPPC2XgqhHuRdnYyAJy7zzr4jG7YDZoOU2bN/T4y0L
	 d49SBBtB0SgYCODQzEMmD4HDkHl5crRIgjcOWVHST+1rHiUL3M1GaeszzlnBMao21SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872943;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
	b=WC9Tj1AKcFVapzKEycS+40WLPNp4YesV+G5ihwqCJ4X3GitGYANZR6fWu6gn724KvDXh
	 O9nzX2PuVQyYrDO3ONpQ0Txg9NRrwB07KWXUEfVcpf99wsq7DuUUNkMcTAXtS0BhORmGo
	 YVCJZimUnqQ+/baqXc772pW+t2FAC7oJJwAf+A41/bl410sxp8OUzD/SraEgoyxA/J7cS
	 cIl7oSu1M5F0y0TkOOlPF0+ZGRn7E2Li6bAhhAqJr0z7Qx1s2pwPZFKZ5VF6eX7rBMzEE
	 vvfXaPtbokhhs1nuu7UOirHzXoOS23+vEnEgA8BIzfFX7R+dsrQxLYetA/i6iXXLabg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2F606A31B
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 10:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AF2F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53644b28706so24651141cf.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 02:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872942; x=1794477742;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
        b=vx9rSvYzV6VZtyTzMnDurcKWCLVxQakdg9W9QiJoONjj9fiGqBOVONjwaLgDIt+5aP
         FapYhLEjoEsySL2UQKwVijlzrE/i6Ae/2CwBIq2wSJANjh7u9hxJxdvKQix9t1i7zqnj
         BVXcbj7wp3h+gNvKxR0dW61bBGu9rwdbWwG0d6obAyp4K8cWp43xjytjgsQnyl2DB6AE
         1Kt0mlju2gBfd3qpXe1cpXE3K7/O07ADj6MNCLuSCQfneX99jd1tIZU0kiengblisUOw
         PFr/+6qq2qVUvFqf0lMMbwO959ze5XamJq6e7cBBOTajQOdTVJuQpByiZZt/cQwyrby0
         h0Og==
X-Forwarded-Encrypted: i=1; AKwUvBwYr0alt7KC5861u7vV6Af2joJnOSblgMjoTiPEEiUUy2om7CtReYq1MFTNbSFXOOet/zpHBkNAc6W0J2s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kMAmR0Btl1LVMFYXcEUl64GqWs/24/thGLxXISeMM5YO2/WNC
	SBhx8FIND845XixnC8gf6xI8VsJoyZznjHhDy+czilAOA4VB/QxdB7M2ALVEBL5QYSw=
X-Gm-Gg: AYBFou36xGAPdR8kcu7vdUSBkza9RBbwSzAgMKV9X5CfMPhXwxz29FmP/vH0rBgeE8w
	lZkv9px5cBr1lsRSv7lIAxVXDTW4299cKfgagEEQarE4nRMo1KRm5vdkr2lV8gFMiy5cxh+vgKG
	65uenBoqu78ECjTr0vvxDXiOsIPqsXGtTDImKFvDc3K0VCR48xDmCtl8y5eG9RQpTu1WJhMR6qr
	wVCzEEzqenN1Bo2bVPMuvUY9+JyNbSdqtRD+fxDpTvTva2ug+wpuCSQqmAj/rDwjE+2gfCAZRL+
	v0gB1UEOIk1Nso7LlhT5sJX/IoerN+jFHcfJZRcbT8oIcPuiXHh/ayjUuIptc5LWlkLd66GglwY
	VnLWOyQxtz1kdrr3AxrfmrawkaZwwxE65TL+wtYjobacnZuRQ8Q8TEibVrXZt5o/3vfSVc8BLbC
	ANIsOn1hR3NguJlXdRIONGRT1cd2lIAhk05v8yjtm3LFHynBw5gfRtLcqD0XU+3EkXY7pO1+a88
	fcG49kL046QHw/3h9wRrrFecd4wR/gQSe4cOUGDvTAt7ld05U45UDTrvmae/lZUc9kxlokdIrcp
	xhjjtGR8bdHFSogyOevwEx6VSLfeM/ZoUOK0fcef4ou1COPc4e1C2wCkaZrlUoHvDMJcFg==
X-Received: by 2002:a05:622a:248b:b0:533:340e:7483 with SMTP id d75a77b69052e-542b3b79278mr297009751cf.5.1793872942151;
        Thu, 05 Nov 2026 02:02:22 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10a7006asm48116661cf.17.2026.11.05.02.02.21
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:02:21 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5364042eecfso22734421cf.2
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 02:02:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxlJakfwnbAFagm7+bRgddFvntMiGR7e15BJdCwb1/9UBC5gfyfVuzprC6UNsH0jpr/TKvQgOlJ/BpVARw=@vger.kernel.org
X-Received: by 2002:a05:6102:5108:b0:7cc:56a:58e5 with SMTP id
 ada2fe7eead31-7d072d84a58mr8269567137.37.1793872526219; Thu, 05 Nov 2026
 01:55:26 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org> <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
X-Gm-Features: AclHuK_UsJ1nGicdWEWcMLQAICTi1A7pGF3yhNkxXkXRPqohle17eXAHHNBsR6k
Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/26] zorro: let procfs copy out reads
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

On Wed, 4 Nov 2026 at 20:43, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read from
> /proc/bus/zorro/<slot> to userspace after it unpinned the entry.
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
