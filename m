From: John David Anglin <dave.anglin@bell.net>
Subject: Re: [PATCH] serial: fix parisc boot hang
Date: Sun, 4 Jan 2015 15:41:02 -0500
Message-ID: <BLU436-SMTP18804757BD2AD6E29059A76975B0@phx.gbl>
References: <1420221913.2072.7.camel@HansenPartnership.com> <20150102185127.GA8636@kroah.com> <1420398768.2078.1.camel@HansenPartnership.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1420398768.2078.1.camel@HansenPartnership.com>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-parisc <linux-parisc@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2015-01-04, at 2:12 PM, James Bottomley wrote:

> On Fri, 2015-01-02 at 10:51 -0800, Greg Kroah-Hartman wrote:
>> On Fri, Jan 02, 2015 at 10:05:13AM -0800, James Bottomley wrote:
>>> From: James Bottomley <JBottomley@Parallels.com>
>>> 
>>> This is a partial revert of 2f2dafe (serial: serial_core.c: printk
>>> replacement) which gets us booting again.  The real problem seems to be
>>> the _emit path in early boot.  However, until we can root cause it, we
>>> need at least to get boot working.
>>> 
>>> Fixes: 2f2dafe77df2c78e189a9fa6b1879dffd06ae5a1
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: James Bottomley <JBottomley@Parallels.com>
>>> 
>>> ---
>>> 
>>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>>> index 57ca61b..984605b 100644
>>> --- a/drivers/tty/serial/serial_core.c
>>> +++ b/drivers/tty/serial/serial_core.c
>>> @@ -2164,7 +2164,9 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
>>> 		break;
>>> 	}
>>> 
>>> -	dev_info(port->dev, "%s%d at %s (irq = %d, base_baud = %d) is a %s\n",
>>> +	printk(KERN_INFO "%s%s%s%d at %s (irq = %d, base_baud = %d) is a %s\n",
>>> +	       port->dev ? dev_name(port->dev) : "",
>>> +	       port->dev ? ": " : "",
>>> 	       drv->dev_name,
>>> 	       drv->tty_driver->name_base + port->line,
>>> 	       address, port->irq, port->uartclk / 16, uart_type(port));
>> 
>> Very odd, but I'll go queue it up, thanks.
> 
> OK, well this turned out to be one of the weirder fishing expeditions
> I've been on.  The problem is this strange linux specific printf format
> flag %pV.  The way to fix the bug is not to indirect the dev_xxx printks
> via %pV.  What's happening is that in some circumstances, using %pV
> corrupts the stack.
> 
> The reason seems to be that whoever came up with %pV didn't read the man
> pages carefully enough. In all the examples and use cases, the va_list
> is passed by *copy* not by reference.  For some inexplicable reason it's
> passed by reference in struct va_format.  Sure enough when I fix up my
> local tree to pass by copy it all works (at least as far as I can tell:
> most of the time the stack corruption passes unnoticed and minor
> disturbances can affect that.  However, the type and size of the va_list
> is the same in reference and copy, so I think it's reasonably
> definitive).
> 
> I'd really like one of our gcc experts to comment here because all of
> these are builtin_ types and functions, so why there's a problem is a
> mystery (translate: I don't understand enough of gcc to make sense of
> the source code), but the surmise would be that the builtins are taking
> some stack frame information from the source and, because it's a pointer
> not a copy, it's in the wrong frame.
> 
> Assuming this turns out to be the problem, fixing it is going to be a
> real bugger because on most platforms, the type of va_list is void *
> meaning you can't tell the difference at compile time between a copy and
> a reference, because typeof(void *) == typeof(void **),  and this %pV is
> sprayed all over our code base.
> 
> We should probably also have the security experts look it over because
> any way of inducing stack frame corruption is potentially exploitable,
> although, in this case, I think all of the uses are internal so the user
> doesn't have the ability to influence the source data.


Would it be possible to create a relatively simple test case?

On 64-bit parisc, the va_list is built up in part by hppa_builtin_saveregs() in pa.c.
It's stored in a region in the callers frame reserved for arguments.

I tend to think it's dangerous to pass a va_list by reference as in general the called
function is free to use the incoming argument region for its own purposes after
the incoming arguments have been copied.  This might be the cause of the stack
corruption you are seeing.

On parisc, the callee is responsible for copying incoming arguments if necessary.
This is somewhat unusual...

Dave
--
John David Anglin	dave.anglin@bell.net



