From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: msm_serial add info message
Date: Thu, 28 Apr 2016 15:15:50 -0700
Message-ID: <57228B96.6090502@gmail.com>
References: <571BAC8B.80001@gmail.com> <571BAE11.3020706@gmail.com> <20160428205132.GA22117@kroah.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160428205132.GA22117@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, ivan.ivanov@linaro.org
List-Id: linux-serial@vger.kernel.org

On 4/28/2016 1:51 PM, Greg Kroah-Hartman wrote:
> On Sat, Apr 23, 2016 at 10:17:05AM -0700, Frank Rowand wrote:
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
> 
> Don't print out messages that a user can't do something with :(
> 
> So I agree, this is not needed, sorry.
> 
> greg k-h
> 

I am ok with dropping patch 2.  No problem.

-Frank
