From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCHv3] panic: avoid deadlocks in re-entrant console drivers
Date: Wed, 12 Dec 2018 14:23:08 +0900
Message-ID: <20181212052308.GG431@jagdpanzerIV>
References: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
 <20181031122736.epbxu424l3xagge5@pathway.suse.cz>
 <20181101014821.GB502@jagdpanzerIV>
 <20181101080808.n73lrlnjd65nk4qf@pathway.suse.cz>
 <20181122131202.nkcurdt5k6jrhowa@pathway.suse.cz>
 <CAJmjG2-_8T6uJP54-+gUG7Aq7kNqkAKAEXbzzV9JVKyZFRh4GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJmjG2-_8T6uJP54-+gUG7Aq7kNqkAKAEXbzzV9JVKyZFRh4GQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Wang <wonderfly@google.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (12/11/18 16:53), Daniel Wang wrote:
> Is it okay to tag this commit with `Cc: stable@vger.kernel.org` so
> that it'll get applied to the stable trees once merged into Linux's
> tree, if it's not too late? Otherwise I'll follow up on the stable
> merges separately. Thanks for making the changes anyway.

My bad! I should have Cc-ed stable on that one, sorry. I guess now it
would be easier to wait and follow up once it gets merged.

	-ss
