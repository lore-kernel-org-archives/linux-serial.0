From: Dann Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH v2] serial: uart: add hw flow control support configuration
Date: Wed, 11 Jun 2014 15:05:23 -0600
Message-ID: <CALdTtntgsiOebewCPRMd4wty_rJhggbt13Y8F_YpLrrtQWar5g@mail.gmail.com>
References: <1398971093-17164-1-git-send-email-m-karicheri2@ti.com>
	<CALdTtnvTtjKv6NQd=NCZATHnKLURKYMfnQaGR7MA=_kafBP=JQ@mail.gmail.com>
	<5398C1D0.30808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5398C1D0.30808-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 11, 2014 at 2:53 PM, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org> wrote:
> On 5/28/2014 4:04 PM, Dann Frazier wrote:
>>
>> On Thu, May 1, 2014 at 1:04 PM, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>> wrote:
>>>
>>> 8250 uart driver currently supports only software assisted hw flow
>>> control. The software assisted hw flow control maintains a hw_stopped
>>> flag in the tty structure to stop and start transmission and use modem
>>> status interrupt for the event to drive the handshake signals. This is
>>> not needed if hw has flow control capabilities. This patch adds a
>>> DT attribute for enabling hw flow control for a uart port. Also skip
>>> stop and start if this flag is present in flag field of the port
>>> structure.
>>
>> ubuntu@hwflow:~$ sudo stty -a --file /dev/ttyS0 |tr ' ' '\n' | grep
>> crtscts
>> crtscts
>> ubuntu@hwflow:~$ ls
>> /proc/device-tree/soc/serial@1c021000/has-hw-flow-control
>> /proc/device-tree/soc/serial@1c021000/has-hw-flow-control
>> ubuntu@hwflow:~$ python
>> Python 2.7.6 (default, Mar 22 2014, 22:58:30)
>> [GCC 4.8.2] on linux2
>> Type "help", "copyright", "credits" or "license" for more information.
>>>>>
>>>>> UPF_HARDWARE_FLOW = 1 << 21
>>>>> if 0xB9200000 & UPF_HARDWARE_FLOW:
>>
>> ...     print "OK"
>> ...
>> OK
>>
>> Hope that's a reasonable test case. Test fails when booted w/o
>> has-hw-flow-control attribute.
>>
>> Tested-by: dann frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>
> What is the verdict? pass/fail? Ok/Not OK to merge?

Murali,

 It is working for me, and appears to already be Linus' tree.

  -dann

> Murali
>
>>> Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>>>
>>> CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>> CC: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
>>> CC: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>>> CC: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
>>> CC: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> CC: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
>>> CC: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
>>> CC: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
>>> CC: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
>>> ---
>>>   .../devicetree/bindings/serial/of-serial.txt       |    1 +
>>>   drivers/tty/serial/8250/8250_core.c                |    6 ++++--
>>>   drivers/tty/serial/of_serial.c                     |    4 ++++
>>>   drivers/tty/serial/serial_core.c                   |   12 +++++++++---
>>>   4 files changed, 18 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt
>>> b/Documentation/devicetree/bindings/serial/of-serial.txt
>>> index 1928a3e..7705477 100644
>>> --- a/Documentation/devicetree/bindings/serial/of-serial.txt
>>> +++ b/Documentation/devicetree/bindings/serial/of-serial.txt
>>> @@ -37,6 +37,7 @@ Optional properties:
>>>   - auto-flow-control: one way to enable automatic flow control support.
>>> The
>>>     driver is allowed to detect support for the capability even without
>>> this
>>>     property.
>>> +- has-hw-flow-control: the hardware has flow control capability.
>>>
>>>   Example:
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_core.c
>>> b/drivers/tty/serial/8250/8250_core.c
>>> index 0e1bf88..b69aff2 100644
>>> --- a/drivers/tty/serial/8250/8250_core.c
>>> +++ b/drivers/tty/serial/8250/8250_core.c
>>> @@ -2338,9 +2338,11 @@ serial8250_do_set_termios(struct uart_port *port,
>>> struct ktermios *termios,
>>>           * the trigger, or the MCR RTS bit is cleared.  In the case
>>> where
>>>           * the remote UART is not using CTS auto flow control, we must
>>>           * have sufficient FIFO entries for the latency of the remote
>>> -        * UART to respond.  IOW, at least 32 bytes of FIFO.
>>> +        * UART to respond.  IOW, at least 32 bytes of FIFO. Also enable
>>> +        * AFE if hw flow control is supported
>>>           */
>>> -       if (up->capabilities & UART_CAP_AFE && port->fifosize >= 32) {
>>> +       if ((up->capabilities & UART_CAP_AFE && (port->fifosize >= 32))
>>> ||
>>> +           (port->flags & UPF_HARD_FLOW)) {
>>>                  up->mcr &= ~UART_MCR_AFE;
>>>                  if (termios->c_cflag & CRTSCTS)
>>>                          up->mcr |= UART_MCR_AFE;
>>> diff --git a/drivers/tty/serial/of_serial.c
>>> b/drivers/tty/serial/of_serial.c
>>> index 9924660..77ec6a1 100644
>>> --- a/drivers/tty/serial/of_serial.c
>>> +++ b/drivers/tty/serial/of_serial.c
>>> @@ -182,6 +182,10 @@ static int of_platform_serial_probe(struct
>>> platform_device *ofdev)
>>>                                            "auto-flow-control"))
>>>                          port8250.capabilities |= UART_CAP_AFE;
>>>
>>> +               if (of_property_read_bool(ofdev->dev.of_node,
>>> +                                         "has-hw-flow-control"))
>>> +                       port8250.port.flags |= UPF_HARD_FLOW;
>>> +
>>>                  ret = serial8250_register_8250_port(&port8250);
>>>                  break;
>>>          }
>>> diff --git a/drivers/tty/serial/serial_core.c
>>> b/drivers/tty/serial/serial_core.c
>>> index b68550d..851707a 100644
>>> --- a/drivers/tty/serial/serial_core.c
>>> +++ b/drivers/tty/serial/serial_core.c
>>> @@ -174,8 +174,12 @@ static int uart_port_startup(struct tty_struct *tty,
>>> struct uart_state *state,
>>>                          if (tty->termios.c_cflag & CBAUD)
>>>                                  uart_set_mctrl(uport, TIOCM_RTS |
>>> TIOCM_DTR);
>>>                  }
>>> -
>>> -               if (tty_port_cts_enabled(port)) {
>>> +               /*
>>> +                * if hw support flow control without software
>>> intervention,
>>> +                * then skip the below check
>>> +                */
>>> +               if (tty_port_cts_enabled(port) &&
>>> +                   !(uport->flags & UPF_HARD_FLOW)) {
>>>                          spin_lock_irq(&uport->lock);
>>>                          if (!(uport->ops->get_mctrl(uport) & TIOCM_CTS))
>>>                                  tty->hw_stopped = 1;
>>> @@ -2772,7 +2776,9 @@ void uart_handle_cts_change(struct uart_port
>>> *uport, unsigned int status)
>>>
>>>          uport->icount.cts++;
>>>
>>> -       if (tty_port_cts_enabled(port)) {
>>> +       /* skip below code if the hw flow control is supported */
>>> +       if (tty_port_cts_enabled(port) &&
>>> +           !(uport->flags & UPF_HARD_FLOW)) {
>>>                  if (tty->hw_stopped) {
>>>                          if (status) {
>>>                                  tty->hw_stopped = 0;
>>> --
>>> 1.7.9.5
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>>> in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
