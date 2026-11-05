Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873323;
	b=SLfeHR2Z7M9yv7SmDNdDKu8s+r4grdS/JvKRwRXCrP60kHZ1EL2IDB1S1/3PhP1DlotB
	 teLGstl70VjYEfsduB4c67q8BXbSh92NTrku3omqlUIXqkW9bgHKNG61ioTWTDnvFPT6N
	 +xA7FutQAGJ2Y79qIFcFznVho91F2tdvsSPKn2zThAmCYhDIY4XJxWPX0UCyyo6DP+Q93
	 xUrSPzgCDXy6BF1Fr4Zv/AXew0Ap91lUesLF3z9Zl4rTM2WNClYXa0l0kAV9bRyjXWZCp
	 F9heyQDhacmCObFq5ubMsd8dy8+3ynKUxA85M4/xwyGDMsONnHd53U3EIgMx4vUC9Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873323;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Z2qCIfu1coqF5CKQo/xHkFXbKW7Y+rLlNCa31RZmxiE=;
	b=1wWYGjxVIzxJXFdcTW++ITy4VdccXs9PAEynVtSH+MFhMWh5twrH+FOahMJhPfZWTPFZ
	 mJixgEm0NLR4N2vvsg5ktdCsRWjjo5iXnVC15Rtc5NtFFwEohW0MCHwgg5qVJl1oXsu0O
	 ZkC/NxRxXr419Ziz56qe11DK2LYle4F/u7C/pfdzvaTOngtmvbkWZs9puzZKUNY+E5d+i
	 2ChJziPJPMKxJPt5fQ43Nj99XEuJFy6h8fNiXLUU55BVO2YyAT6TjoMvKbaXbUxpeGjIu
	 8OCCCrd4emw5x3C8BVLxchqRWpyeCq+UhCwhYriohFDDK+Aw0/WpChwmlYCDJr5SD+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9960A3836
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 10:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89F9960A3836
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99075306daaso889563241.3
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 02:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873322; x=1794478122;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z2qCIfu1coqF5CKQo/xHkFXbKW7Y+rLlNCa31RZmxiE=;
        b=fxYfHNGZAt6jVlN/k2wzTBqC4iga8hLyhnYB/I3HtPhi3sTPx06Ii5aeEdvYsSS6/y
         fZNrAlbKRIFJxze6WfdJ1WvAGXdntC1ZQsv3eboUPiQ8OuLRnyhKpqroMgPK4Ogst/bb
         rmvbK2m71VsdDK8Wr/dS6N01DODAoqB6Qtvu4bgExW9c03NciFaa8weGSGpa8Q+JN/6j
         swk0yj/FHcFA6WdwNhyD6hWYrFz+0pUapzJwnv9/F7oToiUMQK5WPgm+8Sk3xmCTqBKM
         HlBdukzPvMeGrrAl6qc9T/axqc9pNknKJtncJqF5PXJN2VXxxduRpulbTGnjOddqr29z
         9Ucw==
X-Forwarded-Encrypted: i=1; AKwUvBwuvmfBIwQAMLmu8VOujqVtZrjD6Rl62hhKMx5ULOgNmEkreUKSEE6i757q57dbYipDTfeEaX7Szc4dn+Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z86PPwa6s20Cak053ThZOSnFxJglOtIDsSek/AmF2sfOz5edszH
	xnHnPZ+L7q1qGAv6lskjCOZNJpxkXbgT0aLPU0kS4vyBmOz/0xLPKAE6vbW6Ktw42Is=
X-Gm-Gg: AYBFou2v3WNYmRExEtAYQ7K8vPvtI+FFlQGwILvCeyGJLzhHFsHj8vcT2skw2zV3Nys
	WIJufG/kymf3wGw/LnRQH6JXPmd0n/4VlfAOCVwTR1iT+MK8n8OAE6WKPIQ1zWVi5sWexOJNQM+
	sTV8WVJpnkYiYzp/VVBtYcmWJF5YIc6CUcfUx3stmfllcp4iCQJDktaXn8xfxX9StRKYkaGogGJ
	YdbQdE6tNrnbTe7ksdJuk6P+mIH+zdMAq+lu09U0OwmNe331Y8rm1wfvCOKDbp//bb/hugc6YmJ
	zSOpM17mRujXGzz5C8wGrtb33eu3Jj436rlaV/djM8FI8GprA8HAXDYPkhNwE1Ao0rp3l0F1M48
	emPA/T7h3z4Yz6dxDSj/TwtSQq3HQPbzMM97YKS4YVHxzyNn29qA6/z0IoQFX5FO8N8FLjXdIL4
	ST+BFmZLzb5O34gi6Ez1DqDAA/b/YS1mD6CZQVN0bAE+yanRIRL/ROdRb2GozK29JM9q0CV/J1a
	3+aOhfRQKGcZ4k+SPJpMTyiQB9NsirH+xnuWHPqR8QgCTKq1PQHedwfb10C3vI7mza2QuwDvrBu
	L6ZpFmDwD0Gud//TRc5YeENv6sPRmGdUQg1wOmKXl2wbAApzndAdtshSwylupmwm1A==
