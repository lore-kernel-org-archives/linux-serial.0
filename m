From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 07/25] printk-rb: add functionality required by printk
Date: Wed, 13 Feb 2019 10:20:07 +0100
Message-ID: <87k1i411vc.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-8-john.ogness@linutronix.de>
        <CAHk-=whToBNHN_X_BQkO4zSyhSBaGqTH8XEtxg2_AxoBdDnEdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=whToBNHN_X_BQkO4zSyhSBaGqTH8XEtxg2_AxoBdDnEdg@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 12 Feb 2019 09:15:36 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-02-12, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, Feb 12, 2019 at 6:30 AM John Ogness <john.ogness@linutronix.de> wrote:
>>
>> +                       while (atomic_long_read(&rb->lost)) {
>> +                               atomic_long_dec(&rb->lost);
>> +                               rb->seq++;
>> +                       }
>
> This looks like crazy garbage. It's neither atomic nor sane.

It works because because only 1 context on a single CPU can hit that
loop. But yes, it is crazy.

> Why isn't it something like
>
>     if (atomic_long_read(&rb->lost)) {
>         long lost = atomic_xchg(&rb->lost, 0);
>         rb->seq += lost;
>     }
>
> instead?

Yes, it should be like you suggest. Thanks.

John Ogness
