From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 2/2] xtensa/uapi: Add definition of TIOC[SG]RS485
Date: Tue, 9 Sep 2014 19:32:53 +0200
Message-ID: <CAPybu_0w0+Ez1BUUm6PNwN4gv5w7EqE7YL3F3AvDWVtQ8a_UrA@mail.gmail.com>
References: <1410240056-22786-1-git-send-email-ricardo.ribalda@gmail.com> <CAMo8BfJRO+dwMVDJiQ4KH0PdJN604YrrZZUdSK35KumE574uyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36379 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbaIIRdO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Sep 2014 13:33:14 -0400
In-Reply-To: <CAMo8BfJRO+dwMVDJiQ4KH0PdJN604YrrZZUdSK35KumE574uyg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chris Zankel <chris@zankel.net>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

Hello Max

I really don't know who should do it, the maintainer of tty-next or
you :). I guess Greg will want that his is fixed on his tree asap,
since that build is broken.

Lets give him some time to reply, if nothing happens, then please
apply it through your tree.


Best regards

On Tue, Sep 9, 2014 at 5:24 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Mon, Sep 8, 2014 at 10:20 PM, Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
>> Commit: e676253b19b2d269cccf67fdb1592120a0cd0676 [3/21] serial/8250: Add
>> support for RS485 IOCTLs, adds support for RS485 ioctls for 825_core on
>> all the archs. Unfortunaltely the definition of TIOCSRS485 and
>> TIOCGRS485 was missing on the ioctls.h file
>>
>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>> ---
>>  arch/xtensa/include/uapi/asm/ioctls.h | 2 ++
>>  1 file changed, 2 insertions(+)
>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
>
> If you want this patch to go through the xtensa tree please let me know,
> I'll include it to my fixes branch then.
>
> --
> Thanks.
> -- Max



-- 
Ricardo Ribalda
