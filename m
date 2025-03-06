Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E9192D9A;
	Thu,  6 Mar 2025 04:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741234961; cv=none; b=gwEvyugTl+F3Tz98uY4+3J22ZTekKVgQQ71YUgWy0Kc5otbl8cNx+iRCQ0olusqtiZn+PZaJneBmgBDvCMPiYOcE6T1q+PyfDk7JUbAR0DO89Hj44LDgE9TYIRwT+EuQYlX27836VYjDiKIDEfGXWjHfQFTcJNJdXHwysm2IPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741234961; c=relaxed/simple;
	bh=H2OVW5hp+pECfwQ8sOJWNwxdv2gjfOiIOLFnUzzbq6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8lP/gKD9T+2CCk8kHmOA5M/AJPnkUD96DNAJTTLnibys29z04+Q3fFY4H9yMOCVuPAeC7mymNof0wDrPJNertgfGEXqfn8QmKAlYldeRhs/M6ltbfdmzHOIHnKC9o+VmPpXWLDvhszX7TxjctaLpgPPLug9Kkyq8HE0Pghs/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDsImsiX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDsImsiX"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3b4c4b409so37497585a.3;
        Wed, 05 Mar 2025 20:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741234958; x=1741839758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/KN0xY9MIh51cXx4wjb4mSWDZdUL41avdYzHlA6zDA=;
        b=BDsImsiXLht7VBHzBRU8XqOsaOhI+hne/Ob6TvS/PMlMjMXHZ4Pij88OeFCokReTjE
         46NuP9nEZYXwd6L07SLfJq3di80y7c1gSGnzWUctSq06CSLWjw00FOJxU79Kfo24wj3v
         KSgM5FAp7Y2W/5AZuPK5ooODmhpObQatnh+58TgxP6DOl1ap590TVdN5Z2a525jYOhPx
         Nv2d+Qwli8m19r/pSmYOb3UV9VE2wII58UzTo4YqvXbN1uIQohD6oMGrYVpLuoXMyZzV
         zLs7t7MR2BKL6+hALzJpPJHLUmiBlb4dbrw7NOnFhonL/Ww5v+j2vRCH0CszoZA5oDE2
         lpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741234958; x=1741839758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/KN0xY9MIh51cXx4wjb4mSWDZdUL41avdYzHlA6zDA=;
        b=S0pNaPvKiE2Z1OKAJFLBDmy/ixII4T8ifAcO/ldOiviRc53ebUKzUDvD+uO8LspWv5
         RKMMio/ZOPRutjrbLS0HyALlW1NmHpIAMqft6vnL3MITJ+igpm5oGQhWamyCAW1eVpG4
         DJxid9S7njTXWVbgGVKAWHXs70/ntsc9ykslo+GkUN3yagjgeL4tZ8UNUiLJNsdTulg+
         u7JN4S3W5szDZWCBEQC93TEy4cbUgJRhlzbmLrk3ngO0fmzIg8UPtOPNK6BqQ/9ENElP
         9nPI68nkaJVv7raEymBdpookcuWVTwudoW1u3I65dIo+tK5uRxn4Mu0BX4sOOjfR8bTb
         Kksw==
X-Forwarded-Encrypted: i=1; AJvYcCWm+DkZ4GDYmEnJNuGFyloz7NX/JmFQSeR7zmVsE1+qcbhgb+dqe4STzCi8VVJYhns0BOD53NiVs+MkuRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQi4B9hBR0oYo9lMVwML3NYJusyFw0W0qoGcA4vA6cLwBx6BB
	wtKphvPbDhb7dgutAHNUfIXdCix+w3LfJcJtxzlfRKhIvio5+kB9
X-Gm-Gg: ASbGncvsBsOV/Zq8Jzplx8WeNYw7AkxBjPCurzlTr7V8pf4ld5/vHW0zPqzHYhiZ4zJ
	SIYdHj4MqJs1tmFT0QG/gzg5UNH29iqI6ZM/cLlHJ/TFAs4EwndsSgTLEKMdo0U4Qt+9xZN8ndB
	ze2rKP99dIQTvgMgkziCwdnoBHng3sHFL2p6ZfoLDfj+4JohBINN75Ss762+oMoPONdkSd9uKhX
	XlzvOF/uM+JNhHNM62DYiqv1mYS0tajtAP3HOlxiQbmH9gPOCh0shl8CrlmHutRV00XSZ6JeLDP
	u5sgAMUgCGTUXa5zPJobHz8h8rwuW0QXVc/lkWCjFkp+Gi2Ajm0zyn2wfme0d7oYZQ==
