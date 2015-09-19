From: "Ivan T. Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/7] tty: serial: msm: Fix command Stale Event Enable definition
Date: Sat, 19 Sep 2015 07:56:35 +0300
Message-ID: <EF8B8149-63BF-4F09-8EF2-AD55E66365DE@linaro.org>
References: <1442062934-13449-1-git-send-email-ivan.ivanov@linaro.org> <1442062934-13449-4-git-send-email-ivan.ivanov@linaro.org> <20150918233316.GB23081@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150918233316.GB23081-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Frank Rowand <frank.rowand-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


> On Sep 19, 2015, at 2:33 AM, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> 
> On 09/12, Ivan T. Ivanov wrote:
>> Stale Event Enable command should be 5 not 8, fix this.
>> 
>> Signed-off-by: Ivan T. Ivanov <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>> drivers/tty/serial/msm_serial.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/tty/serial/msm_serial.h b/drivers/tty/serial/msm_serial.h
>> index 60917d30c6b5..223f961f992a 100644
>> --- a/drivers/tty/serial/msm_serial.h
>> +++ b/drivers/tty/serial/msm_serial.h
>> @@ -59,7 +59,7 @@
>> #define UART_CR_CMD_SET_RFR		(13 << 4)
>> #define UART_CR_CMD_RESET_RFR		(14 << 4)
>> #define UART_CR_CMD_PROTECTION_EN	(16 << 4)
>> -#define UART_CR_CMD_STALE_EVENT_ENABLE	(80 << 4)
>> +#define UART_CR_CMD_STALE_EVENT_ENABLE	(5 << 8)
> 
> I don't get this one
> 
> 5 << 8 == 80 << 4
> 
> so this makes no difference.


Uh, of course. It is not 0x80. 

Regards,
Ivan--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
