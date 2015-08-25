From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Potential data race in uart_ioctl
Date: Tue, 25 Aug 2015 16:58:42 -0400
Message-ID: <55DCD702.2090208@hurleysoftware.com>
References: <CAAeHK+xPOrm4JMjmRL4Er+LU7Auh_+rSnNcbWniPOoQFMZaqfw@mail.gmail.com>
 <55DCB365.2060501@hurleysoftware.com>
 <CACT4Y+Y5ue_Oh1_DWEiAudro5Vo5R1g4V-RDcTxexr25+v7NNw@mail.gmail.com>
 <CACT4Y+aJJGcG2nRXAH5xgZzd4DiWdDS9cO5ogYM8Cbe5XsQJaA@mail.gmail.com>
 <55DCBC04.6040601@hurleysoftware.com>
 <CACT4Y+assV+6ytFGVZ4i-+C4oJ0QHTBRpjr=uXovejL5Xqz5PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+assV+6ytFGVZ4i-+C4oJ0QHTBRpjr=uXovejL5Xqz5PA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>
List-Id: linux-serial@vger.kernel.org

On 08/25/2015 03:50 PM, Dmitry Vyukov wrote:
> On Tue, Aug 25, 2015 at 9:03 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 08/25/2015 02:38 PM, Dmitry Vyukov wrote:
>>> On Tue, Aug 25, 2015 at 8:32 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>>> On Tue, Aug 25, 2015 at 8:26 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>> On 08/25/2015 08:17 AM, Andrey Konovalov wrote:
>>>>>> Hi!
>>>>>>
>>>>>> We are working on a dynamic data race detector for the Linux kernel
>>>>>> called KernelThreadSanitizer (ktsan)
>>>>>> (https://github.com/google/ktsan/wiki).
>>>>>>
>>>>>> While booting the kernel (upstream revision 21bdb584af8c) we got a report:
>>>>>>
>>>>>> ==================================================================
>>>>>> ThreadSanitizer: data-race in uart_ioctl
>>>>>>
>>>>>> Read of size 8 by thread T424 (K971):
>>>>>>  [<ffffffff81673c56>] uart_ioctl+0x36/0x11e0
>>>>>> drivers/tty/serial/serial_core.c:1216
>>>>>>  [<ffffffff81643802>] tty_ioctl+0x4f2/0x11d0 drivers/tty/tty_io.c:2924
>>>>>>  [<     inlined    >] do_vfs_ioctl+0x44a/0x750 vfs_ioctl fs/ioctl.c:43
>>>>>>  [<ffffffff8127b0ca>] do_vfs_ioctl+0x44a/0x750 fs/ioctl.c:607
>>>>>>  [<     inlined    >] SyS_ioctl+0x79/0xa0 SYSC_ioctl fs/ioctl.c:622
>>>>>>  [<ffffffff8127b449>] SyS_ioctl+0x79/0xa0 fs/ioctl.c:613
>>>>>>  [<ffffffff81eae0ae>] entry_SYSCALL_64_fastpath+0x12/0x71
>>>>>> arch/x86/entry/entry_64.S:186
>>>>>> DBG: cpu = ffff88063fc1fe68
>>>>>> DBG: cpu id = 0
>>>>>>
>>>>>> Previous write of size 8 by thread T422 (K970):
>>>>>>  [<ffffffff816737ef>] uart_open+0x12f/0x220
>>>>>> drivers/tty/serial/serial_core.c:1629
>>>>>>  [<ffffffff81645be2>] tty_open+0x192/0x8f0 drivers/tty/tty_io.c:2105
>>>>>>  [<ffffffff812628fc>] chrdev_open+0x13c/0x290 fs/char_dev.c:388
>>>>>>  [<ffffffff812582fc>] do_dentry_open+0x3ac/0x550 fs/open.c:736
>>>>>>  [<ffffffff81259d68>] vfs_open+0xb8/0xe0 fs/open.c:853
>>>>>>  [<     inlined    >] path_openat+0x81c/0x2440 do_last fs/namei.c:3163
>>>>>>  [<ffffffff81272f1c>] path_openat+0x81c/0x2440 fs/namei.c:3295
>>>>>>  [<ffffffff8127656a>] do_filp_open+0xfa/0x170 fs/namei.c:3330
>>>>>>  [<ffffffff8125a243>] do_sys_open+0x183/0x2b0 fs/open.c:1025
>>>>>>  [<     inlined    >] SyS_open+0x35/0x50 SYSC_open fs/open.c:1043
>>>>>>  [<ffffffff8125a3a5>] SyS_open+0x35/0x50 fs/open.c:1038
>>>>>>  [<ffffffff81eae0ae>] entry_SYSCALL_64_fastpath+0x12/0x71
>>>>>> arch/x86/entry/entry_64.S:186
>>>>>> DBG: cpu = ffff88063fd1fe68
>>>>>>
>>>>>> DBG: addr: ffff8801d2a0ce88
>>>>>> DBG: first offset: 0, second offset: 0
>>>>>> DBG: T424 clock: {T424: 211057, T422: 275728}
>>>>>> DBG: T422 clock: {T422: 275819}
>>>>>> ==================================================================
>>>>>>
>>>>>> It seems that one thread reads and uses tty->driver_data while it's
>>>>>> being initialized in another one. The second thread holds port->mutex,
>>>>>> but the first one does a few accesses to tty->driver_data before
>>>>>> locking it.
>>>>>>
>>>>>> Could you confirm if this is a real race?
>>>>>
>>>>> Although I don't understand what triggers ktsan to signal a race
>>>>> condition, this doesn't appear to be an actual race.
>>>>>
>>>>> For an ioctl() syscall to act on any given tty requires a successful
>>>>> open() syscall to have nearly completed (do_sys_open() => fd_install()
>>>>> initializes the file descriptor; ioctl() => fdget() derefs the descriptor).
>>>>>
>>>>> Perhaps what's tripping the race detection is that 2nd and subsequent
>>>>> opens also (redundantly) write the same values as from the first open?
>>>>
>>>> Since we use a fuzzer, yes, it is possible that open is called twice.
>>>
>>> Oh, no, sorry, this happens during booting.
>>> The race is on tty_struct, which is probably shared between several
>>> file descriptors.
>>
>> Yep, but there is 1:1 correspondence between tty_struct and uart_state;
>> so once the first open() initializes tty->driver_data, subsequent opens
>> are just re-writing the same value for tty->driver_data.
>>
>> Is ktsan just triggering on the fact there is a memory write, without
>> checking the value has changed?
> 
> Yes, that is correct. Ktsan is based on C memory model which says that
> any write racing with other memory access leads to undefined behavior.

The Linux kernel largely ignores the C memory model definition, and
relies on practical compiler behavior.

So-called 'data races' are common in kernel code.

> As far as I see the setup is quite complex and not just writes to
> tty->driver_data.

Yes, vfs => tty => serial core => uart driver is a (necessarily) complicated
stack.

> For example, it also calls uart_startup which does
> set_bit(TTY_IO_ERROR, &tty->flags) on the tty. Can't that lead to some
> issues?

No.

> E.g. we set TTY_IO_ERROR, but since tty is already used by
> other threads, operations on the tty in other threads will spuriously
> fail.

See below.

> 195 static int uart_startup(struct tty_struct *tty, struct uart_state *state,
> 196                 int init_hw)
> 197 {
> 198         struct tty_port *port = &state->port;
> 199         int retval;
> 200
> 201         if (port->flags & ASYNC_INITIALIZED)
> 202                 return 0;

Subsequent opens return success here (note below how the ASYNCB_INITIALIZED bit
is set in tty->flags if uart_port_startup() returned success from the earlier
open ?)

Regards,
Peter Hurley

> 203
> 204         /*
> 205          * Set the TTY IO error marker - we will only clear this
> 206          * once we have successfully opened the port.
> 207          */
> 208         set_bit(TTY_IO_ERROR, &tty->flags);
> 209
> 210         retval = uart_port_startup(tty, state, init_hw);
> 211         if (!retval) {
> 212                 set_bit(ASYNCB_INITIALIZED, &port->flags);
> 213                 clear_bit(TTY_IO_ERROR, &tty->flags);
> 214         } else if (retval > 0)
> 215                 retval = 0;
> 216
> 217         return retval;
> 218 }
> 
