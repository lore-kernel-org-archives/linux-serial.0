From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] tty: Remove leftover dependencies on PPC_OF
Date: Thu, 16 Apr 2015 23:17:22 -0700
Message-ID: <5530A572.6060506@roeck-us.net>
References: <1429248059-18461-1-git-send-email-linux@roeck-us.net> <20150417060104.GH6256@pek-khao-d1.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150417060104.GH6256@pek-khao-d1.corp.ad.wrs.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
List-Id: linux-serial@vger.kernel.org

On 04/16/2015 11:01 PM, Kevin Hao wrote:
> On Thu, Apr 16, 2015 at 10:20:59PM -0700, Guenter Roeck wrote:
>> powerpc qemu runs fail with the current upstream kernel.
>> Bisect points to commit 52d996270032 ("powerpc: kill PPC_OF").
>> Unfortunately, that commit did not remove all instances of PPC_OF.
>> Practical impact is that the serial driver used by powerpc qemu
>> targets is no longer built into the test kernel.
>
> Sorry for the break. This is a dependency issue. The patch 213dce3c17a6
> ("tty: kconfig: remove the superfluous dependency on PPC_OF") has already
> been merged into tty-next, but still not propagate to upstream yet. I failed
> to reminder Michael of this when the pulling request is sent to Linus.
>

Guess that explains why I don't see the breakage in linux-next.

This kind of problem seems to be happening a lot in this commit window.

Is there a new mechanism in place which requires splitting such series
into multiple parts ? Personally I preferred the "old" style, where
the entire series would have been handled by one maintainer, with Acks
from the others.

Guenter
