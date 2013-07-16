From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 1/3] x86, boot: add mmio serial during compressed boot
Date: Tue, 16 Jul 2013 14:59:11 -0700
Message-ID: <CAE9FiQUW2QTkmT=n3jnL_s09wrSBU5u9rvzNKvCUzcz6pVEgWw@mail.gmail.com>
References: <1373659660-31123-1-git-send-email-keescook@chromium.org>
	<20130712203802.GA14702@www.outflux.net>
	<CAE9FiQWJin8-hXsodo46vhYPMrWiiboEVQySPO-LgXtebYmUzw@mail.gmail.com>
	<CAGXu5jJs5ve-31AYKbv6EaV5PKCf5cOEeWTRsYsi_kBbLWj5uQ@mail.gmail.com>
	<51E5A0A9.90108@zytor.com>
	<CAGXu5jJJXgnJxuvc851UZ4Du10HSBJnDWc7rKgRb4_=ojMmtug@mail.gmail.com>
	<51E5A207.30204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <51E5A207.30204@zytor.com>
Sender: linux-doc-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 16, 2013 at 12:41 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 07/16/2013 12:40 PM, Kees Cook wrote:
>>>
>>> I think setting up a dynamic #PF handler is the right thing for the
>>> decompressor, we already did for the kernel proper.
>>
>> I'm not sure how to accomplish this yet. I'm still trying to
>> understand how the page tables are arranged. :)
>>
>
> Look at the handler at the top of arch/x86/kernel/head64.c.

could extract code from arch/x86/kernel/{head64.c, head_64.S},
and share them with arch/x86/boot/compressed/{misc.c, head_64.S}

Yinghai
