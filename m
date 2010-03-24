From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [RFC PATCH 2/2] Alchemy: UART PM through serial framework.
Date: Wed, 24 Mar 2010 18:46:34 +0100
Message-ID: <f861ec6f1003241046q200bdb4ey2d2439197e63e76e@mail.gmail.com>
References: <1269450986-3714-1-git-send-email-manuel.lauss@gmail.com>
	 <1269450986-3714-3-git-send-email-manuel.lauss@gmail.com>
	 <4BAA4E81.8070405@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:53737 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508Ab0CXRqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Mar 2010 13:46:36 -0400
In-Reply-To: <4BAA4E81.8070405@mvista.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>

On Wed, Mar 24, 2010 at 6:40 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Hello.
>
> Manuel Lauss wrote:
>
>> Hook up the Alchemy on-chip uarts with the platform 8250 PM callback
>> and enable/disable the uart blocks as needed.
>>
>> Tested on Au1200.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> ---
>> =A0arch/mips/alchemy/common/platform.c | =A0 17 +++++++++++++++++
>> =A0arch/mips/alchemy/common/power.c =A0 =A0| =A0 32
>> --------------------------------
>> =A02 files changed, 17 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/mips/alchemy/common/platform.c
>> b/arch/mips/alchemy/common/platform.c
>> index 2580e77..70f4abd 100644
>> --- a/arch/mips/alchemy/common/platform.c
>> +++ b/arch/mips/alchemy/common/platform.c
>> @@ -21,6 +21,22 @@
>> =A0#include <asm/mach-au1x00/au1100_mmc.h>
>> =A0#include <asm/mach-au1x00/au1xxx_eth.h>
>> =A0+static void alchemy_8250_pm(struct uart_port *port, unsigned int=
 state,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int o=
ld_state)
>> +{
>> + =A0 =A0 =A0 if (state =3D=3D 0) { =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* p=
ower on */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, port->membase + UART_M=
OD_CNTRL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wmb();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1, port->membase + UART_M=
OD_CNTRL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wmb();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(3, port->membase + UART_M=
OD_CNTRL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wmb();
>> + =A0 =A0 =A0 } else if (state =3D=3D 3) { =A0 =A0 =A0 =A0/* power o=
ff */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, port->membase + UART_M=
OD_CNTRL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wmb();
>> + =A0 =A0 =A0 }
>> +}
>
> =A0A *switch* statement seems more fitting here...

Well, those are the only 2 values defined anyway, but I'll change it.

Thanks!
       Manuel Lauss
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
