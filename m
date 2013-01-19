From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [next-20130118] Analyzing a call-trace reproducible with
 pm_test/freezer [ X86|RCU|TTY|EXT4FS|JBD2|PM related? ]
Date: Sat, 19 Jan 2013 23:59:15 +0100
Message-ID: <CA+icZUVqR9FCk4PcoXJJwa+zEkU3rf6cDwvYKkocfJpVhGo7xQ@mail.gmail.com>
References: <CA+icZUWKCbaL=oAwBk0vcPtLrGmvsqPdpXdYAqPZVKzA9Y_iDw@mail.gmail.com>
	<50FB2197.7010306@ilyx.ru>
	<CA+icZUU-4WXXMTCjRWP6H7+JhytBSWuA55-JFyu3yowcT6Q4xw@mail.gmail.com>
	<50FB249D.4050906@ilyx.ru>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <50FB249D.4050906@ilyx.ru>
Sender: linux-next-owner@vger.kernel.org
To: Ilya Zykov <ilya@ilyx.ru>
Cc: linux-next <linux-next@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, linux-serial@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, x86@kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paul.mckenney@linaro.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Jan Kara <jack@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 19, 2013 at 11:56 PM, Ilya Zykov <ilya@ilyx.ru> wrote:
> On 20.01.2013 2:51, Sedat Dilek wrote:
>> On Sat, Jan 19, 2013 at 11:43 PM, Ilya Zykov <ilya@ilyx.ru> wrote:
>>> Hello!
>>> I don't expert, but
>>> maybe it can help.
>>>
>>> I test with:
>>>   while echo mem > /sys/power/state; do sleep 2; done
>>> in one X-terminal, in other I trying playing with keyboard.
>>> (Without playing all right I use ext3.)
>>
>> Can you test with the patches listed in [1] (including two TTY patches
>> from you!)?
>> My base is Linux-Next (next-20130118).
>> FYI: My Ubuntu/precise is EXT4FS-formatted.
>>
> Ok.
> but not now I have 3.00 night.
> I already use this in my 3.8.0-rc3-next-20130118-pm+.
>  tty: Correct tty buffer flush.
>

The TTY patches are not enough, you need in addition the JBD2 fix [1].

- Sedat -

[1] http://patchwork.ozlabs.org/patch/207237/

>
