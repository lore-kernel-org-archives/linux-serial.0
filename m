Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823213;
	b=nUgIfqztaPDpNVcQJxZgJoytuiT2b8RTJEVislUvMoIZAwR3op9KMMFgTkA2Itz9EOOm
	 zruaYdxFlXRz1FdTKgG1YbLUgzVqk8eVFzDMszoY8d58gPdAZXZmAqVehhgE96QUM6l1T
	 TaThWYD2tZm5jEKDfoRgK33sNm6s5YCkMN1RIngDf4idc1FIBDjSJ+BP2e2sVR38EEuQ/
	 D2BmQlRZYGsHDxm0L1uOhdps2VuSNXYpWPBbmcXKoMS5KTUR8eF4MBKkhcDMnxbeluItV
	 OUJNMjkLQ+MnoQ9uenTZ/eGezeM0rylxDnEEZ+Trccmw6ZFrvZ6TgcSDu5/SAPkTp0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	b=Sgr/rLVzk/0DayM/0Sb0gIeCo0HwEsQ0m0+7aRY1ISua0nJjQoLNUJZ3g7KdqJmcAZeV
	 Kwuq1+vP1BGxW6YF2xVWq+6iBe5NDVMb+z7bQME3Bn1jeSe+OAIy7sNY2Q1L1bJB6Wwx3
	 GrR8wD2hhtNXkp/qxBx88OmH+GkxqKq56EuFRK9zk19+KbIjzDTlvsTjthVFKY5IaAwlU
	 BzvJ0VRr9ga3St/UfZfHVnm/QPwJv0UZ4y3uWPzVL4Hb3QrPusFttAkH0RF4PMQFf/VVT
	 391KXOa0vLLaE/F+W/2IxjqizUmRVIWIVs5zq9B8N9TZvqRMqz+uMAa7Gqip2gny67w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=IgDRGmtp;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D44606D81E
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 20:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95D44606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=IgDRGmtp
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c445c95d553so165089266b.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2026 12:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823211; x=1794428011; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=IgDRGmtp59pqvL9s1uRP/Orbzjg9Ku7OmWz55etQb0fv+8mC0ho+9XJL/zm+oOI2Hl
         6DnIl7kADWV4bgKOEnEHgA3jlXtY6mkTTzgB4P2HkU1mTqczsFGptgejt7PbyX1Wocr6
         aP0jML0ryKh/b52Zqk7qrCYKl0aHi9GlImVeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823211; x=1794428011;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=lPFy7gBcrnLKyEOtCsFWdXUW7T5mbVbB0MoAqYde434kZ6R4a6q34HrNgMfFuHasc+
         nVag9SME8D6oBANfwXWXbKKUbLvnKy2Q7jBKPXIfx1XFbgcbtwe9YAU+3EBjn/VWdhue
         JToX6p0oDUVuDu64RVgXvWe/S6i7vvauc5F+5jktIv4+XFmY3cRN0zYMuugxvI77bn79
         Wu3UC9v4hwlkJ0ZdWJYJUNhUAzRz8Ru3V3w5JfyGQltm4DLxu7ZFkpigh8li7BcwJoSa
         XpxMeL8I9bF75HQHYHqvjYUfeDu+c4NKYT72GwB1n5feSVHLJreAvZdWPl2Hn39x6thr
         UtZA==
X-Forwarded-Encrypted: i=1; AKwUvBxorK9YeyLOU70dIuMGlrpPUMm9dT7JuPnrx619qj0w8Hiqq09QSp2I52duMvdEiAVD256zl+MfvLEep2Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xJn8vDhgPpBE+QtxDOSP5LuOd90vuFA/DHuSXqTL4fFprw5x5
	5Nbik71OM5wKmsy0eJkaCY3PimVc82IeDf8sZNqY4jsMj3TixHuwFdZucwciZF5PEIHRr11YosU
	78VTNIl+TPg==
X-Gm-Gg: AYBFou2ol/a5uu0wgY4n0My+uTCrWkG7JoZZSU8bG0yJG/WYEv4nYmaylwsmI9rq0EF
	oVzJuDpJ2RctcYpRLN9VEITv7Y9Yw/Lwv4pcg08R09gHtQUDm93tmCwlKUQ2iqK0QFeaTvagqBn
	dT5jSqdsc/MrviQGtOwAhD2r663+p2MKjZTpPu3H3fzmwwNDX0tgdh1QpQzSf0UQlPGzI/s7DTP
	0DoGgrsg1rPSZs8N6c2H9x/OtAuLUdm4xYT7j3iiLdjif9YWH4R+rxj6CBZ9ljd3rZaTbPAC+GV
	sJMVNn+ANGfLrzdjg6+Pp6j9+mSW3jZcJ9e6WZ+3q4nwzzJpogti6uKPtBWb0YaSBwklLEDSweo
	JlKrpFKTqDi/Y0ldknCfk9fqsFntwBGOAettrOFbkKMT7cb5ELV2xRg/VVuPZeUJu2Fs48hKrqh
	ZT7/fL+OhmKQEA+NXNqkmo2XBZq9FeIWOMygqMlrGTFvjCFgxAzeiCrD8pfE4S9aWcmjXbdQw3D
	Y2/JG9t38+r1kjNipowO1LP4ksi/tu2hAXBB19+vrwNUNR5YTL5dUk4OnwAUB2MkQGSA7wKx+zr
	hAUOG4iRQa5WfLk01ild0X+CHrdBDLWUhi96aEBVcSvHKmtNZC3+ZX7pDqiY7u6/AyMvJCvMhrM
	qgw==
X-Received: by 2002:a17:906:eec8:b0:c2e:317e:d711 with SMTP id a640c23a62f3a-c4ca7aac250mr1583269166b.27.1793823211074;
        Wed, 04 Nov 2026 12:13:31 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e46a465sm105242066b.58.2026.11.04.12.13.30
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:13:30 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so1564221a12.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2026 12:13:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByNPC8KXk69pedd4hhu2hjfrybA9UOxJ2313saGAQAT5DNcEH2Vi5u/VMIwPZ/SohVwg5yP0269cyCy8ag=@vger.kernel.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
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

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus
