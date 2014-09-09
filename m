From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 2/2] xtensa/uapi: Add definition of TIOC[SG]RS485
Date: Tue, 9 Sep 2014 08:24:02 -0700
Message-ID: <CAMo8BfJRO+dwMVDJiQ4KH0PdJN604YrrZZUdSK35KumE574uyg@mail.gmail.com>
References: <1410240056-22786-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410240056-22786-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chris Zankel <chris@zankel.net>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 8, 2014 at 10:20 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Commit: e676253b19b2d269cccf67fdb1592120a0cd0676 [3/21] serial/8250: Add
> support for RS485 IOCTLs, adds support for RS485 ioctls for 825_core on
> all the archs. Unfortunaltely the definition of TIOCSRS485 and
> TIOCGRS485 was missing on the ioctls.h file
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  arch/xtensa/include/uapi/asm/ioctls.h | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

If you want this patch to go through the xtensa tree please let me know,
I'll include it to my fixes branch then.

-- 
Thanks.
-- Max
