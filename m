From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH] serial: samsung: add clock controls in
 s3c24xx_serial_resume_noirq()
Date: Thu, 26 Jan 2017 14:40:52 +0100
Message-ID: <43f1d7da-9857-4f0e-12b9-ff0f241de762@math.uni-bielefeld.de>
References: <000d01d218c5$3069cdf0$913d69d0$@samsung.com>
 <CGME20160930103448epcas2p4e2ee38332ad98ad3cb1e07866d4337d8@epcas2p4.samsung.com>
 <20160930103434.GA4713@kozik-lap>
 <000401d21dfc$dba89bb0$92f9d310$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <000401d21dfc$dba89bb0$92f9d310$@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?UTF-8?B?64Ko7JiB66+8?= <youngmin.nam@samsung.com>, 'Krzysztof Kozlowski' <krzk@kernel.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

was going through my mail folder and I don't think that this patch was
ever applied (or resent).

Just wondering if it is still necessary.

- Tobias


남영민 wrote:
> Hello,
> 
>> On Tue, Sep 27, 2016 at 10:43:54PM +0900, 남영민 wrote:
>>> This patch adds clock controls in s3c24xx_serial_resume_noirq() to set
>>> S3C64XX_UINTM register.
>>
>> Code looks correct but the commit message is bogus. It does not bring any
>> benefit over the code, not mentioning that it is quite cryptic (what does
>> the "clock controls" mean?).
>>
>> Just describe here WHAT is the problem and WHY the fix is needed.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Thank you for taking your time for the review.
> I will improve the commit message applying your suggestions and resend this patch.
> 
> Best regards,
> Youngmin Nam
> 
> 
>>>
>>> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
>>> ---
>>>  drivers/tty/serial/samsung.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/tty/serial/samsung.c
>>> b/drivers/tty/serial/samsung.c index ae2095a..97f7b3b 100644
>>> --- a/drivers/tty/serial/samsung.c
>>> +++ b/drivers/tty/serial/samsung.c
>>> @@ -1921,6 +1921,7 @@ static int s3c24xx_serial_resume(struct device
>>> *dev)  static int s3c24xx_serial_resume_noirq(struct device *dev)  {
>>>  	struct uart_port *port = s3c24xx_dev_to_port(dev);
>>> +	struct s3c24xx_uart_port *ourport = to_ourport(port);
>>>
>>>  	if (port) {
>>>  		/* restore IRQ mask */
>>> @@ -1930,7 +1931,9 @@ static int s3c24xx_serial_resume_noirq(struct
>> device *dev)
>>>  				uintm &= ~S3C64XX_UINTM_TXD_MSK;
>>>  			if (rx_enabled(port))
>>>  				uintm &= ~S3C64XX_UINTM_RXD_MSK;
>>> +			clk_prepare_enable(ourport->clk);
>>>  			wr_regl(port, S3C64XX_UINTM, uintm);
>>> +			clk_disable_unprepare(ourport->clk);
>>>  		}
>>>  	}
>>>
>>> --
>>> 2.8.1
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-samsung-soc" in the body of a message to
>>> majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
