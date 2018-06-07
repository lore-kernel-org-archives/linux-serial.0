From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: possible deadlock in console_unlock
Date: Thu, 7 Jun 2018 20:40:54 +0900
Message-ID: <6cc6d5c1-fc01-efab-86b8-eb072607680c@I-love.SAKURA.ne.jp>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

On 2018/06/07 20:00, Petr Mladek wrote:
>> ---
>>
>>  drivers/tty/tty_buffer.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
>> index c996b6859c5e..71958ef6a831 100644
>> --- a/drivers/tty/tty_buffer.c
>> +++ b/drivers/tty/tty_buffer.c
>> @@ -167,7 +167,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>>  	   have queued and recycle that ? */
>>  	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
>>  		return NULL;
>> -	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
>> +	p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
>> +			GFP_ATOMIC | __GFP_NOWARN);
>>  	if (p == NULL)
>>  		return NULL;
>>
>> ---
> 
> This looks like the most simple solution for this particular problem.
> I am just afraid that there are many other locations like this.
> 
I haven't tried the reproducer with that change. But isn't __GFP_NOWARN
ignored by fail_dump() (and thus printk() from fault injection still occurs)?

By the way, this reproducer is tricky. It needs to run like ./a.out
followed by "while :; do fg; done" because it always stops by a signal.
