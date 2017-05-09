From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Subject: Re: [regression, bisected] 4.11+ imx uarts broken
Date: Tue, 9 May 2017 10:25:40 +0300
Message-ID: <a1fa7693-c9e9-fea8-fbb7-a20ebf1dd287@nextfour.com>
References: <f6fded83-f062-94da-ec1b-b2ab6e6c5101@nextfour.com>
 <20170509071435.kxt6pjlglzinf2w5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170509071435.kxt6pjlglzinf2w5@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 05/09/2017 10:14 AM, Uwe Kleine-König wrote:
> Hello Mika,
> 
> On Tue, May 09, 2017 at 07:18:09AM +0300, Mika Penttilä wrote:
>> The following commit e61c38d85b7 makes the uarts on i.MX6 nonfunctional (no data transmitted or received). 
>> With e61c38d85b7 reverted the uarts work ok.
>>
>> -------------------
>> commit e61c38d85b7392e033ee03bca46f1d6006156175
>> Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Date:   Tue Apr 4 11:18:51 2017 +0200
>>
>>     serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off
>>  
>> --------------------
> 
> are you operating the UART in DTE or DCE mode? Does this affect all
> UARTs or only those that are not used in the bootloader?

I am operating in DCE mode. The debug/console uart works ok, but two others don't.

> 
> Looking at the patch I wonder if setting IMX21_UCR3_RXDMUXSEL |
> UCR3_ADNIMP is missing for you.
> 

Probably yes, but I can verify this later and get back to you.

> Can you please check which hunk of e61c38d85b73 is giving you problems?
> 
> Best regards
> Uwe
> 

--Mika
