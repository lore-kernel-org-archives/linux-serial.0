From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v13 5/5] uart: pl011: Add support to ZTE ZX296702 uart
Date: Tue, 27 Oct 2015 09:31:13 -0400
Message-ID: <562F7CA1.5080100@hurleysoftware.com>
References: <1438328959-16177-1-git-send-email-jun.nie@linaro.org>
 <1438328959-16177-6-git-send-email-jun.nie@linaro.org>
 <55FC16A2.5070207@arm.com>
 <CABymUCOA3oG7Hq83hDyQ_uisQHeipoHshcWONWTtjxKvikzjsQ@mail.gmail.com>
 <CAOZdJXUjZLKkUYScD7oDTMuRUtAEJ6=DopmE4n6Vb9zyv+_viA@mail.gmail.com>
 <CABymUCORU9CDD64Rdw2VX0kLSe6E1zY9iZCap5xittoVFwbOtw@mail.gmail.com>
 <562AFBD5.3050508@codeaurora.org>
 <CABymUCMAc59SCBnji8bcHkYzuFMbA3GMZL0Cv6ReuK=27kBW4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABymUCMAc59SCBnji8bcHkYzuFMbA3GMZL0Cv6ReuK=27kBW4Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jun Nie <jun.nie@linaro.org>, Timur Tabi <timur@codeaurora.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "jason.liu@linaro.org" <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "wan.zhijun@zte.com.cn" <wan.zhijun@zte.com.cn>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 10/25/2015 09:27 PM, Jun Nie wrote:
> 2015-10-24 11:32 GMT+08:00 Timur Tabi <timur@codeaurora.org>:
>> Jun Nie wrote:
>>>
>>> I am OK to add a new driver for ZTE UART if no other's objection
>>> though I do not agree you. Without this last patch, other patches are
>>> just for minor refactor for register access.
>>
>>
>> In that case, my vote is to drop the whole patchset.  Just copy/paste the
>> amba-pl011 driver and make whatever changes you need.  That sort of thing
>> happens all the time.
> 
> Greg, Peter & Russell,
> 
> What's your opinion on this separate UART driver suggestion?

That's crazy; fork the driver simply because the register i/o addresses
are different? No.

On the contrary, this patchset directly triggered important improvements to
both this driver and the ARM arch.

Regards,
Peter Hurley
