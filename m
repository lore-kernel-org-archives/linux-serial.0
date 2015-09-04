From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: core: prevent softlockups on slow consoles
Date: Fri, 4 Sep 2015 06:42:26 -0400
Message-ID: <55E97592.40307@hurleysoftware.com>
References: <1441031656-17959-1-git-send-email-vkuznets@redhat.com>
 <20150904042039.GA3719@kroah.com> <87bndid52t.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87bndid52t.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>
List-Id: linux-serial@vger.kernel.org

On 09/04/2015 03:19 AM, Vitaly Kuznetsov wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

>> I don't like this, please narrow this down to the real problem that your
>> hardware has here, the putchar function should not be this slow.  If it
>> is, something is wrong.
> 
> I'm afraid this is really the case:
> 
> 3)               |                                          serial8250_console_putchar() {
> 3)               |                                            wait_for_xmitr() {
> 3) # 3111.189 us |                                              io_serial_in();
> 3) # 3115.334 us |                                            }
> 3) # 2234.099 us |                                            io_serial_out();
> 3) # 5353.883 us |                                          }
> 
> This is one char and I use local pipe for Hyper-V output. In case
> something like remote pipe is in use ...
> 
> So I'm sorry, but I don't really understand the suggestion to 'narrow
> this down' - this is how slow Hyper-V serial's implementation is,
> io_serial_in() is just an inb() and io_serial_out() is an outb().

That corresponds to 330-440 baud. As far as I'm concerned, that's broken.

Regards,
Peter Hurley
