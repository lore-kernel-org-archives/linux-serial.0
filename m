From: Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] serial: flush ldisc after hangup
Date: Tue, 1 Mar 2016 13:21:26 -0500
Message-ID: <56D5DDA6.5080605@fb.com>
References: <1456855375-17175-1-git-send-email-jbacik@fb.com>
 <56D5DCA0.2040201@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56D5DCA0.2040201@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/01/2016 01:17 PM, Peter Hurley wrote:
> Hi Josef,
>
> On 03/01/2016 10:02 AM, Josef Bacik wrote:
>> We hit a panic pretty consistently in production that looked like this
>>
>> PID: 461061  TASK: ffff880203f8bc00  CPU: 2   COMMAND: "kworker/u8:2"
>>   #0 [ffff88015834b940] machine_kexec at ffffffff8103c1c5
>>   #1 [ffff88015834b990] crash_kexec at ffffffff810cd448
>>   #2 [ffff88015834ba60] oops_end at ffffffff81006478
>>   #3 [ffff88015834ba90] no_context at ffffffff818c5262
>>   #4 [ffff88015834baf0] __bad_area_nosemaphore at ffffffff818c545a
>>   #5 [ffff88015834bb40] bad_area_nosemaphore at ffffffff818c548c
>>   #6 [ffff88015834bb50] __do_page_fault at ffffffff81045ad5
>>   #7 [ffff88015834bbc0] do_page_fault at ffffffff81045efc
>>   #8 [ffff88015834bbd0] page_fault at ffffffff818d6b82
>>      [exception RIP: __uart_start+0x1a]
>>      RIP: ffffffff8152f30a  RSP: ffff88015834bc80  RFLAGS: 00010046
>>      RAX: 0000000000000000  RBX: ffffffff822e9920  RCX: 0000000000000036
>>      RDX: 0000000000003636  RSI: 00000000000000fe  RDI: ffffffff822e9920
>>      RBP: ffff88015834bca8   R8: 0000000000000000   R9: 00000000ffffffff
>>      R10: ffff8802546f0d20  R11: 0000000000000000  R12: ffff880254712400
>>      R13: 0000000000000286  R14: 00000000000000fe  R15: ffff880254712400
>>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>   #9 [ffff88015834bc80] uart_start at ffffffff8152fbf2
>
> Thanks for the report, but where's the rest of the stack trace?

Woops sorry about that

crash> bt
PID: 461061  TASK: ffff880203f8bc00  CPU: 2   COMMAND: "kworker/u8:2"
  #0 [ffff88015834b940] machine_kexec at ffffffff8103c1c5
  #1 [ffff88015834b990] crash_kexec at ffffffff810cd448
  #2 [ffff88015834ba60] oops_end at ffffffff81006478
  #3 [ffff88015834ba90] no_context at ffffffff818c5262
  #4 [ffff88015834baf0] __bad_area_nosemaphore at ffffffff818c545a
  #5 [ffff88015834bb40] bad_area_nosemaphore at ffffffff818c548c
  #6 [ffff88015834bb50] __do_page_fault at ffffffff81045ad5
  #7 [ffff88015834bbc0] do_page_fault at ffffffff81045efc
  #8 [ffff88015834bbd0] page_fault at ffffffff818d6b82
     [exception RIP: __uart_start+0x1a]
     RIP: ffffffff8152f30a  RSP: ffff88015834bc80  RFLAGS: 00010046
     RAX: 0000000000000000  RBX: ffffffff822e9920  RCX: 0000000000000036
     RDX: 0000000000003636  RSI: 00000000000000fe  RDI: ffffffff822e9920
     RBP: ffff88015834bca8   R8: 0000000000000000   R9: 00000000ffffffff
     R10: ffff8802546f0d20  R11: 0000000000000000  R12: ffff880254712400
     R13: 0000000000000286  R14: 00000000000000fe  R15: ffff880254712400
     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
  #9 [ffff88015834bc80] uart_start at ffffffff8152fbf2
#10 [ffff88015834bcb0] uart_flush_chars at ffffffff8152fc1e
#11 [ffff88015834bcc0] n_tty_receive_buf_common at ffffffff81516cf1
#12 [ffff88015834bd80] n_tty_receive_buf2 at ffffffff81517414
#13 [ffff88015834bd90] flush_to_ldisc at ffffffff8151ab6d
#14 [ffff88015834bdf0] process_one_work at ffffffff81069871
#15 [ffff88015834be40] worker_thread at ffffffff81069c53
#16 [ffff88015834bec0] kthread at ffffffff8106f429
#17 [ffff88015834bf50] ret_from_fork at ffffffff818d50c8

>
>> It was a NULL pointer dereference, the state->port.tty was NULL so when we go to
>> check tty->stopped in uart_tx_stopped() we panic.  Looking at the other CPU's we
>> were in the middle of uart_open(), and the core actually had a valid pointer in
>> state->port.tty, which points to a race between either close or hangup (the only
>> two places that set state->port.tty to NULL) and open.  Close already flushes
>> the ldisc but hangup does not, which means we could have some characters in the
>> receive buffer in between the hangup and the open, and we end up in this
>> situation.
>
> Yeah, the race is that the ldisc should not be attempting i/o to
> the driver at all. This problem is fixed in -next already, but in the
> tty core rather than in each individual tty driver.
>

Great!  Which patch/patches fix this?  I looked at linux-next and 
there's a lot of refactoring stuff, do I need all the things or is there 
a specific one that fixes this problem?  Thanks,

Josef
