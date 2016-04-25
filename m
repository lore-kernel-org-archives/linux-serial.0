From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: msm_serial add info message
Date: Mon, 25 Apr 2016 14:31:27 -0700
Message-ID: <571E8CAF.4060601@gmail.com>
References: <571BAC8B.80001@gmail.com> <571BAE11.3020706@gmail.com> <20160425204806.GG13149@codeaurora.org>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160425204806.GG13149@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, ivan.ivanov@linaro.org
List-Id: linux-serial@vger.kernel.org

On 4/25/2016 1:48 PM, Stephen Boyd wrote:
> On 04/23, Frank Rowand wrote:
>> From: Frank Rowand <frank.rowand@am.sony.com>
>>
>> Failure to enable DMA by the msm_serial driver is silent.
>> Add a message to report the failure.
>>
>> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
>> ---
>>  drivers/tty/serial/msm_serial.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> Index: b/drivers/tty/serial/msm_serial.c
>> ===================================================================
>> --- a/drivers/tty/serial/msm_serial.c
>> +++ b/drivers/tty/serial/msm_serial.c
>> @@ -170,6 +170,7 @@ rel_tx:
>>  	dma_release_channel(dma->chan);
>>  no_tx:
>>  	memset(dma, 0, sizeof(*dma));
>> +	dev_info(dev, "msm_serial: DMA not enabled\n");
>>  }
>>  
> 
> Wouldn't this print twice for TX and RX channels? I'd prefer we
> not print anything when this driver probes, just because it's a
> bunch of log spam that we don't really need.

This is in msm_request_tx_dma().  I should have made the message
"msm_serial: TX DMA not enabled\n" and added a similar message
to msm_request_rx_dma().

Then it could print twice, once for TX and once for RX. :-)
For my board it would print twice because both requests would
fail for the same reason.

Should I add it to msm_request_rx_dma() also, but make both
locations dev_debug() instead of dev_info()?

-Frank
