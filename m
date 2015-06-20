From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Subject: Re: [PATCH] serial: imx: count tty buffer overruns
Date: Sat, 20 Jun 2015 19:17:04 +0200
Message-ID: <5585A010.2030707@gmx.at>
References: <558597B0.80104@gmx.at> <20150620165718.GA31390@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150620165718.GA31390@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
List-Id: linux-serial@vger.kernel.org

On 2015-06-20 18:57, Greg Kroah-Hartman wrote:
> On Sat, Jun 20, 2015 at 06:41:20PM +0200, manfred.schlaegl@gmx.at wrote:
>> As can be seen in function uart_insert_char (serial_core) the element
>> buf_overrun of struct uart_icount is used to count overruns of
>> tty-buffer.
>> Added support for counting of overruns in imx driver analogue to
>> serial_core.
>>
>> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
> 
> Your From: line in your email doesn't match this, please fix up and
> resend.
> 
> Same goes for your other serial patch.
> 
> thanks,
> 
> greg k-h
> 

Hi!

Argh.. Sorry for the mess .. 
The patch format was also not ok. I was working on a newly setup system.
I'll resend soon.

best regards,
manfred
