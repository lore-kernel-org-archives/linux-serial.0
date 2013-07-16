From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/3] x86, boot: add mmio serial during compressed boot
Date: Tue, 16 Jul 2013 15:05:01 -0700
Message-ID: <51E5C38D.1090201@zytor.com>
References: <1373659660-31123-1-git-send-email-keescook@chromium.org> <20130712203802.GA14702@www.outflux.net> <CAE9FiQWJin8-hXsodo46vhYPMrWiiboEVQySPO-LgXtebYmUzw@mail.gmail.com> <CAGXu5jJs5ve-31AYKbv6EaV5PKCf5cOEeWTRsYsi_kBbLWj5uQ@mail.gmail.com> <51E5A0A9.90108@zytor.com> <CAGXu5jJJXgnJxuvc851UZ4Du10HSBJnDWc7rKgRb4_=ojMmtug@mail.gmail.com> <CAE9FiQUAGPgqU3vOOjKJva=nN71CKoOEdpyjg_23-OfgFSkG=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQUAGPgqU3vOOjKJva=nN71CKoOEdpyjg_23-OfgFSkG=A@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 07/16/2013 02:03 PM, Yinghai Lu wrote:
> 
> Other way could be:
> 
> Detect if it get into misc.c directly from
> arch/x86/boot/compressed/head_64.S::startup_64. that is from 64bit
> bootloader.
> 
> others go through startup_32 should be 32bit bootloader.
> 
> If it with 64bit boot loader path, You can skip parsing mmio in
> misc.c::console_init() calling.
> 

Don't hack around it when we can do it right.

	-hpa


