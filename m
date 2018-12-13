From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
Date: Thu, 13 Dec 2018 11:19:26 +0900
Message-ID: <20181213021926.GC4860@jagdpanzerIV>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
 <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
 <20181212034252.GD431@jagdpanzerIV>
 <137479ad-d38e-7d26-dae4-a4e721d69928@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <137479ad-d38e-7d26-dae4-a4e721d69928@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Safonov <dima@arista.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jiri Slaby <jslaby@suse.cz>, kernel test robot <rong.a.chen@intel.com>, lkp@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>
List-Id: linux-serial@vger.kernel.org

On (12/12/18 14:54), Dmitry Safonov wrote:
> > In this particular case we probably can just move free_page()
> > out of uart_port lock scope. Note that free_page()->MM can printk()
> > on its own.
> > 
> > 
> > Something like this (not tested):
> 
> Looks good to me.
> Probably, it's worth to update comment about freeing just to make sure
> no one will "refactor"/"simplify" it some day.
> 
> Does it make sense to add this to your patch?

Makes perfect sense, thanks! I'll send a patch a bit later.

	-ss