X-Google-Smtp-Source: AGHT+IH6apQoKwM/9SjFk1i/87DiWodBnnoPXC51KenGbllayxgk7R6It54iIQhW6KT0cb19RfRQxQ==
X-Received: by 2002:a05:620a:2606:b0:7c0:a236:7183 with SMTP id af79cd13be357-7c3d8eb185dmr800727385a.37.1741234958474;
        Wed, 05 Mar 2025 20:22:38 -0800 (PST)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:2726:6286:a126:9027])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551102csm36784785a.101.2025.03.05.20.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 20:22:37 -0800 (PST)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Subject:
 Re: [PATCH v6 3/3] tty: Change order of ttynull to be linked sooner if
 enabled as a console.
Date: Wed, 05 Mar 2025 23:22:35 -0500
Message-ID: <4451040.8hb0ThOEGa@nerdopolis2>
In-Reply-To:
 <CAHp75VfadXS8Z2G6U_DcOOZFFmaOSn_9uQN_N7Psse3kiSGj0g@mail.gmail.com>
References:
 <20250304035447.3138221-1-adamsimonelli@gmail.com>
 <7969025.Sb9uPGUboI@nerdopolis2>
 <CAHp75VfadXS8Z2G6U_DcOOZFFmaOSn_9uQN_N7Psse3kiSGj0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, March 5, 2025 1:52:00 PM EST Andy Shevchenko wrote:
> On Wed, Mar 5, 2025 at 4:06=E2=80=AFAM Adam Simonelli <adamsimonelli@gmai=
l.com> wrote:
> > On Tuesday, March 4, 2025 1:51:52 AM EST Andy Shevchenko wrote:
> > > On Tue, Mar 4, 2025 at 5:55=E2=80=AFAM <adamsimonelli@gmail.com> wrot=
e:
>=20
> ...
>=20
> > > >  obj-y                          +=3D vt/
> > >
> > > + blank line.
> > >
> > > > +# If ttynull is configured to be a console by default, ensure that=
 it is linked
> > > > +# earlier before a real one is selected.
> > > > +obj-$(CONFIG_NULL_TTY_DEFAULT_CONSOLE) \
> > > > +                               +=3D ttynull.o
> > >
> > > Here is the question: are you sure that all console drivers that exist
> > > in the kernel happen to be here? Have you grepped the source tree for
> > > checking this?
> > >
> > Grepping for console_initcall, the only other places I see outside of
> > drivers/tty/ is
> >
> > arch/mips/fw/arc/arc_con.c
> > arch/mips/sibyte/common/cfe_console.c
> > arch/powerpc/kernel/legacy_serial.c
> > arch/powerpc/kernel/udbg.c
> > arch/powerpc/platforms/powermac/setup.c
> > arch/um/drivers/stderr_console.c
> > arch/xtensa/platforms/iss/console.c
> > drivers/s390/char/con3215.c
> > drivers/s390/char/con3270.c
> > drivers/s390/char/sclp_con.c
> > drivers/s390/char/sclp_vt220.c
>=20
> Which means you need to test your stuff on those cases, to see how the
> linker order is done there. It might be that your change wouldn't work
> there as expected (quick workaround is to mark the new option as
> depends on !S390 && !PPC and so on.
>=20
>=20
It will be difficult to test other arches, I mean I guess it is possible wi=
th
QEMU, and cross-building, though I did do an experimental test on x86:

Making it temporarily adding an architecture specific console like
powerpc/some mips/s390/arches with Xen enabled.
=2D------------------------------------------------------------------------=
=2D-----
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 05c5aa951da7..bcd248c44fc8 100644
=2D-- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1159,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
=20
        e820__setup_pci_gap();
=20
+       add_preferred_console("ttyS", 0, NULL);
+
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
        if (!efi_enabled(EFI_BOOT) || (efi_mem_type(0xa0000) !=3D EFI_CONVE=
NTIONAL_MEMORY))
=2D------------------------------------------------------------------------=
=2D-----
=20
to see what /proc/consoles will look like, to pretend that x86 is an arch t=
hat
sets a console somewhere, and I get:

ttynull0             --- (EC    )  242:0
ttyS0                -W- (E  p a)    4:64

and I got console messages to ttyS0 with no issue.

which in my mind is acceptable I would think. ttynull is first in the list,
which is desired effect of CONFIG_NULL_TTY_DEFAULT_CONSOLE, it doesn't have=
 to
be _exclusive_ AFAIK, especially if there are long-time default consoles th=
at.
users or the hardware expects.


The only arch that seems to _unconditionally_ add a console without some ot=
her
circumstance, like boot loader env var, and command line option, or firmware
flag, or suboption (like CONFIG_SERIAL_PMACZILOG_CONSOLE) is Jazz.=20

Like platforms/powernv adds it if CONFIG_HVC_OPAL is disabled, or the firmw=
are
is missing "FW_FEATURE_OPAL". I would assume that a user of this situation
turning on CONFIG_NULL_TTY_DEFAULT_CONSOLE in addition, will just get ttynu=
ll
and hvc in /proc/consoles instead of just hvc. Could that cause something to
break?



Correct me if I am wrong, I could very very very well be wrong.




