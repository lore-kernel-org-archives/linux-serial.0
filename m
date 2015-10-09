From: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] Revert "serial: 8250_dma: don't bother DMA with small
 transfers"
Date: Fri, 9 Oct 2015 16:45:14 +0200
Message-ID: <5617D2FA.1020108@linux.intel.com>
References: <1444136920-17969-1-git-send-email-frederic.danis@linux.intel.com>
 <20151006135503.GA13250@kroah.com> <5613D968.7000505@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5613D968.7000505-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hello Greg,

On 06/10/2015 16:23, Frederic Danis wrote:
>>
>> Andy, any objections?
>>
>> Frederic, don't you want to see this backported to 4.0 and newer?
>
> Yes, you're right, unless Andy has any objection this should be good

This is first time for me that patch may be applied to previous kernel.

Is there something specific I should do to allow this patch to be 
applied and backported to 4.0 and newer ?

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporation
