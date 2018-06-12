From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2] serial: imx: fix cached UCR2 read on software reset
Date: Tue, 12 Jun 2018 14:11:44 +0200
Message-ID: <afda793c86ba7394233e17813589b44c@agner.ch>
References: <20180420124407.12892-1-stefan@agner.ch>
 <20180607075633.y3tm245jv7nkdrqx@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607075633.y3tm245jv7nkdrqx@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: gregkh@linuxfoundation.org, festevam@gmail.com, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 07.06.2018 09:56, Uwe Kleine-König wrote:
> On Fri, Apr 20, 2018 at 02:44:07PM +0200, Stefan Agner wrote:
>> To reset the UART the SRST needs be cleared (low active). According
>> to the documentation the bit will remain active for 4 module clocks
>> until it is cleared (set to 1).
>>
>> Hence the real register need to be read in case the cached register
>> indicates that the SRST bit is zero.
>>
>> This bug lead to wrong baudrate because the baud rate register got
>> restored before reset completed in imx_flush_buffer.
>>
>> Fixes: 3a0ab62f43de ("serial: imx: implement shadow registers for UCRx and UFCR")
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> For the record, there is a customer of mine who reports that this commit
> breaks rs485 communication on i.MX25 because RTS stops to toggle as
> intended.
> 
> (Some details: uart3, fsl,uart-has-rtscts, fsl,dte-mode,
> linux,rs485-enabled-at-boot-time, native RTS.)
> 
> I didn't debug this yet.

I have seen your patch today "serial: imx: fix comment about UCR2_SRST
and its handling for shadowing" so I assume you looked into this issue?

Was it related to that change?

--
Stefan
