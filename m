From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 1/3] x86, boot: add mmio serial during compressed boot
Date: Sat, 13 Jul 2013 14:56:54 -0700
Message-ID: <CAE9FiQVrq3_oeFFLVhXvfBM75frQghzy7i6r+N4gW_F-K0-n8g@mail.gmail.com>
References: <1373659660-31123-1-git-send-email-keescook@chromium.org>
	<20130712203802.GA14702@www.outflux.net>
	<CAE9FiQWJin8-hXsodo46vhYPMrWiiboEVQySPO-LgXtebYmUzw@mail.gmail.com>
	<51E169F1.5010301@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:38743 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab3GMV4z (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Jul 2013 17:56:55 -0400
In-Reply-To: <51E169F1.5010301@zytor.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org

On Sat, Jul 13, 2013 at 7:53 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 07/12/2013 11:47 PM, Yinghai Lu wrote:
>>
>> for 32 bit, that is ok.
>> for 64 bit via 32bit bootloader, arch/x86/boot/compressed/head_64.S
>> will set page table for first 4G still ok.
>> for 64 bit via 64bit loader, like kexec via bzImage64, First Kernel/Kexec only
>> set ident mapping for usable range, so mmio just under 64 is not mapped.
>>
>> Looks like we need to update boot.txt to add requirement for 64bit bootloader
>> that 0-4G need to be all ident mapping?
>>
>
> I think that is an unrealistic requirement, especially if this is the
> sole user.

That will cause regression for:
64bit system with kexec/kdump bzImage64.
if second kernel carry "console=uart,mmio,0xABCD0000"

or we can extend kexec-tools to make it scan second kernel command line string
and one entry into image->segment[]

Yinghai
