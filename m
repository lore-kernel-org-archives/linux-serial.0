From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: [PATCH-v2] tty: Use raw spin lock to protect the TTY read section
Date: Mon, 28 Jan 2013 13:15:26 +0100
Message-ID: <CAMSQXEFFYqEZcJr5ig7fHgNd6Vfqh6GFZ_Md5OG=iRpDPWpTUw@mail.gmail.com>
References: <1348150166-4868-1-git-send-email-meltedpianoman@gmail.com>
	<1359023699-27050-1-git-send-email-meltedpianoman@gmail.com>
	<20130125161351.GA9929@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <20130125161351.GA9929@kroah.com>
Sender: linux-rt-users-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi,

2013/1/25 Greg KH <gregkh@linuxfoundation.org>:
> On Thu, Jan 24, 2013 at 11:34:59AM +0100, Ivo Sieben wrote:
>>
>> On a 240 MHz AT91SAM9261 processor setup this fixes about 100us of scheduling
>> overhead on the TTY read call.
>
> Out of how many us total?
>

I tested with a TTY read call that before all optimizations had an
average 76 us and a maximum of 305 us.
After the optimizations the average dropped to 59 us and the maximum
dropped to 135 us.
Of course that gain of 170us is not completely due to this patch, also
the other TTY patches that I've posted have contributed to this.

I will remove this remark on the exact numbers from the commit
message... it prevents unnecessary scheduling overhead, which is I
think sufficient to describe what this patch does.

> And this really makes a difference?  I'd like to hear the rt developers
> opinoin of this.
>
> greg k-h

I will repost this patch and ask Thomas Gleixner and Steven Rostedt to
take a look at it.

Regards,
Ivo Sieben