X-Received: by 2002:a05:6102:c01:b0:7c3:c0b9:8d50 with SMTP id ada2fe7eead31-7d072c89051mr7720492137.21.1793873322579;
        Thu, 05 Nov 2026 02:08:42 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm3840728137.11.2026.11.05.02.08.36
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:08:38 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-990835cec4bso949849241.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 02:08:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByTLV9vqhH0Ondu+ebBh/oDxtJ8Enr/oibUzGqJAIncTXqlQADRIC/ybzkOlluWkAP4QirFalYA+dQiyqU=@vger.kernel.org
X-Received: by 2002:a05:6102:5494:b0:7cb:bc5e:7d9f with SMTP id
 ada2fe7eead31-7d072bb3829mr8787869137.11.1793873316184; Thu, 05 Nov 2026
 02:08:36 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-16-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-16-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:08:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAk9CwoXpak8+EQjdvJ2Ab9fo1bvj_D5GqBzXB7urEUQ@mail.gmail.com>
X-Gm-Features: AclHuK_D2R6ZzQFy7DOLUQHC3VotRoglnOuhbtIFU-Oniz4UMRG_6kQUnblEqeo
Message-ID: <CAMuHMdXAk9CwoXpak8+EQjdvJ2Ab9fo1bvj_D5GqBzXB7urEUQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 16/23] proc: let procfs copy out reads that
 don't go through seq_file
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

Hi Christian,

On Wed, 4 Nov 2026 at 20:33, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_read() and proc_reg_read_iter() pin the entry and call
> ->proc_read() or ->proc_read_iter() which copy to userspace
> themselves. Like for seq_file reads and for writes, a reader can make
> a page fault in that copy take as long as it wants and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for these reads as well. An entry that implements
> ->proc_read_buf() fills a kernel buffer of at most ->proc_read_size
> bytes, a page if the entry doesn't care, and procfs copies it to
> userspace after unpinning the entry. The entry moves the position like
> it did for ->proc_read() but that only sticks if the copy to userspace
> worked, like in kernfs_file_read_iter(). If the copy fails halfway the
> read fails with -EFAULT and the position stays, where
> simple_read_from_buffer() returned what it had copied until then.
> procfs remembers ->proc_read_size in the entry like ->proc_write_size.
>
> Larger reads come up short, like with kernfs. An entry whose readers
> want all of a large file in one read asks for PROC_ENTRY_FULL_READS and
> procfs fills the read in pieces of ->proc_read_size, unpinning the entry
> in between. A piece whose copy fails ends the read with what the pieces
> before it returned. kexec-tools treats any short read of /proc/vmcore
> as fatal for example (cf. [1]).
>
> These entries are read through ->read_iter() so readv(), splice(), aio,
> the RWF flags, kernel_read() and io_uring work for them like for the
> ->proc_read_iter() ones. io_uring's nonblocking attempt gets -EAGAIN
> though, like loop_rw_iter() gave it for ->proc_read() entries. Neither
> the allocation nor the entry can honor IOCB_NOWAIT, and io_uring would
> take a short read of a record file for an unfinished one and glue the
> next record to it. So it retries from a worker like before.
>
> An entry that implements ->proc_read_buf() and also declares a seq_file
> or one of the other read methods fails to register.
>
> No users yet.
>
> [1]: https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/util_lib/elf_info.c
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h

> @@ -84,6 +91,15 @@ struct proc_ops {
>          */
>         ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);
>         unsigned int proc_write_size;
> +       /*
> +        * procfs calls ->proc_read_buf() to fill a kernel buffer of at most
> +        * ->proc_read_size bytes, PAGE_SIZE if that's 0, and copies it to
> +        * userspace afterwards. Larger reads come up short unless the entry
> +        * asks for PROC_ENTRY_FULL_READS. The position the entry moves to only
> +        * sticks if the copy works.
> +        */
> +       ssize_t (*proc_read_buf)(struct file *, char *, size_t, loff_t *);

As for proc_write_buf, I think it would be good to use this conversion
as an opportunity to replace "char *" by "void *", which will probably
let you drop several casts from users.

> +       unsigned int proc_read_size;
>  } __randomize_layout;
>
>  /* definitions for hide_pid field */
>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
