From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH linux-next] MIPS: ioctls: Add missing TIOC{S,G}RS485 definitions
Date: Wed, 10 Sep 2014 10:39:45 +0200
Message-ID: <CAPybu_128PsDN7wywntyTuCCfenBWTiS60P2g6_Hk68EMQc1CQ@mail.gmail.com>
References: <1410263575-26720-1-git-send-email-markos.chandras@imgtec.com>
 <20140909191736.GA7467@kroah.com> <54100AE5.6050401@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <54100AE5.6050401@imgtec.com>
Sender: linux-next-owner@vger.kernel.org
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: Greg KH <greg@kroah.com>, linux-mips@linux-mips.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Greg

Sorry, Probably my bad :). I did resend a new patch using the _IO*
macros, that has been now merged to tty-next

Regards!

On Wed, Sep 10, 2014 at 10:25 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> On 09/09/2014 08:17 PM, Greg KH wrote:
>> On Tue, Sep 09, 2014 at 12:52:55PM +0100, Markos Chandras wrote:
>>> Commit e676253b19b2d269cccf67fdb1592120a0cd0676
>>> (serial/8250: Add support for RS485 IOCTLs) added cases for the
>>> TIOC{S,G}RS485 commands but this broke the build for MIPS:
>>>
>>> drivers/tty/serial/8250/8250_core.c: In function 'serial8250_ioctl':
>>> drivers/tty/serial/8250/8250_core.c:2874:7: error: 'TIOCSRS485' undeclared
>>> (first use in this function)
>>> drivers/tty/serial/8250/8250_core.c:2886:7: error: 'TIOCGRS485' undeclared
>>> (first use in this function)
>>>
>>> This patch adds these missing definitions
>>>
>>> Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
>>> Cc: <linux-next@vger.kernel.org>
>>> Cc: <linux-kernel@vger.kernel.org>
>>> Cc: <linux-serial@vger.kernel.org>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>>  arch/mips/include/uapi/asm/ioctls.h | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
>>> index b1e637757fe3..34050cb6b631 100644
>>> --- a/arch/mips/include/uapi/asm/ioctls.h
>>> +++ b/arch/mips/include/uapi/asm/ioctls.h
>>> @@ -76,6 +76,8 @@
>>>
>>>  #define TIOCSBRK    0x5427  /* BSD compatibility */
>>>  #define TIOCCBRK    0x5428  /* BSD compatibility */
>>> +#define TIOCGRS485  0x542E
>>> +#define TIOCSRS485  0x542F
>>
>> Any reason you aren't using the _IOR() type macros here?
>>
>> thanks,
>>
>> greg k-h
>>
> Hi Greg,
>
> Not really. I am being consistent with what
> include/uapi/asm-generic/ioctls.h is using, and with the xtensa patch
> that was posted yesterday
>
> https://lkml.org/lkml/2014/9/9/27
>
> --
> markos



-- 
Ricardo Ribalda
