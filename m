From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control from
 set/get_mctrl
Date: Fri, 29 May 2015 15:40:31 +0530
Message-ID: <55683B17.1010706@toradex.com>
References: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>	<1432886754-30115-3-git-send-email-bhuvanchandra.dv@toradex.com> <20150529120421.754fd6ab@north>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150529120421.754fd6ab@north>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?SmFrdWIgS2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhuvanchandra.dv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hello Jakub,

On 05/29/2015 03:34 PM, Jakub Kici=C5=84ski wrote:
> On Fri, 29 May 2015 13:35:53 +0530, Bhuvanchandra DV wrote:
>> The LPUART does not provide manual control of RTS/CTS signals,
>> those can only be controlled by the hardware directly. Therefore
>> manual control of those signals through mctrl can not be provided.
>> The current implementation enables/disables the automatic control,
>> which is not what mctrl should do, hence remove the incorrect
>> implementation.
>>
>> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
>
> Now that the functions do nothing there is probably no point in keepi=
ng
> separate lpuart/lpuart32 variants.
Agreed, will update it accordingly.

Thanks! for pointing this.
>

Best regards,
Bhuvan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
