From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 1/3] x86, boot: add mmio serial during compressed boot
Date: Tue, 16 Jul 2013 12:40:12 -0700
Message-ID: <CAGXu5jJJXgnJxuvc851UZ4Du10HSBJnDWc7rKgRb4_=ojMmtug@mail.gmail.com>
References: <1373659660-31123-1-git-send-email-keescook@chromium.org>
	<20130712203802.GA14702@www.outflux.net>
	<CAE9FiQWJin8-hXsodo46vhYPMrWiiboEVQySPO-LgXtebYmUzw@mail.gmail.com>
	<CAGXu5jJs5ve-31AYKbv6EaV5PKCf5cOEeWTRsYsi_kBbLWj5uQ@mail.gmail.com>
	<51E5A0A9.90108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:54168 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933742Ab3GPTkN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Jul 2013 15:40:13 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so2503508ieb.10
        for <linux-serial@vger.kernel.org>; Tue, 16 Jul 2013 12:40:12 -0700 (PDT)
In-Reply-To: <51E5A0A9.90108@zytor.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-serial@vger.kernel.org

On Tue, Jul 16, 2013 at 12:36 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 07/16/2013 12:31 PM, Kees Cook wrote:
>>
>> Could the first step be documenting the limitation? I've found this
>> patch extremely useful for my case already, and I imagine there might
>> be other people that need the early mmio stuff to. Generally the
>> compressed boot serial console stuff is going to be used in the more
>> common non-kexec situations at least for a while.
>>
>> Does this patch create any _problems_? Right now, neither low nor >4G
>> kernel can use an mmio serial port. :) This this, we'd at least gain
>> it for the low case.
>>
>
> Even documenting the limitation is likely to end up with a bunch of
> emails asking why their kernel crashed.
>
> I think setting up a dynamic #PF handler is the right thing for the
> decompressor, we already did for the kernel proper.

I'm not sure how to accomplish this yet. I'm still trying to
understand how the page tables are arranged. :)

-Kees

--
Kees Cook
Chrome OS Security
