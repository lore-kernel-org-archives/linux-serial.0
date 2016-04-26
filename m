From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: msm_serial add info message
Date: Mon, 25 Apr 2016 17:44:43 -0700
Message-ID: <571EB9FB.9070402@gmail.com>
References: <571BAC8B.80001@gmail.com> <571BAE11.3020706@gmail.com> <20160425204806.GG13149@codeaurora.org> <571E8CAF.4060601@gmail.com> <20160425213527.GH13149@codeaurora.org>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160425213527.GH13149@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, ivan.ivanov@linaro.org
List-Id: linux-serial@vger.kernel.org

On 4/25/2016 2:35 PM, Stephen Boyd wrote:
> On 04/25, Frank Rowand wrote:
>>
>> This is in msm_request_tx_dma().  I should have made the message
>> "msm_serial: TX DMA not enabled\n" and added a similar message
>> to msm_request_rx_dma().
>>
>> Then it could print twice, once for TX and once for RX. :-)
>> For my board it would print twice because both requests would
>> fail for the same reason.
> 
> Ah right, the 3 line diff window caught me here.
> 
>>
>> Should I add it to msm_request_rx_dma() also, but make both
>> locations dev_debug() instead of dev_info()?
> 
> Honestly I don't see much point in having this at all. Why does
> the user care if DMA is used or not? Don't they just want the
> hardware to work? Maybe dev_dbg(), but again, debug junk. I'll
> leave it up to you and Greg.

If the user doesn't care if DMA is used then why even bother
implementing it in the driver?  :-)

I don't _need_ the messages, I just need the driver to quit
dropping bytes and writing corrupt bytes.  So patch 1 of 2 is
sufficient for my needs.

-Frank
