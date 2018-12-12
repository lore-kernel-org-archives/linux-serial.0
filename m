From: Waiman Long <longman@redhat.com>
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
Date: Wed, 12 Dec 2018 10:12:11 -0500
Message-ID: <fb2e249a-fbda-d197-95ea-0f8a85acf6e7@redhat.com>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
 <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
 <20181212034252.GD431@jagdpanzerIV> <20181212050432.GE431@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212050432.GE431@jagdpanzerIV>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Dmitry Safonov <dima@arista.com>
Cc: Jiri Slaby <jslaby@suse.cz>, kernel test robot <rong.a.chen@intel.com>, lkp@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-serial@vger.kernel.org

On 12/12/2018 12:04 AM, Sergey Senozhatsky wrote:
> On (12/12/18 12:42), Sergey Senozhatsky wrote:
> [..]
>>>>> [   87.255156]        CPU0                    CPU1
>>>>> [   87.255813]        ----                    ----
>>>>> [   87.256460]   lock(&port_lock_key);
>>>>> [   87.256973]                                lock(console_owner);
>>>>> [   87.257829]                                lock(&port_lock_key);
>>>>> [   87.258680]   lock(&obj_hash[i].lock);
>> So it's like
>>
>> 	CPU0					CPU1
>>
>> 	uart_shutdown()				db->lock
>> 	 uart_port->lock			 debug_print_object()
>> 	  free_page()				  printk
>> 	   debug_check_no_obj_freed		   uart_port->lock
>> 	    db->lock
>>
>>
>> In this particular case we probably can just move free_page()
>> out of uart_port lock scope. Note that free_page()->MM can printk()
>> on its own.
>>
> [..]
>> [1] https://lore.kernel.org/lkml/1542653726-5655-8-git-send-email-longman@redhat.com/T/#u
> That said, I'd first try Waiman's patch. The one I suggested is
> more of a defense move - there are too many things happening under
> uart_port->lock. This is not the first time we see lockdep complaining
> about the way uart and the rest of the kernel interact.
>
> 	-ss

Thanks for the information. I will extract my debugobjects patch out of
my lockdep patchset and send it out as standalone patch.

Cheers,
Longman
