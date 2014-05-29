From: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Subject: Re: Re: [PATCH V7] serial/uart/8250: Add tunable RX interrupt
 trigger I/F of FIFO buffers
Date: Thu, 29 May 2014 14:16:06 +0900
Message-ID: <5386C296.4040706@hitachi.com>
References: <20140527050921.17672.97365.stgit@yunodevel> <20140528201327.GA19249@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140528201327.GA19249@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Stephen Warren <swarren@nvidia.com>, Alan <gnomes@lxorguk.ukuu.org.uk>, Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, linux-serial@vger.kernel.org, yrl.pp-manager.tt@hitachi.com, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Aaron Sierra <asierra@xes-inc.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

Thank you for your review.

(2014/05/29 5:13), Greg Kroah-Hartman wrote:
> On Tue, May 27, 2014 at 02:09:21PM +0900, Yoshihiro YUNOMAE wrote:
>> Add tunable RX interrupt trigger I/F of FIFO buffers.
>>
>> Serial devices are used as not only message communication devices but control
>> or sending communication devices. For the latter uses, normally small data
>> will be exchanged, so user applications want to receive data unit as soon as
>> possible for real-time tendency. If we have a sensor which sends a 1 byte data
>> each time and must control a device based on the sensor feedback, the RX
>> interrupt should be triggered for each data.
>>
>> According to HW specification of serial UART devices, RX interrupt trigger
>> can be changed, but the trigger is hard-coded. For example, RX interrupt trigger
>> in 16550A can be set to 1, 4, 8, or 14 bytes for HW, but current driver sets
>> the trigger to only 8bytes.
>>
>> This patch makes some devices change RX interrupt trigger from userland.
>
> I'd prefer it if you could split the attr_grps logic out into a separate
> patch, the first one in a 2 patch series.  I don't think it is quite
> correct what you are doing here, but given the other changes going on at
> the same time, it's hard to pick it apart.

OK, I understood. If this patch will be separated as you say, other
people will be able to understand easily when attr_grps will have
been introduced.

> So, can you split this up into 2 patches and resend please?

Sure. I'll do it soon.

Thank you,
Yoshihiro YUNOMAE

-- 
Yoshihiro YUNOMAE
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: yoshihiro.yunomae.ez@hitachi.com
