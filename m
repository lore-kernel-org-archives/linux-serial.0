From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] tty: Remove leftover dependencies on PPC_OF
Date: Fri, 17 Apr 2015 08:00:45 +0100
Message-ID: <CACxGe6tEBJkQQJnGjoGYKn_uDgqBd9qkPvY076PO28Szs5V=uw@mail.gmail.com>
References: <1429248059-18461-1-git-send-email-linux@roeck-us.net>
 <20150417060104.GH6256@pek-khao-d1.corp.ad.wrs.com> <5530A572.6060506@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5530A572.6060506@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kevin Hao <haokexin@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 17, 2015 at 7:17 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 04/16/2015 11:01 PM, Kevin Hao wrote:
>>
>> On Thu, Apr 16, 2015 at 10:20:59PM -0700, Guenter Roeck wrote:
>>>
>>> powerpc qemu runs fail with the current upstream kernel.
>>> Bisect points to commit 52d996270032 ("powerpc: kill PPC_OF").
>>> Unfortunately, that commit did not remove all instances of PPC_OF.
>>> Practical impact is that the serial driver used by powerpc qemu
>>> targets is no longer built into the test kernel.
>>
>>
>> Sorry for the break. This is a dependency issue. The patch 213dce3c17a6
>> ("tty: kconfig: remove the superfluous dependency on PPC_OF") has already
>> been merged into tty-next, but still not propagate to upstream yet. I
>> failed
>> to reminder Michael of this when the pulling request is sent to Linus.
>>
>
> Guess that explains why I don't see the breakage in linux-next.
>
> This kind of problem seems to be happening a lot in this commit window.
>
> Is there a new mechanism in place which requires splitting such series
> into multiple parts ? Personally I preferred the "old" style, where
> the entire series would have been handled by one maintainer, with Acks
> from the others.

The rules haven't changed. Maintainers are doing the wrong thing. If a
series is split up into multiple parts, then maintainers *must*
coordinate to put the prerequisites into a single branch that can be
merged into each branch handling it. However, it is still almost
always better to just merge the entire series via a single tree.

Make noise whenever you see this kind of breakage because it means a
maintainer has done the wrong thing.

g.
